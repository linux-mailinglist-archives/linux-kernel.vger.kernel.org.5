Return-Path: <linux-kernel+bounces-95519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2317874EC9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 535A52813AC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CCF12A167;
	Thu,  7 Mar 2024 12:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4mgcXlI"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5215D129A7D;
	Thu,  7 Mar 2024 12:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709813857; cv=none; b=fGkst1/z5sQP8yrtJAPXIuzCATni4W1ho2tfgiHBzLZfMGRLX8PAwar41xnnl43+DOKel+jIC/1c3B2AUOFq6SBCsRoRDQTi3SkMejrPbU3XS45X5fjTYRUT8NhnaC1pEbbQOWkiVgpWOw5RHsK7Fo3Qjfc9X2Tq5364zHwhG2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709813857; c=relaxed/simple;
	bh=ABf4sv5AXvxdqXJt9Bfdq/bjZHuwKeMqD/z0tX/Flac=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GvneYwC2dKaW4MfNbqEr7u/RrYD8SFvKn20vke1mdELdNwljNyd5HpQstp1r9O44Ro/Q936g4xAP9QfEJtNpnmSNyFzhLbM7rHr81nLm4tgZLzPTXwsWqmBFIy9kN4PjGXVPLx1kRAfwpIrHs6Djv5DhzbfMj72XEUJSDJZGWkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4mgcXlI; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51331634948so1933388e87.0;
        Thu, 07 Mar 2024 04:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709813852; x=1710418652; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U5SLkjwIQZkkO+zmEpiW/twSUX2B8qPMuIOeh9eW0HI=;
        b=E4mgcXlIsFJxhujftW619jPawk+QGR9q6NuiDrTVrLn06VDXt5ML50IWLVx3WjwyxN
         6VnXU9OXrvbyvCpLzatTkDSGB6sJL7XNwmqP8pK3j5kx+hMjtw6FRveDWU+uVU8ThHYq
         yRl+O47HrW3/RBHesGN1eoniYVUqHMHaGb+cxWPANU5GAAgLKTn7WvCx7uq6Z4TAv3JD
         WT3NvNP9LbC+AKSctTiqkyA+zUgf0nheKjUNbwt5+EfOuf8rKp7ft1MZrvm1G14ifbTS
         3OnqrR+5z1MYvb9aK6g6HrjlTqOgt57iJjhOynDG1b48qltejkPs84B9LAKYPUmxJblz
         8u1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709813852; x=1710418652;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U5SLkjwIQZkkO+zmEpiW/twSUX2B8qPMuIOeh9eW0HI=;
        b=VDSP7Qh93r0haz0YG1EGldgj4vh2gSHU1Qy4RlLQQ/++1uk91KYpZ+Xic/zZUzYLIP
         Hhu02yR4mU9TTjiN4rtnncMgcqfnGskZ0HyiZ2wpvf/MBLuN6GSVuDWvGhh1PaBv3cc6
         3XdzFPrI6lxO4rnoCA7HTBM+N5ZBTme3qXzlh/Cx3q4Ud6Lt6n3d5LqFkRC3xtdAEg23
         eWpDzi3uiGJ1C1YAtRVxnoolvdcB9us4ctmKsrQVL1sCHPtthcqkpVkTLbRS1ZmtB7xT
         kxvT+6U+8murYmR/x/wweJRyvvvAmLPgjILm4+2pLvq80PNQOnozEjYP/CXCOdGkhlB7
         159A==
X-Forwarded-Encrypted: i=1; AJvYcCXNnIgQXAd/V8gY3ekIVC2TAOtWdfG5traGzuZd0LpTBCIDBkEh8Xguh0z7KIXEYpjGsWkKxLJMgqqab+99LrYA8QJjm7TNP0Wo6DiC4/eWwuTqyNtm5ShjGL2sF8bAaF+s
X-Gm-Message-State: AOJu0YzgWPKfMYMCBh9VqjvrgVDb66UhNZ+H3NkteHK8tHMeLmZkIDRi
	efMVp4VSojn/3vYgYZ1TSdSDqDq+FT+f7khIcII7A9jp763VIEtl
