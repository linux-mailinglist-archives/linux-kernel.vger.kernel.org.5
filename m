Return-Path: <linux-kernel+bounces-35957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B3483992A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3668B2D3A9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D69486140;
	Tue, 23 Jan 2024 19:04:09 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891B285C51;
	Tue, 23 Jan 2024 19:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706036649; cv=none; b=VaBgBLLjWzoj4QlEbP7q42UrtaFij8W+c06AaJRpxerDV6QQ/uchbN5dFOleBKyXZKckMxWdsYPoX2B2Mo+xlDjisxoRlPVQfmE2rjCPRet/yv6wPO/Ik+EWB6+vJiJG9i174FILs+mUbSPg8Ozz+kxLx0Eyslwg4aLrnISMTx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706036649; c=relaxed/simple;
	bh=q11SjeLHIffDupzOy17+vN5caAfzzMc0RZ0GeUYwVZo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TTYSqaaHB/6I5+Jnns1y7ccNRi3xqGTcfxgspDQ+h95k0IBdMse5RyzxmzcI7eHYVLjS6dIProte7aRR5ZxWqX0q3+nyHYdGwU+JCDkI8OteC4oop3/D5PSZtm/y7jGVw5LZ+cSawrW4twyAFsYKB2m2N8kDIFLBXp36+pDlsUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a30ed6dbdadso51704566b.1;
        Tue, 23 Jan 2024 11:04:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706036645; x=1706641445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UaYmaU4+wS1JLEC+FHOFhGdSjofs8J7IZAFKIL08Xaw=;
        b=FLAuUfXgy3SNBS3ClcjoVQaybAje+UnLkx44/a8zVFHxc3KOyUp7lvwwmUcN4+Snl1
         5XITa53w6ljYpg42X3/+xc6wuAbJvIDtENLVUR/kwlBBlJg/t0KXXrQAwronMeEuc/zR
         JUHQXgN9Gxe5+LtAivcvrAnRsvHhzkDF1WK0BisAvQXSW624wKZ7dbtkk9qjz3Yc/xOb
         dVPz8wObAMKKn1EniQ0Su6T/8oDA9ffpfsHhPjoZYRjO4Q9Yg5e7c0V6rHSd3nzc+kmN
         PwqNfT1wITl3BfchHe4MdP2aUGmfsZ2tALwfikwa5fmN26frJWSw4HCniCDLEr6M66zi
         yb+A==
X-Gm-Message-State: AOJu0YyNSNDUiCqQtoJZBflFzR3MBZs7a3nc6PGgW6hlwYbDRE36gckI
	lPZQ/tSzfn6v8qP5YD9HCfE+3eHTRIXQBadVAJ0wVh/6pbF1T49r
X-Google-Smtp-Source: AGHT+IGo0bdsHsFx2Zd+pOXzZaZL9Tdd+YE5lFUHaAgV3grb7krUJ3yQGCJxtC3zpBzk9QVkLqboiw==
X-Received: by 2002:a17:906:f34a:b0:a30:dca5:887 with SMTP id hg10-20020a170906f34a00b00a30dca50887mr166035ejb.87.1706036645425;
        Tue, 23 Jan 2024 11:04:05 -0800 (PST)
Received: from localhost (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id vu3-20020a170907a64300b00a2d7f63dd71sm11569765ejc.29.2024.01.23.11.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 11:04:05 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: dsahern@kernel.org,
	weiwan@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 02/10] net: fill in MODULE_DESCRIPTION()s for Broadcom bgmac
Date: Tue, 23 Jan 2024 11:03:23 -0800
Message-Id: <20240123190332.677489-3-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240123190332.677489-1-leitao@debian.org>
References: <20240123190332.677489-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to the Broadcom iProc GBit driver.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/broadcom/bcm4908_enet.c    | 1 +
 drivers/net/ethernet/broadcom/bgmac-bcma-mdio.c | 1 +
 drivers/net/ethernet/broadcom/bgmac-bcma.c      | 1 +
 drivers/net/ethernet/broadcom/bgmac-platform.c  | 1 +
 drivers/net/ethernet/broadcom/bgmac.c           | 1 +
 5 files changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bcm4908_enet.c b/drivers/net/ethernet/broadcom/bcm4908_enet.c
index 3e7c8671cd11..72df1bb10172 100644
--- a/drivers/net/ethernet/broadcom/bcm4908_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm4908_enet.c
@@ -793,5 +793,6 @@ static struct platform_driver bcm4908_enet_driver = {
 };
 module_platform_driver(bcm4908_enet_driver);
 
+MODULE_DESCRIPTION("Broadcom BCM4908 Gigabit Ethernet driver");
 MODULE_LICENSE("GPL v2");
 MODULE_DEVICE_TABLE(of, bcm4908_enet_of_match);
diff --git a/drivers/net/ethernet/broadcom/bgmac-bcma-mdio.c b/drivers/net/ethernet/broadcom/bgmac-bcma-mdio.c
index 9b83d5361699..50b8e97a811d 100644
--- a/drivers/net/ethernet/broadcom/bgmac-bcma-mdio.c
+++ b/drivers/net/ethernet/broadcom/bgmac-bcma-mdio.c
@@ -260,4 +260,5 @@ void bcma_mdio_mii_unregister(struct mii_bus *mii_bus)
 EXPORT_SYMBOL_GPL(bcma_mdio_mii_unregister);
 
 MODULE_AUTHOR("Rafał Miłecki");
+MODULE_DESCRIPTION("Broadcom iProc GBit BCMA MDIO helpers");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/broadcom/bgmac-bcma.c b/drivers/net/ethernet/broadcom/bgmac-bcma.c
index 6e4f36aaf5db..36f9bad28e6a 100644
--- a/drivers/net/ethernet/broadcom/bgmac-bcma.c
+++ b/drivers/net/ethernet/broadcom/bgmac-bcma.c
@@ -362,4 +362,5 @@ module_init(bgmac_init)
 module_exit(bgmac_exit)
 
 MODULE_AUTHOR("Rafał Miłecki");
+MODULE_DESCRIPTION("Broadcom iProc GBit BCMA interface driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/broadcom/bgmac-platform.c b/drivers/net/ethernet/broadcom/bgmac-platform.c
index 0b21fd5bd457..77425c7a32db 100644
--- a/drivers/net/ethernet/broadcom/bgmac-platform.c
+++ b/drivers/net/ethernet/broadcom/bgmac-platform.c
@@ -298,4 +298,5 @@ static struct platform_driver bgmac_enet_driver = {
 };
 
 module_platform_driver(bgmac_enet_driver);
+MODULE_DESCRIPTION("Broadcom iProc GBit platform interface driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
index 448a1b90de5e..6ffdc4229407 100644
--- a/drivers/net/ethernet/broadcom/bgmac.c
+++ b/drivers/net/ethernet/broadcom/bgmac.c
@@ -1626,4 +1626,5 @@ int bgmac_enet_resume(struct bgmac *bgmac)
 EXPORT_SYMBOL_GPL(bgmac_enet_resume);
 
 MODULE_AUTHOR("Rafał Miłecki");
+MODULE_DESCRIPTION("Broadcom iProc GBit driver");
 MODULE_LICENSE("GPL");
-- 
2.39.3


