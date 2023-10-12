Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F5A7C7133
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 17:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343696AbjJLPPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 11:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347303AbjJLPPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 11:15:51 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8424D9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 08:15:48 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-406aaccb41dso3571325e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 08:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697123747; x=1697728547; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H40DjF2DvqAhDOEevi599YrHU/CFw/Fi+zNNdBCogjA=;
        b=PNmY7qfsJg3qA3AO6xKiAA4NxniEBVrJkyckd53w30xZpAd5dOgSGGb9QHvrBXGwQ2
         MbtrieVgkI4k0FunlkNKCTEfHQvpm8Vxb6mrxmFVHOdElFJZMAr30WS/NYGmkZsapG09
         JuZanPHmB8N75iOTNFYEcsBoxkPGDb0P+4ECOkC+TxfCrm1GpFU4r+c9mRvwIPoIaYiL
         ibc41BILwn3CiQEbAUiZVQ0vn0MGdffGlBHLtosFCq4EGCwqxQExLmiprjvED/ZzYy8/
         XnC0eqElz5GHUJsYUeNB6cB1Ij0vYwioV1i/ZsUvU6h4PX6nro6WYD09JQLWemKmBvqu
         nisA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697123747; x=1697728547;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H40DjF2DvqAhDOEevi599YrHU/CFw/Fi+zNNdBCogjA=;
        b=QkQaYSQShsBmjs/f2Tue49YnmMqmNrBvnoU15dvYG650vBXUd4D/B9S4mdfX2TKo8u
         78xDIuz08tfTH0D18fpO0SgeamEklNGgRNVKR/AaPXpwNsbfx/1GPtXgSMYN2odc/ox7
         1Gf2r/uPK20KGQbTSu3hdYHl1viMb/MvLnz7prScuxzSssurPRzzIOdxnPKyyrmJQ5Ix
         D6c0BHSiHTr3KhOvlhp/DwkCsO1Zgiww99pELAvQSApdIT5Vzy0Erq62bsOzqn9lbnnR
         v9d/4dSC9oqF8uYWaT7NJX3HQ1tHF+3jLI22K++2NaMvLEkC0jZJX/X94f3YomHfJcBt
         i+ew==
X-Gm-Message-State: AOJu0YxN6AvsRikqMqdha5eGXB6/+efrSd8qeVU0rNu/oqNOG91feKAb
        GQUGw7mOyzGpTzbhAXaPBvu7yQ==
X-Google-Smtp-Source: AGHT+IGgtyD7d5JdTAOBgsfaVSkKTyr+ixUgoSAdL+LWzbJmc7NFj9h7df+UzeVb5v70tLe13yfemg==
X-Received: by 2002:a05:600c:214f:b0:406:513d:738f with SMTP id v15-20020a05600c214f00b00406513d738fmr21976065wml.2.1697123746655;
        Thu, 12 Oct 2023 08:15:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:3fed:c1e5:145f:8179? ([2a01:e0a:999:a3a0:3fed:c1e5:145f:8179])
        by smtp.gmail.com with ESMTPSA id m16-20020a7bca50000000b003fee6e170f9sm76694wml.45.2023.10.12.08.15.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 08:15:46 -0700 (PDT)
