Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161097B81B3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242762AbjJDOEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242770AbjJDOEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:04:39 -0400
Received: from sender3-op-o17.zoho.com (sender3-op-o17.zoho.com [136.143.184.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C05BF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 07:04:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1696428194; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=htY/wMSm8p5yOySCFhqa3AixtriFzYJljC9Xt5ZgC+gBFjrOokXJaZMfffRHj0RwddItBtQVcvw//Kn7f2l640u9tw/Y06DV7k6yFGRZU6fq78QYZfA+0u2+PnTPG1J1XzL4maOvZBQGeg7I+UWxJbOSQouvXlx+O7jYSeL9Lf0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1696428194; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
        bh=lfdKBiEfg7M6MID6J3Whfh516eqSiysLzgdeOPdxLNo=; 
        b=hkkRE6KV9t1KaXMoYj2CIxqpb7UEVOwthTAOEMjKsXeMfeTVF02YFDsfbKmC98yih+SevSonzQ0VtqL2LN2opV4KbEsOShk5Z1viHZTligl/jTQpLgna6v2gCUvOjn9nS/yZyiKaswaL1cEpx7XZhbplGDqd9FkfHP6XO1i2Yys=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1696428194;
        s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
        bh=lfdKBiEfg7M6MID6J3Whfh516eqSiysLzgdeOPdxLNo=;
        b=jy8qBi1ka9ufG3CGbI7zefjIAOFCPfybagWCJ2Bm46BnaquEmcDcR6E8FW6Buz7a
        Qer6p4hsooPZ8X9tKsq4Al+ZjYg0vc3WBZTmRL/I5V02D5JM36JkkpIOKSy8Anh0RU3
        t90csO4+uDHgmxdW03FHDdLaasKAgVwG2ZARWHNVSe5HPqu4RTx4PBv2mG+6nZHvDbo
        XK6+SFzMTR4cOLJsCWlm17+W5q33FScXNC75Tw2ih7zMIG+aMVXhMV9xVMkpLgMWBLg
        Tl9yTMvHpEKNZDSXOT49lAmtncep6Vb87oPMzu+Ph7cx7SuFAKbFXR8jiq7rK3rEWc9
        hlayoPbKAg==
Received: from edelgard.fodlan.icenowy.me (120.85.98.65 [120.85.98.65]) by mx.zohomail.com
        with SMTPS id 1696428191465788.6446738676636; Wed, 4 Oct 2023 07:03:11 -0700 (PDT)
Message-ID: <c2ea3f34bb919293b850fab6ed42b61e3517ba35.camel@icenowy.me>
Subject: Re: [PATCH 0/6] RISC-V: Add eMMC support for TH1520 boards
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Robin Murphy <robin.murphy@arm.com>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Jisheng Zhang <jszhang@kernel.org>
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
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Linux-MM <linux-mm@kvack.org>
Date:   Wed, 04 Oct 2023 22:02:56 +0800
In-Reply-To: <bc2b0b30-ab37-f336-c90e-eab570d393a2@arm.com>
References: <20230921-th1520-mmc-v1-0-49f76c274fb3@baylibre.com>
         <CAOCHtYhnx1EpBM+o3xhdsicx5uqLidojK3f0HQ+VfyVv1ZXnVQ@mail.gmail.com>
         <CAOCHtYi5Ab5ppCmaQV3QuKQcpmJX+sHdAmtuEXhfq8xf5fFCYQ@mail.gmail.com>
         <ZRuamJuShOnvP1pr@x1> <ZR1M3FcdXrDmIGu2@xhacker>
         <CA+V-a8ugwqkQxnX-wwWCHVtBBtG=aVv=MZTc53LbpxtFA=N1_A@mail.gmail.com>
         <bc2b0b30-ab37-f336-c90e-eab570d393a2@arm.com>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2023-10-04=E6=98=9F=E6=9C=9F=E4=B8=89=E7=9A=84 14:49 +0100=EF=BC=
=8CRobin Murphy=E5=86=99=E9=81=93=EF=BC=9A
> On 04/10/2023 2:02 pm, Lad, Prabhakar wrote:
> > + CC linux-mm and Robin Murphy
> >=20
> > On Wed, Oct 4, 2023 at 12:42=E2=80=AFPM Jisheng Zhang <jszhang@kernel.o=
rg>
> > wrote:
> > >=20
> > > On Mon, Oct 02, 2023 at 09:37:44PM -0700, Drew Fustini wrote:
> > > > On Fri, Sep 22, 2023 at 05:48:21PM -0500, Robert Nelson wrote:
> > > > > On Fri, Sep 22, 2023 at 2:08=E2=80=AFPM Robert Nelson
> > > > > <robertcnelson@gmail.com> wrote:
> > > > > >=20
> > > > > > On Thu, Sep 21, 2023 at 8:51=E2=80=AFPM Drew Fustini
> > > > > > <dfustini@baylibre.com> wrote:
> > > > > > >=20
> > > > > > > This series adds support for the eMMC on the BeagleV
> > > > > > > Ahead and the
> > > > > > > Sipeed LicheePi 4A. This allows the kernel to boot with
> > > > > > > the rootfs on
> > > > > > > eMMC.
> > > > > > >=20
> > > > > > > I tested on top of v6.6-rc2 with this config [1]. I was
> > > > > > > able to boot
> > > > > > > both the Ahead [2] and LPi4a [3] from eMMC. The following
> > > > > > > prerequisites
> > > > > > > are required:
> > > > > > >=20
> > > > > > > =C2=A0=C2=A0 [PATCH v2] riscv: dts: thead: set dma-noncoheren=
t to
> > > > > > > soc bus [4]
> > > > > > >=20
> > > > > > > I pushed a branch [5] with this patch series and the
> > > > > > > above patch for
> > > > > > > those that find a git branch easier to test.
> > > > > > >=20
> > > > > > > Please note that only the MMC controller connected to the
> > > > > > > eMMC device
> > > > > > > is enabled in the device trees for these two boards. I
> > > > > > > did not yet
> > > > > > > attempt to configure and use the microSD card slot. My
> > > > > > > preference is to
> > > > > > > address that in a future patch series.
> > > > > > >=20
> > > > > > > References:
> > > > > > > [1]
> > > > > > > https://gist.github.com/pdp7/5fbdcf2a65eb1abdd3a29d519c19cdd2
> > > > > > > [2]
> > > > > > > https://gist.github.com/pdp7/91a801a5f8d1070c53509eda9800ad78
> > > > > > > [3]
> > > > > > > https://gist.github.com/pdp7/1445c3c991e88fd69c60165cef65726a
> > > > > > > [4]
> > > > > > > https://lore.kernel.org/linux-riscv/20230912072232.2455-1-jsz=
hang@kernel.org/
> > > > > > > [5] https://github.com/pdp7/linux/tree/b4/th1520-mmc
> > > > > >=20
> > > > > > This patchset came out very nice!
> > > > > >=20
> > > > > > v6.6-rc2 with Last RFC v2:
> > > > > >=20
> > > > > > [=C2=A0=C2=A0=C2=A0 4.066630] mmc0: SDHCI controller on ffe7080=
000.mmc
> > > > > > [ffe7080000.mmc] using PIO
> > > > > >=20
> > > > > > debian@BeagleV:~$ sudo hdparm -tT /dev/mmcblk0
> > > > > >=20
> > > > > > /dev/mmcblk0:
> > > > > > =C2=A0 Timing cached reads:=C2=A0=C2=A0 1516 MB in=C2=A0 2.00 s=
econds =3D 758.09
> > > > > > MB/sec
> > > > > > =C2=A0 Timing buffered disk reads:=C2=A0 84 MB in=C2=A0 3.01 se=
conds =3D=C2=A0
> > > > > > 27.94 MB/sec
> > > > > >=20
> > > > > > vs v6.6-rc2 with this patchset:
> > > > > >=20
> > > > > > =C2=A0 [=C2=A0=C2=A0=C2=A0 4.096837] mmc0: SDHCI controller on =
ffe7080000.mmc
> > > > > > [ffe7080000.mmc] using DMA
> > > > > >=20
> > > > > > debian@BeagleV:~$ sudo hdparm -tT /dev/mmcblk0
> > > > > >=20
> > > > > > /dev/mmcblk0:
> > > > > > =C2=A0 Timing cached reads:=C2=A0=C2=A0 1580 MB in=C2=A0 2.00 s=
econds =3D 790.97
> > > > > > MB/sec
> > > > > > =C2=A0 Timing buffered disk reads: 418 MB in=C2=A0 3.00 seconds=
 =3D
> > > > > > 139.11 MB/sec
> > > > >=20
> > > > > Drew pointed out on Slack, this was not quite right.. After
> > > > > more
> > > > > digging by Drew, CONFIG_DMA_GLOBAL_POOL is causing a DMA
> > > > > limitation
> > > > > with the multiplatform defconfig. so with,
> > > > >=20
> > > > > ./scripts/config --disable CONFIG_ARCH_R9A07G043
> > > > >=20
> > > > > (to remove CONFIG_DMA_GLOBAL_POOL)... another 2x in buffered
> > > > > reads..
> > > > >=20
> > > > > [=C2=A0=C2=A0=C2=A0 4.059242] mmc0: SDHCI controller on ffe708000=
0.mmc
> > > > > [ffe7080000.mmc] using ADMA 64-bit
> > > > >=20
> > > > > debian@BeagleV:~$ sudo hdparm -tT /dev/mmcblk0
> > > > >=20
> > > > > /dev/mmcblk0:
> > > > > =C2=A0 Timing cached reads:=C2=A0=C2=A0 1600 MB in=C2=A0 2.00 sec=
onds =3D 800.93
> > > > > MB/sec
> > > > > =C2=A0 Timing buffered disk reads: 892 MB in=C2=A0 3.00 seconds =
=3D
> > > > > 297.06 MB/sec
> > > >=20
> > > > It seems CONFIG_DMA_GLOBAL_POOL=3Dy causes ADMA buffer alloc to
> > > > fail [1]:
> > > >=20
> > > > =C2=A0=C2=A0 mmc0: Unable to allocate ADMA buffers - falling back t=
o
> > > > standard DMA
> > > >=20
> > > > Prabhakar's AX45MP non-coherent DMA support [2] series
> > > > introduced the
> > > > selection of DMA_GLOBAL_POOL for ARCH_R9A07G043 and the riscv
> > > > defconfig
> > > > selects ARCH_R9A07G043.
> > > >=20
> > > > Patch 5 in the series [3] states that:
> > > >=20
> > > > =C2=A0=C2=A0 With DMA_GLOBAL_POOL enabled all DMA allocations happe=
n from
> > > > this
> > > > =C2=A0=C2=A0 region and synchronization callbacks are implemented t=
o
> > > > synchronize
> > > > =C2=A0=C2=A0 when doing DMA transactions.
> > > >=20
> > > > This example of a "shared-dma-pool" node was given:
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pma_resv0@58000000=
 {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 compatible =3D "shared-dma-pool";
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 reg =3D <0x0 0x58000000 0x0 0x08000000>;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 no-map;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 linux,dma-default;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > > >=20
> > > > I've copied that to th1520-beaglev-ahead.dts. The address of
> > > > 0x58000000
> > > > has no significance on th1520, but the existence of shared-dma-
> > > > pool
> > > > seems to fix the problem. ADMA mode [4] is now working even
> > > > though
> > > > CONFIG_DMA_GLOBAL_POOL=3Dy.
> > >=20
> > > + Christoph, Lad
> > >=20
> > > IMHO, this is not TH1520 specific but a generic issue.
> > >=20
> > > I believe commit 484861e09f3e ("soc: renesas: Kconfig: Select the
> > > required configs for RZ/Five SoC") can cause regression on all
> > > non-dma-coherent riscv platforms with generic defconfig. This is
> > > a common issue. The logic here is: generic riscv defconfig
> > > selects
> > > ARCH_R9A07G043 which selects DMA_GLOBAL_POOL, which assumes all
> > > non-dma-coherent riscv platforms have a dma global pool, this
> > > assumption
> > > seems not correct. And I believe DMA_GLOBAL_POOL should not be
> > > selected by ARCH_SOCFAMILIY, instead, only ARCH under some
> > > specific
> > > conditions can select it globaly, for example NOMMU ARM and so
> > > on.
> > >=20
> > > Since this is a regression, what's proper fix? any suggestion is
> > > appreciated.
>=20
> I think the answer is to not select DMA_GLOBAL_POOL, since that is
> only=20

Well I think for RISC-V, it's not NOMMU only but applicable for every
core that does not support Svpbmt or vendor-specific alternatives,
because the original RISC-V priv spec does not define memory attributes
in page table entries.

For the Renesas/Andes case I think a pool is set by OpenSBI with
vendor-specific M-mode facility and then passed in DT, and the S-mode
(which MMU is enabled in) just sees fixed memory attributes, in this
case I think DMA_GLOBAL_POOL is needed.

> designed for nommu cases where non-cacheable memory lives in a fixed=20
> place in the physical address map, and regular kernel pages can't be=20
> remapped. As far as I'm aware, RISCV_DMA_NONCOHERENT is the thing you
> want, such that DMA_DIRECT_REMAP can dynamically provide non-
> cacheable=20
> coherent buffers for non-hardware-coherent devices.
>=20
> Thanks,
> Robin.
>=20
> > >=20
> > > Thanks
> > >=20
> > > >=20
> > > > Thanks,
> > > > Drew
> > > >=20
> > > > [1]
> > > > https://gist.github.com/pdp7/73041ed808bbc7dd445836fb90574979
> > > > [2]
> > > > https://lore.kernel.org/linux-riscv/20230818135723.80612-1-prabhaka=
r.mahadev-lad.rj@bp.renesas.com/
> > > > [3]
> > > > https://lore.kernel.org/linux-riscv/20230818135723.80612-6-prabhaka=
r.mahadev-lad.rj@bp.renesas.com/
> > > > [4]
> > > > https://gist.github.com/pdp7/91e72a663d3bb73eb28182337ad8bbcb

