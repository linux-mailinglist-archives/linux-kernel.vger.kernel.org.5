Return-Path: <linux-kernel+bounces-32616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1440835E02
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 033CF1C24050
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F52C39875;
	Mon, 22 Jan 2024 09:21:46 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E290439850
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 09:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705915305; cv=none; b=YwMTcP7sevXVKImEd6EjDc4Gp0KRbtUMNuQG9Cgy/tLTFGrE7fiQkD0So9TG6pWn7purAkbPnJfFiumLqq9r1r5fsP+HexdEeZVyXhNbcp12E9dSpzo3YM7UTh45EjTQPUu4mO2TNIvLlTHz1V3rKIKJvpj7u7H5O9XVCBOGiOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705915305; c=relaxed/simple;
	bh=4KI2ZPp+klv0+9vC5YPDcXCE5qOHpeBA9+S8DFkEjqo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=nkz65DrcxyceE26ZfGOrQlJQjT0dk6plDYg4w++PZ7m52IqE16KzOT0SXY0dztkl2sG7bA7f3eFhArAVoTzWbUTwRTKq7D7CmEo5YfJa5Qv8j8ocLUy7A5FbW6tKW435klBCfYrVktGfXJTLjeNRBd2U2EpfrBUUhCDBKTKufwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e60d74b81so3393765e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 01:21:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705915302; x=1706520102;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nW0OYZX6txhfsdkxEjh61D57I5eQsuXgO/N1kAmHy5Y=;
        b=I9geHDDsbPb0UwkuqgvRc6nJmdRZN9mJO8Ji2seivseQqjueVmQpo+gryLiwlQPyuZ
         9Qj0+V79E+JSxomfZGhVereix38CI0QOb3DJHc0O93QHf2NxGUEWtjQPFM2hDq9D4aHt
         psIml34LeFifYY+pIeWBM8kafrAjArEJazMSMuSNbNF8n6nSSZ/aukGtZdIFRSLWM9Yr
         59MnJClBZD1FvzS5Q8XCxM9niQYyzNVgphMZ3YobTbupIP69en6x3jg4LlN0qzE3YwQo
         mo1KXV51XT/LbwzaeMLpoIQYBX8HzeGo93IP62TpRu861MByuLg1cJ8ElDd/yfvPnASf
         2S/g==
X-Gm-Message-State: AOJu0YxsPTaT57Dmnq03nGRLH/Re2bFiWOCE4cjCegjfoS5RhmRHtkfn
	BLdjNr3srsxe/kcPMHTCS8UFCK42qiotg9mGqnm5xKRc+IsrUJAk
X-Google-Smtp-Source: AGHT+IEfsX4fJoG8LnjDTWeQf2jBLmLmHGVt/WcR7FSBxGdNUm3k1JmLyxvfQ1KqsOTsVQDpxrOx7Q==
X-Received: by 2002:a05:600c:4f04:b0:40d:3ae3:2337 with SMTP id l4-20020a05600c4f0400b0040d3ae32337mr5600525wmq.2.1705915301802;
        Mon, 22 Jan 2024 01:21:41 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id o8-20020a05600c4fc800b0040e549c77a1sm42269726wmq.32.2024.01.22.01.21.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 01:21:41 -0800 (PST)
Message-ID: <92407bcc-ed93-4963-898b-abc4737768bc@grimberg.me>
Date: Mon, 22 Jan 2024 11:21:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme_core: scan namespaces asynchronously
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
To: Stuart Hayes <stuart.w.hayes@gmail.com>, linux-kernel@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
References: <20240118210303.10484-1-stuart.w.hayes@gmail.com>
 <189cde89-9750-476f-8fbb-1c95dc056efb@grimberg.me>
In-Reply-To: <189cde89-9750-476f-8fbb-1c95dc056efb@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Resending... didn't make it to the list, probably smtp issues....

