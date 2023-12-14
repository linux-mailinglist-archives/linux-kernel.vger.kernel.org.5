Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE29E812427
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 01:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbjLNA5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 19:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjLNA5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 19:57:04 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4E4DD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 16:57:10 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-a1f8a1e9637so20892466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 16:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702515429; x=1703120229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3B8OBzCG1IZ7Sv1aowAb1qOmx+XUkyQgXoo4Zoj7cKU=;
        b=kVwwYQkFb0H2hOSbGAXHsLIYbDpx8lH9fy+dmJnXI3Ep9tRYgWtSOpaCwsMjl39gHd
         5K9VdFvBwn/LgJ3V3me8j/w3NoLI34vebjI3NDnt2bYxUQF2hE6k2KtRG/av3GvUsgij
         bZxLWR+h8AEm9gkE0fyPi6jiWcM9BrGcjDtpayQ1kdHEIiBpYnLQvbv+XKlopW+YMK5k
         BmglFf2dOydHZorJrU7nX2UYwPwqprPz+jFNmpNBiK/nDGr8QyOQfPaXFiyvK261PpZJ
         etYXE2yNMV/GgfruPFIu01yZhrFrZq20WequLoapMAKDRJ+vWD42K2dRG6aT3N5KnB0o
         0Ssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702515429; x=1703120229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3B8OBzCG1IZ7Sv1aowAb1qOmx+XUkyQgXoo4Zoj7cKU=;
        b=gZx3BXY2Eq5zMF3fbp3eAdq1H2AjVwSD/Uw409K2qkqVzXmQSRoqgVsZqv3Eh3KJXl
         XGkmdvRKqaQUsVTX/iUg/qELD0lM0ECD9g1Yto1NOk5gOUmiDUO/Nx0KIf5ML/TMOGes
         m2xy8er2HsNb+BtpKUl/EjCUaYmnNHDUhwDAllsmXaGqP8u5eunQ8xkIegxdU1RjN932
         TIwTlabvCeIzGphL3XrDTLkt3gjLMoXWeGR/C9w92tsBymHZYkDvRC/5NW1HfTZrugU1
         yYCdeRXTZFv1/QDTxDc6rtA3bGuI13POrrRIK4D5+nu+8y5nVoCgIPYlW3yl02mL6GtH
         mABA==
X-Gm-Message-State: AOJu0YwC/fbS2sWI4yFSO/49/ENQHSTSDsLlrPheOQ6Il+J1dgODQVoV
        EmrwdoS9rq+DL1r9Mj2IyshQdgyX7h8fYmWZAAhBcA==
X-Google-Smtp-Source: AGHT+IHcshsT4bWys9L3ZKRZ0grn6m+7PCAsquWuunB9g4MODUbrDgopLM97JErFmHJ3WeM6+N5nSBbdzETyyNVsEu8=
X-Received: by 2002:a17:906:4ad1:b0:a1f:ae88:b909 with SMTP id
 u17-20020a1709064ad100b00a1fae88b909mr5457522ejt.70.1702515429095; Wed, 13
 Dec 2023 16:57:09 -0800 (PST)
MIME-Version: 1.0
References: <20231213-zswap-dstmem-v1-0-896763369d04@bytedance.com> <20231213-zswap-dstmem-v1-4-896763369d04@bytedance.com>
In-Reply-To: <20231213-zswap-dstmem-v1-4-896763369d04@bytedance.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 13 Dec 2023 16:56:32 -0800
Message-ID: <CAJD7tkaaXGehvsCS4T186NjrD+KJRFmeXYe3+5Fn89m6ZW_TOg@mail.gmail.com>
Subject: Re: [PATCH 4/5] mm/zswap: cleanup zswap_load()
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
> After the common decompress part goes to __zswap_load(), we can cleanup
> the zswap_load() a little.
>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

LGTM, I think it can be squashed into the patch creating
__zswap_load(), but it doesn't matter much.

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

> ---
>  mm/zswap.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 2f095c919a5c..0476e1c553c2 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1765,7 +1765,6 @@ bool zswap_load(struct folio *folio)
>         struct zswap_tree *tree =3D zswap_trees[type];
>         struct zswap_entry *entry;
>         u8 *dst;
> -       bool ret;
>
>         VM_WARN_ON_ONCE(!folio_test_locked(folio));
>
> @@ -1782,19 +1781,16 @@ bool zswap_load(struct folio *folio)
>                 dst =3D kmap_local_page(page);
>                 zswap_fill_page(dst, entry->value);
>                 kunmap_local(dst);
> -               ret =3D true;
> -               goto stats;
> +       } else {
> +               __zswap_load(entry, page);
>         }
>
> -       __zswap_load(entry, page);
> -       ret =3D true;
> -stats:
>         count_vm_event(ZSWPIN);
>         if (entry->objcg)
>                 count_objcg_event(entry->objcg, ZSWPIN);
>
>         spin_lock(&tree->lock);
> -       if (ret && zswap_exclusive_loads_enabled) {
> +       if (zswap_exclusive_loads_enabled) {
>                 zswap_invalidate_entry(tree, entry);
>                 folio_mark_dirty(folio);
>         } else if (entry->length) {
> @@ -1804,7 +1800,7 @@ bool zswap_load(struct folio *folio)
>         zswap_entry_put(tree, entry);
>         spin_unlock(&tree->lock);
>
> -       return ret;
> +       return true;
>  }
>
>  void zswap_invalidate(int type, pgoff_t offset)
>
> --
> b4 0.10.1
