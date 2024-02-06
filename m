Return-Path: <linux-kernel+bounces-55291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B11D84BA57
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E8611F27462
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD30F134728;
	Tue,  6 Feb 2024 15:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="OOqG6FMe"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDAB134727
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 15:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707235135; cv=none; b=o9IkYjpxZAG9hOFLN3nCmBo04J+k8LUxk7hR9og6qd7faSHD8xAmFl7Lau7Vv25QZLR/bCUMWQJKITJC0xNVSHXEJCTJZ7kcTEJEikOt5qy2gbUWFVXwI8c5gzQ3oG/xfHi3nAXzO23JMRMMEXwNYbGM57ITYBNChERctbIUrhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707235135; c=relaxed/simple;
	bh=iQKdxn8Q6UzvgRQIU5HP7nQIZF+PWL+WLsjt877ujqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FqM4z8E4gWP3v9KDeXP/ffxm8FqN+sezyOzzvinMRyA98vOH/KbDYqLT4hi3NndriCMdCWIoRgOUud3DGqa0HJzg2ksEWdGungL4tA9VUQudldrIalXelMf7JOgvYaQPNO/GzR6H5xdn/E+VVX2H4kbyX4/OpR9V1d5zxPVV3QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=OOqG6FMe; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9EA0140E023B;
	Tue,  6 Feb 2024 15:58:51 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id wcfWwa9y7WDI; Tue,  6 Feb 2024 15:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707235129; bh=nCnf8Q3aeAEVnysuF0oNuGH4F1kDc0xuQ8p1tyHi5Lg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OOqG6FMeLE9lSwQzjfmXlOeWzIoniHYY94+BXKXZ6pFnVwTDqP1dgCE35ya53OdHy
	 32MHf9/TPOhk4yQiBQIPuuGUJHHqGt+wdi+C59kSWm6scJH56eriVkVuKlvH7A0eyK
	 lK+vnLMJBNpBYWSk3eYwyYdTAD2mfilOqoeplpmKoakG1iZ1eQnDceBucqxsXwMvmZ
	 wxJIk40U1bRxjG95KdLSyKoDkQUL/BdKHNOinlFj0YA1LPLTpc4pzxa8ZhliOlDWxw
	 g9PbpvF1xbt23/HZrn36nFaKUH0MCvlHBOOo9v0Msft+2JR8bPvwFOikAPzuqDnPmK
	 lo0sV08VsKOYY8zvicWTGO0NxHogWYedd0cwhMLhhQ7y9g1WEMiuE8v+RFd3tSQBCZ
	 SzqahK3JIBN1aT9ujmVmYZy7KinoS5C+fGH8rOYBPBJ52p7IeqmtYzeYQ04f9mG9IR
	 KXfRn3hQ9GNjniVyGMwpyiJmgzpmPVXa42miWTOf1vWvzxo2i9yZBQg9k8ppwqqCiM
	 eP2g5uCSQ2ARDa7lH5aLQv/0B+9iQybNziij7auNHsGzvYJQEJ7xnmxZPpNLDJJTtz
	 3HsDFDSIomKLmk3FnWfz2iR4bwePXvDWwC9j7IN6b4nJ8B5gnXDpqCv+HnWuvVDYFm
	 rB2A26BHjlh4AlQ1wBY56uLE=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 27A3B40E01A2;
	Tue,  6 Feb 2024 15:58:31 +0000 (UTC)
Date: Tue, 6 Feb 2024 16:58:30 +0100
From: Borislav Petkov <bp@alien8.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
	Dimitri Sivanich <dimitri.sivanich@hpe.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Feng Tang <feng.tang@intel.com>,
	Andy Shevchenko <andy@infradead.org>,
	Michael Kelley <mhklinux@outlook.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [patch v5 11/19] x86/cpu: Use common topology code for AMD
Message-ID: <20240206155830.GPZcJXJkOv8NOtIfHi@fat_crate.local>
References: <20240117115752.863482697@linutronix.de>
 <20240117115909.011311608@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240117115909.011311608@linutronix.de>

On Tue, Jan 23, 2024 at 01:53:47PM +0100, Thomas Gleixner wrote:
> --- a/arch/x86/kernel/cpu/mce/inject.c
> +++ b/arch/x86/kernel/cpu/mce/inject.c
> @@ -433,8 +433,7 @@ static u32 get_nbc_for_node(int node_id)
>  	struct cpuinfo_x86 *c = &boot_cpu_data;
>  	u32 cores_per_node;
>  
> -	cores_per_node = (c->x86_max_cores * smp_num_siblings) / amd_get_nodes_per_socket();
> -
> +	cores_per_node = (c->x86_max_cores * smp_num_siblings) / topology_amd_nodes_per_pkg();
>  	return cores_per_node * node_id;
>  }

One more hunk depending on what goes in when and in what order, to fix
a build issue from the RAS tree:

ERROR: modpost: "amd_get_nodes_per_socket" [drivers/ras/amd/atl/amd_atl.ko] undefined!
make[2]: *** [scripts/Makefile.modpost:145: Module.symvers] Error 1
make[1]: *** [/mnt/kernel/kernel/2nd/linux/Makefile:1873: modpost] Error 2
make: *** [Makefile:240: __sub-make] Error 2

---

diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
index 7e310d1dfcfc..283812bd8497 100644
--- a/drivers/ras/amd/atl/umc.c
+++ b/drivers/ras/amd/atl/umc.c
@@ -264,7 +264,7 @@ static u8 get_die_id(struct atl_err *err)
 	 * For CPUs, this is the AMD Node ID modulo the number
 	 * of AMD Nodes per socket.
 	 */
-	return topology_die_id(err->cpu) % amd_get_nodes_per_socket();
+	return topology_die_id(err->cpu) % topology_amd_nodes_per_pkg();
 }
 
 #define UMC_CHANNEL_NUM	GENMASK(31, 20)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

