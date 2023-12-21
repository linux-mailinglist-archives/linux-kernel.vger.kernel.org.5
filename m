Return-Path: <linux-kernel+bounces-8275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F062C81B4D1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 908971F2553C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA6C6BB3D;
	Thu, 21 Dec 2023 11:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0jUaNeW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947CA6D1DC;
	Thu, 21 Dec 2023 11:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50e60d67e6aso379262e87.1;
        Thu, 21 Dec 2023 03:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703157783; x=1703762583; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PePSp+PbF4BfBMSUYpDpriXKuCCpPeH9Cv6eaY4BwCk=;
        b=g0jUaNeWGvJqfg27V6l9P1tqufMKQpCWmK31BQXcThZsmYXEh5jHpXNsPHHAaAhhSo
         MfJwHawI6pv8zno8ZgXCVdka3UxcLI8L/1y9FJJX0Zzn5IQ0suewTa377EFn9fIlVSIt
         Lm5HOK/d9O+yGw6KkNmGZ7M7QHaw6RdgvB9M5+kbNW0Y3X7NlUR3RovZ4A3asbxDotde
         s8N+EZelTl6nrZ5iPux0E4c+T8KShQKiwxovUHTjzpV3AnR3pUezWvazlZKpTjG/icJm
         ZWMbNAZXCFeIGmTiDJByHvXPpt51uA4bOLKdBJsz2azuOeu2sEbkW8qgNAB2kpBQTTgn
         TgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703157783; x=1703762583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PePSp+PbF4BfBMSUYpDpriXKuCCpPeH9Cv6eaY4BwCk=;
        b=iFA+rBjouIPEb9iF8u08voAo0VxiI/2nYejFWFpvQa7y0t8vZaHuneDYZKgimDgdd5
         zFaWQqpE+Qz4scKKIOfv+gh4MRYBml/IMlqO6rYmF2PJ+d4KjwSb3esF7xhySJhBjSPx
         LG41MwK0bBDry/06+RiCfFuq+2DdkgrKZu92+IxfVPo1AShy4AJS4UpwkLn3VPCtIOoC
         lSAOyUe2vZKL5Ab4wOueaNFhsZffNNNx2eNitaWmS8RK2K2+uXWVhDN1c4GcC9VJeAZ8
         JXlST3IxJD0IPrvxwUw1LyWFbhgUvlnNkeXAgZZVY8fA7G1DYRrgmU4z/IS4YP+l6yss
         5ZdA==
X-Gm-Message-State: AOJu0YzrKnlAWmjvlAK4EH3Hs9ytrMcjv9M76/rQfq8pTqZrCiw97wm3
	a+W7O9tkeplcxKKu8MeDqO4=
X-Google-Smtp-Source: AGHT+IFBBp4Oy8m5Thz79K804egyupbldOYQy2a6Eg/NfMOP2Fzg7uzMtXqNfeBtm6p72qcok3aPpQ==
X-Received: by 2002:a05:6512:4c1:b0:50e:535f:f325 with SMTP id w1-20020a05651204c100b0050e535ff325mr363256lfq.9.1703157783213;
        Thu, 21 Dec 2023 03:23:03 -0800 (PST)
Received: from pc636 (host-90-233-221-204.mobileonline.telia.com. [90.233.221.204])
        by smtp.gmail.com with ESMTPSA id h4-20020a056512220400b0050e3904848esm242057lfu.56.2023.12.21.03.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 03:23:02 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 21 Dec 2023 12:22:59 +0100
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v3 5/7] rcu: Support direct wake-up of synchronize_rcu()
 users
Message-ID: <ZYQgE_dJnoADxN0a@pc636>
References: <20231128080033.288050-1-urezki@gmail.com>
 <20231128080033.288050-6-urezki@gmail.com>
 <e04f30bf-9793-4c42-a9a9-24c8f3545f3f@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e04f30bf-9793-4c42-a9a9-24c8f3545f3f@paulmck-laptop>

On Tue, Dec 19, 2023 at 05:46:11PM -0800, Paul E. McKenney wrote:
> On Tue, Nov 28, 2023 at 09:00:31AM +0100, Uladzislau Rezki (Sony) wrote:
> > This patch introduces a small enhancement which allows to do a
> > direct wake-up of synchronize_rcu() callers. It occurs after a
> > completion of grace period, thus by the gp-kthread.
> > 
> > Number of clients is limited by the hard-coded maximum allowed
> > threshold. The remaining part, if still exists is deferred to
> > a main worker.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> Nice optimization!
> 
> One question below.
> 
> > ---
> >  kernel/rcu/tree.c | 39 +++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 37 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index d7b48996825f..69663a6d5050 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -1384,6 +1384,12 @@ static void rcu_poll_gp_seq_end_unlocked(unsigned long *snap)
> >  		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> >  }
> >  
> > +/*
> > + * A max threshold for synchronize_rcu() users which are
> > + * awaken directly by the rcu_gp_kthread(). Left part is
> > + * deferred to the main worker.
> > + */
> > +#define SR_MAX_USERS_WAKE_FROM_GP 5
> >  #define SR_NORMAL_GP_WAIT_HEAD_MAX 5
> >  
> >  struct sr_wait_node {
> > @@ -1617,7 +1623,8 @@ static DECLARE_WORK(sr_normal_gp_cleanup, rcu_sr_normal_gp_cleanup_work);
> >   */
> >  static void rcu_sr_normal_gp_cleanup(void)
> >  {
> > -	struct llist_node *wait_tail;
> > +	struct llist_node *wait_tail, *head, *rcu;
> > +	int done = 0;
> >  
> >  	wait_tail = sr.srs_wait_tail;
> >  	if (wait_tail == NULL)
> > @@ -1626,11 +1633,39 @@ static void rcu_sr_normal_gp_cleanup(void)
> >  	sr.srs_wait_tail = NULL;
> >  	ASSERT_EXCLUSIVE_WRITER(sr.srs_wait_tail);
> >  
> > +	WARN_ON_ONCE(!rcu_sr_is_wait_head(wait_tail));
> > +	head = wait_tail->next;
> > +
> > +	/*
> > +	 * Process (a) and (d) cases. See an illustration. Apart of
> > +	 * that it handles the scenario when all clients are done,
> > +	 * wait-head is released if last. The worker is not kicked.
> > +	 */
> > +	llist_for_each_safe(rcu, head, head) {
> 
> This does appear to be a clever way to save eight bytes on the stack,
> but is our stack space really so restricted?  We are being invoked from
> the RCU GP kthread, which isn't using much stack, right?
> 
> If so, let's spend the extra local variable and spare the reader a
> trip to the llist_for_each_safe() definition.
> 
OK, you mean to go with an extra "next" variable to use it in the
llist-loop. I will change it accordingly!

--
Uladzislau Rezki

