Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659D77DA140
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 21:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbjJ0TXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 15:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjJ0TXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 15:23:46 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2BC18F;
        Fri, 27 Oct 2023 12:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XM2rmBDfnn/OdY5k6mzvvSgataWYn9Q1nKf6N/KUMco=; b=o5osNn0mhZs9ifcDHDw7hyHaGq
        3ShNzLsL9LtlLLqtda3px3q+NUDNs2zdrSifjt2eA6evgMdjJejLv7ok/+UhNgn9EJOk4e79c1hO5
        eOry4dNhhfiobdtXFqFVKb+Z0fhlWBX2cPVDT3/p+PX6tR4jyIOOcs8GsKZM4L2YboSnS6IRRZD0Q
        hXqgtsaCVvw2ckfHtBsAguGwmM74jnOO7vyQ9h2yXlarJlF6PVjcCHWR9pnzVQCpUI1ZQcrotj7Y6
        o/ByG3MrMCrB6iH76XuJk2+Fc6cjEaMJQIPzyYJjOZAuxbDadiEgWV5rUi5RLsjxnid6LDQH1xqBb
        hyQg3IvQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qwSQV-000xvj-2g;
        Fri, 27 Oct 2023 19:23:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 46827300392; Fri, 27 Oct 2023 21:23:23 +0200 (CEST)
Date:   Fri, 27 Oct 2023 21:23:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Zqiang <qiang.zhang1211@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH 0/4] rcu: Fix PF_IDLE related issues v3
Message-ID: <20231027192323.GH26550@noisy.programming.kicks-ass.net>
References: <20231027144050.110601-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027144050.110601-1-frederic@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 04:40:46PM +0200, Frederic Weisbecker wrote:

> Frederic Weisbecker (4):
>       rcu: Introduce rcu_cpu_online()
>       rcu/tasks: Handle new PF_IDLE semantics
>       rcu/tasks-trace: Handle new PF_IDLE semantics
>       sched: Exclude CPU boot code from PF_IDLE area

Aside of that pre-existing ->on_rq usage I can't see anything wrong with
this.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
