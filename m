Return-Path: <linux-kernel+bounces-167812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B62038BAF6F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66D622811E0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05B548CCC;
	Fri,  3 May 2024 15:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9rul5yW"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A0657C84
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 15:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714749076; cv=none; b=DUqCvaUQgRBqOB6rNTNVSltHY2an7bqOg+uVgNJndwqxhnZ/h1Wiy0H/O2Bbs8id0uNjewQs35Q9iO0aL6jG/qbP2DNIJbu9h8vKIwg79DXv8eQS7ZqMH+/B53ge+WKhOzSAcCpj/t4uhuaKWhLuAiY7qtOYwF4v6RPEQrQWleM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714749076; c=relaxed/simple;
	bh=/w1Umk7QuTBhZjIKkypg3REtOA/TplSZsFezyaIa5JQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ARGwzPjj5WGH5UqHNWvnrOjMd0vS7/ny7uQQ35SgiDLyBO9l9ms1l/P+t+QxG6yCL9QElWOyW/xggVmZos+jKGFbXPhdknwTRysQ60y55FLDjCau1fA5cMrl2LONjIWxLWcko+CoAOGlUzhn7MAOocjalNmMEGTAy0UfQQv38es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9rul5yW; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41b79451153so57601985e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 08:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714749073; x=1715353873; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u+3HzXMAKOQPznx02Kq/PyKDV/8AD6lCk3ecRCC6kGo=;
        b=R9rul5yWyNeixFJF4XrjrK1GW5Msmt1mI7ht/zKLdvezYrYyiKqdd+JasMnIUhccEP
         Exc62PaIc04jWUw99pYYV4j34BvryZANnnqJQKPidiDx1NZ2bY79Zv2MRe/+Xnw7AgVm
         G4OG4QcixL4uTFkVYqXP1L/c08gA4+iXUWl73OeMSfBUokS+UMaNwrPrGq/jIsJjb85u
         2ptXL7cnnCyNnr3j2083nnIZ4w3Km0scCAKUfwWbcuS/y6/6GAKkyyRO2LQXXkGxCV6V
         Q1WN+MaB1W500xrEncrqb+Unq6Jjh7QfehtSjfLpVBuYjAkFnr2Hb4kRlwQS8XYVg749
         FhKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714749073; x=1715353873;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u+3HzXMAKOQPznx02Kq/PyKDV/8AD6lCk3ecRCC6kGo=;
        b=iFiOntAyWWddsGIS3/xmAfdzNVGfSFI4YiP+Tu4JF4EhC4LqZ8Te+zHIR6vUetwaof
         3mcilIPoqEuHzDNg8dd3cJjS9Oaknvg5ZdqXVhjZxps72gqToNFu+7hGWdYU/R2t0Hbs
         HruoTWuAt9jkqhJgNiB4WTvq8NDXi9HHiM1Y7UrJR35m/BWEQMqVrdrdLxKfzLnWXTsj
         x6o7jlRmAS6gY9aSlfff32N7rXNTGqKupFYa1aRax3fCIucTmDBkIUOciSuw+gjN/Zhb
         EEaHXMfH5cFruh9hgMaW8ZVXADMyRW3NB7hHViLYoMShDDoozLAyjeMkfSmHjn2lZjoV
         46vQ==
X-Forwarded-Encrypted: i=1; AJvYcCXb5lgy5XtSc7vICHhpsc5Jt0XHRgXGihyFCbfv0+Tp6cQzmMzfik12N+sgJ380dasPDMgz4L5NE4U3xX0tZZuy8+xHjF8nBtD1ynmP
X-Gm-Message-State: AOJu0YwwwtKcACLCy/J60FVZb1zFGq4QAFEpnZ3VvkVuvpSgU47M1AyU
	MbSqVoGB9K2m6pVsAQcoTaaE/Nm71RaAU1GRiyQ1m5+Bw13RIL3Y
X-Google-Smtp-Source: AGHT+IFR6bDoRgVKy5/VkEevpa6wJTuILz8VoTMyMcw1BZebqA4gt/GfjtqFf34tA3O4v2QErQ/ADw==
X-Received: by 2002:a05:600c:4706:b0:41a:b56c:2929 with SMTP id v6-20020a05600c470600b0041ab56c2929mr2469373wmo.34.1714749072502;
        Fri, 03 May 2024 08:11:12 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:b211:ad00:1490:6cc2:4d06:940f? ([2a01:4b00:b211:ad00:1490:6cc2:4d06:940f])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c220a00b0041bef325c4esm12059011wml.1.2024.05.03.08.11.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 08:11:12 -0700 (PDT)
Message-ID: <e348afde-392b-474b-8e1a-f6ae9fb004cf@gmail.com>
Date: Fri, 3 May 2024 16:11:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: cgroup: add tests to verify the zswap
 writeback path
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, yosryahmed@google.com,
 chengming.zhou@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com
References: <20240501100446.1454264-1-usamaarif642@gmail.com>
 <CAKEwX=NKMOJQ2KuiBcs-62NzqAhRDOvEhWvAzjsAbUtg=65fvA@mail.gmail.com>
 <cc634240-bfa0-43c5-b34a-257411d0e6a1@gmail.com>
 <CAKEwX=P3CzkrkB8iQ5-BvgaFko03hUULtz=8z-qe_d3LZ7Ge2Q@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAKEwX=P3CzkrkB8iQ5-BvgaFko03hUULtz=8z-qe_d3LZ7Ge2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 03/05/2024 00:30, Nhat Pham wrote:
> On Thu, May 2, 2024 at 12:05 PM Usama Arif <usamaarif642@gmail.com> wrote:
>>
>> On 01/05/2024 16:44, Nhat Pham wrote:
>>> On Wed, May 1, 2024 at 3:04 AM Usama Arif <usamaarif642@gmail.com> wrote:
>>>> The condition for writeback can be triggered by allocating random
>>>> memory more than memory.high to push memory into zswap, more than
>>>> zswap.max to trigger writeback if enabled, but less than memory.max
>>>> so that OOM is not triggered. Both values of memory.zswap.writeback
>>>> are tested.
>>> Thanks for adding the test, Usama :) A couple of suggestions below.
>>>
>>>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>>>> ---
>>>>    tools/testing/selftests/cgroup/test_zswap.c | 83 +++++++++++++++++++++
>>>>    1 file changed, 83 insertions(+)
>>>>
>>>> diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/selftests/cgroup/test_zswap.c
>>>> index f0e488ed90d8..fe0e7221525c 100644
>>>> --- a/tools/testing/selftests/cgroup/test_zswap.c
>>>> +++ b/tools/testing/selftests/cgroup/test_zswap.c
>>>> @@ -94,6 +94,19 @@ static int allocate_bytes(const char *cgroup, void *arg)
>>>>           return 0;
>>>>    }
>>>>
>>>> +static int allocate_random_bytes(const char *cgroup, void *arg)
>>>> +{
>>>> +       size_t size = (size_t)arg;
>>>> +       char *mem = (char *)malloc(size);
>>>> +
>>>> +       if (!mem)
>>>> +               return -1;
>>>> +       for (int i = 0; i < size; i++)
>>>> +               mem[i] = rand() % 128;
>>>> +       free(mem);
>>>> +       return 0;
>>>> +}
>>>> +
>>>>    static char *setup_test_group_1M(const char *root, const char *name)
>>>>    {
>>>>           char *group_name = cg_name(root, name);
>>>> @@ -248,6 +261,74 @@ static int test_zswapin(const char *root)
>>>>           return ret;
>>>>    }
>>>>
>>>> +/* Test to verify the zswap writeback path */
>>>> +static int test_zswap_writeback(const char *root, bool wb)
>>>> +{
>>>> +       int ret = KSFT_FAIL;
>>>> +       char *test_group;
>>>> +       long zswpwb_before, zswpwb_after;
>>>> +
>>>> +       test_group = cg_name(root,
>>>> +               wb ? "zswap_writeback_enabled_test" : "zswap_writeback_disabled_test");
>>>> +       if (!test_group)
>>>> +               goto out;
>>>> +       if (cg_create(test_group))
>>>> +               goto out;
>>>> +       if (cg_write(test_group, "memory.max", "8M"))
>>>> +               goto out;
>>>> +       if (cg_write(test_group, "memory.high", "2M"))
>>>> +               goto out;
>>>> +       if (cg_write(test_group, "memory.zswap.max", "2M"))
>>>> +               goto out;
>>>> +       if (cg_write(test_group, "memory.zswap.writeback", wb ? "1" : "0"))
>>>> +               goto out;
>>>> +
>>>> +       zswpwb_before = cg_read_key_long(test_group, "memory.stat", "zswpwb ");
>>>> +       if (zswpwb_before < 0) {
>>>> +               ksft_print_msg("failed to get zswpwb_before\n");
>>>> +               goto out;
>>>> +       }
>>>> +
>>>> +       /*
>>>> +        * Allocate more than memory.high to push memory into zswap,
>>>> +        * more than zswap.max to trigger writeback if enabled,
>>>> +        * but less than memory.max so that OOM is not triggered
>>>> +        */
>>>> +       if (cg_run(test_group, allocate_random_bytes, (void *)MB(3)))
>>>> +               goto out;
>>> I think we should document better why we allocate random bytes (rather
>>> than just using the existing allocation helper).
>>>
>>> This random allocation pattern (rand() % 128) is probably still
>>> compressible by zswap, albeit poorly. I assume this is so that zswap
>>> would not be able to just absorb all the swapped out pages?
>> Thanks for the review! I have added doc in v2 explaining why random
>> memory is used.
>>
>>
>>>> +
>>>> +       /* Verify that zswap writeback occurred only if writeback was enabled */
>>>> +       zswpwb_after = cg_read_key_long(test_group, "memory.stat", "zswpwb ");
>>>> +       if (wb) {
>>>> +               if (zswpwb_after <= zswpwb_before) {
>>>> +                       ksft_print_msg("writeback enabled and zswpwb_after <= zswpwb_before\n");
>>>> +                       goto out;
>>>> +               }
>>>> +       } else {
>>>> +               if (zswpwb_after != zswpwb_before) {
>>>> +                       ksft_print_msg("writeback disabled and zswpwb_after != zswpwb_before\n");
>>>> +                       goto out;
>>>> +               }
>>> It'd be nice if we can check that in this case, the number of pages
>>> that are "swapped out" matches the cgroup's zswpout stats :)
>> I think with the method in v2, this might not be easily tracked as some
>> metrics are all time (zswpout) while others are current.
> Hmm would pgsteal be a good candidate for this purpose?
> Just throwing out ideas - I'll leave this up to you to decide :)

So I think what the equation would be is pgsteal = zswpout + number of 
pages that couldnt be compressed and directly moved to swap? We have 
pgsteal and zswpout, but I cant see from existing metrics if we can get 
the 3rd thing.

As a reference these are some of the metrics at the end of writeback 
enabled test from v2:

zswpin 1024
zswpout 1801
zswpwb 297

pgsteal 2057

zswap 0
zswapped 0

We need a metric that is 2057-1801 = 256, but can't find any :)




