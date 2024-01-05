Return-Path: <linux-kernel+bounces-17543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CA3824F23
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 08:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02C39284176
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 07:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3863C1EB48;
	Fri,  5 Jan 2024 07:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6rRE2D5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F66C1DDDC;
	Fri,  5 Jan 2024 07:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-28bcc273833so1066610a91.1;
        Thu, 04 Jan 2024 23:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704439431; x=1705044231; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mi5dW+kaTv8H8oViBS7oLpGne9QKIEIWJnrqh7QIaNk=;
        b=f6rRE2D5EahHyZS/wSkGRDmZ9NrSuEUkSISzS4bjfNrnAb3BeSDPIw2s+Ad1y/QLSa
         Gw1lEfL2PpDneP1pJ7zCEUBoxPEIJoCKSo708ysbb/FQcEgvmQsNcUzErpwoS/zO/JMj
         zfY2RNqEFz9xdfEdJEERk8dvPFDLf5TAJhjqM+0cH1EhBzm8aaIoqdwunflDQEJ8dzu1
         05YCS5g+skZ1LwY1NvJ2fiR1fy/I0yypmy+KsyLxLQ9SnIoZknSa/uo4smyDNV0yaN28
         dkQx82jPHmf6jjAfATSA3MZ2h1aVUBlex0eo0ybxKwrXqBYGl/qcLxXqWvB7paz+VOet
         +dhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704439431; x=1705044231;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mi5dW+kaTv8H8oViBS7oLpGne9QKIEIWJnrqh7QIaNk=;
        b=HHBrrvvpf6k4xAquuI8j9A5xqjPOrh1x7Bh5rzX/0pwPwF5z+ua0L7GtZsoWZ0k09X
         ZoojN8N41Gr9eXT5X2K7hPIzjEs3xlW/LAmR5XV3CCKbKEr5gmPIBWBB0Is5BWdsMNt+
         7SFc454rfJ/yrOPkttUZjbULzfMi81Ucc1IMkSqQ/9HwV+Zef1F08IR3HCXD7dwmm6Kd
         2ZS4Nhk/Jilum3QvJPZM9QsfnC/RnUYvfMrnpXJg+bqRBVhtC4KnjtNt2XddyTeaUG75
         jDb0/VWq205c61uHnzjr0UqHPGjCX+Yz2tK7H73baPV4VVtUZ7x8xdKt0ouojd5Y0woU
         HJyg==
X-Gm-Message-State: AOJu0YyYueWj5b5XkIINruv/ioIvzmQAUpp4hc4gpHfSbAFWU69rNOzp
	aikkgrWkw0yhdZjBSZzbDyE=
X-Google-Smtp-Source: AGHT+IEnOgUU+Twu/APnYJIBliVK10kdVnA6ApzgZ8e7KrNNqWst6oeA16XX5foM0sm+w/OTpOhiTQ==
X-Received: by 2002:a17:90b:4387:b0:28c:e296:7336 with SMTP id in7-20020a17090b438700b0028ce2967336mr1586181pjb.34.1704439431455;
        Thu, 04 Jan 2024 23:23:51 -0800 (PST)
Received: from ?IPV6:2001:250:206:1c18:5510:d476:e3ee:6e9f? ([2001:250:206:1c18:5510:d476:e3ee:6e9f])
        by smtp.gmail.com with ESMTPSA id px5-20020a17090b270500b0028b17832efdsm532645pjb.39.2024.01.04.23.23.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 23:23:51 -0800 (PST)
Message-ID: <fb57ddd4-b5e3-4e76-8642-8020d34fc1f1@gmail.com>
Date: Fri, 5 Jan 2024 15:23:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: mon: Fix atomicity violation in mon_bin_vma_fault
To: Greg KH <gregkh@linuxfoundation.org>
Cc: surenb@google.com, 42.hyeyoo@gmail.com, benjamin.tissoires@redhat.com,
 mhocko@suse.com, ivan.orlov0322@gmail.com, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, baijiaju1990@outlook.com,
 stable@vger.kernel.org, BassCheck <bass@buaa.edu.cn>
References: <20231222060450.5449-1-2045gemini@gmail.com>
 <2024010409-poppy-rumor-bff5@gregkh>
From: Gui-Dong Han <2045gemini@gmail.com>
In-Reply-To: <2024010409-poppy-rumor-bff5@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,


Fixed in the patch v3!

Thank you for helpful advice.


Thanks,

Han

