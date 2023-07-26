Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73160762FC9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjGZIZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbjGZIZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:25:04 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B180273B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:14:04 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b9338e4695so96244421fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690359242; x=1690964042;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jUR+8HTvxKrmvFbKVVHSsJQHXeGbUXJFaikg5YZ0Qg4=;
        b=hVOpcFpH0o9M+kWMA1us4uHJmwkZz8VJJTOjlCvXtknJP2KTtjeXi51E/MkYtRU26z
         pOQ+WbXaS2WDw9hRw4aFfOpOxHiGhZV/gVbZ5i+iXQo+GYC9zpPR8f/DsLUFR1942m4W
         mSYXlvXmTckSyuz8skauGYqxeuptEjQXITktH0nqV+hL5btbA1Jv4yi1x17ftB7Es9Mk
         wX+olh6QnI8hZCBq4aLBROKcbuec3+jKiE3cnJPFF6NweBrK/2KlrtvxZFxpVtB+m538
         xM+WJLnmTXDmPUh5m8v12t44j/tvMrUVZPncE0j9SezFIe7P1uR/uU+R7RmnZAS0SxeM
         ksAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690359242; x=1690964042;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jUR+8HTvxKrmvFbKVVHSsJQHXeGbUXJFaikg5YZ0Qg4=;
        b=BT1feAQKHz8lWgZ8O/Y4X2O1q6g5WTAt6VKqrrWAwz3u63q5lmzdUvFqH2SfOOur6m
         cU7o4ooGw3de4PHdVLEfNpzGdo8wyYbSyAYAiTPHAHP66DPt6XL+njvHmBON4P01XgYk
         H6+ebyUA1qcq2jD31N6/ibQs4EhJum6qUtjCYwOIlqm+EBj9cGEODVWrBS2pUG3tHHA+
         IZkup7F93rNIqRWnLWEmJhTm8abkXBLU4pemB943c3Y5pNUa+5dy+nzTZc81cdhTgoyV
         xr9c0BqXcXzYw1jgRBRFX76SVqJsOV0Iq6BIzKSHgJSanZxoEru+RPT3tX22YdR5EENt
         juXA==
X-Gm-Message-State: ABy/qLaBY+MS3q+v2oxXYzsMarfJ907+MStw5O4meetVqEXvnbjxGW7m
        FjRkBhbdd0pynkHMHiGlRwFtGB/7uB8q/GPv2gV2vw==
X-Google-Smtp-Source: APBJJlHbi0hdaP/HaNWOatMh0uvG9VNHJEZMEze5ENOxchuWLXB33lHowUBJwFb3Gub9ShI4NkHCaG0qA2Ph84M9JgE=
X-Received: by 2002:a2e:8914:0:b0:2b5:7dd9:74f5 with SMTP id
 d20-20020a2e8914000000b002b57dd974f5mr987059lji.21.1690359242501; Wed, 26 Jul
 2023 01:14:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230714170853.866018-1-aleksander.lobakin@intel.com>
 <20230714170853.866018-3-aleksander.lobakin@intel.com> <ac97825d-6a27-f121-4cee-9d2ee0934ce6@redhat.com>
 <e48185cb-3057-e778-75c4-d266a249088b@intel.com>
In-Reply-To: <e48185cb-3057-e778-75c4-d266a249088b@intel.com>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Wed, 26 Jul 2023 11:13:26 +0300
Message-ID: <CAC_iWjJ-yfW2Bu-vYQHVw3Y0svkYQNOva3orsv0VzvWyfQkiLw@mail.gmail.com>
Subject: Re: [PATCH RFC net-next v2 2/7] net: page_pool: place frag_* fields
 in one cacheline
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     Jesper Dangaard Brouer <jbrouer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, brouer@redhat.com,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies for the late reply, I was on vacation and start going
through my email piles...

On Tue, 18 Jul 2023 at 16:52, Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Jesper Dangaard Brouer <jbrouer@redhat.com>
> Date: Fri, 14 Jul 2023 20:37:39 +0200
>
> >
> >
> > On 14/07/2023 19.08, Alexander Lobakin wrote:
> >> On x86_64, frag_* fields of struct page_pool are scattered across two
> >> cachelines despite the summary size of 24 bytes. The last field,
> >> ::frag_users, is pushed out to the next one, sharing it with
> >> ::alloc_stats.
> >> All three fields are used in pretty much the same places. There are some
> >> holes and cold members to move around. Move frag_* one block up, placing
> >> them right after &page_pool_params perfectly at the beginning of CL2.
> >> This doesn't do any meaningful to the second block, as those are some
> >> destroy-path cold structures, and doesn't do anything to ::alloc_stats,
> >> which still starts at 200-byte offset, 8 bytes after CL3 (still fitting
> >> into 1 cacheline).
> >> On my setup, this yields 1-2% of Mpps when using PP frags actively.
> >> When it comes to 32-bit architectures with 32-byte CL: &page_pool_params
> >> plus ::pad is 44 bytes, the block taken care of is 16 bytes within one
> >> CL, so there should be at least no regressions from the actual change.
> >>
> >> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> >> ---
> >>   include/net/page_pool.h | 10 +++++-----
> >>   1 file changed, 5 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/include/net/page_pool.h b/include/net/page_pool.h
> >> index 829dc1f8ba6b..212d72b5cfec 100644
> >> --- a/include/net/page_pool.h
> >> +++ b/include/net/page_pool.h
> >> @@ -130,16 +130,16 @@ static inline u64
> >> *page_pool_ethtool_stats_get(u64 *data, void *stats)
> >>   struct page_pool {
> >>       struct page_pool_params p;
> >>   +    long frag_users;
> >> +    struct page *frag_page;
> >> +    unsigned int frag_offset;
> >> +    u32 pages_state_hold_cnt;
> >
> > I think this is okay, but I want to highlight that:
> >  - pages_state_hold_cnt and pages_state_release_cnt
> > need to be kept on separate cache-lines.
>
> They're pretty far away from each other. I moved hold_cnt here as well
> to keep it stacked with frag_offset and avoid introducing 32-bit holes.

This is to prevent cache line bouncing and/or false sharing right?
The change seems fine to me as well but mind adding a comment about
this when you resend?

Thanks
/Ilias
>
> >
> >
> >> +
> >>       struct delayed_work release_dw;
> >>       void (*disconnect)(void *);
> >>       unsigned long defer_start;
> >>       unsigned long defer_warn;
> >>   -    u32 pages_state_hold_cnt;
> >> -    unsigned int frag_offset;
> >> -    struct page *frag_page;
> >> -    long frag_users;
> >> -
> >>   #ifdef CONFIG_PAGE_POOL_STATS
> >>       /* these stats are incremented while in softirq context */
> >>       struct page_pool_alloc_stats alloc_stats;
> >
>
> Thanks,
> Olek
