Return-Path: <linux-kernel+bounces-37800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9AD83B59B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 00:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 519A42869F2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939AF13666A;
	Wed, 24 Jan 2024 23:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UZLptB3o"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BFC86157;
	Wed, 24 Jan 2024 23:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706139314; cv=none; b=Uu8ncRb7nMnYkKjv3sPvCJaTZ6KmYL7IkCME2CpxJlMBkhMMRgRZyrJMbDr9jKA8oJlfQ+SDB0cvhkcAPlJexnfk+wimkQQzT8RJDRaGjWtaihj4MAAOXo1xjzgft+UN4T9KewtR41jt3PYIpJRaHKT3BeeGCHkIB8uZN7aR5ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706139314; c=relaxed/simple;
	bh=B9ZuBkYtPDcqQGNhV8S2cg57wPrNScoCs6eFSdQ7a74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TH4GD159FfpfyOyeS3Q5VXEjpsNF1ZJyOIntRPwubA55bazGjcPcb7Bw+4hVVWzpr512igmPt57hoOsNZi8wxhpAUwCQdpU5++jadg7viCKwH15fyll7PQqM+p0yX1MTbrhct0PgpdvLcCHeBeA6lS9oDO/UyJPr3sN4hjkO5z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UZLptB3o; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id ECBAF40E01AE;
	Wed, 24 Jan 2024 23:35:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3CeVuIp7DbQF; Wed, 24 Jan 2024 23:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706139305; bh=AiocZRU0PQo3Ni6J+eCR9ApFRQfM8ohWp82T0Fa/txM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UZLptB3oYvNE0fgdlnRs4XFctf8QE3qvTWcCvDlnbOvvXVjYwmAfnESOi/7Rh7c01
	 F3UGFXYVLF5PidbXtHZShp+uhCy60tmXLOekgtBSFC2gJbsjJ3qOMf8KciGGBrcU51
	 u6igrxi01uq1zUcr25zTlonhDptCLKKMOH2RaPMIhwShO4KGctD12SHw0DqfEkJ/1j
	 EsgVq+ENYWRHx9LYNPc1Kp1CL0Gnj9c1iFrtojSp7G+HTcECMHYge+0z5R5Fx17a9U
	 2uu05jyhatfLE36JiCaBAD1iHqNUIlyLQeM4C9UdqoAurYzc2d4ZL2UgLfnhk2Wee9
	 CbsCxNZyhOcLIXGeRCdmy2VFew2GdJhj8IlW6Em+271OrVileWqHh1pCdKY87u/RMO
	 XdbHyKB6jKd9MEPQMvf/N9oGXEQ5bYvxAeIK8rRaUXBWgsIjQRoiRdaEX8HRgw7z2N
	 p5ljk5/AeU3BAd+TNnhBoR62TYckdp77+dicIvdaCcqHi2kUIglO2EeSAstxjShUFo
	 9a7rV039ZNDbZ+XPS7z0LrvDo4/xzYryNBWfW+8DGpmJyi7dqDN/96xe8sh6OAKXmI
	 5DYT3D2sn4aA1TQ5UHHUvkem14J3bKioAN/o7eJI/pFCD4So0mrsYeTXNIIswUrI4H
	 FpKeWHcE4MOUkjkzm9r178Ug=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7667740E01A9;
	Wed, 24 Jan 2024 23:34:31 +0000 (UTC)
Date: Thu, 25 Jan 2024 00:34:24 +0100
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
Message-ID: <20240124233424.GLZbGegG_5eUaGBOlz@fat_crate.local>
References: <84128a3c83654493f637b8349153af10d69e2752.1706118776.git.babu.moger@amd.com>
 <39c4501e-4937-49de-b12b-742e6201df6f@intel.com>
 <20240124183153.GFZbFXmTKTLEpwZshW@fat_crate.local>
 <e96df7ac-f0b4-4300-8546-7c1df836dea2@intel.com>
 <20240124191429.GGZbFhldYr3K85H9cg@fat_crate.local>
 <6635c607-cab2-45f4-a0fe-ff4f53b36849@intel.com>
 <20240124204525.GIZbF25bekUME2flt0@fat_crate.local>
 <7d6e3d39-ce53-40e4-bba5-242911a1522a@intel.com>
 <20240124224657.GKZbGTYTjN2m8VirbF@fat_crate.local>
 <abf569d6-9634-424f-97b3-a71716b3cde5@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <abf569d6-9634-424f-97b3-a71716b3cde5@intel.com>

On Wed, Jan 24, 2024 at 03:03:15PM -0800, Reinette Chatre wrote:
> Since you are the one that decides the rules for inclusion you can make this
> check to be one where checkpatch.pl can be ignored. No objection from me if
> you choose to do so (and I will note the precedent for future patches).

Nah, that's not nearly as important for you to change your workflow.

What I'd suggest, though, is to sanity-check what checkpatch suggests and
ask yourself whether it always makes sense.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

