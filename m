Return-Path: <linux-kernel+bounces-98230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F29D877708
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 14:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA4101F212C0
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 13:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B80E2C84F;
	Sun, 10 Mar 2024 13:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oltmanns.dev header.i=@oltmanns.dev header.b="yqpB/ZFs"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB8738F9B;
	Sun, 10 Mar 2024 13:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710076965; cv=none; b=o6vvZUBAPf8yV2L/FhwQIZ/2LPbroHDquGXdl97bSmRpkJO1QVyijJTWZuZpH3KrA1r8h/hepHFhDZcPFh+aGlsqSv49p0DC2a1lzW79SfBL4I1YiiPSvuU0NE2oR2kMUIt1Qr0LocpGyY39buvN1GnFjfdK8TR67R0LqgHc+5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710076965; c=relaxed/simple;
	bh=kvvIkTmfQMw8UxSyDxPC93rn0oSCr/Quea9RAybNOn8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FFwatvMeuNWrtNYfZA2iVt6nNxbr1KerPummToTwQQVrQPVoxBcKccPAataK9/QktxypzrRfXLvPJfoxIfAgum5tHnCxyam1fCzQczXxMX1SmlJ7JNKJrxQmXKBdT2rn/RanQXdyMNkB4pYazVDrdl4lnyrO4hYCebUZE+O6TQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oltmanns.dev; spf=pass smtp.mailfrom=oltmanns.dev; dkim=pass (2048-bit key) header.d=oltmanns.dev header.i=@oltmanns.dev header.b=yqpB/ZFs; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oltmanns.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oltmanns.dev
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Tt0vF5gjbz9smD;
	Sun, 10 Mar 2024 14:22:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
	s=MBO0001; t=1710076953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XhGwFTOxsp8TA925vZCjt+JcQqgJocjoqK3BssOmRYM=;
	b=yqpB/ZFsIC3kVJiHYJxsIUj+zkEdsrbwWRpoL3s3LJXI5NXAT7uCqBmYJynZrZvLl9pG8L
	6Lf3AiIu71PVNlRQ+byBfX2w5xMsh44hiyxEqL1EgviV57n1HO7SxCwMJC7nU0l4IemOnT
	RrgNw4P9jbLAs0TbBFnqURRsmlFipUNhVn5S4doXCmEOhZm/oSXdrr1vjURggphMfKkvQC
	5dpf5rQfqOhf+emT9gpdPE3El/+kMKAt1LpILKsR3l49okaMcqcMlZNVVwjrCyXNXwxrdm
	PycJixMcrT0d1HVm7iYFxB74VZA1c+dD7Yza54IEYi2w6i6csV3XqrYbMO7WTw==
From: Frank Oltmanns <frank@oltmanns.dev>
Date: Sun, 10 Mar 2024 14:21:15 +0100
Subject: [PATCH v4 5/5] arm64: dts: allwinner: a64: Run GPU at 432 MHz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240310-pinephone-pll-fixes-v4-5-46fc80c83637@oltmanns.dev>
References: <20240310-pinephone-pll-fixes-v4-0-46fc80c83637@oltmanns.dev>
In-Reply-To: <20240310-pinephone-pll-fixes-v4-0-46fc80c83637@oltmanns.dev>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Purism Kernel Team <kernel@puri.sm>, Ondrej Jirman <megi@xff.cz>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 Frank Oltmanns <frank@oltmanns.dev>, Erico Nunes <nunes.erico@gmail.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1257; i=frank@oltmanns.dev;
 h=from:subject:message-id; bh=kvvIkTmfQMw8UxSyDxPC93rn0oSCr/Quea9RAybNOn8=;
 b=owEB7QES/pANAwAIAZppogiUStPHAcsmYgBl7bP6p2D/0yVAajHJzxsF2A2zeZMiqWXbGyGZ0
 py+R4ILTJuJAbMEAAEIAB0WIQQC/SV7f5DmuaVET5aaaaIIlErTxwUCZe2z+gAKCRCaaaIIlErT
 xzQeC/9jShpjnftS4GkyabYSB2tpbtKkzT+oFr9HD819N1UtksrEvwfmCRDtWbZkHg+E+Id2EFl
 5cwQX+IXyN5BYzWsPCCw/Jxf3LqYdbEmmwYWS7YMLBE8VVjpycE3jloPFsYVc4yOxjRW7+MCJxl
 5/29M0HefgdbSERNfRe40HeZZGjZHUu4KdUa69QIixrQTZLrLsCFm42Z/UqQJ3VkPn5NiiyJr6E
 z40Tg+9Ga/rU2uaDcforPsLl/l0y9ayLBoK0UA9C3LijM2DxATNpeWz3iWPwg/YIRp6MvTKNW18
 YiHtgkixh18DiLRJBl2Z3G0dhWGU3g9e6EfYoV93t/YeHSmXCxp91JSM+cwxNsgHLKCoZ1jIWsP
 82JDNAdA0LyExvZXF5171VphDgB353vTAiSQlb0BlupDKjDFbKCbOfIpcJTDS63WGJ+pBlEi0Xa
 t/JoCa19Y8thObe2+u87zj51in6LJCujRj8DHXUmwhVWJgMTIO93b65RqRGapzoBPecpg=
X-Developer-Key: i=frank@oltmanns.dev; a=openpgp;
 fpr=02FD257B7F90E6B9A5444F969A69A208944AD3C7

The Allwinner A64's GPU has currently three operating points. However,
the BSP runs the GPU fixed at 432 MHz. In addition, at least one of the
devices using that SoC - the pinephone - shows unstabilities (see link)
that can be circumvented by running the GPU at a fixed rate.

Therefore, remove the other two operating points from the GPU OPP table,
so that the GPU runs at a fixed rate of 432 MHz.

Link: https://gitlab.com/postmarketOS/pmaports/-/issues/805
Acked-by: Erico Nunes <nunes.erico@gmail.com>
Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 57ac18738c99..c810380aab6d 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -107,14 +107,6 @@ de: display-engine {
 	gpu_opp_table: opp-table-gpu {
 		compatible = "operating-points-v2";
 
-		opp-120000000 {
-			opp-hz = /bits/ 64 <120000000>;
-		};
-
-		opp-312000000 {
-			opp-hz = /bits/ 64 <312000000>;
-		};
-
 		opp-432000000 {
 			opp-hz = /bits/ 64 <432000000>;
 		};

-- 
2.44.0


