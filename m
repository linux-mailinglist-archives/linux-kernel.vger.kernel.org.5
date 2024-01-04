Return-Path: <linux-kernel+bounces-16574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A63D0824070
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BD3A2864B9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B9521369;
	Thu,  4 Jan 2024 11:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnHmBlvl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6E021344;
	Thu,  4 Jan 2024 11:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cd1a1c5addso4492461fa.1;
        Thu, 04 Jan 2024 03:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704367083; x=1704971883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0fY4KAev0YvTWOo+yfNf4haoMllAwXF/UHdK8nIe8OE=;
        b=TnHmBlvlzIeodKC+QP9TjADza42EelFRxJemh/xt4yikp/TR5ekUl8NUEmt0ziS0QN
         oxJcY3/S72e9LCpjNDxSM8ipFI94yRmfnUJyfodmtzSGGm3Lrwo5yyv7AtgoisXClnIC
         MqdJUQ998GRT2adWUxRx+aNaLf0r6aZpMvHgMVJytAU2sZTL7jbrZeVUHZy/QVkbVB81
         lh7DyizKQC7dpvCgu1LMRHv7vSYvdo3Bqv+kzBQkSZVT82U2Wbeb0HDA8wGLjBDY/62R
         h383ZOYktMlEE57QRGzEhhH9M3p4L7LgQQlQAYyEFI04TuZUu7hvYUWw/so22Vz1MC7h
         iyvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704367083; x=1704971883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0fY4KAev0YvTWOo+yfNf4haoMllAwXF/UHdK8nIe8OE=;
        b=YTwqMx55kOCuq6MkZI6vXJnvxAlCnW1i9YJtQNwjkhNATbxqCiU06WD9g56GF4D9wS
         fprE5YsB39qJ/+mGlP5+itxNJf+lspflFptkbmbi0iEhXZ8jieb7zm5SauHVVZI70agD
         h5QNnIu4MZoHGvkY/WIrpd5Wy/jjicpP7EtmgSZEV2MlscxhWEeW4/xw+u98ZprxPjc0
         U+aKZfUXisYs2l+gI1PRa4blEcdNw6rGLkK8LHUSKo34RNoN1agiLPVc7MOrxQz6RSrh
         A/BSDbwMXgS2Gme7xMxCrYh7v9BRSnIgOB/cJsX1AWWnnmmjIz74lUc90VS0l6JQPZna
         6Q4Q==
X-Gm-Message-State: AOJu0YzjPvx8aCnQYz1P9rEWesz7+phgMWbK2ihJN4yckVJlnqvm8IJU
	LZ1WmkkLuUJ0vwyRBIpjz8s=
X-Google-Smtp-Source: AGHT+IEIj6bfxp7mN6ZE9yBh+mRCxiq2rKBecy5DALO0b7pLLukHeHb1hQMGXfWpQrY+Pfs/q6pvLQ==
X-Received: by 2002:a2e:7c13:0:b0:2cd:1919:ee28 with SMTP id x19-20020a2e7c13000000b002cd1919ee28mr206953ljc.36.1704367082368;
        Thu, 04 Jan 2024 03:18:02 -0800 (PST)
Received: from pc636 (host-95-193-77-34.mobileonline.telia.com. [95.193.77.34])
        by smtp.gmail.com with ESMTPSA id h5-20020a2ebc85000000b002ccd49fa5a9sm4135991ljf.19.2024.01.04.03.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 03:18:01 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 4 Jan 2024 12:17:59 +0100
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v3 4/7] rcu: Improve handling of synchronize_rcu() users
Message-ID: <ZZaT56z4Re4q9hp4@pc636>
References: <e20058f9-a525-4d65-b22b-7dd9cfec9737@paulmck-laptop>
 <ZZQHCrGNwjooI4kU@pc636>
 <cd45b0b5-f86b-43fb-a5f3-47d340cd4f9f@paulmck-laptop>
 <ZZVeEGTKVp7CUqtK@pc636>
 <45a15103-0302-4e7d-b522-e17e8b8ac927@paulmck-laptop>
 <ZZWa2LENLXCMUBhW@pc636>
 <d4635fdf-8ed0-452d-8bc8-0fe0e7fb1994@paulmck-laptop>
 <ZZWvKLy9mIOaaay4@pc636>
 <ZZWvbkhFA_Mbw_wH@pc636>
 <7dfb7ee8-f9a3-4c15-b3d1-b4f77602cbe1@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dfb7ee8-f9a3-4c15-b3d1-b4f77602cbe1@paulmck-laptop>

