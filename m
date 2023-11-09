Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFD47E6CCA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 16:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234504AbjKIPBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 10:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234531AbjKIPA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 10:00:59 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192CD3594;
        Thu,  9 Nov 2023 07:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699542057; x=1731078057;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uzYIjF80A20oOh9VpL8XmCTbBdLfo9U3VxzvD/i3wXY=;
  b=HD4IBNLv7Dzd3n9Yj4fzOoE1jDvndKI01H9o5mnV2nZTyZ69gfnnW5By
   DEqOYI4FtwgPRsGdTOqK3frbk1TQiG39IVtlwj6d/ET6KPoZCnMxDeN1F
   v4ahXpEx3SvCMAhz27byp7vlf/Ng2yd00k0GRvFA1nVMECxQUEEXAv20b
   xjsB+cC/ZZcUES18QlxDFuN4BxGBNPajwKTcFqREEfQc4+WiC4vpsVZXn
   EHjz8tAxC2G1WTxo3V5rVo+UO740xP41e3+DPwMg4/wZZ9KmT6RqPSZZB
   obcMiq3yWElkl6uLuQNrS1nXDxJykGnITQQC1VjTovwXhoGSmLb3prNsA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="454301601"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="454301601"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 07:00:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="4562362"
Received: from tiwariv-mobl.amr.corp.intel.com (HELO [10.212.165.194]) ([10.212.165.194])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 07:00:16 -0800
Message-ID: <14bf7ab4-f770-4b3b-ad10-aa1d29d4f219@intel.com>
Date:   Thu, 9 Nov 2023 07:00:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crypto: x86/sm2 -add Zhaoxin SM2 algorithm implementation
Content-Language: en-US
To:     LeoLiu-oc <LeoLiu-oc@zhaoxin.com>, herbert@gondor.apana.org.au,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, seanjc@google.com, kim.phillips@amd.com,
        pbonzini@redhat.com, babu.moger@amd.com,
        jiaxi.chen@linux.intel.com, jmattson@google.com,
        pawan.kumar.gupta@linux.intel.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     CobeChen@zhaoxin.com, TonyWWang@zhaoxin.com, YunShen@zhaoxin.com,
        Leoliu@zhaoxin.com
References: <20231109094744.545887-1-LeoLiu-oc@zhaoxin.com>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20231109094744.545887-1-LeoLiu-oc@zhaoxin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/23 01:47, LeoLiu-oc wrote:
...
> diff --git a/arch/x86/crypto/Kconfig b/arch/x86/crypto/Kconfig
> index 9bbfd01cfa2f..a771a9da2abd 100644
> --- a/arch/x86/crypto/Kconfig
> +++ b/arch/x86/crypto/Kconfig
> @@ -519,4 +519,15 @@ config CRYPTO_CRCT10DIF_PCLMUL
>  	  Architecture: x86_64 using:
>  	  - PCLMULQDQ (carry-less multiplication)
>  
> +config CRYPTO_SM2_ZHAOXIN_GMI
> +	tristate "SM2 Cipher algorithm (Zhaoxin GMI Instruction)"
> +	depends on X86

Why does this not have "depends on CPU_SUP_ZHAOXIN"?

Also, the assembly in here looks suspiciously like x86_64 assembly.
How, exactly, does this build when !X86_64?

> +	select CRYPTO_AKCIPHER
> +	select CRYPTO_MANAGER
> +	help
> +	  SM2 (ShangMi 2) public key algorithm by Zhaoxin GMI Instruction
> +
> +	  Published by State Encryption Management Bureau, China,
> +	  as specified by OSCCA GM/T 0003.1-2012 -- 0003.5-2012.
> +
>  endmenu
> diff --git a/arch/x86/crypto/Makefile b/arch/x86/crypto/Makefile
> index 9aa46093c91b..c23b328a3ecd 100644
> --- a/arch/x86/crypto/Makefile
> +++ b/arch/x86/crypto/Makefile
> @@ -109,6 +109,9 @@ aria-aesni-avx2-x86_64-y := aria-aesni-avx2-asm_64.o aria_aesni_avx2_glue.o
>  obj-$(CONFIG_CRYPTO_ARIA_GFNI_AVX512_X86_64) += aria-gfni-avx512-x86_64.o
>  aria-gfni-avx512-x86_64-y := aria-gfni-avx512-asm_64.o aria_gfni_avx512_glue.o
>  
> +obj-$(CONFIG_CRYPTO_SM2_ZHAOXIN_GMI) += sm2-zhaoxin-gmi.o
> +sm2-zhaoxin-gmi-y := sm2-zhaoxin-gmi_asm.o sm2-zhaoxin-gmi_glue.o
> +
>  quiet_cmd_perlasm = PERLASM $@
>        cmd_perlasm = $(PERL) $< > $@
>  $(obj)/%.S: $(src)/%.pl FORCE
> diff --git a/arch/x86/crypto/sm2-zhaoxin-gmi_asm.S b/arch/x86/crypto/sm2-zhaoxin-gmi_asm.S
> new file mode 100644
> index 000000000000..4ee5194557a0
> --- /dev/null
> +++ b/arch/x86/crypto/sm2-zhaoxin-gmi_asm.S
> @@ -0,0 +1,59 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Zhaoxin GMI implementation of a SM2 function
> + *
> + * Copyright(c) 2023 Zhaoxin Semiconductor LTD.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of version 2 of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * Contact Information:
> + *  YunShen <YunShen@zhaoxin.com>
> + */

