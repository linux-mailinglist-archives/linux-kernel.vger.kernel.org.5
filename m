Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9F379DE4E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 04:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237682AbjIMCiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 22:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjIMCiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 22:38:11 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CDB1713
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 19:38:07 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68fb98745c1so2311227b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 19:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694572687; x=1695177487; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oCV0SJs4aaH7C3SBh6saHJSAUm4Tutw8CuZ1ZBrfFjc=;
        b=DpDcbfKS58KFJQiiL2xMRM0dcCcrsAqGro/1GHQ+xI+tfJdOVV2qO0iP8SFz1/YAnZ
         e6JuFS3qPGh9ea1EbYPpZ5/A17DYfKxZMQHddBka+NFF9DZMSwxQeVPzTlZ5a3/47ElE
         kPQ/fGtRYMDd8HLwurO/mCwi8tkTt/IP0/vfojptYiQPxk6cEuXWr4TsrlbKnalb+rqP
         fACpuHehdQTCpSyad/PezqhDhbMIOiPutrYVMTZb9OwKiAKwgRc8GE4z1eOSzJ5eZkk2
         s0PcNL4W/UhlqFBPtW3Qeh0QAaXWhbqMuup9nlP8qjZaMK0D3FVhM3CAGthLWdTS8Y98
         x5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694572687; x=1695177487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oCV0SJs4aaH7C3SBh6saHJSAUm4Tutw8CuZ1ZBrfFjc=;
        b=e2oWNjZCpcgd2Shx/aeqmI4RMjYS1BGCGNdphjKWWdaTQgGWQVsB7rxJDrvwvGr9EC
         KCot7MsYsE+sMRnow8tkNareJk1ozC6nIliOdz8F5BEsxAGCjnnFUSYvg6UG1lTt3Mj6
         9Q+0CLhwGrZmba6kKF/DwUarxfRrGzNnp9EFTXxKHgJ5CPd9OWwhJGy6Agw0/cx6DtJv
         rdYpPHCYvoNuNODQXYyFmYePtLSiRQNYsvm+HWkReEdx/HSuLSW2PB+1MdzyLmOcOI+s
         XiKjU+u38UOGrV3C3/G66Vvx41PzFB5o8N/UQMLTkkvoSQSgd3ThL6pdZr/n5h6PPPSI
         3uNw==
X-Gm-Message-State: AOJu0YxYsQm9rTSmvr94avVwMT6X4tE8qQseeilQ2Tef/DQKeqT/BYVr
        I47gpFkSNsyLdgXHc8b8uO/5+A==
X-Google-Smtp-Source: AGHT+IH2B7XBScq2iYXM8ny2G8opApTtyTQuJqi3nFFRqw9P1cRROod8LeDTStUMGhmitD2aoTWP6g==
X-Received: by 2002:a05:6a20:b70a:b0:154:fb34:5f23 with SMTP id fg10-20020a056a20b70a00b00154fb345f23mr1049772pzb.8.1694572686918;
        Tue, 12 Sep 2023 19:38:06 -0700 (PDT)
Received: from ghost ([50.168.177.76])
        by smtp.gmail.com with ESMTPSA id j9-20020a170902da8900b001bbbbda70ccsm9157674plx.158.2023.09.12.19.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 19:38:06 -0700 (PDT)
Date:   Tue, 12 Sep 2023 19:38:03 -0700
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        David Laight <David.Laight@aculab.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v4 1/5] riscv: Checksum header
Message-ID: <ZQEgi9v1gt6MlkDv@ghost>
References: <20230911-optimize_checksum-v4-0-77cc2ad9e9d7@rivosinc.com>
 <20230911-optimize_checksum-v4-1-77cc2ad9e9d7@rivosinc.com>
 <CAJM55Z-kj8eWKvR32At4kx+PPPn9OMaR88BhEqppQHSL03n50Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJM55Z-kj8eWKvR32At4kx+PPPn9OMaR88BhEqppQHSL03n50Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 03:24:29AM -0700, Emil Renner Berthing wrote:
