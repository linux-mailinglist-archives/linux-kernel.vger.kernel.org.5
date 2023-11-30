Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8307FF4CB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbjK3QXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjK3QXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:23:18 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401C2196;
        Thu, 30 Nov 2023 08:23:24 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-7c461a8cb0dso338560241.0;
        Thu, 30 Nov 2023 08:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701361403; x=1701966203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Rz1SfkoBLt1wzKfSCUoXy9avUjy1X29wSOetvydD2A=;
        b=MEqvCscYI2CGaNvi8Xyyb2spUF1pXVrX4EGdYlHdPj/e7LR10qcYjk80dCoyr/+JbL
         9339rXgjV+APtV1JqJOp7G2iEFjMw4CwR5lk/GZ4eFnN3v+l8H9GZq3zl11mhyFaEdra
         iEneBl0lM4geKJFhfJDNnNdF24gnwkOynXy8l9mFuuNPZAvHevziblM0Ercxi7oeIzRE
         zR+6ghLdPxil05su9CVkYcZlGRt670E2mVXsij7g2RoST+Tu1qttN8VEgkZa7ElUxur5
         UEb9F6jseTgbAUx8w+Ps99qumms6lTYsmaQ9frNeQRiZqXwhcQVQY5rOjVhKlUJbmSC0
         dMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701361403; x=1701966203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Rz1SfkoBLt1wzKfSCUoXy9avUjy1X29wSOetvydD2A=;
        b=KGLBRnn/z8gzoEmeZfsOqGdKU/K+2ab4kALBA1T48dz/AHNeR8vMheMO2WUy05FwjC
         HAlq9dplf7YHkKc2bpuG99heJcXMlceEdwo+LSKW6pvxVCynFvKVcjWmVxtKVv6+ZV7i
         0/RQ7W6ARKAvsTb78KhE0PwOpvOiSvAwAIdN3rs6blwceLSaTmcOGlb3GsyLR4Hq8Egl
         WK4Leq/ChQq2yn7BUayiN/E8DqqWLNA2BOeQtEveHEnJ8Y1YjHLosZTuhuk+lOZW5h08
         bjtd+V7IaBQhfXiiZPQl+yNcQ7FLIwT9lvzvtG7bynu2Yj3Nzc1cSoF9fgQz3S+Ip+NX
         eW3Q==
X-Gm-Message-State: AOJu0Yxq3XP/pp6kmy6ldGg2GOVv2qTKc4FdfJz1CXL8nrW+owbnRa6C
        g5tZhIvpb1ONh9LDw86kqmGAL8udMjxiv8XQtRM=
X-Google-Smtp-Source: AGHT+IEeLnCxqQ7A3j/755SDmM5BlKzV7pAi/QkjP/SQBY+0Bp1bz64n5BIgfrQ4BicLBjnC7HYNorOLEhX1IY8dU4M=
X-Received: by 2002:a05:6122:2528:b0:49b:289a:cc44 with SMTP id
 cl40-20020a056122252800b0049b289acc44mr20528331vkb.6.1701361403215; Thu, 30
 Nov 2023 08:23:23 -0800 (PST)
MIME-Version: 1.0
References: <20231130125606.64931-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdWd3XY8r-Db_JgazCin_xgSmTGttKzAaHGRKAXsM5xJOQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWd3XY8r-Db_JgazCin_xgSmTGttKzAaHGRKAXsM5xJOQ@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 30 Nov 2023 16:22:56 +0000
Message-ID: <CA+V-a8uKCfdOXVQ6cEPQfXFdrJQT_NDztt=++o95AQEAeM9GGg@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: errata: andes: Probe for IOCP only once in boot stage
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Yu Chien Peter Lin <peterlin@andestech.com>,
        Samuel Holland <samuel.holland@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thank you for the review.

