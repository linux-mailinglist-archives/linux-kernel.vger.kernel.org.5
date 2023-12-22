Return-Path: <linux-kernel+bounces-9782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0752E81CB5C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B82E4284795
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 14:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FDD200BF;
	Fri, 22 Dec 2023 14:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="iDkam2ew"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB581A591
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 14:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d03f03cda9so4860445ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 06:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1703255479; x=1703860279; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hCMljXl64bVf1xnNOYFSwE5VnW4uhjdgxZFrLklQSVY=;
        b=iDkam2ewW1rguNd2uR+v6GcA5sZKsU4X7/Mfk7B/a6UFYOZsL3Y7wvl1sAAkqbu1Sm
         WR0uSQo18jgoWlqIK7Ga05z8SlYpgEO351Oi+k7qtA0Og3K3MHol1jwLziR4B/BFItMf
         XmibftlvvH6ZjIcoh+6Wl4viUKV6Nx9gBzJa6vDtPzTa2EfeGBGRvWWzUp1u9JgILMQE
         +smx7v+rlqza02dPDgN9GsCFToSzuk2kbhOdeitAqlrDn9j7WH8vjQQbfnpqn05keFan
         KpoTJJ5ECqYT5a1OZmMLofo8U6/r/Z4gsBy7mqwwXgxU7o8sqcBGb4+5MGCzUXp8w8iL
         iETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703255479; x=1703860279;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hCMljXl64bVf1xnNOYFSwE5VnW4uhjdgxZFrLklQSVY=;
        b=QfpuWmJN7RepUwovIC0aXhihD0Qm31M4BMHT5y89knXNM991rXgDBB6+ERlZLmODAa
         OS1W0QzxQz0+8XfDNk1F4j5O7CIclQmip98QMOhr6KLQ7F6JxwsajNCeThQ57eBa4DZg
         RanVYCHfmW3LVrpxsuFk/7LiPbyg+jaD5HmGi2wS74PV/7g5xrd1Hjv81sEKcFgW/nG3
         BRB2WJkVhjdQ/FsUViRIYcgnykmReEbznfWWzGtORRs1JPjKPNbNhgnWW7IfNPxZs5sL
         RkTTocGqiUP/z1c4gcO5CpmlZa0KDsSdGqHwNScCYNacAwkF+O3h3TCWwXn0PVto9kJz
         ONwQ==
X-Gm-Message-State: AOJu0Yy8nIP1DGjgaiUCa4YSELid+qtRhKaUgCxu5h93dlmCq/XqSahd
	4QzTrappIgDcY3pBOW0XkVzrIu50ROUjJw==
X-Google-Smtp-Source: AGHT+IFjDQZwXvG5BR3N8L1gnXyEysJlRGKZyMYMuNqbRbFKqbNQ0c1vGGrP08A46agxxuuHnN9aHg==
X-Received: by 2002:a17:903:244e:b0:1d3:e7cc:e2a6 with SMTP id l14-20020a170903244e00b001d3e7cce2a6mr2631936pls.0.1703255478759;
        Fri, 22 Dec 2023 06:31:18 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id p2-20020a170902e74200b001d33e65b3cdsm3520002plf.112.2023.12.22.06.31.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Dec 2023 06:31:17 -0800 (PST)
Message-ID: <c4c2de2e-b816-41eb-8646-8e57b7ed7913@kernel.dk>
Date: Fri, 22 Dec 2023 07:31:16 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] io_uring: Statistics of the true utilization of sq
 threads.
Content-Language: en-US
To: Xiaobing Li <xiaobing.li@samsung.com>
Cc: asml.silence@gmail.com, linux-kernel@vger.kernel.org,
 io-uring@vger.kernel.org, kun.dou@samsung.com, peiwei.li@samsung.com,
 joshi.k@samsung.com, kundan.kumar@samsung.com, wenwen.chen@samsung.com,
 ruyi.zhang@samsung.com
References: <c3995796-8aab-45e1-ad59-d970373a4fab@kernel.dk>
 <CGME20231222084334epcas5p10badfe3c82a6b8355c03f8d0aa192892@epcas5p1.samsung.com>
 <20231222083530.11051-1-xiaobing.li@samsung.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231222083530.11051-1-xiaobing.li@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/22/23 1:35 AM, Xiaobing Li wrote:
> On 12/18/23 15:53, Jens Axboe wrote:
>> I think I'm convinced that the effectiveness of the chosen SQPOLL
>> settings being exposed is useful, I'm just not sure fdinfo is the right
>> place to do it. Is it going to be a problem that these are just
>> perpetual stats, with no way to reset them? This means there's no way to
>> monitor it for a period of time and get effectiveness for something
>> specific, it'll always just count from when the ring was created.
>>
>> We could of course have the act of reading the stat also reset it, but
>> maybe that'd be a bit odd?
>>
>> Alternatively, it could be exported differently, eg as a register opcode
>> perhaps.
>>
>> Open to suggestions...
> 
> I thought carefully about your proposed reset stat, and I think it can be 
> achieved by outputting "work_time" and "total_time".
> eg:
> Output at time t1:
> SqMask: 0x3
> SqHead: 1168417
> SqTail: 1168418
> SqWorkTime: t1_work
> SqTotalTime: t1_total
> 
> Output at time t2:
> SqMask: 0x3
> SqHead: 1168417
> SqTail: 1168418
> SqWorkTime: t2_work
> SqTotalTime: t2_total
> 
> Then we can manually calculate the utilization rate from t1 to t2:
> (t2_work - t1_work) / (t2_total - t1_total)
> 
> Not sure what you think, but if you think it doesn't work, I'll look into 
> other good ways to add the ability to reset.

Yep that would work, just leave the stats calculation to the tool
querying it. Which is really how it should be.

> In addition, on register opcode - generally it is used for resource like
> buffers, handles etc.. I am not sure how that can help here. If you have
> something in mind, could you please elaborate in more detail?

It's also a bit of a dumping ground for any kind of out-of-band
mechanism, so it would work fine for something like this too. But since
we already have fdinfo and with your idea of just logging work and total
time, then we should probably just stick with that.

-- 
Jens Axboe


