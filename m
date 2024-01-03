Return-Path: <linux-kernel+bounces-15679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 344D5823030
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34F921C23419
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D5F1B279;
	Wed,  3 Jan 2024 15:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bvpCkP+1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BE61B26F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 15:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704294152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9YzjbOUgpmBQjCOcD8mqfwxZd0BBuvIZGME9zIgMdSg=;
	b=bvpCkP+11r7CMuEUvC9ckmz+92LfP/dRt0rdwF50BPN0jb6X226T4qfvgmlhGH+pu/h1bP
	X2xFpxZ0T0QnUVUkzZOZpFxeGPtxvNwQcRC+bqc1qDNUU83kMImAzFsE7+E39Y5l92uSq6
	G1waExlgMY7gSSwGb8Cl9cP62V/M/8U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-rj6weVZxN16S24OD-OFbvA-1; Wed, 03 Jan 2024 10:02:30 -0500
X-MC-Unique: rj6weVZxN16S24OD-OFbvA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40d8791308eso19248035e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 07:02:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704294149; x=1704898949;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9YzjbOUgpmBQjCOcD8mqfwxZd0BBuvIZGME9zIgMdSg=;
        b=J3JxaUvl/d13RqdkMMP5yyZFH0x5dWHE2XKXqgI8pi0FqeG4ERdvRHGU6XAX4pEAKH
         UmGLhxhPbIwAuG6XOA8az4lAZO1jukYbd0pjo+bBZQKxVLwjIY4Hfz7jw06A6e+iqxyG
         wDp7g3cE3+Gwcpqlg1zXfLJGvJofbqot32v/frDPwpNi0LuyXecCsfvx5p6g8M/m4HfC
         m+w4upMqh2S+8uPsrH+zHsS487CduiYF5rdhmdYKaJM8gOToUl3WJRU78ICnUNkRtBt1
         Lp+G2TTFGsvGxhpNRghjJNn85hRVqNIheNudpwu1+Jple3sADRYWDcc7c2sN5zDMtpOg
         8kMg==
X-Gm-Message-State: AOJu0Yy+YINLW4S9z6799YW7yApMwUFxEOta2ZWccfLsdTUlha1n7Z+Q
	db+452tsZ7qBSIZp0n69iEjhSNoxXqJ5CVW51+mMpyH7Ncd2cUmJtyTvM0XIa4td3uZmLalpqxJ
	b95lWZSU4xCZyGbEcjWAxecyEuUqRoRs=
X-Received: by 2002:a7b:c3c6:0:b0:40c:de2:148c with SMTP id t6-20020a7bc3c6000000b0040c0de2148cmr9814047wmj.47.1704294149639;
        Wed, 03 Jan 2024 07:02:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGf2xvpgewPhCy7SJJa8JoELXLbO3OMO+jKcvhfVqh41Qo5YGyItbjrI41gXQAgNxq5coAqjQ==
X-Received: by 2002:a7b:c3c6:0:b0:40c:de2:148c with SMTP id t6-20020a7bc3c6000000b0040c0de2148cmr9814036wmj.47.1704294149263;
        Wed, 03 Jan 2024 07:02:29 -0800 (PST)
Received: from [192.168.9.34] (net-2-34-31-72.cust.vodafonedsl.it. [2.34.31.72])
        by smtp.gmail.com with ESMTPSA id n19-20020a05600c4f9300b0040d8d023760sm2574803wmq.5.2024.01.03.07.02.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 07:02:28 -0800 (PST)
Message-ID: <67bd8de1-f4a2-43bd-a973-3add86cc2b26@redhat.com>
Date: Wed, 3 Jan 2024 16:02:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 1/2] fpga: add an owner field and use it to take
 the low-level module's refcount
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
References: <20231218202809.84253-1-marpagan@redhat.com>
 <20231218202809.84253-2-marpagan@redhat.com>
 <ZYkoIdrbqJ9w+EHg@yilunxu-OptiPlex-7050>
Content-Language: en-US
From: Marco Pagani <marpagan@redhat.com>
In-Reply-To: <ZYkoIdrbqJ9w+EHg@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2023-12-25 07:58, Xu Yilun wrote:
> On Mon, Dec 18, 2023 at 09:28:08PM +0100, Marco Pagani wrote:
>> Add a module owner field to the fpga_manager_ops struct and use it to
>> take the low-level control module's refcount instead of relying on the
>> parent device's driver pointer. Low-level control modules should
>> statically set the owner field to THIS_MODULE. To detect when the owner
> 
> Don't be so strict, people could pass in any owner module they think it
> is correct.
>

