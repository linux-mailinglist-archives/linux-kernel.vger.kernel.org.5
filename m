Return-Path: <linux-kernel+bounces-84759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 624ED86AB25
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C5991C2224B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8306132189;
	Wed, 28 Feb 2024 09:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCDM0jy7"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1106D36103;
	Wed, 28 Feb 2024 09:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709112497; cv=none; b=arJn3KSLalsofvCC4ruXFpL7qKIynMLn4pZWX3dVyjpb/d1xppq4g34Ni8QFfs2qYVkOZgw7l4D2v4pDZiyLxLvz1u5/LwfDRbzYhDps5+RV0XlUqvKVfNuhfrKRmFWfzcauxEJBzofzy6EM4pZwRAdkJXf+gI5y1slAe5Qe9yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709112497; c=relaxed/simple;
	bh=U9dihVgHrwLV647kosEhX6QDdv2LPSGr7BqD90UgUyg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1hyc98FI2vjfx8YFQu/m9P/7N2u59OeagBJytgQA4OBAuR8FUEg6r+Mp35xQYWdQJbst2dMc7Uu5o6MrN5qeos7u7RLxmjD2gBB1N9lYUwSeFD2safqAP+YCycJM92NSOmHedtCSd9fBNekUhfTpbEfUOF5U0NPORZuT7ee4cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nCDM0jy7; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d22b8801b9so84943051fa.0;
        Wed, 28 Feb 2024 01:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709112494; x=1709717294; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oGK72162MdnLwFLf7GIA1kmtXhXPTiOIV5c3HATo7ik=;
        b=nCDM0jy7giOGSP8eleXSuBhe5CScHUjXCDL+dM+xZ4rO2UXQpDk1SzMOhBhId36kYU
         iYPS6Nu3pI2gTjrpP5zpSk+GiIq3YhS9gzDmO4p6YDqRt1nOqaUlf/It91+2W1wf/ZKn
         qNxPBpD80S1ZWBvcYbHgp4tk09tRemomKHyWXAb5SgEFAIBtCOfHEHFJeG2ypCakrXjv
         7AbROB13fWweAKsFXQJO21zVk2SvtWXamP1Uw9Zqyswckl2uNBmjxsTkFEksbUuxWIuy
         Vq4NellXXB5ufaNFdL71T+ZI5GqVFVdQ+pt04/bPRDX4nosJFyip1y2c6Ptu+lBzvnYR
         5DyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709112494; x=1709717294;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGK72162MdnLwFLf7GIA1kmtXhXPTiOIV5c3HATo7ik=;
        b=g8ZIzg2uCgnCaKOECbezBULtnuI7tTPLOiOzh0cfq5tMa86FSD6GXYioVWSlKZjgoU
         6s5tL7jE6WMi3a2bfoBbGhTpeu8lqTcjb4GW0Vl7mINVSeutzp2b84MGeOirQl4d0LKV
         ZENdTXbAjMpy14M52CUP71JySyAA3xBB++KZ0975BnPdP6M5SPV6aVjD4ssv5LsupIqz
         nij/23NjAw6bdLEaweI1b6HfbQODoSxIuGEa8hGZmX6HTyOHkGcUPwg0vGD26fPuyOkr
         VT9GecbC08c91AEcTbgHY5atR5T70kW/cQHBX8yy+V3lVuwFcwxMTZpwuby1k08+x3sb
         vg/w==
X-Forwarded-Encrypted: i=1; AJvYcCVAeeQIWcyJFjL4KxriryEyNaPG+ReVcdHZgNV2ZlWNlKTB6EqYCON5pfoRY1Vq3GoiXHDDkYfTIvn1pAmveta3a/P609IL4FCsOswk9I5C+EAHJ07n8MInVfW76I/14Cl5
X-Gm-Message-State: AOJu0YwbzMnxFaPWxYd/P3I5hGCD39KupTQZji/YHp/f7ChKfeAt7DWd
	F5nJdY3nR1pb75tSUvECMni0Zo0Bjb8h5ueAXs97l/CqOFAAyF4g
X-Google-Smtp-Source: AGHT+IF7bSJ7qwbMinklPhUTqQyYaA8Y4QFrquCejoltWNYZsBBYAbcVEkNCwF2ZLB7WYDxGgTsP/Q==
X-Received: by 2002:a05:651c:231d:b0:2d2:3db6:b168 with SMTP id bi29-20020a05651c231d00b002d23db6b168mr6531995ljb.14.1709112493868;
        Wed, 28 Feb 2024 01:28:13 -0800 (PST)
Received: from pc636 (host-90-233-206-150.mobileonline.telia.com. [90.233.206.150])
        by smtp.gmail.com with ESMTPSA id w18-20020a2ea3d2000000b002d25c81fb30sm1532737lje.94.2024.02.28.01.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 01:28:13 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 28 Feb 2024 10:28:11 +0100
