Return-Path: <linux-kernel+bounces-108707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3BF880EF1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E2EE1C21F60
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C113CF7E;
	Wed, 20 Mar 2024 09:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+R/Mv6E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88FC3B794;
	Wed, 20 Mar 2024 09:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710927869; cv=none; b=n/DsxX8fxGdPKTNkbmbVPugTKszcP1qF4E3kNN58PEL2MC4ysbm03vRata7izN78wD1qI79m4CY6zxp/ThJmhZesGhWQNcoxoih3jXbt6VkigeDbqdXbdDGGsV5sPQXEoPZe18qNtEV9gbqzURCgtEjbjm2UOPIffH0RifPq+j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710927869; c=relaxed/simple;
	bh=Uf0CCksxzPh94RRVnornSAILdhxqXP3ccZAL4skjSzw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MXWR3vnoox6rzll5BI+llkNw++ZagIcAch0L/5WhqziMgT3hqAvIppLUZv9EoWfrVj8GWYx8TGPlCyW1IYPpz7qXhBHZnUnER+X/R1Xpw6jzDyxjJos2GWF9cHtdAb0VY48Q9zEJTSKeeQHpmWhriMMPySPkM5gPyTdrm9aCY7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+R/Mv6E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98545C43394;
	Wed, 20 Mar 2024 09:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710927868;
	bh=Uf0CCksxzPh94RRVnornSAILdhxqXP3ccZAL4skjSzw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=i+R/Mv6EMFDPiERKE2XT94eFmGajTCo07nPgECSQHYF08j3VQzrLoLm1h9vnMsPj2
	 hwxYehm5rNYGT5+JnnTHaFfvduTUZnZxiINOuvS/Apgh3jvNqSlCA4u2GrGJYabX9d
	 3NxUtLW/41N3CwmGAQJq+PrQg4S30dFApfH+PBxNRZ+4vXjb/ve7060KdXJc2VU8+h
	 /bXcVKr3O2HoLYru6w/viq7I6v+tKBQJxdYxDi553gicQqTKuZPwvT3WOKFbM/wnwN
	 TRL5ksGryYJypUav/MlJKp0n5h6H50TdN70UQrkIFTDX+TqM1QAnSN7kObNh5TyI/e
	 W/ZaducsFm0Sg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C30CD11DB;
	Wed, 20 Mar 2024 09:44:28 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Wed, 20 Mar 2024 17:44:14 +0800
Subject: [PATCH v2 2/5] dt-bindings: arm: amlogic: add A5 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240320-basic_dt-v2-2-681ecfb23baf@amlogic.com>
References: <20240320-basic_dt-v2-0-681ecfb23baf@amlogic.com>
In-Reply-To: <20240320-basic_dt-v2-0-681ecfb23baf@amlogic.com>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-serial@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710927866; l=1029;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=r0xuqU4Ugjg7+rGvC23MyKK1+DvdlUD+RiCVMa++e2I=;
 b=uUUPeJHApSTFAbpk9atAj5lylvkx6geVJ0wgftmHDcIXC3+zOlKydo3Z9XGmH+wK15238Lica
 XrEMVzrTLoRDpOTZNXpzMrzByUyx5lPlxrmqa2kNnHuSEcHB++wU7S3
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Document the new A5 SoC/board device tree bindings.

Amlogic A5 is an application processor designed for smart audio
and IoT applications.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 520975e7cac0..e64ced44ece8 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -207,6 +207,12 @@ properties:
               - amlogic,ba400
           - const: amlogic,a4
 
+      - description: Boards with the Amlogic A5 A113X2 SoC
+        items:
+          - enum:
+              - amlogic,av400
+          - const: amlogic,a5
+
       - description: Boards with the Amlogic C3 C302X/C308L SoC
         items:
           - enum:

-- 
2.37.1



