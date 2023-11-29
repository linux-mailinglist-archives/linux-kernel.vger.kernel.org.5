Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECA77FDB6F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbjK2PbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjK2PbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:31:19 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99B1D48;
        Wed, 29 Nov 2023 07:31:25 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C7635E0004;
        Wed, 29 Nov 2023 15:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701271884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QI1TyzlXaMDB+nhKVeoMHOxLQU8QDlDCw/eJpwfHUjI=;
        b=B+04Pvk3bWmTvMKPRwosQPKO0bPMfT8nIYKro4x6w5StmHTn4ntp35qumfbEmEr1iZUFvY
        h5vd2lx1Zu/KXq7I1HA6Svd1D8ClwkQzAwQqywyRs6HtxmBhOuq9HzTD+NKrs44JpoWvuw
        VHRg8plyHlX+LFUItkfkhsHzfg4vpwM8PfCvcrdrTsXreunjIm8cyH+AnsJW1ZwL0MK0KB
        r0EjUi5bX7UQ1s8CqLH9z99bs2+qnDt7eLd45H3/eLWPQ18er8GjsSPAiysHVatAko5t7V
        3TbKN29vILU+zZ12cMiF7FB7eNV+Q1gav41vgI+AS112rPbwCGOV6ckr5sfFiQ==
From:   Thomas Richard <thomas.richard@bootlin.com>
Date:   Wed, 29 Nov 2023 16:31:17 +0100
Subject: [PATCH 1/5] dt-bindings: arm: keystone: add ti,j7200-sci
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231129-j7200-tisci-s2r-v1-1-c1d5964ed574@bootlin.com>
References: <20231129-j7200-tisci-s2r-v1-0-c1d5964ed574@bootlin.com>
In-Reply-To: <20231129-j7200-tisci-s2r-v1-0-c1d5964ed574@bootlin.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        gregory.clement@bootlin.com, u-kumar1@ti.com,
        Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.12.0
X-GND-Sasl: thomas.richard@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On j7200, during suspend to ram the soc is powered-off.
At resume requested irqs shall be restored which is a different behavior
from other platforms.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
index c24ad0968f3e..53d9c58dcd70 100644
--- a/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
+++ b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
@@ -40,6 +40,8 @@ properties:
       - description: System controller on TI AM654 SoC
         items:
           - const: ti,am654-sci
+      - description: System controller on TI J7200 SOC
+          - const: ti,j7200-sci
 
   reg-names:
     description: |

-- 
2.39.2

