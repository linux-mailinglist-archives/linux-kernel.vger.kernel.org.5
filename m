Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBF87F98EF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 06:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjK0FxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 00:53:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjK0FxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 00:53:07 -0500
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ae])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B170A9
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 21:53:13 -0800 (PST)
Message-ID: <a5a84482-13ef-47d8-bf07-8017060a5d64@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1701064391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FvRw6ptl4akAKpWVgSuf2f07sBHvkf30L/haNtwceS0=;
        b=OcXoQe7XBZrt74EWV4tmkjqmC7uaUeb4Rmb1c8ysV8HvVITL7Ho1BBtZuNbhaBxw9wZ7XZ
        ZzH8441lMITVK3EMYTehxBYPSrfqINYHKpJOJ/GhsTFD77n5mXIWKSvP37Rm0ZS6DTGEUl
        V51jr+XlQFr1k+FzwQChSKKWWcjVUiA=
Date:   Sun, 26 Nov 2023 21:53:04 -0800
MIME-Version: 1.0
Subject: Re: [PATCH ipsec-next v1 6/7] bpf: selftests: test_tunnel: Disable
 CO-RE relocations
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yonghong Song <yonghong.song@linux.dev>
To:     Eduard Zingerman <eddyz87@gmail.com>, Daniel Xu <dxu@dxuuu.xyz>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        antony.antony@secunet.com, Mykola Lysenko <mykolal@fb.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, devel@linux-ipsec.org,
        Network Development <netdev@vger.kernel.org>
References: <cover.1700676682.git.dxu@dxuuu.xyz>
 <391d524c496acc97a8801d8bea80976f58485810.1700676682.git.dxu@dxuuu.xyz>
 <0f210cef-c6e9-41c1-9ba8-225f046435e5@linux.dev>
 <CAADnVQ+sEsUyNYPeZyOf2PcCnxOvOqw4bUuAuMofCU14szTGvg@mail.gmail.com>
 <3ec6c068-7f95-419a-a0ae-a901f95e4838@linux.dev>
 <18e43cdf65e7ba0d8f6912364fbc5b08a6928b35.camel@gmail.com>
 <uc5fv3keghefszuvono7aclgtjtgjnnia3i54ynejmyrs42ser@bwdpq5gmuvub>
 <0535eb913f1a0c2d3c291478fde07e0aa2b333f1.camel@gmail.com>
 <42f9bf0d-695a-412d-bea5-cb7036fa7418@linux.dev>
