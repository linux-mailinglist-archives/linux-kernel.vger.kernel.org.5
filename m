Return-Path: <linux-kernel+bounces-165239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DC48B89F9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3F9E1C21530
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAD584E15;
	Wed,  1 May 2024 12:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhbShkT1"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29861824A3
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 12:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714566545; cv=none; b=QAXVm1kI4n/cteJCss9ufPqVV/yp+W7d9DHkS+orf+PKuwiHoZWpTmJGofiPYig1c+8fiGqicJZ7EqlviO9QcWOdJUdQWMsjMxvMVYcpkNfWkvYMHjCeYUvWYMlR/MNb49izu5OSf1hKqSVrwl50T3zwhVwdNb5QVdACxUbC/Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714566545; c=relaxed/simple;
	bh=8GbieHlYsAwn+9UzwNuT7AWB1YzIw3xmRM9ekc5TfPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LxWUxQEyh1WD1Zp11s4QnxXFdLNnBqVd5CYp6bR/WRk9KiCu666XYxEVnFKB/lF+CvrSxZj7x6FaLQLW7UyBLCnuokig0Qnp59/xDFt02CQDBLHPJ9GWGsx8y8KRPChh0XmmViIYIyEjyLS0NsH2Udjs2Jl0VBbhvg6tW7IYuVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VhbShkT1; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a556d22fa93so737423266b.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 05:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714566542; x=1715171342; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=41aaC9phhdSl5EUFnErBqiAfHUdpr+Xaat+EsN6yMpc=;
        b=VhbShkT1mT/L/bFXa4Fu9u8CqVv2pcmOnkvijwT9RyeGA4Oud5boY4QgSqabrk0urT
         YjQtC/kzgPJ6I48W5kCvm6IKwAADwYcDurH00mYoffP5BTzfFOjzG6NcnjC+C65kLahY
         MKSU6TOltbudR+OcpSneLmqcNRMdhIu78/gLW28Ti40bVaZ0gbKohLxNhG/u6A3lTaDQ
         0jZauaRNqOjaQgj5jesxvB4CzDvneKDIe5a02/rfI1MsC7hCw/xtmCg95BiQBAyAipi3
         fZj5K7vhKVkykSmPLDa+MqHhZdnnrPTqnlltoGoEYdkQob9X8EEggDrinnV1zz7xQhzr
         3C7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714566542; x=1715171342;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=41aaC9phhdSl5EUFnErBqiAfHUdpr+Xaat+EsN6yMpc=;
        b=e0pj7S/Nw7btccR663RA9VByk1VOHuX3YQISNmbk4jM54PXIAauhaYWefZfbObo7el
         EN1y41K/ZhTsWUfzN4P08H/3iZRFKamv6RxVXHIz56oZwjc7hPyqMuaX632AazCpkA28
         mLBSebHk8VKmEwnODR1MaQyiIp+AR1JDuOEutN69ldLSAa0rXKe0CudnTKmM2UNhObNq
         bcG7WwhrqlCQOHT3RF8q2/fhbZvC00wROl/3FTqwp8yxf4OLBtM93GBH8HDq0klmRFy7
         dm50tctS1xQ9bPnSWHIjEh3n2HZbFjQZrXg3vXs/IMEYfF8KCak78CfIOwCfyf9z2akr
         bzyA==
X-Forwarded-Encrypted: i=1; AJvYcCU1pOKxJVbhjVNvgLLWcRU1zaodB7hbIrODahTZzFXCtmoXQjGSh+AA4+B3JY7x8YrnSZUZRSm65EkNSFKUc5p12alqIXLGyL61ljZG
X-Gm-Message-State: AOJu0YxiQXKjGReDEd3y/WUxZfoL/4nbnjLJBuTJjqzfEudOZukQ3rDa
	IsX1tH2hYb83dxCFdbPKGS4gvRu8e0EXAFJaBoOm2bAVGH2foR9Z
X-Google-Smtp-Source: AGHT+IHJynM1WpKiteasQwNmtpBx2dJbZ0nmL+jqu8Z9KLhIcffVhdPBAjbMeeU61HtazScfwmirJg==
X-Received: by 2002:a17:906:90c:b0:a58:bcdc:cf40 with SMTP id i12-20020a170906090c00b00a58bcdccf40mr1513488ejd.77.1714566542219;
        Wed, 01 May 2024 05:29:02 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c093:500::5:e805])
        by smtp.gmail.com with ESMTPSA id i8-20020a170906264800b00a52433f0907sm16296331ejc.37.2024.05.01.05.29.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 05:29:01 -0700 (PDT)
Message-ID: <befff094-eb1a-4160-907f-f12e3c923d34@gmail.com>
Date: Wed, 1 May 2024 13:29:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: cgroup: add tests to verify the zswap
 writeback path
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org, yosryahmed@google.com, nphamcs@gmail.com,
 chengming.zhou@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com
