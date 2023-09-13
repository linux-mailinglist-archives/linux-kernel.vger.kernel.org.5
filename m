Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59E879E368
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 11:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239245AbjIMJT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 05:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238104AbjIMJTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 05:19:51 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0739F19B4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 02:19:47 -0700 (PDT)
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D8AF93F674
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 09:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1694596785;
        bh=QtCA0UtRzCSjKL8jQ8LuLqlWRxghJL7WuWVY8knUOsQ=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=X5Fny7FYuObTIPO3NToF+rc3XSp3Rnty3cIBwb78GkwpNkJ2QYFa2ijHLelNrU4WT
         T9Ltewab6+841dU0xHDGK9nHpm7wU7pM/7t5z1gmsCtjEMfjVMhJcJiSBs1s3nC78U
         suvLXt9AiKCE3YCxvuGNWHL5PCwu6kvJQBGjBOl1HuvDtYlNEL+ENyQXa2b6cm4ljG
         UEY1lb1xMQ4hvmKoiakBfA9i1zYnek9i/272Dr0HvpfVFN4kTldmx4bp8I+7ll7vQM
         eCsxmxT7zuwgEIUxUwiIdrxg8eGgAnWU8FVfJNTR5LBZw9+gHqvaO5X0TIVnrYzgn5
         QPVaixAI8+DoQ==
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4131d4bc82dso79989241cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 02:19:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694596784; x=1695201584;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QtCA0UtRzCSjKL8jQ8LuLqlWRxghJL7WuWVY8knUOsQ=;
        b=bc/YawEnnYDo0nhT98KTgzy+Zqh76wcGY8s1yU/AY1rQhokgVrHzSqXcN93AGtBo1+
         Lu+y4gdwW9FI6n4t6j05xF9mRzsUG4SRajIWJKb/ENhBaeRCFALyCHCwlxZekfeePFV7
         GdaAcn9vAHTyt3QcqEEHSHuXV4UGr+66oPUrTtzr4KDBtBP1+aSVhJHs+LKsT2t6dEMi
         xAJR3kB7Gu6cPcStk5muYCpIMNuuKMzXWaPfJm+tmDJtDuLdjPf/dNPbWgnHrLH+lcum
         IpDIAOy++JXIhAD7Wea3af8D5IztfOHwGblYsCEn6EqNbpt0qtv+1ilFsT6ZXq3O5QOF
         Y1Rg==
X-Gm-Message-State: AOJu0YzQxO0a8c+5SjrGH4wdbU8JdOHMVqOn8UzQSurR3Wof+gCSodbo
        F49stRNxj5Nl4ud0lyOfIQK/GU7pXnvVqkfcu1uNl7D24S/AYC9mjaBDyAVlvkzdogkr9l6DsuQ
        GW4YeJZeU/6Rq8DaAAzd0A2WpRcgQ2uEFJUn7r+UgkqQ73MjAaKF6E/5z6w==
X-Received: by 2002:ac8:5e50:0:b0:410:8873:aca with SMTP id i16-20020ac85e50000000b0041088730acamr1946438qtx.52.1694596784429;
        Wed, 13 Sep 2023 02:19:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEPEk+g8sSB+NpwuSLALIeaLj2VlTbMgY40JOMaj8TmrfLzRbqL3eZIJfaog8DKhpLdeY+wYP5elUu40uvzLk=
X-Received: by 2002:ac8:5e50:0:b0:410:8873:aca with SMTP id
 i16-20020ac85e50000000b0041088730acamr1946425qtx.52.1694596784130; Wed, 13
 Sep 2023 02:19:44 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Sep 2023 02:19:43 -0700
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <ZQEgi9v1gt6MlkDv@ghost>
References: <20230911-optimize_checksum-v4-0-77cc2ad9e9d7@rivosinc.com>
 <20230911-optimize_checksum-v4-1-77cc2ad9e9d7@rivosinc.com>
 <CAJM55Z-kj8eWKvR32At4kx+PPPn9OMaR88BhEqppQHSL03n50Q@mail.gmail.com> <ZQEgi9v1gt6MlkDv@ghost>