Message-ID: <7b71ff39-bbc0-4ba9-8b98-d36fa127316e@rivosinc.com>
Date:   Thu, 12 Oct 2023 17:15:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/13] riscv: add ISA extension probing for Zv*
 extensions
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>
References: <20231011111438.909552-1-cleger@rivosinc.com>
 <20231011111438.909552-3-cleger@rivosinc.com>
 <b157edc4-a21f-40ac-8c9f-e989b34bb872@rivosinc.com>
 <20231012-darkness-neutron-fc1843ff05ff@spud>
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20231012-darkness-neutron-fc1843ff05ff@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/10/2023 16:10, Conor Dooley wrote:
> On Thu, Oct 12, 2023 at 03:17:14PM +0200, Clément Léger wrote:
>>
>>
>> On 11/10/2023 13:14, Clément Léger wrote:
>>> Add probing of some Zv* ISA extensions that are mentioned in "RISC-V
>>> Cryptography Extensions Volume II" [1]. These ISA extensions are the
>>> following:
>>>
>>> - Zvbb: Vector Basic Bit-manipulation
>>> - Zvbc: Vector Carryless Multiplication
>>> - Zvkb: Vector Cryptography Bit-manipulation
>>> - Zvkg: Vector GCM/GMAC.
>>> - Zvkned: NIST Suite: Vector AES Block Cipher
>>> - Zvknh[ab]: NIST Suite: Vector SHA-2 Secure Hash
>>> - Zvksed: ShangMi Suite: SM4 Block Cipher
>>> - Zvksh: ShangMi Suite: SM3 Secure Hash
>>> - Zvkn: NIST Algorithm Suite
>>> - Zvknc: NIST Algorithm Suite with carryless multiply
>>> - Zvkng: NIST Algorithm Suite with GCM.
>>> - Zvks: ShangMi Algorithm Suite
>>> - Zvksc: ShangMi Algorithm Suite with carryless multiplication
>>> - Zvksg: ShangMi Algorithm Suite with GCM.
>>> - Zvkt: Vector Data-Independent Execution Latency.
>>>
>>> [1] https://drive.google.com/file/d/1gb9OLH-DhbCgWp7VwpPOVrrY6f3oSJLL/view
>>>
>>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>>> ---
>>>  arch/riscv/include/asm/hwcap.h | 16 ++++++++++++++++
>>>  arch/riscv/kernel/cpufeature.c | 16 ++++++++++++++++
>>>  2 files changed, 32 insertions(+)
>>>
>>> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
>>> index b7b58258f6c7..4e46981ac6c8 100644
>>> --- a/arch/riscv/include/asm/hwcap.h
>>> +++ b/arch/riscv/include/asm/hwcap.h
>>> @@ -58,6 +58,22 @@
>>>  #define RISCV_ISA_EXT_ZICSR		40
>>>  #define RISCV_ISA_EXT_ZIFENCEI		41
>>>  #define RISCV_ISA_EXT_ZIHPM		42
>>> +#define RISCV_ISA_EXT_ZVBB		43
>>> +#define RISCV_ISA_EXT_ZVBC		44
>>> +#define RISCV_ISA_EXT_ZVKB		45
>>> +#define RISCV_ISA_EXT_ZVKG		46
>>> +#define RISCV_ISA_EXT_ZVKN		47
>>> +#define RISCV_ISA_EXT_ZVKNC		48
>>> +#define RISCV_ISA_EXT_ZVKNED		49
>>> +#define RISCV_ISA_EXT_ZVKNG		50
>>> +#define RISCV_ISA_EXT_ZVKNHA		51
>>> +#define RISCV_ISA_EXT_ZVKNHB		52
>>> +#define RISCV_ISA_EXT_ZVKS		53
>>> +#define RISCV_ISA_EXT_ZVKSC		54
>>> +#define RISCV_ISA_EXT_ZVKSED		55
>>> +#define RISCV_ISA_EXT_ZVKSH		56
>>> +#define RISCV_ISA_EXT_ZVKSG		57
>>
>> About Zvks/Zvkn, these extensions are actually shorthand for a few other
>> sub-extensions, it is still not clear if it should be parsed as is.
>> There are multiple solutions:
>>
>> - Handle them as-is, simply enable the extension, if reported through
>> hwprobe, userspace will be responsible to detect the sub-extensions
>> (current approach)
> 
> I dislike this, since in-kernel users will have to check for "parent" &
> "child" extensions.
> 
>> - "Unfold" the extension in order to enable all the sub-extensions and
>> keep the main one (for instance for Zvkn, enable Zvkned, Zvknhb, Zvkb,
>> Zvkt, Zvkn)
> 
> We threw together some code for this a few months ago after some
> discussion with some of your Rivos colleagues. The initial version of it
> was in this thread with Evan:
> https://lore.kernel.org/all/20230703-mangle-panning-75909ebbe30c@spud/
> and in a later iteration there was some more done by myself and Drew:
> https://lore.kernel.org/all/20230713-bootleg-tray-c5bfe58b5673@wendy/
> One of the versions ended up as the riscv-extensions-strings-scalar-crypto
> branch in my k.org repo:
> https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/log/?h=riscv-extensions-strings-scalar-crypto
> 

