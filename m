Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D327F0AD6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 04:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjKTDQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 22:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjKTDQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 22:16:28 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F40137
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 19:16:24 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50970c2115eso5635734e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 19:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700450183; x=1701054983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JoUBMBH+0Q/OryRpOsGJL0OZmSVelGYXaGmXu0ohb3Q=;
        b=ZdOcQVWkiNpJulpQ8oyD+srqU8iNFr3v0YZmwWQe7/sAXCZjIc8cbs/EhI5pfeXl+1
         NJZaACLZkVhcdI2xc2bg7gxfrB/S2dlXaXDFPQsA/RcReNZZwD31E20LpLn4/Xq0etvy
         tKDk1bd1DTYoL7fjwLxxHDEkKL6SsXPJ+UREO1AiZUBrNxx9wecXIa2p7MqRzCSZyARO
         Jx0mbWQU2p/70fkyRoHeiZy8VhXEwY2ASdmH0jclGxIawLmYWTllICJh81LGmt+Rmn7o
         f+I5cnzCqb2KpEL5G7/2dXCR9nstZ0ggg+6afNWLnJUzT4ASgwo2I1+n7pQs/qmTO4px
         zCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700450183; x=1701054983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JoUBMBH+0Q/OryRpOsGJL0OZmSVelGYXaGmXu0ohb3Q=;
        b=WztZuHhzgkbVRjC6wmIk5EKphyHqFcTWj2GAbnauz97JFR5s1CilnqdNs+PEY4jMVZ
         xdPDV26EOVnyzvuBHfBJhDTfOUXoEYaf/6Ouq5I1E0tOkLr0SAFMxZNa8EOg6R11yXGB
         F+1JU+YYpjRR7Vp1KwV4sp+sdqS6uMfs5+DGwBOiXXDkSn3tnrtJOv6WoG+8uJ1CcwBH
         M0gJ5VHZzVtYLlOPiFf0W94dYOoZUKdGW0c9GCBm6fPCx8Nr0sgsazWoy1rGRoqWGL9W
         DpBRRRhFuuKLbAdp49ABA5V5kq0YTkCI/Chr1m50xCfbMQSlQl6IYjsAMXWOOmHWPPSi
         Bq0A==
X-Gm-Message-State: AOJu0YxnIOD+ObUHiVRgrG4F/TUCsOJ9gRhBa/X3c6O72BUGj4TTzUkA
        RxnZVd4pV4icrKgjPhhtxMCzHFPE0fW8WaLgsmABNg==
X-Google-Smtp-Source: AGHT+IHtQHTisA+hjbHTlz3FEX8vTmU8Pghydu5KR8l1yT4YihfagE4vnMCA/sjTNclUbGVimRNotpwyfW+F219AMHE=
X-Received: by 2002:ac2:563b:0:b0:509:8db5:949 with SMTP id
 b27-20020ac2563b000000b005098db50949mr3953145lff.6.1700450183088; Sun, 19 Nov
 2023 19:16:23 -0800 (PST)
MIME-Version: 1.0
References: <20231113130601.3350915-1-hezhongkun.hzk@bytedance.com>
 <CAJD7tkY8SwROmNEaBAhkS4OKj33g-6fHsKFeYKW3afT+yAbvxA@mail.gmail.com>
 <CAF8kJuPonfuOtipdifXwBny2H7cy6m6BL8mWFVXzfb9JSdYq3Q@mail.gmail.com>
 <CAJD7tkYMiJiXTTgAN34TP8QTr-ViAuEFddYes=ac+1ErenjCZw@mail.gmail.com>
 <CAF8kJuOC30feLGs0bNHOxMjSZ3uqF1y7eUdJ4p-w-myP8c1cFg@mail.gmail.com>
 <CACSyD1NJ4ycr74pXHNus3ZjA=LvZP+aMNyz=iWyHuDODpx7aww@mail.gmail.com>
 <CAF8kJuPymUX+DwouwgH6og0BO6ZYheGXsk=GYqYuMjKMz-Xqbw@mail.gmail.com>
 <CACSyD1P-6mQ7n+ghsZQ0Gp4AxyTTi6=UZHz2DnXWuCWke2fkPw@mail.gmail.com> <CAF8kJuOR+POJx4wT7jbZkoiwGjrjVH4uuJ5GgoWBOf20JUf9qw@mail.gmail.com>
