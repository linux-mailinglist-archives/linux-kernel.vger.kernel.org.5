Return-Path: <linux-kernel+bounces-147436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BEC8A7419
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56E901C211C7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E585613791B;
	Tue, 16 Apr 2024 19:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1M8ONBT"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8FF71B25;
	Tue, 16 Apr 2024 19:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713294110; cv=none; b=l02RM+c0Efww4uEDaonyz3cTir3Wn/3ip1mIA2CNvezLVLQUZ/R7L6OhevegK3jLvxNl8uCBA+CZpHWzvPrkOghmPb9JaCleraOHD+uTkvRTCp6Qc+tbKrbEq7ibDtpU8UTTaHDhIBeCrahpDyTtAY1Lxm7A7J2xa5vZop+u7lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713294110; c=relaxed/simple;
	bh=ZT6JwWGESMJIek2msf93oMeKULPITkMdylpLGXXC9ks=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g8cFdqV02MZhMRDhQbBINEdwRG4Dyh2DLI776LZKVKoTTakMlWImknx4/w275ppItLyGXm9lbmofI8Kk5w5/XVfhvugTyuED1GTQCEEOlWonztphHZcFqu5W8KdymmKNXsp8XD/1UzJtb2vf4yAgz8SxkdydI10rUR0MSy41AnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1M8ONBT; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41892a751cdso9820175e9.3;
        Tue, 16 Apr 2024 12:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713294107; x=1713898907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OkL2xPimLBkVWlW3BSsxZrZBgoyt2QLaIRWm+tSvYd4=;
        b=R1M8ONBTZhy+9Pyw8+XPtCRmv/l4rRD3eMu7bpmEaR7eihbnHFyxySVLGczLcdHAqN
         QfTpffQUWVcW7Nz4gYmwPU6m0v1ihp9tmltIUnvOoRlQl5vPQl7PtLS0ssX8e4mBx44y
         YX2Qn/3IQmiZlqBwnxM7UyUJ6Q4jXLaog+hcy81sQ7hMElN8bwYOQHGjgL3ouYa+8a0j
         jvfbemN34w2GO+QjJOXflm+7uEnx6k5OoZTGiSW/95Glmw6d++EC5B9HAKcjCeY/21GK
         8tdWOhUcGTXt0wjrv9oD9cafHPOrf4fV05oo1HMnUBgXb7O95CoR+QzPVpsX5KA/AQxM
         Jvuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713294107; x=1713898907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OkL2xPimLBkVWlW3BSsxZrZBgoyt2QLaIRWm+tSvYd4=;
        b=Hz0XkIZkARy/4UjzsXFhKTOXRKZCHw372NPXBi+hGr2VgJG4eF43wOddqLo6pwfrPs
         YTaYqDaRJcN8hv1+7OXOHA/FyOiEC3TOPzLtyr02o2mEVj7vxx4hdw5NFxQnD2jmQZje
         kLEFzlhxY9qByfucpir3d0r5vwo3exs7ChvMJjx4kb8+p9pHHz/Jjb0LJG97aSMTDwfe
         4Ikp7VHQI/x9zny7R724Q7JH8LtAI1K0hCIgn5U2b/dGOnnzv2sTIhxMlXRDGbw2qibC
         sPWtJsHeoTSSMWuG6UDZqcKvB2TTDA74ny1/42pm7lDoTVuKxUj+mY8usLCrJeNZFsIs
         4Dqg==
X-Forwarded-Encrypted: i=1; AJvYcCVNiKpGWuCnByut7ikmbixfTnDVAMlZ0ugFju11iwohZ45SxY2QOH3Sq33T5rh2xV7iSoslcA1MLxWMkXS7Nn1LnnXvLPuEgM1mvRA1
X-Gm-Message-State: AOJu0Yy4fALGaWp7Il6n7FEwTEavn4GeFPmNTLmdjW7uAVcxPI7YY7ea
	GNMoZOLul8M3chXhUC1V6tEgFkFzWB7Hx2wjHHDBnQC88pLrCES5YaDNY20G
X-Google-Smtp-Source: AGHT+IHbGF0OAnQ077gz1SzYMBTkouWk8LBMRRX+Q7HE+DHVg16aZ/j56KVZwTU/VNlSq0AFWJwong==
X-Received: by 2002:a5d:6a88:0:b0:347:2428:a4e0 with SMTP id s8-20020a5d6a88000000b003472428a4e0mr10302452wru.66.1713294106469;
        Tue, 16 Apr 2024 12:01:46 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id mm10-20020a170906cc4a00b00a524531a580sm5247981ejb.152.2024.04.16.12.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 12:01:46 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/5] net: dsa: vsc73xx: convert to PHYLINK and do some cleanup
Date: Tue, 16 Apr 2024 21:00:50 +0200
Message-Id: <20240416190055.3277007-1-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series is a result of splitting a larger patch series [0],
where some parts needed to be refactored.

The first patch switches from a poll loop to read_poll_timeout.

The second patch is a simple conversion to phylink because adjust_link
won't work anymore.

The third patch is preparation for future use. Using the
"phy_interface_mode_is_rgmii" macro allows for the proper recognition
of all RGMII modes.

Patches 4-5 involve some cleanup: The fourth patch introduces
a definition with the maximum number of ports to avoid using
magic numbers. The next one fills in documentation.

[0] https://patchwork.kernel.org/project/netdevbpf/list/?series=841034&state=%2A&archive=both

Pawel Dembicki (5):
  net: dsa: vsc73xx: use read_poll_timeout instead delay loop
  net: dsa: vsc73xx: convert to PHYLINK
  net: dsa: vsc73xx: use macros for rgmii recognition
  net: dsa: vsc73xx: Add define for max num of ports
  net: dsa: vsc73xx: add structure descriptions

 drivers/net/dsa/vitesse-vsc73xx-core.c | 246 +++++++++++--------------
 drivers/net/dsa/vitesse-vsc73xx.h      |  27 ++-
 2 files changed, 136 insertions(+), 137 deletions(-)

-- 
2.34.1


