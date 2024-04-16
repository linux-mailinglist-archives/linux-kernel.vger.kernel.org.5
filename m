Return-Path: <linux-kernel+bounces-147207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3558A7101
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A20022856A8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1641E131BB4;
	Tue, 16 Apr 2024 16:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESdD627B"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD3A131746;
	Tue, 16 Apr 2024 16:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713283979; cv=none; b=pJD8BNaMufP+nu73yuQSBUbaZ5md2x7HsVvFu6kbej+ltJJfqM+PazJIA9txMA4or2TixiOoKWeTfKgig0uVrArluUPY55BkzFiDecxxYd9r6OmdsDs+vmnoi/05Vik2jeNwC9pKqb7shm+VqPzkQMJ6F8CDmclxndkN/tsodeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713283979; c=relaxed/simple;
	bh=iN1S4d4yj5HPZX9bvcI3GrCiM7vt6EdgyVF6SuvXuIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cs0CdpMF5GPsrPf0bCapYqgd2LaEL28r8LTa5Rh8eQ7/DbAAJPv7ZnJ/VssaRVT87C5QEI52uCXOmKVVFTSoQIIxY3thKvCDJO1ATNmLEK/gdEaiSsKX9h0AxOhuhlut4CMmodlB/ntV6ay/o/H6zNeBWDvRSXej4xFuCuq5R+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ESdD627B; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d87660d5c9so46194111fa.2;
        Tue, 16 Apr 2024 09:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713283976; x=1713888776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUiCR1svhxxRL5lsxc2pQcGa6DHnWjaA4pAZ506382o=;
        b=ESdD627BIA8iBfXnX05VgxN0D6lLJSpqGwAm+jbfgivzyZKiGqgxj7tW1YofeRoVpy
         IwW5DxFTc/GVpKUf7nHN6KYpflG73zpepvOdn1Aq5krSTcrbvZcZKOfKBj4tL/xuVFKy
         8vFaajy5Z4ZndymLMPJGJQJUfbKFl3x/lzCUE4bTuR+qkMXkYjmoYWFWLFifNP5xaf3Z
         7to/pLgFb5T8TEuG29R/0/N/odB+Sl106t5mLJ+UMYCq8DOF7AfRQD1zECX3tdVRsBeU
         Xarddcs4jbPB/iYCZfJbU34B7Tw0U72xyYfNzoq2ppvzfiALdVOE29CazrOUOch1b4pb
         Uu7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713283976; x=1713888776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aUiCR1svhxxRL5lsxc2pQcGa6DHnWjaA4pAZ506382o=;
        b=LQlkSdcyR23runyHI14W3gtv1NX643k/qipo6W0Ofhc4yuZfxj+PIlzVKyATsRZshZ
         xIrq7ZnXGzuZaKtipUOupThxmUDlHVOO93mTKEbxxi0sARQ3ru3esKgVN/Yj90/jPLus
         EArLwKTP2k0gRRUZ90N+xv+5RlkRwjqvPPyUwGmlENpocGwek2XwLs1WoopTBYLIIhvb
         6s+LeGejtC7JPIIFXwC0NWKLNyzwlZzTNJ/Uyzi65FGyFmxAcAdbPxdeewCcyOcw9F+8
         mxE6iVzyO/3y8i1wXtKJXRMeQrtNMEk2WtvpUdqfkRmol2iwuY8hsTg21f37PIzR5OHy
         XF5A==
X-Forwarded-Encrypted: i=1; AJvYcCV/fpq4s2vjnI4gxaL2UUKCSZI858o/xJusDY3/+rE6FwRj6UhFz5TggahBZyQOWQO5Qp10Om5b8dxEVCvVUjjsCFHuLAyCu5v5SxiBuQwekNi27sXj0AHaYMarwR64AUITz1aGlhyhpo1SSZa4DH5qj42N3n7lgMAfmElRbu8ieM4ASKU=
X-Gm-Message-State: AOJu0Yw1eK+gl6o1kPWQijHxupYRQ668LpXfw0a1wQL//BcWcbPMIP/W
	M+FU0uRipzidvHd8TDfPlHYUlghZsK8q8FaCeB6UArHQDusPJM4=
X-Google-Smtp-Source: AGHT+IGL0AAzW6gi5FMaOnf2+t1zcD1sVS1LK3XSrI0v4R9xqr0sQMPNnWO6PLsnDB2l3FxArGL2wA==
X-Received: by 2002:a2e:999a:0:b0:2d8:781c:7ba1 with SMTP id w26-20020a2e999a000000b002d8781c7ba1mr9244034lji.7.1713283975689;
        Tue, 16 Apr 2024 09:12:55 -0700 (PDT)
Received: from U4.lan ([91.66.160.190])
        by smtp.gmail.com with ESMTPSA id t7-20020adfe447000000b00343eac2acc4sm15350743wrm.111.2024.04.16.09.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 09:12:55 -0700 (PDT)
From: Alex Bee <knaerzche@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Chris Zhong <zyw@rock-chips.com>,
	Zhang Qing <zhangqing@rock-chips.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v4 3/5] pinctrl: rk805: Add rk816 pinctrl support
Date: Tue, 16 Apr 2024 18:12:35 +0200
Message-ID: <20240416161237.2500037-4-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240416161237.2500037-1-knaerzche@gmail.com>
References: <20240416161237.2500037-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds support for RK816 to the exising rk805 pinctrl driver

It has a single pin which can be configured as input from a thermistor (for
instance in an attached battery) or as a gpio.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes since v1:
  - rename pin-function names according to the updated binding
  - added missing fun_reg for rk816_gpio_cfgs