I'm planning to use a helper macro to set the owner field at registration,
as suggested by Greg K-H. So, I would change this sentence anyway.
 
>> module pointer becomes stale, set the mops pointer to null during
>> fpga_mgr_unregister() (called by the low-level module exit function) and
> 
> No need the side note, people could call fpga_mgr_unregister() at any
> time they think it is correct.
>

Okay, I'll drop this line.

>> test it before taking the module's refcount. Use a mutex to avoid a
>> crash that can happen if __fpga_mgr_get() gets suspended between testing
>> the mops pointer and taking the low-level refcount and then resumes when
>> the low-level module has already been freed.
>>
>> Thanks to Xu Yilun for suggesting the locking pattern.
> 
> I appreciate that but don't put it in changelog. A Suggested-by is
> appropriate.
> 

Okay.

>>
>> Other changes: move put_device() from __fpga_mgr_get() to fpga_mgr_get()
> 
> Opportunistically move put_device() ...
> 
> The point is, try to imply the *Other* changes are simple and relative to
> the main change, or we should split the patch.
> 
> Sorry but seeing the actual change, please split. The whole change is
> small and the put_device() part contributes 40% code ...
> 

Make sense. I would prefer to rephrase the message and do everything in a
single patch since moving put_device() is a small change related to the
mechanism for getting the manager.

Thanks,
Marco

>> and of_fpga_mgr_get() to improve code clarity.
>>
>> Fixes: 654ba4cc0f3e ("fpga manager: ensure lifetime with of_fpga_mgr_get")
>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
>> ---
>>  drivers/fpga/fpga-mgr.c       | 50 ++++++++++++++++++++++++-----------
>>  include/linux/fpga/fpga-mgr.h |  4 +++
>>  2 files changed, 38 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
>> index 06651389c592..a32b7d40080d 100644
>> --- a/drivers/fpga/fpga-mgr.c
>> +++ b/drivers/fpga/fpga-mgr.c
>> @@ -664,20 +664,20 @@ static struct attribute *fpga_mgr_attrs[] = {
>>  };
>>  ATTRIBUTE_GROUPS(fpga_mgr);
>>  
>> -static struct fpga_manager *__fpga_mgr_get(struct device *dev)
>> +static struct fpga_manager *__fpga_mgr_get(struct device *mgr_dev)
>>  {
>>  	struct fpga_manager *mgr;
>>  
>> -	mgr = to_fpga_manager(dev);
>> +	mgr = to_fpga_manager(mgr_dev);
>>  
>> -	if (!try_module_get(dev->parent->driver->owner))
>> -		goto err_dev;
>> +	mutex_lock(&mgr->mops_mutex);
>>  
>> -	return mgr;
>> +	if (!mgr->mops || !try_module_get(mgr->mops->owner))
>> +		mgr = ERR_PTR(-ENODEV);
>>  
>> -err_dev:
>> -	put_device(dev);
>> -	return ERR_PTR(-ENODEV);
>> +	mutex_unlock(&mgr->mops_mutex);
>> +
>> +	return mgr;
>>  }
>>  
>>  static int fpga_mgr_dev_match(struct device *dev, const void *data)
>> @@ -693,12 +693,18 @@ static int fpga_mgr_dev_match(struct device *dev, const void *data)
>>   */
>>  struct fpga_manager *fpga_mgr_get(struct device *dev)
>>  {
>> -	struct device *mgr_dev = class_find_device(&fpga_mgr_class, NULL, dev,
>> -						   fpga_mgr_dev_match);
>> +	struct fpga_manager *mgr;
>> +	struct device *mgr_dev;
>> +
>> +	mgr_dev = class_find_device(&fpga_mgr_class, NULL, dev, fpga_mgr_dev_match);
>>  	if (!mgr_dev)
>>  		return ERR_PTR(-ENODEV);
>>  
>> -	return __fpga_mgr_get(mgr_dev);
>> +	mgr = __fpga_mgr_get(mgr_dev);
>> +	if (IS_ERR(mgr))
>> +		put_device(mgr_dev);
>> +
>> +	return mgr;
>>  }
>>  EXPORT_SYMBOL_GPL(fpga_mgr_get);
>>  
>> @@ -711,13 +717,18 @@ EXPORT_SYMBOL_GPL(fpga_mgr_get);
>>   */
>>  struct fpga_manager *of_fpga_mgr_get(struct device_node *node)
>>  {
>> -	struct device *dev;
>> +	struct fpga_manager *mgr;
>> +	struct device *mgr_dev;
>>  
>> -	dev = class_find_device_by_of_node(&fpga_mgr_class, node);
>> -	if (!dev)
>> +	mgr_dev = class_find_device_by_of_node(&fpga_mgr_class, node);
>> +	if (!mgr_dev)
>>  		return ERR_PTR(-ENODEV);
>>  
>> -	return __fpga_mgr_get(dev);
>> +	mgr = __fpga_mgr_get(mgr_dev);
>> +	if (IS_ERR(mgr))
>> +		put_device(mgr_dev);
>> +
>> +	return mgr;
>>  }
>>  EXPORT_SYMBOL_GPL(of_fpga_mgr_get);
>>  
>> @@ -727,7 +738,7 @@ EXPORT_SYMBOL_GPL(of_fpga_mgr_get);
>>   */
>>  void fpga_mgr_put(struct fpga_manager *mgr)
>>  {
>> -	module_put(mgr->dev.parent->driver->owner);
>> +	module_put(mgr->mops->owner);
>>  	put_device(&mgr->dev);
>>  }
>>  EXPORT_SYMBOL_GPL(fpga_mgr_put);
>> @@ -803,6 +814,7 @@ fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *in
>>  	}
>>  
>>  	mutex_init(&mgr->ref_mutex);
>> +	mutex_init(&mgr->mops_mutex);
>>  
>>  	mgr->name = info->name;
>>  	mgr->mops = info->mops;
>> @@ -888,6 +900,12 @@ void fpga_mgr_unregister(struct fpga_manager *mgr)
>>  	 */
>>  	fpga_mgr_fpga_remove(mgr);
>>  
>> +	mutex_lock(&mgr->mops_mutex);
>> +
>> +	mgr->mops = NULL;
>> +
>> +	mutex_unlock(&mgr->mops_mutex);
>> +
>>  	device_unregister(&mgr->dev);
>>  }
>>  EXPORT_SYMBOL_GPL(fpga_mgr_unregister);
>> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
>> index 54f63459efd6..b4d9413cb444 100644
>> --- a/include/linux/fpga/fpga-mgr.h
>> +++ b/include/linux/fpga/fpga-mgr.h
>> @@ -162,6 +162,7 @@ struct fpga_manager_info {
>>   * @write_complete: set FPGA to operating state after writing is done
>>   * @fpga_remove: optional: Set FPGA into a specific state during driver remove
>>   * @groups: optional attribute groups.
>> + * @owner: owner module containing the ops.
>>   *
>>   * fpga_manager_ops are the low level functions implemented by a specific
>>   * fpga manager driver.  The optional ones are tested for NULL before being
>> @@ -184,6 +185,7 @@ struct fpga_manager_ops {
>>  			      struct fpga_image_info *info);
>>  	void (*fpga_remove)(struct fpga_manager *mgr);
>>  	const struct attribute_group **groups;
>> +	struct module *owner;
>>  };
>>  
>>  /* FPGA manager status: Partial/Full Reconfiguration errors */
>> @@ -201,6 +203,7 @@ struct fpga_manager_ops {
>>   * @state: state of fpga manager
>>   * @compat_id: FPGA manager id for compatibility check.
>>   * @mops: pointer to struct of fpga manager ops
>> + * @mops_mutex: protects mops from low-level module removal
>>   * @priv: low level driver private date
>>   */
>>  struct fpga_manager {
>> @@ -209,6 +212,7 @@ struct fpga_manager {
>>  	struct mutex ref_mutex;
>>  	enum fpga_mgr_states state;
>>  	struct fpga_compat_id *compat_id;
>> +	struct mutex mops_mutex;
>>  	const struct fpga_manager_ops *mops;
>>  	void *priv;
>>  };
>> -- 
>> 2.43.0
>>
>>
> 


