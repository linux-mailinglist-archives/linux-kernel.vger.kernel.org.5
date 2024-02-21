Return-Path: <linux-kernel+bounces-74718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E45BD85D82D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D43E282ED1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E516077A05;
	Wed, 21 Feb 2024 12:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J060MfgN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6654C69972;
	Wed, 21 Feb 2024 12:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708519547; cv=none; b=u6HbRW187W2YTKbnOMT/eou1JajGunm2BFhPljFD6W/RpGFoMb2ZITM7F33Mb7iwA5sGOKT9dek4iRB18LH0pz1uXAbHocqLmaelJ5uu6BMKncW0aVWjd0pMG7+QMSUF75zIq3d3szRewHbnv2BjCLvuPvmy0mee5Jk/RmYacf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708519547; c=relaxed/simple;
	bh=slgj3guZ6Z9tOfsaZHVxvfSZgSTNkEptvrY2Lok1/e8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uYvk+i4JxBQWpUcAF26Qsq0wpijyAFlSGUE7463WRpFTh6qkouHT4IjcrQwzRUkEg5opmsXhGvXzBFLQBK8yWH5Z1Wcp8pJap510MD9T0ms8ouDuNnrne95KuCLKNCFetqkH76eeY2xMZElSAxZqRqlQ129YCYpNabrdvivjzSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J060MfgN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE33BC43142;
	Wed, 21 Feb 2024 12:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708519546;
	bh=slgj3guZ6Z9tOfsaZHVxvfSZgSTNkEptvrY2Lok1/e8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=J060MfgNWnyH6t7fMrDe63PNcB+jYf+SlsfWghOUKuj5o3bpDBfjiQzxh43k2a9sN
	 BUZKrs3VuHHv41PHOt94sUsjeOWy3uPJipNkGIlyghR9fEyFBgrj3k0Wq1pF0P36rO
	 oZ+YJwXKJSNVQgzXdOa413V2sQtO5p6F0f25yfylHpJuV6UN1Kq+eMzGkxpjSXumL3
	 VMuBzHVqpDyo6Prhuuc8FlaiAgYcknIjPGkhwlsQb51lyp3/007wjL5TYBM0pRha5p
	 vcmhZbJ2JbGaK72oQIPNHFAjczoCMCklkJ/NY68AWXiqP4LPjQp5d0jx8iJT8cY5rA
	 XHiw594+f+0aw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC85C54788;
	Wed, 21 Feb 2024 12:45:46 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Wed, 21 Feb 2024 20:45:07 +0800
Subject: [PATCH v6 5/5] dt-bindings: mmc: hisilicon,hi3798cv200-dw-mshc:
 add Hi3798MV200 binding
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-b4-mmc-hi3798mv200-v6-5-bc41bf6a9769@outlook.com>
References: <20240221-b4-mmc-hi3798mv200-v6-0-bc41bf6a9769@outlook.com>
In-Reply-To: <20240221-b4-mmc-hi3798mv200-v6-0-bc41bf6a9769@outlook.com>
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
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708519512; l=2243;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=MbI2PnDc478+pXDtiAiOl4Pgtl4uv4VM2qKM2Aj02Fo=;
 b=GHMbA+ui0CZj/9PA7UQN3DitGiodD7rPMA/G2T+/6k889MCtJfDNBOILA23c67nIXdiMtFMi1
 ZGxs43UDR1XBsZqvNwDSQhf3xL/qcNTIDouoxGrfuDym3cYcwLcCepn
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
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