changes since v2:
  - aligned pin-function names with binding (dropped "pin_fun"-prefix)

 drivers/pinctrl/pinctrl-rk805.c | 69 +++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-rk805.c b/drivers/pinctrl/pinctrl-rk805.c
index 56d916f2cee6..c42f1bf93404 100644
--- a/drivers/pinctrl/pinctrl-rk805.c
+++ b/drivers/pinctrl/pinctrl-rk805.c
@@ -93,6 +93,11 @@ enum rk806_pinmux_option {
 	RK806_PINMUX_FUN5,
 };
 
+enum rk816_pinmux_option {
+	RK816_PINMUX_THERMISTOR,
+	RK816_PINMUX_GPIO,
+};
+
 enum {
 	RK805_GPIO0,
 	RK805_GPIO1,
@@ -104,6 +109,10 @@ enum {
 	RK806_GPIO_DVS3
 };
 
+enum {
+	RK816_GPIO0,
+};
+
 static const char *const rk805_gpio_groups[] = {
 	"gpio0",
 	"gpio1",
@@ -115,6 +124,10 @@ static const char *const rk806_gpio_groups[] = {
 	"gpio_pwrctrl3",
 };
 
+static const char *const rk816_gpio_groups[] = {
+	"gpio0",
+};
+
 /* RK805: 2 output only GPIOs */
 static const struct pinctrl_pin_desc rk805_pins_desc[] = {
 	PINCTRL_PIN(RK805_GPIO0, "gpio0"),
@@ -128,6 +141,11 @@ static const struct pinctrl_pin_desc rk806_pins_desc[] = {
 	PINCTRL_PIN(RK806_GPIO_DVS3, "gpio_pwrctrl3"),
 };
 
+/* RK816 */
+static const struct pinctrl_pin_desc rk816_pins_desc[] = {
+	PINCTRL_PIN(RK816_GPIO0, "gpio0"),
+};
+
 static const struct rk805_pin_function rk805_pin_functions[] = {
 	{
 		.name = "gpio",
@@ -176,6 +194,21 @@ static const struct rk805_pin_function rk806_pin_functions[] = {
 	},
 };
 
+static const struct rk805_pin_function rk816_pin_functions[] = {
+	{
+		.name = "gpio",
+		.groups = rk816_gpio_groups,
+		.ngroups = ARRAY_SIZE(rk816_gpio_groups),
+		.mux_option = RK816_PINMUX_GPIO,
+	},
+	{
+		.name = "thermistor",
+		.groups = rk816_gpio_groups,
+		.ngroups = ARRAY_SIZE(rk816_gpio_groups),
+		.mux_option = RK816_PINMUX_THERMISTOR,
+	},
+};
+
 static const struct rk805_pin_group rk805_pin_groups[] = {
 	{
 		.name = "gpio0",
@@ -207,6 +240,14 @@ static const struct rk805_pin_group rk806_pin_groups[] = {
 	}
 };
 
+static const struct rk805_pin_group rk816_pin_groups[] = {
+	{
+		.name = "gpio0",
+		.pins = { RK816_GPIO0 },
+		.npins = 1,
+	},
+};
+
 #define RK805_GPIO0_VAL_MSK	BIT(0)
 #define RK805_GPIO1_VAL_MSK	BIT(1)
 
@@ -255,6 +296,20 @@ static struct rk805_pin_config rk806_gpio_cfgs[] = {
 	}
 };
 
+#define RK816_FUN_MASK		BIT(2)
+#define RK816_VAL_MASK		BIT(3)
+#define RK816_DIR_MASK		BIT(4)
+
+static struct rk805_pin_config rk816_gpio_cfgs[] = {
+	{
+		.fun_reg = RK818_IO_POL_REG,
+		.fun_msk = RK816_FUN_MASK,
+		.reg = RK818_IO_POL_REG,
+		.val_msk = RK816_VAL_MASK,
+		.dir_msk = RK816_DIR_MASK,
+	},
+};
+
 /* generic gpio chip */
 static int rk805_gpio_get(struct gpio_chip *chip, unsigned int offset)
 {
@@ -439,6 +494,8 @@ static int rk805_pinctrl_gpio_request_enable(struct pinctrl_dev *pctldev,
 		return _rk805_pinctrl_set_mux(pctldev, offset, RK805_PINMUX_GPIO);
 	case RK806_ID:
 		return _rk805_pinctrl_set_mux(pctldev, offset, RK806_PINMUX_FUN5);
+	case RK816_ID:
+		return _rk805_pinctrl_set_mux(pctldev, offset, RK816_PINMUX_GPIO);
 	}
 
 	return -ENOTSUPP;
@@ -588,6 +645,18 @@ static int rk805_pinctrl_probe(struct platform_device *pdev)
 		pci->pin_cfg = rk806_gpio_cfgs;
 		pci->gpio_chip.ngpio = ARRAY_SIZE(rk806_gpio_cfgs);
 		break;
+	case RK816_ID:
+		pci->pins = rk816_pins_desc;
+		pci->num_pins = ARRAY_SIZE(rk816_pins_desc);
+		pci->functions = rk816_pin_functions;
+		pci->num_functions = ARRAY_SIZE(rk816_pin_functions);
+		pci->groups = rk816_pin_groups;
+		pci->num_pin_groups = ARRAY_SIZE(rk816_pin_groups);
+		pci->pinctrl_desc.pins = rk816_pins_desc;
+		pci->pinctrl_desc.npins = ARRAY_SIZE(rk816_pins_desc);
+		pci->pin_cfg = rk816_gpio_cfgs;
+		pci->gpio_chip.ngpio = ARRAY_SIZE(rk816_gpio_cfgs);
+		break;
 	default:
 		dev_err(&pdev->dev, "unsupported RK805 ID %lu\n",
 			pci->rk808->variant);
-- 
2.43.2


