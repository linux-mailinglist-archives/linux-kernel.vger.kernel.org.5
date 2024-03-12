Return-Path: <linux-kernel+bounces-100013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8958790C0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 559E01F24EB7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFFE79B80;
	Tue, 12 Mar 2024 09:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kyekibct"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEAB78278;
	Tue, 12 Mar 2024 09:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710235141; cv=none; b=oVQT6PKCsA4jD8yeIgEXCCLA7nW70clQtQHl81hAyOH57au70zz96poryAuRu8M0s2CsktzGxa5kroKbq0eEIAkA1rJaeB1hn2yNpnyc+5TrQNv4fl1SljAxKg+brJxFWoUPWz1Tmm5yUhMdpRtJEVyNTldjl71TmRlaYq9CjP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710235141; c=relaxed/simple;
	bh=K505GhKHcy56JME2WlR5Eyql4DOJ1aVM0Jyv/sRU6Ng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jt5rwSH9jdx25Gz9o1Brc8b0oZUz8ysC1xw6WPtZ5IbGLVb+5Zns+r+veBWGBliA3JyaXzOkrDg6Hf41T1vgRLwqbMn7u0/Szrgp8/EjXtDgBDtFOCGVFxesjDu8CBc+Wm8eaAuqU2yW0ivnsyaMvUuS2xNi/pwWpY88D4WCwdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kyekibct; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0BC1C43390;
	Tue, 12 Mar 2024 09:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710235140;
	bh=K505GhKHcy56JME2WlR5Eyql4DOJ1aVM0Jyv/sRU6Ng=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KyekibctYHT9HzLt2zQc3SmuyEoeh/FRA4OVtGUaBotXGJ7mNOFdHDtFVpcgtXQ8B
	 Dq9ZQ4EBF9cQynni61hklaDMK4iEdjbHgyflZ2K3of57c0wzn23cLHS843hiA3bJuR
	 unaX6jskRMazud9ck/wXuEurn9TBBzeSXSVMwd/BUfJ8Cu/zJA+nCIpdat5ET93m5T
	 C/MV4Mvwu9GcQ9VWkJ11mTm3C0pyrwlRkEKWkyA4xBK14s7L93SDG3OS4GWsyZrQb1
	 Q94n7rySvCpQRHgkmwOeaPWOQFuNibAUAtPSsXAVywcn/TECIDOmgghSSz8X3OkXDT
	 cvQF67HTXM4vw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88AAC54E58;
	Tue, 12 Mar 2024 09:19:00 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Tue, 12 Mar 2024 17:18:58 +0800
Subject: [PATCH 2/4] dt-bindings: arm: amlogic: add A5 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240312-basic_dt-v1-2-7f11df3a0896@amlogic.com>
References: <20240312-basic_dt-v1-0-7f11df3a0896@amlogic.com>
In-Reply-To: <20240312-basic_dt-v1-0-7f11df3a0896@amlogic.com>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710235139; l=998;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=OjYemETinzmeJ9Q4YrGV5qbHibSqK0gJRNB1l5DOrLo=;
 b=tFHNPr2tadjZI0f7yRXUHfGbas/LCBRkjU+cD60xc4dwRmucwJfD80aGFsMz+cb+Z2SBUuaOU
 74GeQ1M93BzDp4bVIzFNNlPxL0TvuH7avkGhY8wfhLiRFYGh5XVTY0l
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received:
 by B4 Relay for xianwei.zhao@amlogic.com/20231208 with auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: <xianwei.zhao@amlogic.com>

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Document the new A5 SoC/board device tree bindings.

Amlogic A5 is an application processor designed for smart audio
and IoT applications.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 9a135fe1c862..6090cb674b65 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -209,6 +209,13 @@ properties:
               - amlogic,ba409
           - const: amlogic,a4
 
+      - description: Boards with the Amlogic A5 A113X2 SoC
+        items:
+          - enum:
+              - amlogic,av400
+              - amlogic,av409
+          - const: amlogic,a5
+
       - description: Boards with the Amlogic C3 C302X/C308L SoC
         items:
           - enum:

-- 
2.37.1