Thanks for these information ! I think your version to handle extension
group is pretty clean. Are you waiting for anything in particular except
a Signed-off: from Evan to submit that patch ? If so, can I backport
this patch in my branch, gather Evan SoB and rebase my series on top of it ?

> That crypto stuff has all gone quiet of late unfortunately. I wonder if
> Samuel is still working on it.

I talked with Samuel and we agreed on the following plan: I'll actually
carry on the bitmanip ISA part and he will resubmit the Zkr with
archrandom part.

> 
>> - "Unfold" but don't keep the extension "shorthand" in the ISA extension
>> list (for instance for Zvkn, enable Zvkned, Zvknhb, Zvkb, Zvkt)
> 
> But I would also be fine with this one from a pure in-kernel PoV.

Which is the case with your version FWIU (ie, only the child extensions
are visible).

> I think it's likely to be annoying for users though, since they won't be
> able to poll for the "parent" unless we re-assemble the parents in
> hwprobe etc (eugh).

Indeed, and re-assembling the parent is IMHO duplication of the existing
information. Checking that the needed ISA extensions are present will be
simple enough (simple bitmask) so I'm not sure that re-assembling the
parents is necessary (But that's a personal statement and I'm pretty
sure others will like it to be provided directly).

Thanks,

Clément

> 
> - don't permit passing the "parents" at all, and only deal with the
>   "children". We can enforce this for DT, but not for ACPI, so probably
>   not a runner>
> Thanks,
> Conor.
> 
>>
>> Thanks,
>>
>> Clément
>>
>>> +#define RISCV_ISA_EXT_ZVKT		58
>>>  
>>>  #define RISCV_ISA_EXT_MAX		64
>>>  
>>> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
>>> index 1cfbba65d11a..859d647f3ced 100644
>>> --- a/arch/riscv/kernel/cpufeature.c
>>> +++ b/arch/riscv/kernel/cpufeature.c
>>> @@ -174,6 +174,22 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
>>>  	__RISCV_ISA_EXT_DATA(zba, RISCV_ISA_EXT_ZBA),
>>>  	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
>>>  	__RISCV_ISA_EXT_DATA(zbs, RISCV_ISA_EXT_ZBS),
>>> +	__RISCV_ISA_EXT_DATA(zvbb, RISCV_ISA_EXT_ZVBB),
>>> +	__RISCV_ISA_EXT_DATA(zvbc, RISCV_ISA_EXT_ZVBC),
>>> +	__RISCV_ISA_EXT_DATA(zvkb, RISCV_ISA_EXT_ZVKB),
>>> +	__RISCV_ISA_EXT_DATA(zvkg, RISCV_ISA_EXT_ZVKG),
>>> +	__RISCV_ISA_EXT_DATA(zvkn, RISCV_ISA_EXT_ZVKN),
>>> +	__RISCV_ISA_EXT_DATA(zvknc, RISCV_ISA_EXT_ZVKNC),
>>> +	__RISCV_ISA_EXT_DATA(zvkned, RISCV_ISA_EXT_ZVKNED),
>>> +	__RISCV_ISA_EXT_DATA(zvkng, RISCV_ISA_EXT_ZVKNG),
>>> +	__RISCV_ISA_EXT_DATA(zvknha, RISCV_ISA_EXT_ZVKNHA),
>>> +	__RISCV_ISA_EXT_DATA(zvknhb, RISCV_ISA_EXT_ZVKNHB),
>>> +	__RISCV_ISA_EXT_DATA(zvks, RISCV_ISA_EXT_ZVKS),
>>> +	__RISCV_ISA_EXT_DATA(zvksc, RISCV_ISA_EXT_ZVKSC),
>>> +	__RISCV_ISA_EXT_DATA(zvksed, RISCV_ISA_EXT_ZVKSED),
>>> +	__RISCV_ISA_EXT_DATA(zvksh, RISCV_ISA_EXT_ZVKSH),
>>> +	__RISCV_ISA_EXT_DATA(zvksg, RISCV_ISA_EXT_ZVKSG),
>>> +	__RISCV_ISA_EXT_DATA(zvkt, RISCV_ISA_EXT_ZVKT),
>>>  	__RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
>>>  	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
>>>  	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
