Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A62079CFE3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234796AbjILL3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234694AbjILL2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:28:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A27A10E6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 04:28:25 -0700 (PDT)
Date:   Tue, 12 Sep 2023 13:28:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694518104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rVXc3PWu7AetKzemOvQUJuvc1Uvg62gmmwcrHINKezw=;
        b=Esx03WWET490njwJ3rbg8+inaFrdlwkk0kMYYJTSerpMA0CQSV1xDnq+ObfPUzHMvJzheE
        4b6RjF0pxo9lA5IFe/wf2SP8teGqSG1w1XBSRNhUIMshFG3Sf/IL5SPqq1yfT3ctAy1PH6
        t5u6VcnGwJ1GG1U1u6u9cat8IK/JvYWFbYq/+ILS6nbU4rnXgVJ/92gKTRVJOO3JjTTjAi
        ih967cAqh0B1m3+lWEp5jyyJPBA/9JfrJZpug1oUzXfxlI0tQIedpZuYjG4us9UHJ7ub+G
        betFktSHdPRI/aJhLSeSf3x7v+VNM71EegB1Dwc1McNj+TxVJejgoY7isoq+zQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694518104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rVXc3PWu7AetKzemOvQUJuvc1Uvg62gmmwcrHINKezw=;
        b=16SWC6aktDaFsKfgy5oVbAjFl0z+3ydCXTlaakAuHIBv6+EAPPjd5seo8JvS+POg5m+R+g
        kMFlHSOla1JmK3AA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        boqun.feng@gmail.com, bristot@redhat.com, bsegall@google.com,
        dietmar.eggemann@arm.com, jstultz@google.com,
        juri.lelli@redhat.com, longman@redhat.com, mgorman@suse.de,
        mingo@redhat.com, rostedt@goodmis.org, swood@redhat.com,
        vincent.guittot@linaro.org, vschneid@redhat.com, will@kernel.org
Subject: Re: [PATCH v3 7/7] locking/rtmutex: Acquire the hb lock via trylock
 after wait-proxylock.
Message-ID: <20230912112823.E2Ygzkl3@linutronix.de>
References: <20230908162254.999499-1-bigeasy@linutronix.de>
 <20230908162254.999499-8-bigeasy@linutronix.de>
 <20230911141135.GB9098@noisy.programming.kicks-ass.net>
 <20230912111711.DHVKG-B4@linutronix.de>
 <20230912112551.GH35261@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230912112551.GH35261@noisy.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-12 13:25:51 [+0200], Peter Zijlstra wrote:
> 
> And I think there was a requeue site that wants updating too.. the above
> was more or less a starting point for discussion :-)

Yes. I spent the morning testing it so I can contribute to the
discussion ;)

Sebastian
