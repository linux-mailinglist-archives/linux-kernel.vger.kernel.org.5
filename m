Return-Path: <linux-kernel+bounces-48888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 217768462D9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 458721C22D13
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3D340BF4;
	Thu,  1 Feb 2024 21:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBFiEO6J"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0EE3EA67;
	Thu,  1 Feb 2024 21:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706824064; cv=none; b=NuKKlcpkoqbadF0AeC3gPbuSHAcL7PT/barLHHtV1Hbca5Fkl7B9MJQpuZ0ka+8cLHh4IBsyzbo3i59DGytNmvM8LNsMxlI/NXxS2CT6skbmix2DH5wjkdfl3cw8IEgKr3rPrQDDedrugaMbQFXu3ZK965ya5anTKXnZxsPhWB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706824064; c=relaxed/simple;
	bh=i8ei3/3iBku7zImBxqYUtsEsmTLhfHzH/Wx7NbUnqrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqcIN4hQmiMyp71pZqxmm5jIKRYLbEI+HgYwiO8XdmeP36OiSeUH7B4AiLQOKPlB86M7+ZixOuRO7Joq/3CJmq/laCF8nDANEeJs/atnT4NSJ1rs6ZcVz3WNnOPsluksGiJvQbsFpqmRaPGzWkXtkaaAxFI9WLaQ1N88D3dXOW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBFiEO6J; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d731314e67so10774005ad.1;
        Thu, 01 Feb 2024 13:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706824062; x=1707428862; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vPELX+OiDIyvT/Bzm5WtNE+XaH+punLg9rt/elSB1q8=;
        b=iBFiEO6J/Mrel9qbWzWAMtJwQ1ib6Ol0u9uKMAjb1gd9sVeQ8MY34yDzYCyvF/s0hG
         N8QAcrtPuTiE6SPdjNyV+mjhwy2aOkVcwLNv/BYQ/tzrJ9TMz+RFMhPArrup2J6laBNg
         24Cq6tKC6GcH8b5Qdw6nYpi9gjFtA/bQZ0uDcVnpKgLUYG3kcKrVcUOdI3Yc0PKsX+re
         jseGCB7Yze5RGt/po7kEDgfYUXnBs1xrapkmRQwu5wx32pzo2NbQ6RkIkvhJ7oA9qXaj
         9l03TFiCeDsCwVqmLyDcPJUKAKjbrFssD1zc8wTZgQ9elTaMLgmeuqKC8wXh9r9Spn5K
         R0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706824062; x=1707428862;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vPELX+OiDIyvT/Bzm5WtNE+XaH+punLg9rt/elSB1q8=;
        b=OuNTa8yCIHEqrf60/bRzpuPAlPc7ex25GMJZKzPsD/BJMEl74rIGxKZ/MNxMHjZBmz
         udswSWXbooNdPu/grMONOxfXoaxyRow9SdVoArBRCvAT5rpnQQqcufaKUM3Zz4U20BKG
         5PrO8ESWnTb+hZPXOzPoZdDeH32mkQeW71T77PBh8yLCCKI12k2zqERng7taSQ9UOVif
         bDi6x5UFIP6dY1r1glQd/bexuRsdHyE75/Y/JOgocnQZ0T5iQLyHzgY0C+YdpBPRlSSC
         0IBpM3h40rdsFFapUvJ5jY99vaRVCO9KKqJflWqG5B9z+rfTnZ98JnnFE2uF2uTAvu1z
         5+fA==
X-Gm-Message-State: AOJu0YwRgqwuod04NUMxkc4OydSUQHRX+Yg+4JLhNmcdut5bu+UFesLl
	j6roPj00r8KNnZnzclcJm1Kjw5TmBV7nXRcHYMjfvNiBW8qWKtVW
