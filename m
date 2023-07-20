Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229C775B6C9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 20:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbjGTSaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 14:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbjGTSaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 14:30:16 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0FF196
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 11:30:14 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-262c42d3fafso804273a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 11:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689877814; x=1690482614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mkhjk/nVBrnNuMjmXsk/jA6PNc5ly2hNBTN0yfAkH5Q=;
        b=b2Pe1xIPWJCDsg6h66rbrpgxHYq51tgb/OXB6KHRNSesz35L8jVwo4n89JSY1WX6fm
         DjqF1Jswmg201FhvUH6hGoWb7tW+wOCwbweIAthSeQeJF9/gVCCyIo9T2/aNCo0pGd2r
         vtdxC6aEX1EVRLwItj22Rc+wxV8eX0D9IJ+2Yv2luBEw6+Z9zlMRws9UYFFv6awtnz8Y
         Hv9Mf7tS/i1/SedIQnnFYzLK92Gh43NMMVcNzmOPKgYiZNIUNzuQgDwCxw1eq+96rQmM
         o/dkQaKs5DT74ynoWMGRpONBSpXBPm1UJXtTK/7D5ay4Z8RROWam8WzsAYNhHZOwGwAK
         X9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689877814; x=1690482614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mkhjk/nVBrnNuMjmXsk/jA6PNc5ly2hNBTN0yfAkH5Q=;
        b=buDyNUohy3ZSL5j/kd9lEIYEikq7dciGRxAlqxoXLyHXVM4jTXVqJZKYSDvNXv1lUC
         nn55JBTwB1rbuxJBL5CivV8gJRXAspVpZHp3/l69ZKZtKa9lZh9B1cZplE+mB/HrtZEU
         HVr0Qyn9U+/RopAVV9m7GKG5roOLIApmIzF5pMh43uKVi2VuGq5olBlGf9eTZ4tDvyo+
         5TaTLm5i7rmrJvOOA8QEFGxnQ+QTT9sVQsvD+V0VQJlcFLtBpXY+wlw0Upbz5JNasnL6
         8xpiXA30A+vULr24xSZAjZVQ68pgoh3W7DHn9ug5Bkf2qGqvSUeUh1hT5hDf0bi4Y7gC
         DIvA==
X-Gm-Message-State: ABy/qLZsZRqpy8PgjqZZwPw/ESVs766DyZHumhWyRNok/hzmYZNC48nN
        otHRKHVoBTlWWouozoojdt+KwjiG2q6ay4qIuOBHHg==
X-Google-Smtp-Source: APBJJlGFbUizqz1vNI7vMUQ0ylZG3q2JJ4UhCTVRD6md7r3Rcjt9plOMw7o0JnLrKKGUNqRDannn0g50nIaGzfRduP0=
X-Received: by 2002:a17:90a:c28c:b0:261:219b:13b3 with SMTP id
 f12-20020a17090ac28c00b00261219b13b3mr53612pjt.16.1689877814079; Thu, 20 Jul
 2023 11:30:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689792825.git.tjeznach@rivosinc.com> <610abe685f90870be52bc7c2ca45ab5235bd8eb4.1689792825.git.tjeznach@rivosinc.com>
 <c26d029e-dabc-9ad2-ed42-bb6ee276e3fb@kernel.org>
In-Reply-To: <c26d029e-dabc-9ad2-ed42-bb6ee276e3fb@kernel.org>
From:   Tomasz Jeznach <tjeznach@rivosinc.com>
Date:   Thu, 20 Jul 2023 11:30:03 -0700
Message-ID: <CAH2o1u6pMF3MN=oFBcs9kOf-nwnEYfD2Vv=89+DzUanV59R5dw@mail.gmail.com>
Subject: Re: [PATCH 05/11] RISC-V: drivers/iommu/riscv: Add sysfs interface
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Sebastien Boeuf <seb@rivosinc.com>, iommu@lists.linux.dev,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@rivosinc.com
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

On Wed, Jul 19, 2023 at 11:38=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On 19/07/2023 21:33, Tomasz Jeznach wrote:
> > Enable sysfs debug / visibility interface providing restricted
> > access to hardware registers.
>
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching.
>

ack.

> >
> > Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> > ---
> >  drivers/iommu/riscv/Makefile      |   2 +-
> >  drivers/iommu/riscv/iommu-sysfs.c | 183 ++++++++++++++++++++++++++++++
> >  drivers/iommu/riscv/iommu.c       |   7 ++
> >  drivers/iommu/riscv/iommu.h       |   2 +
> >  4 files changed, 193 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/iommu/riscv/iommu-sysfs.c
> >
> > diff --git a/drivers/iommu/riscv/Makefile b/drivers/iommu/riscv/Makefil=
e
> > index 38730c11e4a8..9523eb053cfc 100644
> > --- a/drivers/iommu/riscv/Makefile
> > +++ b/drivers/iommu/riscv/Makefile
> > @@ -1 +1 @@
> > -obj-$(CONFIG_RISCV_IOMMU) +=3D iommu.o iommu-pci.o iommu-platform.o
> > \ No newline at end of file
> > +obj-$(CONFIG_RISCV_IOMMU) +=3D iommu.o iommu-pci.o iommu-platform.o io=
mmu-sysfs.o
> > \ No newline at end of file
>
> You have this error in multiple places.
>

ack. next version will run through checkpatch.pl, should spot such problems=
.

> > diff --git a/drivers/iommu/riscv/iommu-sysfs.c b/drivers/iommu/riscv/io=
mmu-sysfs.c
> > new file mode 100644
> > index 000000000000..f038ea8445c5
> > --- /dev/null
> > +++ b/drivers/iommu/riscv/iommu-sysfs.c
> > @@ -0,0 +1,183 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * IOMMU API for RISC-V architected Ziommu implementations.
> > + *
> > + * Copyright =C2=A9 2022-2023 Rivos Inc.
> > + *
> > + * Author: Tomasz Jeznach <tjeznach@rivosinc.com>
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/kernel.h>
> > +#include <linux/compiler.h>
> > +#include <linux/iommu.h>
> > +#include <linux/platform_device.h>
> > +#include <asm/page.h>
> > +
> > +#include "iommu.h"
> > +
> > +#define sysfs_dev_to_iommu(dev) \
> > +     container_of(dev_get_drvdata(dev), struct riscv_iommu_device, iom=
mu)
> > +
> > +static ssize_t address_show(struct device *dev,
> > +                         struct device_attribute *attr, char *buf)
>
>
> Where is the sysfs ABI documented?
>

Sysfs for now is used only to expose selected IOMMU memory mapped
registers, with complete documentation in the RISC-V IOMMU Arch Spec
[1], and some comments in iommu-bits.h file.
LMK If it would be better to put a dedicated file documenting those
with the patch itself.


[1] https://github.com/riscv-non-isa/riscv-iommu/releases/download/v1.0/ris=
cv-iommu.pdf

>
> Best regards,
> Krzysztof
>

regards,
- Tomasz
