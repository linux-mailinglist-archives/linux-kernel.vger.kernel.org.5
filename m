Return-Path: <linux-kernel+bounces-40871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD0483E74E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71CAD28BC76
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820EA59B43;
	Fri, 26 Jan 2024 23:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m96zRJSJ"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763B6481B9;
	Fri, 26 Jan 2024 23:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706313308; cv=none; b=l2gFYpIKSTprTqRfnkpTEe+d9hBcgtbsL1do8hKfjH3Te8Yep7awUwH2hRqZchDAbbGbvXxQ5Z+OVNzFVdDoKfpsk+IaS0Beus9TF6MzPGf4nTNz5soYXw+/rRZVFDLdXAZgmzL7cYWtjF6wdT/VC80ujL1857x93osIwdlLiuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706313308; c=relaxed/simple;
	bh=AOgcdxEuRH5OchEmeFNBfHa989J6WfMHU+g9a+jBSjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XgEqXRZE/QnaYGiDKVGUnW66OalglemOtjhR0SphLf6vHiVYO05Pi9Vs/4rClvqna77ASS1p/l9RXF8nhH8pjSXTziiDkvrMHBd60RLYzqQR4dz9RA5SLTahHrGyuwtAoeL50GWCJ4YG+FlZqFv9r0tLtev2AFS2nWPtIOoL1zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m96zRJSJ; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-53fa455cd94so670034a12.2;
        Fri, 26 Jan 2024 15:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706313306; x=1706918106; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=K5lBl4i+8P8sGKHl15bs5ZRUFHZxDH2d02stVF63r7s=;
        b=m96zRJSJ49Swsu0FeAftzpTKlaba8fBUmHbcRwfUytnO1muH0omyJsQj3ecAmb1+Ep
         NdQatUFqYdD/htEttbWRYyesNj0DbWIe8gec7hJgFZS4RHVblm7zIDOZp3u56iEf7AA0
         nw/BsvL5Ejl647C1IBzWynjWRQJ5Lg7Cxf+izhGIG6g6YT1Pb/Tq5174hEUho+blzd9r
         iuOXsNix7dEaV9k6tJFndmJ+vN5GwYKc9SY6IpEC2Su9cR72aJSQtZ2ZXFvi0Ha6cycF
         oaBTAnkGikjgGv3gcZwVZZSB3qCAQBeBRMFo63uBTyXYC0WcGX67W5cnQoK0Z4uV3j7s
         0TXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706313306; x=1706918106;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K5lBl4i+8P8sGKHl15bs5ZRUFHZxDH2d02stVF63r7s=;
        b=Oi/uLcjdwlUXQHXa+Ytqod7S1vjXzPJfrdwuMSlaGSH6tjVrnDbkR3gObFZYIF3jak
         ROu85+x+AqGzSJ68T9jXfugk2f7d8Pc9i20SFp8CVNJmYXqevWPyoVs9YuQhQqimxZJP
         NGcplzu+AVh5nbeiCrlz4+vCscj0/lyeiX9mBSPN14NvssnA7TDsx+M9hsNaLG6+wVAp
         M9tSi6KHKJwNvNHUTbYcCguJrwFpypWz8yUX/6Odlq1V9uhEDMZxDcsWKjAUpsvxgCTs
         e458LCZCQB24TfW2x0Enq5gVWqSmR/WGus7uMuTRvCPxf/xGrNOWABka+rJQsT+eo4zv
         sQyQ==
X-Gm-Message-State: AOJu0YwirhEJ3ycwuNRAOQwv/EvFewbixiCqNw7X3sGWtxCUGhiG+wtX
	wWwe9MbDH41bWt8dhh//z3gIThMd/aae6/OxgFLjCgWgSadMAzYa
X-Google-Smtp-Source: AGHT+IEn5YN9vXx4X/okeGWxRs695EvAAQoe6/z6qkoNNLbqvyhAxW3/sp1SL8UVQNtDqV60syDE4g==
X-Received: by 2002:a17:902:ceca:b0:1d5:7425:12d6 with SMTP id d10-20020a170902ceca00b001d5742512d6mr1075703plg.112.1706313305562;
        Fri, 26 Jan 2024 15:55:05 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g16-20020a170902f75000b001d74504fc3asm1459299plw.257.2024.01.26.15.55.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 15:55:04 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <bef7737e-4b8e-4a89-b538-cd8e75874fd2@roeck-us.net>
Date: Fri, 26 Jan 2024 15:55:02 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/286] 5.10.209-rc1 review
Content-Language: en-US
To: Nathan Chancellor <nathan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, llvm@lists.linux.dev, keescook@chromium.org,
 arei.gonglei@huawei.com, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux.dev, linux-crypto@vger.kernel.org
