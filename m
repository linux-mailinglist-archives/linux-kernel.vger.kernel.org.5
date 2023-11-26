Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D6C7F9366
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 16:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjKZPlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 10:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjKZPlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 10:41:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D73F7
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 07:41:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7866FC433C8;
        Sun, 26 Nov 2023 15:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701013288;
        bh=eK77suEjtbZcGG8hvUfP4aZ4wCiPIf897WlwaDZjof8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gfeh+4XdYHF7CgCbBHz6MSOBSZwWw+EAOAiVcK47k9CEjAcRkDui+MV+QBUhiyYTk
         S7tPsm6MsOR01BQlxCNsvUejkd2Z8o97upjz1LWJoBYwLOpDyfPlMM8PoEuOBr2J2P
         sHjHZwK7HYgV83abzi8w3ZSQZeBNCIfdrhkGNbjU=
Date:   Sun, 26 Nov 2023 15:41:26 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, allen.lkml@gmail.com, hca@linux.ibm.com,
        gbatra@linux.vnet.ibm.com
Subject: Re: [PATCH 6.1 000/368] 6.1.64-rc3 review
Message-ID: <2023112624-plutonium-garland-694d@gregkh>
References: <20231125194359.201910779@linuxfoundation.org>
 <a853e6f3-f658-4049-9c36-66835d144eac@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a853e6f3-f658-4049-9c36-66835d144eac@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2023 at 11:41:11PM -0600, Daniel Díaz wrote:
> Hello!
> 
> On 25/11/23 1:45 p. m., Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.1.64 release.
> > There are 368 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Mon, 27 Nov 2023 19:43:06 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.64-rc3.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> 
> The following configurations are failing for System/390:
> * gcc-8-allmodconfig
> * gcc-8-allnoconfig
> * gcc-8-defconfig (+CONFIG_DEBUG_INFO_BTF=n)
> * gcc-8-tinyconfig
> * gcc-13-allmodconfig
> * gcc-13-allnoconfig
> * gcc-13-defconfig
> * gcc-13-tinyconfig
> * clang-17-allmodconfig
> * clang-17-allnoconfig
> * clang-17-defconfig
> * clang-17-tinyconfig
> * clang-nightly-allmodconfig
> * clang-nightly-allnoconfig
> * clang-nightly-defconfig
> * clang-nightly-tinyconfig
> 
> The error looks like this:
> -----8<-----
>   In file included from /builds/linux/arch/s390/include/asm/page.h:208,
>                    from /builds/linux/arch/s390/include/asm/thread_info.h:26,
>                    from /builds/linux/include/linux/thread_info.h:60,
>                    from /builds/linux/arch/s390/include/asm/preempt.h:6,
>                    from /builds/linux/include/linux/preempt.h:78,
>                    from /builds/linux/include/linux/spinlock.h:56,
>                    from /builds/linux/include/linux/mmzone.h:8,
>                    from /builds/linux/include/linux/gfp.h:7,
>                    from /builds/linux/include/linux/mm.h:7,
>                    from /builds/linux/arch/s390/mm/page-states.c:13:
>   /builds/linux/arch/s390/mm/page-states.c: In function 'cmma_init_nodat':
>   /builds/linux/arch/s390/mm/page-states.c:198:30: error: 'invalid_pg_dir' undeclared (first use in this function)
>     198 |         page = virt_to_page(&invalid_pg_dir);
>         |                              ^~~~~~~~~~~~~~
>   /builds/linux/include/asm-generic/memory_model.h:25:45: note: in definition of macro '__pfn_to_page'
>      25 | #define __pfn_to_page(pfn)      (vmemmap + (pfn))
>         |                                             ^~~
>   /builds/linux/arch/s390/include/asm/page.h:198:34: note: in expansion of macro 'phys_to_pfn'
>     198 | #define virt_to_pfn(kaddr)      (phys_to_pfn(__pa(kaddr)))
>         |                                  ^~~~~~~~~~~
>   /builds/linux/arch/s390/include/asm/page.h:198:46: note: in expansion of macro '__pa'
>     198 | #define virt_to_pfn(kaddr)      (phys_to_pfn(__pa(kaddr)))
>         |                                              ^~~~
>   /builds/linux/arch/s390/include/asm/page.h:201:45: note: in expansion of macro 'virt_to_pfn'
>     201 | #define virt_to_page(kaddr)     pfn_to_page(virt_to_pfn(kaddr))
>         |                                             ^~~~~~~~~~~
>   /builds/linux/arch/s390/mm/page-states.c:198:16: note: in expansion of macro 'virt_to_page'
>     198 |         page = virt_to_page(&invalid_pg_dir);
>         |                ^~~~~~~~~~~~
>   /builds/linux/arch/s390/mm/page-states.c:198:30: note: each undeclared identifier is reported only once for each function it appears in
>     198 |         page = virt_to_page(&invalid_pg_dir);
>         |                              ^~~~~~~~~~~~~~
>   /builds/linux/include/asm-generic/memory_model.h:25:45: note: in definition of macro '__pfn_to_page'
>      25 | #define __pfn_to_page(pfn)      (vmemmap + (pfn))
>         |                                             ^~~
>   /builds/linux/arch/s390/include/asm/page.h:198:34: note: in expansion of macro 'phys_to_pfn'
>     198 | #define virt_to_pfn(kaddr)      (phys_to_pfn(__pa(kaddr)))
>         |                                  ^~~~~~~~~~~
>   /builds/linux/arch/s390/include/asm/page.h:198:46: note: in expansion of macro '__pa'
>     198 | #define virt_to_pfn(kaddr)      (phys_to_pfn(__pa(kaddr)))
>         |                                              ^~~~
>   /builds/linux/arch/s390/include/asm/page.h:201:45: note: in expansion of macro 'virt_to_pfn'
>     201 | #define virt_to_page(kaddr)     pfn_to_page(virt_to_pfn(kaddr))
>         |                                             ^~~~~~~~~~~
>   /builds/linux/arch/s390/mm/page-states.c:198:16: note: in expansion of macro 'virt_to_page'
>     198 |         page = virt_to_page(&invalid_pg_dir);
>         |                ^~~~~~~~~~~~
>   make[4]: *** [/builds/linux/scripts/Makefile.build:250: arch/s390/mm/page-states.o] Error 1
> ----->8-----
> 
> Bisection points to:
> 
>   commit 1a5dd59623dc206de30df2d13316a3ce9be6821a
>   Author: Heiko Carstens <hca@linux.ibm.com>
>   Date:   Tue Oct 24 10:15:20 2023 +0200
> 
>       s390/cmma: fix handling of swapper_pg_dir and invalid_pg_dir
>       commit 84bb41d5df48868055d159d9247b80927f1f70f9 upstream.

