Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E407B8020
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 15:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242533AbjJDNDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 09:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbjJDNDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 09:03:07 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD11198;
        Wed,  4 Oct 2023 06:03:03 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-49d39f07066so892997e0c.0;
        Wed, 04 Oct 2023 06:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696424583; x=1697029383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSv0fnQiWGKznN7qc7Hk8Fhlm64nM7lW3Q5OIBrznfA=;
        b=H+igHGaN5bbNzPtAgI1fO6uV+0NUl5Z54c6IulgddYTl0afPLchRIeyOERrrHfEuBh
         1JqKbFMx6BbXp5EMKgvhfRAtmZx4TLRMbQa6G4xSba895Y0l8ssAKCerOf+OA7lpuE1K
         bZqli2vsG4kyuOKiuswsOKc3Lt6FhI74SZU6zmzikS7oJcwtZF2CxCpRJkQBjA2aWb8M
         sOjaa95qvjtBbjh/grWdq4go09ALZez3gaw6RvGHqqvR8YByjf5S4FFJqtvvtwTyv1WG
         HJ+KEFzEwIC0o5rMkzOAhX+PqJGpVX+IImsNwWvbVXV/ex3Mt+KhOYknAJmyxUooEN2I
         wVAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696424583; x=1697029383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bSv0fnQiWGKznN7qc7Hk8Fhlm64nM7lW3Q5OIBrznfA=;
        b=U4kb1gd4d2avqPxOrSSAsok7nXO53nN6V/YbhI0sKzfL0dSjScVpO+bGa49h10IrpK
         6yPRFEnVGGsdBiu2a7DdhZgOPtuaQqzoxDnLXc55HIaF0aYOk4LqtMb4mZmJ6w28wxZk
         Ox8t2hQM+fwyPiLNJj6mMABqekTcuAD9uzDo1Vo9OX1KIlPgESyEi44zSY41rKrYFPUx
         5QopXE95fZ5TSyO7yKI7uJVeGudlYuW9cfWfY9uCwtox3yiHXmSZoXtJbPl0XEBVQiPY
         vKacCpWw3LXcB0kasTl15BVocIkMNA6BRKnVzKhUdnjWW72F0Xx5V8MFTi9bWVnH9me8
         MjrA==
X-Gm-Message-State: AOJu0Yx8cJPzPrXz3n1ER9UxYUXFrkio8N+SXtypaio5Nebgxaw9bvPb
        8wUmk5fG1OeqV4ik6jYRl8NtEeGpsDcZbJu9GkI=
X-Google-Smtp-Source: AGHT+IEmmj5kDwjfmLxuhp+KqCie3sEBZRH8qhFF3JL8qvtcD8WJmGUdKav7/FUfeLhBloT9LJ8hb0kuH7HP2pQD718=
X-Received: by 2002:a1f:4bc4:0:b0:47e:8a9:478c with SMTP id
 y187-20020a1f4bc4000000b0047e08a9478cmr1789874vka.16.1696424582835; Wed, 04
 Oct 2023 06:03:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230921-th1520-mmc-v1-0-49f76c274fb3@baylibre.com>
 <CAOCHtYhnx1EpBM+o3xhdsicx5uqLidojK3f0HQ+VfyVv1ZXnVQ@mail.gmail.com>
 <CAOCHtYi5Ab5ppCmaQV3QuKQcpmJX+sHdAmtuEXhfq8xf5fFCYQ@mail.gmail.com>
 <ZRuamJuShOnvP1pr@x1> <ZR1M3FcdXrDmIGu2@xhacker>
In-Reply-To: <ZR1M3FcdXrDmIGu2@xhacker>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 4 Oct 2023 14:02:36 +0100
Message-ID: <CA+V-a8ugwqkQxnX-wwWCHVtBBtG=aVv=MZTc53LbpxtFA=N1_A@mail.gmail.com>
Subject: Re: [PATCH 0/6] RISC-V: Add eMMC support for TH1520 boards
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Drew Fustini <dfustini@baylibre.com>,
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
        Icenowy Zheng <uwu@icenowy.me>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Linux-MM <linux-mm@kvack.org>,
        Robin Murphy <robin.murphy@arm.com>
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

+ CC linux-mm and Robin Murphy

On Wed, Oct 4, 2023 at 12:42=E2=80=AFPM Jisheng Zhang <jszhang@kernel.org> =
wrote:
>
> On Mon, Oct 02, 2023 at 09:37:44PM -0700, Drew Fustini wrote:
> > On Fri, Sep 22, 2023 at 05:48:21PM -0500, Robert Nelson wrote:
> > > On Fri, Sep 22, 2023 at 2:08=E2=80=AFPM Robert Nelson <robertcnelson@=
gmail.com> wrote:
> > > >
> > > > On Thu, Sep 21, 2023 at 8:51=E2=80=AFPM Drew Fustini <dfustini@bayl=
ibre.com> wrote:
> > > > >
> > > > > This series adds support for the eMMC on the BeagleV Ahead and th=
e
> > > > > Sipeed LicheePi 4A. This allows the kernel to boot with the rootf=
s on
> > > > > eMMC.
> > > > >
> > > > > I tested on top of v6.6-rc2 with this config [1]. I was able to b=
oot
> > > > > both the Ahead [2] and LPi4a [3] from eMMC. The following prerequ=
isites
> > > > > are required:
> > > > >
> > > > >   [PATCH v2] riscv: dts: thead: set dma-noncoherent to soc bus [4=
]
> > > > >
> > > > > I pushed a branch [5] with this patch series and the above patch =
for
> > > > > those that find a git branch easier to test.
> > > > >
> > > > > Please note that only the MMC controller connected to the eMMC de=
vice
> > > > > is enabled in the device trees for these two boards. I did not ye=
t
> > > > > attempt to configure and use the microSD card slot. My preference=
 is to
