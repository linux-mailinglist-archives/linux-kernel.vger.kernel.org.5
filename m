Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B219781B86
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 02:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjHTAKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 20:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjHTAK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 20:10:26 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93BF88325;
        Sat, 19 Aug 2023 13:19:16 -0700 (PDT)
Received: from p5dcc3be5.dip0.t-ipconnect.de ([93.204.59.229] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1qXSPZ-002ojp-1j; Sat, 19 Aug 2023 22:19:05 +0200
Date:   Sat, 19 Aug 2023 22:19:03 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: Add TI TWL603X GPADC
Message-ID: <20230819221903.726a1c39@aktux>
In-Reply-To: <426d78d6-9fa6-bfeb-b36a-fba264097a27@linaro.org>
References: <20230816202614.324457-1-andreas@kemnade.info>
        <426d78d6-9fa6-bfeb-b36a-fba264097a27@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 19 Aug 2023 20:35:27 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 16/08/2023 22:26, Andreas Kemnade wrote:
> > Document TI TWL603X GPADC devicetree bindings.
> > A driver is already there, the compatibles are used, but not documented.
> > Use two separate files to reference only the allowed compatible in
> > a future YAML version of
> > Documentation/devicetree/bindings/mfd/twl-family.txt
> > 
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---  
> 
> Thank you for your patch. There is something to discuss/improve.
> 
> 
> >  .../bindings/iio/adc/ti,twl6030-gpadc.yaml    | 42 +++++++++++++++++++
> >  .../bindings/iio/adc/ti,twl6032-gpadc.yaml    | 42 +++++++++++++++++++
> >  2 files changed, 84 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,twl6030-gpadc.yaml
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,twl6032-gpadc.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/ti,twl6030-gpadc.yaml b/Documentation/devicetree/bindings/iio/adc/ti,twl6030-gpadc.yaml
> > new file mode 100644
> > index 000000000000..08bc0468f616
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/ti,twl6030-gpadc.yaml
> > @@ -0,0 +1,42 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/ti,twl6030-gpadc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: GPADC subsystem in the TWL6030 power module
> > +
> > +maintainers:
> > +  - Jonathan Cameron <jic23@kernel.org>  
> 
> This should be rather someone knowing or having or caring about this
> particular hardware, not subsystem maintainer.
> 
Hmm, I have the twl6032, but not the twl6030. So probably
Tony (OMAP-Maintainer) or me?

> > +
> > +description:
> > +  The GPADC subsystem in the TWL6030 consists of a 10-bit ADC
> > +  combined with a 15-input analog multiplexer.
> > +
> > +properties:
> > +  compatible:
> > +    const: ti,twl6030-gpadc  
> 
> Devices look fairly similar. Same properties. Why aren't they in one
> binding (enum here instead)?
>
I hope it can be done. See commit message. Maybe my reasoning is wrong.

So what I am thinking about:

&i2c {
	twl: pmic@48 {
		compatible = "ti,twl6032;
		adc {
			compatible = "ti,twl6032-gpadc";
		}
	}
}

So the idea was to later enforce that below a "ti,twl6032" no "ti,twl6030-gpadc"
is allowed in a future yaml version of mfd/twl-family.txt by
using a if: ... compatible = "twl,6032" .. $ref ti,twl6032-gpadc.yaml

If there are other possibilities or that can be just ignored for now,
I fully agree to your proposal. 

Regards,
Andreas
