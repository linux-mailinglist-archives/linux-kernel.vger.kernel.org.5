Return-Path: <linux-kernel+bounces-97576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAAC876C12
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F1B31C20FFD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F035F478;
	Fri,  8 Mar 2024 20:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOJKqfeT"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20F35B20C;
	Fri,  8 Mar 2024 20:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709931427; cv=none; b=Tub1KxeGjGqhXVogPkP+eWUELDOUp+vD0gcucr3bOGi8I0xp7/y5vozOL0bA+/ygiKBkSgF498hkgOKGxY3ZKTRaur2TLzCM2Q29AuUyMvzgMlHK/uXXNNx0vXLfyod3O7VSCTbHPu+eGNuek2+ihAKXZv/MK89rF5XLsDSaRHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709931427; c=relaxed/simple;
	bh=VOH0uGjlamTkGKWBUFzaUSvLcg+ZgjEUF3K2hEsJEkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r24RwYSkrs8Vm9Hn+12PizvTv9VJ1GZWAWeF0TG3P6R50uefqVqlIQ7m5xoE+/djqtCm6/074ZWww6cAy/m760Z+ltX6yq+iNLRP/L6MWO4dsaucSMNCDCAKNFtPfConB/+ssFJ/nEGWVhQnDLglmeIcyRq7u1a8QNU2EewSBQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOJKqfeT; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dd5df90170so15540665ad.0;
        Fri, 08 Mar 2024 12:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709931425; x=1710536225; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LZ1lttaPT6oImPNItYzV/eS/q/nsl7IAM97Yp19qF10=;
        b=LOJKqfeTGeojhVOlPSrT4kQFHIVD7BIN3Q4C7V9cEc/EiGWdHA6/+HsMWC0PNwnEza
         StJhf1tK2ygdgHd12X2Q//O0uIzzzJL1q+qhQ+p1QrA/CX33ugZmxlkBRkWqGMS0QBe4
         YAywsu4epasZTkCkDwNjKC8F8+rpUqyBjzMVyYcUrkrluC3CXBcWOPd/isVscCNcSNtv
         V5CL/ElbU0UXTfACCVvE8eTm/M+AqW1HMHBCZ+Xu/drnIRCv8T7Sjn8R0hxnjrYyh/3F
         D1LgO5XbKh4UdNUWSdnsk9KL1u0ly7rEkAM/C4nbeDl02cAINL1+Zi1CgEB3ISdDhqxe
         CdJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709931425; x=1710536225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZ1lttaPT6oImPNItYzV/eS/q/nsl7IAM97Yp19qF10=;
        b=SiNYMrefjycYTm9dtX0WQKHeenKMTDGXiNTb9HtpHi2/BjTDsYYCCWcogtFEU/WNGn
         +V3gfCfiCEu41/r3PgC3OSCKcVkrhzH/nJjFH0/HudwjiCePdasvCEjHJBXkHQmbriEA
         U8l6Z+xeMW4Q31B8if8XkSqcsuC/Tv9OYgwpLe3YXpbKFZld534HSbmF6pob28sAlTUL
         Cxa9ElUtn3qeLQflh5lGkJoJtIxW1wJPvJiNj4TiksSs2PQpGrYklpdUMUOUsziHK+6Y
         1PZV2A0c2TDwEkJG2dIQEuIlrkkaNpHMIpfhK42YhIiSKHKZCGSAq/qXRQABS64zVsSj
         qDkA==
X-Forwarded-Encrypted: i=1; AJvYcCXR7fC6NGIFYxOzDbzeheSo8dBudt/Ifsxit0TxLsGBnByzdAF/YIn3BA/jXy5r/zm0DIkUfSH6DXOtgqL/WAbCnjlqth0KnH5sQ2LNPBO4vJ07eb966+vcuUyPpi001d+C0uOXKXjfhJF87W4jZnJn47aRuE2Lw7ZzuZuMrLHrTg==
X-Gm-Message-State: AOJu0YxpdV2+mdY9/zPiDw7VrwWjcQDgS8eo+EOdSgAfUr1YOhSAb87m
	mMJ1GXMvm9sw21ksWekVToRsErMISM7968yGLc+Cv5cCGw68Mlqw
X-Google-Smtp-Source: AGHT+IEvgUBojpUpbkDB25bGHd4TvdI+WTXfgYQ8kdQhv6hkv/khHthg5hmriSusZDYwDOf7ZsikBg==
X-Received: by 2002:a17:902:c942:b0:1dd:91c:249f with SMTP id i2-20020a170902c94200b001dd091c249fmr496165pla.24.1709931424783;
        Fri, 08 Mar 2024 12:57:04 -0800 (PST)
Received: from gmail.com ([192.184.166.229])
        by smtp.gmail.com with ESMTPSA id o11-20020a17090323cb00b001dcc0d06959sm69529plh.245.2024.03.08.12.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 12:57:04 -0800 (PST)
