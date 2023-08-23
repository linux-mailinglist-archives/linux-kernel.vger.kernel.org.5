Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A4D7852ED
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 10:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbjHWIox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 04:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234691AbjHWIcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:32:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4792117;
        Wed, 23 Aug 2023 01:27:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42D306162C;
        Wed, 23 Aug 2023 08:27:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E052DC433C8;
        Wed, 23 Aug 2023 08:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692779268;
        bh=69PE5gQJiEYod7ui+fX3bPowl/3d8H9a0vbiN23RpbU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F6B+Q51Ark3YyhyQYI+f5ShRZBV6Eb14sfSF9c4jRk1K4blvwvkKmjlavHJ7ZZ5lk
         otCmJqhcRJuWT0woMWMAbfXanaF2N99Oi6BxHG3PfimciuxANrvk39zlShnpPIM6O5
         9qAGW+cXpHzX9KpJOUHnHvaS/P7i3Dd3eV5GpBi0=
Date:   Wed, 23 Aug 2023 10:27:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 000/194] 6.1.47-rc1 review
Message-ID: <2023082357-doing-throwback-c9f0@gregkh>
References: <20230821194122.695845670@linuxfoundation.org>
 <991b93d2-9fde-4233-97d5-1133a9360d02@roeck-us.net>
 <2023082309-veggie-unwoven-a7df@gregkh>
 <CA+G9fYvwxuVpSn24YvtdNXaofg2JtZDREatOpDsKTVJX+nFN3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYvwxuVpSn24YvtdNXaofg2JtZDREatOpDsKTVJX+nFN3Q@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 01:47:39PM +0530, Naresh Kamboju wrote:
> On Wed, 23 Aug 2023 at 12:33, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Aug 22, 2023 at 05:49:54PM -0700, Guenter Roeck wrote:
> > > On Mon, Aug 21, 2023 at 09:39:39PM +0200, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 6.1.47 release.
> > > > There are 194 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > >
> > > > Responses should be made by Wed, 23 Aug 2023 19:40:45 +0000.
> > > > Anything received after that time might be too late.
> > > >
> > >
> > > Build results:
> > >       total: 157 pass: 156 fail: 1
> > > Failed builds:
> > >       m68k:sun3_defconfig
> > > Qemu test results:
> > >       total: 521 pass: 519 fail: 2
> > > Failed tests:
> > >       arm:fuji-bmc:aspeed_g5_defconfig:notests:mem1G:mtd128,0,8,1:net,nic:aspeed-bmc-facebook-fuji:f2fs
> > >       arm:bletchley-bmc,fmc-model=mt25qu02g,spi-model=mt25qu02g:aspeed_g5_defconfig:notests:mem1G:mtd256:net,nic:aspeed-bmc-facebook-bletchley:f2fs
> > >
> > > The m68k build failure is
> > >
> > > Inconsistent kallsyms data
> > > Try make KALLSYMS_EXTRA_PASS=1 as a workaround
> > >
> > > I already have KALLSYMS_EXTRA_PASS=1 enabled, so that doesn't help.
> > > Nothing to worry about. The f2fs crashes are still seen. They
> > > also happen for other architectures, so it is not just an arm problem.
> > > I'll probably just disable all f2fs testing going forward. If so I'll
> > > send a note clarifying that the lack of reported test failures doesn't
> > > mean that it works.
> >
> > I'll look into this later this week, next week to resolve the f2fs
> > stuff.  I wanted to get to the other known bug fixes first.
> >
> > > For x86 I get the same runtime warning as everyone else.
> >
> > Yeah, this is troubling...
> >
> > Is it clang only?  I'll dig into this today...
> 
> It is seen with gcc-13 and clang-17 with few extra configs.
> We are not booting defconfig.
> 
> The Kconfigs are enabled with KFENCE.
> 
> I see this from lore
> "
> This is from overnight testing that hit this only in the KCSAN runs.
> The KASAN and non-debug runs had no trouble.
> 
> Thanx, Paul
> 
> "

Ok, that's good, it's not going to hit "normal" users...  :)

> 
> steps to reproduce:
> -------------------
> tuxmake --runtime podman --target-arch x86_64 --toolchain gcc-13
> --kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2UJAv99Wwi6YMltFjlQD5XRO5x4/config
> 
> 
> Here is the links to details and build details,
> [1]
> https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.46-195-g5165f4e9738c/testrun/19256276/suite/log-parser-boot/test/check-kernel-exception/details/
> 
> [2]
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2UJAv99Wwi6YMltFjlQD5XRO5x4/
> 
> [3]
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2UJAv99Wwi6YMltFjlQD5XRO5x4/config

You are going to force me to use tuxmake again, aren't you...

I'll dig into this after lunch.

greg k-h
