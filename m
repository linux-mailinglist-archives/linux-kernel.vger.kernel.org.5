Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43EEB78FCB3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 13:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344635AbjIALyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 07:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjIALx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 07:53:59 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A82C91;
        Fri,  1 Sep 2023 04:53:53 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-77a62a84855so71754939f.1;
        Fri, 01 Sep 2023 04:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693569232; x=1694174032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TV6C0hh2ZIMC4A3RZXds3JrT4JY8ZfGJ9YXC8hLoRZE=;
        b=UumjosoH+wRGRbRAPPBWGfIpey2PN35R5dWeG4JF2/yeXQW3eBnExB072/obWBxsXS
         2Be3nvvyCwEP7nz30PN8he/dTXd16kXFgVRJ/bDW/3idve31KIJbhS5A9ZWR9zny/W/n
         AwDJAS2qZhn7Xu9hL1qxVYjcYvFFU3nfbuqbSQMBVQAV+j6PX7ylQIaAuadI9Foa9xTB
         4FiCvKSN0OPFVKybWff/Ibd/je+tJhH8S6VabZYPK0muuf/SlYxWyhkSwh+PZ5qTTZwE
         o28mdAyvr0aHv4k3Op5rIET1PwZauJjEklaBz7G16JnzJuHiDeOvH7ikS3nwVw4DPylB
         7/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693569232; x=1694174032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TV6C0hh2ZIMC4A3RZXds3JrT4JY8ZfGJ9YXC8hLoRZE=;
        b=CWjANoYjZtWx+pKjQnfKCyu9vZYpVmlLrOjYRPBpKBOFKcSkTNDWFibq8cmt1Wav0r
         IRuooHm0phVDrLzHQVceOSya7WWGVVpkm5r6tXL95AbR6HkkFb0sgUDdeq+b+eieCj05
         9WZC4G+Qx9Tew3f/SA/J9QXBY7Q/Qs/oa1KRC4fKL2lMqeXppPwkePQc91vQRJbGBQ/G
         6wzS/tUvP+1+MxTtBnAnYK0xv5pYUJoVl73oIvTKhx+pKVYjlhF7KOPiRJBDR1FzmggG
         cNTui7SvI0HmANCadqpXTgg0tkf0aoS4a8xvcnDAM94He1z89WbUhCtu0k4FeGBYJDVw
         Vmgg==
X-Gm-Message-State: AOJu0YzqtWM3iEhdchHJCF7M6w3/8FS+7Vd6SflHjGNYP+97XRIyACPM
        nd9Sv7726rU/MFoClm1vXyPlISUk1pmCL6Z9IPYe7fTEnK0=
X-Google-Smtp-Source: AGHT+IFOz7bKJ/aLhXtWbNR53Jf4XM4L67jj0p3umv+nMADttKamdLEE34OkiRM17N6w6Ncvt4xUTKT3tDXmeX3ay+4=
X-Received: by 2002:a05:6602:160b:b0:792:792e:6619 with SMTP id
 x11-20020a056602160b00b00792792e6619mr3050794iow.2.1693569232710; Fri, 01 Sep
 2023 04:53:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230901110936.313171-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdUyiWOdXtGR8o4kKOyYV8JwoPN-FvMBxYmcRoKLAdu3PQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUyiWOdXtGR8o4kKOyYV8JwoPN-FvMBxYmcRoKLAdu3PQ@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 1 Sep 2023 12:53:00 +0100
Message-ID: <CA+V-a8s76eZnmBBZ0uuQLUo6Dj_yCeW+0XHMzsj2Udezti2RfQ@mail.gmail.com>
Subject: Re: [PATCH] soc: renesas: Kconfig: For ARCH_R9A07G043 select the
 required configs if dependencies are met
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thank you for the review.

On Fri, Sep 1, 2023 at 12:44=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Prabhakar,
>
> On Fri, Sep 1, 2023 at 1:10=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.=
com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > To prevent randconfig build issues when enabling the RZ/Five SoC, consi=
der
> > selecting specific configurations only when their dependencies are
> > satisfied.
>
> Thanks for your patch!
>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202308311610.ec6bm2G8-lkp=
@intel.com/
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Fixes: ed1a8872ff839de0 ("soc: renesas: Kconfig: Select the required
> configs for RZ/Five SoC")
>
> > --- a/drivers/soc/renesas/Kconfig
> > +++ b/drivers/soc/renesas/Kconfig
> > @@ -334,10 +334,11 @@ if RISCV
> >  config ARCH_R9A07G043
> >         bool "RISC-V Platform support for RZ/Five"
> >         select ARCH_RZG2L
> > -       select AX45MP_L2_CACHE
> > +       select AX45MP_L2_CACHE if RISCV_DMA_NONCOHERENT
> >         select DMA_GLOBAL_POOL
> > -       select ERRATA_ANDES
> > -       select ERRATA_ANDES_CMO
> > +       select ERRATA_ANDES if RISCV_SBI
> > +       select ERRATA_ANDES_CMO if ERRATA_ANDES
> > +
> >         help
> >           This enables support for the Renesas RZ/Five SoC.
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> As the offending commit won't be in my tree until v6.6-rc1, I cannot
> take it now, and risc/for-next sounds like the best target.
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
Agreed.

Palmer, can you please pick this patch via riscv tree?

Cheers,
Prabhakar