> Charlie Jenkins wrote:
> > Provide checksum algorithms that have been designed to leverage riscv
> > instructions such as rotate. In 64-bit, can take advantage of the larger
> > register to avoid some overflow checking.
> >
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  arch/riscv/include/asm/checksum.h | 95 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 95 insertions(+)
> >
> > diff --git a/arch/riscv/include/asm/checksum.h b/arch/riscv/include/asm/checksum.h
> > new file mode 100644
> > index 000000000000..0d7fc8275a5e
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/checksum.h
> > @@ -0,0 +1,95 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * IP checksum routines
> > + *
> > + * Copyright (C) 2023 Rivos Inc.
> > + */
> > +#ifndef __ASM_RISCV_CHECKSUM_H
> > +#define __ASM_RISCV_CHECKSUM_H
> > +
> > +#include <linux/in6.h>
> > +#include <linux/uaccess.h>
> > +
> > +#ifdef CONFIG_32BIT
> > +typedef unsigned int csum_t;
> > +#else
> > +typedef unsigned long csum_t;
> > +#endif
> 
> Hi Charlie,
> 
> Isn't unsigned long already 32bit on 32bit RISC-V, so why is this #ifdef
> needed?
Oh, I wasn't sure so I ran sizeof(long) in qemu-system-riscv32 and it
gave me 8 so assumed a long was 8 bytes. Do you think it would make what
is going on more clear if I use u32 and u64 or would you recommend just
using long?
> 
> > +
> > +/*
> > + *	Fold a partial checksum without adding pseudo headers
> > + */
> > +static inline __sum16 csum_fold(__wsum sum)
> > +{
> > +	return (~sum - ror32(sum, 16)) >> 16;
> > +}
> > +
> > +#define csum_fold csum_fold
> > +
> > +/*
> > + * Quickly compute an IP checksum with the assumption that IPv4 headers will
> > + * always be in multiples of 32-bits, and have an ihl of at least 5.
> > + * @ihl is the number of 32 bit segments and must be greater than or equal to 5.
> > + * @iph is assumed to be word aligned.
> > + */
> > +static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
> > +{
> > +	csum_t csum = 0;
> > +	int pos = 0;
> > +
> > +	do {
> > +		csum += ((const unsigned int *)iph)[pos];
> > +		if (IS_ENABLED(CONFIG_32BIT))
> > +			csum += csum < ((const unsigned int *)iph)[pos];
> > +	} while (++pos < ihl);
> > +
> > +	/*
> > +	 * ZBB only saves three instructions on 32-bit and five on 64-bit so not
> > +	 * worth checking if supported without Alternatives.
> > +	 */
> > +	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
> > +	    IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
> > +		csum_t fold_temp;
> > +
> > +		asm_volatile_goto(ALTERNATIVE("j %l[no_zbb]", "nop", 0,
> > +					      RISCV_ISA_EXT_ZBB, 1)
> > +		    :
> > +		    :
> > +		    :
> > +		    : no_zbb);
> > +
> > +		if (IS_ENABLED(CONFIG_32BIT)) {
> > +			asm(".option push				\n\
> > +			.option arch,+zbb				\n\
> > +				not	%[fold_temp], %[csum]		\n\
> > +				rori	%[csum], %[csum], 16		\n\
> > +				sub	%[csum], %[fold_temp], %[csum]	\n\
> > +			.option pop"
> > +			: [csum] "+r" (csum), [fold_temp] "=&r" (fold_temp));
> > +		} else {
> > +			asm(".option push				\n\
> > +			.option arch,+zbb				\n\
> > +				rori	%[fold_temp], %[csum], 32	\n\
> > +				add	%[csum], %[fold_temp], %[csum]	\n\
> > +				srli	%[csum], %[csum], 32		\n\
> > +				not	%[fold_temp], %[csum]		\n\
> > +				roriw	%[csum], %[csum], 16		\n\
> > +				subw	%[csum], %[fold_temp], %[csum]	\n\
> > +			.option pop"
> > +			: [csum] "+r" (csum), [fold_temp] "=&r" (fold_temp));
> > +		}
> > +		return csum >> 16;
> > +	}
> > +no_zbb:
> > +#ifndef CONFIG_32BIT
> > +		csum += (csum >> 32) | (csum << 32);
> > +		csum >>= 32;
> 
> The indentation seems off here.
> 
> /Emil
> 
> > +#endif
> > +	return csum_fold((__force __wsum)csum);
> > +}
> > +
> > +#define ip_fast_csum ip_fast_csum
> > +
> > +#include <asm-generic/checksum.h>
> > +
> > +#endif // __ASM_RISCV_CHECKSUM_H
> >
> > --
> > 2.42.0
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.inradead.org/mailman/listinfo/linux-riscv