References: <20240501100446.1454264-1-usamaarif642@gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20240501100446.1454264-1-usamaarif642@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 01/05/2024 11:04, Usama Arif wrote:
> The condition for writeback can be triggered by allocating random
> memory more than memory.high to push memory into zswap, more than
> zswap.max to trigger writeback if enabled, but less than memory.max
> so that OOM is not triggered. Both values of memory.zswap.writeback
> are tested.
>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>


Forgot to add:

Suggested-by: Nhat Pham <nphamcs@gmail.com>


> ---
>   tools/testing/selftests/cgroup/test_zswap.c | 83 +++++++++++++++++++++
>   1 file changed, 83 insertions(+)
>
> diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/selftests/cgroup/test_zswap.c
> index f0e488ed90d8..fe0e7221525c 100644
> --- a/tools/testing/selftests/cgroup/test_zswap.c
> +++ b/tools/testing/selftests/cgroup/test_zswap.c
> @@ -94,6 +94,19 @@ static int allocate_bytes(const char *cgroup, void *arg)
>   	return 0;
>   }
>   
> +static int allocate_random_bytes(const char *cgroup, void *arg)
> +{
> +	size_t size = (size_t)arg;
> +	char *mem = (char *)malloc(size);
> +
> +	if (!mem)
> +		return -1;
> +	for (int i = 0; i < size; i++)
> +		mem[i] = rand() % 128;
> +	free(mem);
> +	return 0;
> +}
> +
>   static char *setup_test_group_1M(const char *root, const char *name)
>   {
>   	char *group_name = cg_name(root, name);
> @@ -248,6 +261,74 @@ static int test_zswapin(const char *root)
>   	return ret;
>   }
>   
> +/* Test to verify the zswap writeback path */
> +static int test_zswap_writeback(const char *root, bool wb)
> +{
> +	int ret = KSFT_FAIL;
> +	char *test_group;
> +	long zswpwb_before, zswpwb_after;
> +
> +	test_group = cg_name(root,
> +		wb ? "zswap_writeback_enabled_test" : "zswap_writeback_disabled_test");
> +	if (!test_group)
> +		goto out;
> +	if (cg_create(test_group))
> +		goto out;
> +	if (cg_write(test_group, "memory.max", "8M"))
> +		goto out;
> +	if (cg_write(test_group, "memory.high", "2M"))
> +		goto out;
> +	if (cg_write(test_group, "memory.zswap.max", "2M"))
> +		goto out;
> +	if (cg_write(test_group, "memory.zswap.writeback", wb ? "1" : "0"))
> +		goto out;
> +
> +	zswpwb_before = cg_read_key_long(test_group, "memory.stat", "zswpwb ");
> +	if (zswpwb_before < 0) {
> +		ksft_print_msg("failed to get zswpwb_before\n");
> +		goto out;
> +	}
> +
> +	/*
> +	 * Allocate more than memory.high to push memory into zswap,
> +	 * more than zswap.max to trigger writeback if enabled,
> +	 * but less than memory.max so that OOM is not triggered
> +	 */
> +	if (cg_run(test_group, allocate_random_bytes, (void *)MB(3)))
> +		goto out;
> +
> +	/* Verify that zswap writeback occurred only if writeback was enabled */
> +	zswpwb_after = cg_read_key_long(test_group, "memory.stat", "zswpwb ");
> +	if (wb) {
> +		if (zswpwb_after <= zswpwb_before) {
> +			ksft_print_msg("writeback enabled and zswpwb_after <= zswpwb_before\n");
> +			goto out;
> +		}
> +	} else {
> +		if (zswpwb_after != zswpwb_before) {
> +			ksft_print_msg("writeback disabled and zswpwb_after != zswpwb_before\n");
> +			goto out;
> +		}
> +	}
> +
> +	ret = KSFT_PASS;
> +
> +out:
> +	cg_destroy(test_group);
> +	free(test_group);
> +	return ret;
> +}
> +
> +static int test_zswap_writeback_enabled(const char *root)
> +{
> +	return test_zswap_writeback(root, true);
> +}
> +
> +static int test_zswap_writeback_disabled(const char *root)
> +{
> +	return test_zswap_writeback(root, false);
> +}
> +
>   /*
>    * When trying to store a memcg page in zswap, if the memcg hits its memory
>    * limit in zswap, writeback should affect only the zswapped pages of that
> @@ -425,6 +506,8 @@ struct zswap_test {
>   	T(test_zswap_usage),
>   	T(test_swapin_nozswap),
>   	T(test_zswapin),
> +	T(test_zswap_writeback_enabled),
> +	T(test_zswap_writeback_disabled),
>   	T(test_no_kmem_bypass),
>   	T(test_no_invasive_cgroup_shrink),
>   };

