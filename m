Return-Path: <linux-kernel+bounces-161541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C4B8B4D76
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 20:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75ABE1C20953
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 18:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD4956B60;
	Sun, 28 Apr 2024 18:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="G8WY07E2"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131DF637;
	Sun, 28 Apr 2024 18:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714329115; cv=none; b=mJmA9PZKwmW7KNcsqtRPv2Eu/ezwUisnWLQkyOGUpJd+9stLfWJVyd9QA/TDiNFVqrbEfnplHACo0biUM36un6L/jqLMolK+ptLMldtUoYpgnA/0vV7UYOp+0ZhEZ+jlrmpDv2/X6QKDrLzJ43wLZ6WeHotG4vRxkyla3tyyDRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714329115; c=relaxed/simple;
	bh=nKhYVMPF3dLb3WTODieun1LiiOpjngfOtKCLBKA0jfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8t2N1KSYv4pjC5me+WSY8PVF5oVorZQ+kIcR520mmqwj/XkLeH0zuu5cKXQyAzBjiW3/J1mVLRzc6sEV5eNpvOvepcCfxN2WrrthT2DAnjdGRovJofaxV8Y4YnxhggXTeONdxMKLxt7mD095f6JvEmVR9pnctI5a5CPPK1A/Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=G8WY07E2; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 141AC40E0205;
	Sun, 28 Apr 2024 18:31:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id NeroCGrJ4vxC; Sun, 28 Apr 2024 18:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714329108; bh=NgizXzri5JvSwG7gvqwUSh/z+pZkn8saouSm8FOp+W4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G8WY07E2ilwRSqqOqKldIdcINt0qIEjhDjT0mz18dzJvVh0i5NHRRbnLF1bAr+CvA
	 g2OSSxxYj9lyb9n5D7axBNqZUNf6yzuJxt644F6AK0Rd+poxtlXEXSVT1fpynz0sGR
	 P9EhYrao/0Z8xQ7kED7cil7UcSHfuWmsVXk8iPiRfTm++fHuMwIcERc6Z6Geom2HP9
	 3pngWNJBc2U6gzuzkhrJJnetQbGw9z/Dpi2KJ+1HCEyst7dQ0xWDbrnnH0iEp3OcFk
	 F42beFd5TmfGQg50HdV6uC1ExEXoxc3L4x8BknItikdU7dl39IdopnQoKafbgczbT+
	 1M/N+uKie+mDqdykEpMd2bxAg4IXGcRyXtdmNeNFBF5oKNQ7951iIKPNLX1gCE9yci
	 7kkdBCdElg73K3+WrqwZs4d9ZCD9O4DsOXdMq4AUyE95ysQI/Ye8bJgPmAEd4xHDqT
	 yV4uJ8/rLO+uGhGlnolVinAv8BTQdK3CBmt0d9WZhFb9dUUnmvrIDevkr97zJf/MDx
	 W+HJWo7tuqHu7U/uu8RUFRA0rbX06tIAlZCjKDssAQ4AdepX8eSNdQufwxG97lE5bN
	 zu474ZJouDoSihK1VnnLPjGs2bldHs+xpEukfUw6pVvXXiX0+ADfM0nKWKXeI/vLP+
	 SFU9wzZYHY/8bxR6fZSeW2lA=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6D91E40E0187;
	Sun, 28 Apr 2024 18:31:43 +0000 (UTC)
Date: Sun, 28 Apr 2024 20:31:42 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tony Luck <tony.luck@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: Re: [tip: x86/cpu] x86/mce: Switch to new Intel CPU model defines
Message-ID: <20240428183142.GHZi6WDu5nbmJJ_BcH@fat_crate.local>
References: <171415513118.10875.11391783217612357854.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <171415513118.10875.11391783217612357854.tip-bot2@tip-bot2>

On Fri, Apr 26, 2024 at 06:12:11PM -0000, tip-bot2 for Tony Luck wrote:
> @@ -398,7 +398,7 @@ static noinstr int mce_severity_intel(struct mce *m, struct pt_regs *regs, char 
>  			continue;
>  		if (s->excp && excp != s->excp)
>  			continue;
> -		if (s->cpu_model && boot_cpu_data.x86_model != s->cpu_model)
> +		if (s->cpu_vfm && boot_cpu_data.x86_model != s->cpu_vfm)

Hold on, isn't this supposed to be:

		if (s->cpu_vfm && boot_cpu_data.cpu_vfm != s->cpu_vfm)

?

You're getting rid of the ->x86_model checking altogether...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

