Return-Path: <linux-kernel+bounces-63787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C489A853462
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A07A1F23676
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC0A5DF02;
	Tue, 13 Feb 2024 15:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="a5ahLrn/"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084AB58AB4
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 15:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707837246; cv=none; b=c4IR5vZg3Xl4Tc3CrfW5L660n8Syqy1LYVTflQHP8n50CqKLJPbHBk8BSUCrpW0JmZrrcTvacgIl+hHn+Xxec3Z9dsGN3Ws6SCv0elA3cTp3BiVJmj4Ge92lyaGfwrn1Vl3Wcmjx2rzEu8VUVraM/s3Gq9qiipVbmJ3M4gBq4ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707837246; c=relaxed/simple;
	bh=DTL/5CHgsBRJoE4w/Uh+RJvrgXM8VfzWMl2n62wjmRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMRCDLMdhg0AQYptwSbFrgQ9RimNx+bU3LbQXu4uXdwCvN+QA3QKlcbJ47Doi/RTBWYrjJSZpBsPAq3HKaLAttfQIJ8Dz3U5FP1W5Y9RE5hATyVVXowSumMaE64wsNKcBIxC4EB4HbTeU+gYZpyOcrIB+zuPlm3l68a4wDAeQj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=a5ahLrn/; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3d1151b497so74212066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 07:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1707837242; x=1708442042; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CoiiSvGy6jiUuFwJBqdSxNcNmdgRyL2T6XJRnFEUz24=;
        b=a5ahLrn/AQdK441YOTwnUVrDe9hs6hYTN+AdSkcRofxPsrP1g2hySZkCAAAJ3sgXVq
         4riWPa98LCmaHwBkltfS3lAh4SJzCrdVqrTnxcZeXc8KtG7Pf1yiSwORVR6CSU3HGf0n
         xs8IYoPKZB/9QkiHYV9tPmKczEo0kqIun6JCGYsA5ioSXdUsvGVaZS67kCIwHIIk8xSs
         SpGKqqMZS2epuvLsFllquQUQLVRMKpr9yUbwJ2DPtjhbnrvAggW/Ioc7uxsIbF4RIAhK
         4ZSh9oQbMi7LwTbu7FMC0MsK0r3t8WYoh1ywlqjlDbboUy5n4NhwBDcyOm+RVGsPLxUV
         txfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707837242; x=1708442042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CoiiSvGy6jiUuFwJBqdSxNcNmdgRyL2T6XJRnFEUz24=;
        b=iEMIqaTIwmVtXPytVtMgjyeCJpznjCVhIi4mILV952EcybT0Ukm8oofpuCCEkp4/FJ
         YM9dZ+ts0ZOlc6luuhOnoit4GXIbG/uSgdNS6gk9XgDfNreyHjgIjwxsGzQL//WTrmzm
         383Oyjx1MdDjQV41Tlmx2EE4S4gYwD72f4S27CL/JbsSe5yijqNkFBAC9b8fk9q2gZ+g
         zFKY+kfUMRgxhQS4sSFWM8B7qrWeufZRWQusmRvWToiGniBnY6ulyuygXqpd/h5vZcsa
         Y3p8oX48zyJtvQVbq2GY5K561H4FNdrVrW0agDVDld/2JeJ5KpZiwS+7uUjp1o257uVU
         EqJA==
X-Forwarded-Encrypted: i=1; AJvYcCW89r/fYeCIxYmQBIESknUBuOgcOO34vxXxIXg4gaqAv7SXcIwhtvKW70zljOUMUSRtfi1TEDkEmOA5IilUPLGxzxwNtV4rUfnEhUHG
X-Gm-Message-State: AOJu0YxWdgfpbqGLjaYVcCYwl3lyne2td0CmvgjkwCtrtcUIqDhVJe66
	2O9FaCF9fw1Be1Mb7/zWkpap33qXStvaRMblnYU0kc/4+HRgedjC7FuFY6KILM0=
X-Google-Smtp-Source: AGHT+IGW25hoSoA/NwkywR6wd9Iqom6ZAIk18TYnjehStbOy+ZYgOtYJpske3imE79UA7AiGldPh4A==
X-Received: by 2002:a17:906:6899:b0:a39:34bc:493b with SMTP id n25-20020a170906689900b00a3934bc493bmr6525164ejr.45.1707837242260;
        Tue, 13 Feb 2024 07:14:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXyck7LH1u3HfVqtIyPpKV2jWP2kKE+mXMMqnX1lTQZUoYt0ccP5waKUiF7kKoX6Lmhk+MOBj54Rb6NqX+QQ6AwY2Y5bajPm6NPO7QxZhqGoLcmZ2WGE6iN+ruKuyrH9RWnTPBuQqzg1wW/EMs+4cZU9nJVCNH3xU/OzVGVMJrTariiIU/btx7S9kFDo1itb/CfVsuVs2acayX3
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id y9-20020a1709063da900b00a3bfe3de44csm1369437ejh.133.2024.02.13.07.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 07:14:01 -0800 (PST)
Date: Tue, 13 Feb 2024 16:14:00 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Stefan O'Rear <sorear@fastmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH -fixes v2 3/4] riscv: Add ISA extension parsing for Sm
 and Ss
