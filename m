Return-Path: <linux-kernel+bounces-126776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D555A893CA6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3878A282A24
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792CE482C1;
	Mon,  1 Apr 2024 15:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqIzWbE/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AA745BEC;
	Mon,  1 Apr 2024 15:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711984217; cv=none; b=gQ+MWWL9B75qEEzKzsNIl6tn9LBxr2IYLSrAxGyOyeoLwfIjfpQlXo3gwYO6i/2ApXuUrx+kxGoxTwyiNBMGs8PIZYOoGJThtEAJpC0rBA5K0buGRzHNPgHCwaeaUMV82RWO7CUwHoD5EvF41lqU/cUoZQaGcpsz9ncSGzJZvvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711984217; c=relaxed/simple;
	bh=ypyseA7gjkezHNz8byQb1xroCwMnLrrumCgs2qcJ9TM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H/b9PHRqP0p/rAOhpIcR0vRGqp2AP8t2vuD7LRJXmBohdU3bylH3ZU2pWLOCJsSBxVtBGAQ04Su6estFnTMtJu0vATVBH5GRpqkoeQ96bTnyRfEIXZn+U2L/uDxl2X9Fz+5Rj8+xheMr7Js5JpUlaUVadz4XakMzl2TrZ6l71/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqIzWbE/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11CEFC43390;
	Mon,  1 Apr 2024 15:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711984217;
	bh=ypyseA7gjkezHNz8byQb1xroCwMnLrrumCgs2qcJ9TM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kqIzWbE/88Dxgs2PUcPDRr4wCvLECfF7SyBly1ZZdfPqyzF1TqIC62iPGfu6mCp1y
	 PApzigXBT3XRaFaTC2g9yxdOfw6DmHjCy7E8zq/NTr4o3nA6ia2v5TvaNtJSqQYZPw
	 tTW5yAbseOcyif1tIkuAFr5slgU/kGRHfKKV1+1U7z5VzoVadDC+8kq6jmwSsaczwg
	 uMgyElTWfF/zipJXK1EJXyJ5Vq2DXJKQm3UGzMDWRLXic2ghvX6qlUoO+0wXTDbuKm
	 WMtaj86hNbhlun4u/o3EVCslxAR8T2+A4VdSothhK6QdmIig8fFdPNlHZkuvOykNhQ
	 TUyuz2rlxwrWQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A84CD1288;
	Mon,  1 Apr 2024 15:10:16 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Date: Mon, 01 Apr 2024 18:32:19 +0300
Subject: [PATCH 1/6] dt-bindings: adc: ad7173: add support for ad411x
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240401-ad4111-v1-1-34618a9cc502@analog.com>
References: <20240401-ad4111-v1-0-34618a9cc502@analog.com>
In-Reply-To: <20240401-ad4111-v1-0-34618a9cc502@analog.com>
To: Ceclan Dumitru <dumitru.ceclan@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711985550; l=4017;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=ZyRClsyDd6RKV/PtoHfGxoOfXDbJoSHfK85MVhx0ze8=;
 b=OVfXhcFTgH9CYNC7fhmMZbavK94vVtJeh+VDoQk2nZ9ZKe93KmREz9IS2PvDGUG6wrpoXP4TU
 tS58/VzjVh1AsCfd01MdgrIYEuNU+n4kbO4agDA4qQqmCt6T01rMm+d
X-Developer-Key: i=dumitru.ceclan@analog.com; a=ed25519;
 pk=HdqMlVyrcazwoiai7oN6ghU+Bj1pusGUFRl30jhS7Bo=
X-Endpoint-Received: by B4 Relay for dumitru.ceclan@analog.com/20240313
 with auth_id=140
X-Original-From: Dumitru Ceclan <dumitru.ceclan@analog.com>
Reply-To: dumitru.ceclan@analog.com

From: Dumitru Ceclan <dumitru.ceclan@analog.com>

Add support for: AD4111, AD4112, AD4114, AD4115, AD4116.

AD411x family ADCs support a VCOM pin, dedicated for single-ended usage.
AD4111/AD4112 support current channels, usage is implemented by
 specifying channel reg values bigger than 15.

Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7173.yaml    | 59 +++++++++++++++++++++-
 1 file changed, 57 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
index ea6cfcd0aff4..bba2de0a52f3 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
@@ -19,7 +19,18 @@ description: |
   primarily for measurement of signals close to DC but also delivers
   outstanding performance with input bandwidths out to ~10kHz.
 
+  Analog Devices AD411x ADC's:
+  The AD411X family encompasses a series of low power, low noise, 24-bit,
+  sigma-delta analog-to-digital converters that offer a versatile range of
+  specifications. They integrate an analog front end suitable for processing
+  fully differential/single-ended and bipolar voltage inputs.
+
   Datasheets for supported chips:
+    https://www.analog.com/media/en/technical-documentation/data-sheets/AD4111.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/AD4112.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/AD4114.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/AD4115.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/AD4116.pdf
     https://www.analog.com/media/en/technical-documentation/data-sheets/AD7172-2.pdf
     https://www.analog.com/media/en/technical-documentation/data-sheets/AD7172-4.pdf
     https://www.analog.com/media/en/technical-documentation/data-sheets/AD7173-8.pdf
@@ -31,6 +42,11 @@ description: |
 properties:
   compatible:
     enum:
+      - adi,ad4111
+      - adi,ad4112
+      - adi,ad4114
+      - adi,ad4115
+      - adi,ad4116
       - adi,ad7172-2
       - adi,ad7172-4
       - adi,ad7173-8
@@ -125,10 +141,19 @@ patternProperties:
 
     properties:
       reg:
+        description:
+          Reg values 16-19 are only permitted for ad4111/ad4112 current channels.
         minimum: 0
-        maximum: 15
+        maximum: 19
 
       diff-channels:
+        description:
+          For using current channels specify only the positive channel.
+            (IIN2+, IIN2−) -> diff-channels = <2 0>
+
+          Family AD411x supports a dedicated VCOM voltage input.
+          To select it set the second channel to 16.
+            (VIN2, VCOM) -> diff-channels = <2 16>
         items:
           minimum: 0
           maximum: 31
@@ -166,7 +191,6 @@ allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
   # Only ad7172-4, ad7173-8 and ad7175-8 support vref2
-  # Other models have [0-3] channel registers
   - if:
       properties:
         compatible:
@@ -187,6 +211,37 @@ allOf:
                 - vref
                 - refout-avss
                 - avdd
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad4114
+              - adi,ad4115
+              - adi,ad4116
+              - adi,ad7173-8
+              - adi,ad7175-8
+    then:
+      patternProperties:
+        "^channel@[0-9a-f]$":
+          properties:
+            reg:
+              maximum: 15
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad7172-2
+              - adi,ad7175-2
+              - adi,ad7176-2
+              - adi,ad7177-2
+    then:
+      patternProperties:
+        "^channel@[0-9a-f]$":
+          properties:
             reg:
               maximum: 3
 

-- 
2.43.0



