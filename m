Return-Path: <linux-kernel+bounces-140093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5E58A0B5A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 787321C20BA1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742331482E6;
	Thu, 11 Apr 2024 08:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1TxZ7Hj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85751146A8C;
	Thu, 11 Apr 2024 08:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712824327; cv=none; b=B15EfP+EVwq5ATgkUiQk5w7EgoPiY07NS+EFTr/FcqS2BjUobGpJVrB200UEtlpaiHgD8Ifq1DQ0vbLBI4tFTCqJF6jrTLmWFsAi1667Zb7dMGlqMKtgupovcYcaqVoKFUbJUDd6c9/H3u3YRP008+L+4K0ki0z8veXbVWVBqd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712824327; c=relaxed/simple;
	bh=2pSJ5RtkTJUIWZtuMClF1MziyBCDcsQTg8O2HQnpmqY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CLNAf0XdTokiSDTujS6ROgM9bzUbJYHFTNTxN4F24JBZFlWzR5+99wweW1ekwd3bpu3nu2t/qbvsLzxmxHL1BT4FZ6geJM9IX990UVn60temrYE+he17JV3jd29xUQ3SRBriI5Og3xlwp06sDjBpmg02r/D+k+K0SRZDvwUh7sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1TxZ7Hj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07894C433B1;
	Thu, 11 Apr 2024 08:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712824327;
	bh=2pSJ5RtkTJUIWZtuMClF1MziyBCDcsQTg8O2HQnpmqY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=A1TxZ7Hj6II42OysevajMY6o3hNAwyYleYDBdZEJReniV5AypzzOQ6MqUcBOAztKF
	 +qjckBplSIC2GlQeLqHX0CqnEb9S1JjeW8jblQeahn82NWoQtaH4TGQIbYNLff9PK2
	 l/D/S+++UbRvRWEYxkK27aPgdSSePgwqhVD0RIIgz0gwBun+km6ulnWKR/4RuxygaJ
	 fLzrAb7GLWc8jNidp+Hm5rX62dvtKUkduKjRr2+X9wsCqYxALfChIVntyFyJ6KxMtC
	 b0ZaxEjGnqufpLpHd7+rFkNTUOJGLHkOhJWviQyZ2RKOxS/xCj2t3U9QtPRvoUYdXs
	 sVhtsgvcGVszA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED88ACD128A;
	Thu, 11 Apr 2024 08:32:06 +0000 (UTC)
From: Fenglin Wu via B4 Relay <devnull+quic_fenglinw.quicinc.com@kernel.org>
Date: Thu, 11 Apr 2024 16:30:59 +0800
Subject: [PATCH v9 3/4] dt-bindings: input: qcom,pm8xxx-vib: add new SPMI
 vibrator module
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-pm8xxx-vibrator-new-design-v9-3-7bf56cb92b28@quicinc.com>
References: <20240411-pm8xxx-vibrator-new-design-v9-0-7bf56cb92b28@quicinc.com>
In-Reply-To: <20240411-pm8xxx-vibrator-new-design-v9-0-7bf56cb92b28@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712824325; l=1205;
 i=quic_fenglinw@quicinc.com; s=20240327; h=from:subject:message-id;
 bh=SwnogURbBf0S1flEa633BZvpsevy5nBnFae6M+y7bFo=;
 b=2lEkdbrPEw81OD95Z9DZiCTOC2ragbnwcYnsSVGs1egINyGATNjqy2mHHE0QtSL+ecbEecMkS
 y89PApfOMQZBPW+RwXtdMVhKLa9oUfFCOlvrJ8h/v5ifPQ+w12GtZPz
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



