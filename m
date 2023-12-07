Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1158080FB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 07:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjLGGoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 01:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjLGGoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 01:44:15 -0500
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3467BD7F;
        Wed,  6 Dec 2023 22:44:22 -0800 (PST)
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
        by mail5.25mail.st (Postfix) with ESMTPSA id D55AE6045F;
        Thu,  7 Dec 2023 06:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
        s=25mailst; t=1701931461;
        bh=nJmFuXQf9RfNTr9UuRgO4Hc4w3gZivv6FvKt1ZS32ng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IrRFqxFxt9IwRGnDy4eKNbzra9+kK+MNCN5HzI7FE+tDi0u3uCDUfI2InxQ2Gk+q3
         RMt6Ccx+vm9z0zZJkMeMuleUZRlAMKIfIFLRaGH0RyCuwfc7Eu9bpJi480d5bih1Zo
         My/LD9Zn5wiUe5R/2EQ/8G/z4O6PQo+llw5/AWU7CzREV0wZvYOl8F3qrKIzvWAoqY
         ZZLLQUDYR2EBmfWKukj9trCrpVv13ZkIsiCA6iZL4pyTNBpOqlHj397UCNzG+Td/ul
         AZQATRAHMVmZc9RQhn+zthYvQxf9+xY+b1MT3MS5AR+g9KtBOUadRY5k0+mHtVLt+F
         G09+T9e60N14g==
Date:   Thu, 7 Dec 2023 08:43:59 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Adam Ford <aford173@gmail.com>
Cc:     Andreas Kemnade <andreas@kemnade.info>, lee@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, bcousson@baylibre.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH v3 6/6] ARM: dts: omap: gta04: standardize
 system-power-controller
Message-ID: <20231207064359.GS5169@atomide.com>
References: <20231203222903.343711-1-andreas@kemnade.info>
 <20231203222903.343711-7-andreas@kemnade.info>
 <CAHCN7xKG6-vgnJ+mA8xt0aFK-jCBWOX-GkVmJGNERH43N0ikaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHCN7xKG6-vgnJ+mA8xt0aFK-jCBWOX-GkVmJGNERH43N0ikaw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Adam Ford <aford173@gmail.com> [231203 22:46]:
> On Sun, Dec 3, 2023 at 4:29 PM Andreas Kemnade <andreas@kemnade.info> wrote:
> >
> > Replace TI-specific property by generic one.
> >
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> > cannot be applied independently of the other ones, so maybe simply delay
> > it.
> >
> >  arch/arm/boot/dts/ti/omap/omap3-gta04.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/boot/dts/ti/omap/omap3-gta04.dtsi b/arch/arm/boot/dts/ti/omap/omap3-gta04.dtsi
> > index 3661340009e7a..5001c4ea35658 100644
> > --- a/arch/arm/boot/dts/ti/omap/omap3-gta04.dtsi
> > +++ b/arch/arm/boot/dts/ti/omap/omap3-gta04.dtsi
> > @@ -476,6 +476,7 @@ twl: twl@48 {
> >                 reg = <0x48>;
> >                 interrupts = <7>; /* SYS_NIRQ cascaded to intc */
> >                 interrupt-parent = <&intc>;
> > +               system-power-controller;
> 
> Could this go into the twl4030.dtsi file so we don't have every omap3
> board with this part duplicating this line?

Sounds good to me.

Regards,

Tony
