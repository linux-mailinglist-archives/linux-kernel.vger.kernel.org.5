Return-Path: <linux-kernel+bounces-150351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F07D48A9DC1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 908B91F21730
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF04616C6BA;
	Thu, 18 Apr 2024 14:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Fm81bzrF"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797D816ABD8;
	Thu, 18 Apr 2024 14:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713452275; cv=none; b=Lsn/k1SfuLi4FsuxTpL7Iqa/Gv7Nx3CpMY1psBwLUdM7YK6Q3AU5uiqapJERmjjTP3/u+1Hk5MaOgC9fIrMjeuborappdsE4JuNDdzGt69WuUI4ofnzMFxYDSqmnx6oP7GXdJHlpH8diuVhUXnlp0f8zZ/JPp1F4R1wP/yRcdOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713452275; c=relaxed/simple;
	bh=4U3WRbyCnOnkQnZ41bTWd65ADoYW1zIFR/LVWMvI3qU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZX5jwP1HpTtoAsHQ77BSyo+bVOBuB50+VqUasqYQmHSFoI+Vm1UsWHRbhWfq9yxD6jpYexuPsJX+9WvQVkFXW/Pl3feYiP78/8Ns6V3MthHQUzj458Y6U/MmuqYv324A0CM6FvFpXq6/5OVxsatyaaMLZSACd3y5fE91bWTpAKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Fm81bzrF; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 39E6DE0005;
	Thu, 18 Apr 2024 14:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713452269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=22V/9/vEJpEcidGLVhJgIB+KQKlIxyJ3KNXd2wPelig=;
	b=Fm81bzrFsXBTdoR/EZ94HL5ogTTkxn9LSc1bNL+ilg4qVmIXTG78tezLsusrXWZuur5xCc
	qw2fKRBfQK9qCvt09h033nk7SgBL/W6tasONuUi23vzQMP9KfkOvc45QLXi2xX/A1YGIgl
	gaFN6i0jZr9GrGsi1ebo/MrcOq5MNcimyVXmdbKapBkfI3C7zJe6dh76Yg1uaKl+n2NvZu
	0Ci4q01o+fo5UG17jZNhWmGtEsQuu58Qqyt4wWWPTOAoBwcxpdu3ZE7MtSE9jLEIhM1UkV
	vkKHqUjhFi5APEGMQxZ66yUj2vECc1tEuAznQqlYsq47JXhne5L4hR9vYMh6Jg==
Date: Thu, 18 Apr 2024 16:57:38 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Dent Project <dentproject@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, devicetree@vger.kernel.org, Conor
 Dooley <conor+dt@kernel.org>, kernel@pengutronix.de, "Rafael J. Wysocki"
 <rafael@kernel.org>, linux-doc@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Russell King <linux@armlinux.org.uk>, Russ
 Weight <russ.weight@linux.dev>, Jakub Kicinski <kuba@kernel.org>, Heiner
 Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Mark Brown
 <broonie@kernel.org>, Eric Dumazet <edumazet@google.com>, Frank Rowand
 <frowand.list@gmail.com>, Paolo Abeni <pabeni@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Jonathan Corbet <corbet@lwn.net>,
 netdev@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH net-next v9 08/14] dt-bindings: net: pse-pd: Add another
 way of describing several PSE PIs
Message-ID: <20240418165738.2443f1a6@kmaincent-XPS-13-7390>
In-Reply-To: <ZiDwz7_2nGzwVHy8@pengutronix.de>
References: <20240417-feature_poe-v9-0-242293fd1900@bootlin.com>
	<20240417-feature_poe-v9-8-242293fd1900@bootlin.com>
	<171336806575.2618779.157615998420721814.robh@kernel.org>
	<ZiDwz7_2nGzwVHy8@pengutronix.de>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Thu, 18 Apr 2024 12:07:11 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Hi Rob,
>=20
> On Wed, Apr 17, 2024 at 10:34:26AM -0500, Rob Herring wrote:
> > On Wed, 17 Apr 2024 16:39:56 +0200, Kory Maincent wrote: =20
> ....
> > > ---
> > >  .../bindings/net/pse-pd/pse-controller.yaml        | 101
> > > ++++++++++++++++++++- 1 file changed, 98 insertions(+), 3 deletions(-)
> > >  =20
> >=20
> > My bot found errors running 'make dt_binding_check' on your patch:
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
> Hm... this documentation was added by patch 7. I assume refcheckdocs
> is searching in the wrong place or should the path be relative?
>=20
> Is this warning a blocker for this patch set?

Yeah it is a false positive.
I don't think so. I assume maintainers time is the blockers for the patch
series to be accepted.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

