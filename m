Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596947CB095
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 18:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbjJPQ4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 12:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234346AbjJPQ4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 12:56:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3938B1BDA
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 09:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+K+H6P5ca06ze5jNAi7+j/eV/kQqkOwYTk279J4BMsk=; b=VnvWKzb8GvEO+SpPOl7tcHqHxv
        5e247SODqOQFoAo6il1rena7v99LKIrrYTa9mmHzDV57kak5eLwW/3SV5Du1wk4DRL9LvEHFhyfuD
        +OuckGbgM4tCDpf6Hvs8bzBm8Uc0yjP0kilNj71H4eT4+qgIlpoZe/5p3QQjLlus82xjxvuARfdc5
        /rjKI87L/HNe7XjLbyj6Onp67mKmxkAh72cmM0hCTTK17jP4WO6XVkzHfLXUIw3i9ohTcCu+YPvTn
        fR8AIh6OgO+mtKYUnZc/SE0hocf9QU0syq52tlsClm3BRoWxoVWkqBXuxZOXC3eA0EDhmFh2nrbFv
        PR6TLIaw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qsQp6-007CyA-Nb; Mon, 16 Oct 2023 16:52:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 63969300513; Mon, 16 Oct 2023 18:52:08 +0200 (CEST)
Date:   Mon, 16 Oct 2023 18:52:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Youssef Esmat <youssefesmat@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, bsegall@google.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com, mgorman@suse.de,
        bristot@redhat.com, corbet@lwn.net, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, joel@joelfernandes.org, efault@gmx.de,
        tglx@linutronix.de, wuyun.abel@bytedance.com
Subject: Re: [PATCH] sched/eevdf: Toggle eligibility through sched_feat
Message-ID: <20231016165208.GH33217@noisy.programming.kicks-ass.net>
References: <20231013030213.2472697-1-youssefesmat@chromium.org>
 <20231015104428.GA11840@noisy.programming.kicks-ass.net>
 <20231016112851.5cc0ccad@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016112851.5cc0ccad@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 11:28:51AM -0400, Steven Rostedt wrote:

> The main point is, our testing is not around any single benchmark that we
> are trying to make happy. We really are looking at what makes the user base
> run better in the real world.

This is a key (har-har) performance indicator for you guys though, I've
seen it mentioned before (with the core-scheduling crud IIRC).

As such it would be good to capture in a stand alone program and share.
