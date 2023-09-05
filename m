Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26271792B80
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242760AbjIEQyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352425AbjIEFsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 01:48:19 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC781AD;
        Mon,  4 Sep 2023 22:48:12 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id A8BD040901;
        Tue,  5 Sep 2023 10:48:04 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1693892885; bh=xzBsIM1fOfN3WiR0egrK5klaE/EyIqqTyt08MjK+7GU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=QZDDt0CfQ8beU87Vew+Rncs34gUPN/6Vl/D9/krJ+4SdPlkum8aBB0DAwBtoHFh20
         l6Ek+TMJtfZTxGMUNyYLsgpfByimB7PQsVI+c99IQtsua6K3bPHe+tBAeH1B0B7sq9
         SSCkmxsv4AGVGKxxVQwRiY8V0AyJ1BWtFYkV8K8nRsNx83txS+5aSz2pR655b4sCDH
         UoV9CmhP17e5J0uG7gwlWGLAOYl2pUwYSKl6Z7Io/Hgond9v/iZTDc1dCxjJqsQXdT
         pCXLZJmpT+zn65WW8CNG4GGWcRIo+lmfnSoJshjqJ2bnGjYb4g8q/1R6/2Cx0+idYL
         5wbUAebtPfM5w==
From:   Nikita Travkin <nikita@trvn.ru>
Date:   Tue, 05 Sep 2023 10:47:20 +0500
Subject: [PATCH 1/4] dt-bindings: remoteproc: qcom: sc7180-pas: Add ADSP
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230905-sc7180-adsp-rproc-v1-1-dfea7699da7b@trvn.ru>
References: <20230905-sc7180-adsp-rproc-v1-0-dfea7699da7b@trvn.ru>
In-Reply-To: <20230905-sc7180-adsp-rproc-v1-0-dfea7699da7b@trvn.ru>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     David Wronek <davidwronek@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1140; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=xzBsIM1fOfN3WiR0egrK5klaE/EyIqqTyt08MjK+7GU=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBk9sESW73sc+qIsY8R2iF/ppissAEcRLqnSvQbo
 /FOREoR8ZuJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZPbBEgAKCRBDHOzuKBm/
 df75D/wOi1Z/IX0nTp+322VAZRFpSqt2JXG3TaVFbDzIYddUNb2Dz3Mq0rNHRTmsNz+bgBY4tlg
 1xv3/27xv50ZLJ38fvU6Nq7mP/ARiPyCmNHX0U2LbF6fjhSkDdT3emNfGkHHgRAptPLzaTslNiS
 IYG72fZNzjB4f8jcdE4nsxODcpxnYZ4J/FT1PrLJPazNHOkuL0/u99DxybQPkQ2LIBYp/dWzmHT
 1eDBfKkbPwxqxIeFuTSqyj/HoEPBzcyjUwvHj0z0EXOJHN+pDJi2eEhrVOlImtMQqUFp2xU2v2C
 2X85PnQVlzQtuAzvrh350IDGgtlp+Q01K3ahh/UH0m+PitjTIAUCk4flqOJOC35iSxwZM9nNHGX
 5xaPKg3leybAGoIlnQd8hfs1/6b4jSzPgwJrUBS84eAXVNVVHKnhtxIDk/aK6P9KRZoEIZfFqzA
 P12wZFox7iT8mvEoAB7WmF4Sv2RgfDWbDsMVfTvBXjFa6UEvIBKGBpKx+w4gzqiUbgnnW6TgSs3
 B6zAmSbm8f/FFknyhcvQpq3RnoH6cbCb1rEjo+uDf4XH79OaRmSUWUNyDEJBZyPCpOiiWh3B6QL
 mFUYGQ2jP5bWaFpYOiO4zR58dEN/pBKvsreBfHgd2ekl1vQN/3Q8wXNJhSo4dnyW7kzD7r3XAuP
 PHtp5yBwT25NcsA==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SC7180 has an ADSP remoteproc. Add it's compatible to the bindings.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 .../devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml      | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml
index 689d5d535331..37eeb51b849e 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml
@@ -16,6 +16,7 @@ description:
 properties:
   compatible:
     enum:
+      - qcom,sc7180-adsp-pas
       - qcom,sc7180-mpss-pas
       - qcom,sc7280-mpss-pas
 
@@ -88,6 +89,17 @@ allOf:
           maxItems: 2
         power-domain-names:
           maxItems: 2
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sc7180-adsp-pas
+    then:
+      properties:
+        interrupts:
+          minItems: 5
+        interrupt-names:
+          minItems: 5
 
 unevaluatedProperties: false
 

-- 
2.41.0

