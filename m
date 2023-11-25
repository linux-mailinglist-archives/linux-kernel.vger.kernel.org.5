Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FA07F8C2C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 16:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbjKYPv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 10:51:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjKYPv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 10:51:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC45EE1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 07:52:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2634BC433C8;
        Sat, 25 Nov 2023 15:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700927522;
        bh=XKFCiu+TQj4OtST5/T7Lg3zC/rplkSgWsiLSqkkdzfY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m9Z5nnQ/v9jzYT4fvj3KgbmbOV4gnkK2Snwo4bUbzdgSrqPiiYqilMtp6NeCO0ZTh
         2Bnik7sfdF/PXnamij/KJpMViCD7PMTDsHciSHsO8LUklaRJdMr+cqDmefSkTYkbi6
         dbWe53okpiE8lvqtc6MjLLgSxLpnShTzwiZRQNjg=
Date:   Sat, 25 Nov 2023 15:52:00 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, hca@linux.ibm.com, mpe@ellerman.id.au
Subject: Re: [PATCH 5.10 000/193] 5.10.202-rc1 review
Message-ID: <2023112544-irk-purple-80b8@gregkh>
References: <20231124171947.127438872@linuxfoundation.org>
 <a67ec47c-6d4c-4a2f-a4c0-5284d895982a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a67ec47c-6d4c-4a2f-a4c0-5284d895982a@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 04:19:32PM -0600, Daniel Díaz wrote:
> Hello!
> 
> On 24/11/23 11:52 a. m., Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.10.202 release.
> > There are 193 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun, 26 Nov 2023 17:19:17 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.202-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> 
> System/390 fails here too:
> 
> -----8<-----
>   In function 'setup_lowcore_dat_off',
>       inlined from 'setup_arch' at /builds/linux/arch/s390/kernel/setup.c:1165:2:
>   /builds/linux/arch/s390/kernel/setup.c:410:9: warning: 'memcpy' reading 128 bytes from a region of size 0 [-Wstringop-overread]
>     410 |         memcpy(lc->stfle_fac_list, S390_lowcore.stfle_fac_list,
>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     411 |                sizeof(lc->stfle_fac_list));
>         |                ~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   /builds/linux/arch/s390/kernel/setup.c:412:9: warning: 'memcpy' reading 128 bytes from a region of size 0 [-Wstringop-overread]
>     412 |         memcpy(lc->alt_stfle_fac_list, S390_lowcore.alt_stfle_fac_list,
>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     413 |                sizeof(lc->alt_stfle_fac_list));
>         |                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   /builds/linux/arch/s390/mm/page-states.c: In function 'mark_kernel_pgd':
>   /builds/linux/arch/s390/mm/page-states.c:175:45: error: request for member 'val' in something not a structure or union
>     175 |         max_addr = (S390_lowcore.kernel_asce.val & _ASCE_TYPE_MASK) >> 2;
>         |                                             ^
>   In file included from /builds/linux/arch/s390/include/asm/page.h:186,
>                    from /builds/linux/arch/s390/include/asm/thread_info.h:26,
>                    from /builds/linux/include/linux/thread_info.h:39,
>                    from /builds/linux/arch/s390/include/asm/preempt.h:6,
>                    from /builds/linux/include/linux/preempt.h:78,
>                    from /builds/linux/include/linux/spinlock.h:51,
>                    from /builds/linux/include/linux/mmzone.h:8,
>                    from /builds/linux/include/linux/gfp.h:6,
>                    from /builds/linux/include/linux/mm.h:10,
>                    from /builds/linux/arch/s390/mm/page-states.c:13:
>   /builds/linux/arch/s390/mm/page-states.c: In function 'cmma_init_nodat':
>   /builds/linux/arch/s390/mm/page-states.c:204:30: error: 'invalid_pg_dir' undeclared (first use in this function)
>     204 |         page = virt_to_page(&invalid_pg_dir);
>         |                              ^~~~~~~~~~~~~~
>   /builds/linux/include/asm-generic/memory_model.h:54:45: note: in definition of macro '__pfn_to_page'
>      54 | #define __pfn_to_page(pfn)      (vmemmap + (pfn))
>         |                                             ^~~
>   /builds/linux/arch/s390/include/asm/page.h:176:34: note: in expansion of macro 'phys_to_pfn'
>     176 | #define virt_to_pfn(kaddr)      (phys_to_pfn(__pa(kaddr)))
>         |                                  ^~~~~~~~~~~
>   /builds/linux/arch/s390/include/asm/page.h:176:46: note: in expansion of macro '__pa'
>     176 | #define virt_to_pfn(kaddr)      (phys_to_pfn(__pa(kaddr)))
>         |                                              ^~~~
>   /builds/linux/arch/s390/include/asm/page.h:179:45: note: in expansion of macro 'virt_to_pfn'
>     179 | #define virt_to_page(kaddr)     pfn_to_page(virt_to_pfn(kaddr))
>         |                                             ^~~~~~~~~~~
>   /builds/linux/arch/s390/mm/page-states.c:204:16: note: in expansion of macro 'virt_to_page'
>     204 |         page = virt_to_page(&invalid_pg_dir);
>         |                ^~~~~~~~~~~~
>   /builds/linux/arch/s390/mm/page-states.c:204:30: note: each undeclared identifier is reported only once for each function it appears in
>     204 |         page = virt_to_page(&invalid_pg_dir);
>         |                              ^~~~~~~~~~~~~~
>   /builds/linux/include/asm-generic/memory_model.h:54:45: note: in definition of macro '__pfn_to_page'
>      54 | #define __pfn_to_page(pfn)      (vmemmap + (pfn))
>         |                                             ^~~
>   /builds/linux/arch/s390/include/asm/page.h:176:34: note: in expansion of macro 'phys_to_pfn'
>     176 | #define virt_to_pfn(kaddr)      (phys_to_pfn(__pa(kaddr)))
>         |                                  ^~~~~~~~~~~
>   /builds/linux/arch/s390/include/asm/page.h:176:46: note: in expansion of macro '__pa'
>     176 | #define virt_to_pfn(kaddr)      (phys_to_pfn(__pa(kaddr)))
>         |                                              ^~~~
>   /builds/linux/arch/s390/include/asm/page.h:179:45: note: in expansion of macro 'virt_to_pfn'
>     179 | #define virt_to_page(kaddr)     pfn_to_page(virt_to_pfn(kaddr))
>         |                                             ^~~~~~~~~~~
>   /builds/linux/arch/s390/mm/page-states.c:204:16: note: in expansion of macro 'virt_to_page'
>     204 |         page = virt_to_page(&invalid_pg_dir);
>         |                ^~~~~~~~~~~~
>   make[3]: *** [/builds/linux/scripts/Makefile.build:286: arch/s390/mm/page-states.o] Error 1
>   make[3]: Target '__build' not remade because of errors.
>   make[2]: *** [/builds/linux/scripts/Makefile.build:503: arch/s390/mm] Error 2
>   In file included from /builds/linux/arch/s390/kernel/lgr.c:13:
>   In function '__stfle',
>       inlined from 'stfle' at /builds/linux/arch/s390/include/asm/facility.h:99:2,
>       inlined from 'lgr_info_get' at /builds/linux/arch/s390/kernel/lgr.c:122:2:
>   /builds/linux/arch/s390/include/asm/facility.h:87:9: warning: 'memcpy' reading 4 bytes from a region of size 0 [-Wstringop-overread]
>      87 |         memcpy(stfle_fac_list, &S390_lowcore.stfl_fac_list, 4);
>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   In function 'pcpu_prepare_secondary',
>       inlined from '__cpu_up' at /builds/linux/arch/s390/kernel/smp.c:911:2:
>   /builds/linux/arch/s390/kernel/smp.c:277:9: warning: 'memcpy' reading 128 bytes from a region of size 0 [-Wstringop-overread]
>     277 |         memcpy(lc->stfle_fac_list, S390_lowcore.stfle_fac_list,
>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     278 |                sizeof(lc->stfle_fac_list));
>         |                ~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   /builds/linux/arch/s390/kernel/smp.c:279:9: warning: 'memcpy' reading 128 bytes from a region of size 0 [-Wstringop-overread]
>     279 |         memcpy(lc->alt_stfle_fac_list, S390_lowcore.alt_stfle_fac_list,
>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     280 |                sizeof(lc->alt_stfle_fac_list));
>         |                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   make[2]: Target '__build' not remade because of errors.
> ----->8-----
> 
> That was allnoconfig with GCC 12. Bisection pointed to:
> 
>   commit 2e530ad14d778a089d8ec190a7e2a70421a8a71a
>   Author: Heiko Carstens <hca@linux.ibm.com>
>   Date:   Tue Oct 17 21:07:03 2023 +0200
> 
>       s390/cmma: fix initial kernel address space page table walk
>       commit 16ba44826a04834d3eeeda4b731c2ea3481062b7 upstream.

