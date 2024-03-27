Return-Path: <linux-kernel+bounces-121633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB7288EB4E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41DAD29EED9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9811D1327FF;
	Wed, 27 Mar 2024 16:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKLAYYPD"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504B61311B6;
	Wed, 27 Mar 2024 16:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711557021; cv=none; b=SbPnF9Abu4hz77vyXjDHim2JYNap4bdp+/9bMLM3FnggzpUh2Ghrmjen318WbuVvhlL0g4HOxi3d/31N4k6zgCsKp9sHrIbpk1BqP92StPD1mQnVZ+orfC+iCA/LiHMEQu9F/71oyqyFLJE+O0g4x8Y7iUbuJf80U/LKejpbRh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711557021; c=relaxed/simple;
	bh=+IQ0w5v5MheTaI5m471++uoq8tmNWb8WrcmDZ/hhJUY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M3Cw7WJAW8yAiVS1ctYG14CCYu6GCGAfcPxV2LWA36hq8P3LIoVJ6ZlXXNbgGm3Is29MqN/DiXvPTtap6XzamuB3XQVL6C8EBmnbYKbdeatPZJWr9bSWN+Z+JI7LYxpXju3mBfY+cIa+95WTBS7XuRjTd7pA8C3Py4xCMiD9OXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKLAYYPD; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a4a39ab1a10so239566b.1;
        Wed, 27 Mar 2024 09:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711557018; x=1712161818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbVD9UKbAsHeFEJViP5OC4bsSoJgyMJMV/qKCudoXnA=;
        b=fKLAYYPDzwVayhbFeGead9WG7pquGh/9nah3qWhbcuOd6Jd+CIufUbbMKrYALS8vLp
         1Vqm/icj7//trCDnASy/WI8txWu6bPgnz9GBBN4JB3IeH8XRMy0AncxhVg3ee7tuSkSK
         L5iMr6wskr3oWDi+gxRnm/fbwA7F9T8TVPkoBi0Jr2Q9wlo5zJueXldYs7HKJrYcWRpt
         +RzQgJivYVquQ5mFy1a5nzmjR3uU6D6YLnRIrxXLIbfCRFsGEMbWAm9jstYIsAjzTdEw
         X9i069wi002NNRS34h/JntBve7JE4crPIiRuNY3nhsgcKz+cs3FOf6CxGDB4/F3ZRnJp
         eOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711557018; x=1712161818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CbVD9UKbAsHeFEJViP5OC4bsSoJgyMJMV/qKCudoXnA=;
        b=SCJjFcKiDjj3bBEM/YOVt3JvhXDxK/UpkuCq4eAoetMtbJmMW7DitDyp4rzcOKUIP+
         C3hcurY88KymBPOX1GCfaoXHDa9Ja7pWTefa31bH4tHaPhRbVIEE/tCX+QqYnW7QQT+y
         Ho2M7CdbvUuYNkBWYxRHgJEfid/+4FpCtfmo604rV7erygTZyieNkjvFEc7kunlGluDO
         WLKSzkSJKX/dRhrRZzrPGiFt0Mp33GOOttZ7I/9rWLMN/Zj68sjbwVfnJ4DSKsImItu3
         IhxoNsQxuYPG2/8Q0o96o9aQZvNtTpqGPONuHvmruNiSPaUObOu96xp4KAyEm1p4Nsus
         MtOg==
X-Forwarded-Encrypted: i=1; AJvYcCX0HL4gT6Jim4PBKb8GdXOb9KjR6twmrG3BE8Ioz/dWHm8zm/lRPAFHnosw+LYtonA70/TCZLbT9A8gczC5DaVexxQwWVuRV6rU3uic
X-Gm-Message-State: AOJu0YyrD0HwCQMcSSPS0iajK7gRRgaUyGGRGp9rkixWD+qxCqWPCtrO
	8XDTOfxO7un1FHYMDLydDTcx0YViaS38Pn4mfg0W/C0zlLaHxrlfHL51YQsWPjY=
X-Google-Smtp-Source: AGHT+IE5IBamCBAHkDaExv0oUwkjTN0V3VOPmjrWefJQCZMf4oVPcVseagMWY8AEy2MnxA+oAqTI/g==
X-Received: by 2002:a17:907:76f2:b0:a47:32b3:18c5 with SMTP id kg18-20020a17090776f200b00a4732b318c5mr2319745ejc.68.1711557018062;
        Wed, 27 Mar 2024 09:30:18 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id o9-20020a170906774900b00a46a2ac0dbasm5609385ejn.197.2024.03.27.09.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 09:30:17 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Shay Agroskin <shayagr@amazon.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/3] net: ethtool: Add impedance mismatch result code to cable test
Date: Wed, 27 Mar 2024 17:29:13 +0100
Message-Id: <20240327162918.2426792-2-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327162918.2426792-1-paweldembicki@gmail.com>
References: <20240327162918.2426792-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some PHYs can recognize during a cable test if the impedance in the cable
is okay.

This commit introduces a new result code:
ETHTOOL_A_CABLE_RESULT_CODE_IMPEDANCE_MISMATCH
which represents the results of a cable test indicating abnormal impedance.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v2:
  - introduce patch

 include/uapi/linux/ethtool_netlink.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index 3f89074aa06c..ecc020bd47d1 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -515,6 +515,7 @@ enum {
 	ETHTOOL_A_CABLE_RESULT_CODE_OPEN,
 	ETHTOOL_A_CABLE_RESULT_CODE_SAME_SHORT,
 	ETHTOOL_A_CABLE_RESULT_CODE_CROSS_SHORT,
+	ETHTOOL_A_CABLE_RESULT_CODE_IMPEDANCE_MISMATCH,
 };
 
 enum {
-- 
2.25.1


