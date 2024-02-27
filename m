Return-Path: <linux-kernel+bounces-83938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9027986A095
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C8D9B27896
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FDA524DF;
	Tue, 27 Feb 2024 19:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgBHHG8b"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416E52D60B;
	Tue, 27 Feb 2024 19:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709062562; cv=none; b=rqiF6F7NmLG9yFhb30CGCuAG4slbmDK0L4DG5DoLZmvTrI6cNGiDciEbSvFnXO93xuK8igOCK6pZ82tQiiV98VrkFx+yj4L3yfJjXd8+voLyMjqyN/iWq/eq+Gi1dcFPQ1T9QFXzltcCx2lom5EUWDn0AVQwWcWkWf0mLpIRVVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709062562; c=relaxed/simple;
	bh=X+NmQ16htm9KepdSCCA3LOSQmioJnFN1c9C9GgTodUM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FD1ywRIo0BYXtoLAitMXxA6HLB0lsRxWnHtmMwailZX/Aqghc/JGUB6Ikh+JBp4nfHIJ+lAE3hUu2+LRhKGaGl6VNk1BJI/my7QDMlkPmAh6CdzHk3STllzPDkbbZVpCz87VvVFWD3dHbUIRLxjmkPf5Skrwjmt9MHfrHkRRFRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mgBHHG8b; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-512fd840142so3320120e87.2;
        Tue, 27 Feb 2024 11:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709062559; x=1709667359; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tD9VH6E6cPEsmYpWie1f4j7L7wZzShtjynMD+HiK+Hg=;
        b=mgBHHG8b49NsqDzMteq34QpmwK9liPsx9j3WhYbmN0I6IwEQaD7k3xW8d1Yt4Fti5X
         ecttttIBBNxXREnxrsh7rjQ9M3uxBHOYrDgIUWFqdcewGCFkWuBa/9eZ/dUwMFN3eVOM
         vnrW0hs5a1h5xhtx4z20becXKgGGjZCLZUUjkaZQNKCisR3925YFEBTN0kOmDKM/LHiH
         6pct+TY24JR9M815sfV6TFtGJz3jsq9iwRGZ9zrZrvDAx73yZX/YfLxzofWa5duQcvDo
         yhHHge/IEPMrBXArTp69S3YxymN934WQG4iqAdWalxz0C5F09jVOFHOmOcLsIfpatEir
         7+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709062559; x=1709667359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tD9VH6E6cPEsmYpWie1f4j7L7wZzShtjynMD+HiK+Hg=;
        b=qCrfxRCclwxY3O6GAHe8pW+iiCglkano3o1JT3eFSHf6MO+ft4lw5yM2cXbeJud5vd
         e9HWZfJiv/2uuJJyCCywAMi+hFLn5nkGH/Rvq3UaK8IwTZLDAXa1GmLDgavEqIuXkl7Y
         QgK0eo5TmYTivZMjzv+Li8UQWmUh45G7dvSCzqoomBHazn5gqWhbcysXdDATD4R2cz7k
         ip0AkbaNqgjF3RiZU2SNMDKAAITcXoDE/g0X5HppVe0xRUAGIp8OBLnjrOj9SV3bUr/H
         k6JKkZHMsnx6tRJx/o/uJfa/DVenaBenRwQWAmXzxztd4GYF+WbN7MRWE6JOx0lHWHuN
         P/Qg==
X-Forwarded-Encrypted: i=1; AJvYcCXU2Y4lZKqvnYovf7ufZ0xDrzyYIF4jA5cjJkuW5MsgMDdL9lD9+mZjCjeBKWz98+1Bn0+x0GHSEpY8+lxubi/IuREVfGkuvNaqfux795N4Vzc+zaCIkH+9jv+St45YV2Du
X-Gm-Message-State: AOJu0YyGEqdEZl3PboqVC4XHdFVQCfbvTpdJogDUPl8JGdzOf13gG3IW
	W2+PpCG5YIrpsdiD48T4+tlEUYdHdilwlk5J8ZIFSDDEvjc8BZcE
X-Google-Smtp-Source: AGHT+IEmtznTBWICF55EZiVWIShPadOxbp0eg/fjozpEa0tLgMh88pmZ3kc4A+T1ghCY/treg1MokA==
X-Received: by 2002:a05:6512:31c6:b0:513:c3:1d95 with SMTP id j6-20020a05651231c600b0051300c31d95mr4176167lfe.6.1709062559031;
        Tue, 27 Feb 2024 11:35:59 -0800 (PST)
