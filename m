Return-Path: <linux-kernel+bounces-63455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEACB852FC4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E0841F25F12
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD2638DEC;
	Tue, 13 Feb 2024 11:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="sI3SJIhg"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68602381A1;
	Tue, 13 Feb 2024 11:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707824618; cv=none; b=qTdzLk5eTm3Mlq1hcCeC1ddg9YJwikZN8bG9Ojkt+DeayvqDwDSVfV4oBxhXNDoLyAFnFFHaIttMroMbBrDlMuhcRfLDCP1J2Y1h20r43FI0VkR4Ghs0VaTO6m+zwhov5TeW6e2Ttnfppy2A0+Zfo1B/JX1F8PU7R1p2R6L4aMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707824618; c=relaxed/simple;
	bh=QppPBZutxxvxsO7CZI8udsyp6dnLPQwivwjRU1FdxFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzkvms5lUhbcwR7C++E2vJ3t21G+mNZCqUCIZROrcbPmZjOICkDZiTomKAsK+aohK8v9lp4atF/m8EhZT0p9P0k1lR1jDICtoIXfC1PEkpteYmcRKyDN+mFtevr9dC0SbcqB88uvxJ+wL0lknNdXW5yUClHufovuahWtWaH6QLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=sI3SJIhg; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (unknown [5.170.16.17])
	by mail11.truemail.it (Postfix) with ESMTPA id 7B8B220A65;
	Tue, 13 Feb 2024 12:43:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1707824613;
	bh=Bp7pG2CUWQYmkgoE1nLhEi74JHI4RrXDPmnEHpNrJ3k=; h=From:To:Subject;
	b=sI3SJIhgbHDwl3u5ptprAx4mv/QomLlV1UL3bGxsM+Uc+ijsQqz6A5hASQcWFCKAS
	 FLHprtLXCKKEJKEKWRqKUFLJFEh//GWc6yXBgJ25pb9QdevosIZCUgTCFp2cQKvwwo
	 m/YwfJzpg4wTj6MPSNmxUDajdFuJk4mcTwSgFi8d0jB4VK9Oc5NtWMOykHEh5SvYLD
	 yPMhJRWrTw7vXQxm2KtkUtuTTc34KJvg6C/uw6tsyYQvzXPxLIFDUPe0Iv4FIvUDjx
	 bdxV3F33fYc+d8Xf7+KHCMcaM5N6jEQ7IdnFdV33sYBuu1gst+uW3HNJMeOkv2LYRz
	 CoKaCcwa6Gb9Q==
Date: Tue, 13 Feb 2024 12:43:28 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Aswath Govindraju <a-govindraju@ti.com>,
	Sjoerd Simons <sjoerd@collabora.com>,
	Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arm64: dts: ti: k3-am62-main: disable usb lpm
Message-ID: <20240213114328.GA6727@francesco-nb>
References: <20240209130213.38908-1-andrejs.cainikovs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209130213.38908-1-andrejs.cainikovs@gmail.com>

On Fri, Feb 09, 2024 at 02:02:12PM +0100, Andrejs Cainikovs wrote:
> From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
> 
> AM62 USB works with some devices, while failing to operate with others.
> 
> [  560.189822] xhci-hcd xhci-hcd.4.auto: xHCI Host Controller
> [  560.195631] xhci-hcd xhci-hcd.4.auto: new USB bus registered, assigned bus number 2
> [  574.388509] xhci-hcd xhci-hcd.4.auto: can't setup: -110
> [  574.393814] xhci-hcd xhci-hcd.4.auto: USB bus 2 deregistered
> [  574.399544] xhci-hcd: probe of xhci-hcd.4.auto failed with error -110
> 
> This seems to be related to LPM (Link Power Management), and disabling it
> turns USB into reliable working state.
> 
> As per AM62 reference manual:
> 
> > 4.8.2.1 USB2SS Unsupported Features
> >
> > The following features are not supported on this family of devices:
> > ...
> > - USB 2.0 ECN: Link Power Management (LPM)
> > ...
> 
> Fixes: 2240f96cf3cd ("arm64: dts: ti: k3-am62-main: Add support for USB")
> Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Francesco


