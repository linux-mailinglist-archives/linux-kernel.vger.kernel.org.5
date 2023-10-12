Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2BB7C7283
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379539AbjJLQ20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjJLQ2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:28:25 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8D3C0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:28:23 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-507973f3b65so358961e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697128101; x=1697732901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvPFzv/vQzpigDF/RrVmKSWAiTfxGgVgBVZV9bvyAdM=;
        b=VjJhM/arbVrxWrnIHIdgztauEHXuVTZXgR9RyYqPVQY0iDQ6j9dxURhI/RxnRXKkWc
         5YTJCnDP20dwmXHVsEaZB4pbsZJARM9bZtu6X6R7xbyAmjD2jNtQ2OHrJPs3GxHzMuC7
         whBDLTkx6PXOexKp/xCzWWQ7JaFKovEAiIqtIsye5Ug+T37uNwT/JeHr5YMmSWa0gyE+
         5if38w0GFi2+GHX/7dVBY4kZI5w9PPbxumUyYNX24DI1P23qAa/rq3/Na/pVAQtb2EMo
         QvURx8bKeqdb7UByDXlFS7tG69AqVCnJetEiIuNTgR0YURszpmz62WyTBOm60Py6GaxQ
         PUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697128101; x=1697732901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lvPFzv/vQzpigDF/RrVmKSWAiTfxGgVgBVZV9bvyAdM=;
        b=C316ysrwI5kfaNKCWBwgdxvfUuglG+gkPSx05tEh3/H79dzLnF6+mCMS6NZKELMEVV
         iPUzjwLp7bYAMozchsOM1kMHM38RPipUJ1I2VXQ9E/QcJ89tt6XbCBmjuCITcSj79nmL
         gbs7cFMumOt/jD8qwst2h12fVBHqdsNciHLu2aPPWI2aRj3HwLhZZOvsEC/ltH+uQgoV
         l4BjXlcEXkE82rn0fhrlu4mYpVKFoCzyAqolFXMNFgH+2EjwuzJ0pI7gmlRyJJn5JKlS
         7zfBEtfQl8Xj+n+kpnuN87a83IF6t1xYPW6BkfidfM8GpS4LRUV/LOQl7RgCXJ9T18aL
         zsHQ==
X-Gm-Message-State: AOJu0Ywi5Zha9qST0dDKJuzn0zc/GoDkYEelgx9eMBEi2Zd1hHo43GKI
        B+eQZvSkmbzndyBURqsHTAHVFTQXpFD00JZSlbnSVw==
X-Google-Smtp-Source: AGHT+IHn/9WKVUA3hbamQusopdG6YKmUJRdUn5iLBH5qF/lV7QZb90d9hEZv/T0r8aZTXUFepJAIrRuQFMSetp5IOM4=
X-Received: by 2002:a05:6512:3d87:b0:504:7bb0:9d7e with SMTP id
 k7-20020a0565123d8700b005047bb09d7emr26151997lfv.27.1697128101616; Thu, 12
 Oct 2023 09:28:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230712084134.1648008-1-sameo@rivosinc.com> <20230712084134.1648008-2-sameo@rivosinc.com>
 <20230712-bulldozer-affected-199042dc3afd@wendy> <CALs-HsuxxVcwX=mSwktPiEiAFkfK+5qJ6zg1Bzf2t37L=pZWjw@mail.gmail.com>
 <20230713-3f574332a06678f908cee21e@orel> <20230713-aggregate-uncut-e16ee9270b14@wendy>
In-Reply-To: <20230713-aggregate-uncut-e16ee9270b14@wendy>
From:   Evan Green <evan@rivosinc.com>
Date:   Thu, 12 Oct 2023 09:27:45 -0700
Message-ID: <CALs-Hss0aAa_3dVUcdKN0i0+1F6iZ_d_95K2SwWw-B0MYbEXeQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] RISC-V: Add Bitmanip/Scalar Crypto parsing from DT
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Andrew Jones <ajones@ventanamicro.com>,
        Samuel Ortiz <sameo@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        "Hongren (Zenithal) Zheng" <i@zenithal.me>, linux@rivosinc.com,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        devicetree@vger.kernel.org, sorear@fastmail.com,
        Jiatai He <jiatai2021@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 4:28=E2=80=AFAM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> On Thu, Jul 13, 2023 at 10:46:14AM +0200, Andrew Jones wrote:
