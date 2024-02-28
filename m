Return-Path: <linux-kernel+bounces-84904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8418186AD71
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F65328D79A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C07315D5D0;
	Wed, 28 Feb 2024 11:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GuSbooRT"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F3E15B974;
	Wed, 28 Feb 2024 11:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119715; cv=none; b=LQI/Mh6XAkNSvGpT2+ggTTrxaK5sd+SpBubyu6r8eZCLWfyOqFzNuhg2GIII3TPLyagHws7wK9zzAiT1ZCoawkhF4Zr0b5r3XeJiVXFXcOKJHi/7i6YQ/kKqFKUhF7N6jo0hV/o/XJ1ob3qQOKnvcxK0BA0VecfESvwU8312nPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119715; c=relaxed/simple;
	bh=oGgJ8gpaqNelt5SQc8DcHBifkEvfboVrcnZ7BcpiHEM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pgNAQkA/AjI0SlfuIInSZ/edgyobTv2o5NJfYnHcVW+vd/pPxzb+DzfnlKRoKmR/E6a+trgvgC0t9eHN6fTHbST+vi15/hWL4yJ7f+0PIoFX+mELuX1R2wxR6iT74WNpCxeZ3T7n33bGQ3YIFiUwl7jdZberqtHrjSQLfNwbqbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GuSbooRT; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EEBE71BF205;
	Wed, 28 Feb 2024 11:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709119711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gg4NpT1+tGaIwywkDyVXPjv6BH/uwC3MOgmWJRGX7RQ=;
	b=GuSbooRTPsdPVvaawnG9AF+wk4vds8BusKSYzoPwTbqyDtYCnDAxSn5SHw2bHit7BkbWgf
	W9fqZMDvioRTG6YEQsKQ66uIueRCvqE3k2KlKHdjEQJwm6+GOeF5YeIxsydPp1F/Pz/lLI
	DCihn5/IQ4RoNFh/X8R2iPCpp6arHv24cikuxruFaERSA3eRjSmK57RXK8qe2s21ZWKFvn
	qSuMKZ9XP4tf+ZLAwbzN7wtCFscmONDOUpIqTAsAbtQIpgwljqAdPIefO9Q7YpS1CBGKmf
	fI0cr6UNHuYMTEZFz/UAf3Ik3hB4Y3ClxnZYobokrHBOP81s+EngTUE2HFSlgA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 28 Feb 2024 12:28:25 +0100
Subject: [PATCH v2 27/30] MIPS: eyeq5_defconfig: enable GPIO by default
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240228-mbly-gpio-v2-27-3ba757474006@bootlin.com>
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

Add both CONFIG_GPIOLIB=y and CONFIG_GPIO_NOMADIK=y to our platform
defconfig. Default config is CONFIG_GPIOLIB=n.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 arch/mips/configs/eyeq5_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/configs/eyeq5_defconfig b/arch/mips/configs/eyeq5_defconfig
index c35c29a4d479..6f052d4c5e58 100644
--- a/arch/mips/configs/eyeq5_defconfig
+++ b/arch/mips/configs/eyeq5_defconfig
@@ -66,6 +66,8 @@ CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
 CONFIG_HW_RANDOM=y
 # CONFIG_PTP_1588_CLOCK is not set
 CONFIG_PINCTRL=y
+CONFIG_GPIOLIB=y
+CONFIG_GPIO_NOMADIK=y
 CONFIG_MFD_SYSCON=y
 CONFIG_HID_A4TECH=y
 CONFIG_HID_BELKIN=y

-- 
2.44.0


