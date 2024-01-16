Return-Path: <linux-kernel+bounces-27718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D747482F4B6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 374DBB22DDC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81041CF98;
	Tue, 16 Jan 2024 18:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIoKsz9n"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956111CAA2
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 18:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705431447; cv=none; b=M1mT+Z7qxwjNqWIq6q2KgK/KyXFDcaFV+ZNldGwvPldK1AevbAAE9BwJNrI+iEHuGmSrDic5dz5ltLDh82B1Lioc81qZFSuBqJGmx3SS+aVmfqFNll5QyWEIsF+5Ku68g0iCPVgOq76UUn0k62ze7lKDxFtuMfGRlIaY07rGAWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705431447; c=relaxed/simple;
	bh=T8kXfy8I6R29x/com7Ybs10y68lo/wxDKPQ38ALGylk=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Sender:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9SbkHMA0exHztZPtDSTywDyfkq4N6kAUkKHvX3/GM1tz7Edx+FcOH9np+vkkgww73vaGtaArLXyykVgErKU+J3qRhShFqWqFN3CTNtqOJbPXMwSwwPDRmNlDunxd/AHIrEio3CYvNCWAoW177WBBZYc5+DPZcY/snROR3vs6/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DIoKsz9n; arc=none smtp.client-ip=209.85.216.49
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-28be8ebcdc1so6789644a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 10:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705431446; x=1706036246; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Ggt3qdMUg1GC8c+54SNnJmlwZL/CKF8hO+X890U6Qk=;
        b=DIoKsz9nyFSPV9Jgs/0YDEiLlM4y0bqjPJq5irVCbIrRLp9qBvMbi3OvkTpk0oYOzt
         XYXcUjYRawVAYfha2mwJMV9YbpD549COp1mpw8+l1OlnCXzKqi3eXxLKtInyZRnQ+WQb
         k31sj9flBwVsUJYwJdVzgypraDqMuSCg+4K4LZ9ISzd1ieTwphtW/aXx5DCNizQUPTR0
         GUvuanWbwWHx2Cl2KrHTfuZnBptDmhSlaAiEtx0O2sRY8gunUPO5LZaf0LY+y56zvOuf
         U40xY1jiEJFtMO1i2B08OGqlYJ2ekM4RMeD0ky3jH91gpnPHCgIiUphPfHBu4gVbUpnM
         e9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705431446; x=1706036246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Ggt3qdMUg1GC8c+54SNnJmlwZL/CKF8hO+X890U6Qk=;
        b=lFafvicS8LlyBfaGpI33jgQiI1kz3TmZKjACycpqHUPvWWh723hNB0zrYBBc5QK41t
         rR2ILyfoW698GxLBivmn/LiO1JrlmLAefoUYsb+41bHEbjVCQ9OamwUQ7ubyog5iAxjG
         1EK21ThpivW2aIJPtdxRes/fgFH3RB4uLxtl9ZbU4UMYqK441I0Ig2Koe2Kt3m7YxHfv
         9eeJ/fldU96ME2yTudnM+uaxSYes68zLDsgn3AZLxIuOzKny/TvYLyAv6NZJwFTNArlQ
         Y1Jkg/yifsBYTcc0b6hcm3bSMsJqbgSlBH7Z8YQkCsYzeuCimQ0th0DQlRKoVqDdnuaj
         AWug==
X-Gm-Message-State: AOJu0Yw1378NvJGmfMyiv0SEgNIMn+c+ZzBmsK+XCNgBxHbmY9NZLTMA
	xeuZ0R2SxxkSaOza5YRDPqk=
X-Google-Smtp-Source: AGHT+IG6aZNU10s1OtMq2i4+4ISBKf9A0MB7YPvZsM3dOWAaNObQppunY9y2KyTNy0GLRc05VpgV0g==
X-Received: by 2002:a17:90b:408e:b0:28d:29ea:25f8 with SMTP id jb14-20020a17090b408e00b0028d29ea25f8mr4237296pjb.72.1705431445732;
        Tue, 16 Jan 2024 10:57:25 -0800 (PST)
Received: from localhost (dhcp-72-235-13-140.hawaiiantel.net. [72.235.13.140])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902c3c500b001d5e7afe97csm1567559plj.152.2024.01.16.10.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 10:57:25 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 16 Jan 2024 08:57:24 -1000
From: Tejun Heo <tj@kernel.org>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/4] kernel/workqueue: Distinguish between general
 unbound and WQ_SYSFS cpumask changes
Message-ID: <ZabRlEklmuqwFPj-@slm.duckdns.org>
References: <20240116161929.232885-1-juri.lelli@redhat.com>
 <20240116161929.232885-4-juri.lelli@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116161929.232885-4-juri.lelli@redhat.com>

Hello, Juri.

On Tue, Jan 16, 2024 at 05:19:28PM +0100, Juri Lelli wrote:
> Both general unbound cpumask and per-wq (WQ_SYSFS) cpumask changes end
> up calling apply_wqattrs_prepare for preparing for the change, but this
> doesn't work well for general unbound cpumask changes as current
> implementation won't be looking at the new unbound_cpumask.
> 
> Fix the prepare phase for general unbound cpumask changes by checking
> which type of attributes (general vs. WQ_SYSFS) are actually changing.
> 
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> ---
>  kernel/workqueue.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 3a1d5a67bd66a..2ef6573909070 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -4359,7 +4359,17 @@ apply_wqattrs_prepare(struct workqueue_struct *wq,
>  	 * it even if we don't use it immediately.
>  	 */
>  	copy_workqueue_attrs(new_attrs, attrs);
> -	wqattrs_actualize_cpumask(new_attrs, unbound_cpumask);
> +
> +	/*
> +	 * Is the user changing the general unbound_cpumask or is this a
> +	 * WQ_SYSFS cpumask change?
> +	 */
> +	if (attrs == wq->unbound_attrs)
> +		cpumask_copy(new_attrs->cpumask, unbound_cpumask);
> +	else
> +		wqattrs_actualize_cpumask(new_attrs, unbound_cpumask);
> +
> +	cpumask_and(new_attrs->cpumask, new_attrs->cpumask, cpu_possible_mask);

This looks rather hacky. Can you elaborate how the current code misbehaves
with an example? For the unbound_cpumask update path, the intention is
supplying the current ->attrs (wq user's request) and the new
unbound_cpumask expecting wqattrs_actualize_cpumask() to do the right thing.
Is the problem that you want to have access to the effective cpumask for the
entire workqueue? If so, we don't want to do that with ctx->attrs as that's
supposed to carry the user's requested configuration rather than the
currently effective. We can just add a new field.

>  	cpumask_copy(new_attrs->__pod_cpumask, new_attrs->cpumask);
>  	ctx->dfl_pwq = alloc_unbound_pwq(wq, new_attrs);
>  	if (!ctx->dfl_pwq)
> @@ -4377,12 +4387,7 @@ apply_wqattrs_prepare(struct workqueue_struct *wq,
>  		}
>  	}
>  
> -	/* save the user configured attrs and sanitize it. */
> -	copy_workqueue_attrs(new_attrs, attrs);
> -	cpumask_and(new_attrs->cpumask, new_attrs->cpumask, cpu_possible_mask);
> -	cpumask_copy(new_attrs->__pod_cpumask, new_attrs->cpumask);
>  	ctx->attrs = new_attrs;

This part exists to store the user requested configuration rather than the
applied effective configuration, so that e.g. later if the unbound_cpumask
changes, we can apply the effective mask according to the user's latest
requested configuration. I'm not sure why this is being dropped.

Thanks.

-- 
tejun

