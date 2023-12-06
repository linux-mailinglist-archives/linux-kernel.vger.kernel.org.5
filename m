Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636DD806DB0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378176AbjLFLRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377967AbjLFLRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:17:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D387DC
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 03:17:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC36C433C7;
        Wed,  6 Dec 2023 11:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701861461;
        bh=SGDDtanpuy2F23oyCza+p5DlVsIoWTxJOOMzvs5zlaw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kkWOUTBEiXapYrbVBAwbZ4TRaU50H/SRZeVWkIsHXxrJrrqpudu9m/shx+NPO9/7w
         Ocvr/C6SnwgIkgEWxC/f+2kfViekOgLNi+zlP/N9ugGlxEJbVtEJdPaDE/efW9o35T
         1kxdCrtiZzK2HuryahEBS0/chuQCzSzTl9WkV0CLOaDPtBwIZy0HK6238DjL9MaGVV
         L5rGuAVGERlCQvbTHzXnWqDVFOYhIjFz/OV8PeLS5667rzR9onPgo/iXGGlDXIeHqy
         oRSa0UnpiuwPjwdgpgGRwXDcfRJwgYIECfej++iAOgqHiCmhARuX0vNE12fAiZ6QDX
         g9PpsR97PDp5A==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1rApvA-0001wG-1i;
        Wed, 06 Dec 2023 12:18:28 +0100
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
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 2/4] dt-bindings: mfd: hisilicon,hi6421-spmi-pmic: fix regulator binding
Date:   Wed,  6 Dec 2023 12:17:52 +0100
Message-ID: <20231206111754.7410-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231206111754.7410-1-johan+linaro@kernel.org>
References: <20231206111754.7410-1-johan+linaro@kernel.org>
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

The regulator child nodes do not have unit addresses so drop the
incorrect '#address-cells' and '#size-cells' properties from the parent
'regulators' node.

Fixes: 352335a6aced ("staging: hikey9xx: hisilicon, hi6421-spmi-pmic.yaml: simplify props")
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml       | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
index e36e5ce58136..45cd6a613a91 100644
--- a/Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
@@ -42,13 +42,6 @@ properties:
 
     additionalProperties: false
 
-    properties:
-      '#address-cells':
-        const: 1
-
-      '#size-cells':
-        const: 0
-
     patternProperties:
       '^ldo[0-9]+$':
         type: object
@@ -77,9 +70,6 @@ examples:
       interrupts = <0 0>;
 
       regulators {
-        #address-cells = <1>;
-        #size-cells = <0>;
-
         ldo3: ldo3 {
           regulator-name = "ldo3";
           regulator-min-microvolt = <1500000>;
-- 
2.41.0

