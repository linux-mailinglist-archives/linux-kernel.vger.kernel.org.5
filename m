Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1EA7FF739
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345816AbjK3Qyv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 30 Nov 2023 11:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345771AbjK3Qyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:54:49 -0500
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1D610F2;
        Thu, 30 Nov 2023 08:54:55 -0800 (PST)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-58ceabd7cdeso632081eaf.3;
        Thu, 30 Nov 2023 08:54:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701363294; x=1701968094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ExIG6L5bm/zoN5KK5bT+DV3TV+i14K4ySOYvxYXP+d8=;
        b=AYeVc71R1ICDkXUc1cA2PU3LF1APiUhFxCCNZak+wu+onkZBYsoi1m0rIwEtRAb/gx
         dOKSHA8ROLcAhlGaq0yFe80AdYGWyFvvKxnbA5YJCUGNJlSDiU7fMTchTelXYkYuGquT
         GgrHkRmeWkqh/rFYMiuuR06vnExYTq6q+vtFcJ9ure0tsO8rws3Z7rykiD09XIvBe/Pg
         VmDcEPTPIivwYPIQWKeIetFQTHVm8iqyD0/kdrgvEGNqcPMl3VyKmzDeaoQrVnJ5rnWo
         Q2oMl6ftxLnTJcpRUxEFCl8h93tgnPrr7GuSgQugdOmoEJF8Qr6QrKZwU8nlp2kmGFTQ
         hXdQ==
X-Gm-Message-State: AOJu0Yy/ilKxWYrRpLKrgv7U+jaYxUkRq+RX0PEuGFhxyPo4WOoHOWrT
        N2cnvb3JjhTinCRF9tD4sS/1ecbDJFaqkw==
X-Google-Smtp-Source: AGHT+IFyS9MuT4OBB+9qD/dQvBySBy+ouV5IjbgEJyTSRLSfoDeMX7GLrAptBuREXv3WYddSTguAlA==
X-Received: by 2002:a05:6820:2207:b0:58d:8bda:d480 with SMTP id cj7-20020a056820220700b0058d8bdad480mr56214oob.8.1701363294476;
        Thu, 30 Nov 2023 08:54:54 -0800 (PST)
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com. [209.85.161.42])
        by smtp.gmail.com with ESMTPSA id k29-20020a4a851d000000b0058cbbf9b4e4sm241101ooh.48.2023.11.30.08.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 08:54:54 -0800 (PST)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-58ceabd7cdeso632073eaf.3;
        Thu, 30 Nov 2023 08:54:54 -0800 (PST)
X-Received: by 2002:a05:6358:3102:b0:16d:fb6c:e65e with SMTP id
 c2-20020a056358310200b0016dfb6ce65emr22949188rwe.7.1701363293982; Thu, 30 Nov
 2023 08:54:53 -0800 (PST)
MIME-Version: 1.0
References: <20231130125606.64931-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdWd3XY8r-Db_JgazCin_xgSmTGttKzAaHGRKAXsM5xJOQ@mail.gmail.com>
 <CA+V-a8uKCfdOXVQ6cEPQfXFdrJQT_NDztt=++o95AQEAeM9GGg@mail.gmail.com>
 <CAMuHMdVXDBP=rXiaQPFNPzCEY1QrzS5W2wm9=NtkWSwO4_8y2g@mail.gmail.com> <CA+V-a8shubctjQrg4DP-4RVAPg-TOn-twWeg5bL+M2JDsMGBbw@mail.gmail.com>
In-Reply-To: <CA+V-a8shubctjQrg4DP-4RVAPg-TOn-twWeg5bL+M2JDsMGBbw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 30 Nov 2023 17:54:42 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVaybxXhPu0Od=A8YLR4JpgN4fV=Win==Etg1N8c+r4jA@mail.gmail.com>
Message-ID: <CAMuHMdVaybxXhPu0Od=A8YLR4JpgN4fV=Win==Etg1N8c+r4jA@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: errata: andes: Probe for IOCP only once in boot stage
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Yu Chien Peter Lin <peterlin@andestech.com>,
        Samuel Holland <samuel.holland@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Thu, Nov 30, 2023 at 5:50 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Thu, Nov 30, 2023 at 4:26 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Thu, Nov 30, 2023 at 5:23 PM Lad, Prabhakar
