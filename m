Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DE77EFD0C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 02:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbjKRBqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 20:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjKRBqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 20:46:12 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB996D6D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 17:46:08 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50970c2115eso3827182e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 17:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700271967; x=1700876767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TcVT2LcZer1CThzsGm63Ib3f2fkvyB696jGdmBWhhs=;
        b=Zyo3bXYtGRUlvfvJt6KlyGDSLrtO+2RCLnazzKHN/SeviiFTENBANW5SHXC3TkVE3K
         jAxudwY8YCNVKWMnPRGF1vycjM8kX3LV6rDIwRpcfAqZcHVCNLVGitKyLFSA5SpXm/e+
         LgkLaqn0n5sJrKYe4Itu+6daoX5HKgLm7wDBs9IddQYhlTbDCX6SEQ/doz9n+5gJiUix
         hggf5rswgP0FCD/6+QXz2TwT2WV/mwpRTKNWXCNJ5E/l/R6XZZHICARembfvUxTJJTzc
         gncWMrciWvE6NXU59j9GemnACVpHdU/bs4Gv+JJXEnThIHbChM1vKiDJwoue0LOpIrP1
         U8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700271967; x=1700876767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8TcVT2LcZer1CThzsGm63Ib3f2fkvyB696jGdmBWhhs=;
        b=nlt7YDCV15GfslqVX+pr5rcWR9jiGF0N4lauDuDJljWurkYFOTiAo7NLhWxI5XL3sb
         HZ0clbBB2Ha77e/IvqAGaSuJEXLMVt5KD35oBweewiwRRAl12jKYeAiQ4UPzGKd22TFz
         XjWQTYfG9oEf1zgzx/kybfm17ECXeTIvfNXyS7nJQTishwWgOkAKPZCFNvXlBf7GAdCC
         xhsCU98rByAqBO9hDYWROIJUEBnCgIB32SzkaECpr09M1B0xgXwvFJ/aj+Aglf5GtgKt
         QOiNwGBHAvrYYlBOrh6kaJvLa7Kq7NTVE3d5Hxm1Vo35Bi3hG4yaHdGLnHU+W6vufKX8
         Xynw==
X-Gm-Message-State: AOJu0YwEZOxw1XSbCuYCA5BAUdXjidHx0oeI/fVtO0yMDwi6FQj7B2x0
        3Gbg6d3fXaT/QMKdLxkwjTdTyKNxfB7ZOw98AYMhpQ==
X-Google-Smtp-Source: AGHT+IFMnyE/Xetqtbvas5oGxx7sd1g0q/XEH0TVrahotyuGB1lIhpTcC0Pq5TUcWI34cmt+PyAbZBx5V5ZlTtOnmAI=
X-Received: by 2002:ac2:4c53:0:b0:506:899d:1989 with SMTP id
 o19-20020ac24c53000000b00506899d1989mr1123882lfk.44.1700271966960; Fri, 17
 Nov 2023 17:46:06 -0800 (PST)
MIME-Version: 1.0
References: <20231113130601.3350915-1-hezhongkun.hzk@bytedance.com>
 <CAJD7tkY8SwROmNEaBAhkS4OKj33g-6fHsKFeYKW3afT+yAbvxA@mail.gmail.com>
 <CAF8kJuPonfuOtipdifXwBny2H7cy6m6BL8mWFVXzfb9JSdYq3Q@mail.gmail.com>
 <CAJD7tkYMiJiXTTgAN34TP8QTr-ViAuEFddYes=ac+1ErenjCZw@mail.gmail.com>
 <CAF8kJuOC30feLGs0bNHOxMjSZ3uqF1y7eUdJ4p-w-myP8c1cFg@mail.gmail.com>
 <CACSyD1NJ4ycr74pXHNus3ZjA=LvZP+aMNyz=iWyHuDODpx7aww@mail.gmail.com> <CAF8kJuPymUX+DwouwgH6og0BO6ZYheGXsk=GYqYuMjKMz-Xqbw@mail.gmail.com>
In-Reply-To: <CAF8kJuPymUX+DwouwgH6og0BO6ZYheGXsk=GYqYuMjKMz-Xqbw@mail.gmail.com>
From:   Zhongkun He <hezhongkun.hzk@bytedance.com>
Date:   Sat, 18 Nov 2023 09:45:55 +0800
Message-ID: <CACSyD1P-6mQ7n+ghsZQ0Gp4AxyTTi6=UZHz2DnXWuCWke2fkPw@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris, thanks for your time.

>
> On Fri, Nov 17, 2023 at 1:56=E2=80=AFAM Zhongkun He
> <hezhongkun.hzk@bytedance.com> wrote:
> > Hi Chris, thanks for your feedback.  I have the same concerns,
> > maybe we should just move the zswap_invalidate() out of batches,
> > as Yosry mentioned above.
>
> As I replied in the previous email, I just want to understand the
> other side effects of the change better.
>
> To me, this patching is actually freeing the memory that does not
> require actual page IO write from zswap. Which means the memory is
> from some kind of cache. It would be interesting if we can not
> complicate the write back path further. Instead, we can drop those
> memories from the different cache if needed. I assume those caches are
> doing something useful in the common case. If not, we should have a
> patch to remove these caches instead.  Not sure how big a mess it will
> be to implement separate the write and drop caches.
>
> While you are here, I have some questions for you.
>
> Can you help me understand how much memory you can free from this
> patch? For example, are we talking about a few pages or a few GB?
>
> Where does the freed memory come from?
> If the memory comes from zswap entry struct. Due to the slab allocator
> fragmentation. It would take a lot of zswap entries to have meaningful
> memory reclaimed from the slab allocator.
>
> If the memory comes from the swap cached pages, that would be much
> more meaningful. But that is not what this patch is doing, right?
>
> Chris

It's my bad for putting two cases together. The memory released in both
cases comes from zswap entry struct and zswap compressed page.

The original intention of this patch is to solve the problem that
shrink_work() fails to reclaim memory in two situations.

For case (1),  the zswap_writeback_entry() will failed for the
__read_swap_cache_async return NULL because the swap has been
freed but cached in swap_slots_cache, so the memory come from
the zswap entry struct and compressed page.
Count =3D SWAP_BATCH * ncpu.
Solution: move the zswap_invalidate() out of batches, free it once the swap
count equal to 0.

For case (2),  the zswap_writeback_entry() will failed for !page_was_alloca=
ted
because zswap_load will have two copies of the same page in memory
  (compressed and uncompressed) after faulting in a page from zswap when
zswap_exclusive_loads disabled. The amount of memory is greater but depends
on the usage.

Why do we need  to release them?
Consider this scenario,there is a lot of data cached in memory and zswap,
hit the limit=EF=BC=8Cand shrink_worker will fail. The new coming data will=
 be written
directly to swap due to zswap_store failure. Should we free the last one
to store the latest one in zswap.

According to the previous discussion, the writeback is inevitable.
So I want to make zswap_exclusive_loads_enabled the default behavior
or make it the only way to do zswap loads. It only makes sense when
the page is read and no longer dirty. If the page is read frequently, it
should stay in cache rather than zswap. The benefit of doing this is
very small, i.e. two copies of the same page in memory.

Thanks again.