To: Joel Fernandes <joel@joelfernandes.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v5 2/4] rcu: Reduce synchronize_rcu() latency
Message-ID: <Zd78qzAGeriKUxBi@pc636>
References: <20240220183115.74124-1-urezki@gmail.com>
 <20240220183115.74124-3-urezki@gmail.com>
 <c8182a5a-e804-4fcc-a6a5-bb121260e6a6@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8182a5a-e804-4fcc-a6a5-bb121260e6a6@joelfernandes.org>

On Tue, Feb 27, 2024 at 03:51:03PM -0500, Joel Fernandes wrote:
> 
> 
> On 2/20/2024 1:31 PM, Uladzislau Rezki (Sony) wrote:
> > A call to a synchronize_rcu() can be optimized from a latency
> > point of view. Workloads which depend on this can benefit of it.
> > 
> > The delay of wakeme_after_rcu() callback, which unblocks a waiter,
> > depends on several factors:
> > 
> > - how fast a process of offloading is started. Combination of:
> >     - !CONFIG_RCU_NOCB_CPU/CONFIG_RCU_NOCB_CPU;
> >     - !CONFIG_RCU_LAZY/CONFIG_RCU_LAZY;
> >     - other.
> > - when started, invoking path is interrupted due to:
> >     - time limit;
> >     - need_resched();
> >     - if limit is reached.
> > - where in a nocb list it is located;
> > - how fast previous callbacks completed;
> > 
> > Example:
> > 
> > 1. On our embedded devices i can easily trigger the scenario when
> > it is a last in the list out of ~3600 callbacks:
> > 
> > <snip>
> >   <...>-29      [001] d..1. 21950.145313: rcu_batch_start: rcu_preempt CBs=3613 bl=28
> > ...
> >   <...>-29      [001] ..... 21950.152578: rcu_invoke_callback: rcu_preempt rhp=00000000b2d6dee8 func=__free_vm_area_struct.cfi_jt
> >   <...>-29      [001] ..... 21950.152579: rcu_invoke_callback: rcu_preempt rhp=00000000a446f607 func=__free_vm_area_struct.cfi_jt
> >   <...>-29      [001] ..... 21950.152580: rcu_invoke_callback: rcu_preempt rhp=00000000a5cab03b func=__free_vm_area_struct.cfi_jt
> >   <...>-29      [001] ..... 21950.152581: rcu_invoke_callback: rcu_preempt rhp=0000000013b7e5ee func=__free_vm_area_struct.cfi_jt
> >   <...>-29      [001] ..... 21950.152582: rcu_invoke_callback: rcu_preempt rhp=000000000a8ca6f9 func=__free_vm_area_struct.cfi_jt
> >   <...>-29      [001] ..... 21950.152583: rcu_invoke_callback: rcu_preempt rhp=000000008f162ca8 func=wakeme_after_rcu.cfi_jt
> >   <...>-29      [001] d..1. 21950.152625: rcu_batch_end: rcu_preempt CBs-invoked=3612 idle=....
> > <snip>
> > 
> > 2. We use cpuset/cgroup to classify tasks and assign them into
> > different cgroups. For example "backgrond" group which binds tasks
> > only to little CPUs or "foreground" which makes use of all CPUs.
> > Tasks can be migrated between groups by a request if an acceleration
> > is needed.
> > 
> > See below an example how "surfaceflinger" task gets migrated.
> > Initially it is located in the "system-background" cgroup which
> > allows to run only on little cores. In order to speed it up it
> > can be temporary moved into "foreground" cgroup which allows
> > to use big/all CPUs:
> > 
> > cgroup_attach_task():
> >  -> cgroup_migrate_execute()
> >    -> cpuset_can_attach()
> >      -> percpu_down_write()
> >        -> rcu_sync_enter()
> >          -> synchronize_rcu()
> 
> We should do this patch but I wonder also if cgroup_attach_task() usage of
> synchronize_rcu() should actually be using the _expedited() variant (via some
> possible flag to the percpu rwsem / rcu_sync).
> 
> If the user assumes it a slow path, then usage of _expedited() should probably
> be OK. If it is assumed a fast path, then it is probably hurting latency anyway
> without the enablement of this patch's rcu_normal_wake_from_gp.
> 
> Thoughts?
> 
How i see it, the rcu_normal_wake_from_gp is disabled so far. We need to
work on this further to have it on by default. But we will move toward
this.


> Then it becomes a matter of how to plumb the expeditedness down the stack.
> 
> Also, speaking of percpu rwsem, I noticed that percpu refcounts don't use
> rcu_sync. I haven't looked closely why, but something I hope to get time to look
> into is if it can be converted over and what benefits would that entail if any.
> 
> Also will continue reviewing the patch. Thanks.
> 
Thanks.

--
Uladzislau Rezki

