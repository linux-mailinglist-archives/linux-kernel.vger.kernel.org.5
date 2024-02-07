Return-Path: <linux-kernel+bounces-56824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D02084CFBD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 917051F281B8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98378289A;
	Wed,  7 Feb 2024 17:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAucaS+o"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDFD82886
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 17:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707326717; cv=none; b=OteCdNhByHJUWaSs5haNT0Q5WIHrKp1MyuuyGtWL+LUFTXSM94KDDrrD6EC2WTqZUk5k3TJg7CmtM8kKgH8+uhNfAt8L2Wan7qEY9va/p0dtoFnddN8rKsELbusMEp+63oj4J3zP2B0CzWtFUp46wZqrTh5v7OpiAgB5Q/oMbjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707326717; c=relaxed/simple;
	bh=xqTKmPSmn629HFya5gYQnUWscFAIZ2d/yoaTkTFFlY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=meW2YPTjwkLbWTU8f5iq8sG0cbn9yWJfa3fFFhp0kedfpBjPa9bA/V8IeadD/DTTk2XmJ4MQmVtT+05CmHWsR1g0qe3AAedKogWHKDnmr8orr0kOZdXFnhv0B+jJjkvn3FRHoK96+UtTH5sWUuZ1oTpoAhRuyRdqaqOkDb0lrUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAucaS+o; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d7858a469aso7448925ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 09:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707326715; x=1707931515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rBvthJ08YpTRaGck78xaZKvIrrAHAm7dl0CoVOzhFNg=;
        b=TAucaS+onHivYXXjEVsPTLjvDqK8BxaTz+fKj2FqnSDhiEW+T71F0YDh41+B83fCfT
         tnfXo8pXQBE1CyqFQDS3ZNZalkPxF+wDgStbRt4WvTsclHWzja9GOAuTrBZ/5I8cQjrj
         m/MfGQaoC+26DfEtqNHjaymfoix0zVEdJ5OZ1rnB9jaGWiwA9RV2UxxaLAyEbFNbzl28
         Ycn/AcoqyoLQQdgBebrUfbYsxa4Eu3f1u3UiPsJac2NHa5jYLHvoZ/Dc/FGu6nCFE2YP
         vgZ9cc6I096qKOKnopfdjzyp8dzj2rVm7p621afQkXXO/CZXSqvDI054n6+RKR+8pA0Q
         41pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707326715; x=1707931515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rBvthJ08YpTRaGck78xaZKvIrrAHAm7dl0CoVOzhFNg=;
        b=S1kYQYktjSGkZuX/sz4I1FYqQoEcAJBtHu4qtyS2iNwA8xPBOnFZdNN2kOAa568IwO
         M/yLOLF4CJYv4CWlN1uivr/D1KJbE0tmGYgEAlKQ7yqjf3bDEElcBDsZ5pkXu1X+jOiz
         Rq6i0s8gH3PjlbLeyMHoxRr775gaBX/92v6qy/CZYNlP3Xw4GcqBx6QdrgcSu0XckfL/
         90KP8dUL2o1vk18kJUm2kkZ9tH6Hj62q0oNNZNeo1io/1Do/RCjklCweWxuPKZJeh0WJ
         y9LG+B+zMbPQ0qfr5GNj0yUVt+FkUG1vdjxAyyv11Y3jaGhM/mJ5GX2KqP4psElazeT3
         N/yg==
X-Forwarded-Encrypted: i=1; AJvYcCUop+6UMGWT9acsVPpyxato+Aklj2qlfYuI9+iVGi69KlxSE7LPP6py8O8dtkw89JL6SwoE8/b5/iHXa+Tgi+1hD39DixqAKf7mgZHx
X-Gm-Message-State: AOJu0YyOUw+LK44v3RH0EYwvPnmetT1OKk8o/eQcDaGveEIpVY4l7YyM
	i3xF1pu3AVQq8MNJKJ6+GyqQQBRfYXMzXPTlCVG7jzaxpNF8Jw7htrnYPj8Mxw8=
X-Google-Smtp-Source: AGHT+IHH22DPtROYOohanEO88b+Q5FBTYZd8j5BxEhN9KwEiONT/35CQs/twvLrbBfMuusFe8jQ4bw==
X-Received: by 2002:a17:902:d506:b0:1d9:3b98:2709 with SMTP id b6-20020a170902d50600b001d93b982709mr6304233plg.5.1707326714623;
        Wed, 07 Feb 2024 09:25:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX7WG+Yh86lYdEAXk+28dCUEfR4kBnkb61sYJFnmbRDre/I1OsTsnBC0TG7I2euoMSjYByz5ImsWvLWa1BZHFriGAhrlJKqERT48OTnCU4varOF2jDXsdDVjlrT4/HbUgjg9fma9TR6ipIv1zA4iEKalDOU22cHDfY6/JQ9gwHfvEs6bDvsz8EyDgk9b2+VZqOKubr1oru2oH7kt+fbO58PJ3C15Qxq7zMWXPva2Fu4eP0tSHwN+dasUW/s1t7IsLc/ks0UEQ==
