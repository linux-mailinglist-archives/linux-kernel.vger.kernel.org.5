Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A418131A6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573333AbjLNNci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573304AbjLNNch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:32:37 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E3C114
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:32:43 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c9f7fe6623so102248511fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702560761; x=1703165561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jim/lOntV9iDTSpGOJDnAOIgsuHO8H2tmMhky2DuBN8=;
        b=n2O+2yyvfMlx3iRGTFyVuJRi0xFba3z3y3enUC03J97GfsWwFblkejJKYbeAQABic2
         UVnhBi8643UrO/QyPPbP/EDdy/Vd0YBeJ6ADNLgeeOzGsmg/lpPFIw3t8rrtfLRtSavu
         JGMgrCqFLfq9b8Euww+onuIyM2c6Fve8F6Ht1O0XbhPxuey9ldNag0dmb2sj/PqIuBgH
         wlLet/5lQkcrML81DgoPasmqa+3oIlgxmfJBE5CoXFrbPb/RafveqxWKImqAy9xyl2/y
         a1/TThbSSh1WdchBX2LqFlmLUUWCiyIOIdVEbH0vGaqeBNUbAWQBOF8icKpvHG/zGpvF
         VuZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702560761; x=1703165561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jim/lOntV9iDTSpGOJDnAOIgsuHO8H2tmMhky2DuBN8=;
        b=Dj0aqkYa2NtOESyvixl47NTxvZYoX5rdhKpckyZc5HyDskfsuYWWKYPHcfu3qe0dtG
         YTlziwf5B3beVpXqJuBb0JXyf1m62XKu0xUrUj7HPLiHMUBMNhc6R2mqgIHqdXHGMajh
         T4Rt4dFeQnIv7M+9pXB4mUV08cqWus+VUYKPuciiXGxdgp0mfyXTVXmt8OauT2+2tGCA
         5UKVBN7gn/1JnG7/wXGU72J8NslKs3TbhgV3x7CV7esRyJ86kFuKep+2qdTbDkuyeI0h
         kGKDEf+81bI0844Jsw2Jrc4SluXxY40UpOVQ4tx4EghdlVlYEsOSw3Bp6xBoZcAVGU4j
         bZBg==
X-Gm-Message-State: AOJu0YwLulqY7A8PUahrk4LWwsS2T/4P22hmmoeKJUzAl4zu1nI4HFBi
        bVc5yafTTJaFdXSM5eSphrhwQCX85dHh59FPbOSkUFTfyOG9HmivL9U=
X-Google-Smtp-Source: AGHT+IEJvQHNgucfsmf6sjlHsvCkB/CwWba34eRci4n9RZX+1e/kdUJv1PKf7SuYlqg2XtH8BzhZEbK2P17AIyVj1EE=
X-Received: by 2002:a19:644a:0:b0:50b:f47d:770f with SMTP id
 b10-20020a19644a000000b0050bf47d770fmr2955552lfj.0.1702560761036; Thu, 14 Dec
 2023 05:32:41 -0800 (PST)
MIME-Version: 1.0
References: <20231213-zswap-dstmem-v1-0-896763369d04@bytedance.com>
 <20231213-zswap-dstmem-v1-1-896763369d04@bytedance.com> <CAJD7tkbicqevYuJbTUZBQUo2n_k-HKTixG5TbXGtdbtFJgFmfg@mail.gmail.com>
 <8f80fe3e-a8c7-463d-896b-99575c362839@bytedance.com>
In-Reply-To: <8f80fe3e-a8c7-463d-896b-99575c362839@bytedance.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 14 Dec 2023 05:32:03 -0800
Message-ID: <CAJD7tkbS_3eEDbfo-w1Z+tuY44YKMYnAqaL0684Y6nh2EmHq+Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] mm/zswap: reuse dstmem when decompress
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nhat Pham <nphamcs@gmail.com>, Chris Li <chriscli@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
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

On Thu, Dec 14, 2023 at 5:29=E2=80=AFAM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> On 2023/12/14 07:24, Yosry Ahmed wrote:
> > On Tue, Dec 12, 2023 at 8:18=E2=80=AFPM Chengming Zhou
> > <zhouchengming@bytedance.com> wrote:
> >>
> >> In the !zpool_can_sleep_mapped() case such as zsmalloc, we need to fir=
st
> >> copy the entry->handle memory to a temporary memory, which is allocate=
d
> >> using kmalloc.
> >>
> >> Obviously we can reuse the per-compressor dstmem to avoid allocating
> >> every time, since it's percpu-compressor and protected in mutex.
> >>
> >> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> >> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> >> ---
> >>  mm/zswap.c | 29 +++++++++--------------------
> >>  1 file changed, 9 insertions(+), 20 deletions(-)
> >>
> >> diff --git a/mm/zswap.c b/mm/zswap.c
> >> index 7ee54a3d8281..edb8b45ed5a1 100644
> >> --- a/mm/zswap.c
> >> +++ b/mm/zswap.c
> >> @@ -1772,9 +1772,9 @@ bool zswap_load(struct folio *folio)
> >>         struct zswap_entry *entry;
> >>         struct scatterlist input, output;
> >>         struct crypto_acomp_ctx *acomp_ctx;
> >> -       u8 *src, *dst, *tmp;
> >> +       unsigned int dlen =3D PAGE_SIZE;
> >> +       u8 *src, *dst;
> >>         struct zpool *zpool;
> >> -       unsigned int dlen;
> >>         bool ret;
> >>
> >>         VM_WARN_ON_ONCE(!folio_test_locked(folio));
> >> @@ -1796,27 +1796,18 @@ bool zswap_load(struct folio *folio)
> >>                 goto stats;
> >>         }
> >>
> >> -       zpool =3D zswap_find_zpool(entry);
> >> -       if (!zpool_can_sleep_mapped(zpool)) {
> >> -               tmp =3D kmalloc(entry->length, GFP_KERNEL);
> >> -               if (!tmp) {
> >> -                       ret =3D false;
> >> -                       goto freeentry;
> >> -               }
> >> -       }
> >> -
> >>         /* decompress */
> >> -       dlen =3D PAGE_SIZE;
> >> -       src =3D zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
> >> +       acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> >> +       mutex_lock(acomp_ctx->mutex);
> >>
> >> +       zpool =3D zswap_find_zpool(entry);
> >> +       src =3D zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
> >>         if (!zpool_can_sleep_mapped(zpool)) {
> >> -               memcpy(tmp, src, entry->length);
> >> -               src =3D tmp;
> >> +               memcpy(acomp_ctx->dstmem, src, entry->length);
> >> +               src =3D acomp_ctx->dstmem;
> >
> > I don't like that we are now using acomp_ctx->dstmem and
> > acomp_ctx->mutex now for purposes other than what the naming suggests.
>
> The "mutex" name is coherent, "dstmem" depends on how we use IMHO.
> Change to just "mem"? Or do you have a better name to replace?
>
> >
> > How about removing these two fields from acomp_ctx, and directly using
> > zswap_dstmem and zswap_mutex in both the load and store paths, rename
> > them, and add proper comments above their definitions that they are
> > for generic percpu buffering on the load and store paths?
>
> Yes, they are percpu memory and lock, but they are used by per acomp_ctx,
> and the cpu maybe changing in the middle, so maybe better to keep them.

I don't mean to remove completely. Keep them as (for example)
zswap_mem and zswap_mutex global percpu variables, and not have
pointers in acomp_ctx to them. Instead of using acomp_ctx->dstmem
today, we directly use the global zswap_mem (same for the mutex).

This makes it clear that the buffers are not owned or exclusively used
by the acomp_ctx. WDYT?
