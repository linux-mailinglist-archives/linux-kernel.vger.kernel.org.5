Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03C477FC0F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 18:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353589AbjHQQ1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 12:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353645AbjHQQ0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 12:26:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3946B2713;
        Thu, 17 Aug 2023 09:26:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C111561CC4;
        Thu, 17 Aug 2023 16:26:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 465CEC433C8;
        Thu, 17 Aug 2023 16:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692289588;
        bh=C6cONN092jxbsvu6AqqhB938PWlN9DTWuSYANuWmSlc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hew43YNwx2uX+I9+4JQSkfx7TeHoCJdr00GXdo04pjdW2uLEACj32vmwyf5j+aexI
         twQgNjva7/igs1wkM7OyNmHL6SpX35odruS0MdkTVKWAvB/+jOD3vtB95AuODKI+WZ
         KDUMZ8nN+omfA39bN53W66/VWzuQan91UenFb2Kjb37ObvLosKa01MSI9dum1P9c9/
         EqxIM2uF9lXe1SHgasBmSUrgQhp6yZZ8hWs9Rmh40wHKqSLWHP5gfegvHlSSO12uMf
         FfRHuPU4ifOf3YxKhM67jKYdb25qVaq4NbBQBydjDa9HArOZredF1Gcgy62gsxW30S
         JNmx4j2EudsXg==
Received: (nullmailer pid 1446733 invoked by uid 1000);
        Thu, 17 Aug 2023 16:26:24 -0000
Date:   Thu, 17 Aug 2023 11:26:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Anjelique Melendez <quic_amelende@quicinc.com>
Cc:     pavel@ucw.cz, lee@kernel.org, thierry.reding@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, luca.weiss@fairphone.com,
        konrad.dybcio@linaro.org, u.kleine-koenig@pengutronix.de,
        quic_subbaram@quicinc.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 1/7] dt-bindings: soc: qcom: Add qcom,pbs bindings
Message-ID: <20230817162624.GA1444880-robh@kernel.org>
References: <20230814235918.10396-1-quic_amelende@quicinc.com>
 <20230814235918.10396-2-quic_amelende@quicinc.com>
 <102328fa-5699-4731-d639-079bce8863a5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <102328fa-5699-4731-d639-079bce8863a5@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 10:36:39PM +0200, Krzysztof Kozlowski wrote:
> On 15/08/2023 01:59, Anjelique Melendez wrote:
> > Add binding for the Qualcomm Programmable Boot Sequencer device.
> > 
> > Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
> > ---
> >  .../bindings/soc/qcom/qcom,pbs.yaml           | 46 +++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,pbs.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,pbs.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,pbs.yaml
> > new file mode 100644
> > index 000000000000..b502ca72266a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,pbs.yaml
> > @@ -0,0 +1,46 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/soc/qcom/qcom,pbs.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Qualcomm Technologies, Inc. Programmable Boot Sequencer
> > +
> > +maintainers:
> > +  - Anjelique Melendez <quic_amelende@quicinc.com>
> > +
> > +description: |
> > +  The Qualcomm Technologies, Inc. Programmable Boot Sequencer (PBS)
> > +  supports triggering power up and power down sequences for clients
> > +  upon request.
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - qcom,pmi632-pbs
> > +      - const: qcom,pbs
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/spmi/spmi.h>
> > +
> > +    pmic@0 {
> 
> This should be rather just "pmic", because the examples have
> address-cells=1 and size-cells=1, which is not correct in this context.

But there's a 'reg' property so you can't drop the unit-address. The bus 
node (spmi) needs to be added.

Rob
