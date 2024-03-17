Return-Path: <linux-kernel+bounces-105342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE4A87DC7A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 08:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15C1E1C20FBF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 07:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73E317BD2;
	Sun, 17 Mar 2024 07:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlflMOrt"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E3517984;
	Sun, 17 Mar 2024 07:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710659817; cv=none; b=gi2nGKE4ETPIn6Erd6XpnoOGJRMVnYdeFLPN7VG4sU3KAEQEf4milRV4C70LBKmcdGBRya+1YTsmRnHbzisTuEks2Qe99A3tLI6ub3s1BMaAkn+cq3zQSxuK4xiE7uWB/PRyaVaplDVoc75Ojmr5f6dvRHPfAqv7TPVmPV0qgoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710659817; c=relaxed/simple;
	bh=/xFeAVPBvNzkf5wS1ZvzTPDQ3b+anbzhWBoeE21y/bw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9BoCYxC54BG/xXfN4gIEkeScbgX4gVaEDOUzL15a98cnEuDaaj4epNY4+Eym8goLqVejIdWaDt2IBCFvvZ6E7J2hNyb4zrnHJjYOuc5D9fxYDzR9CTDV5oM1Z5+SRQHEoztFCtzOWJVU1y7hAMeh5PMelLQbUZ3/0Q7yJWyjog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mlflMOrt; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-29c16b324ecso2532635a91.3;
        Sun, 17 Mar 2024 00:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710659815; x=1711264615; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CmynaQ6JTp4OmLBmn9aKpX8GzQv/C+aAFPv+mT6Kx8Q=;
        b=mlflMOrtBy3g2u3KSxrm/bFCd13FGIUUkU0bzaaEJy7YV2WlgC8EL8WV2e1Cig5zo0
         sIVIUTfZz3FKQP5de5uvZnyp90PUh+RojMSqjFWHDnO2pMQMHNLhUpm9Oq4EK8OMSHoZ
         RtBlUnIC7r0boI/fhaRGVHuvXk4Ur0YhX45gEKuk0YCzEKm9kXVk7NT6sSc5f3ijnFDa
         RjnHrq7eP/O84/Nrjzc9k5sUZ6MgAUv+2YarzYrrLI9dJRMIq+Bn5HCaMF4ubV0EbFw3
         puIW3Eamsn4E/x3OV+dtAYcL5Pmz4k6jPZ0lyFsMBMpIb3vwyu7r+6WQQzmVSy5bltN0
         Q5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710659815; x=1711264615;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CmynaQ6JTp4OmLBmn9aKpX8GzQv/C+aAFPv+mT6Kx8Q=;
        b=gp62Ki5xMaMsHhJXR3re0o/cn3CgyLOybjB2IzlIMlDOxQokZGiOfqv7rhM2+jHcjQ
         yH5n89w28Y6WwIATCjHq+RRcDTbnI1CO/F0HNyE+JD8hO244qdKQV5lZdvqHi3HfVxxi
         8jNCjZ01cz1T0JIf+wfAs8iC9CJkwmfOj8/a0zLm7USj7VSV/DMPSqLy5HeUcWpjgk1B
         VsAo893zeRUr7IMLiYsfABcliF9UN6Qnt+WVUkvMyK5fFQwk7mU27jjquaCWvv7lYNUH
         n4rfx0dZjqkd1rIcjgmmoxV0hUkALmkZYiDl/eHf+jGgKvMHOYXqeDlg+ETrhlq6jY06
         YKJA==
X-Forwarded-Encrypted: i=1; AJvYcCVtMsIWhQFBwdTNLZLsfMlFavJwbmQNkEOiVk6Zwnh0GYysvfkAV0jBeVG+BfnzmjnJ03FAjm+Ph6pGN0C3qw0laTFzWqETaLvdU6C9umcjHQUhk/aQ7OXe9r+UAMB8NMpm
X-Gm-Message-State: AOJu0YwYO3wNC9A6UdsiIuxcIl2GFkwyJ6cIUGxCU38VcYbJlLSN54gZ
	MnKycCHL16UpngBj0we1x2uW8LT/A/vlkmPupThOkNUFSBS0pSCu1WZSMjqyjAUvALE0pvr8c8h
	OeVcbfHn8aZx2qb/8cU+WV1QzAzg=
