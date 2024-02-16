Return-Path: <linux-kernel+bounces-68455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7FE857A75
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98F3A1C219AC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529EB537E8;
	Fri, 16 Feb 2024 10:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4+48+Mg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764102420B;
	Fri, 16 Feb 2024 10:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708079897; cv=none; b=B8jZW7AGS65JJpf0seP7jMSolzropuN/zyD0VvpbJgh+FAwghr+7ND7KsVKYrmS4bFemlpkBAC5n06OvYGTfzPY4hLRvi536CSvLuzCkcV0YSVkkYCg1c4aynaKE+Hv310JO5+HgIiw7oRTbL64ppEvsqVFlxXlktXh5wZ6gupQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708079897; c=relaxed/simple;
	bh=Fnl66XIdTuTujJvG94gIbuUBXgbzthzRybPY5BhJBaM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cgZ5iQVnrZOH85t5Nhcb3ULr8CT15QxUlG8FZLTrP5ox8ZZPdQOv/xmOV7V4+hQUymPwpXgzlp2L4meLZi79+sk1kWn4YrM5zB+1KI4F4vn/FyJomH6nONYPBkZEexvKPBCj2Je1mlAPzan8FcAqojKwnvjdkID2Un3ZdIf4jPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4+48+Mg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25D2DC433B2;
	Fri, 16 Feb 2024 10:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708079897;
	bh=Fnl66XIdTuTujJvG94gIbuUBXgbzthzRybPY5BhJBaM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=A4+48+MgXiN7ROeAtDlQe4IZ3tUsvZWrCbyVOae36hy97/Qmmks8YVtygMzuDSVNt
	 96ZPO8JiNPwnPi+bQgrkew8cmhSMIy/83ngVnT3OeHubS4XrpkeY6XuBrdLcdhuOPb
	 sivP/sSNW1YHIkyhqDZ8yGC9FtPwLmHq8E7A4aVCX8GV9/OZWMQznD+HJ+BDV/ypF7
	 az/wAusDJcmNYTYLvy5JYEURtBgpfbbZvYiemKkQLJdRIAqKtytcmwzw9tJerd1Tfl
	 3XbVexKPCcmEM7zYoqwdAQuNV4hi0QLAwZPNmM8yKKTbKwg7CJS85HtF8WNYazCS6z
	 EHOaQbTx2Fzag==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106D5C48BF0;
	Fri, 16 Feb 2024 10:38:17 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 16 Feb 2024 18:38:02 +0800
Subject: [PATCH v2 4/4] dt-bindings: mmc: hisilicon,hi3798cv200-dw-mshc:
 rename to hisilicon,hi3798-dw-mshc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-b4-mmc-hi3798mv200-v2-4-010d63e6a1d5@outlook.com>
References: <20240216-b4-mmc-hi3798mv200-v2-0-010d63e6a1d5@outlook.com>
In-Reply-To: <20240216-b4-mmc-hi3798mv200-v2-0-010d63e6a1d5@outlook.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Igor Opaniuk <igor.opaniuk@linaro.org>, 
 tianshuliang <tianshuliang@hisilicon.com>, David Yang <mmyangfl@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708079892; l=2283;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=kbi5FiKSJPRArZ3uAhDN7VM2vSOYaKQB8k6gKCbl5lY=;
 b=k/a9QOutIn7Yn4Rf3eI4U8VrmPHMOdoDmcUyNR5dlRlz82ncGmwrfS5NhMFVR2mVGoMsgMI2h
 2a0vPqqp9nsBnPkplBqcTxeNuNhfT8c2HZgssgqr5jjzb4c5DogUlTL
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
 ...-dw-mshc.yaml => hisilicon,hi3798-dw-mshc.yaml} | 23 ++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/hisilicon,hi3798cv200-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/hisilicon,hi3798-dw-mshc.yaml
similarity index 72%
rename from Documentation/devicetree/bindings/mmc/hisilicon,hi3798cv200-dw-mshc.yaml
rename to Documentation/devicetree/bindings/mmc/hisilicon,hi3798-dw-mshc.yaml
index 9db85a0fa41c..1b5c2a49a2eb 100644
--- a/Documentation/devicetree/bindings/mmc/hisilicon,hi3798cv200-dw-mshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/hisilicon,hi3798-dw-mshc.yaml
@@ -1,10 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/mmc/hisilicon,hi3798cv200-dw-mshc.yaml#
+$id: http://devicetree.org/schemas/mmc/hisilicon,hi3798-dw-mshc.yaml#
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
@@ -32,6 +33,12 @@ properties:
       - const: ciu-drive
         description: card input driving phase clock
 
+  hisilicon,sap-dll-reg:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      A phandle points to the sample delay-locked-loop(DLL)
+      syscon node, used for tuning.
+
 required:
   - compatible
   - reg
@@ -42,6 +49,18 @@ required:
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


