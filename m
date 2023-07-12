Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669807512C0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 23:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbjGLVu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 17:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjGLVuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 17:50:25 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AEF1FDE
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 14:50:24 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-577497ec6c6so79122197b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 14:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689198623; x=1691790623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jgBJLt8F8nT06lWZrT5my19T/ssDD4EJFVZYf3r4c4Q=;
        b=p8Teks0L9CvwXphuOq4oks/fO7DtBEr+auYh/cksOi2bgyT6ElAElYgc5vhGQppz5o
         IpInsZDir/2od0aik6iEZKYW9j/tQ1udeGv5pWiVUF7KqRjox22Wpcc+1wHuiAljllSL
         UcPRI74Qxyr4i64Jnmw4c1hvP0tnciKwhE+1xTpvWO4Hzw53MkfzNm97UFgNVn/CbH+/
         h7h588z0ac4Lb0usI0xQyZbDoFToIXzM/oduEyyq0JxOeHckhM5sRZhGP+6XhzQQx3O/
         /HF+9LW+e6mindlt0iIkTR4eHUDBTkAb7A/4hiviOf0Ul92hn/KNVU3O3EFGUF9ET32o
         1VhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689198623; x=1691790623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jgBJLt8F8nT06lWZrT5my19T/ssDD4EJFVZYf3r4c4Q=;
        b=OIWwXsw10LEJSEvpO/IrQBQUb6SP/UnxnA1lXiKibXkuQ6S3Jm9PebuVdqcEYItRvS
         LQ7BzFuq5YTMoT8SocdQ2uCNviwpIsgUg1/cO1eM35NrKai0qLbQpZ1zNRe/ZgUPVlR/
         BdsH+9xr77HMuYVfVuNwt7uV8OB8Bbm+WjemhmJtobYm0EXTeuQanFqkI3zEs3zjl93c
         NnC4y+Zi6DjoaprvIxJpOXZ/gErJPCZqjfU83KpgJoR133f1UMaGnVKunHT2txM7ymIW
         5ULdm0DBfc+ZG4Lm7mg/HFZY/j0F2BOjWIYj35nD4jypK9dxAZ/qMqEaWgt1YCwPEoy8
         TOrw==
X-Gm-Message-State: ABy/qLYKunwWfsL7vbAuWYBZQ37+bxdGKWUs4tWag+cR7dMoumTR5tdb
        q5Cl4F34tTqnUlqlPxlWMV802Ntx2BDXDy6SNBLidHbKarOay48dEm4=
X-Google-Smtp-Source: APBJJlFpo1WHcVadx/trVx1aimxcfGQFeDkhnm99Y7fwkSaA33wBEGLMpXRDouuqfFCvXego9henI4tLESubaYmlvCc=
X-Received: by 2002:a0d:d74b:0:b0:56d:b0a:f012 with SMTP id
 z72-20020a0dd74b000000b0056d0b0af012mr22504519ywd.9.1689198623305; Wed, 12
 Jul 2023 14:50:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230712-spi-nor-winbond-w25q128-v1-1-f78f3bb42a1c@linaro.org> <46d0846850df455901cf3d11c66c5a90@walle.cc>
In-Reply-To: <46d0846850df455901cf3d11c66c5a90@walle.cc>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 12 Jul 2023 23:50:11 +0200
Message-ID: <CACRpkdaKOHoq_8yhBGdvYpkUr=cZM+-XXyotx4GvJN3C1-ADYg@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: Correct flags for Winbond w25q128
To:     Michael Walle <michael@walle.cc>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for helping out Michael, I would never get this
right without people like you!

On Wed, Jul 12, 2023 at 9:04=E2=80=AFAM Michael Walle <michael@walle.cc> wr=
ote:

> Am 2023-07-12 00:02, schrieb Linus Walleij:
> > The Winbond W25Q128 (actual vendor name W25Q128JV)
>
> Not necessarily see below. Do you know what part numbers is
> written on your flash?

Yes, if I look at it with a looking glass it says
Winbond
25Q128JVF

> > has exactly the same flags as the sibling device
> > w25q128fw. The devices both require unlocking and
> > support dual and quad SPI transport.
> >
> > The actual product naming between devices:
> >
> > 0xef4018: "w25q128"   W25Q128JV-IM/JM
> > 0xef7018: "w25q128fw" W25Q128JV-IN/IQ/JQ
>
> Where do you get that string? from winbond.c?

Yes

> Because,
> then it's incorrect. For 0xef7018 its actually w25q128jv.

No I just confused things, it should be w25q128jv not fw.
But the actual names to the right are from the datasheet,
they are kind of both actually named "jv" :/

