Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F3D785100
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 08:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbjHWG7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 02:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjHWG7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 02:59:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C279CE3;
        Tue, 22 Aug 2023 23:59:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF78261044;
        Wed, 23 Aug 2023 06:59:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F75C433C8;
        Wed, 23 Aug 2023 06:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692773973;
        bh=Nb5NOLMCbzrJX2FpremlVeT/Pn2TmlTfjHH3zhMBlVo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=baXqW9D/x7mqIxT04bR8D7YS/EpFiAeSSufKKGHltxhzDeJl5YbiiE3qQcMR6iWDL
         BfC+0brQB7Mtu5zt4/lYbHTOEB3MGg0q1fgygt6V/NalvylqlaBK99iFlBv9PTOZF5
         wXDud0DVZhpo4GcafBXOo02+Njp77A4/2HCc4jz3iavegL1XCWkyCvJO9qXM6NiNKE
         XNCTUZbyPczjPTpSZ6xdokmH0Y03WgWtHcsVvskeXq58tOv2KDWK/IhLXA8x6pJY48
         omjBXXqgmSF5hAg1q8aZYb5Ge8aZ60OmVl5hLwlK6u44BjZ2PBCrq9B55MUJn/DFN3
         DKrg0+tNM97ew==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Subject: Re: linux-next: Tree for Aug 21 (riscv-64 asm)
In-Reply-To: <0111b49a-8cdf-2c1a-bab3-d1fd647aafa6@infradead.org>
References: <20230821164605.7bac05f1@canb.auug.org.au>
 <5ebf04f8-0cf6-d2b4-fb73-f51fff421b3a@infradead.org>
 <87ttsr33a8.fsf@all.your.base.are.belong.to.us>
 <0111b49a-8cdf-2c1a-bab3-d1fd647aafa6@infradead.org>
Date:   Wed, 23 Aug 2023 08:59:30 +0200
Message-ID: <87bkeyxmzx.fsf@all.your.base.are.belong.to.us>
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

Randy Dunlap <rdunlap@infradead.org> writes:

> Hi,
>
> On 8/22/23 01:11, Bj=C3=B6rn T=C3=B6pel wrote:
>> Randy Dunlap <rdunlap@infradead.org> writes:
>>=20
>>> On 8/20/23 23:46, Stephen Rothwell wrote:
>>>> Hi all,
>>>>
>>>> Changes since 20230818:
>>>>
>>>
>>> ../arch/riscv/kernel/traps.c: In function 'do_irq':
>>> ../arch/riscv/kernel/traps.c:384:1: error: s0 cannot be used in 'asm' h=
ere
>>>   384 | }
>>>       | ^
>>> ../arch/riscv/kernel/irq.c: In function 'do_softirq_own_stack':
>>> ../arch/riscv/kernel/irq.c:94:1: error: s0 cannot be used in 'asm' here
>>>    94 | }
>>>       | ^
>>>
>>>
>>> 2 out of 10 risc-v 64-bit builds failed with these errors.
>>>
>>> Is this a toolchain problem or something else?
>>=20
>> Hmm, do you have a link to config/toolchain/log, or similar?
>
> The full randconfig file is attached.
>
> The toolchain is Arnd's build of gcc 13.1.0 from:
>   https://mirrors.edge.kernel.org/pub/tools/crosstool/
> (x86_64 host)
>
> Hm, I see that the latest/current there is gcc 13.2.0.
> I'll upgrade later today.

Thanks Randy! I can reproduce with GCC 12 on my machine.

The config has
 | # CONFIG_FRAME_POINTER is not set
but for some reason "-fno-omit-frame-pointer" is passed to GCC anyway,
which is why GCC complains about s0 (FP on RISC-V) in asm.


I'll dig a bit more.
Bj=C3=B6rn
