Return-Path: <linux-kernel+bounces-58483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEB884E706
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCE151C2682E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6FB86145;
	Thu,  8 Feb 2024 17:46:11 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE67786124;
	Thu,  8 Feb 2024 17:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707414371; cv=none; b=KlGWABkOq4lE2oSX+PLeXgfj5MosQdErITssC9/zLZAxbDMQvaJMZv+ebVIUo0UXI7wUdU3nw2OWkGF2uh4nJSKIlJNy1gehk2PfvFHCUmj/dexjhAXd0lmHSMklE9yQxth72w6uyYoYexqGgZm/fbI88eRznXrMrBrzXLMZ/QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707414371; c=relaxed/simple;
	bh=KaV20q0GQfGnGgavViyz5KXHwueNCiLVGhY7BqMMw18=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eeWf1FbkJj6mmlRROpKughQtIEHxJShf6MPQUP/9oYPCzeuBKbJ2SFHNIo3dz1qxoeecJmFd7ZXm2kfFSpqU13ANIDQ9V7N8y0UomuEDDIw/qBw7R9WpeeK1+//3Ul0ZptG4oqHPZ3lTm/iVXN71z30YuZ5uWc0/ParHN9bHuXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e071953676so58776b3a.2;
        Thu, 08 Feb 2024 09:46:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707414369; x=1708019169;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tKfd7lmWIbfcamrHQWTBL8dnYP6EtyRFZjlbeDKgg2E=;
        b=D/u2En/7VGG18JgEx6/K1bTJpOLXZQTuoi3Db3q2WN8p4DSPSTFeVLVWLF0NP9cfC6
         HftiVg8VHXtjQFeko78gLWRBRvxOre20efyjifuWM7eqDxNw3LI+fD3Os6ahXnvt2QR0
         xqBVlsOBEbacblQj2pFd2BzjZR2cTkDIgVpEY3dY4RRXZriloWnLMsT+dUyOVfPbxZOx
         rvERYE+q/pJHbtNqUPSiKz1cXW5ox4dEheS27scmn2zOAqXM5u3H7/M49E8AfAjq1h/R
         4bIsUnz8vv5GxuHouLMDlEEF3wK4NC3oRtTeDHwjK4mC9QqZauGQlNoPqIwEAWON3bAl
         2msA==
X-Gm-Message-State: AOJu0Yz3B6aX4iqXnCoqn6QJ+eCz7DQcMb/tD8ILQ8H4+bGkgtceYz6j
	dhAlogssvjliN7Wi66hyHFiiC7uHusU0jLj5HrnbKcCg2p9WaL5oj7oFtBM7
X-Google-Smtp-Source: AGHT+IFVXx5yprIFcXZZD+ButXoyZPkAGls4X6oQz0IhSiK88IfZJ0OdctI53Zra3OMb1YxpO2j1Ag==
X-Received: by 2002:aa7:8745:0:b0:6e0:7308:7325 with SMTP id g5-20020aa78745000000b006e073087325mr3041016pfo.1.1707414368915;
        Thu, 08 Feb 2024 09:46:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWiuVCKqUeskch1J4BBFbTjt+/A6f91D69wHp0wQEmpUQK1Jglrx6TUKHvJlM3AL20Bs6pd6Cbc32x1vVoMC7cWPDro0Fe+1Ege1XPRm0uY2WsFa9eYGAs2AvNGRqjdCoRbPgmco9StnyXAfV9fEg+4upNpFtubxuSwSt2aS45pDxbHRvnPH/vEVugf6QrP2mTkLpFdv8IdIfQJdXhPvnXAQFLpyhFhwZzureT0XU6wTIIZUeBLSjrMxMYAJx0nE7ZWyNBfDVZtrgC0A2aBoge4CumVLRmuHyy3HF5UpiLPtTd3FTdZsFMt/QOH/LC+aeaUlTW9rta4skTOoWq9ENLyfuGNkhR2KGEI5QrSHI21VkgZBFJBRbbT
Received: from ?IPV6:2620:0:1000:8411:6ab9:a725:60e:97d2? ([2620:0:1000:8411:6ab9:a725:60e:97d2])
        by smtp.gmail.com with ESMTPSA id lp20-20020a056a003d5400b006e04c3b3b58sm4191879pfb.179.2024.02.08.09.46.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 09:46:08 -0800 (PST)
Message-ID: <5f934ebf-4e2a-44f9-993f-8b2c8d358370@acm.org>
Date: Thu, 8 Feb 2024 09:46:06 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] block: introducing a bias over deadline's fifo_time
Content-Language: en-US
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Jens Axboe
 <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Yu Zhao <yuzhao@google.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zhaoyang Huang <huangzhaoyang@gmail.com>, steve.kang@unisoc.com
References: <20240208093136.178797-1-zhaoyang.huang@unisoc.com>
 <20240208093136.178797-3-zhaoyang.huang@unisoc.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240208093136.178797-3-zhaoyang.huang@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/8/24 01:31, zhaoyang.huang wrote:
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index f958e79277b8..43c08c3d6f18 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -15,6 +15,7 @@
>   #include <linux/compiler.h>
>   #include <linux/rbtree.h>
>   #include <linux/sbitmap.h>
> +#include "../kernel/sched/sched.h"

Is kernel/sched/sched.h perhaps a private scheduler kernel header file? Shouldn't
block layer code only include public scheduler header files?

> @@ -840,7 +842,9 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>   		/*
>   		 * set expire time and add to fifo list
>   		 */
> -		rq->fifo_time = jiffies + dd->fifo_expire[data_dir];
> +		fifo_expire = task_is_realtime(current) ? dd->fifo_expire[data_dir] :
> +			CFS_PROPORTION(current, dd->fifo_expire[data_dir]);
> +		rq->fifo_time = jiffies + fifo_expire;
>   		insert_before = &per_prio->fifo_list[data_dir];
>   #ifdef CONFIG_BLK_DEV_ZONED
>   		/*

Making the mq-deadline request expiry time dependent on the task priority seems wrong
to me.

Thanks,

Bart.

