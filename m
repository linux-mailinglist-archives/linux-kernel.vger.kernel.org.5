Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D66576C340
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 05:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbjHBDBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 23:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjHBDBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 23:01:10 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4903F2735
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 20:00:34 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe32ec7201so7145e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 20:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690945233; x=1691550033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RlAKMW2hhyEGf7EbQoDjxae+sXt59ciz5L61y3xkpbo=;
        b=vQJAOG12dWe2jHunL4c0y4nkGH47MCyLHObcx3wytIGo7cJbUOCvivyIOYUfF+wrFO
         unrIYujYnkF+ySOaIF+/kcNOKmOBLJwGwj82XBbWwBb4288Zuc617LPlcbAkRHKXxyc5
         rQZH0wA/4bJp316IZY7q/iIlBwVwzQoknehVtxOnQF9lE4ooLuTLpS3sAyHviJqQTGml
         CUIsHiFKJHycqolab+QqPxjMe5wacy98j7JS/gsZ7WJMly20mExGGR5QswsxqfNN6H8z
         b1QZLQZMBTSFcRd6AW/jY+z3nqiiHzg9EFUz6rDPVjnkT4UfpTVHJzZLPg+mdXbypAn9
         E6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690945233; x=1691550033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RlAKMW2hhyEGf7EbQoDjxae+sXt59ciz5L61y3xkpbo=;
        b=QDCXlYuNzgTTf68gqk0kJZ17C7UTZwZHa347I/895s13p50354NYyyDKtENq39+c72
         YcCtUaKEYFzhYNyEIxEwBenmIeKmv3gkMvTizrMwci/5IbsL/pihPfRl6Xjkw1gY4AMn
         2rPTnmQp9cuqEunEsEkyp6QxyyeRscignk6yw4EhI4QDaokeFRQJvM709F9RqofjCJJ7
         FEYicgc1bqipp13hzJP13najJDmbtMY9VUPnqDVVd3lbn37WBEqCGDaaGnjuBM9KejW1
         C81PT1+WLSCRlFbssgjOyB5J950hE41bBvN4s4hlNPsnKQFlx/yT4IPqRmaycXBp/o0R
         QOEA==
X-Gm-Message-State: ABy/qLbuXWfv9/DIPi9Fkj4H24+wObnyG6EfD9K8X03DSLArLvpnUHMT
        Zd/RYGrmwdvqSiOD0nwlVuiA5vxhD+aUoC+wfuHELQ==
X-Google-Smtp-Source: APBJJlEAU7sf9LNnkdL9BM8PD1a8rc+IfAWYFJmdLXziM/Js7RppZ43toQ4SbcluXzArg9H2qin9Z8zMAbCrzSlThAg=
X-Received: by 2002:a05:600c:1f0a:b0:3f7:e59f:2183 with SMTP id
 bd10-20020a05600c1f0a00b003f7e59f2183mr310158wmb.5.1690945232638; Tue, 01 Aug
 2023 20:00:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230802001938.3913174-1-kaleshsingh@google.com> <CAOUHufbz-VHZ12b9wrCFxZ9mqVnU=Xstkoo5Ym9_tw72R1-2Gg@mail.gmail.com>
In-Reply-To: <CAOUHufbz-VHZ12b9wrCFxZ9mqVnU=Xstkoo5Ym9_tw72R1-2Gg@mail.gmail.com>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Tue, 1 Aug 2023 20:00:20 -0700
Message-ID: <CAC_TJveohqQNDT+AuoP-25Bm+=GWTZY=XWV+Q=_t=H5YujNF4g@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm-unstable: Multi-gen LRU: Fix per-zone reclaim
To:     Yu Zhao <yuzhao@google.com>
Cc:     akpm@linux-foundation.org, surenb@google.com,
        android-mm@google.com, kernel-team@android.com,
        Charan Teja Kalla <quic_charante@quicinc.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 1, 2023 at 7:08=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrote:
>
> On Tue, Aug 1, 2023 at 6:19=E2=80=AFPM Kalesh Singh <kaleshsingh@google.c=
om> wrote:
> >
> > MGLRU has a LRU list for each zone for each type (anon/file) in each
> > generation:
> >
> >         long nr_pages[MAX_NR_GENS][ANON_AND_FILE][MAX_NR_ZONES];
> >
> > The min_seq (oldest generation) can progress independently for each
> > type but the max_seq (youngest generation) is shared for both anon and
> > file. This is to maintain a common frame of reference.
> >
> > In order for eviction to advance the min_seq of a type, all the per-zon=
e
> > lists in the oldest generation of that type must be empty.
> >
> > The eviction logic only considers pages from eligible zones for
> > eviction or promotion.
> >
> >     scan_folios() {
> >         ...
> >         for (zone =3D sc->reclaim_idx; zone >=3D 0; zone--)  {
> >             ...
> >             sort_folio();       // Promote
> >             ...
> >             isolate_folio();    // Evict
> >         }
> >         ...
> >     }
> >
> > Consider the system has the movable zone configured and default 4
> > generations. The current state of the system is as shown below
> > (only illustrating one type for simplicity):
> >
> > Type: ANON
> >
> >         Zone    DMA32     Normal    Movable    Device
> >
> >         Gen 0       0          0        4GB         0
> >
> >         Gen 1       0        1GB        1MB         0
> >
> >         Gen 2     1MB        4GB        1MB         0
> >
> >         Gen 3     1MB        1MB        1MB         0
> >
> > Now consider there is a GFP_KERNEL allocation request (eligible zone
> > index <=3D Normal), evict_folios() will return without doing any work
> > since there are no pages to scan in the eligible zones of the oldest
> > generation. Reclaim won't make progress until triggered from a ZONE_MOV=
ABLE
> > allocation request; which may not happen soon if there is a lot of free
> > memory in the movable zone. This can lead to OOM kills, although there
> > is 1GB pages in the Normal zone of Gen 1 that we have not yet tried to
> > reclaim.
> >
> > This issue is not seen in the conventional active/inactive LRU since
> > there are no per-zone lists.
> >
> > If there are no (not enough) folios to scan in the eligible zones, move
> > folios from ineligible zone (zone_index > reclaim_index) to the next
> > generation. This allows for the progression of min_seq and reclaiming
> > from the next generation (Gen 1).
> >
> > Qualcomm, Mediatek and raspberrypi [1] discovered this issue independen=
tly.
> >
> > [1] https://github.com/raspberrypi/linux/issues/5395
> >
> > Cc: Yu Zhao <yuzhao@google.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Reported-by: Charan Teja Kalla <quic_charante@quicinc.com>
> > Reported-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
>
> LGTM. But I think we need the Fixes tag and Cc stable.

I've reposted the patches with fixes tag and stable cc'ed at:
https://lore.kernel.org/lkml/20230802025606.346758-1-kaleshsingh@google.com=
/#t

Thanks,
Kalesh
