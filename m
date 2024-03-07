Return-Path: <linux-kernel+bounces-95561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DAD874F7E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 370781C21041
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC98E12BEA9;
	Thu,  7 Mar 2024 12:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adnpG8Iw"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4980C63419;
	Thu,  7 Mar 2024 12:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709816237; cv=none; b=Ng0CpjIqjnTm7ynWiRNzNll2uDRp2Ny92AzdeeEOA7wxNBrcFdiUxOq2kW6UHfLUXvFnzHp75+SvfIl7+p3mT29RhQJgQHUcE6CTe0rnUYZJtiPPu5mq0Gnw6+7c7M9LY0shhjCEhIIsLIEMtPyvOOFNYq9Gi/gQbgPkS55aBN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709816237; c=relaxed/simple;
	bh=BL5YusCjv6EJjz9ovyfEC1+bwrVuRiLGFjpVsJwOSKM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uq2eycFwxOCHAVpGMVSRBpjSJnRnON65DHq8AqNJPloAzIXma0FSIdmqGPzm/xqWRqu2LGLj7B7x0znqcfxwVIUAD1FTsO1c94KkMxVnqCZMyBxc84GyOoWH9MMMYU9mAFqZeJld8vQWGGqCraoJMjqUTu8dbPIUAHtB4p0Mpng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adnpG8Iw; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51331634948so1963901e87.0;
        Thu, 07 Mar 2024 04:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709816233; x=1710421033; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nbhgHt1YDa6CQCjpWTsRGO+07dj49MgrOul+Xxkk278=;
        b=adnpG8Iwbq/6N1do+KRYwbMa6hEZMN2xXduxXQi4TrsgUGMiUhHGYshHnpD596hv7O
         Kh/jMZwwuNTL/QGaa94rHpy78GfHtKqJGhi7OD39LzymcSeStOwe2w6/MYQVHfYgsgE+
         4rqGuMwwyPzyqN7WQeP9nxrXWXgGua7syjYJ6KzJgJVADUiMtthDFWqwxrGGKwqPUP0M
         aDeoEbggP41ThvGzvZzwhtiGHupKHFonUoghygGNBlsDD1wPs38SZ2C9i0FbAQ/Thvai
         uaGGGEBL4R8yNZ5YHIPf/9UcoExyvGo/FxdKL6aX/YX22aivyPXAjUUZVaDC3WWtTywt
         0kaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709816233; x=1710421033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nbhgHt1YDa6CQCjpWTsRGO+07dj49MgrOul+Xxkk278=;
        b=W+h4HUvA8bok8l9JTHm/58PjmjW8E24noHNIKdY41OWZfq4Se/ZNoaaHT9ZDRzBtGp
         ES1zIIyYdXHfZn1IyWwEa/dBFjvR2uqGktfFoIwjJWTcIlmzTo777HcbGzrtEldW10t8
         7QUlwhGFCNrsIFYhCv9nfg1cO5++cRCg3ZCVrladtXsFspeFMiMIAjXj531bVDI3T+2d
         OXfE61QNebH9NRqo6fK5oUEjAQiBVptYLkMd6d8vKZfMuA9C4f3YAWqKHVcU9CpsysQh
         6JMOX/ywf2gU7VaJj2iDGXYK0ZuPDkpf2X4DRI7vpZ8QY9YPykYG4J+IESbU6ltFBROG
         8Qfg==
X-Forwarded-Encrypted: i=1; AJvYcCUSUuWXsvZiScZ3lLMDYWFxwv5X+1sMIaYZEr1Tc3zfh0TJrMwSdfvOqX7sxwew/8SRU+vA5bsKrEnAO2dVuaU1rcMAmtvsfJcUOEYKj7aoEkQZfmR4v8mirOpLzp7Tl+Oe
X-Gm-Message-State: AOJu0YwToVW9Zp2rl4/qDAmOFNuvj7yA7Yns0mIjjrg9qTcqbglde9ms
	BotuSL4y1rPdDR7qYJ9kynIWjnd8EMWTRTFOoTrJkhcT4IXTRykV