In-Reply-To: <CAF8kJuOR+POJx4wT7jbZkoiwGjrjVH4uuJ5GgoWBOf20JUf9qw@mail.gmail.com>
From:   Zhongkun He <hezhongkun.hzk@bytedance.com>
Date:   Mon, 20 Nov 2023 11:16:11 +0800
Message-ID: <CACSyD1Omro1h2w6bSP0_gB21u=KwFDu+DHjN4+K82H5Pv7yMig@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm:zswap: fix zswap entry reclamation
 failure in two scenarios
To:     Chris Li <chrisl@kernel.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Nhat Pham <nphamcs@gmail.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, Ying <ying.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Thanks for the clarification. Keep in mind that memory freeing from
> and zswap entry and zpool does not directly translate into page free.
> If the page has other none freed zswap entry or zsmalloc usage, those
> pages will not be free to the system. That is the fragmentation cost I
> was talking about.

Yes, it may need to be compacted.

>
> With this consideration, do you know many extra pages it can release
> back to the system by this patch in your usage case? If the difference
> is very small, it might not be worth the extra complexity to release
> those.
>

The original intention of this patch is to make shrink work properly=EF=BC=
=8C
not to release cache and related memory.

> > The original intention of this patch is to solve the problem that
> > shrink_work() fails to reclaim memory in two situations.
> >
> > For case (1),  the zswap_writeback_entry() will failed for the
> > __read_swap_cache_async return NULL because the swap has been
> > freed but cached in swap_slots_cache, so the memory come from
> > the zswap entry struct and compressed page.
> In those cases, if we drop the swap_slots_cache, it will also free
> those zswap entries and compressed pages (zpool), right?
>
> > Count =3D SWAP_BATCH * ncpu.
>
> That is the upper limit. Not all CPUs have swap batches fully loaded.

Yes.

>
> > Solution: move the zswap_invalidate() out of batches, free it once the =
swap
> > count equal to 0.
> Per previous discussion, this will have an impact on the
> swap_slot_cache behavior.
> We need some data points for cost benefit analysis.
>
> > For case (2),  the zswap_writeback_entry() will failed for !page_was_al=
located
> > because zswap_load will have two copies of the same page in memory
> >   (compressed and uncompressed) after faulting in a page from zswap whe=
n
> > zswap_exclusive_loads disabled. The amount of memory is greater but dep=
ends
> > on the usage.
>
> That is basically disable the future swap out page IO write
> optimization that skip the write if the page hasn't changed. If the
> system are low on memory, that is justifiable. Again, it seems we can
> have a pass to drop the compressed memory if the swap count is zero
> (and mark page dirty).
>

OK.

> >
> > Why do we need  to release them?
> > Consider this scenario,there is a lot of data cached in memory and zswa=
p,
> > hit the limit=EF=BC=8Cand shrink_worker will fail. The new coming data =
will be written
>
> Yes, the shrink_worker will need to allocate a page to store
> uncompressed data for write back.
>
> > directly to swap due to zswap_store failure. Should we free the last on=
e
> > to store the latest one in zswap.
>
> The "last one" you mean the most recent zswap entry written into zswap?
> Well, you need to allocate a page to write it out, that is an async proce=
ss.
> Shrink the zpool now is kind of too late already.
>

The last zswap_entry in zswap_pool->lru.

> > According to the previous discussion, the writeback is inevitable.
> > So I want to make zswap_exclusive_loads_enabled the default behavior
> > or make it the only way to do zswap loads. It only makes sense when
>
> We need some data point for how often we swap it out to zswap again,
> where the zswap out write can be saved by using the existing compressed d=
ata.
>
> It is totally possible this page IO write out optimization is not
> worthwhile for zswap.
> We need some data to support that claim.
>

Got it. I will find it.

> > the page is read and no longer dirty. If the page is read frequently, i=
t
> > should stay in cache rather than zswap. The benefit of doing this is
> > very small, i.e. two copies of the same page in memory.
>
> If the benefit of doing this is very small, that seems to be the
> argument against this patch?
> Again we need some data points for cost and benefit analysis.
>

Yes, it is the new idea to make zswap_exclusive_loads_enabled the
default behavior or make it the only way to do zswap loads.

> Chris
