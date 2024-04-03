Return-Path: <linux-kernel+bounces-130209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 888E2897566
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A59891C25F05
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD26614C596;
	Wed,  3 Apr 2024 16:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFbe3yxQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B84C1B7F4
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 16:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712162485; cv=none; b=QPJlyQaL9YXLj6J94/NxpHS/6g4aDeSiPNVjkYM0kk7Q1PKnvOLFMamjrrk5yAw4DaLQoH12RsNJj+WjtYkzIFe9ekrvj0o2ToRlGWz4IjtunJ6VOkJ8ZJV0oLGSjBF48le0iZv1WAiFnZ1nZw203ISST7SuwR31M9AFSPrHvZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712162485; c=relaxed/simple;
	bh=VexJclgIGmsUeF7CI2xMgQCuZXf6sBp/eNu+TfEwNiI=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=kJlFAKYCnwN8reQe4oeFs0tgHCbg0qGOL/Y21neZbdjgmabkEZ1gye09yxdB5XwAG1R1bF+WlnS6KpsETq/TMP7tFkj25Jbj0X+XhYh+8rdbNJYUTDP9U33LcYoBGGnrG7myQZk/AUQRInHqRyLRrJl+ex3M11tXLEOXWp0TW7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFbe3yxQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F24C433F1;
	Wed,  3 Apr 2024 16:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712162484;
	bh=VexJclgIGmsUeF7CI2xMgQCuZXf6sBp/eNu+TfEwNiI=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=nFbe3yxQTQQ2GZ+bPONz87rHGCY6CFv+MXeU38ZFqqYqKv7QK0eNlUyMNHXWQ3qu9
	 7KCSAOYepDrX8h9s+Lb9rJ3qI8V0em5aJZHpUbVwj7YmF+kmVthJZoIcYXNJ0rRVGt
	 0puEnNQoGpheH59BR6yKYbaJ5Kv7RSNM52cTNoiUME5QBgNVoWerpQXgFRaV8Citd4
	 m1Lj2qsFeOhWnCa4HZkmKujjmsWpxI/RHdJ46dutUmz92KuTb5TcUmfXYng4PXtI7f
	 3m7Lo5atm//Utqa+5NWPVkwZ+Vj27euih9fk/sOOX/gIYkd4L3++lLjFbc3ShNYREl
	 BMwwiLjMuqTBw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Apr 2024 19:41:20 +0300
Message-Id: <D0AMY0ZA8BZK.F6S2B4743MXL@kernel.org>
To: "Mark Rutland" <mark.rutland@arm.com>, <linux-kernel@vger.kernel.org>
Cc: <anil.s.keshavamurthy@intel.com>, <aou@eecs.berkeley.edu>,
 <catalin.marinas@arm.com>, <davem@davemloft.net>,
 <linux-arm-kernel@lists.infradead.org>, <mhiramat@kernel.org>,
 <naveen.n.rao@linux.ibm.com>, <palmer@dabbelt.com>,
 <paul.walmsley@sifive.com>, <will@kernel.org>
Subject: Re: [PATCH v2 4/4] kprobes: Remove core dependency on modules
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240403150154.667649-1-mark.rutland@arm.com>
 <20240403150154.667649-5-mark.rutland@arm.com>
In-Reply-To: <20240403150154.667649-5-mark.rutland@arm.com>

On Wed Apr 3, 2024 at 6:01 PM EEST, Mark Rutland wrote:
> From: Jarkko Sakkinen <jarkko@kernel.org>
>
> Tracing with kprobes while running a monolithic kernel is currently
> impossible because KPROBES depends on MODULES. While this dependency is
> necessary when HAVE_KPROBES_ALLOC=3Dn and the core kprobes code allocates
> memory using module_alloc(), all the other module-specific code only
> exist to handle the case when MODULES=3Dy, and can be hidden behind
> ifdeffery.
>
> Add the necessary ifdeffery, and remove the dependency on MODULES=3Dy whe=
n
> HAVE_KPROBES_ALLOC=3Dy.
>
> As of this patch kprobes can be used when MODULES=3Dn on arm64 and
> riscv. All other architectures still depend on MODULES, either by virtue
> of the core dependency on MODULES when HAVE_KPROBES_ALLOC=3Dn, or by
> virtue of an explciit dependency on MODULES in arch code.
>
> Other architectures can enable support by implementing their own
> kprobes_alloc_insn_page() and kprobes_free_insn_page() which do not
> depend on MODULES.
>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> Link: https://lore.kernel.org/lkml/20240326134616.7691-1-jarkko@kernel.or=
g/
> [Mark: Remove execmem changes, depend on HAVE_KPROBES_ALLOC]
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Will Deacon <will@kernel.org>
> ---
>  arch/Kconfig                |  2 +-
>  kernel/kprobes.c            | 46 ++++++++++++++++++++++---------------
>  kernel/trace/trace_kprobe.c | 15 ++++++++++--
>  3 files changed, 41 insertions(+), 22 deletions(-)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 85bb59f7b8c07..0df2c88547b3c 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -52,7 +52,7 @@ config GENERIC_ENTRY
> =20
>  config KPROBES
>  	bool "Kprobes"
> -	depends on MODULES
> +	depends on MODULES || HAVE_KPROBES_ALLOC
>  	depends on HAVE_KPROBES
>  	select KALLSYMS
>  	select TASKS_RCU if PREEMPTION
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index fa2ee4e59eca2..ec4493a41b505 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1594,6 +1594,7 @@ static int check_kprobe_address_safe(struct kprobe =
*p,
>  			goto out;
>  		}
> =20
> +#ifdef CONFIG_MODULES
>  		/*
>  		 * If the module freed '.init.text', we couldn't insert
>  		 * kprobes in there.
> @@ -1604,7 +1605,9 @@ static int check_kprobe_address_safe(struct kprobe =
*p,
>  			*probed_mod =3D NULL;
>  			ret =3D -ENOENT;
>  		}
> +#endif /* CONFIG_MODULES */
>  	}
> +
>  out:
>  	preempt_enable();
>  	jump_label_unlock();
> @@ -2484,24 +2487,6 @@ int kprobe_add_area_blacklist(unsigned long start,=
 unsigned long end)
