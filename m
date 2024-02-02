Return-Path: <linux-kernel+bounces-49042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66964846538
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E959DB23ADF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 01:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C850863BA;
	Fri,  2 Feb 2024 01:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dGjiB7bY"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6397EAD4F;
	Fri,  2 Feb 2024 01:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706835775; cv=none; b=JVO2MNZxPPiXCDSAJzdN3CQQwP81sI1mBwsT6BJe/uvnypom6zZuxWYdDF78VD6T3skHu8oAr0wumz7H+/IKXxXbTdGOOstwuwIOenu9VSgIsgY1Zyxv+OvsHMUsZ+ScnBgOQUz6A/9kZ1Tf6tBAsnZWHOjf/p96Ihkq7VnhyZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706835775; c=relaxed/simple;
	bh=t7fqNukb58DPR2uH9r6sePm8zu2FpuOah650ZPEwo7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6AOXqrfYgTt/L4T4xlopJ9sJVNdaTGHo2hb6IpdoF6cFuGRp+C2n8bAf+mXkzj5G1jm2yhvysWCC1FJuCpfxDU4c+PVzLuxCYvl5l8I/Nir1Z780DXqlh8tEwWJXHnf6z96gez0b9j5HaKjo/56N5DGCZL+Yf5CuXViVQPzxXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dGjiB7bY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SRwLFjr2kgHxYJ1y6JChlTLnAQdKVct1/aWOL5U9V1E=; b=dGjiB7bYGz73GOemZdRIpMdldZ
	fjwWY0MERslapOKspJ8e7S3E+cKy0xPZ8YR5/KAbl+E3TlvK80b9Oy5wiGXajZDDh7tY6U8mnzJGO
	QtpI7PeFasregV25OhbVn5v29t2nA8HqVbCHXusiGm201hkk/yRBTAzs6Pw170EHBSmE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rVhx3-006jdz-Ce; Fri, 02 Feb 2024 02:02:41 +0100
Date: Fri, 2 Feb 2024 02:02:41 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Antoine Tenart <atenart@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Frank Rowand <frowand.list@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
	Robert Marko <robert.marko@sartura.hr>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [net-next PATCH v5 2/9] net: phy: add support for scanning PHY
 in PHY packages nodes
Message-ID: <2bba44dc-b5df-46ef-b5f3-eabbd34aa7db@lunn.ch>
References: <20240201151747.7524-1-ansuelsmth@gmail.com>
 <20240201151747.7524-3-ansuelsmth@gmail.com>
 <170680473689.4979.1991415008659281513@kwain>
 <65bbd2ce.050a0220.5ff09.69d5@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65bbd2ce.050a0220.5ff09.69d5@mx.google.com>

On Thu, Feb 01, 2024 at 06:20:10PM +0100, Christian Marangi wrote:
> On Thu, Feb 01, 2024 at 05:25:36PM +0100, Antoine Tenart wrote:
> > Quoting Christian Marangi (2024-02-01 16:17:28)
> > > 
> > > +static int __of_mdiobus_parse_phys(struct mii_bus *mdio, struct device_node *np,
> > > +                                  int base_addr, bool *scanphys)
> > > +{
> > > +       struct device_node *child;
> > > +       int addr, rc = 0;
> > > +
> > > +       /* Loop over the child nodes and register a phy_device for each phy */
> > > +       for_each_available_child_of_node(np, child) {
> > > +               if (of_node_name_eq(child, "ethernet-phy-package")) {
> > > +                       rc = of_property_read_u32(child, "reg", &addr);
> > > +                       if (rc)
> > > +                               goto exit;
> > 
> > This means a PHY package node w/o a reg property will prevent all other
> > PHYs in the same parent node to be found?
> >
> 
> Since this is something new, would it be a problem to make it mandatory
> to define a reg? (And return error if we find something? Or print a
> warn?)

Making reg mandatory within a package is reasonable. Please indicate
this in the DT schema.

     Andrew

