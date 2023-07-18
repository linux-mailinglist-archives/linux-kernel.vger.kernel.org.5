Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63433758846
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 00:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjGRWKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 18:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjGRWK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 18:10:26 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DD119B0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:10:22 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-314319c0d3eso6269951f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1689718221; x=1692310221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBK526CC9vRM8Qicvd5fv+TDorJV2z3St+r9zTNd/dg=;
        b=K0k0d3wBHzrO0MRiJievBoNmRX6KbxNymIWT6RBI4ZnD4Q3QUdIXiGVD9ZCIYGJtYJ
         bhZFB5IvP9mYMWHbRw6Qz3FvXD8xmQMbtxB3pJdFEQzr8Lbaxx9hpG8WiaX3K3ZgqRrx
         nFrLWN6sA+CrRuw3ZM37Qpo47Z5fyxL4HpY7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689718221; x=1692310221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZBK526CC9vRM8Qicvd5fv+TDorJV2z3St+r9zTNd/dg=;
        b=abSafEzaYw7iyH3ZM3kks8pu9FBOtxtMbS2Np2RDIgp2aol0fxI9z4haWaxT/OfkEp
         4kpJfNlqUIZL/kq67wLjWjBHTXAlUvv+LwX1NCwZhL3LFFnGIzwMEDt7jM8a7VZBi3C5
         51Sguo0x3kaGU/2FbsYg6I0D+uSwjDA/bTNtQ0rfScP9NnIBLcB2upabYImEVma593Ky
         dBtVR1n7EOZwA9Zj9nCvgZd9PHYXDUw8jY7d01VCN8E2hKbHsIYD7R6OV0Ypx7iiC9OO
         80bR8OKA/kWSpbCFnZhnPSCmCipRUsDLXGGJTzM/dj3Z+Q9LLqiE/4935tDSiCXTCApd
         ya8w==
X-Gm-Message-State: ABy/qLZZJDx45t54//yqseajSOsg9hjHWki/CWJbVJxaRmPIX+XAUSB9
        0NO2xwHFRmS8nujNou50sKP28Pt37v8aHYueXqY3SglfDwR5NC9Oyb+3eg==
X-Google-Smtp-Source: APBJJlGSxi7Q0gYf65Evd47mpx07ZCmyA0AUflwDdZnd4to/MmdbWpKGn4QLA6K2tRLJ+OO1NGCqi7ryE6ikaY20jDc=
X-Received: by 2002:adf:eb44:0:b0:314:36c5:e4c0 with SMTP id
 u4-20020adfeb44000000b0031436c5e4c0mr812830wrn.11.1689718220693; Tue, 18 Jul
 2023 15:10:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230711043453.64095-1-ivan@cloudflare.com> <20230711193612.22c9bc04@kernel.org>
 <CAO3-PbrZHn1syvhb3V57oeXigE_roiHCbzYz5Mi4wiymogTg2A@mail.gmail.com>
 <20230712104210.3b86b779@kernel.org> <CABWYdi3VJU7HUxzKJBKgX9wF9GRvmA0TKVpjuHvJyz_EdpxZFA@mail.gmail.com>
 <c015fdb8-9ac1-b45e-89a2-70e8ababae17@kernel.org> <CABWYdi010VpHHi6-PLyBB3F_btFggm7XLxstboCRBvBLdoKdmA@mail.gmail.com>
 <3cab5936-c696-157f-f3a6-eba8b26df32d@kernel.org>
