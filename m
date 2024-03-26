Return-Path: <linux-kernel+bounces-119567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D8488CA83
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39619323988
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BA51CD2D;
	Tue, 26 Mar 2024 17:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NlHYV/Pf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34191C69C
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 17:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711473238; cv=none; b=Mg9UMePwUDrKdY1cxWrIdDazMWSmBDt3vSsPZmn+C6C/1RU5c9XosY5DqNLb/o3RmSLrZLUXFrAc0pIUCkPcc/eYyCvX7HziS2iaxH+KaPmmgsuga1o/FER+5YrvwePUeVJKh1u1D41Y97AtSNB5WcsxA35zIJ7quLT2lcefIzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711473238; c=relaxed/simple;
	bh=AJR5USqJiMDQOJPpOHN5Bf+9uA64buMtfFzhzaUh3jg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=TPQ1ERm0pHEnvar6Tc//Q4lP2bwxu9Na1GFMVfRc9YDgrGaLXL2beoK5h6RYRssUcBg8TwzNSWoxbrivruIUUwBhAu0MD/EnBMDRkFxixrdjbYz9dBIiZtPKUIAabJ8rUlpivET77oS3xGZeEFwt+9InTu2c5+QxqSFLrNm2tGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NlHYV/Pf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4F4C433F1;
	Tue, 26 Mar 2024 17:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711473237;
	bh=AJR5USqJiMDQOJPpOHN5Bf+9uA64buMtfFzhzaUh3jg=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=NlHYV/PfVN+fR+oUL/bR8wrrYkHVzVrwwurW1v0qiQp4Pl3WuqaQJa3gkjg0ZjopU
	 O59LhWiDSS2m1V/OQcpDwvQx7rEAVoANBoyRk9ymFhu0dnjHxnj5FjHPTARuknaKrk
	 tJgqzCgaJuw9AlGJkq0Fm1BLH1b9psVm+WZSJctymRcP3LEDkGgOXAFg0lEBpvQ9sW
	 4cPgMw57vLzHiwappHT/o3l4dUMrbXqNHgHcH4teUtFD8LP/DcAAOhNT+Z9C7ZuMN6
	 gw8iDk1b8rQI4DSwjPcU/RauzGlztanbOCMy2JhrfUw5xFCJ64gsLeTch+PNdCuvvI
	 f2tMhXwszhqgw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 Mar 2024 19:13:51 +0200
Message-Id: <D03UMKC71414.2D6NN1BIWD5TZ@kernel.org>
Cc: <agordeev@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
 <aou@eecs.berkeley.edu>, <bp@alien8.de>, <catalin.marinas@arm.com>,
 <dave.hansen@linux.intel.com>, <davem@davemloft.net>, <gor@linux.ibm.com>,
 <hca@linux.ibm.com>, <jcalvinowens@gmail.com>,
 <linux-arm-kernel@lists.infradead.org>, <mhiramat@kernel.org>,
 <mingo@redhat.com>, <mpe@ellerman.id.au>, <naveen.n.rao@linux.ibm.com>,
 <palmer@dabbelt.com>, <paul.walmsley@sifive.com>, <tglx@linutronix.de>,
 <will@kernel.org>
Subject: Re: [PATCH 4/4] kprobes: Remove core dependency on modules
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Mark Rutland" <mark.rutland@arm.com>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240326163624.3253157-1-mark.rutland@arm.com>
 <20240326163624.3253157-5-mark.rutland@arm.com>
In-Reply-To: <20240326163624.3253157-5-mark.rutland@arm.com>

On Tue Mar 26, 2024 at 6:36 PM EET, Mark Rutland wrote:
> From: Jarkko Sakkinen <jarkko@kernel.org>
>
> Tracing with kprobes while running a monolithic kernel is currently
> impossible because KPROBES depends on MODULES. While this dependency is
> necessary when KPROBES_USE_MODULE_ALLOC=3Dy, all the other module-specifi=
c
> code only exist to handle the case when MODULES=3Dy, and can be hidden
> behind ifdeffery.
>
> Add the necessary ifdeffery, and remove the dependency on MODULES=3DN whe=
n
> KPROBES_USE_MODULE_ALLOC=3Dn.
>
> Currently this allows kprobes to be used when CONFIG_MODULES=3Dn on arm64
> and riscv, and other architectures can enable support by implementing
> their own kprobes_alloc_insn_page() and kprobes_free_insn_page() which
> do not depend on MODULES.
>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> Link: https://lore.kernel.org/all/20240326012102.27438-1-jarkko@kernel.or=
g/
> [Mark: Remove execmem changes, depend on !KPROBES_USE_MODULE_ALLOC]
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
> ---
>  arch/Kconfig                |  2 +-
>  kernel/kprobes.c            | 12 +++++++++++-
>  kernel/trace/trace_kprobe.c | 15 +++++++++++++--
>  3 files changed, 25 insertions(+), 4 deletions(-)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 85bb59f7b8c07..cf43de9ffb5b9 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -52,7 +52,7 @@ config GENERIC_ENTRY
> =20
>  config KPROBES
>  	bool "Kprobes"
> -	depends on MODULES
> +	depends on MODULES || !KPROBES_USE_MODULE_ALLOC
>  	depends on HAVE_KPROBES
>  	select KALLSYMS
>  	select TASKS_RCU if PREEMPTION
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index fa2ee4e59eca2..7c2f0b504cdcb 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1582,6 +1582,7 @@ static int check_kprobe_address_safe(struct kprobe =
*p,
>  		goto out;
>  	}
> =20
> +#ifdef CONFIG_MODULES
>  	/* Check if 'p' is probing a module. */
>  	*probed_mod =3D __module_text_address((unsigned long) p->addr);
>  	if (*probed_mod) {
> @@ -1605,6 +1606,8 @@ static int check_kprobe_address_safe(struct kprobe =
*p,
>  			ret =3D -ENOENT;
>  		}
>  	}
> +#endif

This can be scoped a bit more (see v7 of my patch set).

> +
>  out:
>  	preempt_enable();
>  	jump_label_unlock();
> @@ -2484,6 +2487,7 @@ int kprobe_add_area_blacklist(unsigned long start, =
unsigned long end)
>  	return 0;
>  }
> =20
> +#ifdef CONFIG_MODULES
>  /* Remove all symbols in given area from kprobe blacklist */
>  static void kprobe_remove_area_blacklist(unsigned long start, unsigned l=
ong end)
>  {
> @@ -2501,6 +2505,7 @@ static void kprobe_remove_ksym_blacklist(unsigned l=
ong entry)
>  {
>  	kprobe_remove_area_blacklist(entry, entry + 1);
>  }
> +#endif /* CONFIG_MODULES */
> =20
>  int __weak arch_kprobe_get_kallsym(unsigned int *symnum, unsigned long *=
value,
>  				   char *type, char *sym)
> @@ -2566,6 +2571,7 @@ static int __init populate_kprobe_blacklist(unsigne=
d long *start,
>  	return ret ? : arch_populate_kprobe_blacklist();
>  }
> =20
> +#ifdef CONFIG_MODULES
>  static void add_module_kprobe_blacklist(struct module *mod)
>  {
>  	unsigned long start, end;
> @@ -2662,6 +2668,9 @@ static int kprobes_module_callback(struct notifier_=
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
> @@ -2726,7 +2735,8 @@ static int __init init_kprobes(void)
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

The last two CONFIG_MODULES sections could be combined. This was also in
v7.

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

Other than lgtm.

BR, Jarkko

