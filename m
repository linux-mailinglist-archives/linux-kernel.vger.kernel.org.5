Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220207643EA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 04:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjG0CnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 22:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjG0CnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 22:43:00 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F4A1724
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 19:42:59 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-78372b895d6so16659939f.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 19:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1690425778; x=1691030578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8jyIXLWbiaPIfUNQUt/A1abaBSl99TewPn4xIRH3Gk=;
        b=dbnUFrMfJLqrJt66x+t87Cn30gCM4ssUP+qYJSr9zH+PptsSMCURpkLnIQbFBiFdWF
         UwmkDC+uzYwwo/JAe24bt9XBAXX5jibXHISDLWDE2RgZOu8QMSfQlEsLF+Xmi7TYK4vd
         3dm99tWY34wEeITB0N/MMMztVoxiOEyoYkyGXMl1fwYHaEB2EvDw/Tls3xlGbl86xO0o
         mN4FZMO+uTeKfCQD4mhLMrhm+InZmxPaxOWq7Ur1mTCqxH7JktdjtxDEvTZnlH8c1eDq
         fPvFX7HmSYvywfjg9RyMITrlL5aTIhpe7L+smnYu0PFl4Ir9Hyz9HlkgQleRn8QkxPrw
         izJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690425778; x=1691030578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V8jyIXLWbiaPIfUNQUt/A1abaBSl99TewPn4xIRH3Gk=;
        b=I9LQkkekd6V1RFxyK8HAytobP8hirHv1V1P5ismU2BQZIwiNp90D4WdHI2zOI8aVoY
         +hoCKD1gwafKsaH6HA0nCuKm5xwC16ifrxc9x/jm5HOt2xr1LGVUS1G7ilxqRIRj8l5B
         JRL3vL3ZpJpC0L/YgcMEpFcMM15Eww8U3eHzHHIoE2Lwr4J50P+F14fQ2IkvCc35vl53
         VBpcoBjj5LMz+ektIlIBS9mV7RYXc/MALiwvFJa7xIqfbVHx2uO5v2i/bKZLzYHPALae
         jRMdjUZpoPojvIIk7QwMk4SYhYYLifMqk4bvyztX/DOe39Sz+CtZ+QaYYygHGYgnWAyO
         fQow==
X-Gm-Message-State: ABy/qLZD8BnhVKknuZ8kiPZLXpTCQa/Bh7HvJBL9gdm9X5iyATROWScd
        j6R8hhHZKrZlTFQlTFGnUl5NNbfEYjEcpG1m8HJzmw==
X-Google-Smtp-Source: APBJJlHCjsq9WEkyIPdPbZnYZG7ki1pDsOSIOucj+Kdgdv9AAgadEJaEys0ZQLpivwimHm1HmO/UrXhpnSNMewQmKXo=
X-Received: by 2002:a6b:6014:0:b0:783:572c:9caa with SMTP id
 r20-20020a6b6014000000b00783572c9caamr3688832iog.0.1690425778618; Wed, 26 Jul
 2023 19:42:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689792825.git.tjeznach@rivosinc.com> <d62ceb33620cab766d809e6bbf30eaf5b46bc955.1689792825.git.tjeznach@rivosinc.com>
 <CANXhq0r=2eqpy9wLjVt1U0J7=LpnJLcKV7N9d90jvCss=7+Fzg@mail.gmail.com>
 <CAK9=C2Vg9eR5LJPeqDDQ0pHZcrT5DOUzA8_wYEVEjfnhb6s8pw@mail.gmail.com>
 <CANXhq0oTrU_-OQroW7H+hvxcU7YROhkgdCF9g_WtPTzVFQL7gA@mail.gmail.com>
 <CAK9=C2XoQjPzZ5yB5jfTbee4-Pb8GgFAZRbfcMwMk9pyo39WxQ@mail.gmail.com>
 <CANXhq0q7R9Srx6U=fReq7LDLFgW6rMmjKH=o6MzDT5AWNRXP6w@mail.gmail.com>
 <592edb17-7fa4-3b5b-2803-e8c50c322eee@linux.intel.com> <CANXhq0pS_=YxgrxSKbdfrFdGcBduzk3LTyC4vp_hqoJTbX3e0g@mail.gmail.com>
 <ZMEO1kNGfGjN6kZM@ziepe.ca>
In-Reply-To: <ZMEO1kNGfGjN6kZM@ziepe.ca>
From:   Zong Li <zong.li@sifive.com>
Date:   Thu, 27 Jul 2023 10:42:47 +0800
Message-ID: <CANXhq0qMWS_j0n_aUO8BVFSedYCjuMM=Z_tsnK05ZhG+Ob6pqw@mail.gmail.com>
Subject: Re: [PATCH 03/11] dt-bindings: Add RISC-V IOMMU bindings
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Tomasz Jeznach <tjeznach@rivosinc.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux@rivosinc.com,
        linux-kernel@vger.kernel.org, Sebastien Boeuf <seb@rivosinc.com>,
        iommu@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
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

On Wed, Jul 26, 2023 at 8:17=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Wed, Jul 26, 2023 at 12:26:14PM +0800, Zong Li wrote:
> > On Wed, Jul 26, 2023 at 11:21=E2=80=AFAM Baolu Lu <baolu.lu@linux.intel=
.com> wrote:
> > >
> > > On 2023/7/24 21:23, Zong Li wrote:
> > > >>>>> In RISC-V IOMMU, certain devices can be set to bypass mode when=
 the
> > > >>>>> IOMMU is in translation mode. To identify the devices that requ=
ire
> > > >>>>> bypass mode by default, does it be sensible to add a property t=
o
> > > >>>>> indicate this behavior?
> > > >>>> Bypass mode for a device is a property of that device (similar t=
o dma-coherent)
> > > >>>> and not of the IOMMU. Other architectures (ARM and x86) never ad=
ded such
> > > >>>> a device property for bypass mode so I guess it is NOT ADVISABLE=
 to do it.
> > > >>>>
> > > >>>> If this is REALLY required then we can do something similar to t=
he QCOM
> > > >>>> SMMU driver where they have a whitelist of devices which are all=
owed to
> > > >>>> be in bypass mode (i.e. IOMMU_DOMAIN_IDENTITY) based their devic=
e
> > > >>>> compatible string and any device outside this whitelist is
> > > >>>> blocked by default.
>
> I have a draft patch someplace that consolidated all this quirk
> checking into the core code. Generally the expectation is that any
> device behind an iommu is fully functional in all modes. The existing
> quirks are for HW defects that make some devices not work properly. In
> this case the right outcome seems to be effectively blocking them from
> using the iommu.
>
> So, you should explain a lot more what "require bypass mode" means in
> the RISCV world and why any device would need it.

Perhaps this question could be related to the scenarios in which
devices wish to be in bypass mode when the IOMMU is in translation
mode, and why IOMMU defines/supports this case. Currently, I could
envision a scenario where a device is already connected to the IOMMU
in hardware, but it is not functioning correctly, or there are
performance impacts. If modifying the hardware is not feasible, a
default configuration that allows bypass mode could be provided as a
solution. There might be other scenarios that I might have overlooked.
It seems to me since IOMMU supports this configuration, it would be
advantageous to have an approach to achieve it, and DT might be a
flexible way.

>
> Jason
