Return-Path: <linux-kernel+bounces-68138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C2D857654
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87EC7B23F0C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298101759F;
	Fri, 16 Feb 2024 06:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIDit2tV"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C444817551;
	Fri, 16 Feb 2024 06:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708066730; cv=none; b=ahDoekM+MRAOu/GN39nA7zFLB+/HL8eC3SyN5bidm+/sQkUpDLeoczt4b/KhHTGhL3yObIL+0a/Mi/qZu8+/8ULEWsCOyaCZ2GLPvuvZ5yZ9vZKKzt4YuEqIkyZGZyd25dgBMoe9gHxqHZFGk2hRN1GbWAk7+teSslICoa78U88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708066730; c=relaxed/simple;
	bh=P6j6+1DMW+2nUeGjSEWM6OnZa73ovhFYv3veacBwZq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AGV36SZxRlCYOO6gptM0kSkwF+0IojcJNhIvESnu/MTfki45K064sFSuN8YtH4g7tvh0pxkgWlM2mkATeBVoO54lFIQxRFVvE4avr7ZLSTMNrKEHDCfBNSbcZ3cF3miC8KNPS81ijFL64ijKJ9GrvTP+KwF2NwqUNpbQhswUi1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIDit2tV; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2906bcae4feso241819a91.3;
        Thu, 15 Feb 2024 22:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708066728; x=1708671528; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=65Y20pAH9KRtgAYGxuwGuiTjTfNVvBPLnCGbqb5FxCk=;
        b=iIDit2tV5AnDc+KWyNWngVgta5xDpN2SPRkTNwJ3hUNTzDmijgKqlCjKSOb6Q7Jfo3
         IoTyMX5L4IP72WyrcTwdorNiAExy1ifxh41bGt1mCZn9bTRRnC82hTCxzHh8HUlSrz4o
         KE/OW0SBshyoP6xvHALIyM6aJZ7K0uDlv5QnGAWS5LSL1H3Z0qyLdHzmachc2jX2N+Uv
         KedgdBY1pUK3d5nEdYieximIFsJ0IlmBUu+7z92RxYQiZctbZZ6e4FhJV7FMKKSXHWI7
         FcWUlOUhLrn1bmvx045dxHQfWt9AHKn5EjjjAEO/IDNzxBHpsN7+UsERiKfoTDYAaaUO
         F+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708066728; x=1708671528;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=65Y20pAH9KRtgAYGxuwGuiTjTfNVvBPLnCGbqb5FxCk=;
        b=UsxidajonZH1W1cWkyvf/AiRSD/iXVUNOtKbHm1nRwaI34QjtSYAsAmEXrepqs5POP
         4x1DmA10+SpOSMejWMZvgsItcKa3ILmz0G0KIrxuK55rg1g21OqzdovDEojjQbF2xh2R
         sqiqUMZMJpEUUeOD3ynmGvBkQ1rppd6+j9N4znaBMmuycYlLlukCaT4VQP3gbP9li9TO
         DBU3mZ5IINSHRnypJfJ/Y77BTR+ImIuxpy9hbbIcbfGTK+BnYqs6yUKaTBO1N3DsFeKy
         nDCxw9TuCDKoTb7i1fHdC73hWXlr4p9rWbIKwP1uFO5FhdIbBzesNO0Tp6Y3EUOOVgGs
         dP0w==
X-Forwarded-Encrypted: i=1; AJvYcCXGh6rJblraYXB8Uq6Y1AfI8T81y8yd0c4tnRUYbyO4vlv6uB2yb300C541nAvEHqmySetjy+rkEahC3DAEnOKdR1uB3qOal5/jHoq7XNnfR4nZBVZTJshLtZzPlJnxhgkbrH7VPtwijNAn
X-Gm-Message-State: AOJu0Yz5pCQ1uqOBjDwa146DQ0ieMx1YZ+PqNhj5SPy9z9C4pBSr9+ED
	OpFCLkKsJkTGx8c3msJ3uhylVxiCA+VLWHuFETqtkD815jafQefn
X-Google-Smtp-Source: AGHT+IHIh71AizHTobQTAL/8XelAtKO6OAZ26d0Ggbs+Fg7dEzVMmysY5lPDz2q8Fi6bUsHSiQ7U5w==
X-Received: by 2002:a17:90a:fd0a:b0:297:a5e:c15 with SMTP id cv10-20020a17090afd0a00b002970a5e0c15mr3884344pjb.6.1708066727999;
        Thu, 15 Feb 2024 22:58:47 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id hg6-20020a17090b300600b00296b57ac914sm2525943pjb.38.2024.02.15.22.58.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 22:58:47 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ac107edb-74fd-46fa-8687-110d8db07aac@roeck-us.net>
Date: Thu, 15 Feb 2024 22:58:46 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] lib: checksum: Use aligned accesses for
 ip_fast_csum and csum_ipv6_magic tests
Content-Language: en-US
To: Helge Deller <deller@gmx.de>
Cc: Charlie Jenkins <charlie@rivosinc.com>,
 David Laight <David.Laight@aculab.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Parisc List <linux-parisc@vger.kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
References: <20240214-fix_sparse_errors_checksum_tests-v8-0-36b60e673593@rivosinc.com>
 <20240214-fix_sparse_errors_checksum_tests-v8-2-36b60e673593@rivosinc.com>
 <2ec91b11-23c7-4beb-8cef-c68367c8f029@roeck-us.net> <Zc1pSi59aDOnqz++@ghost>
 <cb4e358b-3fd0-4ca4-bf53-9cc379087304@roeck-us.net>
 <25f108d1-827f-4a18-bee4-4105fbd45974@gmx.de>
 <b8065a61-f5eb-4ec5-a9af-6d6bcdf1ee9b@roeck-us.net>
 <7b207808-10e7-44b0-9a9f-253e2349011d@gmx.de>
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
In-Reply-To: <7b207808-10e7-44b0-9a9f-253e2349011d@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Helge,

On 2/15/24 23:31, Helge Deller wrote:
> On 2/16/24 06:25, Guenter Roeck wrote:
>> On Fri, Feb 16, 2024 at 06:54:55AM +0100, Helge Deller wrote:
>>>
>>> Can you please give a pointer to this test code?
>>> I'm happy to try it on real hardware.
>>>
>> See below.
> 
> Testcase runs OK on physical machine:
> 
> #### carry64 aligned, expect 1 -> 1
> #### carry64 unaligned 4, expect 1 -> 1
> #### carry64 unaligned 2, expect 1 -> 1
> #### carry32 aligned, expect 1 -> 1
> #### carry64 unaligned, expect 1 -> 1
> #### carry64 aligned, expect 0 -> 0
> #### carry64 unaligned 4, expect 0 -> 0
> #### carry64 unaligned 2, expect 0 -> 0
> #### carry32 aligned, expect 0 -> 0
> #### carry32 unaligned, expect 0 -> 0
>      ok 6 test_bad_carry
> 

thanks a lot for the confirmation.

Guenter


