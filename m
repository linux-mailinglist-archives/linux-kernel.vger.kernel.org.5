Return-Path: <linux-kernel+bounces-45456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A97F8430F7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B4E52880F9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CD980C17;
	Tue, 30 Jan 2024 23:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQe58B2g"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8577D80C05;
	Tue, 30 Jan 2024 23:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706656466; cv=none; b=kM7Asg8vw+uzLWQ2krMxmasKTylpq4yBpFOFsowuNLCkKLDpAN0/TqZlBa9L5eMg0CYhcfuBefxnzJFXHR/rwnSNeTTZHfPkxrbvtbjX32+eJD7/Py2XAP09mgPLi0hwjTDTm1JrttVdrzQIqSsVA+ZpqYX0dkiMec0CFwZPxlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706656466; c=relaxed/simple;
	bh=O9Z0K/in+V/0Sg8kYoxYiAta8TGB/5GvVdjlD41NHi4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZAjIuc3m0V4J4ScEJTnhOoPJ7p4BFyhKj/+BTWvUkVXQOII7IAiwTJGvT1pvah6Cq0H4XiTEK6a2OUQVdntYiljr/ef2KWfa0gp0V5fpvCd7pghDZ463yXPv+SNv4Vf3Hrdy07S+oqvp4zGiqzvt3U3OWOkSE3U2bnBXfzuLcYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQe58B2g; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d751bc0c15so38780395ad.2;
        Tue, 30 Jan 2024 15:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706656464; x=1707261264; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RFmiP8u0XylO+2YgibNLkampEImJxL5ecq2MK58dcw0=;
        b=bQe58B2gRzgtrK/IoIl7R44LIVaXm6rA2fjGIryAOa2JDkYkaYRiz9RJ4RJj2ymNUq
         irOHKNCi2FEuIbT89fmDrYVHzgp1ltuQ+0qcY/SFaLPlF3GNmbUN8ghRzOGwzL1yQElT
         Ldfdo5wwiUASerA3Nn9IWEzCSVOeMJJoXCWt6G71Wap5xM87gMzsYsan70xXnRldSj00
         Iea1SBi64U/qbrJVFFyozxav2FnAApzVXVN1VxzAHZz3dMiN7dXGpPq3eLZcBBcVv17w
         AY3xdbaMLtzr+DZLk96WbBewTuu3pR8juFhWOqVkLUqVVZ93pI6EB/ZQPUD60MwJN0hj
         QWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706656464; x=1707261264;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RFmiP8u0XylO+2YgibNLkampEImJxL5ecq2MK58dcw0=;
        b=pOiP0kuCNUQCJEDwfPBR5eilwzmU8V8L9qlLhHL1VeE55ZIe+kBmHrS28V06rZ7rOV
         9JOceXGKqrNui8TFXGjVeRQNjZukwbU5QQzCY+89qlw3MkpjTqk7j5lVohxHLOSWGYIB
         QRCWs7V6wyCcKCkA1YyijCNYJdVwnHh/S9cJfImTM5Ui2wlYJoqvlprmSK2S74of40y/
         LNJKk7o9w/CAC/jUR8o8Y0IyIVfkOIJIzjCunD0UaslLzLqXm68nVyWllx+G4lZnQPS9
         Te1jguqLZ4jY9S2aJU/7SH+yrigt6vVq/92v9N9yCvkOdzd9+zO+Ic9stLh1O2ajROnO
         AaSA==
X-Gm-Message-State: AOJu0YyWF4UC4W4gDv/qK9q9gbBI4nD/jL0dRFHfpnZKEng1QCF34kMu
	4gjizG2MpbHQ/dP1nth4RC5A/BTnFayw5Ph64QkRZETTSFUNzfSs
X-Google-Smtp-Source: AGHT+IHtV7cUKcq853ZxhKvS4K7ojFoeShVj+4T2XqDF+UzKfx3F1lfH4q7yOB9KKEgzeGpDEoaISw==
X-Received: by 2002:a17:903:11cc:b0:1d8:ebdf:183a with SMTP id q12-20020a17090311cc00b001d8ebdf183amr80430plh.6.1706656463871;
        Tue, 30 Jan 2024 15:14:23 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([2804:c:204:200:2be:43ff:febc:c2fb])
        by smtp.gmail.com with ESMTPSA id jx2-20020a170903138200b001d8f251c8b2sm3473203plb.221.2024.01.30.15.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 15:14:23 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Tue, 30 Jan 2024 20:13:25 -0300
Subject: [PATCH net-next v5 06/11] net: dsa: realtek: merge rtl83xx and
 interface modules into realtek-dsa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-realtek_reverse-v5-6-ecafd9283a07@gmail.com>
References: <20240130-realtek_reverse-v5-0-ecafd9283a07@gmail.com>
In-Reply-To: <20240130-realtek_reverse-v5-0-ecafd9283a07@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3898; i=luizluca@gmail.com;
 h=from:subject:message-id; bh=O9Z0K/in+V/0Sg8kYoxYiAta8TGB/5GvVdjlD41NHi4=;
 b=owEBbQGS/pANAwAIAbsR27rRBztWAcsmYgBluYKxF8R4opkUW6HN6uV0Nens8pcKQvtDrelMM
 MAsQSccR9CJATMEAAEIAB0WIQQRByhHhc1bOhL6L/i7Edu60Qc7VgUCZbmCsQAKCRC7Edu60Qc7
 VpjIB/9s7c9o2n3On29AW5hEBVabaguN1eI0gdan+JynoEAYTLsjy1jX8dLLQUzii91j6xBuQH4
 Nbs7e35EA+BXFrOx/80R2frlIX4ADz6kzy8D9oK8TUCClDHpDliTy7q9X6KBBFBX3aYZGCDycwy
 1bzYU6h8l236jjens+/qhye7A9kkNRkEc2r6UZbED9MkFpag5LFpaovzogoPe/EvTdHJr7z1eHP
 Utzwm8BGokEGezUMUBht+uwDuv0agxKV46zhrom9gLgMZnnN7YDlQ4QrXPDapN57b9RQpjsqYmS
 PEUAv6B0nyitR6hr/Gz+qlSS4rFuarn6126UyPNqwqHRlx1l
