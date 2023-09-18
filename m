Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F177A4EEA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjIRQai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjIRQaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:30:21 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA5E25AC6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:27:31 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-34fa117f92bso299205ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695054451; x=1695659251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDPvNTGnVzfWEnM2vQQWdbts3fJPWj+Kgd251XWPAzE=;
        b=LXuO613cpuEZ+ZaFW7D339XIkbpzy19F0KZAdsJ9NxS9dZutYHt9BdJgN28NFK3iz6
         vFtsuLW8L1ES+pS1l2uhJvVXk/o5GGNs1cHxU6MJVb7pPyv6e/Bm9awKFR+eSykj6nI1
         A2M5tIaM81fT6lrdK5VYDie/8G6cJ+TsZLPMbbPjcT2SiHBKRXDYcat0yNPs9erUXkkF
         bwzY87vVeLfP9m2y0mU3KltBSHxbCjkwwQ4KmwhLKgYYakZsK6qtW/2kb/xEBqSisMWq
         IsZrxTy/2E1qQh4XjRQCyEDVEv3PTtikeoyXHynFxu7rzJWJ01/kK7BzGtPpkOx6kzy3
         uLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695054451; x=1695659251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cDPvNTGnVzfWEnM2vQQWdbts3fJPWj+Kgd251XWPAzE=;
        b=WIZRWRbTZ+dKzH7z1kSokJqVLgHXAYvMLM7cE8Dlf6s9/EzEJWrQ7gUjbbrI0gWkYc
         nfhBeTNF1Zvd6go/n7Y9unzSOpixrG5o+S27AS3bsPhm5rTLXwRdypPWN9pxgMJ1TNTS
         52dvtqAyAyZzzlrd6ujXosLRhKoKtB/2GbNGsGYj5/WyTKvcHQ2V6Ntt0pqxnIvMyXHw
         bpf+bUiEaLYUb9xX4vaPcKczrnIwJE/qtu56U7AOv43vk8IMjplAKQRVLzhq/AvcQRHI
         l3EV9OH9L7oJl77jaAdSxoGNS/NFghFzD+gm1Ldf6e9GaxO7WbQCRrjTQzadIt2eccl6
         D07g==
X-Gm-Message-State: AOJu0YyE3j7NuCmxGPh5/M5ZJ2FakPZ6b+LArCitkxeLGRkT0BV70BK5
        jINqp6mrEsaPAdkxldNqltBaIBfmOENWm/nWfoVr4OqyTD+hOHcLwKM=
X-Google-Smtp-Source: AGHT+IHX1+2Zl+SQS6wfYua3ZBYCi72FsIZkYPIqSURf8Dthf3fUhwidvKwEQ1mfTRGHNrOVqA63S2x0HPiO3faeRNk=
X-Received: by 2002:a17:902:d2cb:b0:1c5:59ea:84c3 with SMTP id
 n11-20020a170902d2cb00b001c559ea84c3mr158871plc.21.1695052187709; Mon, 18 Sep
 2023 08:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230901062141.51972-1-wuyun.abel@bytedance.com>
 <20230901062141.51972-4-wuyun.abel@bytedance.com> <8c470d4d-b972-3f43-9b0a-712ee882a402@bytedance.com>
In-Reply-To: <8c470d4d-b972-3f43-9b0a-712ee882a402@bytedance.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 18 Sep 2023 08:49:36 -0700
Message-ID: <CALvZod4P3_726Jo_FAoDVTNrYcy1vgp67SSxix1=k8FEKoVM7g@mail.gmail.com>
Subject: Re: [RFC PATCH net-next 3/3] sock: Throttle pressure-aware sockets
 under pressure
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        Yu Zhao <yuzhao@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Breno Leitao <leitao@debian.org>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        David Howells <dhowells@redhat.com>,
        Jason Xing <kernelxing@tencent.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 12:48=E2=80=AFAM Abel Wu <wuyun.abel@bytedance.com>=
 wrote:
>
> On 9/1/23 2:21 PM, Abel Wu wrote:
> > @@ -3087,8 +3100,20 @@ int __sk_mem_raise_allocated(struct sock *sk, in=
t size, int amt, int kind)
> >       if (sk_has_memory_pressure(sk)) {
> >               u64 alloc;
> >
> > -             if (!sk_under_memory_pressure(sk))
> > +             /* Be more conservative if the socket's memcg (or its
> > +              * parents) is under reclaim pressure, try to possibly
> > +              * avoid further memstall.
> > +              */
> > +             if (under_memcg_pressure)
> > +                     goto suppress_allocation;
> > +
> > +             if (!sk_under_global_memory_pressure(sk))
> >                       return 1;
> > +
> > +             /* Trying to be fair among all the sockets of same
> > +              * protocal under global memory pressure, by allowing
> > +              * the ones that under average usage to raise.
> > +              */
> >               alloc =3D sk_sockets_allocated_read_positive(sk);
> >               if (sk_prot_mem_limits(sk, 2) > alloc *
> >                   sk_mem_pages(sk->sk_wmem_queued +
>
> I totally agree with what Shakeel said in last reply and will try ebpf-
> based solution to let userspace inject proper strategies. But IMHO the
> above hunk is irrelevant to the idea of this patchset, and is the right
> thing to do, so maybe worth a separate patch?
>
> This hunk originally passes the allocation when this socket is below
> average usage even under global and/or memcg pressure. It makes sense
> to do so under global pressure, as the 'average' is in the scope of
> global, but it's really weird from a memcg's point of view. Actually
> this pass condition was present before memcg pressure was introduced.
>
> Please correct me if I missed something, thanks!
>

Please send the patch 1 and this hunk as separate patches with
relevant motivation and reasoning.

thanks,
Shakeel
