Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463F77A0BBE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 19:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238934AbjINR31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 13:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbjINR3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 13:29:25 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C4B1FF0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 10:29:21 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68fac346f6aso1083747b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 10:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694712561; x=1695317361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jq2pj3vNh3ov1lqVemerrvtZo/V9/5ZCRIvFVvmuS5o=;
        b=ib8u2RF63yvQM87+8A2339BRCaw6AOlI12wWM2FA8fSJwG7c0Vd8sJvVAkDuPN3vr0
         23SmBpWx6ZYubavqdojxKgY1UX49w++9OBm4IkD+z4ciBeYKkTRo5QiU0cgvRz9VqoFR
         OteuLWLyyxb/G1+dqWzyu+VZQLr/rxetVXZ4s3Mk3HdxJRyVZA3vumfW/uzfKHIAi565
         BKE8vDUz7NOZoUPhfphQj6ujDsYew5ZDusmQpAgqNYGYo9N7yb02ToUV5Bs3l3Gznr8P
         3DshY8NBxyqWC/bGbTLoSEkfD5//wG7/u4Z0ObX0EkyWzJF08AIzk/bBlWDkbj7TUnOY
         6XoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694712561; x=1695317361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jq2pj3vNh3ov1lqVemerrvtZo/V9/5ZCRIvFVvmuS5o=;
        b=jEDVSlYA94KwKwnXhWXSOq21KN+MNsU450vsnax83Vxf+MpnC4hJhADM2C6NFTWi84
         aLIOkmcTEuGvtDnBMH4at4QyCpmQpCZOB8fE0h747sK1b4mstJAo71ITgINevT1cvLz2
         8D6UqjT1I05n6QKYP0/+DpgTZ2RbZS+lX9a7cDLkfp4Hl6I7d52H+XdxfTDeq6Ulwcxn
         nutW32mn/YYqQVRVsMW7ZysTCymoJO2of4pqppCESGPAf9CAJX7OGTTizHiXHrNaSWRI
         ha6xu433Cgztc1qQLWuT6DhvBv6/RjAkqRkHyxMwEZlF0YGxar7SBhZzC8/XCZ2UmUa/
         kH4A==
X-Gm-Message-State: AOJu0YyeEhzdvdDheVr9IS3UvyuBQ959AXrLeTpu503zghQqudcNX3LT
        eEB+D2ZGTYGsszDodX5hod5MtQ==
X-Google-Smtp-Source: AGHT+IH9labNFQs2EdZody5WEKzNQjUN5CFr8g2eOwpNkImj03tG14zapLjJWh6adLEeSkJxfd2kUQ==
X-Received: by 2002:a05:6a00:248a:b0:68c:dcc:3578 with SMTP id c10-20020a056a00248a00b0068c0dcc3578mr6755649pfv.25.1694712561275;
        Thu, 14 Sep 2023 10:29:21 -0700 (PDT)
Received: from ghost ([50.168.177.76])
        by smtp.gmail.com with ESMTPSA id d21-20020aa78695000000b006889511ab14sm1582547pfo.37.2023.09.14.10.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 10:29:20 -0700 (PDT)
Date:   Thu, 14 Sep 2023 13:29:18 -0400
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Samuel Holland <samuel.holland@sifive.com>,
        David Laight <David.Laight@aculab.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v4 4/5] riscv: Vector checksum library
Message-ID: <ZQNC7mAYKfuWLUVr@ghost>
References: <20230911-optimize_checksum-v4-0-77cc2ad9e9d7@rivosinc.com>
 <20230911-optimize_checksum-v4-4-77cc2ad9e9d7@rivosinc.com>
 <20230914-pennant-obligate-db3adf056281@wendy>
 <ZQMxWPczYeDMCokP@ghost>
 <20230914-hardiness-uninjured-6818bfb40b4f@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914-hardiness-uninjured-6818bfb40b4f@spud>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 05:29:29PM +0100, Conor Dooley wrote:
> On Thu, Sep 14, 2023 at 12:14:16PM -0400, Charlie Jenkins wrote:
> > On Thu, Sep 14, 2023 at 01:46:29PM +0100, Conor Dooley wrote:
> > > On Mon, Sep 11, 2023 at 03:57:14PM -0700, Charlie Jenkins wrote:
> > > > This patch is not ready for merge as vector support in the kernel is
> > > > limited. However, the code has been tested in QEMU so the algorithms
> > > > do work. This code requires the kernel to be compiled with C vector
> > > > support, but that is not yet possible. It is written in assembly
> > > > rather than using the GCC vector instrinsics because they did not
> > > > provide optimal code.
> > > > 
> > > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > > ---
> > > >  arch/riscv/lib/csum.c | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 92 insertions(+)
> > > > 
> > > > diff --git a/arch/riscv/lib/csum.c b/arch/riscv/lib/csum.c
> > > > index 47d98c51bab2..eb4596fc7f5b 100644
> > > > --- a/arch/riscv/lib/csum.c
> > > > +++ b/arch/riscv/lib/csum.c
> > > > @@ -12,6 +12,10 @@
> > > >  
> > > >  #include <net/checksum.h>
> > > >  
> > > > +#ifdef CONFIG_RISCV_ISA_V
> > > > +#include <riscv_vector.h>
> > > 
> > > What actually includes this header, I don't see it in either Andy's
> > > in-kernel vector series or Bjorn's blake2 one.
> > > Can you link to the pre-requisites in your cover letter please.
> > > 
> > > Thanks,
> > > Conor.
> > 
> > It is defined here:
> > https://github.com/riscv-non-isa/rvv-intrinsic-doc/blob/main/doc/rvv-intrinsic-spec.adoc.
> > The header is for the vector intrinsics that are supported by llvm and
> > gcc.
> 
> Well, whatever you're doing with it does not work, producing 3600 or so
> fatal errors during compilation, all saying:
> ../arch/riscv/include/asm/checksum.h:14:10: fatal error: riscv_vector.h: No such file or directory
> 
> Do you have some makefile hack somewhere that's not part of this
> patchset? Also, I'm dumb, but can you show me where are the actual
> intrinsics are being used in this patch anyway? I just seem some
> types & asm.
> 
> Thanks,
> Conor.
> 

Intrinsics are needed for the vector types. Vector types are needed to
get the inline asm to select vector registers at compile time. I could
manually select vector registers to use but that is not ideal. In order
to get this to work, vector has to be enabled in the compiler. This
patch will not compile right now, but since people are working on vector
I was hoping that it would be possible in the future. Palmer recommended
that I just put up this patch for now since I had the code, but only the
non-vector versions should be candidates for release for now.

- Charlie

