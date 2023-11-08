Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F787E5BB4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 17:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjKHQuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 11:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjKHQuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 11:50:03 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB281FD6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 08:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k0cmwXDf9mNEfGVLM+XbtxKWBRgBMnhpCA1nGcyhhhM=; b=MBSWrXa2GWf0mhEzsuRa91iuUT
        4rw/voGMKkTc7jZtdyuVUrQmNF9NHJh9O2KjqQu8GBU/X93WETeLsWMYLpn333Ll7v97T+5/64R8c
        uL0uyNMqmWlmRD6oWav70inkgHx6aL8j2VAETS4U3s+DHzwjEvqeE6CLknE3qxDLHcxpLI4LphglK
        2uiVfVA/TL8hpIo3KZdG1HHps9EW1QH5z78BHAMxU/IfQhyijV9xl9wHCNapsP4GJRxd+u9za4wwk
        e5qdcBhlxlvxSt08F8AHxwn/UXUhTjL1AmOwsig4tThdU7PIrIzSTwXZEBiPB7liyw5htzsaZT1kh
        2tzd48Ow==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r0ljw-0026LN-Cg; Wed, 08 Nov 2023 16:49:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id B7CBF30049D; Wed,  8 Nov 2023 17:49:16 +0100 (CET)
Date:   Wed, 8 Nov 2023 17:49:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, David.Laight@aculab.com,
        richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 00/86] Make the kernel preemptible
Message-ID: <20231108164916.GR8262@noisy.programming.kicks-ass.net>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231108085156.GD8262@noisy.programming.kicks-ass.net>
 <87bkc4lfxp.fsf@oracle.com>
 <20231108101330.GK3818@noisy.programming.kicks-ass.net>
 <877cmsgsrg.ffs@tglx>
 <20231108112227.62f0c5a8@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108112227.62f0c5a8@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2023 at 11:22:27AM -0500, Steven Rostedt wrote:

> Peter, how can you say we can get rid of cond_resched() in NONE when you

Because that would fix none to actually be none. Who cares.

> > Look at my PoC: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
> 
> And I've been saying that many times already ;-)

Why should I look at random patches on the interweb to make sense of
these patches here?

That just underlines these here patches are not making sense.
