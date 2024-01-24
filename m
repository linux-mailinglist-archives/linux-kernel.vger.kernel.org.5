Return-Path: <linux-kernel+bounces-36818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0433E83A751
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 299191C220D8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79451AACC;
	Wed, 24 Jan 2024 10:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UTWutB/+"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257D71AAB1
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 10:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706093779; cv=none; b=XtRtMD9nnryPy50ahO1ShZ03NFXTT5czvXgQ5911peEdDn7potW1DZ2eDWGhTCuKgSkcOidiOTadKx6T9TRaBVA/s+n9p5Pjk5EXUFtJjZHUdMc7WthzN+693nunpN4ia8DnIUGH4LpQ/hlDNuOMbNsVTqJzHsrShC7ZUfAattk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706093779; c=relaxed/simple;
	bh=K+EXX6KBa5jIlxDzNlMzdasEsnVxhCngOASeGfqDXHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHyfwx748l+war+fgrmtTFFFIBMNamzUHwkdT1xLnxi1l0dZWYMgJSmbXoX5TFXd4viwmqERWRUWzPUIIPjY9beme8xzxIuYl1PBfHEzMM0MXznDnPJuQEks21Z4vapT6eXluoBUvrC4oshX4SSiWDrFI+69EDAvEDbaVt426EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UTWutB/+; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C5C7640E01A9;
	Wed, 24 Jan 2024 10:56:14 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vD12-3enQolI; Wed, 24 Jan 2024 10:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706093771; bh=VtfkV0cpR7DWjUDpJgezGMyP/R/1YxhanWpTAND8jb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UTWutB/+j4i/lSdesqXcAxZkHQ+IqntkB4U5oEKIOBdEtmlZZWv4/ucCFNu+qeCk2
	 /cca579Y6S1Vttdb/ReTdVNIVOua5FXt82D3hx+KUMJWtGtQzkHGWujAkjkt3fE309
	 aFyBLtOZado5mWJSPPpfLJEWruafJ872Vvbbl9CvOkDL45QzxMefUFEzl28TVLR1Mf
	 FdLXYB2wA4PtX8LYe5fdPUIHaES/KkgfzQcQY69yjoukAc8qf92W1P0QILmq77SvEp
	 tAZd9goLUGU3b3HhOwS+BqGIfaegpQ0vI3FGQ8LXJV1Uo1OrMAHLo6iiK84vCEoJMe
	 7pgG6VoowCLos7Q0eCOoVDBB7k0Q8EAl5LGHgj/M7ELGjJTpw2aKsh1TM2M/xVyymV
	 xviBTSJ8HHEwYOaVUlRW5WSBMj4fQPfHQpLWzX2zzkJ67QQyeTjvpTVU+MxNJAvFsB
	 GGhBwo8/boWuFd62iJ1eqXWR7Nax0okB0lItAEXtmbP9tIib7piVwzZx9xsQNg8PlW
	 vR25FQ/ySk+a4tZNUsx4F4bGrkPEjKjdKqSacqWEDjMzHNWUnYKU9r8iG3posphXeC
	 LVnadZDADAY/ZB7YVMYyMq6yw7CSujtdket0lfol0vEXMLAusMdnoTiV7wZ/3V5Wij
	 Luwl1STLu1jhr5PkzxqHLLkg=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D62A740E00C5;
	Wed, 24 Jan 2024 10:56:01 +0000 (UTC)
Date: Wed, 24 Jan 2024 11:55:55 +0100
From: Borislav Petkov <bp@alien8.de>
To: kernel test robot <lkp@intel.com>
Cc: Babu Moger <babu.moger@amd.com>, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr
Subject: Re: [tip:x86/cache 3/3]
 arch/x86/kernel/cpu/resctrl/rdtgroup.c:1621:5-8: Unneeded variable: "ret".
 Return "  0" on line 1655
Message-ID: <20240124105555.GBZbDsu-zsQ8YTgXjS@fat_crate.local>
References: <202401241810.jbd8Ipa1-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202401241810.jbd8Ipa1-lkp@intel.com>

