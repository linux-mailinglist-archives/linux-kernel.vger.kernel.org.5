Return-Path: <linux-kernel+bounces-39766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D496883D5DE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 890CA1F212D0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329C0134AF;
	Fri, 26 Jan 2024 08:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="sIqksMLT"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA501CFAE;
	Fri, 26 Jan 2024 08:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706257940; cv=none; b=pQhfLOGzzqxxWjB6QZ6xMXLD3vEK3ms/kC+scbp+fITYPxiP7HstRM3XtTfMsLgK06m8c8uSBq64jreHKMHtkc2ien9uUpVzsDxuAsE6DgCcbEBDqJf+i+eS+4vBe1xp0aXVRMaANnmFTIIO6acGBnua0anY3YvSppuVyQk+djg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706257940; c=relaxed/simple;
	bh=jlmG1wzP0u2ArENwmDLoBVgwPoZ/B4FgKHD1TWOBq7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8Kv1YzsrirkXdov0iUQhIvY/JuskEdtsff6zWPzqjAbrp1KIH6IYHd5dWsMLG6FF7uSMJQWSZTFvE7kGLEMzeO5ZXZCLVGnV6bO4VJ/UtYhAeauHdyxHQ+yy8YNle/eRjshFE8twtxipzAnxbc0SuAOdxBwHcWmaq3YvZ2UvN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=sIqksMLT; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 185BD6042F;
	Fri, 26 Jan 2024 08:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1706257937;
	bh=jlmG1wzP0u2ArENwmDLoBVgwPoZ/B4FgKHD1TWOBq7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sIqksMLTCXWb8YUFNG8ewkvN10ILCXI1aOGTilVIg35IPVz+WJkoCE8estBQG+FAi
	 Ki7xAhTnIBvmU7OT5pDVYwupm0MNdBVikCkHmOMS9zEnkFYc+p+Rv439YyW0wezQ1m
	 AQm1UrgeSR3ciAJ3BUe5fRPWvd1aD73HTbeyQcR6/w7KFSGosKYgBRYmLPOjEu2v0g
	 mVdpTvoPRdfSwfRtXaknFwhfG7tSnHQ2Nw7J0GGffMSE7mDHmuKgl3dLTRVj+R2bCQ
	 FPbBMatNFsfpZfk6sdEu7p4PAQn8v0x91DqeXdCxoUqSYY1vMnecRDXgdstAf4F0rd
	 G/IDhnoyGsmvg==
Date: Fri, 26 Jan 2024 10:31:17 +0200
From: Tony Lindgren <tony@atomide.com>
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Andrew Davis <afd@ti.com>, Frank Binns <frank.binns@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	Adam Ford <aford173@gmail.com>,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	=?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-omap@vger.kernel.org,
	linux-mips@vger.kernel.org
Subject: Re: [PATCH 02/11] dt-bindings: gpu: Add PowerVR Series5 SGX GPUs
Message-ID: <20240126083117.GU5185@atomide.com>
References: <20240109171950.31010-1-afd@ti.com>
 <20240109171950.31010-3-afd@ti.com>
 <e2fce141-4966-4e70-9a5c-865a2737174c@linaro.org>
 <20240110083857.GB5185@atomide.com>
 <20240119174815.GA633343-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119174815.GA633343-robh@kernel.org>

* Rob Herring <robh@kernel.org> [240119 17:48]:
> On Wed, Jan 10, 2024 at 10:38:57AM +0200, Tony Lindgren wrote:
> > So for merging these, as many of the changes touch the omap variants, I
> > could set up an immutable branch with all the changes after -rc1. Or I can
> > ack the patches too if somebody has better ideas.
> 
> Just take all but patches 10 and 11. I don't think it matters if the 
> binding is there for them as long as it is all there in next. No one is 
> paying that close attention to the warnings I think.

OK I've now applied these except patches 10 and 11 into a sgx-for-v6.9
branch [0].

Regards,

Tony

[0] https://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git/log/?h=sgx-for-v6.9

