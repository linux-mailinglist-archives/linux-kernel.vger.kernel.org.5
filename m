Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46B97F3C95
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 04:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343607AbjKVDqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 22:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235035AbjKVDqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 22:46:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BBE18E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 19:46:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8DF4C433CB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 03:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700624777;
        bh=+ZdQxYStF7qlczejYvvnc/fNWLDpo7+8IzuOh8Ic98s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MJ/kWN8FiAdyH/TlhkMFfVxKmsQt5ZJSZsz1SQe6GM85jolnlWz3KkrpdXUgc3Iem
         6a/zk8D4dCdoLCa/UMpSZq6sEE16gnPqH1rYBxeVg7rhg9QNqEECfM2jlPPMcTIQCE
         F9yipKBXj01XiCaWxern0w/6NweCUtBALYQMxKIg5RGtSPPaUNkRJvpGZ4f24WLVVo
         m5oMm5CaE2hAAaax9bGY5s1cXCBiXrqkblchs828d2q6t23PYoVWfo8zjY0qltdhl8
         oqfOh0LVjP2HsqKQZGmOSLALAUWoNzW8+rE8moyUqHiyX3cirBmEjRgO7GHPbncjZh
         we57VjwsUNSeA==
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-778927f2dd3so317189485a.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 19:46:17 -0800 (PST)
X-Gm-Message-State: AOJu0YyKtkNyjL7zHbvnaHc1QlwPSsHs2XNXgZ17tsOb4I7sfsUkaBeX
        aZ2ht2k1DjX2491+lh+S7Ip450lGZKkCkRCr8sDZeQ==
X-Google-Smtp-Source: AGHT+IEcaHMwYV6MNu58EXGgqZl9LbbEuqb72Ci6XYjP9DfltYsYdqnYxHSvsyXaKBN7jDh17NKmVll4E2bTTyVX8Dw=
X-Received: by 2002:a05:6a20:938b:b0:187:afb0:c2f5 with SMTP id
 x11-20020a056a20938b00b00187afb0c2f5mr1303175pzh.3.1700624756029; Tue, 21 Nov
 2023 19:45:56 -0800 (PST)
MIME-Version: 1.0
References: <20231115172344.4155593-1-nphamcs@gmail.com> <CAF8kJuN-4UE0skVHvjUzpGefavkLULMonjgkXUZSBVJrcGFXCA@mail.gmail.com>
 <CAJD7tkZ1U+YuvoBAnrXFxQDiQV2hXdbMG-gbzu64R8GLAtNAPA@mail.gmail.com>
 <CAF8kJuPTNwQM413UdeQTkMQ8HkJFyF4OWVrxJSf7uWbege0CXQ@mail.gmail.com>
 <CAKEwX=O5M-vZE5YhYQ5_CbCmXovS1XECO4ROXKWo06K880M1Mg@mail.gmail.com>
 <CAF8kJuOD6zq2VPcVdoZGvkzYX8iXn1akuYhNDJx-LUdS+Sx3GA@mail.gmail.com>
 <CAKEwX=NdFjemcmf27PVpgHpVHWQEo19KfApepWJBRYeyVCWvCw@mail.gmail.com>
 <CAF8kJuOCyd5r0LQ3m8fQp0GtxxNUKSmwURJH6V9aApefvX8xCA@mail.gmail.com>
 <ZVrHXJLxvs4_CUxc@google.com> <CAKEwX=MR6a-u87p=Oqm+zvwB_1zhrsM_n2=xW1kJz0_AoVwkPA@mail.gmail.com>
 <CAF8kJuNFQn_e29YEPy-G29FR2RnrPzZNWR07VuadOTNask_Rig@mail.gmail.com> <CAKEwX=NpKqjApRKk2Qp9Hp63xSjRwD-DEu9yX4BvbMd86x2b1g@mail.gmail.com>
In-Reply-To: <CAKEwX=NpKqjApRKk2Qp9Hp63xSjRwD-DEu9yX4BvbMd86x2b1g@mail.gmail.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Tue, 21 Nov 2023 19:45:44 -0800
X-Gmail-Original-Message-ID: <CAF8kJuNbgsMK-JiBvj=O6UbueNNeo5WJnJdwrH7JAuavNHH6Lg@mail.gmail.com>
Message-ID: <CAF8kJuNbgsMK-JiBvj=O6UbueNNeo5WJnJdwrH7JAuavNHH6Lg@mail.gmail.com>
Subject: Re: [PATCH v5] zswap: memcontrol: implement zswap writeback disabling
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, tj@kernel.org,
        lizefan.x@bytedance.com, Johannes Weiner <hannes@cmpxchg.org>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Hugh Dickins <hughd@google.com>, corbet@lwn.net,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        senozhatsky@chromium.org, rppt@kernel.org,
        linux-mm <linux-mm@kvack.org>, kernel-team@meta.com,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        david@ixit.cz, Minchan Kim <minchan@google.com>,
        Kairui Song <kasong@tencent.com>,
        Zhongkun He <hezhongkun.hzk@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 5:19=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Tue, Nov 21, 2023 at 11:09=E2=80=AFAM Chris Li <chrisl@kernel.org> wro=
te:
> >
> > On Tue, Nov 21, 2023 at 10:13=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> =
wrote:
> > >
> > > Hi Chris!
> > >
> > > Thanks for the patch. Would you mind if I spend some time staring
> > > at the suggestion again and testing it some more?
> >
> > Of course, by all means. That is just the minimal version to be
> > functional compatible with your zswap.writeback.
> >
> > I might consider a follow up patch to add "no_zswap" and "none" to
> > convert the SSD only swapfile, which can't be expressed by
> > zswap.writeback.
> > That should cover all 4 combinations of zswap and swap files without
> > creating a custom swap tiers list.
> >
> > "all": zswap + swapfile
> > "zswap": zswap only
> > "no_zswap": swapfile only.
> > "none": no swap.
> >
> > All keyword names are open to suggestions.
>
> SGTM! There might be some functionality duplication between
> memory.swap.tiers =3D no_zswap and memory.zswap.max =3D 0, but
> otherwise this seems reasonable to me.

Yes, there is some function duplication. However, there is some small
difference that no_zswap will not enter zswap code at all. Vs
memory.zswap.max will take a short trip into zswap code to find out
Oops, not zswap for you.

>
> no_zswap sounds a bit awkward, but I can't come up with a better
> name.

Again, I am open to better suggestions.
I have also considered "!zswap", "!" has special meaning in bash, so
it will require quoting in bash.
How about "-zswap"? This does not require special quoting in bash.

>
> >
> > >
> > > If everything is good, I'll squash this patch with the original versi=
on,
> > > (keeping you as a co-developer of the final patch of course), and
> > > update the documentation before re-sending everything as v6.
> >
> > Great!
> >
> > >
> > > Anyway, have a nice Thanksgiving break everyone! Thanks for
> > > taking the time to review my patch and discuss the API with me!
> >
> > My pleasure to discuss the swap with you. We should do the online
> > "swap meet" and invite other developers who are interested in the swap
> > area as well.
>
> I look forward to this meeting! I'd love to discuss more about (z)swap
> development (and more generally, multi-tier memory management).

Let me arrange one then. I am thinking maybe every second week of the
month. That can avoid thanksgiving, christmas and new year.

Let me throw in some more ideas: writing compressed zswap data to SSD
without swap cache.

> Generic page promoter/demoter that takes into account workload
> (cgroup), access recency (LRU + generations)/frequency, and tier
> characteristics (latency, bandwidth, etc.) will be awesome to explore!

Sounds great. Looking forward to it.

Chris
