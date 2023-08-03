Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E3F76EF84
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 18:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbjHCQcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 12:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbjHCQck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 12:32:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BC730D5;
        Thu,  3 Aug 2023 09:32:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACE9661E3A;
        Thu,  3 Aug 2023 16:32:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C128C433C8;
        Thu,  3 Aug 2023 16:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691080359;
        bh=ptaxZ4bU16R1uvGfuuzlliYFRX98Xym9B152pK1Wfyk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=gc2iGCVD1BlpyHtmLfHMiJRXTSzasjCXFMP+d2p0/seDfDMNm638QDAbfwh4qzSd9
         4t6sUHmb4jI3hjeKdReELofbpLOC+s6c6plA+VYoeDsk3LP9sJLzsVtgTOsmKiA56X
         0W/QZZMNKK+rVfB42rX5Ib41UWve0bDWLLfZZCgUTWjirgCku0+wrahyz31BEES2po
         IPlxZAEHgK1vKIS4h1v0wL2wNZNNzyl259lXWabOkmsr2Z5E4PVn7lrcA2WPiec6wU
         3VG861tsr5CQx7D5fzFRUGQQ1Jm/Dqll3GZftUhnSJjcEUp7iGwSU5bgf0gPdHTr2N
         H5+I8OwHNKZ6A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 97057CE0C8E; Thu,  3 Aug 2023 09:32:38 -0700 (PDT)
Date:   Thu, 3 Aug 2023 09:32:38 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Zhen Lei <thunder.leizhen@huawei.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: include torture_sched_setaffinity() declaration
Message-ID: <10180121-4584-463a-af52-1005b23271e7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230803144025.14023-1-arnd@kernel.org>
 <CAEXW_YQSO_OZ5MCT6kaTHLV7SgBWyiu8ATfcU7fsCdO=GwiQ9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YQSO_OZ5MCT6kaTHLV7SgBWyiu8ATfcU7fsCdO=GwiQ9Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 12:02:52PM -0400, Joel Fernandes wrote:
> On Thu, Aug 3, 2023 at 10:40 AM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > The prototype for torture_sched_setaffinity() moved to a
> > different header, which needs to be included from update.c
> > to avoid this W=1 warning:
> >
> > kernel/rcu/update.c:529:6: error: no previous prototype for 'torture_sched_setaffinity' [-Werror=missing-prototypes]
> >   529 | long torture_sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
> >
> > Fixes: 521ec59e5453e ("torture: Move rcutorture_sched_setaffinity() out of rcutorture")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Queued (likely for the v6.7 merge window), thank you both!

							Thanx, Paul

> thanks,
> 
> - Joel
> 
> 
> > ---
> >  kernel/rcu/update.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> > index 0533b510f0a8..c534d6806d3d 100644
> > --- a/kernel/rcu/update.c
> > +++ b/kernel/rcu/update.c
> > @@ -25,6 +25,7 @@
> >  #include <linux/interrupt.h>
> >  #include <linux/sched/signal.h>
> >  #include <linux/sched/debug.h>
> > +#include <linux/torture.h>
> >  #include <linux/atomic.h>
> >  #include <linux/bitops.h>
> >  #include <linux/percpu.h>
> > --
> > 2.39.2
> >
