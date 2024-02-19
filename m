Return-Path: <linux-kernel+bounces-71993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 418DD85AD92
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0A151F23A76
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DB653E13;
	Mon, 19 Feb 2024 21:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="c7WVwgx6"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30432E40C;
	Mon, 19 Feb 2024 21:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708377143; cv=none; b=TEgtCLmSWuV5TlCI57DOchP4AGGKSegzaZtN/WkCSlQdbq5g+cKWdx20Uf5FCklHPI0SogWBQ+WcXQL20+8lYK1XaxWkktKu1XG0TbRa2ZFUJo6v1RPQlbI7WDHb+a8vw3Tzc5N0kARl1PqDeKqetgBY87ChYoX+kWEacI/Ame4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708377143; c=relaxed/simple;
	bh=0dZt+PoXfdZjATe9Hle1yjYnVPuWZbSyuYqI8JtPTyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VkB8eLp9UeX7CeK9UQfPX2fghLPDfi53v9TJvFkdXd0wF7+BfbKsh+h9eggpq/eSXfTfx5hbHsaWZ5CF4HuWWrKskQYjMZAf/ghfGGm34A/RC7qIqhPhabwvbJOk9zfHF8FtWLfuz27y9Yxh90Hafg+JnhY4auUQMhvanKzvqvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=c7WVwgx6; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1708377116; x=1708981916; i=deller@gmx.de;
	bh=0dZt+PoXfdZjATe9Hle1yjYnVPuWZbSyuYqI8JtPTyI=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=c7WVwgx63vW+1+V/3MLGwGLn2Qtulsk+acm5XXbJBG/uZ395dd//8DMzunFxm2ZN
	 E77Rul+fNDWwLXi4IRCgMXS7DnKapGVH9SdugUYc52Gk77XRsGtVPfhh109uChFga
	 /K6YoNPHGP3EpvDNsOYj3fmdsYlwCEz2Dj+tJLjBquBYaQdsvQSLgazZ5ODDOAa1K
	 14UA98ixhFr4AB4K6bypqvWbbijI8/6uFOaqTwBPVgZ9w8FVhB10Ou8qkGVBz1xh2
	 M26QQr9cyA+4lTlAqaqUl0et3ukdvTtVeWD/BtZtWXPO7aLn+7Sh7njcKgm+QA/N6
	 kUIWS01GWsxdypbXjA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.155.130]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrQEn-1r7Z8u48Nb-00oU3p; Mon, 19
 Feb 2024 22:11:56 +0100
Message-ID: <f49c1752-3925-47f6-b489-ffa453f15260@gmx.de>
Date: Mon, 19 Feb 2024 22:11:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] parisc: Fix csum_ipv6_magic on 64-bit systems
Content-Language: en-US
To: Charlie Jenkins <charlie@rivosinc.com>, Helge Deller <deller@kernel.org>,
 Guenter Roeck <linux@roeck-us.net>
