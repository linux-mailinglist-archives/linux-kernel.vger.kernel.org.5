Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9877873D1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 17:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242104AbjHXPQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 11:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242089AbjHXPPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 11:15:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCD4199D;
        Thu, 24 Aug 2023 08:15:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 533966327D;
        Thu, 24 Aug 2023 15:15:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394B6C433C9;
        Thu, 24 Aug 2023 15:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692890132;
        bh=7VwnL8Kqzeq/1ZeBjWepo2f0bRj2CCuGL8qstPVUiak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nHIv7ex7FzG16L2QvDe6PfYu3Hz4NWLkw816pWVMEPHEwl2yIjDnb4Y8b2U7Eq69q
         LP9CxepPtbWO6geH9xnSly7ZDyasq7ubHKE5qxGqVu6dm6WuIpJok54XlZdrHQynSo
         azLi5RWhOx/7vW+4MmhXQMlsG9h/jO/EpQVja7K4=
Date:   Thu, 24 Aug 2023 17:15:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 000/194] 6.1.47-rc1 review
Message-ID: <2023082459-oxidize-script-77e4@gregkh>
References: <20230821194122.695845670@linuxfoundation.org>
 <991b93d2-9fde-4233-97d5-1133a9360d02@roeck-us.net>
 <2023082309-veggie-unwoven-a7df@gregkh>
 <CA+G9fYvwxuVpSn24YvtdNXaofg2JtZDREatOpDsKTVJX+nFN3Q@mail.gmail.com>
 <2d8a5f48-6c50-4c12-8a3d-23e621c6b722@roeck-us.net>
 <2023082325-expansion-revoke-1f3a@gregkh>
 <2023082401-arrange-bulk-d42a@gregkh>
 <4b8fcb23-c5e3-4bf1-957f-f0cc717564be@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b8fcb23-c5e3-4bf1-957f-f0cc717564be@roeck-us.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 08:08:19AM -0700, Guenter Roeck wrote:
> On Thu, Aug 24, 2023 at 03:35:55PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Aug 23, 2023 at 05:50:42PM +0200, Greg Kroah-Hartman wrote:
> > > On Wed, Aug 23, 2023 at 06:30:13AM -0700, Guenter Roeck wrote:
> > > > On Wed, Aug 23, 2023 at 01:47:39PM +0530, Naresh Kamboju wrote:
> > > > > On Wed, 23 Aug 2023 at 12:33, Greg Kroah-Hartman
> > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > >
> > > > > > On Tue, Aug 22, 2023 at 05:49:54PM -0700, Guenter Roeck wrote:
> > > > > > > On Mon, Aug 21, 2023 at 09:39:39PM +0200, Greg Kroah-Hartman wrote:
> > > > > > > > This is the start of the stable review cycle for the 6.1.47 release.
> > > > > > > > There are 194 patches in this series, all will be posted as a response
> > > > > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > > > > let me know.
> > > > > > > >
> > > > > > > > Responses should be made by Wed, 23 Aug 2023 19:40:45 +0000.
> > > > > > > > Anything received after that time might be too late.
> > > > > > > >
> > > > > > >
> > > > > > > Build results:
> > > > > > >       total: 157 pass: 156 fail: 1
> > > > > > > Failed builds:
> > > > > > >       m68k:sun3_defconfig
> > > > > > > Qemu test results:
> > > > > > >       total: 521 pass: 519 fail: 2
> > > > > > > Failed tests:
> > > > > > >       arm:fuji-bmc:aspeed_g5_defconfig:notests:mem1G:mtd128,0,8,1:net,nic:aspeed-bmc-facebook-fuji:f2fs
> > > > > > >       arm:bletchley-bmc,fmc-model=mt25qu02g,spi-model=mt25qu02g:aspeed_g5_defconfig:notests:mem1G:mtd256:net,nic:aspeed-bmc-facebook-bletchley:f2fs
> > > > > > >
> > > > > > > The m68k build failure is
> > > > > > >
> > > > > > > Inconsistent kallsyms data
> > > > > > > Try make KALLSYMS_EXTRA_PASS=1 as a workaround
> > > > > > >
> > > > > > > I already have KALLSYMS_EXTRA_PASS=1 enabled, so that doesn't help.
> > > > > > > Nothing to worry about. The f2fs crashes are still seen. They
> > > > > > > also happen for other architectures, so it is not just an arm problem.
> > > > > > > I'll probably just disable all f2fs testing going forward. If so I'll
> > > > > > > send a note clarifying that the lack of reported test failures doesn't
> > > > > > > mean that it works.
> > > > > >
> > > > > > I'll look into this later this week, next week to resolve the f2fs
> > > > > > stuff.  I wanted to get to the other known bug fixes first.
> > > > > >
> > > > > > > For x86 I get the same runtime warning as everyone else.
> > > > > >
> > > > > > Yeah, this is troubling...
> > > > > >
> > > > > > Is it clang only?  I'll dig into this today...
> > > > > 
> > > > > It is seen with gcc-13 and clang-17 with few extra configs.
> > > > > We are not booting defconfig.
> > > > > 
> > > > > The Kconfigs are enabled with KFENCE.
> > > > > 
> > > > I have KFENCE enabled as well, so it may well be that this triggers
> > > > the warning. I don't see it in 6.4.y or upstream, though.
> > > 
> > > Ok, let me rip out all the x86 and objtool patches from this release,
> > > get it out the door with the good things in there that everyone else
> > > needs, and then we can focus on this mess...
> > > 
> > > Maybe I'll just backport _all_ objtool changes to sync things up better,
> > > last time I tried that it was a maze of twisty passages, all coated in
> > > assembly...
> > 
> > I got lost in the maze again today, ick.
> > 
> > Anyway, I give up.  I'm just going to push out a -rc1 with just these
> > changes in it today, and if people are upset about the runtime warning,
> > then they can provide a working backport of this objtool patch.
> > 
> 
> Or maybe just revert all srso patches.

Hah, I wish.

{sigh}

I've notified the patch authors about this, hopefully they can come up
with something.

> > Ideally, the CPU vendor who is causing this mess will do that, as it's
> > their issue we are spending all of this time on, not Linux's issue.
> > 
> > Also, oddly, I can not reproduce this problem here on my hardware at
> > all.  Maybe because it's an AMD processor?  If so, makes sense, as the
> > SRSO issue is only for Intel chips.
> > 
> 
> Apparently I am lost in the maze as well. I am quite sure that SRSO
> only applies to AMD CPUs, and
> 
> arch/x86/Kconfig:config CPU_SRSO
> arch/x86/Kconfig:         Enable the SRSO mitigation needed on AMD Zen1-4 machines.
> 
> seems to confirm that. What am I missing ? Do you mean the warning that
> was supposed to be fixed with the objtool patch(es) is only seen on Intel
> chips ?

Ah, sorry, my confusion (too many different cpu bugs lately)

This might be an issue on AMD chips, but for some reason, in running
this kernel on my systems here, I have no boot warnings at all.  I
blamed it on them being only AMD chips.  If that's not the issue then I
really have no idea, sorry.

thanks,

greg k-h