In-Reply-To: <3cab5936-c696-157f-f3a6-eba8b26df32d@kernel.org>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Tue, 18 Jul 2023 15:10:09 -0700
Message-ID: <CABWYdi3L3HddnoVvhwAD0Mm57AfPDF0J2z42OV_hO34Ev0XNSw@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] tcp: add a tracepoint for tcp_listen_queue_drop
To:     David Ahern <dsahern@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Yan Zhai <yan@cloudflare.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 6:30=E2=80=AFPM David Ahern <dsahern@kernel.org> wr=
ote:
>
> On 7/14/23 5:38 PM, Ivan Babrou wrote:
> > On Fri, Jul 14, 2023 at 8:09=E2=80=AFAM David Ahern <dsahern@kernel.org=
> wrote:
> >>> We can start a separate discussion to break it down by category if it
> >>> would help. Let me know what kind of information you would like us to
> >>> provide to help with that. I assume you're interested in kernel stack=
s
> >>> leading to kfree_skb with NOT_SPECIFIED reason, but maybe there's
> >>> something else.
> >>
> >> stack traces would be helpful.
> >
> > Here you go: https://lore.kernel.org/netdev/CABWYdi00L+O30Q=3DZah28QwZ_=
5RU-xcxLFUK2Zj08A8MrLk9jzg@mail.gmail.com/
> >
> >>> Even if I was only interested in one specific reason, I would still
> >>> have to arm the whole tracepoint and route a ton of skbs I'm not
> >>> interested in into my bpf code. This seems like a lot of overhead,
> >>> especially if I'm dropping some attack packets.
> >>
> >> you can add a filter on the tracepoint event to limit what is passed
> >> (although I have not tried the filter with an ebpf program - e.g.,
> >> reason !=3D NOT_SPECIFIED).
> >
> > Absolutely, but isn't there overhead to even do just that for every fre=
ed skb?
>
> There is some amount of overhead. If filters can be used with ebpf
> programs, then the differential cost is just the cycles for the filter
> which in this case is an integer compare. Should be low - maybe Steven
> has some data on the overhead?

I updated my benchmarks and added two dimensions:

* Empty probe that just returns immediately (simple and complex map
increments were already there)
* Tracepoint probe (fprobe and kprobe were already there)

The results are here:

* https://github.com/cloudflare/ebpf_exporter/tree/master/benchmark

It looks like we can expect an empty tracepoint probe to finish in
~15ns. At least that's what I see on my M1 laptop in a VM running
v6.5-rc1.

15ns x 400k calls/s =3D 6ms/s or 0.6% of a single CPU if all you do is
nothing (which is the likely outcome) for kfree_skb tracepoint.

I guess it's not as terrible as I expected, which is good news.

> >>> If you have an ebpf example that would help me extract the destinatio=
n
> >>> port from an skb in kfree_skb, I'd be interested in taking a look and
> >>> trying to make it work.
> >>
> >> This is from 2020 and I forget which kernel version (pre-BTF), but it
> >> worked at that time and allowed userspace to summarize drop reasons by
> >> various network data (mac, L3 address, n-tuple, etc):
> >>
> >> https://github.com/dsahern/bpf-progs/blob/master/ksrc/pktdrop.c
> >
> > It doesn't seem to extract the L4 metadata (local port specifically),
> > which is what I'm after.
>
> This program takes the path of copy headers to userspace and does the
> parsing there (there is a netmon program that uses that ebpf program
> which shows drops for varying perspectives). You can just as easily do
> the parsing in ebpf. Once you have the start of packet data, walk the
> protocols of interest -- e.g., see parse_pkt in flow.h.

I see, thanks. I want to do all the aggregation in the kernel, so I
took a stab at that. With a lot of trial and error I was able to come
up with the following:

* https://github.com/cloudflare/ebpf_exporter/pull/235

Some points from my experience doing that:

* It was a lot harder to get it working than the tracepoint I
proposed. There are few examples of parsing skb in the kernel in bpf
and none do what I wanted to do.
* It is unclear whether this would work with vlan or other
encapsulation. Your code has special handling for vlan. As a user I
just want the L4 port.
* There's a lot more boilerplate code to get to L4 info. Accessing sk
is a lot easier.
* It's not very useful without adding the reasons that would
correspond to listen drops in TCP. I'm not sure if I'm up to the task,
but I can give it a shot.
* It's unclear how to detect which end of the socket is bound locally.
I want to know which ports that are listened on locally are
experiencing issues, ignoring sockets that connect elsewhere. E.g. I
care about my http server dropping packets, but not as much about curl
doing the same.
* UDP drops seem to work okay in my local testing, I can see
SKB_DROP_REASON_SOCKET_RCVBUFF by port.

As a reminder, the code for my tracepoint is here:

* https://github.com/cloudflare/ebpf_exporter/pull/221

It's a lot simpler. I still feel that it's justified to exist.

Hope this helps.
