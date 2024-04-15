Return-Path: <linux-kernel+bounces-144769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5D08A4A7E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B05C1C222F2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD8F39FCF;
	Mon, 15 Apr 2024 08:36:27 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11762110F;
	Mon, 15 Apr 2024 08:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713170187; cv=none; b=rGqH3XFlR/GfPffV9rcJrg0rqDnp/8Ya+RV2U4O4jXrbbEkVcT0ZqJeD2TJ6ukl4vXgkXXsA4xe3RHsIV+CB4wbrnuilmvjSu2HbLI+h1qBKv0eEuwg6Nz1xXCQFtumI4dYD11p2ZQHAw+ART6ovukDAKwMsCvhNTQYnFMrcEMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713170187; c=relaxed/simple;
	bh=dDiFdwFAfGbkDMVzPEsliCJATEf7dvVMGkGRmgu206s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=liOkrI/mzr+Qed/M892IaO125IzAG0NSzFrH3WEwUg0H6kWDPFjw9Ru4IBiJaWPwrsKu6tmwudon953l32Z+iA9wejVaRj2I1Hmv1Y2jKsEMz7sltTH+3kPgdQG5bcrQeWt+/9XsK9J3fWR2lzRoteapizoHl5U3PBAYb94cPMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rwHoa-0004hj-00; Mon, 15 Apr 2024 10:35:48 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
	id F2EC9C0248; Mon, 15 Apr 2024 10:32:46 +0200 (CEST)
Date: Mon, 15 Apr 2024 10:32:46 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: Justin Swartz <justin.swartz@risingedge.co.za>,
	Sergio Paracuellos <sergio.paracuellos@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 00/14] mips: dts: ralink: mt7621: improve DTS style
Message-ID: <ZhzmLroS9sPGjeBb@alpha.franken.de>
References: <20240316045442.31469-1-justin.swartz@risingedge.co.za>
 <6e8d08e4-5b26-4705-b636-0fc4412a7457@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6e8d08e4-5b26-4705-b636-0fc4412a7457@arinc9.com>

On Mon, Apr 08, 2024 at 10:35:07AM +0300, Arınç ÜNAL wrote:
> On 16.03.2024 07:54, Justin Swartz wrote:
> > This set of patches was created with the intention of cleaning up
> > arch/mips/boot/dts/ralink/mt7621.dtsi so that it is aligned with
> > the Devicetree Sources (DTS) Coding Style [1] [2] guide.
> > 
> > [1] Documentation/devicetree/bindings/dts-coding-style.rst
> > 
> > [2] https://docs.kernel.org/devicetree/bindings/dts-coding-style.html
> > 
> > Justin Swartz (14):
> >    mips: dts: ralink: mt7621: reorder cpu node attributes
> >    mips: dts: ralink: mt7621: reorder cpuintc node attributes
> >    mips: dts: ralink: mt7621: reorder mmc regulator attributes
> >    mips: dts: ralink: mt7621: reorder sysc node attributes
> >    mips: dts: ralink: mt7621: reorder gpio node attributes
> >    mips: dts: ralink: mt7621: reorder i2c node attributes
> >    mips: dts: ralink: mt7621: reorder spi0 node attributes
> >    mips: dts: ralink: mt7621: move pinctrl and sort its children
> >    mips: dts: ralink: mt7621: reorder mmc node attributes
> >    mips: dts: ralink: mt7621: reorder gic node attributes
> >    mips: dts: ralink: mt7621: reorder ethernet node attributes and kids
> >    mips: dts: ralink: mt7621: reorder pcie node attributes and children
> >    mips: dts: ralink: mt7621: reorder pci?_phy attributes
> >    mips: dts: ralink: mt7621: reorder the attributes of the root node
> > 
> >   arch/mips/boot/dts/ralink/mt7621.dtsi | 430 ++++++++++++++------------
> >   1 file changed, 239 insertions(+), 191 deletions(-)
> 
> Thomas, will you apply this patch series as is or should we squash it to
> one patch?

I've applied them, no need to squash.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

