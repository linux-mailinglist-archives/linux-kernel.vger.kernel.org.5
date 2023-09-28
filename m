Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7187B1B50
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 13:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjI1Lmg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 28 Sep 2023 07:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbjI1Lme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:42:34 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9087CBF;
        Thu, 28 Sep 2023 04:42:32 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5a22eaafd72so3500917b3.3;
        Thu, 28 Sep 2023 04:42:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695901351; x=1696506151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P126arM5ynAe8A5WRmgE6i+j3G1VPUvbv1KSB/lujvw=;
        b=U9Tsw9I+/hJAHiwX5rJP7tfL8mP4bEdpdd/wK8AWvfjcxWcLnXbndgCJTiVbOU9EfH
         kNTJS3vHimopWW/B30GuvIgotb3+ELtw0UE1C4tBz54awoLkAWHNJGPLJyMraA7Z2lsF
         f9LpafrzNOGDYYTSa+3mv0yzRg3Ugl4gopglFU4E7dJCiA3OQFkv23vcKQVFqUWHbzeo
         iQcdvP1nNmN9Q8ab4IFHKnGiwFfn3cSB7D3MJ3LxPTzASiNPOUOCqQ+FPCXWAhJoIRUn
         yiYU5ubVty5uGA25y0WGISS5h5SALMIC4KLbt23GXwEEukmH/VKilB6WDrtQ/2Woyzm/
         E4kQ==
X-Gm-Message-State: AOJu0YyItzA+XP94Zm7Ly2eZaqfOBvJjTdTSca98gqUdMjXShoatfqg8
        kKKzGZZDFKGneIpHA2YfmD9RA1wPpLzklQ==
X-Google-Smtp-Source: AGHT+IHNbZvCK0c0fmSWnYmtO+xansmq/ubt2bkNf+ZT7ysUMByM/p9n3U4/t+JPdM2X8RogS7QJlQ==
X-Received: by 2002:a81:a0d2:0:b0:57a:9b2c:51f1 with SMTP id x201-20020a81a0d2000000b0057a9b2c51f1mr893964ywg.1.1695901351437;
        Thu, 28 Sep 2023 04:42:31 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id m131-20020a817189000000b005a1f7231cf5sm1236375ywc.142.2023.09.28.04.42.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 04:42:30 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-d8673a90f56so11098073276.0;
        Thu, 28 Sep 2023 04:42:30 -0700 (PDT)
X-Received: by 2002:a25:e00a:0:b0:d86:357:e314 with SMTP id
 x10-20020a25e00a000000b00d860357e314mr805399ybg.47.1695901349832; Thu, 28 Sep
 2023 04:42:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230928104520.24768-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230928104520.24768-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 28 Sep 2023 13:42:15 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUCc=M0khCyipEBFF+52OvgFQD4bOw=+bo564DvQZTUKA@mail.gmail.com>
Message-ID: <CAMuHMdUCc=M0khCyipEBFF+52OvgFQD4bOw=+bo564DvQZTUKA@mail.gmail.com>
Subject: Re: [PATCH] clocksource/drivers/riscv: Increase the clock_event rating
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        Anup Patel <anup@brainfault.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Conor Dooley <conor.dooley@microchip.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 12:45 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Renesas RZ/Five SoC has OSTM blocks which can be used for clock_event and
> clocksource [0]. The clock_event rating for the OSTM is set 300 but
> whereas the rating for riscv-timer clock_event is set to 100 due to which
> the kernel is choosing OSTM for clock_event.
>
> As riscv-timer is much more efficient than MMIO clock_event, increase the
> rating to 400 so that the kernel prefers riscv-timer over the MMIO based
> clock_event.
>
> [0] drivers/clocksource/renesas-ostm.c
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> Note, Ive set the rating similar to RISC-V clocksource, on ARM architecture
> the rating for clk_event is set to 450.

Makes sense.
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
