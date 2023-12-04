Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618068041CD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 23:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjLDWmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 17:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjLDWmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 17:42:17 -0500
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF10BE
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 14:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Reply-To:Content-ID:Content-Description;
        bh=o70d//JYoJ1Tfh+yCl49djcfA839SZwkOqOLtsmt7qs=; b=OBkk7NQVbnOYMkTOg8lRFAkxCU
        p4og0L3qTkgghCk2mGFGY0cUh/vB+LNep/ZeR3GxuE8S0liQeYoIyMZYn3PrjTEGOqbHLlgZIrqUR
        fQM0oC3ePpMIpZ4Z2Uv7ZtkmmVYmCzyxGBfkF3ztKeXY8aFt4ptq/qHw261/5BXcFjOBxxO1NsDro
        5vshnATL/sUK8kMisBsvn9+a8u0i/2MqUDTR08RmCrlhQGpmZzTsSorKwsX5Qrd/LhMzzZ8d7JWJ3
        IGW5IGGWLU4rxjSUDzILevGI2sdyS1j/yeyfOFlYt5PgZokoDtzq+B5J86nxgh3zl9sGC1knCtoiW
        HC1lFWgw==;
Received: from authenticated user
        by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
        (Exim 4.94.2)
        (envelope-from <sylvestre@debian.org>)
        id 1rAHdc-00Gmsc-OQ; Mon, 04 Dec 2023 22:42:04 +0000
Message-ID: <c61f61c9-3bfb-4ffd-adaf-1313965b3037@debian.org>
Date:   Mon, 4 Dec 2023 23:42:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: clang-nightly: vdso/compat_gettimeofday.h:152:15: error:
 instruction variant requires ARMv6 or later
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     clang-built-linux <llvm@lists.linux.dev>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        lkft-triage@lists.linaro.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <CA+G9fYvD72Vpfs2g8R+OJ6L8w9p_uaWbXpWMvnGAx_AOLabatw@mail.gmail.com>
 <20231204181304.GA2043538@dev-arch.thelio-3990X>
 <20231204223317.GA2053629@dev-arch.thelio-3990X>
From:   Sylvestre Ledru <sylvestre@debian.org>
Autocrypt: addr=sylvestre@debian.org; keydata=
 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
In-Reply-To: <20231204223317.GA2053629@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Debian-User: sylvestre
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


