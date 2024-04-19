Return-Path: <linux-kernel+bounces-151993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFB48AB71E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 00:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE4401F22043
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 22:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7B913D287;
	Fri, 19 Apr 2024 22:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBUVhb7G"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC08712DD97;
	Fri, 19 Apr 2024 22:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713564834; cv=none; b=UzpuKnjhrLR8Z0zuO+ZhUYA3JrOETcmT4qnSEoU+S6GPWKRB4hb8VwqPRbTwsXV7VBH4obaCISlnj398tHtpDYjgJ7qCqpCs8CeRNJprK3WH1Q1dtEuDmsD1lUqNmgwJOS6gh7uX9F/myocdDr/Cp7/8SjhSkk1zp5/iOkvZKk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713564834; c=relaxed/simple;
	bh=4RCTcwheMb+Q4EVU5iBIoEbIEMFY5NKFObbcFjjXIbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NdV/qW8SGG8F5CfJrGQnzMnHcCtekLwjBsCiUtU/L8+IaYtDmbWyoje/hWBH0mckXdGUkNT7zbvJmnT/oV7yjosH/w9eqMfMcrQvEA59rEgbF5dfxMp0nBqyz7Uw9dGU0M6ISZKqyTLToN8K0dW5XNBQyQ0knSY8LGNMnBueOIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBUVhb7G; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-61b2218ab6fso19151057b3.1;
        Fri, 19 Apr 2024 15:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713564831; x=1714169631; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XLemlwrfOOHHIdLYfovzq1+tB6FxSufcqxpxI2QR6C4=;
        b=eBUVhb7GtmQP5q1TjYAWoU40THJtXmg/ihX9CGCsKx2/VC4CZ3mLPV8Y1G75gok1YM
         JuFG5I5hyw6mYtBteTa1ZESMPp35EVaVBE3fd7jpsV+8+G2t/vkhDrxkznBLcL0e1isp
         f/fhdADRmBaBxRMXjWp8oZVK52aR1lEHPc6T+niyXJ1KTDsg1nyMsV2enhfFOyovkV6r
         VLVZXhSZfWsZ/Hwn3DOjSOxAFCIK4oNsBfApJW3GjWAjoXAVbI/cj5sFpVLhr9jOtXw5
         XmJQ93jmovdAcDLfCra4rz2DUCruXl0W8DsaTloaPyFjiOB4hizsHMfv6hwUXnM4AV66
         KZ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713564831; x=1714169631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XLemlwrfOOHHIdLYfovzq1+tB6FxSufcqxpxI2QR6C4=;
        b=mmy7QT7h5duNhgkENtiNUaNCTFhdNlxWYdYLKEJZFsts7Wt/pdxczrgDO5r/4QBwOn
         i5mzXzbqbpdNx38tL5CSLjOQOJja1UjM6yk03NmFwVBnndQNiy+gShhgkMBZQ52xRWF6
         gYJmKaFu59WgW/vhtq5li4ymRZtp8Lr0XBJ09aP87Q1v9z66p2jdrD8ofcVOmhsq9l5Q
         POzsbt29EqcsEtcwoPgCMBLqLuGI90G1XGHNxwolfgIi2/VWRiiU/zQs1+0B9FE0z1QU
         4UG2vDejwFErgm8MvE8ka77ODL+0g9SKxZ2LggtPZPNGRuqPBBJFG4ZmgrkM+ozi+dB/
         ziYw==
X-Forwarded-Encrypted: i=1; AJvYcCU40pt8BzujvgtmJYSpB6BJZG6G+z0MwHhLapZSIq4NiWxDiCjklRgUePXZwSISGWCXBCWmc9q5JzG0T6h/QJwBXKyf7zUL+5QL/X9RdQfRiNbD5mDS3M4Wd8fWCx3Ow80JYmOmQ/dOUg==
X-Gm-Message-State: AOJu0YxUpKHNGyJYBV/DroyTfTS0wku6/5mibdPsfv8Zzzz02f5Mzprr
	SS72X3r3J6kAexk9pkcxt4NqZ/J/B4vSGEXyQpXXWJNnuedHSnYlteJkFw==
X-Google-Smtp-Source: AGHT+IH2N5eKsc9Rjjtj4X/zIbgz/X9/U8Xd5WX+HS2hQDR9mjWXz5YG8AgO+0yMV+9ZfE7ZaY/OSg==
X-Received: by 2002:a05:690c:301:b0:618:2972:ee3b with SMTP id bg1-20020a05690c030100b006182972ee3bmr3438512ywb.39.1713564831483;
        Fri, 19 Apr 2024 15:13:51 -0700 (PDT)
Received: from localhost ([2601:344:8301:57f0:7f85:3703:8b1a:b551])
        by smtp.gmail.com with ESMTPSA id m190-20020a0dfcc7000000b006187ad29fe8sm957045ywf.61.2024.04.19.15.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 15:13:50 -0700 (PDT)
Date: Fri, 19 Apr 2024 15:13:49 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Dawei Li <dawei.li@shingroup.cn>
Cc: Sam Ravnborg <sam@ravnborg.org>, davem@davemloft.net,
	andreas@gaisler.com, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Remove onstack cpumask var usage
Message-ID: <ZiLsnWCwKeg4B65a@yury-ThinkPad>
References: <20240418104949.3606645-1-dawei.li@shingroup.cn>
 <20240419051350.GA558245@ravnborg.org>
 <A60F94A9589C8589+ZiI4yj073cgmt5Qq@centos8>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A60F94A9589C8589+ZiI4yj073cgmt5Qq@centos8>

