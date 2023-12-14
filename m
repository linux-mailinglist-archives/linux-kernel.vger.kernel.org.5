Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46C7812422
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 01:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbjLNAwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 19:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjLNAwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 19:52:47 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E069D0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 16:52:52 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40c580ba223so20560255e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 16:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702515171; x=1703119971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQez4IJe2pfRQhQRsqZ8uM1oyufL0YFowawEXGTpQlY=;
        b=nDlFMQasbJkWnWAfayHr8OITbUk0tJuRI1Cjoldy3eJZpJ8RjuYMPQHQ2pHCGHpm6U
         SjKa/M7uhDxwJ875CTxEV16yaksgU/s72oV70Fo+A5t2PAZbzPhz+XzV6dMhYsfFb6vA
         NPu8vq6S96mUs3dBGObJoNKfo9rvR46TlWmX7J6kFZeZrg43Aa3TELj4hAQkBeIf1eSR
         7hsylic79iUX7ee/PMftkV98hWoZsnY8gglTuX/enO9ZuKQvEIE1cRgNQFV+rRgCbHXE
         Vfr66yuTYCBbNbNPoxSAhfpfTk9ixm2n2THelBGZQrEQemx12bCkP9xB/zvoiHswwvw4
         uqDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702515171; x=1703119971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQez4IJe2pfRQhQRsqZ8uM1oyufL0YFowawEXGTpQlY=;
        b=nMsBZpw+IZF/Npi/wx8GnkmcdDAtKdExCHiUE/kgdRqY9NUSHuxdWUlJEX63XdxsGu
         WgFRa5EBycNKdK0120qN9V//OTKSN6DKRJ56vmJLF0p6iVk4xZFMygxfzWuW3nLo13aT
         b5Lk7D93SP7iTD/+2s9nw5tjnsg2m7l6rMZoGukJaU1FKH68PIHO19u0mTj/m/UZbcSx
         a2vgd4iMpe85QZ9UNcwOQdjI1ZI1bpwxWXQD7IbT6NOIJ4Y2YdqRl76PM2zxlebQPquy
         TZ1JW1ZQUjAhGG4maQrGUDksT0/VQVmxMUiiglVGDLFpiWVNDJ/IRfIVFl0Kk2YRV7E6
         6k6w==
X-Gm-Message-State: AOJu0YzQKn8QXbjSg/i/QB2XfvAwOB5vTAafJxzVPo7uFYLQ6XBAsInL
        I/dfl+RcoviQWpdNAXQlyJO3r39vngxlPacZaPV4Wg==
X-Google-Smtp-Source: AGHT+IHr9ZBkAWXS3rP7eFeIHcUIZb0hzq6/5MRV82p/Lp0po4o1kgQnKaF/79ll9K6VTWHl69C4cLgR7V26czfUqao=
X-Received: by 2002:a05:600c:3ca5:b0:40c:4b42:a1fd with SMTP id
 bg37-20020a05600c3ca500b0040c4b42a1fdmr2539677wmb.34.1702515170906; Wed, 13
 Dec 2023 16:52:50 -0800 (PST)
MIME-Version: 1.0
References: <20231213-zswap-dstmem-v1-0-896763369d04@bytedance.com> <20231213-zswap-dstmem-v1-3-896763369d04@bytedance.com>
In-Reply-To: <20231213-zswap-dstmem-v1-3-896763369d04@bytedance.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 13 Dec 2023 16:52:13 -0800
Message-ID: <CAJD7tkbPPy6Xqy7Xtei24B7CzxdaGwYN7tdbLH_UMVmYkYYJ=g@mail.gmail.com>
Subject: Re: [PATCH 3/5] mm/zswap: refactor out __zswap_load()
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
> The zswap_load() and zswap_writeback_entry() have the same part that
> decompress the data from zswap_entry to page, so refactor out the
> common part as __zswap_load(entry, page).
>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>

On a second look, there a few nits here.

First I think it makes more sense to move this refactoring ahead of
reusing destmem. Right now, we add the destmem reuse to zswap_load()
only, then we do the refactor and zswap_writeback_entry() gets it
automatically, so there is a slight change coming to
zswap_writeback_entry() hidden in the refactoring patch.

Let's refactor out __zswap_load() first, then reuse destmem in it.

> ---
>  mm/zswap.c | 107 ++++++++++++++++++++++---------------------------------=
------
>  1 file changed, 38 insertions(+), 69 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index fa186945010d..2f095c919a5c 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1392,6 +1392,41 @@ static int zswap_enabled_param_set(const char *val=
,
>         return ret;
>  }
>
> +static void __zswap_load(struct zswap_entry *entry, struct page *page)
> +{
> +       struct scatterlist input, output;
> +       unsigned int dlen =3D PAGE_SIZE;
> +       struct crypto_acomp_ctx *acomp_ctx;
> +       struct zpool *zpool;
> +       u8 *src;
> +       int ret;
> +
> +       acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> +       mutex_lock(acomp_ctx->mutex);
> +
> +       zpool =3D zswap_find_zpool(entry);
> +       src =3D zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
> +       if (!zpool_can_sleep_mapped(zpool)) {
> +               memcpy(acomp_ctx->dstmem, src, entry->length);
> +               src =3D acomp_ctx->dstmem;
> +               zpool_unmap_handle(zpool, entry->handle);
> +       }
> +
> +       sg_init_one(&input, src, entry->length);
> +       sg_init_table(&output, 1);
> +       sg_set_page(&output, page, PAGE_SIZE, 0);
> +       acomp_request_set_params(acomp_ctx->req, &input, &output, entry->=
length, dlen);

We should pass PAGE_SIZE here directly, BUG_ON(acomp_ctx->req->dlen)
below, and remove the dlen variable.

> +       ret =3D crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), =
&acomp_ctx->wait);

We should just BUG_ON() here directly an remove the ret variable.