> > > > > address that in a future patch series.
> > > > >
> > > > > References:
> > > > > [1] https://gist.github.com/pdp7/5fbdcf2a65eb1abdd3a29d519c19cdd2
> > > > > [2] https://gist.github.com/pdp7/91a801a5f8d1070c53509eda9800ad78
> > > > > [3] https://gist.github.com/pdp7/1445c3c991e88fd69c60165cef65726a
> > > > > [4] https://lore.kernel.org/linux-riscv/20230912072232.2455-1-jsz=
hang@kernel.org/
> > > > > [5] https://github.com/pdp7/linux/tree/b4/th1520-mmc
> > > >
> > > > This patchset came out very nice!
> > > >
> > > > v6.6-rc2 with Last RFC v2:
> > > >
> > > > [    4.066630] mmc0: SDHCI controller on ffe7080000.mmc
> > > > [ffe7080000.mmc] using PIO
> > > >
> > > > debian@BeagleV:~$ sudo hdparm -tT /dev/mmcblk0
> > > >
> > > > /dev/mmcblk0:
> > > >  Timing cached reads:   1516 MB in  2.00 seconds =3D 758.09 MB/sec
> > > >  Timing buffered disk reads:  84 MB in  3.01 seconds =3D  27.94 MB/=
sec
> > > >
> > > > vs v6.6-rc2 with this patchset:
> > > >
> > > >  [    4.096837] mmc0: SDHCI controller on ffe7080000.mmc
> > > > [ffe7080000.mmc] using DMA
> > > >
> > > > debian@BeagleV:~$ sudo hdparm -tT /dev/mmcblk0
> > > >
> > > > /dev/mmcblk0:
> > > >  Timing cached reads:   1580 MB in  2.00 seconds =3D 790.97 MB/sec
> > > >  Timing buffered disk reads: 418 MB in  3.00 seconds =3D 139.11 MB/=
sec
> > >
> > > Drew pointed out on Slack, this was not quite right.. After more
> > > digging by Drew, CONFIG_DMA_GLOBAL_POOL is causing a DMA limitation
> > > with the multiplatform defconfig. so with,
> > >
> > > ./scripts/config --disable CONFIG_ARCH_R9A07G043
> > >
> > > (to remove CONFIG_DMA_GLOBAL_POOL)... another 2x in buffered reads..
> > >
> > > [    4.059242] mmc0: SDHCI controller on ffe7080000.mmc
> > > [ffe7080000.mmc] using ADMA 64-bit
> > >
> > > debian@BeagleV:~$ sudo hdparm -tT /dev/mmcblk0
> > >
> > > /dev/mmcblk0:
> > >  Timing cached reads:   1600 MB in  2.00 seconds =3D 800.93 MB/sec
> > >  Timing buffered disk reads: 892 MB in  3.00 seconds =3D 297.06 MB/se=
c
> >
> > It seems CONFIG_DMA_GLOBAL_POOL=3Dy causes ADMA buffer alloc to fail [1=
]:
> >
> >   mmc0: Unable to allocate ADMA buffers - falling back to standard DMA
> >
> > Prabhakar's AX45MP non-coherent DMA support [2] series introduced the
> > selection of DMA_GLOBAL_POOL for ARCH_R9A07G043 and the riscv defconfig
> > selects ARCH_R9A07G043.
> >
> > Patch 5 in the series [3] states that:
> >
> >   With DMA_GLOBAL_POOL enabled all DMA allocations happen from this
> >   region and synchronization callbacks are implemented to synchronize
> >   when doing DMA transactions.
> >
> > This example of a "shared-dma-pool" node was given:
> >
> >         pma_resv0@58000000 {
> >             compatible =3D "shared-dma-pool";
> >             reg =3D <0x0 0x58000000 0x0 0x08000000>;
> >             no-map;
> >             linux,dma-default;
> >         };
> >
> > I've copied that to th1520-beaglev-ahead.dts. The address of 0x58000000
> > has no significance on th1520, but the existence of shared-dma-pool
> > seems to fix the problem. ADMA mode [4] is now working even though
> > CONFIG_DMA_GLOBAL_POOL=3Dy.
>
> + Christoph, Lad
>
> IMHO, this is not TH1520 specific but a generic issue.
>
> I believe commit 484861e09f3e ("soc: renesas: Kconfig: Select the
> required configs for RZ/Five SoC") can cause regression on all
> non-dma-coherent riscv platforms with generic defconfig. This is
> a common issue. The logic here is: generic riscv defconfig selects
> ARCH_R9A07G043 which selects DMA_GLOBAL_POOL, which assumes all
> non-dma-coherent riscv platforms have a dma global pool, this assumption
> seems not correct. And I believe DMA_GLOBAL_POOL should not be
> selected by ARCH_SOCFAMILIY, instead, only ARCH under some specific
> conditions can select it globaly, for example NOMMU ARM and so on.
>
> Since this is a regression, what's proper fix? any suggestion is
> appreciated.
>
> Thanks
>
> >
> > Thanks,
> > Drew
> >
> > [1] https://gist.github.com/pdp7/73041ed808bbc7dd445836fb90574979
> > [2] https://lore.kernel.org/linux-riscv/20230818135723.80612-1-prabhaka=
r.mahadev-lad.rj@bp.renesas.com/
> > [3] https://lore.kernel.org/linux-riscv/20230818135723.80612-6-prabhaka=
r.mahadev-lad.rj@bp.renesas.com/
> > [4] https://gist.github.com/pdp7/91e72a663d3bb73eb28182337ad8bbcb
