Return-Path: <linux-kernel+bounces-19890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41777827643
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4702283D1C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F4554673;
	Mon,  8 Jan 2024 17:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b3vuXlAw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4CD54662
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 17:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704734701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C6aX9dBiEE8LbJklMGgqvE97/nITQJQxltiGdxz/Yh4=;
	b=b3vuXlAw6W9i36uBzuHDqC5uUMd3Wk2KEuaLbAhEz+jFftsjIZ37DIl/n3YUJGhGT5YUYM
	sD8LdqZ4CknwwN/irbRW649qaHJrJHUKnsFQe8ud2KjUYtRhTlsy6P3Hm0/JQxxMwR6Uk/
	e1uSWl/2Rx8G9F2vxUhBah5QvHBY7r0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-4nvP6-uDOAmLXjmBsx-atg-1; Mon, 08 Jan 2024 12:25:00 -0500
X-MC-Unique: 4nvP6-uDOAmLXjmBsx-atg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-680971002e3so40426006d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 09:25:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704734700; x=1705339500;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C6aX9dBiEE8LbJklMGgqvE97/nITQJQxltiGdxz/Yh4=;
        b=InrM1VzNM2r0EWoE4UC+cQHK7ca4MGmobiMHdIEXPqFVSv4JT6v7crKOyHRf5f6apq
         gF80THDvuIkcgCz/gGnxe7AXiegS8LHondLyt6a/UQvaNTnpICsnQMBkuYO0OGW+t5KQ
         8mYHJuMjVNVYPrDrpbN9l0r1KC3JDdvfCe/RzZPxA1Xn5JHNkXB19DOcea6BtKrZPwoJ
         eMozLlMDyocV87S4mXGdinm7qDsQif9L14oICh1LyhFRDnwvZJhRa9q3yKjvh1eLEhij
         DPqGKgR4+vN4WVsn/rF4CSsAN7kVvYeIzhopvLJoCFJZ9X+iI3isIRHaxoZd21nabMlU
         COPg==
X-Gm-Message-State: AOJu0Yxofl6jP6ixXWW/+23YEJqAgKq55bHo7LBwpdzVWfQnBvr0i1me
	xZm94OkD7OqqsomDoS3Gur5vlIFIdFxeGDrLGSHtnSjkgypRXS1c5ejVQcE1MMwafWJZLd/gLCy
	ycKXLFcSLWGi/Xw/RGexaYEoiFwax8eA=
X-Received: by 2002:a05:6214:2407:b0:680:ce93:f47b with SMTP id fv7-20020a056214240700b00680ce93f47bmr174734qvb.11.1704734699663;
        Mon, 08 Jan 2024 09:24:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHwHhGjS1auKA1aOgNfaOKzeWdPecytVxhAHRqr0je3LYSsu03Z8q8kEDkBIOyxyb0Q++s3FA==
X-Received: by 2002:a05:6214:2407:b0:680:ce93:f47b with SMTP id fv7-20020a056214240700b00680ce93f47bmr174719qvb.11.1704734699284;
        Mon, 08 Jan 2024 09:24:59 -0800 (PST)
Received: from [192.168.9.34] (net-2-34-31-72.cust.vodafonedsl.it. [2.34.31.72])
        by smtp.gmail.com with ESMTPSA id i11-20020a0cfccb000000b006810b63d26fsm137357qvq.59.2024.01.08.09.24.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 09:24:58 -0800 (PST)
Message-ID: <c2026945-76ab-4224-b3af-b6991e16d282@redhat.com>
Date: Mon, 8 Jan 2024 18:24:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 1/1] fpga: add an owner and use it to take the
 low-level module's refcount
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
References: <20240105231526.109247-1-marpagan@redhat.com>
 <20240105231526.109247-2-marpagan@redhat.com>
 <ZZu7Uf3kC1i3zho3@yilunxu-OptiPlex-7050>
