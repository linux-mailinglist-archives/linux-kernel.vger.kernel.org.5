Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC80769748
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 15:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjGaNQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 09:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjGaNQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:16:06 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20226A0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 06:16:05 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-79095499a17so111234639f.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 06:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1690809364; x=1691414164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRH6VQXemkXA+D7i+tzL2o9BcfhJ0anPcs6glUFKwE0=;
        b=Q1xK9cDrMwE0LmpgNCnRLvUiu1+Gy1wu4LA08EI6Ns27tGn2M4sR6WXFyPI4x03hCE
         R4ybue8dY+aQhR1eS8UN2p6CrvsFox2KJPbg8QEWZoAG4GsbHzcN8Rx7YiGQO1E/vDhT
         mhxaaMx6i4+u8v7bfVkcMLtgs9LLxKlunXXUjZgCUjAA0fUl338Hnvtd26JhQXGaOc9R
         +vf06UfCEhc5dv1jS+m3exRjGVN2pKVpVD6fIc8kmeJM9+b7oqlMRric8lKvpHobPGdw
         WIoJKxfkICtfilBWaf4sq9XGHKI3Qbnw1L3nM31WTMBUFVyePC6T0waakxIg4AcYn/a2
         0HGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690809364; x=1691414164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vRH6VQXemkXA+D7i+tzL2o9BcfhJ0anPcs6glUFKwE0=;
        b=TTukJ1/PXBRa6GEywN66/PXpvowl2kRryOmLEhE+ODFBFY2zlh7qOnBmTfj8BP1iXs
         RSLdsHBvh7hmybFrOUO9MUFkuEvnrRBeI/eC2GQQnYvVIe94+pWsnvuBRP9bgkCpUQsf
         yykijmiraej8W2VmJoH/zO/0bNwFQLoLBRBOKoGSosO+80dfvsS99gyH4Ygltabxg4Lc
         WaiblGsLlEPQOBKgbcpNUg48scOAs0f7JtoOvW2eyEgxjUbQf24uZtdMBRPvDNndCtxO
         f6Jty2OORigHX0o8no+hO4DlaYDfFvs7Jjn14s0iMb3SC85MfM8lyrkOKMQO4AlahS/R
         nLSg==
X-Gm-Message-State: ABy/qLbJOj6O83Xdj6YUDvLTrQS/L21kkvi28pyz5k75reJzPuRV0op+
        YsAEbSIrRhiaZ9WFwK0RiVZ6TFsX+a9zT8nSf4f6oA==
X-Google-Smtp-Source: APBJJlH8nBsPuRb798NsaX1lz2UV52ixs9AF2BaoevPGu19FNnbZMl13NG+Y1dqJ03EeXfC0yYnuihdvfglI0jI3ilY=
X-Received: by 2002:a5d:9b1a:0:b0:787:6bd:e590 with SMTP id
 y26-20020a5d9b1a000000b0078706bde590mr9238130ion.3.1690809364466; Mon, 31 Jul
 2023 06:16:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689792825.git.tjeznach@rivosinc.com> <1fd79e5c53d9d6ed2264f60dd4261f293cc00472.1689792825.git.tjeznach@rivosinc.com>
 <CANXhq0pm+1yXuvUGudwNtvNHWV3FytH4VfCnq7_Ws=t-MZP_kQ@mail.gmail.com> <3d4d9b22-8451-f4d5-bbd8-117988f3a545@ics.forth.gr>
In-Reply-To: <3d4d9b22-8451-f4d5-bbd8-117988f3a545@ics.forth.gr>
From:   Zong Li <zong.li@sifive.com>
Date:   Mon, 31 Jul 2023 21:15:53 +0800
Message-ID: <CANXhq0puxuHA2cEyb2+TobkoFTc=7MQqtv7DYbuZdvf0T8+iUQ@mail.gmail.com>
Subject: Re: [PATCH 06/11] RISC-V: drivers/iommu/riscv: Add command, fault,
 page-req queues
To:     Nick Kossifidis <mick@ics.forth.gr>
Cc:     Tomasz Jeznach <tjeznach@rivosinc.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux@rivosinc.com,
        linux-kernel@vger.kernel.org, Sebastien Boeuf <seb@rivosinc.com>,
        iommu@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 5:32=E2=80=AFPM Nick Kossifidis <mick@ics.forth.gr>=
 wrote:
>
> On 7/29/23 15:58, Zong Li wrote:
> > On Thu, Jul 20, 2023 at 3:34=E2=80=AFAM Tomasz Jeznach <tjeznach@rivosi=
nc.com> wrote:
> >> +       iommu->cap =3D riscv_iommu_readq(iommu, RISCV_IOMMU_REG_CAP);
> >> +
> >> +       /* For now we only support WSIs until we have AIA support */
> >
> > I'm not completely understand AIA support here, because I saw the pci
> > case uses the MSI, and kernel seems to have the AIA implementation.
> > Could you please elaborate it?
> >
>
> When I wrote this we didn't have AIA in the kernel, and without IMSIC we
> can't have MSIs in the hart (we can still have MSIs in the PCIe controlle=
r).

Thanks for your clarification, do we support the MSI in next version?

>
> >
> > Should we define the "interrupt-names" in dt-bindings?
> >
>
> Yes we should, along with queue lengths below.
>
> >> +
> >> +       /* Make sure fctl.WSI is set */
> >> +       fctl =3D riscv_iommu_readl(iommu, RISCV_IOMMU_REG_FCTL);
> >> +       fctl |=3D RISCV_IOMMU_FCTL_WSI;
> >> +       riscv_iommu_writel(iommu, RISCV_IOMMU_REG_FCTL, fctl);
> >> +
> >> +       /* Parse Queue lengts */
> >> +       ret =3D of_property_read_u32(pdev->dev.of_node, "cmdq_len", &i=
ommu->cmdq_len);
> >> +       if (!ret)
> >> +               dev_info(dev, "command queue length set to %i\n", iomm=
u->cmdq_len);
> >> +
> >> +       ret =3D of_property_read_u32(pdev->dev.of_node, "fltq_len", &i=
ommu->fltq_len);
> >> +       if (!ret)
> >> +               dev_info(dev, "fault/event queue length set to %i\n", =
iommu->fltq_len);
> >> +
> >> +       ret =3D of_property_read_u32(pdev->dev.of_node, "priq_len", &i=
ommu->priq_len);
> >> +       if (!ret)
> >> +               dev_info(dev, "page request queue length set to %i\n",=
 iommu->priq_len);
> >> +
> >>          dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> >>
