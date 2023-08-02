Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F7C76D8AA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 22:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjHBU3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 16:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjHBU3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 16:29:03 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6517626A0
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 13:29:02 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-686be3cbea0so947487b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 13:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1691008142; x=1691612942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hqvoTOiyuv4V1kgAdgMNiSxKc6mmFloyOiPHrBE85c=;
        b=OUshjBs3oLkzrOHgBh0MTMLHTYl9xc2uTs/DfoPYFfyAo4mxNCWm8J4c9QM9hSexum
         9HBylmRqvzav1PjL/yeLumKinHJ29RDq5JH0bhVnvEVvlFOG6cE89Nz+C+VZEiXN6GyC
         XE873DFIWrg4Psq8+zzR6SAdu+1WvbZwP9yxUmXFBqXEw525K/0miYFDpnK9xUuLahCN
         MPZl5xGpGevXKZ9VlsrzRHn1HwBtfMSKWM/Rli1NyeCdOiFLEFgDVNLhpZ5wrJtbz85O
         jzJ3956aUY4nykeCy9V7egZ5d1VrdSBrAOieqj/eiWcz0CobtVTQPYEpQAAl1MANoq0M
         homA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691008142; x=1691612942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9hqvoTOiyuv4V1kgAdgMNiSxKc6mmFloyOiPHrBE85c=;
        b=GXwurQNb4lZ83iVOZX5ujxM8kJXhHoNRcnRFQd1tRffTiQRaQEnQtjyt/LiM+N1WqE
         7p2o+/vh0HGWcZPuH/sXEVwhISq5jErwu2p5rDJzyJz5Bc4UOBKrRynpziLd7UzLT8XQ
         M1ivGVVKuwZaZXmwcYui+pJxeH1gyYY/hXRY/1ZPXVywDvHYMBtXlkny2x2+AZbGcXG+
         z1qk31h/QuxvbR5LgkL3Imm4RRwqkFvqSCOP97IpHcEODUEdQC0V5e4MbTDJcoibZfvM
         THYMBLzYfeuU92aipXfQKNzLcTPpFYZ46b6z3m6IbUzhDgUe/+3yNHrZDQ9p7ZjTTnlk
         qAPg==
X-Gm-Message-State: ABy/qLY18zsw4bbZtYhfC0sJSLhLAIG9OPu4wHYW7+Ivd2x0c1vwNNv6
        5XPdjw2wIPR4IscaFf+MVgNUeiIDtfai1ASAeo1u6g==
X-Google-Smtp-Source: APBJJlGP08btXPIyZdLRW9fI8QltrQJlC7A3Ah3EyOyL7RumMhw8sISeCHdZdoMcG5/SZZ1fgZnxmXXhYem8Rv+0x6w=
X-Received: by 2002:a17:90b:101:b0:268:ad94:3cf5 with SMTP id
 p1-20020a17090b010100b00268ad943cf5mr14387097pjz.8.1691008141832; Wed, 02 Aug
 2023 13:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689792825.git.tjeznach@rivosinc.com> <1fd79e5c53d9d6ed2264f60dd4261f293cc00472.1689792825.git.tjeznach@rivosinc.com>
 <CANXhq0pm+1yXuvUGudwNtvNHWV3FytH4VfCnq7_Ws=t-MZP_kQ@mail.gmail.com>
 <3d4d9b22-8451-f4d5-bbd8-117988f3a545@ics.forth.gr> <CANXhq0puxuHA2cEyb2+TobkoFTc=7MQqtv7DYbuZdvf0T8+iUQ@mail.gmail.com>
 <dc3974f0-500c-b7d3-c8ca-df069dbd02a8@ics.forth.gr> <CANXhq0pz5U2i3V7P2qYnhZf5fpcNUrs4J24in2ffMncK7yx6pw@mail.gmail.com>
In-Reply-To: <CANXhq0pz5U2i3V7P2qYnhZf5fpcNUrs4J24in2ffMncK7yx6pw@mail.gmail.com>
From:   Tomasz Jeznach <tjeznach@rivosinc.com>
Date:   Wed, 2 Aug 2023 13:28:51 -0700
Message-ID: <CAH2o1u7BodgZO2R03e9gyMGCR+bU58aAq2-uKYUSF4F7=Xiifg@mail.gmail.com>
Subject: Re: [PATCH 06/11] RISC-V: drivers/iommu/riscv: Add command, fault,
 page-req queues
To:     Zong Li <zong.li@sifive.com>
Cc:     Nick Kossifidis <mick@ics.forth.gr>,
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 5:38=E2=80=AFPM Zong Li <zong.li@sifive.com> wrote:
>
> On Tue, Aug 1, 2023 at 7:35=E2=80=AFAM Nick Kossifidis <mick@ics.forth.gr=
> wrote:
> >
> > On 7/31/23 16:15, Zong Li wrote:
> > > On Mon, Jul 31, 2023 at 5:32=E2=80=AFPM Nick Kossifidis <mick@ics.for=
th.gr> wrote:
> > >>
> > >> On 7/29/23 15:58, Zong Li wrote:
> > >>> On Thu, Jul 20, 2023 at 3:34=E2=80=AFAM Tomasz Jeznach <tjeznach@ri=
vosinc.com> wrote:
> > >>>> +       iommu->cap =3D riscv_iommu_readq(iommu, RISCV_IOMMU_REG_CA=
P);
> > >>>> +
> > >>>> +       /* For now we only support WSIs until we have AIA support =
*/
> > >>>
> > >>> I'm not completely understand AIA support here, because I saw the p=
ci
> > >>> case uses the MSI, and kernel seems to have the AIA implementation.
> > >>> Could you please elaborate it?
> > >>>
> > >>
> > >> When I wrote this we didn't have AIA in the kernel, and without IMSI=
C we
> > >> can't have MSIs in the hart (we can still have MSIs in the PCIe cont=
roller).
> > >
> > > Thanks for your clarification, do we support the MSI in next version?
> > >
> >
> > I don't think there is an IOMMU implementation out there (emulated or i=
n
> > hw) that can do MSIs and is not a pcie device (the QEMU implementation
> > is a pcie device). If we have something to test this against, and we
> > also have an IMSIC etc, we can work on that.
>
> I guess I can assist with that. We have an IOMMU hardware (non-pcie
> device) that has already implemented the MSI functionality, and I have
> conducted testing on it. Perhaps let me add the related implementation
> here after this series is merged.

Thanks, getting MSI support for non-PCIe IOMMU hardware would be great!

best,
- Tomasz
