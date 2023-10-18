Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1EA7CE4BC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjJRRhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjJRRhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:37:37 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B221731;
        Wed, 18 Oct 2023 10:36:12 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c50cf61f6dso77264451fa.2;
        Wed, 18 Oct 2023 10:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697650571; x=1698255371; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3zNWTtFsvzJ0eNT/uIt33iHUybx+dKwdPOpAnNRdODg=;
        b=l5Mqk/umuELxSTC+mpKTL7xGC7u24NsL8/ImB4/daJFFc+mkDpk1lC999kKr2jgk+4
         WlE56zEJALvVLtWztkiOcwINn+68swbemyT9/6d4nEODepkrfscpOIvFUhIci2gux9TD
         X8w8ngQaOy3LcKnZEABMqxGG1uAkHUJbJ3UbgYPKQzNmva8ZSndvauC4YMqY6B0zgYbj
         vAtGY3KopiyxcxLo3Jx3+KP0/CbOeXkkqv+d1pu55vvpUX45DoKYPmtKNAYgSLlcyFi4
         u5Nivtw4XAekwTYOUCtNEpcF/YKfVQV72Nvd6PzUt63lupYVYosAfE3Uyw0KZ0sqdPue
         gVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697650571; x=1698255371;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3zNWTtFsvzJ0eNT/uIt33iHUybx+dKwdPOpAnNRdODg=;
        b=MIpg5jccsLOYH27InGilQ76QYy22gyID5w4fcdWonbLHCVT+US2Q2/mCimGsJfozAt
         zNT9Lt2jJwyQ4Q0qcjsNliJiR01032Dr9EJ7ij5DZZngxdJBZuws8nfnWmOFhPXTfhzy
         igNX8YAetxmzTDJGFtJEy9Bo+z2h3qOwmot4kTwCiD8efPJd/LOwDuF7PZ2jNI/0TKbU
         Q7vItf4Vp34ta+E/ixeK/W1TyhKAnhGT7NHgLVOCoWkt1XbsQeq+DodEf1gvUtZxs119
         uS1HL9qSgpe8WGOXBIw2cFZGuIfo5u2gaY3ul4er0C9W76P+3ksGeOZizSmdqCF8jeJZ
         +qKA==
X-Gm-Message-State: AOJu0Yy5KF8iwdP7z83FiNxk2HVimuFHnmcxKr/IjKHsBf3cBgj9NdEV
        zu0h9hW+oHSWtNsjsGiNcE4=
X-Google-Smtp-Source: AGHT+IGVQtL8EluxnF0x/e8D/MLdBDQhng6Owp44Md2QV0nA6QS92mV/0/de3DP2RdtvenoFpguhjg==
X-Received: by 2002:a2e:bc12:0:b0:2c5:9a5:a1c2 with SMTP id b18-20020a2ebc12000000b002c509a5a1c2mr7171059ljf.30.1697650570471;
        Wed, 18 Oct 2023 10:36:10 -0700 (PDT)
Received: from pc636 (host-90-233-215-212.mobileonline.telia.com. [90.233.215.212])
        by smtp.gmail.com with ESMTPSA id v14-20020a2e990e000000b002c00e475e23sm780606lji.131.2023.10.18.10.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 10:36:10 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 18 Oct 2023 19:36:07 +0200
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>,
        Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v3 1/1] rcu: Reduce synchronize_rcu() waiting time
Message-ID: <ZTAXh1ifgAAF0GsW@pc636>
References: <20231016173004.14148-1-urezki@gmail.com>
 <CAEXW_YRfuXqnBFN=DpOLio74j8fX3eEDSFCH8LXyavuHDdYysA@mail.gmail.com>
 <ZS6U5SgvGcmdE_DA@pc636>
 <CAEXW_YT5+ginWcAM-Bxk7tDcGxOgn-6cuTamBJOzr8ta6_jf+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YT5+ginWcAM-Bxk7tDcGxOgn-6cuTamBJOzr8ta6_jf+g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 10:32:22AM -0400, Joel Fernandes wrote:
> On Tue, Oct 17, 2023 at 10:06 AM Uladzislau Rezki <urezki@gmail.com> wrote:
> [...]
> > > > +
> > > > +       /* Finally. */
> > > > +       complete(&rs->completion);
> > > > +}
> > > > +
> > > > +static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
> > > > +{
> > > > +       struct llist_node *done, *rcu, *next;
> > > > +
> > > > +       done = llist_del_all(&sr.done);
> > > > +       if (!done)
> > > > +               return;
> > > > +
> > > > +       llist_for_each_safe(rcu, next, done)
> > > > +               rcu_sr_normal_complete(rcu);
> > > > +}
> > > [...]
> > > > +static void rcu_sr_normal_add_req(struct rcu_synchronize *rs)
> > > > +{
> > > > +       atomic_inc(&sr.active);
> > > > +       if (llist_add((struct llist_node *) &rs->head, &sr.curr))
> > > > +               /* Set the tail. Only first and one user can do that. */
> > > > +               WRITE_ONCE(sr.curr_tail, (struct llist_node *) &rs->head);
> > > > +       atomic_dec(&sr.active);
> > >
> > > Here there is no memory ordering provided by the atomic ops. Is that really Ok?
> > >
> > This needs to be reworked since there is no ordering guaranteed. I think
> > there is a version of "atomic_inc_something" that guarantees it?
> 
> Yeah there is atomic_fetch_{inc,dec}{_acquire,_release}()
> 
> Or:
>   atomic_inc(&sr.active);
>   smp_mb__after_atomic();
> 
>   smp_mb__before_atomic();
>   atomic_dec(&sr.active);
> 
> ?
>
> That's probably better because we don't need ordering before the inc
> or after the dec, AFAICS.
> 
There are two variants, atomic_inc_return() and atomic_dec_return()
which are fully ordered. Any thoughts about them? One line instead of
two as in your case.

Your concern is about, that atomic_inc() can be reodered? There is a
llist_add() that has inside the try_cmpxchg() that should have barrier.

Any thoughts?

Thank you for the review and help, Joel!

--
Uladzislau Rezki
