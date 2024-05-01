Return-Path: <linux-kernel+bounces-165469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5BD8B8CED
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24A44288666
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220C012FB09;
	Wed,  1 May 2024 15:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b="izN5/8E+"
Received: from mail-108-mta78.mxroute.com (mail-108-mta78.mxroute.com [136.175.108.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35AF12F59D
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 15:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714577201; cv=none; b=pMuF+BqqVsK+AEv+W/rUAFiAYHwoOFwViJQDmo51rexToGhFXUbwX0iOd3t5KBC8Fgdnpl4D4SQQ6w7ZtZCRRcDi5ttwzIt+Smq6/onQ8af6rXGHit/3mBgWcznkKJouZvoaJKc0HbeHErNL4UJm2kkmT4FkwdoToIonjoblPAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714577201; c=relaxed/simple;
	bh=liAeCOCis53oq3GtruCxMWUheY7cl+d70gOgO+0PYV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CGSKiWBSv9yuDaLpnf4Vgy7XlkPwwrtTj0RRz1thggRP0mrFo3dj85lOCUuGsPoDRKdTncBg1lmbb+ToArkCqs1qzExvqvAr261VPwASF+oBDEL/j7Y1yynFvRx/3eGpe07nVKz+vL4tqx53DHFYQqAZAY0caDJDgaK6QzifkPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com; spf=pass smtp.mailfrom=luigi311.com; dkim=pass (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b=izN5/8E+; arc=none smtp.client-ip=136.175.108.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luigi311.com
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta78.mxroute.com (ZoneMTA) with ESMTPSA id 18f34c2c3b10008ca2.011
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 01 May 2024 15:25:30 +0000
X-Zone-Loop: 1425f019b24d1800aac63f627eed934db289d9d1ed3f
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=luigi311.com; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PzT4xTOEeVDL66kJK8reXjWQ9fp0oEJkeO2UsrLAT0g=; b=izN5/8E+EHY5iywXRGikzZ/FES
	t/NYOc+jhjgS2/X0Fl1sr5Tfv5YThU1A4d89T0JiOcbyWMVTOy7NMlaCbjPid6Oji+jprVKwT6jKw
	Nwt/lpKCbU7Av/592TCiMnL9QopQvSsuU6g27+pvS69cZ7shmbYOrAfQzhNmGKUuSA07R1UAp4dYZ
	qDGnK/Nez1yLP+h0wvO1ck47+toWHgy8K1K6HfWHE+b06hBPzEaYD/vJRHDSDnl25rM4XQPzzO2gq
	4JsEaCcMrnu/bzjUHG4VQVbIR79IszftuO+hKjLGZWWCfLThmfI069bl65PbGXCm2VzNItWsxyGt5
	E8nf6MYA==;
From: git@luigi311.com
To: linux-media@vger.kernel.org
Cc: dave.stevenson@raspberrypi.com,
	jacopo.mondi@ideasonboard.com,
	mchehab@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	sakari.ailus@linux.intel.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	pavel@ucw.cz,
	phone-devel@vger.kernel.org,
	Luis Garcia <git@luigi311.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 18/25] dt-bindings: media: imx258: Add alternate compatible strings
Date: Wed,  1 May 2024 09:24:35 -0600
Message-ID: <20240501152442.1072627-19-git@luigi311.com>
In-Reply-To: <20240501152442.1072627-1-git@luigi311.com>
References: <20240501152442.1072627-1-git@luigi311.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: personal@luigi311.com

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

There are a number of variants of the imx258 modules that can not
be differentiated at runtime, so add compatible strings for the
PDAF variant.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Luis Garcia <git@luigi311.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Pavel Machek <pavel@ucw.cz>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/media/i2c/sony,imx258.yaml       | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
index bee61a443b23..c978abc0cdb3 100644
--- a/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
@@ -13,11 +13,16 @@ description: |-
   IMX258 is a diagonal 5.867mm (Type 1/3.06) 13 Mega-pixel CMOS active pixel
   type stacked image sensor with a square pixel array of size 4208 x 3120. It
   is programmable through I2C interface.  Image data is sent through MIPI
-  CSI-2.
+  CSI-2. The sensor exists in two different models, a standard variant
+  (IMX258) and a variant with phase detection autofocus (IMX258-PDAF).
+  The camera module does not expose the model through registers, so the
+  exact model needs to be specified.
 
 properties:
   compatible:
-    const: sony,imx258
+    enum:
+      - sony,imx258
+      - sony,imx258-pdaf
 
   assigned-clocks: true
   assigned-clock-parents: true
-- 
2.44.0


