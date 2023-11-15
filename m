Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941547EC1E4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 13:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343634AbjKOMMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 07:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbjKOMMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 07:12:49 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562F1121
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 04:12:15 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-507a55302e0so9470272e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 04:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700050333; x=1700655133; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T89SiAsQc/h+GMq70kagyYYGnBW+TAITQk5Fhw20c4w=;
        b=fgVm2MRbfwEoWUJ6ZzmwBM/nW13p9dpmeTPIR98aDykSjk2reOUHJ4TDRSfh8HuK2D
         vZm50S1+/dWUbDSOV6r7vDURZbr5K4E/gJ1DYslgjjx56nl1D4XzmE5o6bUZz0pptE/A
         d+1eh6SUC+t/IOTgTm721HZMIQxAfQaknzxc1Y8oJD8Dj35SD0HArlyasDYAS1oIng/i
         t8DIrk7S+M/io9bdHfpO3wJYumjPrrwi9IIynLRG15MNGcPlZfe3Bl21uPXjkTV9ouxk
         10cYBh8cAOYZXmyxJVhabvNHu8nhBKmP7mbZPgX1rN5R5QSqxpc5L31EO7wR9Vlx97IF
         CnTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700050333; x=1700655133;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T89SiAsQc/h+GMq70kagyYYGnBW+TAITQk5Fhw20c4w=;
        b=DQaG3cm2wGBuTnnbm6p32+8tXygV++X57SoSFjkMSArN8sJMUeUZ4DeLYxDoJ1xIZv
         k4cCOZNgudZA1qTn7HEz2WkSyCymZ6dO4dj/Rl6r0WZyJkWYUFAm4NcdNHvEWrTqQ4Ic
         pJQyUKZNz3URoEbYkGUkgw9+GnbRzNPyWgE5iZgFGgSapLEGz4ZjzG4HiKSBmLcivnoo
         w3aFFx5FB1y4qRuGxajCd9eKO5NVMIcV1iZAdPhNQQL0u3pOP1Y39ODYtmycEDsP7W9T
         9NCefjYpqbKBBzxrR+LcgwaV7GYsUjojeSBLHdSAeekARo+Bg1qQ16xUQcZdetUutxM9
         IikA==
X-Gm-Message-State: AOJu0YxkodK+DjYokbEKL9So1juSWpwRtB5x9fJPuxoLv7NebgXwyt8H
        +GfyJoQLkb6rppjTUzRhHlRcQPNCXDQkPZzNiRxLJg==
X-Google-Smtp-Source: AGHT+IF11gaQjEjEYaDdzVe9+XgV1z74FQXYQLBkepiDrbrqLeVAdGpGUJ7LQtBo4pSj/D2u0wvXBC9oF0VigHRMNeU=
X-Received: by 2002:a05:6512:ac4:b0:507:a701:3206 with SMTP id
 n4-20020a0565120ac400b00507a7013206mr11019099lfu.49.1700050333546; Wed, 15
 Nov 2023 04:12:13 -0800 (PST)
MIME-Version: 1.0
References: <20231113130601.3350915-1-hezhongkun.hzk@bytedance.com>
 <CAKEwX=NhiGyoqR3HaDCuarqGmM5CCMYDatvVEEtVKzrL8DdDbw@mail.gmail.com>
 <CACSyD1NyynLrrkrp-A8tGW5gUJeFQiYk_E_SO14m_7wqrddtiQ@mail.gmail.com> <CAKEwX=MinEqt_gR+hvyYc1dgU68B1Auw8fypRo7SKFjFK7VHaA@mail.gmail.com>
In-Reply-To: <CAKEwX=MinEqt_gR+hvyYc1dgU68B1Auw8fypRo7SKFjFK7VHaA@mail.gmail.com>
From:   =?UTF-8?B?6LS65Lit5Z2k?= <hezhongkun.hzk@bytedance.com>
Date:   Wed, 15 Nov 2023 20:12:01 +0800
Message-ID: <CACSyD1Ou-CuqXfpNtjj=oypYP47natsJtYd8iZ38hVuncfuT_g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm:zswap: fix zswap entry reclamation
 failure in two scenarios
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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
> Ah my bad, I should have been clearer.
>
> I was looking at the zswap shrinker patch series (specifically the
> cgroup-aware LRU patch), which moves the counter update out of
> zswap_writeback_entry. If we apply that patch on top of that series, we will
> screw up the counter. Should be easily fixable anyway though.

Got it.

>
> Ah I think I understand the point of the patch a bit better now.
>
> Essentially, we're invalidating these entries, which does reclaim the
> memory used for these compressed objects, but there is no IO involved.
> Writeback-less shrinking, if you will.
>
> This will still screw up one of the heuristics I'm using for the zswap
> shrinker a bit, but that should be easily fixable with some plumbing.
> Same goes for the writeback counter - but depending on the order in
> which Andrew apply the patches, you might have to resolve the conflicts
> there :)

OK,  I will fix it.

>
> Other than this objection, I think this optimization makes sense to me:
>
> In the first case, we already freed the swap entry. Might as well also
> dropped the zswap entry.
>
> In the second case, we already have another copy in memory, so
> dropping the compressed copy to make space for warmer objects
> coming into zswap makes sense to me. Might be worth doing a
> micro-benchmark to verify this intuition, but I agree that it's more
> important to maintain the LRU ordering than any CPU saving from
> skipping re-compression.
>
> I would suggest that you should expand on this on the commit log
> to make clearer the motivation behind this optimization, if you were
> to re-submit this patch for some reason (for e.g to resolve the
> aforementioned conflicts with the zswap shrinker series).
>
> But otherwise, LGTM!
>
> Feel free to add the following tag:
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>

Thanks, there are still some commits from Yosry,
after that, I will send it again.
