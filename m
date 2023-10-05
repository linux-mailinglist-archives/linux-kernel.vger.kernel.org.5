Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D299E7B9F1D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbjJEOSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244369AbjJENxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 09:53:13 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD0DA262;
        Thu,  5 Oct 2023 02:20:02 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-495c10cec8aso301717e0c.1;
        Thu, 05 Oct 2023 02:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696497601; x=1697102401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mmCqW9/RdSqKhGNA9TKQ87Kw41v1aHc9awKHSSwaUow=;
        b=XKZHqhOQtCJjJGu2yjhzCzYiwhgWHYOR9ifK/PkPGWipcTd6dcfdWYbgllr1BpoaTp
         3nioJnsIxBzu+V0qmUyz8ya+dlHy5Tbx/xu4W0fLmKY7TtdSFhlMDoo37g7A7ifW9EVd
         gYS5QNL2iLZ1J45ufkr8MHI0YkhYuSNOg+RxYbcn3gfEUCqMUNw2tKQs9A1ClUl6jfH1
         KaJIzmu384GcQYFqYgpONuoJoHMstU+j05AgCsMAbdfKXxnixV247De27Bo3moMypsHn
         huQnhCI5SwGveM+GgaaDkorTV2J/kAehyEafUeymOPYUYH5bQ3jj6Vb2n6BE8rahe5RL
         JOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696497601; x=1697102401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mmCqW9/RdSqKhGNA9TKQ87Kw41v1aHc9awKHSSwaUow=;
        b=EoNWI4zHlhZzLjWxC/hktuqYB5rSeLkdjaf7vjE8cD3m5M7EID4lzWm453wPNWNG+/
         4tiL7nCUaPMGNEEf1ogK9DMrlhJwRTsQq23VrQ8sxuv6BxiuSKMCdh7QjOqHqL3n0Tvs
         0zoaUq3OZsTHL9EmKBiG4P3mbASOjSfGGdraPXKatURwpOewHlyS4ulBOPiIG1ohNUKx
         /I+hW9vQ4iATPKItM78sPw7+Gf233wiZK7Cr1uQK9HiIILfX2K0aJ1324a1fg1u0pDrb
         Zv0Gh+h6kcaRAyCEi4O4jAZ5oHT502uEtKtjKkjiJ+bnrtT9wXTKjqEI9oYo83OaZ5Xb
         CyJg==
X-Gm-Message-State: AOJu0Yym1gYZ+p+Fh/8w/7zkiNgblTl1SMOT1GkLzxXvLKDUcr9qBjXD
        7EwT884z2cQlUnRfNA6TWgdXn5xkHSOYdftcMGo=
X-Google-Smtp-Source: AGHT+IGUrv6tiziv5lNUOurSFPVAQQfdUe8LaLIUvdzpuLVD38jauJwHQ9ABh5kenASpIGpWyVACc47Bj2BBcblpoc8=
X-Received: by 2002:a1f:6d84:0:b0:496:1bc2:ddf with SMTP id
 i126-20020a1f6d84000000b004961bc20ddfmr4465596vkc.8.1696497601021; Thu, 05
 Oct 2023 02:20:01 -0700 (PDT)
MIME-Version: 1.0
References: <20231004150856.2540-1-jszhang@kernel.org>
In-Reply-To: <20231004150856.2540-1-jszhang@kernel.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 5 Oct 2023 10:19:06 +0100
Message-ID: <CA+V-a8uTr9vMNTKJDudjCERjnW9M_wms3LtHcOcpRc2RuhbBBw@mail.gmail.com>
Subject: Re: [PATCH] soc: renesas: make ARCH_R9A07G043 (riscv version) depend
 on NONPORTABLE
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Drew Fustini <dfustini@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 4, 2023 at 4:21=E2=80=AFPM Jisheng Zhang <jszhang@kernel.org> w=
rote:
>
> Drew found "CONFIG_DMA_GLOBAL_POOL=3Dy causes ADMA buffer alloc to fail"
> the log looks like:
> [    3.741083] mmc0: Unable to allocate ADMA buffers - falling back to st=
andard DMA
>
> The logic is: generic riscv defconfig selects ARCH_RENESAS then
> ARCH_R9A07G043 which selects DMA_GLOBAL_POOL, which assumes all
> non-dma-coherent riscv platforms have a dma global pool, this assumption
> seems not correct. And I believe DMA_GLOBAL_POOL should not be
> selected by ARCH_SOCFAMILIY, instead, only ARCH under some specific
> conditions can select it globaly, for example NOMMU ARM and so on,
> because it's designed for special cases such as "nommu cases where
> non-cacheable memory lives in a fixed place in the physical address
> map" as pointed out by Robin.
>
> Fix the issue by making ARCH_R9A07G043 (riscv version) depend on
> NONPORTABLE, thus generic defconfig won't select ARCH_R9A07G043 by
> default. And even for random config case, there will be less debug
> effort once we see NONPORTABLE is enabled.
>
> Reported-by: Drew Fustini <dfustini@baylibre.com>
> Closes: https://lore.kernel.org/linux-riscv/ZRuamJuShOnvP1pr@x1/
> Fixes: 484861e09f3e ("soc: renesas: Kconfig: Select the required configs =
for RZ/Five SoC")
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  drivers/soc/renesas/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar


> diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
> index 5a75ab64d1ed..12040ce116a5 100644
> --- a/drivers/soc/renesas/Kconfig
> +++ b/drivers/soc/renesas/Kconfig
> @@ -333,6 +333,7 @@ if RISCV
>
>  config ARCH_R9A07G043
>         bool "RISC-V Platform support for RZ/Five"
> +       depends on NONPORTABLE
>         select ARCH_RZG2L
>         select AX45MP_L2_CACHE if RISCV_DMA_NONCOHERENT
>         select DMA_GLOBAL_POOL
> --
> 2.40.1
>