Date: Fri, 8 Mar 2024 12:57:02 -0800
From: Calvin Owens <jcalvinowens@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Naveen N Rao <naveen.n.rao@linux.ibm.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	David S Miller <davem@davemloft.net>,
	Thomas Gleixner <tglx@linutronix.de>, bpf@vger.kernel.org,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 3/4] kprobes: Allow kprobes with CONFIG_MODULES=n
Message-ID: <Zet7nsiStlbNx0km@gmail.com>
References: <cover.1709676663.git.jcalvinowens@gmail.com>
 <2af01251ca21d79fa29092505d192f1f1b746cff.1709676663.git.jcalvinowens@gmail.com>
 <20240308114603.289720cf17ed75ba7bce8779@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240308114603.289720cf17ed75ba7bce8779@kernel.org>

On Friday 03/08 at 11:46 +0900, Masami Hiramatsu wrote:
> On Wed,  6 Mar 2024 12:05:10 -0800
> Calvin Owens <jcalvinowens@gmail.com> wrote:
> 
> > If something like this is merged down the road, it can go in at leisure
> > once the module_alloc change is in: it's a one-way dependency.
> > 
> > Signed-off-by: Calvin Owens <jcalvinowens@gmail.com>
> > ---
> >  arch/Kconfig                |  2 +-
> >  kernel/kprobes.c            | 22 ++++++++++++++++++++++
> >  kernel/trace/trace_kprobe.c | 11 +++++++++++
> >  3 files changed, 34 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index cfc24ced16dd..e60ce984d095 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -52,8 +52,8 @@ config GENERIC_ENTRY
> >  
> >  config KPROBES
> >  	bool "Kprobes"
> > -	depends on MODULES
> >  	depends on HAVE_KPROBES
> > +	select MODULE_ALLOC
> 
> OK, if we use EXEC_ALLOC,
> 
> config EXEC_ALLOC
> 	depends on HAVE_EXEC_ALLOC
> 
> And 
> 
>   config KPROBES
>   	bool "Kprobes"
> 	depends on MODULES || EXEC_ALLOC
> 	select EXEC_ALLOC if HAVE_EXEC_ALLOC
> 
> then kprobes can be enabled either modules supported or exec_alloc is supported.
> (new arch does not need to implement exec_alloc)
> 
> Maybe we also need something like
> 
> #ifdef CONFIG_EXEC_ALLOC
> #define module_alloc(size) exec_alloc(size)
> #endif
> 
> in kprobes.h, or just add `replacing module_alloc with exec_alloc` patch.
> 
> Thank you,

The example was helpful, thanks. I see what you mean with
HAVE_EXEC_ALLOC, I'll implement it like that in the next verison.

