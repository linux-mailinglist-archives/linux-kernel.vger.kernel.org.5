Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E907D4A94
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbjJXIlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjJXIlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:41:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF7599;
        Tue, 24 Oct 2023 01:41:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB77BC433CC;
        Tue, 24 Oct 2023 08:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698136895;
        bh=4eFu4rt7wR4jt5IgYVUl8wvT/+YjiWdAY2/ByetleT0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZPhaXG/UtL5sd4cBIff03LX7/uXLzIR4uYDwsHOVHWiKv8FLzk51j2uuNu1bL6lSO
         otKK8Ky2qfj9f6QKgB2soBD35mW6GimWcZ8KPzrr0KtwOSY8rv2EAy5oKM2T4opug4
         L6f//B6p0bZn7QXv3wZsBYzwGRSicNqqPFzifNb0=
Date:   Tue, 24 Oct 2023 10:41:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 5.15 000/137] 5.15.137-rc1 review
Message-ID: <2023102413-delirium-manliness-d8b4@gregkh>
References: <20231023104820.849461819@linuxfoundation.org>
 <724521b8-9c63-4645-b3e0-30d9635573a7@linaro.org>
 <CAEUSe7-zbuRsgsr2EYq+OeW9iEJyZHmo8u9K3pDCAFRKnCEv0A@mail.gmail.com>
 <CAMuHMdXYB6QAE15RYs7eg9sVofesqNN1+vmPHkosqC_8A-JTSg@mail.gmail.com>
 <9737cd7b-f3c6-7e90-f92c-0ceeed788980@roeck-us.net>
 <2023102453-backspin-immunize-b110@gregkh>
 <CAMuHMdVR9KFdu=t=8cowyY_-88Hutd-1OxKh6w+f+Cu+YXgtWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdVR9KFdu=t=8cowyY_-88Hutd-1OxKh6w+f+Cu+YXgtWQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 10:35:05AM +0200, Geert Uytterhoeven wrote:
> Hi Greg,
> 
> On Tue, Oct 24, 2023 at 10:31 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Mon, Oct 23, 2023 at 12:56:48PM -0700, Guenter Roeck wrote:
> > > On 10/23/23 11:50, Geert Uytterhoeven wrote:
> > > > CC maz
> > > >
> > > > On Mon, Oct 23, 2023 at 7:17 PM Daniel Díaz <daniel.diaz@linaro.org> wrote:
> > > > > On Mon, 23 Oct 2023 at 09:11, Daniel Díaz <daniel.diaz@linaro.org> wrote:
> > > > > > On 23/10/23 4:55 a. m., Greg Kroah-Hartman wrote:
> > > > > > > This is the start of the stable review cycle for the 5.15.137 release.
> > > > > > > There are 137 patches in this series, all will be posted as a response
> > > > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > > > let me know.
> > > > > > >
> > > > > > > Responses should be made by Wed, 25 Oct 2023 10:47:57 +0000.
> > > > > > > Anything received after that time might be too late.
> > > > > > >
> > > > > > > The whole patch series can be found in one patch at:
> > > > > > >        https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.137-rc1.gz
> > > > > > > or in the git tree and branch at:
> > > > > > >        git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> > > > > > > and the diffstat can be found below.
> > > > > > >
> > > > > > > thanks,
> > > > > > >
> > > > > > > greg k-h
> > > > > >
> > > > > > We see lots of errors on Arm 32-bits:
> > > > > >
> > > > > > -----8<-----
> > > > > > /builds/linux/drivers/gpio/gpio-vf610.c:249:11: error: 'IRQCHIP_IMMUTABLE' undeclared here (not in a function); did you mean 'IS_IMMUTABLE'?
> > > > > >     .flags = IRQCHIP_IMMUTABLE | IRQCHIP_MASK_ON_SUSPEND
> > > > > >              ^~~~~~~~~~~~~~~~~
> > > > > >              IS_IMMUTABLE
> > > > > > /builds/linux/drivers/gpio/gpio-vf610.c:251:2: error: 'GPIOCHIP_IRQ_RESOURCE_HELPERS' undeclared here (not in a function)
> > > > > >     GPIOCHIP_IRQ_RESOURCE_HELPERS,
> > > > > >     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > > /builds/linux/drivers/gpio/gpio-vf610.c:251:2: warning: excess elements in struct initializer
> > > > > > /builds/linux/drivers/gpio/gpio-vf610.c:251:2: note: (near initialization for 'vf610_irqchip')
> > > > > > /builds/linux/drivers/gpio/gpio-vf610.c: In function 'vf610_gpio_probe':
> > > > > > /builds/linux/drivers/gpio/gpio-vf610.c:340:2: error: implicit declaration of function 'gpio_irq_chip_set_chip'; did you mean 'gpiochip_get_data'? [-Werror=implicit-function-declaration]
> > > > > >     gpio_irq_chip_set_chip(girq, &vf610_irqchip);
> > > > > >     ^~~~~~~~~~~~~~~~~~~~~~
> > > > > >     gpiochip_get_data
> > > > > > cc1: some warnings being treated as errors
> > > > > > ----->8-----
> > > > >
> > > > > Bisection points to "gpio: vf610: make irq_chip immutable" (upstream
> > > > > commit e6ef4f8ede09f4af7cde000717b349b50bc62576).
> > > >
> > > > IRQCHIP_IMMUTABLE was introduced in commit 6c846d026d490b23 ("gpio:
> > > > Don't fiddle with irqchips marked as immutable") in v5.19.
> > > > Backporting (part of) that is probably not safe.
> > > >
> > >
> > > In this context: What exactly does commit e6ef4f8ede09 fix that makes it
> > > a stable release candidate ?
> >
> > It is needed as a dependency for 430232619791 ("gpio: vf610: mask the
> > gpio irq in system suspend and support wakeup") which says it:
> >   Fixes: 7f2691a19627 ("gpio: vf610: add gpiolib/IRQ chip driver for Vybrid")
> > which was in the 3.19 kernel release.
> >
> > That's why it was added.  And then none of my x86 builds caught this
> > build failure before I pushed out the -rcs.
> 
> Ah, the difference between semantic and lexical changes ;-)
> 
> The proper backport would be to just add
> 
>        .flags = IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND,
> 
> Don't bother with the IRQCHIP_IMMUTABLE.

Thanks, I'll look into that after this round of stable kernels are
released.

greg k-h
