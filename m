Return-Path: <linux-kernel+bounces-107910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80764880368
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A44BC1C226F2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC052C853;
	Tue, 19 Mar 2024 17:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxG3ihHV"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199F22B9CC;
	Tue, 19 Mar 2024 17:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710869190; cv=none; b=Ndnr0Q1/WDaPdz9gzw4B3dSBErFMHNkONl9KSe5hRIuJdRgSAhrEbxwCPCsAmDqYEAYaJiXeQizDf17MFhW6hYQbfarcqSIbxLEaOm47As/ToKIH9IIrlnjhnxRJ5IM2+TjaHQfvovAbbDZJ9x8o3ymWomM3J5lk+9QSe92GlFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710869190; c=relaxed/simple;
	bh=LBILahuHaPmKd4eRWJx8t0PKMK+L1X+U6qHAQ1ttssg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LccQUE+L43cPmupnYKVQwLgrwOivIGASKRQkrDWxEC4FL5vHjT1tCyeUtFw8UZRsXicExdAx2v6+KqqK9Dfg/ynuQDI/xhg1zOof/k37oseFGziBmIIGYCrlZ77C7o+xDbOZmV2yBHKKotFhT4gqOQtrtgtZql/G0p9T+mrshC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxG3ihHV; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-513d212f818so6960630e87.2;
        Tue, 19 Mar 2024 10:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710869186; x=1711473986; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hygNO2Bp8eyNZnTF5JnVR6ZN42y8vVmUr+0tKBNYEPc=;
        b=AxG3ihHVweKrenHhMcSPGoTnwiz21fn0nKqHYw53CVE3LS3+NIpRbJEvgARjVMhwlJ
         g7+d8RohqgrKGHKPy1Nb3MAm9E8tc30LYqsFnQamwzuVqgPjC7RpjLDTPSZL/47IgEhp
         OQU+yBOi4LPzPc3JOKxks5vCFGvsh3/2qlhHDEMTAnWAMlqNOQVoqUtl94kGVUr3zhJP
         buw2OywH+X/E2LhIPPvBGJm+OViH2O2ebbfxrku7drlKGKqSmFbfl73P64rg4J9MKHaW
         8PN2p9sPB6yYTcPk3MIkuS4QxPNjaZtpKxl0Bqt/B+FtbRLf/O5OTiPNaBZhhhuAN67+
         9j6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710869186; x=1711473986;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hygNO2Bp8eyNZnTF5JnVR6ZN42y8vVmUr+0tKBNYEPc=;
        b=saEmcrsrYYpBNx/46xuqpjdUT1vdpcHnuB6l01pkkOyOorDb6yq+YTsgFcbnvftz7G
         El+0PVP22kKovbf+FfjknyQuNdENhj8tgt/wXSG70zNiuNH8Z042MyTQJ8g8OpmHM06i
         sPQwgwqyMRDiXogMyj4eZ21NzBFqYxBcJ/3Xgb5ZZzcDY0WWW4pWZCUStTLmE01K66oE
         qlYJ5VUPxdyfAsB2CFNpbG9fCSWNqBuagVTUQQ+Fui8EsE9F/Oyun9AXuBh2glOBwCVe
         GBOiPxfdiDxtNUwz6kR2j22e0Wjm2BMwoVKNq5fTofjvYkfeJuUL5KEy6nSNtxMqDr0T
         mNmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtp2NFCdbzO8ZMxttAlKijFZtwp4AicxSiIzEQBAQhnU2IVS79N/ZjRWNtrF07G3Sl9ClwLkMo4v/2RIpuBVLiXsEr4TYKIZdSxCvgDwPR90I2/+aUBaPjyAmHfx/ff3Id
X-Gm-Message-State: AOJu0Yx3MN8Gzoe4WMPs1y6sgng1imKwi8BHvPqpubaX7wQIcawJ9Xq4
	L3SoB9tzabd2QoghNRY3YVG4igHI0R4N4YrkW7MlqVPgktKqTn64tJK3ZQly4io=
X-Google-Smtp-Source: AGHT+IEBBMf0R+OMQ4Bk2UP+FAbdamcce8T/v5E6lXvElhFr8NuWOUBjrd0rzRx2uMYCA6Ke+7/tzA==
X-Received: by 2002:ac2:5bcd:0:b0:513:b90f:f4dd with SMTP id u13-20020ac25bcd000000b00513b90ff4ddmr10338694lfn.49.1710869185996;
        Tue, 19 Mar 2024 10:26:25 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id i30-20020a0565123e1e00b00513c9ad26e8sm2001445lfv.34.2024.03.19.10.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 10:26:25 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date: Tue, 19 Mar 2024 18:26:23 +0100
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org,
	frederic@kernel.org, boqun.feng@gmail.com, neeraj.iitr10@gmail.com,
	rcu@vger.kernel.org, rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v2 rcu/dev 1/2] rcu/tree: Reduce wake up for
 synchronize_rcu() common case
