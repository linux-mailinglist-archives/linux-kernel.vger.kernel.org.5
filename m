Return-Path: <linux-kernel+bounces-45993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D2E8438F6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 753B31F2813D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06111605BC;
	Wed, 31 Jan 2024 08:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grimler.se header.i=@grimler.se header.b="ffg99K2T"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7875813A
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706689540; cv=none; b=KQ1pSkuwmh08GZpTMvvynIRsvB9d/hBa2zAyRiVdbaAsJoo12HYv4gCikrM03J2sQKyJ0ZiZSNUbRws2RGX0cVtjB5zq3/abPqYY3tFLUzTkjzh+TupNhg02i4bdAkFhTZnmBy6g0Z9qq+Vn9PB2Xu1e5q4pwgvctDBrZZ/WvWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706689540; c=relaxed/simple;
	bh=WWX+x9HX5EM8SaGAqOTNX3kDLlC1VquzzVi/hKdjFxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ze/nLcIDJMRweLfoZkaSf7lxQxgnpLwh9pPQgXsi0vx8mulGViEUrqgjJqfV/5ZZD1NIxnw3qocPzrfWcSai3XhoGmSMHx4w3M96VSTLFltOm7L7YahsbLiyTcJ3D8F2iM5OWjuSmFYGIDbKdnrli8ZRsUylaray7Yabi6tn3J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=grimler.se; spf=pass smtp.mailfrom=grimler.se; dkim=pass (1024-bit key) header.d=grimler.se header.i=@grimler.se header.b=ffg99K2T; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=grimler.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grimler.se
Date: Wed, 31 Jan 2024 09:25:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
	t=1706689528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kWb7p2bEtC92dOJ6NGc+Pmrz9kY3GPom2bz71f1CiJU=;
	b=ffg99K2TI0MAAwgF88UTYZ8mGusdiPX33vtKIz4/8qFKXbtax1LAsi7Un1fa6NiCgvVBwo
	B6E8/CUtZLuhQ6jW6R9gNIhs2cKi+gqxTRGdpYrovm5WqXPaQnbtwkAmoN++jj0YQrWK1u
	VzRop7zX+gZQMobPhv4lID5G89BtsZ0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Henrik Grimler <henrik@grimler.se>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 1/3] ARM: dts: samsung: exynos5420-galaxy-tab-common:
 sort node properties
Message-ID: <20240131082401.GA6710@samsung-a5>
References: <20240130-galaxy-tab-s-cleanup-v1-0-d4e17857241d@grimler.se>
 <20240130-galaxy-tab-s-cleanup-v1-1-d4e17857241d@grimler.se>
 <a04aa883-d9b8-480b-a9df-8c31bef1165c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a04aa883-d9b8-480b-a9df-8c31bef1165c@linaro.org>
X-Migadu-Flow: FLOW_OUT

Hi Krzysztof,

On Wed, Jan 31, 2024 at 08:19:39AM +0100, Krzysztof Kozlowski wrote:
> On 30/01/2024 21:40, Henrik Grimler wrote:
> > Sort all node properties according to dts coding style guidelines, to
> > make dtsi easier to follow.
> > 
> > Signed-off-by: Henrik Grimler <henrik@grimler.se>
> > ---
> >  .../dts/samsung/exynos5420-galaxy-tab-common.dtsi  | 23 +++++++++++-----------
> >  1 file changed, 11 insertions(+), 12 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/samsung/exynos5420-galaxy-tab-common.dtsi b/arch/arm/boot/dts/samsung/exynos5420-galaxy-tab-common.dtsi
> > index f525b2f5e4e0..0c1aeafc025b 100644
> > --- a/arch/arm/boot/dts/samsung/exynos5420-galaxy-tab-common.dtsi
> > +++ b/arch/arm/boot/dts/samsung/exynos5420-galaxy-tab-common.dtsi
> > @@ -103,8 +103,8 @@ &cpu4 {
> >  };
> >  
> >  &gpu {
> > -	status = "okay";
> >  	mali-supply = <&buck4_reg>;
> > +	status = "okay";
> 
> Such changes should come from a tool, but since we do not have them, I
> don't want to bother with properties re-shuffling.

Noted, thanks. I will drop this patch and send a v2 in a few hours.

> Best regards,
> Krzysztof

Best regards
Henrik Grimler