> But that being said, Winbond is known to reuse the IDs among its
> flashes. From a quick look at various datasheets:
>
> 0x60 seems to be DW, FW and NW(Q) series
> 0x70 seems to be JV(M)
> 0x80 seems to be NW(M)
> 0x40 seems to be BV, JV(Q), "V" (probably the first [1])
>
> (Q) denotes the fixed quad enable bit.
>
> Now 0x40 are the first ones who where added back in the days. I'm
> not sure, what kind of winbond devices there were and if they
> support dual/quad read.
>
> Normally, you'd use a .fixups (see w25q256_fixups for example) to
> dynamically detect the newer flash type and then refine the flags.
> But because we don't know how the older flashes look like, that
> would be just guessing :/ Although, I've once thought about
> fingerprinting the SFDP tables eg. by some hash. But that would
> assume the SFDP data is not changing a lot on a given device. Not
> sure if that is the case, we just began to collect SFDP tables
> of various devices.
>
> If it turns out that only SPI_NOR_HAS_LOCK and SPI_NOR_HAS_TB
> is needed, I'm leaning towards just adding these flags to the
> w25q128 entry. According to [1] this was already supported
> back in the days.

They are absolutely needed, else I cannot write to the flash.

> > The latter device, "w25q128fw" supports features
> > named DTQ and QPI, otherwise it is the same.
> >
> > Not having the right flags has the annoying side
> > effect that write access does not work.
>
> This should only apply to FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB).
>
> I'd guess your flash supports SFDP, then the NO_SFDP_FLAGS should be
> automatically detected. Could you please dump the SFDP tables
> (described in [2])?

I hope this is correct:

root@OpenWrt:/sys/devices/platform/ubus/10001000.spi/spi_master/spi1/spi1.0=
/spi-nor#
cat jedec_id
ef4018

root@OpenWrt:/sys/devices/platform/ubus/10001000.spi/spi_master/spi1/spi1.0=
/spi-nor#
cat manufacturer
winbond

root@OpenWrt:/sys/devices/platform/ubus/10001000.spi/spi_master/spi1/spi1.0=
/spi-nor#
cat partname
w25q128

root@OpenWrt:/sys/devices/platform/ubus/10001000.spi/spi_master/spi1/spi1.0=
/spi-nor#
hexdump -v -C sfdp
00000000  53 46 44 50 05 01 00 ff  00 05 01 10 80 00 00 ff  |SFDP..........=
..|
00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |..............=
..|
00000020  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |..............=
..|
00000030  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |..............=
..|
00000040  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |..............=
..|
00000050  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |..............=
..|
00000060  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |..............=
..|
00000070  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |..............=
..|
00000080  e5 20 f9 ff ff ff ff 07  44 eb 08 6b 08 3b 42 bb  |. ......D..k.;=
B.|
00000090  fe ff ff ff ff ff 00 00  ff ff 40 eb 0c 20 0f 52  |..........@.. =
.R|
000000a0  10 d8 00 00 36 02 a6 00  82 ea 14 c9 e9 63 76 33  |....6........c=
v3|
000000b0  7a 75 7a 75 f7 a2 d5 5c  19 f7 4d ff e9 30 f8 80  |zuzu...\..M..0=
..|
000000c0

> As mentioned above, could you try without the DUAL_READ/QUAD_READ flags.

It works fine but I cannot judge if it is faster or slower,
I guess it mostly affects the speed right?

Don't I need to set the PARSE_SFDP macro here, to turn
.parse_sfdp =3D true?

> You can have a look at the debugfs whether the detected capabilities
> are still the same with and without these flags.

This is with no changes:

root@OpenWrt:/sys/kernel/debug/spi-nor/spi1.0# cat capabilities
Supported read modes by the flash
 1S-1S-1S
  opcode        0x03
  mode cycles   0
  dummy cycles  0
 1S-1S-1S (fast read)
  opcode        0x0b
  mode cycles   0
  dummy cycles  8

Supported page program modes by the flash
 1S-1S-1S
  opcode        0x02

This is with PARSE_SFDP:

root@OpenWrt:/sys/kernel/debug/spi-nor/spi1.0# cat capabilities
Supported read modes by the flash
 1S-1S-1S
  opcode        0x03
  mode cycles   0
  dummy cycles  0
 1S-1S-1S (fast read)
  opcode        0x0b
  mode cycles   0
  dummy cycles  8
 1S-1S-2S
  opcode        0x3b
  mode cycles   0
  dummy cycles  8
 1S-2S-2S
  opcode        0xbb
  mode cycles   2
  dummy cycles  2
 1S-1S-4S
  opcode        0x6b
  mode cycles   0
  dummy cycles  8
 1S-4S-4S
  opcode        0xeb
  mode cycles   2
  dummy cycles  4
 4S-4S-4S
  opcode        0xeb
  mode cycles   2
  dummy cycles  0

Supported page program modes by the flash
 1S-1S-1S
  opcode        0x02

So indeed it works with SFDP parsing! I'll send an updated patch.

I guess a lot of the chips could actually use this but someone has
to test them on a 1-by-1 basis?

Yours,
Linus Walleij
