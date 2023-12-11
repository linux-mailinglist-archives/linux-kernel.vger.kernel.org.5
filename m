Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F049980DAE0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 20:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjLKT2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 14:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjLKT2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 14:28:40 -0500
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CDFCD;
        Mon, 11 Dec 2023 11:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
        t=1702322893; bh=IcWnbFKmnLs2Lnf6xi3WdqGT+icJHz0yV8hz/Qw3KxY=;
        h=From:Date:Subject:To:Cc;
        b=SG7jPbL2RPp32mXDGlC/HP+ZsnROkYZretAssZsS7le/YRguVLsfXpYrCdKQ1zGGU
         ohQE2SiLE/4q8NQHLyv91wlBlVHLZvyJkW14OCg/1YD3BM2H1kzeXYoTY4c7Js5o0N
         2YVSn6OvuxgsvG2/G9xJ/qoyz69sPea2WKfSg7C4=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Mon, 11 Dec 2023 20:28:07 +0100
Subject: [PATCH] dt-bindings: arm: qcom: Fix up htc-memul compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231211-htc-memul-fixup-v1-1-c0aeab5aaf44@z3ntu.xyz>
X-B4-Tracking: v=1; b=H4sIAMZid2UC/x2MSwqAMBDFriKzdsBWUPEq4qLWpx3wR6siFO9uc
 RlCEinACwK1WSSPW4LsWwKVZ2Sd2WawjIlJF7pUWil2p+UV67XwJM91MGyFwZoGU20oVYdHEv+
 x69/3A6C1G+VhAAAA
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1322; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=IcWnbFKmnLs2Lnf6xi3WdqGT+icJHz0yV8hz/Qw3KxY=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBld2LM07F2YQDhLu6I331Mp0c+Qn4XSpfYUmPXT
 xrDRm/ypLmJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZXdizAAKCRBy2EO4nU3X
 VgLeEADZBoBBGg2S3DuDVqPm47Bc+C+1a+jY8EGM+nK5swiTFTqu7xH//AuPNfmvhbkFCqXut9n
 ei6oe/uvmLkpqHcsxDIRYAn1lBouER7pjnWkm0DJkjQcO6y6DS3ZSKcyMstOanLnQjfeEFwypoB
 HvOEwmgJxgPAfRvEFxhAJYZVYqHihVv4VnkV1E/Agan9nF+DBCVtIb5oqHwGDwdoitaB5/D5Awc
 N3lkOZMSq1mBMG0wUwcNJQ9krQZrXa0DQ213jvGJECV0NrDKXuy/Ra/7X+gTsomcNUosjEOG9/r
 LA2+1KR6n8w0+BaGCzIvi23A9oVQ2FGO81QNOF5oB9FEZ5Fcmi7iwNU8YiV7yV8LZ53km9ETgzC
 LKPA9gF4MnAmjC51sJ02lrHvS61i0wa+s8zc0ueG83FiSfe+nUOZlG997dWhjXntLywxG2+Fgv/
 AQpH5tFMmDwvt2eRRSZMbjgLYVWtxrfkNAXT7WCibbA3v/TRNVoOfLFmDz1I9qMPY5Ty8Acuf7J
 zd0lwABBP8pt2EVzcTmC6qjoXIqdnvEw0HVATG74dDiriaUoReb8xHnqMIt0YUsWcREBPWgRWnR
 dO7mDmkNa9TOI9M6SBE3jrKW6CeVDkS3GFpzDCWxVE6KvuLcjjBoAwRNCBcktk921yzyCPBri0Y
 zvlBSG4ate6W1kQ==
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

While applying the original patch, some things got messed up and it
didn't apply to the correct section. Move the compatible to the correct
location to fix that.

Fixes: bfccc195192e ("dt-bindings: arm: qcom: Add HTC One Mini 2")
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index c968412d86b8..96eba7454c82 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -183,6 +183,7 @@ properties:
 
       - items:
           - enum:
+              - htc,memul
               - microsoft,superman-lte
               - microsoft,tesla
           - const: qcom,msm8926
@@ -259,11 +260,6 @@ properties:
           - const: qcom,msm8916-v1-qrd/9-v1
           - const: qcom,msm8916
 
-      - items:
-          - enum:
-              - htc,memul
-          - const: qcom,msm8926
-
       - items:
           - enum:
               - motorola,potter

---
base-commit: fc538f5c65c2c1ac9a1fbea90393bf8e145676f2
change-id: 20231211-htc-memul-fixup-ec6ebca8ef7a

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>