> >  	select KALLSYMS
> >  	select TASKS_RCU if PREEMPTION
> >  	help
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index 9d9095e81792..194270e17d57 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -1556,8 +1556,12 @@ static bool is_cfi_preamble_symbol(unsigned long addr)
> >  		str_has_prefix("__pfx_", symbuf);
> >  }
> >  
> > +#if IS_ENABLED(CONFIG_MODULES)
> >  static int check_kprobe_address_safe(struct kprobe *p,
> >  				     struct module **probed_mod)
> > +#else
> > +static int check_kprobe_address_safe(struct kprobe *p)
> > +#endif
> >  {
> >  	int ret;
> >  
> > @@ -1580,6 +1584,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
> >  		goto out;
> >  	}
> >  
> > +#if IS_ENABLED(CONFIG_MODULES)
> >  	/* Check if 'p' is probing a module. */
> >  	*probed_mod = __module_text_address((unsigned long) p->addr);
> >  	if (*probed_mod) {
> > @@ -1603,6 +1608,8 @@ static int check_kprobe_address_safe(struct kprobe *p,
> >  			ret = -ENOENT;
> >  		}
> >  	}
> > +#endif
> > +
> >  out:
> >  	preempt_enable();
> >  	jump_label_unlock();
> > @@ -1614,7 +1621,9 @@ int register_kprobe(struct kprobe *p)
> >  {
> >  	int ret;
> >  	struct kprobe *old_p;
> > +#if IS_ENABLED(CONFIG_MODULES)
> >  	struct module *probed_mod;
> > +#endif
> >  	kprobe_opcode_t *addr;
> >  	bool on_func_entry;
> >  
> > @@ -1633,7 +1642,11 @@ int register_kprobe(struct kprobe *p)
> >  	p->nmissed = 0;
> >  	INIT_LIST_HEAD(&p->list);
> >  
> > +#if IS_ENABLED(CONFIG_MODULES)
> >  	ret = check_kprobe_address_safe(p, &probed_mod);
> > +#else
> > +	ret = check_kprobe_address_safe(p);
> > +#endif
> >  	if (ret)
> >  		return ret;
> >  
> > @@ -1676,8 +1689,10 @@ int register_kprobe(struct kprobe *p)
> >  out:
> >  	mutex_unlock(&kprobe_mutex);
> >  
> > +#if IS_ENABLED(CONFIG_MODULES)
> >  	if (probed_mod)
> >  		module_put(probed_mod);
> > +#endif
> >  
> >  	return ret;
> >  }
> > @@ -2482,6 +2497,7 @@ int kprobe_add_area_blacklist(unsigned long start, unsigned long end)
> >  	return 0;
> >  }
> >  
> > +#if IS_ENABLED(CONFIG_MODULES)
> >  /* Remove all symbols in given area from kprobe blacklist */
> >  static void kprobe_remove_area_blacklist(unsigned long start, unsigned long end)
> >  {
> > @@ -2499,6 +2515,7 @@ static void kprobe_remove_ksym_blacklist(unsigned long entry)
> >  {
> >  	kprobe_remove_area_blacklist(entry, entry + 1);
> >  }
> > +#endif
> >  
> >  int __weak arch_kprobe_get_kallsym(unsigned int *symnum, unsigned long *value,
> >  				   char *type, char *sym)
> > @@ -2564,6 +2581,7 @@ static int __init populate_kprobe_blacklist(unsigned long *start,
> >  	return ret ? : arch_populate_kprobe_blacklist();
> >  }
> >  
> > +#if IS_ENABLED(CONFIG_MODULES)
> >  static void add_module_kprobe_blacklist(struct module *mod)
> >  {
> >  	unsigned long start, end;
> > @@ -2665,6 +2683,7 @@ static struct notifier_block kprobe_module_nb = {
> >  	.notifier_call = kprobes_module_callback,
> >  	.priority = 0
> >  };
> > +#endif /* IS_ENABLED(CONFIG_MODULES) */
> >  
> >  void kprobe_free_init_mem(void)
> >  {
> > @@ -2724,8 +2743,11 @@ static int __init init_kprobes(void)
> >  	err = arch_init_kprobes();
> >  	if (!err)
> >  		err = register_die_notifier(&kprobe_exceptions_nb);
> > +
> > +#if IS_ENABLED(CONFIG_MODULES)
> >  	if (!err)
> >  		err = register_module_notifier(&kprobe_module_nb);
> > +#endif
> >  
> >  	kprobes_initialized = (err == 0);
> >  	kprobe_sysctls_init();
> > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > index c4c6e0e0068b..dd4598f775b9 100644
> > --- a/kernel/trace/trace_kprobe.c
> > +++ b/kernel/trace/trace_kprobe.c
> > @@ -102,6 +102,7 @@ static nokprobe_inline bool trace_kprobe_has_gone(struct trace_kprobe *tk)
> >  	return kprobe_gone(&tk->rp.kp);
> >  }
> >  
> > +#if IS_ENABLED(CONFIG_MODULES)
> >  static nokprobe_inline bool trace_kprobe_within_module(struct trace_kprobe *tk,
> >  						 struct module *mod)
> >  {
> > @@ -129,6 +130,12 @@ static nokprobe_inline bool trace_kprobe_module_exist(struct trace_kprobe *tk)
> >  
> >  	return ret;
> >  }
> > +#else
> > +static nokprobe_inline bool trace_kprobe_module_exist(struct trace_kprobe *tk)
> > +{
> > +	return true;
> > +}
> > +#endif
> >  
> >  static bool trace_kprobe_is_busy(struct dyn_event *ev)
> >  {
> > @@ -670,6 +677,7 @@ static int register_trace_kprobe(struct trace_kprobe *tk)
> >  	return ret;
> >  }
> >  
> > +#if IS_ENABLED(CONFIG_MODULES)
> >  /* Module notifier call back, checking event on the module */
> >  static int trace_kprobe_module_callback(struct notifier_block *nb,
> >  				       unsigned long val, void *data)
> > @@ -704,6 +712,7 @@ static struct notifier_block trace_kprobe_module_nb = {
> >  	.notifier_call = trace_kprobe_module_callback,
> >  	.priority = 1	/* Invoked after kprobe module callback */
> >  };
> > +#endif /* IS_ENABLED(CONFIG_MODULES) */
> >  
> >  static int count_symbols(void *data, unsigned long unused)
> >  {
> > @@ -1897,8 +1906,10 @@ static __init int init_kprobe_trace_early(void)
> >  	if (ret)
> >  		return ret;
> >  
> > +#if IS_ENABLED(CONFIG_MODULES)
> >  	if (register_module_notifier(&trace_kprobe_module_nb))
> >  		return -EINVAL;
> > +#endif
> >  
> >  	return 0;
> >  }
> > -- 
> > 2.43.0
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