Cc: "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Palmer Dabbelt <palmer@rivosinc.com>
References: <20240213234631.940055-1-linux@roeck-us.net>
 <Zc9XW-TxQKp84vMt@p100> <ZdAhQHFXUF7wEWea@ghost>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <ZdAhQHFXUF7wEWea@ghost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pn7BuT8QnGgJrmUlidl4hqDNTJzUmHdoIWuZZCrKCcMbxez94wL
 8MUeuvnqPESfBm7fscuOLzg2kzSvlzE/jeU7ZWu4SpZvTKr5genWqjhIlt7jiupkHfnXrnw
 0oBnVKlpPcigtCBfFS/yXPcNydgo4jEpCBtSIZfjhfqIfgMU4AgQjBiIx9aSGgVpfOIl7m+
 A/nqeYhIvukciFGullm8g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Q7Q0tzYfQ+M=;lRDRA532PjXeWWWLG1jFHwul3th
 oEGKD0gSV7no/i7InUgvbWuysvU9zFfPChXc+FI/PxYQJYYmb13htbntI7IJIP2MR3d5oH2oY
 P7RiXGkjfGoQK7QcC7xAeJkNxBcPOoBbf51zNiC0B15kPiWwwwrP6hu4ziW/HEia+7RG5VdA6
 SMS1ZXwJs0Bv4Te/iG4lZW7DY3fQF3tuSQ8xlihVJm2LhJAYS2yWaxBU1u8wQaZustm9f9POS
 y0jUXCjKOgOsFHgd6UbWWIrT2qYdwsl2h/4U13tcUwExGRZBbBGnvDPKNkNvpwWc4hLPDO2Hs
 6flvq82Be9ULWAZQ5u1D1foaUO7/JbwVTSUu/pOYnYPetmMP6sDyg/mwuzRWIKMVrHAbQnyow
 uCImILBZE2L1XTlyqzMwOCyvuqpKD6usQEXzystfUY7xgYg7AdQqyVLNvMJ/Ufh5hLtqfu506
 HhWAZoYp4czqmhQiRmj+LHf/7BP1/qmujbRAzs/eEf418Di+Hwt3+ns1Lazb5BSLnzLPgl483
 ykWoAGZkVvqawG4q9SxIw2PdBq9hKSYIm1/7StQ0cU47N0b65bvtofoFDrSUCp6ZNAlvF2/HF
 eV9X6JsZuf4qYigrT36e0+2NyoMduHFDLt406byBpzVB7xVcbu3mDmz7nfOuDzq9zPmFNNiRS
 6CucUpJ9ClAyHovLtU7SuHjyYod3HzJy/rBTxPc5VaBunMUv3fK/EHRbYzk5DHzWAfPEoitzK
 UI1m0MgBQf+UurI5FeEzJMNEduuqLVzkDgvEMLJNG+8lkNEhTAL3Fpra7cdgIEESIs/bGLrOx
 Yo8QH/bXItPHEjbiqcwUShxFbgf4+B1CHi2kDwQu7JFj4=

On 2/17/24 04:00, Charlie Jenkins wrote:
> On Fri, Feb 16, 2024 at 01:38:51PM +0100, Helge Deller wrote:
>> * Guenter Roeck <linux@roeck-us.net>:
>>> hppa 64-bit systems calculates the IPv6 checksum using 64-bit add
>>> operations. The last add folds protocol and length fields into the 64-=
bit
>>> result. While unlikely, this operation can overflow. The overflow can =
be
>>> triggered with a code sequence such as the following.
>>>
>>> 	/* try to trigger massive overflows */
>>> 	memset(tmp_buf, 0xff, sizeof(struct in6_addr));
>>> 	csum_result =3D csum_ipv6_magic((struct in6_addr *)tmp_buf,
>>> 				      (struct in6_addr *)tmp_buf,
>>> 				      0xffff, 0xff, 0xffffffff);
>>>
>>> Fix the problem by adding any overflows from the final add operation i=
nto
>>> the calculated checksum. Fortunately, we can do this without additiona=
l
>>> cost by replacing the add operation used to fold the checksum into 32 =
bit
>>> with "add,dc" to add in the missing carry.
>>
>>
>> Gunter,
>>
>> Thanks for your patch for 32- and 64-bit systems.
>> But I think it's time to sunset the parisc inline assembly for ipv4/ipv=
6
>> checksumming.
>> The patch below converts the code to use standard C-coding (taken from =
the
>> s390 header file) and it survives the v8 lib/checksum patch.
>>
>> Opinions?
>> [...]

> We can do better than this! By inspection this looks like a performance
> regression.
> [...]
> Similar story again here where the add with carry is not well translated
> into C, resulting in significantly worse assembly. Using __u64 seems to
> be a big contributing factor for why the 32-bit assembly is worse.
>
> I am not sure the best way to represent this in a clean way in C.
>
> add with carry is not well understood by GCC 12.3 it seems. These
> functions are generally heavily optimized on every architecture, so I
> think it is worth it to default to assembly if you aren't able to
> achieve comparable performance in C.

Thanks a lot for your analysis!!!
I've now reverted my change to switch to generic code and applied
the 3 suggested patches from Guenter which fix the hppa assembly.
Let's see how they behave in the for-next git tree during the next few day=
s.

Helge

