Return-Path: <linux-kernel+bounces-60567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A548506CA
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 22:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B4DE1F21C2F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 21:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F27060272;
	Sat, 10 Feb 2024 21:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKGarICS"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCA95FB9C;
	Sat, 10 Feb 2024 21:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707602052; cv=none; b=HbAviWrk2swpVhR0H1vaSga0NSTn4jD/FnYTo5VA0G+4WPHZtk9z+VtC44Fw6TDZR1u3t8GGFMAZark48X+Wp8625afGCH+XyA7mQKF1xpN7I9xzmUVmDjBzVmUarB1p8Oo8dciHMm6JKg1RGq8fn7sAXjmi9/nSgDepdRuUGY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707602052; c=relaxed/simple;
	bh=KVFXbPUNEoPkeJ8mNzkypEy02T30WqR5YO4BksHmEaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ExYhxgk4hqSWrruFdAaIvIyNfABZQk2Mrx1pNH8XDfrZmoCLp5ytXf4tg7y58ZHK/EtfXgT5Lr6dZcsgEZuciZ7DTZS9F5kOg89Mn1eE34Jxa9meLjlsdD8IO5H8BNbquo4R1667bEbts5eMmvCaNwqbTGU4VmlTg5o+5m7CkU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKGarICS; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso1535266a12.3;
        Sat, 10 Feb 2024 13:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707602050; x=1708206850; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=89qU8d2VqYcDbQy5/Hw7nV9wcyZeWc07Nb7qZWWr1PA=;
        b=cKGarICSTCy8Jz696eS4/y+vfHpCe5bQTPtIHC4nzyudsjsGwmA8hzV8X6ZlAPxnwj
         dbb0oLjsXPNs1eWVA2fu35jpTe8wtGcJGDaoMaxM0s/ptc1HWtKplB6+7idquBJUFl3j
         GokFwSfiJMNiZQ9Ab0uMwdF61Nw+XYYhwxS28f9ZNeZ56A0R9N8BHbDQ5m9XpD3BAbrj
         OaTrM8Fwp5AqOpY9VOULN3Uc3x6KtqaSqSMvU5ml0CudKISUldrDiADy3Ec5Z6EpvSPg
         qb27TKPQHOoq2W27+tSV8iCNtTumSIyLw/toRYCNmGFPZ2ZPRd+36QaB63XQHFU7S48A
         Fsaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707602050; x=1708206850;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=89qU8d2VqYcDbQy5/Hw7nV9wcyZeWc07Nb7qZWWr1PA=;
        b=liZS/7rnwitumXWXn0/KvJ/j2e+Os/qniQCpG3a9MWXwcx/K3Pp+FexRhorSu85Okx
         KiopMd4Agc3OhA/+JlIklKr69v8yHSxQzgSiIFz5s9ZXHulO6cvaIVO9KGmGXCOOPw+i
         fQQHiLJ43K0GiHIlSenR2LsdZzNjoaPddSchdI7iqRplMjmcklpESjWdbgRiGo+Hx3sx
         VgxRQlisxoEU9rICg5jNzh0npPdJQoK1Ogm/zlMhPq8pGLpbnGm7J/omo47N0vUKzz5q
         I8j7uJjhts4MwFN5tsC5anqPd3i0hksFWmWWqXPX20Ro1iS0qKntYkvNxC5ZSNLUrbTQ
         OO8g==
X-Gm-Message-State: AOJu0YyNI/UgpdfVHa7sMfkNtQ12qouhHSR9AgGhICNE9jiUK8wvQQ7q
	8emvUzexTduBzokB/6aZMx7WkfsqS/HUXI9pj5uID+ZLy1mx4DSZ4zvak+iR
X-Google-Smtp-Source: AGHT+IGyBIrAelcIVOfr88tJlGTTkRZkjbftFplbRBqjePHF1lg+rSJ5CgaF4pFPeb5cToCyOeOZjQ==
X-Received: by 2002:a05:6a20:d708:b0:19e:bc25:c7de with SMTP id iz8-20020a056a20d70800b0019ebc25c7demr4858754pzb.48.1707602049846;
        Sat, 10 Feb 2024 13:54:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVRz27U5kWKLd9NyPKyVXMdg0QO4g1UO3Tie0OuqWpy/ItBj4gXE7BMFxPb8sOuhSk3qRBysmpDr884PUS3x0hlnKCuPwsJXaX215QSjbQFLB9M+TlaT5jHPYi1s/m41K/XN3pZ0oW8jMhtfIBxUGT3G5b7u1HZW/IYHFviTyS7otT0
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n8-20020a056a000d4800b006d638fd230bsm2834128pfv.93.2024.02.10.13.54.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Feb 2024 13:54:09 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0a0fbbd8-17dd-4f4c-9513-f3ac9749890b@roeck-us.net>
Date: Sat, 10 Feb 2024 13:54:07 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Problems with csum_partial with misaligned buffers on sh4
 platform