Message-ID: <ZfnKv1K85Nkwy7p4@pc638.lan>
References: <ZflgfrjZSZdqrLLw@pc636>
 <0B372386-9546-492E-930E-DC6C883F3B2B@joelfernandes.org>
 <ZfmlziaLw1bl4IjX@pc636>
 <20240319160252.GA186534@joelbox2>
 <CAEXW_YTVNb_NpM8bY4KU60tvd0s-iVQ0AZs1s+LFk-Ux51++6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YTVNb_NpM8bY4KU60tvd0s-iVQ0AZs1s+LFk-Ux51++6Q@mail.gmail.com>

On Tue, Mar 19, 2024 at 12:11:28PM -0400, Joel Fernandes wrote:
> On Tue, Mar 19, 2024 at 12:02 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Tue, Mar 19, 2024 at 03:48:46PM +0100, Uladzislau Rezki wrote:
> > > On Tue, Mar 19, 2024 at 10:29:59AM -0400, Joel Fernandes wrote:
> > > >
> > > >
> > > > > On Mar 19, 2024, at 5:53 AM, Uladzislau Rezki <urezki@gmail.com> wrote:
> > > > >
> > > > > ﻿On Mon, Mar 18, 2024 at 05:05:31PM -0400, Joel Fernandes wrote:
> > > > >>
> > > > >>
> > > > >>>> On Mar 18, 2024, at 2:58 PM, Uladzislau Rezki <urezki@gmail.com> wrote:
> > > > >>>
> > > > >>> ﻿Hello, Joel!
> > > > >>>
> > > > >>> Sorry for late checking, see below few comments:
> > > > >>>
> > > > >>>> In the synchronize_rcu() common case, we will have less than
> > > > >>>> SR_MAX_USERS_WAKE_FROM_GP number of users per GP. Waking up the kworker
> > > > >>>> is pointless just to free the last injected wait head since at that point,
> > > > >>>> all the users have already been awakened.
> > > > >>>>
> > > > >>>> Introduce a new counter to track this and prevent the wakeup in the
> > > > >>>> common case.
> > > > >>>>
> > > > >>>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > >>>> ---
> > > > >>>> Rebased on paul/dev of today.
> > > > >>>>
> > > > >>>> kernel/rcu/tree.c | 36 +++++++++++++++++++++++++++++++-----
> > > > >>>> kernel/rcu/tree.h |  1 +
> > > > >>>> 2 files changed, 32 insertions(+), 5 deletions(-)
> > > > >>>>
> > > > >>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > >>>> index 9fbb5ab57c84..bd29fe3c76bf 100644
> > > > >>>> --- a/kernel/rcu/tree.c
> > > > >>>> +++ b/kernel/rcu/tree.c
> > > > >>>> @@ -96,6 +96,7 @@ static struct rcu_state rcu_state = {
> > > > >>>>   .ofl_lock = __ARCH_SPIN_LOCK_UNLOCKED,
> > > > >>>>   .srs_cleanup_work = __WORK_INITIALIZER(rcu_state.srs_cleanup_work,
> > > > >>>>       rcu_sr_normal_gp_cleanup_work),
> > > > >>>> +    .srs_cleanups_pending = ATOMIC_INIT(0),
> > > > >>>> };
> > > > >>>>
> > > > >>>> /* Dump rcu_node combining tree at boot to verify correct setup. */
> > > > >>>> @@ -1642,8 +1643,11 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
> > > > >>>>    * the done tail list manipulations are protected here.
> > > > >>>>    */
> > > > >>>>   done = smp_load_acquire(&rcu_state.srs_done_tail);
> > > > >>>> -    if (!done)
> > > > >>>> +    if (!done) {
> > > > >>>> +        /* See comments below. */
> > > > >>>> +        atomic_dec_return_release(&rcu_state.srs_cleanups_pending);
> > > > >>>>       return;
> > > > >>>> +    }
> > > > >>>>
> > > > >>>>   WARN_ON_ONCE(!rcu_sr_is_wait_head(done));
> > > > >>>>   head = done->next;
> > > > >>>> @@ -1666,6 +1670,9 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
> > > > >>>>
> > > > >>>>       rcu_sr_put_wait_head(rcu);
> > > > >>>>   }
> > > > >>>> +
> > > > >>>> +    /* Order list manipulations with atomic access. */
> > > > >>>> +    atomic_dec_return_release(&rcu_state.srs_cleanups_pending);
> > > > >>>> }
> > > > >>>>
> > > > >>>> /*
> > > > >>>> @@ -1673,7 +1680,7 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
> > > > >>>> */
> > > > >>>> static void rcu_sr_normal_gp_cleanup(void)
> > > > >>>> {
> > > > >>>> -    struct llist_node *wait_tail, *next, *rcu;
> > > > >>>> +    struct llist_node *wait_tail, *next = NULL, *rcu = NULL;
> > > > >>>>   int done = 0;
> > > > >>>>
> > > > >>>>   wait_tail = rcu_state.srs_wait_tail;
> > > > >>>> @@ -1699,16 +1706,35 @@ static void rcu_sr_normal_gp_cleanup(void)
> > > > >>>>           break;
> > > > >>>>   }
> > > > >>>>
> > > > >>>> -    // concurrent sr_normal_gp_cleanup work might observe this update.
> > > > >>>> -    smp_store_release(&rcu_state.srs_done_tail, wait_tail);
> > > > >>>> +    /*
> > > > >>>> +     * Fast path, no more users to process. Remove the last wait head
> > > > >>>> +     * if no inflight-workers. If there are in-flight workers, let them
> > > > >>>> +     * remove the last wait head.
> > > > >>>> +     */
> > > > >>>> +    WARN_ON_ONCE(!rcu);
> > > > >>>>
> > > > >>> This assumption is not correct. An "rcu" can be NULL in fact.
> > > > >>
> > > > >> Hmm I could never trigger that. Are you saying that is true after Neeraj recent patch or something else?
> > > > >> Note, after Neeraj patch to handle the lack of heads availability, it could be true so I requested
> > > > >> him to rebase his patch on top of this one.
> > > > >>
> > > > >> However I will revisit my patch and look for if it could occur but please let me know if you knew of a sequence of events to make it NULL.
> > > > >>>
> > > > > I think we should agree on your patch first otherwise it becomes a bit
> > > > > messy or go with a Neeraj as first step and then work on youth. So, i
> > > > > reviewed this patch based on latest Paul's dev branch. I see that Neeraj
> > > > > needs further work.
> > > >
> > > > You are right. So the only change is to drop the warning and those braces. Agreed?
> > > >
> > > Let me check a bit. Looks like correct but just in case.
> > >
> >
> > Thanks. I was also considering improving it for the rcu == NULL case, as
> > below. I will test it more before re-sending.
> >
> > On top of my patch:
> >
> > ---8<-----------------------
> >
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 0df659a878ee..a5ef844835d4 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -1706,15 +1706,18 @@ static void rcu_sr_normal_gp_cleanup(void)
> >                         break;
> >         }
> >
> > +
> > +       /* Last head stays. No more processing to do. */
> > +       if (!rcu)
> > +               return;
> > +
> 
> Ugh, should be "if (!wait_head->next)"  instead of "if (!rcu)".  But
> in any case, the original patch except the warning should hold.
> Still, I am testing the above diff now.
> 
>  - Joel
>
Just in case, it is based on your patch:

<snip>
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index bd29fe3c76bf..98546afe7c21 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1711,29 +1711,25 @@ static void rcu_sr_normal_gp_cleanup(void)
 	 * if no inflight-workers. If there are in-flight workers, let them
 	 * remove the last wait head.
 	 */
-	WARN_ON_ONCE(!rcu);
-	ASSERT_EXCLUSIVE_WRITER(rcu_state.srs_done_tail);
-
-	if (rcu && rcu_sr_is_wait_head(rcu) && rcu->next == NULL &&
-		/* Order atomic access with list manipulation. */
-		!atomic_read_acquire(&rcu_state.srs_cleanups_pending)) {
+	if (wait_tail->next && rcu_sr_is_wait_head(wait_tail->next) && !wait_tail->next->next &&
+			!atomic_read_acquire(&rcu_state.srs_cleanups_pending)) {
+		rcu_sr_put_wait_head(wait_tail->next);
 		wait_tail->next = NULL;
-		rcu_sr_put_wait_head(rcu);
-		smp_store_release(&rcu_state.srs_done_tail, wait_tail);
-		return;
 	}
 
 	/* Concurrent sr_normal_gp_cleanup work might observe this update. */
 	smp_store_release(&rcu_state.srs_done_tail, wait_tail);
+	ASSERT_EXCLUSIVE_WRITER(rcu_state.srs_done_tail);
 
-	/*
-	 * We schedule a work in order to perform a final processing
-	 * of outstanding users(if still left) and releasing wait-heads
-	 * added by rcu_sr_normal_gp_init() call.
-	 */
-	atomic_inc(&rcu_state.srs_cleanups_pending);
-	if (!queue_work(sync_wq, &rcu_state.srs_cleanup_work)) {
-		atomic_dec(&rcu_state.srs_cleanups_pending);
+	if (wait_tail->next) {
+		/*
+		 * We schedule a work in order to perform a final processing
+		 * of outstanding users(if still left) and releasing wait-heads
+		 * added by rcu_sr_normal_gp_init() call.
+		 */
+		atomic_inc(&rcu_state.srs_cleanups_pending);
+		if (!queue_work(sync_wq, &rcu_state.srs_cleanup_work))
+			atomic_dec(&rcu_state.srs_cleanups_pending);
 	}
 }
<snip>



--
Uladzislau Rezki

