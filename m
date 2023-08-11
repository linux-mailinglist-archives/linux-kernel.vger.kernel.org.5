Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36AA177983C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 22:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjHKUJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 16:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235546AbjHKUJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 16:09:15 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59DA30F9;
        Fri, 11 Aug 2023 13:09:08 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3180fd48489so1814889f8f.3;
        Fri, 11 Aug 2023 13:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691784547; x=1692389347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fiId7A5uZw2EU8qqzqo15ZE/APG2EJpcQ/tYWVbt9lY=;
        b=BaZ+dUQu/1Rh/HmooCs5qesrlznNZmxKQcjlG6xS3H9tMBq45bWpSP/e/I9VW7Q4Xg
         AYC3dIvP3Tshg4rhk7854uV/UhGx97vQN7Rf3ZCaEHHAoEtsxEWEmUpcEhAOLyHKUkRY
         HVVMWwEzTKjzju9rFIbSEBbfEjRns5F4jM4I+IGUunaEP+fCDTpk2oAvMHx4dL7U2RGZ
         4aZGEHqsVqDzd/Dx1nigupYSSEd6i5SYdVQlhZnYf0HmP1+JX1iQyYjTZ7iJO25zwy/W
         meLkO9bC2fWzC7AP4RiEm000UPRoQTx/kvFqN+cmSypY/c7NuSjR+Di9RfLfbQvrmzWa
         O7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691784547; x=1692389347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fiId7A5uZw2EU8qqzqo15ZE/APG2EJpcQ/tYWVbt9lY=;
        b=aa5Ld1IvZSlelk5qVUqclBzDNMxa+eHp0p7gq/PdbJuCUU4sXGFLS2Gk/uofj9DAFy
         Ew3kXAygyWUV850MYPgCrubzC7O2N49ngEMCR8dLXtxcuJt4TKbrIgeH0Kuae2mLH2jE
         L4OeTyipK3le1q3pwnXPJMxPzscpagkgp07u8Ql3fLuVC5C9JluKzdRsmHu2BfZAL2oO
         nk4VaxLXDCZat+aCVfjybGvb69ATHncsyxwO3urjx+2pWj8sreSDiC170Q79Mj0aB47U
         JQQivCcnhmrBO/29X5xltF1zcgS2b3sQSQP4aruEvsH4B0bUNUYp/z9a/zexkK8FLau1
         MfxQ==
X-Gm-Message-State: AOJu0YxVGYcn5R9vnkRAX+xSMDHyAYN1zBo8BQhcOFuUTvq/VuHFZw0H
        Amx+M/XKO7Zcb63+QAV5/74=
X-Google-Smtp-Source: AGHT+IF56byQqtdspAbdfY0iQX/Evfjk3njW6HR2sh5+JW8jK3nUCCRIGElV0mnlA998CkxmLy5Zlg==
X-Received: by 2002:a5d:5309:0:b0:313:e57b:e96d with SMTP id e9-20020a5d5309000000b00313e57be96dmr2116630wrv.36.1691784547091;
        Fri, 11 Aug 2023 13:09:07 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id g11-20020adff40b000000b00317df42e91dsm6540591wro.4.2023.08.11.13.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 13:09:06 -0700 (PDT)
Date:   Fri, 11 Aug 2023 21:09:06 +0100
From:   Stafford Horne <shorne@gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Brian Cain <bcain@quicinc.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        sparclinux@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Youling Tang <tangyouling@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Xin Li <xin3.li@intel.com>, Nhat Pham <nphamcs@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marc =?iso-8859-1?Q?Aur=E8le?= La France <tsi@tuyoix.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 16/17] [RFC] arch: turn -Wmissing-prototypes off
 conditionally
Message-ID: <ZNaVYh2qi0VQQKWf@antec>
References: <20230810141947.1236730-1-arnd@kernel.org>
 <20230810141947.1236730-17-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810141947.1236730-17-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 04:19:34PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
