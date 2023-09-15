Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72537A224A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 17:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235968AbjIOPZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 11:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235867AbjIOPZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 11:25:36 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A197AE50
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 08:25:31 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68fb98745c1so1876359b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 08:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694791531; x=1695396331; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+nRnWJVlyVm74KJSvGTBFuTkn4CEKHbiJVsCA3/dFpo=;
        b=HvgmqJSI1NuK7U5VuZNulKhQpNqXCPwgksptTcEgKaCZybLLs6+F7mcezrvvUGhVqR
         cbfKZGaViMfH/FVcq4q+IzX3vRkER/YnJpa+EWwe41UXLmF3on8n3o9DVZvw1OrvKILf
         wFwUmENTanLAJ1RfDnY0/U16kht91ErmZqgCRA3Xb8Qq25Q4gCwNz3pr3qn+pMCbaOLf
         wiAPGQRtZFnx0A5GocfeYF7Xm/wDOnu9O8lGed0B33tVVlaVFHRAv47VI7sVAvnmHiNH
         LRjYufgCXPXe7H7sz/cXSTp/FqwF96ixokTukyrhhpoJBg+pYOs1f+rRIc4lRVJbRMKD
         mxjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694791531; x=1695396331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+nRnWJVlyVm74KJSvGTBFuTkn4CEKHbiJVsCA3/dFpo=;
        b=pgXPgjZESqgjlbJRDarcgPVnLOM2W+s6FTL+2N0gihcPeT8CJ7I3hSY7QjVFQosnLT
         ya5/S+G7wqZi0Qw7QpaZ+quh1oiYKMHDK6vmOirED1zGP2UHWENQpClbkJ9UD/OI/j/o
         4PXIniNpJRaz7EgB87RuqIQ5WIavDcClhThLvE6vdkYmGe0McQznK5MMFSmFSOxaxHUc
         1dFBwpjHEU5zkCh6GVyt7tb92DVw8TAUP2L6Biqqfak9JFyyj2RcZfwC6SK5mLITJoIJ
         Pzi1NzBr8JlZNCe6DIO7wNCr81hGuwkv0DvLNAwLlqMhAJSsPOnzuWAwKRkX2wIs4hgm
         r0+Q==
X-Gm-Message-State: AOJu0Yy4bBVhiaoXmKB0jiLUe5f9SRdleP70zcXASU5M0AJijRzJQy6r
        o2IiuXdhC0F/82FBTWV8FaUyJEefADqroOmy0Sc=
X-Google-Smtp-Source: AGHT+IFWSAXm5J+VpZpxQapfS9Kf+W8q+RHFHOu4Swl+30DSpgpGlA/Al9XKHt9qI0P03NLRXI3ANw==
X-Received: by 2002:a05:6a00:a1f:b0:68f:e810:e87e with SMTP id p31-20020a056a000a1f00b0068fe810e87emr2318985pfh.31.1694791530991;
        Fri, 15 Sep 2023 08:25:30 -0700 (PDT)
Received: from ghost ([50.168.177.76])
        by smtp.gmail.com with ESMTPSA id x53-20020a056a000bf500b0069029a2206bsm3110322pfu.47.2023.09.15.08.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 08:25:30 -0700 (PDT)
Date:   Fri, 15 Sep 2023 11:25:27 -0400
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        David Laight <David.Laight@aculab.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v5 2/4] riscv: Checksum header
Message-ID: <ZQR3Z2oUJYf3jSFl@ghost>
References: <20230914-optimize_checksum-v5-0-c95b82a2757e@rivosinc.com>
 <20230914-optimize_checksum-v5-2-c95b82a2757e@rivosinc.com>
 <CAJM55Z8Pjbu8uCqh9Heaj=ScuAoYgqsEzFuxwBUCfiZmMmk+KQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJM55Z8Pjbu8uCqh9Heaj=ScuAoYgqsEzFuxwBUCfiZmMmk+KQ@mail.gmail.com>
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 03:07:39AM -0700, Emil Renner Berthing wrote:
> Charlie Jenkins wrote:
> > Provide checksum algorithms that have been designed to leverage riscv
> > instructions such as rotate. In 64-bit, can take advantage of the larger
> > register to avoid some overflow checking.
> >
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  arch/riscv/include/asm/checksum.h | 79 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 79 insertions(+)
> >
> > diff --git a/arch/riscv/include/asm/checksum.h b/arch/riscv/include/asm/checksum.h
> > new file mode 100644
> > index 000000000000..2f0f224682bd
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/checksum.h
> > @@ -0,0 +1,79 @@
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
> > +#define ip_fast_csum ip_fast_csum
> > +
> > +#include <asm-generic/checksum.h>
> > +
> > +/*
> > + * Quickly compute an IP checksum with the assumption that IPv4 headers will
> > + * always be in multiples of 32-bits, and have an ihl of at least 5.
> > + * @ihl is the number of 32 bit segments and must be greater than or equal to 5.
> > + * @iph is assumed to be word aligned.
> > + */
> > +static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
> > +{
> > +	unsigned long csum = 0;
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
> > +		unsigned long fold_temp;
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
> This indentation is still weird.
> 
Oof I was juggling stuff around and this wound up incorrect again at the
end, I apologize for that. I will fix it up.

- Charlie
> > +#endif
> > +	return csum_fold((__force __wsum)csum);
> > +}
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
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