> > <prabhakar.csengg@gmail.com> wrote:
> > > On Thu, Nov 30, 2023 at 2:34 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > On Thu, Nov 30, 2023 at 1:56 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > >
> > > > > We need to probe for IOCP only once during boot stage, as we were probing
> > > > > for IOCP for all the stages this caused the below issue during module-init
> > > > > stage,
> > > > >
> > > > > [9.019104] Unable to handle kernel paging request at virtual address ffffffff8100d3a0
> > > > > [9.027153] Oops [#1]
> > > > > [9.029421] Modules linked in: rcar_canfd renesas_usbhs i2c_riic can_dev spi_rspi i2c_core
> > > > > [9.037686] CPU: 0 PID: 90 Comm: udevd Not tainted 6.7.0-rc1+ #57
> > > > > [9.043756] Hardware name: Renesas SMARC EVK based on r9a07g043f01 (DT)
> > > > > [9.050339] epc : riscv_noncoherent_supported+0x10/0x3e
> > > > > [9.055558]  ra : andes_errata_patch_func+0x4a/0x52
> > > > > [9.060418] epc : ffffffff8000d8c2 ra : ffffffff8000d95c sp : ffffffc8003abb00
> > > > > [9.067607]  gp : ffffffff814e25a0 tp : ffffffd80361e540 t0 : 0000000000000000
> > > > > [9.074795]  t1 : 000000000900031e t2 : 0000000000000001 s0 : ffffffc8003abb20
> > > > > [9.081984]  s1 : ffffffff015b57c7 a0 : 0000000000000000 a1 : 0000000000000001
> > > > > [9.089172]  a2 : 0000000000000000 a3 : 0000000000000000 a4 : ffffffff8100d8be
> > > > > [9.096360]  a5 : 0000000000000001 a6 : 0000000000000001 a7 : 000000000900031e
> > > > > [9.103548]  s2 : ffffffff015b57d7 s3 : 0000000000000001 s4 : 000000000000031e
> > > > > [9.110736]  s5 : 8000000000008a45 s6 : 0000000000000500 s7 : 000000000000003f
> > > > > [9.117924]  s8 : ffffffc8003abd48 s9 : ffffffff015b1140 s10: ffffffff8151a1b0
> > > > > [9.125113]  s11: ffffffff015b1000 t3 : 0000000000000001 t4 : fefefefefefefeff
> > > > > [9.132301]  t5 : ffffffff015b57c7 t6 : ffffffd8b63a6000
> > > > > [9.137587] status: 0000000200000120 badaddr: ffffffff8100d3a0 cause: 000000000000000f
> > > > > [9.145468] [<ffffffff8000d8c2>] riscv_noncoherent_supported+0x10/0x3e
> > > > > [9.151972] [<ffffffff800027e8>] _apply_alternatives+0x84/0x86
> > > > > [9.157784] [<ffffffff800029be>] apply_module_alternatives+0x10/0x1a
> > > > > [9.164113] [<ffffffff80008fcc>] module_finalize+0x5e/0x7a
> > > > > [9.169583] [<ffffffff80085cd6>] load_module+0xfd8/0x179c
> > > > > [9.174965] [<ffffffff80086630>] init_module_from_file+0x76/0xaa
> > > > > [9.180948] [<ffffffff800867f6>] __riscv_sys_finit_module+0x176/0x2a8
> > > > > [9.187365] [<ffffffff80889862>] do_trap_ecall_u+0xbe/0x130
> > > > > [9.192922] [<ffffffff808920bc>] ret_from_exception+0x0/0x64
> > > > > [9.198573] Code: 0009 b7e9 6797 014d a783 85a7 c799 4785 0717 0100 (0123) aef7
> > > > > [9.205994] ---[ end trace 0000000000000000 ]---
> > > > >
> > > > > This is because we called riscv_noncoherent_supported() for all the stages
> > > > > during IOCP probe. riscv_noncoherent_supported() function sets
> > > > > noncoherent_supported variable to true which has an annotation set to
> > > > > "__ro_after_init" due to which we were seeing the above splat. Fix this by
> > > > > probing for IOCP only once in boot stage by having a boolean variable
> > > > > is_iocp_probe_done which will be set to true upon IOCP probe in
> > > > > errata_probe_iocp() and we bail out early if is_iocp_probe_done is set.
> > > > >
> > > > > While at it make return type of errata_probe_iocp() to void as we were
> > > > > not checking the return value in andes_errata_patch_func().
> > > > >
> > > > > Fixes: e021ae7f5145 ("riscv: errata: Add Andes alternative ports")
> > > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > ---
> > > > > v1->v2
> > > > > * As RISCV_ALTERNATIVES_BOOT stage can happen twice add a is_iocp_probe_done
> > > > >   variable to probe for IOCP only once.
> > > > > * Updated commit message
> > > > > * Make return value of errata_probe_iocp() to void
> > > >
> > > > Thanks for the update!
> > > >
> > > > > --- a/arch/riscv/errata/andes/errata.c
> > > > > +++ b/arch/riscv/errata/andes/errata.c
> > > > > @@ -38,29 +38,36 @@ static long ax45mp_iocp_sw_workaround(void)
> > > > >         return ret.error ? 0 : ret.value;
> > > > >  }
> > > > >
> > > > > -static bool errata_probe_iocp(unsigned int stage, unsigned long arch_id, unsigned long impid)
> > > > > +static void errata_probe_iocp(unsigned int stage, unsigned long arch_id, unsigned long impid)
> > > > >  {
> > > > > +       static bool is_iocp_probe_done;
> > > >
> > > > done?
> > > >
> > > OK I'll rename it to "done".
> > >
> > > > > +
> > > > >         if (!IS_ENABLED(CONFIG_ERRATA_ANDES_CMO))
> > > > > -               return false;
> > > > > +               return;
> > > > > +
> > > > > +       if (is_iocp_probe_done)
> > > > > +               return;
> > > > >
> > > >
> > > > Why not keep it simple, and just do
> > > >
> > > >     done = true;
> > > >
> > > OK.
> > >
> > > > here?
> > > > Can arch_id or impid suddenly change, so you have to recheck?
> > > I only check arch_id and impid here. Are you suggesting I drop it?
> >
> > No, I do not suggest to drop it.
> > I suggested moving the "done = true" up, so the check is done only once.
> >
> OK, I'll have something like below:
>
> static void errata_probe_iocp(unsigned int stage, unsigned long
> arch_id, unsigned long impid)
> {
>     static bool done;
>
>     if (!IS_ENABLED(CONFIG_ERRATA_ANDES_CMO))
>         return;
>
>     if (done)
>         return;
>
>     if (arch_id != ANDES_AX45MP_MARCHID || impid != ANDES_AX45MP_MIMPID)
>         return;

Please move this check below "done = true", as there is no need to
execute this check multiple times.

>     done = true;
>
>     if (!ax45mp_iocp_sw_workaround())
>         return;
>
>     /* Set this just to make core cbo code happy */
>     riscv_cbom_block_size = 1;
>     riscv_noncoherent_supported();
> }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
