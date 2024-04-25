Return-Path: <linux-kernel+bounces-159066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC478B28DA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 682F41F23C7F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BBF1514FA;
	Thu, 25 Apr 2024 19:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="MjSmMgN4"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8432135A;
	Thu, 25 Apr 2024 19:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714072453; cv=none; b=XACtM1W7z1JSB/kXXnM4OTO+0WpLxlj4E0muAZqzAPvpUBtPOevL3Cz9cTYAg6fj49Akr7efx4aRmAyZOae/yFYtOeea5X6ZxAQFL2vz4Dw/rzcf6BCA9J2ZmdXlynMt84DK5F1nBGhduvrRrYC8b3DQn/x+Fr80RZQPS40OPpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714072453; c=relaxed/simple;
	bh=c2bvs+0ceImnoVKMJqz/ttZR+eL8yLkggMrcmjgcCe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ghcVLBXCFJcIQc4YJrE/f82p6NgsBAtESzi5Un8wVaGbsrYOGGv4eCelSXN2VREGUofs5AUtuBsbbyAfZnOFiWUlhnoT5+nGo1PzR7+EnA+5EeGO8gBGOXoB1gNJkCdhV4fEb6jHkWlPXgWk37N19I8g0eyq59Gs4w3zG4BeZZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=MjSmMgN4 reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 80b2b45d4181e730; Thu, 25 Apr 2024 21:14:09 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 78E3066DF24;
	Thu, 25 Apr 2024 21:14:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1714072449;
	bh=c2bvs+0ceImnoVKMJqz/ttZR+eL8yLkggMrcmjgcCe0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MjSmMgN4zg40I7AtnaUPm7vkLNsWzJc77w8gypBQDqS+qjAT+YLnNGU6mQ9CRbvrV
	 QYajf1BkFNPKBzjcq4+2ZyfHdC3a5fmvp6yFqd9fP2YrOBXGvfE6tS0ykuQRZW1hUi
	 9DvEO76kkiDsgXuWCmpPVN/pfnf10BkktRJHUi7uN+K9sq8X08Fb2v4tLhlpkNNdri
	 D2UUkPwocJKtlAivpvCDkpqh0YPCIGf4B096CbCahfq5w8AuqqWkJDlF7xXRBv6UMw
	 CxntknCHEI6r75uPZNmEpbYZVHAmEwPPgPNajG5pDLX6n+LnGnGh7Ok/B4BfY/4ua8
	 WBj+/H+OzJhwQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: x86 Maintainers <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ricardo Neri <ricardo.neri@intel.com>, Tim Chen <tim.c.chen@intel.com>
Subject:
 Re: [RFC][PATCH v1 2/3] x86/sched: Introduce arch_rebuild_sched_domains()
Date: Thu, 25 Apr 2024 21:14:08 +0200
Message-ID: <2738703.mvXUDI8C0e@kreacher>
In-Reply-To: <3227587.5fSG56mABF@kreacher>
References: <7663799.EvYhyI6sBW@kreacher> <3227587.5fSG56mABF@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudeljedgudefiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopedutddprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehpvghtvghriiesihhnfhhrrggu
 vggrugdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=10 Fuz1=10 Fuz2=10

On Thursday, April 25, 2024 9:04:48 PM CEST Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Add arch_rebuild_sched_domains() for rebuilding scheduling domains and
> updating topology on x86 and make the ITMT code use it.
> 
> First of all, this reduces code duplication somewhat and eliminates
> a need to use an extern variable, but it will also lay the ground for
> future work related to CPU capacity scaling.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

This obviously is a duplicate of patch [1/3], sorry about this.  My bad.

I'll send the proper patch [2/3] in a reply to this message.

