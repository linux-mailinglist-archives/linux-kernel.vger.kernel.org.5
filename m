Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD2875DF8D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 03:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjGWBRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 21:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGWBRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 21:17:15 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A3F1FCB;
        Sat, 22 Jul 2023 18:17:14 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6b9c9944da8so2618348a34.3;
        Sat, 22 Jul 2023 18:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690075034; x=1690679834;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jq18TQbFJVUbRS2A9/AE9j8fQVqfGncfEJK6UGNMjtA=;
        b=jltIEs0l3MyofZeB7aYzlzzBBctV1vBEHXCODMrHe4bY7KIVX5+0QQkjQPcM+hfMuK
         Fn7cwVgIBfE+mw7bNfnSW1KzK6WOek1GlDD9wc5pbfKJUdyaT/vRUs27IGn7blM42Nyq
         scITMQsQWWDTbM2S/9UkSiWFLFiT9UKQZOi/ihyv6WXXlZaSYnvKpvuLEeSZjKNyaV+w
         6pZCFUYm1zNG0iKQsX7UUW/nRSzmNdW+ldutRb2xDLe5Cuh94Nop3SGBjnZ8Pl0qDK7I
         5VoM9KsZu8A9vibx8p3x2PGTeIZsyn2yyXw7LeHocUHfp0axVi871Un/aXBpPKz6GUSo
         Fp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690075034; x=1690679834;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jq18TQbFJVUbRS2A9/AE9j8fQVqfGncfEJK6UGNMjtA=;
        b=Dc38mnx8x/JNDQJpbNY7iVEr9wjGp4bPCGPpfLwc/2/P0jpXdI5aC4UvEiemjZ70+l
         J/QqB+kWD7XLMyn2rT0vgn2WePBEQnoddfg1f0wSMNDXjIYAglGkwdTmP+MWMj9punaE
         KESOrLVtnlxLHuNlOrS40sYLxdDmxZzJQBsSFPfu/9uzaN8O+q252sBmReryrWLskHtl
         lUvKe4+XGUtXLlJfrqr62yq27agquIWBkEtf87k3/JD7X8zY1QkdliJhcKGTv4le0tcL
         /33Jvu5E32iDOI9Mr7kK1KqvzVXoBkf+oEIteCRIE3XS9ER26lCnK9sx6I0Ca1mDuiB/
         SAew==
X-Gm-Message-State: ABy/qLapmWNryGzbXU9f/ChIgXK4ZXyl9Eei80Vl8DNsY6slJcK1rGd4
        pA2SYIlh9K7tfxroes/qqbkiEo2om0E9dj0ysMinyPhq
X-Google-Smtp-Source: APBJJlEB4n30cmwxjiC1uj2ildKP/OpO71rAhdB/lyLvvZcnPo3SjOqFggSAa68bJZn2KMsOY+VtVcULNVYzz8GWmq4=
X-Received: by 2002:a05:6870:a91e:b0:1b7:3fd5:87cd with SMTP id
 eq30-20020a056870a91e00b001b73fd587cdmr5395563oab.48.1690075033855; Sat, 22
 Jul 2023 18:17:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230717131756.240645-1-biju.das.jz@bp.renesas.com>
 <20230717131756.240645-2-biju.das.jz@bp.renesas.com> <ZLVlIPHdmEGdG5D1@google.com>
 <OS0PR01MB592264ADC86061AB003048DD863BA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <66228ad3-c087-418c-925f-b9fd4a60fb16@sirena.org.uk> <ZLWIPPAfeR1+KbeH@google.com>
 <OS0PR01MB59225D8CF3E96808DD776A8E863BA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <ZLbbslBiIQXFWpmN@google.com> <TYCPR01MB593346FBBA320260A290EAFD8639A@TYCPR01MB5933.jpnprd01.prod.outlook.com>
 <ZLsCOj1t4JvG3SEp@google.com> <TYCPR01MB5933D4252360AAE57D90FE1C863CA@TYCPR01MB5933.jpnprd01.prod.outlook.com>
