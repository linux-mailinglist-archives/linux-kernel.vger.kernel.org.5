Return-Path: <linux-kernel+bounces-82127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F67867FA5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C8911C28E30
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAEF12F370;
	Mon, 26 Feb 2024 18:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IDkyR1pW"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C29D12E1F3
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 18:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708971249; cv=none; b=aA3asEts5EO4iHoKmxYniJmA+SS5tEZ/rLogzVYH8aFciFW5fWZxQIl4TR4vz86jTJbwSF/1Xo15zA9FFDjb+x8uK20LdBAnLpwP/bw1JIVsCVexbWjlLRtS8WcbSGXwER5gopjOTleZJGJPKKbgnJ/W2R4eHJg7NA3KPtAUo8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708971249; c=relaxed/simple;
	bh=jvztlj2fOBuagAeUU8MHaIuRSoRjQLL3omt64QErqFk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XqKV9EOnYAzzgZK5hXGO1jX69vjcY3Gx/8NemfZ7ilr9PCXvYA0W3E0wOdiDTR1hGtsI1roXuNNojtNok3fukzNI9FUmDyqTYqNXi8r4d9hWQMtKN65VnmtnbT0fvVt2eHz05anmN2unWsup/Rf58kdZKpc72PfHXKxUpKbh9f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IDkyR1pW; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33d18931a94so2663673f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 10:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708971246; x=1709576046; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rdOlnisLBpgn2tY4M92YMommU1ind5HDlDhk0k1dAms=;
        b=IDkyR1pW8ChSsmgSDgCrCtd9tXDSkuaVXK6aGF8RCmymEvGQukXH8c6LHRwmLL1eW7
         MOVJ4D+EzPSTFbaQoOJc3ASI6veG/5K8OoZRrOzTLC05/wxX9XoqLsw579UTs4ZiFYag
         B/r/U2ZQA8450ogF9zjyFDyuy7eU0qlxXqiDkutmgee9z/hrpouQT48APEHk+/WpXhqY
         wrnHKg0aWrynLQy9qgIkTfvUQ8GN0xKo3i6DuqATijgO3XVgDM4kSncU/E+YuTqlh+bO
         2y9sDBfDvXSFd+yVq4RwiZutUVKY48BrbZbFl7Dz377mgT7KMK0SqdRjcO260b9rkPdj
         ndpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708971246; x=1709576046;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rdOlnisLBpgn2tY4M92YMommU1ind5HDlDhk0k1dAms=;
        b=XdRNKhR9K2u8W4NPY8MwlCT4o2uY/6HQvGttCYNAZvmNcAm4NFwthixFBekk3fn3lb
         8ntEKLGsN1AojzELmt7ooeYVCItNBUMIZEVYU+xX9leGpufH9Cm0VEYlsMJJzmmvvQz/
         IQnuvb/vOrNS2987bo9lgR5TlRO6sIiPUwUM47Y1S1mT/iqFWX5MEgWWq6m4e0uUjE0g
         Ix90vr3TbhZ9rlUC7SsN3OpNHJtoBP7ZSwWq3HNFqqRlywNmeIFTohK3yiaFpDgE1Chr
         rbMZs5G5H0X7iMBNvwHATmFXDpwp52VtzYNgqtVSLJhIu/7WSMkrfKbQ88f6Vk0DWNZj
         0onA==
X-Forwarded-Encrypted: i=1; AJvYcCUXtfRkWlLzyLasiIn/BHTRSNNdEJgAz5pJDZ/ryJ6UmQLXGRRkQVZcmPN2w9EYRwx1thzXyDkXI59x6mazHRE4eU3u9gYjH87qq8nU
X-Gm-Message-State: AOJu0YwLkjEhSwSeidmDUnBZtdve9asTHlxnsTPgQhnjNADwHaVMNMX/
	IMdifD+Xf3GpXqWtX2IHlrJiKFsGp5LaLT3NYkni/KD80X9nvO7Pf+k1/9t6XkaOR8h+lMnzskC
	d
X-Google-Smtp-Source: AGHT+IFPy8PQ+Y6ALtHBB46D50zSvTEsaf8HgqKvkKq5krJix8fiZnDh+U3QAloD0ksGoobusBm3aw==
X-Received: by 2002:a05:6000:12d0:b0:33d:6554:fe81 with SMTP id l16-20020a05600012d000b0033d6554fe81mr4990641wrx.64.1708971245802;
        Mon, 26 Feb 2024 10:14:05 -0800 (PST)
