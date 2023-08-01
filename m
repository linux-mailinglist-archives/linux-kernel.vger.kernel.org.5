Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A2A76B90E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 17:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbjHAPud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 11:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjHAPub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 11:50:31 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB01171C;
        Tue,  1 Aug 2023 08:50:30 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b703a0453fso88619941fa.3;
        Tue, 01 Aug 2023 08:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690905028; x=1691509828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bg4+KvMlhZ34B4eMJftZ2Ixr3pXT/19a5y3fl6JXNlw=;
        b=RDsYzD5oIlIdxeucfKLa/N8ab3HHWeWH3c9SMtwOoHql+T2xfEeJzh03Uy18HMAmyY
         AMbgAEvKNjbgtp5nSfK0Jfx+VP5PDYs/WemSICZBGrGD6qf4fM3qrkQVCXO3b1MjE++J
         bMx/mE0EOtQKy4Zd26oxRyqpEN94pOgftPVeZiGmrgUw3U0xxdCTtR8NhXBlSpGJS5mm
         KGT0+nt7StIP2VpiiAGPb7ezYSZiX1l9drDS0hocMx79FFFVO5JjHsZ2M/R2FHrWRzx6
         CssjjiyzzTQxCdUyh2r0qyAsSO/3+ZheTJ8DzgdAxjcJF9G+QfrCgRFGwYGyBFJn5YrL
         yKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690905028; x=1691509828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bg4+KvMlhZ34B4eMJftZ2Ixr3pXT/19a5y3fl6JXNlw=;
        b=gHjkQc9nd1bEK3QrWYaR+jS2yEGHGT3RbZxnby+VJiihcjXGcrCycnuKOd2wwhlQTT
         KbUKbKXdOjGPr5qK/vXS7DxEdkDlqHYxVLk+moC2utte+IbfEWsEqtjRxTUDdw5bFGoc
         Zg40ITz9iAN+q0rrKiGp9xKmEqPapGd0yw4zE533IG0/pgEkD8RajvjTW++iwynKuk6H
         OY1aUxtND9UhocK5Svzi8uIFNdOyxEXnSZlaEd+Axk5TrPLNvF3dShzHZnzOcXtJhX/A
         dH7vBqR1Kc5KxYqDtZ8tZPGfP28gsJnx6MagcaA3xAUJOkI65hwIkIeDjlOyuNkn4G5J
         aiVA==
X-Gm-Message-State: ABy/qLanYyBDI7108Plr4gPck6sCU4Jt63yL33I0JXlfWY1uSMXGMC92
        sTVw4Sy9zufObngYghvUcPJ4yF69UNroemLnwY8=
X-Google-Smtp-Source: APBJJlEqqV4FtxSIj3IHGgAxaSVhP32LN2jwvjZaqWXkm2w86ahkQJutxSobKgVWLVq+pLm9fhdqqalluWlwSdBtRLM=
X-Received: by 2002:a2e:980c:0:b0:2b9:b41a:aa66 with SMTP id
 a12-20020a2e980c000000b002b9b41aaa66mr3117683ljj.20.1690905028142; Tue, 01
 Aug 2023 08:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230728064411.305576-1-tglozar@redhat.com> <87ila0fn01.fsf@cloudflare.com>
 <64c882fd8c200_a427920843@john.notmuch> <19a3a2be3c2389e97cacd7e7ab93b317b016ef94.camel@redhat.com>
In-Reply-To: <19a3a2be3c2389e97cacd7e7ab93b317b016ef94.camel@redhat.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 1 Aug 2023 08:50:16 -0700
Message-ID: <CAADnVQ+VNWTfE7cn4rDkfqdwLqLv22ZEe_HD0vAhKE=8U15mdQ@mail.gmail.com>
Subject: Re: [PATCH net] bpf: sockmap: Remove preempt_disable in sock_map_sk_acquire
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, tglozar@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 1, 2023 at 12:44=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Mon, 2023-07-31 at 20:58 -0700, John Fastabend wrote:
> > Jakub Sitnicki wrote:
> > >
> > > On Fri, Jul 28, 2023 at 08:44 AM +02, tglozar@redhat.com wrote:
> > > > From: Tomas Glozar <tglozar@redhat.com>
> > > >
> > > > Disabling preemption in sock_map_sk_acquire conflicts with GFP_ATOM=
IC
> > > > allocation later in sk_psock_init_link on PREEMPT_RT kernels, since
> > > > GFP_ATOMIC might sleep on RT (see bpf: Make BPF and PREEMPT_RT co-e=
xist
> > > > patchset notes for details).
> > > >
> > > > This causes calling bpf_map_update_elem on BPF_MAP_TYPE_SOCKMAP map=
s to
> > > > BUG (sleeping function called from invalid context) on RT kernels.
> > > >
> > > > preempt_disable was introduced together with lock_sk and rcu_read_l=
ock
> > > > in commit 99ba2b5aba24e ("bpf: sockhash, disallow bpf_tcp_close and=
 update
> > > > in parallel"), probably to match disabled migration of BPF programs=
, and
> > > > is no longer necessary.
> > > >
> > > > Remove preempt_disable to fix BUG in sock_map_update_common on RT.
> > > >
> > > > Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> > > > ---
> > >
> > > We disable softirq and hold a spin lock when modifying the map/hash i=
n
> > > sock_{map,hash}_update_common so this LGTM:
> > >
> >
> > Agree.
> >
> > > Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
> >
> > Reviewed-by: John Fastabend <john.fastabend@gmail.com>
> >
> > >
> > > You might want some extra tags:
> > >
> > > Link: https://lore.kernel.org/all/20200224140131.461979697@linutronix=
.de/
> > > Fixes: 99ba2b5aba24 ("bpf: sockhash, disallow bpf_tcp_close and updat=
e in parallel")
>
> ENOCOFFEE here (which is never an excuse, but at least today is really
> true), but I considered you may want this patch via the ebpf tree only
> after applying it to net.
>
> Hopefully should not be tragic, but please let me know if you prefer
> the change reverted from net and going via the other path.

It's fine. Probably it shouldn't conflict with other sockmap fixes.
