Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0B2809143
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 20:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443562AbjLGT1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 14:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjLGT1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 14:27:35 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4723C10DC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 11:27:41 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a1f47f91fc0so95375966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 11:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701977260; x=1702582060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4E9EjufK+QQ1AdYRrvjoO8aPYSHXzTiO3F6OND42SLI=;
        b=I4/KHkK08+OWS1hN5mtQXof/bTMhQfAsjhynUtzwXGLjBWvHLiqw9pZrXxXLNK0QIi
         Sxkd3eU1r3A0TWcCpC4GlctsK1i35sJGNTSpeIwxjtcXULFUSRk1QJCJOO7UcK9n2VQS
         ESfmBVAwC8M8JXcAzUyx/ETJEvia0p3AfOIf6wpz7g2I1ih1VdG316yHrnhGhGYo3IE9
         VkqVDPYGZfsp1Fqz307UuNx6X3oRX/0UYhCpuhoArxT8fJ6/o79scRUEV/C2C6Zl98FK
         2NJt40hB9/ZmZs6//8L5163JekFUUcGLzqoQYNx1vWBCpM266/ZM5Bn5FuS8Ybua60Xt
         h4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701977260; x=1702582060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4E9EjufK+QQ1AdYRrvjoO8aPYSHXzTiO3F6OND42SLI=;
        b=UHDO1KV2w7FuJC2lcEzT+SIzJzROc5HG7UW+Am0M3PRcr/TvjLSLUxd2M1wp8tlSWI
         XKQWPCC6mS+o08Y71ML1M91JElqfTtCb0yDzoZyRWM87tDhTp4gwno6sgx3xNGLkAMPF
         TQ5tiF4lapdZQpuNkl9S6YszC+ELF47aUohogBEAHrXBuXRcwzLToSjBgngKikQh5NOP
         k1NOC0FUtcANQ46lhH1yPJY3P40loQTtS6yxUlIbZhjHP34pPqWisDi/R+7EHTf7L4aO
         ly7tf9mUL/FDlPmTaBPFPlW8IdbjxoFuFshNgGbs5KQ00XuRUu05Jjs2pVV4skcvhaOk
         y2MA==
X-Gm-Message-State: AOJu0YwDK3gnFcKAtq+CWS2sUop92nGHvoURAV60krqnkWnkqn9RxSXw
        gT1IWH1v6LKOFUuRI8h8leC1Mc9egFt8brRkQ3nUNQ==
X-Google-Smtp-Source: AGHT+IHH1zFYufSwyQB8U9rgrIC4sq0GB6WXoJ/zmhJTj49HFlZA7bY4ykSDj9Wui1XOBR/5t/KfodLOglwZxfBCqQ8=
X-Received: by 2002:a17:906:4717:b0:a19:a19b:5604 with SMTP id
 y23-20020a170906471700b00a19a19b5604mr1751313ejq.148.1701977259361; Thu, 07
 Dec 2023 11:27:39 -0800 (PST)
MIME-Version: 1.0
References: <20231207192406.3809579-1-nphamcs@gmail.com>
In-Reply-To: <20231207192406.3809579-1-nphamcs@gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 7 Dec 2023 11:26:58 -0800
Message-ID: <CAJD7tkaNE8G_Cd5gghaVUOf76kFxZvePv6XSZY2g4zWq2s_kfA@mail.gmail.com>
Subject: Re: [PATCH v6] zswap: memcontrol: implement zswap writeback disabling
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, tj@kernel.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, cerasuolodomenico@gmail.com,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, hughd@google.com, corbet@lwn.net,
        konrad.wilk@oracle.com, senozhatsky@chromium.org, rppt@kernel.org,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        david@ixit.cz, chrisl@kernel.org
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

On Thu, Dec 7, 2023 at 11:24=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> During our experiment with zswap, we sometimes observe swap IOs due to
> occasional zswap store failures and writebacks-to-swap. These swapping
> IOs prevent many users who cannot tolerate swapping from adopting zswap
> to save memory and improve performance where possible.
>
> This patch adds the option to disable this behavior entirely: do not
> writeback to backing swapping device when a zswap store attempt fail,
> and do not write pages in the zswap pool back to the backing swap
> device (both when the pool is full, and when the new zswap shrinker is
> called).
>
> This new behavior can be opted-in/out on a per-cgroup basis via a new
> cgroup file. By default, writebacks to swap device is enabled, which is
> the previous behavior. Initially, writeback is enabled for the root
> cgroup, and a newly created cgroup will inherit the current setting of
> its parent.
>
> Note that this is subtly different from setting memory.swap.max to 0, as
> it still allows for pages to be stored in the zswap pool (which itself
> consumes swap space in its current form).
>
> This patch should be applied on top of the zswap shrinker series:
>
> https://lore.kernel.org/linux-mm/20231130194023.4102148-1-nphamcs@gmail.c=
om/
>
> as it also disables the zswap shrinker, a major source of zswap
> writebacks.
>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

FTR I still prefer a more generic and future-proof interface (e.g.
memory.swap.tiers), but I am not opposed to this. It will just be
annoying to have different interfaces with overlapping functionalities
in the future if/when the need for a generic interface arises.
