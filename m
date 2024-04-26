Return-Path: <linux-kernel+bounces-159875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3FF8B355A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB43A1C2159D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079C885624;
	Fri, 26 Apr 2024 10:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="iUR0wU8n"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31E21E522;
	Fri, 26 Apr 2024 10:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714127720; cv=none; b=Vu08wgPyJ2n/u7umloIKFIHaVuxnJ/Pw7IlIHWMxuUG2rRt/CqqMGk5U0MihYOgyHff5y7ku353iFsi62f8cndWDnFs3xlvwAImnNJw1oY7vP5uB1hzQShmRR3tBODkpFcHNbpEQoQIwKP2btaaEWFnH6cxJRQnah6ZLTyMpihM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714127720; c=relaxed/simple;
	bh=Mtp9ehtRVZxIDdoOzDV8GaQaUy9GU2C0yfvWwfHlaRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKs0LQ6nM3nzrpItjqE/w0ODyVMcyfEJbRKlBt4EThF/kZ3/RxzkeYCi2Wx8l9m7B5W2gpIbeRqkH6Vieqm6VvcCZbUr/G6K5Nw34SZ7cfhKQSv/YGOKY0HIHOZwT8wPVXywxUUYsv9aWmtY1kpdhOfSWodHj7jDrItpCINN+5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=iUR0wU8n; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EDEA640E0192;
	Fri, 26 Apr 2024 10:35:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ynQ7WOOtbViU; Fri, 26 Apr 2024 10:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714127705; bh=qSDm5h4qqz17fdcEbukQx53WBbOMtdaUi0d1s/MxXUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iUR0wU8nOx+ZxOL4/mUm4hAtZiqnikuY/CpFluQmj/Mz5qBdajYMD7YgvbgOzjgVJ
	 IIBWY28HdPoKpmp72R3IzndV0lLQnX0mKGptPK6rhXpJ5WZpRF/jx/oovFlY1oHUgc
	 py/5ChpS48ggHCKDss/cI8+hjTyGP6slDewMtbhKDZpBhbn18vNI5ysUygUDF/Ca7Y
	 fFKEqXOzEMkdGkT1jSI2aDDJUIqkQ0AsoXWdmIjGaCMW+TKvOop189/cRTFpcsn2AA
	 4i+ZhNpqLAte6zOaCnTATsM8Ll78Si3kJUaNlAyVKmebTp730GFPkq6mUOMEtIcLaC
	 y9BOgPIvy1YqNyb6baLsQ54N5HMqBlTCflbwkpSFEnJz8q4t11RIJXS8+ZsaRj74OT
	 Qhf9vLLxHH4NKZ348ln845Y+UrtuOK01MUrfnDfh3Fwrx8e2+NjUrkFE+K6ZUbl5IW
	 on7AP0eh80C7WQ/wgxvaEZWQ6Iwm5uBHROgwUgDUSM5mJP25i1YJD8VaJL6mXJoeNj
	 VRnKh/C0G5UrFGX1U2SEp/taIVayXIOa/tfBxC4Fc9N+NqnbaX96EZXV3FyHn7DYk8
	 i2o9xPZ1wdd95Sv8YwHwCRrjbUPupp8qPPkVguwqjT8KEcNObLX6HmabZ4tidsXsQG
	 94mOBHFTYhpIKbDSwazAT/DQ=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ED06040E0177;
	Fri, 26 Apr 2024 10:34:52 +0000 (UTC)
Date: Fri, 26 Apr 2024 12:34:47 +0200
From: Borislav Petkov <bp@alien8.de>
To: Perry Yuan <perry.yuan@amd.com>
Cc: rafael.j.wysocki@intel.com, Mario.Limonciello@amd.com,
	viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com,
	Alexander.Deucher@amd.com, Xinmei.Huang@amd.com,
	Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/6] cpufreq: amd-pstate: initialize new core
 precision boost state
Message-ID: <20240426103447.GAZiuDR7u2d-AXspik@fat_crate.local>
References: <cover.1714112854.git.perry.yuan@amd.com>
 <6ea9dc722218a8498e60612cdcd26e99305c16a8.1714112854.git.perry.yuan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6ea9dc722218a8498e60612cdcd26e99305c16a8.1714112854.git.perry.yuan@amd.com>

On Fri, Apr 26, 2024 at 02:34:45PM +0800, Perry Yuan wrote:
> @@ -665,18 +667,31 @@ static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
>  	return 0;
>  }
>  
> -static void amd_pstate_boost_init(struct amd_cpudata *cpudata)
> +static int amd_pstate_boost_init(struct amd_cpudata *cpudata)
>  {
> -	u32 highest_perf, nominal_perf;
> +	u64 boost_val;
> +	int ret;
>  
> -	highest_perf = READ_ONCE(cpudata->highest_perf);
> -	nominal_perf = READ_ONCE(cpudata->nominal_perf);
> +	if (!boot_cpu_has(X86_FEATURE_CPB)) {

Repeat after me:

Everytime I need to test a X86_FEATURE flag, I will use cpu_feature_enabled()!
Everytime I need to test a X86_FEATURE flag, I will use cpu_feature_enabled()!
Everytime I need to test a X86_FEATURE flag, I will use cpu_feature_enabled()!
Everytime I need to test a X86_FEATURE flag, I ...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