X-Developer-Key: i=luizluca@gmail.com; a=openpgp;
 fpr=1107284785CD5B3A12FA2FF8BB11DBBAD1073B56

Since rtl83xx and realtek-{smi,mdio} are always loaded together,
we can optimize resource usage by consolidating them into a single
module.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/realtek/Kconfig        |  4 ++--
 drivers/net/dsa/realtek/Makefile       | 11 +++++++++--
 drivers/net/dsa/realtek/realtek-mdio.c |  5 -----
 drivers/net/dsa/realtek/realtek-smi.c  |  5 -----
 drivers/net/dsa/realtek/rtl83xx.c      |  1 +
 5 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/net/dsa/realtek/Kconfig b/drivers/net/dsa/realtek/Kconfig
index 9d182fde11b4..6989972eebc3 100644
--- a/drivers/net/dsa/realtek/Kconfig
+++ b/drivers/net/dsa/realtek/Kconfig
@@ -16,14 +16,14 @@ menuconfig NET_DSA_REALTEK
 if NET_DSA_REALTEK
 
 config NET_DSA_REALTEK_MDIO
-	tristate "Realtek MDIO interface support"
+	bool "Realtek MDIO interface support"
 	depends on OF
 	help
 	  Select to enable support for registering switches configured
 	  through MDIO.
 
 config NET_DSA_REALTEK_SMI
-	tristate "Realtek SMI interface support"
+	bool "Realtek SMI interface support"
 	depends on OF
 	help
 	  Select to enable support for registering switches connected
diff --git a/drivers/net/dsa/realtek/Makefile b/drivers/net/dsa/realtek/Makefile
index 67b5ee1c43a9..6ed6b4598d2e 100644
--- a/drivers/net/dsa/realtek/Makefile
+++ b/drivers/net/dsa/realtek/Makefile
@@ -1,8 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_NET_DSA_REALTEK)		+= realtek-dsa.o
 realtek-dsa-objs			:= rtl83xx.o
-obj-$(CONFIG_NET_DSA_REALTEK_MDIO) 	+= realtek-mdio.o
-obj-$(CONFIG_NET_DSA_REALTEK_SMI) 	+= realtek-smi.o
+
+ifdef CONFIG_NET_DSA_REALTEK_MDIO
+realtek-dsa-objs += realtek-mdio.o
+endif
+
+ifdef CONFIG_NET_DSA_REALTEK_SMI
+realtek-dsa-objs += realtek-smi.o
+endif
+
 obj-$(CONFIG_NET_DSA_REALTEK_RTL8366RB) += rtl8366.o
 rtl8366-objs 				:= rtl8366-core.o rtl8366rb.o
 obj-$(CONFIG_NET_DSA_REALTEK_RTL8365MB) += rtl8365mb.o
diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
index 7cbce3e893e1..45d9ef43fe3d 100644
--- a/drivers/net/dsa/realtek/realtek-mdio.c
+++ b/drivers/net/dsa/realtek/realtek-mdio.c
@@ -184,8 +184,3 @@ void realtek_mdio_shutdown(struct mdio_device *mdiodev)
 	rtl83xx_shutdown(priv);
 }
 EXPORT_SYMBOL_NS_GPL(realtek_mdio_shutdown, REALTEK_DSA);
-
-MODULE_AUTHOR("Luiz Angelo Daros de Luca <luizluca@gmail.com>");
-MODULE_DESCRIPTION("Driver for Realtek ethernet switch connected via MDIO interface");
-MODULE_LICENSE("GPL");
-MODULE_IMPORT_NS(REALTEK_DSA);
diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
index ffa68272d0d4..67bdad7ac910 100644
--- a/drivers/net/dsa/realtek/realtek-smi.c
+++ b/drivers/net/dsa/realtek/realtek-smi.c
@@ -464,8 +464,3 @@ void realtek_smi_shutdown(struct platform_device *pdev)
 	rtl83xx_shutdown(priv);
 }
 EXPORT_SYMBOL_NS_GPL(realtek_smi_shutdown, REALTEK_DSA);
-
-MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
-MODULE_DESCRIPTION("Driver for Realtek ethernet switch connected via SMI interface");
-MODULE_LICENSE("GPL");
-MODULE_IMPORT_NS(REALTEK_DSA);
diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
index 702ee0d40b0b..fb3b3b2305d1 100644
--- a/drivers/net/dsa/realtek/rtl83xx.c
+++ b/drivers/net/dsa/realtek/rtl83xx.c
@@ -229,5 +229,6 @@ void rtl83xx_remove(struct realtek_priv *priv)
 EXPORT_SYMBOL_NS_GPL(rtl83xx_remove, REALTEK_DSA);
 
 MODULE_AUTHOR("Luiz Angelo Daros de Luca <luizluca@gmail.com>");
+MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
 MODULE_DESCRIPTION("Realtek DSA switches common module");
 MODULE_LICENSE("GPL");

-- 
2.43.0


