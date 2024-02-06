Return-Path: <linux-kernel+bounces-55277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7454D84BA19
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C9E22835AF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6A4134732;
	Tue,  6 Feb 2024 15:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="aTvOsg48"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BCA134727
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 15:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707234539; cv=none; b=rvMVujx8HSPxVqHpV4nbPKqXDSXKDd7SD0AYRi4M06JnCGjDtae4Rz14fH3cbK/A92ZeggrECqzEehmVmrLeWHt/96AyRKw+nRNBQGcYJOKiCLg9dMiNpGs2UV9fAT4k56YulnerLN10ZO+OAuFGStmxxaiFYnjhV/NVD8ZOLv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707234539; c=relaxed/simple;
	bh=MugGYJDT5X739etuU4UniyS6U+N4eqHCT3QeU0paadg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VeCJUB/A5Qy0TeUzBkNYCkhlt3vcAxuUjf3i1ZzngCy6vjuyvvg5Nfwf9nyzwIWQ4YHpwXNjxgc/+c42EqHqjetyGOMMO5nQYYJalMAJyFnCwcOIHiYnAx+SOya3Scw9WtBVbV5yiLAbkz2lvnaMsW2Ruv6O0HrgT76I+cejq60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=aTvOsg48; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 44F0940E023B;
	Tue,  6 Feb 2024 15:48:55 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id nwBFDjxXf8_Q; Tue,  6 Feb 2024 15:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707234532; bh=smDVek07in+ATqnFthIVLRadHZFIZTvXW9ELQwnkFeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aTvOsg48RVf4L+M8MlO88ubUVBZUexbKgPPIxzyltRUkpBuAENQQPvSTPCfZgNP6k
	 zrgx9M12UwGNnftwk2mGvZN1OIaenTkhgYwZNPZm7ORcmdOr/pNSqfCf74jatpDl3f
	 unIWLdmLNI8E90WUFfHjm3X/vZ6TnT0DXGurWuS6ZkXYU8wOjtk+4U4xvUtMt8ygkV
	 DzTTvE+a+sQOY/KwskmDF+ZBLQQcETboSv0jvDE0IK2ujMotlYmfpdssqN0nSFPiy7
	 HNQP2/gyoc4aa8kMFIr0ylQYbEtEQsdFa163aMYiDXeIqTqt8nVuS5AfysnIQg0zsK
	 mafId/VoY3Pgl9+1pJfTHLdmnO0yp3IyQBNV8tBpf1S6u9ZKXBjhVkpJF60ouLsMHL
	 r+NJPgmg9Pq6RmL57D9fBTrgLySxLtb3VXD10BFyiVW6xOoNCqREH1vxlaDCkYd70u
	 2V+Z1Mj1hOEK7z2K+/9Z0O6nP+GCvDOx6N6ktfQORgqcDLpdo+Kv2zoHLuVsyfLcJt
	 Bk1hVJdbd9B2VSzi/qpuDKeIcUSGf1ZFGhZUcgAC04tKeJaU0egNUIM1QQkKNct+FY
	 VvTDhrlUEyMbBO9ESDzuLow97ejI676qkbSV9cir7pe65Be0xeUdN5EQVd0oVJzKDF
	 rQVLIwT702Ewp2oOud4t1PVM=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A562D40E00B2;
	Tue,  6 Feb 2024 15:48:34 +0000 (UTC)
Date: Tue, 6 Feb 2024 16:48:29 +0100
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
Subject: Re: [patch v5 10/19] x86/smpboot: Teach it about topo.amd_node_id
Message-ID: <20240206154829.GOZcJUzRbfv7WUsKdI@fat_crate.local>
References: <20240117115752.863482697@linutronix.de>
 <20240117115908.946275828@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240117115908.946275828@linutronix.de>

On Tue, Jan 23, 2024 at 01:53:45PM +0100, Thomas Gleixner wrote:
>  static bool match_die(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
>  {
> -	if (c->topo.pkg_id == o->topo.pkg_id &&
> -	    c->topo.die_id == o->topo.die_id)
> -		return true;
> -	return false;
> +	if (c->topo.pkg_id != o->topo.pkg_id || c->topo.die_id != o->topo.die_id)
> +		return false;
> +
> +	if (boot_cpu_has(X86_FEATURE_TOPOEXT) && topology_amd_nodes_per_pkg() > 1)

check_for_deprecated_apis: WARNING: arch/x86/kernel/smpboot.c:516: Do not use boot_cpu_has() - use cpu_feature_enabled() instead.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

