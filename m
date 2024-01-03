Return-Path: <linux-kernel+bounces-15807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BDF823368
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5A7E1C20CC6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB3C1C29D;
	Wed,  3 Jan 2024 17:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MF0ZAbPD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFE81C28F;
	Wed,  3 Jan 2024 17:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50e72e3d435so8183798e87.2;
        Wed, 03 Jan 2024 09:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704303323; x=1704908123; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HgaItFa446aFMiSnamEBaM7GyUBdJS5VRch8OwZfXSk=;
        b=MF0ZAbPD/X0xvTZ7hzJ3D2PnHB1SBQF0pRRIFmFhnv331llhfvMlZJUSp+k5T+xEbV
         ue8X3HfoMnMq3iKUGiTSZ/Ddi1EUKN7CL83536X6P3alk4/RrqjQUuM4hf3GZCAGNulT
         v5VVO8FnI/v/4gsJJbIIdJq08RwiK5fdnrqcUbrPInucfs32dBxtwHjFaAPcXs5udpxj
         KypPZzBt+a74t8bjyBernX3c3i0+aU0Qv3RisytYSg9smuoYAn0kqJhykpqJhViMzXWY
         NhZBvw7ix8vwi5LzRS+NQdzgyzAT5S7Of0hiUmc3PYeeSq3Kswy6woN4Gzx1wImDKAPf
         6S6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704303323; x=1704908123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgaItFa446aFMiSnamEBaM7GyUBdJS5VRch8OwZfXSk=;
        b=VcAmHU5zS68VKVFNSSh/+sLOePkZM4ajAZfGAj4FESXqV9ZskqQnAdaOon/mbD6WDh
         XvYYwDe/VMfXdFBlxnfjuafPRFbtDvGKdzJ4mv2IzSxRRQIgGS1oqnxL6Dqtzt29H/wk
         odsUw9Wag0v1y+49lT/M2xbVYFDyyAOuVj2tq4OqWpCvbGwx5v0gPEvFEojX8tKLWBzi
         7nLWnqzMQ3fSsrYQxktwvUD+q3L0O6f+Ogv7EHJtWdihYKPSo/Bv/u8XRIMPvgXogr8O
         x1ijAe6TNjcrOZUmocHWj0RYbGT+dtzETWtV3kwOhOC2f8kd3Qu3w7GiIKI0o0hB2UyK
         kssg==
X-Gm-Message-State: AOJu0YythNlC43Ft48eK2Y8bSCDnRWnaLi/Z4KXlmPpqAQFVGfu6eE3p
	Likgus5ltdKMdpZBXN1ZKVE=
X-Google-Smtp-Source: AGHT+IG5Hn9TGj/uHC7PG4pedjddlBvONui+OZ7Qe7a52QJj1d/0obPGawzNCzIPKR9toMBnDGKT8A==
X-Received: by 2002:a19:f812:0:b0:50e:6c1d:5dec with SMTP id a18-20020a19f812000000b0050e6c1d5decmr4325314lff.23.1704303323303;
        Wed, 03 Jan 2024 09:35:23 -0800 (PST)
Received: from pc636 (host-90-233-200-64.mobileonline.telia.com. [90.233.200.64])
        by smtp.gmail.com with ESMTPSA id w18-20020a05651203d200b0050e6c30236esm3526090lfp.12.2024.01.03.09.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 09:35:22 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 3 Jan 2024 18:35:20 +0100
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v3 4/7] rcu: Improve handling of synchronize_rcu() users
Message-ID: <ZZWa2LENLXCMUBhW@pc636>
References: <20231128080033.288050-5-urezki@gmail.com>
 <579f86e0-e03e-4ab3-9a85-a62064bcf2a1@paulmck-laptop>
 <ZYQY8bB3zpywfBxO@pc636>
 <650554ca-17f6-4119-ab4e-42239c958c73@paulmck-laptop>
 <ZYVWjc65LzD8qkdw@pc636>
 <e20058f9-a525-4d65-b22b-7dd9cfec9737@paulmck-laptop>
 <ZZQHCrGNwjooI4kU@pc636>
 <cd45b0b5-f86b-43fb-a5f3-47d340cd4f9f@paulmck-laptop>
 <ZZVeEGTKVp7CUqtK@pc636>
 <45a15103-0302-4e7d-b522-e17e8b8ac927@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45a15103-0302-4e7d-b522-e17e8b8ac927@paulmck-laptop>

