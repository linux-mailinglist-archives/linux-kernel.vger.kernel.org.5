Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531547851C5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 09:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbjHWHiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 03:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233482AbjHWHiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 03:38:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9631709;
        Wed, 23 Aug 2023 00:37:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0098A64ED9;
        Wed, 23 Aug 2023 07:37:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB316C433C7;
        Wed, 23 Aug 2023 07:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692776233;
        bh=9VDdlX8ZeyJwgIjrJNUC5vHMaGJEWMGFWPF7gHyuF/s=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=sFnsjPljkf9KB0zqv/WPZzNfzxBNzphCuj6rJFulog22LM2Y+M5kFLsDETYqBY+1+
         lyzXT/ICtWg9irLbvD7wI1G+vpjGwB57mVbhqNkXtr59ftOqXaiy6bk0/71UCQKXld
         KjO7ysc9EvbKmAmcJKdIOiURkOxdGC0Yes3hwWTEOr0VNOOR20kAxxxvogYcN3sGmJ
         UXT1AOdUGlKNpMM1FQEzJZw20naOfLsuPlP5q+Q7VpVAcO/6ECGmvRcenhuIPvtl2g
         ZbGL4GkNPm5yCaiqb129otlnhNSyjUTjFMFMO+Wg6Pz963ppUuSVkS8bTLNRDd3AY3
         SI5so7s5cc79g==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Subject: Re: linux-next: Tree for Aug 21 (riscv-64 asm)
In-Reply-To: <87bkeyxmzx.fsf@all.your.base.are.belong.to.us>
References: <20230821164605.7bac05f1@canb.auug.org.au>
 <5ebf04f8-0cf6-d2b4-fb73-f51fff421b3a@infradead.org>
 <87ttsr33a8.fsf@all.your.base.are.belong.to.us>
 <0111b49a-8cdf-2c1a-bab3-d1fd647aafa6@infradead.org>
 <87bkeyxmzx.fsf@all.your.base.are.belong.to.us>
Date:   Wed, 23 Aug 2023 09:37:10 +0200
Message-ID: <877cpmxl95.fsf@all.your.base.are.belong.to.us>
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

> Randy Dunlap <rdunlap@infradead.org> writes:
>
>> Hi,
>>
>> On 8/22/23 01:11, Bj=C3=B6rn T=C3=B6pel wrote:
>>> Randy Dunlap <rdunlap@infradead.org> writes:
>>>=20
>>>> On 8/20/23 23:46, Stephen Rothwell wrote:
>>>>> Hi all,
>>>>>
>>>>> Changes since 20230818:
>>>>>
>>>>
>>>> ../arch/riscv/kernel/traps.c: In function 'do_irq':
>>>> ../arch/riscv/kernel/traps.c:384:1: error: s0 cannot be used in 'asm' =
here
>>>>   384 | }
>>>>       | ^
>>>> ../arch/riscv/kernel/irq.c: In function 'do_softirq_own_stack':
>>>> ../arch/riscv/kernel/irq.c:94:1: error: s0 cannot be used in 'asm' here
>>>>    94 | }
>>>>       | ^
>>>>
>>>>
>>>> 2 out of 10 risc-v 64-bit builds failed with these errors.
>>>>
>>>> Is this a toolchain problem or something else?
>>>=20
>>> Hmm, do you have a link to config/toolchain/log, or similar?
>>
>> The full randconfig file is attached.
>>
>> The toolchain is Arnd's build of gcc 13.1.0 from:
>>   https://mirrors.edge.kernel.org/pub/tools/crosstool/
>> (x86_64 host)
>>
>> Hm, I see that the latest/current there is gcc 13.2.0.
>> I'll upgrade later today.
>
> Thanks Randy! I can reproduce with GCC 12 on my machine.
>
> The config has
>  | # CONFIG_FRAME_POINTER is not set
> but for some reason "-fno-omit-frame-pointer" is passed to GCC anyway,
> which is why GCC complains about s0 (FP on RISC-V) in asm.
>
>
> I'll dig a bit more.

There are multiple issues:
 * riscv enables -fno-omit-frame-pointer unconditionally for PERF_EVENTS
 * CONFIG_FUNCTION_TRACER w/o dynamic ftrace enables -pg, which pulls in
   -fno-omit-frame-pointer on riscv.

Bj=C3=B6rn

