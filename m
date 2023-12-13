Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F105B8122C6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 00:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbjLMXYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 18:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjLMXYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 18:24:50 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F37E3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 15:24:56 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a1ec87a7631so670748366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 15:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702509895; x=1703114695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFEmwUcK7ari3l1HAYNZ+QAFaZZrXeQEzXKeC4yMuRw=;
        b=p67Dgqqsa+zo3k4YSYAMwwxXURoveV/FCvOzakUOwIJlxyyB/N3M3K65xVEdmgvX2/
         uTVwnFygeSEk9cX7L62k3UMDHs2IN4TZgoDpgdTFliEAEVGGeMUf48viX7I1uZnSKlOq
         vD7K9hqpr26sGas6ADgIR+MOd9S1HzYySFun2CmdR4deNZ3i/r6qB0+XyKwlv3dJPRlH
         FHiEkxhnoa7ZzwOZR33YlwCBDDuKLAuh+ADW3HHCPn+elgWE+OfiqBodi7LpdU5cI6nW
         YnvJAc8IK1AD6tEAlTHGoajjwcb1KX6A6DALTJjNyOrUYVq+IwGh4j9YJFPWcSkbRcEq
         aceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702509895; x=1703114695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pFEmwUcK7ari3l1HAYNZ+QAFaZZrXeQEzXKeC4yMuRw=;
        b=EdT0kxYXGb/KBohF/S5bLRBS19+LXuAIl0X2WQrHg48K6ftFu2qzOXCtTMPANwaZR9
         zM+2EDthZ3nEDMG06MozMA6/5gEdpOUGplWUzFn/bnchXN2DOyYy1wHs3qIhLCRxAviJ
         8zlM4nUtXOOLMi6KphCWn36MigteiYoeXpx0AoRQzPPVEMdYkuRbOuC/2ov7LpA9Lf2e
         pu1vol18J+NQSyE6ZLRz3qVMhm5WWegdyASIiHpCUvDHmR7q5yu2erFfmQ8n9THsV/B4
         bua76IIdyKGIQZ/UdA0ign0Xn6LVt5r/On/DNhOkU8VTzV8sclJfxXDmL15eAwa2kVRW
         22fw==
X-Gm-Message-State: AOJu0Yzf2VZCoqdlGw3Zz5S2J4reDNbdnZrqZkbEFShsxImZ5pGUTwUs
        Libb1oIcUgtcu7W6hvysjyyqfels3Z7JgQ0u5i8Jdg==
X-Google-Smtp-Source: AGHT+IFxWZstDV0MDpA8pfegUWB3HXmyzLLjGIG85pRq8f9FDhZWz+x7TIjmybFMQAcLJhNDAUPvdhfz+lXRkaHNckc=
X-Received: by 2002:a17:906:35ca:b0:a19:29b3:89f4 with SMTP id
 p10-20020a17090635ca00b00a1929b389f4mr4825392ejb.52.1702509895189; Wed, 13
 Dec 2023 15:24:55 -0800 (PST)
MIME-Version: 1.0
References: <20231213-zswap-dstmem-v1-0-896763369d04@bytedance.com> <20231213-zswap-dstmem-v1-1-896763369d04@bytedance.com>
In-Reply-To: <20231213-zswap-dstmem-v1-1-896763369d04@bytedance.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 13 Dec 2023 15:24:17 -0800
Message-ID: <CAJD7tkbicqevYuJbTUZBQUo2n_k-HKTixG5TbXGtdbtFJgFmfg@mail.gmail.com>
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

On Tue, Dec 12, 2023 at 8:18=E2=80=AFPM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> In the !zpool_can_sleep_mapped() case such as zsmalloc, we need to first
> copy the entry->handle memory to a temporary memory, which is allocated
> using kmalloc.
>
> Obviously we can reuse the per-compressor dstmem to avoid allocating
> every time, since it's percpu-compressor and protected in mutex.
>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  mm/zswap.c | 29 +++++++++--------------------
>  1 file changed, 9 insertions(+), 20 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 7ee54a3d8281..edb8b45ed5a1 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1772,9 +1772,9 @@ bool zswap_load(struct folio *folio)
>         struct zswap_entry *entry;
>         struct scatterlist input, output;
>         struct crypto_acomp_ctx *acomp_ctx;
> -       u8 *src, *dst, *tmp;
> +       unsigned int dlen =3D PAGE_SIZE;
> +       u8 *src, *dst;
>         struct zpool *zpool;
> -       unsigned int dlen;
>         bool ret;
>
>         VM_WARN_ON_ONCE(!folio_test_locked(folio));
> @@ -1796,27 +1796,18 @@ bool zswap_load(struct folio *folio)
>                 goto stats;
>         }
>
> -       zpool =3D zswap_find_zpool(entry);
> -       if (!zpool_can_sleep_mapped(zpool)) {
> -               tmp =3D kmalloc(entry->length, GFP_KERNEL);
> -               if (!tmp) {
> -                       ret =3D false;
> -                       goto freeentry;
> -               }
> -       }
> -
>         /* decompress */
> -       dlen =3D PAGE_SIZE;
> -       src =3D zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
> +       acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> +       mutex_lock(acomp_ctx->mutex);
>
> +       zpool =3D zswap_find_zpool(entry);
> +       src =3D zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
>         if (!zpool_can_sleep_mapped(zpool)) {
> -               memcpy(tmp, src, entry->length);
> -               src =3D tmp;
> +               memcpy(acomp_ctx->dstmem, src, entry->length);
> +               src =3D acomp_ctx->dstmem;

I don't like that we are now using acomp_ctx->dstmem and
acomp_ctx->mutex now for purposes other than what the naming suggests.

How about removing these two fields from acomp_ctx, and directly using
zswap_dstmem and zswap_mutex in both the load and store paths, rename
them, and add proper comments above their definitions that they are
for generic percpu buffering on the load and store paths?
