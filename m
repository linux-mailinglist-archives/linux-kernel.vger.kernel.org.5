Return-Path: <linux-kernel+bounces-13559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F32682080F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 18:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 297431F22CC5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 17:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB1FBA57;
	Sat, 30 Dec 2023 17:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="OOcFk8Jl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227B9BA31
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 17:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d3b84173feso15734995ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 09:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1703958095; x=1704562895; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y34Zd+Se6X3E/Vet+AZz0G3CVTbacRhGw9N0cZoQO6c=;
        b=OOcFk8Jl4AzGJevah/snXDpHp3G/c6Jn42vVqzpzMaVrKU06qp4R18ItahPAKWwFaz
         qHbDXJOGWwgDXT4BUc/+dG5OictyD1bK5+DLtKvBLYSfJ43NgSYK9oSblE5LriRazKuX
         vW5UcaWkKNOEJ50KMjzARB+8mJmbMelVdVf9XNVmpQRCmt/o1ECOOP/BDl9zNW5L4J15
         NLvS8l4R39L6WBrIvoiVG4VGGeZ0z+36SSprv2xi3N9/tSf6Lf7yE559+Je0K3k8gxo3
         VS9fkLh+ra7bHnnEl15JR8Vsw9UjW3mWFpzkg17SXSUU+3uYANQnvydLUllUtOVoSs2J
         2P5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703958095; x=1704562895;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y34Zd+Se6X3E/Vet+AZz0G3CVTbacRhGw9N0cZoQO6c=;
        b=ogQSnTRARN1/NPNWjPJp6onxCyEGKIQwPyQvEH/FSpoKXClO8zywZjJnuQIRe2K3mV
         L4pzXyWsxuwZl5yABblsSa9Du1fBS005b3sSmEDJHaf9oMrcHeAlmmZsYJC341qygIci
         2ZGshdqRdWG8fyZiS7KoFj+YGX6aImF2fVpNaJGhg0UVv/0MhWtu7V14ItEegT8hwZzT
         SkBkBAbpQOhqt3c++mqJgQGHqSNuMi0S9D/Y0nquoA+RfeyM5iRrQTCXYHHlr1el6rN6
         AK5XoCKf48E9golr9SrlZpuoY6qUDIxdhSeaJLKMqZDmRxmZzfg3WKz2fxG4xC0HWoPt
         C0QQ==
X-Gm-Message-State: AOJu0YzUpv3VBZqk7ogX3kjBFI6kBRhGV8SJA5XJU1L+y1jeqNim9V6x
	GQqbJV2ITu9xActa9n8kpe/GO3E1mPMV+w==
X-Google-Smtp-Source: AGHT+IF0LrqayIADx35y34JnTk71imJfXkyXjc0gTdw+9eqnw0DLtUh8HZDdApgWeNeaBv6v062Lrw==
X-Received: by 2002:a17:903:41cd:b0:1d3:cf95:fd4b with SMTP id u13-20020a17090341cd00b001d3cf95fd4bmr28630621ple.6.1703958095396;
        Sat, 30 Dec 2023 09:41:35 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id n10-20020a1709026a8a00b001ab39cd875csm17554544plk.133.2023.12.30.09.41.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Dec 2023 09:41:34 -0800 (PST)
Message-ID: <57b81a15-58ae-46c1-a1af-9117457a31c7@kernel.dk>
Date: Sat, 30 Dec 2023 10:41:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] io_uring: Statistics of the true utilization of sq
 threads.
Content-Language: en-US
To: Pavel Begunkov <asml.silence@gmail.com>,
 Xiaobing Li <xiaobing.li@samsung.com>
Cc: linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
 kun.dou@samsung.com, peiwei.li@samsung.com, joshi.k@samsung.com,
 kundan.kumar@samsung.com, wenwen.chen@samsung.com, ruyi.zhang@samsung.com,
 cliang01.li@samsung.com, xue01.he@samsung.com
References: <CGME20231225055252epcas5p43ae8016d329b160f688def7b4f9d4ddb@epcas5p4.samsung.com>
 <20231225054438.44581-1-xiaobing.li@samsung.com>
 <170360833542.1229482.7687326255574388809.b4-ty@kernel.dk>
 <7967c7a9-3d17-44de-a170-2b5354460126@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <7967c7a9-3d17-44de-a170-2b5354460126@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/30/23 9:27 AM, Pavel Begunkov wrote:
> On 12/26/23 16:32, Jens Axboe wrote:
>>
>> On Mon, 25 Dec 2023 13:44:38 +0800, Xiaobing Li wrote:
>>> Count the running time and actual IO processing time of the sqpoll
>>> thread, and output the statistical data to fdinfo.
>>>
>>> Variable description:
>>> "work_time" in the code represents the sum of the jiffies of the sq
>>> thread actually processing IO, that is, how many milliseconds it
>>> actually takes to process IO. "total_time" represents the total time
>>> that the sq thread has elapsed from the beginning of the loop to the
>>> current time point, that is, how many milliseconds it has spent in
>>> total.
>>>
>>> [...]
>>
>> Applied, thanks!
>>
>> [1/1] io_uring: Statistics of the true utilization of sq threads.
>>        commit: 9f7e5872eca81d7341e3ec222ebdc202ff536655
> 
> I don't believe the patch is near complete, there are still
> pending question that the author ignored (see replies to
> prev revisions).

We can drop and defer, that's not an issue. It's still sitting top of
branch.

Can you elaborate on the pending questions?

> Why it uses jiffies instead of some task run time?
> Consequently, why it's fine to account irq time and other
> preemption? (hint, it's not)

Yeah that's a good point, might be better to use task run time. Jiffies
is also an annoying metric to expose, as you'd need to then get the tick
rate as well. Though I suspect the ratio is the interesting bit here.

> Why it can't be done with userspace and/or bpf? Why
> can't it be estimated by checking and tracking
> IORING_SQ_NEED_WAKEUP in userspace?

Asking people to integrate bpf for this is a bit silly imho. Tracking
NEED_WAKEUP is also quite cumbersome and would most likely be higher
overhead as well.

> What's the use case in particular? Considering that
> one of the previous revisions was uapi-less, something
> is really fishy here. Again, it's a procfs file nobody
> but a few would want to parse to use the feature.

I brought this up earlier too, fdinfo is not a great API. For anything,
really.

> Why it just keeps aggregating stats for the whole
> life time of the ring? If the workload changes,
> that would either totally screw the stats or would make
> it too inert to be useful. That's especially relevant
> for long running (days) processes. There should be a
> way to reset it so it starts counting anew.

I don't see a problem there with the current revision, as the app can
just remember the previous two numbers and do the appropriate math
"since last time".

> I say the patch has to be removed until all that is
> figured, but otherwise I'll just leave a NACK for
> history.

That's fine, I can drop it for now and we can get the rest addressed.

-- 
Jens Axboe


