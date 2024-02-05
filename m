Return-Path: <linux-kernel+bounces-53047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F170849FF0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 153FC1F21F4D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288A24CB47;
	Mon,  5 Feb 2024 16:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njNzfEvm"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198414879C;
	Mon,  5 Feb 2024 16:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707151758; cv=none; b=njvkVzZSSeY8smagVWWxVnE6uLBeZMCJTzqK/iMjJDqMu0eV1xpPKtSgSKfj4tsBiO1nMEFqq8SsntKyUv4oSMmr6HSksBTagnjPExc8LFd5zj26M71E5lvxWBLqSgyP20k1PsKcUel5F2lwIfmGF83OkEI1hbXZlCHWdCXaUYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707151758; c=relaxed/simple;
	bh=0dGPT223KlpSppcb4Q5nKzooandtEzP9beu2JwjbgUA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YlMGf0XtLdZ5W/Fh5TjKRtulLAZsotOc2MtwJ4/bw9aqGo6ivDHccib/gWSN8SU1ZAS/ZnLh6cI1dzFcuIYQ3rhHNtRI04auACdyb7oP/ovNhMGKqPKjro7RWzvzUlAkmhuCarx/DltU0e9r2RpWQHEnd1cmtOfwFINH0yK4kxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njNzfEvm; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40ef3f351d2so32318225e9.1;
        Mon, 05 Feb 2024 08:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707151754; x=1707756554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=60K7HYoyD/okN2s+2wGpw5kK4uYop3FwQq/xBHnBh9I=;
        b=njNzfEvmoLHoNplsGuSjfwBYGhKPlBhdkhYI6eRxGbTB/JMBAViSZazu7pJivPC1YY
         5F0a7Q6WVVudoRGEB0ltnVYG5AxoOUBfT8CCZ2yTXmJ+o58mpZA6A81Evf0rqAL3FQhj
         gkb7J34HvzeM3cFZ9DsabIaBgh/4byLtkaHcB0ByCNSlz7R/6tLf99PRChszE8l3w227
         Kdtyskrd0dvrD47yiTHBCbncbfEUgzUxHW9S2Jh5Q24MIjy7yP36D5gXXKvWqxE4BTk0
         hJW7hz9uhP2NznL9iquav6Dc8kZYMxaaq6JRKYxi6TVBAgzohp5SFcJhfIfHyJI8UCny
         iPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707151754; x=1707756554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60K7HYoyD/okN2s+2wGpw5kK4uYop3FwQq/xBHnBh9I=;
        b=w7YVFIq64kFIwRaYM+FJCqbop4bSFMo/BY/lk7FjPXUz8TdinXe/IyH5nGYuPHGrt2
         AOZzveHRhp9yPvkNKdyaie8WZ292BpZfZaNqKULaAgTeB31kge3ih8EVo4Xh/MmWVraZ
         kGGGhI9p7NeHBnB/TcWeXU5Rb19kFBfk3QxIpZP7uIahkcRjXn5+1VQVX0HYGh80ya4X
         k7JLTcIXtivJ+sGWGL8NiIwZYfhktCDCp88CZADUvszB1vVNE5pSq0SueN2JzcJEuRNp
         ZDw0zD5nESRU3aLRgRBbeA0r9JkW9MjM/lNfddqcHQ6OZcUOdKSC2pFIntdaeP5HSSGr
         wspQ==
X-Gm-Message-State: AOJu0YxrnHe13fVtpoZJKb5nPcE5K8gjriMZtUBmbFdgqS0QBbcIrcfW
	zD1jjhAK/8XCgVKIGJ1IzDihne0TL/vDP4wgZrUuaUnnDEMcET5f
