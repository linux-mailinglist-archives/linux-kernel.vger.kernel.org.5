Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C728072EA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442439AbjLFOqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 09:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379089AbjLFOp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:45:57 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59541BC0
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 06:45:39 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-4649d22b78aso597446137.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 06:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701873938; x=1702478738; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RvuRYbFdpoGcm/YpWzxHjiZOvKmQglmv2U2Hz0xPJx8=;
        b=MdCruztsGfzor59nRnYv+CxH//8yiFYSNbReYqh+RLkqv7zXJoYfse68eHtdq6gowM
         MM3oBM5Ruio8ZComLRCZcU0TZ+cNnXcLBLiAG4Rjges1CodFB1iA6ne7TqzjA3QehlrV
         b+WjKyl32l4KtqzRuuVm/WABuxCZtq0vcHL2nHepXPXOEXNFz2rAp/fc/nPrW9PwgBKi
         EMYDx8Ox+XAvhSeiRz0kOOoI2OOhnx75HLXp4s3AtiFabOlriwkNNVOTHVBZsqN2e5fK
         6sl8zmSbhRw7GMl0MD4zsyJzXOTLhE8QLQqr2v6or5685LM10NrX+Gxyno8CQ3bWacME
         p+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701873938; x=1702478738;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RvuRYbFdpoGcm/YpWzxHjiZOvKmQglmv2U2Hz0xPJx8=;
        b=saMhYbVEoISwdzaoF4iIFIq1xHCEA91eAsYB8mk3kbg4Lm/wYKiaa7uykDOqO43tLk
         RQrsO142uOgOJNbHEMquZN5rBsgjaI72Px1yJ5KhGZlcIq9luEsfvOzjBVJDv/cEOn/C
         uHZMHw3xrt9cm8oJJOadf5odnm2WEGpBuHu+JYvr/K6nr5hJ9QiuYb7il5VQ20lHA48x
         psU6Yeg/8VKcnDAaveViHMQjxq0C99ddkDvc9g03ZAhRhYt7pu7bS7bfX4jhhjh6A671
         73WTxMdjPBZ5OaAomQjDgEXHAdxwiqkMb+rweTJ3w9zYEZFM6mK7jR8aq0CUy3Yt05fO
         udrw==
X-Gm-Message-State: AOJu0Yx2RugE/0AQ21uw5sYBud2ppk/OOn+eUOcAZ3y0JmG+eE97Ljan
        KZiW2pQCMlAe145DRhACtTm2fsnDcDelQwj/ivytrA==
X-Google-Smtp-Source: AGHT+IEgL5yvB/HTZPlguEGLqaPQzS0tF7ycaxggqTmtRTi/HtiNen24cxKjMyhwMWV/GacNHVs8A8iBwvtM4AFSvUI=
X-Received: by 2002:a05:6102:1901:b0:464:9f88:8310 with SMTP id
 jk1-20020a056102190100b004649f888310mr511241vsb.10.1701873938446; Wed, 06 Dec
 2023 06:45:38 -0800 (PST)
MIME-Version: 1.0
References: <20231204-slub-cleanup-hooks-v1-0-88b65f7cd9d5@suse.cz>
 <20231204-slub-cleanup-hooks-v1-4-88b65f7cd9d5@suse.cz> <44421a37-4343-46d0-9e5c-17c2cd038cf2@linux.dev>
 <79e29576-12a2-a423-92f3-d8a7bcd2f0ce@suse.cz> <fdd11528-b0f8-48af-8141-15c4b1b01c65@linux.dev>
In-Reply-To: <fdd11528-b0f8-48af-8141-15c4b1b01c65@linux.dev>
From:   Marco Elver <elver@google.com>
Date:   Wed, 6 Dec 2023 15:44:59 +0100
Message-ID: <CANpmjNO1_LxE9w4m_Wa5xxc1R87LhnJSZ3DV59ia3-SdQUmtpw@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm/slub: free KFENCE objects in slab_free_hook()
To:     Chengming Zhou <chengming.zhou@linux.dev>,
        Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 6 Dec 2023 at 14:02, Chengming Zhou <chengming.zhou@linux.dev> wrote:
