Return-Path: <linux-kernel+bounces-2145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 914E781588B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 10:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F37271F25AB7
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 09:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8148514A88;
	Sat, 16 Dec 2023 09:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="frNCyLLX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3482213AEC
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 09:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702719364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1u1eZK6X0Kf6i0TKoHEuX4Vw1Du5K4BWpxy01bvPuRg=;
	b=frNCyLLXGo1IFRz68mza+r/kDzYF/zByQtEBttFYP4zu8g93fGzJX16d2wwndBWegZqrWn
	JEQHwjE59RTkek1lXUep9WuL8XSiI5aQHpW96QLHZ7voAOVey26PPFMC5WpydGmkpOTijD
	Hk8Fw+ZZDoD9wCkLmqjr6WlfDSiNpdI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-GebXdVhTNiK3Xi0wEIhc4w-1; Sat, 16 Dec 2023 04:36:02 -0500
X-MC-Unique: GebXdVhTNiK3Xi0wEIhc4w-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a230f53a8d3so258451766b.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 01:36:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702719361; x=1703324161;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1u1eZK6X0Kf6i0TKoHEuX4Vw1Du5K4BWpxy01bvPuRg=;
        b=AHkjgCmYAmSUHk3LjJ81r13XTzDMxLmQk+iotp9mHcv85Y8Kd80U93Qmd/YFQSlijy
         BVErMGHw+z+M2fqpjNwsODgupyePgOsrNChqKwIYpn7rgnS/Yb6wQvpeFjCGM61P9AzF
         OxHLhU+rRjeqPaEFleNP2RFB2Gxb6Dz8xVvdOOtmBRJkdgBKDvbwSD9LMGy3gJm5hS1q
         lzmnrm7OAVjWcrcGOYE0dsIevvfiYa7jJ8ywTLsEm952gAk3niAf7nFMOLD2tvI8xQLn
         yd3V1pV1fr/Y5toxKG0+odTo6iNVFwvnoq9nTgHwzX3wWOLrkCSkN6tI+xOn3uhC+TOk
         8hrA==
X-Gm-Message-State: AOJu0YwjxxIwqpzg2zQV1kehdzAHSXqwp6tquAE+fW6Xm+sy8eT6R9gH
	m4NT57ePkipJzzI57b7dNfVdcDI4yJX9X4SCOeBFrOGtjItVzPWCNVaxLAJctOdiL+qfEoR9tv+
	NowX2FryiDagcVwFjkcVX/QzawASwZCU=
X-Received: by 2002:a17:907:8d8:b0:a1c:7c86:8b79 with SMTP id zu24-20020a17090708d800b00a1c7c868b79mr11289566ejb.26.1702719360798;
        Sat, 16 Dec 2023 01:36:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGBrb/VroY85tW8R/NWxsz628VO4OMmV4LWaggnkSgLfmGc7KI0fjM3zH6tJjzHu20yQGBuug==
X-Received: by 2002:a17:907:8d8:b0:a1c:7c86:8b79 with SMTP id zu24-20020a17090708d800b00a1c7c868b79mr11289558ejb.26.1702719360435;
        Sat, 16 Dec 2023 01:36:00 -0800 (PST)
Received: from [192.168.9.34] (net-2-34-31-72.cust.vodafonedsl.it. [2.34.31.72])
        by smtp.gmail.com with ESMTPSA id bn2-20020a170906c0c200b00a23152a543dsm2196717ejb.202.2023.12.16.01.35.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Dec 2023 01:35:59 -0800 (PST)
Message-ID: <bd9b5122-788c-42dd-bbd4-c5a8323adfde@redhat.com>
Date: Sat, 16 Dec 2023 10:35:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/2] fpga: add a module owner field to fpga_manager
 and fpga_manager_ops
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
References: <20231124162807.238724-1-marpagan@redhat.com>
 <20231124162807.238724-2-marpagan@redhat.com>
 <ZWG6Tg0egX6Cy9j5@yilunxu-OptiPlex-7050>
 <7004d215-5185-4cce-a51e-42e131a30453@redhat.com>
 <ZWsgFViqdJuC7N1d@yilunxu-OptiPlex-7050>
 <5a8819ad-3551-475e-a645-1a300d3373f1@redhat.com>
 <ZXSHVguFadvfaUcO@yilunxu-OptiPlex-7050>
