Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9F37A0A8B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 18:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbjINQO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 12:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237860AbjINQOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 12:14:24 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99BB1BEA
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 09:14:20 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5776089b652so854265a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 09:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694708060; x=1695312860; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nE0aoCznO4lO1M+q3CiqWDdRUIUR9dxzkIRDNw4yOmY=;
        b=abzvKja3aGvCo6o865Rp0lbCjexuPjfhKCiVMCJlu3KBq9PM4+64/tbVaTHpqvA7EM
         4z6UOz/koh/+7aMAF2p4jIDGw6Pcrb1hnmp/fNpw+dsLcrQ+x/kUhvPtWc17FkyD27Zw
         kPS4QiHxZFEZkOvKrDTCudtiD+t0rVLzCM8hsppA4MxaRBjowsuEQNftIsO5ILm54dg8
         QQdMVTN5kYAqM4Nq3j0tWT/9BwgZtkrrLFWKWvNrDg0Mzc5d+9n4/p3EBZWNbGmA/bn3
         NMcg0qZG4fbvvz29RvGQpeHy0tSP6HsF4ud2KHW6Qa+9rshFdTazYOdjq8JhS+KeMQYy
         ZfpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694708060; x=1695312860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nE0aoCznO4lO1M+q3CiqWDdRUIUR9dxzkIRDNw4yOmY=;
        b=bbkNxDd/241ID6n/Cw2KZGjpr1ttzTFZ1YF8/BkrK1x7Ppsoe0nSnqgIR+pea5MS2G
         j7lkHsY1UoXR07CU3/jPGm3L7SF8MQjDcXk7DQb+09BDVvimANHVRSaQSqvTc13w6qe5
         lDNSXeaCnNQXrinXHNAkoDbGLEX/ppYb+IFXkQxDnBPc1Aj9J9I06ErFfmm+ZdQJqtMu
         wHpqEYh5MH71iTuliMi5xO/bGDY/Wr78ZBSSgYp/sdziCqJWG3094h9eNyLfgvDlzdNp
         ED7MzCcLk7jj2cnNzbiWO1Ww42dKuLA1S8+wjcPmxiNkXHCPHk6M6/PviX/Pvus+vhPd
         Scgg==
X-Gm-Message-State: AOJu0YwlBjIhS5WzFLJgl6I9cnrGrskVUxXpkJFZftCQPf2+GXLMZxEf
        kM9Y+WCPGHC7eSGZ+y1m+xchrIbJIR46361wMqs=
X-Google-Smtp-Source: AGHT+IGyECtUBVI/6INcM8krANysLZY5xSVet68OyZ4X0m4nqHcUmrkpbyiqT0B82hdqoIIv7vyLbg==
X-Received: by 2002:a17:90b:4b84:b0:26b:2538:d717 with SMTP id lr4-20020a17090b4b8400b0026b2538d717mr5811694pjb.25.1694708060108;
        Thu, 14 Sep 2023 09:14:20 -0700 (PDT)
Received: from ghost ([50.168.177.76])
        by smtp.gmail.com with ESMTPSA id j5-20020a17090aeb0500b0026b4ca7f62csm1504449pjz.39.2023.09.14.09.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 09:14:19 -0700 (PDT)
Date:   Thu, 14 Sep 2023 12:14:16 -0400
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        David Laight <David.Laight@aculab.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v4 4/5] riscv: Vector checksum library
Message-ID: <ZQMxWPczYeDMCokP@ghost>
References: <20230911-optimize_checksum-v4-0-77cc2ad9e9d7@rivosinc.com>
 <20230911-optimize_checksum-v4-4-77cc2ad9e9d7@rivosinc.com>
 <20230914-pennant-obligate-db3adf056281@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914-pennant-obligate-db3adf056281@wendy>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 01:46:29PM +0100, Conor Dooley wrote:
> On Mon, Sep 11, 2023 at 03:57:14PM -0700, Charlie Jenkins wrote:
> > This patch is not ready for merge as vector support in the kernel is
> > limited. However, the code has been tested in QEMU so the algorithms
> > do work. This code requires the kernel to be compiled with C vector
> > support, but that is not yet possible. It is written in assembly
> > rather than using the GCC vector instrinsics because they did not
> > provide optimal code.
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  arch/riscv/lib/csum.c | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 92 insertions(+)
> > 
> > diff --git a/arch/riscv/lib/csum.c b/arch/riscv/lib/csum.c
> > index 47d98c51bab2..eb4596fc7f5b 100644
> > --- a/arch/riscv/lib/csum.c
> > +++ b/arch/riscv/lib/csum.c
> > @@ -12,6 +12,10 @@
> >  
> >  #include <net/checksum.h>
> >  
> > +#ifdef CONFIG_RISCV_ISA_V
> > +#include <riscv_vector.h>
> 
> What actually includes this header, I don't see it in either Andy's
> in-kernel vector series or Bjorn's blake2 one.
> Can you link to the pre-requisites in your cover letter please.
> 
> Thanks,
> Conor.

It is defined here:
https://github.com/riscv-non-isa/rvv-intrinsic-doc/blob/main/doc/rvv-intrinsic-spec.adoc.
The header is for the vector intrinsics that are supported by llvm and
gcc.

- Charlie

