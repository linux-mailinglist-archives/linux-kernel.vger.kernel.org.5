Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F147F1C4F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 19:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbjKTSZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 13:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjKTSZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 13:25:15 -0500
Received: from mail.subdimension.ro (unknown [IPv6:2a01:7e01:e001:1d1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8E1C8;
        Mon, 20 Nov 2023 10:25:11 -0800 (PST)
Received: from sunspire (unknown [188.24.94.216])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by mail.subdimension.ro (Postfix) with ESMTPSA id 2E5CC28EE6F;
        Mon, 20 Nov 2023 18:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
        s=skycaves; t=1700504710;
        bh=TqPCYi/lfIqtwCO6M0vvyzzQcnlSevyzaWBJMKt67zI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=morhvBQTAbQh5MbTCeiLvnMOThf9SrBu76IjYpU/VGqvGd24SDnqdEqtQQaQ2hFa/
         1WdwaPW+9Yu7PczCiWz9tozCinhRSKceEkYghEO3wtCSk7fc/RtVnhLVAUiIFG8uh1
         F/irdTFARvvIzQ0nuW/UY/DlQAbrnMdzKlXufW5s=
Date:   Mon, 20 Nov 2023 20:25:08 +0200
From:   Petre Rodan <petre.rodan@subdimension.ro>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: pressure: add honeywell,hsc030
Message-ID: <ZVukhMcY8A3Crxc_@sunspire>
References: <20231117164232.8474-1-petre.rodan@subdimension.ro>
 <20231117192305.17612-1-petre.rodan@subdimension.ro>
 <5b2e4b05-9408-48ea-92ac-15883e102013@linaro.org>
 <ZVtiVM2Gm1x1j_G1@sunspire>
 <8aa11758-5eee-427b-adcb-c3578a521daf@linaro.org>
 <ZVtv8x8LqGMhCisw@sunspire>
 <20231120173929.00006a6d@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120173929.00006a6d@Huawei.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello!

On Mon, Nov 20, 2023 at 05:39:29PM +0000, Jonathan Cameron wrote:
> On Mon, 20 Nov 2023 16:40:51 +0200
> Petre Rodan <petre.rodan@subdimension.ro> wrote:
> 
> > Hello!
> > 
> > On Mon, Nov 20, 2023 at 03:04:07PM +0100, Krzysztof Kozlowski wrote:
> > > On 20/11/2023 14:42, Petre Rodan wrote:
> > >   
> > > >>> +properties:
> > > >>> +  compatible:
> > > >>> +    enum:
> > > >>> +      - honeywell,hsc  
> > > >>
> > > >> Way too generic  
> > > > 
> > > > I'm new to this, please excuse my ignorance.
> > > > my driver covers all Honeywell pressure sensors under the "TruStability board mount HSC/SSC" moniker.  
> > > 
> > > We talk here about bindings, not driver. For the driver you can use
> > > whatever name is approved by reviewers of your driver.
> > >   
> > > > that is why my intention was to provide a rather generic name for the driver itself.
> > > > are you afraid that they will come up with a different device that they will call "hsc" in the future?
> > > > in this case honeywell,trustability-hsc would be fine?
> > > > 
> > > > as I see you prefer to target a particular chip, but I am a bit afraid that the end-user will be confused by needing to set up something like
> > > > 
> > > > pressure@28 {
> > > > 	compatible = "honeywell,hsc030pa";  
> > > 
> > > The compatible should be specific, thus for example match exact model
> > > number.  
> > 
> > there are an infinite number of combinations of 4 transfer functions and 118 ranges + one custom range, so providing an array with all specific chips that could end up as compatible is out of the question.
> > I was aiming at providing a generic name for the binding and get the transfer function and the pressure range as required parameters.
> > 
> > > If you can guarantee that all devices from given family are the same in
> > > respect of programming model and hardware requirements (e.g. supplies),
> > > then you could go with family name. However such guarantees are rarely
> > > given.  
> > 
> > I see your point.
> > 
> > > Therefore for mprls0025pa I agreed for using one specific model
> > > for entire family.
> > > 
> > > https://lore.kernel.org/all/d577bc44-780f-f25d-29c6-ed1d353b540c@linaro.org/
> > > 
> > >   
> > > > 	reg = <0x28>;
> > > > 	honeywell,transfer-function = <0>;
> > > > 	honeywell,pressure-range = "250MD";
> > > > };
> > > > 
> > > > ie. specifying "hsc030pa" as driver while his chip is not in the 030PA range, but 250MD.
> > > > 
> > > > so do you prefer
> > > >  honeywell,trustability-hsc  OR
> > > >  honeywell,hsc030pa  
> > > 
> > > I think the latter, just like we did for mprls0025pa. How many devices
> > > do you have there?  
> > 
> > both hsc and ssc have 118 ranges, 4 transfer functions and both can be requested from the manufacturer with custom measurement ranges.
> > 
> > ok,I will rename hsc->hsc030pa in the code as you requested.
> 
> Where does pa come from? 

honeywell,hsc030pa was provided as an equivalent to honeywell,mprls0025pa (which is already in the repo).

'030PA' and '0025PA' define the pressure range (0-30, 0-25), the unit of measure (Psi) and the measurement type (Absolute) for a particular chip in the honeywell catalog. (please ignore the psi part, we convert everything to pascals).
but both my driver and Andreas Klinger's mprls0025pa actually provide a generic abstraction layer for entire series of sensors.

> If we are going generic, feels like trustability-ssc etc are more representative
> and matches the datasheet cover page.

Krzysztof voted for non-generic, honeywell,mprls0025pa is already set up non-generic, my intent was to go generic.

I'll rewrite the code to whatever you guys feel is best.

peter


-- 
petre rodan
