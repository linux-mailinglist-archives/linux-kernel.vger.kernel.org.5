Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3557C9B37
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 22:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjJOUEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 16:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjJOUEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 16:04:06 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FF9C5;
        Sun, 15 Oct 2023 13:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1697400212; bh=HsI6q5ZqWA2Xqb7iuplYKiKLey5gau/NWt1cjNPYiYY=;
        h=From:Subject:Date:To:Cc;
        b=eibEV0JgXjMSfigi6w8SQom18W9kxtWAUaGm3ygoHsIpQBIuT3Ls0VUtLq0m6LcGR
         ioWkLPyESxVYM8f+klu/B7KfdFsbuts9Yb3Wo9J7GCh5dQxKZMoOVv1BpeJvPh9kZc
         +qndWPnRl9OZebR6NZ0790k5kZQn4oOZThl4RG70=
From:   Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH 0/4] Add WCN3680B WiFi/Bluetooth and enable it on Fairphone
 3
Date:   Sun, 15 Oct 2023 22:03:05 +0200
Message-Id: <20231015-fp3-wcnss-v1-0-1b311335e931@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHpFLGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDA0NT3bQCY93y5LziYl0j41QL4yQLI2PTNFMloPqCotS0zAqwWdGxtbU
 ALtuZRVsAAAA=
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Kalle Valo <kvalo@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1128; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=HsI6q5ZqWA2Xqb7iuplYKiKLey5gau/NWt1cjNPYiYY=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlLEWG9Gp66ulRUz7oQWuzEBvMk2DKLUswm1NFY
 OuLLA8+1VaJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZSxFhgAKCRBy2EO4nU3X
 VspqD/0c+2OcM1vAUEhGee8RMbaeYcyy0yD6WuefeqaEEHO51eB9PlZimEv/NDVi2H/N1FFvKjG
 PhA96ExHV1idW3gUcEod6w8QSGGSu8FSVEY08LfV8iIFxZiZazxvrKAzOOI5KpI28btSbsLjg4E
 4A6alHfxWSfoeAAvLwgb070Pj7D8mIqjhQ9gasW85r+Z5hb+5l/qOe/mp+gKXuQ+8vIu9b5OXFj
 dEc+O0V3XEzfwANhzmYfZVcQoXqFAsPGyKLLuglHsVGXS7uSXxdEwR7XfXh5pmszFVAomIKjboY
 U6NRRq6otOG/6nKxy8GLv4yQjuVd8I95IUvTk7wlMYJeJDnOAQmaHZGLcfHIfs5RpzITo+p8n+1
 cSrpKVligbDsaJZBSct8IttOph6UL8XdhM7l9skVtlHLiMPLcbYFQaxwNDduJOxDyaC0ukQD/db
 Mmsj38SNSAoJOIV43HTygfFHVB4en7/8CpyGSQ5xG35u1sdpT633ZSfZKBc8NXyCQMCtuRWUsdL
 dJsCUg//rZ6JOSlfUg25WUXZeGO/60D86DZkyOk/KhYpSD77VpQDQTJ7oF/5qR9JwjCOfbNsGLa
 T3X3Vz1YLzwn2bqqVL1t9P1GL1DbLir2IL2spBuk0qaEGAAYC6tQwbT9l3gbsM9eF+R9KDRY/nn
 YhEGG6xQG3LxoQA==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new compatible for the WCN3680B found together with some Qualcomm
SoCs. And enable this WiFi/Bluetooth combo on Fairphone 3 smartphone.

Worth noting that I'm pretty sure some phones already in mainline do
have this WCN3680B chip enabled but are using a different compatible,
e.g. qcom,wcn3680 (without the b suffix).

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Luca Weiss (4):
      dt-bindings: remoteproc: qcom: wcnss: Add WCN3680B compatible
      remoteproc: qcom_wcnss: Add WCN3680B compatible
      wifi: wcn36xx: Add check for WCN3680B
      arm64: dts: qcom: sdm632-fairphone-fp3: Enable WiFi/Bluetooth

 .../devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml    |  1 +
 arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts         | 15 +++++++++++++++
 drivers/net/wireless/ath/wcn36xx/main.c                   |  3 ++-
 drivers/remoteproc/qcom_wcnss_iris.c                      |  1 +
 4 files changed, 19 insertions(+), 1 deletion(-)
---
base-commit: 09eda82818c490a6fb24f1374bd704ea5c3b577a
change-id: 20231015-fp3-wcnss-23e83b8235f5

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>

