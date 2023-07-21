Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D99975BCF2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 05:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjGUDuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 23:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjGUDt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 23:49:59 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3E21982
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 20:49:58 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bb1baf55f5so11415925ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 20:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689911398; x=1690516198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PP+KsyysvUIQdJ6ewTv+F8ZGuWEA39fo13NEoHyitfw=;
        b=lfA3gYcio7s8oXJqeQSsLROwIgTtmn9LOUax/z/TlERlxHvwKQzbg+zITQWLHrNzOZ
         i/L6H22njmRWQXVDw7Grf+rfqBo7TsV6x+t0+NtQcXl8lGzjuWq5y+xOk2twOEkV2kSg
         hTb7rlHlVuJtZn1KBuI2WrO3+czJl4IKL+LK/AAfWFFdoSSL20ZV9I39ZDaQw6nHI+Z/
         mcAfy7Q80bUPPoC2zVQNGaWWGFgC7LqKvVArO4LG/X1zh5wn0c3GypldFJz9qgxQ9Ckw
         75pDvcoKVJJv+feLng3AmMxnYUsAVhWv8QuErq/4LdyOVLkF9rrGKdE3sLuRKXnHJiib
         50sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689911398; x=1690516198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PP+KsyysvUIQdJ6ewTv+F8ZGuWEA39fo13NEoHyitfw=;
        b=A1D5bPB+Cvwgxt5jZqv350RF9Hzq5i9VipZ+737fvW35rEb7+ldSpa7cAJcoNerHoP
         fg7yyBI+JZ0tYkwz8s+MYnQpCdzqKlV9ZZYmcAPKRVBTjE/8Le8xL4ebtBHVBmtgmNc1
         306kXYl64UBsuBp8zAWkAUHY2Lslo+FLBf/Pqm5MdkSB4ohUXcsuMYPnK5fkIhuSoQdJ
         HbWNaM/9wH11PZdypbinn648//sKCgMKA53J8gIhcvtdVk/40Tewd1sVXRkKqrUFZgrq
         FZNzHwA/jiqnWLtaPdW6cvim3J8npo/ajAPa29+nmRUCWSq8XpeubwecZdTi24TvRtNR
         3KlA==
X-Gm-Message-State: ABy/qLbT6PbIxws19Kow7k6FPUij5/4mDrp4sOg7OqpfLSX41j84iKVY
        hXkc/rBkBWEBFxXDDAiAlFoMVZnkN1kKNa1t56T3BA==
X-Google-Smtp-Source: APBJJlEr/VjirMVZtMc4cX0uJPsKqRsU32tlCDQs3tsf6K7eUQ4sFLhW24crr5+dorszKseHB0iIVKQGE8YGQVOmfI8=
X-Received: by 2002:a17:90a:5a4c:b0:263:514:5ee3 with SMTP id
 m12-20020a17090a5a4c00b0026305145ee3mr605988pji.32.1689911398194; Thu, 20 Jul
 2023 20:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689792825.git.tjeznach@rivosinc.com> <610abe685f90870be52bc7c2ca45ab5235bd8eb4.1689792825.git.tjeznach@rivosinc.com>
 <c26d029e-dabc-9ad2-ed42-bb6ee276e3fb@kernel.org> <CAH2o1u6pMF3MN=oFBcs9kOf-nwnEYfD2Vv=89+DzUanV59R5dw@mail.gmail.com>
 <69800c58-2df8-25e5-09e0-c9929bae2193@kernel.org> <20230720-bully-famine-dfc9a5e688ef@spud>
In-Reply-To: <20230720-bully-famine-dfc9a5e688ef@spud>
From:   Tomasz Jeznach <tjeznach@rivosinc.com>
Date:   Thu, 20 Jul 2023 20:49:47 -0700
Message-ID: <CAH2o1u77EpQN6QOatc9vr7NjVk3Yzn=mjFkHmTB13PCxZfbqoQ@mail.gmail.com>
Subject: Re: [PATCH 05/11] RISC-V: drivers/iommu/riscv: Add sysfs interface
To:     Conor Dooley <conor@kernel.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
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

On Thu, Jul 20, 2023 at 3:08=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Thu, Jul 20, 2023 at 11:37:50PM +0200, Krzysztof Kozlowski wrote:
> > On 20/07/2023 20:30, Tomasz Jeznach wrote:
>
> > >>> +#define sysfs_dev_to_iommu(dev) \
> > >>> +     container_of(dev_get_drvdata(dev), struct riscv_iommu_device,=
 iommu)
> > >>> +
> > >>> +static ssize_t address_show(struct device *dev,
> > >>> +                         struct device_attribute *attr, char *buf)
> > >>
> > >>
> > >> Where is the sysfs ABI documented?
> > >>
> > >
> > > Sysfs for now is used only to expose selected IOMMU memory mapped
> > > registers, with complete documentation in the RISC-V IOMMU Arch Spec
> > > [1], and some comments in iommu-bits.h file.
> > > LMK If it would be better to put a dedicated file documenting those
> > > with the patch itself.
> >
> > I meant, you created new sysfs interface. Maybe I missed something in
> > the patchset, but each new sysfs interface required documenting in
> > Documentation/ABI/.
>
> | expose selected IOMMU memory mapped registers
>
> | Enable sysfs debug / visibility interface providing restricted
> | access to hardware registers.
>
> Documentation requirements of sysfs stuff aside, I'm not sure that we
> even want a sysfs interface for this in the first place? Seems like, if
> at all, this should be debugfs instead? Seems like the only use case for
> it is debugging/development...

Thanks Conor, will switch to debugfs. This will be a more suitable interfac=
e.

regards,
- Tomasz
