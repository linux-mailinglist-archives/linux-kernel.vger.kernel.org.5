Return-Path: <linux-kernel+bounces-52994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57601849F42
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D4941F21579
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B42376E1;
	Mon,  5 Feb 2024 16:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1iHZOeh"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5345E33CDA;
	Mon,  5 Feb 2024 16:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707149168; cv=none; b=L/RxKitu8gIu7M/ZbI1aolK2M2TSV9X19WN82nTdMSmeC1wC4Wqzngp93LIaAT7JkN7cSe88KVpaKu6WXiOwu1GfI5W80G0q/+rYZNS8aC5Kk+92dIkxUx/swqHAsH+VdhT7JfFWsvUaJwup36N6qm7m68GSeyPLf8/bKBPkg0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707149168; c=relaxed/simple;
	bh=F5TdBqpfmRqtEIvYYBWWHquyP7yxsMy/qm/7PwSOixw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pHbnfBo8JFK/pwbuJQkEPgcyXVuSxEsjfw7eSrDoWLem1ReBvr+pzczc+dp8UAS21dzDsiL1kuDiQ1xnl1LLBzJBeBho7auOBAY2cNsEowkbXp6Q9J4a5DKiw/f7KN2fXQh/lXP7sMcjjSY43hRm2gWCP6wQn5nX+kAVy56GID4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1iHZOeh; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d9b2400910so6714415ad.0;
        Mon, 05 Feb 2024 08:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707149165; x=1707753965; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=+EeZAfwEPyGr3bPcxLVrnaOfNElu/B3c1f9i79s2kVI=;
        b=i1iHZOehLMz/h5kJppv3HX/ulZHbvJns8HJH+Ra9d3LXbhF4beLH2Dwc6xwZEM3DU/
         cj0UN6Fe4V6h5Ex63gxbQTmBJEwgEQD3i+Z5x1pNrgYHnfkGlPR0TedBUmMvG3G41yrw
         11xpqYEXavz5tGkpsSHl1Ukd7NO9LjPLQCbQ9Tx/TjU7m1Q5IyYkWZKAbYFWM6/36w9J
         j7/SiYDmYYYD8CldaBGwZ2zONJfDIz1VPEbBGR3hqK3UTysyggYcQazKxgESUpJNPWPB
         WREYe75wfRKQnFuqjun0VSXhOIQivuB2s3o3Ywpsy0J9piIaBWODIq/cUmUjXauBglhg
         Kf5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707149165; x=1707753965;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+EeZAfwEPyGr3bPcxLVrnaOfNElu/B3c1f9i79s2kVI=;
        b=wYDuGjA7CmWHA/akCOggx7jK/UdO3apbhpQAxan83vm5o/8WFU0K4ajian6lfLVwgh
         CnWEn/2UGzPMkcUNRfQbo9oYAE4pe6XrCSN0u6qd1rOrBmcvElQ2Jj5/Z5K+t43XVUAb
         aWmmAoHLff0SGggLdtU6aU2/slxiEyW0tHHJDkb3HWmwpKZKMLY75JkPyqx4X1kWOB38
         4bdXZShh30bbxChQ7M7O5Lfd1Qxxa9pXc0kKXyL6XbAtRoVG2G99mdpbhlCLXO12wJ53
         eN1mbowSgKlLZk9kaxeX5NL/EOvrYCgfZYcEiqMKHx3QnkDMHHvxt4J/y6XuNdJnBcgs
         t2hA==
X-Gm-Message-State: AOJu0Yw/Hkxk2ZAF1MdHRbqLfOSLE7cY20ftAHTrCVlY8e9Q36yWFyHz
	ZyrboRmT3JaBxboIhpfAyyJldAFaAGEg7cvw9MDZ77ksvgQPqfqEeHPqJTDj
