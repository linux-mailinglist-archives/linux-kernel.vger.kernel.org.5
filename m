Return-Path: <linux-kernel+bounces-70334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FA9859634
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 11:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FC491F211FC
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 10:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C07E37162;
	Sun, 18 Feb 2024 10:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grimler.se header.i=@grimler.se header.b="POmXrPzV"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78872D60B
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 10:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708251899; cv=none; b=usZJ0bS06s7fE2wwF2/RDZOfWHH5JA96cD5O2LHPbctYKXebfj28/hk/wweA2nlaTqaU4ALM4qbf7LGsBzMfzlFUxBN2r6de3LawEfzjOBjI+oim1bl6ho+NY/Zd+qnGjyE1uZAyCqkM31pGyNHXvyoe/UXsWXIfZ+8dHAGqZJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708251899; c=relaxed/simple;
	bh=7T65f/Wd63Ks1lufnUN/PWkHZ5lS3y7W0WH/QysgGms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZ80F7lm0aV+ZSPe3FvAec/nY97cE3hGDOzcWt0jE5s+yCvCq1REegpZzttn5on0k4J3SX4bVHZwnK+Eg3ofW/QATwnPbrLoMRn1Upw/P3m0TjVbJhG1TH1OjP6bFAkAnXpbuBAxjLPF6Lb4VS7KGJE3rr/nO2wAk7HW5SpjPDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=grimler.se; spf=pass smtp.mailfrom=grimler.se; dkim=pass (1024-bit key) header.d=grimler.se header.i=@grimler.se header.b=POmXrPzV; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=grimler.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grimler.se
Date: Sun, 18 Feb 2024 11:24:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
	t=1708251893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Q6gteFXLuw2xa9qiBWiKUaLv3oz6lEnepe4NxbB9Vs=;
	b=POmXrPzVyqbX9+lwS3g3MVsM1gkzEC6PGkcdMmTbGjf5yrQqoVeEAEoDS4EJZiuikXJKfd
	1vWGINMT2dD/TMkzn6/SakwIOj1swc3zbVfj/gXijUECLRdfA7pjr8CBm/Tb4DkQjDtQYi
	OW/n+aog7oheGUfApsczc9y54aCsUcc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Henrik Grimler <henrik@grimler.se>
To: Artur Weber <aweber.kernel@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH] ARM: dts: exynos4212-tab3: limit usable memory range
Message-ID: <20240218102449.GA7577@grimlerstat.localdomain>
References: <20240217-tab3-limit-usable-memory-range-v1-1-49cc9c86a5cc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240217-tab3-limit-usable-memory-range-v1-1-49cc9c86a5cc@gmail.com>
X-Migadu-Flow: FLOW_OUT

Hi Artur,

On Sat, Feb 17, 2024 at 08:02:47PM +0100, Artur Weber wrote:
> The stock bootloader on the Samsung Galaxy Tab 3 8.0 provides an
> incorrect available memory range over ATAG_MEM. Limit the usable
> memory in the DTS to prevent it from doing so, without having to
> disable ATAG support.
> 
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> ---
>  arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi b/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi
> index e5254e32aa8f..9bc05961577d 100644
> --- a/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi
> +++ b/arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi
> @@ -45,6 +45,12 @@ chosen {
>  		/* Default S-BOOT bootloader loads initramfs here */
>  		linux,initrd-start = <0x42000000>;
>  		linux,initrd-end = <0x42800000>;
> +
> +		/*
> +		 * Stock bootloader provides incorrect memory size in ATAG_MEM;
> +		 * override it here
> +		 */
> +		linux,usable-memory-range = <0x40000000 0x3fc00000>;

Maybe it would make sense to set the memory reg to
<0x40000000 0x60000000> (1.5 GiB) and move the comment about last
512(/516) MiB being weird/broken here instead.  It looks a bit weird
that the memory range and usable-memory-range are identical, and device tree
should describe hardware, which technically has 1.5 GiB RAM.

From a functional point of view it does not really matter, so in any case:
Reviewed-by: Henrik Grimler <henrik@grimler.se>

>  	};
>  
>  	firmware@204f000 {
> 
> ---
> base-commit: 0f1dd5e91e2ba3990143645faff2bcce2d99778e
> change-id: 20240217-tab3-limit-usable-memory-range-1d1ffa8dc44d
> 
> Best regards,
> -- 
> Artur Weber <aweber.kernel@gmail.com>
> 

