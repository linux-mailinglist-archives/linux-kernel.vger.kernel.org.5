Return-Path: <linux-kernel+bounces-68526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECE7857BC1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2D0D281BD9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEAC77F10;
	Fri, 16 Feb 2024 11:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bobwKDm3"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6260559B54
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 11:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708083189; cv=none; b=PVVCaYsMsfpY94hSV0kSCuSXRAZ8DW0jNntVBgk4XRrfIWdlsi1wlSkjdIts5vpBHPzDMYlZzPSSH97E3iJE0Sx7lSkyr0YHPgMjD9WS9By70BBausyrzjlXAFi6GB00x81uM5+qarCTcliQotMYJBNJrV7wiHkSLW3Gz0yIhlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708083189; c=relaxed/simple;
	bh=ekvMJejM8Q9Rsm8ABH1MCujBINVBhoGUHsSnAiGIfys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=UyB6vaNW0JxrrJIt4WePALwzYIegwfb5YFqyvoAkOvD4kNKcRAsKio6lPZgKWaduxlM7vr74KFpR5IaCJjULSOzrD0t9w1qZoAR+552lMEj0Tt7H9pCu3zzByMHT4TsH9BX/jvEHkpdvSBlAFZuw/IxFtr/csNLH+Gi7dp3pk3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=bobwKDm3; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240216113305euoutp02de4ddcc5ce9c0790512424501b62ad40~0VJt5fipS0053900539euoutp02U
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 11:33:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240216113305euoutp02de4ddcc5ce9c0790512424501b62ad40~0VJt5fipS0053900539euoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1708083185;
	bh=vBj+uB8tvahP4rV/oT29NFzwDEVKTcXGWXsARXzcPvY=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=bobwKDm3eShanxdqtRUTSZ3Rnyu72F84dmVdOdx++VU8jJYu1c8Shw6hugex130XN
	 /h7jzetrpfw+9i+f3soB9PMBuJWwlXwUzYuM2lcQ5RNwbyBb7gTyKaJcXsM1JGS25L
	 Qr2/+GMi/4g9qJqHfaCTgHKRQz7MVe2mDqX8D1vw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240216113305eucas1p2baf95d9fa84d86ea5c57fc72886ba26c~0VJtrZa7R0290902909eucas1p25;
	Fri, 16 Feb 2024 11:33:05 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 10.0B.09539.1F74FC56; Fri, 16
	Feb 2024 11:33:05 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240216113304eucas1p24e80244975c156a6937fc6acaff23f19~0VJtAor0M2551425514eucas1p29;
	Fri, 16 Feb 2024 11:33:04 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240216113304eusmtrp2bc875415e4bfc5c94586e15dd4d68dbb~0VJs-9HnT2293822938eusmtrp2n;
	Fri, 16 Feb 2024 11:33:04 +0000 (GMT)
X-AuditID: cbfec7f2-52bff70000002543-a0-65cf47f1f724
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id ED.4D.09146.0F74FC56; Fri, 16
	Feb 2024 11:33:04 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240216113303eusmtip1a84c59b8cf1694f94af5ff5b281936fc~0VJsj7a3o1155111551eusmtip1L;
	Fri, 16 Feb 2024 11:33:03 +0000 (GMT)
