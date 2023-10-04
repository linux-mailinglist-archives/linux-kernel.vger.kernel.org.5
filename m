Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3753D7B8310
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbjJDO7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbjJDO7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:59:43 -0400
Received: from sender3-op-o18.zoho.com (sender3-op-o18.zoho.com [136.143.184.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBD59B;
        Wed,  4 Oct 2023 07:59:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1696431543; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=gMNoEli4g2cQmjpcvCqiTd0zYxrBPMD7THOpvqCJHuBCjFTHlL9bRpK1PpNn9VxWIMRRvOWFj/81OVWtua0txKV9ePNxYJz/s9wa8Qqwc1qR17pt+ONK2llQh9jXO0O5o9UxpU03SAa1SuhE8GBIMYh9hcJmZxEeC1MxpTxWMWQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1696431543; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
        bh=LdPMaLjHlfUS0gHSy+2qt31lLyAWmRO7wmsNvzL4OAA=; 
        b=RndgPiKwFgWEQvELvUjLB4YgihwR+6RtVkQGlc1vQeTytOl0qwkq5Grh5h9Q9vBuNH3GrYJZrJs9ZSIAeB86tKLvEloWPMRDz0OLeCPIvzRfZ1ZFefbdsUggu3U4WAAyjQNBpKAKOZ4d/EhXai85OdmlZj5xQXKqxiKnUt5F3uM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1696431543;
        s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
        bh=LdPMaLjHlfUS0gHSy+2qt31lLyAWmRO7wmsNvzL4OAA=;
        b=eR+gxRYUfLByktnwDoAwm9lPs4BfVqK07dHUdshqDxQX2gRuSzUu3NFgPnhbxYRc
        rMLb8eGiorRLyOJ6xgw3daXcyMGY2mq886CEGxS+toWYQzUc2hAtqYhDWbylPy5cyru
        lULRYYaZaMkWc4UCNNbRIi8ttEPo1CXM5swK74Bcscl9OZ3+MlpilTGcqSMFxaV0HNR
        VmMkv2V9QlRvVB2a9wjbrBQ02AP5OmGfA642uz3IbHTtbREbkub7MO2+IpvBJ9yECtI
        PK3T9xtDX4OVUyarYMIkSfRjEgR286oGWKYn3eTMHyjiFuQ29v0YbqYHFSlrN6FjeGg
        xCr+bBBG+w==
Received: from edelgard.fodlan.icenowy.me (120.85.98.65 [120.85.98.65]) by mx.zohomail.com
        with SMTPS id 1696431540266745.8094566529361; Wed, 4 Oct 2023 07:59:00 -0700 (PDT)
Message-ID: <12ea9707f8c45dc398eb20f303aba9ecc7624455.camel@icenowy.me>
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
Date:   Wed, 04 Oct 2023 22:58:52 +0800
In-Reply-To: <a568a9dd-bab2-1e23-c4d5-9f6475bdcc3b@arm.com>
References: <20230921-th1520-mmc-v1-0-49f76c274fb3@baylibre.com>
         <CAOCHtYhnx1EpBM+o3xhdsicx5uqLidojK3f0HQ+VfyVv1ZXnVQ@mail.gmail.com>
         <CAOCHtYi5Ab5ppCmaQV3QuKQcpmJX+sHdAmtuEXhfq8xf5fFCYQ@mail.gmail.com>
         <ZRuamJuShOnvP1pr@x1> <ZR1M3FcdXrDmIGu2@xhacker>
         <CA+V-a8ugwqkQxnX-wwWCHVtBBtG=aVv=MZTc53LbpxtFA=N1_A@mail.gmail.com>
         <bc2b0b30-ab37-f336-c90e-eab570d393a2@arm.com>
         <c2ea3f34bb919293b850fab6ed42b61e3517ba35.camel@icenowy.me>
         <a568a9dd-bab2-1e23-c4d5-9f6475bdcc3b@arm.com>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2023-10-04=E6=98=9F=E6=9C=9F=E4=B8=89=E7=9A=84 15:18 +0100=EF=BC=
=8CRobin Murphy=E5=86=99=E9=81=93=EF=BC=9A
> On 04/10/2023 3:02 pm, Icenowy Zheng wrote:
> [...]
> > > > > I believe commit 484861e09f3e ("soc: renesas: Kconfig: Select
> > > > > the
> > > > > required configs for RZ/Five SoC") can cause regression on
> > > > > all
> > > > > non-dma-coherent riscv platforms with generic defconfig. This
> > > > > is
> > > > > a common issue. The logic here is: generic riscv defconfig
> > > > > selects
> > > > > ARCH_R9A07G043 which selects DMA_GLOBAL_POOL, which assumes
> > > > > all
> > > > > non-dma-coherent riscv platforms have a dma global pool, this
> > > > > assumption
> > > > > seems not correct. And I believe DMA_GLOBAL_POOL should not
> > > > > be
> > > > > selected by ARCH_SOCFAMILIY, instead, only ARCH under some
> > > > > specific
> > > > > conditions can select it globaly, for example NOMMU ARM and
> > > > > so
> > > > > on.
> > > > >=20
> > > > > Since this is a regression, what's proper fix? any suggestion
> > > > > is
> > > > > appreciated.
> > >=20
> > > I think the answer is to not select DMA_GLOBAL_POOL, since that
> > > is
> > > only
> >=20
> > Well I think for RISC-V, it's not NOMMU only but applicable for
> > every
> > core that does not support Svpbmt or vendor-specific alternatives,
> > because the original RISC-V priv spec does not define memory
> > attributes
> > in page table entries.
> >=20
> > For the Renesas/Andes case I think a pool is set by OpenSBI with
> > vendor-specific M-mode facility and then passed in DT, and the S-
> > mode
> > (which MMU is enabled in) just sees fixed memory attributes, in
> > this
> > case I think DMA_GLOBAL_POOL is needed.
>=20
> Oh wow, is that really a thing? In that case, either you just can't=20
> support this platform in a multi-platform kernel, or someone needs to
> do=20

Well, considering RZ/Five enables some spec-non-conformant local memory
(which bypasses MMU) that makes even running generic user space
binaries not so viable (PIE ones may still run, but those built to be
on the default fixed location of binutils will conflict with the MMU-
bypassing local memory), not supporting it in a multi-platform kernel
doesn't look like a big deal.

> some fiddly work in dma-direct to a) introduce the notion of an
> optional=20
> global pool, and b) make it somehow cope with DMA_DIRECT_REMAP being=20
> enabled but non-functional.
>=20
> Thanks,
> Robin.

