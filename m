Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97EBE7FF86F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346189AbjK3Rhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbjK3RhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:37:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E5610D1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:37:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C8CC433C7;
        Thu, 30 Nov 2023 17:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701365851;
        bh=WN/J7jFY+bfKMs/N2amMY0Qy46obkUkAx7OxDaTojL4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mchUzyVHazWPFjPM4KZSLxJ2wRspUREmAg/Kbx9mjJvBEE8L0BzgExztXgf+gEZok
         +KcoL6SLLmcyfP7mBIXdEflu3xXp0SFDOTtYgfXbDmFaKnp+lbzlQfCIXGGYocGejv
         dNnEqhTe2mjEbMgw1rMRO75UdaHVXJ/h//JcubhdmPzShAOUPHmeP2gviMjaBcitra
         RSWjK3BBFnm/PjTllc2VeBuMY8RJx8Tawme738MoETdgEU4hpfBG9rajE+Tpx6IsUU
         3uJtTWtSDOsvLJwI+SVnCuJhoYHZIXoaNHRlCW9vGuWFo00n0sUY3er3HtTnLSPrvV
         YCnHHhCbe3CsQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1r8kzE-0003O8-2t;
        Thu, 30 Nov 2023 18:38:04 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 1/2] dt-bindings: spmi: hisilicon,hisi-spmi-controller: fix binding references
Date:   Thu, 30 Nov 2023 18:37:56 +0100
Message-ID: <20231130173757.13011-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231130173757.13011-1-johan+linaro@kernel.org>
References: <20231130173757.13011-1-johan+linaro@kernel.org>
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

Fix up the free text binding references which were not updated when
moving the bindings out of staging and which had a leading current
directory component, respectively.

Fixes: 9bd9e0de1cf5 ("mfd: hi6421-spmi-pmic: move driver from staging")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../bindings/spmi/hisilicon,hisi-spmi-controller.yaml         | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spmi/hisilicon,hisi-spmi-controller.yaml b/Documentation/devicetree/bindings/spmi/hisilicon,hisi-spmi-controller.yaml
index f882903769f9..eee7c8d4cf4a 100644
--- a/Documentation/devicetree/bindings/spmi/hisilicon,hisi-spmi-controller.yaml
+++ b/Documentation/devicetree/bindings/spmi/hisilicon,hisi-spmi-controller.yaml
@@ -14,7 +14,7 @@ description: |
   It is a MIPI System Power Management (SPMI) controller.
 
   The PMIC part is provided by
-  ./Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml.
+  Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml.
 
 allOf:
   - $ref: spmi.yaml#
@@ -48,7 +48,7 @@ patternProperties:
       PMIC properties, which are specific to the used SPMI PMIC device(s).
       When used in combination with HiSilicon 6421v600, the properties
       are documented at
-      drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml.
+      Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
 
 unevaluatedProperties: false
 
-- 
2.41.0