Message-ID: <20240213-1835b458d8cad71a76fa7322@orel>
References: <20240213033744.4069020-1-samuel.holland@sifive.com>
 <20240213033744.4069020-4-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213033744.4069020-4-samuel.holland@sifive.com>

On Mon, Feb 12, 2024 at 07:37:34PM -0800, Samuel Holland wrote:
> Previously, all extension version numbers were ignored. However, the
> version number is important for these two extensions. The simplest way
> to implement this is to use a separate bitmap bit for each supported
> version, with each successive version implying all of the previous ones.
> This allows alternatives and riscv_has_extension_[un]likely() to work
> naturally.
> 
> To avoid duplicate extensions in /proc/cpuinfo, the new successor_id
> field allows hiding all but the newest implemented version of an
> extension.
> 
> Cc: <stable@vger.kernel.org> # v6.7+
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
> 
> Changes in v2:
>  - New patch for v2
> 
>  arch/riscv/include/asm/cpufeature.h |  1 +
>  arch/riscv/include/asm/hwcap.h      |  8 ++++++
>  arch/riscv/kernel/cpu.c             |  5 ++++
>  arch/riscv/kernel/cpufeature.c      | 42 +++++++++++++++++++++++++----
>  4 files changed, 51 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
> index 0bd11862b760..ac71384e7bc4 100644
> --- a/arch/riscv/include/asm/cpufeature.h
> +++ b/arch/riscv/include/asm/cpufeature.h
> @@ -61,6 +61,7 @@ struct riscv_isa_ext_data {
>  	const char *property;
>  	const unsigned int *subset_ext_ids;
>  	const unsigned int subset_ext_size;
> +	const unsigned int successor_id;
>  };
>  
>  extern const struct riscv_isa_ext_data riscv_isa_ext[];
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index 5340f818746b..5b51aa1db15b 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -80,13 +80,21 @@
>  #define RISCV_ISA_EXT_ZFA		71
>  #define RISCV_ISA_EXT_ZTSO		72
>  #define RISCV_ISA_EXT_ZACAS		73
> +#define RISCV_ISA_EXT_SM1p11		74
> +#define RISCV_ISA_EXT_SM1p12		75
> +#define RISCV_ISA_EXT_SS1p11		76
> +#define RISCV_ISA_EXT_SS1p12		77
>  
>  #define RISCV_ISA_EXT_MAX		128
>  #define RISCV_ISA_EXT_INVALID		U32_MAX
>  
>  #ifdef CONFIG_RISCV_M_MODE
> +#define RISCV_ISA_EXT_Sx1p11		RISCV_ISA_EXT_SM1p11
> +#define RISCV_ISA_EXT_Sx1p12		RISCV_ISA_EXT_SM1p12
>  #define RISCV_ISA_EXT_SxAIA		RISCV_ISA_EXT_SMAIA
>  #else
> +#define RISCV_ISA_EXT_Sx1p11		RISCV_ISA_EXT_SS1p11
> +#define RISCV_ISA_EXT_Sx1p12		RISCV_ISA_EXT_SS1p12
>  #define RISCV_ISA_EXT_SxAIA		RISCV_ISA_EXT_SSAIA
>  #endif
>  
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index d11d6320fb0d..2e6b90ed0d51 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -215,6 +215,11 @@ static void print_isa(struct seq_file *f, const unsigned long *isa_bitmap)
>  		if (!__riscv_isa_extension_available(isa_bitmap, riscv_isa_ext[i].id))
>  			continue;
>  
> +		/* Only show the newest implemented version of an extension */
> +		if (riscv_isa_ext[i].successor_id != RISCV_ISA_EXT_INVALID &&
> +		    __riscv_isa_extension_available(isa_bitmap, riscv_isa_ext[i].successor_id))
> +			continue;

I'm not sure we need this. Expanding Ss1p12 to 'Ss1p11 Ss1p12' and then
outputting both in the ISA string doesn't seem harmful to me. Also, using
a successor field instead of supersedes field may make this logic easy,
but it'll require updating old code (changing RISCV_ISA_EXT_INVALID to the
new version extension ID) when new versions are added. A supersedes field
wouldn't require old code updates and would match the profiles spec which
have explicit 'Ss1p12 supersedes Ss1p11.' type sentences.