Content-Language: en-US
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <65ed7c95-712c-410b-84f3-58496b0c9649@roeck-us.net>
 <aedf7b7f39f820de555f1c41b6a8d663738eb3a2.camel@physik.fu-berlin.de>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <aedf7b7f39f820de555f1c41b6a8d663738eb3a2.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Adrian,

On 2/10/24 12:12, John Paul Adrian Glaubitz wrote:
> Hi Guenter,
> 
> On Sat, 2024-02-10 at 07:12 -0800, Guenter Roeck wrote:
>> when running checksum unit tests on sh4 qemu emulations, I get the following
>> errors.
>>
>>      KTAP version 1
>>      # Subtest: checksum
>>      # module: checksum_kunit
>>      1..5
>>      # test_csum_fixed_random_inputs: ASSERTION FAILED at lib/checksum_kunit.c:500
>>      Expected ( u64)result == ( u64)expec, but
>>          ( u64)result == 53378 (0xd082)
>>          ( u64)expec == 33488 (0x82d0)
>>      not ok 1 test_csum_fixed_random_inputs
>>      # test_csum_all_carry_inputs: ASSERTION FAILED at lib/checksum_kunit.c:525
>>      Expected ( u64)result == ( u64)expec, but
>>          ( u64)result == 65281 (0xff01)
>>          ( u64)expec == 65280 (0xff00)
>>      not ok 2 test_csum_all_carry_inputs
>>      # test_csum_no_carry_inputs: ASSERTION FAILED at lib/checksum_kunit.c:573
>>      Expected ( u64)result == ( u64)expec, but
>>          ( u64)result == 65535 (0xffff)
>>          ( u64)expec == 65534 (0xfffe)
>>      not ok 3 test_csum_no_carry_inputs
>>      ok 4 test_ip_fast_csum
>>      ok 5 test_csum_ipv6_magic
>> # checksum: pass:2 fail:3 skip:0 total:5
>>
>> The above is with from a little endian system. On a big endian system,
>> the test result is as follows.
>>
>>      KTAP version 1
>>      # Subtest: checksum
>>      # module: checksum_kunit
>>      1..5
>>      # test_csum_fixed_random_inputs: ASSERTION FAILED at lib/checksum_kunit.c:500
>>      Expected ( u64)result == ( u64)expec, but
>>          ( u64)result == 33488 (0x82d0)
>>          ( u64)expec == 53378 (0xd082)
>>      not ok 1 test_csum_fixed_random_inputs
>>      # test_csum_all_carry_inputs: ASSERTION FAILED at lib/checksum_kunit.c:525
>>      Expected ( u64)result == ( u64)expec, but
>>          ( u64)result == 65281 (0xff01)
>>          ( u64)expec == 255 (0xff)
>>      not ok 2 test_csum_all_carry_inputs
>>      # test_csum_no_carry_inputs: ASSERTION FAILED at lib/checksum_kunit.c:565
>>      Expected ( u64)result == ( u64)expec, but
>>          ( u64)result == 1020 (0x3fc)
>>          ( u64)expec == 0 (0x0)
>>      not ok 3 test_csum_no_carry_inputs
>>      # test_ip_fast_csum: ASSERTION FAILED at lib/checksum_kunit.c:589
>>      Expected ( u64)expected == ( u64)csum_result, but
>>          ( u64)expected == 55939 (0xda83)
>>          ( u64)csum_result == 33754 (0x83da)
>>      not ok 4 test_ip_fast_csum
>>      # test_csum_ipv6_magic: ASSERTION FAILED at lib/checksum_kunit.c:617
>>      Expected ( u64)expected_csum_ipv6_magic[i] == ( u64)csum_ipv6_magic(saddr, daddr, len, proto, csum), but
>>          ( u64)expected_csum_ipv6_magic[i] == 6356 (0x18d4)
>>          ( u64)csum_ipv6_magic(saddr, daddr, len, proto, csum) == 43586 (0xaa42)
>>      not ok 5 test_csum_ipv6_magic
>> # checksum: pass:0 fail:5 skip:0 total:5
>>
>> Note that test_ip_fast_csum and test_csum_ipv6_magic fail on all big endian
>> systems due to a bug in the test code, unrelated to this problem.
>>
>> Analysis shows that the errors are seen only if the buffer is misaligned.
>> Looking into arch/sh/lib/checksum.S, I found commit cadc4e1a2b4d2 ("sh:
>> Handle calling csum_partial with misaligned data") which seemed to be
>> related. Reverting that commit fixes the problem.
>> This suggests that something may be wrong with that commit. Alternatively,
>> of course, it may be possible that something is wrong with the qemu
>> emulation, but that seems unlikely.
> 
> I have not run these tests before. Can you tell me how these are run,
> so I can verify these reproduce on real hardware?
> 

Enabling CONFIG_KUNIT and CONFIG_CHECKSUM_KUNIT on top of a working
configuration should do the trick. Both can be built as module,
so presumably one can build and load them separately. I have not tried
that, though - I always build them into the kernel and boot the resulting
image.

Hope this helps,
Guenter


