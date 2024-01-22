Return-Path: <linux-kernel+bounces-34002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBA98372AC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1E23B2BAA1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF525C8FE;
	Mon, 22 Jan 2024 18:46:18 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF1E5C61C;
	Mon, 22 Jan 2024 18:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705949178; cv=none; b=bn1uns3SZBRARIz7Y7VlgLCkheKZDNvzZn1Rxig+MniWJ2wlyoke0KwjnmA5LQ9mSMaraxXJcMAobTkPaJBoloqIzZEbJgflAahsClXFjpgX+2FxgTdlIapDptUVQtIA83XvPj8odbUzY2rSvjlK0eKGYUa5B5Sns1Hmep75Vm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705949178; c=relaxed/simple;
	bh=B0r81dsvC0EhFzUUx9/LT14DSXICfpgY2H5ECg0reLs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bGSYztpMNZ7+5iYAaGbW89ff6MhoP4HmYy5Ln2lVOh9DzASIZ1J67Mo62RgyKLgBPriIOpvRsK3Tfsw4pO0SvR7L5ELnLx97zPXp1kmRRKLRseOcklS80P2aOlhBzUKgd1akX0h3f5z9y/ASzq0ZNVhvYSmPFwXRT3Ivzj5BoJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55a8fd60af0so2410887a12.1;
        Mon, 22 Jan 2024 10:46:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705949174; x=1706553974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9UKlActuHp1P3aKfG6Qy7nOc85t689CaZCZC6ToyYug=;
        b=TlILAnbmUMcBx4hxU2nhtdujdQXxu8huV+wG3qwn2b7r+3y42j8KI5jvmrmwu7+q0B
         Q2EngwpIB4KotVkO6eSYJzEmiJFExW15hI6nUmqDtFXQ3pFY7qvbxN/siVHS/tyGcnyF
         u9gzVElKWTtDSX10JeGRxBFxA4bM2t2rENklbwDI1sS52Ixpb4OgiSdR2E0VCKAinfWf
         Wwf/QbpmbuYCZHLVZWn9QIwFklptFwnFwgKJV/V7qfO0TRIFy8uEZVE8hkdrTkxWJ5NX
         STmPmnNAQgQqntZDX9Hh1b/9W2zjxWcrxG5Vda62Udxak1JmoKdUe40fp5BvPuAZvy9+
         oskA==
X-Gm-Message-State: AOJu0YxbOxfCwH34LSyqY2r3NQj+Gd5wkcTdGN0c6hseefwRdNwqn0+Q
	W11nZztUX0NlS10rnLx/h7c4jPz+qeuQ+Up1SMP+5irNd5YaKlS5
X-Google-Smtp-Source: AGHT+IFn2xn8AVpzF0DDk7wHVqXASIlgdD6RxQKOYVhaP5aiCD8e3TTdYaDsxDSHKgLNG9oniSubaA==
X-Received: by 2002:a05:6402:7c8:b0:559:e3d2:6ba1 with SMTP id u8-20020a05640207c800b00559e3d26ba1mr100225edy.95.1705949174353;
        Mon, 22 Jan 2024 10:46:14 -0800 (PST)
Received: from localhost (fwdproxy-lla-000.fbsv.net. [2a03:2880:30ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id e9-20020a056402104900b0055c15c5919csm2269096edu.86.2024.01.22.10.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 10:46:14 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	abeni@redhat.com,
	edumazet@google.com,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: dsahern@kernel.org,
	weiwan@google.com,
	netdev@vger.kernel.org (open list:BROADCOM BCM4908 ETHERNET DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 04/22] net: fill in MODULE_DESCRIPTION()s for Broadcom bgmac
Date: Mon, 22 Jan 2024 10:45:25 -0800
Message-Id: <20240122184543.2501493-5-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240122184543.2501493-1-leitao@debian.org>
References: <20240122184543.2501493-1-leitao@debian.org>
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
index 3e7c8671cd11..a6bc5ce70230 100644
--- a/drivers/net/ethernet/broadcom/bcm4908_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm4908_enet.c
@@ -793,5 +793,6 @@ static struct platform_driver bcm4908_enet_driver = {
 };
 module_platform_driver(bcm4908_enet_driver);
 
+MODULE_DESCRIPTION("Broadcom iProc GBit Ethernet driver");
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
index 6e4f36aaf5db..6c53ea522daf 100644
--- a/drivers/net/ethernet/broadcom/bgmac-bcma.c
+++ b/drivers/net/ethernet/broadcom/bgmac-bcma.c
@@ -362,4 +362,5 @@ module_init(bgmac_init)
 module_exit(bgmac_exit)
 
 MODULE_AUTHOR("Rafał Miłecki");
+MODULE_DESCRIPTION("Broadcom iProc GBit BCMA helpers");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/broadcom/bgmac-platform.c b/drivers/net/ethernet/broadcom/bgmac-platform.c
index 0b21fd5bd457..5bdd875831f1 100644
--- a/drivers/net/ethernet/broadcom/bgmac-platform.c
+++ b/drivers/net/ethernet/broadcom/bgmac-platform.c
@@ -298,4 +298,5 @@ static struct platform_driver bgmac_enet_driver = {
 };
 
 module_platform_driver(bgmac_enet_driver);
+MODULE_DESCRIPTION("Broadcom iProc GBit platform");
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


