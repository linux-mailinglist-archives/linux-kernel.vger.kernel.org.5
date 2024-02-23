Return-Path: <linux-kernel+bounces-78129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B46860F3F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D65C21C21465
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7301E5D46D;
	Fri, 23 Feb 2024 10:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrdpUBRi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAD2D533;
	Fri, 23 Feb 2024 10:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708684160; cv=none; b=iXpdTMwaxa+sGEFns2AX06BBro+E7PU0fg/BAiloKd5AgZz/fC/RUnxYLm2KDCJ40mJCx6r7XLLxercxOsxIWABwGNA/sFKEDUc8i7Uq2LrD2hyaHT79CzNHGOuk9RyI2CtiS1nSIG593k6bmLemgtYdIOXa+Yw4F4sjfR5P4a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708684160; c=relaxed/simple;
	bh=9+IqwSvh3CVQ4wMae+KgwEVEiaFCooR3IE6EgC8AFiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQNGWgG2hFJ3+XBOiTloca7yUOHVGjEvcOzyW/d8KOGDxY8Jv9c3JDPYeKgFWy/4cq2kL0R0SIIbZ6Ac3tg6X2tiJyGn5hGr66rO6+JY13qj6t76NOcD+7MZF2nCpY5OIgqLyoSAmcc7OtM3lfgSKSB4sqkwwX7Ufk8nZkDg4HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrdpUBRi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16378C433F1;
	Fri, 23 Feb 2024 10:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708684160;
	bh=9+IqwSvh3CVQ4wMae+KgwEVEiaFCooR3IE6EgC8AFiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OrdpUBRiO2Z0ks2eXOy59okoAClE/jFoDtUYBj4pm34t6xtLgLhdk51J6LJSmIu9d
	 bj3nNO1WTfQ6M1EzSdKR3btBCylJltPr8D/x8nBrMiVnD4h2nyWREPETfswKbN451K
	 pc6p5yY8FOutizM3gIyIhui/alaAuDPSWyDz9ho/TwmddVtx5qhz7HhIFA2yD9C70P
	 OIG5DyCYy+cvtFue8ve3oicditG/q5Z+jOT1CbfaqptElxfFx3Fv8iH3Xm/wv/xEOJ
	 Z9Rp4KSLd287UYRl0mgnXPVZ1DxDW3UUYSM4ztKsOMcvztoEkqdwaX07o5ZSjWE+Cq
	 tyNpqEQbNCNpA==
Date: Fri, 23 Feb 2024 10:29:14 +0000
From: Lee Jones <lee@kernel.org>
To: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc: linux-kernel@vger.kernel.org, Aren Moynihan <aren@peacevolution.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
	Chen-Yu Tsai <wens@csie.org>, Ondrej Jirman <megi@xff.cz>,
	linux-sunxi@lists.linux.dev, Pavel Machek <pavel@ucw.cz>,
	linux-arm-kernel@lists.infradead.org, linux-leds@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, Miles Alan <m@milesalan.com>,
	Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v2 4/4] arm64: dts: sun50i-a64-pinephone: change led type
 to status
Message-ID: <20240223102914.GO10170@google.com>
References: <20240206185400.596979-1-aren@peacevolution.org>
 <20240206185400.596979-4-aren@peacevolution.org>
 <2792937.BEx9A2HvPv@jernej-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2792937.BEx9A2HvPv@jernej-laptop>

On Thu, 22 Feb 2024, Jernej Škrabec wrote:

> Dne torek, 06. februar 2024 ob 19:13:20 CET je Aren Moynihan napisal(a):
> > The status function is described in the documentation as being a rgb led
> > used for system notifications on phones[1][2]. This is exactly what this
> > led is used for on the PinePhone, so using status is probably more
> > accurate than indicator.
> > 
> > 1: Documentation/leds/well-known-leds.txt
> > 2: include/dt-bindings/leds/common.h
> > 
> > Signed-off-by: Aren Moynihan <aren@peacevolution.org>
> 
> Sorry for late review.
> 
> Please update subject in patches 2-3. Instead of "sun50i-a64-pinephone:"
> use "allwinner: pinephone:" (check commit history of sun50i-a64-pinephone.dtsi).
> Also rgb -> RGB, led -> LED. Last, please reword commit message to exclude
> links and just say DT bindings documentation.
> 
> Note that I'll merge patches 2-3 once patch 1 is merged.

Works for me - I'll go apply it now.

-- 
Lee Jones [李琼斯]

