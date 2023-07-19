Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F2F75A0B4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 23:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjGSVoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 17:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjGSVoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 17:44:04 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D771FD8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 14:44:02 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-262c42d3fafso124507a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 14:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689803042; x=1690407842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLihZVHK3CHWRwQZuJeTGZhqi1m+X+Vl21f6YoEXJhU=;
        b=G+UVUHjmkfa1/Iq+zmyB9mjg/dn+9znCrn3YV7v6AEvEH+6Isw/fYyMRfwBN4MUI9Q
         DMCmhTAWA/tndSpWKNBcbeZMoBrNHbq6I3Y3SFxZ9TYnR/cTXsJarADgWG0v7CRKS7MT
         86Aa+F3bx7QHwdi8/mOfbWJ8clXA/zEh7PS70c2+vslzfCv4seQtPy2JfNUKwX/NLT4H
         jVohrDUeK3eAUzHcA9lJF9MxyrR7fTQ3gwziLV7TVEKi/1JmTNU382je2ILO8L5Q7bSN
         lL+vgfvPWDhd3TzvnIyZ4op+0rhSr8CvxX5PlJ+lv5r7Zob2M3hINsgcszb97jAz+39Z
         gVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689803042; x=1690407842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rLihZVHK3CHWRwQZuJeTGZhqi1m+X+Vl21f6YoEXJhU=;
        b=Zazthj49MAjlIN3dYyBz0F+qEq7EWghvZdMERk6aytIRqdkbx0927g1iw5k14tVNXc
         xh8gReraM+HWoxVtLnLPIYgR4nyFKsHLE0mvM74a+Y6VwkojueA2QUA3nZ/s2G+7zvAl
         11PhaNirrxfH60vMRPRg0dQSzdeGjLcfdfpFhOxCtemy/47uEBubjxz4BStJvUvCRKtY
         G6Vkllo4fyx8Ln6ptpJhcp6KngeeJBMrB8khwbleTKZ3+zYO1xPdqHYDuN+6mk3ZrEIi
         X8+v3BNZMhPpL1bfOeOQiGtidTCkGiQQJ12Tv0kGyn9XNxWFYnUd8ZLqnMmzRJ0tqiYw
         mSow==
X-Gm-Message-State: ABy/qLbIdjAymsXX+sGTY0Z8YGZdwojCxFPkgFu54exGLVemca8cREv+
        1c3Q9VlIVcS9IJiK40c+p6KWcmVJxP1y/P8yucJX5w==
X-Google-Smtp-Source: APBJJlGLY/JCFHLpqHxC1oKpUPyJvF7kYQiXWEFjX323i/90V6LtxLIpabl9qDoFSu4vgV6EadlDAQCk73/N3FIeTak=
X-Received: by 2002:a17:90a:8c4:b0:263:f521:da3e with SMTP id
 4-20020a17090a08c400b00263f521da3emr4431779pjn.2.1689803042099; Wed, 19 Jul
 2023 14:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689792825.git.tjeznach@rivosinc.com> <c33c24036c06c023947ecb47177da273569b3ac7.1689792825.git.tjeznach@rivosinc.com>
 <20230719-confront-grass-6d0eb304b94f@spud>
In-Reply-To: <20230719-confront-grass-6d0eb304b94f@spud>
From:   Tomasz Jeznach <tjeznach@rivosinc.com>
Date:   Wed, 19 Jul 2023 14:43:51 -0700
Message-ID: <CAH2o1u5pZQ6iKThFLgnn+_BBZ=j8fu91URYYxwWbfVt3OyerAA@mail.gmail.com>
Subject: Re: [PATCH 01/11] RISC-V: drivers/iommu: Add RISC-V IOMMU - Ziommu support.
To:     Conor Dooley <conor@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux@rivosinc.com,
        linux-kernel@vger.kernel.org, Sebastien Boeuf <seb@rivosinc.com>,
        iommu@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 1:50=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> Hey Tomasz,
>
> On Wed, Jul 19, 2023 at 12:33:45PM -0700, Tomasz Jeznach wrote:
> > The patch introduces skeleton IOMMU device driver implementation as def=
ined
>
> This commit message reads like a cover letter IMO. At whatever point
> you send a v2, could you re-write this focusing on what is done in the
> patch itself?
>

ack. will amend the commit message.


> Also, since I am not going to reply to any of these iommu driver patches
> in a meaningful capacity, please run checkpatch.pl on your work. There
> are well over 100 style etc complaints that it has highlighted. Sparse
> has also gone a bit nuts, with many warnings along the lines of:
> drivers/iommu/riscv/iommu.c:1568:29: warning: incorrect type in assignmen=
t (different base types)
> drivers/iommu/riscv/iommu.c:1568:29:    expected unsigned long long [user=
type] iohgatp
> drivers/iommu/riscv/iommu.c:1568:29:    got restricted __le64 [usertype]
>
> I can provide you the full list when the patchwork automation has run
> through the series.
>

Thank you, a list of used lint checkers definitely would help.


> Anyway, what I wanted to ask was whether it was valid to use the IOMMU
> in a system if Ziommu is not present in whatever the ISA extension
> communication mechanism is? Eg, riscv,isa or the ISA string property in
> the ACPI tables.
>

Yes, this has been pointed out to me already. As far as I can recall,
there was a discussion
at some point to introduce those as Ziommu extensions, later agreeing
not to call IOMMU
using ISA string conventions.  Will remove remaining occurrences of
Ziommu from the series.


> Thanks,
> Conor.
>
> > References:
> >  - [1] https://github.com/riscv-non-isa/riscv-iommu
> >  - [2] https://github.com/tjeznach/linux/tree/tjeznach/riscv-iommu
> >  - [3] https://github.com/tjeznach/qemu/tree/tjeznach/riscv-iommu
>
> FYI, we have the Link: tag/trailer for this.
>


Thanks,
- Tomasz
