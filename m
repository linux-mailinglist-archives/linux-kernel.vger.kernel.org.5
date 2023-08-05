Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E249771154
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 20:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjHESKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 14:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjHESK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 14:10:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB0F1A4;
        Sat,  5 Aug 2023 11:10:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A498660DF5;
        Sat,  5 Aug 2023 18:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA508C433C8;
        Sat,  5 Aug 2023 18:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691259027;
        bh=3cOSVqPZ8fzLMACkuwTA6mctnPETbzl0oDRi88n6Las=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=STFE2LdfPY8HHrQuFQFxpkN89CppnPX1ZHWzPHU1peBgMbDP+rSdi9mKrMNG8F0rq
         jh5MqWxFHxFj5PSEh+ScPmq9jyVkBTIDyiR8BE5BfihLMHqa069kMGEqJGqrSBZEPs
         tND65bxS4FY2smyFySGrt38ISav9sF5l0Im/kw4C+ASAsqTwpvooPcF8S3mP/lJjEp
         hTb1l+FPaIyfIdNXjTJ+82wGQSOVz2OyiKQmxYq7rKWZTpxFYCqM/jlDlvFjjLnAs8
         EWJ0Br6YOka5lVPKpd08urbMQ1rOdb4hGlDS7M+5PSfTO0KwzeCvF1djklDNdppy1A
         2yZVaO20IK6mA==
Date:   Sat, 5 Aug 2023 19:10:19 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Antoniu Miclaus <antoniu.miclaus@analog.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: admv1013: add vcc regulators
Message-ID: <20230805191019.388284b2@jic23-huawei>
In-Reply-To: <20230801-rasping-petty-5fca54f6f696@spud>
References: <20230731094455.26742-1-antoniu.miclaus@analog.com>
        <20230801-rasping-petty-5fca54f6f696@spud>
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

On Tue, 1 Aug 2023 22:09:28 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Mon, Jul 31, 2023 at 12:44:54PM +0300, Antoniu Miclaus wrote:
> > Add bindings for the VCC regulators of the ADMV1013 microware
> > upconverter.
> > 
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>  
> 
> Assuming the driver or regulator core handles the missing regulators on
> older devicetrees (which I think it does with dummy regulators?)

Yup - that should happen fine.

> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Series applied to the togreg branch of iio.git and pushed out as
testing for 0-day to poke at it.

Thanks,

Jonathan

> 
> Thanks,
> Conor.
> 
> > ---
> > changes in v3:
> >  - add missing spaces in the commit subject.
> >  .../bindings/iio/frequency/adi,admv1013.yaml  | 60 +++++++++++++++++++
> >  1 file changed, 60 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
> > index fc813bcb6532..f2eb2287ed9e 100644
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
> > +    description:in/v3_20230731_antoniu_miclaus_dt_bindings_iio_admv1013_add_vcc_regulators.mbx
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
> >    adi,detector-enable:
> >      description:
> >        Enable the Envelope Detector available at output pins VENV_P and
> > @@ -69,6 +109,16 @@ required:
> >    - clocks
> >    - clock-names
> >    - vcm-supply
> > +  - vcc-drv-supply
> > +  - vcc2-drv-supply
> > +  - vcc-vva-supply
> > +  - vcc-amp1-supply
> > +  - vcc-amp2-supply
> > +  - vcc-env-supply
> > +  - vcc-bg-supply
> > +  - vcc-bg2-supply
> > +  - vcc-mixer-supply
> > +  - vcc-quad-supply
> >  
> >  allOf:
> >    - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > @@ -87,6 +137,16 @@ examples:
> >          clocks = <&admv1013_lo>;
> >          clock-names = "lo_in";
> >          vcm-supply = <&vcm>;
> > +        vcc-drv-supply = <&vcc_drv>;
> > +        vcc2-drv-supply = <&vcc2_drv>;
> > +        vcc-vva-supply = <&vcc_vva>;
> > +        vcc-amp1-supply = <&vcc_amp1>;
> > +        vcc-amp2-supply = <&vcc_amp2>;
> > +        vcc-env-supply = <&vcc_env>;
> > +        vcc-bg-supply = <&vcc_bg>;
> > +        vcc-bg2-supply = <&vcc_bg2>;
> > +        vcc-mixer-supply = <&vcc_mixer>;
> > +        vcc-quad-supply = <&vcc_quad>;
> >          adi,quad-se-mode = "diff";
> >          adi,detector-enable;
> >        };
> > -- 
> > 2.41.0
> >   

