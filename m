Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F38678B732
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbjH1SXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbjH1SWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:22:52 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01AFDB4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:22:49 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1c504386370so2476641fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1693246968; x=1693851768;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ga2gVen33azZ76Qh5zvhdK58PNvnvDUlMbqHu7tcD5I=;
        b=eOuzCOCIOr6mECywSLVO8rgl7EKRQ+tcA6n96uPCmIq5W2Uuxkk1UFNvQZSua/brRh
         FgFYJUaGVwC9AFWo2nrDjA4UpSWEL3dBn4yPjGHHv4XT6G/Zne+x7DBLhNgn8ePyoO6B
         4rs+NXufNjB+oyNTwJs+0dB4ZiJbSPaxJ27q8pC/C1Ke/UrTTlFWF59coqd+w7WBJnTB
         J1bKh/vStpLLHxT5Jpg09fRg8cUBrwXC8Y7YCei/GonRFRa5uKcy+pAvscJYBz0R8C14
         IRleuWRH+CtNqkfLMbQKZ39+xV8UbMeX3VM+vlPr2Dcov7MfhAwTigMpKqiriTs2rV82
         Oz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693246968; x=1693851768;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ga2gVen33azZ76Qh5zvhdK58PNvnvDUlMbqHu7tcD5I=;
        b=f8eq9k8P5nFTjah2gwedKDqzjILoSQS3ODVQG41z5vWrhXvUNhySbaF1QQc00zvVBB
         vSDHMBMaeB2Tw2Ugp36xjBcvPjNRDZvFHb+bd4Y86Ujzc7j214/nqvDwdkoHxPBWHMJh
         jQeer1pVq5tbgkExn1Kwc7eTUlsb4Y/mm/GatAzKgOY+tld/fRNAceQsPNjyPSs8PP4g
         LbLJeZvBBUDA+42JGNFGsKppaK4usN+SCjzgeR5BJtPLoxl5UihPkgwFNH+EvL2zCLvt
         G1y6EhCNYjM13zEZVIyEBBYNLEtrekimUS7TqVJD9JXVrUkdA3nV/h9AXwdWi0DR98cM
         VbXg==
X-Gm-Message-State: AOJu0YzbETxGatLE5sRV5hCVuRrPiYAjWUze0UQn1w8mquELC/u6ayN7
        rQLamIuOiJDdpHeumjNe94hL7Q==
X-Google-Smtp-Source: AGHT+IF4mG5pKxGDzKy/ctxHKW2AxQgqLhU4jqhTnVrwSfVbGEHMHGMfLwB/H3ZEFoxfaByFCr2vgA==
X-Received: by 2002:a05:6870:9a25:b0:1bb:5480:4b4 with SMTP id fo37-20020a0568709a2500b001bb548004b4mr13379044oab.8.1693246968227;
        Mon, 28 Aug 2023 11:22:48 -0700 (PDT)
Received: from ?IPV6:2600:1700:2000:b002:6140:58e3:2550:7e99? ([2600:1700:2000:b002:6140:58e3:2550:7e99])
        by smtp.gmail.com with ESMTPSA id 21-20020a17090a19d500b00263f5ac814esm9891041pjj.38.2023.08.28.11.22.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 11:22:47 -0700 (PDT)
Message-ID: <0a8c98bf-46da-e77a-0431-a6c1e224af2e@sifive.com>
Date:   Mon, 28 Aug 2023 13:22:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] riscv: Vector checksum header
Content-Language: en-US
To:     Charlie Jenkins <charlie@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230826-optimize_checksum-v1-0-937501b4522a@rivosinc.com>
 <20230826-optimize_checksum-v1-3-937501b4522a@rivosinc.com>