X-Google-Smtp-Source: AGHT+IGrAziDFk+WYNrkbZj05QIbOMn/eBR8M+/WSh7aUk0phfOV30T/idsEbd57vPM43kPUbOWPVeUFijGifMOn84g=
X-Received: by 2002:a17:90a:6bc5:b0:29a:9fad:4ad9 with SMTP id
 w63-20020a17090a6bc500b0029a9fad4ad9mr7371237pjj.3.1710659814728; Sun, 17 Mar
 2024 00:16:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312072357.23517-1-qiang.zhang1211@gmail.com> <40a4b0f3-b850-4d73-b514-ce5149abb465@paulmck-laptop>
In-Reply-To: <40a4b0f3-b850-4d73-b514-ce5149abb465@paulmck-laptop>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Sun, 17 Mar 2024 15:16:43 +0800
Message-ID: <CALm+0cXCK5dj+a8YNe-etxVjJwChPtSeDDL3M7cZxDO1OCTR9Q@mail.gmail.com>
Subject: Re: [PATCH] rcutorture: Make rcutorture support print rcu-tasks gp state
To: paulmck@kernel.org
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org, 
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On Tue, Mar 12, 2024 at 03:23:57PM +0800, Zqiang wrote:
> > This commit make rcu-tasks related rcutorture test support rcu-tasks
> > gp state printing when the writer stall occurs or the at the end of
> > rcutorture test.
> >
> > The test is as follows:
> > [ 3872.548702] tasks-tracing:  Start-test grace-period state: g4560 f0x0
> > [ 4332.661283] tasks-tracing:  End-test grace-period state: g41540 f0x0 total-gps=36980
> >
> > [ 4401.381138] tasks:  Start-test grace-period state: g8 f0x0
> > [ 4565.619354] tasks:  End-test grace-period state: g1732 f0x0 total-gps=1724
> >
> > [ 4589.006917] tasks-rude:  Start-test grace-period state: g8 f0x0
> > [ 5059.379321] tasks-rude:  End-test grace-period state: g8508 f0x0 total-gps=8500
> >
> > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
>
> Again, good eyes, and that fix would work.  But wouldn't it make more
> sense to create a new cur_ops function pointer for these functions?
> That might allow getting rid of the *_FLAVOR checks and values, plus
> simplify the code a bit.  To make the function signatures work out,
> there would need to be an intermediate SRCU function to supply the right
> rcu_struct pointer.
>
> This would shorten and simplify the code a bit.
>
> Or is there some reason that this won't work?

Hi, Paul

Thanks for your suggestion, I will resend with reference to the
suggestions above.

Thanks
Zqiang