X-Google-Smtp-Source: AGHT+IETXLcDJRAUe2shZb8ZtYFJuD3Oq0aklzw4ozcLCR+0pAh4CFB1L8vPhXEG0nYHAiIiKFKBZw==
X-Received: by 2002:a17:902:d902:b0:1d9:803a:8b0b with SMTP id c2-20020a170902d90200b001d9803a8b0bmr98496plz.33.1707149165428;
        Mon, 05 Feb 2024 08:06:05 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXSRz2GVa/571uh5IbM9khs7E3R9b0KYqyBoUMTCLuXJL0kQnioQZvm9oHiViJM7xVy6pdAdyOIRn1bvfKk/7ttyoaueKJUllGa9Jz29CR/E4H8jOS+AOYm158UdYaVLpdM22RFyQQh7bLafw/Vmjsyr6TiKnRnPT/i3KtwuKfOkJ6px7kfjFQcWQRQYGt9cw8sTsC9YN4VfLk6zuTQ9YsjwA304823Pkk9DcD30YsjM0tOBbC7aVHzDmmEN10=
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ki6-20020a170903068600b001d916995423sm39851plb.99.2024.02.05.08.06.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 08:06:05 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c1d89da0-f9ef-44d8-8731-5a34240eba95@roeck-us.net>
Date: Mon, 5 Feb 2024 08:06:03 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kunit test failures with cpumask tests on parisc
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, Yury Norov <yury.norov@gmail.com>
Cc: James.Bottomley@hansenpartnership.com, linux-parisc@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org
References: <e6f0ab85-5bbe-41c1-8976-5ba00044998c@roeck-us.net>
 <929506cf-a1a7-436e-938d-4e5eff0181e4@gmx.de>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <929506cf-a1a7-436e-938d-4e5eff0181e4@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/5/24 01:28, Helge Deller wrote:
> On 2/5/24 07:53, Guenter Roeck wrote:
>> when running cpumask Kunit tests on parisc/parisc64 in qemu,
>> I get the following errors.
>>
>>        KTAP version 1
>>        # Subtest: cpumask
>>        # module: cpumask_kunit
>>        1..6
>>        # test_cpumask_weight: EXPECTATION FAILED at lib/cpumask_kunit.c:68
>>        Expected nr_cpu_ids == cpumask_weight(((const struct cpumask *)&__cpu_possible_mask)), but
>>            nr_cpu_ids == 16 (0x10)
>>            cpumask_weight(((const struct cpumask *)&__cpu_possible_mask)) == 1 (0x1)
>>    cpu_possible_mask contains CPUs 0
>>        not ok 1 test_cpumask_weight
>>        # test_cpumask_first: EXPECTATION FAILED at lib/cpumask_kunit.c:79
>>        Expected nr_cpu_ids <= cpumask_first_zero(((const struct cpumask *)&__cpu_possible_mask)), but
>>            nr_cpu_ids == 16 (0x10)
>>            cpumask_first_zero(((const struct cpumask *)&__cpu_possible_mask)) == 1 (0x1)
>>    cpu_possible_mask contains CPUs 0
>>        not ok 2 test_cpumask_first
>>        # test_cpumask_last: EXPECTATION FAILED at lib/cpumask_kunit.c:87
>>        Expected nr_cpu_ids - 1 == cpumask_last(((const struct cpumask *)&__cpu_possible_mask)), but
>>            nr_cpu_ids - 1 == 15 (0xf)
>>            cpumask_last(((const struct cpumask *)&__cpu_possible_mask)) == 0 (0x0)
>>    cpu_possible_mask contains CPUs 0
>>        not ok 3 test_cpumask_last
>>        # test_cpumask_next: EXPECTATION FAILED at lib/cpumask_kunit.c:94
>>        Expected nr_cpu_ids <= cpumask_next_zero(-1, ((const struct cpumask *)&__cpu_possible_mask)), but
>>            nr_cpu_ids == 16 (0x10)
>>            cpumask_next_zero(-1, ((const struct cpumask *)&__cpu_possible_mask)) == 1 (0x1)
>>    cpu_possible_mask contains CPUs 0
>>        not ok 4 test_cpumask_next
>>        ok 5 test_cpumask_iterators
>>        ok 6 test_cpumask_iterators_builtin
>>    # cpumask: pass:2 fail:4 skip:0 total:6
>>    # Totals: pass:2 fail:4 skip:0 total:6
>>    not ok 5 cpumask
>>
>> It appears that parisc sets __cpu_possible_mask to the number of online CPUs,
>> which is limited in qemu and doesn't match CONFIG_NR_CPUS. Is this a problem
>> with the unit test or with the parisc architecture, or does the unit test
>> simply not apply for parisc ?
> 
> Thank you for finding and reporting this!
> It's a bug (or a misunderstanding) in the parisc kernel.
> Reverting commit 0921244f6f4f ("parisc: Only list existing CPUs in cpu_possible_mask")
> fixes the KUnit test.
> 
> Furthermore the revert fixes the issue that CPU hot-unplugging doesn't
> work and which I just was starting to debug:
> https://lore.kernel.org/lkml/Zb0mbHlIud_bqftx@slm.duckdns.org/t/
> 

Glad to help, and thanks for the update.

Guenter


