Return-Path: <linux-kernel+bounces-78680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3365861723
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 747AD1F2880C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131B986632;
	Fri, 23 Feb 2024 16:09:22 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402038593C;
	Fri, 23 Feb 2024 16:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704561; cv=none; b=ecb3mSMP11dwXQn+kdQUtmWdnrjDMPKD1hqbfPfMOxVUDTQLuGSWFDW4O7xARFCJdTtKUc8UssxhOcj04O7EQKx9Sw5rgcEtEMpYrIWh6vVFpeLS3sW0vVCLAzd+FmW3FL5pSQ+yOSbMR1FVcAjVbKJmmM5J5VLXwZJlMY+oYxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704561; c=relaxed/simple;
	bh=8EW9uQLOdznbAPl0cofVdxHNmAe825HDlXki5KfHp0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BPz7xDQ8h+2BIW0h0/HR6C4wsLpHMS1MUDfW9s+CaRHqEQlB+qriRUNq/Fsa8SWXcKiH3wePWhpETwLk6Uia+eXOlMmMJGntsu5WB7yJzKUB0NWznZkGQEGg1t/eEU1GGTFGyVv3aFdVbsn2F5sed0SONd817U+MJUqPTRrIVvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dc0e5b223eso8004245ad.1;
        Fri, 23 Feb 2024 08:09:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708704559; x=1709309359;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yUqo3LDO3MePmZecpCkqo+c4ORCmyh4of7rsQOCJpdc=;
        b=RKsD6CPo4aRlF/nFpLS0QXWkP0gJZtd+NHm39mv7ch2X57owvBm2s7iUK3rlj0vfs9
         K6nWJ3jPV/LvIzMjpxyoIdrx2KdiDWvyyeNfl+CThfB3sWtUsyFHPv5nuZrAcf0WdITy
         UrhA8auGmNfPpTrMrdLYsyRNDTmhpZjPMeUFmm0w5HECwyC9yYQrXHlWkMp5+m1qMdkW
         KxKg4uP3XcE1XCmoLyREuj4VSzzx3tshZhdkxBvUAguNZOp8PTGWz7tej7AHjWi1iz9I
         oRbTVkpR3Ad3IHYTe3GTb7fmw+VjyFqFXMBYUrJS1dVr9KEgl0LRZ/8FnSPwnNplaijA
         5KHg==
X-Forwarded-Encrypted: i=1; AJvYcCXBtDlWEi/4mOzKm0yWI40KPHtuA5Kk6cEJG/42gfb/ZBdGfPd2oVxGaE0rMOQhcnC+2PR9sckWcKCgUyufrbmgu3vcE/x3HU30GoY=
X-Gm-Message-State: AOJu0Ywt2TYvjpp0RrpDfWl0Yo9yLT+7+VfaTMtSm98biJyx3LBDMY4G
	tlb287YePBwsV3a/V7arNEJedarkV39Plc5ibGdH89k1iHQgeXxb
X-Google-Smtp-Source: AGHT+IHG/OSwQWccxYdQxcbFB2H6jmW2c05PUk+gYgOxvNERj3AzXIS0+HD86R6sX/B/2yHcVsnagQ==
X-Received: by 2002:a17:902:cec6:b0:1d9:a2d3:812a with SMTP id d6-20020a170902cec600b001d9a2d3812amr219294plg.56.1708704559491;
        Fri, 23 Feb 2024 08:09:19 -0800 (PST)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id f13-20020a170902ce8d00b001dc2d1bd4dasm5190624plg.80.2024.02.23.08.09.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 08:09:19 -0800 (PST)
Message-ID: <8fc70827-9785-48d0-9a43-e1e3674317e9@acm.org>
Date: Fri, 23 Feb 2024 08:09:17 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] block/blk-mq: Don't complete locally if capacities
 are different
Content-Language: en-US
To: Qais Yousef <qyousef@layalina.io>, Jens Axboe <axboe@kernel.dk>,
 Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>, Wei Wang <wvw@google.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Christoph Hellwig <hch@infradead.org>
References: <20240223155749.2958009-1-qyousef@layalina.io>
 <20240223155749.2958009-3-qyousef@layalina.io>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240223155749.2958009-3-qyousef@layalina.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/23/24 07:57, Qais Yousef wrote:
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 2dc01551e27c..ea69047e12f7 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1167,10 +1167,11 @@ static inline bool blk_mq_complete_need_ipi(struct request *rq)
>   	if (force_irqthreads())
>   		return false;
>   
> -	/* same CPU or cache domain?  Complete locally */
> +	/* same CPU or cache domain and capacity?  Complete locally */
>   	if (cpu == rq->mq_ctx->cpu ||
>   	    (!test_bit(QUEUE_FLAG_SAME_FORCE, &rq->q->queue_flags) &&
> -	     cpus_share_cache(cpu, rq->mq_ctx->cpu)))
> +	     cpus_share_cache(cpu, rq->mq_ctx->cpu) &&
> +	     cpus_equal_capacity(cpu, rq->mq_ctx->cpu)))
>   		return false;
>   
>   	/* don't try to IPI to an offline CPU */

I think it's worth mentioning that this change is intended for storage
controllers that only support a single completion interrupt. Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

