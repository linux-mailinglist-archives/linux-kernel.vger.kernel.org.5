Return-Path: <linux-kernel+bounces-35991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA388399D5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BEDD290364
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3352182D87;
	Tue, 23 Jan 2024 19:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pschenker.ch header.i=@pschenker.ch header.b="T/2AMIqw"
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [45.157.188.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1A6823AE;
	Tue, 23 Jan 2024 19:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706039061; cv=none; b=Hl9O7f/Yqw/eSpiPlSDLU5qmGfMZViezLdQlIt5KC61Gx9ImTvvDmRalx2WvBRkdzWyCrFUpWJD2gP8kiRIGw9nbg4DoXMiB99vjkP+bf/rxp827hR7jGYXRCxRtUj2bNhAODPV7oe5pOWghG2WKuGUMgNjO/B0uKqzxb+zKfpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706039061; c=relaxed/simple;
	bh=wl5cqQcWfykVVJblgMlQOTH7snhU8fazVZAYDiv1i+4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FikCOcbR6njjAiaSutt6VF5CSxjaFBNgezZUX2H7ZBYOb92xsJ8LpeYbIpF6HYOHpQr9mrxg0W7a8BcCxwr2zJptPgii78gF65ATZCmUTPt8Dy5xXfLqcZ1bXs7O1PjhBaQr5lVlSfUE3tEFvmOhwu7GoGshgoHTI1ZI73jX/qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pschenker.ch; spf=pass smtp.mailfrom=pschenker.ch; dkim=pass (1024-bit key) header.d=pschenker.ch header.i=@pschenker.ch header.b=T/2AMIqw; arc=none smtp.client-ip=45.157.188.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pschenker.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pschenker.ch
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TKHbK2DftzMr2QW;
	Tue, 23 Jan 2024 20:44:13 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4TKHbJ0MFvz3b;
	Tue, 23 Jan 2024 20:44:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
	s=20220412; t=1706039053;
	bh=wl5cqQcWfykVVJblgMlQOTH7snhU8fazVZAYDiv1i+4=;
	h=Subject:From:Reply-To:To:Cc:Date:In-Reply-To:References:From;
	b=T/2AMIqwHzqN4SWaSS2PkqwluUZlfpZsXeGU7/6qHPr6ik3hmzYtDPlc1Zqmot1mS
	 fv70ViNQ1UiDjB/+DWv9HOk3eCLB0S/KWffHjYl9D2bmyZjM75yAuKFcFfWy+molC0
	 7qMbku6xa9/9Rqkwi/1wkiF5TP6KrMHI/kwZLV/A=
Message-ID: <1b5a20ce6e6332b7fad7b6af61a5548152ae19c9.camel@pschenker.ch>
Subject: Re: [PATCH net-next v1 1/2] dt-bindings: net: dsa: Add KSZ8567
 switch support
From: Philippe Schenker <dev@pschenker.ch>
Reply-To: dev@pschenker.ch
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
Date: Tue, 23 Jan 2024 20:44:11 +0100
In-Reply-To: <20240123-carpool-avatar-c1e51ab3cc32@spud>
References: <20240123135014.614858-1-dev@pschenker.ch>
	 <20240123-ripening-tabby-b97785375990@spud>
	 <b2e232de11cee47a5932fccc2d151a9c7c276784.camel@pschenker.ch>
	 <20240123-atlas-dart-7e955e7e24e5@spud>
	 <979b1e77b5bb62463d52e7b9d3f9ca1415f4006a.camel@pschenker.ch>
	 <20240123-carpool-avatar-c1e51ab3cc32@spud>
Autocrypt: addr=dev@pschenker.ch; prefer-encrypt=mutual;
 keydata=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
	7y2ACHIW8WQkD8EORcLp7+QKQh4NgSkg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Infomaniak-Routing: alpha

On Tue, 2024-01-23 at 18:37 +0000, Conor Dooley wrote:
> On Tue, Jan 23, 2024 at 06:30:16PM +0100, Philippe Schenker wrote:
> >=20
> >=20
> > On Tue, 2024-01-23 at 17:23 +0000, Conor Dooley wrote:
> > > On Tue, Jan 23, 2024 at 05:17:53PM +0100, Philippe Schenker wrote:
> > > >=20
> > > >=20
> > > > On Tue, 2024-01-23 at 16:06 +0000, Conor Dooley wrote:
> > > > > On Tue, Jan 23, 2024 at 02:50:13PM +0100, Philippe Schenker
> > > > > wrote:
> > > > > > From: Philippe Schenker <philippe.schenker@impulsing.ch>
> > > > > >=20
> > > > > > This commit adds the dt-binding for KSZ8567, a robust 7-port
> > > > > > Ethernet switch. The KSZ8567 features two RGMII/MII/RMII
> > > > > > interfaces,
> > > > > > each capable of gigabit speeds, complemented by five 10/100
> > > > > > Mbps
> > > > > > MAC/PHYs.
> > > > > >=20
> > > > > > Signed-off-by: Philippe Schenker
> > > > > > <philippe.schenker@impulsing.ch>
> > > > >=20
> > > > > This device has all the same constraints as the other ones in
> > > > > this
> > > > > binding, why is it not compatible with any of them? If it
> > > > > isn't,
> > > > > the
> > > > > compatible should mention why it is not.
> > > >=20
> > > > Hi Conor, Thanks for your message!
> > > >=20
> > > > I need the compatible to make sure the correct ID of the switch
> > > > is
> > > > being set in the driver as well as its features.
> > >=20
> > > Are the features of this switch such that a driver for another ksz
> > > switch would not work (even in a limited capacity) with the 8567?
> > > Things like the register map changing or some feature being
> > > removed
> > > are
> > > examples of why it may not work.
> >=20
> > Yes the ksz dsa driver is made so that it checks the ID of the
> > attached
> > chip and refuses to work if it doesn't match. [1]
>=20
> That sounds counter productive to be honest. Why does the driver not
> trust that the dt is correct? I saw this recently in some IIO drivers,
> but it was shot down for this sort of reason.
>=20
> > It is a very similar chip and uses the same regmap as KSZ9567 but
> > with
> > lower phy-speeds on its 5 switch ports. The two upstream CPU ports
> > are
> > gigabit capable. All this information is set-up in the second patch
> > of
> > this series. [2]
>=20
> That, to me, means the lack of a fallback is justified. If it were the
> other way around, then a fallback sounds like it would be suitable.

Yes, I believe a generic fallback would anyway mostly end up with errors
or misbehavior. But I also might be wrong. What I checked is that these
per-switch settings even increased from 5.15..6.7 which to me it seems
those are really needed.
I am no expert in this driver at all I just try to make my hardware work
and with these patches it now seems to switch really well.

>=20
> >=20
> > I will include a description to the second series. Thanks for your
> > feedback.
>=20
> Okay, thanks. You can add
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> when you do.
>=20
> And despite the email, I have nothing to do with these switches, I am
> just a sucker that signed up to review dt-bindings...

Well, I'm grateful for your review and feedback. Thanks for your work
around Linux kernel! And thanks for the Acked-by.

Philippe

>=20
> Thanks,
> Conor.
>=20
> >=20
> > Philippe
> >=20
> >=20
> > [1]
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/net/dsa/microchip/ksz_common.c?h=3Dv6.8-rc1#n3181
> > [2]
> > https://patchwork.kernel.org/project/netdevbpf/patch/20240123135014.614=
858-2-dev@pschenker.ch/
> >=20
> > >=20
> > > > You mean I shall mention the reason in the commit-message, or
> > > > where?
> > >=20
> > > Yes.
> > >=20
> > > Thanks,
> > > Conor
> > >=20
> > > > > > =C2=A0Documentation/devicetree/bindings/net/dsa/microchip,ksz.y=
am
> > > > > > l |
> > > > > > 1 +
> > > > > > =C2=A01 file changed, 1 insertion(+)
> > > > > >=20
> > > > > > diff --git
> > > > > > a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.ya
> > > > > > ml
> > > > > > b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.ya
> > > > > > ml
> > > > > > index c963dc09e8e1..52acc15ebcbf 100644
> > > > > > ---
> > > > > > a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.ya
> > > > > > ml
> > > > > > +++
> > > > > > b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.ya
> > > > > > ml
> > > > > > @@ -31,6 +31,7 @@ properties:
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - microchip,ksz9893
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - microchip,ksz9563
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - microchip,ksz8563
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - microchip,ksz8567
> > > > > > =C2=A0
> > > > > > =C2=A0=C2=A0 reset-gpios:
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 description:
> > > > > > --=20
> > > > > > 2.34.1
> > > > > >=20


