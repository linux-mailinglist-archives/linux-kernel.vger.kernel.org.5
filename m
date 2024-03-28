Return-Path: <linux-kernel+bounces-123063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3704B8901A1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E162B1F24D09
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D83212F397;
	Thu, 28 Mar 2024 14:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RHUE3lO8"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA7112A157;
	Thu, 28 Mar 2024 14:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711635664; cv=none; b=rJ/d9wofLZku17Kk1hQPHyCYdvj2wy1NATn7s8O3aFe2YT3KLQrO0/u+6Aopd28NCRfJJPXlKQCSrINPW7AvWwmBJ2gz2r/Ymi1n0nFv1SK9eX9/1zwYV65W8guLG6cKveDgDTOMxobohRSHaUjI1JQyV6prLNxnNNvVYYFS2iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711635664; c=relaxed/simple;
	bh=JfRqZIJmC4PjPJChHR0VcjE2fBSwvEm7Ufw1q6CvlgU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QDUbV/tTXOSgqS7yfHRoXpDy/3r9jp92fPCtjsymmkPtJPEheKFqhGXn4kyAJOyrLyiV3+u/Sqerv8a7+/6e/YdgJUA6/bq+EIgoBeWwZeuk0VwLSDWiFF9KsJ/vsAvRTpdgNM801ENjfC2p6+ZFYMa867idK9sBfV7YEwmoKr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RHUE3lO8; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BE24BC0005;
	Thu, 28 Mar 2024 14:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711635653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JfRqZIJmC4PjPJChHR0VcjE2fBSwvEm7Ufw1q6CvlgU=;
	b=RHUE3lO8NtqEgRc3pjmj5y2bQA9xBIQMm9X2ZtXnFQA1dIekleMA6uXYAOllJWrfLVdOPP
	BCYGUxPetyp53sqdouL5ZtlcI+19d/z7BSVmn+ZR4iI7YfhUr8Ka9mbo/MdAX0BLlVNPBb
	EGRc3a8KGHoaZBGlWFuYe7PdUP7opIOVdCXqFzUeL+T9i0RFi/OOmx3OS2Npr1DkA+AJaw
	U36MGbbB9D5A7tNDwdZgu2UjdSa3sN7D5G8zKPMESdoo8uvPHsMqVKTpz0ISRY2n8y7D8W
	mXj/iQepjdQ0ZTL8qBk5rrXDYfws0JMVnUuNOSV+nZBkV/uQLXtQFIHWRxtZjw==
Date: Thu, 28 Mar 2024 15:20:46 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, Dent Project
 <dentproject@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>, Russell
 King <linux@armlinux.org.uk>, Conor Dooley <conor+dt@kernel.org>, Jakub
 Kicinski <kuba@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russ Weight <russ.weight@linux.dev>, "David S.
 Miller" <davem@davemloft.net>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Paolo Abeni <pabeni@redhat.com>, Mark Brown <broonie@kernel.org>,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, Eric Dumazet
 <edumazet@google.com>, Luis Chamberlain <mcgrof@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 11/17] dt-bindings: net: pse-pd: Add another
 way of describing several PSE PIs
Message-ID: <20240328152046.0b908024@kmaincent-XPS-13-7390>
In-Reply-To: <5230d786-44a8-45a0-ab0d-e1aa4ab6a836@lunn.ch>
References: <20240326-feature_poe-v6-0-c1011b6ea1cb@bootlin.com>
	<20240326-feature_poe-v6-11-c1011b6ea1cb@bootlin.com>
	<171146756753.2253156.218733720090104400.robh@kernel.org>
	<5230d786-44a8-45a0-ab0d-e1aa4ab6a836@lunn.ch>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Thu, 28 Mar 2024 13:32:09 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> On Tue, Mar 26, 2024 at 10:39:28AM -0500, Rob Herring wrote:
> >=20
> > On Tue, 26 Mar 2024 15:04:48 +0100, Kory Maincent wrote: =20
> > > From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> > >=20
> > > PSE PI setup may encompass multiple PSE controllers or auxiliary circ=
uits
> > > that collectively manage power delivery to one Ethernet port.
> > > Such configurations might support a range of PoE standards and require
> > > the capability to dynamically configure power delivery based on the
> > > operational mode (e.g., PoE2 versus PoE4) or specific requirements of
> > > connected devices. In these instances, a dedicated PSE PI node becomes
> > > essential for accurately documenting the system architecture. This no=
de
> > > would serve to detail the interactions between different PSE controll=
ers,
> > > the support for various PoE modes, and any additional logic required =
to
> > > coordinate power delivery across the network infrastructure.
> > >=20
> > > The old usage of "#pse-cells" is unsuficient as it carries only the P=
SE PI
> > > index information.
> > >=20
> > > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > > --- =20
> > My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_chec=
k'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >=20
> > yamllint warnings/errors:
> >=20
> > dtschema/dtc warnings/errors:
> >=20
> >=20
> > doc reference errors (make refcheckdocs):
> > Warning: Documentation/devicetree/bindings/net/pse-pd/pse-controller.ya=
ml
> > references a file that doesn't exist:
> > Documentation/networking/pse-pd/pse-pi.rst
> > Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml:
> > Documentation/networking/pse-pd/pse-pi.rst =20
>=20
> Is this a false positive?

I suppose so as the file is added in the patch 10.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

