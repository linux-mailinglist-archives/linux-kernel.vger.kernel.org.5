Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7AEC75B5AD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 19:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjGTRdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 13:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbjGTRdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 13:33:06 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE50A1984
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 10:33:05 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-262dc1ced40so620964a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 10:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689874385; x=1690479185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghQpfFyvcfhUNISvLwJyXktxUkGP1dSbutRKHuLM3bw=;
        b=dfISc7U6AF5BJRDv8tvjGb/dY6p+ULVVoRlY0W50Ki8JhqALjc5fwJwr0qMlKmM41b
         nkePpa4MjWqtrC3H+etMall5C1i2RCWAd877lqFJq0trUt166uqd2WPKoPJlHCuYAK33
         1+WGH/EeEp7h85+vs7uq7kfg0/UvoNPpY/mZhF7mS3H9T5nBEDZb8kkpKXGy9kwE+MDz
         HCJQ4oow1i1mNO+8YCAXWK1bjkEr3/TF9NsqQ1b2B4UTPrVOLICIGH+nUC6FLIDTbr9o
         jH8et3vA22SYu6+YJIxV5cJfxn5FHGTqRIhVzWxposUnSULOclCAYCDAOx+lEF10yvNj
         B2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689874385; x=1690479185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ghQpfFyvcfhUNISvLwJyXktxUkGP1dSbutRKHuLM3bw=;
        b=FCt9EnkJabpFTQubnnJy2xOtaxiPo+fNdnPdJWndslC8yX8j6piWo8G0k1EBfbohpi
         4ugaFDR6u90Z9XgGA5ex8cOZzz2tQXEcOD9o+QcD+Z88fJ0NjKHSiDoRHDjeNzJ7C1B7
         DL16yZMpz+CXkpDn6GN6qSe4MnJCOVpPmpi+v70tcC/fij1Cntiv7QMUj0W7A23wXfVx
         zaY1FD8NSTSG4XQyRETqEJ2kimWQRZeVz30cf4/th8Q868f0UF44obVtUVVSsQGjkw6d
         NrHFeMBDTgUdzNNHM9w03EbVuLSlokLhteBwQD4ah3D+tIxpko9m9hYn3wZj1M81H1A5
         ZFdw==
X-Gm-Message-State: ABy/qLbi/mHgUSXhhUK6vH3PlTBfIaGYLM+4aSNAF8cbDYnGH6/Lh4Pl
        tWUG0h2UK8kaPoKLl+X4zvxEqxTYXW9phNu6Fwlwcw==
X-Google-Smtp-Source: APBJJlFxII+Gi7msvyAsb7Vr6LA5urVxi7htutTXVflD5dwYC2EC1sjXNCgFUpAOMtOs2njJbMS+eqcv23XsZ0xHh4s=
X-Received: by 2002:a17:90a:38e5:b0:24e:4b1c:74d2 with SMTP id
 x92-20020a17090a38e500b0024e4b1c74d2mr129400pjb.32.1689874385349; Thu, 20 Jul
 2023 10:33:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689792825.git.tjeznach@rivosinc.com> <e1578b96b9c75433d8c49b6a173ff47a64675c2b.1689792825.git.tjeznach@rivosinc.com>
 <376985dd-a8b9-b86a-3c12-4633dd4505d7@linux.intel.com>
In-Reply-To: <376985dd-a8b9-b86a-3c12-4633dd4505d7@linux.intel.com>
From:   Tomasz Jeznach <tjeznach@rivosinc.com>
Date:   Thu, 20 Jul 2023 10:32:54 -0700
Message-ID: <CAH2o1u4GuVw-V0AVar97F7ByRWpgRBMrAEP_FTvsrxSKqF8pEw@mail.gmail.com>
Subject: Re: [PATCH 04/11] MAINTAINERS: Add myself for RISC-V IOMMU driver
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
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 5:42=E2=80=AFAM Baolu Lu <baolu.lu@linux.intel.com>=
 wrote:
>
> On 2023/7/20 3:33, Tomasz Jeznach wrote:
> > Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> > ---
> >   MAINTAINERS | 7 +++++++
> >   1 file changed, 7 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index aee340630eca..d28b1b99f4c6 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -18270,6 +18270,13 @@ F:   arch/riscv/
> >   N:  riscv
> >   K:  riscv
> >
> > +RISC-V IOMMU
> > +M:   Tomasz Jeznach <tjeznach@rivosinc.com>
> > +L:   linux-riscv@lists.infradead.org
>
> Please add the iommu subsystem mailing list.
>
> iommu@lists.linux.dev
>
> It's the right place to discuss iommu drivers.
>

ack. will add in the next version. Thanks

> > +S:   Maintained
> > +F:   Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> > +F:   drivers/iommu/riscv/
> > +
> >   RISC-V MICROCHIP FPGA SUPPORT
> >   M:  Conor Dooley <conor.dooley@microchip.com>
> >   M:  Daire McNamara <daire.mcnamara@microchip.com>
>
> Best regards,
> baolu

regards,
- Tomasz
