Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3327EC306
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 13:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343835AbjKOMyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 07:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343837AbjKOMyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 07:54:20 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE39E130
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 04:53:54 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c594196344so87478021fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 04:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700052833; x=1700657633; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MuyikNx6ChSG02AxULm8OQDXCsKtdigfSeQkNQXENcI=;
        b=dO167f3B9fSrQBcST8qA+z2TRvLvQkL5SDaVJuj0+n2BufBUMQGK1qfhEj9YTj/7yG
         2OG2iJx5EHoV9bS3Y/kFjZdochY/jZzleccanb9P7agjRvkdD9+FqfBrZ6ELtwDEmoQL
         1jPiNXjdV+xBD30jzcAFTU5mUdVpOOGk4t7xPaR9LnQVRUBs2p8w8gwpmCzYVG7aaMzY
         CctxN5EpgAeK67CeWoOy5hZxyyxJ7Eu1MbfEGjSqBcPy+j84FCDpn5XdVCI1GbZwEEWW
         k/wpCaI2MCkptauPv8PLMBZyBUQrR4o+m/pg8VSHvUth3xJsdzDpJVZSlTJ7nQvxanu0
         UqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700052833; x=1700657633;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MuyikNx6ChSG02AxULm8OQDXCsKtdigfSeQkNQXENcI=;
        b=cmfdL9s3cESy/A1ypDJ5nYysHJVmoZuyAdsuim11FGhVdIN/IBAADb2obTZnx38sE9
         iHyqIGEJ3dL1UJm1kXaJw1KzonE1tm71YmYrZwjrJlBX1WrdbHaBM1guqta5Xia4/Moq
         jm/f2ikJO0T1pmmn0rJdqyAO4SJkrRMddoES7aVxILQd9qW6tUVnQ2Ij09LCL6M36THT
         FXN0vW9hU4vtuGrPQMjtg1ghQoDz70daNF7ftpmmDB1jBaU9BmNp5+2PZ3Sc3est6JlJ
         d+JXtWZ36424pVEaK6sS8hlHD2PB1kMRk40H6D8VpMvWFiR2DJQ4QfPBrwTqOWSNbtuu
         r9hw==
X-Gm-Message-State: AOJu0YyJmE/a7U708qi7NTAeyxACAnfETTZXYmw+Rblv6EDf95l60PMm
        LfanXIcnAgr5jBFChJxcCDwkcpEUUGXjbkWkL8rPg53ih/0RH5BOibk=
X-Google-Smtp-Source: AGHT+IF5esqszkwCy+vMIqhxdZ+dWLL2kmA3it6yqtksXWLX0V9SWVGIU/6hzusvlrBtpLEbL/wb47EGvlhdUZ3GGfA=
X-Received: by 2002:a2e:b607:0:b0:2c5:18ed:1802 with SMTP id
 r7-20020a2eb607000000b002c518ed1802mr4063420ljn.34.1700052833082; Wed, 15 Nov
 2023 04:53:53 -0800 (PST)
MIME-Version: 1.0
References: <20231113130601.3350915-1-hezhongkun.hzk@bytedance.com> <CAJD7tkY8SwROmNEaBAhkS4OKj33g-6fHsKFeYKW3afT+yAbvxA@mail.gmail.com>
In-Reply-To: <CAJD7tkY8SwROmNEaBAhkS4OKj33g-6fHsKFeYKW3afT+yAbvxA@mail.gmail.com>
From:   =?UTF-8?B?6LS65Lit5Z2k?= <hezhongkun.hzk@bytedance.com>
Date:   Wed, 15 Nov 2023 20:53:40 +0800
Message-ID: <CACSyD1P6RwjWpKhvNWEo77LKpTrnKOzT-+TV+GnQu_g-ADYbcQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm:zswap: fix zswap entry reclamation
 failure in two scenarios
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, nphamcs@gmail.com,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ying <ying.huang@intel.com>
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

> For case (1), I think a cleaner solution would be to move the
> zswap_invalidate() call from swap_range_free() (which is called after
> the cached slots are freed) to __swap_entry_free_locked() if the usage
> goes to 0. I actually think conceptually this makes not just for
> zswap_invalidate(), but also for the arch call, memcg uncharging, etc.
> Slots caching is a swapfile optimization that should be internal to
> swapfile code. Once a swap entry is freed (i.e. swap count is 0 AND
> not in the swap cache), all the hooks should be called (memcg, zswap,
> arch, ..) as the swap entry is effectively freed. The fact that
> swapfile code internally batches and caches slots should be
> transparent to other parts of MM. I am not sure if the calls can just
> be moved or if there are underlying assumptions in the implementation
> that would be broken, but it feels like the right thing to do.

Good idea,  This is indeed a clear solution.  I'll try it in another
patch later.

>
> For case (2), I don't think zswap can just decide to free the entry.
>
> In that case, the page is in the swap cache pointing to a swp_entry
> which has a corresponding zswap entry, and the page is clean because
> it is already in swap/zswap, so we don't need to write it out again
> unless it is redirtied. If zswap just drops the entry, and reclaim
> tries to reclaim the page in the swap cache, it will drop the page
> assuming that there is a copy in swap/zswap (because it is clean). Now
> we lost all copies of the page.
>
> Am I missing something?
>

Ah, my bad.  Missed the step of marking the page as dirty.
Please have a look,  just like zswap_exclusive_loads_enabled,
set page dity so that it can be pageout again.
       if (!page_was_allocated) {
              if (!count) {
                       set_page_dirty(page);
                       ret = 0;
               } else
                       ret = -EEXIST;
               put_page(page);
}
Thanks  for your feedback, Yosry.
