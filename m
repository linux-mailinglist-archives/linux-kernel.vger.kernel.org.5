Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8617F4276
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343602AbjKVJqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235323AbjKVJqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:46:17 -0500
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E82010F5;
        Wed, 22 Nov 2023 01:45:31 -0800 (PST)
Received: by mail-vk1-xa2b.google.com with SMTP id 71dfb90a1353d-4afe5fc8ad7so1441174e0c.3;
        Wed, 22 Nov 2023 01:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700646330; x=1701251130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEK1gvF+0yh3uLtMdCKIrrASVh3jVfs8UswMA/3tWPg=;
        b=lcWBegU1t58X507D5ZaRljuYHlpcUfaFtA+VCfs0fnsT4YODL7Av5BkeBxY5NI143X
         JxUCYU+Z0AX9Fjc6LaD07UFPJkikiieZOJYqdmjb1GBJW3DxFqNydgbY47x/9eM4sUBe
         LyKtlibsmLOo1JQeDGZ01E0cocxgSuY3pZc+bGwtDc/al6zWMg2MW9mZtxMuxq/8K3jj
         24t7/nvDzGdElp8v5+V7jKVG3HkpeukbWIAEflGkVXS471stEm34FyZay7J9zHKq8hnB
         WUnn7c+3UQ4ijo4R1WLj0OtuFNzzuq7R2ciVHgHCKC20OSS8/EVL/DxPRABAHKJONhK+
         bgLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700646330; x=1701251130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hEK1gvF+0yh3uLtMdCKIrrASVh3jVfs8UswMA/3tWPg=;
        b=HnGpPi07WTN6ZuAm4PSMjH+M8wwjK5Nx6fVdQ5+LXi4+0ygrSnEUFyozqNjt023A6d
         p5qKoXnPHdV5Rr/lcUZ1w9qfFoJCUq976XpgdrGnWvbptugt5Sl34Ju09IazZzabVrNt
         5ngkw+CfsHCjMqbnOCB3srPCf/Gkl7zbLgOeOXQX0glOhoMU5AQXDblmYHvkxjIoN8mD
         ziZw+xIXdO313upwyzKzstCaWG0Bq5ylKn2yYHDVGFVwIsRPsVatxGbnEumW2z/ey5Ou
         P2ox5asLjfyomO3xiQMndCFSSLAFthkKVUIoD8SZN/JOxhZcBPViREidYLOFI+0nJZ9u
         5sJA==
X-Gm-Message-State: AOJu0YxAjkt3PdOqtyh6bUGrkYhGbasGC3jhrnlXT5O785yydQZFgyqW
        VhtCEF9IQqHkePpOqcQ1c8KebWup0ENoBbp/alw=
X-Google-Smtp-Source: AGHT+IFuf/d1ZCRCDNio7oftxa5nhopfxwxef1qnN4viMv59EQXSl+3nZ5RhzAtZMJE+ygoRdNNAhgb2QVY7IeZndVU=
X-Received: by 2002:a1f:ec81:0:b0:49d:9916:5740 with SMTP id
 k123-20020a1fec81000000b0049d99165740mr1905727vkh.9.1700646330398; Wed, 22
 Nov 2023 01:45:30 -0800 (PST)
MIME-Version: 1.0
References: <20231121202459.36874-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdXozB7PVOZM+SQa9D6Zca3x_+LE63RhmBGPDvmOma1fUA@mail.gmail.com>
In-Reply-To: <CAMuHMdXozB7PVOZM+SQa9D6Zca3x_+LE63RhmBGPDvmOma1fUA@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 22 Nov 2023 09:44:50 +0000
Message-ID: <CA+V-a8tfN8goMf=sc2t6dovBsGmFbioWt7cdbOca8QHJF=EP_w@mail.gmail.com>
Subject: Re: [PATCH] riscv: errata: andes: Probe IOCP during boot stage
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Yu Chien Peter Lin <peterlin@andestech.com>,
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

On Wed, Nov 22, 2023 at 8:23=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Prabhakar,
>
> On Tue, Nov 21, 2023 at 9:25=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail=
.com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > We should be probing for IOCP during boot stage only. As we were probin=
g
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
> > probing IOCP during boot stage only.
> >
> > Fixes: e021ae7f5145 ("riscv: errata: Add Andes alternative ports")
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> > --- a/arch/riscv/errata/andes/errata.c
> > +++ b/arch/riscv/errata/andes/errata.c
> > @@ -60,7 +60,8 @@ void __init_or_module andes_errata_patch_func(struct =
alt_entry *begin, struct al
> >                                               unsigned long archid, uns=
igned long impid,
> >                                               unsigned int stage)
> >  {
> > -       errata_probe_iocp(stage, archid, impid);
> > +       if (stage =3D=3D RISCV_ALTERNATIVES_BOOT)
> > +               errata_probe_iocp(stage, archid, impid);
> >
> >         /* we have nothing to patch here ATM so just return back */
> >  }
>
> I believe this still causes errata_probe_iocp() to be called twice:
> once from apply_boot_alternatives(), and a second time (if CONFIG_MMU=3Dy=
)
> from apply_vdso_alternatives().  Is that OK?
>
Hmm during my testing I didnt see this being called twice (maybe
because alternative section was not found) in
apply_vdso_alternatives().

> Perhaps instead you want to add a check to errata_probe_iocp() (after
> the check for CONFIG_ERRATA_ANDES_CMO), to bail out if the function
> was called before?
>
OK so I'll have a static variable ("riscv_noncoherent_set") in
errata_probe_iocp() and if it's being set I'll bail out early.

Cheers,
Prabhakar