Message-ID: <5cb55af6-5c9f-4a75-8c42-819415aec4d2@samsung.com>
Date: Fri, 16 Feb 2024 12:33:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] module: Don't ignore errors from set_memory_XX()
Content-Language: en-US
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Luis Chamberlain
	<mcgrof@kernel.org>, linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
	"linux-hardening @ vger . kernel . org" <linux-hardening@vger.kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <21037bf38438a285f5dff9501668f1675bc45989.1708070781.git.christophe.leroy@csgroup.eu>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRjtt7vH3WRynYqfJpqjGmaaQujCCiWtVRCBFCVRrbyoNJdszkf/
	NNZLJ5HOJJvOZ2aaaQ1xpmm50CWGj96KZuRU8omPMh+5ul4r/zvn+87hnO/HD8cEuSw3PFae
	QCrkUpmQzWPWti50+E4f6CT9M65xxH26EY74dXqcOL96AYnf1uexxerceZa49GM3Q/wpYwiF
	cCSV+ZVIkqvuZkq+93QwJMaKNLZk1uhxlBXJ2x1FymITScWOvWd5MX0NNkb8rcDkO2OZSI1+
	+GgRjgOxE3TZCi3i4QLiAYJM9Us2TeYQFKXaWDSZRaDpv420iLvqmOnNW1uUIZhs+oloMv3H
	r6lnUCo+sRcaGsZXHUxiC1yx5rDouQO03bUyKexMeMJAbw6Hwo6EBEpGaT1GuECvtYBB9XMi
	UuBDaQg9NiF40byZwmwiALQTWjYl4RLnIGsohpZ4gmkiD6PqANGHw8t8I4suHQbvl8vXDnCE
	UUsNh8buYHtKRVGGGwgKlwbWSAYC9UjvmiMY+joWV9Mwwhuq63fQ41DIWRlk0e9oD58mHOgS
	9qCrvYPRYz6kXhfQ6q2gt1T9i23ueoNlIKF+3aPo1x2vX3eO/n9uIWJWIBdSpYyLJpUBcjLJ
	TymNU6rk0X7nL8YZ0Z//075imalDhtFpPzNi4MiMAMeETnzdzdekgB8lTblEKi6eUahkpNKM
	NuJMoQt/S5QnKSCipQnkBZKMJxV/twyc66ZmRAShG023757MrupqH2+5NxV2sDQtcflVwRND
	kPPgt4QNDiLSFDJdcm28OLTqQFtmY5Pdcx/XffPhFXVDts/+qjCbW2SkIXUxjbBtfz7cX39P
	FVt9+LS3ERsIKeufCOb5B2XJ9GC4n7y/qM01QiVZ1nlwnB29B74Y0iO4U6OT6blaTnuS1fMq
	Yf6qiC8Zk+h3WQ61hPb4iWzG5NOPPDrT1A+bucftlzY9mue8Y9mGp6RhviZ14IhGJDhWERQc
	WVQ8Z0G+DpUnug3PZCLRWCPvSKc54FStlw/TtSY8PTXpV02J++VFU5edRmP1GkteaM0utzz2
	OpEl36OPCn/oJGQqY6QB2zCFUvobb9Qohq4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsVy+t/xu7of3M+nGizeIGZxZ9Jzdosz3bkW
	89b/ZLS4vGsOm0XD7O+sFkuvX2SyuDHhKaMDu8eaeWsYPWY3XGTx+HrzHJPHplWdbB6fN8kF
	sEbp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZdzZ
	/Z+poN+sYvrriYwNjN+0uxg5OSQETCQ+3ZrD2sXIxSEksJRRYtm63SwQCRmJk9MaWCFsYYk/
	17rYIIreM0rcu3EcrIhXwE5i9+43jCA2i4CqRPOTGawQcUGJkzOfgNWICshL3L81gx3EFhbw
	kFj8CqKeWUBc4taT+UwgtohApcTjJ0eZQRYwC2xnlDi7sJMFYttWRolHLdfBOtgEDCW63oKc
	wcHBKZAkMflpBsQgM4murV1QQ+Ultr+dwzyBUWgWkjtmIdk3C0nLLCQtCxhZVjGKpJYW56bn
	FhvqFSfmFpfmpesl5+duYgRG3bZjPzfvYJz36qPeIUYmDsZDjBIczEoivJN6z6QK8aYkVlal
	FuXHF5XmpBYfYjQFBsZEZinR5Hxg3OeVxBuaGZgamphZGphamhkrifN6FnQkCgmkJ5akZqem
	FqQWwfQxcXBKNTDtmTyrNdg24dNvnri8I/n/xTjW784oX/2k5Na7nx03mLImBBucf9zRXH+p
	LlzQet2zmU7npJ4dZ+ls2ut9p6j9l/CywObHkk+mnFDulFiZ/ENFZ0mZgPknl79MM1Yy/TRa
	8KHrwdHU6R4Oravzb4pfL5VbyNCYfvXanbsNbYI1Fask1rU/tF/bL2bxr+T74r8/kyZYLCju
	iFpuE/2A7X1k8/F8xa0OLHcWq6zSqpXoC5q/4V/slxMt6VvX76pxtfRj+M1045cr53ZH1u0J
	bcwzP8TN6r4SX9yzqi15Ud2HDVv4irV1Nty6M//mtKion0w+ScGbToUVqK0y1gt8eUozIKrP
	7Y2giXq3e8LxKfeVWIozEg21mIuKEwEwdpiXQwMAAA==