X-Google-Smtp-Source: AGHT+IFmOk7TPgqBwYIoA82SSiSOedzORPryco3JEl3jmuOGX1BvCgU9mm1bLtu2enwAk2GrAVN3tw==
X-Received: by 2002:a17:902:8602:b0:1d3:45c8:bc0f with SMTP id f2-20020a170902860200b001d345c8bc0fmr3418205plo.46.1706824061997;
        Thu, 01 Feb 2024 13:47:41 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXhQWjH/0bDIcgXc1KerryMZkSeZmS/dDISMhFwIRX2ML9fFJ2t6J3eiLURpm60C9TmPMfkaej25NFDYbHlhR4AuoXleb07R/6w8q9CFq4o5zZfu3we+5Jv6Gf0ul9Uqokb97GgA3tt7KWEGNm1209Gj0mMulTpjMwyGqR5t6lnHyAxRyVwDx4oFW2wn0gdjKVgNi1qpJ6IXUo8ApCiKn/t4iHKzEf1PUnAY8BHc0iaHiXcVgFZUGAxY8tLO1UH5fw4yjXV0QTmNeLm+vOLyPCs/kNFARJF+GuJbfz6Z1ZeyLDeIn76BJLPyXZopRo5aTdWhkU7ntqRVh2yAJaxuAkG7po9lNW3BA2mXYsHWAXh7hR2PP2+m0gkktHI1PeBT4U1VjYuABhqoKjPmP8M2hsmVTHSFfjGPnWQa5iXNvZ01cO0CigbAWZ2/BDLR4XfgsfvhIB219UIIlGik4jSLtFgzXIk
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id ji7-20020a170903324700b001d944bf2d83sm301249plb.7.2024.02.01.13.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 13:47:41 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 1 Feb 2024 11:47:40 -1000
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: torvalds@linux-foundation.org, mpatocka@redhat.com,
	linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev,
	msnitzer@redhat.com, ignat@cloudflare.com, damien.lemoal@wdc.com,
	bob.liu@oracle.com, houtao1@huawei.com, peterz@infradead.org,
	mingo@kernel.org, netdev@vger.kernel.org, allen.lkml@gmail.com,
	kernel-team@meta.com
Subject: Re: [PATCH 3/8] workqueue: Implement BH workqueues to eventually
 replace tasklets
Message-ID: <ZbwRfHCfss2THOeX@slm.duckdns.org>
References: <20240130091300.2968534-1-tj@kernel.org>
 <20240130091300.2968534-4-tj@kernel.org>
 <CAJhGHyCk_cjD-Ex_OAd=DrBkTEe0Xvs81=On65Sp7sS8zNBfGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJhGHyCk_cjD-Ex_OAd=DrBkTEe0Xvs81=On65Sp7sS8zNBfGQ@mail.gmail.com>

Hello, Lai.

On Thu, Feb 01, 2024 at 07:02:27PM +0800, Lai Jiangshan wrote:
> On Tue, Jan 30, 2024 at 5:16 PM Tejun Heo <tj@kernel.org> wrote:
> > @@ -1184,6 +1211,14 @@ static bool kick_pool(struct worker_pool *pool)
> >         if (!need_more_worker(pool) || !worker)
> >                 return false;
> >
> > +       if (pool->flags & POOL_BH) {
> > +               if (pool->attrs->nice == HIGHPRI_NICE_LEVEL)
> > +                       tasklet_hi_schedule(&worker->bh_tasklet);
> > +               else
> > +                       tasklet_schedule(&worker->bh_tasklet);
> > +               return true;
> > +       }
> 
> I think it is more straightforward to call bh_worker_taskletfn[_hi]()
> in tasklet_action() and tasklet_hi_action() rather than add a
> worker->bh_tasklet.
> 
> raise_softirq_irqoff() can be used here (kick_pool()) instead.
> 
> As the changelog said, once the conversion is complete, tasklet can be
> removed and BH workqueues can directly take over the tasklet softirqs,
> in which case, then, bh_worker_taskletfn[_hi]() can directly take over
> the tasklet_action() and tasklet_hi_action().

Hmmm.... maybe. Yeah, that'd also make it a tiny bit cheaper for hot paths.
Lemme see how that looks.

> I think wq->max_active can be forced to be UINT_MAX or ULONG_MAX
> in the max_active management code to avoid a branch here.

Good point. Will update.

> worker_attach_to_pool() and worker_detach_from_pool also access to
> worker->task with kthread_set_per_cpu() and luckily to_kthread()
> checks the NULL pointer for it.
> 
> IMO, it is better to avoid calling kthread_set_per_cpu() for bh workers.

Note that BH worker pools are always DISASSOCIATED, so
worker_attach_to_pool() shouldn't call kthread_set_per_cpu(). Also, BH
workers and worker pools are never destroyed, so worker_detach_from_pool()
shouldn't be called either. I'll add WARN_ONs to clarify.

> > @@ -5605,7 +5731,12 @@ static void pr_cont_pool_info(struct worker_pool *pool)
> >         pr_cont(" cpus=%*pbl", nr_cpumask_bits, pool->attrs->cpumask);
> >         if (pool->node != NUMA_NO_NODE)
> >                 pr_cont(" node=%d", pool->node);
> > -       pr_cont(" flags=0x%x nice=%d", pool->flags, pool->attrs->nice);
> > +       pr_cont(" flags=0x%x", pool->flags);
> > +       if (pool->flags & POOL_BH)
> > +               pr_cont(" bh%s",
> > +                       pool->attrs->nice == HIGHPRI_NICE_LEVEL ? "-hi" : "");
> > +       else
> > +               pr_cont(" nice=%d", pool->attrs->nice);
> 
> There are also some "worker->task" in show_pwq(), show_one_worker_pool(),
> and show_cpu_pool_hog() needing taking care of.

Ah, right, I'll hunt them down. 

Thanks.

-- 
tejun

