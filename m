Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D97E7B8474
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242739AbjJDQEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbjJDQEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:04:08 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F94D7;
        Wed,  4 Oct 2023 09:04:04 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-496d3e18f19so4420e0c.2;
        Wed, 04 Oct 2023 09:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696435443; x=1697040243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MABqfnWSdAh1rkdR5ORe/BqnN4/f/y3PtSz94ONAKI4=;
        b=LjSut4t1cnfDnGSXSwLhY061TRdkVHDsJwmFsEwsOT7/K5L5A7wBxWtCK9lZ47o6Oq
         n12FtYl4KruRwOSXk2CSd5SKuKuodTk6zaRqplngDQ3bjF1w7rg9flSYSJsQ3encgAZA
         rCrF404dq7drul805knb8QQwqTTGXyskXPMUiK+j66D6++vbtIsf4ByOeR86BFkR7IaC
         HqRGIlRMS9NVw3EqZedecraSAJ10K11OEMcfQOuu2vRuQX6iLzt0FyqREkTe0idWac+U
         MZQ2fuNHdd+9k7NBgGTkshTt6fYXsZAEXBnKI9dh6s3OyKtNSbhSMO5MBt5cz0y0oNlJ
         EgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696435443; x=1697040243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MABqfnWSdAh1rkdR5ORe/BqnN4/f/y3PtSz94ONAKI4=;
        b=Wp3YGeEzSX27zDxmozlkHVac33F47CBbX1vI56SHLsZ0X0IZeGJ926htapXZiiHFp4
         MKo8+kI8GxTCxu66a3b0u/sh7v2ry5SBL3Bk6eOabtWYiAxlPEGpTbEPvZnA3BIMgWd4
         XwxRWlbGWBuxCAsi2lSwn7QzSGpw3CAoyj6YcfrTVeBes2pLlJRygh8i7SniuC6zGOGY
         FDMYpUxUC42ZB8d0qjAqIpBOR55hQn4uTMoVTTGOd53S5/x/V940/63peB+3QtYzVdvL
         hAcODmRnAtuKY69sQt0p6x0gZ2l1yMPcz+sbObIXkx40M3aT3ImBQb9/w02WzZc0X+Kp
         R5sg==
X-Gm-Message-State: AOJu0Yy2FVoULxH72Ll8WUy3Or/yHhJ3LyprpbbRRghScMtsj3Gex0dp
        p6JVt/RWPEIVAUOxctZZ27qA95XgDF5uW8nSGv8=
X-Google-Smtp-Source: AGHT+IFhqTAHYHSaLhsynlzcRRRkFceUfAS3vdmJwZJTjrHm3e3CkHq0mrE5OVpqiZHY9FG2KMkgJe29WNiyo850cMc=
X-Received: by 2002:a1f:4ac2:0:b0:49a:3537:881e with SMTP id
 x185-20020a1f4ac2000000b0049a3537881emr2263379vka.13.1696435443340; Wed, 04
 Oct 2023 09:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230921-th1520-mmc-v1-0-49f76c274fb3@baylibre.com>
 <CAOCHtYhnx1EpBM+o3xhdsicx5uqLidojK3f0HQ+VfyVv1ZXnVQ@mail.gmail.com>
 <CAOCHtYi5Ab5ppCmaQV3QuKQcpmJX+sHdAmtuEXhfq8xf5fFCYQ@mail.gmail.com>
 <ZRuamJuShOnvP1pr@x1> <ZR1M3FcdXrDmIGu2@xhacker> <CA+V-a8ugwqkQxnX-wwWCHVtBBtG=aVv=MZTc53LbpxtFA=N1_A@mail.gmail.com>
 <bc2b0b30-ab37-f336-c90e-eab570d393a2@arm.com> <c2ea3f34bb919293b850fab6ed42b61e3517ba35.camel@icenowy.me>
 <a568a9dd-bab2-1e23-c4d5-9f6475bdcc3b@arm.com>
In-Reply-To: <a568a9dd-bab2-1e23-c4d5-9f6475bdcc3b@arm.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 4 Oct 2023 17:03:36 +0100
Message-ID: <CA+V-a8s1S4yTH19PVNSznAgUFoHRNoye9CfwjW6iy6PbQ9thew@mail.gmail.com>
Subject: Re: [PATCH 0/6] RISC-V: Add eMMC support for TH1520 boards
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>, Icenowy Zheng <uwu@icenowy.me>,
        Jisheng Zhang <jszhang@kernel.org>,
        Drew Fustini <dfustini@baylibre.com>,
        Christoph Hellwig <hch@lst.de>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Robert Nelson <robertcnelson@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Xi Ruoyao <xry111@xry111.site>, Han Gao <gaohan@iscas.ac.cn>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Linux-MM <linux-mm@kvack.org>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 4, 2023 at 3:18=E2=80=AFPM Robin Murphy <robin.murphy@arm.com> =
wrote:
>
> On 04/10/2023 3:02 pm, Icenowy Zheng wrote:
> [...]
> >>>> I believe commit 484861e09f3e ("soc: renesas: Kconfig: Select the
> >>>> required configs for RZ/Five SoC") can cause regression on all
> >>>> non-dma-coherent riscv platforms with generic defconfig. This is
> >>>> a common issue. The logic here is: generic riscv defconfig
> >>>> selects
> >>>> ARCH_R9A07G043 which selects DMA_GLOBAL_POOL, which assumes all
> >>>> non-dma-coherent riscv platforms have a dma global pool, this
> >>>> assumption
> >>>> seems not correct. And I believe DMA_GLOBAL_POOL should not be
> >>>> selected by ARCH_SOCFAMILIY, instead, only ARCH under some
> >>>> specific
> >>>> conditions can select it globaly, for example NOMMU ARM and so
> >>>> on.
> >>>>
> >>>> Since this is a regression, what's proper fix? any suggestion is
> >>>> appreciated.
> >>
> >> I think the answer is to not select DMA_GLOBAL_POOL, since that is
> >> only
> >
> > Well I think for RISC-V, it's not NOMMU only but applicable for every
> > core that does not support Svpbmt or vendor-specific alternatives,
> > because the original RISC-V priv spec does not define memory attributes
> > in page table entries.
> >
> > For the Renesas/Andes case I think a pool is set by OpenSBI with
> > vendor-specific M-mode facility and then passed in DT, and the S-mode
> > (which MMU is enabled in) just sees fixed memory attributes, in this
> > case I think DMA_GLOBAL_POOL is needed.
>
> Oh wow, is that really a thing? In that case, either you just can't
> support this platform in a multi-platform kernel, or someone needs to do
> some fiddly work in dma-direct to a) introduce the notion of an optional
> global pool,
Looking at the code [0] we do have compile time check for
CONFIG_DMA_GLOBAL_POOL irrespective of this being present in DT or
not, instead if we make it compile time and runtime check ie either
check for DT node or see if pool is available and only then proceed
for allocation form this pool.

What are your thoughts on this?

[0] https://elixir.bootlin.com/linux/v6.6-rc4/source/kernel/dma/direct.c#L2=
38

> and b) make it somehow cope with DMA_DIRECT_REMAP being
> enabled but non-functional.
>
DMA_DIRECT_REMAP config option is selected by NONCOHERENET config option an=
yway.

Cheers,
Prabhakar