X-CMS-MailID: 20240216113304eucas1p24e80244975c156a6937fc6acaff23f19
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240216081457eucas1p2c22493d17918753128b39df47e98d8cd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240216081457eucas1p2c22493d17918753128b39df47e98d8cd
References: <CGME20240216081457eucas1p2c22493d17918753128b39df47e98d8cd@eucas1p2.samsung.com>
	<21037bf38438a285f5dff9501668f1675bc45989.1708070781.git.christophe.leroy@csgroup.eu>

On 16.02.2024 09:14, Christophe Leroy wrote:
> set_memory_ro(), set_memory_nx(), set_memory_x() and other helpers
> can fail and return an error. In that case the memory might not be
> protected as expected and the module loading has to be aborted to
> avoid security issues.
>
> Check return value of all calls to set_memory_XX() and handle
> error if any.
>
> Add a check to not call set_memory_XX() on NULL pointers as some
> architectures may not like it allthough numpages is always 0 in that
> case. This also avoid a useless call to set_vm_flush_reset_perms().
>
> Link:https://github.com/KSPP/linux/issues/7
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
> v2:
> - Bail out early from module_set_memory() when address is NULL.
> - Properly clear bug list when module_set_memory() fails in complete_formation().
>
> This patch applies on top of modules/modules-next branch
> ---
>   kernel/module/internal.h   |  6 ++---
>   kernel/module/main.c       | 20 ++++++++++++---
>   kernel/module/strict_rwx.c | 51 +++++++++++++++++++++++++++-----------
>   3 files changed, 55 insertions(+), 22 deletions(-)
>
> diff --git a/kernel/module/internal.h b/kernel/module/internal.h
> index 4f1b98f011da..2ebece8a789f 100644
> --- a/kernel/module/internal.h
> +++ b/kernel/module/internal.h
> @@ -322,9 +322,9 @@ static inline struct module *mod_find(unsigned long addr, struct mod_tree_root *
>   }
>   #endif /* CONFIG_MODULES_TREE_LOOKUP */
>   
> -void module_enable_rodata_ro(const struct module *mod, bool after_init);
> -void module_enable_data_nx(const struct module *mod);
> -void module_enable_text_rox(const struct module *mod);
> +int module_enable_rodata_ro(const struct module *mod, bool after_init);
> +int module_enable_data_nx(const struct module *mod);
> +int module_enable_text_rox(const struct module *mod);
>   int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
>   				char *secstrings, struct module *mod);
>   
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index a9a4a4885102..689def7676c4 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2571,7 +2571,9 @@ static noinline int do_init_module(struct module *mod)
>   	/* Switch to core kallsyms now init is done: kallsyms may be walking! */
>   	rcu_assign_pointer(mod->kallsyms, &mod->core_kallsyms);
>   #endif
> -	module_enable_rodata_ro(mod, true);
> +	ret = module_enable_rodata_ro(mod, true);
> +	if (ret)
> +		goto fail_mutex_unlock;
>   	mod_tree_remove_init(mod);
>   	module_arch_freeing_init(mod);
>   	for_class_mod_mem_type(type, init) {
> @@ -2609,6 +2611,8 @@ static noinline int do_init_module(struct module *mod)
>   
>   	return 0;
>   
> +fail_mutex_unlock:
> +	mutex_unlock(&module_mutex);
>   fail_free_freeinit:
>   	kfree(freeinit);
>   fail:
> @@ -2736,9 +2740,15 @@ static int complete_formation(struct module *mod, struct load_info *info)
>   	module_bug_finalize(info->hdr, info->sechdrs, mod);
>   	module_cfi_finalize(info->hdr, info->sechdrs, mod);
>   
> -	module_enable_rodata_ro(mod, false);
> -	module_enable_data_nx(mod);
> -	module_enable_text_rox(mod);
> +	err = module_enable_rodata_ro(mod, false);
> +	if (err)
> +		goto out_strict_rwx;
> +	err = module_enable_data_nx(mod);
> +	if (err)
> +		goto out_strict_rwx;
> +	err = module_enable_text_rox(mod);
> +	if (err)
> +		goto out_strict_rwx;
>   
>   	/*
>   	 * Mark state as coming so strong_try_module_get() ignores us,
> @@ -2749,6 +2759,8 @@ static int complete_formation(struct module *mod, struct load_info *info)
>   
>   	return 0;
>   
> +out_strict_rwx:
> +	module_bug_cleanup(mod);
>   out:
>   	mutex_unlock(&module_mutex);
>   	return err;
> diff --git a/kernel/module/strict_rwx.c b/kernel/module/strict_rwx.c
> index b36d93983465..c45caa4690e5 100644
> --- a/kernel/module/strict_rwx.c
> +++ b/kernel/module/strict_rwx.c
> @@ -11,13 +11,16 @@
>   #include <linux/set_memory.h>
>   #include "internal.h"
>   
> -static void module_set_memory(const struct module *mod, enum mod_mem_type type,
> -			      int (*set_memory)(unsigned long start, int num_pages))
> +static int module_set_memory(const struct module *mod, enum mod_mem_type type,
> +			     int (*set_memory)(unsigned long start, int num_pages))
>   {
>   	const struct module_memory *mod_mem = &mod->mem[type];
>   
> +	if (!mod_mem->base)
> +		return 0;
> +
>   	set_vm_flush_reset_perms(mod_mem->base);
> -	set_memory((unsigned long)mod_mem->base, mod_mem->size >> PAGE_SHIFT);
> +	return set_memory((unsigned long)mod_mem->base, mod_mem->size >> PAGE_SHIFT);
>   }
>   
>   /*
> @@ -26,35 +29,53 @@ static void module_set_memory(const struct module *mod, enum mod_mem_type type,
>    * CONFIG_STRICT_MODULE_RWX because they are needed regardless of whether we
>    * are strict.
>    */
> -void module_enable_text_rox(const struct module *mod)
> +int module_enable_text_rox(const struct module *mod)
>   {
>   	for_class_mod_mem_type(type, text) {
> +		int ret;
> +
>   		if (IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
> -			module_set_memory(mod, type, set_memory_rox);
> +			ret = module_set_memory(mod, type, set_memory_rox);
>   		else
> -			module_set_memory(mod, type, set_memory_x);
> +			ret = module_set_memory(mod, type, set_memory_x);
> +		if (ret)
> +			return ret;
>   	}
> +	return 0;
>   }
>   
> -void module_enable_rodata_ro(const struct module *mod, bool after_init)
> +int module_enable_rodata_ro(const struct module *mod, bool after_init)
>   {
> +	int ret;
> +
>   	if (!IS_ENABLED(CONFIG_STRICT_MODULE_RWX) || !rodata_enabled)
> -		return;
> +		return 0;
>   
> -	module_set_memory(mod, MOD_RODATA, set_memory_ro);
> -	module_set_memory(mod, MOD_INIT_RODATA, set_memory_ro);
> +	ret = module_set_memory(mod, MOD_RODATA, set_memory_ro);
> +	if (ret)
> +		return ret;
> +	ret = module_set_memory(mod, MOD_INIT_RODATA, set_memory_ro);
> +	if (ret)
> +		return ret;
>   
>   	if (after_init)
> -		module_set_memory(mod, MOD_RO_AFTER_INIT, set_memory_ro);
> +		return module_set_memory(mod, MOD_RO_AFTER_INIT, set_memory_ro);
> +
> +	return 0;
>   }
>   
> -void module_enable_data_nx(const struct module *mod)
> +int module_enable_data_nx(const struct module *mod)
>   {
>   	if (!IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
> -		return;
> +		return 0;
>   
> -	for_class_mod_mem_type(type, data)
> -		module_set_memory(mod, type, set_memory_nx);
> +	for_class_mod_mem_type(type, data) {
> +		int ret = module_set_memory(mod, type, set_memory_nx);
> +
> +		if (ret)
> +			return ret;
> +	}
> +	return 0;
>   }
>   
>   int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


