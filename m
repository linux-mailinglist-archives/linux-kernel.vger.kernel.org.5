Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028B87AE2F9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 02:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjIZAfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 20:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjIZAfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 20:35:38 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058ED10E;
        Mon, 25 Sep 2023 17:35:32 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3add83c9043so3870126b6e.2;
        Mon, 25 Sep 2023 17:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695688531; x=1696293331; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yDfwvoV6juhNVfFYjv+kFk+nrGJP0YOG7IEbzTcdy7c=;
        b=TxRaGCaLv42IsfHY8pjJTDTpLybfLbr5jgDrbud6JGbBuPV39mpiNweOk64phCVQ+B
         f+WffKGHPxVZQpbQyfqkTXJfsVT5Wn3T5gY5f/lqPUT/WdKATm/JUOSzj1LIvKUlABW+
         VlTWfMFoL4dOccnRuG54MOr7yjRzNz1kDZMQCywmUKhy3LZum13a9U3SeJA+SJGTlU2F
         648Nl6+7QJDg0N9pjUZ9+L/+Y1lE+5z4wgwfmVkJY40zFNL/Fdt9a2bDNNb42ZOZLbrb
         /aQDndRDDuURGPSttj2KvmUpsJAEJyLvL0WWctJbiaGip8vSnDQBB9uoO+2kdXFB/j9s
         YrvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695688531; x=1696293331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yDfwvoV6juhNVfFYjv+kFk+nrGJP0YOG7IEbzTcdy7c=;
        b=FmXFtjQHW/lYO6nm4jotN9mi8WCOwNXU3iLpjSmrif5x0z19zARaecYGnXMz/laRbk
         7VVcvtl6PATuz8gVSjnHWlqJXfW7aZkedS92fhc4M6mZTpUsKv1VUsfYncW1ysfV0oBZ
         NBZHry20F33qyMfQ2I2F+BDdI8EUc8uUNXcZ6kPzjNerA4oBY3Wvp399ggZuim9w2AyA
         q5dZEssM2isVQxbQQniNuf1Q7rzvA0Fai/keXeD35GsTToqyMzhH31gVAuUVtE9+IMyi
         pVlipI+fwWcBjulDBf7vfFWuufXjQDgzd404x7Ub9/87FSRLmpI4e1/sKsaOlQ30PIy9
         wdgQ==
X-Gm-Message-State: AOJu0YwYieUrTLFlaUtkXnz5J3nb74DyKaUuMOnWGR/y1fjlfxEuDLsy
        x8tTBqwUzto5R3nxQnWfVYA=
X-Google-Smtp-Source: AGHT+IFZCmNJnJdBBgZG8mrF9VaaQIQQKbIAtmGU3RLgAWG+zAccdSVW4KNX9t2EvpjwBsxfUTs40w==
X-Received: by 2002:a05:6808:19a2:b0:3a8:5fd6:f4d0 with SMTP id bj34-20020a05680819a200b003a85fd6f4d0mr9300136oib.49.1695688531176;
        Mon, 25 Sep 2023 17:35:31 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z10-20020aa791ca000000b0068fbad48817sm8638053pfa.123.2023.09.25.17.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 17:35:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 25 Sep 2023 17:35:28 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Andrew Jeffery <andrew@aj.id.au>, g@hatter.bewilderbeest.net,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "Milton D. Miller II" <mdmii@outlook.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, openbmc@lists.ozlabs.org,
        Eddie James <eajames@linux.ibm.com>,
        Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH 1/2] dt-bindings: watchdog: aspeed-wdt: Add
 aspeed,reset-mask property
Message-ID: <e6b82ec9-c19b-4210-9251-2beee30c6d90@roeck-us.net>
References: <20230922104231.1434-4-zev@bewilderbeest.net>
 <20230922104231.1434-5-zev@bewilderbeest.net>
 <6df088a6-75ab-42f2-ba39-3f155714ed2d@app.fastmail.com>
 <6b0d4901-d543-4a06-a1e4-7f1558f5361f@hatter.bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b0d4901-d543-4a06-a1e4-7f1558f5361f@hatter.bewilderbeest.net>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 05:04:10PM -0700, Zev Weiss wrote:
