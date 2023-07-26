Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9DE7638C4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 16:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbjGZOPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 10:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbjGZOPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:15:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1128635B8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 07:13:52 -0700 (PDT)
Date:   Wed, 26 Jul 2023 16:12:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690380775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=unpTRsbeKY+MpufWmTAfqvuCcibHkreAH23aDKs5sS4=;
        b=mXvs1veXqF0iy6uKi+vbzqU7VDBxdqpPGe31Vy0E3sqOTCAe6EK8X31NsRpvHHf08Nt9fB
        2JzgZJ0mCrgXEaVmO0cqlslpb6A8novBeSBnjsxPhGvc11wOhJ4BXju8WumYGRz1/IFVes
        trcYq2iIkzQwfeo2A/EdLtQF+E/zTTCvsfXPrYEXTvu+LqysfMic341f0EjJ60KopuonbG
        k/078/7J/X/ENapeitXHeLhWKJCW6Vs/ncYwnhhlpqNmLkmKfcoe83Cb7ImL6gbaCMbiOO
        IWjTGPrvY/e7xkpAF4McBkOdICvdMDLhkOa3p6Pd6uzpPPB1ySjmSnptCENadg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690380775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=unpTRsbeKY+MpufWmTAfqvuCcibHkreAH23aDKs5sS4=;
        b=sA5WOFR5XeWJ45jDYhrwguoBWcs8MZIgUO7jHVleJ7ilMOIyaEQg0/K3TUhDOX3y6u65kq
        5z+o4I+bLAwMq5Ag==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     triangletrap12@gmail.com, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
        Boqun Feng <boqun.feng@gmail.com>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] locking/rtmutex: Fix task->pi_waiters integrity
Message-ID: <20230726141253.R_LS0bsr@linutronix.de>
References: <20230707161052.GF2883469@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230707161052.GF2883469@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-07 18:10:52 [+0200], Peter Zijlstra wrote:
> 
> Henry reported that rt_mutex_adjust_prio_check() has an ordering

I'm going to apply it to the RT tree so it does not get lost :)

Sebastian
