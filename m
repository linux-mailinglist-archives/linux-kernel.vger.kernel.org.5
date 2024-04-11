Return-Path: <linux-kernel+bounces-139633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D93178A0595
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 169471C218AF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EA3612D3;
	Thu, 11 Apr 2024 01:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akFyMqra"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E4623BF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 01:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712799148; cv=none; b=WZ8kthi3vN1/OBJ+qMXaK7Nr0Yh4czvTUL8PAjx4yDWkGpUHEh8RRlMkP0f9dUnah6kJ2hj4wGzgJdtjQeLuv86gVJjAESG01dHnPlAe+grh8jVwtEcsJppE+6+vjWi9CepRVA4PCo4t+OZAnBtBURKvME2oScF6mTIg6mLy6XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712799148; c=relaxed/simple;
	bh=5DPBE7RYbKtilL/ZI+6FVsgCfOtY6Muwg0RGSybQTik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H09Pl4m7i5jY/4Za9WhQhA93WcsKvT/LZJrLQCVYd88ADN9r8ZXh6J10KzlMbF75/V2orLXmpgbVoR1mghVTV8ofEcKnxUKo4/s78v07s+6llnMLnGQdsceuUJ2c+/oan2WvhnA5WoEkSFYdYcVFf39eettwmCjGb8L0L2eoJ50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akFyMqra; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e45b9a5c53so26610795ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 18:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712799146; x=1713403946; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XALMnSYERqk5Qp+Vxu9i+C04EFsVndeTtc8pDuDdexc=;
        b=akFyMqraYO3Ct5INFRKmfiaGxG0GCvN7EjvK2n49LPajM8a7wFGKqBLhApXfpdyaKE
         tKbsxjWTOcXaP/VR3HKI/Uzcpj/kZxr70AQ3sayp7InpxU+2P9Y63eiNzUautNgoVEfR
         J7Px4gx3z5XnUcKnmzmrirg98ILacHcsMT1CVcJ/cDN9dl/eeX3eWSW0ulNjXAPCHPT2
         D3G3lz7oUow1q6Ou91jHxqZPevOllnph/HIs4a9Tv5+KWK3AUKVhFYCYiAutOwzptIh3
         8FhWek68vfK4lXv/DETQPBstdLoPA/JWz8QXleWXR17+vbSZolZ+gUbBAgmcKJyzh9Sv
         eYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712799146; x=1713403946;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XALMnSYERqk5Qp+Vxu9i+C04EFsVndeTtc8pDuDdexc=;
        b=m4WWTzupVfl7XcveQC/zUirDKT9dGQ4aRVpc34KzdOE6G1MUCd5gJF1awN6HpHFdE0
         s1KZIcXDaSMakGD3jeZ6USMbxEx9Jq3jlu0f/uI5SIbSVIkxBPCshwctTvd0bCxsa6ZP
         D/WDdSyeKqStsAmLQRm61d5b+0xbVZPSvqpJj84+H20SEHBlaomRV81o/b46YNsUkc+D
         pAjpc2gX8mH3aqshSxNMqMWdT+8f25ktMHuhR3WXvObCjOl0icr7EoUqHCpHXkaZbzIT
         rncR/fKJHD6f1EN+xZMS7hTEqrAGuu1Wo3IcaXGUsRhnU8fCb8nBWYWrjmdub3oxr2EC
         EhGw==
X-Forwarded-Encrypted: i=1; AJvYcCVh+nfS/fblbwtuoxLN9U9cBtUW/i/t7pbsG6iyI/EAVAVl7dezaA/xnaen0S4mhUFS0am4RynzLBjnHaClN1fP7NZwEVfpoU/xqn1b
X-Gm-Message-State: AOJu0YwN1c2xwOPNDlB1Ju3DGSGRY16cXhNMNfhEGk1MahlK8pNsvCqG
	ChdQYAXF5cChYD1j6QSz1dZ4fbFwy24CjhBURu4QCfb5sV9pdEHr