Le 04/12/2023 à 23:33, Nathan Chancellor a écrit :
> On Mon, Dec 04, 2023 at 11:13:04AM -0700, Nathan Chancellor wrote:
>> Hi Naresh,
>>
>> On Mon, Dec 04, 2023 at 05:33:26PM +0530, Naresh Kamboju wrote:
>>> Following build errors noticed on Linux next-20231204 tag with clang-nightly
>>> for arm and arm64.
>>>
>>> ## Test Regressions (compared to next-20231201)
>>> * arm64, build
>>>    - clang-nightly-defconfig
>>>    - clang-nightly-defconfig-40bc7ee5
>>>    - clang-nightly-lkftconfig
>>>    - clang-nightly-lkftconfig-kselftest
>>>
>>> * arm, build
>>>    - clang-nightly-allnoconfig
>>>    - clang-nightly-axm55xx_defconfig
>>>    - clang-nightly-bcm2835_defconfig
>>>    - clang-nightly-clps711x_defconfig
>>>    - clang-nightly-defconfig
>>>    - clang-nightly-exynos_defconfig
>>>    - clang-nightly-imx_v6_v7_defconfig
>>>    - clang-nightly-keystone_defconfig
>>>    - clang-nightly-lkftconfig
>>>    - clang-nightly-lkftconfig-kselftest
>>>    - clang-nightly-omap2plus_defconfig
>>>    - clang-nightly-pxa910_defconfig
>>>    - clang-nightly-s3c6400_defconfig
>>>    - clang-nightly-s5pv210_defconfig
>>>    - clang-nightly-sama5_defconfig
>>>    - clang-nightly-shmobile_defconfig
>>>    - clang-nightly-tinyconfig
>>>    - clang-nightly-u8500_defconfig
>>>    - clang-nightly-vexpress_defconfig
>>>
>>>
>>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>>
>>>
>>> Build log on arm64:
>>> ---------
>>> In file included from lib/vdso/gettimeofday.c:5:
>>> In file included from include/vdso/datapage.h:135:
>>> arch/arm64/include/asm/vdso/compat_gettimeofday.h:152:15: error:
>>> instruction variant requires ARMv6 or later
>>>    152 |         asm volatile("mov %0, %1" : "=r"(ret) : "r"(_vdso_data));
>>>        |                      ^
>>> <inline asm>:1:2: note: instantiated into assembly here
>>>      1 |         mov r4, r1
>>>        |         ^
>>> In file included from <built-in>:3:
>>> lib/vdso/gettimeofday.c:139:3: error: invalid instruction
>>>    139 |                 smp_rmb();
>>>        |                 ^
>>>
>>> Build log on arm:
>>> ---------
>>> In file included from arch/arm/vfp/vfpmodule.c:23:
>>> arch/arm/include/asm/cp15.h:101:2: error: instruction requires: data-barriers
>>>    101 |         isb();
>>>        |         ^
>> This is caused by a change to Debian's LLVM that changes the internal
>> defaults of the arm-linux-gnueabi and arm-linux-gnueabihf tuples:
>>
>> https://salsa.debian.org/pkg-llvm-team/llvm-toolchain/-/commit/907baf024b9a5a1626893d9e731b6c79ccf45c87
>>
>> We use arm-linux-gnueabi for the kernel (see scripts/Makefile.clang) so
>> now we have a hardcoded armv5te CPU, even if we are building for armv7
>> or such.
>>
>> I am still investigating into what (if anything) can be done to resolve
>> this on the kernel side. We could potentially revert commit
>> ddc72c9659b5 ("kbuild: clang: do not use CROSS_COMPILE for target
>> triple") but I am not sure that will save us from that change, as
>> tuxmake's CROSS_COMPILE=arm-linux-gnueabihf will cause us to have an
>> armv7 CPU even though we may not be building for armv7.
> Okay, this is a pretty awful situation the more I look into it :(
>
> The arm64 compat vDSO build is easy enough to fix because we require use
> of the integrated assembler, which means we can add '-mcpu=generic' (the
> default in LLVM for those files based on my debugging) to those files
> and be done with it:
>
> diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
> index 1f911a76c5af..5f5cb722cfc2 100644
> --- a/arch/arm64/kernel/vdso32/Makefile
> +++ b/arch/arm64/kernel/vdso32/Makefile
> @@ -9,6 +9,10 @@ include $(srctree)/lib/vdso/Makefile
>   ifeq ($(CONFIG_CC_IS_CLANG), y)
>   CC_COMPAT ?= $(CC)
>   CC_COMPAT += --target=arm-linux-gnueabi
> +# Some distributions (such as Debian) change the default CPU for the
> +# arm-linux-gnueabi target triple, which can break the build. Explicitly set
> +# the CPU to generic, which is the default for Linux in LLVM.
> +CC_COMPAT += -mcpu=generic
>   else
>   CC_COMPAT ?= $(CROSS_COMPILE_COMPAT)gcc
>   endif
>
> The failures for all the ARCH=arm configurations appear to be much more
> difficult to fix because the default CPU value changes based on the
> '-march' value, which basically means that we would have to hardcode
> LLVM's default CPU logic into the kernel's Makefile, which is just not
> maintainable in my opinion. Just doing a multi_v7_defconfig build of
> arch/arm/ shows the value returned from ARM::getARMCPUForArch() in
> llvm/lib/TargetParser/ARMTargetParser.cpp can vary between "arm7tdmi" or
> "generic". Supplying '-mcpu=generic' explicitly won't work with
> LLVM_IAS=0 because GNU as does not support it and clang just happily
> passes it along, even though it does not do that in the implicit default
> case.
>
> Sylvestre, I strongly believe you should consider reverting that change
> or give us some compiler flag that allows us to fallback to upstream
> LLVM's default CPU selection logic. I think that hardcoding Debian's
> architecture defintions based on the target triple into the compiler
> could cause issues for other projects as well. For example,
> '--target=arm-linux-gnueabi -march=armv7-a' won't actually target ARMv7:
>
>    $ echo 'int main(void) { asm("dsb"); return 0; }' | \
>          clang --target=arm-linux-gnueabi -march=armv7-a \
>          -x c -c -o /dev/null -v -
>    ...
>     "/usr/bin/clang-17" -cc1 -triple armv7-unknown-linux-gnueabi ...
>    ...
>
> vs.
>
>    $ echo 'int main(void) { asm("dsb"); return 0; }' | \
>          clang --target=arm-linux-gnueabi -march=armv7-a \
>          -x c -c -o /dev/null -v -
>    ...
>    "<prefix>/bin/clang-18" -cc1 -triple armv5e-unknown-linux-gnueabi ...
>    ...
>
I guess it is this patch, right?

https://salsa.debian.org/pkg-llvm-team/llvm-toolchain/-/commit/97633b6d51ebc8579c5dbecd12a02fb933620620

if so, do you want me to revert it?

Thanks
S

