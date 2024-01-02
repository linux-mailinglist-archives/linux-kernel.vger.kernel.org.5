Return-Path: <linux-kernel+bounces-14251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD528219F0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBC3F282F5E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F26D2FD;
	Tue,  2 Jan 2024 10:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Uzl7Zo5R"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E47DD28D;
	Tue,  2 Jan 2024 10:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DD99540E00C9;
	Tue,  2 Jan 2024 10:34:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id mxpEbl6mtL9g; Tue,  2 Jan 2024 10:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1704191688; bh=qmzzjq3k0ZYuRvdQFFKTodBxJQM9E/DweoyCy+/wM74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uzl7Zo5ROy5ZjJo+SRSbo7Jv+rAmFH2RAMynkUlNu2MHLgqEcn5u54yIRhd+KrvzN
	 6rH+GM5G8yVYLYO+HqnEwIgxT7EtO5jYtV2kIhN3G+/jftTquh3tnfN8YIUt5sMi35
	 1smnU700J/W1hP7FO9y50JKT6Xu6ZfEWZDV3GtjQxgqzyceow5SCsmYr9vs3J1ii77
	 JyuLgCLFJXxMIlwS16uiu9e5nfE1wWh6PD6Wjq4z9EttthrAao7Twt/KKyNSWoYsPC
	 Xqj9hIfrGlj0n/LOfT6OD55NVdDoS57TlCfrRjizoMyiWidJrDWcAenHzCcrCBJEzn
	 dwcbOdyHFvdYJE84P1vKJgszRZPejPDQDDXMefBSy2tkYcZZAX9C/VQlPf+mB93kyy
	 MdkNmSh06lo4CxeR2pvgUXbOOV7IHli3y2dYayP2eAstBKACbIVpiPZ4E6f/9nb9u5
	 eollM0gTXfrHNyO4+WOPaJrfdJm4qSqEnxnAl49rZiXCMeeo7fO8FbpQuLMdU2/rzI
	 bxdFRwkxMiYjKfxm/4jSKI/WvETSjDWsIqhBP1dTmLrh7jI8RH+G4+5cbl357LxMOR
	 PRuvhYtAAUSyJodRPf4Y/KbPvsTTA91/Wp4u85mFB7njsCen7Fmr0N+k3alI8X3gLl
	 Kyzmd4BalADYoOOcwPlzKLFc=
Received: from zn.tnic (pd9530f8c.dip0.t-ipconnect.de [217.83.15.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C878040E016D;
	Tue,  2 Jan 2024 10:34:29 +0000 (UTC)
Date: Tue, 2 Jan 2024 11:34:24 +0100
From: Borislav Petkov <bp@alien8.de>
To: Sandipan Das <sandipan.das@amd.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	namhyung@kernel.org, adrian.hunter@intel.com, tglx@linutronix.de,
	eranian@google.com, irogers@google.com, mario.limonciello@amd.com,
	ravi.bangoria@amd.com, ananth.narayan@amd.com
Subject: Re: [PATCH v2 1/3] perf/x86/amd/lbr: Use freeze based on availability
Message-ID: <20240102103424.GAZZPmsDsrSF9WZVl+@fat_crate.local>
References: <cover.1704103399.git.sandipan.das@amd.com>
 <d75c92b6bfdd536ad8186afaea6fb7819c64ab28.1704103399.git.sandipan.das@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d75c92b6bfdd536ad8186afaea6fb7819c64ab28.1704103399.git.sandipan.das@amd.com>

On Tue, Jan 02, 2024 at 11:31:28AM +0530, Sandipan Das wrote:
> Currently, it is assumed that LBR Freeze is supported on all processors
> which have CPUID leaf 0x80000022[EAX] bit 1 set. This is incorrect as
> the feature availability is additionally dependent on CPUID leaf
> 0x80000022[EAX] bit 2 being set which may not be set for all Zen 4
> processors. Define a new feature bit for LBR and PMC freeze and set the
> freeze enable bit (FLBRI) in DebugCtl (MSR 0x1d9) conditionally.
> 
> It should still be possible to use LBR without freeze for profile-guided
> optimization of user programs by using an user-only branch filter during
> profiling. When the user-only filter is enabled, branches are no longer
> recorded after the transition to CPL 0 upon PMI arrival. When branch
> entries are read in the PMI handler, the branch stack does not change.
> 
> E.g.
> 
>   $ perf record -j any,u -e ex_ret_brn_tkn ./workload
> 
> Fixes: ca5b7c0d9621 ("perf/x86/amd/lbr: Add LbrExtV2 branch record support")
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>

Whoever ends up committing this, please add to the commit message the
reason why X86_FEATURE_AMD_LBR_PMC_FREEZE is left visible in
/proc/cpuinfo:

https://lore.kernel.org/all/CABPqkBQ0Zn_orR_9FnHA7Y1pNHAzG0E=86MkdMjOtGfKXDp29g@mail.gmail.com/

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

