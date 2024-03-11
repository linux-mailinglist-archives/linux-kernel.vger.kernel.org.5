Return-Path: <linux-kernel+bounces-98966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 863A48781AE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3840C1F229DA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8933EA8C;
	Mon, 11 Mar 2024 14:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="QYR/6uUh"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF205250
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 14:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710167626; cv=none; b=qJVMUcJ/f+MGqqAbDqIhQghZE9inpgCIRBq/mPMQQdjJBMEsEPQkyw42hxQgdLWa3mgGxXSLRMqOoWKH1MPDbn0NvF8CqACoP8q+yFcmZftNVsV/FyRxS1BY8C+ZDZuB+l98p78WqT8NSdacRO0TucoWJeyTblsVnOLnbSvNnPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710167626; c=relaxed/simple;
	bh=yrx81kjwGiqbJazMVKis2Tfzhyo2HOZPTe8m5D5nct4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UotCZbROWqNM+tAwkpHiUESS1GjepzM1pRZStMB94pTMt4nMBVFftFQElYug5LvxUfB+UHDuCN3/4YOPb3589k0E3NUAKjllKrJxgxJfHAl6O2MQpK0+e8G5mH56ILsSP2WjaMhexU4y64eIKTMFDhVgtM2XTCzOfxM1mguLtsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=QYR/6uUh; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E1A5840E0174;
	Mon, 11 Mar 2024 14:33:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id amGWAVCdAnLn; Mon, 11 Mar 2024 14:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1710167615; bh=IyvkHVet6K/D5DIWjWUp17Y5st0ljxvN19nEDSAVCIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QYR/6uUhPk5V7G1Itg+CPJNCpfnhqm6MSPt6yrXHvfrnj0v8xoM5yeS63nZdHpgOt
	 IteewnMy082R4wa8nhUpmtotnnbXXWwAP5uoqMTMVkMXSOkGoCOUlefoA9DtPkkXNo
	 D2aRWBbLgOJxgQMlPtZC1oCziML+xhaT1kIAhOrfgPIzQ0Ofx69IWe8km0nTVKqH2t
	 F7/mS3MktyKQEj4pokt8EfcoME/jJUpUtIT92esLuxwSF25N64D3bDcHy0KsJtISrP
	 Wg4U61kcorFhu624mOaw2OAE33C7s2Y3CviX8lOS+uZ0UO2sTmI9z04PdfO2Lkv6kk
	 kvkhnOW+V+N7ziLjnnccdVQ+GAYGXJCcyI54DJwm+Mw7AldK5KwN0/lthOGm/XEX55
	 mxUXRlkzz5uWkzM8CCHpYzEb4Nr9HgbOaL3IEdoJ0byZ5GkcxN1m/kIZaPrgWnaqF0
	 hjsBBO/Mh+gyYSjoqtw9Y9+3Sx9OkVV7twdMmtAmGH+OTiQb0JeW/PhKCygT+oPbrh
	 A0tiQcoPHZ958CtkwvI7eKgWKdhn8vpEIymggG0tC/zYiZ+rnqI7FwzZIM3Q69R3vW
	 qYZnivMqHCplYODjoHQHHA/ydBtOsWmIK36obd4XZXBrjpc4XM3PtjRw+Xs0SRF5A8
	 /jAOpPL1jCdq1wqqJC9yOgho=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7BB9940E0173;
	Mon, 11 Mar 2024 14:33:29 +0000 (UTC)
Date: Mon, 11 Mar 2024 15:33:21 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	the arch/x86 maintainers <x86@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Uros Bizjak <ubizjak@gmail.com>
Subject: Re: [GIT PULL] x86/core changes for v6.9
Message-ID: <20240311143321.GAZe8WMQnVFHAS24NK@fat_crate.local>
References: <Ze8LpCezZ4yHRBnk@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ze8LpCezZ4yHRBnk@gmail.com>

On Mon, Mar 11, 2024 at 02:48:20PM +0100, Ingo Molnar wrote:
> The conflict is contextual only, it's fine to put the new __warn_thunk line 
> anywhere in entry.S, as long as it's outside the other section blocks. 
> Putting it last in the file is the most straightforward resolution.

..and if you encounter another merge conflict in
arch/x86/kernel/process.c, here's how a resolve should look like:

diff --cc arch/x86/kernel/process.c
index 6121c2b42ecf,f0166b31a803..b8441147eb5e
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@@ -933,19 -909,19 +909,19 @@@ static __cpuidle void mwait_idle(void
  	__current_clr_polling();
  }
  
- void select_idle_routine(const struct cpuinfo_x86 *c)
+ void __init select_idle_routine(void)
  {
- #ifdef CONFIG_SMP
- 	if (boot_option_idle_override == IDLE_POLL && __max_threads_per_core > 1)
- 		pr_warn_once("WARNING: polling idle and HT enabled, performance may degrade\n");
- #endif
- 	if (x86_idle_set() || boot_option_idle_override == IDLE_POLL)
+ 	if (boot_option_idle_override == IDLE_POLL) {
 -		if (IS_ENABLED(CONFIG_SMP) && smp_num_siblings > 1)
++		if (IS_ENABLED(CONFIG_SMP) && __max_threads_per_core > 1)
+ 			pr_warn_once("WARNING: polling idle and HT enabled, performance may degrade\n");
+ 		return;
+ 	}
+ 
+ 	/* Required to guard against xen_set_default_idle() */
+ 	if (x86_idle_set())
  		return;
  
- 	if (boot_cpu_has_bug(X86_BUG_AMD_E400)) {
- 		pr_info("using AMD E400 aware idle routine\n");
- 		static_call_update(x86_idle, amd_e400_idle);
- 	} else if (prefer_mwait_c1_over_halt(c)) {
+ 	if (prefer_mwait_c1_over_halt()) {
  		pr_info("using mwait in idle threads\n");
  		static_call_update(x86_idle, mwait_idle);
  	} else if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {

---

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

