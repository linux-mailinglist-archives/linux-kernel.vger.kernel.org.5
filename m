Return-Path: <linux-kernel+bounces-50659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9423B847C35
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 514992873CF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECD185951;
	Fri,  2 Feb 2024 22:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZcZF5FC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04529126F13;
	Fri,  2 Feb 2024 22:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706912627; cv=none; b=YDKeO6Wi/YloC6andN0tJJkcXnPLcJyZQncy+wxepuBBxs3NPWqUNJhwwDFyOp2xweImhvqaowvAqaAYxReoervupzPaUPjdhIsKYLzjdts9BZEkkWLQwGjalsOG/QcLKpZJTnsruIRlhIyNUjUNNOFFSWfsJ9LT4qr2kY5b8cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706912627; c=relaxed/simple;
	bh=i6HTJL8JbdO5UqIMmgRXK3anSEPC7g7b+u7MrObSAV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NnIpo8BRqs+B+Tsw1LjIsuwragvpYQ4Ah0K86Byt8x0zHcvWmtgnp5pvjjo2wHXbH6MU2LenQ1mdaY1M91bpteMC1x3w+egX7Xh3E9O+bVZS4DanwZSzx95jFo1oWo3mIgSiPdHmZFFnVrdyjkmWMleugoT+zRBu2pVPCA7Tues=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZcZF5FC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A36C433F1;
	Fri,  2 Feb 2024 22:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706912626;
	bh=i6HTJL8JbdO5UqIMmgRXK3anSEPC7g7b+u7MrObSAV8=;
	h=From:To:Cc:Subject:Date:From;
	b=pZcZF5FCtJ5ITHsbrc3oU/pZ0o6uEqFEBROR5ZSS91loikQQ9by3Xuq3vvw/Dx0Qk
	 dIBlokjekYfIQNlM+9iY/XUdDf14tQ/7EvM2IeH3Vuj/p5hhcvMDCX/B9SVOwoijOe
	 XdQGQwWbj9DV+27iULWTVMGn5/a67cOwrOcaer1G3s2Ah4yzfrAHxZPwHdaWxB5liW
	 AyJm9looJMfG51bpg1nO6Dwl+eWbyRDNKA4MA4c2PG6VGTOFYCRN6xxODl6Dx/hUWY
	 rEAUasy0h+CiOrUQCAokDSPGsa29MMC9EHH37jq9mcT4tRZs9NvLD7bcZfV3OK7mYd
	 d2zBYRv1d47Ug==
From: Rob Herring <robh@kernel.org>
To: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: display: msm: sm8650-mdss: Add missing explicit "additionalProperties"
Date: Fri,  2 Feb 2024 16:23:37 -0600
Message-ID: <20240202222338.1652333-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to check schemas for missing additionalProperties or
unevaluatedProperties, cases allowing extra properties must be explicit.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/display/msm/qcom,sm8650-mdss.yaml     | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-mdss.yaml
index bd11119dc93d..24cece1e888b 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-mdss.yaml
@@ -37,18 +37,21 @@ properties:
 patternProperties:
   "^display-controller@[0-9a-f]+$":
     type: object
+    additionalProperties: true
     properties:
       compatible:
         const: qcom,sm8650-dpu
 
   "^displayport-controller@[0-9a-f]+$":
     type: object
+    additionalProperties: true
     properties:
       compatible:
         const: qcom,sm8650-dp
 
   "^dsi@[0-9a-f]+$":
     type: object
+    additionalProperties: true
     properties:
       compatible:
         items:
@@ -57,6 +60,7 @@ patternProperties:
 
   "^phy@[0-9a-f]+$":
     type: object
+    additionalProperties: true
     properties:
       compatible:
         const: qcom,sm8650-dsi-phy-4nm
-- 
2.43.0


