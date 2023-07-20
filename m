Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2B075AA6F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjGTJOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbjGTJMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:12:34 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849074C39
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 01:58:37 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-401d1d967beso237531cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 01:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689843455; x=1690448255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0Q8HK8TX799KwlVsueVU2Vn6pAZBPxCHZbkBqMog0w=;
        b=sbu7cKX3RJ4STU+W+JnLifIFmUz7jowp9LlbTrMBKpyqTT6Kt21vKp2H8FzOIS5tep
         bbXgF86b7ixmUe1C64by8cuyAkXEDJAhk/gJ2VRtUGHb9caKNjgb9OxMQP+zrnCqpcj2
         0GriA2TxJI0nFyWsYdarH2tV2F8oXchBWBF49T4hNwMZKqRvLpT7KUAaFpv/hWBlJtnr
         eR3Q7T3Ih01HzEFFJp1vIMbg3XuP9jk+gC3Voy9dtnPLpZFwxTUCMBTiLlhqEnVZspy9
         c7k4pKrsJ+tQo++vjhDeFYDA9oaDf8lz3TJbJLHFGGmlrXivPKXfPtwH5nnoPelp0XVz
         2R6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689843455; x=1690448255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k0Q8HK8TX799KwlVsueVU2Vn6pAZBPxCHZbkBqMog0w=;
        b=Q2saSoQsvlCL/WA6hJhYmK48OFULIjqYkoCMXRnDUgHen6HgGcq2TlVrwZfLqWBusY
         TYVcDI4tosNOhsOkgDqA+5O6llyv9qElizMdmJUR/g+paHmCp8Tfsf/ixFBL2IJR9xqO
         bZ3pwjGqWWWYglcUPHdzeOYXyCnVl9jCIJ0rLsXzZOiLJRme7nWAEQitgDXWfkZj7mHG
         aX268SLJ4sxJ20NrfVrTXFfi6P76pM90F5ESzkX0q1WvBV5/BNwbcW/fiCPwtM9TkZM/
         DE8hB3ef8Sh+tZK8qrwr0Hh+eO7CyLOsrfScV+HfwGOC0m0qw9z6hrQMb1vsTIpAgl//
         dx1Q==
X-Gm-Message-State: ABy/qLZJnz0QS7bWnZ+xR3AcVzQXeOAskowvJM9CQD+CrsobgqrWs1mA
        DMcDPtHBdT/d2gTPBggOH4IQskUeY4XEfaYOmjtP6g==
X-Google-Smtp-Source: APBJJlFqutZVzbsA3NqN/Ssn0odGnTV/YCAAziUPG0pJHG9pnasjigUhJvUq9CLPLsN4fxxZHp1mY/y9L0R6loLApxY=
X-Received: by 2002:a05:622a:1a12:b0:404:8218:83da with SMTP id
 f18-20020a05622a1a1200b00404821883damr159489qtb.1.1689843455136; Thu, 20 Jul
 2023 01:57:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230711124157.97169-1-wuyun.abel@bytedance.com> <d114834c-2336-673f-f200-87fc6efb411f@bytedance.com>
In-Reply-To: <d114834c-2336-673f-f200-87fc6efb411f@bytedance.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 20 Jul 2023 10:57:23 +0200
Message-ID: <CANn89iLBLBO0CK-9r-eZiQL+h2bwTHL2nR6az5Az6W_-pBierw@mail.gmail.com>
Subject: Re: [PATCH RESEND net-next 1/2] net-memcg: Scopify the indicators of
 sockmem pressure
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Ahern <dsahern@kernel.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Breno Leitao <leitao@debian.org>,
        David Howells <dhowells@redhat.com>,
        Jason Xing <kernelxing@tencent.com>,
        Xin Long <lucien.xin@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Alexei Starovoitov <ast@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 9:59=E2=80=AFAM Abel Wu <wuyun.abel@bytedance.com> =
wrote:
>
> Gentle ping :)

I was hoping for some feedback from memcg experts.

You claim to fix a bug, please provide a Fixes: tag so that we can
involve original patch author.

Thanks.

>
> On 7/11/23 8:41 PM, Abel Wu wrote:
> > Now there are two indicators of socket memory pressure sit inside
> > struct mem_cgroup, socket_pressure and tcpmem_pressure.
> >
> > When in legacy mode aka. cgroupv1, the socket memory is charged
> > into a separate counter memcg->tcpmem rather than ->memory, so
> > the reclaim pressure of the memcg has nothing to do with socket's
> > pressure at all. While for default mode, the ->tcpmem is simply
> > not used.
> >
> > So {socket,tcpmem}_pressure are only used in default/legacy mode
> > respectively. This patch fixes the pieces of code that make mixed
> > use of both.
> >
> > Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> > ---
> >   include/linux/memcontrol.h | 4 ++--
> >   mm/vmpressure.c            | 8 ++++++++
> >   2 files changed, 10 insertions(+), 2 deletions(-)
> >
