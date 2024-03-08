Return-Path: <linux-kernel+bounces-97588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDA0876C39
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 22:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C791FB22464
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FCD5FBA3;
	Fri,  8 Mar 2024 21:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtTL745w"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285815FB8B;
	Fri,  8 Mar 2024 21:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709931727; cv=none; b=dZ/qEqVEgPjMVQhic3jMCvNB9pXUYFC8U8ya9ARTDr1AueCSn661mkRihFuVxkarFSoAUkO/M+gIxBtn+8bEWtZmaJdXWRnU1U+nBGEsXxxAgpK/3DuCgq+jDCMruKpNhrkWGUbKvnNHk59f0kLsBMxbwk+nblQEPuZdxQEadww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709931727; c=relaxed/simple;
	bh=UM9jc5fgmHbVL7BnLQyjcqJgARZoM0vip8uYMrCWmcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tm1JQq/ORqdJKaT3ZoT5G8AYuSQ8smbo+frvyW2sVpgO1yOcyVLGYh4U3ac0OO27xI0868JdRBL2KomzD8v5O0ZrrqOUIvJQvacXTjxNFPsssWbleCUKOJshjojJUGg9l2bi701oRLbfSJJ8h9ydbm3xgYpKSvIpvtqw7fgpsek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MtTL745w; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dc3b4b9b62so17037445ad.1;
        Fri, 08 Mar 2024 13:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709931725; x=1710536525; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MlvOvJpv2KQUnvLAYq6IvlB8qPuNbA/g11CjU9bj0BA=;
        b=MtTL745w3BOW2LNqIcVNLzCkSoaZvbVkCbYL6RmEQ1b99wfzcgKJgBn/WJ4gTHmkzZ
         DBN26HJQerN6Nv4uOYcm9Ohr3bljGBPIWIZQPs3CuTwz8eptyv5F/HKfUKz2OLaSDOn/
         iJPVVVWe9Ar1suUvT6UJ1EEXCJp4VCvGGYDZuQr4xHFk8MC2n9VvarHbGVoyL/R7GKmW
         OuoXPm1+hwQu9T3haHzhgDJNCyr+n39u4l1jtP3mdKWSaxJNkWH9Q3LfX3jGQk3VtF8q
         wrE1jHNBJlSAZNJUvUhLJCAJxpuuUDxOwJHTEsmJdHp6wgi7NW4ObBgIkGgrl+WQ6SDF
         E4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709931725; x=1710536525;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MlvOvJpv2KQUnvLAYq6IvlB8qPuNbA/g11CjU9bj0BA=;
        b=P12vYIuUuvJ2x4QfxhP57aMZRCFzTw7E+QqwImPQQBuaVzAbqHUuAiuuvSXtB4C1rk
         HkxJeK2IGIHNpIk6Kc5WSuaYOnrweHGQ6a3q5K8w1rbkNpopdqlrcyCenIIoY8/vlKMR
         dP87qCcPfDvTSbLBu6qn1marHkLZX6KJMb2z5caH11Y6ys6ssxMoJmu5e+zITNR+xOok
         uu7ATdWDZBYKwt2WS8bLaDLFakuAP7y78ZGBaAuYGhE9ok9nZnKpaxUZiJXPbJXQ1gO1
         Kviz5RDiLJqXUFIVikdQpUN6He4hzWbPC7ARVOghIUqciTHHdSdnpA+3eXicSrsWeUIF
         sN6A==
X-Forwarded-Encrypted: i=1; AJvYcCXMxSPs09+SYrKT11HMQnQhRKx721ZV36FXPGYdtxMgCYWDKMNMIE5c6XF5LcGsyP5RaNi9L77rHo67/DQjqrXQ+2khrCWNQoAKTXWJs/IjvlpxiXf8eyspDxPD0RlQsK/UMHa8cZ6GZpeYc2fMsiNfoYeZ7Dyc73Ta8DIypKLGAg==
X-Gm-Message-State: AOJu0Yzx2ommL9uBITunyBojfF4v7AtmfpnkX17TR6DZV2vHHmFnCgEX
	yz6a1pV8ol5qHlR5ypC2MF+G4M5exwpNfnCXBfz+x2yV6qXM0g+i
X-Google-Smtp-Source: AGHT+IGk+iT+FE+TYssg7RRbD5XfhXvy0SNNI5TXV2um2c8N4t0DXwsR/2DKFSBnOGuiYn72CtTyHQ==
X-Received: by 2002:a17:902:d484:b0:1dd:69bb:7f96 with SMTP id c4-20020a170902d48400b001dd69bb7f96mr423882plg.6.1709931725316;
        Fri, 08 Mar 2024 13:02:05 -0800 (PST)
