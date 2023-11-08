Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A447E5AF2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 17:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjKHQRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 11:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjKHQRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 11:17:00 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA74C6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 08:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HQBcuS6yynl+Xfotv8WVzOrBYwQy2vL25amr6eMARVY=; b=h9bhuwShSjT5j1fkk4MZczqB8z
        HfLwgnd9msTJSp9dw2tR9kzySqbfyg7v3aN+xtjbR+/jp8jUAm1irqQuRR7Mnjd+4fw1WxSFmCWSG
        iTdn9D7DCqdl07LtkC4IKvTyG+dh18oTHkIFD5pY2ZVmzZIaOJJzOLD/QpTJdWClCinmaInGnOVEO
        4SiRqxsBaHReCi9fBod7QUPljDBd2+9bPCoLON3h22BNT1CXB7k8HkC/kr/7NFaPbLoC9H4eL5UNv
        yjmQpKZ5Gen3NcmUI7JtV3ZlkCiImVYzbbjGudQyw69w6xKMg0BHLpEKJteoeHXvfqC64x5Guquu/
        W8xzPniQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r0lDg-00DbhO-1v;
        Wed, 08 Nov 2023 16:15:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4485030049D; Wed,  8 Nov 2023 17:15:56 +0100 (CET)
Date:   Wed, 8 Nov 2023 17:15:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
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
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 00/86] Make the kernel preemptible
Message-ID: <20231108161556.GL3818@noisy.programming.kicks-ass.net>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231108085156.GD8262@noisy.programming.kicks-ass.net>
 <87bkc4lfxp.fsf@oracle.com>
 <20231108101330.GK3818@noisy.programming.kicks-ass.net>
 <877cmsgsrg.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877cmsgsrg.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2023 at 04:38:11PM +0100, Thomas Gleixner wrote:

> No. The whole point of LAZY is to keep preempt_schedule(),
> preempt_schedule_notrace(), irqentry_exit_cond_resched() always enabled.

Yeah, I got that. What wasn't at all clear is that it also wanted to
replace NONE.

0/n didn't even mention none.
