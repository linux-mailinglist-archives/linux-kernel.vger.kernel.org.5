Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF97790333
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 23:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350784AbjIAVvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 17:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350865AbjIAVqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 17:46:24 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0E3CD7
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 14:45:45 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6bcade59b24so1974140a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 14:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693604745; x=1694209545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xrM57ibCVE1vPyfYNR7KfD9pKOSb0WIIoAK4UJ07VUc=;
        b=h6OVLq+MCiBk6ml4GH27yU8WVJe20F2FdLUM80yH5QmEyJcv7WV5xdiuCgKUvqjvLC
         zwnZ5tVXCcVwhsbvd62npaP2ogKnNWYGRtMWuavJOa5Kca5k+UseSMv6ZbOzZGiEVQjQ
         3vIbssALphdYj2hfGmS9Gtfcw2sNIDJ6M2TTEInrplsAHjzIoLe8xfUdIRywjqbru8xA
         t2yDgFtQESFfwSd7gH7PxAcRixypdDpz5VwFBaHpylPbbn0ci0uouYcVxZUaXbBKfhl0
         NB423pu/EiROAucwGXbnRPbPHuPNrWQMxp+9r7hbfrf0I5QdJIhcb04Idu7ag/ySpF08
         AeQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693604745; x=1694209545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xrM57ibCVE1vPyfYNR7KfD9pKOSb0WIIoAK4UJ07VUc=;
        b=KcGhnrPolM+QZutuUBHux2211AW3ALocv5dUO9TCyuJ4X/xXTL8uL7G+huJhpyO+If
         F+6rra8nVfk1BZy11xMKPYihK/uRKB0x5OOEgN1qpWmec9j9P/YviLKyVsSxhrCbZTaz
         np6F/AiDIIQJNya9iE2Fd7hCjr8QYqgeEY14PNKoGQFTh0L0Xi6CdBSoBocCRCyEPE7G
         WEUV5Zb/CcMHMCNGRUx0SQjX7DxePLE6XKAGP0rn6i4l9d0yYNop+R9vXAOrclV6wZGF
         GiWtjmq8uLRoFkz2uxO9zzEbq6xtujcVngcEKhNsDMlRsgZCBPA140H3Q/iVhhOnUIXI
         7WQQ==
X-Gm-Message-State: AOJu0YzfEY6Ry/5tOoR/1BRMUQEDJoRqesVqMpbXC4feh8EUsCFO0aNB
        SvwWGU6hwBaGZYP6+h/Z3cC1aktxuSKaDdiXMljvXr9ct172oA==
X-Google-Smtp-Source: AGHT+IEwH9jqCPrF4EwMbxbghsphucND1JEWN9TIvBzRB5VYc4FotGYNgxPoBh3Ap/wslpCrq3VZ+EmAXOm+532S1P0=
X-Received: by 2002:a5d:8f94:0:b0:786:7389:51d7 with SMTP id
 l20-20020a5d8f94000000b00786738951d7mr4532869iol.5.1693602814209; Fri, 01 Sep
 2023 14:13:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230901110320.312674-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <c9da6ffe-7a58-1efa-f625-41d73346d6a2@infradead.org>
In-Reply-To: <c9da6ffe-7a58-1efa-f625-41d73346d6a2@infradead.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 1 Sep 2023 22:12:41 +0100
Message-ID: <CA+V-a8tyUpgDSBrpHBBfWfie4xnR7iKCZben3U5dX1puFu3_1A@mail.gmail.com>
Subject: Re: [PATCH] riscv: Kconfig.errata: Add dependency for RISCV_SBI in
 ERRATA_ANDES config
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kernel@vger.kernel.org,
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

Hi Randy,

On Fri, Sep 1, 2023 at 9:27=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org>=
 wrote:
>
> Hi,
>
> On 9/1/23 04:03, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Andes errata uses sbi_ecalll() which is only available if RISCV_SBI is
> > enabled. So add an dependency for RISCV_SBI in ERRATA_ANDES config to
> > avoid any build failures.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202308311610.ec6bm2G8-lkp=
@intel.com/
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  arch/riscv/Kconfig.errata | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
> > index bee5d838763b..566bcefeab50 100644
> > --- a/arch/riscv/Kconfig.errata
> > +++ b/arch/riscv/Kconfig.errata
> > @@ -2,7 +2,7 @@ menu "CPU errata selection"
> >
> >  config ERRATA_ANDES
> >       bool "Andes AX45MP errata"
> > -     depends on RISCV_ALTERNATIVE
> > +     depends on RISCV_ALTERNATIVE && RISCV_SBI
> >       help
> >         All Andes errata Kconfig depend on this Kconfig. Disabling
> >         this Kconfig will disable all Andes errata. Please say "Y"
>
>
> I'm still seeing build warnings/errors after applying all 3 RISC-V
> Kconfig patches from today (2023 SEP 01).
>
> WARNING: unmet direct dependencies detected for ERRATA_ANDES
>   Depends on [n]: RISCV_ALTERNATIVE [=3Dy] && RISCV_SBI [=3Dn]
>   Selected by [y]:
>   - ARCH_R9A07G043 [=3Dy] && SOC_RENESAS [=3Dy] && RISCV [=3Dy]
>
> ../arch/riscv/errata/andes/errata.c: In function 'ax45mp_iocp_sw_workarou=
nd':
> ../arch/riscv/errata/andes/errata.c:29:23: error: storage size of 'ret' i=
sn't known
>    29 |         struct sbiret ret;
>       |                       ^~~
> ../arch/riscv/errata/andes/errata.c:35:15: error: implicit declaration of=
 function 'sbi_ecall' [-Werror=3Dimplicit-function-declaration]
>    35 |         ret =3D sbi_ecall(ANDESTECH_SBI_EXT_ANDES, ANDES_SBI_EXT_=
IOCP_SW_WORKAROUND,
>       |               ^~~~~~~~~
> ../arch/riscv/errata/andes/errata.c:29:23: warning: unused variable 'ret'=
 [-Wunused-variable]
>    29 |         struct sbiret ret;
>       |                       ^~~
>
> ARCH_R9A07G043 in drivers/soc/renesas/Kconfig selects ERRATA_ANDES and
> ERRATA_ANDES_CMO even though RISCV_SBI is not set/enabled.
>

You need to apply patch [1] aswell.

[1] https://patchwork.kernel.org/project/linux-riscv/patch/20230901110936.3=
13171-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar
