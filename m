Return-Path: <linux-kernel+bounces-58475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AB984E6F5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 922781F22D29
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C99823D2;
	Thu,  8 Feb 2024 17:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTYvaocI"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB34823C2
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 17:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707414151; cv=none; b=ObNX3zU3duxsdCGyFNq0pRlXOphH3CZHmocgbBN6FcJsFUNxeVyMPgr6GXLwVMryXJjwjcRUMMpSLmEZ9uJ6XdhhG+wqYKQuTgb5DJhQzoIg1pxBAXm1lUjvBkOt6t/fGfYIHW2RQzRZr40amAhNTHARxLq0iy013tdI4SxHJjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707414151; c=relaxed/simple;
	bh=r3ot4oF1LX3nA6eTOhVf+jyF+CVFFa7172oMKsIh+b4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ih1Uxj2C7358to0hVFD2BJEAcn9rV0bV4wRpJy1pxMlRPuMvzB4eJQFyvSiHsoJe3smLLhA/mDPmjQ93NKYToMUUAPU/8d7f85YhcghbaeHRkh37CRZVEV+ftRuBGzFsU9yJZe81r69Zq8sYPuyGFp9hIbS9Fun7KiD10XWQ76U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTYvaocI; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d944e8f367so339385ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 09:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707414149; x=1708018949; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kbA8ylbFRlKyg5U453MmfWxg4qPQ1odWQVw3a/yjMMA=;
        b=hTYvaocIehF1NJeE88McVIzur5iFgb2oJkcoUJv7bWzCGSgK77SJWluiqUgwBgXTqb
         Y8unvikmGPK8RjBTj9/gBWptfUMApx030JNmaC63qU/VksrsLrY1+I0pwXdtYnOQOPSu
         NlC9P/F4Oy80Z1MwjTBjt8Iu/GEht6mPm7RBEj966of7Wi/QU1Cq1Ovw+Ym4z3p44D5x
         eQp+B/9cZy1ZtBOTWHuu97/h86LOYNC2zzNoHeoUdKcOV5O/TMhlgBXekDbPnD3AZEdS
         quGV+j4foPNS/gLh0KD/Tl9SoOEcTMBjvdsgmLCYnRcGJKMeWs9re906NOrCxQcZJYHP
         /TMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707414149; x=1708018949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kbA8ylbFRlKyg5U453MmfWxg4qPQ1odWQVw3a/yjMMA=;
        b=adhJ4u+rrRDcF/irbY/DvVg/VuzZGyQRWDZ0sIlnF1Cc2uACPiASromse1n5ZqPS2O
         MALHp2KH4tvmTchbGL/xal/4vj1koyhd1vuHSdteLTSDmcaHXGnHFNGG5YZkqMVfeIec
         9ujnIpiipUb0/JlGtm5agU0Tqj3YLEe22xuQH+s+Ctk6LTiUE/x5gcBpteNpLIUNFsXT
         +tI5vq8KFburqOjHRFVnwXGQtMHBmLfLTQCNOQTCuuSooxM4v7oDhyz2IY/xK/sLzvFM
         ivBcvlYECb8MYdDV8NAigWN5DiK48BF9J3mJ22/RyyvfSAbmv5Sybsyj3S5bL4SNXBnP
         /+0g==
X-Gm-Message-State: AOJu0YwudnhDee/fEntCOQAv5SOzMgAh/TVc+3AzMVkVPyXZl2P3ap8s
	3ERvjpTuFRxMjQVH6EEp9X2n6Fm7dq9UsOcs+UqgthslURi+msng
X-Google-Smtp-Source: AGHT+IFk6ER52uITpm87v07bgASXvVurZymY4H4FuFh2fytCLhYBydXqnDqjV2kf0JSjDzbU5vhyNQ==
X-Received: by 2002:a17:902:e548:b0:1d8:fafa:f923 with SMTP id n8-20020a170902e54800b001d8fafaf923mr10701826plf.10.1707414149142;
        Thu, 08 Feb 2024 09:42:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUuLQdpMvgMSpEolg7dRZzQIMALmahYAibXzcxpqNiziqewujlGdkHkym2hAvMMGY12mwW2XKyEI6yKivy7gXcvR4pMRzr8XGLB2mXBa1nYCHldWUX7LdBN/+/wZP7kBHiAXG8A7+Elrkn7ezrDZK0gzging/43et5msVEXE9xfCdR45gSRc9pL3RONG7dF6qQlnEuQsruPByqcT1a4DiPBD+nw9J4fPAP7uVeEP3I5AyULM+s/Q3lfDctjgV9RuBF/ycxQIw==
Received: from localhost ([2620:10d:c090:400::4:3c45])
        by smtp.gmail.com with ESMTPSA id mn7-20020a1709030a4700b001d8aa88f59esm15975plb.110.2024.02.08.09.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 09:42:28 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 8 Feb 2024 07:42:27 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Cestmir Kalina <ckalina@redhat.com>,
	Alex Gladkov <agladkov@redhat.com>, Phil Auld <pauld@redhat.com>,
	Costa Shulyupin <cshulyup@redhat.com>
Subject: Re: [PATCH wq/for-6.9 v5 2/4] workqueue: Enable unbound cpumask
 update on ordered workqueues
Message-ID: <ZcUSg1t-hXbZXsKj@slm.duckdns.org>
References: <20240208161014.1084943-1-longman@redhat.com>
 <20240208161014.1084943-3-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208161014.1084943-3-longman@redhat.com>

Hello,

Generally looks good to me. Minor nits below:

On Thu, Feb 08, 2024 at 11:10:12AM -0500, Waiman Long wrote:
> +static void unplug_oldest_pwq(struct workqueue_struct *wq)
> +{
> +	struct pool_workqueue *pwq;
> +	unsigned long flags;
> +
> +	lockdep_assert_held(&wq->mutex);
> +
> +	pwq = list_first_entry_or_null(&wq->pwqs, struct pool_workqueue,
> +				       pwqs_node);
> +	if (WARN_ON_ONCE(!pwq))
> +		return;
> +	raw_spin_lock_irqsave(&pwq->pool->lock, flags);

Can we do raw_spin_lock_irq() instead?

> @@ -4740,6 +4784,13 @@ static void pwq_release_workfn(struct kthread_work *work)
>  		mutex_lock(&wq->mutex);
>  		list_del_rcu(&pwq->pwqs_node);
>  		is_last = list_empty(&wq->pwqs);
> +
> +		/*
> +		 * For ordered workqueue with a plugged dfl_pwq, restart it now.
> +		 */
> +		if (!is_last && (wq->flags & __WQ_ORDERED))
> +			unplug_oldest_pwq(wq);

I'm not so sure about is_last test here. unplug_oldest_pwq() is testing for
NULL anyway, so maybe just drop this test here and drop WARN_ON_ONCE()
there?

> @@ -4966,6 +5017,15 @@ apply_wqattrs_prepare(struct workqueue_struct *wq,
>  	cpumask_copy(new_attrs->__pod_cpumask, new_attrs->cpumask);
>  	ctx->attrs = new_attrs;
>  
> +	/*
> +	 * For initialized ordered workqueues, there is only one pwq (dfl_pwq).
> +	 * Set the plugged flag of ctx->dfl_pwq to suspend execution of newly
> +	 * queued work items until execution of older work items in the old
> +	 * pwq's have completed.
> +	 */
> +	if (!list_empty(&wq->pwqs) && (wq->flags & __WQ_ORDERED))
> +		ctx->dfl_pwq->plugged = true;

Can we test __WQ_ORDERED first?

Thanks.

-- 
tejun

