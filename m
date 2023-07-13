Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F171B752DE2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 01:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbjGMXSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 19:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbjGMXRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 19:17:45 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F80AA
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 16:17:43 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fb4146e8ceso12029615e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 16:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1689290262; x=1691882262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNtZQAU+1NBnYl0Q7O+PJo/Su/S1HUk8FojQN4NQ24s=;
        b=k8IDe/uPC0xHXo/NTi3jSm7SkyXIR9Bh0lo7NjYKS+gBjLs/XroiHhv7uhxA8J+mhl
         A16G/vHZF/BM5tmlPQ5EnbwrgLr3MzpMbYi3CTMXGCP+UgJFPQKtZe5PJB6zK4g2Y9Lw
         pj5x3zVg9tXkYS73F9hBQdQr3k6SumC+FBv1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689290262; x=1691882262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BNtZQAU+1NBnYl0Q7O+PJo/Su/S1HUk8FojQN4NQ24s=;
        b=SUeF7MZdasdW6X9pgZITf42q4zKVC7dHip0J7PpOZdPNeMPpC3APCAXA+Aan/B/pGx
         AXxTKkjHcW10Rwmi0fpmmRTHTOIwP1UWYH0Em0yW2+iKhfIojzHuNf1kpEG8QyqjDiHt
         HgbzM3FY0fCYbMWF+ZEEeOcVAv7qop+trGk+/vDYe2cfQiLWY9gxJINbO8LPuv3yBqqf
         fyzF8vMzL/h+g/Xvzn2EHAKcWCe2UFlORp8RWOhcLXLTGowAT4y1znnGQz/pnGqo3+2z
         L7puk0tiQEkITL/LsacIBIWjDWoMa4zBKa0vwgrq1FmYATb8F6qA1tw0xM9fo9k30pOQ
         u0hA==
X-Gm-Message-State: ABy/qLaA2VxQz/W8Mg0PUBJX6q8Dp6HuhKa5rX6Uakzw6e7th+Z/ZfA9
        JEghBjBIdEsm+78tYOQSbYVBhnpnmj3dX1rXL/+A5A==
X-Google-Smtp-Source: APBJJlGNC6oG8/QWhSI5r2zsxypKTf1HJt7tVzfVXeqTqpTDsp/qJUc1tboLolvdeM3uQaU/w0HMFrbkrpoeBKZiH1M=
X-Received: by 2002:a1c:6a19:0:b0:3fb:cfe8:8d12 with SMTP id
 f25-20020a1c6a19000000b003fbcfe88d12mr2252182wmc.14.1689290262143; Thu, 13
 Jul 2023 16:17:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230711043453.64095-1-ivan@cloudflare.com> <20230711193612.22c9bc04@kernel.org>
 <CAO3-PbrZHn1syvhb3V57oeXigE_roiHCbzYz5Mi4wiymogTg2A@mail.gmail.com> <20230712104210.3b86b779@kernel.org>
In-Reply-To: <20230712104210.3b86b779@kernel.org>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Thu, 13 Jul 2023 16:17:31 -0700
Message-ID: <CABWYdi3VJU7HUxzKJBKgX9wF9GRvmA0TKVpjuHvJyz_EdpxZFA@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] tcp: add a tracepoint for tcp_listen_queue_drop
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Yan Zhai <yan@cloudflare.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 10:42=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Wed, 12 Jul 2023 11:42:26 -0500 Yan Zhai wrote:
> >   The issue with kfree_skb is not that it fires too frequently (not in
> > the 6.x kernel now). Rather, it is unable to locate the socket info
> > when a SYN is dropped due to the accept queue being full. The sk is
> > stolen upon inet lookup, e.g. in tcp_v4_rcv. This makes it unable to
> > tell in kfree_skb which socket a SYN skb is targeting (when TPROXY or
> > socket lookup are used). A tracepoint with sk information will be more
> > useful to monitor accurately which service/socket is involved.
>
> No doubt that kfree_skb isn't going to solve all our needs, but I'd
> really like you to clean up the unnecessary callers on your systems
> first, before adding further tracepoints. That way we'll have a clear
> picture of which points can be solved by kfree_skb and where we need
> further work.