I thought we were using SPDX instead of blown-up license text now.  Why
does this need the GPLv2 blurb?

> +#include <linux/linkage.h>
> +
> +#define KEY_PTR     %rdi /* 1st arg */
> +#define HASH_PTR    %rsi /* 2nd arg */
> +#define SIG_PTR     %rdx /* 3rd arg */
> +#define SCRATCH_PTR %rcx /* 4rd arg */
> +#define VER_RESULT  %rax /* ret     */
> +
> +.text
> +.align 32
> +###############################################################################
> +# int zhaoxin_gmi_sm2_verify (
> +#         unsigned char *key, /*key*/
> +#         unsigned char *hash, /*hash*/
> +#         unsigned char *sig, /*signature*/
> +#         unsigned char *scratch /*8 kbytes scratch space*/
> +#     );
> +###############################################################################

This comment is just a waste of space.  The types here are completely
uninformative and the comments:

	unsigned char *key, /*key*/

are, um, equally uninformative considering the #defines above.

> +SYM_FUNC_START(zhaoxin_gmi_sm2_verify)
> +	push %r12
> +	push %rbx

Please mention that these are callee-saved registers that the
instruction will clobber.

> +	mov HASH_PTR, %rax
> +	mov KEY_PTR, %rbx
> +	mov SIG_PTR, %r12
> +	mov $8, %rdx
> +	mov SCRATCH_PTR, %rsi
> +	mov %r12, %rdi
> +
> +	.byte 0XF2
> +	.byte 0X0F
> +	.byte 0XA6
> +	.byte 0XC0

Please look around the codebase and see what folks do with assembly for
instructions that might not be supported in the assembler.  There's an
existing standard here.

> +	mov %rcx, %rax
> +
> +	pop %rbx
> +	pop %r12
> +
> +	RET
> +SYM_FUNC_END(zhaoxin_gmi_sm2_verify)
> diff --git a/arch/x86/crypto/sm2-zhaoxin-gmi_glue.c b/arch/x86/crypto/sm2-zhaoxin-gmi_glue.c
> new file mode 100644
> index 000000000000..4d0d18f68266
> --- /dev/null
> +++ b/arch/x86/crypto/sm2-zhaoxin-gmi_glue.c
> @@ -0,0 +1,145 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * SM2 asymmetric public-key algorithm
> + * as specified by OSCCA GM/T 0003.1-2012 -- 0003.5-2012 SM2 and
> + * described at https://tools.ietf.org/html/draft-shen-sm2-ecdsa-02
> + *
> + * Copyright (c) 2023 Shanghai Zhaoxin Semiconductor LTD.
> + * Authors: YunShen <yunshen@zhaoxin.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/mpi.h>
> +#include <crypto/internal/akcipher.h>
> +#include <crypto/akcipher.h>
> +#include <crypto/sm2.h>
> +#include <asm/cpufeature.h>
> +#include <asm/processor.h>
> +#include <asm/cpu_device_id.h>
> +
> +#define SCRATCH_SIZE (4 * 2048)
> +
> +asmlinkage int zhaoxin_gmi_sm2_verify(unsigned char *key, unsigned char *hash, unsigned char *sig,
> +				unsigned char *scratch);
> +
> +struct sm2_cipher_data {
> +	u8 pub_key[65]; /* public key */
> +};
> +
> +/* Load supported features of the CPU to see if the SM2 is available. */
> +static int zhaoxin_gmi_available(void)
> +{
> +	if (!boot_cpu_has(X86_FEATURE_SM2_EN)) {
> +		pr_err("can't enable hardware SM2 if Zhaoxin GMI SM2 is not enabled\n");
> +		return -ENODEV;
> +	}
> +	return 0;
> +}

How can this code even be reached if X86_FEATURE_SM2_EN is clear?  How
will the cipher even get registered?