Received: from localhost ([2620:10d:c090:400::4:3c45])
        by smtp.gmail.com with ESMTPSA id jk19-20020a170903331300b001d9c0c321c6sm1704075plb.67.2024.02.07.09.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 09:25:14 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 7 Feb 2024 07:25:12 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Cestmir Kalina <ckalina@redhat.com>,
	Alex Gladkov <agladkov@redhat.com>, Phil Auld <pauld@redhat.com>,
	Costa Shulyupin <cshulyup@redhat.com>
Subject: Re: [PATCH wq/for-6.9 v4 2/4] workqueue: Enable unbound cpumask
 update on ordered workqueues
Message-ID: <ZcO8-JDXkoDeMFVT@slm.duckdns.org>
References: <20240207011911.975608-1-longman@redhat.com>
 <20240207011911.975608-3-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207011911.975608-3-longman@redhat.com>

Hello, Waiman.

On Tue, Feb 06, 2024 at 08:19:09PM -0500, Waiman Long wrote:
..
> + * The unplugging is done either in apply_wqattrs_cleanup() [fast path] when
> + * the workqueue was idle or in pwq_release_workfn() [slow path] when the
> + * workqueue was busy.

I'm not sure the distinction between fast and slow paths is all that useful
here. Both are really cold paths.

> +static void unplug_oldest_pwq(struct workqueue_struct *wq,
> +			      struct pool_workqueue *exlude_pwq)
> +{
> +	struct pool_workqueue *pwq;
> +	unsigned long flags;
> +	bool found = false;
> +
> +	for_each_pwq(pwq, wq) {
> +		if (pwq == exlude_pwq)
> +			continue;
> +		if (!pwq->plugged)
> +			return;	/* No unplug needed */
> +		found = true;
> +		break;
> +	}
> +	if (WARN_ON_ONCE(!found))
> +		return;
> +
> +	raw_spin_lock_irqsave(&pwq->pool->lock, flags);
> +	if (!pwq->plugged)
> +		goto out_unlock;
> +	pwq->plugged = false;
> +	if (pwq_activate_first_inactive(pwq, true))
> +		kick_pool(pwq->pool);
> +out_unlock:
> +	raw_spin_unlock_irqrestore(&pwq->pool->lock, flags);
> +}

I don't quite understand why this needs iteration and @exclude_pwq.
Shouldn't something like the following be enough?

static void unplug_oldest_pwq(struct workqueue_struct *wq)
{
	struct pool_workqueue *pwq;

	raw_spin_lock_irq(&pwq->pool->lock);
	pwq = list_first_entry_or_null(&pwq->pwqs, ...);
	if (pwq)
		pwq->plugged = false;
	raw_spin_unlock_irq(&pwq->pool->lock);
}

> @@ -4740,6 +4796,13 @@ static void pwq_release_workfn(struct kthread_work *work)
>  		mutex_lock(&wq->mutex);
>  		list_del_rcu(&pwq->pwqs_node);
>  		is_last = list_empty(&wq->pwqs);
> +
> +		/*
> +		 * For ordered workqueue with a plugged dfl_pwq, restart it now.
> +		 */
> +		if (!is_last && (wq->flags & __WQ_ORDERED))
> +			unplug_oldest_pwq(wq, NULL);

This makes sense.

> @@ -4906,8 +4969,26 @@ static void apply_wqattrs_cleanup(struct apply_wqattrs_ctx *ctx)
..
> +		/*
> +		 * It is possible that ctx->dfl_pwq (previous wq->dfl_pwq)
> +		 * may not be the oldest one with the plugged flag still set.
> +		 * unplug_oldest_pwq() will still do the right thing to allow
> +		 * only one unplugged pwq in the workqueue.
> +		 */
> +		if ((ctx->wq->flags & __WQ_ORDERED) &&
> +		     ctx->dfl_pwq && !ctx->dfl_pwq->refcnt)
> +			unplug_oldest_pwq(ctx->wq, ctx->dfl_pwq);
> +		rcu_read_unlock();

But why do we need this? Isn't all that needed to call unplug_oldest during
workqueue initialization and chaining unplugging from pwq release from there
on?

Thanks.

-- 
tejun