On Wed, Jan 03, 2024 at 06:47:30AM -0800, Paul E. McKenney wrote:
> On Wed, Jan 03, 2024 at 02:16:00PM +0100, Uladzislau Rezki wrote:
> > On Tue, Jan 02, 2024 at 11:25:13AM -0800, Paul E. McKenney wrote:
> > > On Tue, Jan 02, 2024 at 01:52:26PM +0100, Uladzislau Rezki wrote:
> > > > Hello, Paul!
> > > > 
> > > > Sorry for late answer, it is because of holidays :)
> > > > 
> > > > > > > > The problem is that, we are limited in number of "wait-heads" which we
> > > > > > > > add as a marker node for this/current grace period. If there are more clients
> > > > > > > > and there is no a wait-head available it means that a system, the deferred
> > > > > > > > kworker, is slow in processing callbacks, thus all wait-nodes are in use.
> > > > > > > > 
> > > > > > > > That is why we need an extra grace period. Basically to repeat our try one
> > > > > > > > more time, i.e. it might be that a current grace period is not able to handle
> > > > > > > > users due to the fact that a system is doing really slow, but this is rather
> > > > > > > > a corner case and is not a problem.
> > > > > > > 
> > > > > > > But in that case, the real issue is not the need for an extra grace
> > > > > > > period, but rather the need for the wakeup processing to happen, correct?
> > > > > > > Or am I missing something subtle here?
> > > > > > > 
> > > > > > Basically, yes. If we had a spare dummy-node we could process the users
> > > > > > by the current GP(no need in extra). Why we may not have it - it is because
> > > > > > like you pointed:
> > > > > > 
> > > > > > - wake-up issue, i.e. wake-up time + when we are on_cpu;
> > > > > > - slow list process. For example priority. The kworker is not
> > > > > >   given enough CPU time to do the progress, thus "dummy-nodes"
> > > > > >   are not released in time for reuse.
> > > > > > 
> > > > > > Therefore, en extra GP is requested if there is a high flow of
> > > > > > synchronize_rcu() users and kworker is not able to do a progress
> > > > > > in time.
> > > > > > 
> > > > > > For example 60K+ parallel synchronize_rcu() users will trigger it.
> > > > > 
> > > > > OK, but what bad thing would happen if that was moved to precede the
> > > > > rcu_seq_start(&rcu_state.gp_seq)?  That way, the requested grace period
> > > > > would be the same as the one that is just now starting.
> > > > > 
> > > > > Something like this?
> > > > > 
> > > > > 	start_new_poll = rcu_sr_normal_gp_init();
> > > > > 
> > > > > 	/* Record GP times before starting GP, hence rcu_seq_start(). */
> > > > > 	rcu_seq_start(&rcu_state.gp_seq);
> > > > > 	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
> > > > >
> > > > I had a concern about the case when rcu_sr_normal_gp_init() handles what
> > > > we currently have, in terms of requests. Right after that there is/are
> > > > extra sync requests which invoke the start_poll_synchronize_rcu() but
> > > > since a GP has been requested before it will not request an extra one. So
> > > > "last" incoming users might not be processed.
> > > > 
> > > > That is why i have placed the rcu_sr_normal_gp_init() after a gp_seq is
> > > > updated.
> > > > 
> > > > I can miss something, so please comment. Apart of that we can move it
> > > > as you proposed.
> > > 
> > > Couldn't that possibility be handled by a check in rcu_gp_cleanup()?
> > > 
> > It is controlled by the caller anyway, i.e. if a new GP is needed.
> > 
> > I am not 100% sure it is as straightforward as it could look like to
> > handle it in the rcu_sr_normal_gp_cleaup() function. At least i see
> > that we need to access to the first element of llist and find out if
> > it is a wait-dummy-head or not. If not we know there are extra incoming
> > calls.
> > 
> > So that way requires extra calling of start_poll_synchronize_rcu().
> 
> If this is invoked early enough in rcu_gp_cleanup(), all that needs to
> happen is to set the need_gp flag.  Plus you can count the number of
> requests, and snapshot that number at rcu_gp_init() time and check to
> see if it changed at rcu_gp_cleanup() time.  Later on, this could be
> used to reduce the number of wakeups, correct?
> 
You mean instead of waking-up a gp-kthread just continue processing of
new users if they are exist? If so, i think, we can implement it as separate
patches.

> > I can add a comment about your concern and we can find the best approach
> > later, if it is OK with you!
> 
> I agree that this should be added via a later patch, though I have not
> yet given up on the possibility that this patch might be simple enough
> to be later in this same series.
> 
Maybe there is a small misunderstanding. Please note, the rcu_sr_normal_gp_init() 
function does not request any new gp, i.e. our approach does not do any extra GP
requests. It happens only if there are no any dummy-wait-head available as we
discussed it earlier.

--
Uladzislau Rezki

