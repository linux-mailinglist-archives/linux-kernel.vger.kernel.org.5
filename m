Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5267E5606
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 13:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344296AbjKHMQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 07:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbjKHMQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 07:16:35 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D66B1BE4
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 04:16:33 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so13490a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 04:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699445791; x=1700050591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eih6T1QKUdzbWftoLZKbxzh3vZlf5WfPj/69P8AwcBM=;
        b=RuzCe10drsIdC9ejr4s+AxkC8YZXhoStz/bBWvA6sUIeMc3nwZ+/neh3U9tfA41Igj
         yXG1F9iNbxkqo54I0gthKfx/o9EqEPhHWickw14KQpR/pSNsmxqLGtDEpnwhrjrHJkwv
         hWEUdcgTW81Gip/zY1zZRlveAngQscXZBG1QC23U2CpQJuHcOodXeyjcbBUEdUGWLKwz
         sUCyM9zuSpXab2qV/aCOHhdmbl1oBQ3llV8d36HMxzKrfatl4BvTGqzzf7MbKdaYaJa9
         RPmu8z2qTW0WfZeJlXwXDZF/uOTq/ETeSEYDBfWinJI8XTc4ZkEBPRnBqADeeB5zZk0P
         OpGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699445791; x=1700050591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eih6T1QKUdzbWftoLZKbxzh3vZlf5WfPj/69P8AwcBM=;
        b=GW/Ufwan0tyeO99n/x9F4nZ6VftjvcYnmmpYkuKtFdiB7X1gaN27oaPdfxi+caoxr5
         gk/ZTDC3uPKm/LZa+6FJksZydDwi9UU+0TTwB1nJ2WAEe+KirU659Me7Tbaczn4rCWLU
         phGyhBSE9rpiq/0Ax1JWgHnuuCAkZRF+yLvxXRBEZG1JJ0YxRpf8o+DuglAvyXwFCONG
         olLvyTTS7kWKrrpr8FycUA+T9wFd3LSWVI/ndBnpuZ2m8GI1CRTEMmMoHEC6lY0XLqzV
         jI1J2kokPlJWfXtJJDNpB2X7c0BvqLuxrd097WG9JjUY6gfNDnVsjCNnDYVsYLrP9ZGE
         Hfxw==
X-Gm-Message-State: AOJu0YytPd6YPsr4mcquui3FWmtw6QzU/GQWe0ZCLvp/IwnXD+boE/SF
        ChGqd6QzBd/wc/NDiuu4lv1yk3AdF7EVPevA+c3WcA==
X-Google-Smtp-Source: AGHT+IFBqcWVcXbeWVdYU+5QWKDwce1Q7jwMeN9FTTGoz3Sj6+w3rpciGJdvCu5o5z1HqGkOlbvdLWc23EcpzzPGbLI=
X-Received: by 2002:aa7:d281:0:b0:545:3a48:ebab with SMTP id
 w1-20020aa7d281000000b005453a48ebabmr26889edq.5.1699445791385; Wed, 08 Nov
 2023 04:16:31 -0800 (PST)
MIME-Version: 1.0
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-1-ankur.a.arora@oracle.com> <20231107230822.371443-23-ankur.a.arora@oracle.com>
In-Reply-To: <20231107230822.371443-23-ankur.a.arora@oracle.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 8 Nov 2023 13:16:17 +0100
Message-ID: <CANn89i+b3=N1gT7rrrxU+zOMN_VzzHjyYW=TeE5AMSoKcdLvyg@mail.gmail.com>
Subject: Re: [RFC PATCH 79/86] treewide: net: remove cond_resched()
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
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com,
        Marek Lindner <mareklindner@neomailbox.ch>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Antonio Quartulli <a@unstable.cc>,
        Sven Eckelmann <sven@narfation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Roopa Prabhu <roopa@nvidia.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        David Ahern <dsahern@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Matthieu Baerts <matttbe@kernel.org>,
        Mat Martineau <martineau@kernel.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Xin Long <lucien.xin@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Jon Maloy <jmaloy@redhat.com>,
        Ying Xue <ying.xue@windriver.com>,
        Martin Schiller <ms@dev.tdt.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 8, 2023 at 12:09=E2=80=AFAM Ankur Arora <ankur.a.arora@oracle.c=
om> wrote:
>
> There are broadly three sets of uses of cond_resched():
>
> 1.  Calls to cond_resched() out of the goodness of our heart,
>     otherwise known as avoiding lockup splats.
>
> 2.  Open coded variants of cond_resched_lock() which call
>     cond_resched().
>
> 3.  Retry or error handling loops, where cond_resched() is used as a
>     quick alternative to spinning in a tight-loop.
>
> When running under a full preemption model, the cond_resched() reduces
> to a NOP (not even a barrier) so removing it obviously cannot matter.
>
> But considering only voluntary preemption models (for say code that
> has been mostly tested under those), for set-1 and set-2 the
> scheduler can now preempt kernel tasks running beyond their time
> quanta anywhere they are preemptible() [1]. Which removes any need
> for these explicitly placed scheduling points.

What about RCU callbacks ? cond_resched() was helping a bit.

>
> The cond_resched() calls in set-3 are a little more difficult.
> To start with, given it's NOP character under full preemption, it
> never actually saved us from a tight loop.
> With voluntary preemption, it's not a NOP, but it might as well be --
> for most workloads the scheduler does not have an interminable supply
> of runnable tasks on the runqueue.
>
> So, cond_resched() is useful to not get softlockup splats, but not
> terribly good for error handling. Ideally, these should be replaced
> with some kind of timed or event wait.
> For now we use cond_resched_stall(), which tries to schedule if
> possible, and executes a cpu_relax() if not.
>
> Most of the uses here are in set-1 (some right after we give up a
> lock or enable bottom-halves, causing an explicit preemption check.)
>
> We can remove all of them.

A patch series of 86 is not reasonable.

596 files changed, 881 insertions(+), 2813 deletions(-)

If really cond_resched() becomes a nop (Nice !) ,
make this at the definition of cond_resched(),
and add there nice debugging.

Whoever needs to call a "real" cond_resched(), could call a
cond_resched_for_real()
(Please change the name, this is only to make a point)

Then let the removal happen whenever each maintainer decides, 6 months
later, without polluting lkml.

Imagine we have to revert this series in 1 month, how painful this
would be had we removed
~1400 cond_resched() calls all over the place, with many conflicts.

Thanks
