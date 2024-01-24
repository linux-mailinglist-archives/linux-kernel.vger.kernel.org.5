Return-Path: <linux-kernel+bounces-37516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D0A83B130
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C40C31F25050
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E70131724;
	Wed, 24 Jan 2024 18:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="d7jMUbwJ"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB65130E5A;
	Wed, 24 Jan 2024 18:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706121162; cv=none; b=csPfxavfIH4389bB35aqO65fWcmsws11rlYkglDm08kegUQ5WLhaR07jRhicuego477AXtj0ukVZ0Kf7BwBCegP+MPc3+/WX4yCys5KUPyApaoxFOXRuW+4LQobAWoX8Qp6k8Mh9tYEHaFIFvlShViuKAXk8f21CVyhD47jIff0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706121162; c=relaxed/simple;
	bh=1ptnX18ROuZF1++MBajLh5HKvxdkkKwzGW8IoJy13AM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXSHcucUN5GxM6+v42pZqwLOxOFkVD/GvCO2UxKPIvJnjaABjKVXva9uXgH3lzO9bqgHlRnf+hIW4pO4vWhS8YszAFf6YaK4QVIC1anN8tEVMb2Ne74lvZtTvDYJxieh2GTMFTYoPd+RBaz+8Yi2gVTYbEWXjLm3HcrAGjfltC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=d7jMUbwJ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0AC5F40E01A9;
	Wed, 24 Jan 2024 18:32:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id pm4fXtx2h_D8; Wed, 24 Jan 2024 18:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706121154; bh=vaEqhiwCC6NaERNe6TMVeVGP6JVmokf1utfp4cV9z9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d7jMUbwJEUTZ+kYI59q0QtfID7t0vONybXbFFqog6jM80eJpN3mLntKS5KmV0Xj0f
	 8TpPiOJ+dwOlWvJ6Yuh+Ti0Uz3Ei7JwqZvSyQiYtYL4jcNorMRI6Z+bwArf5pks2H8
	 Nx8f+XeJXchVWiDbIBXkg/hyOiFfs4nwH11+GPAQrD5BUeXomUsG4D8L3fiu91Uo43
	 gXYEnZM75XLpNz84jFIA/ew8w7paePlL0thVhoG7KLUCWZol02ZaNGFvAXYC/cHDqT
	 cyAKdiNnsxxgn7ic6AhBIXo14IDfsBMikWSJWW5/9W9Z70/dENMuuA5c8ceVj/kKfJ
	 PiTaSj34viEkzaUTNVc9JutpGVOkTps0OnE1wt/HCiBQva7wia2KuaakT6XDRbpTSN
	 aBCTg/XE4sRgKTth3hGdHQQvQ2MWv0xLhko+tfcBHjYgzaegE4AHLA6dpOYYcFb6Bg
	 GbXkwWIXpJyFnPcvhIAC6Ru3BriU6YcDEC+pCTMY1KmSWjGv5QFd+9xbzc1iXjusYH
	 08balh8wPFrA08XlDml96tzWqQal1rVZ6IeG1UBlgy8R6WZ/MxFmEXvgKMpef9amz+
	 prsWsIZPWjUK6qLaheRNL1z/KVPjYTYwoOtxNgHm9Pj+ApsPPevx26o9UljmA3HnFe
	 bgcI8RCcottEYSU9XPCRfyU4=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 28B8C40E00C5;
	Wed, 24 Jan 2024 18:32:00 +0000 (UTC)
Date: Wed, 24 Jan 2024 19:31:53 +0100
From: Borislav Petkov <bp@alien8.de>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: Babu Moger <babu.moger@amd.com>, corbet@lwn.net, fenghua.yu@intel.com,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, paulmck@kernel.org,
	rdunlap@infradead.org, tj@kernel.org, peterz@infradead.org,
	yanjiewtw@gmail.com, kim.phillips@amd.com, lukas.bulwahn@gmail.com,
	seanjc@google.com, jmattson@google.com, leitao@debian.org,
	jpoimboe@kernel.org, rick.p.edgecombe@intel.com,
	kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
	kai.huang@intel.com, kan.liang@linux.intel.com,
	daniel.sneddon@linux.intel.com, pbonzini@redhat.com,
	sandipan.das@amd.com, ilpo.jarvinen@linux.intel.com,
	peternewman@google.com, maciej.wieczor-retman@intel.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	eranian@google.com
Subject: Re: [PATCH] x86/resctrl: Fix unneeded variable warning reported by
 kernel test robot
Message-ID: <20240124183153.GFZbFXmTKTLEpwZshW@fat_crate.local>
References: <202401241810.jbd8Ipa1-lkp@intel.com>
 <84128a3c83654493f637b8349153af10d69e2752.1706118776.git.babu.moger@amd.com>
 <39c4501e-4937-49de-b12b-742e6201df6f@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <39c4501e-4937-49de-b12b-742e6201df6f@intel.com>

On Wed, Jan 24, 2024 at 10:25:17AM -0800, Reinette Chatre wrote:
> This can be confusing since it implies that the patch you mention
> introduces the issue but instead the variable has been unneeded since
> the original:
> 92bd5a139033 ("x86/resctrl: Add interface to write mbm_total_bytes_config")

What I said. :)

> To help clarify you can mention this order of events and also add an
> appropriate "Fixes:" tag.
> 
> > cocci warnings: (new ones prefixed by >>)
> >>> arch/x86/kernel/cpu/resctrl/rdtgroup.c:1621:5-8: Unneeded variable: "ret". Return "  0" on line 1655
> > 
> > Fix the warning by removing the variable "ret" and returning 0 directly.
> 
> cocci warning was spot on*. This fix is not just a change to "make a
> warning go away" but instead fixing an actual problem.
> It can just be "Remove the unneeded variable and return 0 directly".

I'll fix all up before applying.

> * I'll add a private setup with the goal to catch these earlier.

Except that it doesn't fire with the patch that added the code. It looks
like the cocci script needs adjustment...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