Received: from gmail.com ([192.184.166.229])
        by smtp.gmail.com with ESMTPSA id h20-20020a170902f2d400b001d974ffa1fcsm75044plc.173.2024.03.08.13.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 13:02:04 -0800 (PST)
Date: Fri, 8 Mar 2024 13:02:02 -0800
From: Calvin Owens <jcalvinowens@gmail.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen.n.rao@linux.ibm.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	David S Miller <davem@davemloft.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH 3/4] kprobes: Allow kprobes with CONFIG_MODULES=n
Message-ID: <Zet8ykBtJhfVJuYR@gmail.com>
References: <cover.1709676663.git.jcalvinowens@gmail.com>
 <2af01251ca21d79fa29092505d192f1f1b746cff.1709676663.git.jcalvinowens@gmail.com>
 <79062fa3-3402-47b3-8920-9231ad05e964@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <79062fa3-3402-47b3-8920-9231ad05e964@csgroup.eu>

On Thursday 03/07 at 22:16 +0000, Christophe Leroy wrote:
> 
> 
> Le 06/03/2024 à 21:05, Calvin Owens a écrit :
> > [Vous ne recevez pas souvent de courriers de jcalvinowens@gmail.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > If something like this is merged down the road, it can go in at leisure
> > once the module_alloc change is in: it's a one-way dependency.
> 
> Too many #ifdef, please reorganise stuff to avoid that and avoid 
> changing prototypes based of CONFIG_MODULES.
> 
> Other few comments below.

TBH the ugliness here was just me trying not to trigger -Wunused, but
that was silly: as you point out below, it's unncessary. I'll clean it
up.

> > 
> > Signed-off-by: Calvin Owens <jcalvinowens@gmail.com>
> > ---
> >   arch/Kconfig                |  2 +-
> >   kernel/kprobes.c            | 22 ++++++++++++++++++++++
> >   kernel/trace/trace_kprobe.c | 11 +++++++++++
> >   3 files changed, 34 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index cfc24ced16dd..e60ce984d095 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -52,8 +52,8 @@ config GENERIC_ENTRY
> > 
> >   config KPROBES
> >          bool "Kprobes"
> > -       depends on MODULES
> >          depends on HAVE_KPROBES
> > +       select MODULE_ALLOC
> >          select KALLSYMS
> >          select TASKS_RCU if PREEMPTION
> >          help
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index 9d9095e81792..194270e17d57 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -1556,8 +1556,12 @@ static bool is_cfi_preamble_symbol(unsigned long addr)
> >                  str_has_prefix("__pfx_", symbuf);
> >   }
> > 
> > +#if IS_ENABLED(CONFIG_MODULES)
> >   static int check_kprobe_address_safe(struct kprobe *p,
> >                                       struct module **probed_mod)
> > +#else
> > +static int check_kprobe_address_safe(struct kprobe *p)
> > +#endif
> 
> A bit ugly to have to change the prototype, why not just keep probed_mod 
> at all time ?
> 
> When CONFIG_MODULES is not selected, __module_text_address() returns 
> NULL so it should work without that many #ifdefs.
> 
> >   {
> >          int ret;
> > 
> > @@ -1580,6 +1584,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
> >                  goto out;
> >          }
> > 
> > +#if IS_ENABLED(CONFIG_MODULES)
> >          /* Check if 'p' is probing a module. */
> >          *probed_mod = __module_text_address((unsigned long) p->addr);
> >          if (*probed_mod) {
> > @@ -1603,6 +1608,8 @@ static int check_kprobe_address_safe(struct kprobe *p,
> >                          ret = -ENOENT;
> >                  }
> >          }
> > +#endif
> > +
> >   out:
> >          preempt_enable();
> >          jump_label_unlock();
> > @@ -1614,7 +1621,9 @@ int register_kprobe(struct kprobe *p)
> >   {
> >          int ret;
> >          struct kprobe *old_p;
> > +#if IS_ENABLED(CONFIG_MODULES)
> >          struct module *probed_mod;
> > +#endif
> >          kprobe_opcode_t *addr;
> >          bool on_func_entry;
> > 
> > @@ -1633,7 +1642,11 @@ int register_kprobe(struct kprobe *p)
> >          p->nmissed = 0;
> >          INIT_LIST_HEAD(&p->list);
> > 
> > +#if IS_ENABLED(CONFIG_MODULES)
> >          ret = check_kprobe_address_safe(p, &probed_mod);
> > +#else
> > +       ret = check_kprobe_address_safe(p);
> > +#endif
> >          if (ret)
> >                  return ret;
> > 
> > @@ -1676,8 +1689,10 @@ int register_kprobe(struct kprobe *p)
> >   out:
> >          mutex_unlock(&kprobe_mutex);
> > 
> > +#if IS_ENABLED(CONFIG_MODULES)
> >          if (probed_mod)
> >                  module_put(probed_mod);
> > +#endif
> > 
> >          return ret;
> >   }
> > @@ -2482,6 +2497,7 @@ int kprobe_add_area_blacklist(unsigned long start, unsigned long end)
> >          return 0;
> >   }
> > 
> > +#if IS_ENABLED(CONFIG_MODULES)
> >   /* Remove all symbols in given area from kprobe blacklist */
> >   static void kprobe_remove_area_blacklist(unsigned long start, unsigned long end)
> >   {
> > @@ -2499,6 +2515,7 @@ static void kprobe_remove_ksym_blacklist(unsigned long entry)
> >   {
> >          kprobe_remove_area_blacklist(entry, entry + 1);
> >   }
> > +#endif
> > 
> >   int __weak arch_kprobe_get_kallsym(unsigned int *symnum, unsigned long *value,
> >                                     char *type, char *sym)
> > @@ -2564,6 +2581,7 @@ static int __init populate_kprobe_blacklist(unsigned long *start,
> >          return ret ? : arch_populate_kprobe_blacklist();
> >   }
> > 
> > +#if IS_ENABLED(CONFIG_MODULES)
> >   static void add_module_kprobe_blacklist(struct module *mod)
> >   {
> >          unsigned long start, end;
> > @@ -2665,6 +2683,7 @@ static struct notifier_block kprobe_module_nb = {
> >          .notifier_call = kprobes_module_callback,
> >          .priority = 0
> >   };
> > +#endif /* IS_ENABLED(CONFIG_MODULES) */
> > 
> >   void kprobe_free_init_mem(void)
> >   {
> > @@ -2724,8 +2743,11 @@ static int __init init_kprobes(void)
> >          err = arch_init_kprobes();
> >          if (!err)
> >                  err = register_die_notifier(&kprobe_exceptions_nb);
> > +
> > +#if IS_ENABLED(CONFIG_MODULES)
> >          if (!err)
> >                  err = register_module_notifier(&kprobe_module_nb);
> > +#endif
> > 
> >          kprobes_initialized = (err == 0);
> >          kprobe_sysctls_init();
> > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > index c4c6e0e0068b..dd4598f775b9 100644
> > --- a/kernel/trace/trace_kprobe.c
> > +++ b/kernel/trace/trace_kprobe.c
> > @@ -102,6 +102,7 @@ static nokprobe_inline bool trace_kprobe_has_gone(struct trace_kprobe *tk)
> >          return kprobe_gone(&tk->rp.kp);
> >   }
> > 
> > +#if IS_ENABLED(CONFIG_MODULES)
> >   static nokprobe_inline bool trace_kprobe_within_module(struct trace_kprobe *tk,
> >                                                   struct module *mod)
> >   {
> > @@ -129,6 +130,12 @@ static nokprobe_inline bool trace_kprobe_module_exist(struct trace_kprobe *tk)
> > 
> >          return ret;
> >   }
> > +#else
> > +static nokprobe_inline bool trace_kprobe_module_exist(struct trace_kprobe *tk)
> > +{
> > +       return true;
> > +}
> > +#endif
> > 
> >   static bool trace_kprobe_is_busy(struct dyn_event *ev)
> >   {
> > @@ -670,6 +677,7 @@ static int register_trace_kprobe(struct trace_kprobe *tk)
> >          return ret;
> >   }
> > 
> > +#if IS_ENABLED(CONFIG_MODULES)
> >   /* Module notifier call back, checking event on the module */
> >   static int trace_kprobe_module_callback(struct notifier_block *nb,
> >                                         unsigned long val, void *data)
> > @@ -704,6 +712,7 @@ static struct notifier_block trace_kprobe_module_nb = {
> >          .notifier_call = trace_kprobe_module_callback,
> >          .priority = 1   /* Invoked after kprobe module callback */
> >   };
> > +#endif /* IS_ENABLED(CONFIG_MODULES) */
> > 
> >   static int count_symbols(void *data, unsigned long unused)
> >   {
> > @@ -1897,8 +1906,10 @@ static __init int init_kprobe_trace_early(void)
> >          if (ret)
> >                  return ret;
> > 
> > +#if IS_ENABLED(CONFIG_MODULES)
> >          if (register_module_notifier(&trace_kprobe_module_nb))
> >                  return -EINVAL;
> Why a #if here ?
> 
> If CONFIG_MODULES is not selected, register_module_notifier() return 
> always 0.
> 
> > +#endif
> > 
> >          return 0;
> >   }
> > --
> > 2.43.0
> > 
> > 