On Thu, Nov 30, 2023 at 2:34=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Prabhakar,
>
> On Thu, Nov 30, 2023 at 1:56=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail=
.com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > We need to probe for IOCP only once during boot stage, as we were probi=
ng
> > for IOCP for all the stages this caused the below issue during module-i=
nit
> > stage,
> >
> > [9.019104] Unable to handle kernel paging request at virtual address ff=
ffffff8100d3a0
> > [9.027153] Oops [#1]
> > [9.029421] Modules linked in: rcar_canfd renesas_usbhs i2c_riic can_dev=
 spi_rspi i2c_core
> > [9.037686] CPU: 0 PID: 90 Comm: udevd Not tainted 6.7.0-rc1+ #57
> > [9.043756] Hardware name: Renesas SMARC EVK based on r9a07g043f01 (DT)
> > [9.050339] epc : riscv_noncoherent_supported+0x10/0x3e
> > [9.055558]  ra : andes_errata_patch_func+0x4a/0x52
> > [9.060418] epc : ffffffff8000d8c2 ra : ffffffff8000d95c sp : ffffffc800=
3abb00
> > [9.067607]  gp : ffffffff814e25a0 tp : ffffffd80361e540 t0 : 0000000000=
000000
> > [9.074795]  t1 : 000000000900031e t2 : 0000000000000001 s0 : ffffffc800=
3abb20
> > [9.081984]  s1 : ffffffff015b57c7 a0 : 0000000000000000 a1 : 0000000000=
000001
> > [9.089172]  a2 : 0000000000000000 a3 : 0000000000000000 a4 : ffffffff81=
00d8be
> > [9.096360]  a5 : 0000000000000001 a6 : 0000000000000001 a7 : 0000000009=
00031e
> > [9.103548]  s2 : ffffffff015b57d7 s3 : 0000000000000001 s4 : 0000000000=
00031e
> > [9.110736]  s5 : 8000000000008a45 s6 : 0000000000000500 s7 : 0000000000=
00003f
> > [9.117924]  s8 : ffffffc8003abd48 s9 : ffffffff015b1140 s10: ffffffff81=
51a1b0
> > [9.125113]  s11: ffffffff015b1000 t3 : 0000000000000001 t4 : fefefefefe=
fefeff
> > [9.132301]  t5 : ffffffff015b57c7 t6 : ffffffd8b63a6000
> > [9.137587] status: 0000000200000120 badaddr: ffffffff8100d3a0 cause: 00=
0000000000000f
> > [9.145468] [<ffffffff8000d8c2>] riscv_noncoherent_supported+0x10/0x3e
> > [9.151972] [<ffffffff800027e8>] _apply_alternatives+0x84/0x86
> > [9.157784] [<ffffffff800029be>] apply_module_alternatives+0x10/0x1a
> > [9.164113] [<ffffffff80008fcc>] module_finalize+0x5e/0x7a
> > [9.169583] [<ffffffff80085cd6>] load_module+0xfd8/0x179c
> > [9.174965] [<ffffffff80086630>] init_module_from_file+0x76/0xaa
> > [9.180948] [<ffffffff800867f6>] __riscv_sys_finit_module+0x176/0x2a8
> > [9.187365] [<ffffffff80889862>] do_trap_ecall_u+0xbe/0x130
> > [9.192922] [<ffffffff808920bc>] ret_from_exception+0x0/0x64
> > [9.198573] Code: 0009 b7e9 6797 014d a783 85a7 c799 4785 0717 0100 (012=
3) aef7
> > [9.205994] ---[ end trace 0000000000000000 ]---
> >
> > This is because we called riscv_noncoherent_supported() for all the sta=
ges
> > during IOCP probe. riscv_noncoherent_supported() function sets
> > noncoherent_supported variable to true which has an annotation set to
> > "__ro_after_init" due to which we were seeing the above splat. Fix this=
 by
> > probing for IOCP only once in boot stage by having a boolean variable
> > is_iocp_probe_done which will be set to true upon IOCP probe in
> > errata_probe_iocp() and we bail out early if is_iocp_probe_done is set.
> >
> > While at it make return type of errata_probe_iocp() to void as we were
> > not checking the return value in andes_errata_patch_func().
> >
> > Fixes: e021ae7f5145 ("riscv: errata: Add Andes alternative ports")
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v1->v2
> > * As RISCV_ALTERNATIVES_BOOT stage can happen twice add a is_iocp_probe=
_done
> >   variable to probe for IOCP only once.
> > * Updated commit message
> > * Make return value of errata_probe_iocp() to void
>
> Thanks for the update!
>
> > --- a/arch/riscv/errata/andes/errata.c
> > +++ b/arch/riscv/errata/andes/errata.c
> > @@ -38,29 +38,36 @@ static long ax45mp_iocp_sw_workaround(void)
> >         return ret.error ? 0 : ret.value;
> >  }
> >
> > -static bool errata_probe_iocp(unsigned int stage, unsigned long arch_i=
d, unsigned long impid)
> > +static void errata_probe_iocp(unsigned int stage, unsigned long arch_i=
d, unsigned long impid)
> >  {
> > +       static bool is_iocp_probe_done;
>
> done?
>
OK I'll rename it to "done".

> > +
> >         if (!IS_ENABLED(CONFIG_ERRATA_ANDES_CMO))
> > -               return false;
> > +               return;
> > +
> > +       if (is_iocp_probe_done)
> > +               return;
> >
>
> Why not keep it simple, and just do
>
>     done =3D true;
>
OK.

> here?
> Can arch_id or impid suddenly change, so you have to recheck?
I only check arch_id and impid here. Are you suggesting I drop it?

> If the SBI call in ax45mp_iocp_sw_workaround() fails, is there really
> a need to try it again later?
>
No if it fails we just continue with a broken system.

Cheers,
Prabhakar
> >         if (arch_id !=3D ANDESTECH_AX45MP_MARCHID || impid !=3D ANDESTE=
CH_AX45MP_MIMPID)
> > -               return false;
> > +               return;
> >
> > -       if (!ax45mp_iocp_sw_workaround())
> > -               return false;
> > +       if (!ax45mp_iocp_sw_workaround()) {
> > +               is_iocp_probe_done =3D true;
> > +               return;
> > +       }
> >
> >         /* Set this just to make core cbo code happy */
> >         riscv_cbom_block_size =3D 1;
> >         riscv_noncoherent_supported();
> > -
> > -       return true;
> > +       is_iocp_probe_done =3D true;
> >  }
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
