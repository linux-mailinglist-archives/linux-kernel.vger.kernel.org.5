Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6FD775E31A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 18:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjGWQI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 12:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjGWQIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 12:08:49 -0400
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [5.144.164.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B728BE74;
        Sun, 23 Jul 2023 09:08:47 -0700 (PDT)
Received: from Marijn-Arch-PC.localdomain (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 1DEC53F1DE;
        Sun, 23 Jul 2023 18:08:45 +0200 (CEST)
From:   Marijn Suijten <marijn.suijten@somainline.org>
Date:   Sun, 23 Jul 2023 18:08:42 +0200
Subject: [PATCH v4 04/17] dt-bindings: display/msm: Remove DSI1 ports from
 SM6350/SM6375 example
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230723-sm6125-dpu-v4-4-a3f287dd6c07@somainline.org>
References: <20230723-sm6125-dpu-v4-0-a3f287dd6c07@somainline.org>
In-Reply-To: <20230723-sm6125-dpu-v4-0-a3f287dd6c07@somainline.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, Lux Aliaga <they@mint.lgbt>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both SM6350 and SM6375 support only a single DSI link, and don't have a
corresponding dsi1 node in DTS.  Their examples should not suggest an
output interface port on the display-controller node to this inexistant
DSI host, with a dsi1_in label reference that doesn't exist in the
example either.

Fixes: 3b7502b0c205 ("dt-bindings: display/msm: Add SM6350 MDSS")
Fixes: 2a5c1021bc77 ("dt-bindings: display/msm: Add SM6375 MDSS")
Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 .../devicetree/bindings/display/msm/qcom,sm6350-mdss.yaml          | 7 -------
 .../devicetree/bindings/display/msm/qcom,sm6375-mdss.yaml          | 7 -------
 2 files changed, 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6350-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6350-mdss.yaml
index ed0ad194d4ce..63962a8f2faf 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm6350-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6350-mdss.yaml
@@ -131,13 +131,6 @@ examples:
                         remote-endpoint = <&dsi0_in>;
                     };
                 };
-
-                port@1 {
-                    reg = <1>;
-                    dpu_intf2_out: endpoint {
-                        remote-endpoint = <&dsi1_in>;
-                    };
-                };
             };
         };
 
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.yaml
index 76369a4f7c4d..595a9d56949c 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.yaml
@@ -132,13 +132,6 @@ examples:
                         remote-endpoint = <&dsi0_in>;
                     };
                 };
-
-                port@1 {
-                    reg = <1>;
-                    dpu_intf2_out: endpoint {
-                        remote-endpoint = <&dsi1_in>;
-                    };
-                };
             };
         };
 

-- 
2.41.0

