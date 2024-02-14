Return-Path: <linux-kernel+bounces-65979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E1F8554A8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F223B21811
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 21:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01E813EFF4;
	Wed, 14 Feb 2024 21:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="CqCyTW2H"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A89B1B7E2
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 21:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707945806; cv=none; b=r4PKJGh0PsTCkBXz7EcCXDFHKfpaQEDMg7Y0/P6bkc5isvdLIwtX9sApoH1BQsaQvDcPXm64pHt/GX3eZdCz0ts3iaJsAJ/EScPg92UEnIyrtBNAVF5lu25w2+Obrc415cfYpwjKOAyeN4SoORpwCTeI3KwLznZDLQXScS5ZO7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707945806; c=relaxed/simple;
	bh=/3sj4kIHsz1lrH0Xu4Znbnbda38oIJNyyz7OZQyRXzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHyV2dI1uNtLE7Yli+Ic7084yxnZ5+e6Rt+CUvj0jdnnwX4TKXULgyTmtW3eUs0OqPA1O+WxzgpaqgIa3qv8YfbyOs5dw1CbWGsehGH7+OZtIwBeGT42f+eugbvB27Gm4c3F/bMyhPH8KvAy43vmJqFVGzNwmtzglgeZ4SNHkJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=CqCyTW2H; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D60F540E016C;
	Wed, 14 Feb 2024 21:23:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id LsUm4qn5MwcQ; Wed, 14 Feb 2024 21:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707945798; bh=T+yxDWMbLz2SzuwieZyo2L9JUJzqcNd3Kd8AlmJ19Xk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CqCyTW2HQNs4u1nZXHZH2gKQpE0+cK0oNMcxRnj3JwQ4TLliBuM8QFKAp/d9j+fIX
	 ulGs08yBO6nahzlVERpZhH+5Q68vQLxQ+YtfZ8liMlnMQeE45n/1Q/C0sEub5WC1Wi
	 NupuKd4rxre78MMRgPa46okFfy8c3WJJim+xmOV6Ktr8NdK0MK4z7qHPF9AOdY+T+b
	 k9VJjWKj/9jTY3AHl/pN5HM7SKjapboR7Oa11cj3I4Y3/aCve9br4ZVn+J0eSbce4X
	 ofOlOSkdAAWEukRYZK5+AtXYIEb49wvgShizuwdc6RaJ0VzWHrMRrNs1XjPYYuRN2y
	 2VsecLXEfyBTyrugavX3+nBmawDPZOH8ntaeggnQi/2IHnKIQp7GS3OJsR9BBlvsPQ
	 dY87T3kjjTFTjbQogoHr7tY2HPB0ZXChlmG7rYocYpnqPRC/75y28Q4PNzaxCJfHPN
	 GhNIhlf1gZ7cGyaZCEO0atyrQ3Mj51aSAGUpFkOfH3Gz6cW9+lHtTY8poTmbFWmVUt
	 u3oKu38EVUew3g+hWcV1OAmdPCtBX6eDbeCpbmVbGX2TmiktyaNcY6HE1z+98r7J5o
	 CDTbCB6Gr14Z5AGx/DpigymXlCCjWthmb6VEBGzqj/ahE4D5H6aRpc1w6nlmYjXPyJ
	 /SDLW3kd2vkjZchKhlmlUxng=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6710640E00B2;
	Wed, 14 Feb 2024 21:23:12 +0000 (UTC)
Date: Wed, 14 Feb 2024 22:23:06 +0100
From: Borislav Petkov <bp@alien8.de>
To: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc: Ashish Kalra <ashish.kalra@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>, X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/sev: Dump SEV_STATUS
Message-ID: <20240214212306.GHZc0vOtia9U0d2P6-@fat_crate.local>
References: <20240213163311.32130-1-bp@alien8.de>
 <20240214163725.GA13407@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240214163725.GA13407@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Wed, Feb 14, 2024 at 08:37:25AM -0800, Jeremi Piotrowski wrote:
> This could use some commas/delimiters to improve readability for those multi-word
> bits (or stick to the name from the APM).

The APM names are too long.

> This is from an Azure SNP CVM(*):
> 
> Feb 14 16:16:55 vm kernel: SEV: Status: SEV SEV-ES SEV-SNP vTom Reflect VC AI DebugSwap No HostIBS BTB Isol VMSA reg prot

But yeah, that's a good point. I'll make them all a single word so that
space is a natural delimiter.

And the usual use case is to do

dmesg | grep -i "bla"

Thanks for testing it!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

