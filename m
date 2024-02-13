Return-Path: <linux-kernel+bounces-63095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78565852ADD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 180511F237D7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFAA18E37;
	Tue, 13 Feb 2024 08:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="MtXTtQXr"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B997D20B02;
	Tue, 13 Feb 2024 08:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707812400; cv=none; b=MPpC9aK+sD645baqr2xUmX4+u67kx7IhTlm45kZ3F7bYvt5kI2B0UtQTOt3WE7NUvyhmuy9e5mNjPfnMl/KTb2rJ+Ipo/2QaPblOJ1jz4t/tZJfht0DhEaUOrVCg7YFQb7gZR3UiJ+JyAryap3E4Gz9k+K7iSYynre8HuqcGlhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707812400; c=relaxed/simple;
	bh=W3OQx+vte8LCFNUS3Wcu0smJm6CwOzsBDEvIBOQ0dmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJ+Oj/QjRnCinUlNytSjt0Q+Ch0FLjtgZo/nF1E4tj1OJMXsxGSPGuV9Qaf4RShaqlTQWERPhMhbmmgAkFBXw0oEsQ/Irhqpluau9IPFdzFmGGhojzvR0+6yTGBWmh4gyh0fITdI5+dI5uDpSnwJZjqqr0gxRLwq/0XxEj9hpQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=MtXTtQXr; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (unknown [5.170.16.17])
	by mail11.truemail.it (Postfix) with ESMTPA id 9A90920141;
	Tue, 13 Feb 2024 09:19:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1707812395;
	bh=aFTkNAreh+thEY8C06wOi8OJmoLRe11h8bSx1Ac7XvI=; h=From:To:Subject;
	b=MtXTtQXrPk3vRqHSWpJDxnMAEkfopkg1B1mIz6FZKqIobg9cXyKhz6uhjpA1OF7as
	 7wKOAgYWNv3LX4D7V05rCyBSdigivHOt779TUmOf2AcQQIGgWYSS26N31oWn0OQibe
	 9AFvc8MkKFxhGk1GCXyBakU9mqnSvoTmrTnZTWfQ36egloqv3WEchiiyLwWYEvL0G+
	 T4XXwlM+pLh+6BMIMVYyAY2C5Ef1rbDAyetOQbymA0TcnRXsFmZ5SBEkEWrtH4RvvA
	 KVhczQkVuLGoHwFAbD3tAJKcpuoMPCmHa3TBDsIJOAStyfkAqqVG/z4htyEsjwDiPK
	 pYJGzQsKQbfKw==
Date: Tue, 13 Feb 2024 09:19:53 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Wadim Egorov <w.egorov@phytec.de>
Cc: Judith Mendez <jm@ti.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v2 8/9] arm64: dts: ti: k3-am6*: Fix bus-width property
 in MMC nodes
Message-ID: <20240213081953.GB3810@francesco-nb>
References: <20240213002416.1560357-1-jm@ti.com>
 <20240213002416.1560357-9-jm@ti.com>
 <c6ad3a3e-330c-40cd-8e25-fd259fd1e398@phytec.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6ad3a3e-330c-40cd-8e25-fd259fd1e398@phytec.de>

On Tue, Feb 13, 2024 at 06:07:28AM +0100, Wadim Egorov wrote:
> Hi Judith,
> 
> Am 13.02.24 um 01:24 schrieb Judith Mendez:
> > Move bus-width property to *main.dtsi, above the OTAP/ITAP
> > delay values. While there is no error with where it is
> > currently at, it is easier to read the MMC node if the
> > bus-width property is located above the OTAP/ITAP delay
> > values consistently across MMC nodes.
> > 
> > Add missing bus-width for MMC2 in k3-am62-main.
> > 
> > Signed-off-by: Judith Mendez <jm@ti.com>
> > ---
> >   arch/arm64/boot/dts/ti/k3-am62-main.dtsi       | 5 +++--
> >   arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts | 1 -
> >   arch/arm64/boot/dts/ti/k3-am62a-main.dtsi      | 2 +-
> >   arch/arm64/boot/dts/ti/k3-am64-main.dtsi       | 2 ++
> >   arch/arm64/boot/dts/ti/k3-am642-evm.dts        | 2 --
> >   arch/arm64/boot/dts/ti/k3-am642-sk.dts         | 1 -
> 
> I think you missed to update all non TI boards.

Not sure which boards are you referring to.

I would not change the verdin-am62 boards, the bus-width there is
consistent with the schematics, it's just correct and in the right place
IMO.

Francesco


