Return-Path: <linux-kernel+bounces-92480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9865E872102
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BA902831BA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA6286AD4;
	Tue,  5 Mar 2024 13:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXzJyOlS"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26CA86ACD;
	Tue,  5 Mar 2024 13:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709647150; cv=none; b=ZzwMkbBwqcv/tQ+LUZ7ThAd3jzKbyBhgsp/FcW7eUZiujPzO6bes0tRy2NE/dRY2xMES6xCbq4P5oqA6Wg2Pyyrs4IlN+FW3Boeo4lCv1uFGXip5COBruJcjmh66gE/ebd947dSar51J/KT1pivdTfA7asDoIgVA879L7GGApco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709647150; c=relaxed/simple;
	bh=wET7lxWL5+a6cOW+e8Hm2QP+6ArrR8fvDaiOmdw834Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uHMSbQVMREOFcP1e7JbPNU/s7KygR20vo/d4hRxqC5mY/170ZffiKUkKLTgVUHH26TuRhVOjWISNbAY06rKdhivAfrAaj2lDVUP3w127e/jzdNcG6+5Q3zgfpYzl5m4XjsqXMpQij11B65lLCHxEVUfU26jwISTtIge8TLJpZXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CXzJyOlS; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a45606c8444so249609066b.3;
        Tue, 05 Mar 2024 05:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709647147; x=1710251947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ezrez5zBjAnZtqpMJIhkt3FNVFaisJDMP2rkEI9ICVk=;
        b=CXzJyOlSDrfQH7q0ZinhZN8W0Ccagp0O/fEPMQv2hnoxcrB0Y6NesPRTS0Samq/uDp
         +3Ml6f98obkiAg6szccsLxw3/MpZwFsyUMgyhhm8CKu2uqORbMelB4wKebObQyMFigaK
         +Bxn0pirB5pSRxDeNZxVmeZxqNxfF+KWmTekxIpGGAcWF4PPoDFAdRKDPVWrP6Y85+8G
         S+/wOtXxicHJrJzkntpuJh1mcYbqlu7R98ceK+628IMz86yr7Emgu9MydaXHO2z+KSsP
         4a1HiqnIhB8iCfedAoy+ScY3ZYXxVK2KwZ0w1npEeJMiM5yTtOCYIInudCaN6Yf1CmSp
         fc8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709647147; x=1710251947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ezrez5zBjAnZtqpMJIhkt3FNVFaisJDMP2rkEI9ICVk=;
        b=KpZ27rwAdC18xldxb5ywsMQGzjJNXCnaBG+J6EOS6y2kGJJG6v7myrZURxInQmGRHf
         cgvZPDHGW1sxvzjMglpOD/5ijnFuntGkt6n4VvQp5so+1Jqy6C+VgNFRaYrLg2ZMMiNs
         4ntfNfK/9/yIKPfXRbs0YMI46MmSTok/Yhw/SmQKMmz/yMeJ7wUFShiw0OdmInxTE8ZP
         H47BsMeV9Hu95mcUJDtAAT6R3k1gls1WNz+Sdmfa5Tu7MfcpnXJWLhvEm+giIcQFyY2i
         yaNlL2u0/VXFa7DCOSWtiTVYQ4LKpKLBfH69fMMnXj5iCVW9gZkJWQhx67WC9vBdabgd
         t9QQ==
X-Forwarded-Encrypted: i=1; AJvYcCWv5P3AYERmbBI9ZJLKSP3qIrSDv79v7tBpBMSfJzApELgiMYfofi+ZwMSZAhrTJQyBl0GLQopoLE1RQrK/okrHnXRG2goo7ddNT42P7i5SAj4mRzlqNGnD6nQJX7oFZweEHW9ii3jPuKlCqMYeReUvEArSYPs3cO0+jSlGRPyqyAkThA==
X-Gm-Message-State: AOJu0YwTyAPcRScv9c1soNT+f8DsiXk90vmEedzJj3bOrNx1mbKQuPHw
	gYe9Fty8WO3ypJMvFhBFSRKKzJPmv3hnI2E+7BtXiEjFWsP8UVxL
