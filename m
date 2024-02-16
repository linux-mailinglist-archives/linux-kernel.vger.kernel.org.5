Return-Path: <linux-kernel+bounces-68284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C943857831
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 341011C213B5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219441B947;
	Fri, 16 Feb 2024 08:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SJODTM/N"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E421BC3E;
	Fri, 16 Feb 2024 08:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708073784; cv=none; b=cLcp7OFHW6ug6S7X6gknSK9mqI2Eu8w7U2xZS2vhavOCcFoM/IMMbnMe2Sj6l/mIEraonTwRAfFCVrYKSIxbKFBzfG4+Htofju33Jd2afnI2bN7scfCKez9S4TDIqwjbrV17+cT6t40LDbDNk9gp2t4oYRmhH6GaDlIyc/ZNINg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708073784; c=relaxed/simple;
	bh=FL28FnfDmBq1BCaoCs/X/JHQJ1bEbFj60rIGNvUcKWk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C0/ABAuYbsi09TuaKdZeBg4h2R5H5IEGjoxMuovvM6tDgQJ3dO5TVp80sR89yhaMWLlVNUZo/0aXA4GJBfJPz9fvFyzhHXfAEDBYjEn2tP6BzrLYuru5bD5fd7LJV+UaBdcSTsVp/IqyBWTF8/mfT4Hyj5jEHKPxNXUzVXNSXSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SJODTM/N; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E326F20002;
	Fri, 16 Feb 2024 08:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708073779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AuAEb8d/CugVhChQMJaD1N3FjnSqJYmQ5HtY9oyL3k8=;
	b=SJODTM/NlhYT74EjZYhqVw5f0bd9Ad3L1u87aefNbA6pDoCQWb6fK6MgyoWPzxrhljRq2m
	/9eGp0CCIGeyWoq7jujVwgN9iep6bCEnSx0liFdpHVOG9G00ayQS2fRlrfmTif95Lm5lIv
	RLVVF/5p4Qfx01zdCZuK9sa3baHqw055qSq8HH/1VJYpsDua02dy7CinvBHJ1tgixMewfA
	k5GruVkQkplJesn8zQ+fR6JS1gR7W8OoSFhyHKo6s7MFx/hLvcRDxPYZYUYZs8hM4ua83D
	2DZdB2DBB1NbKcmfJZ2AH6QNvBGVOhVYuZ2JTmLGAxmSBLJ54or6Jn9kUYj4xQ==
Date: Fri, 16 Feb 2024 09:56:16 +0100
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Rob Herring <robh@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Luis Chamberlain
 <mcgrof@kernel.org>, "David S. Miller" <davem@davemloft.net>, Jonathan
 Corbet <corbet@lwn.net>, netdev@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Russell King <linux@armlinux.org.uk>,
 devicetree@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Dent Project
 <dentproject@linuxfoundation.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Frank Rowand <frowand.list@gmail.com>, Mark Brown <broonie@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Russ Weight
 <russ.weight@linux.dev>, Eric Dumazet <edumazet@google.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Jakub Kicinski
 <kuba@kernel.org>
Subject: Re: [PATCH net-next v4 11/17] dt-bindings: net: pse-pd: Add another
 way of describing several PSE PIs
Message-ID: <20240216095616.3300aef3@kmaincent-XPS-13-7390>
In-Reply-To: <170802277529.323906.8697693998570251856.robh@kernel.org>
References: <20240215-feature_poe-v4-0-35bb4c23266c@bootlin.com>
	<20240215-feature_poe-v4-11-35bb4c23266c@bootlin.com>
	<170802277529.323906.8697693998570251856.robh@kernel.org>
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

On Thu, 15 Feb 2024 12:46:16 -0600
Rob Herring <robh@kernel.org> wrote:

> On Thu, 15 Feb 2024 17:02:52 +0100, Kory Maincent wrote:
> > PSE PI setup may encompass multiple PSE controllers or auxiliary circui=
ts
> > that collectively manage power delivery to one Ethernet port.
> > Such configurations might support a range of PoE standards and require
> > the capability to dynamically configure power delivery based on the
> > operational mode (e.g., PoE2 versus PoE4) or specific requirements of
> > connected devices. In these instances, a dedicated PSE PI node becomes
> > essential for accurately documenting the system architecture. This node
> > would serve to detail the interactions between different PSE controller=
s,
> > the support for various PoE modes, and any additional logic required to
> > coordinate power delivery across the network infrastructure.
> >=20
> > The old usage of "#pse-cells" is unsuficient as it carries only the PSE=
 PI
> > index information.
> >=20
> > This patch is sponsored by Dent Project <dentproject@linuxfoundation.or=
g>.
> >=20
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > ---
> >=20
> > Changes in v3:
> > - New patch
> >=20
> > Changes in v4:
> > - Remove $def
> > - Fix pairset-names item list
> > - Upgrade few properties description
> > - Update the commit message
> > ---
> >  .../bindings/net/pse-pd/pse-controller.yaml        | 84
> > +++++++++++++++++++++- 1 file changed, 81 insertions(+), 3 deletions(-)
> >  =20
>=20
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):

Weird, I don't get your errors even with dt-schema up to date.
Maybe I have version mismatch in other tools.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