>
> On 2023/12/6 17:58, Vlastimil Babka wrote:
> > On 12/5/23 14:27, Chengming Zhou wrote:
> >> On 2023/12/5 03:34, Vlastimil Babka wrote:
> >>> When freeing an object that was allocated from KFENCE, we do that in the
> >>> slowpath __slab_free(), relying on the fact that KFENCE "slab" cannot be
> >>> the cpu slab, so the fastpath has to fallback to the slowpath.
> >>>
> >>> This optimization doesn't help much though, because is_kfence_address()
> >>> is checked earlier anyway during the free hook processing or detached
> >>> freelist building. Thus we can simplify the code by making the
> >>> slab_free_hook() free the KFENCE object immediately, similarly to KASAN
> >>> quarantine.
> >>>
> >>> In slab_free_hook() we can place kfence_free() above init processing, as
> >>> callers have been making sure to set init to false for KFENCE objects.
> >>> This simplifies slab_free(). This places it also above kasan_slab_free()
> >>> which is ok as that skips KFENCE objects anyway.
> >>>
> >>> While at it also determine the init value in slab_free_freelist_hook()
> >>> outside of the loop.
> >>>
> >>> This change will also make introducing per cpu array caches easier.
> >>>
> >>> Tested-by: Marco Elver <elver@google.com>
> >>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> >>> ---
> >>>  mm/slub.c | 22 ++++++++++------------
> >>>  1 file changed, 10 insertions(+), 12 deletions(-)
> >>>
> >>> diff --git a/mm/slub.c b/mm/slub.c
> >>> index ed2fa92e914c..e38c2b712f6c 100644
> >>> --- a/mm/slub.c
> >>> +++ b/mm/slub.c
> >>> @@ -2039,7 +2039,7 @@ static inline void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
> >>>   * production configuration these hooks all should produce no code at all.
> >>>   *
> >>>   * Returns true if freeing of the object can proceed, false if its reuse
> >>> - * was delayed by KASAN quarantine.
> >>> + * was delayed by KASAN quarantine, or it was returned to KFENCE.
> >>>   */
> >>>  static __always_inline
> >>>  bool slab_free_hook(struct kmem_cache *s, void *x, bool init)
> >>> @@ -2057,6 +2057,9 @@ bool slab_free_hook(struct kmem_cache *s, void *x, bool init)
> >>>             __kcsan_check_access(x, s->object_size,
> >>>                                  KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ASSERT);
> >>>
> >>> +   if (kfence_free(kasan_reset_tag(x)))
> >>
> >> I'm wondering if "kasan_reset_tag()" is needed here?
> >
> > I think so, because AFAICS the is_kfence_address() check in kfence_free()
> > could be a false negative otherwise. In fact now I even question some of the
>
> Ok.
>
> > other is_kfence_address() checks in mm/slub.c, mainly
> > build_detached_freelist() which starts from pointers coming directly from
> > slab users. Insight from KASAN/KFENCE folks appreciated :)
> >
> I know very little about KASAN/KFENCE, looking forward to their insight. :)
>
> Just saw a check in __kasan_slab_alloc():
>
>         if (is_kfence_address(object))
>                 return (void *)object;
>
> So thought it seems that a kfence object would be skipped by KASAN.

The is_kfence_address() implementation tolerates tagged addresses,
i.e. if it receives a tagged non-kfence address, it will never return
true.

The KASAN_HW_TAGS patches and KFENCE patches were in development
concurrently, and at the time there was some conflict resolution that
happened when both were merged. The
is_kfence_address(kasan_reset_tag(..)) initially came from [1] but was
squashed into 2b8305260fb.

[1] https://lore.kernel.org/all/9dc196006921b191d25d10f6e611316db7da2efc.1611946152.git.andreyknvl@google.com/

Andrey, do you recall what issue you encountered that needed kasan_reset_tag()?