X-Google-Smtp-Source: AGHT+IHrhZPJko2SywuNbpTAwYF28eOpJ53IJ0IeI8AGRN6zAa5BkcIVAS6wVzoso2hAPNesVP+Caw==
X-Received: by 2002:a17:906:e2cc:b0:a44:dadc:654e with SMTP id gr12-20020a170906e2cc00b00a44dadc654emr6470785ejb.39.1709647147061;
        Tue, 05 Mar 2024 05:59:07 -0800 (PST)
Received: from fedora.. (d-zg1-234.globalnet.hr. [213.149.36.248])
        by smtp.googlemail.com with ESMTPSA id z20-20020a170906271400b00a441cb52bfcsm6093783ejc.165.2024.03.05.05.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 05:59:06 -0800 (PST)
From: Robert Marko <robimarko@gmail.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	andersson@kernel.org,
	konrad.dybcio@linaro.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ansuelsmth@gmail.com,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Robert Marko <robimarko@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH net v2] net: phy: qca807x: fix compilation when CONFIG_GPIOLIB is not set
Date: Tue,  5 Mar 2024 14:58:18 +0100
Message-ID: <20240305135903.3752568-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kernel bot has discovered that if CONFIG_GPIOLIB is not set compilation
will fail.

Upon investigation the issue is that qca807x_gpio() is guarded by a
preprocessor check but then it is called under
if (IS_ENABLED(CONFIG_GPIOLIB)) in the probe call so the compiler will
error out since qca807x_gpio() has not been declared if CONFIG_GPIOLIB has
not been set.

Fixes: d1cb613efbd3 ("net: phy: qcom: add support for QCA807x PHY Family")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202403031332.IGAbZzwq-lkp@intel.com/
Signed-off-by: Robert Marko <robimarko@gmail.com>
---
Changes in v2:
* Reduce the code indent level

 drivers/net/phy/qcom/qca807x.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/net/phy/qcom/qca807x.c b/drivers/net/phy/qcom/qca807x.c
index 780c28e2e4aa..672c6929119a 100644
--- a/drivers/net/phy/qcom/qca807x.c
+++ b/drivers/net/phy/qcom/qca807x.c
@@ -732,24 +732,24 @@ static int qca807x_probe(struct phy_device *phydev)
 	priv->dac_disable_bias_current_tweak = of_property_read_bool(node,
 								     "qcom,dac-disable-bias-current-tweak");
 
-	if (IS_ENABLED(CONFIG_GPIOLIB)) {
-		/* Make sure we don't have mixed leds node and gpio-controller
-		 * to prevent registering leds and having gpio-controller usage
-		 * conflicting with them.
-		 */
-		if (of_find_property(node, "leds", NULL) &&
-		    of_find_property(node, "gpio-controller", NULL)) {
-			phydev_err(phydev, "Invalid property detected. LEDs and gpio-controller are mutually exclusive.");
-			return -EINVAL;
-		}
+#if IS_ENABLED(CONFIG_GPIOLIB)
+	/* Make sure we don't have mixed leds node and gpio-controller
+	 * to prevent registering leds and having gpio-controller usage
+	 * conflicting with them.
+	 */
+	if (of_find_property(node, "leds", NULL) &&
+	    of_find_property(node, "gpio-controller", NULL)) {
+		phydev_err(phydev, "Invalid property detected. LEDs and gpio-controller are mutually exclusive.");
+		return -EINVAL;
+	}
 
-		/* Do not register a GPIO controller unless flagged for it */
-		if (of_property_read_bool(node, "gpio-controller")) {
-			ret = qca807x_gpio(phydev);
-			if (ret)
-				return ret;
-		}
+	/* Do not register a GPIO controller unless flagged for it */
+	if (of_property_read_bool(node, "gpio-controller")) {
+		ret = qca807x_gpio(phydev);
+		if (ret)
+			return ret;
 	}
+#endif
 
 	/* Attach SFP bus on combo port*/
 	if (phy_read(phydev, QCA807X_CHIP_CONFIGURATION)) {
-- 
2.44.0