The existing UDP tracepoint was there for 12 years and it's a part of
what kernel exposes to userspace, so I don't think it's fair to remove
this and break its consumers. I think "do not break userspace" applies
here. The proposed TCP tracepoint mostly mirrors it, so I think it's
fair to have it.

I don't know why kfree_skb is called so much. I also don't agree with
Yan that it's not actually too much, because it's a lot (especially
compared with near zero for my proposed tracepoint). I can easily see
300-500k calls per second into it:

$ perf stat -I 1000 -a -e skb:kfree_skb -- sleep 10
#           time             counts unit events
     1.000520165             10,108      skb:kfree_skb
     2.010494526             11,178      skb:kfree_skb
     3.075503743             10,770      skb:kfree_skb
     4.122814843             11,334      skb:kfree_skb
     5.128518432             12,020      skb:kfree_skb
     6.176504094             11,117      skb:kfree_skb
     7.201504214             12,753      skb:kfree_skb
     8.229523643             10,566      skb:kfree_skb
     9.326499044            365,239      skb:kfree_skb
    10.002106098            313,105      skb:kfree_skb
$ perf stat -I 1000 -a -e skb:kfree_skb -- sleep 10
#           time             counts unit events
     1.000767744             52,240      skb:kfree_skb
     2.069762695            508,310      skb:kfree_skb
     3.102763492            417,895      skb:kfree_skb
     4.142757608            385,981      skb:kfree_skb
     5.190759795            430,154      skb:kfree_skb
     6.243765384            405,707      skb:kfree_skb
     7.290818228            362,934      skb:kfree_skb
     8.297764298            336,702      skb:kfree_skb
     9.314287243            353,039      skb:kfree_skb
    10.002288423            251,414      skb:kfree_skb

Most of it is NOT_SPECIFIED (1s data from one CPU during a spike):

$ perf script | sed 's/.*skbaddr=3D//' | awk '{ print $NF }' | sort |
uniq -c | sort -n | tail
      1 TCP_CLOSE
      2 NO_SOCKET
      4 TCP_INVALID_SEQUENCE
      4 TCP_RESET
     13 TCP_OLD_DATA
     14 NETFILTER_DROP
   4594 NOT_SPECIFIED

We can start a separate discussion to break it down by category if it
would help. Let me know what kind of information you would like us to
provide to help with that. I assume you're interested in kernel stacks
leading to kfree_skb with NOT_SPECIFIED reason, but maybe there's
something else.

Even if I was only interested in one specific reason, I would still
have to arm the whole tracepoint and route a ton of skbs I'm not
interested in into my bpf code. This seems like a lot of overhead,
especially if I'm dropping some attack packets.

Perhaps a lot of extra NOT_SPECIFIED stuff can be fixed and removed
from kfree_skb. It's not something I can personally do as it requires
much deeper network code understanding than I possess. For TCP we'll
also have to add some extra reasons for kfree_skb, because currently
it's all NOT_SPECIFIED (no reason set in the accept path):

* https://elixir.bootlin.com/linux/v6.5-rc1/source/net/ipv4/tcp_input.c#L64=
99
* https://elixir.bootlin.com/linux/v6.5-rc1/source/net/ipv4/tcp_ipv4.c#L174=
9

For UDP we already have SKB_DROP_REASON_SOCKET_RCVBUFF, so I tried my
best to implement what I wanted based on that. It's not very
approachable, as you'd have to extract the destination port yourself
from the raw skb. As Yan said, for TCP people often rely on skb->sk,
which is just not present when the incoming SYN is dropped. I failed
to find a good example of extracting a destination port that I could
replicate. So far I have just a per-reason breakdown working:

* https://github.com/cloudflare/ebpf_exporter/pull/233

If you have an ebpf example that would help me extract the destination
port from an skb in kfree_skb, I'd be interested in taking a look and
trying to make it work.

The need to extract the protocol level information in ebpf is only
making kfree_skb more expensive for the needs of catching rare cases
when we run out of buffer space (UDP) or listen queue (TCP). These two
cases are very common failure scenarios that people are interested in
catching with straightforward tracepoints that can give them the
needed information easily and cheaply.

I sympathize with the desire to keep the number of tracepoints in
check, but I also feel like UDP buffer drops and TCP listen drops
tracepoints are very much justified to exist.
