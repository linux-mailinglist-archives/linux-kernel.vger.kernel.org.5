Return-Path: <linux-kernel+bounces-55592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CC284BE9F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 21:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31ED2B23059
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B973317BAE;
	Tue,  6 Feb 2024 20:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yaorfce7"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA0F179A7;
	Tue,  6 Feb 2024 20:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707251013; cv=none; b=X6bIpG3AeTjIvZ1c4kkoB+0JlcZcagSddN0MdfkTYoAYmTo6xMPvxwdwvGf6RMZljk6elPTjQdBCuv7b6XARMkto0+XT87f1/XYFh4dYY+msF8p8lKo5AhGhgwEdjKSMdJFBx/DTNC9/jvWjb4NOGxrbp7HvEeyLu3hX7emiOnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707251013; c=relaxed/simple;
	bh=ExVvdejDXaScW5SRhts9i60rZm7y9Bidq97I4ylJFPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BysG/632j4oLxLditxv9cdyayeWZdbMH/vj2tunt0Pz+zAf58UlGqaK6wAyLvL866VETLmWn6WTfOJLe35SP30oDv0k0/fTqx931R9zCdnS+d67dWMSmsVVDOzMvEaFH/hFszw/uPu8mJIBLIiS2gss+5EK3u2bpePUTYGhLQ2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yaorfce7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=bMRByQrhVkH4pn/LwNEljSjg1desPiypR55QpUVdA4E=; b=yaorfce7tSCRyMYkfTKabrZwgM
	SBdMEzaXYc7q+HXTVYWaTtRQLqWs1f0Sbd9MhYf5jGOHMkhMwQTQ7wMflN8+GgkSODqG0QPRDnhVL
	xKzL5RqmX7K4VEZpM+e0Zh5KxZTcb3Zw5RlEKTCQcSvBhjx+wQbJMsYuFVWSQRcLrs+mviM+d+DRA
	zek49347WzQdHXz/ghdXIidvU+MethVz6T88/u61Ye2zqVr+9/KNRsRGGrTDw+pAJP7lnPXTJP7EI
	ODDfqbGiClygIKP0yURldydQ1dflxvssNYvlr5TnFQxJW5cEd0fqmrHdbGTxIrMLnr7nFx06GraqS
	JItv7k7Q==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXRyV-00000008mRy-1Rpl;
	Tue, 06 Feb 2024 20:23:25 +0000
Message-ID: <7c0dd2f1-0b43-425e-8b0e-004760bed317@infradead.org>
Date: Tue, 6 Feb 2024 12:23:21 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: Add the arm64.no32bit_el0 command line option
Content-Language: en-US
To: Andrea della Porta <andrea.porta@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240206185459.32465-1-andrea.porta@suse.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240206185459.32465-1-andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

On 2/6/24 10:54, Andrea della Porta wrote:
> Introducing the field 'el0' to the idreg-override for register
> ID_AA64PFR0_EL1. This field is also aliased to the new kernel
> command line option 'arm64.no32bit_el0' as a more recognizable
> and mnemonic name to disable the execution of 32 bit userspace
> applications (i.e. avoid Aarch32 execution state in EL0) from
> kernel command line.
> 
> Link: https://lore.kernel.org/r/ZVTleETzfFUchs77@apocalypse
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 3 +++
>  arch/arm64/kernel/idreg-override.c              | 2 ++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 65731b060e3f..9f962deeef5a 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -433,6 +433,9 @@
>  	arm64.nosve	[ARM64] Unconditionally disable Scalable Vector
>  			Extension support
>  
> +	arm64.no32bit_el0 [ARM64] Unconditionally disable the execution of
> +			32 bit applications
> +

That new entry is not in alphabetical order like it should be.

>  	ataflop=	[HW,M68k]
>  
>  	atarimouse=	[HW,MOUSE] Atari Mouse


-- 
#Randy

