Return-Path: <linux-kernel+bounces-166854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B42D58BA0E1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A4CB288B40
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AA617334F;
	Thu,  2 May 2024 19:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foZRubj5"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E28269D2F
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 19:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714676740; cv=none; b=V8InWdfQkpoWMIz7lGcptpyT0MkYJheEq4jiJRqh+w6EgYB7990agFkQ0JZ4wkGRDPLIQY7WxJ9CIZLrw6pZWHs/EVE8FnEWTU5KLN1PwIkXXUTxUGyA87wTh+hDjsm+W1oABQX7UQMqMhpBW4I8BTiGgdrlDIxFoKuWaG7AeUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714676740; c=relaxed/simple;
	bh=Kl79noMAqZjLz9FZWeAiw/63301oeJM3RDaOYuvzCIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ozQxBkx5BElN0p9/ylkjSocOUEIcKJqfJjSiB37D3km0i1zldlGBcq53W4xvDtgNGVvfOt2oLVSF411KIiyCZ6EFYbnfV33eJV4DkjvT/3IEF1w5irkm9zD99xCA+43phnBmuVZL/UhYBWASqN+mg8LEyekUkn6imnIHE/2ZYeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=foZRubj5; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41adf3580dbso13344085e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 12:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714676737; x=1715281537; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pQezgGHBde2PG49TFvcPtewcmftD8mjUw8NBpGR0NeI=;
        b=foZRubj5hQjlm+lkJQoxhALNvcvg2x5Y1hBsXyJ/GX071MuCc+p7X12N0p/f4VXhqX
         fmVYf4UK4ZxgA7N/IowA0CDn/8KJ29t22rkWthD275mr8j7myMJxX9NmB4rlC6nBybmA
         6n7UhT5iQoNzyacsMBURpl+9nWD21pGKg+pkumly4+sCzsO9MA0J7GrfCoWhqzeKGpmm
         BUjuPvVlU7zJb/W7CNBMyfL0oRHX7P9DEvElQ9eXn7hkmJTvNXYiRA+bDomQXT+UbD6Y
         E8RAKd7lzaiSzn348a26mWg1mDJIDq0juCq3As71aQHgC0SvsCxU14rjWKbfmKqpvl5Y
         3Avw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714676737; x=1715281537;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pQezgGHBde2PG49TFvcPtewcmftD8mjUw8NBpGR0NeI=;
        b=njxrIQD8IvySjo5ytZT0b/cNyvyysDI1ZIpgpeLr3QBfO+o7yjvQ9spgvllgGdpLbF
         VPZ3LII9lrg4loM4eVMgDgBnBe9/jVyoKkRqPqh+S3CZcHiDSrcc8bqb2iaEbr3DPcfq
         BeYnmSQfwAqibmG0JpI0ExyLc5jg0gcysHe6WDYG4sYpwqQIgPNBKSt6MF8k1Vv6MdcE
         kfKqMiOS9b5g3PImHGp9v2SNJ0ijdLE3lCpH0JU2oKAqtTgCguTvYCBbf4h8wrR7ifeb
         0xjkVInJXv4ARKmnhSp29RQL9+ZbrDYyAiHJR+9vepzFLzywS/sJYJKvWfqjgoThhhqR
         qEdA==
X-Forwarded-Encrypted: i=1; AJvYcCWBKWPsIJRdvZcfWjd0JKbG2jxdBEEC0BWfA9cY2tGK5DCn8GLKi1ZHhZrTluna0RK8uJPMIXtL+d0jtUAvS56L2fch4f+bJfJ7PVyb
X-Gm-Message-State: AOJu0YwKHtpkmhGQc0qkiFzIb/70qWOeJVcLUnOPn0Pa7oIio/43/EjY
	F76IfbzeRVgW55kQZgykePSKlB24vv/3h0iXy4o8I2B8TO8CBOaz7zN1J6v+DZivJw==
X-Google-Smtp-Source: AGHT+IEsQU3BbzqxIp0ovOKArFrLjb73eFpuZj5WOoSUSr4aylhyZQyO2pxQLtfGhxT96VWhIZ20nA==
X-Received: by 2002:a05:600c:3103:b0:41b:f24a:b590 with SMTP id g3-20020a05600c310300b0041bf24ab590mr3403357wmo.3.1714676737014;
        Thu, 02 May 2024 12:05:37 -0700 (PDT)
Received: from ?IPV6:2a02:6b6a:b75d:0:64:3301:4710:ec21? ([2a02:6b6a:b75d:0:64:3301:4710:ec21])
        by smtp.gmail.com with ESMTPSA id ka21-20020a05600c585500b0041a9c3444a6sm6529636wmb.28.2024.05.02.12.05.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 12:05:36 -0700 (PDT)
