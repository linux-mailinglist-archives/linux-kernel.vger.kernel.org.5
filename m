Return-Path: <linux-kernel+bounces-128987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 007AF8962C2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 05:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 514841F23B90
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6681C6B6;
	Wed,  3 Apr 2024 03:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Y8m7nmA3"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09E01B950;
	Wed,  3 Apr 2024 03:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712113649; cv=none; b=b+e5vIlpE/a5dl4FjhxbV2nPf1tqQuRW2h+yqeCqmgb7XzN7fwpd3UxOSdIK3z16Xm6m9G273ylnHJ9umsR9zMNjMLkEDhlHk3daLfrFNE1uucIxtcSMOI30b7nWOV6oCslqr2fPwPBrnd0jTSvre0+bXZpt1xqdl3MQMW3FRO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712113649; c=relaxed/simple;
	bh=ROtb/TdhEhS14cmCDYhPnEoNJ0jX0mNNsCCUwMkC5ks=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcteU3FEEj2phViZHqXmQCJfBK9DsewYTggSaLHB+WwyOJevjxVS85F9Y32dZOvI/8q1JtYNl/8MVT1VRI7P9izTXriUyOAElqZbKC2gVx0jkfLdEeu8U8ZiiCASt21jxAfhI7ZZZnu3+jhASjsUrWl/fppiZ876i//A5qXkrMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Y8m7nmA3; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 432K39iQ029137;
	Tue, 2 Apr 2024 20:06:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pfpt0220; bh=cIxSFpufY5nRKyMlIffzzC
	ralxEiy0TVlswlh++OQgg=; b=Y8m7nmA30w8NYNhiX4YIbCGNGlGZX7dT/8zPJv
	HlIxSC+6YMvHY21sG5K/WUMfk4V0GdHxba7suvb+SEIHVp3WY+s5BXMLo9KG/s8u
	mHmnkUyrhTxGHoPLOFUYCaVJJ6nZ4F7q6CLGmCERuXheUKkO202W8HOrFh4owbAV
	AbV9Db6FzRW0MiP6yruMsD5gxz2bBygAZzpkJaJaQOS6aVlCiOSRY1aYjzjlF3E4
	Rs9KjqOA0OX2ulNkcVLM6pC+QKUap67aLihgPW69+jx4m5d1kSCR00rZtXs8wptT
	guwL1M6SCfKq10J/1rFt91BJ+Ez1g+1obP+hbdbT35k4BTLw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3x809fx510-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 20:06:51 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 2 Apr 2024 20:06:49 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 2 Apr 2024 20:06:49 -0700
Received: from maili.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 134265B694C;
	Tue,  2 Apr 2024 20:06:43 -0700 (PDT)
Date: Wed, 3 Apr 2024 08:36:42 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Justin Stitt <justinstitt@google.com>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii
 Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song
	<yonghong.song@linux.dev>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers
	<ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
        <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] bpf: replace deprecated strncpy with strscpy
Message-ID: <20240403030642.GA1652044@maili.marvell.com>
References: <20240402-strncpy-kernel-bpf-core-c-v1-1-7cb07a426e78@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240402-strncpy-kernel-bpf-core-c-v1-1-7cb07a426e78@google.com>
X-Proofpoint-GUID: QmRE6pvh5nsQpJLoK1ntZVKZA9QB3BtZ
X-Proofpoint-ORIG-GUID: QmRE6pvh5nsQpJLoK1ntZVKZA9QB3BtZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_02,2024-04-01_01,2023-05-22_02

On 2024-04-03 at 05:22:50, Justin Stitt (justinstitt@google.com) wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
>
> bpf sym names get looked up and compared/cleaned with various string
> apis. This suggests they need to be NUL-terminated (strncpy() suggests
> this but does not guarantee it).
>
> |	static int compare_symbol_name(const char *name, char *namebuf)
> |	{
> |		cleanup_symbol_name(namebuf);
> |		return strcmp(name, namebuf);
> |	}
>
> |	static void cleanup_symbol_name(char *s)
> |	{
> |		...
> |		res = strstr(s, ".llvm.");
> |		...
> |	}
>
> Use strscpy() as this method guarantees NUL-termination on the
> destination buffer.
>
> This patch also replaces two uses of strncpy() used in log.c. These are
> simple replacements as postfix has been zero-initialized on the stack
> and has source arguments with a size less than the destination's size.
>
> Note that this patch uses the new 2-argument version of strscpy
> introduced in Commit e6584c3964f2f ("string: Allow 2-argument
> strscpy()").
>
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
>
> Found with: $ rg "strncpy\("
> ---
>  kernel/bpf/core.c | 4 ++--
>  kernel/bpf/log.c  | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 696bc55de8e8..8c9078f4549c 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -747,7 +747,7 @@ const char *__bpf_address_lookup(unsigned long addr, unsigned long *size,
>  		unsigned long symbol_start = ksym->start;
>  		unsigned long symbol_end = ksym->end;
>
> -		strncpy(sym, ksym->name, KSYM_NAME_LEN);
> +		strscpy(sym, ksym->name, KSYM_NAME_LEN);
You dont have to check return value of strscpy for errors ?

>
>  		ret = sym;
>  		if (size)
> @@ -813,7 +813,7 @@ int bpf_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
>  		if (it++ != symnum)
>  			continue;
>
> -		strncpy(sym, ksym->name, KSYM_NAME_LEN);
> +		strscpy(sym, ksym->name, KSYM_NAME_LEN);
>
>  		*value = ksym->start;
>  		*type  = BPF_SYM_ELF_TYPE;
> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> index 2a243cf37c60..4bd8f17a9f24 100644
> --- a/kernel/bpf/log.c
> +++ b/kernel/bpf/log.c
> @@ -467,9 +467,9 @@ const char *reg_type_str(struct bpf_verifier_env *env, enum bpf_reg_type type)
>
>  	if (type & PTR_MAYBE_NULL) {
>  		if (base_type(type) == PTR_TO_BTF_ID)
> -			strncpy(postfix, "or_null_", 16);
> +			strscpy(postfix, "or_null_");
>  		else
> -			strncpy(postfix, "_or_null", 16);
> +			strscpy(postfix, "_or_null");
>  	}
>
>  	snprintf(prefix, sizeof(prefix), "%s%s%s%s%s%s%s",
>
> ---
> base-commit: 026e680b0a08a62b1d948e5a8ca78700bfac0e6e
> change-id: 20240402-strncpy-kernel-bpf-core-c-4d8297f95e18
>
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
>

