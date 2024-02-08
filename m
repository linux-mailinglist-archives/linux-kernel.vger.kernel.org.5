Return-Path: <linux-kernel+bounces-57399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C46C784D7F3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 03:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53CE7286A4B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 02:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628151D52C;
	Thu,  8 Feb 2024 02:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCV4bx4w"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6791D526
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 02:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707360287; cv=none; b=Pqz1DzWYoLbNDxRk4y7C8bMZM21LQBA8+NhExaCYmacBKQdrTgCthRrxSEWsdgPZY1kBKthpwOxqyGEdHOa37z7VcUfHmDpDQuHmSzeYBKUqk5x7i3cG5RGoy/H64LxlaqJMq4l0N1XlmNOa97gPc8sQ98jsspEzmrtxDjNXsxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707360287; c=relaxed/simple;
	bh=gWRJfyvnfr8IuOi42mEJJAKeyuzjF1PjOjUnUZDHGGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KL90NYILWYUGKjd6qqfcsR6fIsqJSzQxOdV9yQ7r37K2glLdu2l8of67efbD+MnMbfeBwo2UIpZJnhUBJjrQLlbYdE5GKqhSLbeAuqMXB5tL5lLbJHLPhpEhxXNsGeFhDCqH5Dk7HCh0M24SFrhcz+UJ1G9HwUw44Oh/MSyDcy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCV4bx4w; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3bda4bd14e2so1179011b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 18:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707360285; x=1707965085; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=8xuQjRjBuhA5J7Jebq3jrSWdK7UbrSGGBIMtsR4rn7M=;
        b=TCV4bx4wJfzFCsevWvU1eXsi3hxm74TEmJEA7vwR0Y2Vy8Z6RfHxCiPv0bdDWCHrFK
         ZiwuTLdUYDtcFKGknBqd86AZjXtGwRhAeXy8IgqQ0+ro5yfW4SeHAMI6EXw9ExmWNdeg
         yGWohpxZSjqxwUbTELC81yJB7tuaT6L/19yxUOmf28g2yGoKsV4olszKaWFulRGlr/QT
         9paWLurrDwYqIY9ymY1ABxEHEF6SPMcjiEm5AOeLqFVAhtkKsb5VTgLxZ6yavOv9fTrN
         5mp3rrR9xRrbwKfkx/UpkIFlpkFCthNxGSmCpo/fH91I//6IvigRc8pba2lEEsZZTLRS
         JQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707360285; x=1707965085;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8xuQjRjBuhA5J7Jebq3jrSWdK7UbrSGGBIMtsR4rn7M=;
        b=hYy1ORgieqi/DU0sGMkpjoO0xxfS8vsFIYXWzx2nEihVLsYzqPqG7+6JRKqPVPNI96
         P7jicrOCwz69fUv3Hmcz9P+ghWsCJmczFp6ZpV1wSirEyl6q30armFLr4xgWd7aWkUPa
         knXkxn8UuT5Y0JZWVi7veu8UPMAKJd59ApvCALyGm7dI97SrLSeEo/tAptb8B/ySnElK
         qq79LlltE+dI9jxFAYKHGNtuKcTnCqOnGiHEOezD53ySX9HnKdTPTfdBX7AZlqUu3F6N
         l2dEh5O23YU/IIeXcT3xvp39Vq7Ibc5eO/+sYBqrD132f5WCNpWnFECEUX2XgGMzsYQK
         0GXA==
X-Forwarded-Encrypted: i=1; AJvYcCWPyaM5lhJj6Jvp8BBT6l47TmpUXvlpUfL7Eblyrl+KeOH05kE2vlw9XQ0fiUU75T+IS5esebOLvEY6juCcG6PcRbNm+M/JU7pXKtQw
X-Gm-Message-State: AOJu0YwQwIfM091LPMDLW6uFuhevS9NWZNry1SagC0RO5IIOSqnSN4rn
	SH2OGs+jTzHJoUpy5GXGNkifU1WdeKdJB9jGUxXxmgl/bb4oDV11fd5rAoio
X-Google-Smtp-Source: AGHT+IFqiMcvU19026JiqLA/TeFHyiebdsIX48amjqdAovfc+Ex760vrirXXv7FQctq/FhJnNidRVg==
X-Received: by 2002:a05:6808:10d3:b0:3bd:9e75:15cf with SMTP id s19-20020a05680810d300b003bd9e7515cfmr8454667ois.53.1707360284920;
        Wed, 07 Feb 2024 18:44:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWBUkFRCSLmqWplXGbu37CR8AiaoRem3/1JQMX8l6LB+Rxs4AiGbb6L3rwIkNHygNtF+Ke25U3Kze7n1X0FMtne5VQPom1UmW5rfrAHO+0UFnAgjuV3IcGcfVIUpUCXmWGJSN9qoki5h3jo9vtEqekIIvlIW/Jbik6hsCwAoYqCG7Xp35iVnMYUtx8=
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m24-20020a638c18000000b005dc36417f35sm2171794pgd.34.2024.02.07.18.44.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 18:44:44 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <622b1790-8abb-463c-b6f6-9fb8b4a739cc@roeck-us.net>
Date: Wed, 7 Feb 2024 18:44:42 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/2] lib: checksum: Fix issues with checksum tests
Content-Language: en-US
To: Charlie Jenkins <charlie@rivosinc.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: David Laight <David.Laight@aculab.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-kernel@vger.kernel.org,
 kernel test robot <lkp@intel.com>
References: <20240207-fix_sparse_errors_checksum_tests-v6-0-4caa9629705b@rivosinc.com>
 <20240207174522.2d19729ec2e014d521335a04@linux-foundation.org>
 <ZcQ38U20MLSdIxHP@ghost>
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
In-Reply-To: <ZcQ38U20MLSdIxHP@ghost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/7/24 18:09, Charlie Jenkins wrote:
> On Wed, Feb 07, 2024 at 05:45:22PM -0800, Andrew Morton wrote:
>> On Wed, 07 Feb 2024 16:22:49 -0800 Charlie Jenkins <charlie@rivosinc.com> wrote:
>>
>>> The ip_fast_csum and csum_ipv6_magic tests did not have the data
>>> types properly casted, and improperly misaligned data.
>>
>> Neither this nor the two patch's changelogs describe *why* these changes
>> are needed.  They merely assert that we need to do this.
>>
>> IOW, when fixing a bug please always describe the user-visible effects
>> of that bug.
>>
> 
> I can add a description that says that the tests are being fixed because
> they caused failures on systems without misaligned access support. As
> for the casting patch it's a bit less pertinent but I can add that it
> allows the code to pass sparse checks.
> 
> - Charlie
> 
I don't know exactly what Andrew is asking for, but maybe including the
error log from the failed selftests and/or the sparse errors would be
sufficient ?

Not sure though if any of those count as "user visible".

Guenter




