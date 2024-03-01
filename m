Return-Path: <linux-kernel+bounces-88246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3CD86DF1B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CB781C20C6E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C3B6BB20;
	Fri,  1 Mar 2024 10:17:06 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3672EB0E;
	Fri,  1 Mar 2024 10:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709288225; cv=none; b=K3L6aqGnk+sHYUMY01hakWaaWMCjdZCU9ZC0PpLAmSrJkMSt3w4v2mGaX4kkYTCQv4DiwlKIJror4zrL98VgT89ESr6008BdNZrOMLcQLsSHNLlXBaO7171Do8cDWnd6UOOq0NeiA4+FZs5hda6oBCVwBoXxuAdrykNRFz7z5Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709288225; c=relaxed/simple;
	bh=qwVIxiufJj1mr1cm23cxINBd1eTGOKopYIHThjoyex4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iaG5YaBDQYDKdDoOQnyozHQDFvyljgi4X7nOO2IpGHaO8H0+a0BlYw/pv5ZWITphUrLIWSTYj8l+Ot7rATLSDL3jWz1ehQn8oLpvR63O0CF/zSfa5BO7+8RVEJueyQcSBxIwye+edDqVTLTvx2U4oBesR9790cpiPmJKLCu7tcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rfzwh-0002zb-00; Fri, 01 Mar 2024 11:16:51 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id D28FDC0267; Fri,  1 Mar 2024 10:39:47 +0100 (CET)
Date: Fri, 1 Mar 2024 10:39:47 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>,
	Paul Burton <paulburton@kernel.org>, linux-mips@vger.kernel.org,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v8 00/14] Add support for the Mobileye EyeQ5 SoC
Message-ID: <ZeGiYyiQQ7pwpECE@alpha.franken.de>
References: <20240216174227.409400-1-gregory.clement@bootlin.com>
 <ZdSst3fM3EOQGH03@alpha.franken.de>
 <CZGOPF51JA1R.2YN65K6WUH9N4@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CZGOPF51JA1R.2YN65K6WUH9N4@bootlin.com>

On Wed, Feb 28, 2024 at 12:44:09PM +0100, Théo Lebrun wrote:
> Hello Thomas,
> 
> On Tue Feb 20, 2024 at 2:44 PM CET, Thomas Bogendoerfer wrote:
> > On Fri, Feb 16, 2024 at 06:42:09PM +0100, Gregory CLEMENT wrote:
> > > Hello,
> > > 
> > > The EyeQ5 SoC from Mobileye is based on the MIPS I6500 architecture
> > > and features multiple controllers such as the classic UART, I2C, SPI,
> > > as well as CAN-FD, PCIe, Octal/Quad SPI Flash interface, Gigabit
> > > Ethernet, MIPI CSI-2, and eMMC 5.1. It also includes a Hardware
> > > Security Module, Functional Safety Hardware, and MJPEG encoder.
> 
> [...]
> 
> > series applied to mips-next.
> >
> > I've fixed generic|ingenic|realtek builds by adding select MACH_GENERIC_CORE
> > in arch/mips/Kconfig.
> 
> Would it be possible to provide an immutable branch containing the two
> series? I've got quite a few series that depend on them as they target
> EyeQ5 devicetrees and defconfig.

that's IMHO too late, as I've merged it already to mips-next. mips-linux
itself is immutable, but contains other mips related stuff.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

