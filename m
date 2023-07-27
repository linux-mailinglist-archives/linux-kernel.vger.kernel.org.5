Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE40765187
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 12:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbjG0Kn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 06:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjG0Kn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 06:43:26 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B526519B6;
        Thu, 27 Jul 2023 03:43:24 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RBS1G0lq8z6GDG1;
        Thu, 27 Jul 2023 18:38:58 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 27 Jul
 2023 11:43:21 +0100
Date:   Thu, 27 Jul 2023 11:43:20 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Antoniu Miclaus <antoniu.miclaus@analog.com>, <jic23@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings:iio:frequency:admv1013: add vcc regs
Message-ID: <20230727114320.00000021@Huawei.com>
In-Reply-To: <96a82a51-6e26-cee2-c095-98fac749393f@linaro.org>
References: <20230727102309.92479-1-antoniu.miclaus@analog.com>
        <96a82a51-6e26-cee2-c095-98fac749393f@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2023 12:37:47 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 27/07/2023 12:23, Antoniu Miclaus wrote:
> > Add bindings for the VCC regulators of the ADMV1013 microware
> > upconverter.
> > 
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>  
> 
> Subject: missing spaces between prefix parts.
> 
> > ---
> >  .../bindings/iio/frequency/adi,admv1013.yaml  | 50 +++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
> > index fc813bcb6532..6660299ac1ad 100644
> > --- a/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
> > +++ b/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
> > @@ -39,6 +39,46 @@ properties:
> >      description:
> >        Analog voltage regulator.
> >  
> > +  vcc-drv-supply:
> > +    description:
> > +      RF Driver voltage regulator.
> > +
> > +  vcc2-drv-supply:
> > +    description:
> > +      RF predriver voltage regulator.
> > +
> > +  vcc-vva-supply:
> > +    description:
> > +      VVA Control Circuit voltage regulator.
> > +
> > +  vcc-amp1-supply:
> > +    description:
> > +      RF Amplifier 1 voltage regulator.
> > +
> > +  vcc-amp2-supply:
> > +    description:
> > +      RF Amplifier 2 voltage regulator.
> > +
> > +  vcc-env-supply:
> > +    description:
> > +      Envelope Detector voltage regulator.
> > +
> > +  vcc-bg-supply:
> > +    description:
> > +      Mixer Chip Band Gap Circuit voltage regulator.
> > +
> > +  vcc-bg2-supply:
> > +    description:
> > +      VGA Chip Band Gap Circuit voltage regulator.
> > +
> > +  vcc-mixer-supply:
> > +    description:
> > +      Mixer voltage regulator.
> > +
> > +  vcc-quad-supply:
> > +    description:
> > +      Quadruppler voltage regulator.
> > +  
> 
> You made them required in the driver, so they should be required here as
> well. They should be required anyway, because AFAIU they have to be
> provided.
> 
> OTOH, this will break the ABI, so your driver might need to take them as
> optional.

In many cases will get stub regulators if they aren't explicitly provided,
so no breakage and no need to make them optional.

Jonathan
> 
> Best regards,
> Krzysztof
> 

