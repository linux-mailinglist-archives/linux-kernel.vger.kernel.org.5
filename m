Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7347EB4C6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 17:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbjKNQax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 11:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbjKNQau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 11:30:50 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65398134
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 08:30:47 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-7a996357550so246665039f.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 08:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699979447; x=1700584247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDmYTpQ7ElU68lbzr+9q96SRibKaNKBSn5JxdJQPRH4=;
        b=SQfQgyN4i2nyEwNVZI+bgoCnMMbCjDvAFeoL+9rL2yodAECJzs/sI3TjXWWxCTr0br
         6d/9Z8MZQMl/3Uh2E28Wh5/oofCRtVup0jxHR+9GK4w5zTCbpvIcHc+iXcJk7bPU6wxL
         LxncCZj9UxSyd4GdDsA7h/Rz9Y7OaW1nDkzUy92W2PB9Rt5mis0U9AA28u2uS56sAjTr
         pljewq4OQ7d0HZjtUNa2BmyDEDIBLaHBKJMCx0HpWjZ480xIEZ9G371ObCI2BDev6ljy
         heZsaBsN+u8KWqlh/lW37dh9gzvLVDdHUIaDsOLOwNrFSXxpL8Vp/xPRZn0FoCkKdb5z
         UMdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699979447; x=1700584247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eDmYTpQ7ElU68lbzr+9q96SRibKaNKBSn5JxdJQPRH4=;
        b=kOzkEupSIbGuEmKRYzC9e4nFRdnVq5m1OgFFNvUDFloi8OBtaN3uy40I+0d3st61qU
         G3DEjXk+pkbcTRt2vfUlb3ZCrvHvzf0ASohPD/NDJKZVIQYgDMBJadMWJ0TonfesNd4M
         3cKTgodqB5DAAruGqxTGvQo7Ax1igqNh6zAuL32Yn1qGbsv3433jngvSv9tG2B53TbHB
         zDIEeMpXIggOuFrTz/5QewIP+bpFPHYHETLrlejsZpuxzfN49QMbiiXwdFg/pVkDP6pY
         iCBCkkTHhnznw2+Tfc2/GHn6MAgSAIlq0RetdiJc1WJDWMT5+dMvgZQaEWBNgiQCExjf
         8ZeA==
X-Gm-Message-State: AOJu0Yy8oS5lwi7w27mYIMaH9PqboVrWWLTbu37HLB5k/9xYJogWGZR6
        KxtDnJQ67IfvcR/aeMgM7dIvb7nyCpFYzoqY6D0=
X-Google-Smtp-Source: AGHT+IFKXz+U5SHG/cutGmlpXg4CbVgwipwW7eN+TON4JG4prnDFlquLp9n9k9ipAcRa6lPTdjw2fjR7GaW/qKhaIg4=
X-Received: by 2002:a05:6602:334f:b0:795:fa0:c15 with SMTP id
 c15-20020a056602334f00b007950fa00c15mr11052248ioz.6.1699979446588; Tue, 14
 Nov 2023 08:30:46 -0800 (PST)
MIME-Version: 1.0
References: <20231113130601.3350915-1-hezhongkun.hzk@bytedance.com>
 <CAKEwX=NhiGyoqR3HaDCuarqGmM5CCMYDatvVEEtVKzrL8DdDbw@mail.gmail.com> <CACSyD1NyynLrrkrp-A8tGW5gUJeFQiYk_E_SO14m_7wqrddtiQ@mail.gmail.com>
In-Reply-To: <CACSyD1NyynLrrkrp-A8tGW5gUJeFQiYk_E_SO14m_7wqrddtiQ@mail.gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Tue, 14 Nov 2023 11:30:35 -0500
Message-ID: <CAKEwX=MinEqt_gR+hvyYc1dgU68B1Auw8fypRo7SKFjFK7VHaA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm:zswap: fix zswap entry reclamation
 failure in two scenarios
To:     =?UTF-8?B?6LS65Lit5Z2k?= <hezhongkun.hzk@bytedance.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Tue, Nov 14, 2023 at 12:21=E2=80=AFAM =E8=B4=BA=E4=B8=AD=E5=9D=A4 <hezho=
ngkun.hzk@bytedance.com> wrote:
>
> Thanks for your time, Nhat.
>
> >
> > These two cases should not count as "successful writeback" right?
> >
>
> This is true from the perspective of the writeback itself, but should it
> also be considered successful from the purpose of the writeback,
>  i.e. whether the compressed memory and zswap_entry can be reclaimed?
>
> > I'm slightly biased of course, since my zswap shrinker depends on this
> > as one of the potential signals for over-shrinking - but that aside, I =
think
> > that this constitutes a failed writeback (i.e should not increment writ=
eback
> > counter, and the limit-based reclaim should try again etc.). If anythin=
g,
> > it will make it incredibly confusing for users.
>
> This patch will skip the writeback step=EF=BC=8Cso the writeback counter =
will not
> be incremented. Currently MAX_RECLAIM_RETRIES is 14, shrink_worker
> will often fail if writeback fails.

Ah my bad, I should have been clearer.

I was looking at the zswap shrinker patch series (specifically the
cgroup-aware LRU patch), which moves the counter update out of
zswap_writeback_entry. If we apply that patch on top of that series, we wil=
l
screw up the counter. Should be easily fixable anyway though.

>
> >
> > For instance, we were trying to estimate the number of zswap store
> > fails by subtracting the writeback count from the overall pswpout, and
> > this could throw us off by inflating the writeback count, and deflating
> > the zswap store failure count as a result.
>
> As mentioned above, writeback counter will not be incremented.
>
> >
> > Regarding the second case specifically, I thought that was the point of
> > having zswap_exclusive_loads_enabled disabled - i.e still keeps a copy
> > around in the zswap pool even after a completed zswap_load? Based
> > on the Kconfig documentation:
> >
> > "This avoids having two copies of the same page in memory
> > (compressed and uncompressed) after faulting in a page from zswap.
> > The cost is that if the page was never dirtied and needs to be
> > swapped out again, it will be re-compressed."
> >
>
> Yes=EF=BC=8Ci know the point=EF=BC=8Cin the case of reading, there is no =
data update,
> so the next swapout does not need to be compressed again.
> Consider this scenario,there is a lot of data cached in memory and zswap,
> hit the limit=EF=BC=8Cand shrink_worker will fail. The new coming data be=
 written
> directly to swap due to zswap_store failure. Should we free the last one
> to store the latest one in zswap.

Ah I think I understand the point of the patch a bit better now.

Essentially, we're invalidating these entries, which does reclaim the
memory used for these compressed objects, but there is no IO involved.
Writeback-less shrinking, if you will.

This will still screw up one of the heuristics I'm using for the zswap
shrinker a bit, but that should be easily fixable with some plumbing.
Same goes for the writeback counter - but depending on the order in
which Andrew apply the patches, you might have to resolve the conflicts
there :)

Other than this objection, I think this optimization makes sense to me:

In the first case, we already freed the swap entry. Might as well also
dropped the zswap entry.

In the second case, we already have another copy in memory, so
dropping the compressed copy to make space for warmer objects
coming into zswap makes sense to me. Might be worth doing a
micro-benchmark to verify this intuition, but I agree that it's more
important to maintain the LRU ordering than any CPU saving from
skipping re-compression.

I would suggest that you should expand on this on the commit log
to make clearer the motivation behind this optimization, if you were
to re-submit this patch for some reason (for e.g to resolve the
aforementioned conflicts with the zswap shrinker series).

But otherwise, LGTM!

Feel free to add the following tag:
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
