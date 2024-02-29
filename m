Return-Path: <linux-kernel+bounces-86002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B645786BE5B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D966C1C20D4C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF4137153;
	Thu, 29 Feb 2024 01:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="snco1LAQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436372D638;
	Thu, 29 Feb 2024 01:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709170617; cv=none; b=HWzl2vLAdODeowIOdcxt+BcusSJetz1jIY9mK2cdcIk5PA3i4a6d0JwU4z9IDtVhMK9zvYGEO1nCX4L76+zrsn5YxYmfbW5m86OdhTWZKVV2jHaK1e5v+xI0rPWEo7TtRQHTFb8/YNd/juevREmCSBBM9uwC8SYIN8YxhceEiD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709170617; c=relaxed/simple;
	bh=slgj3guZ6Z9tOfsaZHVxvfSZgSTNkEptvrY2Lok1/e8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eqJLYPSJpwraF/MMVXhxZQBitlwh2uHwM5RHWFR2ym00uoxEyoA2v74U1E7HBS5pUihjhjDQJPpVfXAJK5vv4BKo8sDyjY6Yz9LAVulMAMqEiJba+2UxNS5LUvPgz246m4BXrOW+cTLW4UrUfrWBkame/XZGqoknDaK/eDHrDmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=snco1LAQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6F80C43609;
	Thu, 29 Feb 2024 01:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709170617;
	bh=slgj3guZ6Z9tOfsaZHVxvfSZgSTNkEptvrY2Lok1/e8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=snco1LAQDnskqcKyM5XHNGII0jP3PrNjviOutuZm3rOaQiDhPOKQvathSskO8+0mT
	 q2oUdX5SXxwvHm5Tt/cjBbtiqvJ5FbcH+XhWrfJ0g4aD81T1Sx837jb4EOOoI5CBqK
	 wO4R4nusqOmWkNB3chXPoRZnkeLO3QDbCpoCCK3QrekSUBb12QYv9fRqajL+S+MCvt
	 P1rwcz6/rgkQs6D291ShKiQrE6lwCToNvD3X53QYCv3gxe+Ba/JPRiLgdPD4LunPhd
	 ugXFQ1FYE7830vWRBCr0UfMnCv79lIFTW24zEfv3L+02RBHrOycCq0JARAXt+s+Saq
	 pB/XhlRlzZfJQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CC3C54E4A;
	Thu, 29 Feb 2024 01:36:56 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Thu, 29 Feb 2024 09:36:22 +0800
Subject: [PATCH v7 4/5] dt-bindings: mmc: hisilicon,hi3798cv200-dw-mshc:
 add Hi3798MV200 binding
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240229-b4-mmc-hi3798mv200-v7-4-10c03f316285@outlook.com>
References: <20240229-b4-mmc-hi3798mv200-v7-0-10c03f316285@outlook.com>
In-Reply-To: <20240229-b4-mmc-hi3798mv200-v7-0-10c03f316285@outlook.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
Cc: Igor Opaniuk <igor.opaniuk@linaro.org>, 
 tianshuliang <tianshuliang@hisilicon.com>, David Yang <mmyangfl@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
 openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
 Yang Xiwen <forbidden405@outlook.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709170614; l=2243;
 i=forbidden405@outlook.com; s=20240228; h=from:subject:message-id;
 bh=MbI2PnDc478+pXDtiAiOl4Pgtl4uv4VM2qKM2Aj02Fo=;
 b=8zSp4dLLsDBu30sAz/NTxlB/j/tOeb07F14PeolScfGgeJO2MHdeiGNbbq4uVBZeQWd1iWSEu
 LvL8wvkizJzAcrQvO4XM/jg2oVl3LX8Gusoka+2JcwSgwse57ffHy+a
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=KAWv6ZzFsT54MGllOczJgFiWB+DuayEmyn24iiVVThU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20240228 with auth_id=136
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

Add binding and an extra property for Hi3798MV200 DWMMC specific extension.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 .../mmc/hisilicon,hi3798cv200-dw-mshc.yaml         | 24 +++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/hisilicon,hi3798cv200-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/hisilicon,hi3798cv200-dw-mshc.yaml
index f3dc973cb490..41c9b22523e7 100644
--- a/Documentation/devicetree/bindings/mmc/hisilicon,hi3798cv200-dw-mshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/hisilicon,hi3798cv200-dw-mshc.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/mmc/hisilicon,hi3798cv200-dw-mshc.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Hisilicon Hi3798CV200 SoC specific extensions to the Synopsys DWMMC controller
+title: Hisilicon HiSTB SoCs specific extensions to the Synopsys DWMMC controller
 
 maintainers:
   - Yang Xiwen <forbidden405@outlook.com>
@@ -13,6 +13,7 @@ properties:
   compatible:
     enum:
       - hisilicon,hi3798cv200-dw-mshc
+      - hisilicon,hi3798mv200-dw-mshc
 
   reg:
     maxItems: 1
@@ -34,6 +35,15 @@ properties:
       - const: ciu-sample
       - const: ciu-drive
 
+  hisilicon,sap-dll-reg:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: |
+      DWMMC core on Hi3798MV2x SoCs has a delay-locked-loop(DLL) attached to card data input path.
+      It is integrated into CRG core on the SoC and has to be controlled during tuning.
+    items:
+      - description: A phandle pointed to the CRG syscon node
+      - description: Sample DLL register offset in CRG address space
+
 required:
   - compatible
   - reg
@@ -44,6 +54,18 @@ required:
 allOf:
   - $ref: synopsys-dw-mshc-common.yaml#
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: hisilicon,hi3798mv200-dw-mshc
+    then:
+      required:
+        - hisilicon,sap-dll-reg
+    else:
+      properties:
+        hisilicon,sap-dll-reg: false
+
 unevaluatedProperties: false
 
 examples:

-- 
2.43.0


