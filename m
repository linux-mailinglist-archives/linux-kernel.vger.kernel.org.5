Return-Path: <linux-kernel+bounces-86645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B08A686C84F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A6F91F23DA5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB077C6CD;
	Thu, 29 Feb 2024 11:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UTZawJFm"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEDC7C6C4
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 11:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709207091; cv=none; b=WucgoA206nI91bGhjaf5VKyQjVNlGcGHyZwPogaQKAJgN32gvHboWkC218OFLuPWj+9Z4bss5QQvRqdQ8GL9bI6Lx2CKIG8awQ29EW2GtlrqZ5CHXVqPKGp3HHTDmMfS8GTaVRptvTSY0o1zRbveOkobusjK3d+DExP0wR94L9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709207091; c=relaxed/simple;
	bh=gqSm8MYLIVR/YBvqKOzvJl7HducvnUY68m5cyYziU1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nEybArv0s3C/JDidiVAJEHTKFKhzj319r2+XEPWmNBd0bP901aF6grykdaGFKPPT386LdiQplQINZReq5RxoSro9OLi1N34oj5zuYKEMgLxZDrP+SVLaR/ETbeAbuUHlIYl6MuS15C8LCEHWs7VQyC6GQ55eE5eKh89uxlfasAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UTZawJFm; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <361e1243-7975-43e1-807e-e9d4473ecc0f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709207085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KHLGt0Ofqy3PQoH+RqDHzhuytpxwAw+VoEfFRwzP40g=;
	b=UTZawJFmsLjwlPgLeg8iB8Ct94iJYfbC1jrSbhEaRgfiFMHzNTYKYLSwiZDQ53Rv+rlotr
	b7NslKmrMNT4WrLxTvXbfIuOteDzfYrVdWwEaQ6YVQRSMfycnjCrtmJ89yt2aVYrVAiUBi
	oeBPzATAZSt5zcJYJ46nVJz1O2XZIGQ=
Date: Thu, 29 Feb 2024 11:44:38 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [revert 0d60d8df6f49] [net/net-next] [6.8-rc5] Build Failure
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>,
 Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 arkadiusz.kubalewski@intel.com, jiri@nvidia.com, kuba@kernel.org,
 "abdhalee@linux.vnet.ibm.com" <abdhalee@linux.vnet.ibm.com>,
 "mputtash@linux.vnet.com" <mputtash@linux.vnet.com>,
 "sachinp@linux.vnet.com" <sachinp@linux.vnet.com>,
 venkat88@linux.vnet.ibm.com,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <3fcf3a2c-1c1b-42c1-bacb-78fdcd700389@linux.vnet.ibm.com>
 <85b78dad-affa-47c3-9cd0-79a4321460b8@linux.dev>
 <CANn89iJEzTjwxF7wXSnUR+NyDu-S-zEOYVXA+fEaYs_1o1g5HQ@mail.gmail.com>
 <a1fdd2c2-4443-458e-86db-280e7cbd4a36@linux.vnet.ibm.com>
 <CANn89iKdaMFCKnGRL4ffnbyrr2PUaKn1hoiu4VZ=sRyX=Vy0Wg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CANn89iKdaMFCKnGRL4ffnbyrr2PUaKn1hoiu4VZ=sRyX=Vy0Wg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 29/02/2024 08:55, Eric Dumazet wrote:
> On Thu, Feb 29, 2024 at 9:04 AM Tasmiya Nalatwad
> <tasmiya@linux.vnet.ibm.com> wrote:
>>
>> Greetings,
>>
>> I have tried the patch provided below. Moving struct to file
>> "net/core/rtnetlink.c" is not resolving the problem. Please find the
>> below traces.
>>
>> --- Traces ---
>>
>> In file included from ./include/linux/rbtree.h:24,
>>                    from ./include/linux/mm_types.h:11,
>>                    from ./include/linux/mmzone.h:22,
>>                    from ./include/linux/gfp.h:7,
>>                    from ./include/linux/umh.h:4,
>>                    from ./include/linux/kmod.h:9,
>>                    from ./include/linux/module.h:17,
>>                    from net/core/rtnetlink.c:17:
>> net/core/rtnetlink.c: In function ‘netdev_dpll_pin’:
>> ./include/linux/rcupdate.h:439:9: error: dereferencing pointer to
>> incomplete type ‘struct dpll_pin’
>>     typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
>>            ^
>> ./include/linux/rcupdate.h:587:2: note: in expansion of macro
>> ‘__rcu_dereference_check’
>>     __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
>>     ^~~~~~~~~~~~~~~~~~~~~~~
>> ./include/linux/rtnetlink.h:70:2: note: in expansion of macro
>> ‘rcu_dereference_check’
>>     rcu_dereference_check(p, lockdep_rtnl_is_held())
>>     ^~~~~~~~~~~~~~~~~~~~~
>> net/core/rtnetlink.c:1059:15: note: in expansion of macro
>> ‘rcu_dereference_rtnl’
>>           return rcu_dereference_rtnl(dev->dpll_pin);
>>                  ^~~~~~~~~~~~~~~~~~~~
>>     CC      crypto/algboss.o
>> net/core/rtnetlink.c:1063:1: error: control reaches end of non-void
>> function [-Werror=return-type]
>>    }
>>    ^
>>     CC      crypto/authenc.o
>>     CC      crypto/authencesn.o
>>     CC      crypto/af_alg.o
>>     CC      crypto/algif_hash.o
>>     CC      crypto/algif_skcipher.o
>>     CC      crypto/algif_rng.o
>>     CC      crypto/algif_aead.o
>>     AR      arch/powerpc/kernel/built-in.a
>> cc1: some warnings being treated as errors
>> make[4]: *** [scripts/Makefile.build:243: net/core/rtnetlink.o] Error 1
>> make[4]: *** Waiting for unfinished jobs....
>>     CC      lib/kobject_uevent.o
>>     AR      drivers/net/mdio/built-in.a
>>     AR      net/802/built-in.a
>>     AR      drivers/connector/built-in.a
>>     CC      lib/vsprintf.o
>>     AR      ipc/built-in.a
>>     AR      net/nsh/built-in.a
>>     CC      lib/dynamic_debug.o
>> In file included from ./arch/powerpc/include/generated/asm/rwonce.h:1,
>>                    from ./include/linux/compiler.h:251,
>>                    from ./include/linux/instrumented.h:10,
>>                    from ./include/linux/uaccess.h:6,
>>                    from net/core/dev.c:71:
>> net/core/dev.c: In function ‘netdev_dpll_pin_assign’:
>> ./include/linux/rcupdate.h:462:36: error: dereferencing pointer to
>> incomplete type ‘struct dpll_pin’
>>    #define RCU_INITIALIZER(v) (typeof(*(v)) __force __rcu *)(v)
>>                                       ^~~~
>> ./include/asm-generic/rwonce.h:55:33: note: in definition of macro
>> ‘__WRITE_ONCE’
>>     *(volatile typeof(x) *)&(x) = (val);    \
>>                                    ^~~
>> ./arch/powerpc/include/asm/barrier.h:76:2: note: in expansion of macro
>> ‘WRITE_ONCE’
>>     WRITE_ONCE(*p, v);      \
>>     ^~~~~~~~~~
>> ./include/asm-generic/barrier.h:172:55: note: in expansion of macro
>> ‘__smp_store_release’
>>    #define smp_store_release(p, v) do { kcsan_release();
>> __smp_store_release(p, v); } while (0)
>> ^~~~~~~~~~~~~~~~~~~
>> ./include/linux/rcupdate.h:503:3: note: in expansion of macro
>> ‘smp_store_release’
>>      smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
>>      ^~~~~~~~~~~~~~~~~
>> ./include/linux/rcupdate.h:503:25: note: in expansion of macro
>> ‘RCU_INITIALIZER’
>>      smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
>>                            ^~~~~~~~~~~~~~~
>> net/core/dev.c:9081:2: note: in expansion of macro ‘rcu_assign_pointer’
>>     rcu_assign_pointer(dev->dpll_pin, dpll_pin);
>>     ^~~~~~~~~~~~~~~~~~
>>
>> On 2/28/24 20:13, Eric Dumazet wrote:
>>> On Wed, Feb 28, 2024 at 3:07 PM Vadim Fedorenko
>>> <vadim.fedorenko@linux.dev> wrote:
>>>> On 28/02/2024 11:09, Tasmiya Nalatwad wrote:
>>>>> Greetings,
>>>>>
>>>>> [revert 0d60d8df6f49] [net/net-next] [6.8-rc5] Build Failure
>>>>>
>>>>> Reverting below commit fixes the issue
>>>>>
>>>>> commit 0d60d8df6f493bb46bf5db40d39dd60a1bafdd4e
>>>>>        dpll: rely on rcu for netdev_dpll_pin()
>>>>>
>>>>> --- Traces ---
>>>>>
>>>>> ./include/linux/dpll.h: In function ‘netdev_dpll_pin’:
>>>>> ./include/linux/rcupdate.h:439:9: error: dereferencing pointer to
>>>>> incomplete type ‘struct dpll_pin’
>>>>>      typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
>>>>>             ^
>>>>> ./include/linux/rcupdate.h:587:2: note: in expansion of macro
>>>>> ‘__rcu_dereference_check’
>>>>>      __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
>>>>>      ^~~~~~~~~~~~~~~~~~~~~~~
>>>>> ./include/linux/rtnetlink.h:70:2: note: in expansion of macro
>>>>> ‘rcu_dereference_check’
>>>>>      rcu_dereference_check(p, lockdep_rtnl_is_held())
>>>>>      ^~~~~~~~~~~~~~~~~~~~~
>>>>> ./include/linux/dpll.h:175:9: note: in expansion of macro
>>>>> ‘rcu_dereference_rtnl’
>>>>>      return rcu_dereference_rtnl(dev->dpll_pin);
>>>>>             ^~~~~~~~~~~~~~~~~~~~
>>>>> make[4]: *** [scripts/Makefile.build:243: drivers/dpll/dpll_core.o] Error 1
>>>>> make[4]: *** Waiting for unfinished jobs....
>>>>>      AR      net/mpls/built-in.a
>>>>>      AR      net/l3mdev/built-in.a
>>>>> In file included from ./include/linux/rbtree.h:24,
>>>>>                     from ./include/linux/mm_types.h:11,
>>>>>                     from ./include/linux/mmzone.h:22,
>>>>>                     from ./include/linux/gfp.h:7,
>>>>>                     from ./include/linux/umh.h:4,
>>>>>                     from ./include/linux/kmod.h:9,
>>>>>                     from ./include/linux/module.h:17,
>>>>>                     from drivers/dpll/dpll_netlink.c:9:
>>>>> ./include/linux/dpll.h: In function ‘netdev_dpll_pin’:
>>>>> ./include/linux/rcupdate.h:439:9: error: dereferencing pointer to
>>>>> incomplete type ‘struct dpll_pin’
>>>>>      typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
>>>>>             ^
>>>>> ./include/linux/rcupdate.h:587:2: note: in expansion of macro
>>>>> ‘__rcu_dereference_check’
>>>>>      __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
>>>>>      ^~~~~~~~~~~~~~~~~~~~~~~
>>>>> ./include/linux/rtnetlink.h:70:2: note: in expansion of macro
>>>>> ‘rcu_dereference_check’
>>>>>      rcu_dereference_check(p, lockdep_rtnl_is_held())
>>>>>      ^~~~~~~~~~~~~~~~~~~~~
>>>>> ./include/linux/dpll.h:175:9: note: in expansion of macro
>>>>> ‘rcu_dereference_rtnl’
>>>>>      return rcu_dereference_rtnl(dev->dpll_pin);
>>>>>             ^~~~~~~~~~~~~~~~~~~~
>>>>> make[4]: *** [scripts/Makefile.build:243: drivers/dpll/dpll_netlink.o]
>>>>> Error 1
>>>>> make[3]: *** [scripts/Makefile.build:481: drivers/dpll] Error 2
>>>>> make[3]: *** Waiting for unfinished jobs....
>>>>> In file included from ./arch/powerpc/include/generated/asm/rwonce.h:1,
>>>>>                     from ./include/linux/compiler.h:251,
>>>>>                     from ./include/linux/instrumented.h:10,
>>>>>                     from ./include/linux/uaccess.h:6,
>>>>>                     from net/core/dev.c:71:
>>>>> net/core/dev.c: In function ‘netdev_dpll_pin_assign’:
>>>>> ./include/linux/rcupdate.h:462:36: error: dereferencing pointer to
>>>>> incomplete type ‘struct dpll_pin’
>>>>>     #define RCU_INITIALIZER(v) (typeof(*(v)) __force __rcu *)(v)
>>>>>                                        ^~~~
>>>>> ./include/asm-generic/rwonce.h:55:33: note: in definition of macro
>>>>> ‘__WRITE_ONCE’
>>>>>      *(volatile typeof(x) *)&(x) = (val);    \
>>>>>                                     ^~~
>>>>> ./arch/powerpc/include/asm/barrier.h:76:2: note: in expansion of macro
>>>>> ‘WRITE_ONCE’
>>>>>      WRITE_ONCE(*p, v);      \
>>>>>      ^~~~~~~~~~
>>>>> ./include/asm-generic/barrier.h:172:55: note: in expansion of macro
>>>>> ‘__smp_store_release’
>>>>>     #define smp_store_release(p, v) do { kcsan_release();
>>>>> __smp_store_release(p, v); } while (0)
>>>>> ^~~~~~~~~~~~~~~~~~~
>>>>> ./include/linux/rcupdate.h:503:3: note: in expansion of macro
>>>>> ‘smp_store_release’
>>>>>       smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
>>>>>       ^~~~~~~~~~~~~~~~~
>>>>> ./include/linux/rcupdate.h:503:25: note: in expansion of macro
>>>>> ‘RCU_INITIALIZER’
>>>>>       smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
>>>>>                             ^~~~~~~~~~~~~~~
>>>>> net/core/dev.c:9081:2: note: in expansion of macro ‘rcu_assign_pointer’
>>>>>      rcu_assign_pointer(dev->dpll_pin, dpll_pin);
>>>>>      ^~~~~~~~~~~~~~~~~~
>>>>> make[4]: *** [scripts/Makefile.build:243: net/core/dev.o] Error 1
>>>>> make[4]: *** Waiting for unfinished jobs....
>>>>>      AR      drivers/net/ethernet/built-in.a
>>>>>      AR      drivers/net/built-in.a
>>>>>      AR      net/dcb/built-in.a
>>>>>      AR      net/netlabel/built-in.a
>>>>>      AR      net/strparser/built-in.a
>>>>>      AR      net/handshake/built-in.a
>>>>>      GEN     lib/test_fortify.log
>>>>>      AR      net/8021q/built-in.a
>>>>>      AR      net/nsh/built-in.a
>>>>>      AR      net/unix/built-in.a
>>>>>      CC      lib/string.o
>>>>>      AR      net/packet/built-in.a
>>>>>      AR      net/switchdev/built-in.a
>>>>>      AR      lib/lib.a
>>>>>      AR      net/mptcp/built-in.a
>>>>>      AR      net/devlink/built-in.a
>>>>> In file included from ./include/linux/rbtree.h:24,
>>>>>                     from ./include/linux/mm_types.h:11,
>>>>>                     from ./include/linux/mmzone.h:22,
>>>>>                     from ./include/linux/gfp.h:7,
>>>>>                     from ./include/linux/umh.h:4,
>>>>>                     from ./include/linux/kmod.h:9,
>>>>>                     from ./include/linux/module.h:17,
>>>>>                     from net/core/rtnetlink.c:17:
>>>>> ./include/linux/dpll.h: In function ‘netdev_dpll_pin’:
>>>>> ./include/linux/rcupdate.h:439:9: error: dereferencing pointer to
>>>>> incomplete type ‘struct dpll_pin’
>>>>>      typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
>>>>>             ^
>>>>> ./include/linux/rcupdate.h:587:2: note: in expansion of macro
>>>>> ‘__rcu_dereference_check’
>>>>>      __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
>>>>>      ^~~~~~~~~~~~~~~~~~~~~~~
>>>>> ./include/linux/rtnetlink.h:70:2: note: in expansion of macro
>>>>> ‘rcu_dereference_check’
>>>>>      rcu_dereference_check(p, lockdep_rtnl_is_held())
>>>>>      ^~~~~~~~~~~~~~~~~~~~~
>>>>> ./include/linux/dpll.h:175:9: note: in expansion of macro
>>>>> ‘rcu_dereference_rtnl’
>>>>>      return rcu_dereference_rtnl(dev->dpll_pin);
>>>>>             ^~~~~~~~~~~~~~~~~~~~
>>>>> In file included from net/core/rtnetlink.c:60:
>>>>> ./include/linux/dpll.h:179:1: error: control reaches end of non-void
>>>>> function [-Werror=return-type]
>>>>>     }
>>>>>
>>>> Hi, Eric!
>>>>
>>>> Looks like we have to move struct dpll_pin definition to
>>>> include/linux/dpll.h to have this fixed, right?
>>>>
>>> No idea what is wrong. Is it powerpc specific ? Some compiler version ?
>>>
>>> netdev_dpll_pin() could be moved to net/core/rtnetlink.c, this is the only user.
> 
> OK, it seems netdev_dpll_pin() has to be moved in a place the
> structure is known,
> because rcu_dereference() needs to know its size.
> 
> I do not see other solution than this, otherwise we have to add more
> pollution to include/linux/netdevice.h
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index a9c973b92294bb110cf3cd336485972127b01b58..40797ea80bc6273cae6b7773d0a3e47459a72150
> 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -2469,7 +2469,7 @@ struct net_device {
>          struct devlink_port     *devlink_port;
> 
>   #if IS_ENABLED(CONFIG_DPLL)
> -       struct dpll_pin __rcu   *dpll_pin;
> +       void __rcu *dpll_pin;
>   #endif
>   #if IS_ENABLED(CONFIG_PAGE_POOL)
>          /** @page_pools: page pools created for this netdevice */

I agree, this is the easiest solution.

Reviewed-by: Vadim Fedorenko <vadim.fedoreno@linux.dev>


