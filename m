Return-Path: <linux-kernel+bounces-127547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6CD894D75
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF10A282BC2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63C257323;
	Tue,  2 Apr 2024 08:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="AvmNUIA4"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A13856459;
	Tue,  2 Apr 2024 08:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712046588; cv=none; b=hqrUtFgQ5PtupwXftAsZVVVnKiO5nsvPMHZJ5qZOVU4edET43NLB5Zs04Y15rylTKxcJf5TjWlGGd3CgyNgOzmEY5AfTuRm59rqKzfBCFAAIty5fWbH/k1bK3vJN21UESMionogw4zO5FUbdgO5UyPg7dHyhmss9PK5XET7cXEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712046588; c=relaxed/simple;
	bh=w5Y4HAhWpPFs303OWWtOgDs1po79LqgdLoTPOFnYzS8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CjAvhIB4IdkZtya7x0TbWemJg9zDzJW+glBjqrxoRoBHtobTcCnQDEJEd3eB8Hj+vOraFRW9mSqWDV7b+rupRpZU32a8eixEg6mOfWlCwI+BZM0uVmEQ1/nf7I0auToYb7GSL7jeeF1tz3brFW/sFtws9+yAlvr4giUQtfSW2sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=AvmNUIA4; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.1.118] (unknown [103.86.18.232])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id AFE6F3A2;
	Tue,  2 Apr 2024 10:29:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712046548;
	bh=w5Y4HAhWpPFs303OWWtOgDs1po79LqgdLoTPOFnYzS8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AvmNUIA4nC8tV78ryeJRsGKx9yYGbUtddVBb71TunCHFqoV88GFddPrU48Ew0oF7f
	 /s0U/mxXmEDHaHz27IhcWLHej3ZHwwaAYWh61ZS8ysh/69MtmDP4QKlFsn5dxPOp+C
	 gqt+pJZP47Pdp5XWV4Suh/HhgZZIfXS9RjebXrjk=
From: Umang Jain <umang.jain@ideasonboard.com>
Date: Tue, 02 Apr 2024 13:59:27 +0530
Subject: [PATCH 3/3] fixups
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240402-kernel-name-extraversion-v1-3-57bb38de841b@ideasonboard.com>
References: <20240402-kernel-name-extraversion-v1-0-57bb38de841b@ideasonboard.com>
In-Reply-To: <20240402-kernel-name-extraversion-v1-0-57bb38de841b@ideasonboard.com>
To: Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Umang Jain <umang.jain@ideasonboard.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712046569; l=2587;
 i=umang.jain@ideasonboard.com; s=20240402; h=from:subject:message-id;
 bh=w5Y4HAhWpPFs303OWWtOgDs1po79LqgdLoTPOFnYzS8=;
 b=5IBzj1PKxlH3VdAL+w8r6TYuSlgTEiVJsOLgy1YTyK8k6P6fVvCzwHwcwMkYLt2q0To5bP6gz
 N1CDL8oEBR/DP8Od0JqI1++81Yub8+bS4U9OQl/qIrbvYUJItUnwfa0
X-Developer-Key: i=umang.jain@ideasonboard.com; a=ed25519;
 pk=8K9qSAtc2dNF4Ax+jYC0w9dlfptU7wxPBQwOy0nxRoc=

---
 drivers/media/i2c/imx283.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/media/i2c/imx283.c b/drivers/media/i2c/imx283.c
index 81fe2d4fd4d3..ace8f65aa6b3 100644
--- a/drivers/media/i2c/imx283.c
+++ b/drivers/media/i2c/imx283.c
@@ -450,12 +450,12 @@ static const struct imx283_mode supported_modes_12bit[] = {
 		.bpp = 12,
 		.width = 2736,
 		.height = 1824,
-		.min_hmax = 1870, /* Pixels (362 * 360/72 + padding) */
+		.min_hmax = 2414, /* Pixels (362 * 480MHz/72MHz + padding) */
 		.min_vmax = 3840, /* Lines */
 
 		/* 50.00 FPS */
-		.default_hmax = 1870, /* 362 @ 360MHz/72MHz */
-		.default_vmax = 3960,
+		.default_hmax = 2500, /* 375 @ 480MHz/72Mhz */
+		.default_vmax = 3840,
 
 		.veff = 1824,
 		.vst = 0,
@@ -483,7 +483,7 @@ static const struct imx283_mode supported_modes_10bit[] = {
 		.min_vmax = 3793,
 
 		/* 25.00 FPS */
-		.default_hmax = 1500, /* 750 @ 576MHz / 72MHz */
+		.default_hmax = 6000, /* 750 @ 576MHz / 72MHz */
 		.default_vmax = 3840,
 
 		.min_shr = 10,
@@ -568,12 +568,15 @@ static inline void get_mode_table(unsigned int code,
 static u64 imx283_pixel_rate(struct imx283 *imx283,
 			     const struct imx283_mode *mode)
 {
+	u64 link_frequency = link_frequencies[__ffs(imx283->link_freq_bitmap)];
 	unsigned int bpp = mode->bpp;
 	const unsigned int ddr = 2; /* Double Data Rate */
 	const unsigned int lanes = 4; /* Only 4 lane support */
-	u64 link_frequency = link_frequencies[__ffs(imx283->link_freq_bitmap)];
+	u64 numerator = link_frequency * ddr * lanes;
 
-	return link_frequency * ddr * lanes / bpp;
+	do_div(numerator, bpp);
+
+	return numerator;
 }
 
 /* Convert from a variable pixel_rate to 72 MHz clock cycles */
@@ -588,8 +591,11 @@ static u64 imx283_internal_clock(unsigned int pixel_rate, unsigned int pixels)
 	 */
 	const u32 iclk_pre = 72;
 	const u32 pclk_pre = pixel_rate / HZ_PER_MHZ;
+	u64 numerator = pixels * iclk_pre;
+
+	do_div(numerator, pclk_pre);
 
-	return pixels * iclk_pre / pclk_pre;
+	return numerator;
 }
 
 /* Internal clock (72MHz) to Pixel Rate clock (Variable) */
@@ -604,8 +610,11 @@ static u64 imx283_iclk_to_pix(unsigned int pixel_rate, unsigned int cycles)
 	 */
 	const u32 iclk_pre = 72;
 	const u32 pclk_pre = pixel_rate / HZ_PER_MHZ;
+	u64 numerator = cycles * pclk_pre;
+
+	do_div(numerator, iclk_pre);
 
-	return cycles * pclk_pre / iclk_pre;
+	return numerator;
 }
 
 /* Determine the exposure based on current hmax, vmax and a given SHR */

-- 
2.43.0