> +
>  		/* Only multi-letter extensions are split by underscores */
>  		if (strnlen(riscv_isa_ext[i].name, 2) != 1)
>  			seq_puts(f, "_");
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index c5b13f7dd482..8e10b50120e9 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -113,23 +113,29 @@ static bool riscv_isa_extension_check(int id)
>  	return true;
>  }
>  
> -#define _RISCV_ISA_EXT_DATA(_name, _id, _subset_exts, _subset_exts_size) {	\
> +#define _RISCV_ISA_EXT_DATA(_name, _id, _subset_exts, _subset_exts_size, _successor) {	\
>  	.name = #_name,								\
>  	.property = #_name,							\
>  	.id = _id,								\
>  	.subset_ext_ids = _subset_exts,						\
> -	.subset_ext_size = _subset_exts_size					\
> +	.subset_ext_size = _subset_exts_size,					\
> +	.successor_id = _successor,						\
>  }
>  
> -#define __RISCV_ISA_EXT_DATA(_name, _id) _RISCV_ISA_EXT_DATA(_name, _id, NULL, 0)
> +#define __RISCV_ISA_EXT_DATA(_name, _id) \
> +	_RISCV_ISA_EXT_DATA(_name, _id, NULL, 0, RISCV_ISA_EXT_INVALID)
>  
>  /* Used to declare pure "lasso" extension (Zk for instance) */
>  #define __RISCV_ISA_EXT_BUNDLE(_name, _bundled_exts) \
> -	_RISCV_ISA_EXT_DATA(_name, RISCV_ISA_EXT_INVALID, _bundled_exts, ARRAY_SIZE(_bundled_exts))
> +	_RISCV_ISA_EXT_DATA(_name, RISCV_ISA_EXT_INVALID, \
> +			    _bundled_exts, ARRAY_SIZE(_bundled_exts), RISCV_ISA_EXT_INVALID)
>  
>  /* Used to declare extensions that are a superset of other extensions (Zvbb for instance) */
>  #define __RISCV_ISA_EXT_SUPERSET(_name, _id, _sub_exts) \
> -	_RISCV_ISA_EXT_DATA(_name, _id, _sub_exts, ARRAY_SIZE(_sub_exts))
> +	_RISCV_ISA_EXT_DATA(_name, _id, _sub_exts, ARRAY_SIZE(_sub_exts), RISCV_ISA_EXT_INVALID)
> +
> +#define __RISCV_ISA_EXT_VERSION(_name, _id, _preds, _preds_size, _successor) \
> +	_RISCV_ISA_EXT_DATA(_name, _id, _preds, _preds_size, _successor)
>  
>  static const unsigned int riscv_zk_bundled_exts[] = {
>  	RISCV_ISA_EXT_ZBKB,
> @@ -201,6 +207,16 @@ static const unsigned int riscv_zvbb_exts[] = {
>  	RISCV_ISA_EXT_ZVKB
>  };
>  
> +static const unsigned int riscv_sm_ext_versions[] = {
> +	RISCV_ISA_EXT_SM1p11,
> +	RISCV_ISA_EXT_SM1p12,
> +};
> +
> +static const unsigned int riscv_ss_ext_versions[] = {
> +	RISCV_ISA_EXT_SS1p11,
> +	RISCV_ISA_EXT_SS1p12,
> +};
> +
>  /*
>   * The canonical order of ISA extension names in the ISA string is defined in
>   * chapter 27 of the unprivileged specification.
> @@ -299,8 +315,16 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
>  	__RISCV_ISA_EXT_DATA(zvksh, RISCV_ISA_EXT_ZVKSH),
>  	__RISCV_ISA_EXT_BUNDLE(zvksg, riscv_zvksg_bundled_exts),
>  	__RISCV_ISA_EXT_DATA(zvkt, RISCV_ISA_EXT_ZVKT),
> +	__RISCV_ISA_EXT_VERSION(sm1p11, RISCV_ISA_EXT_SM1p11, riscv_sm_ext_versions, 0,
> +				RISCV_ISA_EXT_SM1p12),
> +	__RISCV_ISA_EXT_VERSION(sm1p12, RISCV_ISA_EXT_SM1p12, riscv_sm_ext_versions, 1,
> +				RISCV_ISA_EXT_INVALID),
>  	__RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
>  	__RISCV_ISA_EXT_DATA(smstateen, RISCV_ISA_EXT_SMSTATEEN),
> +	__RISCV_ISA_EXT_VERSION(ss1p11, RISCV_ISA_EXT_SS1p11, riscv_ss_ext_versions, 0,
> +				RISCV_ISA_EXT_SS1p12),
> +	__RISCV_ISA_EXT_VERSION(ss1p12, RISCV_ISA_EXT_SS1p12, riscv_ss_ext_versions, 1,
> +				RISCV_ISA_EXT_INVALID),
>  	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
>  	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
>  	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
> @@ -414,6 +438,14 @@ static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct risc
>  				;
>  
>  			++ext_end;
> +
> +			/*
> +			 * As a special case for the Sm and Ss extensions, where the version
> +			 * number is important, include it in the extension name.
> +			 */
> +			if (ext_end - ext == 2 && tolower(ext[0]) == 's' &&
> +			    (tolower(ext[1]) == 'm' || tolower(ext[1]) == 's'))
> +				ext_end = isa;
>  			break;
>  		default:
>  			/*
> -- 
> 2.43.0
>

Thanks,
drew

