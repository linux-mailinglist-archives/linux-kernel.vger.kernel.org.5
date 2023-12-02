Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B9F801FC5
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 00:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbjLBXpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 18:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLBXpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 18:45:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFFC107
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 15:45:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FBA2C433C8;
        Sat,  2 Dec 2023 23:45:10 +0000 (UTC)
Date:   Sat, 2 Dec 2023 18:45:07 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RCU] rcu_tasks_trace_qs(): trc_reader_special.b.need_qs value
 incorrect likely()?
Message-ID: <20231202184507.26178c17@rorschach.local.home>
In-Reply-To: <b0772bf3-5b47-4aea-b964-17a2bebc6313@paulmck-laptop>
References: <20231201154932.468d088b@gandalf.local.home>
        <b0772bf3-5b47-4aea-b964-17a2bebc6313@paulmck-laptop>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Dec 2023 14:24:26 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> > Note, the unlikely tracing is running on my production server v6.6.3.
> > 
> > The above trace is from my test box with latest Linus's tree.  
> 
> Nice tool!!!

Thanks! It's only been in the kernel since 2008 ;-)

  1f0d69a9fc815 ("tracing: profile likely and unlikely annotations")

> 
> My kneejerk reaction is that that condition is suboptimal.  Does the 
> (untested) patch below help things?

I'll give it a try on Monday.

Thanks,

-- Steve
