Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BC17E4C70
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbjKGXEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235158AbjKGXEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:04:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D96810CC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 15:04:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B5CCC433C7;
        Tue,  7 Nov 2023 23:04:34 +0000 (UTC)
Date:   Tue, 7 Nov 2023 18:04:37 -0500
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
Subject: Re: [RFC PATCH 02/86] Revert "sched/core: Make sched_dynamic_mutex
 static"
Message-ID: <20231107180437.58666d6a@gandalf.local.home>
In-Reply-To: <20231107215742.363031-3-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
        <20231107215742.363031-3-ankur.a.arora@oracle.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 Nov 2023 13:56:48 -0800
Ankur Arora <ankur.a.arora@oracle.com> wrote:

> This reverts commit 9b8e17813aeccc29c2f9f2e6e68997a6eac2d26d.

Please explain why it's being reverted.

-- Steve

> 
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  kernel/sched/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 802551e0009b..ab773ea2cb34 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8746,7 +8746,7 @@ int sched_dynamic_mode(const char *str)
>  #error "Unsupported PREEMPT_DYNAMIC mechanism"
>  #endif
>  
> -static DEFINE_MUTEX(sched_dynamic_mutex);
> +DEFINE_MUTEX(sched_dynamic_mutex);
>  static bool klp_override;
>  
>  static void __sched_dynamic_update(int mode)