> ---
>  arch/x86/include/asm/topology.h |    6 ++++--
>  arch/x86/kernel/itmt.c          |   12 ++++--------
>  arch/x86/kernel/smpboot.c       |   10 +++++++++-
>  3 files changed, 17 insertions(+), 11 deletions(-)
> 
> Index: linux-pm/arch/x86/include/asm/topology.h
> ===================================================================
> --- linux-pm.orig/arch/x86/include/asm/topology.h
> +++ linux-pm/arch/x86/include/asm/topology.h
> @@ -235,8 +235,6 @@ struct pci_bus;
>  int x86_pci_root_bus_node(int bus);
>  void x86_pci_root_bus_resources(int bus, struct list_head *resources);
>  
> -extern bool x86_topology_update;
> -
>  #ifdef CONFIG_SCHED_MC_PRIO
>  #include <asm/percpu.h>
>  
> @@ -284,9 +282,13 @@ static inline long arch_scale_freq_capac
>  
>  extern void arch_set_max_freq_ratio(bool turbo_disabled);
>  extern void freq_invariance_set_perf_ratio(u64 ratio, bool turbo_disabled);
> +
> +void arch_rebuild_sched_domains(void);
>  #else
>  static inline void arch_set_max_freq_ratio(bool turbo_disabled) { }
>  static inline void freq_invariance_set_perf_ratio(u64 ratio, bool turbo_disabled) { }
> +
> +static inline void arch_rebuild_sched_domains(void) { }
>  #endif
>  
>  extern void arch_scale_freq_tick(void);
> Index: linux-pm/arch/x86/kernel/itmt.c
> ===================================================================
> --- linux-pm.orig/arch/x86/kernel/itmt.c
> +++ linux-pm/arch/x86/kernel/itmt.c
> @@ -54,10 +54,8 @@ static int sched_itmt_update_handler(str
>  	old_sysctl = sysctl_sched_itmt_enabled;
>  	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
>  
> -	if (!ret && write && old_sysctl != sysctl_sched_itmt_enabled) {
> -		x86_topology_update = true;
> -		rebuild_sched_domains();
> -	}
> +	if (!ret && write && old_sysctl != sysctl_sched_itmt_enabled)
> +		arch_rebuild_sched_domains();
>  
>  	mutex_unlock(&itmt_update_mutex);
>  
> @@ -114,8 +112,7 @@ int sched_set_itmt_support(void)
>  
>  	sysctl_sched_itmt_enabled = 1;
>  
> -	x86_topology_update = true;
> -	rebuild_sched_domains();
> +	arch_rebuild_sched_domains();
>  
>  	mutex_unlock(&itmt_update_mutex);
>  
> @@ -150,8 +147,7 @@ void sched_clear_itmt_support(void)
>  	if (sysctl_sched_itmt_enabled) {
>  		/* disable sched_itmt if we are no longer ITMT capable */
>  		sysctl_sched_itmt_enabled = 0;
> -		x86_topology_update = true;
> -		rebuild_sched_domains();
> +		arch_rebuild_sched_domains();
>  	}
>  
>  	mutex_unlock(&itmt_update_mutex);
> Index: linux-pm/arch/x86/kernel/smpboot.c
> ===================================================================
> --- linux-pm.orig/arch/x86/kernel/smpboot.c
> +++ linux-pm/arch/x86/kernel/smpboot.c
> @@ -39,6 +39,7 @@
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
> +#include <linux/cpuset.h>
>  #include <linux/init.h>
>  #include <linux/smp.h>
>  #include <linux/export.h>
> @@ -125,7 +126,7 @@ static DEFINE_PER_CPU_ALIGNED(struct mwa
>  int __read_mostly __max_smt_threads = 1;
>  
>  /* Flag to indicate if a complete sched domain rebuild is required */
> -bool x86_topology_update;
> +static bool x86_topology_update;
>  
>  int arch_update_cpu_topology(void)
>  {
> @@ -135,6 +136,13 @@ int arch_update_cpu_topology(void)
>  	return retval;
>  }
>  
> +#ifdef CONFIG_X86_64
> +void arch_rebuild_sched_domains(void) {
> +	x86_topology_update = true;
> +	rebuild_sched_domains();
> +}
> +#endif
> +
>  static unsigned int smpboot_warm_reset_vector_count;
>  
>  static inline void smpboot_setup_warm_reset_vector(unsigned long start_eip)
> 