X-Google-Smtp-Source: AGHT+IG1jaKEh1cKWqqTKOiamczUiL1VewCCnBHV/ctt+HrT68l48m6jipD3JeBpMYF3dfTfRMPYOw==
X-Received: by 2002:a05:6512:535:b0:513:1a46:36d7 with SMTP id o21-20020a056512053500b005131a4636d7mr63817lfc.2.1709816232833;
        Thu, 07 Mar 2024 04:57:12 -0800 (PST)
Received: from pc636 (host-90-235-19-15.mobileonline.telia.com. [90.235.19.15])
        by smtp.gmail.com with ESMTPSA id y26-20020a19641a000000b005133d07d926sm2336078lfb.45.2024.03.07.04.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 04:57:12 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 7 Mar 2024 13:57:10 +0100
To: Joel Fernandes <joel@joelfernandes.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 1/2] rcu: Do not release a wait-head from a GP kthread
Message-ID: <Zem5pkNiAy-EZdo9@pc636>
References: <20240305195720.42687-1-urezki@gmail.com>
 <a1faf101-c689-4530-a9a5-c7f95b8825d6@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1faf101-c689-4530-a9a5-c7f95b8825d6@joelfernandes.org>

On Wed, Mar 06, 2024 at 05:31:31PM -0500, Joel Fernandes wrote:
> 
> 
> On 3/5/2024 2:57 PM, Uladzislau Rezki (Sony) wrote:
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
> > ---
> >  kernel/rcu/tree.c | 22 ++++++++--------------
> >  1 file changed, 8 insertions(+), 14 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 31f3a61f9c38..475647620b12 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -1656,21 +1656,11 @@ static void rcu_sr_normal_gp_cleanup(void)
> >  	WARN_ON_ONCE(!rcu_sr_is_wait_head(wait_tail));
> >  
> >  	/*
> > -	 * Process (a) and (d) cases. See an illustration. Apart of
> > -	 * that it handles the scenario when all clients are done,
> > -	 * wait-head is released if last. The worker is not kicked.
> > +	 * Process (a) and (d) cases. See an illustration.
> >  	 */
> >  	llist_for_each_safe(rcu, next, wait_tail->next) {
> > -		if (rcu_sr_is_wait_head(rcu)) {
> > -			if (!rcu->next) {
> > -				rcu_sr_put_wait_head(rcu);
> > -				wait_tail->next = NULL;
> > -			} else {
> > -				wait_tail->next = rcu;
> > -			}
> > -
> > +		if (rcu_sr_is_wait_head(rcu))
> >  			break;
> > -		}
> >  
> >  		rcu_sr_normal_complete(rcu);
> >  		// It can be last, update a next on this step.
> > @@ -1684,8 +1674,12 @@ static void rcu_sr_normal_gp_cleanup(void)
> >  	smp_store_release(&rcu_state.srs_done_tail, wait_tail);
> >  	ASSERT_EXCLUSIVE_WRITER(rcu_state.srs_done_tail);
> >  
> > -	if (wait_tail->next)
> > -		queue_work(system_highpri_wq, &rcu_state.srs_cleanup_work);
> > +	/*
> > +	 * We schedule a work in order to perform a final processing
> > +	 * of outstanding users(if still left) and releasing wait-heads
> > +	 * added by rcu_sr_normal_gp_init() call.
> > +	 */
> > +	queue_work(system_highpri_wq, &rcu_state.srs_cleanup_work);
> >  }
> 
> Ah, nice. So instead of allocating/freeing in GP thread and freeing in worker,
> you allocate heads only in GP thread and free them only in worker, thus
> essentially fixing the UAF that Frederick found.
> 
> AFAICS, this fixes the issue.
> 
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
Thank you for the review-by!

> There might a way to prevent queuing new work as fast-path optimization, incase
> the CBs per GP will always be < SR_MAX_USERS_WAKE_FROM_GP but I could not find a
> workqueue API that helps there, and work_busy() has comments saying not to use that.
> 
This is not really critical but yes, we can think of it.

--
Uladzislau Rezki