Mime-Version: 1.0
Date:   Wed, 13 Sep 2023 02:19:43 -0700
Message-ID: <CAJM55Z9SC0ET=tBJ7s0pz+L4tRSC02yogsWtmsuhr=-jf04yjQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] riscv: Checksum header
To:     Charlie Jenkins <charlie@rivosinc.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        David Laight <David.Laight@aculab.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Charlie Jenkins wrote:
> On Tue, Sep 12, 2023 at 03:24:29AM -0700, Emil Renner Berthing wrote:
> > Charlie Jenkins wrote:
> > > Provide checksum algorithms that have been designed to leverage riscv
> > > instructions such as rotate. In 64-bit, can take advantage of the larger
> > > register to avoid some overflow checking.
> > >
> > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > ---
> > >  arch/riscv/include/asm/checksum.h | 95 +++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 95 insertions(+)
> > >
> > > diff --git a/arch/riscv/include/asm/checksum.h b/arch/riscv/include/asm/checksum.h
> > > new file mode 100644
> > > index 000000000000..0d7fc8275a5e
> > > --- /dev/null
> > > +++ b/arch/riscv/include/asm/checksum.h
> > > @@ -0,0 +1,95 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/*
> > > + * IP checksum routines
> > > + *
> > > + * Copyright (C) 2023 Rivos Inc.
> > > + */
> > > +#ifndef __ASM_RISCV_CHECKSUM_H
> > > +#define __ASM_RISCV_CHECKSUM_H
> > > +
> > > +#include <linux/in6.h>
> > > +#include <linux/uaccess.h>
> > > +
> > > +#ifdef CONFIG_32BIT
> > > +typedef unsigned int csum_t;
> > > +#else
> > > +typedef unsigned long csum_t;
> > > +#endif
> >
> > Hi Charlie,
> >
> > Isn't unsigned long already 32bit on 32bit RISC-V, so why is this #ifdef
> > needed?
> Oh, I wasn't sure so I ran sizeof(long) in qemu-system-riscv32 and it
> gave me 8 so assumed a long was 8 bytes. Do you think it would make what
> is going on more clear if I use u32 and u64 or would you recommend just
> using long?

Yeah, it doesn't seem like csum_t is used anywhere else, so I'd just use
unsigned long if all you want is a register sized unsigned value. It'll be more
familiar and easier to read for most people.

> >
> > > +
> > > +/*
> > > + *	Fold a partial checksum without adding pseudo headers
> > > + */
> > > +static inline __sum16 csum_fold(__wsum sum)
> > > +{
> > > +	return (~sum - ror32(sum, 16)) >> 16;
> > > +}
> > > +
> > > +#define csum_fold csum_fold
> > > +
> > > +/*
> > > + * Quickly compute an IP checksum with the assumption that IPv4 headers will
> > > + * always be in multiples of 32-bits, and have an ihl of at least 5.
> > > + * @ihl is the number of 32 bit segments and must be greater than or equal to 5.
> > > + * @iph is assumed to be word aligned.
> > > + */
> > > +static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
> > > +{
> > > +	csum_t csum = 0;
> > > +	int pos = 0;
> > > +
> > > +	do {
> > > +		csum += ((const unsigned int *)iph)[pos];
> > > +		if (IS_ENABLED(CONFIG_32BIT))
> > > +			csum += csum < ((const unsigned int *)iph)[pos];
> > > +	} while (++pos < ihl);
> > > +
> > > +	/*
> > > +	 * ZBB only saves three instructions on 32-bit and five on 64-bit so not
> > > +	 * worth checking if supported without Alternatives.
> > > +	 */
> > > +	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
> > > +	    IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
> > > +		csum_t fold_temp;
> > > +
> > > +		asm_volatile_goto(ALTERNATIVE("j %l[no_zbb]", "nop", 0,
> > > +					      RISCV_ISA_EXT_ZBB, 1)
> > > +		    :
> > > +		    :
> > > +		    :
> > > +		    : no_zbb);
> > > +
> > > +		if (IS_ENABLED(CONFIG_32BIT)) {
> > > +			asm(".option push				\n\
> > > +			.option arch,+zbb				\n\
> > > +				not	%[fold_temp], %[csum]		\n\
> > > +				rori	%[csum], %[csum], 16		\n\
> > > +				sub	%[csum], %[fold_temp], %[csum]	\n\
> > > +			.option pop"
> > > +			: [csum] "+r" (csum), [fold_temp] "=&r" (fold_temp));
> > > +		} else {
> > > +			asm(".option push				\n\
> > > +			.option arch,+zbb				\n\
> > > +				rori	%[fold_temp], %[csum], 32	\n\
> > > +				add	%[csum], %[fold_temp], %[csum]	\n\
> > > +				srli	%[csum], %[csum], 32		\n\
> > > +				not	%[fold_temp], %[csum]		\n\
> > > +				roriw	%[csum], %[csum], 16		\n\
> > > +				subw	%[csum], %[fold_temp], %[csum]	\n\
> > > +			.option pop"
> > > +			: [csum] "+r" (csum), [fold_temp] "=&r" (fold_temp));
> > > +		}
> > > +		return csum >> 16;
> > > +	}
> > > +no_zbb:
> > > +#ifndef CONFIG_32BIT
> > > +		csum += (csum >> 32) | (csum << 32);
> > > +		csum >>= 32;
> >
> > The indentation seems off here.
> >
> > /Emil
> >
> > > +#endif
> > > +	return csum_fold((__force __wsum)csum);
> > > +}
> > > +
> > > +#define ip_fast_csum ip_fast_csum
> > > +
> > > +#include <asm-generic/checksum.h>
> > > +
> > > +#endif // __ASM_RISCV_CHECKSUM_H
> > >
> > > --
> > > 2.42.0
> > >
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.inradead.org/mailman/listinfo/linux-riscv
