Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB907E5499
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 11:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344352AbjKHK5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 05:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344193AbjKHK4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 05:56:32 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2154719B3;
        Wed,  8 Nov 2023 02:56:30 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c6cb4a79deso7362971fa.1;
        Wed, 08 Nov 2023 02:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699440988; x=1700045788; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mogb3IhGt4Q2N3obqjOBm5LdYq5oV+x18gHfAYgpPNk=;
        b=RD2RE0iVUoFJPo33S4DqIS6GVUIYd5V9d8V8baW8q5QvyxQlzius10qGmw49Tf5rAa
         tP6G8MBhCi/DvqnUmJReIoHxC3BxyuNWYfgJLOP+Ucx0Y/yuiP+45bsFHAij5u/cufRP
         tDedE1hMfNlgfBY0lvEBv1IJ5oKr75g+w0lD6bZQIPVj1Us95NpUIwT53jgFXi7w7MMf
         W9e1HupkO40SHQlWmyPdWU0W9kIJhpf+npw1b+1eOhAk27PEVD356Oy7TRviSeUOMgfC
         ytEoeVQgGgcUSh03kiVlchcEX1hAzfdHPVsE8eX40G7IFMEzsa/oOwN+GHhzZXrq8Uws
         p0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699440988; x=1700045788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mogb3IhGt4Q2N3obqjOBm5LdYq5oV+x18gHfAYgpPNk=;
        b=wfqUBIjcDPRLxZQTZqFGAdSLTpHbo7+wI0b5l+DarKIyF5/rLlZOVP/SscbhjfGXnO
         a1kY3e9p2cM8KQSCurSX5x5yvKJB0Ex7rb2qE4Q6TbpWczgw6UCn+eQSg2eIFRZdfbkJ
         u2uq2EaOpCvndue04s5w06w8AmTtlvkKhf8tY7b9SX1bguSUYVrWBSDLL0T3L7eY9IlK
         ptfWkxSejLqF5DcSzoaB2OYcFpg6/66rl5TSUimMWiOg7rPuAAPuOfvabp/CiV372kmt
         Nrw2TFBXq1vOJicEU3mf6kHm6HPA0ynJ3Gv9rsObJno8ZjS/bTBcolXIWJlKTDQmmLfC
         zN/w==
X-Gm-Message-State: AOJu0Yzdyjx+tuKTZr/AlHj5IvkKmYz578FkgI/SnqI56IivXv8moM3/
        p73iAYGzIWGFLCi6sFXLE4I=
X-Google-Smtp-Source: AGHT+IEVyArZPgncj1YKFJ3k7sVO9cmkBEulfPZ4Grh0yx492fXesW0whNpmZqqjPLub18SygXbpbw==
X-Received: by 2002:a2e:2f10:0:b0:2c5:332:f18d with SMTP id v16-20020a2e2f10000000b002c50332f18dmr1920319ljv.2.1699440987967;
        Wed, 08 Nov 2023 02:56:27 -0800 (PST)
Received: from pc636 (host-90-233-220-95.mobileonline.telia.com. [90.233.220.95])
        by smtp.gmail.com with ESMTPSA id 13-20020a2e164d000000b002bce3123639sm1879274ljw.98.2023.11.08.02.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 02:56:27 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 8 Nov 2023 11:56:25 +0100
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, RCU <rcu@vger.kernel.org>,
        Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v2 1/3] rcu: Reduce synchronize_rcu() latency
Message-ID: <ZUtpWbUfdesFWvDw@pc636>
References: <20231030131254.488186-1-urezki@gmail.com>
 <20231030131254.488186-2-urezki@gmail.com>
 <70578164-6c12-47ca-9528-163b688c1b47@paulmck-laptop>
 <ZUjWWpqOQObm8yaz@pc636>
 <988c2023-f97b-4706-8a97-e829bc030245@paulmck-laptop>
 <ZUpH7BqS3PldQf5K@pc636>
 <9cd799fd-e4e9-4a24-9e91-0443592b2960@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cd799fd-e4e9-4a24-9e91-0443592b2960@paulmck-laptop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > Do you have something that can easily trigger it? I mean some proposal
> > or steps to test. Probably i should try what you wrote, regarding
> > toggling from user space.
> > 
> > > I can imagine ways around this, but they are a bit ugly.  They end
> > > up being things like recording a timestamp on every sysfs change to
> > > rcu_normal, and then using that timestamp to deduce whether there could
> > > possibly have been sysfs activity on rcu_normal in the meantime.
> > > 
> > > It feels like it should be so easy...  ;-)
> > > 
> > Hmm.. Yes it requires more deep analysis :)
> 
> Maybe make that WARN_ONCE() condition also test a separate Kconfig
> option that depends on both DEBUG_KERNEL and RCU_EXPERT?
> 
Do you mean to introduce a new Kconfig? For example CONFIG_DEBUG_SRS:

<snip>
config DEBUG_SRS
        bool "Provide debugging asserts for normal synchronize_rcu() call"
        depends on DEBUG_KERNEL && RCU_EXPERT
        help
	   ...
<snip>

> > > > I was thinking about read_lock()/write_lock() since we have many readers
> > > > and only one writer. But i do not really like it either.
> > > 
> > > This might be a hint that we should have multiple lists, perhaps one
> > > per CPU.  Or lock contention could be used to trigger the transition
> > > from a single list to multiple lists. as is done in SRCU and tasks RCU.
> > >
> > I do not consider to be a sync call as heavily used as other callbacks
> > which require several workers to handle, IMHO. From the other hand my
> > experiments show that to handle 60K-100K by NOCB gives even worse results.
> > 
> > > 
> > > But I bet that there are several ways to make things work.
> > > 
> > Right. The main concern with read_lock()/write_lock() is a PREEMPT_RT
> > kernels where it is a rt-mutex. It would be good to avoid of using any
> > blocking in the gp-kthread since it is a gp driver.
> 
> RCU is pretty low-level, so it is OK with a raw spinlock for the list
> manipulation.  But only the list manipulation itself.  Perhaps you are
> worried about lock contention, but in that case, there is also the issue
> of memory contention for the llist code.
> 
I do not consider a lock nor memory contention as an issue here. Whereas
blocking on rt-mutex in the gp-kthread i consider as "not good to go with".
raw-spinlocks are OK, but it is a per-cpu or per-node approach which i tend
to avoid, if not, then probably per-cpu-or-node and merge everything into
one llist to offload by one worker.

--
Uladzislau Rezki
