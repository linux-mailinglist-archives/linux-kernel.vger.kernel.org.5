Return-Path: <linux-kernel+bounces-65004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 489C3854675
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB8AE2861E1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6C819474;
	Wed, 14 Feb 2024 09:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIsqQB8Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E7015AE0;
	Wed, 14 Feb 2024 09:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707904121; cv=none; b=hyl/PZrKuflTlWKd0CDyjf6Uy0L3JIYTFcLWlnX+LLoHtibvfJWVxtFxWBhgigbY6ljH5yOdSlyhcYDwCCh6FIm07neoLImKz0YkjqoS6/hArHjprf/fmUSCYwkWLb39FFM5WE7C7Z9btPFXwIBI3OqGjssBty9T1s9bXIQ63RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707904121; c=relaxed/simple;
	bh=8f43hjZKhQSxbAyrgwruozpP6DsOBuauW42V2nrYgss=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IZZHY9Ng2ickmci9Bl5EyncIVKyo8TkTH1qq+IKQf13vQXGEoMLADvAqvSAvH2V5LHgyGHIFJh0/oq8DpoY/RfJJJ7O72YDnbXfVDpjIgKnrVgWADev2JvBGCCUmIfUHFCmpe0uBNpBS425HY6VXY/SUCtOs8tW9x4thV3rjPZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIsqQB8Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D31C4166A;
	Wed, 14 Feb 2024 09:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707904121;
	bh=8f43hjZKhQSxbAyrgwruozpP6DsOBuauW42V2nrYgss=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XIsqQB8Zm0Jb+sl8MzSyxBPD8Eg8whH6wzIVgpkROiMsQBvbVmJwWfgPlRvK41Joh
	 SiRCezS21e9wMZVW3URVVt6A544ktyR98mPm4rv5n7oK5+U1jEjSDy7UB5Nhme6nCI
	 7oCBzC1agE0twgq6euLcWY+4d2+WNaajfdscSwpxGWLvOna/CP86koKF0ux+3gtfik
	 BHMQwZniBt8H/PVdeW8qD6l/lDxjJPbO3zf4XBnK5YzvY4R8v/OYd5Hf4pA1xSaqvu
	 t5KUj/GgSTC0XufCT+thh+SOPc0kzeEsuGVUoasE8F+RLnIlOyS/zBeFJCyP77kErN
	 FvXJ3VjY/L6AQ==
From: Roger Quadros <rogerq@kernel.org>
Date: Wed, 14 Feb 2024 11:46:48 +0200
Subject: [PATCH v3 4/5] dt-bindings: usb/ti,am62-usb.yaml: Add PHY2
 register space
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-for-v6-9-am62-usb-errata-3-0-v3-4-147ec5eae18c@kernel.org>
References: <20240214-for-v6-9-am62-usb-errata-3-0-v3-0-147ec5eae18c@kernel.org>
In-Reply-To: <20240214-for-v6-9-am62-usb-errata-3-0-v3-0-147ec5eae18c@kernel.org>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: nm@ti.com, r-gunasekaran@ti.com, afd@ti.com, b-liu@ti.com, srk@ti.com, 
 francesco@dolcini.it, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1686; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=8f43hjZKhQSxbAyrgwruozpP6DsOBuauW42V2nrYgss=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBlzIxmYoXsUd1qhjCRsCV2AnVfR4rLh2DaufhUP
 2AZVhhJvACJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZcyMZgAKCRDSWmvTvnYw
 k8A8D/4nqQkxv9A9tnIq1iw1o4H7cxqPMg1c8wIMKgVInqTDAvwobYv/InyRsHWX4ybjtDkRyV2
 JIoR1MOnifXaXnsmfqINhVSH3SG3rCWlKmRETIoLcb2gbnJ1msMerYKknhuoo9P2W/d+QP1Vg27
 p5hQ4HSWi+a4crUJzJRTj5n8jwlvG9OUxVC40sG3mrDVIYbDhrfCzh9YFu/JhSnCoCXCv1T3UHY
 f+WGLJHBlG+Ojt+qR+l4UEs8kU1lPsrNlP2r/8Auxf1qBtROPl9sbKmjUyaYwzLFRT3HzckNV+/
 2GOGMOa8ao8YVW5tsIz4xvPLFniHpVhULWLKL5+L4XMCvVq9NQfwtEKiqAWXVw9Lz4k5Af/hfAw
 7YdxHe2qw6wlTUB+VnyYSa44hTXt4vbVUJ6eKkWT0KTZ4Qlio7/nimfXYI9yf4Ts32rtGSYWDde
 Ldgibseb5jZB556MG8MueOjliAo2sSfN0VmoxGNhOHIFQZjlNR/rdkExVrGMJLsX1kHDfdSTD+e
 NL2+lJX5tlrBiZefAmmTAhmNZjTFq9BLjYdQAZUF9U66GYr//8jq2xPrfKsX/u+2fWws4t7VbEn
 Doh5sSZ2eC1f+7rh/BZFpVRK3DxPMwzZnpHI96RSvoxByHeFRC7NOJgSJlZ6F016Ljxl/7Wxq8w
 4B1Vs1h3y7t8Meg==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

Add PHY2 register space to DT binding documentation.

We use minItems: 1 as DT update will come later and we don't
want warnings for existing DTs.

So far this register space was not required but due to the
newly identified Errata i2409 [1] we need to poke this
register space.

[1] https://www.ti.com/lit/er/sprz487d/sprz487d.pdf

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
Changelog:

v3: no change

v2: add minItems and update commit log
	https://lore.kernel.org/all/20240205141221.56076-5-rogerq@kernel.org/

v1: was sent as part of different series
https://lore.kernel.org/all/20240201120332.4811-5-rogerq@kernel.org/
---
 Documentation/devicetree/bindings/usb/ti,am62-usb.yaml | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml b/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
index fec5651f5602..f6e6d084d1c5 100644
--- a/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
+++ b/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
@@ -14,7 +14,10 @@ properties:
     const: ti,am62-usb
 
   reg:
-    maxItems: 1
+    minItems: 1
+    items:
+      - description: USB CFG register space
+      - description: USB PHY2 register space
 
   ranges: true
 
@@ -82,7 +85,8 @@ examples:
 
       usbss1: usb@f910000 {
         compatible = "ti,am62-usb";
-        reg = <0x00 0x0f910000 0x00 0x800>;
+        reg = <0x00 0x0f910000 0x00 0x800>,
+              <0x00 0x0f918000 0x00 0x400>;
         clocks = <&k3_clks 162 3>;
         clock-names = "ref";
         ti,syscon-phy-pll-refclk = <&wkup_conf 0x4018>;

-- 
2.34.1


