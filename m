Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3962277462D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbjHHSyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbjHHSxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:53:49 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F25A790;
        Tue,  8 Aug 2023 10:08:34 -0700 (PDT)
Received: from relay1-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::221])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id B5DB4C6DC9;
        Tue,  8 Aug 2023 12:32:31 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8F88D24000C;
        Tue,  8 Aug 2023 12:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691497948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Uz4PDleM9cm+NzvA+51SH9T9J1LoZFkV7vQFvjxHPvc=;
        b=U2zxC6kUkqR+q7UizYXdWgf/r3Vv4/Jg+KWT7f32GCj/bzuGXUXHVrjF9juLgxAk59QO55
        nBT+btfgySUbEbIp+OxLwsbqA0KcDR/SzFuClmKp0Vli07c53KQOh3Dpn9pB+g5EEoP0Lz
        9cHdE24aGeI1LNaPdDm5VJureEoSymKLPQBSf3GLIxRF4FukB8m8Fmcw50wnSCwHSdRXPt
        JO8wWPyfSqvxR+cmD6JcqKO0e9PFc5FnlKNt5KYh6bygJ5nzzdT81Z2vCXGQkR+sfRVybJ
        AfwpFM8BoGFkaaZmTrbKbBvv8/fkPI/WgtqnNfPyKeWI/Kjaga1F/qnFSzClyg==
Date:   Tue, 8 Aug 2023 14:32:26 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Conor Dooley <conor@kernel.org>, a.zummo@towertech.it,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bruno.thomsen@gmail.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH 1/2] dt-bindings: rtc: add properties to set
 battery-related functions
Message-ID: <202308081232266ec8a9b7@mail.local>
References: <20230802191153.952667-1-hugo@hugovil.com>
 <20230802191153.952667-2-hugo@hugovil.com>
 <20230808-capsize-deodorize-5776d3dbb192@spud>
 <20230808082533.b608c9a2a4bd922920643c4b@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808082533.b608c9a2a4bd922920643c4b@hugovil.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2023 08:25:33-0400, Hugo Villeneuve wrote:
> On Tue, 8 Aug 2023 12:21:24 +0100
> Conor Dooley <conor@kernel.org> wrote:
> 
> > Hey Hugo,
> > 
> > On Wed, Aug 02, 2023 at 03:11:52PM -0400, Hugo Villeneuve wrote:
> > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > 
> > > These properties can be defined in the board's device tree to set the
> > > default power-on values for battery-related functions.
> > > 
> > > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > ---
> > >  .../devicetree/bindings/rtc/rtc.yaml          | 19 +++++++++++++++++++
> > >  1 file changed, 19 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/rtc/rtc.yaml b/Documentation/devicetree/bindings/rtc/rtc.yaml
> > > index efb66df82782..0217d229e3fa 100644
> > > --- a/Documentation/devicetree/bindings/rtc/rtc.yaml
> > > +++ b/Documentation/devicetree/bindings/rtc/rtc.yaml
> > > @@ -26,6 +26,25 @@ properties:
> > >        0: not chargeable
> > >        1: chargeable
> > >  
> > > +  battery-low-detect:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    enum: [0, 1]
> > > +    description: |
> > > +      For RTC devices supporting a backup battery/supercap, this flag can be
> > > +      used to configure the battery low detection reporting function:
> > > +      0: disabled
> > > +      1: enabled
> > > +
> > > +  battery-switch-over:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    enum: [0, 1]
> > > +    description: |
> > > +      For RTC devices supporting a backup battery/supercap, this flag can be
> > > +      used to configure the battery switch over when the main voltage source is
> > > +      turned off:
> > > +      0: disabled
> > > +      1: enabled
> > 
> > Why are these implemented as enums? This seems to fall into the category
> > of using DT to determine software policy - why's it not sufficient to
> > have boolean properties that indicate hardware support and let the software
> > decide what to do with them?
> 
> Hi Conor,
> the reason is that I based the new properties on the existing property
> "aux-voltage-chargeable":
> 
> -------------------
>  aux-voltage-chargeable:
>     $ref: /schemas/types.yaml#/definitions/uint32
>     enum: [0, 1]
>     description: |
>       Tells whether the battery/supercap of the RTC (if any) is
>       chargeable or not:
>       0: not chargeable
>       1: chargeable
> -------------------
> 
> I agree with you that a boolean would be more appropriate. Should I
> also submit a (separate) patch to fix the "aux-voltage-chargeable"
> property to a boolean?
> 

No, this is an enum on purpose.
I will not take battery switch over related properties, this is not
hardware description but software configuration. There is an ioctl for
this.

> Hugo.
> 
> 
> > Thanks,
> > Conor.
> > 
> > > +
> > >    quartz-load-femtofarads:
> > >      description:
> > >        The capacitive load of the quartz(x-tal), expressed in femto
> > > -- 
> > > 2.30.2
> > > 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
