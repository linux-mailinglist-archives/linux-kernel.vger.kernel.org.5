Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E649675B5A4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 19:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjGTRae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 13:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjGTRac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 13:30:32 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074FC2D4E
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 10:30:25 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-55b66ca1c80so555794a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 10:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689874225; x=1690479025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Jgltx8+AogmPueUJpd1ddvXCoc1LFHFyy2IivtFEuM=;
        b=H7ZOPp6RoPqT7W3PXPM7vGIVlZya6DXsrP6B90e0orSAztWRq7hFyj9YnFrzM9eurj
         gOyeALf31bL4fkfnsd/mssbmc2qNTdZq5fAAQHnXWwHcLlkhwuNJgr5vmPt8I+CysiBB
         kFQnTLadUGn27+HoMEayAIfsPJAsg+rdoFT8xiDfYojFS+yo3RTgpNkdLRSkatLhsjZ0
         mrafv+9VyDbclzhWIwDsbsKDZi+HMalxtGVgmL4Znn3vIK2KrhUSi8NAR39x9jSt1c5q
         WkHlDKqNh9gMoY5fw3wnvfdI4f5mwWfT+EM7YG/63F/vFqAvuxnAp79/BS5Cdo2LgqCa
         quYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689874225; x=1690479025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Jgltx8+AogmPueUJpd1ddvXCoc1LFHFyy2IivtFEuM=;
        b=LRD6VpYd3pO1w4GwRg4ZnQKme+OmuCAx4K3vmmk/UkxxegqQOxcF6a7Ap6y3dDSXLk
         km8Rp+G8Du/xVfmafPXpKztXaKWPZ1wbYVzGM6bc1es4rA3Y40vMofoeOIejHnew0Ubw
         CEZjHcmm09OAojCY0lByo0qlYeWMF4IPB6oqKdoGRvKebK0vCvmxq1A7wMVVxDN66oQ5
         U1r0YSH0viw5SHyRn5nBTJNTFBYGYUXJd4bTZ2Ddn/CDzX3rj0mULNhtVqlUmyfz891D
         PMJmmSbCVzLayfxUT3M2EjD2lScM0ayPwI+kYmiWwMBL0USgkuUsd0YN5IcHXUxEbm+q
         cSXg==
X-Gm-Message-State: ABy/qLbSIKe9Qydv0fIscuNsQfzsMmYGND1TYznWrGwFVpvE+3Aj07rf
        6AeF2C+PTxiU2t3D1fr9oX1mlTqhlQo72EOW57WpuQ==
X-Google-Smtp-Source: APBJJlE+G95QBF6VY00FhWT1XObYtCBMnu+GP3liZNALUzkYUmm8mL+amFnKnovXXWebzCLkWY2Hu5+D3FeScbC5lXY=
X-Received: by 2002:a17:90b:3e8b:b0:267:6c28:17b2 with SMTP id
 rj11-20020a17090b3e8b00b002676c2817b2mr156012pjb.7.1689874224966; Thu, 20 Jul
 2023 10:30:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689792825.git.tjeznach@rivosinc.com> <c33c24036c06c023947ecb47177da273569b3ac7.1689792825.git.tjeznach@rivosinc.com>
 <45d32e95-9d57-a424-63bd-b894cf0d3a2b@linux.intel.com>
In-Reply-To: <45d32e95-9d57-a424-63bd-b894cf0d3a2b@linux.intel.com>
From:   Tomasz Jeznach <tjeznach@rivosinc.com>
Date:   Thu, 20 Jul 2023 10:30:14 -0700
Message-ID: <CAH2o1u4q1=cKz7yFxKWrP2goypsxTxusYV_aSD-Os33bDZwepQ@mail.gmail.com>
Subject: Re: [PATCH 01/11] RISC-V: drivers/iommu: Add RISC-V IOMMU - Ziommu support.
To:     Baolu Lu <baolu.lu@linux.intel.com>
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
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 5:31=E2=80=AFAM Baolu Lu <baolu.lu@linux.intel.com>=
 wrote:
>
> On 2023/7/20 3:33, Tomasz Jeznach wrote:
> > +static void riscv_iommu_iotlb_sync_map(struct iommu_domain *iommu_doma=
in,
> > +                                    unsigned long iova, size_t size)
> > +{
> > +     unsigned long end =3D iova + size - 1;
> > +     /*
> > +      * Given we don't know the page size used by this range, we assum=
e the
> > +      * smallest page size to ensure all possible entries are flushed =
from
> > +      * the IOATC.
> > +      */
> > +     size_t pgsize =3D PAGE_SIZE;
> > +     riscv_iommu_flush_iotlb_range(iommu_domain, &iova, &end, &pgsize)=
;
> > +}
>
> Does RISC-V IOMMU require to invalidate the TLB cache after new mappings
> are created?
>

No. Only on unmapping / permission change.
Thanks for pointing this out.

> Best regards,
> baolu

regards,
- Tomasz
