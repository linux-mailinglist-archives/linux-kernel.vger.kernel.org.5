Return-Path: <linux-kernel+bounces-149217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2D58A8D47
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36EF028730A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D003481B5;
	Wed, 17 Apr 2024 20:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R12vZUJa"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B86C3D967;
	Wed, 17 Apr 2024 20:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713387088; cv=none; b=Qy5EqfYez4SWa8qLcxzaXmOLYPm+9Nx6Vr5hlSx++6EhrgVPG+3faFfJWyPRUWYdJzg83OAo/Eeg1P+uOqREIQJF9iS57eBG48bbHWXpZtnCBgqPnzRI02AuWFhqeJnyc+W/w/HXYF0iFFFmfbZbuQevr9kn31cIpF+MCByDa/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713387088; c=relaxed/simple;
	bh=ruJFVMpqO2dKVdbbCqF1Qew11TTMpiqoj2fWtLoLhj0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WjISfCKawevH+8kNyBF2qrMYJuG/to7RAvG7giPZ5ivAlU1jjaiAv/5WieAIyutkqhQiVAPWXJzQFQVy7MQ8VcTmKJhmN7tqz9Wh80cUEhJYfyu+8AOFU5Vp9NV+ZenPpf72vB5jrG+10LM4i9EL6Bo/t1vVA4QbGrpXpH3dVAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R12vZUJa; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56e1bbdb362so153658a12.1;
        Wed, 17 Apr 2024 13:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713387085; x=1713991885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PP9vybSDiobOue6OOFy5JQgDIqRTYmNSQ/1vik1IRyI=;
        b=R12vZUJancYF5S5CnKBXO/s+bZWxE9BD+i3K/Cngb00aVA3g4CcbyiQhbzFiMkoUFB
         ajb/Fte3Nqdqrxme/9T/XiVSVWHlaFpGjK5DWmDAOUcj7x00tM+7303FjGM8mMjHOPbi
         PQFRArzLEzGF01jhRKJ4G2hv1MiFSQan1vco7usq1O78LXrkHAL531SuKD7Jj1HQs2J+
         mMUWnk4El+DXTksgNC9QLRqN+4eeP89AAUPU9++nkmdNhjUyuLoleE0vHHDPeYznqErX
         JYYbXf2v7q1/P7WOgzro9ZuF/Rh/8sT9RdPpCmdU3r+ONUlKMkgdVNr2oBv14JnFKqSH
         semA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713387085; x=1713991885;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PP9vybSDiobOue6OOFy5JQgDIqRTYmNSQ/1vik1IRyI=;
        b=jcoLo/5OMA7gmuE3eLUroahYm6R6n9ryK+8omKT+O9ZP6gaJ4nbta7p0JFkhRCWLjB
         cvW2pC9ZcENmO7ljYy/aHdYWpiDLXwF9Dld2zLTfz2RaMmfJqCHkiLpnYwbN6vW9jHuC
         y2bTkkKQ0WRVk8u7gTPEZf5v0URhHMflDZ5EiF6NTr4LUDn/3JPOFXRAr93/mNlGznNO
         QXN5znBm++rG9//+EPIJZO0z9o1B1fWEQE0Oo0LV3fUCPpXl3KMnnSrXqR2zP0kuYc6p
         wKfqTmiximGHQWF/Dnd1P9ZOqjc8OfNYndgTJUha/h6aBMqFQmayeytIIhHXHmWZpAeG
         sU4w==
X-Forwarded-Encrypted: i=1; AJvYcCVyGsnRpqppskF2ChCZEG1mFuGQ6grSmFPRrp8wn5a5vjpi4AyMGl0ktNpyWCPGLXFrguMiBJeLrJwJvVaF9NwMaNRhzZX+eZCf4u/+
X-Gm-Message-State: AOJu0YxqeP0iN3PHfo29HKA9DEHVCAJbPShAmGyULZwysbOD4yLf6ckh
	UQQS93gA4gux/jpeG4quFWAYUsZW8mSVk/ZExg5tYVVEtfyt7G4yu1f/dLdG
X-Google-Smtp-Source: AGHT+IEkYrVGOwSA9AtKLOJjNjsII62JiYMBT5rhhOfQ7jmeYJGCFd4NFzGIucWoNWWU89oVKsxjjQ==
X-Received: by 2002:a17:906:2748:b0:a52:27c6:ee67 with SMTP id a8-20020a170906274800b00a5227c6ee67mr482633ejd.43.1713387085026;
        Wed, 17 Apr 2024 13:51:25 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id tx24-20020a1709078e9800b00a554177a2cdsm31752ejc.85.2024.04.17.13.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 13:51:19 -0700 (PDT)
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
Subject: [PATCH net-next v2 0/5] net: dsa: vsc73xx: convert to PHYLINK and do some cleanup
Date: Wed, 17 Apr 2024 22:50:43 +0200
Message-Id: <20240417205048.3542839-1-paweldembicki@gmail.com>
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

 drivers/net/dsa/vitesse-vsc73xx-core.c | 253 ++++++++++++-------------
 drivers/net/dsa/vitesse-vsc73xx.h      |  27 ++-
 2 files changed, 143 insertions(+), 137 deletions(-)

-- 
2.34.1


