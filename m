Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D6477D846
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 04:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241221AbjHPCPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 22:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241243AbjHPCPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 22:15:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4779E5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 19:15:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72A5262EE6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 02:15:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77DB6C433C7;
        Wed, 16 Aug 2023 02:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692152134;
        bh=g/lMKs7iiJxH3+1qd3l2lRBjL/GuWZ/t/VPJAo6sJ9g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cpx9A85uRq++Xtsjozlm3janb4fu04/7Oe0tPGAGtjXGfB6ig9hUzCOP/hTqt4G7v
         6QR3Re+px1qNrG/uRoloRGeRuT+XQjabqOkA/oHBfoxeNekBIPX2Ydk36Q4Ipqd5sq
         QCjIj0SkqEc0uQ9l/W3JT6PZq8zTqYiKqjoCB5bZ0UuRJeE+kzD6pbaq4ykeE/HImu
         huxMtDXZtcUs/ajGi9KGztrXVfZ/G1HePevbhoQQFGYaa6TTPCGyz8wb8vTBi/oouz
         ojXkcqcT85c++OSn/KkdVb7NSzFzI9tWiJQvysVKjlZN+AVUq0T/x7IK9hZXkO1jgo
         +R6fPm8cqO/Ww==
Message-ID: <51c103d8-c404-806b-ea1f-f8c03e220961@kernel.org>
Date:   Tue, 15 Aug 2023 19:15:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: {standard input}:1727: Error: operand out of range (-132 is not
 between -128 and 127)
Content-Language: en-US
To:     paulmck@kernel.org, "Liu, Yujie" <yujie.liu@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        lkp <lkp@intel.com>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        Vineet Gupta <vgupta@kernel.org>,
        linux-snps-arc@lists.infradead.org,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Claudiu Zissulescu <Claudiu.Zissulescu@synopsys.com>
References: <202308111233.rbf5C0JD-lkp@intel.com>
 <416679c9-96b3-4114-bba3-473e647c4c2d@paulmck-laptop>
 <f90742a02398f03f715b2a9afef213f5dee8f2bf.camel@intel.com>
 <574cfd03-c279-4cf7-872f-cbe0b8788a50@paulmck-laptop>
From:   Vineet Gupta <vgupta@kernel.org>
In-Reply-To: <574cfd03-c279-4cf7-872f-cbe0b8788a50@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+CC Alexey and Claudiu

