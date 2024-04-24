Return-Path: <linux-kernel+bounces-157170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF9B8B0DB0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B63D2842CE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A7A15F303;
	Wed, 24 Apr 2024 15:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+E6PW81"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FDB15EFBE
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713971551; cv=none; b=bL+Vgda1TruGjQVJMqj7PiVFfwr1ZiM/dcR3ajDP4lTYKsmehZ40E1SfSE6Mhdpvt5FlvGy02LzGs6X1rlBucDG4ADxuTxWTNXF6lk9Rm5j5o5c2ZlG/jy8n6NZXCs5DpTXS9woeNV5rvEDN/kbDvuoddclEaAoIM/X4XNlzXjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713971551; c=relaxed/simple;
	bh=feFwexyOuic9x9L8pXQlAHDvOmXQjg5z0fAbUbayHNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RacnZ8iVH62xmRDHYeUnlc/co8e/SdYCsvsNYhZ9c6pEpr2/r4B/WC3Mjp6UtWrPaRWZZWTEwGpOLwJi1sNd/V8OYra5K3GSQzFbLkKrmm05GDliNOmMl0cV9ENKgrd5nsnHd5VRhnKEndT+kqLpr5XpE84fVXOz6aU3TjXlI3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+E6PW81; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e834159f40so52555855ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 08:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713971549; x=1714576349; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=imX+ZY14VNnmpiHyfWpv6CcGv1TFVoBe2VybTuilCA4=;
        b=Y+E6PW81ARgM99AF6edWLPQe0VpkWvR5/FWSqWZtaigJSsxh17B6Xv3wpysovI9Qgi
         YNClzEsN8RH3NLRlLBhxf+vDDxX/v6vnRkzonqXAEMe6Iy35IyYZU7msoNoA5DLD72Nx
         1t5hX9Iv4ftoCvgunD7YEu9kXdklvakdCYqNGwGjC6Oj6wrUWw/4fj60vXru4ZyRqyup
         xX48coXQj8lmbCter+dT0ulLeQK2WAOejY+NvhnnUt0JLyCktiq93MjlxHSc9cfSIe/0
         2Yg8ImIdTipxZLgqZwi7nMVgSSBKYvWhT0ol4vWa9hCFv8emn8BxiKpJAqSfAUW1yEIE
         cSVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713971549; x=1714576349;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=imX+ZY14VNnmpiHyfWpv6CcGv1TFVoBe2VybTuilCA4=;
        b=i35YHbAKBLtECrADkenf/OGHnU9Qt5IX97pSyn/+w+5FlwcX0WYqBOunydfNlu76d+
         5XUOUUpK1fDOYM0XF2KS93txyKaLt/J2Cvgoj3tRREUhIRJGvBrDkfJfZvEQTxTzxDHq
         U2DhP+KkkJHor+rFvmLGmceQmddb45rUfYfuCCSXJt13K+3MH+TbTvHT1gTWlRqhXDCf
         eg02aImv0tOQsDHa+zZPOAXkdK+YsWcYTemIXgHUMOAUixUXwRkR/JJr4nq7NRrVzGA1
         06Kd10/165+3BuZTH5zpxWUtyIpm4CV2l9ca29vm7kMcac2EWswZ2/aY//rRLkxcJjkA
         +caw==
X-Forwarded-Encrypted: i=1; AJvYcCX4Hd0lA+75MOIQiu4FK9hP88jrl3K4R3yGyrCJ/vYytWYguNWN+2mpDcLSgFXiyZZXWfyrc62Oe7iVY/hokQKa7XjQeETovSX6antj
X-Gm-Message-State: AOJu0Yw4XgDEuYPl9uEvHoBW4qY+xmfhrCKdkgmjXICQ5DK4fI33Td+R
	7z0Uhfl2ny1LMUlKoOxRXGf5HFy+nv/xcCQpAAsppof2qyXazff1
