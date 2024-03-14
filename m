Return-Path: <linux-kernel+bounces-103267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FF887BD36
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A8441F25A89
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D495A4C6;
	Thu, 14 Mar 2024 13:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="Rn2he2KG"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035C659B52;
	Thu, 14 Mar 2024 13:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710421356; cv=none; b=bMK8gUB0LDyaWylLh9jt8r8aHderGchlINI5Mg9MYHq7kGrN/ltFM0BNj16w0bKKI9COMVW5dJtij3bXAmURIlWTmSsmNCXzXqVn2EMzmeUHdnYQEWE057+huW6/FVOArsW1vPIXJ4D3Ily8d31vK9w4hYuA8DGUxOoAR4Tvvls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710421356; c=relaxed/simple;
	bh=RAKVpHxjeVAwoYuEB8CMcoH4wDiQqcm7h2A5VMcHkuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nwUfz+yBmyjmeTigmmtCWKdhkMOtDjElF6tdaDYYaUO/mhbZ6asVyqCMLP4SGhQCp4hiQb+8Jl6WioyQIqN9DIKfS+WbyghqRoz7hV7UtpbKOq4DepiBnLL+Y3UxNupOsW0T67Sxvboxgvz8r0IKmxwxSzmaf9fJnMEDSnDvVko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=Rn2he2KG; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 7265E1FE36;
	Thu, 14 Mar 2024 14:02:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1710421343;
	bh=2g+DQ7FufJDoNjxFyMoaWdNsJq45GFmfUlVzS35VOAE=; h=From:To:Subject;
	b=Rn2he2KGS+Lm6q4JT+i0cX0ELmENbr3vx1Sv6qu4a4EpLELff/S6/ElpoqrPc/2hq
	 DYnHwdGkFaqAKzcCjRz4cV2aXSZYrpqY7GG+7H19ej387/po4oTEWFz9SiF2tvnAD8
	 L/EmdRH54RQAsuoWP1iFnGvFAPse2H1coeCoOjImjcOhdzm093hfnDCCHfuhYyAroX
	 HbOkRgD5lH6A53OQDJyysy67rihuBg/p42hU0DEFL0eKgrbKqxMlq0M0opBDeAld1J
	 INwep7rJmgyaTv3UEc40VkMqVf/ukaL5PNVCNLMdR2sSss3/LTX6NF/poiaJHtegYo
	 BIGM1EGJIIjbQ==
Date: Thu, 14 Mar 2024 14:02:19 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Nishanth Menon <nm@ti.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Silva_Gon=E7alves?= <joao.goncalves@toradex.com>
Subject: Re: [PATCH v1] arm64: dts: ti: verdin-am62: use SD1 CD as GPIO
Message-ID: <20240314130219.GA124430@francesco-nb>
References: <20240312144956.40211-1-francesco@dolcini.it>
 <20240314121833.4fngkk35aw44o2x5@array>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314121833.4fngkk35aw44o2x5@array>

Hello Nishanth,

On Thu, Mar 14, 2024 at 07:18:33AM -0500, Nishanth Menon wrote:
> On 15:49-20240312, Francesco Dolcini wrote:
> > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > 
> > TI SDHCI IP has a hardware debounce timer of 1 second as described in
> 
> Umm... Minor clarification - the SDHCI IP is not TI's - as commit
> 41fd4caeb00bbd6dc55f056f3e8e956697b0760d says, this was an Arasan IP
> which was integrated into TI SoCs but needs it's own driver due to some
> quirkiness in the version TI picked up.
> 
> Are you OK to rephrase this as TI SDHCI 'instance' rather than 'IP'? If
> yes, I can do the change locally when I commit.

Fine for me, thanks,
Francesco


