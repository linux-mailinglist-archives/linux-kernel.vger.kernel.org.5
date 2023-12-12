Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090F080E5B4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 09:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345999AbjLLITm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Dec 2023 03:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjLLITj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 03:19:39 -0500
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C823CD;
        Tue, 12 Dec 2023 00:19:46 -0800 (PST)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5d74186170fso47827097b3.3;
        Tue, 12 Dec 2023 00:19:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702369185; x=1702973985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jz85Z8XdgQqhlQatAV59mgkpmbeo3/1i+Ku2kekUiYM=;
        b=AE0WlbLx2nt/VQ6AVzeKqmw5eKqSs4eIuuLWUYJBqX6VSbHQwgJdisT34N1j+eV2LY
         4WeK/l9p5V4F9WT+8XaOHE1HJhS8qHat0nqqX5oiUYaE+uEm2Edv3UuY3dBgSkuv4nw0
         EgzCtZHWrU9Yed+nf23Fzi9QXA9OHnDm7UhI1tcADF8VNqcDdFE8NrZ3ofxIB3jZxyXx
         th1hWG3Co1NAnHjbqxATjBbFm4yvSZvZA8nsx8sXlkwHNGytox3I5eCjsWmX7ySmysIB
         /+rQdKQZf2E1xLoOGLql6IkIfKWQZU5yO5HTt57LcQkB6wnGE2PvNMAOW5IQQzd1llmO
         nNaQ==
X-Gm-Message-State: AOJu0YxPqPFO63y8i+nDzxmeNtHWh/wIpQo/fG4bXqA5WI3/2Oqxk5xM
        bWGdFgFBZzzd+NcCff8CKoosoe9c0H/gqQ==
X-Google-Smtp-Source: AGHT+IG/nJUd5A/IT+XaxgFsazX9RuXKRifXnK6FA0+MllAXtWmP18OaMJDSAsJL2DxaU/AdBbsROw==
X-Received: by 2002:a25:cf13:0:b0:db7:dacf:3fa3 with SMTP id f19-20020a25cf13000000b00db7dacf3fa3mr2945250ybg.80.1702369185493;
        Tue, 12 Dec 2023 00:19:45 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id g11-20020a25200b000000b00d7745e2bb19sm3113654ybg.29.2023.12.12.00.19.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 00:19:45 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dbc72b692adso2337390276.2;
        Tue, 12 Dec 2023 00:19:44 -0800 (PST)
X-Received: by 2002:a5b:792:0:b0:da0:ccd6:b8a2 with SMTP id
 b18-20020a5b0792000000b00da0ccd6b8a2mr3073704ybq.19.1702369184206; Tue, 12
 Dec 2023 00:19:44 -0800 (PST)
MIME-Version: 1.0
References: <20231211-primate-arbitrate-fbcd307a0b00@spud>
In-Reply-To: <20231211-primate-arbitrate-fbcd307a0b00@spud>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Dec 2023 09:19:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX0bETuMoZCZM7pAodbwyf0ttZMpKuq0ibBZX7S-YV8xw@mail.gmail.com>
Message-ID: <CAMuHMdX0bETuMoZCZM7pAodbwyf0ttZMpKuq0ibBZX7S-YV8xw@mail.gmail.com>
Subject: Re: [PATCH v1] soc: renesas: make ARCH_R9A07G043 depend on !DMA_DIRECT_REMAP
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-riscv@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Mon, Dec 11, 2023 at 11:06 PM Conor Dooley <conor@kernel.org> wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>
> Randy reported yet another build issue with randconfigs on rv32:
> WARNING: unmet direct dependencies detected for DMA_GLOBAL_POOL
>   Depends on [n]: !ARCH_HAS_DMA_SET_UNCACHED [=n] && !DMA_DIRECT_REMAP [=y]
>   Selected by [y]:
>   - ARCH_R9A07G043 [=y] && SOC_RENESAS [=y] && RISCV [=y] && NONPORTABLE [=y] && RISCV_ALTERNATIVE [=y] && !RISCV_ISA_ZICBOM [=n] && RISCV_SBI [=y]
>
> This happens when DMA_DIRECT_REMAP is selected by the T-Head CMO erratum

or by the Zicbom extension support?

> option and DMA_GLOBAL_POOL is selected by the Andes CMO erratum. Block
> selecting the RZ/Five config option, and by extension DMA_GLOBAL_POOL,
> if DMA_DIRECT_REMAP has already been enabled.
>
> Fixes: 484861e09f3e ("soc: renesas: Kconfig: Select the required configs for RZ/Five SoC")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
> Closes: https://lore.kernel.org/all/24942b4d-d16a-463f-b39a-f9dfcb89d742@infradead.org/
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.8.

Or should this be queued as a fix for v6.7 instead?

> ---
> I don't know what the exact fixes tag here is as I did not bisect with
> the randconfig, so I blamed the one that added DMA_GLOBAL_POOL.

Bisection leads to commit da323d4640704001 ("dma-direct: add
dependencies to CONFIG_DMA_GLOBAL_POOL") in v6.7-rc1, but that is
merely making visible the symptoms, so I think your Fixes tag is fine.

Esmil: I think you need a similar fix for ERRATA_STARFIVE_JH7100 in
your tree.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
