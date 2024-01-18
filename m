Return-Path: <linux-kernel+bounces-30310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 908D7831CEC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49109284974
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845AC2CCD2;
	Thu, 18 Jan 2024 15:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GJPzNIKW"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDCC2C1AB;
	Thu, 18 Jan 2024 15:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705593197; cv=none; b=f7ti8EdzFQwP7PrYat9jiVm3312aUlx0xGFB7KA98FyEy8AftiNeOIBZaOBnCgI0+/dVEccnt+o8C18k68UZjkgdkpi0j4xuOTtUHsCdANtGtuTqjaEzFAQhxFqgtDLxdNd7rH8jD/BlnOtf4bHK823pyrjr2Pi9Gf/6Ub5IOvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705593197; c=relaxed/simple;
	bh=10ZEAJurS12z5xoBCG/ln6uoclFy6kBUieMg+mevi/M=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-GND-Sasl; b=fyMsR8vNx7jCjdMeqlZ1C+5C3s7r2bWPH933h5sJKhkQSwLKwjnWqwsIKf5TpPvFskHio+4eEQ9UrjaKkFxMYjRtqKYvvPuXmu1r8ZRQ/mfHTTZX4i6RcqKoaNAtM0GLNoL5DGkILUBG4YmGHN0DMgJUYza7CfxOtKVh79SJgwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GJPzNIKW; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AFFE3FF811;
	Thu, 18 Jan 2024 15:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1705593193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KtLJx1LoT2GXTWyVjN+1FeAU3avbgKgLJY8tRT/zqqY=;
	b=GJPzNIKWqJyqGJHe4ySUl7lYpn4gALMRCyqUhTuI/5LgqM+rSpHN10iuUk+4aNF2ofommC
	zVW/ILZjPRJEuqBOfW/PuxBHf0JTcVhlpZ8plg7sJVJr9aFF36V0mzs9zm5t2x40YlTDId
	oqguOaTvMIH+3dGWYWyKzycTSxXDwrlRRGXMgNtAGia9bDQ+xX1r2DHhJq85FjYWWm5mKx
	aOljl/30BvnPf+R0ZTM7w+xNeZuZhh5f53NRGhYPW6ZoiuktnwNmHD8iFGfpySvmff6wMs
	UWP3Uk6URD4oUZvTwTH4hFt8Gsv2Yrbv0bJ6CS+iDXhC+icO0g23FB3ss+pwjQ==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Paul Burton <paulburton@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Vladimir  Kondratiev <vladimir.kondratiev@mobileye.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v6 09/15] dt-bindings: mips: Add bindings for Mobileye SoCs
Date: Thu, 18 Jan 2024 16:52:38 +0100
Message-ID: <20240118155252.397947-10-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118155252.397947-1-gregory.clement@bootlin.com>
References: <20240118155252.397947-1-gregory.clement@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: gregory.clement@bootlin.com

Add the yaml bindings for Mobileye SoCs. Currently only EyeQ5 is
supported

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 .../devicetree/bindings/mips/mobileye.yaml    | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mips/mobileye.yaml

diff --git a/Documentation/devicetree/bindings/mips/mobileye.yaml b/Documentation/devicetree/bindings/mips/mobileye.yaml
new file mode 100644
index 0000000000000..831975f6b479f
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/mobileye.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+# Copyright 2023 Mobileye Vision Technologies Ltd.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mips/mobileye.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mobileye SoC series
+
+maintainers:
+  - Vladimir Kondratiev <vladimir.kondratiev@intel.com>
+  - Gregory CLEMENT <gregory.clement@bootlin.com>
+  - Théo Lebrun <theo.lebrun@bootlin.com>
+
+description:
+  Boards with a Mobileye SoC shall have the following properties.
+
+properties:
+  $nodename:
+    const: '/'
+
+  compatible:
+    oneOf:
+      - description: Boards with Mobileye EyeQ5 SoC
+        items:
+          - enum:
+              - mobileye,eyeq5-epm5
+          - const: mobileye,eyeq5
+
+additionalProperties: true
+
+...
-- 
2.43.0