X-Google-Smtp-Source: AGHT+IE7zNplXXnPMp34c+xQ6v930U7Qj7v6GTxIMjkB+1HpqJ67+GoUkrCef3O1FxUCeESy8zGedQ==
X-Received: by 2002:a17:902:ecd0:b0:1e8:5c57:ebb with SMTP id a16-20020a170902ecd000b001e85c570ebbmr3214164plh.34.1713971549265;
        Wed, 24 Apr 2024 08:12:29 -0700 (PDT)
Received: from [0.0.0.0] (74.211.104.32.16clouds.com. [74.211.104.32])
        by smtp.gmail.com with ESMTPSA id j14-20020a170903024e00b001e4753f7715sm12036444plh.12.2024.04.24.08.12.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 08:12:28 -0700 (PDT)
Message-ID: <96888d51-1abb-4a96-ba6d-f84dd1f7245e@gmail.com>
Date: Wed, 24 Apr 2024 23:12:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] workqueue: Fix rescuer task's name truncated
To: Aaron Tomlin <atomlin@atomlin.com>, Wenchao Hao <haowenchao2@huawei.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 linux-kernel@vger.kernel.org, neelx@redhat.com
References: <20240423182104.1812150-1-haowenchao2@huawei.com>
 <00b43845-c990-481f-be0a-4bf15ada8b3c@huawei.com>
 <5s3id43tqtwywggry7zmefl3jsaim3oxgofuhkeq3kmadtxpoz@srrrlrf5si5n>
Content-Language: en-US
From: Wenchao Hao <haowenchao22@gmail.com>
In-Reply-To: <5s3id43tqtwywggry7zmefl3jsaim3oxgofuhkeq3kmadtxpoz@srrrlrf5si5n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/24/24 3:12 PM, Aaron Tomlin wrote:
> On Tue, Apr 23, 2024 at 12:55:22PM +0800, Wenchao Hao wrote:
>> Hi Tejun and all:
>>
>> I added another logic in wq_worker_comm() to append worker's desc when
>> worker is not attached to a work pool. I don't know why the origin
>> logic only append worker's desc when worker is attached to a work pool,
>> so I am not sure if it's safe to using worker here directly.
> 
> Hi Wenchao,
> 
> A worker description is always updated under the per-pool workqueue lock.
> You can indeed use the rescuer's own description to store its associated
> workqueue name - good idea. We know the caller of set_worker_desc() will
> never touch a rescuer. For this unique rescuer case, if I understand
> correctly, you can read a rescuer's description outside the per-pool
> workqueue lock; albeit, you need to prevent a race with destroy_workqueue()
> to avoid a use-after-free.
> 

Hi Aaron, thanks a lot for your reply.

I think destroy_workqueue() may not race with wq_worker_comm(),
wq_pool_attach_mutex is used to avoid race, below is my analysis.
(Welcome to point out if my understand is incorrect)

t1 which call destroy_workqueue()     rescuer->task

destroy_workqueue()
  kthread_stop(rescuer->task)
                                      rescuer_thread()
	                                if (should_stop) {
	                                  __set_current_state(TASK_RUNNING);
	                                  set_pf_worker(false);
                                            mutex_lock(&wq_pool_attach_mutex);
				            current->flags &= ~PF_WQ_WORKER;
				            mutex_unlock(&wq_pool_attach_mutex);
	                                  return 0;
	                                }

  kfree(rescuer)

wq_worker_comm() would acquire wq_pool_attach_mutex then check if task->flags
is set PF_WQ_WORKER.
If PF_WQ_WORKER is not set, wq_worker_comm() would not access this task's worker
any more;
If PF_WQ_WORKER is set, the wq_pool_attach_mutex is held durning access of task's
worker.

What confuse me mostly is why the origin logic only append worker's desc when
worker is attached to a work pool.

Thinks.

> 
> Kind regards,
> 


