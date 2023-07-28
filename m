Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE50766257
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 05:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjG1DTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 23:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjG1DTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 23:19:17 -0400
Received: from out28-147.mail.aliyun.com (out28-147.mail.aliyun.com [115.124.28.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C53926AE;
        Thu, 27 Jul 2023 20:19:15 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0890598|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0874171-0.00189192-0.910691;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047194;MF=like@awinic.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.U2Z5D3i_1690514342;
Received: from awinic..(mailfrom:like@awinic.com fp:SMTPD_---.U2Z5D3i_1690514342)
          by smtp.aliyun-inc.com;
          Fri, 28 Jul 2023 11:19:10 +0800
From:   like@awinic.com
To:     krzysztof.kozlowski@linaro.org
Cc:     broonie@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lgirdwood@gmail.com, liangdong@awinic.com, like@awinic.com,
        linux-kernel@vger.kernel.org, liweilei@awinic.com,
        robh+dt@kernel.org, wangweidong.a@awinic.com
Subject: Re: [PATCH V1 2/2] regulator: aw37503: add device-tree binding
Date:   Fri, 28 Jul 2023 03:19:02 +0000
Message-ID: <20230728031902.1478890-1-like@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <8bd37e11-2861-7877-0321-3f89cd088532@linaro.org>
References: <8bd37e11-2861-7877-0321-3f89cd088532@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof Kozlowski,
Thank you very much for your advice.

> On 26/07/2023 10:16, like@awinic.com wrote:
> > From: Alec Li <like@awinic.com>
> > 
> > Add aw37503 regulator device-tree binding documentation
> 
> subject rather like:
> regulator: dt-bindings: Add Awinic aw37503

I will modify it as suggested.

> > 
> > Signed-off-by: Alec Li <like@awinic.com>
> > ---
> >  .../bindings/regulator/awinic,aw37503.yaml    | 73 +++++++++++++++++++
> >  1 file changed, 73 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/regulator/awinic,aw37503.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/regulator/awinic,aw37503.yaml b/Documentation/devicetree/bindings/regulator/awinic,aw37503.yaml
> > new file mode 100644
> > index 000000000000..0cd6fb001e20
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/regulator/awinic,aw37503.yaml
> > @@ -0,0 +1,73 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/regulator/awinic,aw37503.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Awinic AW37503 Voltage Regulator
> > +
> > +maintainers:
> > +  - Alec Li <like@awinic.com>
> > +
> > +description: |
> 
> Do not need '|' unless you need to preserve formatting.

I will modify it as suggested.

> > +  The AW37503 is dual voltage regulator, designed to support positive/negative
> > +  supply for driving TFT-LCD panels. It support software-configurable output
> > +  switching and monitoring. The output voltages can be programmed via an I2C
> > +  compatible interface.
> > +
> > +properties:
> > +  compatible:
> > +    const:
> > +      - awinic,aw37503
> 
> This has to be in one line. As pointed out by Rob's bot: please test it
> before sending.

I will test it before sending and modify it as suggested.

> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  patternProperties:
> 
> <sigh>
> 
> > +    "^out[pn]$":
> > +      type: object
> > +      $ref: regulator.yaml#
> > +      unvaluatedproperties: false
> > +
> > +      required:
> > +        - regulator-name
> > +        - enable-gpios
> 
> regulator.yaml does not define enable-gpios, so you must define it in
> properties.

I will modify it as suggested.

> > +
> > +      additionalProperties: false
> 
> Drop, you already have unevaluatedProperties.

I will modify it as suggested.

> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - outp
> > +  - outn
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        aw37503@3e {
> 
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

I will modify it as suggested.

 
Best regards,
Alec Li