References: <20240122235732.009174833@linuxfoundation.org>
 <6b563537-b62f-428e-96d1-2a228da99077@roeck-us.net>
 <2024012636-clubbed-radial-1997@gregkh>
 <2f342268-8517-4c06-8785-96a588d20c63@roeck-us.net>
 <20240126203436.GA913905@dev-arch.thelio-3990X>
 <0a194a79-e3a3-45e7-be98-83abd3e1cb7e@roeck-us.net>
 <20240126223554.GA1320833@dev-arch.thelio-3990X>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240126223554.GA1320833@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/26/24 14:35, Nathan Chancellor wrote:
> (slimming up the CC list, I don't think this is too relevant to the
> wider stable community)
> 
> On Fri, Jan 26, 2024 at 01:01:15PM -0800, Guenter Roeck wrote:
>> On 1/26/24 12:34, Nathan Chancellor wrote:
>>> On Fri, Jan 26, 2024 at 10:17:23AM -0800, Guenter Roeck wrote:
>>>> On 1/26/24 09:51, Greg Kroah-Hartman wrote:
>>>>> On Fri, Jan 26, 2024 at 08:46:42AM -0800, Guenter Roeck wrote:
>>>>>> On 1/22/24 15:55, Greg Kroah-Hartman wrote:
>>>>>>> This is the start of the stable review cycle for the 5.10.209 release.
>>>>>>> There are 286 patches in this series, all will be posted as a response
>>>>>>> to this one.  If anyone has any issues with these being applied, please
>>>>>>> let me know.
>>>>>>>
>>>>>>> Responses should be made by Wed, 24 Jan 2024 23:56:49 +0000.
>>>>>>> Anything received after that time might be too late.
>>>>>>>
>>>>>> [ ... ]
>>>>>>
>>>>>>> zhenwei pi <pizhenwei@bytedance.com>
>>>>>>>         virtio-crypto: implement RSA algorithm
>>>>>>>
>>>>>>
>>>>>> Curious: Why was this (and its subsequent fixes) backported to v5.10.y ?
>>>>>> It is quite beyond a bug fix. Also, unless I am really missing something,
>>>>>> the series (or at least this patch) was not applied to v5.15.y, so we now
>>>>>> have functionality in v5.10.y which is not in v5.15.y.
>>>>>
>>>>> See the commit text, it was a dependency of a later fix and documented
>>>>> as such.
>>>>>
>>>>> Having it in 5.10 and not 5.15 is a bit odd, I agree, so patches are
>>>>> gladly accepted :)
>>>>>
>>>>
>>>> We reverted the entire series from the merge because it results in a build
>>>> failure for us.
>>>>
>>>> In file included from /home/groeck/src/linux-chromeos/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c:10:
>>>> In file included from /home/groeck/src/linux-chromeos/include/linux/mpi.h:21:
>>>> In file included from /home/groeck/src/linux-chromeos/include/linux/scatterlist.h:5:
>>>> In file included from /home/groeck/src/linux-chromeos/include/linux/string.h:293:
>>>> /home/groeck/src/linux-chromeos/include/linux/fortify-string.h:512:4: error: call to __read_overflow2_field declared with 'warning' attribute: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
>>>>                           __read_overflow2_field(q_size_field, size);
>>>
>>> For what it's worth, this is likely self inflicted for chromeos-5.10,
>>> which carries a revert of commit eaafc590053b ("fortify: Explicitly
>>> disable Clang support") as commit c19861d34c003 ("CHROMIUM: Revert
>>> "fortify: Explicitly disable Clang support""). I don't see the series
>>> that added proper support for clang to fortify in 5.18 that ended with
>>> commit 281d0c962752 ("fortify: Add Clang support") in that ChromeOS
>>> branch, so this seems somewhat expected.
>>>
>>
>> That explains that ;-). I don't mind if the patches stay in v5.10.y,
>> we have them reverted anyway.
>>
>> The revert was a pure process issue, as you may see when looking into
>> commit c19861d34c003, so, yes, I agree that it is self-inflicted damage.
>> Still, that doesn't explain why the problem exists in 5.18+.
>>
>>>> I also see that upstream (starting with 6.1) when trying to build it with clang,
>>>> so I guess it is one of those bug-for-bug compatibility things. I really have
>>>> no idea what causes it, or why we don't see the problem when building
>>>> chromeos-6.1 or chromeos-6.6, but (so far) only with chromeos-5.10 after
>>>> merging 5.10.209 into it. Making things worse, the problem isn't _always_
>>>> seen. Sometimes I can compile the file in 6.1.y without error, sometimes not.
>>>> I have no idea what triggers the problem.
>>>
>>> Have a .config that reproduces it on upstream? I have not personally
>>> seen this warning in my build matrix nor has our continuous-integration
>>> matrix (I don't see it in the warning output at the bottom but that
>>> could have missed something for some reason) in 6.1:
>>>
>>
>> The following command sequence reproduces the problem for me with all stable
>> branches starting with 5.18.y (plus mainline).
>>
>> rm -rf /tmp/crypto-build
>> mkdir /tmp/crypto-build
>> make -j CC=clang-15 mrproper >/dev/null 2>&1
>> make -j O=/tmp/crypto-build CC=clang-15 allmodconfig >/dev/null 2>&1
>> make -j O=/tmp/crypto-build W=1 CC=clang-15 drivers/crypto/virtio/virtio_crypto_akcipher_algs.o
>>
>> I tried clang versions 14, 15, and 16. This is with my home system running
>> Ubuntu 22.04, no ChromeOS or Google specifics/internals involved. For clang-15,
>> the version is
>>
>> Ubuntu clang version 15.0.7
>> Target: x86_64-pc-linux-gnu
>> Thread model: posix
>> InstalledDir: /usr/bin
> 
> Okay interesting, this warning is hidden behind W=1, which our CI does
> not test with. Looks like it has been that way since the introduction of
> these checks in f68f2ff91512 ("fortify: Detect struct member overflows
> in memcpy() at compile-time").
> 

Interestingly the warning is seen in chromeos-5.10, without this patch,
and without W=1. I guess that must have to do with the revert which is
finally biting us.

> I think this is a legitimate warning though. It is complaining about the
> second memcpy() in virtio_crypto_alg_akcipher_init_session():
> 
>    memcpy(&ctrl->u, para, sizeof(ctrl->u));
> 
> where ctrl is:
> 
>    struct virtio_crypto_op_ctrl_req {
>            struct virtio_crypto_ctrl_header header;         /*     0    16 */
>            union {
>                    struct virtio_crypto_sym_create_session_req sym_create_session; /*    16    56 */
>                    struct virtio_crypto_hash_create_session_req hash_create_session; /*    16    56 */
>                    struct virtio_crypto_mac_create_session_req mac_create_session; /*    16    56 */
>                    struct virtio_crypto_aead_create_session_req aead_create_session; /*    16    56 */
>                    struct virtio_crypto_akcipher_create_session_req akcipher_create_session; /*    16    56 */
>                    struct virtio_crypto_destroy_session_req destroy_session; /*    16    56 */
>                    __u8               padding[56];          /*    16    56 */
>            } u;                                             /*    16    56 */
>            union {
>                    struct virtio_crypto_sym_create_session_req sym_create_session; /*     0    56 */
>                    struct virtio_crypto_hash_create_session_req hash_create_session; /*     0    56 */
>                    struct virtio_crypto_mac_create_session_req mac_create_session; /*     0    56 */
>                    struct virtio_crypto_aead_create_session_req aead_create_session; /*     0    56 */
>                    struct virtio_crypto_akcipher_create_session_req akcipher_create_session; /*     0    56 */
>                    struct virtio_crypto_destroy_session_req destroy_session; /*     0    56 */
>                    __u8                       padding[56];          /*     0    56 */
>            };
> 
> 
>            /* size: 72, cachelines: 2, members: 2 */
>            /* last cacheline: 8 bytes */
>    };
> 
> (so size and p_size_field should be 56) and the type of the para
> parameter in virtio_crypto_alg_akcipher_init_session() is 'void *' but
> the para passed by reference to
> virtio_crypto_alg_akcipher_init_session() in virtio_crypto_rsa_set_key()
> has a type of 'struct virtio_crypto_akcipher_session_para':
> 
>    struct virtio_crypto_akcipher_session_para {
>            __le32                     algo;                 /*     0     4 */
>            __le32                     keytype;              /*     4     4 */
>            __le32                     keylen;               /*     8     4 */
>            union {
>                    struct virtio_crypto_rsa_session_para rsa; /*    12     8 */
>                    struct virtio_crypto_ecdsa_session_para ecdsa; /*    12     8 */
>            } u;                                             /*    12     8 */
>            union {
>                    struct virtio_crypto_rsa_session_para rsa;       /*     0     8 */
>                    struct virtio_crypto_ecdsa_session_para ecdsa;   /*     0     8 */
>            };
> 
> 
>            /* size: 20, cachelines: 1, members: 4 */
>            /* last cacheline: 20 bytes */
>    };
> 
> (so q_size_field would be 20 if clang were able to do inlining to see
> through the 'void *'...?), which would result in the
> 
>    __compiletime_lessthan(q_size_field, size)
> 
> check succeeding and triggering the warning because 20 < 56, so it does
> seem like there is an overread of the source buffer here? Adding the

Looks like it; I think either the passed 'para' should be of type
virtio_crypto_akcipher_create_session_req() or it should only copy
sizeof(struct virtio_crypto_akcipher_session_para) bytes.

Anyway, how did you find that ? Is there a magic trick to find the
actual code causing the warning ? I am asking because we had seen
similar warnings before, and it would help to know how to find the
problematic code.

Thanks,
Guenter

> maintainers of the driver and subsystem in question.
> 
> Cheers,
> Nathan


