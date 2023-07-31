Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB46769522
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 13:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjGaLpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 07:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjGaLpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:45:36 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24923A1;
        Mon, 31 Jul 2023 04:45:35 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-77ac14ff51bso179730939f.3;
        Mon, 31 Jul 2023 04:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690803934; x=1691408734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qqk/kt6+Ga7PWsdfCK1cL1LbXt2AwvGMSRMyEpCfxI=;
        b=okzYRkktr+nRrSVtBCUlShJ4iEpZ4pP6gbHywAWdvOlXSUoGQKdU1X0HWGYabemgKH
         ytJtYPBeUmdTwPScRayYq5tIJ7ak5hhR0ew7NKN/Yo+fqw8AZAX2VpLThA7e6RhhpeGw
         hnmLHI7Y6YN/pNZbqjNKJQBi5RKYL1MV2iktpmMb4E2/ruFT59/jbxVqJXmmQHo2/HAT
         05fUJ8tb3NGegcZhmZjThREc4+fFBqwwcSiAz4nVC7Ez4xC/5904A9vnR4KY8kqEX+rD
         kIxNYijsDgmpEmDesKraaqvWv9+SAElTQ+yLhbTsaQfeADCySqlFkzj9r8xzKkC/A4Td
         PyhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690803934; x=1691408734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3qqk/kt6+Ga7PWsdfCK1cL1LbXt2AwvGMSRMyEpCfxI=;
        b=OC1cFdOLl0qG1hJyPlTdxK7NBPhhi901H4f6LjrbJ5Db2Yb2XSiHlMNz5QNsMNWAPW
         x7B+q4zAxSYXueXdRlJ6gdx/6sFB71FCR8YhhFS3fyhlgH0r+kfeqdGXfR2elTK/RglJ
         QXA7Ms3Fl4lNBqYvVIh1jIX+CZvV88eEYncmzG2r6FQUcEANtgoBo18rugZR+PAwUomr
         AJ485S5s0IPLqh0X3sCIhqC0l8wous+gQhyBBM7whgWp00xygVj6DTYbVmoc3xmw6Afl
         EU7v1nRo9qWVOkG+Pd/PSGF/CpyS/gO7ABYyI0TwC/OhXYjydpx5GSW/Ul5bOseqX79Z
         ODwg==
X-Gm-Message-State: ABy/qLZ2ccpquaAp54WxzUxJldHawzCvorizs7mxGue86zkPzoICoClX
        7vwPhd7u2g+sE4dbrlmqNJM73K/Rp4K9iXSd0aw=
X-Google-Smtp-Source: APBJJlFrThYBjex3opWL4ObHhYJCyDIqwz8yyEyTGf1e1HNfu2R5yX7uSTL8+3rOH2emiyhCqRd8wSTGDCFWcr7gH1E=
X-Received: by 2002:a05:6602:8b:b0:786:26f0:3092 with SMTP id
 h11-20020a056602008b00b0078626f03092mr7456305iob.3.1690803934488; Mon, 31 Jul
 2023 04:45:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230702203429.237615-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230702203429.237615-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ZMZ6XB6gX2kFd/Nt@xhacker> <CA+V-a8u3F_XDjBfVVVvNMfjrni8pgpcRgbVt6_Ax1TmG2fJdEg@mail.gmail.com>
 <20230731-tribute-splashing-6a90f443cefe@wendy>
In-Reply-To: <20230731-tribute-splashing-6a90f443cefe@wendy>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 31 Jul 2023 12:45:08 +0100
Message-ID: <CA+V-a8uHAQBZJBVtLbhxczwAAZYcVSRz+CGoQX0EmPDU5OxEFA@mail.gmail.com>
Subject: Re: [PATCH v10 3/6] riscv: mm: dma-noncoherent: nonstandard cache
 operations support
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Jisheng Zhang <jszhang@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org,
        Christoph Hellwig <hch@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Mon, Jul 31, 2023 at 12:39=E2=80=AFPM Conor Dooley
<conor.dooley@microchip.com> wrote:
>
> On Mon, Jul 31, 2023 at 12:30:43PM +0100, Lad, Prabhakar wrote:
> > On Sun, Jul 30, 2023 at 4:09=E2=80=AFPM Jisheng Zhang <jszhang@kernel.o=
rg> wrote:
> > > On Sun, Jul 02, 2023 at 09:34:26PM +0100, Prabhakar wrote:
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> > > > +config RISCV_NONSTANDARD_CACHE_OPS
> > > > +     bool
> > > > +     depends on RISCV_DMA_NONCOHERENT
> > > > +     help
> > > > +       This enables function pointer support for non-standard nonc=
oherent
> > > > +       systems to handle cache management.
> > >
> > > Per Documentation/riscv/patch-acceptance.rst:
> > >
> > > "we'll only consider patches for extensions that either:
> > >
> > > - Have been officially frozen or ratified by the RISC-V Foundation, o=
r
> > > - Have been implemented in hardware that is widely available, per sta=
ndard
> > >   Linux practice."
> > >
> > > I'm not sure which item this patch series belongs to.
> > >
> > Maybe Conor can help me here ;)
>
> I'm not entirely sure why you need my help, it's your company that
> manufactures the SoC that needs this after all.. I think Emil already
> pointed out that it was the latter of the two. I guess it is not an
> "extension" in the strictest sense of the word, but it fills the same
> gap as one, so /shrug.
>
Aaha I was wondering If there had to be an additional entry here to
fit this case, but if it already does fit in ignore me. Thanks for the
clarification.

Cheers,
Prabhakar
