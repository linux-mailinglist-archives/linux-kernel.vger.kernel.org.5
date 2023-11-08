Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0A87E59B3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 16:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjKHPIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 10:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbjKHPIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 10:08:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0D61BE6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 07:08:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1503EC433C7;
        Wed,  8 Nov 2023 15:08:14 +0000 (UTC)
Date:   Wed, 8 Nov 2023 10:08:18 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
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
        krypton@ulrich-teichert.org, David.Laight@aculab.com,
        richard@nod.at, mjguzik@gmail.com,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Thomas Graf <tgraf@suug.ch>
Subject: Re: [RFC PATCH 71/86] treewide: lib: remove cond_resched()
Message-ID: <20231108100818.4bc238e7@gandalf.local.home>
In-Reply-To: <ZUtRn7oJLL5fisco@gondor.apana.org.au>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
        <20231107230822.371443-1-ankur.a.arora@oracle.com>
        <20231107230822.371443-15-ankur.a.arora@oracle.com>
        <ZUtRn7oJLL5fisco@gondor.apana.org.au>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Nov 2023 17:15:11 +0800
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> >  lib/crc32test.c          |  2 --
> >  lib/crypto/mpi/mpi-pow.c |  1 -
> >  lib/memcpy_kunit.c       |  5 -----
> >  lib/random32.c           |  1 -
> >  lib/rhashtable.c         |  2 --
> >  lib/test_bpf.c           |  3 ---
> >  lib/test_lockup.c        |  2 +-
> >  lib/test_maple_tree.c    |  8 --------
> >  lib/test_rhashtable.c    | 10 ----------
> >  9 files changed, 1 insertion(+), 33 deletions(-)  
> 
> Nack.

A "Nack" with no commentary is completely useless and borderline offensive.

What is your rationale for the Nack?

The cond_resched() is going away if the patches earlier in the series gets
implemented. So either it is removed from your code, or it will become a
nop, and just wasting bits in the source tree. Your choice.

-- Steve
