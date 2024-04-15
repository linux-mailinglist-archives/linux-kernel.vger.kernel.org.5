Return-Path: <linux-kernel+bounces-144768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE8E8A4A7D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69C99283D1B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997B439FC9;
	Mon, 15 Apr 2024 08:36:27 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11B43770C;
	Mon, 15 Apr 2024 08:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713170187; cv=none; b=ZS7Ll7TEesDF155BP7tUYuMxNEzGYd2Z6z8bAbHKgLiAbxj62YRX277mDOVrslqLruyPR3MccB3sCY3sMDENguVmZJReodrZcXC1OCOn5VyqvTBfGlRP/UjIHy8bpJ2GNCKrCWR1A15D4cVwbwCP25wuuATQi/tUk1+Y1g9cS3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713170187; c=relaxed/simple;
	bh=XbFCU3/CfNQ0QTR2migCKHKWgs/cnHZIVxBe6DtTI6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzL7+mxz8qohgi7mlIbjakrx1j0Z6HJgoHQOfQAFyqpAlr2ZXqTAJye3JxsQd5c8AqDhf+PJMYxPRVMOdjIojAEBmnxxhx9NoGaOEEnHEJC2dLUd+4XJiYzC6KNy4ILYGOxyO8dbP7NPH/kLU9d2rVnhIdoczGmWsZ3ibAaKEOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rwHoa-0004hl-00; Mon, 15 Apr 2024 10:35:48 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
	id ACD72C02CD; Mon, 15 Apr 2024 10:33:03 +0200 (CEST)
Date: Mon, 15 Apr 2024 10:33:03 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Justin Swartz <justin.swartz@risingedge.co.za>
Cc: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
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
Message-ID: <ZhzmPxVHjbbCJDJ7@alpha.franken.de>
References: <20240316045442.31469-1-justin.swartz@risingedge.co.za>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240316045442.31469-1-justin.swartz@risingedge.co.za>

On Sat, Mar 16, 2024 at 06:54:28AM +0200, Justin Swartz wrote:
> This set of patches was created with the intention of cleaning up
> arch/mips/boot/dts/ralink/mt7621.dtsi so that it is aligned with
> the Devicetree Sources (DTS) Coding Style [1] [2] guide.
> 
> [1] Documentation/devicetree/bindings/dts-coding-style.rst
> 
> [2] https://docs.kernel.org/devicetree/bindings/dts-coding-style.html 
> 
> Justin Swartz (14):
>   mips: dts: ralink: mt7621: reorder cpu node attributes
>   mips: dts: ralink: mt7621: reorder cpuintc node attributes
>   mips: dts: ralink: mt7621: reorder mmc regulator attributes
>   mips: dts: ralink: mt7621: reorder sysc node attributes
>   mips: dts: ralink: mt7621: reorder gpio node attributes
>   mips: dts: ralink: mt7621: reorder i2c node attributes
>   mips: dts: ralink: mt7621: reorder spi0 node attributes
>   mips: dts: ralink: mt7621: move pinctrl and sort its children
>   mips: dts: ralink: mt7621: reorder mmc node attributes
>   mips: dts: ralink: mt7621: reorder gic node attributes
>   mips: dts: ralink: mt7621: reorder ethernet node attributes and kids
>   mips: dts: ralink: mt7621: reorder pcie node attributes and children
>   mips: dts: ralink: mt7621: reorder pci?_phy attributes
>   mips: dts: ralink: mt7621: reorder the attributes of the root node
> 
>  arch/mips/boot/dts/ralink/mt7621.dtsi | 430 ++++++++++++++------------
>  1 file changed, 239 insertions(+), 191 deletions(-)

series applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

