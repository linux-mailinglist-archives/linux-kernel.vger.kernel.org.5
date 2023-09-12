Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852BC79CE2C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbjILKYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjILKYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:24:37 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAC5B9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 03:24:33 -0700 (PDT)
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8AEAA3F63F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 10:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1694514271;
        bh=l8BkGdGGrHPYHMDfqGr70IoZdJP5aCZ3/gTRxv7NEnI=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=bxPqtTxhUB7c+h8857W3uzUWNAG/Li/T41vNUM4SbRLx3rrwtMwnsVykJR0ZhmnGP
         r/fhigXL1PMzxHWZm/plx6EOzKrjK0SWsBxzXEVYoLd1y3CtdLrN7rSn24y76Bi2mm
         g8U2Tw+/RraFHDnPkDRIrQuCy+pK7uEvl4VJO4Af01H+vH0mXYhuQ2U3Euy7CHE/01
         j0yLoQx2N89fC53nRj7yKMiZndvMW+PqT8C9Xa+EaidtT2FuASdSTVHww9G/QvebEC
         752sP6l0owF57nhhmpwUtRavLpVuKF2GMtb/zMTTg5fmfZOmHKvhQkxJrYH2EqbXKt
         ITNwGXBdJk8Dw==
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-414e1c2b660so49375161cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 03:24:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694514270; x=1695119070;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l8BkGdGGrHPYHMDfqGr70IoZdJP5aCZ3/gTRxv7NEnI=;
        b=jirMU6vHXH2WCc8/E44ANWIakOx02K6tC4sEhZZpgNLEWim9RcuMNN+DP7TTj9ZBrh
         BO0WizPR+7pY/cITlq+TtnbVaHftkBEhnZHihTBEFL3enAWgN4qOnhDH48zRBd2iGIxA
         S6VNnmjzxBPDhWVW/naHVXWHZRW/fMvGGdAnFrFXyThWIo4TY5Sgelz5oXE0qIVVSyGg
         gWy+ejoPprr5GJOUnXcSjykvd9cdiwUfRK4gISd2YrvDSQWMFvCZIkirIUcapaWsGo/4
         mZSEccv95SHeiNXPtVjRCnavmXVNqASMkUn1jkXdnZsRa0eefYVKr1agHU9zXM+TxVhp
         LY/w==
X-Gm-Message-State: AOJu0YxvfUOevc8cgH7STCBxsaPN8iCrM5WpKUhBYPXD0IjzUgGtWaxo
        gyzdIHgletrqf2a0XZ1kh74RYF1blQCUTPVfPFcEjB7ur//KfcIY/kKfdtShZim40xIDskizAQZ
        nidNlnTuzfq7ZWJ3VcoZbVIflA6ha6nyPRO/UJtdOCxfIIpCPgurnVgvxOg==
X-Received: by 2002:ac8:5bc6:0:b0:410:a92f:1dbc with SMTP id b6-20020ac85bc6000000b00410a92f1dbcmr2597640qtb.11.1694514270631;
        Tue, 12 Sep 2023 03:24:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcRRNlOxn0auXsus2rU7wb6g+N0hAl2+PusClukejrqFC+4BhUnEqgdRBRLS8X1AS8tFGKnIp2FEizUwCOONg=
