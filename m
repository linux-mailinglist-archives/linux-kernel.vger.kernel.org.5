Return-Path: <linux-kernel+bounces-65520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE9D854E27
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A3DC1C20FBF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC30360268;
	Wed, 14 Feb 2024 16:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LmB7S6uF"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6399160254;
	Wed, 14 Feb 2024 16:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707927896; cv=none; b=jNcNjwBwgIV3wun7PbgwG7EIEoADbjblqr2ZDtsjrTq7ATlEFWa116/hQ6QlwHwKcBKcjjNXM6BYGvskUrJ5ImxLo3sAA2Op9Q8J8iv2kiOPH0wEkeHjpgnmXaDFTtGD6KZJg9zdLqmaHBfVE7ZL3fdfUCTloyd6xHulyT6knDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707927896; c=relaxed/simple;
	bh=ldERVwA0tqVeaQIDHTYEi71mBmSUTsvjMzu+1URPmgY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JMkvodEkmpNJBR5kBkBhrqanBfN88y7VW6DsoCrnfnDUADDFOLb1xYGikq2bemsWgNKh9A2vsrlPFcMuptESWCgt9J0+YRTLnHeJncPMOBzdVzS5lwBHYYfmcepuhwrVNV788cQNIP6BikQRKaVXRJu1N83vV24ruBMdwjII3d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LmB7S6uF; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 21F1B60018;
	Wed, 14 Feb 2024 16:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707927892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y8W2yOX1/lqz3cTT+5TwvqzWpGJkVlzJWrTABq4PG4k=;
	b=LmB7S6uF1VqHaKkR2WZnKequ04ZUZd7v3E29hBaoG+ztkKOP6mdgED6tMr+jGhvfEDrMDb
	V1BG0YfBcCz+mPopZO8DiuPsX8zMfhshWRj04C0leLIsRsD6TkhO83c1qTrwoaF2Qgqubz
	aWfUKmljXAFDGsyTjFUufi3hiurK3n7MBsa9Fjk0Nb+JlgZdA3PURHrFHNCFIfOnLdIC9u
	thvf5hGoM914YbPlkbK9v4DbTtsOOMqsPBqQ/UkW1ZtIxKHWFvedmI6TzWYuLaVR5afX++
	TKzhqfb4rBfIe4CUAsyRKb69q+FsPR/uOubv7i7sjNewmoOmkYeBy+CjOVZyfg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 14 Feb 2024 17:24:04 +0100
Subject: [PATCH 11/23] pinctrl: nomadik: follow conditional kernel coding
 conventions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240214-mbly-gpio-v1-11-f88c0ccf372b@bootlin.com>
References: <20240214-mbly-gpio-v1-0-f88c0ccf372b@bootlin.com>
In-Reply-To: <20240214-mbly-gpio-v1-0-f88c0ccf372b@bootlin.com>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mips@vger.kernel.org, Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: theo.lebrun@bootlin.com

Fix strict checkpatch warnings relative to if-else blocks and bool
expressions. Message types addressed:

   CHECK: Comparison to NULL could be written "!nmk_cfg_params[index].choice"
   CHECK: Unbalanced braces around else statement
   CHECK: Using comparison to false is error prone
   CHECK: Using comparison to true is error prone
   CHECK: braces {} should be used on all arms of this statement

Before: 0 errors, 1 warnings, 16 checks.
After:  0 errors, 1 warnings,  7 checks.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/pinctrl/nomadik/pinctrl-nomadik.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/nomadik/pinctrl-nomadik.c b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
index 83e7868bc1d7..8099dd947701 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -377,7 +377,7 @@ static void nmk_prcm_altcx_set_mode(struct nmk_pinctrl *npct,
 	 */
 	if (!alt_num) {
 		for (i = 0 ; i < PRCM_IDX_GPIOCR_ALTC_MAX ; i++) {
-			if (pin_desc->altcx[i].used == true) {
+			if (pin_desc->altcx[i].used) {
 				reg = gpiocr_regs[pin_desc->altcx[i].reg_index];
 				bit = pin_desc->altcx[i].control_bit;
 				if (readl(npct->prcm_base + reg) & BIT(bit)) {
@@ -392,7 +392,7 @@ static void nmk_prcm_altcx_set_mode(struct nmk_pinctrl *npct,
 	}
 
 	alt_index = alt_num - 1;
-	if (pin_desc->altcx[alt_index].used == false) {
+	if (!pin_desc->altcx[alt_index].used) {
 		dev_warn(npct->dev,
 			 "PRCM GPIOCR: pin %i: alternate-C%i does not exist\n",
 			 offset, alt_num);
@@ -406,7 +406,7 @@ static void nmk_prcm_altcx_set_mode(struct nmk_pinctrl *npct,
 	for (i = 0 ; i < PRCM_IDX_GPIOCR_ALTC_MAX ; i++) {
 		if (i == alt_index)
 			continue;
-		if (pin_desc->altcx[i].used == true) {
+		if (pin_desc->altcx[i].used) {
 			reg = gpiocr_regs[pin_desc->altcx[i].reg_index];
 			bit = pin_desc->altcx[i].control_bit;
 			if (readl(npct->prcm_base + reg) & BIT(bit)) {
@@ -494,7 +494,7 @@ int __maybe_unused nmk_prcm_gpiocr_get_mode(struct pinctrl_dev *pctldev, int gpi
 	pin_desc = npct->soc->altcx_pins + i;
 	gpiocr_regs = npct->soc->prcm_gpiocr_registers;
 	for (i = 0; i < PRCM_IDX_GPIOCR_ALTC_MAX; i++) {
-		if (pin_desc->altcx[i].used == true) {
+		if (pin_desc->altcx[i].used) {
 			reg = gpiocr_regs[pin_desc->altcx[i].reg_index];
 			bit = pin_desc->altcx[i].control_bit;
 			if (readl(npct->prcm_base + reg) & BIT(bit))
@@ -676,9 +676,9 @@ static const struct nmk_cfg_param nmk_cfg_params[] = {
 
 static int nmk_dt_pin_config(int index, int val, unsigned long *config)
 {
-	if (nmk_cfg_params[index].choice == NULL)
+	if (!nmk_cfg_params[index].choice) {
 		*config = nmk_cfg_params[index].config;
-	else {
+	} else {
 		/* test if out of range */
 		if  (val < nmk_cfg_params[index].size) {
 			*config = nmk_cfg_params[index].config |
@@ -1102,9 +1102,9 @@ static int nmk_pin_config_set(struct pinctrl_dev *pctldev, unsigned int pin,
 		if (gpiomode)
 			/* No glitch when going to GPIO mode */
 			__nmk_gpio_set_mode(nmk_chip, bit, NMK_GPIO_ALT_GPIO);
-		if (output)
+		if (output) {
 			__nmk_gpio_make_output(nmk_chip, bit, val);
-		else {
+		} else {
 			__nmk_gpio_make_input(nmk_chip, bit);
 			__nmk_gpio_set_pull(nmk_chip, bit, pull);
 		}

-- 
2.43.1


