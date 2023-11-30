Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B952E7FF832
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345964AbjK3RZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345867AbjK3RZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:25:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2240910E4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:25:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D76C433C9;
        Thu, 30 Nov 2023 17:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701365125;
        bh=tJgxRz4gUs6W6Faa+Cg1vkflopdC7A4P4ALBdtcXLMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HQsN2Qi7iv0U/cVxFkcbXn63O2jSqdXm0fg5DVFkJmjiowP6RImhn2etpYiltW+G1
         Wbu7eFZ1eYSHxGgye6gXf3sVDFrcUwY1tD9vhxlkwtYeaO/eqE6g2duOWY5o0KAjzQ
         IGWEwo/S+vreGsBoOffXVIHea0W//Ds1AcFCiyM44WW499OO5VIuwHfrekGAXb8DKG
         j2L2o9HBWsA2cW9nJSRpL1+JpxBLCgbtv3180ALMg83DNrxIEtbGYE63tmRepSh9Tj
         K3E1q/8A5FfDuyIL2fKn8sGvoZQ/VQclWq9IcP+0Un4AXGTLHX92ilYuCOsYUAY6kA
         sbOIIM8Lpq+eg==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1r8knX-0003Gv-0x;
        Thu, 30 Nov 2023 18:25:59 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 1/4] dt-bindings: mfd: hisilicon,hi6421-spmi-pmic: fix up binding reference
Date:   Thu, 30 Nov 2023 18:25:44 +0100
Message-ID: <20231130172547.12555-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231130172547.12555-1-johan+linaro@kernel.org>
References: <20231130172547.12555-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up the SPMI PMIC binding document free text reference which
erroneously referred to itself rather than the parent SPMI controller
binding as intended.

Fixes: 9e5917288545 ("dt: document HiSilicon SPMI controller and mfd/regulator properties")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml     | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
index bdff5b653453..e36e5ce58136 100644
--- a/Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
@@ -17,7 +17,7 @@ description: |
   node.
 
   The SPMI controller part is provided by
-  Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
+  Documentation/devicetree/bindings/spmi/hisilicon,hisi-spmi-controller.yaml
 
 properties:
   $nodename:
-- 
2.41.0

