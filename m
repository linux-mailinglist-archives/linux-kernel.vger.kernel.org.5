Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5687F8C1B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 16:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjKYPkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 10:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjKYPkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 10:40:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5A5FD
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 07:40:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4B2C433C7;
        Sat, 25 Nov 2023 15:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700926847;
        bh=sTmtbazNTAgZTolvHu5G9LRcLJavOxe/lPrhkk8HiwM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LvsFp36aQyp3B9WFrVqVFB/B+TprCYma+3DJJs4SzNc/IQD5F8GuGRRKNxjCpiUUy
         LtuOJbEH4YFHPXOvKwFSuknSY5UMvlwrjuVOh3JByk9MGzJ5d7HJGjeoYz/wpAkqtJ
         QkDaa92JXUaIng4pOGLKzA2gyyejrQorLVjH1mGk=
Date:   Sat, 25 Nov 2023 15:40:45 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, hca@linux.ibm.com
Subject: Re: [PATCH 4.14 00/57] 4.14.331-rc1 review
Message-ID: <2023112538-active-armadillo-0651@gregkh>
References: <20231124171930.281665051@linuxfoundation.org>
 <8761f367-1928-40f2-a4da-9d57ecb73218@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8761f367-1928-40f2-a4da-9d57ecb73218@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 02:51:59PM -0600, Daniel Díaz wrote:
> Hello!
> 
> On 24/11/23 11:50 a. m., Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.14.331 release.
> > There are 57 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun, 26 Nov 2023 17:19:17 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.331-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> 
> There are System/390 build failures here:
> 
> -----8<-----
>   In function 'setup_lowcore_dat_off',
>       inlined from 'setup_arch' at /builds/linux/arch/s390/kernel/setup.c:961:2:
>   /builds/linux/arch/s390/kernel/setup.c:339:9: warning: 'memcpy' reading 128 bytes from a region of size 0 [-Wstringop-overread]
>     339 |         memcpy(lc->stfle_fac_list, S390_lowcore.stfle_fac_list,
>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     340 |                sizeof(lc->stfle_fac_list));
>         |                ~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   /builds/linux/arch/s390/kernel/setup.c:341:9: warning: 'memcpy' reading 128 bytes from a region of size 0 [-Wstringop-overread]
>     341 |         memcpy(lc->alt_stfle_fac_list, S390_lowcore.alt_stfle_fac_list,
>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     342 |                sizeof(lc->alt_stfle_fac_list));
>         |                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   /builds/linux/arch/s390/mm/page-states.c: In function 'mark_kernel_pgd':
>   /builds/linux/arch/s390/mm/page-states.c:181:45: error: request for member 'val' in something not a structure or union
>     181 |         max_addr = (S390_lowcore.kernel_asce.val & _ASCE_TYPE_MASK) >> 2;
>         |                                             ^
>   /builds/linux/arch/s390/mm/page-states.c: In function 'cmma_init_nodat':
>   /builds/linux/arch/s390/mm/page-states.c:208:14: error: 'i' undeclared (first use in this function); did you mean 'ix'?
>     208 |         for (i = 0; i < 4; i++)
>         |              ^
>         |              ix
>   /builds/linux/arch/s390/mm/page-states.c:208:14: note: each undeclared identifier is reported only once for each function it appears in
>   In file included from /builds/linux/arch/s390/include/asm/page.h:181,
>                    from /builds/linux/arch/s390/include/asm/thread_info.h:24,
>                    from /builds/linux/include/linux/thread_info.h:39,
>                    from /builds/linux/arch/s390/include/asm/preempt.h:6,
>                    from /builds/linux/include/linux/preempt.h:81,
>                    from /builds/linux/include/linux/spinlock.h:51,
>                    from /builds/linux/include/linux/mmzone.h:8,
>                    from /builds/linux/include/linux/gfp.h:6,
>                    from /builds/linux/include/linux/mm.h:10,
>                    from /builds/linux/arch/s390/mm/page-states.c:13:
>   /builds/linux/arch/s390/mm/page-states.c:210:30: error: 'invalid_pg_dir' undeclared (first use in this function)
>     210 |         page = virt_to_page(&invalid_pg_dir);
>         |                              ^~~~~~~~~~~~~~
>   /builds/linux/include/asm-generic/memory_model.h:54:45: note: in definition of macro '__pfn_to_page'
>      54 | #define __pfn_to_page(pfn)      (vmemmap + (pfn))
>         |                                             ^~~
>   /builds/linux/arch/s390/include/asm/page.h:164:34: note: in expansion of macro '__pa'
>     164 | #define virt_to_pfn(kaddr)      (__pa(kaddr) >> PAGE_SHIFT)
>         |                                  ^~~~
>   /builds/linux/arch/s390/include/asm/page.h:167:45: note: in expansion of macro 'virt_to_pfn'
>     167 | #define virt_to_page(kaddr)     pfn_to_page(virt_to_pfn(kaddr))
>         |                                             ^~~~~~~~~~~
>   /builds/linux/arch/s390/mm/page-states.c:210:16: note: in expansion of macro 'virt_to_page'
>     210 |         page = virt_to_page(&invalid_pg_dir);
>         |                ^~~~~~~~~~~~
>   make[3]: *** [/builds/linux/scripts/Makefile.build:329: arch/s390/mm/page-states.o] Error 1
>   make[3]: Target '__build' not remade because of errors.
>   make[2]: *** [/builds/linux/scripts/Makefile.build:588: arch/s390/mm] Error 2
>   In file included from /builds/linux/arch/s390/kernel/lgr.c:12:
>   In function 'stfle',
>       inlined from 'lgr_info_get' at /builds/linux/arch/s390/kernel/lgr.c:121:2:
>   /builds/linux/arch/s390/include/asm/facility.h:88:9: warning: 'memcpy' reading 4 bytes from a region of size 0 [-Wstringop-overread]
>      88 |         memcpy(stfle_fac_list, &S390_lowcore.stfl_fac_list, 4);
>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   make[2]: Target '__build' not remade because of errors.
> ----->8-----
> 
> This one above is with allnoconfig and GCC 12. Bisection points to:
> 
>   commit 76dc317ac655dafe1747dba6ce689ae3c3a35dd6
>   Author: Heiko Carstens <hca@linux.ibm.com>
>   Date:   Tue Oct 24 10:15:20 2023 +0200
> 
>       s390/cmma: fix handling of swapper_pg_dir and invalid_pg_dir
>       commit 84bb41d5df48868055d159d9247b80927f1f70f9 upstream.
> 
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Now dropped, thanks.

greg k-h