Ugh, s390, let me go drop that from everywhere now...

> Reverting that commit made the build pass.
> 
> Reproducer:
>   tuxmake --runtime podman --target-arch s390 --toolchain gcc-13 --kconfig tinyconfig
> 
> 
> Then, there's a PowerPC failure too on the following configurations:
> * gcc-8-allmodconfig
> * gcc-8-defconfig
> * gcc-13-allmodconfig
> * gcc-13-defconfig
> * clang-17-defconfig
> * clang-nightly-defconfig
> 
> That looks like this:
> -----8<-----
>   /builds/linux/arch/powerpc/platforms/pseries/iommu.c: In function 'find_existing_ddw':
>   /builds/linux/arch/powerpc/platforms/pseries/iommu.c:926:49: error: 'struct dma_win' has no member named 'direct'
>     926 |                         *direct_mapping = window->direct;
>         |                                                 ^~
>   make[5]: *** [/builds/linux/scripts/Makefile.build:250: arch/powerpc/platforms/pseries/iommu.o] Error 1
> ----->8-----
> 
> I guess it might be due to this:
> 
>   commit fd018dfa8f0b963d65700d518596f9d834844fca
>   Author: Gaurav Batra <gbatra@linux.vnet.ibm.com>
>   Date:   Mon Oct 2 22:08:02 2023 -0500
> 
>       powerpc/pseries/iommu: enable_ddw incorrectly returns direct mapping for SR-IOV device
>       commit 3bf983e4e93ce8e6d69e9d63f52a66ec0856672e upstream.
> 
> 
> Reverting that commit does make the build pass again.

Ick, also dropped from everywhere now, thanks.

greg k-h
