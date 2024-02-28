Return-Path: <linux-kernel+bounces-84887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFE186AD2C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44C7A1F237A5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747E014E2CD;
	Wed, 28 Feb 2024 11:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="F/wY/q0P"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCD313AA55;
	Wed, 28 Feb 2024 11:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119705; cv=none; b=erSK/W3Yc5u0Ewyjn8DShrhDf+z2mssJWyMgtbhRtNvvIc01T+NBEKvkI7e08b3UKEkwKps69fVRiXB2ENDeEnoZF/NEVLyAr/jOssskQMXYmEwj13zRz3ikA52DyFl6QxhdbZf7sUaatkFU3uqjWbiBw/iSv+8VPK0OPNKj6vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119705; c=relaxed/simple;
	bh=6z3c1t74vK3ZWVtU9ToxOXmydMjoB2QW4c0ShObyiFk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uoluSizO5QHBvlgQvMwNt2cEKchNMGHNc3jWW10ysftMRP2/5+i06Pf6GYqNkz8Iiju6nBIhgR/c8w0gJVs8Bmlo3m5Fqj889/jXqmJT3i7UaG2E4rJRTUjP3SvMqggw+hXbmLHBvBSPicGr9xci7OEPi4g1qrfPTO4ET03TEkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=F/wY/q0P; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D37EC1BF21B;
	Wed, 28 Feb 2024 11:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709119700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F/Qin2B0dqTR3V/LRjd8MyVOb6bkL9u9izvBOC/OSNY=;
	b=F/wY/q0PhpmwWSGC+jmBzPDsmplU4pYwA/WKbve2/5hCzFu2Ue1A0EnW4mJYykmHGTGmKW
	w8XRzC/FjDvAPbffetJ2Edv7Y2pnUxzN1nZrSgl3K5zFtd6n8nCD7jSuAw6ybEPcidrAYX
	ELPrbYnZ0Lv8lSaj0O/65dFYoDCxh6gp8cR1If+kzd5fq0xu7LHh+Gon8Wjv6tGBGpcZAW
	9h7EDV8UP7dwKFpLeax1W8bX/mNhgCy7wQ32f3zF+NhcHGtOcyrG4DVBCPG3GwiWHrLNOV
	UEln74lvkeWpij0IhKoiKKcoSAShe57kPbDTBmOietJldz2xG1pPHepErAAO+A==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 28 Feb 2024 12:28:11 +0100
Subject: [PATCH v2 13/30] pinctrl: nomadik: follow conditional kernel
 coding conventions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240228-mbly-gpio-v2-13-3ba757474006@bootlin.com>
References: <20240228-mbly-gpio-v2-0-3ba757474006@bootlin.com>
In-Reply-To: <20240228-mbly-gpio-v2-0-3ba757474006@bootlin.com>
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
X-Mailer: b4 0.13.0
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
index 95181ab575e0..b74378302229 100644
--- a/drivers/pinctrl/nomadik/pinctrl-nomadik.c
+++ b/drivers/pinctrl/nomadik/pinctrl-nomadik.c
@@ -378,7 +378,7 @@ static void nmk_prcm_altcx_set_mode(struct nmk_pinctrl *npct,
 	 */
 	if (!alt_num) {
 		for (i = 0 ; i < PRCM_IDX_GPIOCR_ALTC_MAX ; i++) {
-			if (pin_desc->altcx[i].used == true) {
+			if (pin_desc->altcx[i].used) {
 				reg = gpiocr_regs[pin_desc->altcx[i].reg_index];
 				bit = pin_desc->altcx[i].control_bit;
 				if (readl(npct->prcm_base + reg) & BIT(bit)) {
@@ -393,7 +393,7 @@ static void nmk_prcm_altcx_set_mode(struct nmk_pinctrl *npct,
 	}
 
 	alt_index = alt_num - 1;
-	if (pin_desc->altcx[alt_index].used == false) {
+	if (!pin_desc->altcx[alt_index].used) {
 		dev_warn(npct->dev,
 			 "PRCM GPIOCR: pin %i: alternate-C%i does not exist\n",
 			 offset, alt_num);
@@ -407,7 +407,7 @@ static void nmk_prcm_altcx_set_mode(struct nmk_pinctrl *npct,
 	for (i = 0 ; i < PRCM_IDX_GPIOCR_ALTC_MAX ; i++) {
 		if (i == alt_index)
 			continue;
-		if (pin_desc->altcx[i].used == true) {
+		if (pin_desc->altcx[i].used) {
 			reg = gpiocr_regs[pin_desc->altcx[i].reg_index];
 			bit = pin_desc->altcx[i].control_bit;
 			if (readl(npct->prcm_base + reg) & BIT(bit)) {
@@ -495,7 +495,7 @@ int __maybe_unused nmk_prcm_gpiocr_get_mode(struct pinctrl_dev *pctldev, int gpi
 	pin_desc = npct->soc->altcx_pins + i;
 	gpiocr_regs = npct->soc->prcm_gpiocr_registers;
 	for (i = 0; i < PRCM_IDX_GPIOCR_ALTC_MAX; i++) {
-		if (pin_desc->altcx[i].used == true) {
+		if (pin_desc->altcx[i].used) {
 			reg = gpiocr_regs[pin_desc->altcx[i].reg_index];
 			bit = pin_desc->altcx[i].control_bit;
 			if (readl(npct->prcm_base + reg) & BIT(bit))
@@ -677,9 +677,9 @@ static const struct nmk_cfg_param nmk_cfg_params[] = {
 
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
@@ -1105,9 +1105,9 @@ static int nmk_pin_config_set(struct pinctrl_dev *pctldev, unsigned int pin,
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
2.44.0