On 8/15/23 09:35, Paul E. McKenney wrote:
> On Tue, Aug 15, 2023 at 07:34:04AM +0000, Liu, Yujie wrote:
>> Hi Paul,
>>
>> On Fri, 2023-08-11 at 08:41 -0700, Paul E. McKenney wrote:
>>> On Fri, Aug 11, 2023 at 01:02:12PM +0800, kernel test robot wrote:
>>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>>> head:   25aa0bebba72b318e71fe205bfd1236550cc9534
>>>> commit: a6889becb05394255c80b62103677e3b095726a9 refscale: Add tests using SLAB_TYPESAFE_BY_RCU
>>>> date:   7 months ago
>>>> config: arc-randconfig-r006-20230811 (https://download.01.org/0day-ci/archive/20230811/202308111233.rbf5C0JD-lkp@intel.com/config)
>>>> compiler: arceb-elf-gcc (GCC) 12.3.0
>>>> reproduce: (https://download.01.org/0day-ci/archive/20230811/202308111233.rbf5C0JD-lkp@intel.com/reproduce)
>>>>
>>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>>>> the same patch/commit), kindly add following tags
>>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>> Closes: https://lore.kernel.org/oe-kbuild-all/202308111233.rbf5C0JD-lkp@intel.com/
>>>> All errors (new ones prefixed by >>):
>>>>
>>>>     {standard input}: Assembler messages:
>>>>>> {standard input}:1727: Error: operand out of range (-132 is not between -128 and 127)
>>> I am not seeing any inline assembly in that patch, so I have to suspect
>>> a bug in arch code or the compiler backend for arc.
>>>
>>> Or is there something that I am missing here?
>> We looked into this case a little bit. The assembler error popped up
>> when building kernel/rcu/refscale.o
>>
>> $make W=1 --keep-going CROSS_COMPILE=arceb-elf- ARCH=arc kernel/rcu/refscale.o
>> ...
>>    CC [M]  kernel/rcu/refscale.o
>> {standard input}: Assembler messages:
>> {standard input}:1727: Error: operand out of range (-132 is not between -128 and 127)
>> make[3]: *** [scripts/Makefile.build:252: kernel/rcu/refscale.o] Error 1
>> make[2]: *** [scripts/Makefile.build:504: kernel/rcu] Error 2
>> make[2]: Target 'kernel/rcu/refscale.o' not remade because of errors.
>> make[1]: *** [scripts/Makefile.build:504: kernel] Error 2
>> make[1]: Target 'kernel/rcu/refscale.o' not remade because of errors.
>> make: *** [Makefile:2008: .] Error 2
>> make: Target 'kernel/rcu/refscale.o' not remade because of errors.
>>
>> We did some assembly and disassembly tricks:
>>
>> 1721 .L334:
>> 1722         ld_s    r0,[r14,52]             ;15
>> 1723         brgt r0, r19, @.L335
>> 1724         ld_s    r0,[r13,120]            ;15
>> 1725         breq_s r0, 0, @.L337
>> 1726         jl [r17]
>> 1727         brne_s r0, 0, @.L337    <---
>> 1728         mov_s   r2,20   ;3
>> 1729         mov_s   r1,0    ;3
>> 1730         mov_s   r0,sp   ;4
>> 1731         jl [r20]
>> 1732         mov_s   r1,0    ;3
>> 1733         mov_s   r0,sp   ;4
>> 1734         jl @init_wait_entry
>> 1735         .align 2
>>
>> This assembly instruction at line 1727 points to the code in main_func,
>> but main_func is not touched by commit a6889becb053.
>>
>>   d6e:   860d                    ld_s    r0,[r14,0x34]
>>   d70:   0b59 a002               brlt.nt r19,r0,-168     ;cc8 <main_func+0x16c>
>>          return arch_atomic_read(v);
>>   d74:   851e                    ld_s    r0,[r13,0x78]
>>                  wait_event(main_wq,
>>   d76:   e842                    breq_s  r0,0,-124       ;cf8 <main_func+0x19c>
>>   d78:   2022 0440               jl      [r17]
>>   d7c:   e8be                    brne_s  r0,0,124        ;df8 <main_func+0x29c>   <--
>>   d7e:   da14                    mov_s   r2,0x14
>>   d80:   702c                    mov_s   r1,0
>>   d82:   4083                    mov_s   r0,sp
>>   d84:   2022 0500               jl      [r20]
>>   d88:   702c                    mov_s   r1,0
>>   d8a:   4083                    mov_s   r0,sp
>>   d8c:   2022 0f80 0000 0000     jl      0
>>
>> We also tried on the parent commit 3c6496c86e48. It builds fine without
>> that assembler error, and corresponding disassembly is:
>>
>>   afe:   860d                    ld_s    r0,[r14,0x34]
>>   b00:   0b5d a002               brlt.nt r19,r0,-164     ;a5c <main_func+0x16c>
>>          return arch_atomic_read(v);
>>   b04:   8518                    ld_s    r0,[r13,0x60]
>>                  wait_event(main_wq,
>>   b06:   e844                    breq_s  r0,0,-120       ;a8c <main_func+0x19c>
>>   b08:   2022 0440               jl      [r17]
>>   b0c:   e8c0                    brne_s  r0,0,-128       ;a8c <main_func+0x19c>   <--
>>   b0e:   da14                    mov_s   r2,0x14
>>   b10:   702c                    mov_s   r1,0
>>   b12:   4083                    mov_s   r0,sp
>>   b14:   2022 0500               jl      [r20]
>>   b18:   702c                    mov_s   r1,0
>>   b1a:   4083                    mov_s   r0,sp
>>   b1c:   2022 0f80 0000 0000     jl      0
>>   b24:   724c                    mov_s   r2,2
>>   b26:   4183                    mov_s   r1,sp
>>   b28:   40c3 0000 0000          mov_s   r0,0
>>   b2e:   2022 0f80 0000 0000     jl      0
>>
>>
>> We are also not sure if this is a bug in arch code or compiler side.
>> Here we provide above info for your reference.
> Thank you for looking into this and getting back to me.
>
> I added the ARC maintainer and list on CC.
>
> 							Thanx, Paul

