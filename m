Return-Path: <linux-kernel+bounces-63027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A1D85297B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38CEFB2361A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC69A17556;
	Tue, 13 Feb 2024 06:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/vyQ2CC"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11574171A1;
	Tue, 13 Feb 2024 06:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707807471; cv=none; b=P+oelPsPbs2gBSM2JmBnUMurqvgT1lae5/OavoqsNn4Dp2PPqQRSwopxfXj2Q6ypyS1QxoDTX030x4FYtEKJLsLUxmC3ufE6yvuTxdfTb2MXyr6po5bWxGO5NSaDxm/Zc2y9pf0nG8QS1VPWc9mqPaxNN3rMesTwum3nbV8aCzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707807471; c=relaxed/simple;
	bh=gT5PoSFDecpRTzXKAbOH0bjajfmmmK3IMCYPq9Ny0+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KFIxqKh2wH0K9d5XXvZ77lZMIYw/6CBI+qZFOWPCz8soDWdrO4NWK/6g6W9ciFAX0puQRv+2bl+0pSQsiy+SRPNMIY2Mhf+D2V/x9SLMTyK52lRbnORfdBY7qt3svPbPLmnrWcTpBBKELyK+mLZ0p0IKc/jkDvM2hMVABBJQURQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/vyQ2CC; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d7431e702dso34366065ad.1;
        Mon, 12 Feb 2024 22:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707807469; x=1708412269; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=4RBBXmYCZmzVxeyw1ClmQlt7t+/OWQfBpLkt/0C1K3Y=;
        b=j/vyQ2CCrvg2LHB17kXt/TOrFPK6W1CB0fZeJQMHYHFLE1O+ieYso6tV5o1LSSWVbw
         Y1FIVHzyWGZpiHX9E6OCg3Vo+tobgxylnZurW4JL5o7DH029qv9HjQjATlUDcesjrtGW
         pfdI84LWM82y9BKzrKHjJs5RResrc6Ng4/s800IDGgq3+AmGs8cuixACxAFvn4oMvPRz
         tcBB1nUYLJPpI+FhaHwpEaNN3Ppk8mIhcTC/rpJCyTT7qg8JB95THY2hThliGZ6DTE4E
         TqDsl7f78UV4UlTbTaBnaz87uH5J3BKhuD4lI7YFIvzozIrob7OolzbuCGnRCOX1Krvr
         gbJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707807469; x=1708412269;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4RBBXmYCZmzVxeyw1ClmQlt7t+/OWQfBpLkt/0C1K3Y=;
        b=CorPDvo5hGQ+IumCeIkG1QYRsseyLACEckYwPrC73PHrZYWyvFSi84Myqvl3iYjk5O
         22TpGl4785L0A4uqvLQkXl/N4DiVKhrhm69jqSkKLpAN7qfiQsWrgH4VHNO0ZnKrzrUr
         t/OJ5qtE/3yJftnk2KlzVLAUx2MhhZuamrDc7UJxSoywFqg4NmMVpmgPAZarW8389OdY
         gpx0++1rUEYHY6JBPmCfFR3KlJypr/KzOhCuZQQgL4cL+F8+Vw7iD6V4gm4abiytm+0N
         S/Bz1qm5wOwaAMMdNYPuVSqsmA4nls2DJnyeYCTPPRAlB0oSO+P7cstlBF5tnCqS7Ig2
         Q/Kg==
X-Forwarded-Encrypted: i=1; AJvYcCU7DKcgeCQLWLwsk10KVqFqfFKrdQEhi4nNDuWRNhWBQxxuFqL1v2CzWcwpBGj/FwTiZ8RlnsLbWvK6IJg0Y/opxdBYH+Nd+GUqplp3TJAFmgaRbS32Gh8CVTn6x2VQgXRcd6ZSYks4fIt8
X-Gm-Message-State: AOJu0YwgSqxmtW/8w59tN8DPh7EYq8O9sq+lPc/VT5NJdgtlnlepJ8px
	HvFaCv399cmHRNIQDRYavS4N5qXS07NUkg9C+OsiWXy1EZ8im4b+
X-Google-Smtp-Source: AGHT+IHEHHfTWYFBWOzr/f+RLghW8L8ckcGN+ebSGePMTt/AXGpQPwm4c94LL+tfynV09QJnJ2mYeQ==
X-Received: by 2002:a17:903:2593:b0:1db:40a4:1e2d with SMTP id jb19-20020a170903259300b001db40a41e2dmr209035plb.29.1707807469358;
        Mon, 12 Feb 2024 22:57:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVCJtmwvNkuhfcqN2DxZ7NfiYEgL1o6YLgW1b0n9RjepojuCRizAGKBJI2RJJCkAWnGEH2ixHOK5CnarXk4uBeFVPg6FC9iUaOW09bg5LGely2ea1wZZGWGeTzRNcb3BDdKxMvzSCUNXn7AnUgNv4Z86FTaeClz+nDwsvtHeX4erfnPIxdMijamPfRcSdN6gjLIZgW4G4GDDphLyo5gIYL7xZvRnCGHAAl7oZbrLRHXcgxv5knSqZFlGa+CrVzcbSEtQWt6KudQWyfPZRcG2AAOxCN3u5v+tPCFCeYqEP8o6Vm/zE+SytUz
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o8-20020a17090323c800b001d78a08e8e7sm1382596plh.250.2024.02.12.22.57.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 22:57:48 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a430a0b7-28b3-45aa-b9b3-6edbfda36acc@roeck-us.net>
Date: Mon, 12 Feb 2024 22:57:47 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] lib: checksum: Use aligned accesses for
 ip_fast_csum and csum_ipv6_magic tests [issues with parisc64]