X-Received: by 2002:ac8:5bc6:0:b0:410:a92f:1dbc with SMTP id
 b6-20020ac85bc6000000b00410a92f1dbcmr2597632qtb.11.1694514270378; Tue, 12 Sep
 2023 03:24:30 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 12 Sep 2023 03:24:29 -0700
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20230911-optimize_checksum-v4-1-77cc2ad9e9d7@rivosinc.com>
References: <20230911-optimize_checksum-v4-0-77cc2ad9e9d7@rivosinc.com> <20230911-optimize_checksum-v4-1-77cc2ad9e9d7@rivosinc.com>
Mime-Version: 1.0
Date:   Tue, 12 Sep 2023 03:24:29 -0700
Message-ID: <CAJM55Z-kj8eWKvR32At4kx+PPPn9OMaR88BhEqppQHSL03n50Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] riscv: Checksum header
To:     Charlie Jenkins <charlie@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        David Laight <David.Laight@aculab.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Charlie Jenkins wrote:
> Provide checksum algorithms that have been designed to leverage riscv
> instructions such as rotate. In 64-bit, can take advantage of the larger
> register to avoid some overflow checking.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/include/asm/checksum.h | 95 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
>
> diff --git a/arch/riscv/include/asm/checksum.h b/arch/riscv/include/asm/checksum.h
> new file mode 100644
> index 000000000000..0d7fc8275a5e
> --- /dev/null
> +++ b/arch/riscv/include/asm/checksum.h
> @@ -0,0 +1,95 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * IP checksum routines
> + *
> + * Copyright (C) 2023 Rivos Inc.
> + */
> +#ifndef __ASM_RISCV_CHECKSUM_H
> +#define __ASM_RISCV_CHECKSUM_H
> +
> +#include <linux/in6.h>
> +#include <linux/uaccess.h>
> +
> +#ifdef CONFIG_32BIT
> +typedef unsigned int csum_t;
> +#else
> +typedef unsigned long csum_t;
> +#endif

Hi Charlie,

Isn't unsigned long already 32bit on 32bit RISC-V, so why is this #ifdef
needed?

> +
> +/*
> + *	Fold a partial checksum without adding pseudo headers
> + */
> +static inline __sum16 csum_fold(__wsum sum)
> +{
> +	return (~sum - ror32(sum, 16)) >> 16;
> +}
> +
> +#define csum_fold csum_fold
> +
> +/*
> + * Quickly compute an IP checksum with the assumption that IPv4 headers will
> + * always be in multiples of 32-bits, and have an ihl of at least 5.
> + * @ihl is the number of 32 bit segments and must be greater than or equal to 5.
> + * @iph is assumed to be word aligned.
> + */
> +static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
> +{
> +	csum_t csum = 0;
> +	int pos = 0;
> +
> +	do {
> +		csum += ((const unsigned int *)iph)[pos];
> +		if (IS_ENABLED(CONFIG_32BIT))
> +			csum += csum < ((const unsigned int *)iph)[pos];
> +	} while (++pos < ihl);
> +
> +	/*
> +	 * ZBB only saves three instructions on 32-bit and five on 64-bit so not
> +	 * worth checking if supported without Alternatives.
> +	 */
> +	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
> +	    IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
> +		csum_t fold_temp;
> +
> +		asm_volatile_goto(ALTERNATIVE("j %l[no_zbb]", "nop", 0,
> +					      RISCV_ISA_EXT_ZBB, 1)
> +		    :
> +		    :
> +		    :
> +		    : no_zbb);
> +
> +		if (IS_ENABLED(CONFIG_32BIT)) {
> +			asm(".option push				\n\
> +			.option arch,+zbb				\n\
> +				not	%[fold_temp], %[csum]		\n\
> +				rori	%[csum], %[csum], 16		\n\
> +				sub	%[csum], %[fold_temp], %[csum]	\n\
> +			.option pop"
> +			: [csum] "+r" (csum), [fold_temp] "=&r" (fold_temp));
> +		} else {
> +			asm(".option push				\n\
> +			.option arch,+zbb				\n\
> +				rori	%[fold_temp], %[csum], 32	\n\
> +				add	%[csum], %[fold_temp], %[csum]	\n\
> +				srli	%[csum], %[csum], 32		\n\
> +				not	%[fold_temp], %[csum]		\n\
> +				roriw	%[csum], %[csum], 16		\n\
> +				subw	%[csum], %[fold_temp], %[csum]	\n\
> +			.option pop"
> +			: [csum] "+r" (csum), [fold_temp] "=&r" (fold_temp));
> +		}
> +		return csum >> 16;
> +	}
> +no_zbb:
> +#ifndef CONFIG_32BIT
> +		csum += (csum >> 32) | (csum << 32);
> +		csum >>= 32;

The indentation seems off here.

/Emil

> +#endif
> +	return csum_fold((__force __wsum)csum);
> +}
> +
> +#define ip_fast_csum ip_fast_csum
> +
> +#include <asm-generic/checksum.h>
> +
> +#endif // __ASM_RISCV_CHECKSUM_H
>
> --
> 2.42.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.inradead.org/mailman/listinfo/linux-riscv
