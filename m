Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9CF07CC8D0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 18:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343653AbjJQQ3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 12:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234868AbjJQQ3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 12:29:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CD6FA;
        Tue, 17 Oct 2023 09:29:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E9EC433C8;
        Tue, 17 Oct 2023 16:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697560151;
        bh=WVjb3SJMVpnNaJ6HSreJDO0WWBfTxnfVqmUPvrW1iSI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aKrf+SOYtP1evy93MpmK/2FW3GPbUwX11KZy7SxM41WD+mvJkCA+ouTf1HkfEyw/i
         BsDHYBomHSXMdEPWD0TNjecUwWNQ2AT5nNzI83xzM9yGUUKgkd2A0Q+iztv3VHjjr4
         V32iN47exf3NgNgjP3QIVhvTWy9uapZoNMbigVGs=
Date:   Tue, 17 Oct 2023 18:29:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.15 000/102] 5.15.136-rc1 review
Message-ID: <2023101700-symphonic-stretch-b62b@gregkh>
References: <20231016083953.689300946@linuxfoundation.org>
 <a01256b5-6082-4d17-bf4d-310e7b4f7a47@oracle.com>
 <2023101641-resource-scalding-3e1d@gregkh>
 <43ad9708-47d4-4113-ab05-6012cb7c4d6c@oracle.com>
 <2023101655-throng-rickety-ff79@gregkh>
 <fb1ce733-d612-4fa3-a1e4-716545625822@oracle.com>
 <2023101716-sporting-geology-2de2@gregkh>
 <2023101719-anteater-deviant-bdf9@gregkh>
 <8cd1f099-b16e-4db8-91d8-ae1ad974bf08@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8cd1f099-b16e-4db8-91d8-ae1ad974bf08@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 05:09:04PM +0200, Vegard Nossum wrote:
> 
> On 17/10/2023 16:08, Greg Kroah-Hartman wrote:
> > On Tue, Oct 17, 2023 at 03:57:06PM +0200, Greg Kroah-Hartman wrote:
> > > Sure!  Here's the output, good luck!
> > > 
> > > $ make -C tools/perf
> > > make: Entering directory '/home/gregkh/linux/stable/linux-5.15.y/tools/perf'
> > >    BUILD:   Doing 'make -j20' parallel build
> > > Warning: Kernel ABI header at 'tools/include/uapi/linux/const.h' differs from latest version at 'include/uapi/linux/const.h'
> > > diff -u tools/include/uapi/linux/const.h include/uapi/linux/const.h
> > > Warning: Kernel ABI header at 'tools/include/uapi/linux/in.h' differs from latest version at 'include/uapi/linux/in.h'
> > > diff -u tools/include/uapi/linux/in.h include/uapi/linux/in.h
> > > Warning: Kernel ABI header at 'tools/arch/x86/include/asm/disabled-features.h' differs from latest version at 'arch/x86/include/asm/disabled-features.h'
> > > diff -u tools/arch/x86/include/asm/disabled-features.h arch/x86/include/asm/disabled-features.h
> > > Warning: Kernel ABI header at 'tools/arch/x86/include/asm/required-features.h' differs from latest version at 'arch/x86/include/asm/required-features.h'
> > > diff -u tools/arch/x86/include/asm/required-features.h arch/x86/include/asm/required-features.h
> > > Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h'
> > > diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h
> > > Warning: Kernel ABI header at 'tools/arch/x86/include/asm/msr-index.h' differs from latest version at 'arch/x86/include/asm/msr-index.h'
> > > diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h
> > > Warning: Kernel ABI header at 'tools/arch/arm64/include/uapi/asm/kvm.h' differs from latest version at 'arch/arm64/include/uapi/asm/kvm.h'
> > > diff -u tools/arch/arm64/include/uapi/asm/kvm.h arch/arm64/include/uapi/asm/kvm.h
> > > Makefile.config:1036: No libbabeltrace found, disables 'perf data' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
> > > Makefile.config:1062: No alternatives command found, you need to set JDIR= to point to the root of your Java directory
> > > tests/bpf.c: In function ‘epoll_pwait_loop’:
> > > tests/bpf.c:36:17: error: argument 2 null where non-null expected [-Werror=nonnull]
> > >     36 |                 epoll_pwait(-(i + 1), NULL, 0, 0, NULL);
> > >        |                 ^~~~~~~~~~~
> > > In file included from tests/bpf.c:5:
> > > /usr/include/sys/epoll.h:134:12: note: in a call to function ‘epoll_pwait’ declared ‘nonnull’
> > >    134 | extern int epoll_pwait (int __epfd, struct epoll_event *__events,
> > >        |            ^~~~~~~~~~~
> > 
> > <snip>
> > 
> > Also, in Linus's tree, this works just fine on my system, but I get this
> > same error above (and only this error), when building perf on 6.1.y, and
> > on 6.5.y.  The perl errors are not present there.
> 
> So lots of those are -Werror things -- I'm guessing it's a newer
> compiler/toolchain/libraries on an older tree. There might be some
> commits in mainline fixing those... in the meantime, what happens if you
> just disable -Werror for now?
> 
>     make -C tools/perf/ WERROR=0

That does, for the epoll_pwait() issue I see in 6.1.y and 6.5.y, odds
are there's a fix here in Linus's tree.

Yes, all of that code is now gone, in commit 3d6dfae88917 ("perf
parse-events: Remove BPF event support"), which isn't relevant for
stable.

> If that doesn't work, maybe even:
> 
>     make -C tools/perf/ WERROR=0 NO_LIBPERL=1

What's wrong with libperl for older kernels?  :)

> There are a bunch of other options to disable various things, they are
> all documented in tools/perf/Makefile.perf.

True, but again, my system has libperl, and perf doesn't build, and
neither does the bpf test, so that's why I don't ever test any of this,
because it just doesn't work for me.

And yes, I do run newer compilers and libraries, but the rest of the
kernel builds fine with them (I make sure of that), but given that no
one seems to care about perf breaking for so long, I just apply patches
when they come up and don't have conflicts and see if anyone notices any
difference.

Normally, no one does :)

thanks,

greg k-h