Message-ID: <cc634240-bfa0-43c5-b34a-257411d0e6a1@gmail.com>
Date: Thu, 2 May 2024 20:05:36 +0100
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
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAKEwX=NKMOJQ2KuiBcs-62NzqAhRDOvEhWvAzjsAbUtg=65fvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 01/05/2024 16:44, Nhat Pham wrote:
> On Wed, May 1, 2024 at 3:04 AM Usama Arif <usamaarif642@gmail.com> wrote:
>> The condition for writeback can be triggered by allocating random
>> memory more than memory.high to push memory into zswap, more than
>> zswap.max to trigger writeback if enabled, but less than memory.max
>> so that OOM is not triggered. Both values of memory.zswap.writeback
>> are tested.
> Thanks for adding the test, Usama :) A couple of suggestions below.
>
>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>> ---
>>   tools/testing/selftests/cgroup/test_zswap.c | 83 +++++++++++++++++++++
>>   1 file changed, 83 insertions(+)
>>
>> diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/selftests/cgroup/test_zswap.c
>> index f0e488ed90d8..fe0e7221525c 100644
>> --- a/tools/testing/selftests/cgroup/test_zswap.c
>> +++ b/tools/testing/selftests/cgroup/test_zswap.c
>> @@ -94,6 +94,19 @@ static int allocate_bytes(const char *cgroup, void *arg)
>>          return 0;
>>   }
>>
>> +static int allocate_random_bytes(const char *cgroup, void *arg)
>> +{
>> +       size_t size = (size_t)arg;
>> +       char *mem = (char *)malloc(size);
>> +
>> +       if (!mem)
>> +               return -1;
>> +       for (int i = 0; i < size; i++)
>> +               mem[i] = rand() % 128;
>> +       free(mem);
>> +       return 0;
>> +}
>> +
>>   static char *setup_test_group_1M(const char *root, const char *name)
>>   {
>>          char *group_name = cg_name(root, name);
>> @@ -248,6 +261,74 @@ static int test_zswapin(const char *root)
>>          return ret;
>>   }
>>
>> +/* Test to verify the zswap writeback path */
>> +static int test_zswap_writeback(const char *root, bool wb)
>> +{
>> +       int ret = KSFT_FAIL;
>> +       char *test_group;
>> +       long zswpwb_before, zswpwb_after;
>> +
>> +       test_group = cg_name(root,
>> +               wb ? "zswap_writeback_enabled_test" : "zswap_writeback_disabled_test");
>> +       if (!test_group)
>> +               goto out;
>> +       if (cg_create(test_group))
>> +               goto out;
>> +       if (cg_write(test_group, "memory.max", "8M"))
>> +               goto out;
>> +       if (cg_write(test_group, "memory.high", "2M"))
>> +               goto out;
>> +       if (cg_write(test_group, "memory.zswap.max", "2M"))
>> +               goto out;
>> +       if (cg_write(test_group, "memory.zswap.writeback", wb ? "1" : "0"))
>> +               goto out;
>> +
>> +       zswpwb_before = cg_read_key_long(test_group, "memory.stat", "zswpwb ");
>> +       if (zswpwb_before < 0) {
>> +               ksft_print_msg("failed to get zswpwb_before\n");
>> +               goto out;
>> +       }
>> +
>> +       /*
>> +        * Allocate more than memory.high to push memory into zswap,
>> +        * more than zswap.max to trigger writeback if enabled,
>> +        * but less than memory.max so that OOM is not triggered
>> +        */
>> +       if (cg_run(test_group, allocate_random_bytes, (void *)MB(3)))
>> +               goto out;
> I think we should document better why we allocate random bytes (rather
> than just using the existing allocation helper).
>
> This random allocation pattern (rand() % 128) is probably still
> compressible by zswap, albeit poorly. I assume this is so that zswap
> would not be able to just absorb all the swapped out pages?

Thanks for the review! I have added doc in v2 explaining why random 
memory is used.


>> +
>> +       /* Verify that zswap writeback occurred only if writeback was enabled */
>> +       zswpwb_after = cg_read_key_long(test_group, "memory.stat", "zswpwb ");
>> +       if (wb) {
>> +               if (zswpwb_after <= zswpwb_before) {
>> +                       ksft_print_msg("writeback enabled and zswpwb_after <= zswpwb_before\n");
>> +                       goto out;
>> +               }
>> +       } else {
>> +               if (zswpwb_after != zswpwb_before) {
>> +                       ksft_print_msg("writeback disabled and zswpwb_after != zswpwb_before\n");
>> +                       goto out;
>> +               }
> It'd be nice if we can check that in this case, the number of pages
> that are "swapped out" matches the cgroup's zswpout stats :)

I think with the method in v2, this might not be easily tracked as some 
metrics are all time (zswpout) while others are current.

>
>> +       }
>> +
>> +       ret = KSFT_PASS;
>> +
>> +out:
>> +       cg_destroy(test_group);
>> +       free(test_group);
>> +       return ret;
>> +}
>> +
>> +static int test_zswap_writeback_enabled(const char *root)
>> +{
>> +       return test_zswap_writeback(root, true);
>> +}
>> +
>> +static int test_zswap_writeback_disabled(const char *root)
>> +{
>> +       return test_zswap_writeback(root, false);
>> +}
>> +
>>   /*
>>    * When trying to store a memcg page in zswap, if the memcg hits its memory
>>    * limit in zswap, writeback should affect only the zswapped pages of that
>> @@ -425,6 +506,8 @@ struct zswap_test {
>>          T(test_zswap_usage),
>>          T(test_swapin_nozswap),
>>          T(test_zswapin),
>> +       T(test_zswap_writeback_enabled),
>> +       T(test_zswap_writeback_disabled),
>>          T(test_no_kmem_bypass),
>>          T(test_no_invasive_cgroup_shrink),
>>   };
>> --
>> 2.43.0
>>