On Fri, Apr 19, 2024 at 05:26:34PM +0800, Dawei Li wrote:
> Hi Sam,
> 
> Thanks for the review.
> 
> On Fri, Apr 19, 2024 at 07:13:50AM +0200, Sam Ravnborg wrote:
> > Hi Dawei,
> > 
> > On Thu, Apr 18, 2024 at 06:49:44PM +0800, Dawei Li wrote:
> > > Hi,
> > > 
> > > This series aims at removing on-stack cpumask var usage for sparc arch.
> > > 
> > > Generally it's preferable to avoid placing cpumasks on the stack, as
> > > for large values of NR_CPUS these can consume significant amounts of
> > > stack space and make stack overflows more likely.
> > 
> > Took a quick look at the patches, looks good except the one the bot
> > already complained about.
> 
> I will fix this building warning in respinning.
> 
> > A quick grep shows a few more cases where we have an on-stack cpumask
> > in sparc code.
> > 
> > kernel/ds.c:    cpumask_t mask;
> 
> About this case, it's kinda tricky for:
> - dr_cpu_data() returns void, so alloc_cpumask_var() is no go.
> 
> - No idea of the calling context of dr_cpu_data(). IIUC,
>   dr_cpu_data()
>   ->dr_cpu_configure()  
>    ->kzalloc(resp_len, GFP_KERNEL)
>   So I guess it's in process context?
>   If consumption above is OK, a simple but _ugly_ solution could be:
> 
> diff --git a/arch/sparc/kernel/ds.c b/arch/sparc/kernel/ds.c
> index ffdc15588ac2..c9e4ebdccf49 100644
> --- a/arch/sparc/kernel/ds.c
> +++ b/arch/sparc/kernel/ds.c
> @@ -634,7 +634,8 @@ static void dr_cpu_data(struct ds_info *dp, struct ds_cap_state *cp, void *buf,
>         struct dr_cpu_tag *tag = (struct dr_cpu_tag *) (data + 1);
>         u32 *cpu_list = (u32 *) (tag + 1);
>         u64 req_num = tag->req_num;
> -       cpumask_t mask;
> +       static DEFINE_MUTEX(mask_lock);
> +       static cpumask_t mask;
>         unsigned int i;
>         int err;
> 
> @@ -651,6 +652,8 @@ static void dr_cpu_data(struct ds_info *dp, struct ds_cap_state *cp, void *buf,
> 
>         purge_dups(cpu_list, tag->num_records);
> 
> +       mutex_lock(&mask_lock);
> +
>         cpumask_clear(&mask);
>         for (i = 0; i < tag->num_records; i++) {
>                 if (cpu_list[i] == CPU_SENTINEL)
> @@ -665,6 +668,8 @@ static void dr_cpu_data(struct ds_info *dp, struct ds_cap_state *cp, void *buf,
>         else
>                 err = dr_cpu_unconfigure(dp, cp, req_num, &mask);
> 
> +       mutex_unlock(&mask_lock);
> +
>         if (err)
>                 dr_cpu_send_error(dp, cp, data);
>  }
> 
> How does it sound to you?
> 
> > kernel/leon_kernel.c:   cpumask_t mask;
> 
> It's in irqchip::irq_set_affinity(), which is in atomic context(raw spinlock(s) held),
> so dynamic allocation is not a good idea.
> 
> My proposal(*untested*) is somewhat complicated for it introduces a new helper.
> 
> diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
> index 4c61da491fee..6eced7acb8bc 100644
> --- a/arch/sparc/kernel/leon_kernel.c
> +++ b/arch/sparc/kernel/leon_kernel.c
> @@ -104,15 +104,25 @@ unsigned long leon_get_irqmask(unsigned int irq)
>  }
> 
>  #ifdef CONFIG_SMP
> +
> +static bool cpumask_include(const struct cpumask *srcp1, const struct cpumask *srcp2)

Don't steal the other's subsystems prefixes.

> +{
> +       unsigned int cpu;
> +
> +       for_each_cpu(cpu, srcp2) {
> +               if (!cpumask_test_cpu(cpu, srcp1))
> +                       return false;
> +       }
> +
> +       return true;
> +}

We've got cpumask_subset() for this. 

>  static int irq_choose_cpu(const struct cpumask *affinity)
>  {
> -       cpumask_t mask;
> +       unsigned int cpu = cpumask_first_and(affinity, cpu_online_mask);
> 
> -       cpumask_and(&mask, cpu_online_mask, affinity);
> -       if (cpumask_equal(&mask, cpu_online_mask) || cpumask_empty(&mask))
> -               return boot_cpu_id;
> -       else
> -               return cpumask_first(&mask);
> +       return cpumask_include(affinity, cpu_online_mask) || cpu >= nr_cpu_ids ?
> +              boot_cpu_id : cpu;
>  }
>  #else
>  #define irq_choose_cpu(affinity) boot_cpu_id
> 
> Is it OK?
> 
> [cc Yury for bitmap API]
> 
> > kernel/leon_smp.c:static void leon_cross_call(void *func, cpumask_t mask, unsigned long arg1,
> > kernel/sun4d_smp.c:static void sun4d_cross_call(void *func, cpumask_t mask, unsigned long arg1,
> 
> Actually I am awared of existence of (at least some of) them, but so far I
> have not found a _proper_ way of dealing with them(especially for case of
> ds.c).
> 
> Please lemme dig into it.
> 
> Thanks,
> 
>     Dawei
> 
> > 
> > Do you plan to look at the other on-stack users too?
> > It would be nice to see them all gone in one patch-set.
> > 
> > 	Sam
> > 