From:   Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20230826-optimize_checksum-v1-3-937501b4522a@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-26 8:26 PM, Charlie Jenkins wrote:
> This patch is not ready for merge as vector support in the kernel is
> limited. However, the code has been tested in QEMU so the algorithms
> do work. It is written in assembly rather than using the GCC vector
> instrinsics because they did not provide optimal code.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/include/asm/checksum.h | 81 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/checksum.h b/arch/riscv/include/asm/checksum.h
> index af49b3409576..7e31c0ad6346 100644
> --- a/arch/riscv/include/asm/checksum.h
> +++ b/arch/riscv/include/asm/checksum.h
> @@ -10,6 +10,10 @@
>  #include <linux/in6.h>
>  #include <linux/uaccess.h>
>  
> +#ifdef CONFIG_RISCV_ISA_V
> +#include <riscv_vector.h>
> +#endif
> +
>  /* Default version is sufficient for 32 bit */
>  #ifdef CONFIG_64BIT
>  #define _HAVE_ARCH_IPV6_CSUM
> @@ -36,6 +40,46 @@ static inline __sum16 csum_fold(__wsum sum)
>   *	without the bitmanip extensions zba/zbb.
>   */
>  #ifdef CONFIG_32BIT
> +#ifdef CONFIG_RISCV_ISA_V
> +static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
> +{
> +	vuint64m1_t prev_buffer;
> +	vuint32m1_t curr_buffer;
> +	unsigned int vl;
> +	unsigned int high_result;
> +	unsigned int low_result;
> +
> +	asm("vsetivli x0, 1, e64, ta, ma				\n\t\

The same concerns from patch 1 apply here as well. Vector assembly must be gated
behind an alternative section or a call to has_vector(), so the kernel can fall
back to a non-vector implementation at runtime.

You are also missing calls to kernel_vector_begin()/kernel_vector_end(), as
added by [1], which are required to avoid corrupting the user-mode vector
register context.

Regards,
Samuel

[1]: https://lore.kernel.org/linux-riscv/20230721112855.1006-3-andy.chiu@sifive.com/

> +	vmv.v.i %[prev_buffer], 0					\n\t\
> +	1:								\n\t\
> +	vsetvli %[vl], %[ihl], e32, m1, ta, ma				\n\t\
> +	vle32.v %[curr_buffer], (%[iph])				\n\t\
> +	vwredsumu.vs %[prev_buffer], %[curr_buffer], %[prev_buffer]	\n\t\
> +	sub %[ihl], %[ihl], %[vl]					\n\t"
> +#ifdef CONFIG_RISCV_ISA_ZBA
> +	"sh2add %[iph], %[vl], %[iph]					\n\t"
> +#else
> +	"slli %[vl], %[vl], 2						\n\
> +	add %[iph], %[vl], %[iph]					\n\t"
> +#endif
> +	"bnez %[ihl], 1b						\n\
> +	vsetivli x0, 1, e64, m1, ta, ma					\n\
> +	vmv.x.s %[low_result], %[prev_buffer]				\n\
> +	addi %[vl], x0, 32						\n\
> +	vsrl.vx %[prev_buffer], %[prev_buffer], %[vl]			\n\
> +	vmv.x.s %[high_result], %[prev_buffer]"
> +	: [vl] "=&r" (vl), [prev_buffer] "=&vd" (prev_buffer),
> +		[curr_buffer] "=&vd" (curr_buffer),
> +		[high_result] "=&r" (high_result),
> +		[low_result] "=&r" (low_result)
> +	: [iph] "r" (iph), [ihl] "r" (ihl));
> +
> +	high_result += low_result;
> +	high_result += high_result < low_result;
> +	return csum_fold((__force __wsum)(high_result));
> +}
> +
> +#else
>  static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
>  {
>  	__wsum csum = 0;
> @@ -47,8 +91,44 @@ static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
>  	} while (++pos < ihl);
>  	return csum_fold(csum);
>  }
> +#endif
> +#else
> +
> +#ifdef CONFIG_RISCV_ISA_V
> +static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
> +{
> +	vuint64m1_t prev_buffer;
> +	vuint32m1_t curr_buffer;
> +	unsigned long vl;
> +	unsigned long result;
> +
> +	asm("vsetivli x0, 1, e64, ta, ma				\n\
> +	vmv.v.i %[prev_buffer], 0					\n\
> +	1:								\n\
> +	# Setup 32-bit sum of iph					\n\
> +	vsetvli %[vl], %[ihl], e32, m1, ta, ma				\n\
> +	vle32.v %[curr_buffer], (%[iph])				\n\
> +	# Sum each 32-bit segment of iph that can fit into a vector reg	\n\
> +	vwredsumu.vs %[prev_buffer], %[curr_buffer], %[prev_buffer]     \n\
> +	subw %[ihl], %[ihl], %[vl]					\n\t"
> +#ifdef CONFIG_RISCV_ISA_ZBA
> +	"sh2add %[iph], %[vl], %[iph]					\n\t"
>  #else
> +	"slli %[vl], %[vl], 2						\n\
> +	addw %[iph], %[vl], %[iph]					\n\t"
> +#endif
> +	"# If not all of iph could fit into vector reg, do another sum	\n\
> +	bnez %[ihl], 1b							\n\
> +	vsetvli x0, x0, e64, m1, ta, ma					\n\
> +	vmv.x.s %[result], %[prev_buffer]"
> +	: [vl] "=&r" (vl), [prev_buffer] "=&vd" (prev_buffer),
> +		[curr_buffer] "=&vd" (curr_buffer), [result] "=&r" (result)
> +	: [iph] "r" (iph), [ihl] "r" (ihl));
>  
> +	result += (result >> 32) | (result << 32);
> +	return csum_fold((__force __wsum)(result >> 32));
> +}
> +#else
>  /*
>   * Quickly compute an IP checksum with the assumption that IPv4 headers will
>   * always be in multiples of 32-bits, and have an ihl of at least 5.
> @@ -74,6 +154,7 @@ static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
>  	return csum_fold((__force __wsum)(csum >> 32));
>  }
>  #endif
> +#endif
>  #define ip_fast_csum ip_fast_csum
>  
>  extern unsigned int do_csum(const unsigned char *buff, int len);
> 

