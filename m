Return-Path: <linux-kernel+bounces-110160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB51885AF5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEFE31C217C1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4652F8626C;
	Thu, 21 Mar 2024 14:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKeQjSbp"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC1A8624D;
	Thu, 21 Mar 2024 14:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711031986; cv=none; b=AsFY4D9Uly3TTDCGJKoBP6RUgpw/6Fc2CV9nUQLGJppaZOC55ZdQOrW05UVNt6mjzdgXKDGWtz7GYLbxdA6qcIOf4oPafGP8zQzjuffIXLKE4X/33wE29HXCiSRVDKl1JygsjpvU3HAooLvq++4zZWDd7aYgPhVvH/D3yDbZdmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711031986; c=relaxed/simple;
	bh=tJ9hbQiysGyoAPEFuwDReWE+Dwbl9fkBDGOp/9MxoTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rTGH6J9KT9YOuTc3Pl4/FDGT5fvi5LZnCKeNU582xMx4i93d5Vs3TD4tppM729OJQtU3jrvwtyTsQYXF8r3YZwQKnKbnhteKFKU3Zpzy8LPYl5pxcATELeElsOzwUseae13VT56fsqpgjfxlUIslv2GW0rqJKhdu1isJoTr5hZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YKeQjSbp; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a4675aaa2e8so145886266b.0;
        Thu, 21 Mar 2024 07:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711031983; x=1711636783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twALFnMM+Yr/AtveAMdUdW9D1Ib6MBFOTxAn/sC1EOM=;
        b=YKeQjSbpOMZlreBG9l2p9JGZx7HKsdNL+I4K1b6sgp9ZJXfvchoqcw0ghqEViYWKsZ
         R148gHGorZVL2Oq3XWiwChqDC4cbmGHYOMTJAF525V7lf2VDH7wyeTMg21lLFvw4rOPW
         An4hGH5os0R4Ucm4xAE1Ne7BSh7KxGE5eAaIjhiNftG2CdKBZaJqW3BdADmr3qozO1pL
         LPiQ9K+2SozQ3XunJRxtQThm89x2pD5pQqYmZ6D0FRWb/isV+DQhXfqUCllYnJq7oURD
         1Lfy269imRpDWpZk0qQRFAymPmtP1eFS8XCP35MoyuLU/3zfVW39PEhCboEOSpIfBHSr
         S9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711031983; x=1711636783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=twALFnMM+Yr/AtveAMdUdW9D1Ib6MBFOTxAn/sC1EOM=;
        b=Vv4/PsdayYiTQdyDkPrnQ1WZOBYODk/X1K9n5w7EQE66n+l7YuW301fkat+Hx3x8ec
         7OcyjzL+NniS3g8c4cKFRMnqaNyxslSqmACXBtMhHTZs0asu/J6MO+M0lXoFG2Eap6Af
         NdENI5+9nMsgbV9yeg4gRlG0CGwS37/ILjX6LY/D/iynNVlNqBls4BJ7RulHaNKZWf1s
         mqYJcm+cdKIYe79bqG5Yjjs4F2EmrIq60suY8PXxCP7Ocm8OoMI9ypNWxZZxonNvWCM2
         3BM8X4JxTUWJ3SsBrlHHOd8C2eJXbidpwcLtqf/LPlyn0vQcoFJ0tHxmoFS/4g7Vjwst
         zgUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcjyf64ZOoUrGYhIZvgP3hvMcfKPkL2PFUzHBQfkXQP0xH6dXnOe7DS4PbLNzcxw64mysaNZkhc2svQAscFBLADZS+4z/NAVE9eZ4JTUaRaMIShCI+gfU4QKeOsASZNcQjp7/qVyp/JdulPi5JK2O2tN71/UHt6YMer8U2QY1BoPRRGEw=
X-Gm-Message-State: AOJu0YwoMjJ8Sk9JhTRqECOAJ6nKrS3Vsrqkj6qRwcCiiTc9Um3WkpmA
	ktznULucJati/jpbQco9XjhAbs9EwIo3iCqWR4vG2CV+o3z1u1w=
X-Google-Smtp-Source: AGHT+IHHA5j+8Uv6vMC1shrAnIAOqjVLHuTxodIzbNrCfwgHuprghUuMvhHuxk7nkEZPu7NmVb//+A==
X-Received: by 2002:a17:906:ca54:b0:a46:f564:ff80 with SMTP id jx20-20020a170906ca5400b00a46f564ff80mr1568277ejb.68.1711031982941;
        Thu, 21 Mar 2024 07:39:42 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:b39:dab4:8e20:e918])
        by smtp.gmail.com with ESMTPSA id e3-20020a170906248300b00a46abaeeb1csm6147923ejb.104.2024.03.21.07.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 07:39:42 -0700 (PDT)
From: Alex Bee <knaerzche@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: Chris Zhong <zyw@rock-chips.com>,
	Zhang Qing <zhangqing@rock-chips.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH 3/5] pinctrl: rk805: Add rk816 pinctrl support
Date: Thu, 21 Mar 2024 15:39:11 +0100
Message-ID: <20240321143911.90210-6-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240321143911.90210-2-knaerzche@gmail.com>
References: <20240321143911.90210-2-knaerzche@gmail.com>
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
 drivers/pinctrl/pinctrl-rk805.c | 68 +++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-rk805.c b/drivers/pinctrl/pinctrl-rk805.c
index 56d916f2cee6..cf0305477e7a 100644
--- a/drivers/pinctrl/pinctrl-rk805.c
+++ b/drivers/pinctrl/pinctrl-rk805.c
@@ -93,6 +93,11 @@ enum rk806_pinmux_option {
 	RK806_PINMUX_FUN5,
 };
 
+enum rk816_pinmux_option {
+	RK816_PINMUX_GPIO,
+	RK816_PINMUX_TS,
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
+		.name = "ts",
+		.groups = rk816_gpio_groups,
+		.ngroups = ARRAY_SIZE(rk816_gpio_groups),
+		.mux_option = RK816_PINMUX_TS,
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
 
@@ -255,6 +296,19 @@ static struct rk805_pin_config rk806_gpio_cfgs[] = {
 	}
 };
 
+#define RK816_FUN_MASK		BIT(2)
+#define RK816_VAL_MASK		BIT(3)
+#define RK816_DIR_MASK		BIT(4)
+
+static struct rk805_pin_config rk816_gpio_cfgs[] = {
+	{
+		.reg = RK818_IO_POL_REG,
+		.val_msk = RK816_VAL_MASK,
+		.fun_msk = RK816_FUN_MASK,
+		.dir_msk = RK816_DIR_MASK,
+	},
+};
+
 /* generic gpio chip */
 static int rk805_gpio_get(struct gpio_chip *chip, unsigned int offset)
 {
@@ -439,6 +493,8 @@ static int rk805_pinctrl_gpio_request_enable(struct pinctrl_dev *pctldev,
 		return _rk805_pinctrl_set_mux(pctldev, offset, RK805_PINMUX_GPIO);
 	case RK806_ID:
 		return _rk805_pinctrl_set_mux(pctldev, offset, RK806_PINMUX_FUN5);
+	case RK816_ID:
+		return _rk805_pinctrl_set_mux(pctldev, offset, RK816_PINMUX_GPIO);
 	}
 
 	return -ENOTSUPP;
@@ -588,6 +644,18 @@ static int rk805_pinctrl_probe(struct platform_device *pdev)
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