Received: from pc636 (host-90-233-206-150.mobileonline.telia.com. [90.233.206.150])
        by smtp.gmail.com with ESMTPSA id o9-20020ac25b89000000b00512daba3521sm1274978lfn.173.2024.02.27.11.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 11:35:58 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 27 Feb 2024 20:35:56 +0100
To: Frederic Weisbecker <frederic@kernel.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v5 2/4] rcu: Reduce synchronize_rcu() latency
Message-ID: <Zd45nHulMXQx1dJo@pc636>
References: <20240220183115.74124-1-urezki@gmail.com>
 <20240220183115.74124-3-urezki@gmail.com>
 <Zd0ZtNu+Rt0qXkfS@lothringen>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zd0ZtNu+Rt0qXkfS@lothringen>

> On Tue, Feb 20, 2024 at 07:31:13PM +0100, Uladzislau Rezki (Sony) wrote:
> > +static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
> > +{
> > +	struct llist_node *done, *rcu, *next, *head;
> > +
> > +	/*
> > +	 * This work execution can potentially execute
> > +	 * while a new done tail is being updated by
> > +	 * grace period kthread in rcu_sr_normal_gp_cleanup().
> > +	 * So, read and updates of done tail need to
> > +	 * follow acq-rel semantics.
> > +	 *
> > +	 * Given that wq semantics guarantees that a single work
> > +	 * cannot execute concurrently by multiple kworkers,
> > +	 * the done tail list manipulations are protected here.
> > +	 */
> > +	done = smp_load_acquire(&rcu_state.srs_done_tail);
> > +	if (!done)
> > +		return;
> > +
> > +	WARN_ON_ONCE(!rcu_sr_is_wait_head(done));
> > +	head = done->next;
> > +	done->next = NULL;
> 
> Can the following race happen?
> 
> CPU 0                                                   CPU 1
> -----                                                   -----
> 
> // wait_tail == HEAD1
> rcu_sr_normal_gp_cleanup() {
>     // has passed SR_MAX_USERS_WAKE_FROM_GP
>     wait_tail->next = next;
>     // done_tail = HEAD1
>     smp_store_release(&rcu_state.srs_done_tail, wait_tail);
>     queue_work() {
>         test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work)
>         __queue_work()
>     }
> }
> 
>                                                       set_work_pool_and_clear_pending()
>                                                       rcu_sr_normal_gp_cleanup_work() {
> // new GP, wait_tail == HEAD2
> rcu_sr_normal_gp_cleanup() {
>     // executes all completion, but stop at HEAD1
>     wait_tail->next = HEAD1;
>     // done_tail = HEAD2
>     smp_store_release(&rcu_state.srs_done_tail, wait_tail);
>     queue_work() {
>         test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work)
>         __queue_work()
>     }
> }
>                                                           // done = HEAD2
>                                                           done = smp_load_acquire(&rcu_state.srs_done_tail);
>                                                           // head = HEAD1
>                                                           head = done->next;
>                                                           done->next = NULL;
>                                                           llist_for_each_safe() {
>                                                               // completes all callbacks, release HEAD1
>                                                           }
>                                                       }
>                                                       // Process second queue
>                                                       set_work_pool_and_clear_pending()
>                                                       rcu_sr_normal_gp_cleanup_work() {
>                                                           // done = HEAD2
>                                                           done = smp_load_acquire(&rcu_state.srs_done_tail);
> 
>
> // new GP, wait_tail == HEAD3
> rcu_sr_normal_gp_cleanup() {
>     // Finds HEAD2 with ->next == NULL at the end
>     rcu_sr_put_wait_head(HEAD2)
>     ...
> 
> // A few more GPs later
> rcu_sr_normal_gp_init() {
>      HEAD2 = rcu_sr_get_wait_head();
>      llist_add(HEAD2, &rcu_state.srs_next);
>                                                           // head == rcu_state.srs_next
>                                                           head = done->next;
>                                                           done->next = NULL;
>                                                           llist_for_each_safe() {
>                                                               // EXECUTE CALLBACKS TOO EARLY!!!
>                                                           }
>                                                       }
Let me check it tomorrow!

--
Uladzislau Rezki

