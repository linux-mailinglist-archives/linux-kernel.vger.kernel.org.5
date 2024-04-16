Return-Path: <linux-kernel+bounces-146132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 528288A612B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 04:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 055701F2312C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 02:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BED210FF;
	Tue, 16 Apr 2024 02:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZ/uc015"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E59171AB;
	Tue, 16 Apr 2024 02:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713235481; cv=none; b=Lbi1tFhe7V0rD3eJZWtlE/27uSHIN1ss5MmGCyxUzK7aTDNIy4ozioB58MrxQ2rjewdVc3gcPulhwhZ722YlKP0aLEDua7bBm8oC5tOh2Y4l7nvKtvmRKx7tl9dRydGM2uwzEDUTPgCGwxWhYL9V8TCOnZHP7jRMgjxGVJ2U0uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713235481; c=relaxed/simple;
	bh=2pSJ5RtkTJUIWZtuMClF1MziyBCDcsQTg8O2HQnpmqY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nc3XQKdxNTUItvCqkMD5hpvJ/gHFP+OusZhQN6lVAyGoYbx7RTHBqaBulsDLhmwgaz/1EuRsalQXpF4VAoL9HD8KtU4pqi9Y95EWcXmWNLlLgW4DUPzfruDxNHPPsBXzI+sMsnB4O+tK5iX7cAckuI8OUbMe7LiMgUfiNOaKbCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZ/uc015; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 60782C4AF08;
	Tue, 16 Apr 2024 02:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713235481;
	bh=2pSJ5RtkTJUIWZtuMClF1MziyBCDcsQTg8O2HQnpmqY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pZ/uc015yVBeGifN//gD3eC++vwiMoBC+d4Fu/1oRAJnpYKyKo74r8c1Fh9RPdZD+
	 p8BC5p9fCywkqTwx/2YMLFOozbWRKHd+I+Kc9DraOcc862pIrf0AV0Gh0aeFn0t3Ns
	 1BVOEOm/VFF2x1zQQGYZCckwCkVlo4UacqtFA/GGpDfSgestjc7bHoux+MW9nTT1w1
	 vnp8r8RvGpAruf6iYJkVlxS/0pZ+z5dAimD9dUdYn56nPgLuU1U7TdLvIzOQmSo4pE
	 SwjyXdd1B+ZowzCRPqU5PJvXSS24Hd3HEvS/M6IdG57l+svMqYHZyQr+6iDhhM98Ya
	 Jxm/LkgIOBwow==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF72C05023;
	Tue, 16 Apr 2024 02:44:41 +0000 (UTC)
From: Fenglin Wu via B4 Relay <devnull+quic_fenglinw.quicinc.com@kernel.org>
Date: Tue, 16 Apr 2024 10:44:33 +0800
Subject: [PATCH v11 2/3] dt-bindings: input: qcom,pm8xxx-vib: add new SPMI
 vibrator module
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-pm8xxx-vibrator-new-design-v11-2-7b1c951e1515@quicinc.com>
References: <20240416-pm8xxx-vibrator-new-design-v11-0-7b1c951e1515@quicinc.com>
In-Reply-To: <20240416-pm8xxx-vibrator-new-design-v11-0-7b1c951e1515@quicinc.com>
To: kernel@quicinc.com, Andy Gross <agross@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Fenglin Wu <quic_fenglinw@quicinc.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713235479; l=1205;
 i=quic_fenglinw@quicinc.com; s=20240327; h=from:subject:message-id;
 bh=SwnogURbBf0S1flEa633BZvpsevy5nBnFae6M+y7bFo=;
 b=MZ3zGU5XnGhBOb+KlzuigAzntA4TFiD47fvC2y/ZHUUw8LA9sAY8PTpvmaIwaGBWMZaNHpKbE
 CLrPtyK9wxzC92qgfaTB4zzRzEVwrxgcfBHpRbsZlOHYj3uo0bf5xwv
X-Developer-Key: i=quic_fenglinw@quicinc.com; a=ed25519;
 pk=BF8SA4IVDk8/EBCwlBehKtn2hp6kipuuAuDAHh9s+K4=
X-Endpoint-Received: by B4 Relay for quic_fenglinw@quicinc.com/20240327
 with auth_id=146
X-Original-From: Fenglin Wu <quic_fenglinw@quicinc.com>
Reply-To: quic_fenglinw@quicinc.com

From: Fenglin Wu <quic_fenglinw@quicinc.com>

Add compatible strings to support vibrator module inside PMI632,
PMI7250B, PM7325B, PM7550BA.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
---
 .../devicetree/bindings/input/qcom,pm8xxx-vib.yaml       | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml b/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml
index c8832cd0d7da..2025d6a5423e 100644
--- a/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml
+++ b/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml
@@ -11,10 +11,18 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - qcom,pm8058-vib
-      - qcom,pm8916-vib
-      - qcom,pm8921-vib
+    oneOf:
+      - enum:
+          - qcom,pm8058-vib
+          - qcom,pm8916-vib
+          - qcom,pm8921-vib
+          - qcom,pmi632-vib
+      - items:
+          - enum:
+              - qcom,pm7250b-vib
+              - qcom,pm7325b-vib
+              - qcom,pm7550ba-vib
+          - const: qcom,pmi632-vib
 
   reg:
     maxItems: 1

-- 
2.25.1