On Wed, Jan 24, 2024 at 06:31:41PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cache
> head:   54e35eb8611cce5550d3d7689679b1a91c864f28
> commit: 54e35eb8611cce5550d3d7689679b1a91c864f28 [3/3] x86/resctrl: Read supported bandwidth sources from CPUID
> config: x86_64-randconfig-102-20240124 (https://download.01.org/0day-ci/archive/20240124/202401241810.jbd8Ipa1-lkp@intel.com/config)
> compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202401241810.jbd8Ipa1-lkp@intel.com/
> 
> cocci warnings: (new ones prefixed by >>)
> >> arch/x86/kernel/cpu/resctrl/rdtgroup.c:1621:5-8: Unneeded variable: "ret". Return "  0" on line 1655

Well, AFAICT, even with the tree checked out at

92bd5a139033 ("x86/resctrl: Add interface to write mbm_total_bytes_config")

which is the first patch that added this function, ret is unneeded.

But scripts/coccinelle/misc/returnvar.cocci doesn't warn about it then,
only now that that hunk with the "return -EINVAL;" is removed in the
patch you're reporting this against.

Lemme add some cocci people to Cc for comment and leave the rest for
reference.

Thx.

> vim +1621 arch/x86/kernel/cpu/resctrl/rdtgroup.c
> 
> 92bd5a1390335b Babu Moger 2023-01-13  1616  
> 92bd5a1390335b Babu Moger 2023-01-13  1617  static int mbm_config_write_domain(struct rdt_resource *r,
> 92bd5a1390335b Babu Moger 2023-01-13  1618  				   struct rdt_domain *d, u32 evtid, u32 val)
> 92bd5a1390335b Babu Moger 2023-01-13  1619  {
> 92bd5a1390335b Babu Moger 2023-01-13  1620  	struct mon_config_info mon_info = {0};
> 92bd5a1390335b Babu Moger 2023-01-13 @1621  	int ret = 0;
> 92bd5a1390335b Babu Moger 2023-01-13  1622  
> 92bd5a1390335b Babu Moger 2023-01-13  1623  	/*
> 92bd5a1390335b Babu Moger 2023-01-13  1624  	 * Read the current config value first. If both are the same then
> 92bd5a1390335b Babu Moger 2023-01-13  1625  	 * no need to write it again.
> 92bd5a1390335b Babu Moger 2023-01-13  1626  	 */
> 92bd5a1390335b Babu Moger 2023-01-13  1627  	mon_info.evtid = evtid;
> 92bd5a1390335b Babu Moger 2023-01-13  1628  	mondata_config_read(d, &mon_info);
> 92bd5a1390335b Babu Moger 2023-01-13  1629  	if (mon_info.mon_config == val)
> 92bd5a1390335b Babu Moger 2023-01-13  1630  		goto out;
> 92bd5a1390335b Babu Moger 2023-01-13  1631  
> 92bd5a1390335b Babu Moger 2023-01-13  1632  	mon_info.mon_config = val;
> 92bd5a1390335b Babu Moger 2023-01-13  1633  
> 92bd5a1390335b Babu Moger 2023-01-13  1634  	/*
> 92bd5a1390335b Babu Moger 2023-01-13  1635  	 * Update MSR_IA32_EVT_CFG_BASE MSR on one of the CPUs in the
> 92bd5a1390335b Babu Moger 2023-01-13  1636  	 * domain. The MSRs offset from MSR MSR_IA32_EVT_CFG_BASE
> 92bd5a1390335b Babu Moger 2023-01-13  1637  	 * are scoped at the domain level. Writing any of these MSRs
> 92bd5a1390335b Babu Moger 2023-01-13  1638  	 * on one CPU is observed by all the CPUs in the domain.
> 92bd5a1390335b Babu Moger 2023-01-13  1639  	 */
> 92bd5a1390335b Babu Moger 2023-01-13  1640  	smp_call_function_any(&d->cpu_mask, mon_event_config_write,
> 92bd5a1390335b Babu Moger 2023-01-13  1641  			      &mon_info, 1);
> 92bd5a1390335b Babu Moger 2023-01-13  1642  
> 92bd5a1390335b Babu Moger 2023-01-13  1643  	/*
> 92bd5a1390335b Babu Moger 2023-01-13  1644  	 * When an Event Configuration is changed, the bandwidth counters
> 92bd5a1390335b Babu Moger 2023-01-13  1645  	 * for all RMIDs and Events will be cleared by the hardware. The
> 92bd5a1390335b Babu Moger 2023-01-13  1646  	 * hardware also sets MSR_IA32_QM_CTR.Unavailable (bit 62) for
> 92bd5a1390335b Babu Moger 2023-01-13  1647  	 * every RMID on the next read to any event for every RMID.
> 92bd5a1390335b Babu Moger 2023-01-13  1648  	 * Subsequent reads will have MSR_IA32_QM_CTR.Unavailable (bit 62)
> 92bd5a1390335b Babu Moger 2023-01-13  1649  	 * cleared while it is tracked by the hardware. Clear the
> 92bd5a1390335b Babu Moger 2023-01-13  1650  	 * mbm_local and mbm_total counts for all the RMIDs.
> 92bd5a1390335b Babu Moger 2023-01-13  1651  	 */
> 92bd5a1390335b Babu Moger 2023-01-13  1652  	resctrl_arch_reset_rmid_all(r, d);
> 92bd5a1390335b Babu Moger 2023-01-13  1653  
> 92bd5a1390335b Babu Moger 2023-01-13  1654  out:
> 92bd5a1390335b Babu Moger 2023-01-13 @1655  	return ret;
> 92bd5a1390335b Babu Moger 2023-01-13  1656  }
> 92bd5a1390335b Babu Moger 2023-01-13  1657  
> 
> :::::: The code at line 1621 was first introduced by commit
> :::::: 92bd5a1390335bb3cc76bdf1b4356edbc94d408d x86/resctrl: Add interface to write mbm_total_bytes_config
> 
> :::::: TO: Babu Moger <babu.moger@amd.com>
> :::::: CC: Borislav Petkov (AMD) <bp@alien8.de>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

