Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D038139F6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjLNS2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 13:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjLNS2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 13:28:33 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85E911D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:28:38 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a1ceae92ab6so1121549066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702578517; x=1703183317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lH4CLT11soXgvi/oQe5hBTiRESQ8UWLQkTtFerePfus=;
        b=tX6h8nLb1kYr8Fz4Aask5U8JKI7e50dBBD+xcXQhmoqLhmp8LfoWHORUw/kn+gw97E
         gAv0lMfGOyKT2bSf/Ms0umF0YWrGKyXpsNwSnHefmlw/dceZhXJVOESB8OHnmuBB0MSz
         cBKtmp3DZQ7VFkF1BsQSGeNAznQsY7Zle2g/BTA0B7XCV3jBYWUiTjrFrX32IQMe0a6I
         VChW/DqiaxlBoVeMxlIO7fEcCHPpNWnkcvCoeb/lxEeRhj5aKbBvoZUCFcLCmuJO4TdL
         bHW4auLthuMvzhVnLjWkMBesRGSKoV+vGiAXH18GRplVkxivED/+WR81qjuPln+3lfD2
         cBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702578517; x=1703183317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lH4CLT11soXgvi/oQe5hBTiRESQ8UWLQkTtFerePfus=;
        b=gNKn+d+URNVOl01hvOQE0ySq3pDNta1M0/72hO4jq9PNQvmqB0HdWpet9OWU3cldZ+
         e2H1zWv+ZXybYTIFiv5Tpv2l+xD2eNmJDjaH+3uOK+a2ESjZYQd6LpHQnV7LryZDHAei
         IWj9WIEGyiDhDe7IhWAJT0jqSib84eOZHYzSMo1P1anlDZGjT1Y42nqSjMjKYtHwaxaE
         0YLYNFc79SgWk+w5MmMt4ooXgUqE4fkeR7J0HkzVQXvzXkKak34IOQmWOZV4UVdFl+xv
         5TAUsEHjVzy2w2Im6CD77lE4YovLaZt/Fl2UQ8Fosw5sqWy3u4L5TlEONEIHdUe2YkwL
         AjHA==
X-Gm-Message-State: AOJu0YyfwgOLN1Fx8G+3LqUtPTYFU81P5hVH6ogsTMlqbnXtb1ch0jdK
        qvC6ky5KoF7CFDv4t1c+fN71cu18AIax5afmE6OUhw==
X-Google-Smtp-Source: AGHT+IHRwu9vWZ1HNkcpck/GZz1PmTPXDUEpaeLXHi9jKbPJ12eb2WfPX3ltH5XMfAwVgTTcxoc64P3ITxj2/N55KrE=
X-Received: by 2002:a17:907:962a:b0:a1d:53d8:427e with SMTP id
 gb42-20020a170907962a00b00a1d53d8427emr6349710ejc.119.1702578517047; Thu, 14
 Dec 2023 10:28:37 -0800 (PST)
MIME-Version: 1.0
References: <20231213013807.897742-1-schatzberg.dan@gmail.com>
 <20231213013807.897742-3-schatzberg.dan@gmail.com> <ZXq_H4St_NSEFkcD@tiehlicka>
 <ZXtH5T+/qs+dUqrz@dschatzberg-fedora-PF3DHTBV>
In-Reply-To: <ZXtH5T+/qs+dUqrz@dschatzberg-fedora-PF3DHTBV>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 14 Dec 2023 10:28:01 -0800
Message-ID: <CAJD7tkYAzW-8isZFjAaebrw8s4-h1LCRtZV-HckHa5_A-2oY7A@mail.gmail.com>
Subject: Re: [PATCH V4 2/2] mm: add swapiness= arg to memory.reclaim
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Huan Yang <link@vivo.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Yue Zhao <findns94@gmail.com>, Hugh Dickins <hughd@google.com>
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

On Thu, Dec 14, 2023 at 10:22=E2=80=AFAM Dan Schatzberg
<schatzberg.dan@gmail.com> wrote:
>
> On Thu, Dec 14, 2023 at 09:38:55AM +0100, Michal Hocko wrote:
> > On Tue 12-12-23 17:38:03, Dan Schatzberg wrote:
> > > Allow proactive reclaimers to submit an additional swappiness=3D<val>
> > > argument to memory.reclaim. This overrides the global or per-memcg
> > > swappiness setting for that reclaim attempt.
> >
> > You are providing the usecase in the cover letter and Andrew usually
> > appends that to the first patch in the series. I think it would be
> > better to have the usecase described here.
> >
> > [...]
> > > @@ -1304,6 +1297,18 @@ PAGE_SIZE multiple when read back.
> > >     This means that the networking layer will not adapt based on
> > >     reclaim induced by memory.reclaim.
> > >
> > > +The following nested keys are defined.
> > > +
> > > +     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D            =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +     swappiness            Swappiness value to reclaim with
> > > +     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D            =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +   Specifying a swappiness value instructs the kernel to perform
> > > +   the reclaim with that swappiness value. Note that this has the
> > > +   same semantics as the vm.swappiness sysctl - it sets the
> >
> > same semantics as vm.swappiness applied to memcg reclaim with all the
> > existing limitations and potential future extensions.
>
> Thanks, will make this change.
>
> >
> > > +   relative IO cost of reclaiming anon vs file memory but does
> > > +   not allow for reclaiming specific amounts of anon or file memory.
> > > +
> > >    memory.peak
> > >     A read-only single value file which exists on non-root
> > >     cgroups.
> >
> > The biggest problem with the implementation I can see, and others have
> > pointed out the same, is how fragile this is. You really have to check
> > the code and _every_ place which defines scan_control to learn that
> > mem_cgroup_shrink_node, reclaim_clean_pages_from_list,
> > reclaim_folio_list, lru_gen_seq_write, try_to_free_pages, balance_pgdat=
,
> > shrink_all_memory and __node_reclaim. I have only checked couple of
> > them, like direct reclaim and kswapd and none of them really sets up
> > swappiness to the default memcg nor global value. So you effectively en=
d
> > up with swappiness =3D=3D 0.
> >
> > While the review can point those out it is quite easy to break and you
> > will only learn about that very indirectly. I think it would be easier
> > to review and maintain if you go with a pointer that would fallback to
> > mem_cgroup_swappiness() if NULL which will be the case for every
> > existing reclaimer except memory.reclaim with swappiness value.
>
> I agree. My initial implementation used a pointer for this
> reason. I'll switch this back. Just to be clear - I still need to
> initialize scan_control.swappiness in all these other places right? It
> appears to mostly be stack-initialized which means it has
> indeterminate value, not necessarily zero.

My understanding is that in a partially initialized struct,
uninitialized members default to 0, but I am not a C expert :)
