Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E52C801105
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjLAQqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjLAQqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:46:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BA312A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 08:46:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF46C433CD;
        Fri,  1 Dec 2023 16:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701449206;
        bh=wLgR6MqTrL0B4AsUWLMzOT2VikZmtlYBcwK7nvTkcP0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LddZIwzlhQz6gRegEWtKJcWDVOYAOe6RsF2z7+GpqD+WdWTI17vEZIvhqqhSupghO
         WKaclVqZPynYBmatr+Z+kl3VBx+RtHASr0RsIYNar1XkLpDWJ7xm/yblPtWH4RBfoS
         TNPuXaSWVTXlVgg8Sc1/vTLiapEL1o8/Hp0KZSCfPYZ1fOgLHDOUHnzstQ4SK2F9FY
         HSulWjG/OkAXOcs7sSwbs66EbvuWEcsq0gu8olaKIqD2h+6XC+IaapQXd0AVVQDUt1
         9keenpY4HXlVGphrBotJDPkdDQggMvQxBtOf/xt+w4sZHN9hR13q7ydt0hJDIe082i
         50b3+G1yicRSA==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1r96fj-0003IS-06;
        Fri, 01 Dec 2023 17:47:23 +0100
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
        Johan Hovold <johan+linaro@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/4] dt-bindings: mfd: hisilicon,hi6421-spmi-pmic: fix up binding reference
Date:   Fri,  1 Dec 2023 17:45:43 +0100
Message-ID: <20231201164546.12606-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231201164546.12606-1-johan+linaro@kernel.org>
References: <20231201164546.12606-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up the SPMI PMIC binding document free text reference which
erroneously referred to itself rather than the parent SPMI controller
binding as intended.

Fixes: 9e5917288545 ("dt: document HiSilicon SPMI controller and mfd/regulator properties")
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

