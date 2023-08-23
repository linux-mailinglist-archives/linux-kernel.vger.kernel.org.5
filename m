Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE73785200
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 09:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbjHWHwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 03:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbjHWHwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 03:52:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DEFCE6;
        Wed, 23 Aug 2023 00:52:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C21F61920;
        Wed, 23 Aug 2023 07:52:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09211C433C8;
        Wed, 23 Aug 2023 07:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692777127;
        bh=RrVC+nogoaZgt/Y3jUBheREnMWxpQIF1TAB30x8RvjE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=dEj3Lzw7hAZZPCtkp0+9x+e7toz8Q2K8csXTxCu+eAk9U9sFpYDr7Hi16kGUZ0pNB
         ht5J8RxLaEGJPvXxfRukfSwVoO7vRtix56SNNwECn25lHhNgE9vU24qrvCd208dz7T
         76uBf2Mebi5yxvxXz7R6dGM55lIQOqIFGYlbEKMjmF88j1htqj6KYHq4Nh23NQ7d/V
         f2PG+nFdRscJGXFoCaEx3MgWhO08K8n+MQFXhgpH/UmmPd4tyTHLORNWzCGw67gjWU
         zGqIHsdO3XdCnMqsrXC+Uji5UgNFn34BKtMO4cavSTSZpC54Ef8gSQjhIhha6zEyX0
         SwgVZY6Oif3sw==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Subject: Re: linux-next: Tree for Aug 21 (riscv-64 asm)
In-Reply-To: <877cpmxl95.fsf@all.your.base.are.belong.to.us>
References: <20230821164605.7bac05f1@canb.auug.org.au>
 <5ebf04f8-0cf6-d2b4-fb73-f51fff421b3a@infradead.org>
 <87ttsr33a8.fsf@all.your.base.are.belong.to.us>
 <0111b49a-8cdf-2c1a-bab3-d1fd647aafa6@infradead.org>
 <87bkeyxmzx.fsf@all.your.base.are.belong.to.us>
 <877cpmxl95.fsf@all.your.base.are.belong.to.us>
Date:   Wed, 23 Aug 2023 09:52:04 +0200
Message-ID: <87r0nu19i3.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:

> Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:
>
>> Randy Dunlap <rdunlap@infradead.org> writes:
>>
>>> Hi,
>>>
>>> On 8/22/23 01:11, Bj=C3=B6rn T=C3=B6pel wrote:
>>>> Randy Dunlap <rdunlap@infradead.org> writes:
>>>>=20
>>>>> On 8/20/23 23:46, Stephen Rothwell wrote:
>>>>>> Hi all,
>>>>>>
>>>>>> Changes since 20230818:
>>>>>>
>>>>>
>>>>> ../arch/riscv/kernel/traps.c: In function 'do_irq':
>>>>> ../arch/riscv/kernel/traps.c:384:1: error: s0 cannot be used in 'asm'=
 here
>>>>>   384 | }
>>>>>       | ^
>>>>> ../arch/riscv/kernel/irq.c: In function 'do_softirq_own_stack':
>>>>> ../arch/riscv/kernel/irq.c:94:1: error: s0 cannot be used in 'asm' he=
re
>>>>>    94 | }
>>>>>       | ^
>>>>>
>>>>>
>>>>> 2 out of 10 risc-v 64-bit builds failed with these errors.
>>>>>
>>>>> Is this a toolchain problem or something else?
>>>>=20
>>>> Hmm, do you have a link to config/toolchain/log, or similar?
>>>
>>> The full randconfig file is attached.
>>>
>>> The toolchain is Arnd's build of gcc 13.1.0 from:
>>>   https://mirrors.edge.kernel.org/pub/tools/crosstool/
>>> (x86_64 host)
>>>
>>> Hm, I see that the latest/current there is gcc 13.2.0.
>>> I'll upgrade later today.
>>
>> Thanks Randy! I can reproduce with GCC 12 on my machine.
>>
>> The config has
>>  | # CONFIG_FRAME_POINTER is not set
>> but for some reason "-fno-omit-frame-pointer" is passed to GCC anyway,
>> which is why GCC complains about s0 (FP on RISC-V) in asm.
>>
>>
>> I'll dig a bit more.
>
> There are multiple issues:
>  * riscv enables -fno-omit-frame-pointer unconditionally for PERF_EVENTS
>  * CONFIG_FUNCTION_TRACER w/o dynamic ftrace enables -pg, which pulls in
>    -fno-omit-frame-pointer on riscv.

Maybe something like (too crude?):

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 10e7a7ad175a..cd8075c092c3 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -62,6 +62,7 @@ config RISCV
        select COMMON_CLK
        select CPU_PM if CPU_IDLE || HIBERNATION
        select EDAC_SUPPORT
+       select FRAME_POINTER if PERF_EVENTS || (FUNCTION_TRACER && !DYNAMIC=
_FTRACE)
        select GENERIC_ARCH_TOPOLOGY
        select GENERIC_ATOMIC64 if !64BIT
        select GENERIC_CLOCKEVENTS_BROADCAST if SMP
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 6ec6d52a4180..1329e060c548 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -87,9 +87,6 @@ endif
 ifeq ($(CONFIG_CMODEL_MEDANY),y)
        KBUILD_CFLAGS +=3D -mcmodel=3Dmedany
 endif
-ifeq ($(CONFIG_PERF_EVENTS),y)
-        KBUILD_CFLAGS +=3D -fno-omit-frame-pointer
-endif
=20
 # Avoid generating .eh_frame sections.
 KBUILD_CFLAGS +=3D -fno-asynchronous-unwind-tables -fno-unwind-tables
