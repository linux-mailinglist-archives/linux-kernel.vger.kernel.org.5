Return-Path: <linux-kernel+bounces-35781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A860983966C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55C511F24FCE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F4F80041;
	Tue, 23 Jan 2024 17:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pschenker.ch header.i=@pschenker.ch header.b="r3GNIFzq"
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [185.125.25.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562F18002F;
	Tue, 23 Jan 2024 17:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706031024; cv=none; b=gjKSPK9DUnTVEpPhpbltAxgFKwwYHbzok8T31+3zz81WITtyROGgEcaUgvVcGRJjo9VxzDtWKH1smFR5xvnakBezFUdmucsBF0sQRW0VmpA5HVeG1AZ17o1lpiG/txzbeT6GdyT7qV65YDAu6zQ4IZXZiLd4vxP/qQjuul8P4gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706031024; c=relaxed/simple;
	bh=B/2hHzkuQ9wWcKUuhzt5SkH9HMMQlzQD5Ynkq/2Y300=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CpPS8NzItWI4eElOupUN3w3yZOzGUb9qh2276WjXfC96oJvPZbW88lXA64R6dm3Ah6DjLZOQxS7ND03lc12FA+tAoAteeLj11U0iMwtRUS1RROXcfQI3R1TRAnRY13f1VlNlCb98YEnxh1PMhCVXWc1hIa0CcRXc3/raEAnMXRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pschenker.ch; spf=pass smtp.mailfrom=pschenker.ch; dkim=pass (1024-bit key) header.d=pschenker.ch header.i=@pschenker.ch header.b=r3GNIFzq; arc=none smtp.client-ip=185.125.25.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pschenker.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pschenker.ch
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TKDcp0b5TzMpvNJ;
	Tue, 23 Jan 2024 18:30:18 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4TKDcn1hJ8z3Y;
	Tue, 23 Jan 2024 18:30:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
	s=20220412; t=1706031017;
	bh=B/2hHzkuQ9wWcKUuhzt5SkH9HMMQlzQD5Ynkq/2Y300=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=r3GNIFzq199rrRUz3Q+VVI9tMMH+D+WPkOabnP676ohv2UrLZHWP3jCISbXlvO5cX
	 S2VmIeRjmW1D4Bet8OaC1QJ38m9C9q2MngZ4Xh2ctki/PjbLEuA+mryQalTGWUvduc
	 K22L9YMggk5A/o3EywJ1O5Q6+c5VZ60ExwhACc5Q=
Message-ID: <979b1e77b5bb62463d52e7b9d3f9ca1415f4006a.camel@pschenker.ch>
Subject: Re: [PATCH net-next v1 1/2] dt-bindings: net: dsa: Add KSZ8567
 switch support
From: Philippe Schenker <dev@pschenker.ch>
To: Conor Dooley <conor@kernel.org>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Conor Dooley
 <conor+dt@kernel.org>, Woojung Huh <woojung.huh@microchip.com>, Vladimir
 Oltean <olteanv@gmail.com>, linux-kernel@vger.kernel.org,
 UNGLinuxDriver@microchip.com,  Marek Vasut <marex@denx.de>, Florian
 Fainelli <f.fainelli@gmail.com>, devicetree@vger.kernel.org, Eric Dumazet
 <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Jakub Kicinski
 <kuba@kernel.org>,  Andrew Lunn <andrew@lunn.ch>, Rob Herring
 <robh+dt@kernel.org>
Date: Tue, 23 Jan 2024 18:30:16 +0100
In-Reply-To: <20240123-atlas-dart-7e955e7e24e5@spud>
References: <20240123135014.614858-1-dev@pschenker.ch>
	 <20240123-ripening-tabby-b97785375990@spud>
	 <b2e232de11cee47a5932fccc2d151a9c7c276784.camel@pschenker.ch>
	 <20240123-atlas-dart-7e955e7e24e5@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Infomaniak-Routing: alpha



On Tue, 2024-01-23 at 17:23 +0000, Conor Dooley wrote:
> On Tue, Jan 23, 2024 at 05:17:53PM +0100, Philippe Schenker wrote:
> >=20
> >=20
> > On Tue, 2024-01-23 at 16:06 +0000, Conor Dooley wrote:
> > > On Tue, Jan 23, 2024 at 02:50:13PM +0100, Philippe Schenker
> > > wrote:
> > > > From: Philippe Schenker <philippe.schenker@impulsing.ch>
> > > >=20
> > > > This commit adds the dt-binding for KSZ8567, a robust 7-port
> > > > Ethernet switch. The KSZ8567 features two RGMII/MII/RMII
> > > > interfaces,
> > > > each capable of gigabit speeds, complemented by five 10/100
> > > > Mbps
> > > > MAC/PHYs.
> > > >=20
> > > > Signed-off-by: Philippe Schenker
> > > > <philippe.schenker@impulsing.ch>
> > >=20
> > > This device has all the same constraints as the other ones in
> > > this
> > > binding, why is it not compatible with any of them? If it isn't,
> > > the
> > > compatible should mention why it is not.
> >=20
> > Hi Conor, Thanks for your message!
> >=20
> > I need the compatible to make sure the correct ID of the switch is
> > being set in the driver as well as its features.
>=20
> Are the features of this switch such that a driver for another ksz
> switch would not work (even in a limited capacity) with the 8567?
> Things like the register map changing or some feature being removed
> are
> examples of why it may not work.

Yes the ksz dsa driver is made so that it checks the ID of the attached
chip and refuses to work if it doesn't match. [1]
It is a very similar chip and uses the same regmap as KSZ9567 but with
lower phy-speeds on its 5 switch ports. The two upstream CPU ports are
gigabit capable. All this information is set-up in the second patch of
this series. [2]

I will include a description to the second series. Thanks for your
feedback.

Philippe


[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/net/dsa/microchip/ksz_common.c?h=3Dv6.8-rc1#n3181
[2]
https://patchwork.kernel.org/project/netdevbpf/patch/20240123135014.614858-=
2-dev@pschenker.ch/

>=20
> > You mean I shall mention the reason in the commit-message, or
> > where?
>=20
> Yes.
>=20
> Thanks,
> Conor
>=20
> > > > =C2=A0Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml =
|
> > > > 1 +
> > > > =C2=A01 file changed, 1 insertion(+)
> > > >=20
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> > > > b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> > > > index c963dc09e8e1..52acc15ebcbf 100644
> > > > ---
> > > > a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> > > > +++
> > > > b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> > > > @@ -31,6 +31,7 @@ properties:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - microchip,ksz9893
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - microchip,ksz9563
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - microchip,ksz8563
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - microchip,ksz8567
> > > > =C2=A0
> > > > =C2=A0=C2=A0 reset-gpios:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 description:
> > > > --=20
> > > > 2.34.1
> > > >=20

