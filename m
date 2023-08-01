Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15FA76A599
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 02:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjHAAiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 20:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjHAAiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 20:38:08 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE32A8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 17:38:07 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-78f36f37e36so1487200241.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 17:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1690850286; x=1691455086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NdYmmXRXkB8A9hlXpUOeNCxACpncud2UiXIMN7+uwMg=;
        b=ZsfhB4Qik9M38h7DpsHfzbBtyfKLsOae/fInlFnh4KWn1KPTAqKqfss8bCClXvf2eP
         LO249W9XeMRCI5ZQDk7iioHmflDkF/8oO1bFlerdykVfrI+fCW0PMPYE/Dq91HeVGH+W
         SJ8cooavwfQ0d4fvfgIX9urh0Uyj4gBWn20qm9Fx6bOLk2QVrMD/W1Pf62wFCpGEO0Hs
         LBfuHJZVJm89jiw9SZ51eJWZ89ZUqExRj8UfmSVDM3MRMK/k2GCFJ0YMN/WbG1nfHgZa
         jXvE5ZphKIIOEXRtUmuopZZ5dxlVSaZ9xZiDu8VqGPvPXdKq3mzGVEhzvbGOE/ppCGvY
         P+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690850286; x=1691455086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NdYmmXRXkB8A9hlXpUOeNCxACpncud2UiXIMN7+uwMg=;
        b=WavFIXy5j0k08/b62ODqYHekEtKxdyvTABc2o+7W6oYz9iL6l6uyM5YCj3pnSD3xZl
         wFROwhIr5SzobvKtfi5Hy2OZCW7KI/uP4h6KZzciIW4TJDY2FGHr7qd5dujWyvBbHHaw
         JdIl4AGLFzUomt2kJCems+PQqQTO/fx/H2dnIbq4laXC0Z/Gq1GqwckyBzebH3qHiuiX
         efC3/PmiJnge/+Q/2FiSnS38/J2fV9FUa26geM/OpVsV15lI9+bKGLIHVFIXlh1VpTY8
         RsQJlOm21rgNVsf+il9vcWatEb+Uf1uguBX2tU0nEoDIxCmAmvjxbLAAdZ+9AEO/7nkb
         A2VQ==
X-Gm-Message-State: ABy/qLbTbL4a+QUKe9WcsIfhU7IXMzZ/NBH8814egay+wSPnXCok2QaC
        gG1kADlNVR7uCuNhGFcUev1gVqmfdDZgLQxxzODqZg==
X-Google-Smtp-Source: APBJJlFnersDKJEeFzHE4uX3AEe6xNSZtfoqDenYiRn7lbZF/LiOg7O0b5UFQR20Vrygel0Z6Cgmh72uBhl3+ZselsI=
X-Received: by 2002:a1f:5ec6:0:b0:486:42ab:6a46 with SMTP id
 s189-20020a1f5ec6000000b0048642ab6a46mr1469358vkb.13.1690850286296; Mon, 31
 Jul 2023 17:38:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689792825.git.tjeznach@rivosinc.com> <1fd79e5c53d9d6ed2264f60dd4261f293cc00472.1689792825.git.tjeznach@rivosinc.com>
 <CANXhq0pm+1yXuvUGudwNtvNHWV3FytH4VfCnq7_Ws=t-MZP_kQ@mail.gmail.com>
 <3d4d9b22-8451-f4d5-bbd8-117988f3a545@ics.forth.gr> <CANXhq0puxuHA2cEyb2+TobkoFTc=7MQqtv7DYbuZdvf0T8+iUQ@mail.gmail.com>
 <dc3974f0-500c-b7d3-c8ca-df069dbd02a8@ics.forth.gr>
In-Reply-To: <dc3974f0-500c-b7d3-c8ca-df069dbd02a8@ics.forth.gr>
From:   Zong Li <zong.li@sifive.com>
Date:   Tue, 1 Aug 2023 08:37:56 +0800
Message-ID: <CANXhq0pz5U2i3V7P2qYnhZf5fpcNUrs4J24in2ffMncK7yx6pw@mail.gmail.com>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 1, 2023 at 7:35=E2=80=AFAM Nick Kossifidis <mick@ics.forth.gr> =
wrote:
>
> On 7/31/23 16:15, Zong Li wrote:
> > On Mon, Jul 31, 2023 at 5:32=E2=80=AFPM Nick Kossifidis <mick@ics.forth=
.gr> wrote:
> >>
> >> On 7/29/23 15:58, Zong Li wrote:
> >>> On Thu, Jul 20, 2023 at 3:34=E2=80=AFAM Tomasz Jeznach <tjeznach@rivo=
sinc.com> wrote:
> >>>> +       iommu->cap =3D riscv_iommu_readq(iommu, RISCV_IOMMU_REG_CAP)=
;
> >>>> +
> >>>> +       /* For now we only support WSIs until we have AIA support */
> >>>
> >>> I'm not completely understand AIA support here, because I saw the pci
> >>> case uses the MSI, and kernel seems to have the AIA implementation.
> >>> Could you please elaborate it?
> >>>
> >>
> >> When I wrote this we didn't have AIA in the kernel, and without IMSIC =
we
> >> can't have MSIs in the hart (we can still have MSIs in the PCIe contro=
ller).
> >
> > Thanks for your clarification, do we support the MSI in next version?
> >
>
> I don't think there is an IOMMU implementation out there (emulated or in
> hw) that can do MSIs and is not a pcie device (the QEMU implementation
> is a pcie device). If we have something to test this against, and we
> also have an IMSIC etc, we can work on that.

I guess I can assist with that. We have an IOMMU hardware (non-pcie
device) that has already implemented the MSI functionality, and I have
conducted testing on it. Perhaps let me add the related implementation
here after this series is merged.
