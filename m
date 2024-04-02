Return-Path: <linux-kernel+bounces-128643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B724D895D59
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A54FB25E96
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D5B15D5C1;
	Tue,  2 Apr 2024 20:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnyGtojL"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F73E15B966;
	Tue,  2 Apr 2024 20:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712088699; cv=none; b=qZFKvKwGYenN9e0HH1nPh/DDZV8DAshCtTGoARgZHhA8nKOdR/LeHc/k4Twypqn2rGLMMNm2PvJjLax96Un0m1eOI7qztHAhEbdB7mZTpv95nJFfR+EVoUqIimK8200NgIga6KojS9ogibTa6W2WxbNATSstwxJ4EJcnuUo0XNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712088699; c=relaxed/simple;
	bh=ARVTOUd5GsEZBV4agURD9UrjWRU/ncQ4Or63i0u3E/k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kBKV35prm2vI+HM6ZlEXvef+jctoUozhw5mlnURtL7JEGDLo1kVsrJ5C8JHfe6gtaLylQU7YCFRnTNKCQqLzBJDwwy5XIzLqa0/H5H3ITJRDoUn+ci99PWPUKIceHGQrW/yhkgKGTd80HpYOmuT+ojSGb38g+U7kZ0PFlnpqb2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FnyGtojL; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51381021af1so7712468e87.0;
        Tue, 02 Apr 2024 13:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712088695; x=1712693495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h9XGmtr4tKryDcF6zZrLSZqjNQPqsK7oIswVla3FBTc=;
        b=FnyGtojLUgPY+M0KD9t90ZwiYZZTEZDMDK025GcUSlJjhgzH1L8gaL9zN9x5vxAY2l
         rBS2kj4YetUHQvD6ayKVqCaGfItFPnDjgIP7Zpm61E7WPngpj86iQwIbhyxKJ0sAc62m
         VvozqDLSrYdu8jCVn7gSL1SjDGc7l1wqSNq8ZlWZ4tpUzXex+ivFEOjRNlU7BEImfCXS
         lexw5RYJrnaH1/kY9kRT+2/zZpp7U93aKsYd7i+eaCQhqK1iv9Zx9yIpL+R6EN5un7b7
         34S8qCUhiT7KzspLs18l/Wq4huMeT0u2tTdPepmneyGRjKcjwzCropIOxVtyAig/9eyI
         WO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712088695; x=1712693495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h9XGmtr4tKryDcF6zZrLSZqjNQPqsK7oIswVla3FBTc=;
        b=akB2myU5rikFkIdMjXi3/C7Ga6cwyKqXwGQkU26Ivofbgj9IgT2t3Tgzx/g8nb6Rlg
         lyjJf5MQJ66zKywn1LKxxJ97NTwqINiXcUKdJ4lpiVZqEjGsi3nsUw1KU3KI+Vl2YR/g
         uKlrLcTRwGZ6zBSsUaeO89tFYdYcCIpwFQdpFS8tZHqcgKxJufuamU801/eN/c2UapVD
         +aSMfosL+NGd/zU5VPQ0TeazVnPl54dcJYvITv+XaSZ4Dty7/40nu4MN1uUOA2bHj9Nh
         Y7SefsO6oCKSoDkgnOAsttDbsXRXvs8rYrz8higgf+j9RUJo+Cnpa/mOKzvj/wOrhqFt
         pyww==
X-Forwarded-Encrypted: i=1; AJvYcCVZ9qJ3a34WiHHSQv7mFY/GJfhLhpIiPZM+YuPTGqUX5q4ZikdAyj+zeufetGTa2/L6fc2DipB1JoX7MjWGHKo7ECxd1jVaTZXVz4ZU
X-Gm-Message-State: AOJu0Yz2eoMbbxdBxPz+F7UdNSwJ3oC73fpDl/FmUI7XiRcXp5E5jFBX
	7KSaGuKlWJeTV0EtuXx4mA0KWkyUpqQXkXdXTlz4Lwc+vAHQWB4n5RamMaPMwhg=
X-Google-Smtp-Source: AGHT+IEEPAFT+/kOPM/Mp52nF4sjsm7PJK6duhPlAH41iXW4qrQWN6qaA2sLT7guCuQmPutOTMR3BA==
X-Received: by 2002:a2e:9790:0:b0:2d4:49d1:38e with SMTP id y16-20020a2e9790000000b002d449d1038emr2248730lji.28.1712088694809;
        Tue, 02 Apr 2024 13:11:34 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id re26-20020a170906d8da00b00a474ef94fddsm6903829ejb.70.2024.04.02.13.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 13:11:34 -0700 (PDT)
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
	Ahmed Zaki <ahmed.zaki@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 1/3] net: phy: marvell: add basic support of 88E308X/88E609X family
Date: Tue,  2 Apr 2024 22:11:18 +0200
Message-Id: <20240402201123.2961909-1-paweldembicki@gmail.com>
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
v3,v2:
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


