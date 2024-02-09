Return-Path: <linux-kernel+bounces-59604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E5184F99C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB2BCB21E17
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1F17AE51;
	Fri,  9 Feb 2024 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAJRTO42"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6213C768FA
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 16:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707496088; cv=none; b=RgrfWgJCaX+TSBwxMwWkU5nsKTGh3REJV5F8cQf1EpUsreP6mGARnT/OBkLAfl7FJx57RbsnDOaJmXh3LtAkJad+pip/GVPrhvOk5+i9rGHZrvKKKlsPYrwvfJ1ZtlFZ+nCo6wylEjm2dSx3aRAWIIk5UvFCDbC2GFfBWXf46Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707496088; c=relaxed/simple;
	bh=5Nrn9nQwtLClAHT6a0X4rDfHD/svH6hLxoCckVthB4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBZjxZfysSuA1y7bUAt2n2HQ5QMMLXYWoPANPs4Sbi98mjKN1P6i1KsMPsAX6Bzrn4of0lm/X2iFJHNnrZCeaNhWstemGtW+NqVELSKu8zVaWDxDDuyDGv1zAPT/qGo48NWZnXbI2upvDCnOIX0e4IrbWcdMc6IB7h9ubrwa7yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lAJRTO42; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d958e0d73dso8821955ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 08:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707496086; x=1708100886; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YpvcKMV4H4CBgdCXm6Q9mVqCzsBSIqpy1A4Px0Wpicg=;
        b=lAJRTO42oY7O/3rkP4GPS4A3jTkk0fNpA2Jhj/ygYCL6VKHr7gna7TeHq77+dO6XLW
         ePNtoBSVrN7uQ0QDgVmUkurJMYHZM1sVMVuHQCz9TMeZ4vUOJehdUJnQiaiLnYdLcVfB
         jbmf24hcy9U3JW23iYui4gCPaqdZt/oZrdV+IpOg5qgRMAO9hcVz+6WpHLTmjjQblIcu
         v7D+UefN6I4j058ivmZX8jnvc7Fftz42LMYJnclSVAYy68yGKT/T4YBf4rNffPxx7FgJ
         dekzaeJnSTycv3KvjJiKVgrVbi8ZGlQkAA7A83bcBx/+dhdahQnGvXylAkgHXx+OZeKN
         pbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707496086; x=1708100886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YpvcKMV4H4CBgdCXm6Q9mVqCzsBSIqpy1A4Px0Wpicg=;
        b=FBcD68ptVDdVX9LO2QVJ1ATacuJULjstOl2ty9Yk11WlwmV/H/15lH2II612LPA879
         6de5Dn8gXBlJLSKJthn+sfHpt9rnsMkFH603GeVbq/IrsROzrxfw6rYqLBfLZFdelgaq
         lSUSolMQP4bj0pnID6CIOSFbyPkOhhWuKIDL+a5ATFlRbX6X2IDPM1s3l26hVoYfj5Ko
         pfm5GqT4p/ppNQh8pHKfI7sIac/h1Eu/cl05XYQi4aqQW6boYfECDf8vu+nig4rk6OF5
         EPIzSHsRX1r5NErrNvI5+toNcBHDrBB3TsnJOlL+Wpoh/b2c/BkbRnoVzwYisT4fN1MA
         6IGw==
X-Gm-Message-State: AOJu0YzKcgIqAW1xSwB1IxEhjg6K7mDO5PJHSOz3fL5Q6FpYOtZv9Clz
	fF/MG0Dz7RmSwomPYV8k2E2Aj2L4kDyRyt+gfjuHPlr8g73AXSFw
X-Google-Smtp-Source: AGHT+IH9JuZCv6WT6G0fjEJllJvhy7D3xL9EZMrfsjWSOPWiRXD375O18BTFQrWr9mj/7OmfO42ljQ==
X-Received: by 2002:a17:902:d4ce:b0:1d7:7583:6d1c with SMTP id o14-20020a170902d4ce00b001d775836d1cmr1992733plg.16.1707496086493;
        Fri, 09 Feb 2024 08:28:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX31IBRihmxBHhMWZp6EDq3DwY46hP4Cll802swvwVlXhcNlcCF613QVncIDA88J97Om48FLMhFNmfRRoOMMmor+jmUR2gdBRFy3iif+J3cjy7VIkqS/71GYhHqvmjsUxRwbBTcxRjYHbTtg3MdiA==
Received: from localhost ([2620:10d:c090:400::4:3c45])
        by smtp.gmail.com with ESMTPSA id jx4-20020a170903138400b001d942f744f6sm1696407plb.157.2024.02.09.08.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 08:28:06 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 9 Feb 2024 06:28:04 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] workqueue: Fix kernel-doc comment of unplug_oldest_pwq()
Message-ID: <ZcZSlBRELjUIVJ_B@slm.duckdns.org>
References: <20240209145850.1157304-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209145850.1157304-1-longman@redhat.com>

(cc'ing Jonathan and quoting whole body)

I'm not necessarily against the patch but at least from in-code
documentation POV the diagram being in the function comment seems better.
Jonathan, do you happen to know a better way to address this?

Thanks.

On Fri, Feb 09, 2024 at 09:58:50AM -0500, Waiman Long wrote:
> It turns out that it is not a good idea to put an ASCII diagram in the
> kernel-doc comment of unplug_oldest_pwq() as the tool puts out warnings
> about its format and will likely render it illegible anyway. Break the
> ASCII diagram out into its own comment block inside the function to
> avoid this problem.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/workqueue.c | 32 ++++++++++++++++++--------------
>  1 file changed, 18 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index cd2c6edc5c66..f622f535bc00 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -1790,25 +1790,29 @@ static bool pwq_activate_first_inactive(struct pool_workqueue *pwq, bool fill)
>   * unplug_oldest_pwq - restart an oldest plugged pool_workqueue
>   * @wq: workqueue_struct to be restarted
>   *
> - * pwq's are linked into wq->pwqs with the oldest first. For ordered
> - * workqueues, only the oldest pwq is unplugged, the others are plugged to
> - * suspend execution until the oldest one is drained. When this happens, the
> - * next oldest one (first plugged pwq in iteration) will be unplugged to
> - * restart work item execution to ensure proper work item ordering.
> - *
> - *    dfl_pwq --------------+     [P] - plugged
> - *                          |
> - *                          v
> - *    pwqs -> A -> B [P] -> C [P] (newest)
> - *            |    |        |
> - *            1    3        5
> - *            |    |        |
> - *            2    4        6
> + * This function should only be called for ordered workqueues where only the
> + * oldest pwq is unplugged, the others are plugged to suspend execution until
> + * the oldest one is drained and removed. When this happens, the next oldest
> + * one will be unplugged to restart work item execution to ensure proper work
> + * item ordering. Note that pwq's are linked into wq->pwqs with the oldest
> + * first, so the first one in the list is the oldest.
>   */
>  static void unplug_oldest_pwq(struct workqueue_struct *wq)
>  {
>  	struct pool_workqueue *pwq;
>  
> +	/*
> +	 * Layout of an ordered workqueue during a wq_unbound_cpumask update:
> +	 *
> +	 *    dfl_pwq --------------+     [P] - plugged
> +	 *                          |
> +	 *                          v
> +	 *    pwqs -> A -> B [P] -> C [P] (newest)
> +	 *            |    |        |
> +	 *            1    3        5
> +	 *            |    |        |
> +	 *            2    4        6
> +	 */
>  	lockdep_assert_held(&wq->mutex);
>  
>  	/* Caller should make sure that pwqs isn't empty before calling */
> -- 
> 2.39.3
> 

-- 
tejun