Received: from localhost (a109-49-32-45.cpe.netcabo.pt. [109.49.32.45])
        by smtp.gmail.com with ESMTPSA id h4-20020a05600016c400b0033dda0e82e5sm3542919wrf.32.2024.02.26.10.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 10:14:05 -0800 (PST)
From: Rui Miguel Silva <rui.silva@linaro.org>
To: Chengming Zhou <chengming.zhou@linux.dev>, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, vbabka@suse.cz,
 roman.gushchin@linux.dev, Xiongwei.Song@windriver.com
Subject: Re: [PATCH] usb: isp1760: remove SLAB_MEM_SPREAD flag usage
In-Reply-To: <e7f00fbe-a676-4d47-b1bb-cc69cc391172@linux.dev>
References: <20240224135256.830413-1-chengming.zhou@linux.dev>
 <e7f00fbe-a676-4d47-b1bb-cc69cc391172@linux.dev>
Date: Mon, 26 Feb 2024 18:14:04 +0000
Message-ID: <m34jdvm6tv.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hey Zhou,
many thanks for the patch.

Chengming Zhou <chengming.zhou@linux.dev> writes:

> On 2024/2/24 21:52, chengming.zhou@linux.dev wrote:
>> From: Chengming Zhou <zhouchengming@bytedance.com>
>> 
>> The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
>> its usage so we can delete it from slab. No functional change.
>
> Update changelog to make it clearer:
>
> The SLAB_MEM_SPREAD flag used to be implemented in SLAB, which was
> removed as of v6.8-rc1, so it became a dead flag since the commit
> 16a1d968358a ("mm/slab: remove mm/slab.c and slab_def.h"). And the
> series[1] went on to mark it obsolete to avoid confusion for users.
> Here we can just remove all its users, which has no functional change.
>
> [1] https://lore.kernel.org/all/20240223-slab-cleanup-flags-v2-1-02f1753e8303@suse.cz/

With this changelog, you can add my tag:
Acked-by: Rui Miguel Silva <rui.silva@linaro.org>

Cheers,
    Rui
>
> Thanks!
>
>> 
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> ---
>>  drivers/usb/isp1760/isp1760-hcd.c | 8 +++-----
>>  1 file changed, 3 insertions(+), 5 deletions(-)
>> 
>> diff --git a/drivers/usb/isp1760/isp1760-hcd.c b/drivers/usb/isp1760/isp1760-hcd.c
>> index 76862ba40f35..0e5e4cb74c87 100644
>> --- a/drivers/usb/isp1760/isp1760-hcd.c
>> +++ b/drivers/usb/isp1760/isp1760-hcd.c
>> @@ -2521,21 +2521,19 @@ static const struct hc_driver isp1760_hc_driver = {
>>  int __init isp1760_init_kmem_once(void)
>>  {
>>  	urb_listitem_cachep = kmem_cache_create("isp1760_urb_listitem",
>> -			sizeof(struct urb_listitem), 0, SLAB_TEMPORARY |
>> -			SLAB_MEM_SPREAD, NULL);
>> +			sizeof(struct urb_listitem), 0, SLAB_TEMPORARY, NULL);
>>  
>>  	if (!urb_listitem_cachep)
>>  		return -ENOMEM;
>>  
>>  	qtd_cachep = kmem_cache_create("isp1760_qtd",
>> -			sizeof(struct isp1760_qtd), 0, SLAB_TEMPORARY |
>> -			SLAB_MEM_SPREAD, NULL);
>> +			sizeof(struct isp1760_qtd), 0, SLAB_TEMPORARY, NULL);
>>  
>>  	if (!qtd_cachep)
>>  		goto destroy_urb_listitem;
>>  
>>  	qh_cachep = kmem_cache_create("isp1760_qh", sizeof(struct isp1760_qh),
>> -			0, SLAB_TEMPORARY | SLAB_MEM_SPREAD, NULL);
>> +			0, SLAB_TEMPORARY, NULL);
>>  
>>  	if (!qh_cachep)
>>  		goto destroy_qtd;

