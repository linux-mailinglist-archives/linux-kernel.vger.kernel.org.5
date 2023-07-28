Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAE27676E8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 22:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbjG1USy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 16:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbjG1USc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 16:18:32 -0400
X-Greylist: delayed 470 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 28 Jul 2023 13:18:29 PDT
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63D62D75;
        Fri, 28 Jul 2023 13:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1690575037; bh=MtbowmUPW/KlSYKyYheL1Gy0Tj8pJ1m2CPlyeud3blo=;
        h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
        b=zNnEFCGMd3SOjwEr7PhPC7Tt4w7JouLZ2HN6SpPUF/ybtpnB0eDOmENYpp5rP4+v3
         ODvwC8l9COkf8V64+My6OFSZMNvmLdbuY1MN8XRYTJ1CU8lLvJKKW1DBNUb2bJuvMJ
         k9q2ZQkgbOdCofEW6kT5l5iTfounQlvnyxIfSiF4=
Date:   Fri, 28 Jul 2023 22:10:36 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org,
        Peter Robinson <pbrobinson@gmail.com>,
        Caleb Connolly <kc@postmarketos.org>,
        Jarrah Gosbell <kernel@undef.tools>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martijn Braam <martijn@brixit.nl>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: Change serial baud rate for
 Pinephone Pro to 1.5 MB
Message-ID: <nk22axbl47myincpxnhcygtb5viyldv6fkxng3m43yd7dwbzau@p6ycsad6uoqr>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
        Heiko Stuebner <heiko@sntech.de>, Peter Geis <pgwipeout@gmail.com>, 
        Javier Martinez Canillas <javierm@redhat.com>, linux-kernel@vger.kernel.org, 
        Peter Robinson <pbrobinson@gmail.com>, Caleb Connolly <kc@postmarketos.org>, 
        Jarrah Gosbell <kernel@undef.tools>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
        Martijn Braam <martijn@brixit.nl>, Rob Herring <robh+dt@kernel.org>, 
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
        linux-rockchip@lists.infradead.org
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20230403175937.2842085-1-javierm@redhat.com>
 <3797122.KgjxqYA5nG@diego>
 <87pm4kuanl.fsf@minerva.mail-host-address-is-not-set>
 <4495367.TLkxdtWsSY@phil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4495367.TLkxdtWsSY@phil>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko and Javier,

On Fri, Jul 28, 2023 at 08:59:50PM +0200, Heiko Stuebner wrote:
> 
> Hi Javier,
> 
> > Probably won't replace the DTB shipped with the firmware either? If one is
> > replacing the firmware provided DTB witch the one in the mainline kernel,
> > probably such person is also using mainline u-boot?
> 
> Not necessarily.
> 
> I.e. putting an extlinux.conf on an sd-card with a kernel-image and dtb
> is not rocket science ;-)
> 
> > For someone like me who is only using mainline u-boot, linux, etc then
> > having a consistent uart baud rate across all components is really useful.
> > 
> > Otherwise I either have serial console for u-boot or the kernel, but can't
> > have both working so is annoying.
> > 
> > It would be good to have a definite answer on this. Since every time that
> > I try to hack on my PPP, I end changing my DTS and remember this patch :)
> 
> So far people only reported "breaks my setup". I'm in a pickle here ;-) .
> Without anybody saying "I want to also move into this direction" I really
> feel I should not merge a patch that breaks other peoples setups.

Even if this is not changed in kernel, bootloader should fix this situation by
patching the kernel DTB before booting the kernel. U-Boot already patches the
DTB in several ways, so I guess it's possible to just change stdout-path either
in generic code, or in per-board ft_board_setup() for Pinephone Pro to something
that matches whatever the user configured via Kconfig:

https://elixir.bootlin.com/u-boot/latest/source/configs/pinephone-pro-rk3399_defconfig#L79

I mean that if U-Boot allows the user to configure arbitrary baudrate via
KConfig, then it *should* also update the kernel DTB to match, especially if the
choice is different from DTB that it actually embeds:

https://elixir.bootlin.com/u-boot/latest/source/arch/arm/dts/rk3399-pinephone-pro.dts#L29

No static baudrate choice in DT will save anyone anyway, with the provided flexibility
of configuration.

Maybe this would be a nice location to fix this:

https://elixir.bootlin.com/u-boot/v2023.07.02/source/common/fdt_support.c#L131

kind regards,
	o.

> 
> Heiko
> 
> 
