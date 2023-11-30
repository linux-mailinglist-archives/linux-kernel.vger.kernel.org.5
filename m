Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711CC7FF6FA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbjK3QuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbjK3QuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:50:17 -0500
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5CC10F9;
        Thu, 30 Nov 2023 08:50:23 -0800 (PST)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-4b2aa04591dso74409e0c.2;
        Thu, 30 Nov 2023 08:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701363022; x=1701967822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wr04NBHQv8NfEkXPvwegZkjN2M6ocLDH+/1oF32cCE=;
        b=nJCxXz4d7+CFM2u3VA+cEJ7zR6dWshx/BfDjIBr1M2wHmghjscOiGhBZ0olHabzmEr
         Gx2PJWmMOyCVMy79uWRj6+eYEjRhqpS+SGVOPQd6ISEcWVFqy0GFR+0sVY7HAO/b5LGj
         3YgM5aA0qkm0BMDHSS3we6ge4iS6YezpFHrT33JxHdymQnR9bKK2qsDj7S4MxfyIj/Cv
         Hvr/ns74NsE6MQ4Y2QbAdtfwbsBUvKZkNfP6MRqwAzIaTtT0YR7vkWEUSBj7J9uNVP87
         dIn80GW7F/wr0f7uKSGq68wjSzgiwdgIC9tdPow3z/5+1kxE3lOQb9bykgWDLDmia3Tk
         w7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701363022; x=1701967822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9wr04NBHQv8NfEkXPvwegZkjN2M6ocLDH+/1oF32cCE=;
        b=VuT+DW8bbyEkobhKrXVnkHzk85HxT1f/2/Rix3IOaRc/E6Ap5KwIk7I7U6tYVsuu9A
         tpa1qIcCKigVA9TuSYxQW8inJGVnSV0QoGAK8XWI07qhAjkmMm81jQgjUtmhG5/O+HKg
         Ox0Y5K+OQKweh+5F4DrK+3irZQSXD2tJJNKjF+2goDQ4vTqi7qPVH0KWKusWYwhOkvCq
         69uzV0zrTPcamRihM6RR5cZoPa79so0zzX4JRxduavFgSZaFTOvyggio5st/WjQqSnrs
         utVKSzX2s1MQJsmq4bj87yr82LxyyEskLgHg7eH0SqduGKGuM9r8bwBIGZM6LrtbDTW8
         VpZA==
X-Gm-Message-State: AOJu0YygKYSMO54OeD1dVNJbOWkEpaVzbghoK582wIwYMhJmokbDcryC
        m7RBgjpZwKS1SLgGTDJSRlCpFSyxOUqqMtVLr4A=
X-Google-Smtp-Source: AGHT+IHbKcsz5nt4ng19JOcE7vM4hQMbiy5gb4eiPUe1IlCAsC++XCLKLl4e79pRremO2E+EgiLkQpzVMhjg/0NHoeM=
X-Received: by 2002:a1f:c502:0:b0:4b2:87d3:4936 with SMTP id
 v2-20020a1fc502000000b004b287d34936mr6356645vkf.6.1701363022148; Thu, 30 Nov
 2023 08:50:22 -0800 (PST)
MIME-Version: 1.0
References: <20231130125606.64931-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdWd3XY8r-Db_JgazCin_xgSmTGttKzAaHGRKAXsM5xJOQ@mail.gmail.com>
 <CA+V-a8uKCfdOXVQ6cEPQfXFdrJQT_NDztt=++o95AQEAeM9GGg@mail.gmail.com> <CAMuHMdVXDBP=rXiaQPFNPzCEY1QrzS5W2wm9=NtkWSwO4_8y2g@mail.gmail.com>
In-Reply-To: <CAMuHMdVXDBP=rXiaQPFNPzCEY1QrzS5W2wm9=NtkWSwO4_8y2g@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 30 Nov 2023 16:49:31 +0000
Message-ID: <CA+V-a8shubctjQrg4DP-4RVAPg-TOn-twWeg5bL+M2JDsMGBbw@mail.gmail.com>
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

