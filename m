Return-Path: <linux-kernel+bounces-159069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAB28B28E6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A28BD1F23D65
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2A0152DE6;
	Thu, 25 Apr 2024 19:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="YFYyARut"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7A614F9EA;
	Thu, 25 Apr 2024 19:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714072505; cv=none; b=m2ZXfu5Cwwj5SMdz9JqKQlM+8q9j/KcME3Jk0D63bxzw3/uoYimKuLxNyQ//JuQgmMZZ51Fk9VMvYaLORdxtAE5d/AZeR9YwOsdm0KQ7LVPy1MIGtCLxG+KiJyFK+oz16An3cUGOHR3+WPK4TKV5zde6wjduKQYOUL7IgMqRl1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714072505; c=relaxed/simple;
	bh=AQfbI7vOuFm8YP/Xkec/49RruMYlAkAUez61BlDr6HQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lFWcsOmyPJgdSjtAqVr0ZiW1V/+IV2sa6yorXouGs430PzTs7Z1Kp3Dp9qhoi5yrnrgXw6AG9FDhGmxmlY8uYnCgog5mASKC+E10Dt1zA8Y/TeYZCgVg+uXVWXxviCRqbNSwlQqJMnizQ5EbizYlnUi3OkYmfv0Th2tt6jmkbQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=YFYyARut; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1714072502; bh=AQfbI7vOuFm8YP/Xkec/49RruMYlAkAUez61BlDr6HQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YFYyARutU8agXJa2F8fjT4vlV8GvAQZj8i237mYGywFyCEOkAOHmzNmeNHpSB6MT5
	 piRR7jY+knRYcMgkwHFupGeajR7pKnpY4x2+KkD9xy4Z0YbF0wJoY1zTqoFhkBfj72
	 1YbW1suYm7lF94KgnRPjLsDKXS+hHo7/dFgPfDJE=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Thu, 25 Apr 2024 21:14:31 +0200
Subject: [PATCH 2/2] dt-bindings: soc: qcom,smp2p: Mark qcom,ipc as
 deprecated
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240425-qcom-ipc-deprecate-v1-2-a8d8034253ea@z3ntu.xyz>
References: <20240425-qcom-ipc-deprecate-v1-0-a8d8034253ea@z3ntu.xyz>
In-Reply-To: <20240425-qcom-ipc-deprecate-v1-0-a8d8034253ea@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Andy Gross <agross@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1179; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=AQfbI7vOuFm8YP/Xkec/49RruMYlAkAUez61BlDr6HQ=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBmKqu0A0raTWi5QiSyZMZPNUcsBx00rHW6j1Es1
 wsMpEQlTC2JAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZiqrtAAKCRBy2EO4nU3X
 VtU9D/9+qWpTms/tpH8LMz8s6RPt7yhwX/HudrWqZdPNLIVhqzjbTjoSjFVFgwhv2jMMQrp78ps
 Vogq2hWhGvvKsuygor7Aa2BpqIABh1RzBB24sUhAH4Nxl3jv2Gt8BJ5y/9BTpwPnVMSB6DQPYKJ
 qKuTIK1t0yBAOx0jF3VMPi5STLwX9uAOj0NgR1Kz85m9kymTVbC8l2RUU/rq22acEihMFvvUUjS
 1U1QMSU28MAFHJKTjLL7LwkBDaVckuKeA/pcMjb9i8pFwmZwWGT2rJHvL3wJkT0l0KV9w6eUhNb
 nEqGxaDmoKmxNOhHlOyRFq7+9ZCcbQsMHKl9tXG/ABh8FmLk3CxK5dP/ekz39n/rvTLRg+ca5I1
 pxTys4uLWVF33vZ6AvbB9xkqJoBluYLMyO4qFXzxANjPBAiOUrNr2ditDlr6tWKeQ1Z2ZTH7uXT
 vqI3JGQv4p3dfU/MzS9kt6DzJhXDPdR8EylUcbPo8WqVLoxLrSkjL39cENJ6KKcdJEcx/eSRZQP
 gWZQnsQYZyMjNclhY8gs8tQEcZHmTB3aXYybcSqOcPrFYxuvNQlIGzMfTME4ImgUvWp/BNuCLgj
 g8tKlcAoh9pd/YhOuU7Rkhv/HuVwHTo24Q9j5G0p6jQcAEU0537WmhNbcE50gEltBbSV3cHMWRs
 eov2tS+j/EhNQ2w==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Deprecate the qcom,ipc way of accessing the mailbox in favor of the
'mboxes' property.

Update the example to use mboxes.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.yaml
index 58500529b90f..141d666dc3f7 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.yaml
@@ -41,6 +41,7 @@ properties:
     description:
       Three entries specifying the outgoing ipc bit used for signaling the
       remote end of the smp2p edge.
+    deprecated: true
 
   qcom,local-pid:
     $ref: /schemas/types.yaml#/definitions/uint32
@@ -128,7 +129,7 @@ examples:
         compatible = "qcom,smp2p";
         qcom,smem = <431>, <451>;
         interrupts = <GIC_SPI 143 IRQ_TYPE_EDGE_RISING>;
-        qcom,ipc = <&apcs 8 18>;
+        mboxes = <&apcs 18>;
         qcom,local-pid = <0>;
         qcom,remote-pid = <4>;
 

-- 
2.44.0