X-Google-Smtp-Source: AGHT+IGKE/SEPEwmoF/vNiHMxf9+pidXmvr8rjb/gm1p8KvsZYrl8Wmu2XvQuXiRv5Q0Jk5xvIqUNQ==
X-Received: by 2002:a05:6000:4023:b0:33b:39cb:a83c with SMTP id cp35-20020a056000402300b0033b39cba83cmr3461914wrb.13.1707151754191;
        Mon, 05 Feb 2024 08:49:14 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWV+k4V5nnGJpOX/+Cm5V49MEkEns0GMUpTAJOm2Xytj2NZmqyAwSCxUpeXvUd9IE+wmHlCNv3USbAIfUFDTs4nkQbPR4UayHjH1xbT+2M1e+a78QmHEjjhy59BF6FisTK7z7uLWL2WGl2TSAvw2NF/IhmrIqZ+BD00WqxlV2ratZc0h8RC+S0x3ijR0wae8aSj9Vx/CIaDfrPDC2tbJlKcOQoFMjGbivbVKdswOubn+t0GNJrRzuEl70FwZSMvkiNY8kHtxgOgFC5CQx7G9iL2tsQOMH0o1RwHzm4YMnx0Gpep/cNtcCDLdE5qrkWUa2MqyDRDzlWTrrxbl5ICRtQHOcjkivntzjesbPAdKO8agyS6qFyk/9iFEdor4Crx2LX8+1kHk2QG4Y58wqX/ucoOJuZcErkm4CQMA/Pe7rYrw7Cj23JMToQGjCga3G7/+OdvJFJq2+mcgwo/U8Ra467fS1DSdfw9EqjaAuT94ka/jbbwfgHCcKqLnh2K5OBdrKFjMxtsXAmcY7Ko9FZEJpDQDnqYjjCx6/qUHmT8DKx/QCBnu2ABNqqxZep0v8QQGLQ2QpD+QvnoY7ZjccWTO+okaczhc06Ltt3iYy+Ycp9FgH2mjLlHBMpTdGOLBHA5z4X3Mehd2omvpncp8CQ8GIahlx5wpuMnkgwtJtkDRLNl7vDGGKCesA==
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id k2-20020a05600c1c8200b0040fafd84095sm9140567wms.41.2024.02.05.08.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 08:49:13 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Robert Marko <robert.marko@sartura.hr>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [net-next PATCH v6 09/10] net: phy: qcom: generalize some qca808x LED functions
Date: Mon,  5 Feb 2024 17:48:41 +0100
Message-ID: <20240205164851.1351-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205164851.1351-1-ansuelsmth@gmail.com>
References: <20240205164851.1351-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Generalize some qca808x LED functions in preparation for qca807x LED
support.

The LED implementation of qca808x and qca807x is the same but qca807x
supports also Fiber port and have different hw control bits for Fiber
port. To limit code duplication introduce micro functions that takes reg
instead of LED index to tweak all the supported LED modes.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/qcom/qca808x.c      | 38 +++-----------------
 drivers/net/phy/qcom/qcom-phy-lib.c | 54 +++++++++++++++++++++++++++++
 drivers/net/phy/qcom/qcom.h         |  7 ++++
 3 files changed, 65 insertions(+), 34 deletions(-)

diff --git a/drivers/net/phy/qcom/qca808x.c b/drivers/net/phy/qcom/qca808x.c
index b6ff2676d921..325e22ce8972 100644
--- a/drivers/net/phy/qcom/qca808x.c
+++ b/drivers/net/phy/qcom/qca808x.c
@@ -427,9 +427,7 @@ static int qca808x_led_hw_control_enable(struct phy_device *phydev, u8 index)
 		return -EINVAL;
 
 	reg = QCA808X_MMD7_LED_FORCE_CTRL(index);
