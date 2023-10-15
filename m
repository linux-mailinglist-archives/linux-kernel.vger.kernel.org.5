Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0D17C9B38
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 22:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjJOUEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 16:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjJOUEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 16:04:07 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B89ED9;
        Sun, 15 Oct 2023 13:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1697400213; bh=UBcuPPvCkMF5VJX2cM/TeeQFIz6MAcbcTnhTFVt0/f0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=wCMCKUVtrDwe6X5Bg0nId5QFXMCRKYAZBulQ++9fqc4RZbqaXcXAEJ3pHToYx8aED
         LCfIvxiV8jkgwvHzkyJAeGWDnDXrVnjh6vP3nrmocf6uFs6O+l8MUms6eq3qQDJBlS
         wfmuo14ZjcLcv1Iy5UfrQEeHCmg0RKMgnmXepZyg=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Sun, 15 Oct 2023 22:03:06 +0200
Subject: [PATCH 1/4] dt-bindings: remoteproc: qcom: wcnss: Add WCN3680B
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231015-fp3-wcnss-v1-1-1b311335e931@z3ntu.xyz>
References: <20231015-fp3-wcnss-v1-0-1b311335e931@z3ntu.xyz>
In-Reply-To: <20231015-fp3-wcnss-v1-0-1b311335e931@z3ntu.xyz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=746; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=UBcuPPvCkMF5VJX2cM/TeeQFIz6MAcbcTnhTFVt0/f0=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlLEWQWYz3VnCBzuywdfmhz0FJE7b161pJE9+zl
 YZAeemp6A+JAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZSxFkAAKCRBy2EO4nU3X
 VgUoD/957O200UjOLzDFN3HHOTl5/M5HtqlfCK+sAZl73OpKRDMj0Jcp8oMLl0OnrElRbTtpkJW
 croer+9sw6euIA03ntodsFpkA/HSSMSWV8fsYdsa5hs9Vl1M5KT1E8eskSJriUOML2thUt1uvBY
 PbB8K5X5pxSssglgqmFNhrYPaJzQz+rWYCiY1k5PQwHYj1SHfSGaPrT+nGYEK7TtyzZtA7vGOwE
 Os+46TJqIcBEDRjmgNDPR505ZSMESvjZB6tNhgN6bK9bJpb94Ef2uU+8fTXvWaB2ha+NSGQjEZ/
 3O0jTCXwVfd5RitkoJPIPr8JsHmaZnmb4PzhuUa49t72dAuAVmaFKiG81Uvo75et+Q9Vi7UEWrD
 rpTdYS9lwzQIE7rFG6Hd4xJwe488aEEw1PusLwpksOBnxg31L3PRSw3ARAoObqG8751HWPdwCFB
 NAqpeCXIxCFEcYnzNDSA5NaMhSCMkEaUjPN7SaItoLNIy9FuCkqDsDGAPAe9+VJF1G53hpHk7ib
 44eplItLHmqFYdpY7mkAUQjD1XW2Q3JPf0UtrwxiuKNj6slkNvhTBRLp7KZR2BGcFgiEi/eEdyV
 ki9H78THtYsJd2h9ziLiE+n0GyDHhK0GGhQjhLftDK+Ri1ruKO7l3K2K7jPLc+9VVANiw+uBku0
 dv2y6ikI1jaqFTQ==
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

Add a compatible for the iris subnode in the WCNSS PIL.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
index 45eb42bd3c2c..0e5e0b7a0610 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
@@ -111,6 +111,7 @@ properties:
           - qcom,wcn3660
           - qcom,wcn3660b
           - qcom,wcn3680
+          - qcom,wcn3680b
 
       clocks:
         minItems: 1

-- 
2.42.0

