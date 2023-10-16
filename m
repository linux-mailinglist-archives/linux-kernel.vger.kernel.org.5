Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053347CA0CF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 09:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbjJPHiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 03:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbjJPHiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 03:38:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F89F0;
        Mon, 16 Oct 2023 00:37:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF2F3C433CA;
        Mon, 16 Oct 2023 07:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697441878;
        bh=o2W+3Zlbc0rb+VxU0ocDQzUG1+stctWBCShpZiJXHb4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Xsi262bsc/yZOiFtUbhpJZHXFt6NXRQhUc5RE+pAd3Dy7zzgTCV7RdvThs7RcswiQ
         tCOSbl4EdNANiB4veO6BnKcMm6xnPkX442SXQSfdUM1R2fCCuwA36L2q+pPxbhL4TN
         uiRI2f9YzrnM5e/BF7uU9pqfGB8dhSS1SdoeM8VcOvCgYB0pXB7UURsqe6/B8IZWXg
         l4vURZn3UtT3TjG7gJijF1Wxnm/z5WHEYTlv2UsUq4FMWCl3kc2AdQSwLdTCLFL2Lm
         TR0hrDxT6aUSkpa/KpYgb5Vm/EIY2gWLo5QybV/8mp2wrmP3zHSisx1LpUDWkckpsZ
         gMqrF1wa4OtHA==
Date:   Mon, 16 Oct 2023 08:38:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     werneazc@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        lars@metafoo.de, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andre Werner <andre.werner@systec-electronic.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: ti,ads7038: Add
 description for ADS7038
Message-ID: <20231016083815.0b49cab1@jic23-huawei>
In-Reply-To: <2ae8c910-3fa5-4835-9d2a-fbab64d3aabf@linaro.org>
References: <20231016070318.28355-1-andre.werner@systec-electronic.com>
        <2ae8c910-3fa5-4835-9d2a-fbab64d3aabf@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2023 09:18:46 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 16/10/2023 09:02, werneazc@gmail.com wrote:
> > From: Andre Werner <andre.werner@systec-electronic.com>
> > 
> > Add basic description for ADS7038 ADC devices.
> > The devicetree adds the following device specific options:
> > 
> > - average-samples: Program device's programmable average filter.
> > - crc-enabled: Enable the CRC check for SPI transfers. Sadly, this
> >   option has currently no effect in the driver.
> > - status-enabled: Enable the appending of the device's status on the
> >   measure value transmission.
> > - gpio-controller: Sadly function not implemented yet in the driver.
> > 
> > Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
> > ---
> > v3
> > - Delete ADS7138 compatible and comments.
> > - Add options for CRC, status and average samples as well as
> >   gpio-controller.
> > - Update example.
> > - add regulator for digital IO voltage.  
> 
> You received several build errors before. Did you really test it now,
> because looks like not.
> 
> > ---
> >  .../bindings/iio/adc/ti,ads7038.yaml          | 83 +++++++++++++++++++
> >  1 file changed, 83 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads7038.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads7038.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads7038.yaml
> > new file mode 100644
> > index 000000000000..fc1054ca93f7
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads7038.yaml
> > @@ -0,0 +1,83 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/ti,ads7038.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Texas Instruments ADS7038 and similar ADCs
> > +
> > +maintainers:
> > +  - Andre Werner <andre.werner@systec-electronic.com>
> > +
> > +description: |
> > +  Family of 7 channel, 12 bit ADCs with SPI interface.
> > +
> > +  Datasheet: https://www.ti.com/lit/gpn/ads7038
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - ti,ads7038
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  spi-max-frequency:
> > +    maximum: 60000000
> > +
> > +  avdd-supply:
> > +    description: Analog supply voltage, also used as the reference voltage to the ADC.
> > +
> > +  dvdd-supply:
> > +    description: Digital I/O supply voltage.
> > +
> > +  average-samples:
> > +    description: |
> > +      If specified ADC is configured for avaraging measurements (OSR_CFG Register).
> > +      This effects output format for measurement and sampling time.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [0, 1, 2, 3, 4, 5, 6, 7]
> > +
> > +  status-enabled:
> > +    description: |  
> 
> Do not need '|' unless you need to preserve formatting.
> 
> > +      If specified ADC transmits chip status (DATA_CFG Register).  
> 
> Missing type.
> 
> You described the desired Linux feature or behavior, not the actual
> hardware. The bindings are about the latter, so instead you need to
> rephrase the property and its description to match actual hardware
> capabilities/features/configuration etc. Why this is a property of a board?

Agreed - if this information is useful always transmit or enabling when
whatever feature makes it useful is enabled by the driver / userspace interaction.
If it's not useful don't :)

> 
> > +
> > +  crc-enabled:
> > +    description: |
> > +      Checking the integrity of the data bits exchanged over
> > +      SPI interface (GENERAL_CFG Register).  
> 
> Same comment.
Even if you do want to make this controllable from userspace, we will need
a strong argument for why.  People rarely buy CRC capable chips and not
want it turned on.  I'd just always turn it on.

> 
> 
> 
> Best regards,
> Krzysztof
> 

