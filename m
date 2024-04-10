Return-Path: <linux-kernel+bounces-138346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A602989F000
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F677289257
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEA315921D;
	Wed, 10 Apr 2024 10:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJSundnX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B927C15B0F0;
	Wed, 10 Apr 2024 10:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712745465; cv=none; b=r0oBnxOc3KPkfRX/G6kIUN2OyIXD4e+fN/x5Z/882OiPg1QBkCAkbaafPcmtE1HeFxubqsiVeCE4t0RIAq5HRQ0YqcBU0gCKgEG2dc92TinlVBpNpd/jch/f7RFRHedKNaBb2E4tAXS5x5exA1kXqKhztf390vgh6Tym62Yt9PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712745465; c=relaxed/simple;
	bh=V6nc2YAKdgKWZHfMO2mdSMDfQwBidaZh7CVlmeQ/RdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPqEU1no1u6HmqPmcSMW30kNMeuokGmV3p6X0YtamkCIpGVO2E8/ytPmpCuOjz5gsnx3HvANvVX9Y7GJAnHLYLMN5JvxxisBlzdgjjSIYGTPQKB49dSHfbtrjfZWZdVom6f4WsDEofqz3xwiERduiHR2dI4acd4X0AENYo5sA0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJSundnX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71876C433F1;
	Wed, 10 Apr 2024 10:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712745465;
	bh=V6nc2YAKdgKWZHfMO2mdSMDfQwBidaZh7CVlmeQ/RdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GJSundnX+JygdMMTXQhsQvXdAUdTSBEnAWses4V2MkmKT6RU2v7u1bBHWViP4nhOV
	 hmRE6TrSpSr/OukV8DB98dCuiH3oV+7b1g94qsVe23pmwp83G8CqpK4BX0ZgaVCdZU
	 qwDUlnRnarHC/3Q0uMj/feOBJIprsLyHzP52RzrpwaMMMCsjUO/zd/+Qp8grH3GmWU
	 xCs+Z9JvsGIOFEKB/juDLMTu/pDe64Dg+CMCh48WceL1y1dO1Jf8DGySeDpyMYw8f8
	 jnzJYgMQABhIosVmdnijjnE8hzMWTWXlgy45WBSX+h2rcULdQ4yhEYl40BhK89tzws
	 v30JLUDt92KHw==
Date: Wed, 10 Apr 2024 18:24:18 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>,
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: sophgo: add initial Milk-V Duo S board
 device tree
Message-ID: <ZhZo0iJFSn1te-6d@xhacker>
References: <20240409064504.4010353-1-michael.opdenacker@bootlin.com>
 <IA1PR20MB49532A8D4294ADCE0C33A654BB072@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240409-prevent-deepness-2d22bf009b16@spud>
 <IA1PR20MB49534E00CAE29D24F7D7E718BB072@IA1PR20MB4953.namprd20.prod.outlook.com>
 <1514d28a-5e96-4531-a972-894e41902efa@bootlin.com>
 <IA1PR20MB4953CA04D33EA0C7902DFA3ABB062@IA1PR20MB4953.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <IA1PR20MB4953CA04D33EA0C7902DFA3ABB062@IA1PR20MB4953.namprd20.prod.outlook.com>

On Wed, Apr 10, 2024 at 09:24:40AM +0800, Inochi Amaoto wrote:
> On Tue, Apr 09, 2024 at 03:08:17PM +0200, Michael Opdenacker wrote:
> > Hi Inochi
> > 
> > On 4/9/24 at 14:27, Inochi Amaoto wrote:
> > > On Tue, Apr 09, 2024 at 01:13:32PM +0100, Conor Dooley wrote:
> > > > On Tue, Apr 09, 2024 at 03:17:35PM +0800, Inochi Amaoto wrote:
> > > > > On Tue, Apr 09, 2024 at 08:45:04AM +0200, michael.opdenacker@bootlin.com wrote:
> > > > > > From: Michael Opdenacker <michael.opdenacker@bootlin.com>
> > > > > > 
> > > > > > This adds initial support for the Milk-V Duo S board
> > > > > > (https://milkv.io/duo-s), enabling the serial port and
> > > > > > read-only SD card support, allowing to boot Linux to the
> > > > > > command line.
> > > > > > 
> > > > > Hi Michael,
> > > > > 
> > > > > I think your patch losts the board binding and have wrong compatiable.
> > > > > Also, the SD can have rw support with proper property. See link [1]
> > > > > (need 'disable-wp').
> > > > [1] doesn't go anywhere useful.
> > > > 
> > > This is my fault, I copied the wrong url. The right patch is
> > > https://lore.kernel.org/r/20240217144826.3944-1-jszhang@kernel.org.
> > 
> > 
> > No problem, I found out.
> > I confirm that using the "disable-wp;" property does the trick to make the
> > MMC writable.
> > 
> > However, it wasn't mentioned in the above URL...
> > 
> > By the way, do I really need those under &sdhci0?
> > 
> > + bus-width = <4>; + no-1-8-v; + no-mmc; + no-sdio;
> > 
> > My board looks happy so far without them ;-)

setting the correct bus-width is necessary for better performance
no-1-8-v can be removed, but it doesn't harm anything because
the board doesn't supply 1.8v

no-mmc and no-sdio to make the probe a bit quicker

> 
> FYI, Jisheng. Could you share some suggestions?
> 
> > Thanks again for your help
> > Cheers
> > Michael.
> > 
> > -- 
> > Michael Opdenacker, Bootlin
> > Embedded Linux and Kernel engineering
> > https://bootlin.com
> > 