X-Google-Smtp-Source: AGHT+IEriYoxMyqdczM5NvWr5yOCOLNQ6F3Xkle39Na41Trp48ZnSPW7SPW+SwXGQvGnTmlYaldYgw==
X-Received: by 2002:a17:902:db0e:b0:1e4:a667:5528 with SMTP id m14-20020a170902db0e00b001e4a6675528mr6145703plx.3.1712799146000;
        Wed, 10 Apr 2024 18:32:26 -0700 (PDT)
Received: from ?IPV6:2001:b011:3809:b723:8171:9ef4:f43d:8f31? (2001-b011-3809-b723-8171-9ef4-f43d-8f31.dynamic-ip6.hinet.net. [2001:b011:3809:b723:8171:9ef4:f43d:8f31])
        by smtp.gmail.com with ESMTPSA id f5-20020a17090274c500b001e0e8e4f7e3sm188935plt.206.2024.04.10.18.32.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 18:32:25 -0700 (PDT)
Message-ID: <c3611c0a-007f-4e09-b92d-3752438e653e@gmail.com>
Date: Thu, 11 Apr 2024 09:32:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH 08/10] sched/fair: Implement delayed dequeue
To: Peter Zijlstra <peterz@infradead.org>, Chen Yu <yu.c.chen@intel.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
 linux-kernel@vger.kernel.org, kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com, tglx@linutronix.de, efault@gmx.de,
 yu.chen.surf@gmail.com
References: <20240405102754.435410987@infradead.org>
 <20240405110010.631664251@infradead.org> <ZhEUjX1Nw0y2eJ1o@chenyu5-mobl2>
 <20240408090639.GD21904@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Yan-Jie Wang <yanjiewtw@gmail.com>
In-Reply-To: <20240408090639.GD21904@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> 
>> The 99th wakeup latency increases a little bit, and should be in the acceptible
>> range(25 -> 31 us).
> 
> Ah, my test runs haven't been stable enough to observe that.
> 
>> Meanwhile the throughput increases accordingly. Here are
>> the possible reason I can think of:
>>
>> 1. wakeup latency: The time to find an eligible entity in the tree
>>     during wakeup might take longer - if there are more delayed-dequeue
>>     tasks in the tree.
> 
> Another possible cause might be that previously a schedule() would be
> 1 dequeue, 1 pick.
> 
> But now it can be much more variable, a pick can basically do N dequeues
> and N+1 picks.
> 
> So not only do we do more picks, but if you're focussed on worst case
> latency, it goes up, because we can do multiple dequeues for a single
> pick.
> 
> If we find this to really be a problem, I had some half baked ideas to
> fix it, but it added significant complexity, so keep it simple until
> need proves we need more etc.

I have an alternative approach to delayed-dequeue inspired by the 
original CFS implementation.

The idea is to keep the task's vruntime when it goes to sleep.
When the task is woken up, see if the lag is positive at the woken time, 
if it is the case, clamp it to 0 by setting vruntime to avg_vruntime().


<Sleep>

In dequeue_entity(): Remove the task from runqueue, but keep the task's 
vruntime, and do not calculate vlag at this time.


<Wake Up on the same CPU>

In enqueue_entity():
  1. Do not call place_entity().
  2. If the task's vruntume is less than the cfs_rq's avg_vruntime(), 
set the task's vruntime to avg_vruntime(), and update the task's 
deadline according to its timeslice.
  3. Insert the task into the runqueue.


<Wake Up on different CPU>

In migrate_task_rq_fair():
  1. Calculate the task's vlag as if it is on the original cfs_rq.
  2. Set the task's vlag to 0 if it is positive.

In enqueue_entity(): Use place_entity() to calculate the task's new 
vruntime and deadline according to the vlag and the new runqueue before 
inserting it into the runqueue.


