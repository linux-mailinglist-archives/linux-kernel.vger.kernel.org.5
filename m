Return-Path: <linux-kernel+bounces-112270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 239E18877AD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 09:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ECF4B210A8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 08:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2387B1756B;
	Sat, 23 Mar 2024 08:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQ3b/Gr/"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5E1DDCA;
	Sat, 23 Mar 2024 08:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711184353; cv=none; b=tvMbqONjzQGApXQvxymo7UtEH7OH8g58P6ryxwRWygxQ/qjxZPZz7hk6rY2BSVmw5uc8ygUJBOZHUBZmWW+BXAr1Gfe5YTqzf/fg9PCJkhcQ+LqJnBRhUuYoZ98lL4xNAmwR8UC5o9R1dM7b/wSuXUGLGOTGDZX+y+8naiWEg2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711184353; c=relaxed/simple;
	bh=OeDhu3FpNFkFIf/DcWPEwUyPRwyA5CxqUgY+QAxAz4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rm4R/1KU+VHa9w/mOZbu0fFf8k424QXSjNq2uP4qeZfqn2mxlX3Jq6XOLXfayVEDxNwwLHRwQacuogVqM8T09Gy526LPRgGyqMFdEsoogJGwq7Xe/6xUx90Uic/Bwnwq8nhAFgSTVDYf9WP++DmaL5AEPYc7lAb+sgjqbD7PD6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQ3b/Gr/; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4146562a839so19596255e9.1;
        Sat, 23 Mar 2024 01:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711184350; x=1711789150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xV1VuZ10gS4qJcYFgEhCdbniTU6gffWU2OmNmdkZVDU=;
        b=QQ3b/Gr/fwz30CS+M0rk0Ro+7gAmEgA/Igv8UEHYegH0wuEfwreSHkpbwXVV7PrS+s
         zuvgdwHDBY/bLwr7FegxeEUTtTtBqWrHQ8Dq3tb6I7gxkCZPObg7rAgYgpLnwI0Oe00L
         xy0zAohWEmTDmkBS58JL4fkNFytXfoz6/cTRX2EETy9ZIqEOipHdoztrieyQ8L5tZ3/A
         9JHEpHaLxqqncCwC3m0PDzLa6PUnXn2ifVLiLlVETOfSFqNfeTLjS/QDEQgyK86r4aoP
         X7jbkRDv5zLEQNc6HUKCnNDiaERVEstMEQMG7bEYzp6C/ko2nYjAvbureOcCjAPX+HLl
         OECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711184350; x=1711789150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xV1VuZ10gS4qJcYFgEhCdbniTU6gffWU2OmNmdkZVDU=;
        b=YtSnA8IGzjYAiBRJ9H7UHdEvpw9NJETWzOkhxeNmVPkUKLXPE6DezPnVzSQ2hqszx0
         wTVu9BGYZ8WcksTz3WT9S4lerLOOrBrwB+7wvC1SqHizverlxa1Q/bJP7BplARUmS2h8
         zraDacg4zzQP+LticC+4heIjuhlo+pvLi+mIqhe4wlaCTMwDGu3jysPkRVQrMb7wkjHS
         f0qNAVFgmTeeIOX0KGa5JfFM2sOZqk5Pl7AzxenubAn7Kv+SUaTkpip8XG8KtTYSYARs
         2LHOMIkT8qFbXCkKKDEEnLFHMrrdRrI7C7dM646bNIhYZDUj2Rtes/oYN/0SC/iMtQrY
         3qUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXn4Pu/kdTqF1hGKcsteYWNySNC4Dx07j2ZYVKWmlgJuYCg/0rzp1Smcf2mZz71UMr48MaReR8S22T5Io4R1RD7USdILclWkLxsTVYG2qgRTq/4X6cKsJFHpQwlFmEqavUYL9yVXoZwqx5kQO/9kWpuDWz71BYvzvO3pShaf7VZavabzyw=
X-Gm-Message-State: AOJu0YxxhNeLAirDw5Liyq+JgLNCcPGITTKt1Z69W/e/sYYsrm5J/guA
	ZDpoQmTW+Maj0IExjw45biwFFOlDU6NfHMzbnZujiArSqHKFIw8=
X-Google-Smtp-Source: AGHT+IGSsj40L8O6zR6axVninZLB0SV4Jm46LZmvjcTSUMgL19iMEnVTgoVYDPYeZxt1XkNVU9vYMg==
X-Received: by 2002:adf:ec48:0:b0:33e:64f3:65a5 with SMTP id w8-20020adfec48000000b0033e64f365a5mr996318wrn.52.1711184349824;
        Sat, 23 Mar 2024 01:59:09 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:fbb8:7547:139d:a40f])
        by smtp.gmail.com with ESMTPSA id x16-20020a5d6b50000000b0033e93e00f68sm3965031wrw.61.2024.03.23.01.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 01:59:09 -0700 (PDT)
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
Subject: [PATCH v2 3/5] pinctrl: rk805: Add rk816 pinctrl support
Date: Sat, 23 Mar 2024 09:58:50 +0100
Message-ID: <20240323085852.116756-4-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240323085852.116756-1-knaerzche@gmail.com>
References: <20240323085852.116756-1-knaerzche@gmail.com>
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

 drivers/pinctrl/pinctrl-rk805.c | 69 +++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-rk805.c b/drivers/pinctrl/pinctrl-rk805.c
index 56d916f2cee6..4f1a6d8fcda0 100644
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
+		.name = "pin_fun_gpio",
+		.groups = rk816_gpio_groups,
+		.ngroups = ARRAY_SIZE(rk816_gpio_groups),
+		.mux_option = RK816_PINMUX_GPIO,
+	},
+	{
+		.name = "pin_fun_thermistor",
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