X-Google-Smtp-Source: AGHT+IEn5lm2lZdeNwXzulDWNZ5IuGgMyEQiBH2dd3SCFbtHDZ1UuLRATTQ/RZMcrGJ421bYB7OTCw==
X-Received: by 2002:a19:910d:0:b0:513:5e2f:6510 with SMTP id t13-20020a19910d000000b005135e2f6510mr593523lfd.31.1709813852297;
        Thu, 07 Mar 2024 04:17:32 -0800 (PST)
Received: from pc636 (host-90-235-19-15.mobileonline.telia.com. [90.235.19.15])
        by smtp.gmail.com with ESMTPSA id k3-20020a05651c060300b002d4143e96d5sm59192lje.136.2024.03.07.04.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 04:17:30 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 7 Mar 2024 13:17:28 +0100
To: Frederic Weisbecker <frederic@kernel.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 1/2] rcu: Do not release a wait-head from a GP kthread
Message-ID: <ZemwWDBnbtmNjTzK@pc636>
References: <20240305195720.42687-1-urezki@gmail.com>
 <ZekEiXZes38y_Rmq@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZekEiXZes38y_Rmq@localhost.localdomain>

On Thu, Mar 07, 2024 at 01:04:25AM +0100, Frederic Weisbecker wrote:
> Le Tue, Mar 05, 2024 at 08:57:19PM +0100, Uladzislau Rezki (Sony) a écrit :
> > Fix a below race by not releasing a wait-head from the
> > GP-kthread as it can lead for reusing it whereas a worker
> > can still access it thus execute newly added callbacks too
> > early.
> > 
> > CPU 0                              CPU 1
> > -----                              -----
> > 
> > // wait_tail == HEAD1
> > rcu_sr_normal_gp_cleanup() {
> >     // has passed SR_MAX_USERS_WAKE_FROM_GP
> >     wait_tail->next = next;
> >     // done_tail = HEAD1
> >     smp_store_release(&rcu_state.srs_done_tail, wait_tail);
> >     queue_work() {
> >         test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work)
> >         __queue_work()
> >     }
> > }
> > 
> >                                set_work_pool_and_clear_pending()
> >                                rcu_sr_normal_gp_cleanup_work() {
> > // new GP, wait_tail == HEAD2
> > rcu_sr_normal_gp_cleanup() {
> >     // executes all completion, but stop at HEAD1
> >     wait_tail->next = HEAD1;
> >     // done_tail = HEAD2
> >     smp_store_release(&rcu_state.srs_done_tail, wait_tail);
> >     queue_work() {
> >         test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work)
> >         __queue_work()
> >     }
> > }
> >                                  // done = HEAD2
> >                                  done = smp_load_acquire(&rcu_state.srs_done_tail);
> >                                  // head = HEAD1
> >                                  head = done->next;
> >                                  done->next = NULL;
> >                                  llist_for_each_safe() {
> >                                  // completes all callbacks, release HEAD1
> >                                  }
> >                                }
> >                                // Process second queue
> >                                set_work_pool_and_clear_pending()
> >                                rcu_sr_normal_gp_cleanup_work() {
> >                                // done = HEAD2
> >                                done = smp_load_acquire(&rcu_state.srs_done_tail);
> > 
> > // new GP, wait_tail == HEAD3
> > rcu_sr_normal_gp_cleanup() {
> >     // Finds HEAD2 with ->next == NULL at the end
> >     rcu_sr_put_wait_head(HEAD2)
> >     ...
> > 
> > // A few more GPs later
> > rcu_sr_normal_gp_init() {
> >      HEAD2 = rcu_sr_get_wait_head();
> >      llist_add(HEAD2, &rcu_state.srs_next);
> >                                // head == rcu_state.srs_next
> >                                head = done->next;
> >                                done->next = NULL;
> >                                llist_for_each_safe() {
> >                                 // EXECUTE CALLBACKS TOO EARLY!!!
> >                                 }
> >                                }
> > 
> > Reported-by: Frederic Weisbecker <frederic@kernel.org>
> > Fixes: 05a10b921000 ("rcu: Support direct wake-up of synchronize_rcu() users")
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
>
Thank you, I will update with your review-by tag!

--
Uladzislau Rezki

