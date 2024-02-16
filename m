Return-Path: <linux-kernel+bounces-69341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DE2858793
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D4B11F27ACC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EE2146008;
	Fri, 16 Feb 2024 21:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWGva+Ah"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D119139595;
	Fri, 16 Feb 2024 21:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708117351; cv=none; b=HM7a0WogB+4q0sqeLwEhiOdSKqcNdbNa5JGlcHL0pG7SRpvxFCJI38dMYaxN5ZIx12M35xT4pa+iVJN18oXDSGHQH1p0TTTsZUAsNpU91AI+YfprT+X0QKKtTpNWdzhwarD5YhIVPeONXe3b9Dus/AxHLqkBb3WoG6E73mjJ8YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708117351; c=relaxed/simple;
	bh=7wSPhtESvVsFi3grbeSFiB3p/8T4CFcFBTX2JailsS8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rp+DglkIwJQ+o+qMaGbLRvgY/jEF4+B8TvzA2EU2hDBktCeNj6giNuKHihAzW1c0PLCe9xtOeVGMX0zyDIzISokeq/FfsqiIHGCw3UrXQDJRiKj8Gkfrf5KhIN+aH3BMGs8NDrjZ6F8IPyJcP0yPVDihkRFGcTVgu81s5ew4XA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWGva+Ah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD7C8C43330;
	Fri, 16 Feb 2024 21:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708117350;
	bh=7wSPhtESvVsFi3grbeSFiB3p/8T4CFcFBTX2JailsS8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HWGva+AhgQgN3WM79d+JUUrTY0bdho4bZEb42ic2RFGDHqZmuLoDFn5ADWHyHSRPV
	 hXyyRpq0Zc29v6A64/K+4xehE4mn31wqQbDxRQAPX9SAG7J+l/aBtxXQ/afhSPpaOS
	 5Jp3TW9BkmMtJl7UyEYKC7V3hjGx4oRT6qhP3kGOeFvvYMJ/SERY/fblevvas6duBY
	 LOaBuOwIsT9yXvwJkV6WnaU4KB9brhozNqxoBDakQ81BfVbTeRzECllnMA8aAznXxX
	 7C0DfjQWph65+hRHIOLlyocC/D5Nrbr46ZoDAR1rCyRv4l9RWVrfYD/yqfulO8GDr5
	 BmkTtD2vmE+og==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E61FC48BF6;
	Fri, 16 Feb 2024 21:02:30 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Sat, 17 Feb 2024 05:02:32 +0800
Subject: [PATCH v3 4/4] dt-bindings: mmc: hisilicon,hi3798cv200-dw-mshc:
 rename to hisilicon,hi3798-dw-mshc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240217-b4-mmc-hi3798mv200-v3-4-f15464176947@outlook.com>
References: <20240217-b4-mmc-hi3798mv200-v3-0-f15464176947@outlook.com>
In-Reply-To: <20240217-b4-mmc-hi3798mv200-v3-0-f15464176947@outlook.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Igor Opaniuk <igor.opaniuk@linaro.org>, 
 tianshuliang <tianshuliang@hisilicon.com>, David Yang <mmyangfl@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708117349; l=2257;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=4kflwEv+WJmP2PPOQXUMuL9kHf3tVBCROKzZLHhxoCg=;
 b=De+GKfRljIWbAimat2RWpwDanhxiSTNmKJ/2FK/BfGDLvIyapvRs6Ka9et6HFD8QKfOqhoi1p
 YEL4HsJRGaJDvGo93lsCAaT86slCgcRumVlLqwlyYeFC/5ZuUgMpLKI
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
similarity index 73%
rename from Documentation/devicetree/bindings/mmc/hisilicon,hi3798cv200-dw-mshc.yaml
rename to Documentation/devicetree/bindings/mmc/hisilicon,hi3798-dw-mshc.yaml
index f3dc973cb490..26d7f4be965b 100644
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
@@ -34,6 +35,12 @@ properties:
       - const: ciu-sample
       - const: ciu-drive
 
+  hisilicon,sap-dll-reg:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      A phandle points to the sample delay-locked-loop(DLL)
+      syscon node, used for tuning.
+
 required:
   - compatible
   - reg
@@ -44,6 +51,18 @@ required:
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


