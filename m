Return-Path: <linux-kernel+bounces-85500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B12FC86B6AB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 991821C22B5B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A5B79B73;
	Wed, 28 Feb 2024 18:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErxEuFLz"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E22779B6D;
	Wed, 28 Feb 2024 18:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709143467; cv=none; b=imoYCknuv4w3caI4Oc1nNIXLk55cV4ANXOiwI+4DuijE/WILbnAUqcIQK8prVGoFCz6YCVZRR1MqM85/Mdk/mpgRJO/C01Uo2Y+7LVeqXvtM/Mm7SQCph+aLJO/IMVSMnmBfNADM+TvQFXzWcMz339v6TRwH0NOK1WhVXV7ONvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709143467; c=relaxed/simple;
	bh=N6U2+QaW5VeXwZH1HC6wjUMQVkEbc2qw2QuDIpP+log=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKnr/pt9XWbWaV7Qto0ssBfi9l7gpYHNx0I8APcX54m8jbuG8ZFMcNONatNuWcDA6BzP4wMSyg79STR/bj6nyTIzn8bUa/Uv6HzHQ4EHHLc9rFJDmhK7IfbAH5C0G7cB39uANOqYiRSyeRw+EYRDIoPXwhLW7VwtmjsO2ajVzVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ErxEuFLz; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d28464c554so57296261fa.3;
        Wed, 28 Feb 2024 10:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709143464; x=1709748264; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bBF352Tfti3FMF3gl2ozPiENjZpzK1rD95Ac73/ICZg=;
        b=ErxEuFLz07eVvCknuXKL8nMbW8WuICGVzzWX1gHZp4o4RJ9/CJbVHjTaxUQ+YcPOQr
         6fC61ZxJxFy6HyYrb+E8HR3Qggg161SvMwIcKBc4ugewv7Uy5gwtkGhruThNzZsQn349
         q/UZHQ6FIXQTRtRRx5+TqGW2mN8YYDsr2jrgoa/cK54d+hGJRTAzP2XeE/CSYxYy+ccr
         YIEjj4D8GBivDnhmUv8JqN+2kdnU+D9gGWwmtXNGBocglApnEZQGVuBt3fZsUr7pjw3B
         VO7+oL++GnOdHfEi9cOPQyAcECl9PUvTy2ZRWEgKC6RVHrUZUx+k8fCOvQf+cJpJcy6M
         7ZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709143464; x=1709748264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBF352Tfti3FMF3gl2ozPiENjZpzK1rD95Ac73/ICZg=;
        b=cMBT8mPcq1ZATB4/c5zAn1ka8WVPG1KsUrLaKiwY42R2O0HeqzAU0gHPuURSjxGQqN
         aULVyupd7zRvmfoh5UScXqcmGV8qsllMoLW21H4J/VgbArfKlkITe8h/xk+veWv44Ox9
         3TShX6Pbxqel5vMXlmwhEp9rJBrsugjZHyI1p0VRISyIwuLueWhjxf656kuK1by04a+j
         KykIwrfTA2HCnm6hIHFpAvYYNhLOWhUmmEmf/LCqv7Vgch3dR+iL+z0CQHmkeYWvkq1s
         AvvwOk7vsodM+RyjlVHppt0TSREn4g1uPzBD/DeLc4k/OFs8Yu+GCJ32VdlXWYPqeCqo
         5coQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+Ub/iFeUDJnL/n9uRj84j3E76KqRLEf6CKpVjrLUmEXQKdDtcR4r6YMU/sL61Ke9FfwQeB8enAXHR2Amn8cJ7dE8zdLFOWu1ApPNUb2cGFIqJiGKIkFsDs0wHxylmbaw2
X-Gm-Message-State: AOJu0YyqZmNmfnR8Inhn0okB3lX4AthGkYYvUG3tHqv3pqSNlJp8gR/D
	VSisUwOcASyLVzAsYzIFcUHhjfLwOXMWEUHj7+pAH2hn8SE2Dqz7
X-Google-Smtp-Source: AGHT+IEF9xAODB4cRUxwgi6tfpfkRGio1fqe/Hz0ad8tgoBMhmAJu28NLDgCW+e6vLlL3ynMQxrN8g==
X-Received: by 2002:a2e:8e95:0:b0:2d2:e51f:2ba2 with SMTP id z21-20020a2e8e95000000b002d2e51f2ba2mr674576ljk.21.1709143463923;
        Wed, 28 Feb 2024 10:04:23 -0800 (PST)
Received: from pc636 (host-90-233-206-150.mobileonline.telia.com. [90.233.206.150])
        by smtp.gmail.com with ESMTPSA id a19-20020a2ebe93000000b002d283718d89sm1468562ljr.56.2024.02.28.10.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 10:04:23 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 28 Feb 2024 19:04:21 +0100
To: Frederic Weisbecker <frederic@kernel.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v5 2/4] rcu: Reduce synchronize_rcu() latency
Message-ID: <Zd91pR0fjiCUZTtP@pc636>
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

On Tue, Feb 27, 2024 at 12:07:32AM +0100, Frederic Weisbecker wrote:
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
Looks like that. To address this, we should not release the head in the GP kthread.

Thanks!

--
Uladzislau Rezki

