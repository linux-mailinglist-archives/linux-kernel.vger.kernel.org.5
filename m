Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50EA7F86A8
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 00:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjKXXV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 18:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjKXXVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 18:21:54 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5A71735
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 15:21:57 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6ce2988d62eso1367371a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 15:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700868116; x=1701472916; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OlCPjaAtW62P1imPAMqJ2Iy75N+wtMzBYmO+H1bzrO0=;
        b=AVTf3KNxyuDISfCwq0JsS40DFZMUP4WNp9zBrvzrqHPnJKcNhTZqBTrLCfDFk+0e/h
         4GymMyfeIQ7DSugmHEpNSO9kdrrocAZA4iv1NlN6ElAxe9Mtecm7+D8gFDhoRSYLy3il
         LJh+yOM2w9iOgM1sHyDtBb/MpIjZkEvBi56RV7VzQugl/xzM12MSy1BkSnwwg6SZ670N
         96wOEEn03+VVINxrhPouqeDCFj45fsd/2XIKEVzo31FSR3G5yf5Ef3ukicptEubSTmPD
         yVSK0Y2PKOL6UctVaTEiAC4emXCKbj6IPxZSbYBxQ5Zq6MGPCuv3jK/77jRJoXTG+CKN
         HI2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700868116; x=1701472916;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OlCPjaAtW62P1imPAMqJ2Iy75N+wtMzBYmO+H1bzrO0=;
        b=F8zx/rap6mk3ZSP+lzoQLupvA54su8ye7F8Jn2NHbTrFIX5Dyf+6mX7MzdlpDy2+XI
         IJjwPqBm6kXN4ao7xEZwhaSNxemKjTlF2AoG9gUW1JvDq9lOOsSUMLqLAlnx0hR1GCxB
         PFQwMhhi0PFKP3JweB+/qe1rI0MjXcHWOBt0oG296a2kBj/bCejAzoHFdZfRVjD+6vjY
         rJVcpFL2iv4rXYpDZTP1K9pjhHZfGhT9zIG1RkBuUmzcm/LWE+/cfIGT5FH0pomgBcb2
         RU2sGbetlDoEOH0L+t9LoVPSSzDoq0i7eD3/rtyqpVS/gDgLdH8oZH5zlhQKzB2u6RoY
         ovQQ==
X-Gm-Message-State: AOJu0YwoGoQMeQpONxgk5jJGD7OnfhYp4qkScGLha34XJbJsW6VH3mbJ
        ZXBBz9vjVMT5wEseUtmA3eIabg==
X-Google-Smtp-Source: AGHT+IFVf3soPcU1tHWDQrpPYm5yzOD4//vhn47e6wYOjfrUzz8bPsS5nXGhVJhOJX7Oy5J/zJNdHQ==
X-Received: by 2002:a05:6830:1d47:b0:6d8:a8:b59c with SMTP id p7-20020a0568301d4700b006d800a8b59cmr4982138oth.27.1700868116578;
        Fri, 24 Nov 2023 15:21:56 -0800 (PST)
Received: from [192.168.17.16] ([138.84.62.70])
        by smtp.gmail.com with ESMTPSA id j13-20020a9d7f0d000000b006ce28044207sm647747otq.58.2023.11.24.15.21.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 15:21:56 -0800 (PST)
Message-ID: <c0a5a523-708b-431c-b212-df1af5ad7bc0@linaro.org>
Date:   Fri, 24 Nov 2023 17:21:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/297] 5.15.140-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        deller@gmx.de, hca@linux.ibm.com
References: <20231124172000.087816911@linuxfoundation.org>
From:   =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20231124172000.087816911@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 24/11/23 11:50 a. m., Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.140 release.
> There are 297 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 26 Nov 2023 17:19:17 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.140-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

There are problems with PA-RISC:

-----8<-----
   /builds/linux/drivers/parisc/power.c:201:34: warning: 'struct sys_off_data' declared inside parameter list will not be visible outside of this definition or declaration
     201 | static int qemu_power_off(struct sys_off_data *data)
         |                                  ^~~~~~~~~~~~
   /builds/linux/drivers/parisc/power.c: In function 'qemu_power_off':
   /builds/linux/drivers/parisc/power.c:204:43: error: invalid use of undefined type 'struct sys_off_data'
     204 |         gsc_writel(0, (unsigned long) data->cb_data);
         |                                           ^~
   /builds/linux/drivers/parisc/power.c: In function 'power_init':
   /builds/linux/drivers/parisc/power.c:239:17: error: implicit declaration of function 'register_sys_off_handler'; did you mean 'register_restart_handler'? [-Werror=implicit-function-declaration]
     239 |                 register_sys_off_handler(SYS_OFF_MODE_POWER_OFF, SYS_OFF_PRIO_DEFAULT,
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
         |                 register_restart_handler
   /builds/linux/drivers/parisc/power.c:239:42: error: 'SYS_OFF_MODE_POWER_OFF' undeclared (first use in this function); did you mean 'SYSTEM_POWER_OFF'?
     239 |                 register_sys_off_handler(SYS_OFF_MODE_POWER_OFF, SYS_OFF_PRIO_DEFAULT,
         |                                          ^~~~~~~~~~~~~~~~~~~~~~
         |                                          SYSTEM_POWER_OFF
   /builds/linux/drivers/parisc/power.c:239:42: note: each undeclared identifier is reported only once for each function it appears in
   /builds/linux/drivers/parisc/power.c:239:66: error: 'SYS_OFF_PRIO_DEFAULT' undeclared (first use in this function)
     239 |                 register_sys_off_handler(SYS_OFF_MODE_POWER_OFF, SYS_OFF_PRIO_DEFAULT,
         |                                                                  ^~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
   make[3]: *** [/builds/linux/scripts/Makefile.build:289: drivers/parisc/power.o] Error 1
----->8-----

That's allnoconfig with GCC 11; defconfig and tinyconfig fail just like that.

Bisection points to:

   commit 065a7d0b92c0f1ef4160e2129d835eb6093cc675
   Author: Helge Deller <deller@gmx.de>
   Date:   Tue Oct 17 22:19:53 2023 +0200

       parisc/power: Add power soft-off when running on qemu
       
       commit d0c219472980d15f5cbc5c8aec736848bda3f235 upstream.


Then there's this failure on System/390:

-----8<-----
   /builds/linux/arch/s390/mm/page-states.c: In function 'mark_kernel_pgd':
   /builds/linux/arch/s390/mm/page-states.c:175:38: error: request for member 'val' in something not a structure or union
     max_addr = (S390_lowcore.kernel_asce.val & _ASCE_TYPE_MASK) >> 2;
                                         ^
   In file included from /builds/linux/arch/s390/include/asm/page.h:186,
                    from /builds/linux/arch/s390/include/asm/thread_info.h:26,
                    from /builds/linux/include/linux/thread_info.h:60,
                    from /builds/linux/arch/s390/include/asm/preempt.h:6,
                    from /builds/linux/include/linux/preempt.h:78,
                    from /builds/linux/include/linux/spinlock.h:55,
                    from /builds/linux/include/linux/mmzone.h:8,
                    from /builds/linux/include/linux/gfp.h:6,
                    from /builds/linux/include/linux/mm.h:10,
                    from /builds/linux/arch/s390/mm/page-states.c:13:
   /builds/linux/arch/s390/mm/page-states.c: In function 'cmma_init_nodat':
   /builds/linux/arch/s390/mm/page-states.c:204:23: error: 'invalid_pg_dir' undeclared (first use in this function); did you mean 'is_valid_bugaddr'?
     page = virt_to_page(&invalid_pg_dir);
                          ^~~~~~~~~~~~~~
   /builds/linux/include/asm-generic/memory_model.h:25:40: note: in definition of macro '__pfn_to_page'
    #define __pfn_to_page(pfn) (vmemmap + (pfn))
                                           ^~~
   /builds/linux/arch/s390/include/asm/page.h:176:29: note: in expansion of macro 'phys_to_pfn'
    #define virt_to_pfn(kaddr) (phys_to_pfn(__pa(kaddr)))
                                ^~~~~~~~~~~
   /builds/linux/arch/s390/include/asm/page.h:176:41: note: in expansion of macro '__pa'
    #define virt_to_pfn(kaddr) (phys_to_pfn(__pa(kaddr)))
                                            ^~~~
   /builds/linux/arch/s390/include/asm/page.h:179:41: note: in expansion of macro 'virt_to_pfn'
    #define virt_to_page(kaddr) pfn_to_page(virt_to_pfn(kaddr))
                                            ^~~~~~~~~~~
   /builds/linux/arch/s390/mm/page-states.c:204:9: note: in expansion of macro 'virt_to_page'
     page = virt_to_page(&invalid_pg_dir);
            ^~~~~~~~~~~~
   /builds/linux/arch/s390/mm/page-states.c:204:23: note: each undeclared identifier is reported only once for each function it appears in
     page = virt_to_page(&invalid_pg_dir);
                          ^~~~~~~~~~~~~~
   /builds/linux/include/asm-generic/memory_model.h:25:40: note: in definition of macro '__pfn_to_page'
    #define __pfn_to_page(pfn) (vmemmap + (pfn))
                                           ^~~
   /builds/linux/arch/s390/include/asm/page.h:176:29: note: in expansion of macro 'phys_to_pfn'
    #define virt_to_pfn(kaddr) (phys_to_pfn(__pa(kaddr)))
                                ^~~~~~~~~~~
   /builds/linux/arch/s390/include/asm/page.h:176:41: note: in expansion of macro '__pa'
    #define virt_to_pfn(kaddr) (phys_to_pfn(__pa(kaddr)))
                                            ^~~~
   /builds/linux/arch/s390/include/asm/page.h:179:41: note: in expansion of macro 'virt_to_pfn'
    #define virt_to_page(kaddr) pfn_to_page(virt_to_pfn(kaddr))
                                            ^~~~~~~~~~~
   /builds/linux/arch/s390/mm/page-states.c:204:9: note: in expansion of macro 'virt_to_page'
     page = virt_to_page(&invalid_pg_dir);
            ^~~~~~~~~~~~
   make[3]: *** [/builds/linux/scripts/Makefile.build:289: arch/s390/mm/page-states.o] Error 1
----->8-----

Bisection in this case points to:

   commit d247caa47712c9cc36f25ec744f3b5dba90c3334
   Author: Heiko Carstens <hca@linux.ibm.com>
   Date:   Tue Oct 17 21:07:03 2023 +0200

       s390/cmma: fix initial kernel address space page table walk
       
       commit 16ba44826a04834d3eeeda4b731c2ea3481062b7 upstream.


Reproducers:

   tuxmake --runtime podman --target-arch parisc --toolchain gcc-11 --kconfig allnoconfig

and

   tuxmake --runtime podman --target-arch s390 --toolchain gcc-8 --kconfig allnoconfig


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Greetings!

Daniel Díaz
daniel.diaz@linaro.org

