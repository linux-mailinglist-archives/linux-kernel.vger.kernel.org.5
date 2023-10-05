Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93227B9E9A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbjJEOJs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 5 Oct 2023 10:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjJEOHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:07:33 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9320126A70;
        Thu,  5 Oct 2023 05:57:53 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-59f57ad6126so10027747b3.3;
        Thu, 05 Oct 2023 05:57:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696510669; x=1697115469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HADAOv2Ff88FzB1D4GtvfGj4LE7j/q0n3R8h677Tcd0=;
        b=NpQ5xhDDIFfJgs+bDweLL9EefUgAeX/G0dx4D4gXj2gAzG2dnHDBhbcAqi0hC1S3Cw
         +RWZIkl/64sE4zu5GAhbhWOWydnHkyu8lph46xfGDbIz4rO+TkUCwVh0vkqnI3mUtmPX
         5K4CvyWp9FnD/ryx5XwpiCMmTA3yOa3t8fxHRoB4qn5ZuBtlRM/wcYV8xA1EQz4Prfjn
         2rrIfSEbr/Gy3KwJuVss1gQZo8HR1WJXti5844fwmoCRERre9AWhUrO0mbNZWsYOLFId
         RjUihRvZnlFO+Nsmhjs4Vmi+FQ08gmr33r+ckwHBjXg/j/lU5WtKe64/86mVXMiApd4Y
         FGjQ==
X-Gm-Message-State: AOJu0Yx13snWrZlFnKBkqBcYD7lj6yTStdbPBhEy5Vfftiwtf4VEzjLW
        3yrOUhBXd7LZdeYxuxTmzCGRiO+eVD8N4Q==
X-Google-Smtp-Source: AGHT+IEvMNKC9nbOPdNH0MpwacZ1W5yim9tzJ3jmaWBCgy8j2Ymj3G4B/81eTM2oS9aGwSKd1XhK1g==
X-Received: by 2002:a0d:ca02:0:b0:589:a4c6:a4ed with SMTP id m2-20020a0dca02000000b00589a4c6a4edmr5299641ywd.3.1696510669479;
        Thu, 05 Oct 2023 05:57:49 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id g68-20020a0df647000000b0059b2be24f88sm480277ywf.143.2023.10.05.05.57.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 05:57:49 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-59f4db9e11eso10293417b3.0;
        Thu, 05 Oct 2023 05:57:49 -0700 (PDT)
X-Received: by 2002:a81:d513:0:b0:59a:d42c:5d50 with SMTP id
 i19-20020a81d513000000b0059ad42c5d50mr5391255ywj.52.1696510668676; Thu, 05
 Oct 2023 05:57:48 -0700 (PDT)
MIME-Version: 1.0
References: <20231004150856.2540-1-jszhang@kernel.org>
In-Reply-To: <20231004150856.2540-1-jszhang@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 5 Oct 2023 14:57:36 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVfnn2YiorGQeVqa7cQmXVDQhiqoY6dSktA6myuE6LRsw@mail.gmail.com>
Message-ID: <CAMuHMdVfnn2YiorGQeVqa7cQmXVDQhiqoY6dSktA6myuE6LRsw@mail.gmail.com>
Subject: Re: [PATCH] soc: renesas: make ARCH_R9A07G043 (riscv version) depend
 on NONPORTABLE
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
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
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 4, 2023 at 5:21 PM Jisheng Zhang <jszhang@kernel.org> wrote:
> Drew found "CONFIG_DMA_GLOBAL_POOL=y causes ADMA buffer alloc to fail"
> the log looks like:
> [    3.741083] mmc0: Unable to allocate ADMA buffers - falling back to standard DMA
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
> Fixes: 484861e09f3e ("soc: renesas: Kconfig: Select the required configs for RZ/Five SoC")
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
I guess this is the right thing to do until a better solution is found.
I.e. will queue in renesas-fixes for v6.6.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
