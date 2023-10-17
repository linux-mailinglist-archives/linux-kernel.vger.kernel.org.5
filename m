Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD3D7CB870
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 04:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbjJQCdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 22:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJQCdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 22:33:16 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B264E6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 19:33:13 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c5028e5b88so53379131fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 19:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697509991; x=1698114791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TcMqLbn0zF1KX0fdP3lsQLyg3y0OI+0Vy/wkpY30DA=;
        b=CBZL01qNSh5jgUtIHO9JpB7RvEYiKS+vGnIgvED/hOH53B/dPDeTn8nyaGSwE/OfJ9
         8v9CIAs2KveJ/pDYT/OkTpI04zmqzwYppL3p7/Ot79tR3fV2yETM+VhZCQ13c2ENr/rF
         3kkolTIRu6GMqiBhjUY8gIpUoOmZAH0c9x6CWGeMPk0x3P31ujlZTn/VPNKdyfwqC6g1
         r+LfjsdKQ8BnHAtI4id1MalPEGbDsoLwtre8K4iK8xLwZmbCFVKNzWY5s11zI/oKRrBG
         Mxzcf+0ImPln7O+PFcKeVlUTGsgES/fenJ5UOpbdmh6P7CXJd1cfzlMY51ovLZner8dm
         mgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697509991; x=1698114791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8TcMqLbn0zF1KX0fdP3lsQLyg3y0OI+0Vy/wkpY30DA=;
        b=aH4psFU+prSVUTKbhsBMOZIiTTRPdI2+KJCOGPfmgfRgyV8C/KiGyeMCHsVO8jQl1k
         thkFlxmyVJ0RnVo/NLHr/mNf6ceqbbhurQvIhW05u9cSxdeupPU0wk9cMeB+ONlr6auF
         q4JTbN85j2rZq6FZXeisSyPkj0qkcrcoS4r3I5RKBYMmXs1c4ldYzlJw9rg2LoY1AWIe
         6OXnCKLzCTiBcpLGis2YQNQH2DIyxnevTDvNeizmuCfzJgkWaLmkN8hIEmPU4qsPz++i
         iYfNWzO5Oaqh9UMWOWqT6wa0E21HFk3ZUqgr/BNhshZGlhbdgG7dyo+6B2R/mtUg44vv
         NcYg==
X-Gm-Message-State: AOJu0YwQ7nN9fIqBHmFhPuOxxFVgqUixl/26TdwwUJ+XSwEatijbTaAi
        MQl3AGFKj/bbON4yasF9MWQLR7w+C3rV00sTWRA=
X-Google-Smtp-Source: AGHT+IHhlgnJLOyHTROkSaC0DhM2EYlgRA/3QBMytWDYt/jWUd7m1cjmnnqt7sotnk6DtxqeMrg7MbplD6+EIUfBBFg=
X-Received: by 2002:a2e:88ce:0:b0:2bc:f39b:d1a8 with SMTP id
 a14-20020a2e88ce000000b002bcf39bd1a8mr662452ljk.46.1697509991069; Mon, 16 Oct
 2023 19:33:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231016071245.2865233-1-zhaoyang.huang@unisoc.com> <20231016153959.c218e1ae876426b9193eb294@linux-foundation.org>
In-Reply-To: <20231016153959.c218e1ae876426b9193eb294@linux-foundation.org>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Tue, 17 Oct 2023 10:32:59 +0800
Message-ID: <CAGWkznE+NJECwdcyb0d5MOrgjA5Qt-o4-5SmsCstZuYLhunKew@mail.gmail.com>
Subject: Re: [PATCHv6 1/1] mm: optimization on page allocation when CMA enabled
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 6:40=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Mon, 16 Oct 2023 15:12:45 +0800 "zhaoyang.huang" <zhaoyang.huang@uniso=
c.com> wrote:
>
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > According to current CMA utilization policy, an alloc_pages(GFP_USER)
> > could 'steal' UNMOVABLE & RECLAIMABLE page blocks via the help of
> > CMA(pass zone_watermark_ok by counting CMA in but use U&R in rmqueue),
> > which could lead to following alloc_pages(GFP_KERNEL) fail.
> > Solving this by introducing second watermark checking for GFP_MOVABLE,
> > which could have the allocation use CMA when proper.
> >
> > -- Free_pages(30MB)
> > |
> > |
> > -- WMARK_LOW(25MB)
> > |
> > -- Free_CMA(12MB)
> > |
> > |
> > --
> >
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > ---
> > v6: update comments
>
> The patch itself is identical to the v5 patch.  So either you meant
> "update changelog" above or you sent the wrong diff?
sorry, should be update changelog
>
> Also, have we resolved any concerns regarding possible performance
> impacts of this change?
I don't think this commit could introduce performance impact as it
actually adds one more path for using CMA page blocks in advance.

 __rmqueue(struct zone *zone, unsigned int order, int migratetype,
        if (IS_ENABLED(CONFIG_CMA)) {
                if (alloc_flags & ALLOC_CMA &&
-                   zone_page_state(zone, NR_FREE_CMA_PAGES) >
-                   zone_page_state(zone, NR_FREE_PAGES) / 2) {
+                       use_cma_first(zone, order, alloc_flags)) {
          //current '1/2' logic is kept while add a path for using CMA
in advance than now.
                        page =3D __rmqueue_cma_fallback(zone, order);
                        if (page)
                                return page;
                }
        }
retry:
                               //normal rmqueue_smallest path is not
affected which could deemed as a fallback path for
__rmqueue_cma_fallback failure
        page =3D __rmqueue_smallest(zone, order, migratetype);
        if (unlikely(!page)) {
                if (alloc_flags & ALLOC_CMA)
                        page =3D __rmqueue_cma_fallback(zone, order);

                if (!page && __rmqueue_fallback(zone, order, migratetype,
                                                                alloc_flags=
))
                        goto retry;
        }
        return page;
}
