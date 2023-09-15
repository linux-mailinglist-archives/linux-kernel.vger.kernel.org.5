Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38587A1BC8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 12:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbjIOKKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 06:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234160AbjIOKKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:10:00 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F6A3591
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 03:07:45 -0700 (PDT)
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D04503F67C
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 10:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1694772463;
        bh=CePvDk/TxgBw6w90UlCCAlVR7GMFDlWsOITzDbSZkZE=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=KSqcbl2GquNamS8ZyHjLk+kK0OmTqqRvi0VeHrfPBosU8wrYYdR3rEhaAy/sI1tST
         q49Drx9jb1aZo04a+FvlCj5/+ZWcBLFwVQ7sgk0QxE+RzJqPol3IUCMJY56swmuEHz
         lnBMCTTjYuwqCnusdQAGJMsWmHmiKg18A9VIUxtTKaeGwnHmQqFz8eO0cDSJ9l0EB/
         a39NJJBX8N5W5leKm4thzEIjiYZLwUoHYuaqm4jtdz8io+dlcY1wfoa7A0mEMrvkks
         x7a0gmWcAz0I0NccjnSZaX+g7HeyYCY3i6fKicHk48p+qFqdcSJ7p9seUB4NExRHeK
         hjF66zkT/eOZA==
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-412136f4706so20117881cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 03:07:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694772460; x=1695377260;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CePvDk/TxgBw6w90UlCCAlVR7GMFDlWsOITzDbSZkZE=;
        b=qNt+U9aWvC0PYKpoXJZ6tCdVTNrsuIZz27lXbwPNWtWU6tKnHwKZrQz3gSqL4R0CB4
         szwiqjB/M+ZrN1w4OMUNWAX0XY2G4sOwnqzW8RtXTTK6A6lHaB0JCQtHV+RHGtG1xJLo
         UrRhDUUEvx/7Deb1VZD6uK3JcDCQ+CCG3lsfjNhI5cqaPP9eTjClBCf5DaS3ddPJa3oM
         YSJkdgd2hPdFqp6glXLha6c4gB7lZPjdgHT3NFMMQwYJ/IWfhpOhWKAUcLr4StcVjWdX
         Sd3PGUzqbasVqjssgIdkrafes2OsaUbcF9PsLOCVJIQMv1hchU8uZ4qjFEC8zU/5FxcF
         k+JQ==
X-Gm-Message-State: AOJu0YzuBD+i+MIqoNsN6OZxQGGQtxAV9Dz3YLT0QXqZkg7j74dV8IqZ
        MRnuV+l8MRi7m6Afqev2/EQpAHYJscNdqbjfILbFedzdIFdimSig/WJgeL0k0G9R6y2ka+TpGTV
        SIN5pB//57j4+nAt4DZdMmIgmSOQvvdwcgZiAF/kgT4L1+NiPzHNe7j89Pw==
X-Received: by 2002:ac8:59ca:0:b0:412:1ba6:32af with SMTP id f10-20020ac859ca000000b004121ba632afmr1121511qtf.19.1694772460112;
        Fri, 15 Sep 2023 03:07:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+ttv6EU1BRZWt+DGbR4+QlOm43LirF30qz5OYUZ4PVhJmX/0LnnR85y4NNlsb75YxMffLnjCJzd0uf44Zpgw=
X-Received: by 2002:ac8:59ca:0:b0:412:1ba6:32af with SMTP id
 f10-20020ac859ca000000b004121ba632afmr1121495qtf.19.1694772459877; Fri, 15
 Sep 2023 03:07:39 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 15 Sep 2023 03:07:39 -0700
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20230914-optimize_checksum-v5-2-c95b82a2757e@rivosinc.com>
References: <20230914-optimize_checksum-v5-0-c95b82a2757e@rivosinc.com> <20230914-optimize_checksum-v5-2-c95b82a2757e@rivosinc.com>
Mime-Version: 1.0
Date:   Fri, 15 Sep 2023 03:07:39 -0700
Message-ID: <CAJM55Z8Pjbu8uCqh9Heaj=ScuAoYgqsEzFuxwBUCfiZmMmk+KQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] riscv: Checksum header
To:     Charlie Jenkins <charlie@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        David Laight <David.Laight@aculab.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
>  arch/riscv/include/asm/checksum.h | 79 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
>
> diff --git a/arch/riscv/include/asm/checksum.h b/arch/riscv/include/asm/checksum.h
> new file mode 100644
> index 000000000000..2f0f224682bd
> --- /dev/null
> +++ b/arch/riscv/include/asm/checksum.h
> @@ -0,0 +1,79 @@
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
> +#define ip_fast_csum ip_fast_csum
> +
> +#include <asm-generic/checksum.h>
> +
> +/*
> + * Quickly compute an IP checksum with the assumption that IPv4 headers will
> + * always be in multiples of 32-bits, and have an ihl of at least 5.
> + * @ihl is the number of 32 bit segments and must be greater than or equal to 5.
> + * @iph is assumed to be word aligned.
> + */
> +static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
> +{
> +	unsigned long csum = 0;
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
> +		unsigned long fold_temp;
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

This indentation is still weird.

> +#endif
> +	return csum_fold((__force __wsum)csum);
> +}
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
> http://lists.infradead.org/mailman/listinfo/linux-riscv