>
> Why didn't I do that to start with?  Well, the various RCU flavors
> appeared one at a time over some years...  ;-)
>
>                                                         Thanx, Paul
>
> > ---
> >  kernel/rcu/rcu.h        |  8 ++++++++
> >  kernel/rcu/rcutorture.c |  3 +++
> >  kernel/rcu/tasks.h      | 25 +++++++++++++++++++++++++
> >  3 files changed, 36 insertions(+)
> >
> > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > index 86fce206560e..3353e3697645 100644
> > --- a/kernel/rcu/rcu.h
> > +++ b/kernel/rcu/rcu.h
> > @@ -556,6 +556,14 @@ static inline unsigned long rcu_get_jiffies_lazy_flush(void) { return 0; }
> >  static inline void rcu_set_jiffies_lazy_flush(unsigned long j) { }
> >  #endif
> >
> > +#ifdef CONFIG_TASKS_RCU_GENERIC
> > +void rcutaskstorture_get_gp_data(enum rcutorture_type test_type, int *flags,
> > +                             unsigned long *gp_seq);
> > +#else
> > +static inline void rcutaskstorture_get_gp_data(enum rcutorture_type test_type, int *flags,
> > +                             unsigned long *gp_seq) { }
> > +#endif
> > +
> >  #if defined(CONFIG_TREE_RCU)
> >  void rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,
> >                           unsigned long *gp_seq);
> > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > index dd7d5ba45740..91c03f37fd97 100644
> > --- a/kernel/rcu/rcutorture.c
> > +++ b/kernel/rcu/rcutorture.c
> > @@ -2267,6 +2267,7 @@ rcu_torture_stats_print(void)
> >                                      &flags, &gp_seq);
> >               srcutorture_get_gp_data(cur_ops->ttype, srcu_ctlp,
> >                                       &flags, &gp_seq);
> > +             rcutaskstorture_get_gp_data(cur_ops->ttype, &flags, &gp_seq);
> >               wtp = READ_ONCE(writer_task);
> >               pr_alert("??? Writer stall state %s(%d) g%lu f%#x ->state %#x cpu %d\n",
> >                        rcu_torture_writer_state_getname(),
> > @@ -3391,6 +3392,7 @@ rcu_torture_cleanup(void)
> >
> >       rcutorture_get_gp_data(cur_ops->ttype, &flags, &gp_seq);
> >       srcutorture_get_gp_data(cur_ops->ttype, srcu_ctlp, &flags, &gp_seq);
> > +     rcutaskstorture_get_gp_data(cur_ops->ttype, &flags, &gp_seq);
> >       pr_alert("%s:  End-test grace-period state: g%ld f%#x total-gps=%ld\n",
> >                cur_ops->name, (long)gp_seq, flags,
> >                rcutorture_seq_diff(gp_seq, start_gp_seq));
> > @@ -3763,6 +3765,7 @@ rcu_torture_init(void)
> >       rcu_torture_print_module_parms(cur_ops, "Start of test");
> >       rcutorture_get_gp_data(cur_ops->ttype, &flags, &gp_seq);
> >       srcutorture_get_gp_data(cur_ops->ttype, srcu_ctlp, &flags, &gp_seq);
> > +     rcutaskstorture_get_gp_data(cur_ops->ttype, &flags, &gp_seq);
> >       start_gp_seq = gp_seq;
> >       pr_alert("%s:  Start-test grace-period state: g%ld f%#x\n",
> >                cur_ops->name, (long)gp_seq, flags);
> > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > index e83adcdb49b5..b1254cf3c210 100644
> > --- a/kernel/rcu/tasks.h
> > +++ b/kernel/rcu/tasks.h
> > @@ -2149,6 +2149,31 @@ late_initcall(rcu_tasks_verify_schedule_work);
> >  static void rcu_tasks_initiate_self_tests(void) { }
> >  #endif /* #else #ifdef CONFIG_PROVE_RCU */
> >
> > +void rcutaskstorture_get_gp_data(enum rcutorture_type test_type, int *flags,
> > +                             unsigned long *gp_seq)
> > +{
> > +     switch (test_type) {
> > +     case RCU_TASKS_FLAVOR:
> > +#ifdef CONFIG_TASKS_RCU
> > +             *gp_seq = rcu_seq_current(&rcu_tasks.tasks_gp_seq);
> > +#endif
> > +             break;
> > +     case RCU_TASKS_RUDE_FLAVOR:
> > +#ifdef CONFIG_TASKS_RUDE_RCU
> > +             *gp_seq = rcu_seq_current(&rcu_tasks_rude.tasks_gp_seq);
> > +#endif
> > +             break;
> > +     case RCU_TASKS_TRACING_FLAVOR:
> > +#ifdef CONFIG_TASKS_TRACE_RCU
> > +             *gp_seq = rcu_seq_current(&rcu_tasks_trace.tasks_gp_seq);
> > +#endif
> > +             break;
> > +     default:
> > +             break;
> > +     }
> > +}
> > +EXPORT_SYMBOL_GPL(rcutaskstorture_get_gp_data);
> > +
> >  void __init tasks_cblist_init_generic(void)
> >  {
> >       lockdep_assert_irqs_disabled();
> > --
> > 2.17.1
> >