On 1/22/24 11:13, Sagi Grimberg wrote:
> 
> 
> On 1/18/24 23:03, Stuart Hayes wrote:
>> Use async function calls to make namespace scanning happen in parallel.
>>
>> Without the patch, NVME namespaces are scanned serially, so it can take a
>> long time for all of a controller's namespaces to become available,
>> especially with a slower (TCP) interface with large number of namespaces.
>>
>> The time it took for all namespaces to show up after connecting (via TCP)
>> to a controller with 1002 namespaces was measured:
>>
>> network latency   without patch   with patch
>>       0                 6s            1s
>>      50ms             210s           10s
>>     100ms             417s           18s
>>
> 
> Impressive speedup. Not a very common use-case though...
> 
>> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
>>
>> -- 
>> V2: remove module param to enable/disable async scanning
>>      add scan time measurements to commit message
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 0af612387083..069350f85b83 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -4,6 +4,7 @@
>>    * Copyright (c) 2011-2014, Intel Corporation.
>>    */
>> +#include <linux/async.h>
>>   #include <linux/blkdev.h>
>>   #include <linux/blk-mq.h>
>>   #include <linux/blk-integrity.h>
>> @@ -3812,12 +3813,38 @@ static void nvme_validate_ns(struct nvme_ns 
>> *ns, struct nvme_ns_info *info)
>>           nvme_ns_remove(ns);
>>   }
>> -static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>> +/*
>> + * struct nvme_scan_state - keeps track of controller & NSIDs to scan
>> + * @ctrl:    Controller on which namespaces are being scanned
>> + * @count:    Next NSID to scan (for sequential scan), or
>> + *        Index of next NSID to scan in ns_list (for list scan)
>> + * @ns_list:    pointer to list of NSIDs to scan (NULL if sequential 
>> scan)
>> + */
>> +struct nvme_scan_state {
>> +    struct nvme_ctrl *ctrl;
>> +    atomic_t count;
>> +    __le32 *ns_list;
>> +};
>> +
>> +static void nvme_scan_ns(void *data, async_cookie_t cookie)
> 
> I think its better to call it nvme_scan_ns_async to indicate what
> it is.
> 
>>   {
>> -    struct nvme_ns_info info = { .nsid = nsid };
>> +    struct nvme_ns_info info = {};
>> +    struct nvme_scan_state *scan_state;
>> +    struct nvme_ctrl *ctrl;
>> +    u32 nsid;
>>       struct nvme_ns *ns;
>>       int ret;
>> +    scan_state = data;
>> +    ctrl = scan_state->ctrl;
> 
> I think these assignments can be done on the declaration.
> 
>> +    nsid = (u32)atomic_fetch_add(1, &scan_state->count);
>> +    /*
>> +     * get NSID from list (if scanning from a list, not sequentially)
>> +     */
>> +    if (scan_state->ns_list)
>> +        nsid = le32_to_cpu(scan_state->ns_list[nsid]);
>> +
> 
> This is awkward. ns_list passed in optionally.
> How about we limit this change to only operate on nvme_scan_ns_list?
> If the controller is old or quirked to support only a sequential scan
> it does not benefit from a parallel scan. I doubt that these controllers
> are likely to expose a large number of namespaces anyways.
> 
>> +    info.nsid = nsid;
>>       if (nvme_identify_ns_descs(ctrl, &info))
>>           return;
>> @@ -3881,11 +3908,15 @@ static int nvme_scan_ns_list(struct nvme_ctrl 
>> *ctrl)
>>       __le32 *ns_list;
>>       u32 prev = 0;
>>       int ret = 0, i;
>> +    ASYNC_DOMAIN(domain);
>> +    struct nvme_scan_state scan_state;
>>       ns_list = kzalloc(NVME_IDENTIFY_DATA_SIZE, GFP_KERNEL);
>>       if (!ns_list)
>>           return -ENOMEM;
>> +    scan_state.ctrl = ctrl;
>> +    scan_state.ns_list = ns_list;
> 
> Is there a need to have a local ns_list variable here?
> 
>>       for (;;) {
>>           struct nvme_command cmd = {
>>               .identify.opcode    = nvme_admin_identify,
>> @@ -3901,19 +3932,25 @@ static int nvme_scan_ns_list(struct nvme_ctrl 
>> *ctrl)
>>               goto free;
>>           }
>> +        /*
>> +         * scan list starting at list offset 0
>> +         */
>> +        atomic_set(&scan_state.count, 0);
>>           for (i = 0; i < nr_entries; i++) {
>>               u32 nsid = le32_to_cpu(ns_list[i]);
>>               if (!nsid)    /* end of the list? */
>>                   goto out;
>> -            nvme_scan_ns(ctrl, nsid);
>> +            async_schedule_domain(nvme_scan_ns, &scan_state, &domain);
>>               while (++prev < nsid)
>>                   nvme_ns_remove_by_nsid(ctrl, prev);
>>           }
>> +        async_synchronize_full_domain(&domain);
>>       }
>>    out:
>>       nvme_remove_invalid_namespaces(ctrl, prev);
> 
> Is it a good idea to remove the invalid namespaces before synchronizing
> the async scans?
> 
>>    free:
>> +    async_synchronize_full_domain(&domain);
>>       kfree(ns_list);
>>       return ret;
>>   }
>> @@ -3922,14 +3959,23 @@ static void nvme_scan_ns_sequential(struct 
>> nvme_ctrl *ctrl)
>>   {
>>       struct nvme_id_ctrl *id;
>>       u32 nn, i;
>> +    ASYNC_DOMAIN(domain);
>> +    struct nvme_scan_state scan_state;
>>       if (nvme_identify_ctrl(ctrl, &id))
>>           return;
>>       nn = le32_to_cpu(id->nn);
>>       kfree(id);
>> +    scan_state.ctrl = ctrl;
>> +    /*
>> +     * scan sequentially starting at NSID 1
>> +     */
>> +    atomic_set(&scan_state.count, 1);
>> +    scan_state.ns_list = NULL;
>>       for (i = 1; i <= nn; i++)
>> -        nvme_scan_ns(ctrl, i);
>> +        async_schedule_domain(nvme_scan_ns, &scan_state, &domain);
>> +    async_synchronize_full_domain(&domain);
>>       nvme_remove_invalid_namespaces(ctrl, nn);
>>   }
> 
> I think we need a blktest for this. ns scanning has been notorious when
> running simultaneously with controller reset/reconnect/remove
> sequences... Ideally a test with a larger number of namespaces to
> exercise the code.
> 
> Also, make sure that blktest suite does not complain about anything
> else.

