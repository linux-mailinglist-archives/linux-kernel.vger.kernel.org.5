Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067AA78ABC4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 12:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbjH1Keb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 06:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbjH1KeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:34:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FA9CFA;
        Mon, 28 Aug 2023 03:33:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B44C263DB4;
        Mon, 28 Aug 2023 10:33:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7914C433C7;
        Mon, 28 Aug 2023 10:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693218820;
        bh=tG5mfpmkIPqN8OZym996RruD3Ro6btaiwud1g/6/6xY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Crj7FBehCfST9kZRvUkQQE7rp2MoPZOaZ4eOwrUBNDD13LYwAOAGXuHuylBpRfKlc
         /qSjoYVemGZvuYizN347tJmllNdNWsxRrdIlWNs33Ey6+b/OaGJjDDqJwSAFBivtIS
         K1J4O52OoqCCV7WLC0Yv3lUJBhrbsN1j047nmGp+tEA4EqAmJ9OZDyAyqvbBfP9CS7
         CLLIubcji5QLIwnnzyhmHtsOfIcCS+yn8Yj/XcO6INyXtIcFJkmPnO0dJtiiujE/An
         JwRsZs2hQF/x8Mq6vDMuQha9iHkYleJP5ZATf897YEBHhbMDbf6Hday4azCKUrY6KW
         6PnQ8SLbgX10A==
Date:   Mon, 28 Aug 2023 11:33:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: iio: adc: Add TI TWL603X GPADC
Message-ID: <20230828113358.3cf6f994@jic23-huawei>
In-Reply-To: <84388311-c92c-812e-53bd-35daf8821a16@linaro.org>
References: <20230820123229.530371-1-andreas@kemnade.info>
        <84388311-c92c-812e-53bd-35daf8821a16@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Aug 2023 22:34:33 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 20/08/2023 14:32, Andreas Kemnade wrote:
> > Document TI TWL603X GPADC devicetree bindings.
> > A driver is already there, the compatibles are used, but not documented.
> > 
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---  
> 
> Please provide changelog after ---.
> 
> 
> >  .../bindings/iio/adc/ti,twl6030-gpadc.yaml    | 45 +++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,twl6030-gpadc.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/ti,twl6030-gpadc.yaml b/Documentation/devicetree/bindings/iio/adc/ti,twl6030-gpadc.yaml
> > new file mode 100644
> > index 000000000000..5b075237bcfd
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/ti,twl6030-gpadc.yaml
> > @@ -0,0 +1,45 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/ti,twl6030-gpadc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: GPADC subsystem in the TWL6030 power module
> > +
> > +maintainers:
> > +  - Andreas Kemnade <andreas@kemnade.info>
> > +
> > +description:
> > +  The GPADC subsystem in the TWL603X consists of a 10-bit ADC
> > +  combined with a 15-input analog multiplexer in the TWL6030 resp. a
> > +  19-input analog muliplexer in the TWL6032.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - ti,twl6030-gpadc
> > +      - ti,twl6032-gpadc
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  "#io-channel-cells":
> > +    const: 1
> > +
> > +required:
> > +  - compatible
> > +  - interrupts
> > +  - "#io-channel-cells"
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    twl {  
> 
> Just skip the twl node. Anyway, the parent device binding should include
> complete example.
I tidied that up whilst applying.
> 
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Applied to the togreg branch of iio.git and pushed out as testing for 0-day
to poke at it.  I'll be rebasing once rc1 is out so until then I won't
push this out as a branch linux-next will pick up.

Thanks,

Jonathan

> 
> Best regards,
> Krzysztof
> 

