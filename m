Return-Path: <linux-kernel+bounces-71874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A651E85AC19
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D917C1C219DF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB105467B;
	Mon, 19 Feb 2024 19:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAW8qajl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB9F5102D;
	Mon, 19 Feb 2024 19:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708371253; cv=none; b=iqn2DsuYQfVfCj38ogydpHrWnq6CH1raZ1rNFkC2BlN5YcfZGBtNWYNuQIrKDEyOfwSxEkB9yoQHvrkAZjOiMn6jZxN5pLg4kJF+prflu+Iry7cK6+Y9T5UkIsczGOrD9OcOpxT40vB/ACC8oEne9Ohnu2hppuVi9oh80Emzj1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708371253; c=relaxed/simple;
	bh=p6+1tqqWDZwzdUra2QRKbjRNGp3f/KqSAz89kRe+CHA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EIESAelw93gXmhnN8rYt2K7hFaZSiTUfwi+nrnffaA6pDhVZZP4iNkOvoBB3MeTHRYPZUVxJ1qfQ1yzbnLVTB9htvoYJlQhrSCl2ciEU4YRcEgYoSy8gxRSdk4TifQIE73Rcn7iHA8HigxMLX4DKoLonfsmjg5XpRtACibEvsXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAW8qajl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D437AC43609;
	Mon, 19 Feb 2024 19:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708371252;
	bh=p6+1tqqWDZwzdUra2QRKbjRNGp3f/KqSAz89kRe+CHA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eAW8qajljM+6imqA5sHPO2YZ50g9EFlN/aQ/Lke471PCIOvvzKwWTsZipvaUA7sNG
	 5SXBrlMfd2yB0spNFja59WiWelyJB8T43MLIHnf8fxElzzivkryDQjcwoM3xd6UCV1
	 ZMUGHHlrFwJQNRmSTi87+9kRt0fES2ksCzb4RzYqFzNONOcRzTWJoryx/1awMouruQ
	 DmmykAYMqobs50p3n9RnldWR9pE4yAULqsC8zFuXeCdsPtAbiWPgspK3PH6c5zTmrs
	 +Z521ij0mG30qWo1wrUdXNzts4YScZrg1V4nrvCmUpQYGXP3EfzbdWFWq62JT8f9Qh
	 7kDjQFCWA+dmA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C4FC48BF8;
	Mon, 19 Feb 2024 19:34:12 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Tue, 20 Feb 2024 03:34:16 +0800
Subject: [PATCH v5 5/5] dt-bindings: mmc: hisilicon,hi3798cv200-dw-mshc:
 add Hi3798MV200 binding
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-b4-mmc-hi3798mv200-v5-5-f506c55f8e43@outlook.com>
References: <20240220-b4-mmc-hi3798mv200-v5-0-f506c55f8e43@outlook.com>
In-Reply-To: <20240220-b4-mmc-hi3798mv200-v5-0-f506c55f8e43@outlook.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Igor Opaniuk <igor.opaniuk@linaro.org>, 
 tianshuliang <tianshuliang@hisilicon.com>, David Yang <mmyangfl@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708371252; l=2176;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=81ECSc1YzJgi6TVlBpCQAnGtw6DZilzIAOBsgMBQcb8=;
 b=++/uUq9V+SUxuC4pFVSCQq7u5QQ8lqaMQLhj6KrnmbC5zg5Gq4/WCOeMsEnVVwzhCQhd7ACzU
 xDAtwZQT/DSC2DeFWIUgBQDnK1axjUOGbyidAcWbImgSQIFXcYBNw7A
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

Add binding and an extra property for Hi3798MV200 DWMMC specific extension.

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


