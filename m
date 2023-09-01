Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2573378FC95
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 13:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349316AbjIALpM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 1 Sep 2023 07:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349258AbjIALov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 07:44:51 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726B21710;
        Fri,  1 Sep 2023 04:44:14 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-58d31f142eeso19862417b3.0;
        Fri, 01 Sep 2023 04:44:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693568653; x=1694173453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v35D4R/YcbC9ox5KrmWaaZLOPC4k8bfMeoxv1sATsyI=;
        b=aVSJb/D7U2INKZzgOkSRGf31uI88OHwDvgmuMcWtCMcevDVskXlwjzdyWij95g61zK
         /cfIeFGqVdvCIOh9wYynYEMmf7l4ngjMKvWZR+z+VmTdXTwZ9dht46TS13yqroYXAuZz
         EPMjGDbnkBI7aShl9yZEPubw2i9mCNFA7zdUxTX3f/QEDFb2PWBvwhAVndpSUCAl9hGW
         W6sKXkejfQZ7S/wir4rtoEtSumS5TiQCzEHuLXPm2nx2pjLAqsRWowiXmNoH86ZVwe3w
         XeFZ/joXEMPSgfPO7hrjasSqHBYswM/LDvcxasxS/JS5QXs0tlsDPbfj+YtBwNMyGqr/
         sJxA==
X-Gm-Message-State: AOJu0Yy1V9V/Kf/rQ8LBvD8Bpka4kIq1AM8JGVe1qTsEcgz6a3bN9dmD
        0LGrAJyyeogBeqe86xzo0zeEBVMd5yww/w==
X-Google-Smtp-Source: AGHT+IH1Ncjju2N/+NTl/tPU19E794VFJcppizWENjnEAn4SmM8ZVVRLRsTcSgkuCUJoxzr4d0VgHQ==
X-Received: by 2002:a0d:dd08:0:b0:58a:1326:cb85 with SMTP id g8-20020a0ddd08000000b0058a1326cb85mr2689584ywe.40.1693568653478;
        Fri, 01 Sep 2023 04:44:13 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id t76-20020a0dea4f000000b005922c29c025sm988585ywe.108.2023.09.01.04.44.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 04:44:13 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-d7e6d9665bcso698871276.1;
        Fri, 01 Sep 2023 04:44:13 -0700 (PDT)
X-Received: by 2002:a25:a2d2:0:b0:d07:60bd:89f4 with SMTP id
 c18-20020a25a2d2000000b00d0760bd89f4mr2418648ybn.37.1693568653078; Fri, 01
 Sep 2023 04:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230901110936.313171-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230901110936.313171-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 1 Sep 2023 13:44:01 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUyiWOdXtGR8o4kKOyYV8JwoPN-FvMBxYmcRoKLAdu3PQ@mail.gmail.com>
Message-ID: <CAMuHMdUyiWOdXtGR8o4kKOyYV8JwoPN-FvMBxYmcRoKLAdu3PQ@mail.gmail.com>
Subject: Re: [PATCH] soc: renesas: Kconfig: For ARCH_R9A07G043 select the
 required configs if dependencies are met
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Fri, Sep 1, 2023 at 1:10 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> To prevent randconfig build issues when enabling the RZ/Five SoC, consider
> selecting specific configurations only when their dependencies are
> satisfied.

Thanks for your patch!

> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202308311610.ec6bm2G8-lkp@intel.com/
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Fixes: ed1a8872ff839de0 ("soc: renesas: Kconfig: Select the required
configs for RZ/Five SoC")

> --- a/drivers/soc/renesas/Kconfig
> +++ b/drivers/soc/renesas/Kconfig
> @@ -334,10 +334,11 @@ if RISCV
>  config ARCH_R9A07G043
>         bool "RISC-V Platform support for RZ/Five"
>         select ARCH_RZG2L
> -       select AX45MP_L2_CACHE
> +       select AX45MP_L2_CACHE if RISCV_DMA_NONCOHERENT
>         select DMA_GLOBAL_POOL
> -       select ERRATA_ANDES
> -       select ERRATA_ANDES_CMO
> +       select ERRATA_ANDES if RISCV_SBI
> +       select ERRATA_ANDES_CMO if ERRATA_ANDES
> +
>         help
>           This enables support for the Renesas RZ/Five SoC.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

As the offending commit won't be in my tree until v6.6-rc1, I cannot
take it now, and risc/for-next sounds like the best target.
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
