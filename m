Return-Path: <linux-kernel+bounces-15557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED1A822E1B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 239411C22C0E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4A319473;
	Wed,  3 Jan 2024 13:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CS8vyxev"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBADF19452;
	Wed,  3 Jan 2024 13:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cd1aeb1bf3so2919011fa.1;
        Wed, 03 Jan 2024 05:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704287764; x=1704892564; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KpKiKKJ8XQmUre9DFkxyLg+STFm0cpnwGAaFXxdMgXA=;
        b=CS8vyxevLsTqVkBPBPSrbVMGNi9KgikSoi7ue7ZCpPGRsO7VBgpG9SA7jLMufBPJeS
         ZEO/nIJQjqukTePO/J/Z2oeXFXIbrRWJy5R2Wvx3xB/JtqHh6q6zXK0C5i2ntQux4kpv
         DKNhD/WsBnm/cT0U+MsfUFpgx/a0SI2y54/MMevf/Tk0xW8str77wVI+CUFYgHbuhf9/
         LkM3iLeCS0q+i0MYET4wGET1HazyQyuKMN3PGLSemxzyTzSEDpf0kd+hoJTjrX9Lcc9M
         Udz13LwYIBJGj3FGkAAiIuDODK5OcyzepP+0SI1+7T+7tXqDWGDoHQmtCffsZ38xADSQ
         iqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704287764; x=1704892564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KpKiKKJ8XQmUre9DFkxyLg+STFm0cpnwGAaFXxdMgXA=;
        b=ZLkHPmG3Tdrrkfgh0YXep2duKqz7lKLMLQZ4DNeXrMooBV7OVqNMkuELuF+lfwKMsd
         D89nKt6WxO+qiF7UavvgsdIokmiP4El4ow8lQksvW/W/UrrU7kSmzgeVcUpmkgeqeTQg
         o2JUx4XiY6banwWaQi1OVbXtE2LX8Eg7HYEku/6lgX+CifaA/t9qfOherwuKEgWKId/J
         iXJcsK45n8IzSSsq4eL6moQPOAgrn4mFeFZqNCboAILrCjsuQAkBRui8Kgj0ImNqlWTc
         P74qskyLRArljoMqS0XLSgIE3L1qVUvFjRUSj/mMGC/4NU8sWlIKy/42XKNcywaZkiAI
         6gXQ==
X-Gm-Message-State: AOJu0YxPfYe6nGOA0Deh/nG5wHhryKNgSzMBBYSwOgz9Jxf6sL1lw84G
	0NFsSta2CnCx9AQaC4V2t0g=
X-Google-Smtp-Source: AGHT+IFqaR9l0p1KiymRwaTQROU/KdbUDas2FhWDYzIIjzpc6IbSIJTJTkLI//Wl2kV2IqO0xOHBuw==
X-Received: by 2002:a2e:a586:0:b0:2cd:17f0:fcb0 with SMTP id m6-20020a2ea586000000b002cd17f0fcb0mr443287ljp.6.1704287763496;
        Wed, 03 Jan 2024 05:16:03 -0800 (PST)
Received: from pc636 (host-90-233-200-64.mobileonline.telia.com. [90.233.200.64])
        by smtp.gmail.com with ESMTPSA id p14-20020a2e9a8e000000b002ccd3e8a59esm3592957lji.121.2024.01.03.05.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 05:16:03 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 3 Jan 2024 14:16:00 +0100
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v3 4/7] rcu: Improve handling of synchronize_rcu() users
Message-ID: <ZZVeEGTKVp7CUqtK@pc636>
References: <20231128080033.288050-1-urezki@gmail.com>
 <20231128080033.288050-5-urezki@gmail.com>
 <579f86e0-e03e-4ab3-9a85-a62064bcf2a1@paulmck-laptop>
 <ZYQY8bB3zpywfBxO@pc636>
 <650554ca-17f6-4119-ab4e-42239c958c73@paulmck-laptop>
 <ZYVWjc65LzD8qkdw@pc636>
 <e20058f9-a525-4d65-b22b-7dd9cfec9737@paulmck-laptop>
 <ZZQHCrGNwjooI4kU@pc636>
 <cd45b0b5-f86b-43fb-a5f3-47d340cd4f9f@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd45b0b5-f86b-43fb-a5f3-47d340cd4f9f@paulmck-laptop>

