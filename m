Return-Path: <linux-kernel+bounces-67042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4377185653E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D59D01F27F94
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AC7131E33;
	Thu, 15 Feb 2024 14:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZyS54oNG"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24B8132465;
	Thu, 15 Feb 2024 14:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708005687; cv=none; b=SR7YH6paNZ7gURNmVF2RNV7430MUolB4Yn2SRzgj6sWso+FBp1m4jr6YBaYxbIQA75ch5qmRZdObQZq2nOXdmbaSrfQ8Wg5h/cL+sN3MeYVymg/TCROFY3KH/mRT2ntC4+A7iSpl7kyhTWPf09b9gR1NbO8QHVuho7RoMczRmUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708005687; c=relaxed/simple;
	bh=c2eWBTlGEu9aq8CNMf8XJPB074jKqxTWK1kHhQIMRO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQFserFwkCawxqSeJXnKGED5hXeNGBchV0gAj//N/yVTHJmWU1UjmdQ5zZI23cx22p1bCNydCFhHl9T3k02e4FY3Uw49S3RpuRlbkWiDepSEXSzM5c5SRpES5Ti780fF1GyG4KClsg91iVLBf9Y3bdEWYUe04b/dc4KfSJV5IoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZyS54oNG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MP9f/rVbWc8Azf9/HkrCVr+0l2iPqEASnSuI5i7emHY=; b=ZyS54oNGsIqe8TzktlKcR2hpmc
	MEbR/UxclHNRt8HBD+OmD7bDrFwl4xHuDhk2bJ5bWi/2VhGoiIBIV4X4XmsjkNqTQDBzh8S51v0lb
	wwSMjPqthOfWWBRPbTdLvn7cmDXCoKs+jxg0JrzyOR9igsq5/hk/3TS8MIwXucDdgTIg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1racIW-007tXM-Sv; Thu, 15 Feb 2024 15:01:08 +0100
Date: Thu, 15 Feb 2024 15:01:08 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Rob Herring <robh@kernel.org>
Cc: =?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Mark Brown <broonie@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v3 10/17] dt-bindings: net: pse-pd: Add another
 way of describing several PSE PIs
Message-ID: <377d2e0f-dc0c-400f-9c10-f4a158146ceb@lunn.ch>
References: <20240208-feature_poe-v3-0-531d2674469e@bootlin.com>
 <20240208-feature_poe-v3-10-531d2674469e@bootlin.com>
 <20240209144349.GA3678044-robh@kernel.org>
 <20240214141310.119364c4@kmaincent-XPS-13-7390>
 <20240214164150.5be591d0@kmaincent-XPS-13-7390>
 <20240215135130.GA4139246-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215135130.GA4139246-robh@kernel.org>

> > Not so much used indeed:
> > $ git log --grep="Sponsored" | grep Sponsored     
> >     Sponsored by:  The FreeBSD Foundation
> >     Sponsored by:  The FreeBSD Foundation
> >     Sponsored by:  The FreeBSD Foundation
> >     Sponsored by:  The FreeBSD Foundation
> >     Sponsored-by: Google Chromium project
> >     Sponsored: Google ChromeOS
> >     Sponsored: Google ChromeOS
> > 
> > Is it ok to keep it?
> 
> IMO, its use should be documented like other tags, or it should not be 
> used. Just write a sentence to the same effect.

Or include a patch to document it :-)

   Andrew