In-Reply-To: <42f9bf0d-695a-412d-bea5-cb7036fa7418@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/27/23 12:44 AM, Yonghong Song wrote:
>
> On 11/26/23 8:52 PM, Eduard Zingerman wrote:
>> On Sun, 2023-11-26 at 18:04 -0600, Daniel Xu wrote:
>> [...]
>>>> Tbh I'm not sure. This test passes with preserve_static_offset
>>>> because it suppresses preserve_access_index. In general clang
>>>> translates bitfield access to a set of IR statements like:
>>>>
>>>>    C:
>>>>      struct foo {
>>>>        unsigned _;
>>>>        unsigned a:1;
>>>>        ...
>>>>      };
>>>>      ... foo->a ...
>>>>
>>>>    IR:
>>>>      %a = getelementptr inbounds %struct.foo, ptr %0, i32 0, i32 1
>>>>      %bf.load = load i8, ptr %a, align 4
>>>>      %bf.clear = and i8 %bf.load, 1
>>>>      %bf.cast = zext i8 %bf.clear to i32
>>>>
>>>> With preserve_static_offset the getelementptr+load are replaced by a
>>>> single statement which is preserved as-is till code generation,
>>>> thus load with align 4 is preserved.
>>>>
>>>> On the other hand, I'm not sure that clang guarantees that load or
>>>> stores used for bitfield access would be always aligned according to
>>>> verifier expectations.
>>>>
>>>> I think we should check if there are some clang knobs that prevent
>>>> generation of unaligned memory access. I'll take a look.
>>> Is there a reason to prefer fixing in compiler? I'm not opposed to it,
>>> but the downside to compiler fix is it takes years to propagate and
>>> sprinkles ifdefs into the code.
>>>
>>> Would it be possible to have an analogue of BPF_CORE_READ_BITFIELD()?
>> Well, the contraption below passes verification, tunnel selftest
>> appears to work. I might have messed up some shifts in the macro, 
>> though.
>
> I didn't test it. But from high level it should work.
>
>>
>> Still, if clang would peek unlucky BYTE_{OFFSET,SIZE} for a particular
>> field access might be unaligned.
>
> clang should pick a sensible BYTE_SIZE/BYTE_OFFSET to meet
> alignment requirement. This is also required for BPF_CORE_READ_BITFIELD.
>
>>
>> ---
>>
>> diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c 
>> b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
>> index 3065a716544d..41cd913ac7ff 100644
>> --- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
>> +++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
>> @@ -9,6 +9,7 @@
>>   #include "vmlinux.h"
>>   #include <bpf/bpf_helpers.h>
>>   #include <bpf/bpf_endian.h>
>> +#include <bpf/bpf_core_read.h>
>>   #include "bpf_kfuncs.h"
>>   #include "bpf_tracing_net.h"
>>   @@ -144,6 +145,38 @@ int ip6gretap_get_tunnel(struct __sk_buff *skb)
>>       return TC_ACT_OK;
>>   }
>>   +#define BPF_CORE_WRITE_BITFIELD(s, field, new_val) ({            \
>> +    void *p = (void *)s + __CORE_RELO(s, field, BYTE_OFFSET);    \
>> +    unsigned byte_size = __CORE_RELO(s, field, BYTE_SIZE);        \
>> +    unsigned lshift = __CORE_RELO(s, field, LSHIFT_U64); \
>> +    unsigned rshift = __CORE_RELO(s, field, RSHIFT_U64); \
>> +    unsigned bit_size = (rshift - lshift);                \
>> +    unsigned long long nval, val, hi, lo;                \
>> +                                    \
>> +    asm volatile("" : "=r"(p) : "0"(p));                \
>
> Use asm volatile("" : "+r"(p)) ?
>
>> +                                    \
>> +    switch (byte_size) {                        \
>> +    case 1: val = *(unsigned char *)p; break;            \
>> +    case 2: val = *(unsigned short *)p; break;            \
>> +    case 4: val = *(unsigned int *)p; break;            \
>> +    case 8: val = *(unsigned long long *)p; break;            \
>> +    }                                \
>> +    hi = val >> (bit_size + rshift);                \
>> +    hi <<= bit_size + rshift;                    \
>> +    lo = val << (bit_size + lshift);                \
>> +    lo >>= bit_size + lshift;                    \
>> +    nval = new_val;                            \
>> +    nval <<= lshift;                        \
>> +    nval >>= rshift;                        \
>> +    val = hi | nval | lo;                        \
>> +    switch (byte_size) {                        \
>> +    case 1: *(unsigned char *)p      = val; break;            \
>> +    case 2: *(unsigned short *)p     = val; break;            \
>> +    case 4: *(unsigned int *)p       = val; break;            \
>> +    case 8: *(unsigned long long *)p = val; break;            \
>> +    }                                \
>> +})
>
> I think this should be put in libbpf public header files but not sure
> where to put it. bpf_core_read.h although it is core write?
>
> But on the other hand, this is a uapi struct bitfield write,
> strictly speaking, CORE write is really unnecessary here. It
> would be great if we can relieve users from dealing with
> such unnecessary CORE writes. In that sense, for this particular
> case, I would prefer rewriting the code by using byte-level
> stores...
or preserve_static_offset to clearly mean to undo bitfield CORE ...

[...]

