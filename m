Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D9B7DACB2
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 14:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjJ2Nx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 09:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjJ2Nx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 09:53:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2828BF
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 06:53:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B216C433CB
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 13:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698587604;
        bh=zJ9rQygoM8kC84lZz3ZFZdyHYWBgZmA0dEGRK0EIVB0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LcPhryle1nPZKm9ciRqCL7ztYiThrcZ85tDntmRb1Ki8h2ks6+iv2e7xO3mum4Z8M
         6WIJ3gv+TgptBi81x3/8YHZpW92HOll2gAa6WsyGNSfPX0NmmOHA2t+aysaTb9HRaN
         YrfkEhB9fFWe3PzSvS0qpCNIgE5BuW6AB8eBOqt2OdLSKJkzAjTJ6luA938r1Zn20U
         xqoXNvcdvL3z7mqGwltA7dCWs+ixAU8qDaetbSaj46VeHwonFbgHtEw/RQZTZMAN2Y
         ls9xQGZEGahipcUXzAJe0buCpsVgQiy+oQTLCJOGjUqvlDHy5PbMhlkvW9ijw+czc7
         CGTcUpXGTKf4g==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so574225166b.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 06:53:24 -0700 (PDT)
X-Gm-Message-State: AOJu0Yye1vLD04vYZY1DTc48oe5I7mcxzsfVHsaAuW+j5uMPgUPAh3k9
        dYQ9++tZX25xSYUiT/bOzcJ4WOo6GqiGmP17IOE=
X-Google-Smtp-Source: AGHT+IGej6UNZ6b071bPq8fbKcWondhTjBHUkCO2wPSFUOTrVzzPU4mggOSj4V78PBrCkSeH1UMe0be/YfRYQAEFOTA=
X-Received: by 2002:a17:907:7ea0:b0:9cf:18ce:95e6 with SMTP id
 qb32-20020a1709077ea000b009cf18ce95e6mr5811045ejc.62.1698587602824; Sun, 29
 Oct 2023 06:53:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230809031023.3575407-1-songshuaishuai@tinylab.org>
 <CAJF2gTRHbvwyZR_qUNsc3E9X=Y1H7yTcZo3NLgXQ45=jm1jbTg@mail.gmail.com> <A1D410BE9DD1128F+45f92224-dc0f-0bfd-d122-fbbcac48eaf3@tinylab.org>
In-Reply-To: <A1D410BE9DD1128F+45f92224-dc0f-0bfd-d122-fbbcac48eaf3@tinylab.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 29 Oct 2023 21:53:10 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQjChyoGHo9uumyAGEs--KW6=OqV9SjRp=4XBY4R7nVNg@mail.gmail.com>
Message-ID: <CAJF2gTQjChyoGHo9uumyAGEs--KW6=OqV9SjRp=4XBY4R7nVNg@mail.gmail.com>
Subject: Re: [PATCH] riscv: mm: Update the comment of CONFIG_PAGE_OFFSET
To:     Song Shuai <songshuaishuai@tinylab.org>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, ajones@ventanamicro.com,
        alexghiti@rivosinc.com, anup@brainfault.org, samuel@sholland.org,
        rppt@kernel.org, suagrfillet@gmail.com, panqinglin2020@iscas.ac.cn,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 2:52=E2=80=AFPM Song Shuai <songshuaishuai@tinylab.=
org> wrote:
>
>
>
> =E5=9C=A8 2023/9/14 12:59, Guo Ren =E5=86=99=E9=81=93:
> > On Wed, Aug 9, 2023 at 11:11=E2=80=AFAM Song Shuai <songshuaishuai@tiny=
lab.org> wrote:
> >>
> >> From: Song Shuai <suagrfillet@gmail.com>
> >>
> >> Since the commit 011f09d12052 set sv57 as default for CONFIG_64BIT,
> >> the comment of CONFIG_PAGE_OFFSET should be updated too.
> >>
> >> Fixes: 011f09d12052 ("riscv: mm: Set sv57 on defaultly")
> >> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> >> ---
> >>   arch/riscv/include/asm/page.h | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/pa=
ge.h
> >> index b55ba20903ec..53c00164c042 100644
> >> --- a/arch/riscv/include/asm/page.h
> >> +++ b/arch/riscv/include/asm/page.h
> >> @@ -33,8 +33,8 @@
> >>   #define PAGE_OFFSET            _AC(CONFIG_PAGE_OFFSET, UL)
> > Why not remove CONFIG_PAGE_OFFSET and define PAGE_OFFSET_L2 ?
> >
> CONFIG_PAGE_OFFSET holds the first memory address regarding the
> different CONFIGs (MMU,32BIT,64BIT).
>
> As for 64BIT, it actually represents "PAGE_OFFSET_L5" for Sv57 page mode
> defaultly. And the real page mode may be downgraded from kernel cmdline
> or restricted by the hardware, so the PAGE_OFFSET_L3/L4 was defined to
> set the real PAGE_OFFSET.
>
> IIUC, the "PAGE_OFFSET_L2" you specified might be the "PAGE_OFFSET_L5" I
> previously mentioned,
> If not, the PAGE_OFFSET_L2 semantically means the page offset for
> 32BIT's default Sv32 page mode,and it has already been held in
> CONFIG_PAGE_OFFSET too.
>
> So IMO there is no need to touch CONFIG_PAGE_OFFSET in this context.

I mean:

#define PAGE_OFFSET_L5         _AC(0xff60000000000000, UL)
#define PAGE_OFFSET_L4         _AC(0xffffaf8000000000, UL)
#define PAGE_OFFSET_L3         _AC(0xffffffd800000000, UL)
#define PAGE_OFFSET_L2         _AC(0xC0000000)

#ifdef CONFIG_MMU
#ifdef CONFIG_64BIT
#define PAGE_OFFSET             kernel_map.page_offset
#else /* CONFIG_64BIT */
#define PAGE_OFFSET             PAGE_OFFSET_L2
#endif /* CONFIG_64BIT */
#else /* CONFIG_MMU */
#define PAGE_OFFSET             0x80000000
#endif /* CONFIG_MMU */

kernel_map.page_offset =3D _AC(PAGE_OFFSET_L5, UL);

The kernel_map.page_offset is no use to CONFIG_32BIT.

Remove the CONFIG_PAGE_OFFSET, and put all PAGE_OFFSET* together to
ease maintenance and reading.



>
> Please correct me If I'm wrong.
> >>   #endif
> >>   /*
> >> - * By default, CONFIG_PAGE_OFFSET value corresponds to SV48 address s=
pace so
> >> - * define the PAGE_OFFSET value for SV39.
> >> + * By default, CONFIG_PAGE_OFFSET value corresponds to SV57 address s=
pace so
> >> + * define the PAGE_OFFSET value for SV48 and SV39.
> >>    */
> >>   #define PAGE_OFFSET_L4         _AC(0xffffaf8000000000, UL)
> >>   #define PAGE_OFFSET_L3         _AC(0xffffffd800000000, UL)
> >> --
> >> 2.20.1
> >>
> >
> >
>
> --
> Thanks
> Song Shuai
>


--=20
Best Regards
 Guo Ren