Content-Language: en-US
From: Marco Pagani <marpagan@redhat.com>
In-Reply-To: <ZXSHVguFadvfaUcO@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2023-12-09 16:27, Xu Yilun wrote:
>>>>> I feel the scope of the protection is unclear to me in this patch. What
>>>>> data should be protected from concurrent access by this mutex? From the
>>>>> code seems the racing of mgr dev should be protected but apparently it
>>>>> doesn't have to.
>>>>
>>>> The mutex is there to ensure the lifetime of the manager device and
>>>> its context (struct fpga_manager) if fpga_mgr_get() happens to run
>>>> concurrently with the removal of the low-level module.
>>>>
>>>>>
>>>>> And with this mutex, the get/put/unregister() for one mgr should be
>>>>> exclusive with another mgr, but that also seems not necessary.
>>>>>
>>>>
>>>> I decided to use a static mutex because I thought putting the mutex
>>>> in the manager's context would be unsafe since its life would be tied
>>>> to the manager's life. For instance, consider the following sequence:
>>>>
>>>> - A removes the low-level control module, and delete_module progresses
>>>> up to the point when it calls the module's exit function, which in turn
>>>> calls fpga_mgr_unregister().
>>>>
>>>> - fpga_mgr_unregister() takes the mutex but gets descheduled before
>>>> completing the unregistering of the manager device.
>>>>
>>>> - Meanwhile, B wants to get the manager (it is still there) and calls
>>>> fpga_mgr_get(), which tries to take the mutex but gets suspended since
>>>> it is held by A.
>>>>
>>>> - A resumes and fpga_mgr_unregister() releases the manager device and
>>>
>>> The lifecycle of the manager device is not entirely decided by
>>> fpga_mgr_unregister(), this func just puts/decreases the device
>>> refcount.
>>
>> Right, but here I'm considering the case where no one has previously
>> taken the manager device. In that specific case, the refcount will be
> 
> I don't think this is valid, anyone should firstly get the manager
> device via get_device() then try to access its context.
> 
>> decremented to zero, and the device (with its context) will be released.
> 
> If no one has taken the manager device, the device & its context are
> safe to be released.
> 
>>
>> However, you got me thinking about how the mutex is causing the problem
>> in this case.
>>
>>>
>>> Remember fpga_mgr_get() gets the device via
>>> class_find_device()->get_device(). I assume if the valid device pointer
>>> could be returned by class_find_device(), it would never be released by
>>> other nice players. So I have no worry about the per manager mutex.
>>>
>>>> its context, including the mutex on which B is suspended.
>>>>
>>>> We could mitigate this specific case using mutex_trylock(). However,
>>>> there will still be other problematic cases, like if fpga_mgr_get()
>>>> gets suspended right before taking the mutex and then delete_module
>>>> proceeds up to when fpga_mgr_unregister() frees the manager device
>>>> and its context.
>>>>
>>>>> I think the mgr->owner & mgr->ops should be protected from concurrent
>>>>> access of delete_module & fpga_mgr_get/put(), so how about:
>>>>>
>>>>> struct fpga_manager_ops {
>>>>> 	struct module *owner;
>>>>> 	...
>>>>> };
>>>>>
>>>>> struct fpga_manager {
>>>>> 	...
>>>>> 	struct mutex mops_lock;
>>>>> 	const struct fpga_manager_ops *mops;
>>>>> 	...
>>>>> };
>>>>>
>>>>>
>>>>> static struct fpga_manager *__fpga_mgr_get(struct device *dev)
>>>>> {
>>>>> 	struct fpga_manager *mgr;
>>>>>
>>>>> 	mgr = to_fpga_manager(dev);
>>>>>
>>>>> 	mutex_lock(&mgr->mops_lock);
>>>>>
>>>>> 	if (!mgr->mops || !try_module_get(mgr->mops->owner))
>>>>> 		mgr = ERR_PTR(-ENODEV);
>>>>>
>>>>> 	mutex_unlock(&mgr->mops_lock);
>>>>> 		
>>>>> 	return mgr;
>>>>> }
>>>>>
>>>>> void fpga_mgr_unregister(struct fpga_manager *mgr)
>>>>> {
>>>>> 	fpga_mgr_fpga_remove(mgr);	
>>>>>
>>>>> 	mutex_lock(&mgr->ops_lock);
>>>>> 	mgr->mops = NULL;
>>>>> 	mutex_unlock(&mgr->ops_lock);
>>>>>
>>>>> 	device_unregister(&mgr->dev);	
>>>>> }
>>>>>
>>>>> Not actually tested.
>>>>>
>>>>
>>>> I think protecting the only the ops is not enough for the same reasons.
>>>> If fpga_mgr_get() gets suspended right after class_find_device(),and
>>>> meanwhile the low-level module is removed, it resumes with a reference
>>>> to a manager device that no longer exists.
>>>>
>>>> In a certain sense, however, using a mutex seems like a mitigation
>>>> that does not solve the problem at its root. I honestly still think
>>>> that taking the module's refcount right when registering the manager
>>>> is the only way that is both safe and robust against code changes.
>>>
>>> I would nak either. As mentioned above, that makes rmmod vendor module
>>> impossible. Introducing another user interface to release the module's
>>> refcount is also a bad idea. Who decides to take the ref, who releases
>>> it. A user has no knowledge of what is happening inside and should not
>>> enforce.
>>>
>>>> However, my proposal was rejected.
>>>>
>>>> So, if you prefer, I can drop the mutex entirely in the next version,
>>>> and we leave the responsibility of keeping all kernel pieces to the
>>>
>>> No, please try to fix it. Could you please reconsider my proposal?
>>>
>>
>> I have considered it and thought about it. However, I don't think we need a
>> mutex to protect mgr->mops. This is because the low-level module's refcount has
>> already been decremented when fpga_mgr_unregister() is called by the module's
>> exit function. So, when we get to the point of executing fpga_mgr_unregister(),
>> any concurrent call to try_module_get() will fail (if no one has taken the
> 
> Are you still taking care of your previous finding [1]? It says:
> 
>   To be clear, you should only use try_module_get() *iff* you are 100% sure
>   the module already does exist ...
> 
> IIUC, if you do nothing on fpga_mgr_unregister(), the low-level module may
> just disappear and any copy of the owner pointer became invalid. Then
> try_module_get() would not fail but panic.
> 
> [1] 557aafac1153 ("kernel/module: add documentation for try_module_get()")
> 

You are right. I'll follow your proposal for locking. I would have preferred a
solution that kept the module locked until it was safe to remove it, but I
cannot come up with anything reasonable at the moment.

> 
>> module before) without the need to check mops first.
>>
>> If we assume (as you pointed out) that class_find_device() can be safely
>> executed concurrently with device_unregister() (returning either a valid dev
>> pointer or null) and, consequently, the manager context is guaranteed to exist
>> after that point. Then, we should be good without the mutex if we call
>> try_module_get() on a copy of the owner pointer stored in the manager context.
>>
>>>> user. It will still be an improvement over taking the low-level
>>>> module's refcount through the parent device's driver pointer.
>>>>


Thanks,
Marco


