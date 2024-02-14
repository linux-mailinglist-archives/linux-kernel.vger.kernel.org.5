Return-Path: <linux-kernel+bounces-65530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99741854E4B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54A4B280BFF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF0865BBB;
	Wed, 14 Feb 2024 16:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MLKn5uRO"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B91E612CE;
	Wed, 14 Feb 2024 16:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707927903; cv=none; b=ftjcMGLxS0gc8qZCACC+nE21FnRT9buInzhO35OgEdJbl7Y8CS+GP0pqsqV6vrZVD26qda37hpp/p8vPkiNGNwc6jvMjRqUylIEVh53fAuQs8KyjJTgx5W+ebrEl/2rMj4AtvtvEKwbxCZLGz2JZX9uH28DOTR3YD+4hyCspfkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707927903; c=relaxed/simple;
	bh=8zvumhPtc39Rn6Dl8YVkzpMU/rbaGUWpjhUMdaBOfN8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=moqMgmDcmK9P7p1IccmsY9DngWyqmYGk/x9g/J1L//vWLQcH/wkZnadEBDFvrJg5L0/g4dY25uD4D3MyBQo0yj2VtVm/UBmHoG1i7vI+XaQuG4Py2z/laLlVCfSWO79X1OSlk07W5xiPfvAN8nLYdSyw4ShWGi5aLsO6WxRT8PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MLKn5uRO; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 045C160012;
	Wed, 14 Feb 2024 16:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707927899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bbs3ElSU8A2LGjg10D6v+FLxDQ0rBkyPGCcJkK3mAUc=;
	b=MLKn5uROJWve1MycsAobaCKu9Y2dAO1uLRpoAzIvndebUaFrC15lfPMM2AfsFhFMeCLyU2
	0vn92nOrXmhP2FzWv37sMfaeya2L27g6Q1T8QCgqhYcfllkAl9e6rCwV+6a4UM/SmjW9uO
	Kgmz0nkhDRmFGvrUcowpmbWX/jatZ5//RwsGZzjMflVtwPJk7OEWHhpyT9ydZp5HzB2Aj9
	+MEr0oT1wTfzES6M2GAkwswA2CzkASr5KFm/PajpC8EfRgt8WkolDQj+nZrhH6ZS1uakZ2
	VGpc6h/Qif9g7d/wrKQGXi/q+8yYlBmG95TxbEQgdTPsQjzx6W3S9WjY9yuuNQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 14 Feb 2024 17:24:13 +0100
Subject: [PATCH 20/23] MIPS: eyeq5_defconfig: enable GPIO by default
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240214-mbly-gpio-v1-20-f88c0ccf372b@bootlin.com>
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
2.43.1