On Thu, Nov 30, 2023 at 4:26=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Prabhakar,
>
> On Thu, Nov 30, 2023 at 5:23=E2=80=AFPM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> > On Thu, Nov 30, 2023 at 2:34=E2=80=AFPM Geert Uytterhoeven <geert@linux=
-m68k.org> wrote:
> > > On Thu, Nov 30, 2023 at 1:56=E2=80=AFPM Prabhakar <prabhakar.csengg@g=
mail.com> wrote:
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > We need to probe for IOCP only once during boot stage, as we were p=
robing
> > > > for IOCP for all the stages this caused the below issue during modu=
le-init
> > > > stage,
> > > >
> > > > [9.019104] Unable to handle kernel paging request at virtual addres=
s ffffffff8100d3a0
> > > > [9.027153] Oops [#1]
> > > > [9.029421] Modules linked in: rcar_canfd renesas_usbhs i2c_riic can=
_dev spi_rspi i2c_core
> > > > [9.037686] CPU: 0 PID: 90 Comm: udevd Not tainted 6.7.0-rc1+ #57
> > > > [9.043756] Hardware name: Renesas SMARC EVK based on r9a07g043f01 (=
DT)
> > > > [9.050339] epc : riscv_noncoherent_supported+0x10/0x3e
> > > > [9.055558]  ra : andes_errata_patch_func+0x4a/0x52
> > > > [9.060418] epc : ffffffff8000d8c2 ra : ffffffff8000d95c sp : ffffff=
c8003abb00
> > > > [9.067607]  gp : ffffffff814e25a0 tp : ffffffd80361e540 t0 : 000000=
0000000000
> > > > [9.074795]  t1 : 000000000900031e t2 : 0000000000000001 s0 : ffffff=
c8003abb20
> > > > [9.081984]  s1 : ffffffff015b57c7 a0 : 0000000000000000 a1 : 000000=
0000000001
> > > > [9.089172]  a2 : 0000000000000000 a3 : 0000000000000000 a4 : ffffff=
ff8100d8be
> > > > [9.096360]  a5 : 0000000000000001 a6 : 0000000000000001 a7 : 000000=
000900031e
> > > > [9.103548]  s2 : ffffffff015b57d7 s3 : 0000000000000001 s4 : 000000=
000000031e
> > > > [9.110736]  s5 : 8000000000008a45 s6 : 0000000000000500 s7 : 000000=
000000003f
> > > > [9.117924]  s8 : ffffffc8003abd48 s9 : ffffffff015b1140 s10: ffffff=
ff8151a1b0
> > > > [9.125113]  s11: ffffffff015b1000 t3 : 0000000000000001 t4 : fefefe=
fefefefeff
> > > > [9.132301]  t5 : ffffffff015b57c7 t6 : ffffffd8b63a6000
> > > > [9.137587] status: 0000000200000120 badaddr: ffffffff8100d3a0 cause=
: 000000000000000f
> > > > [9.145468] [<ffffffff8000d8c2>] riscv_noncoherent_supported+0x10/0x=
3e
> > > > [9.151972] [<ffffffff800027e8>] _apply_alternatives+0x84/0x86
> > > > [9.157784] [<ffffffff800029be>] apply_module_alternatives+0x10/0x1a
> > > > [9.164113] [<ffffffff80008fcc>] module_finalize+0x5e/0x7a
> > > > [9.169583] [<ffffffff80085cd6>] load_module+0xfd8/0x179c
> > > > [9.174965] [<ffffffff80086630>] init_module_from_file+0x76/0xaa
> > > > [9.180948] [<ffffffff800867f6>] __riscv_sys_finit_module+0x176/0x2a=
8
> > > > [9.187365] [<ffffffff80889862>] do_trap_ecall_u+0xbe/0x130
> > > > [9.192922] [<ffffffff808920bc>] ret_from_exception+0x0/0x64
> > > > [9.198573] Code: 0009 b7e9 6797 014d a783 85a7 c799 4785 0717 0100 =
(0123) aef7
> > > > [9.205994] ---[ end trace 0000000000000000 ]---
> > > >
> > > > This is because we called riscv_noncoherent_supported() for all the=
 stages
> > > > during IOCP probe. riscv_noncoherent_supported() function sets
> > > > noncoherent_supported variable to true which has an annotation set =
to
> > > > "__ro_after_init" due to which we were seeing the above splat. Fix =
this by
> > > > probing for IOCP only once in boot stage by having a boolean variab=
le
> > > > is_iocp_probe_done which will be set to true upon IOCP probe in
> > > > errata_probe_iocp() and we bail out early if is_iocp_probe_done is =
set.
> > > >
> > > > While at it make return type of errata_probe_iocp() to void as we w=
ere
> > > > not checking the return value in andes_errata_patch_func().
> > > >
> > > > Fixes: e021ae7f5145 ("riscv: errata: Add Andes alternative ports")
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.c=
om>
> > > > ---
> > > > v1->v2
> > > > * As RISCV_ALTERNATIVES_BOOT stage can happen twice add a is_iocp_p=
robe_done
> > > >   variable to probe for IOCP only once.
> > > > * Updated commit message
> > > > * Make return value of errata_probe_iocp() to void
> > >
> > > Thanks for the update!
> > >
> > > > --- a/arch/riscv/errata/andes/errata.c
> > > > +++ b/arch/riscv/errata/andes/errata.c
> > > > @@ -38,29 +38,36 @@ static long ax45mp_iocp_sw_workaround(void)
> > > >         return ret.error ? 0 : ret.value;
> > > >  }
> > > >
> > > > -static bool errata_probe_iocp(unsigned int stage, unsigned long ar=
ch_id, unsigned long impid)
> > > > +static void errata_probe_iocp(unsigned int stage, unsigned long ar=
ch_id, unsigned long impid)
> > > >  {
> > > > +       static bool is_iocp_probe_done;
> > >
> > > done?
> > >
> > OK I'll rename it to "done".
> >
> > > > +
> > > >         if (!IS_ENABLED(CONFIG_ERRATA_ANDES_CMO))
> > > > -               return false;
> > > > +               return;
> > > > +
> > > > +       if (is_iocp_probe_done)
> > > > +               return;
> > > >
> > >
> > > Why not keep it simple, and just do
> > >
> > >     done =3D true;
> > >
> > OK.
> >
> > > here?
> > > Can arch_id or impid suddenly change, so you have to recheck?
> > I only check arch_id and impid here. Are you suggesting I drop it?
>
> No, I do not suggest to drop it.
> I suggested moving the "done =3D true" up, so the check is done only once=
.
>
OK, I'll have something like below:

static void errata_probe_iocp(unsigned int stage, unsigned long
arch_id, unsigned long impid)
{
    static bool done;

    if (!IS_ENABLED(CONFIG_ERRATA_ANDES_CMO))
        return;

    if (done)
        return;

    if (arch_id !=3D ANDES_AX45MP_MARCHID || impid !=3D ANDES_AX45MP_MIMPID=
)
        return;

    done =3D true;

    if (!ax45mp_iocp_sw_workaround())
        return;

    /* Set this just to make core cbo code happy */
    riscv_cbom_block_size =3D 1;
    riscv_noncoherent_supported();
}

Cheers,
Prabhakar