>  	return 0;
>  }
> =20
> -/* Remove all symbols in given area from kprobe blacklist */
> -static void kprobe_remove_area_blacklist(unsigned long start, unsigned l=
ong end)
> -{
> -	struct kprobe_blacklist_entry *ent, *n;
> -
> -	list_for_each_entry_safe(ent, n, &kprobe_blacklist, list) {
> -		if (ent->start_addr < start || ent->start_addr >=3D end)
> -			continue;
> -		list_del(&ent->list);
> -		kfree(ent);
> -	}
> -}
> -
> -static void kprobe_remove_ksym_blacklist(unsigned long entry)
> -{
> -	kprobe_remove_area_blacklist(entry, entry + 1);
> -}
> -
>  int __weak arch_kprobe_get_kallsym(unsigned int *symnum, unsigned long *=
value,
>  				   char *type, char *sym)
>  {
> @@ -2566,6 +2551,25 @@ static int __init populate_kprobe_blacklist(unsign=
ed long *start,
>  	return ret ? : arch_populate_kprobe_blacklist();
>  }
> =20
> +#ifdef CONFIG_MODULES
> +/* Remove all symbols in given area from kprobe blacklist */
> +static void kprobe_remove_area_blacklist(unsigned long start, unsigned l=
ong end)
> +{
> +	struct kprobe_blacklist_entry *ent, *n;
> +
> +	list_for_each_entry_safe(ent, n, &kprobe_blacklist, list) {
> +		if (ent->start_addr < start || ent->start_addr >=3D end)
> +			continue;
> +		list_del(&ent->list);
> +		kfree(ent);
> +	}
> +}
> +
> +static void kprobe_remove_ksym_blacklist(unsigned long entry)
> +{
> +	kprobe_remove_area_blacklist(entry, entry + 1);
> +}
> +
>  static void add_module_kprobe_blacklist(struct module *mod)
>  {
>  	unsigned long start, end;
> @@ -2662,6 +2666,9 @@ static int kprobes_module_callback(struct notifier_=
block *nb,
>  	mutex_unlock(&kprobe_mutex);
>  	return NOTIFY_DONE;
>  }
> +#else
> +#define kprobes_module_callback	(NULL)
> +#endif /* CONFIG_MODULES */
> =20
>  static struct notifier_block kprobe_module_nb =3D {
>  	.notifier_call =3D kprobes_module_callback,
> @@ -2726,7 +2733,8 @@ static int __init init_kprobes(void)
>  	err =3D arch_init_kprobes();
>  	if (!err)
>  		err =3D register_die_notifier(&kprobe_exceptions_nb);
> -	if (!err)
> +
> +	if (!err && IS_ENABLED(CONFIG_MODULES))
>  		err =3D register_module_notifier(&kprobe_module_nb);
> =20
>  	kprobes_initialized =3D (err =3D=3D 0);
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 14099cc17fc9e..c509ba776e679 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -111,6 +111,7 @@ static nokprobe_inline bool trace_kprobe_within_modul=
e(struct trace_kprobe *tk,
>  	return strncmp(module_name(mod), name, len) =3D=3D 0 && name[len] =3D=
=3D ':';
>  }
> =20
> +#ifdef CONFIG_MODULES
>  static nokprobe_inline bool trace_kprobe_module_exist(struct trace_kprob=
e *tk)
>  {
>  	char *p;
> @@ -129,6 +130,9 @@ static nokprobe_inline bool trace_kprobe_module_exist=
(struct trace_kprobe *tk)
> =20
>  	return ret;
>  }
> +#else
> +#define trace_kprobe_module_exist(tk) false /* aka a module never exists=
 */
> +#endif /* CONFIG_MODULES */
> =20
>  static bool trace_kprobe_is_busy(struct dyn_event *ev)
>  {
> @@ -670,6 +674,7 @@ static int register_trace_kprobe(struct trace_kprobe =
*tk)
>  	return ret;
>  }
> =20
> +#ifdef CONFIG_MODULES
>  /* Module notifier call back, checking event on the module */
>  static int trace_kprobe_module_callback(struct notifier_block *nb,
>  				       unsigned long val, void *data)
> @@ -699,6 +704,9 @@ static int trace_kprobe_module_callback(struct notifi=
er_block *nb,
> =20
>  	return NOTIFY_DONE;
>  }
> +#else
> +#define trace_kprobe_module_callback (NULL)
> +#endif /* CONFIG_MODULES */
> =20
>  static struct notifier_block trace_kprobe_module_nb =3D {
>  	.notifier_call =3D trace_kprobe_module_callback,
> @@ -1933,8 +1941,11 @@ static __init int init_kprobe_trace_early(void)
>  	if (ret)
>  		return ret;
> =20
> -	if (register_module_notifier(&trace_kprobe_module_nb))
> -		return -EINVAL;
> +	if (IS_ENABLED(CONFIG_MODULES)) {
> +		ret =3D register_module_notifier(&trace_kprobe_module_nb);
> +		if (ret)
> +			return -EINVAL;
> +	}
> =20
>  	return 0;
>  }

I'll test the patch set asap.

BR, Jarkko

