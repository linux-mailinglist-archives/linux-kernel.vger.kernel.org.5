Return-Path: <linux-kernel+bounces-16467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D734A823EF4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88DD31F24A67
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC150208DA;
	Thu,  4 Jan 2024 09:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="beP6Nr+F"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38016208D1
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 09:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704362057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=idoDtZ5NCin0uZIqvcSJb60xoWhrFYXpUCkOZ1DBXOE=;
	b=beP6Nr+FbtBKvG98Pk7EUIHlR3ZAmgueCogUXUvVKHGz8utJu/JN5AjO5UIv/sg9W1c999
	Jj5x7Reg5rC7PbvjXNXjPt1p30LeoVWuAl2vSUljqwInxcJsDmfHryAWZqw03VefplIkwi
	qBpYN1a6jU/q+476lwIylovXnjI3V/U=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-IQpD8dbWOUi_7UOdmi3Aeg-1; Thu, 04 Jan 2024 04:54:14 -0500
X-MC-Unique: IQpD8dbWOUi_7UOdmi3Aeg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7816e45f957so47407985a.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 01:54:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704362054; x=1704966854;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=idoDtZ5NCin0uZIqvcSJb60xoWhrFYXpUCkOZ1DBXOE=;
        b=aJ+8gv655zNBuRmYBnExPQAlvOwa7EqY7hh//bK1nU8ZbEWS9N2gyFD7MCYzSzg2tf
         ORWAjlKyRRtRmfibyXRHjgqDiIHXnruKHomF/aMKw1V776XvHrE4ImecKCqaWmLCLC9T
         ElmxCRiAPB0hrdMAm1e90oIu9qzbJkR/Vh1o3GNtWvav8uSwz5D5lg3HufaVxnMYOM+7
         V4sFQRIqAUJqUtj7YqUMIe7sak+viIBBMzKhspQ/u1ycgplNiKNVCEylVoOoej7wGQ7q
         dHi080z2OlOh8g5jlBY3Seatf6czuYZLzW8WgU/dbRj7PxtoYpYXJmyEKmk/xD6Xkmph
         pDaw==
X-Gm-Message-State: AOJu0YzVW8GNkzPYfsHsiI2sQm0M10xVuJOSUt8DqfNRK4P9ChReOYKd
	DThMkoq2vXlQtuI1YdpFglZaBT/zqIaj5SFucCvzKuKhtrKiElqkM47WllBjgiFYWGYXwP2I0p1
	YfPhR/ye1dvsJnn7qV+No8EfU2naFaOOl
X-Received: by 2002:ac8:574c:0:b0:427:7814:f60d with SMTP id 12-20020ac8574c000000b004277814f60dmr378958qtx.134.1704362054116;
        Thu, 04 Jan 2024 01:54:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrubjIifxF6UK/QtzfUWJNTb3j4QTHKUXOlUFeAgQwcIssh8/juYduNa3KU92LqJ1kFKDhTA==
X-Received: by 2002:ac8:574c:0:b0:427:7814:f60d with SMTP id 12-20020ac8574c000000b004277814f60dmr378956qtx.134.1704362053833;
        Thu, 04 Jan 2024 01:54:13 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id ep5-20020a05622a548500b004282589b74asm3646060qtb.28.2024.01.04.01.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 01:54:13 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Pierre Gondois <pierre.gondois@arm.com>, linux-kernel@vger.kernel.org
Cc: Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel Bristot
 de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 1/2] sched/topology: Annotate RCU pointers properly
In-Reply-To: <20240103125648.194516-2-pierre.gondois@arm.com>
References: <20240103125648.194516-1-pierre.gondois@arm.com>
 <20240103125648.194516-2-pierre.gondois@arm.com>
Date: Thu, 04 Jan 2024 10:54:10 +0100
Message-ID: <xhsmh1qaxjuf1.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 03/01/24 13:56, Pierre Gondois wrote:
> Cleanup RCU-related spare errors by annotating RCU pointers.
>
> sched_domains_numa_distance:
>   error: incompatible types in comparison expression
>   (different address spaces):
>       int [noderef] __rcu *
>       int *
>
> sched_domains_numa_masks:
>   error: incompatible types in comparison expression
>   (different address spaces):
>       struct cpumask **[noderef] __rcu *
>       struct cpumask ***
>
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>

That's from when the NUMA topologies were made dynamic, which should be:
Fixes: 0fb3978b0aac ("sched/numa: Fix NUMA topology for systems with CPU-less nodes")
> ---
>  kernel/sched/topology.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 10d1391e7416..0342a4f41f09 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1542,8 +1542,8 @@ static int			sched_domains_numa_levels;
>  static int			sched_domains_curr_level;
>
>  int				sched_max_numa_distance;
> -static int			*sched_domains_numa_distance;
> -static struct cpumask		***sched_domains_numa_masks;
> +static int			__rcu *sched_domains_numa_distance;
> +static struct cpumask		** __rcu *sched_domains_numa_masks;

I understand that's what sparse is asking for, but that looks odd to me. We
use it as:

  rcu_assign_pointer(sched_domains_numa_masks, foo);

so why isn't it

  __rcu ***sched_domains_numa_masks;

?

This isn't a pointer to an RCU-protected array of masks, this is an
RCU-protected double array of masks.
>  #endif
>
>  /*
> --
> 2.25.1