In-Reply-To: <TYCPR01MB5933D4252360AAE57D90FE1C863CA@TYCPR01MB5933.jpnprd01.prod.outlook.com>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Sat, 22 Jul 2023 18:17:02 -0700
Message-ID: <CAKdAkRT9tMnLnDLgWAevE_4HQ0wYMPehvsYaAeYrXdGGiyjXRA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Input: exc3000 - Simplify probe()
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Andreas Helbech Kleist <andreaskleist@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 22, 2023 at 05:51:17PM +0000, Biju Das wrote:
> Hi Dmitry Torokhov,
>
> Thanks for the feedback.
>
> > Subject: Re: [PATCH v2 1/2] Input: exc3000 - Simplify probe()
> >
> > On Wed, Jul 19, 2023 at 06:43:47AM +0000, Biju Das wrote:
> > > Hi Dmitry Torokhov,
> > >
> > > Thanks for the feedback.
> > >
> > > > Subject: Re: [PATCH v2 1/2] Input: exc3000 - Simplify probe()
> > > >
> > > > On Mon, Jul 17, 2023 at 06:45:27PM +0000, Biju Das wrote:
> > > > > Hi Dmitry,
> > > > >
> > > > > > Subject: Re: [PATCH v2 1/2] Input: exc3000 - Simplify probe()
> > > > > >
> > > > > > On Mon, Jul 17, 2023 at 07:15:50PM +0100, Mark Brown wrote:
> > > > > > > On Mon, Jul 17, 2023 at 04:35:02PM +0000, Biju Das wrote:
> > > > > > >
> > > > > > > > The .device_get_match_data callbacks are missing for I2C and
> > > > > > > > SPI bus
> > > > > > subsystems.
> > > > > > > > Can you please throw some lights on this?
> > > > > > >
> > > > > > > It's the first time I've ever heard of that callback, I don't
> > > > > > > know why whoever added it wouldn't have done those buses in
> > > > > > > particular or if it just didn't happen.  Try adding it and if
> > > > > > > it works send
> > > > the patches?
> > > > > >
> > > > > > I think there is a disconnect. Right now device_get_match_data
> > > > > > callbacks are part of fwnode_operations. I was proposing to add
> > > > > > another optional device_get_match_data callback to 'struct
> > bus_type'
> > > > > > to allow individual buses control how match data is handled,
> > > > > > before (or after) jumping into the fwnode-backed
> > > > > > device_get_match_data
> > > > callbacks.
> > > > >
> > > > > That is what implemented here [1] and [2] right?
> > > > >
> > > > >
> > > > > First it check for fwnode-backed device_get_match_data callbacks
> > > > > and Fallback is bus-type based match.
> > > > >
> > > > > Looks like you are proposing to unify [1] and [2] and you want the
> > > > > logic to be other way around. ie, first bus-type match, then
> > > > > fwnode-backed callbacks?
> > > > >
> > > >
> > > > I do not have a strong preference for the ordering, i.e. I think it
> > > > is perfectly fine to do the generic fwnode-based lookup and if there
> > > > is no match have bus method called as a fallback,
> > >
> > > That involves a bit of work.
> > >
> > > const void *device_get_match_data(const struct device *dev);
> > >
> > > const struct i2c_device_id *i2c_match_id(const struct i2c_device_id
> > *id,
> > >                                    const struct i2c_client *client);
> > >
> > > const struct spi_device_id *spi_get_device_id(const struct spi_device
> > > *sdev);
> > >
> > > Basically, the bus-client driver(such as exc3000) needs to pass struct
> > > device and device_get_match_data after generic fwnode-based lookup,
> > > needs to find the bus type based on struct device and call a new
> > > generic
> > > void* bus_get_match_data(void*) callback, so that each bus interface
> > > can do a match.
> >
> > Yes, something like this (which does not seem that involved to me...):
>
> Looks it will work.
>
> But there is some 2 additional checks in core code, every driver which is not bus type need to go through this checks.
>
> Also in Bus specific callback, there are 2 additional checks.
>
> So, performance wise [1] is better.

I do not believe this is a concern whatsoever: majority of
architectures/boards have been converted to ACPI/DT, which are being
matched first as they are now, so the fallback to bus-specific matching
against bus-specific device ID tables will be very infrequent.
Additionally, device_get_match_data() is predominantly called from
driver probe paths, so we need not be concerned with it being used with
class devices or other kinds of devices not associated with a bus.

>
> Moreover, we need to avoid code duplication with [1]
>
> [1] https://elixir.bootlin.com/linux/v6.5-rc2/source/drivers/i2c/i2c-core-base.c#L125

If and when my proposed solution gets into the kernel we can drop
i2c_get_match_data() altogether.

Thanks.


--
Dmitry
