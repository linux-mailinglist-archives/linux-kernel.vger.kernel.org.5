Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1ED27694C3
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 13:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbjGaL1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 07:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjGaL11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:27:27 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0761B7;
        Mon, 31 Jul 2023 04:27:25 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-7835c92c373so124111739f.0;
        Mon, 31 Jul 2023 04:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690802845; x=1691407645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJH1cy35Z/dyiXUx/UDotPeNv2Pad/0I0FqjA2xNQj4=;
        b=plT+MBU3MkIi3vHhGqYT2gFxn21ipFMcDu9L6V5v+UgoVt4UGJlSS7WtHGYB9h0nCj
         K6BDb8/scVUG8sgmvxsf473s58PVntywrvrJHDMQHkO8CGZETtaK4iE7wdHqOWGFYMWb
         MVn58+aWvHr5jLaUMglvUC1usTA0tefQBkfTsQFOBeEtvI7LbH0CVX1VX4ltOdZSBzgP
         XyS7LBYth80zcJMyJoJsTq+GKr/Wk4wgEbT/0ZibfTgEcO5kTKopATwBVvF+DlC/+KwM
         76UXLEgiIpIZUKDz7HObHG8ua0xBkPlIf8PrQubuFj+cXtEjBWotJSQPAbc2jZ+ys/Ga
         fFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690802845; x=1691407645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iJH1cy35Z/dyiXUx/UDotPeNv2Pad/0I0FqjA2xNQj4=;
        b=MSuYJdRtSVDdxGxuiE3EPXgKiAZsmiWLJiSl91F4VIaZ+lVU9LrqvrOhzSQXJDgXAc
         gosP6WUzkN8zG4wrOT+dhxGzNxhSeWg91wh555QXic66IJMepUMe7TPwGKgApGbmMJfV
         IcmrtXB46O2lpjkuw3Dqpr8WDUKIGy3B9lErEZJtUJdjYt3XvucEXwdld8lSprsA+C2T
         l+JG3Ds22M51P3TG0rFS9f0RNKVwdJVsp8GewL/yxJo3NuFqefONip9UfoxEi/YpCFpC
         r+TL4/ZMp1t9VXJ89V6+APbQIZqtHlD77f2xO+Un30rXxzxhgHUjwWmkn/Sont5BJ35s
         Y7ow==
X-Gm-Message-State: ABy/qLbKAVl1scsU9b3Zn3qmBFyz89GBPpaRLyN/HRaGG+ABS1OerGt2
        u1RmmICqZVBznPkLqnnATeIP/LozJ32jF1Fea5c=
X-Google-Smtp-Source: APBJJlFvcDToSfHeWegIEU1VJdujozidStMyByOJkqqLgCYOoaaGH8Byv1gTZSQBK2JEi+qxz0zW1JwCFmuUi8UtLA8=
X-Received: by 2002:a05:6602:381:b0:783:4135:5b96 with SMTP id
 f1-20020a056602038100b0078341355b96mr8488367iov.5.1690802844941; Mon, 31 Jul
 2023 04:27:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230702203429.237615-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230702203429.237615-6-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAJM55Z_ZoKY5A6icpkZo+U5JQ5rMfNmCWz35EJ9RrH7bEgv53g@mail.gmail.com>
In-Reply-To: <CAJM55Z_ZoKY5A6icpkZo+U5JQ5rMfNmCWz35EJ9RrH7bEgv53g@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 31 Jul 2023 12:26:58 +0100
Message-ID: <CA+V-a8t=R1EoEei_q6S9nsTyo9wNZwuvMOcCOJhrWPbG=XDxZg@mail.gmail.com>
Subject: Re: [PATCH v10 5/6] cache: Add L2 cache management for Andes AX45MP
 RISC-V core
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>,
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

Hi Emil,

Thank you for the review.

On Mon, Jul 31, 2023 at 9:53=E2=80=AFAM Emil Renner Berthing
<emil.renner.berthing@canonical.com> wrote:
>
> On Sun, 2 Jul 2023 at 22:37, Prabhakar <prabhakar.csengg@gmail.com> wrote=
:
> >
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > I/O Coherence Port (IOCP) provides an AXI interface for connecting
> > external non-caching masters, such as DMA controllers. The accesses
> > from IOCP are coherent with D-Caches and L2 Cache.
> >
> > IOCP is a specification option and is disabled on the Renesas RZ/Five
> > SoC due to this reason IP blocks using DMA will fail.
> >
> > The Andes AX45MP core has a Programmable Physical Memory Attributes (PM=
A)
> > block that allows dynamic adjustment of memory attributes in the runtim=
e.
> > It contains a configurable amount of PMA entries implemented as CSR
> > registers to control the attributes of memory locations in interest.
> > Below are the memory attributes supported:
> > * Device, Non-bufferable
> > * Device, bufferable
> > * Memory, Non-cacheable, Non-bufferable
> > * Memory, Non-cacheable, Bufferable
> > * Memory, Write-back, No-allocate
> > * Memory, Write-back, Read-allocate
> > * Memory, Write-back, Write-allocate
> > * Memory, Write-back, Read and Write-allocate
> >
> > More info about PMA (section 10.3):
> > Link: http://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-5.0.0-=
Datasheet.pdf
> >
> > As a workaround for SoCs with IOCP disabled CMO needs to be handled by
> > software. Firstly OpenSBI configures the memory region as
> > "Memory, Non-cacheable, Bufferable" and passes this region as a global
> > shared dma pool as a DT node. With DMA_GLOBAL_POOL enabled all DMA
> > allocations happen from this region and synchronization callbacks are
> > implemented to synchronize when doing DMA transactions.
> >
<snip>
> > +static const struct riscv_cache_ops ax45mp_cmo_ops =3D {
> > +       .wback =3D &ax45mp_dma_cache_wback,
> > +       .inv =3D &ax45mp_dma_cache_inv,
> > +       .wback_inv =3D &ax45mp_dma_cache_wback_inv,
> > +};
>
> Hi Prabhakar,
>
> If you're respinning this patchset anyway, I think you can mark this
> struct as __initdata since it's only used by
> riscv_noncoherent_register_cache_ops which copies the contents.
>
Agreed, I will update it in the next version.

Cheers,
Prabhakar