Content-Language: en-US
From: Marco Pagani <marpagan@redhat.com>
In-Reply-To: <ZZu7Uf3kC1i3zho3@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-01-08 10:07, Xu Yilun wrote:
> On Sat, Jan 06, 2024 at 12:15:26AM +0100, Marco Pagani wrote:
>> Add a module owner field to the fpga_manager struct to take the
>> low-level control module refcount instead of assuming that the parent
>> device has a driver and using its owner pointer. The owner is now
>> passed as an additional argument at registration time. To this end,
>> the functions for registration have been modified to take an additional
>> owner parameter and renamed to avoid conflicts. The old function names
>> are now used for helper macros that automatically set the module that
>> registers the fpga manager as the owner. This ensures compatibility
>> with existing low-level control modules and reduces the chances of
>> registering a manager without setting the owner.
>>
>> To detect when the owner module pointer becomes stale, set the mops
>> pointer to null during fpga_mgr_unregister() and test it before taking
>> the module's refcount. Use a mutex to protect against a crash that can
>> happen if __fpga_mgr_get() gets suspended between testing the mops
>> pointer and taking the refcount while the low-level module is being
>> unloaded.
>>
>> Other changes: opportunistically move put_device() from __fpga_mgr_get()
>> to fpga_mgr_get() and of_fpga_mgr_get() to improve code clarity since
>> the device refcount in taken in these functions.
>>
>> Fixes: 654ba4cc0f3e ("fpga manager: ensure lifetime with of_fpga_mgr_get")
>> Suggested-by: Xu Yilun <yilun.xu@intel.com>
>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
>> ---
>>  drivers/fpga/fpga-mgr.c       | 93 ++++++++++++++++++++++-------------
>>  include/linux/fpga/fpga-mgr.h | 80 +++++++++++++++++++++++++++---
>>  2 files changed, 134 insertions(+), 39 deletions(-)
>>
>> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
>> index 06651389c592..d7bfbdfdf2fc 100644
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
>> +	if (!mgr->mops || !try_module_get(mgr->mops_owner))
> 
> Why move the owner out of struct fpga_manager_ops? The owner within the
> ops struct makes more sense to me, it better illustrates what the mutex
> is protecting.
>