> > On Wed, Jul 12, 2023 at 10:43:33AM -0700, Evan Green wrote:
> > > On Wed, Jul 12, 2023 at 3:39=E2=80=AFAM Conor Dooley <conor.dooley@mi=
crochip.com> wrote:
> > > > On Wed, Jul 12, 2023 at 10:41:17AM +0200, Samuel Ortiz wrote:
> > > > > From: "Hongren (Zenithal) Zheng" <i@zenithal.me>
> > > > >
> > > > > Parse Zb/Zk related string from DT and output them to cpuinfo.
> > > >
> > > > One thing that has sprung to mind is that this is not limited to DT
> > > > anymore, since the information could in theory come from ACPI too.
> > > > Ditto the title I guess.
> > > >
> > > > > It is worth noting that the Scalar Crypto extension defines "zk" =
as a
> > > > > shorthand for the Zkn, Zkr and Zkt extensions. Since the Zkn one =
also
> > > > > implies the Zbkb, Zbkc and Zbkx extensions, simply passing the va=
lid
> > > > > "zk" extension name through a DT will enable all of the  Zbkb, Zb=
kc,
> > > > > Zbkx, Zkn, Zkr and Zkt extensions.
> > > > >
> > > > > Also, since there currently is no mechanism to merge all enabled
> > > > > extensions, the generated cpuinfo output could be relatively larg=
e.
> > > > > For example, setting the "riscv,isa" DT property to "rv64imafdc_z=
k_zks"
> > > > > will generate the following cpuinfo output:
> > > > > "rv64imafdc_zbkb_zbkc_zbkx_zknd_zkne_zknh_zkr_zksed_zksh_zkt".
> > > >
> > > > On that note, I've created another version of what checking for
> > > > supersets could look like, since it'll be needed either by my serie=
s or
> > > > this one, depending on what gets merged first. I've yet to test the
> > > > dedicated extensions part of it, but I wanted to get this out befor=
e I
> > > > went looking at other fixes in the area.
> > > >
> > > > Evan, since it was you that commented on this stuff last time aroun=
d,
> > > > could you take another look? I'm still not keen on the "subset_of"
> > > > arrays, but they're an improvement on what I had last time around f=
or
> > > > sure.
> > > >
> > >
> > > This looks alright to me. At the risk of getting into bikeshedding
> > > territory, the only awkward bit of it is it composes the extensions i=
n
> > > sort of the opposite way you'd expect. I tend to think of Zks as bein=
g
> > > comprised of {zbkb, zbkc, zksed, zksh},
> >
> > This is also the way I think of it, so, FWIW, I prefer the approach bel=
ow,
> > where bundles are expanded.
>
> I took the patch Evan sent me off-list & have spun it into a "real"
> patch. I did some minor changes (c99 loop, __init marking) to match what
> the code was already doing and expanded it to work for the new property
> stuff.
> I'm not sure that match_isa_ext() needs to be a function, given the
> single user - it might be better refactored to drop the outer if & return
> whether a match was found.
> If done that would allow sharing the same function between isa string and
> dedicated property parsing. I left it intact for now. Might also be
> worth adding kerneldoc for that struct.
>
> -- >8 --
> From 8300b98e487e57d192bc9581c6a3639c40c52623 Mon Sep 17 00:00:00 2001
> From: Evan Green <evan@rivosinc.com>
> Date: Wed, 12 Jul 2023 10:36:15 -0700
> Subject: [PATCH] RISC-V: Add support Scalar Crypto using "bundled extensi=
ons"
>
> The Scalar Crypto specification defines Zk as a shorthand for the
> Zkn, Zkr and Zkt extensions. The same follows for both Zkn, Zks and Zbk,
> which are all shorthands for various other extensions. The detailed
> breakdown can be found in their dt-binding entries.
>
> Since Zkn also implies the Zbkb, Zbkc and Zbkx extensions, simply passing
> "zk" through a DT should enable all of Zbkb, Zbkc, Zbkx, Zkn, Zkr and Zkt=
.
> For example, setting the "riscv,isa" DT property to "rv64imafdc_zk"
> should generate the following cpuinfo output:
> "rv64imafdc_zicntr_zicsr_zifencei_zihpm_zbkb_zbkc_zbkx_zknd_zkne_zknh_zkr=
_zkt"
>
> riscv_isa_ext_data grows a pair of new members, to permit setting the
> relevant bits for "bundled" extensions, both while parsing the ISA string
> and the new dedicated extension properties
>
> Co-developed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> There's basically none of the original patch left, so I have dropped the
> co-developed-bys and signed-off-bys from before. It does need one from
> you now though Evan!

Oops, I hadn't realized this was blocked on me!

Signed-off-by: Evan Green <evan@rivosinc.com>