-
-	return phy_clear_bits_mmd(phydev, MDIO_MMD_AN, reg,
-				  QCA808X_LED_FORCE_EN);
+	return qca808x_led_reg_hw_control_enable(phydev, reg);
 }
 
 static int qca808x_led_hw_is_supported(struct phy_device *phydev, u8 index,
@@ -470,16 +468,12 @@ static int qca808x_led_hw_control_set(struct phy_device *phydev, u8 index,
 static bool qca808x_led_hw_control_status(struct phy_device *phydev, u8 index)
 {
 	u16 reg;
-	int val;
 
 	if (index > 2)
 		return false;
 
 	reg = QCA808X_MMD7_LED_FORCE_CTRL(index);
-
-	val = phy_read_mmd(phydev, MDIO_MMD_AN, reg);
-
-	return !(val & QCA808X_LED_FORCE_EN);
+	return qca808x_led_reg_hw_control_status(phydev, reg);
 }
 
 static int qca808x_led_hw_control_get(struct phy_device *phydev, u8 index,
@@ -547,44 +541,20 @@ static int qca808x_led_brightness_set(struct phy_device *phydev,
 	}
 
 	reg = QCA808X_MMD7_LED_FORCE_CTRL(index);
-
-	return phy_modify_mmd(phydev, MDIO_MMD_AN, reg,
-			      QCA808X_LED_FORCE_EN | QCA808X_LED_FORCE_MODE_MASK,
-			      QCA808X_LED_FORCE_EN | value ? QCA808X_LED_FORCE_ON :
-							     QCA808X_LED_FORCE_OFF);
+	return qca808x_led_reg_brightness_set(phydev, reg, value);
 }
 
 static int qca808x_led_blink_set(struct phy_device *phydev, u8 index,
 				 unsigned long *delay_on,
 				 unsigned long *delay_off)
 {
-	int ret;
 	u16 reg;
 
 	if (index > 2)
 		return -EINVAL;
 
 	reg = QCA808X_MMD7_LED_FORCE_CTRL(index);
-
-	/* Set blink to 50% off, 50% on at 4Hz by default */
-	ret = phy_modify_mmd(phydev, MDIO_MMD_AN, QCA808X_MMD7_LED_GLOBAL,
-			     QCA808X_LED_BLINK_FREQ_MASK | QCA808X_LED_BLINK_DUTY_MASK,
-			     QCA808X_LED_BLINK_FREQ_4HZ | QCA808X_LED_BLINK_DUTY_50_50);
-	if (ret)
-		return ret;
-
-	/* We use BLINK_1 for normal blinking */
-	ret = phy_modify_mmd(phydev, MDIO_MMD_AN, reg,
-			     QCA808X_LED_FORCE_EN | QCA808X_LED_FORCE_MODE_MASK,
-			     QCA808X_LED_FORCE_EN | QCA808X_LED_FORCE_BLINK_1);
-	if (ret)
-		return ret;
-
-	/* We set blink to 4Hz, aka 250ms */
-	*delay_on = 250 / 2;
-	*delay_off = 250 / 2;
-
-	return 0;
+	return qca808x_led_reg_blink_set(phydev, reg, delay_on, delay_off);
 }
 
 static int qca808x_led_polarity_set(struct phy_device *phydev, int index,
diff --git a/drivers/net/phy/qcom/qcom-phy-lib.c b/drivers/net/phy/qcom/qcom-phy-lib.c
index 786bfc39912c..d28815ef56bb 100644
--- a/drivers/net/phy/qcom/qcom-phy-lib.c
+++ b/drivers/net/phy/qcom/qcom-phy-lib.c
@@ -620,3 +620,57 @@ int qca808x_cable_test_get_status(struct phy_device *phydev, bool *finished)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(qca808x_cable_test_get_status);
+
+int qca808x_led_reg_hw_control_enable(struct phy_device *phydev, u16 reg)
+{
+	return phy_clear_bits_mmd(phydev, MDIO_MMD_AN, reg,
+				  QCA808X_LED_FORCE_EN);
+}
+EXPORT_SYMBOL_GPL(qca808x_led_reg_hw_control_enable);
+
+bool qca808x_led_reg_hw_control_status(struct phy_device *phydev, u16 reg)
+{
+	int val;
+
+	val = phy_read_mmd(phydev, MDIO_MMD_AN, reg);
+	return !(val & QCA808X_LED_FORCE_EN);
+}
+EXPORT_SYMBOL_GPL(qca808x_led_reg_hw_control_status);
+
+int qca808x_led_reg_brightness_set(struct phy_device *phydev,
+				   u16 reg, enum led_brightness value)
+{
+	return phy_modify_mmd(phydev, MDIO_MMD_AN, reg,
+			      QCA808X_LED_FORCE_EN | QCA808X_LED_FORCE_MODE_MASK,
+			      QCA808X_LED_FORCE_EN | (value ? QCA808X_LED_FORCE_ON :
+							      QCA808X_LED_FORCE_OFF));
+}
+EXPORT_SYMBOL_GPL(qca808x_led_reg_brightness_set);
+
+int qca808x_led_reg_blink_set(struct phy_device *phydev, u16 reg,
+			      unsigned long *delay_on,
+			      unsigned long *delay_off)
+{
+	int ret;
+
+	/* Set blink to 50% off, 50% on at 4Hz by default */
+	ret = phy_modify_mmd(phydev, MDIO_MMD_AN, QCA808X_MMD7_LED_GLOBAL,
+			     QCA808X_LED_BLINK_FREQ_MASK | QCA808X_LED_BLINK_DUTY_MASK,
+			     QCA808X_LED_BLINK_FREQ_4HZ | QCA808X_LED_BLINK_DUTY_50_50);
+	if (ret)
+		return ret;
+
+	/* We use BLINK_1 for normal blinking */
+	ret = phy_modify_mmd(phydev, MDIO_MMD_AN, reg,
+			     QCA808X_LED_FORCE_EN | QCA808X_LED_FORCE_MODE_MASK,
+			     QCA808X_LED_FORCE_EN | QCA808X_LED_FORCE_BLINK_1);
+	if (ret)
+		return ret;
+
+	/* We set blink to 4Hz, aka 250ms */
+	*delay_on = 250 / 2;
+	*delay_off = 250 / 2;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qca808x_led_reg_blink_set);
diff --git a/drivers/net/phy/qcom/qcom.h b/drivers/net/phy/qcom/qcom.h
index 9e24997c355f..4bb541728846 100644
--- a/drivers/net/phy/qcom/qcom.h
+++ b/drivers/net/phy/qcom/qcom.h
@@ -234,3 +234,10 @@ int at803x_cdt_start(struct phy_device *phydev, u32 cdt_start);
 int at803x_cdt_wait_for_completion(struct phy_device *phydev,
 				   u32 cdt_en);
 int qca808x_cable_test_get_status(struct phy_device *phydev, bool *finished);
+int qca808x_led_reg_hw_control_enable(struct phy_device *phydev, u16 reg);
+bool qca808x_led_reg_hw_control_status(struct phy_device *phydev, u16 reg);
+int qca808x_led_reg_brightness_set(struct phy_device *phydev,
+				   u16 reg, enum led_brightness value);
+int qca808x_led_reg_blink_set(struct phy_device *phydev, u16 reg,
+			      unsigned long *delay_on,
+			      unsigned long *delay_off);
-- 
2.43.0


