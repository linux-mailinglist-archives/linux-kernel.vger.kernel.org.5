Return-Path: <linux-kernel+bounces-147196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 481598A70D4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0307A2840EB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7072132C39;
	Tue, 16 Apr 2024 16:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GM4WQbf/"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C50131740;
	Tue, 16 Apr 2024 16:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713283352; cv=none; b=V9AqQcayQeCZdOsYsJQq3kY6VBsVH3S4Xz0E7obRQpzcgTbwzFwe2ebbWdOUgr2sJ7XG5M34/2Bv3Q/qgw1Sy3Uk5YTFBNLTXbinxO1Rqela0/6DrARgH+UKMl3U7CD1uDKzXE+ehUrCyktu5DDV6Qj8iJjEoWBLFdHAFOYQaqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713283352; c=relaxed/simple;
	bh=hCYaejWoX+jAPlE8/5kHoJpYp4YWRYoLhn+cUlzPdYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sDmD3qU9GEWQbeScbNvbw8gK9B9q3+yJJoENSfb9SMkElnpGRCqH+LmMLm/AFtTOjrVgAr4BP0Y7T8uJWptXA2xTVFvAN7RNGHcjYHR9ehes2OL2nzl7ADrKFJoZQtR6o9i922ICljDPb46bpLKX+YJUA8toogReFbWbF3GnTJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GM4WQbf/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=G5o05jTqo01zQ53H9jaSu+jx2p3uSn458GF7UnQPPOA=; b=GM4WQbf/ReowHtLEIc4K2fKQIF
	r4EzLuiLXad2eARmWlc0B8HxLrO2BmRWWgN5QBt2sS/xex/kFRGQb22LASn6JRZ5O++n1LV++1QU5
	MNMLNre4KKjl3h8h+alavWMYrAAm88OOQnobd99yRpFLB4XcKSwXwEFMQ88BqnoOHMko=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rwlG4-00D9gp-W4; Tue, 16 Apr 2024 18:02:08 +0200
Date: Tue, 16 Apr 2024 18:02:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	lxu@maxlinear.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
	michael@walle.cc, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] net: phy: mxl-gpy: add new device tree property
 to disable SGMII autoneg
Message-ID: <5ed39628-4ac0-4c4e-9a16-fd4bf9a6db29@lunn.ch>
References: <20240416121032.52108-1-eichest@gmail.com>
 <20240416121032.52108-3-eichest@gmail.com>
 <3f7f278f-e490-47f1-971c-ecf44a70cee4@lunn.ch>
 <Zh6clAtI3NO+nMEi@eichest-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh6clAtI3NO+nMEi@eichest-laptop>

On Tue, Apr 16, 2024 at 05:43:16PM +0200, Stefan Eichenberger wrote:
> Hi Andrew,
> 
> Thanks a lot for the feedback.
> 
> On Tue, Apr 16, 2024 at 03:46:19PM +0200, Andrew Lunn wrote:
> > On Tue, Apr 16, 2024 at 02:10:32PM +0200, Stefan Eichenberger wrote:
> > > Add a new device tree property to disable SGMII autonegotiation and
> > > instead use the option to match the SGMII speed to what was negotiated
> > > on the twisted pair interface (tpi).
> > 
> > Could you explain this is more detail.
> > 
> > SGMII always runs its clocks at 1000Mbps. The MAC needs to duplicate
> > the symbols 100 times when running at 10Mbs, and 10 times when running
> > at 100Mbps.
> 
> Currently, the mxl-gpy driver uses SGMII autonegotiation for 10 Mbps,
> 100 Mbps, and 1000 Mbps. For our Ethernet controller, which is on an
> Octeon TX2 SoC, this means that we have to enable "in-band-status" on
> the controller. This will work for all three speed settings. However, if
> we have a link partner that can do 2.5 Gbps, the mxl-gpy driver will
> disable SGMII autonegotiation in gpy_update_interface. This is not
> supported by this Ethernet controller because in-band-status is still
> enabled. Therefore, we will not be able to transfer data at 2.5 Gbps,
> the SGMII link will not go into a working state.

This is where i expect Russel to point out that SGMII does not support
2.5G. What you actually mean is that the PHY swaps to 2500BaseX. And
2500BaseX does not perform speed negotiation, since it only supports
2500. So you also need the MAC to swap to 2500BaseX.

I don't think any DT property is required here. This is fundamental to
SGMII only be 10/100/1G, and when you go above that, you swap to
something else.

Lets see what Russell patches do.

    Andrew

---
pw-bot: cr