On 4/1/2024 下午10:16, Greg KH wrote:
> On Fri, Dec 22, 2023 at 02:04:50PM +0800, Gui-Dong Han wrote:
>> In mon_bin_vma_fault():
>> 	offset = vmf->pgoff << PAGE_SHIFT;
>> 	if (offset >= rp->b_size)
>> 		return VM_FAULT_SIGBUS;
>> 	chunk_idx = offset / CHUNK_SIZE;
>> 	pageptr = rp->b_vec[chunk_idx].pg;
>> The code is executed without holding any lock.
>>
>> In mon_bin_vma_close():
>> 	spin_lock_irqsave(&rp->b_lock, flags);
>> 	rp->mmap_active--;
>> 	spin_unlock_irqrestore(&rp->b_lock, flags);
>>
>> In mon_bin_ioctl():
>> 	spin_lock_irqsave(&rp->b_lock, flags);
>> 	if (rp->mmap_active) {
>> 		...
>> 	} else {
>> 		...
>> 		kfree(rp->b_vec);
>> 		rp->b_vec  = vec;
>> 		rp->b_size = size;
>> 		...
>> 	}
>> 	spin_unlock_irqrestore(&rp->b_lock, flags);
>>
>> Concurrent execution of mon_bin_vma_fault() with mon_bin_vma_close() and
>> mon_bin_ioctl() could lead to atomicity violations. mon_bin_vma_fault()
>> accesses rp->b_size and rp->b_vec without locking, risking array
>> out-of-bounds access or use-after-free bugs due to possible modifications
>> in mon_bin_ioctl().
>>
>> This possible bug is found by an experimental static analysis tool
>> developed by our team, BassCheck[1]. This tool analyzes the locking APIs
>> to extract function pairs that can be concurrently executed, and then
>> analyzes the instructions in the paired functions to identify possible
>> concurrency bugs including data races and atomicity violations. The above
>> possible bug is reported when our tool analyzes the source code of
>> Linux 6.2.
>>
>> To address this issue, it is proposed to add a spin lock pair in
>> mon_bin_vma_fault() to ensure atomicity. With this patch applied, our tool
>> never reports the possible bug, with the kernel configuration allyesconfig
>> for x86_64. Due to the lack of associated hardware, we cannot test the
>> patch in runtime testing, and just verify it according to the code logic.
>>
>> [1] https://sites.google.com/view/basscheck/
>>
>> Fixes: 19e6317d24c25 ("usb: mon: Fix a deadlock in usbmon between ...")
>> Cc: stable@vger.kernel.org
>> Reported-by: BassCheck <bass@buaa.edu.cn>
>> Signed-off-by: Gui-Dong Han <2045gemini@gmail.com>
>> ---
>> v2:
>> * In this patch v2, we've added some information of the static analysis
>> tool used, as per the researcher guidelines. Also, we've added a cc in the
>> signed-off-by area, according to the stable-kernel-rules.
>>    Thank Greg KH for helpful advice.
>> ---
>>   drivers/usb/mon/mon_bin.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/mon/mon_bin.c b/drivers/usb/mon/mon_bin.c
>> index 9ca9305243fe..509cd1b8ff13 100644
>> --- a/drivers/usb/mon/mon_bin.c
>> +++ b/drivers/usb/mon/mon_bin.c
>> @@ -1250,12 +1250,16 @@ static vm_fault_t mon_bin_vma_fault(struct vm_fault *vmf)
>>   	struct mon_reader_bin *rp = vmf->vma->vm_private_data;
>>   	unsigned long offset, chunk_idx;
>>   	struct page *pageptr;
>> -
>> +	unsigned long flags;
>> +	spin_lock_irqsave(&rp->b_lock, flags);
> Nit, you still need the blank line before spin_lock_irqsave() here,
> right?
>
>>   	offset = vmf->pgoff << PAGE_SHIFT;
>> -	if (offset >= rp->b_size)
>> +	if (offset >= rp->b_size) {
>> +		spin_unlock_irqrestore(&rp->b_lock, flags);
>>   		return VM_FAULT_SIGBUS;
>> +	}
>>   	chunk_idx = offset / CHUNK_SIZE;
>>   	pageptr = rp->b_vec[chunk_idx].pg;
>> +	spin_unlock_irqrestore(&rp->b_lock, flags);
>>   	get_page(pageptr);
>>   	vmf->page = pageptr;
> Shouldn't the unlock go here, not 2 lines above as you are still
> modifying things touched by rp.
>
> thanks,
>
> greg k-h

