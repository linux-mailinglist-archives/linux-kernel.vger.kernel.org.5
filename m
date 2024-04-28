Return-Path: <linux-kernel+bounces-161461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4A38B4C41
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 16:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37F9528196B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 14:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC9F6D1C1;
	Sun, 28 Apr 2024 14:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GjY/AysB"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E25AD52;
	Sun, 28 Apr 2024 14:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714315739; cv=none; b=Nse+Z9yGSy4mONuEkHnbzTnGWcCsp1dZB1Pa0FK4JAWwSRMP0nPRE2SWPBk/L85CgThuzUbC/f4cnSh9DHwWdFcwrhbuMcItbFV4tmigY1yS6uBXHUwrCk/Ms1f/677MWqx3DTVlzZd4j6VNDq/72G2oHbQgI+NEAFxdt7Mn25w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714315739; c=relaxed/simple;
	bh=TwQA7/miNNOphY2D3FI8tBXZwUzrt3mN49X+VNAy1tA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJereALt65o2jsJNMwf8ggrwNsxaZj9xaVH4Q7ugo6rDAE8E0+KOlXVTIE1sBfpmbqjR/tX634QoohYS9aJP5BkaXIJ2PytjIgSOYyWkpDcc4bI9pn4n/A5EGilGm4OxrrEXJ2jwAO7ELv+xmf0YB9it8EG4gHlJ0RQt6cDL3kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GjY/AysB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=xqq21paJKP2+riMYLIjLYPLWIPBCPPYAVbbEQpB67Mg=; b=Gj
	Y/AysBpQW6z8Qb8hIUYe9BIu8ptnZKE/aFs2RjpMVx6H+3IW+JA74hS3uJr92JIqa/K8uulLDD9lK
	17hzYyijU6s5haNc0DJAJQkHjnUlyCERbSthBROv2NlN8TSYlrqE+twK3ilp/HJKIaF6FKaLKZJEa
	3DQvvwpUT2bzOlg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s15pa-00EBzI-9b; Sun, 28 Apr 2024 16:48:42 +0200
Date: Sun, 28 Apr 2024 16:48:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>
Cc: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net,
	linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, horatiu.vultur@microchip.com,
	ruanjinjie@huawei.com, steen.hegelund@microchip.com,
	vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, Pier.Beruto@onsemi.com,
	Selvamani.Rajagopal@onsemi.com, Nicolas.Ferre@microchip.com,
	benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v4 05/12] net: ethernet: oa_tc6: implement error
 interrupts unmasking
Message-ID: <4ea06ce4-d1df-49ea-8667-1f43dac7e747@lunn.ch>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-6-Parthiban.Veerasooran@microchip.com>
 <Zi1Xbz7ARLm3HkqW@builder>
 <77d7d190-0847-4dc9-8fc5-4e33308ce7c8@lunn.ch>
 <Zi10QS6UGGaNVRaB@builder>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zi10QS6UGGaNVRaB@builder>

On Sat, Apr 27, 2024 at 11:55:13PM +0200, Ramón Nordin Rodriguez wrote:
> > How fast is your SPI bus? Faster than the link speed? Or slower?
> > 
> > It could be different behaviour is needed depending on the SPI bus
> > speed. If the SPI bus is faster than the link speed, by some margin,
> > the receiver buffer should not overflow, since the CPU can empty the
> > buffer faster than it fills.
> 
> I'm running at 25MHz, I'm guessing that should translate to fast enough
> for the 10MBit half duplex link.
> But I'm not sure how the spi clock translates to bps here.

That seems plenty fast. Maybe you can get a bus pirate or similar
sniffing the bus. Maybe there are big gaps between the transfers for
some reason? Or the interrupt controller is very slow?

> I'm guessing you are right and that the others actually would be
> meningful to log.
> There is a nested question here as well, and that is wheter to keep or
> drop the code that drops the rx buffer on overflow interrupt.
> I think not dropping the full buffer could be one of the reasons for the
> perf change.

You need to look careful at what a buffer overflow means, as written
in the standard. Does it mean a chunk has been dropped from the frame
currently being transferred over the SPI bus? If so, you need to drop
the frame, because it is missing 64 bytes somewhere. That could happen
if the device has very minimal buffering and does cut through. So the
frame goes straight to the SPI bus while it is still being received
from the line. Or the device could have sufficient buffers to hold a
few full frames. It has run out of such buffers while receiving, and
so dropped the frame. You never see that frame over SPI because it has
already been discarded. If so, linux should not be dropping anything,
the device already has.

Given your 25Mhz bus speed, i think there at least two things wrong
here. Dropping frames is too noise, and potentially doing it wrong. I
also think there is something not optimal in your SPI master, because
25MHz should not have trouble with 10Mbps line speed.

	Andrew

