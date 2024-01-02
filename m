Return-Path: <linux-kernel+bounces-14233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D701B82198C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F07E8282DA8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8ECD292;
	Tue,  2 Jan 2024 10:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WmuHQPxI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0732BD2E2
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 10:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704190736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HMc+qKdUEl7y+MN7/moRqFMZRIqoflqEZrWPIofC6tk=;
	b=WmuHQPxI9phaN8H4kVeIEgGSA3VNRv/Y9Bg2Ma7MA/fIpntZ1rwZA1kuAX5kHxFM2rOwcm
	ZKEKhAqEJhvhS+6+kQBBqJ2r+lL2toBtMd9fmn86Ki10dm2UcmEcXIjWABXMgBKxLmNONZ
	prnZIm+dN99J7Ai0SPVu4lyCMF8eOT8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-gkCsvJJRPw2YxMYn_Tx8KQ-1; Tue, 02 Jan 2024 05:18:55 -0500
X-MC-Unique: gkCsvJJRPw2YxMYn_Tx8KQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-336953e0fe7so5450544f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 02:18:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704190734; x=1704795534;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HMc+qKdUEl7y+MN7/moRqFMZRIqoflqEZrWPIofC6tk=;
        b=ECyYMI0usihFKTUQ94kzrtbjLzjGMO0oBKg5UbdVps830OV3jDzI2pRyRthC2IbZtR
         4Zq5zhvqmuzx7nw8b4j7pkujWvfB2QhO2CcOdZjQlJLNpho6kY6/S9VmySYU7xhnBJZJ
         6maapDfvgvEj3fXb+E0xrnKC8Skr0YqGXnF6GFOXLwoeDWd9C1bhyK1pW/AeWcGHmUKg
         +Y3GJLX6Hue9Ok3/Lv3HZCisEvovDikgwZFcrlzYmAFp40aoGOKr8gV6dt4ThtAXJghl
         QR/MhFacqs1W1OEjO1SZQehKyFwCu4Hhn0wYz206yqxuynYJUxLauLuiEChCPmz2+50/
         ci3Q==
X-Gm-Message-State: AOJu0YxIoh1kYGOlegnatsOfFlHFHzo2wWawriAr/pvD4G6Vlj8H1p31
	sFp9nPxqnELLMyBHTodVIckq8hpmMM1uNb351MlRCD4G1J3Hk0JOvk0zy3Qn5ff11V6NECXrpJN
	bxMooC8F8iMUmp3stdrVP1ueTGd6+5QIP
X-Received: by 2002:a5d:4b85:0:b0:336:62a7:78f8 with SMTP id b5-20020a5d4b85000000b0033662a778f8mr11957288wrt.5.1704190734221;
        Tue, 02 Jan 2024 02:18:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/h8uyNXIphvHTDt5nycwaaPsq/LOOBt/Vy+P7Ligt6JvVzxaNp+dde9kojplVFOvvdAryEA==
X-Received: by 2002:a5d:4b85:0:b0:336:62a7:78f8 with SMTP id b5-20020a5d4b85000000b0033662a778f8mr11957277wrt.5.1704190733925;
        Tue, 02 Jan 2024 02:18:53 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id a4-20020adff7c4000000b003366da509ecsm28074104wrq.85.2024.01.02.02.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 02:18:53 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: alexs@kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent
 Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel Bristot
 de Oliveira <bristot@redhat.com>, linux-kernel@vger.kernel.org
Cc: curuwang@tencent.com, Alex Shi <alexs@kernel.org>
Subject: Re: [PATCH] sched/tracing: correct the task blocking state
In-Reply-To: <20240102073351.1527503-1-alexs@kernel.org>
References: <20240102073351.1527503-1-alexs@kernel.org>
Date: Tue, 02 Jan 2024 11:18:52 +0100
Message-ID: <xhsmhplykjawj.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 02/01/24 15:33, alexs@kernel.org wrote:
> From: Alex Shi <alexs@kernel.org>
>
> commit 80ed87c8a9ca ("sched/wait: Introduce TASK_NOLOAD and TASK_IDLE")
> stopped the idle kthreads contribution to loadavg. Also task idle should
> separated from blocked state too, otherwise we will get incorrect task
> blocking state from event tracing sched:sched_stat_blocked.
>

Why is that incorrect? AFAICT we have mapped the (schedstat) 'blocked'
meaning to TASK_UNINTERRUPTIBLE. TASK_IDLE tasks don't contribute to
loadavg yes, but they are still in an UNINTERRUPTIBLE wait.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index b28114478b82..b6afa596f071 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1570,7 +1570,7 @@ update_stats_dequeue_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se,
>                       __schedstat_set(p->stats.sleep_start,
>                                       rq_clock(rq_of_dl_rq(dl_rq)));
>
> -		if (state & TASK_UNINTERRUPTIBLE)
> +		if (is_blocked_task_state(state))
>                       __schedstat_set(p->stats.block_start,
>                                       rq_clock(rq_of_dl_rq(dl_rq)));

This change makes it so tasks waiting in TASK_IDLE have their waiting
ignored by schedstat (they are seen as neither INTERRUPTIBLE nor UNINTERRUPTIBLE).