On Wed, Jan 03, 2024 at 11:33:01AM -0800, Paul E. McKenney wrote:
> On Wed, Jan 03, 2024 at 08:03:10PM +0100, Uladzislau Rezki wrote:
> > On Wed, Jan 03, 2024 at 08:02:00PM +0100, Uladzislau Rezki wrote:
> > > On Wed, Jan 03, 2024 at 09:56:42AM -0800, Paul E. McKenney wrote:
> > > > On Wed, Jan 03, 2024 at 06:35:20PM +0100, Uladzislau Rezki wrote:
> > > > > On Wed, Jan 03, 2024 at 06:47:30AM -0800, Paul E. McKenney wrote:
> > > > > > On Wed, Jan 03, 2024 at 02:16:00PM +0100, Uladzislau Rezki wrote:
> > > > > > > On Tue, Jan 02, 2024 at 11:25:13AM -0800, Paul E. McKenney wrote:
> > > > > > > > On Tue, Jan 02, 2024 at 01:52:26PM +0100, Uladzislau Rezki wrote:
> > > > > > > > > Hello, Paul!
> > > > > > > > > 
> > > > > > > > > Sorry for late answer, it is because of holidays :)
> > > > > > > > > 
> > > > > > > > > > > > > The problem is that, we are limited in number of "wait-heads" which we
> > > > > > > > > > > > > add as a marker node for this/current grace period. If there are more clients
> > > > > > > > > > > > > and there is no a wait-head available it means that a system, the deferred
> > > > > > > > > > > > > kworker, is slow in processing callbacks, thus all wait-nodes are in use.
> > > > > > > > > > > > > 
> > > > > > > > > > > > > That is why we need an extra grace period. Basically to repeat our try one
> > > > > > > > > > > > > more time, i.e. it might be that a current grace period is not able to handle
> > > > > > > > > > > > > users due to the fact that a system is doing really slow, but this is rather
> > > > > > > > > > > > > a corner case and is not a problem.
> > > > > > > > > > > > 
> > > > > > > > > > > > But in that case, the real issue is not the need for an extra grace
> > > > > > > > > > > > period, but rather the need for the wakeup processing to happen, correct?
> > > > > > > > > > > > Or am I missing something subtle here?
> > > > > > > > > > > > 
> > > > > > > > > > > Basically, yes. If we had a spare dummy-node we could process the users
> > > > > > > > > > > by the current GP(no need in extra). Why we may not have it - it is because
> > > > > > > > > > > like you pointed:
> > > > > > > > > > > 
> > > > > > > > > > > - wake-up issue, i.e. wake-up time + when we are on_cpu;
> > > > > > > > > > > - slow list process. For example priority. The kworker is not
> > > > > > > > > > >   given enough CPU time to do the progress, thus "dummy-nodes"
> > > > > > > > > > >   are not released in time for reuse.
> > > > > > > > > > > 
> > > > > > > > > > > Therefore, en extra GP is requested if there is a high flow of
> > > > > > > > > > > synchronize_rcu() users and kworker is not able to do a progress
> > > > > > > > > > > in time.
> > > > > > > > > > > 
> > > > > > > > > > > For example 60K+ parallel synchronize_rcu() users will trigger it.
> > > > > > > > > > 
> > > > > > > > > > OK, but what bad thing would happen if that was moved to precede the
> > > > > > > > > > rcu_seq_start(&rcu_state.gp_seq)?  That way, the requested grace period
> > > > > > > > > > would be the same as the one that is just now starting.
> > > > > > > > > > 
> > > > > > > > > > Something like this?
> > > > > > > > > > 
> > > > > > > > > > 	start_new_poll = rcu_sr_normal_gp_init();
> > > > > > > > > > 
> > > > > > > > > > 	/* Record GP times before starting GP, hence rcu_seq_start(). */
> > > > > > > > > > 	rcu_seq_start(&rcu_state.gp_seq);
> > > > > > > > > > 	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
> > > > > > > > > >
> > > > > > > > > I had a concern about the case when rcu_sr_normal_gp_init() handles what
> > > > > > > > > we currently have, in terms of requests. Right after that there is/are
> > > > > > > > > extra sync requests which invoke the start_poll_synchronize_rcu() but
> > > > > > > > > since a GP has been requested before it will not request an extra one. So
> > > > > > > > > "last" incoming users might not be processed.
> > > > > > > > > 
> > > > > > > > > That is why i have placed the rcu_sr_normal_gp_init() after a gp_seq is
> > > > > > > > > updated.
> > > > > > > > > 
> > > > > > > > > I can miss something, so please comment. Apart of that we can move it
> > > > > > > > > as you proposed.
> > > > > > > > 
> > > > > > > > Couldn't that possibility be handled by a check in rcu_gp_cleanup()?
> > > > > > > > 
> > > > > > > It is controlled by the caller anyway, i.e. if a new GP is needed.
> > > > > > > 
> > > > > > > I am not 100% sure it is as straightforward as it could look like to
> > > > > > > handle it in the rcu_sr_normal_gp_cleaup() function. At least i see
> > > > > > > that we need to access to the first element of llist and find out if
> > > > > > > it is a wait-dummy-head or not. If not we know there are extra incoming
> > > > > > > calls.
> > > > > > > 
> > > > > > > So that way requires extra calling of start_poll_synchronize_rcu().
> > > > > > 
> > > > > > If this is invoked early enough in rcu_gp_cleanup(), all that needs to
> > > > > > happen is to set the need_gp flag.  Plus you can count the number of
> > > > > > requests, and snapshot that number at rcu_gp_init() time and check to
> > > > > > see if it changed at rcu_gp_cleanup() time.  Later on, this could be
> > > > > > used to reduce the number of wakeups, correct?
> > > > > > 
> > > > > You mean instead of waking-up a gp-kthread just continue processing of
> > > > > new users if they are exist? If so, i think, we can implement it as separate
> > > > > patches.
> > > > 
> > > > Agreed, this is an optimization, and thus should be a separate patch.
> > > > 
> > > > > > > I can add a comment about your concern and we can find the best approach
> > > > > > > later, if it is OK with you!
> > > > > > 
> > > > > > I agree that this should be added via a later patch, though I have not
> > > > > > yet given up on the possibility that this patch might be simple enough
> > > > > > to be later in this same series.
> > > > > > 
> > > > > Maybe there is a small misunderstanding. Please note, the rcu_sr_normal_gp_init() 
> > > > > function does not request any new gp, i.e. our approach does not do any extra GP
> > > > > requests. It happens only if there are no any dummy-wait-head available as we
> > > > > discussed it earlier.
> > > > 
> > > > The start_poll_synchronize_rcu() added by your patch 4/7 will request
> > > > an additional grace period because it is invoked after rcu_seq_start()
> > > > is called, correct?  Or am I missing something subtle here?
> > > > 
> > > <snip>
> > > +       // New poll request after rnp unlock
> > > +       if (start_new_poll)
> > > +               (void) start_poll_synchronize_rcu();
> > > +
> > > <snip>
> > > 
> > > The "start_new_poll" is set to "true" only when _this_ GP is not able
> > > to handle anything and there are outstanding users. It happens when the
> > > rcu_sr_normal_gp_init() function was not able to insert a dummy separator
> > > to the llist, because there were no left dummy-nodes(fixed number of them)
> > > due to the fact that all of them are "in-use". The reason why there are no
> > > dummy-nodes is because of slow progress because it is done by dedicated
> > > kworker.
> > > 
> > > I can trigger it, i mean when we need an addition GP, start_new_pool is 1,
> > > only when i run 20 000 processes concurrently in a tight loop:
> > > 
> > > <snip>
> > > while (1)
> > >   synchronize_rcu();
> > > <snip>
> > > 
> > > in that scenario we start to ask for an addition GP because we are not up
> > > to speed, i.e. a system is slow in processing callbacks and we need some
> > > time until wait-node/nodes is/are released for reuse.
> > > 
> > > We need a next GP to move it forward, i.e. to repeat a try of attaching
> > > a dummy-node.
> > > 
> > Probably i should add a comment about it :)
> 
> Sounds good, and thank you for bearing with me!
> 
Thanks to you :)

--
Uladzislau Rezki

