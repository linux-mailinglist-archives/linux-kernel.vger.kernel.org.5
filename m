Return-Path: <linux-kernel+bounces-32013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5032E835547
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 11:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 834C81C215DE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 10:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1D636AF2;
	Sun, 21 Jan 2024 10:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="PKsohBEF"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07BA12E59;
	Sun, 21 Jan 2024 10:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705833650; cv=none; b=bQ5n7SaXQ1EwbZVQsJbmMvIoK6IvmbHdC+Z1tr+seE3JXrPHiX2sbHahjlwSfnpN+/7YiJME6CHCRq/3KNdWzdfGP5gsoy991URlnmhHhV0bWtcxaW5uf8YylBBv4JtHDcfUiXTyPGRzbLAJnqvSSJlaMcJf7CkESkx2YbSoHco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705833650; c=relaxed/simple;
	bh=v1/V8yxynbgaJGBY5IHCbJPMSnPaAg0Cc58Fpy0/0eM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eZOZfkv9NJB4jScSAiNEhS0a+U9YHsQAaTPplXRV2n/wuNeEdTIECKAgkt34Ka/6FROjuxHXAO69H/2hsw05qRn9u6zjlDYKmmOPLvGhcmYWhcGpOI+8KZyWGItRzsSxD43qIRNzvf9P6dS0uqZi0gRcy9cgCIwfs8b/aog+eVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=PKsohBEF; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1705833646; bh=v1/V8yxynbgaJGBY5IHCbJPMSnPaAg0Cc58Fpy0/0eM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PKsohBEFeSSc51TOewqkghUWEmTiL3f2nXI/71JcyM/OCu/midFeDoZ+L+MMwouY/
	 NjUMcTdbNktnieiIlDM+YoOJdVLUQrL7/vumVaHrxVhE8aR6Fov5qMY1JoU92T3rI8
	 YbCNu4ufrqyO8sAhY+U3SwKU3RnFknTPjnOCYQY8=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Sun, 21 Jan 2024 11:40:38 +0100
Subject: [PATCH v2 1/2] dt-bindings: display/msm: gpu: Allow multiple
 digits for patchid
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240121-msm8226-gpu-v2-1-77f4a6fbbca4@z3ntu.xyz>
References: <20240121-msm8226-gpu-v2-0-77f4a6fbbca4@z3ntu.xyz>
In-Reply-To: <20240121-msm8226-gpu-v2-0-77f4a6fbbca4@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1665; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=v1/V8yxynbgaJGBY5IHCbJPMSnPaAg0Cc58Fpy0/0eM=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlrPSrBqo6O3RxUO+wPi4zf0JipGyXEKiNmkwKe
 i/xAsC3PFSJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZaz0qwAKCRBy2EO4nU3X
 VqKnEADKPbwniYpsgch1XFFVEdcdVqCqWvfqfgzCUAC6QlHDcMs/JQ4JNq8w7owtiRCkOT0Bhpa
 FGNC1zPT6Ze991JA9l2l17Q4xrwAOYwpcx11zBhx0Ad10WUOuUav6U8HSm+nyKUYcE/n78tQGLF
 uXvS4ezPoVqfqQuo9/lXp3x5K5pbcLNa1JKVEDM09Zksycl/CyF/909l9TrioZsBykUpwVpyCJD
 NlOIhACuKFFGJCbID9QKld1xz6pDYZp56kmSvMogd370qw1WV2F6kB+/5kY9tNJBLoQ487pIdIS
 xxzIpB2NZliygoJ/ecX56KhalRPCP9lMauMoPXo4q+1zeVGCEJ21vvUWK6S/69xOHTCghrXOkzx
 CPxkp7A68PpRpLBBWtW4e0Rle/wq19nBUmb8dVxGgqxNWl7y2u2O/7v1jsOwGsZkkewFeA64/aY
 5txGENH2xGzbLF0CwlDkaqiVuzjjnsHzng6VbiDL8FMKZLwAavjVzXY6k/tU5uzZXfbyM2Ahuzq
 0gNppMEnK3mea3yMho+WdHGAn8lKsEYxbd2Acz2+exI63SYfj9WLQgU1RIjgxBG6XUrA2BLuWe+
 QIVO/dLBe3JbW4bU8ZpFpX6jCpkWME9rg2N29fdvae7Osi1D3iNnjvpIJKzqaMEvu1WNZokZd/M
 d2NbOTPbdlo3gYw==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Some GPUs like the Adreno A305B has a patchid higher than 9, in this
case 18. Make sure the regexes can account for that.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 Documentation/devicetree/bindings/display/msm/gpu.yaml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
index b019db954793..40b5c6bd11f8 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
@@ -23,7 +23,7 @@ properties:
           The driver is parsing the compat string for Adreno to
           figure out the gpu-id and patch level.
         items:
-          - pattern: '^qcom,adreno-[3-7][0-9][0-9]\.[0-9]$'
+          - pattern: '^qcom,adreno-[3-7][0-9][0-9]\.[0-9]+$'
           - const: qcom,adreno
       - description: |
           The driver is parsing the compat string for Imageon to
@@ -127,7 +127,7 @@ allOf:
       properties:
         compatible:
           contains:
-            pattern: '^qcom,adreno-[3-5][0-9][0-9]\.[0-9]$'
+            pattern: '^qcom,adreno-[3-5][0-9][0-9]\.[0-9]+$'
 
     then:
       properties:
@@ -203,7 +203,7 @@ allOf:
         properties:
           compatible:
             contains:
-              pattern: '^qcom,adreno-[67][0-9][0-9]\.[0-9]$'
+              pattern: '^qcom,adreno-[67][0-9][0-9]\.[0-9]+$'
 
       then: # Starting with A6xx, the clocks are usually defined in the GMU node
         properties:

-- 
2.43.0


