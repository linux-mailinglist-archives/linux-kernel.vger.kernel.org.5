Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3D97BB7DA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 14:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjJFMjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 08:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjJFMji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 08:39:38 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D316C2
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 05:39:36 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9ada2e6e75fso385998366b.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 05:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696595975; x=1697200775; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zSVbwuMngsJ15cLY6pR9vh3z/k0osdSclV2xxkOB8v0=;
        b=gJQofOvWKSI91TgYvaCG3Iw9Li6ENlejfD2PB5BVL31oJpbfNrpIfY8DSMu78Z0KWv
         t9jPtxhNIvRnNViPROZE7ekLYA7oEFYc6TFi+MGxibTiyctAGHAecyOMJfc/OACO5WHL
         hyqC9V27dU6aALCpyNhQ6600oSqsOfndJ7rBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696595975; x=1697200775;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zSVbwuMngsJ15cLY6pR9vh3z/k0osdSclV2xxkOB8v0=;
        b=hqjHhdFwpZ/KZNBNGe5IZt62ri/IRrjbGTuh3PcA8JUCyfyKxdw4CfivzjmG1Bqy9z
         PEOt1JTXN5mwaE8Jxk2OVgygZPTpa9+GiXexjZzycRxn5R7THDdfVNxFfmPZ9diBr2Ex
         KTgx/veUszi1GK8kc6DIqHmL4nz8NG1Dg+sdSnqGTG9M8cyfKFoV68RHCJp1o5CzimcI
         1nZrsFhKdgZDvrUavBttUjn495YCLnZo0PrCTNWEQe5NOvJdAXcT7RZBNsfkEz6vMYgH
         e50yYKVBeXX6VXB0xHjFNSEnDqZiVbLovEpeNj+jpbuO9Cjd22ovEdOlvHS/YbR1c5mV
         xWYA==
X-Gm-Message-State: AOJu0YzKZ2lwYxR9QWT+ELOUzYEWWDGbvsjKWkQqfJ1IfdWvjEiWov8j
        RyWA1jOzS81CszmWV/k9Rv9U5qu0gYA1iDhVPpLN6A==
X-Google-Smtp-Source: AGHT+IHF9InDrK2DzmRcPJNljvQBGZsJ+Z8ieD2aVFJnvMVrHvX/38WK/Aqqz8/EkfszHWgRPCHmcw5S2YTuy902ocY=
X-Received: by 2002:a17:906:5342:b0:9ad:ef08:1f32 with SMTP id
 j2-20020a170906534200b009adef081f32mr7684677ejo.37.1696595974780; Fri, 06 Oct
 2023 05:39:34 -0700 (PDT)
MIME-Version: 1.0
References: <20231004093620.2b1d6917@xps-13> <20231004113458.531124-1-mwalle@kernel.org>
 <CAPnjgZ2hWE6Sc=rg55W=-r-TnoWP7Y5gSpn41kwoyja-AMVw+w@mail.gmail.com>
 <9e588e3ec8c0c321a2861723d0d42b9a@kernel.org> <CAPnjgZ20ezipPWAj6bUM9_oCTcX1XzuLqQ7b7-nKjXf1t4p9-Q@mail.gmail.com>
 <a581ef73fa09c6ffeb83a1c1780053bd@kernel.org> <CAPnjgZ2PnKD5m0EgTdEAf-gcK3wuBZvWw_AO2iehb1dmfdoz3A@mail.gmail.com>
 <27d37d4c7cf353d99737a1e7a450f9f7@kernel.org>
In-Reply-To: <27d37d4c7cf353d99737a1e7a450f9f7@kernel.org>
From:   Simon Glass <sjg@chromium.org>
Date:   Fri, 6 Oct 2023 06:39:16 -0600
Message-ID: <CAPnjgZ0OZubVaj1RR6rWrJu2MWD=4PEPOD39zhaHgm6OzsyQnw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: mtd: fixed-partitions: Add binman compatible
To:     Michael Walle <mwalle@kernel.org>
Cc:     miquel.raynal@bootlin.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        ptyadav@amazon.de, rafal@milecki.pl, richard@nod.at,
        robh+dt@kernel.org, robh@kernel.org, trini@konsulko.com,
        u-boot@lists.denx.de, vigneshr@ti.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Fri, 6 Oct 2023 at 02:37, Michael Walle <mwalle@kernel.org> wrote:
>
> Hi,
>
> >> I'm still not sure why that compatible is needed. Also I'd need to
> >> change
> >> the label which might break user space apps looking for that specific
> >> name.
> >>
> >> Also, our board might have u-boot/spl or u-boot/spl/bl31/bl32, right
> >> now
> >> that's something which depends on an u-boot configuration variable,
> >> which
> >> then enables or disables binman nodes in the -u-boot.dtsi. So in linux
> >> we only have that "bootloader" partition, but there might be either
> >> u-boot+spl or u-boot+spl+bl31+bl32.
> >>
> >> Honestly, I'm really not sure this should go into a device tree.
> >
> > I think we might be getting a bit ahead of ourselves here. I thought
> > that the decision was that the label should indicate the contents.
> > If you have multiple things in a partition then it would become a
> > 'section' in Binman's terminology. Either the label programmatically
> > describes what is inside or it doesn't. We can't have it both ways.
> > What do you suggest?
>
> As Rob pointed out earlier, it's just a user-facing string. I'm a bit
> reluctant to use it programatically.
> Taking my example again, the string "bootloader" is sufficient for a
> user. He doesn't care if it's u-boot with spl or u-boot with tfa, or
> even coreboot. It just says, "in this partition is the bootloader".
> If you have an "bootloader" image you can flash it there.
>
> If it has a label "u-boot" and I want to switch to coreboot, will
> it have to change to "coreboot"? I really don't think this is practical,
> you are really putting software configuration into the device tree.

I thought Rob changed his mind on that?

I agree that compatible would make things easier. We could then
continue to use 'label' for whatever it currently has.

Note that some kernel drivers or user space will want to look at what
is there, e.g. to provide a way to extract, check or update a
particular part of the firmware.

>
> > At present it seems you have the image described in two places - one
> > is the binman node and the other is the partitions node. I would like
> > to unify these.
>
> And I'm not sure that will work for all the corner cases :/
>
> If you keep the binman section seperate from the flash partition
> definition you don't have any of these problems, although there is
> some redundancy:
>   - you only have compatible = "binman", "fixed-partition", no further
>     compatibles are required
>   - you don't have any conflicts with the current partition descriptions
>   - you could even use the labels, because binman is the (only?) user
>
> But of course you need to find a place where to put your node.

Sure, but I was pointed to partitions as the place where this should live.

>
> > What does user space do with the partition labels?
>
> I'm not sure. Also I'm not sure if it really matters, I just wanted to
> point out, that you'll force users to change it.

OK I'll send a version that uses compatible strings and see if that
makes any progress.

Regards,
Simon

>
> -michael
>
> >> >> What if a board uses eMMC to store the firmware binaries? Will that
> >> >> then
> >> >> be a subnode to the eMMC device?
> >> >
> >> > I thought there was a way to link the partition nodes and the device
> >> > using a property, without having the partition info as a subnode of
> >> > the device. But I may have imagined it as I cannot find it now. So
> >> > yes, it will be a subnode of the eMMC device.
> >>
> >> Not sure if that will fly.
> >
> > I can't find it anyway. There is somelike like that in
> > simple-framebuffer with the 'display' property.
> >
> > Regards,
> > SImon
