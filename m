Return-Path: <linux-kernel+bounces-122891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AE388FF11
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47A29B24513
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C087EF17;
	Thu, 28 Mar 2024 12:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zg0hIRXJ"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84B38F72;
	Thu, 28 Mar 2024 12:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711629141; cv=none; b=Rk2CEuo1x5Ssv6Vk+2+C66NHbRBGLVv1K5F/SzAmiImmQPV7qCvUZivxkloRhBERgMYzUjAoC22XR5xnAytIR5HXr/ZMFliL8j5tAckoo0BKBFls/3ZJ15wXpVHL9siRXP+EJv96tRmx9pFiSXggoHIZi7NSldmyq9jarE11h74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711629141; c=relaxed/simple;
	bh=h3qsImq/RyQ/HpoR7a4GRGMkNu968dAdOACxo5Fz8kQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJLI3Dv2/CSLzhhSG/4Ti3y706R5py+dw3g1y0mmy2kRVjgzA9Sg2IPSUxvJSB0rUappl7Z1Ak8Sw4Yfczev8Lajy0Oh5hfZiozdxqHq8nNHTlnKZCM1DJ2rbK3fMthlFZQsjPpQdTCJNtNkC/5Xu0A934qVQ91kp7QpNXyzCBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zg0hIRXJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=00mLxt6VUg7/Q0nlQk3tLro0aY2aIMV8pnt3fdjOkbw=; b=zg0hIRXJWJgd5O4iVzZhz6lsa5
	8FZz0So/Kac9eFAN2Hw082FsCIB21nTcpks+hGRXqpLzQXbCf2Uvjyi3u78ozt7DS0egNTHPXVpTB
	TcQIr9+jzlAwnOKuv+2B2N12VJd6miojib+johTWNzWgTLKjaAfWRUmrw2xHMwhBYS3k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rpovR-00BUoL-12; Thu, 28 Mar 2024 13:32:09 +0100
Date: Thu, 28 Mar 2024 13:32:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Rob Herring <robh@kernel.org>
Cc: Kory Maincent <kory.maincent@bootlin.com>, devicetree@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Dent Project <dentproject@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Conor Dooley <conor+dt@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russ Weight <russ.weight@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>, Mark Brown <broonie@kernel.org>,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 11/17] dt-bindings: net: pse-pd: Add another
 way of describing several PSE PIs
Message-ID: <5230d786-44a8-45a0-ab0d-e1aa4ab6a836@lunn.ch>
References: <20240326-feature_poe-v6-0-c1011b6ea1cb@bootlin.com>
 <20240326-feature_poe-v6-11-c1011b6ea1cb@bootlin.com>
 <171146756753.2253156.218733720090104400.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171146756753.2253156.218733720090104400.robh@kernel.org>

On Tue, Mar 26, 2024 at 10:39:28AM -0500, Rob Herring wrote:
> 
> On Tue, 26 Mar 2024 15:04:48 +0100, Kory Maincent wrote:
> > From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> > 
> > PSE PI setup may encompass multiple PSE controllers or auxiliary circuits
> > that collectively manage power delivery to one Ethernet port.
> > Such configurations might support a range of PoE standards and require
> > the capability to dynamically configure power delivery based on the
> > operational mode (e.g., PoE2 versus PoE4) or specific requirements of
> > connected devices. In these instances, a dedicated PSE PI node becomes
> > essential for accurately documenting the system architecture. This node
> > would serve to detail the interactions between different PSE controllers,
> > the support for various PoE modes, and any additional logic required to
> > coordinate power delivery across the network infrastructure.
> > 
> > The old usage of "#pse-cells" is unsuficient as it carries only the PSE PI
> > index information.
> > 
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > ---
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> 
> 
> doc reference errors (make refcheckdocs):
> Warning: Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml references a file that doesn't exist: Documentation/networking/pse-pd/pse-pi.rst
> Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml: Documentation/networking/pse-pd/pse-pi.rst

Is this a false positive?

   Andrew