Now dropped.

> 
> 
> Then there's also a PowerPC failure on allmodconfig:
> 
> -----8<-----
>   /builds/linux/arch/powerpc/platforms/powernv/opal-prd.c:30:17: error: expected specifier-qualifier-list before 'DECLARE_FLEX_ARRAY'
>      30 |                 DECLARE_FLEX_ARRAY(u8, data);
>         |                 ^~~~~~~~~~~~~~~~~~
>   /builds/linux/arch/powerpc/platforms/powernv/opal-prd.c: In function 'opal_prd_msg_notifier':
>   /builds/linux/arch/powerpc/platforms/powernv/opal-prd.c:365:26: error: 'struct opal_prd_msg' has no member named 'data'
>     365 |         memcpy(&item->msg.data, msg->params, msg_size);
>         |                          ^
>   make[4]: *** [/builds/linux/scripts/Makefile.build:286: arch/powerpc/platforms/powernv/opal-prd.o] Error 1
> ----->8-----
> 
> I didn't bisect this one but would suspect this commit:
> 
>   commit 2342ac1ed7704304605e29e337ce073f00f75d1e
>   Author: Michael Ellerman <mpe@ellerman.id.au>
>   Date:   Tue Aug 22 00:28:19 2023 +1000
> 
>       powerpc/powernv: Fix fortify source warnings in opal-prd.c
>       commit feea65a338e52297b68ceb688eaf0ffc50310a83 upstream.

thanks, now dropped.

greg k-h