,,, 
> ---
> Below is the full list of warnings I see in defconfig builds for reference, these
> do not need to be part of the changelog.
...
> arch/openrisc/kernel/process.c:100:6: error: no previous prototype for 'arch_cpu_idle' [-Werror=missing-prototypes]
> arch/openrisc/kernel/process.c:240:21: error: no previous prototype for '__switch_to' [-Werror=missing-prototypes]
> arch/openrisc/kernel/ptrace.c:191:17: error: no previous prototype for 'do_syscall_trace_enter' [-Werror=missing-prototypes]
> arch/openrisc/kernel/ptrace.c:210:17: error: no previous prototype for 'do_syscall_trace_leave' [-Werror=missing-prototypes]
> arch/openrisc/kernel/signal.c:227:5: error: no previous prototype for 'do_signal' [-Werror=missing-prototypes]
> arch/openrisc/kernel/signal.c:293:1: error: no previous prototype for 'do_work_pending' [-Werror=missing-prototypes]
> arch/openrisc/kernel/signal.c:68:17: error: no previous prototype for '_sys_rt_sigreturn' [-Werror=missing-prototypes]
> arch/openrisc/kernel/time.c:111:25: error: no previous prototype for 'timer_interrupt' [-Werror=missing-prototypes]
> arch/openrisc/kernel/traps.c:146:6: error: no previous prototype for 'nommu_dump_state' [-Werror=missing-prototypes]
> arch/openrisc/kernel/traps.c:221:17: error: no previous prototype for 'die' [-Werror=missing-prototypes]
> arch/openrisc/kernel/traps.c:239:17: error: no previous prototype for 'unhandled_exception' [-Werror=missing-prototypes]
> arch/openrisc/kernel/traps.c:246:17: error: no previous prototype for 'do_fpe_trap' [-Werror=missing-prototypes]
> arch/openrisc/kernel/traps.c:268:17: error: no previous prototype for 'do_trap' [-Werror=missing-prototypes]
> arch/openrisc/kernel/traps.c:273:17: error: no previous prototype for 'do_unaligned_access' [-Werror=missing-prototypes]
> arch/openrisc/kernel/traps.c:286:17: error: no previous prototype for 'do_bus_fault' [-Werror=missing-prototypes]
> arch/openrisc/kernel/traps.c:462:17: error: no previous prototype for 'do_illegal_instruction' [-Werror=missing-prototypes]
> arch/openrisc/kernel/traps.c:67:6: error: no previous prototype for 'show_registers' [-Werror=missing-prototypes]
> arch/openrisc/mm/fault.c:44:17: error: no previous prototype for 'do_page_fault' [-Werror=missing-prototypes]
> arch/openrisc/mm/tlb.c:188:13: error: no previous prototype for 'tlb_init' [-Werror=missing-prototypes]

I'll try to get these fixed for 6.6.  I was looking at them recently but did not
actually make any changes and just put on my TODO.  Your series moves it up in
priority and it should be easy to get the fixes out.

...

> diff --git a/init/Kconfig b/init/Kconfig
> index 639e8a3363c30..80cd67c0d7fa4 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -170,6 +170,16 @@ config WERROR
>  
>  	  If in doubt, say Y.
>  
> +config WNO_MISSING_PROTOTYPES
> +	bool "Hide -Wmissing-prototype warnings in arch code"
> +	default WERROR || !COMPILE_TEST
> +	help
> +	  Some architectures have not yet eliminated all warnings for
> +	  missing prototypes in their core code and will produce a lot
> +	  of output for these. Ideally these should all be addresszed

addressed

> +	  by individual bugfix patches, but in the meantime saying 'y'
> +	  will skip that output.
> +
>  config UAPI_HEADER_TEST
>  	bool "Compile test UAPI headers"
>  	depends on HEADERS_INSTALL && CC_CAN_LINK

-Stafford