> On Sun, Sep 24, 2023 at 07:42:45PM PDT, Andrew Jeffery wrote:
> > 
> > 
> > On Fri, 22 Sep 2023, at 20:12, Zev Weiss wrote:
> > > This property configures the Aspeed watchdog timer's reset mask, which
> > > controls which peripherals are reset when the watchdog timer expires.
> > > Some platforms require that certain devices be left untouched across a
> > > reboot; aspeed,reset-mask can now be used to express such constraints.
> > > 
> > > Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> > > ---
> > >  .../bindings/watchdog/aspeed-wdt.txt          | 18 +++-
> > >  include/dt-bindings/watchdog/aspeed-wdt.h     | 92 +++++++++++++++++++
> > >  2 files changed, 109 insertions(+), 1 deletion(-)
> > >  create mode 100644 include/dt-bindings/watchdog/aspeed-wdt.h
> > > 
> > > diff --git a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> > > b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> > > index a8197632d6d2..3208adb3e52e 100644
> > > --- a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> > > +++ b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> > > @@ -47,7 +47,15 @@ Optional properties for AST2500-compatible watchdogs:
> > >  			   is configured as push-pull, then set the pulse
> > >  			   polarity to active-high. The default is active-low.
> > > 
> > > -Example:
> > > +Optional properties for AST2500- and AST2600-compatible watchdogs:
> > > + - aspeed,reset-mask: A bitmask indicating which peripherals will be reset if
> > > +		      the watchdog timer expires.  On AST2500 this should be a
> > > +		      single word defined using the AST2500_WDT_RESET_* macros;
> > > +		      on AST2600 this should be a two-word array with the first
> > > +		      word defined using the AST2600_WDT_RESET1_* macros and the
> > > +		      second word defined using the AST2600_WDT_RESET2_* macros.
> > > +
> > > +Examples:
> > > 
> > >  	wdt1: watchdog@1e785000 {
> > >  		compatible = "aspeed,ast2400-wdt";
> > > @@ -55,3 +63,11 @@ Example:
> > >  		aspeed,reset-type = "system";
> > >  		aspeed,external-signal;
> > >  	};
> > > +
> > > +	#include <dt-bindings/watchdog/aspeed-wdt.h>
> > > +	wdt2: watchdog@1e785040 {
> > > +		compatible = "aspeed,ast2600-wdt";
> > > +		reg = <0x1e785040 0x40>;
> > > +		aspeed,reset-mask = <AST2600_WDT_RESET1_DEFAULT
> > > +				     (AST2600_WDT_RESET2_DEFAULT & ~AST2600_WDT_RESET2_LPC)>;
> > > +	};
> > 
> > Rob has acked your current approach already, but I do wonder about an
> > alternative that aligns more with the clock/reset/interrupt properties.
> > Essentially, define a new generic watchdog property that is specified on
> > the controllers to be reset by the watchdog (or even on just the
> > watchdog node itself, emulating what you've proposed here):
> > 
> > watchdog-resets = <phandle index>;
> > 
> > The phandle links to the watchdog of interest, and the index specifies
> > the controller associated with the configuration. It might even be
> > useful to do:
> > 
> > watchdog-resets = <phandle index enable>;
> > 
> > "enable" could provide explicit control over whether somethings should
> > be reset or not (as a way to prevent reset if the controller targeted by
> > the provided index would otherwise be reset in accordance with the
> > default reset value in the watchdog controller).
> > 
> > The macros from the dt-bindings header can then use macros to name the
> > indexes rather than define a mask tied to the register layout. The index
> > may still in some way represent the mask position. This has the benefit
> > of hiding the issue of one vs two configuration registers between the
> > AST2500 and AST2600 while also allowing other controllers to exploit the
> > binding (Nuvoton BMCs? Though maybe it's generalising too early?).
> > 
> 
> Sorry, I'm having a bit of a hard time picturing exactly what you're
> suggesting here...to start with:
> 
> > property that is specified on the controllers to be reset by the
> > watchdog
> 
> and
> 
> > or even on just the watchdog node itself
> 
> seem on the face of it like two fairly different approaches to me.  The
> former sounds more like existing clock/reset/etc. stuff, where the
> peripheral has a property describing its relationship to the "central"
> subsystem, and various peripheral drivers are all individually responsible
> for observing that property and calling in to the central subsystem to
> configure things for that peripheral appropriately; if I'm understanding you
> correctly, it might look something like:
> 
>   &spi1 {
>     watchdog-resets = <&wdt1 WDT_INDEX_SPI1 0>;
>   };
> 
> Or maybe something more like how pinctrl works, via phandles to subnodes of
> the central device?
> 
>   &wdt1 {
>     wdt1_spi1_reset: spi1_reset {
>       reg = <0x1c>;
>       bit = <24>;
>     };
>   };
> 
>   &spi1 {
>     watchdog-resets = <&wdt1_spi1_reset 0>;
>   };
> 
> Either way, it seems like it'd be complicated by any insufficient
> granularity in the watchdog w.r.t. having independent control over the
> individual devices represented by separate DT nodes (such as how the AST2500
> watchdog has a single SPI controller reset bit instead of one per SPI
> interface, or its "misc SOC controller" bit governing all sorts of odds and
> ends).
> 
> In the latter case (property on the wdt node), would it essentially just be
> kind of an indirection layer mapping hardware-independent device indices to
> specific registers/bits?  It's not obvious to me what purpose a phandle to
> the peripheral device node would serve (would the wdt driver have a good way
> of identifying what specific peripheral it's pointing to to know what bit to
> twiddle?), but maybe I'm misunderstanding what you're suggesting...
> 
> 
> I guess my other uncertainty is the balance between generalization and
> applicability -- how many other watchdog devices have sufficient comparable
> configurability to make use of it?  I haven't pored over all of them, but
> from a random sampling of 20 so of the other existing wdt drivers I don't
> see any obvious candidates -- the closest I saw were cpwd.c, which
> apparently can distinguish between a CPU reset and a CPU/backplane/board
> reset, and realtek_otto_wdt.c, which can do a CPU or a SOC reset (though I
> don't have any of the hardware docs to know what capabilities other devices
> might provide that the drivers don't use).  Do the Nuvoton BMCs have
> watchdogs with peripheral-granularity reset configuration?
> 

Quite frankly, I don't like where this is going. It is getting way
too complicated. And when something is becoming way too complicated,
I tend to put it on my backburner list. The length of that list quickly
approaches maxint.

Guenter