On Tue, Jan 02, 2024 at 11:25:13AM -0800, Paul E. McKenney wrote:
> On Tue, Jan 02, 2024 at 01:52:26PM +0100, Uladzislau Rezki wrote:
> > Hello, Paul!
> > 
> > Sorry for late answer, it is because of holidays :)
> > 
> > > > > > The problem is that, we are limited in number of "wait-heads" which we
> > > > > > add as a marker node for this/current grace period. If there are more clients
> > > > > > and there is no a wait-head available it means that a system, the deferred
> > > > > > kworker, is slow in processing callbacks, thus all wait-nodes are in use.
> > > > > > 
> > > > > > That is why we need an extra grace period. Basically to repeat our try one
> > > > > > more time, i.e. it might be that a current grace period is not able to handle
> > > > > > users due to the fact that a system is doing really slow, but this is rather
> > > > > > a corner case and is not a problem.
> > > > > 
> > > > > But in that case, the real issue is not the need for an extra grace
> > > > > period, but rather the need for the wakeup processing to happen, correct?
> > > > > Or am I missing something subtle here?
> > > > > 
> > > > Basically, yes. If we had a spare dummy-node we could process the users
> > > > by the current GP(no need in extra). Why we may not have it - it is because
> > > > like you pointed:
> > > > 
> > > > - wake-up issue, i.e. wake-up time + when we are on_cpu;
> > > > - slow list process. For example priority. The kworker is not
> > > >   given enough CPU time to do the progress, thus "dummy-nodes"
> > > >   are not released in time for reuse.
> > > > 
> > > > Therefore, en extra GP is requested if there is a high flow of
> > > > synchronize_rcu() users and kworker is not able to do a progress
> > > > in time.
> > > > 
> > > > For example 60K+ parallel synchronize_rcu() users will trigger it.
> > > 
> > > OK, but what bad thing would happen if that was moved to precede the
> > > rcu_seq_start(&rcu_state.gp_seq)?  That way, the requested grace period
> > > would be the same as the one that is just now starting.
> > > 
> > > Something like this?
> > > 
> > > 	start_new_poll = rcu_sr_normal_gp_init();
> > > 
> > > 	/* Record GP times before starting GP, hence rcu_seq_start(). */
> > > 	rcu_seq_start(&rcu_state.gp_seq);
> > > 	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
> > >
> > I had a concern about the case when rcu_sr_normal_gp_init() handles what
> > we currently have, in terms of requests. Right after that there is/are
> > extra sync requests which invoke the start_poll_synchronize_rcu() but
> > since a GP has been requested before it will not request an extra one. So
> > "last" incoming users might not be processed.
> > 
> > That is why i have placed the rcu_sr_normal_gp_init() after a gp_seq is
> > updated.
> > 
> > I can miss something, so please comment. Apart of that we can move it
> > as you proposed.
> 
> Couldn't that possibility be handled by a check in rcu_gp_cleanup()?
> 
It is controlled by the caller anyway, i.e. if a new GP is needed.

I am not 100% sure it is as straightforward as it could look like to
handle it in the rcu_sr_normal_gp_cleaup() function. At least i see
that we need to access to the first element of llist and find out if
it is a wait-dummy-head or not. If not we know there are extra incoming
calls.

So that way requires extra calling of start_poll_synchronize_rcu().

I can add a comment about your concern and we can find the best approach
later, if it is OK with you!

--
Uladzislau Rezki