> +/* Zhaoxin sm2 verify function */
> +static int _zhaoxin_sm2_verify(struct sm2_cipher_data *ec, unsigned char *hash, unsigned char *sig)
> +{
> +	int ret = -EKEYREJECTED;
> +	uint64_t f_ok = 0;

This is an odd type choice since this is far from a user/kernel ABI and
also the zhaoxin_gmi_sm2_verify() declared return type is 'int'.

> +	unsigned char *scratch = kzalloc(SCRATCH_SIZE, GFP_KERNEL);
> +
> +	f_ok = zhaoxin_gmi_sm2_verify(ec->pub_key, hash, sig, scratch);
> +	if (f_ok == 1)
> +		ret = 0;
> +
> +	kfree(scratch);
> +
> +	return ret;
> +}
> +
> +static int zhaoxin_sm2_verify(struct akcipher_request *req)
> +{
> +	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
> +	struct sm2_cipher_data *ec = akcipher_tfm_ctx(tfm);
> +	unsigned char *buffer;
> +	int ret;
> +
> +	buffer = kmalloc(req->src_len + req->dst_len, GFP_KERNEL);
> +	if (!buffer)
> +		return -ENOMEM;
> +
> +	sg_pcopy_to_buffer(req->src, sg_nents_for_len(req->src, req->src_len + req->dst_len),
> +		buffer, req->src_len + req->dst_len, 0);

While sg_pcopy_to_buffer() calls in general seem
readablility-challenged, this one in particular is pretty bad.  Please
break this up logically (one line per argument seems commonplace) or use
some helper intermediate variables.  I do notice that 'req->src_len +
req->dst_len' is repeated quite a few times in this function, for instance.

> +	ret = _zhaoxin_sm2_verify(ec, buffer + req->src_len, buffer);
> +	kfree(buffer);
> +
> +	return ret;
> +}
> +
> +static int zhaoxin_sm2_set_pub_key(struct crypto_akcipher *tfm, const void *key,
> +				unsigned int keylen)
> +{
> +	struct sm2_cipher_data *ec = akcipher_tfm_ctx(tfm);
> +
> +	memcpy(ec->pub_key, key, keylen);
> +
> +	return 0;
> +}
> +
> +static unsigned int zhaoxin_sm2_max_size(struct crypto_akcipher *tfm)
> +{
> +	/* Unlimited max size */
> +	return PAGE_SIZE;
> +}

I don't know the crypto API well, but does this mean that for every 4k
of data that this code deals with, it needs to kmalloc()/kfree() 8k?

> +static int zhaoxin_sm2_init_tfm(struct crypto_akcipher *tfm)
> +{
> +	return zhaoxin_gmi_available();
> +}
> +
> +static void zhaoxin_sm2_exit_tfm(struct crypto_akcipher *tfm)
> +{
> +	struct sm2_cipher_data *ec = akcipher_tfm_ctx(tfm);
> +
> +	memset(ec, 0, sizeof(*ec));
> +}
> +
> +static struct akcipher_alg zhaoxin_sm2 = {
> +	.verify = zhaoxin_sm2_verify,
> +	.set_pub_key = zhaoxin_sm2_set_pub_key,
> +	.max_size = zhaoxin_sm2_max_size,
> +	.init = zhaoxin_sm2_init_tfm,
> +	.exit = zhaoxin_sm2_exit_tfm,
> +	.base = {
> +		.cra_name = "sm2",
> +		.cra_driver_name = "zhaoxin-gmi-sm2",
> +		.cra_priority = 150,
> +		.cra_module = THIS_MODULE,
> +		.cra_ctxsize = sizeof(struct sm2_cipher_data),
> +	},
> +};
> +
> +static const struct x86_cpu_id zhaoxin_sm2_cpu_ids[] = {
> +	X86_MATCH_FEATURE(X86_FEATURE_SM2, NULL),
> +	{}
> +};
> +MODULE_DEVICE_TABLE(x86cpu, zhaoxin_sm2_cpu_ids);
> +
> +static int __init zhaoxin_sm2_init(void)
> +{
> +	if (!x86_match_cpu(zhaoxin_sm2_cpu_ids)) {
> +		pr_err("The CPU isn't support hardware SM2.\n");
> +		return -ENODEV;
> +	}
> +
> +	return crypto_register_akcipher(&zhaoxin_sm2);
> +}

Again, please look around the code base.  There are a bunch of crypto
drivers that do checks like this.  *None* have a pr_err().  Few spew any
spam to dmesg.  Why does this one?

> +static void __exit zhaoxin_sm2_exit(void)
> +{
> +	crypto_unregister_akcipher(&zhaoxin_sm2);
> +}
> +
> +module_init(zhaoxin_sm2_init);
> +module_exit(zhaoxin_sm2_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("YunShen <yunshen@zhaoxin.com>");
> +MODULE_DESCRIPTION("SM2 Zhaoxin GMI Algorithm");
> +MODULE_ALIAS_CRYPTO("zhaoxin-gmi-sm2");
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index 4af140cf5719..07a78ec83bed 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -146,6 +146,8 @@
>  #define X86_FEATURE_HYPERVISOR		( 4*32+31) /* Running on a hypervisor */
>  
>  /* VIA/Cyrix/Centaur-defined CPU features, CPUID level 0xC0000001, word 5 */
> +#define X86_FEATURE_SM2			(5*32 + 0) /* SM2 ZhaoXin GMI present */
> +#define X86_FEATURE_SM2_EN			(5*32 + 1) /* SM2 ZhaoXin GMI enabled */

Ahh, so I actually misread the two CPUID flags that got checked earlier.

What does it take to get "GMI enabled"?  How can it be present but not
enabled?

