Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56ECA7E4CA2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235576AbjKGXV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235406AbjKGXVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:21:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407C92139
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 15:12:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48074C433C7;
        Tue,  7 Nov 2023 23:12:29 +0000 (UTC)
Date:   Tue, 7 Nov 2023 18:12:32 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
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
        krypton@ulrich-teichert.org, David.Laight@ACULAB.COM,
        richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 04/86] Revert "preempt/dynamic: Introduce preemption
 model accessors"
Message-ID: <20231107181232.26dcdf61@gandalf.local.home>
In-Reply-To: <20231107215742.363031-5-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
        <20231107215742.363031-5-ankur.a.arora@oracle.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 Nov 2023 13:56:50 -0800
Ankur Arora <ankur.a.arora@oracle.com> wrote:

I know this is an RFC but I'll state it here just so that it is stated. All
reverts need a change log description to why a revert happened, even if you
are just cut and pasting the reason for every commit. That's because git
commits need to be stand alone and not depend on information in other git
commit change logs.

-- Steve


> This reverts commit cfe43f478b79ba45573ca22d52d0d8823be068fa.
> 
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  include/linux/sched.h | 41 -----------------------------------------
>  kernel/sched/core.c   | 12 ------------
>  2 files changed, 53 deletions(-)
> 
