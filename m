Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175F97A0F65
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 23:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjINVAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 17:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjINVAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 17:00:00 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716141FE5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 13:59:56 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bc0d39b52cso12100785ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 13:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694725196; x=1695329996; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PqBlNu9ahVy/7YHYFjcq9HUnHU67jAPxajNa21Ov6Gk=;
        b=qaHg0MbNLMTLmooVOLDpTsXh2l/bCDKLRcRz7DhscnIhfDRwV6JKhXzIXDHV74XD8K
         To8ooatuURQ/v7tx3cYF1gYTbFZUXnX8RgwCvitwokPOPjn53vea88q4MLjwYcT0DPZP
         pUct945JueJJvBbKweXP2TO0P9uAQ+GefVhZA5ttIxRkN8OphVlzJlH1nuNUXwcMo16L
         SyqbRwb5kn1gcBDV3ZDP+zeztJ0VKz23MWaDyF7KsRa7sEYieCismz/OkGC9EHcRdRJK
         wHGgdvdD8biUNNy6iX3she71zyWxNfOl2UNcG86qmyBE6KYNOVr25AIOI5Qc+eASmZ3H
         ZGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694725196; x=1695329996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PqBlNu9ahVy/7YHYFjcq9HUnHU67jAPxajNa21Ov6Gk=;
        b=EaR2VcOpB6H9QsOPhfwaU73sLRM3I8KJk+XG7Xqcvlfy4H5cdL/5JnNo66+1qDkMfr
         FdqhTfv6ovxFETNBIpGDNATKQuCOxN/C7hnSPe5ZP8vTZh5SBXeULl5R3rqrcoOo6j0Z
         rPtisgrPsWxt1ySaYfTl2Qm7MYFohxR8EJuXO3PN227VF1O42L3kD1g4xjjqt2efVALH
         lQnmHSRUO72aF6xGGazDH/OtpjGiq8w5L8P0PVhpEuyE90Nb1LeGdILNo7md7wrFuOxS
         tAx2EJJmze/tuNwpkq+7HbbT1oU4ZGHeax+BpRqNYPSrkkmzllYlcbRAHwuTBsPAICKY
         ahdA==
X-Gm-Message-State: AOJu0YxiEFp150/9Gi/pE0Gk+Wpij1AizExWgD+a254I8pDQ0K+RnMei
        D6xgJ7z9cpHFO/W++SxJaLDwHw==
X-Google-Smtp-Source: AGHT+IGYe5sd6tgZbPC5u/WtsWbDRqJaNh/t/Oh7nsHT60XmM92v2/qjaUebFtJkzRRAm7IlV9WY6w==
X-Received: by 2002:a17:902:8693:b0:1b5:561a:5ca9 with SMTP id g19-20020a170902869300b001b5561a5ca9mr6133440plo.50.1694725195941;
        Thu, 14 Sep 2023 13:59:55 -0700 (PDT)
Received: from ghost ([50.168.177.76])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902748c00b001b246dcffb7sm2003945pll.300.2023.09.14.13.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 13:59:55 -0700 (PDT)
Date:   Thu, 14 Sep 2023 16:59:52 -0400
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
Message-ID: <ZQN0SBwhYwDQHGF+@ghost>
References: <20230911-optimize_checksum-v4-0-77cc2ad9e9d7@rivosinc.com>
 <20230911-optimize_checksum-v4-4-77cc2ad9e9d7@rivosinc.com>
 <20230914-pennant-obligate-db3adf056281@wendy>
 <ZQMxWPczYeDMCokP@ghost>
 <20230914-hardiness-uninjured-6818bfb40b4f@spud>
 <ZQNC7mAYKfuWLUVr@ghost>
 <20230914-scrawny-aviation-03ec222a46b2@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914-scrawny-aviation-03ec222a46b2@spud>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 06:36:42PM +0100, Conor Dooley wrote:
