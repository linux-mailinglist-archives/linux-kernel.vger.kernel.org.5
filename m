Return-Path: <linux-kernel+bounces-121631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F81088EB4B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55D071F2FE1A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1063A41757;
	Wed, 27 Mar 2024 16:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYFnl4+6"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AC3130AD3;
	Wed, 27 Mar 2024 16:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711557011; cv=none; b=Da2jNWLJLlGQXQ3UWKHYnITsOk4GdD9DxAmA7GOnaqsAlxsVemg74mFkr6T5LKgX6v6JPHLzP0wvvjJm6k2Uxjx6upGkMdj2WuyOtQqcOuCmCiJVtG7qFTR5gHbB0yBPrLi03VECnOL8vdVqetZGM9ZwqKOjQg982o0NiRKeLlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711557011; c=relaxed/simple;
	bh=ynrZQjK78RiFfHs8spnknPgeIpfTWGgafOjmPY/DV0o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QIPOOtImKWM6oz5LcjEIRfPIp/7ZAApe+LRtO28J/e4K5D+jVJL2M3P0koifkcoFKPeYIRbf3Wa6zqR/STVYy/cv17V37zUELhXl56kSYUZ59aqquf/m5oSnCOalTxXvJ4F3vvaIBivsU/l6tnB/y1HM48fTRo6S6snS8E8U9pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYFnl4+6; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56845954ffeso12345a12.2;
        Wed, 27 Mar 2024 09:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711557007; x=1712161807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=em40ZdcYw5a0qmsk0GSXegTRRtyY4Q3EIhC6d6DCO1M=;
        b=hYFnl4+65t2KB66aBCiqwiRjlcGevWK6k8mtRnZIG36KSzDKEilQ7ge6xsZ4NDD7PI
         q49xGXbcocYYT3Hpr2xr84vdPolXzO5YUr2jCFuy7ar6ave2g4t4OR6z5WF0YVuTrys6
         AMTtFphfGR+DE+phkTE7CaJldD2J1Tm6zPMHDXJkY+L4f4bq4+O1wPSkjpKH+TaSq9vX
         yFtyqSFCAvDM6muTcUVnCocAJeMlTL6x/4vlH1xuflfJvvfX5v98xovpfuHimnpGVGAv
         XEJ0UCMOHLJWFlBTjJmTSVqgXLwozV4aJn4pp/8Ft1vN7Fukylq4e9heTQeszElKkbUa
         OsvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711557007; x=1712161807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=em40ZdcYw5a0qmsk0GSXegTRRtyY4Q3EIhC6d6DCO1M=;
        b=RsfslPAkXKfM1qTl378LJ8ssAeLXJgg0Y29iy+s0k1Kn1gV41eHeqJqTobjZgGyKeO
         R09/eyKFwuzsqbF50t2rMFsqvd+yzPpVWAvXD2h8hLA//wEiqJKmw8LESQMLycESFMub
         ot42HW5X2ZBN74zzVQzkdRuSkrPKIpqo60COdBhoJFbozwJqSP5LC1uRnOykKJpATRoc
         FeruPXtMfb3FuU1bvYddv1rqBfcdJiBDqtYAhOlVbxB53TZEgKc3J1Fb1+/WjJR2yz0B
         URrxTU4JoqOcJcLmly5MPArY9uedjk9R2Mq7dRlTkUtkbmZefQ5Xxs02R/rq7wfJrJiv
         E+Ng==
X-Forwarded-Encrypted: i=1; AJvYcCVAkfjTJ5Ac+jOlkIikLd6D0lB10GWF4u8tFDzOMiHA9JUZmtXlwelVIPxo3VGlCu9MEksm9aLVvxvZ2srwFeVolwJwZn1rOKanL0Hm
X-Gm-Message-State: AOJu0Yw9ubNKuZ8Eonjm8wG9F7jGCdZtrQfbDfotjCtuX03RmHS4pCp0
	fth6h7PLo7LZktlI+sc78NFzX8oA62AezDvW+jBjHNZgoXmjuEWf0lFQfKwmbzw=
X-Google-Smtp-Source: AGHT+IGk9dp4lkbSkdtzFPdEB7sD8HaIbkmvaSXvGTU9OnFIWAMR90hLatWAeyEvMtPI47877NvIpA==
X-Received: by 2002:a17:907:7e88:b0:a4e:113b:52cd with SMTP id qb8-20020a1709077e8800b00a4e113b52cdmr139936ejc.20.1711557007316;
        Wed, 27 Mar 2024 09:30:07 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id o9-20020a170906774900b00a46a2ac0dbasm5609385ejn.197.2024.03.27.09.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 09:30:06 -0700 (PDT)
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
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Shay Agroskin <shayagr@amazon.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/3] net: phy: marvell: add basic support of 88E308X/88E609X family
Date: Wed, 27 Mar 2024 17:29:12 +0100
Message-Id: <20240327162918.2426792-1-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch implements only basic support.

It covers PHY used in multiple IC:
PHY: 88E3082, 88E3083
Switch: 88E6096, 88E6097

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

---
v2:
  - resend only

 drivers/net/phy/marvell.c   | 13 +++++++++++++
 include/linux/marvell_phy.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index 42ed013385bf..fae7eb57ee2c 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -3289,6 +3289,18 @@ static struct phy_driver marvell_drivers[] = {
 		.get_strings = marvell_get_strings,
 		.get_stats = marvell_get_stats,
 	},
+	{
+		.phy_id = MARVELL_PHY_ID_88E3082,
+		.phy_id_mask = MARVELL_PHY_ID_MASK,
+		.name = "Marvell 88E308X/88E609X Family",
+		/* PHY_BASIC_FEATURES */
+		.probe = marvell_probe,
+		.config_init = marvell_config_init,
+		.aneg_done = marvell_aneg_done,
+		.read_status = marvell_read_status,
+		.resume = genphy_resume,
+		.suspend = genphy_suspend,
+	},
 	{
 		.phy_id = MARVELL_PHY_ID_88E1112,
 		.phy_id_mask = MARVELL_PHY_ID_MASK,
@@ -3742,6 +3754,7 @@ module_phy_driver(marvell_drivers);
 
 static struct mdio_device_id __maybe_unused marvell_tbl[] = {
 	{ MARVELL_PHY_ID_88E1101, MARVELL_PHY_ID_MASK },
+	{ MARVELL_PHY_ID_88E3082, MARVELL_PHY_ID_MASK },
 	{ MARVELL_PHY_ID_88E1112, MARVELL_PHY_ID_MASK },
 	{ MARVELL_PHY_ID_88E1111, MARVELL_PHY_ID_MASK },
 	{ MARVELL_PHY_ID_88E1111_FINISAR, MARVELL_PHY_ID_MASK },
diff --git a/include/linux/marvell_phy.h b/include/linux/marvell_phy.h
index 693eba9869e4..88254f9aec2b 100644
--- a/include/linux/marvell_phy.h
+++ b/include/linux/marvell_phy.h
@@ -7,6 +7,7 @@
 
 /* Known PHY IDs */
 #define MARVELL_PHY_ID_88E1101		0x01410c60
+#define MARVELL_PHY_ID_88E3082		0x01410c80
 #define MARVELL_PHY_ID_88E1112		0x01410c90
 #define MARVELL_PHY_ID_88E1111		0x01410cc0
 #define MARVELL_PHY_ID_88E1118		0x01410e10
-- 
2.25.1


