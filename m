Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AB87FFCAB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 21:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376331AbjK3UgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 15:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235230AbjK3UgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 15:36:17 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28151711;
        Thu, 30 Nov 2023 12:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1701376551; bh=nY/0hZ0vbbp5essvoHc9RPwquuPPV/hhuX4M/ILLoBg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=HjoylWL56fHHxWhyiE7ZatEflLDYE4QsowWU8OQQByvLS/vnmDZ0VIGOgIsPaGPL0
         cJEG5wgLZuddVrH1fFnuwGNgjOHJnOhCiMEV4MO5Z5mka3D9r+tr8HxqQPNnAAHtEO
         KXYc/ByGmHEHY3/FC9x2HWY4HxA9oNqra8gGFijA=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Thu, 30 Nov 2023 21:35:18 +0100
Subject: [PATCH 1/3] dt-bindings: display/msm: gpu: Allow multiple digits
 for patchid
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231130-msm8226-gpu-v1-1-6bb2f1b29e49@z3ntu.xyz>
References: <20231130-msm8226-gpu-v1-0-6bb2f1b29e49@z3ntu.xyz>
In-Reply-To: <20231130-msm8226-gpu-v1-0-6bb2f1b29e49@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1601; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=nY/0hZ0vbbp5essvoHc9RPwquuPPV/hhuX4M/ILLoBg=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlaPIjw29rzB3cz5ouVOoxkcS+NBvkjHoAp+gt2
 UWmf44YseaJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZWjyIwAKCRBy2EO4nU3X
 VpRID/9+c4nm+yEPLys+ExztX9UG058g7gQqCt53lQE5FB/PKvaSLDVkOGSFQ/YEP6ok1b6z4cn
 gWaVQgcYEuHW0tQRsnQt50QtnAZjwrl0jUADvprNfgwYm+IPtBJJ09uD5SZ2jvwdIV2yRnPyH2R
 ixuEe3WettFHn2yC4f6l17IprAkqX/8oKuXPWfP7DbJBHQpgjPZjyN9x45cQdhkxgd0RuW2rXMf
 9hbn4wb1Gx5/4azzPUuY292RseAgLJ8kd4w+AFYMOlRQGLhrLtSQrchzPiObWOtRykWuOSD5ACA
 pSXDusC6eaQGDwUhe6ISkYP0yTvWH5lPVXKYJFnpYZcqSbh2OkGs6OUkU9xZFsmxsuUKlTJNuhD
 V67dBM0bM8oSKXRxxD1OyYjSU2oT3kuWPoTffUBJA8zcghR3hGnmxzpIUcwxz+ktTCABxeIOACI
 W+M5QnzVB5LvGe8HNuCQ4n4Qb6dkM9v7KXdm17EP4rfJ+XmjILliMLWghEGb4sDxTZmvHJpsxRj
 A+37XigPxizhtjjtlTmcDNTZsJPBREmtUXD0cEzASfzUT/NyJA1uPK1KdC7sklaawoCUj6F86Vq
 hjI61KS8/Q6RWBp8ozsnNi9AcwyfFZH0Ex2Dc1C02iuyxI9VhZlrpjBAibX3Zj8vEfkvGMx+pOP
 xkgm7dBT3u91FuA==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some GPUs like the Adreno A305B has a patchid higher than 9, in this
case 18. Make sure the regexes can account for that.

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