I think having the owner in fpga_manager_ops made sense when it was
meant to be set while initializing the struct in the low-level module.
However, since the owner is now passed as an argument and set at
registration time, keeping it in the FPGA manager context seems more
straightforward to me.

 
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
>> +	module_put(mgr->mops_owner);
>>  	put_device(&mgr->dev);
>>  }
>>  EXPORT_SYMBOL_GPL(fpga_mgr_put);
>> @@ -766,9 +777,10 @@ void fpga_mgr_unlock(struct fpga_manager *mgr)
>>  EXPORT_SYMBOL_GPL(fpga_mgr_unlock);
>>  
>>  /**
>> - * fpga_mgr_register_full - create and register an FPGA Manager device
>> + * __fpga_mgr_register_full - create and register an FPGA Manager device
>>   * @parent:	fpga manager device from pdev
>>   * @info:	parameters for fpga manager
>> + * @owner:	owner module containing the ops
>>   *
>>   * The caller of this function is responsible for calling fpga_mgr_unregister().
>>   * Using devm_fpga_mgr_register_full() instead is recommended.
>> @@ -776,7 +788,8 @@ EXPORT_SYMBOL_GPL(fpga_mgr_unlock);
>>   * Return: pointer to struct fpga_manager pointer or ERR_PTR()
>>   */
>>  struct fpga_manager *
>> -fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info)
>> +__fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
>> +			 struct module *owner)
>>  {
>>  	const struct fpga_manager_ops *mops = info->mops;
>>  	struct fpga_manager *mgr;
>> @@ -803,6 +816,9 @@ fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *in
>>  	}
>>  
>>  	mutex_init(&mgr->ref_mutex);
>> +	mutex_init(&mgr->mops_mutex);
>> +
>> +	mgr->mops_owner = owner;
>>  
>>  	mgr->name = info->name;
>>  	mgr->mops = info->mops;
>> @@ -841,14 +857,15 @@ fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *in
>>  
>>  	return ERR_PTR(ret);
>>  }
>> -EXPORT_SYMBOL_GPL(fpga_mgr_register_full);
>> +EXPORT_SYMBOL_GPL(__fpga_mgr_register_full);
>>  
>>  /**
>> - * fpga_mgr_register - create and register an FPGA Manager device
>> + * __fpga_mgr_register - create and register an FPGA Manager device
>>   * @parent:	fpga manager device from pdev
>>   * @name:	fpga manager name
>>   * @mops:	pointer to structure of fpga manager ops
>>   * @priv:	fpga manager private data
>> + * @owner:	owner module containing the ops
>>   *
>>   * The caller of this function is responsible for calling fpga_mgr_unregister().
>>   * Using devm_fpga_mgr_register() instead is recommended. This simple
>> @@ -859,8 +876,8 @@ EXPORT_SYMBOL_GPL(fpga_mgr_register_full);
>>   * Return: pointer to struct fpga_manager pointer or ERR_PTR()
>>   */
>>  struct fpga_manager *
>> -fpga_mgr_register(struct device *parent, const char *name,
>> -		  const struct fpga_manager_ops *mops, void *priv)
>> +__fpga_mgr_register(struct device *parent, const char *name,
>> +		    const struct fpga_manager_ops *mops, void *priv, struct module *owner)
>>  {
>>  	struct fpga_manager_info info = { 0 };
>>  
>> @@ -868,9 +885,9 @@ fpga_mgr_register(struct device *parent, const char *name,
>>  	info.mops = mops;
>>  	info.priv = priv;
>>  
>> -	return fpga_mgr_register_full(parent, &info);
>> +	return __fpga_mgr_register_full(parent, &info, owner);
>>  }
>> -EXPORT_SYMBOL_GPL(fpga_mgr_register);
>> +EXPORT_SYMBOL_GPL(__fpga_mgr_register);
>>  
>>  /**
>>   * fpga_mgr_unregister - unregister an FPGA manager
>> @@ -888,6 +905,12 @@ void fpga_mgr_unregister(struct fpga_manager *mgr)
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
>> @@ -900,9 +923,10 @@ static void devm_fpga_mgr_unregister(struct device *dev, void *res)
>>  }
>>  
>>  /**
>> - * devm_fpga_mgr_register_full - resource managed variant of fpga_mgr_register()
>> + * __devm_fpga_mgr_register_full - resource managed variant of fpga_mgr_register()
>>   * @parent:	fpga manager device from pdev
>>   * @info:	parameters for fpga manager
>> + * @owner:	owner module containing the ops
>>   *
>>   * Return:  fpga manager pointer on success, negative error code otherwise.
>>   *
>> @@ -910,7 +934,8 @@ static void devm_fpga_mgr_unregister(struct device *dev, void *res)
>>   * function will be called automatically when the managing device is detached.
>>   */
>>  struct fpga_manager *
>> -devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info)
>> +__devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
>> +			      struct module *owner)
>>  {
>>  	struct fpga_mgr_devres *dr;
>>  	struct fpga_manager *mgr;
>> @@ -919,7 +944,7 @@ devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_inf
>>  	if (!dr)
>>  		return ERR_PTR(-ENOMEM);
>>  
>> -	mgr = fpga_mgr_register_full(parent, info);
>> +	mgr = __fpga_mgr_register_full(parent, info, owner);
>>  	if (IS_ERR(mgr)) {
>>  		devres_free(dr);
>>  		return mgr;
>> @@ -930,14 +955,15 @@ devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_inf
>>  
>>  	return mgr;
>>  }
>> -EXPORT_SYMBOL_GPL(devm_fpga_mgr_register_full);
>> +EXPORT_SYMBOL_GPL(__devm_fpga_mgr_register_full);
>>  
>>  /**
>> - * devm_fpga_mgr_register - resource managed variant of fpga_mgr_register()
>> + * __devm_fpga_mgr_register - resource managed variant of fpga_mgr_register()
>>   * @parent:	fpga manager device from pdev
>>   * @name:	fpga manager name
>>   * @mops:	pointer to structure of fpga manager ops
>>   * @priv:	fpga manager private data
>> + * @owner:	owner module containing the ops
>>   *
>>   * Return:  fpga manager pointer on success, negative error code otherwise.
>>   *
>> @@ -946,8 +972,9 @@ EXPORT_SYMBOL_GPL(devm_fpga_mgr_register_full);
>>   * device is detached.
>>   */
>>  struct fpga_manager *
>> -devm_fpga_mgr_register(struct device *parent, const char *name,
>> -		       const struct fpga_manager_ops *mops, void *priv)
>> +__devm_fpga_mgr_register(struct device *parent, const char *name,
>> +			 const struct fpga_manager_ops *mops, void *priv,
>> +			 struct module *owner)
>>  {
>>  	struct fpga_manager_info info = { 0 };
>>  
>> @@ -955,9 +982,9 @@ devm_fpga_mgr_register(struct device *parent, const char *name,
>>  	info.mops = mops;
>>  	info.priv = priv;
>>  
>> -	return devm_fpga_mgr_register_full(parent, &info);
>> +	return __devm_fpga_mgr_register_full(parent, &info, owner);
>>  }
>> -EXPORT_SYMBOL_GPL(devm_fpga_mgr_register);
>> +EXPORT_SYMBOL_GPL(__devm_fpga_mgr_register);
>>  
>>  static void fpga_mgr_dev_release(struct device *dev)
>>  {
>> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
>> index 54f63459efd6..967540311462 100644
>> --- a/include/linux/fpga/fpga-mgr.h
>> +++ b/include/linux/fpga/fpga-mgr.h
>> @@ -201,6 +201,8 @@ struct fpga_manager_ops {
>>   * @state: state of fpga manager
>>   * @compat_id: FPGA manager id for compatibility check.
>>   * @mops: pointer to struct of fpga manager ops
>> + * @mops_mutex: protects mops from low-level module removal
>> + * @mops_owner: module containing the mops
>>   * @priv: low level driver private date
>>   */
>>  struct fpga_manager {
>> @@ -210,6 +212,8 @@ struct fpga_manager {
>>  	enum fpga_mgr_states state;
>>  	struct fpga_compat_id *compat_id;
>>  	const struct fpga_manager_ops *mops;
>> +	struct mutex mops_mutex;
>> +	struct module *mops_owner;
>>  	void *priv;
>>  };
>>  
>> @@ -222,6 +226,7 @@ void fpga_image_info_free(struct fpga_image_info *info);
>>  int fpga_mgr_load(struct fpga_manager *mgr, struct fpga_image_info *info);
>>  
>>  int fpga_mgr_lock(struct fpga_manager *mgr);
>> +
> 
> Why adding a line?
>

I'll remove the line.
 
>>  void fpga_mgr_unlock(struct fpga_manager *mgr);
>>  
>>  struct fpga_manager *of_fpga_mgr_get(struct device_node *node);
>> @@ -230,18 +235,81 @@ struct fpga_manager *fpga_mgr_get(struct device *dev);
>>  
>>  void fpga_mgr_put(struct fpga_manager *mgr);
>>  
>> +/**
>> + * fpga_mgr_register_full - create and register an FPGA Manager device
>> + * @parent:	fpga manager device from pdev
>> + * @info:	parameters for fpga manager
>> + *
>> + * The caller of this function is responsible for calling fpga_mgr_unregister().
>> + * Using devm_fpga_mgr_register_full() instead is recommended.
>> + *
>> + * Return: pointer to struct fpga_manager pointer or ERR_PTR()
>> + */
> 
> No need to duplicate the doc, just remove it.
> Same for the rest of code.

Do you mean keeping the kernel-doc comments only for the __fpga_mgr_*
functions in fpga-mgr.c?

> 
>> +#define fpga_mgr_register_full(parent, info) \
>> +	__fpga_mgr_register_full(parent, info, THIS_MODULE)
>> +
> 
> Delete the line, and ...
> 
>>  struct fpga_manager *
>> -fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info);
>> +__fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
>> +			 struct module *owner);
> 
> Add a line here, to make the related functions packed.
> Same for the rest of code.

Do you prefer having the macro just above the function prototype? Like:

#define devm_fpga_mgr_register(parent, name, mops, priv) \
	__devm_fpga_mgr_register(parent, name, mops, priv, THIS_MODULE)
struct fpga_manager *
__devm_fpga_mgr_register(struct device *parent, const char *name,
			 const struct fpga_manager_ops *mops, void *priv,
			 struct module *owner);

> 
>> +/**
>> + * fpga_mgr_register - create and register an FPGA Manager device
>> + * @parent:	fpga manager device from pdev
>> + * @name:	fpga manager name
>> + * @mops:	pointer to structure of fpga manager ops
>> + * @priv:	fpga manager private data
>> + *
>> + * The caller of this function is responsible for calling fpga_mgr_unregister().
>> + * Using devm_fpga_mgr_register() instead is recommended. This simple
>> + * version of the register function should be sufficient for most users. The
>> + * fpga_mgr_register_full() function is available for users that need to pass
>> + * additional, optional parameters.
>> + *
>> + * Return: pointer to struct fpga_manager pointer or ERR_PTR()
>> + */
>> +#define fpga_mgr_register(parent, name, mops, priv) \
>> +	__fpga_mgr_register(parent, name, mops, priv, THIS_MODULE)
>>  
>>  struct fpga_manager *
>> -fpga_mgr_register(struct device *parent, const char *name,
>> -		  const struct fpga_manager_ops *mops, void *priv);
>> +__fpga_mgr_register(struct device *parent, const char *name,
>> +		    const struct fpga_manager_ops *mops, void *priv, struct module *owner);
>> +
>>  void fpga_mgr_unregister(struct fpga_manager *mgr);
>>  
>> +/**
>> + * devm_fpga_mgr_register_full - resource managed variant of fpga_mgr_register()
>> + * @parent:	fpga manager device from pdev
>> + * @info:	parameters for fpga manager
>> + *
>> + * Return:  fpga manager pointer on success, negative error code otherwise.
>> + *
>> + * This is the devres variant of fpga_mgr_register_full() for which the unregister
>> + * function will be called automatically when the managing device is detached.
>> + */
>> +#define devm_fpga_mgr_register_full(parent, info) \
>> +	__devm_fpga_mgr_register_full(parent, info, THIS_MODULE)
>> +
>>  struct fpga_manager *
>> -devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info);
>> +__devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
>> +			      struct module *owner);
>> +/**
>> + * devm_fpga_mgr_register - resource managed variant of fpga_mgr_register()
>> + * @parent:	fpga manager device from pdev
>> + * @name:	fpga manager name
>> + * @mops:	pointer to structure of fpga manager ops
>> + * @priv:	fpga manager private data
>> + *
>> + * Return:  fpga manager pointer on success, negative error code otherwise.
>> + *
>> + * This is the devres variant of fpga_mgr_register() for which the
>> + * unregister function will be called automatically when the managing
>> + * device is detached.
>> + */
>> +#define devm_fpga_mgr_register(parent, name, mops, priv) \
>> +	__devm_fpga_mgr_register(parent, name, mops, priv, THIS_MODULE)
>> +
>>  struct fpga_manager *
>> -devm_fpga_mgr_register(struct device *parent, const char *name,
>> -		       const struct fpga_manager_ops *mops, void *priv);
>> +__devm_fpga_mgr_register(struct device *parent, const char *name,
>> +			 const struct fpga_manager_ops *mops, void *priv,
>> +			 struct module *owner);
>>  
>>  #endif /*_LINUX_FPGA_MGR_H */
>> -- 
>> 2.43.0
>>
>>
> 