Content-Language: en-US
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: David Laight <David.Laight@aculab.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Andrew Morton <akpm@linux-foundation.org>, Al Viro
 <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
 Helge Deller <deller@gmx.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Parisc List <linux-parisc@vger.kernel.org>
References: <20240212-fix_sparse_errors_checksum_tests-v7-0-bbd3b8f64746@rivosinc.com>
 <20240212-fix_sparse_errors_checksum_tests-v7-2-bbd3b8f64746@rivosinc.com>
 <dc352315-0b7b-407a-8704-e424934a922d@roeck-us.net> <Zcq4jj3vsVtqQIHr@ghost>
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
In-Reply-To: <Zcq4jj3vsVtqQIHr@ghost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/12/24 16:32, Charlie Jenkins wrote:
> On Mon, Feb 12, 2024 at 04:14:49PM -0800, Guenter Roeck wrote:
>> On 2/12/24 12:33, Charlie Jenkins wrote:
>>> The test cases for ip_fast_csum and csum_ipv6_magic were failing on a
>>> variety of architectures that are big endian or do not support
>>> misalgined accesses. Both of these test cases are changed to support big
>>> and little endian architectures.
>>>
>>> The test for ip_fast_csum is changed to align the data along (14 +
>>> NET_IP_ALIGN) bytes which is the alignment of an IP header. The test for
>>> csum_ipv6_magic aligns the data using a struct. An extra padding field
>>> is added to the struct to ensure that the size of the struct is the same
>>> on all architectures (44 bytes).
>>>
>>> Fixes: 6f4c45cbcb00 ("kunit: Add tests for csum_ipv6_magic and ip_fast_csum")
>>> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
>>
>> This thing really wants to annoy me. Now I get:
>>
>>       # test_csum_ipv6_magic: ASSERTION FAILED at lib/checksum_kunit.c:494
>>       Expected ( u64)csum_result == ( u64)expected, but
>>           ( u64)csum_result == 46543 (0xb5cf)
>>           ( u64)expected == 46544 (0xb5d0)
>>       not ok 5 test_csum_ipv6_magic
>>
>> with the parisc64 tests. All other architectures / platforms work fine
>> after applying the various pending fixes. It looks like a carry gets
>> lost somewhere, but I have not been able to figure out where exactly
>> that happens. This only happens with the 64-bit hppa assembler code.
>>

It turns out that hppa64 triggers an unaligned instruction trap if an
access is unaligned (where unaligned means not aligned to 64 bit).
It appears that this trap either wrongly drops or adds a carry flag
under some circumstances, and that this is causing the problem to be seen.
I can confirm this with:

diff --git a/arch/parisc/include/asm/checksum.h b/arch/parisc/include/asm/checksum.h
index e619e67440db..9bddf3231a28 100644
--- a/arch/parisc/include/asm/checksum.h
+++ b/arch/parisc/include/asm/checksum.h
@@ -128,9 +128,9 @@ static __inline__ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,

  "      ldd,ma          8(%1), %4\n"    /* get 1st saddr word */
  "      ldd,ma          8(%2), %5\n"    /* get 1st daddr word */
-"      add             %4, %0, %0\n"
  "      ldd,ma          8(%1), %6\n"    /* 2nd saddr */
  "      ldd,ma          8(%2), %7\n"    /* 2nd daddr */
+"      add             %4, %0, %0\n"
  "      add,dc          %5, %0, %0\n"
  "      add,dc          %6, %0, %0\n"
  "      add,dc          %7, %0, %0\n"

or, simpler,

diff --git a/arch/parisc/include/asm/checksum.h b/arch/parisc/include/asm/checksum.h
index e619e67440db..7e2bb797dfe0 100644
--- a/arch/parisc/include/asm/checksum.h
+++ b/arch/parisc/include/asm/checksum.h
@@ -131,7 +131,7 @@ static __inline__ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
  "      add             %4, %0, %0\n"
  "      ldd,ma          8(%1), %6\n"    /* 2nd saddr */
  "      ldd,ma          8(%2), %7\n"    /* 2nd daddr */
-"      add,dc          %5, %0, %0\n"
+"      add             %5, %0, %0\n"
  "      add,dc          %6, %0, %0\n"
  "      add,dc          %7, %0, %0\n"
  "      add,dc          %3, %0, %0\n"  /* fold in proto+len | carry bit */

both of which make the problem disappear. Unless I am missing something, this
means that the unaligned access trap adds an additional carry flag.

Question now is if this is a bug in the qemu emulation or a bug in the unaligned
trap handler. FWIW, both changes above should be possible workarounds since the
first add operation should never overflow (it adds two 32 bit numbers into a 64
bit register). I'd rather fix the root cause, though.

Any thoughts ? I am adding the parisc maintainers and its e-mail list for
additional feedback.

Thanks,
Guenter