> On Thu, Sep 14, 2023 at 01:29:18PM -0400, Charlie Jenkins wrote:
> > On Thu, Sep 14, 2023 at 05:29:29PM +0100, Conor Dooley wrote:
> > > On Thu, Sep 14, 2023 at 12:14:16PM -0400, Charlie Jenkins wrote:
> > > > On Thu, Sep 14, 2023 at 01:46:29PM +0100, Conor Dooley wrote:
> > > > > On Mon, Sep 11, 2023 at 03:57:14PM -0700, Charlie Jenkins wrote:
> > > > > > This patch is not ready for merge as vector support in the kernel is
> > > > > > limited. However, the code has been tested in QEMU so the algorithms
> > > > > > do work. This code requires the kernel to be compiled with C vector
> > > > > > support, but that is not yet possible. It is written in assembly
> > > > > > rather than using the GCC vector instrinsics because they did not
> > > > > > provide optimal code.
> > > > > > 
> > > > > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > > > > ---
> > > > > >  arch/riscv/lib/csum.c | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++
> > > > > >  1 file changed, 92 insertions(+)
> > > > > > 
> > > > > > diff --git a/arch/riscv/lib/csum.c b/arch/riscv/lib/csum.c
> > > > > > index 47d98c51bab2..eb4596fc7f5b 100644
> > > > > > --- a/arch/riscv/lib/csum.c
> > > > > > +++ b/arch/riscv/lib/csum.c
> > > > > > @@ -12,6 +12,10 @@
> > > > > >  
> > > > > >  #include <net/checksum.h>
> > > > > >  
> > > > > > +#ifdef CONFIG_RISCV_ISA_V
> > > > > > +#include <riscv_vector.h>
> > > > > 
> > > > > What actually includes this header, I don't see it in either Andy's
> > > > > in-kernel vector series or Bjorn's blake2 one.
> > > > > Can you link to the pre-requisites in your cover letter please.
> > > > > 
> > > > > Thanks,
> > > > > Conor.
> > > > 
> > > > It is defined here:
> > > > https://github.com/riscv-non-isa/rvv-intrinsic-doc/blob/main/doc/rvv-intrinsic-spec.adoc.
> > > > The header is for the vector intrinsics that are supported by llvm and
> > > > gcc.
> > > 
> > > Well, whatever you're doing with it does not work, producing 3600 or so
> > > fatal errors during compilation, all saying:
> > > ../arch/riscv/include/asm/checksum.h:14:10: fatal error: riscv_vector.h: No such file or directory
> > > 
> > > Do you have some makefile hack somewhere that's not part of this
> > > patchset? Also, I'm dumb, but can you show me where are the actual
> > > intrinsics are being used in this patch anyway? I just seem some
> > > types & asm.
> > > 
> > > Thanks,
> > > Conor.
> > > 
> > 
> > Intrinsics are needed for the vector types. Vector types are needed to
> > get the inline asm to select vector registers at compile time. I could
> > manually select vector registers to use but that is not ideal. In order
> > to get this to work, vector has to be enabled in the compiler. This
> > patch will not compile right now, but since people are working on vector
> > I was hoping that it would be possible in the future. Palmer recommended
> > that I just put up this patch for now since I had the code, but only the
> > non-vector versions should be candidates for release for now.
> 
> I see. I was pretty unclear to me anyway what the craic was, you should
> probably note that the build failures from here onwards are
> known-broken. If you want that header, I guess you probably need to
> have v set in -march?
> If so, the in-kernel vector patches that have been posted do not do that.
> Oh-so-far from an expert on what is a safe way to do these kinda things
> though, sadly.

It seems like more than just enabling v in the march will need to be
done. Because linux uses -nostdinc the header file won't be included.
After doing some research it also seems like llvm and gcc do not share
inline asm constraints. llvm is missing "vd" to specify a register that
is not a mask register. I think I will drop these vector patches for
now since there seems to be more work than I expected to get this
functional.

- Charlie
