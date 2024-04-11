Return-Path: <linux-kernel+bounces-141169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA848A1ACF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D8A51C22377
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0891F5917;
	Thu, 11 Apr 2024 15:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzu3g4H8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54661F4FD5;
	Thu, 11 Apr 2024 15:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850151; cv=none; b=DipSc2+zjdhiWpDKrp1/I0VbExWchs0oMULluqdoaa8W8O4qihD29bnVBKRvxu2np3MY3YGz8cSlg/72Mpjn8Fo5GM4RBYkavVzcC2XHikPI7r3HD/mBPTxcJjYRkbews6x6u+yUb1677Dufha6GX9CIo1lwjgoa6I1a1s15l/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850151; c=relaxed/simple;
	bh=+nZnGEmZrNB3s5CE4OLicwn7PuejwQracpvWJM0WbEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nuERQU9EIUG7gRHwWrLXRupJm6P4G9ORhr/vctC3dVtmVbFUwqKgukyjr6N+X0aPbnsFsxBDuiBrdJSYOXVKVVvztFtLksimBEeX/ZWH0fwRoxZsPhADJPFG3bofcKLTebo9MSxKeWB23PlKA7lfzIcu1+9GAymZ2qFVFodiPq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzu3g4H8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20728C072AA;
	Thu, 11 Apr 2024 15:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712850150;
	bh=+nZnGEmZrNB3s5CE4OLicwn7PuejwQracpvWJM0WbEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jzu3g4H8bnBM0ZLCtVvhes9KXW6ycau1nmlbhhYlXWT2j0ilPWJ/qM0/B/a3giiCh
	 roAK28frU9Qv9qSJJRQOzNv1QB9xbjjrAoK3Ov1REgGCsEkfS6hg/yNltpusDo4GhM
	 ZoHORWasJM9lg7DYIeXNzLCn1IEJIs7yu49wSTfNf5cPQNOQeLG0JVagQyanMueyCg
	 G8JYW/aCJr3R6nm6kX+J1N3qHvaAK+Qk1KHpu6o4j6qwpt2wbDfPfA1OOJ7PfC5TUw
	 TdodwJdFigXYmcZSSiJG13GWlBiyOqhhMaRO/6mgBqgwpEmVioA+tHKb1770XIOjuP
	 u7TN4Lyvn8V8A==
Date: Thu, 11 Apr 2024 16:42:24 +0100
From: Conor Dooley <conor@kernel.org>
To: Alban Browaeys <alban.browaeys@gmail.com>
Cc: dev@folker-schwesinger.de, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Chris Ruehl <chris.ruehl@gtsys.com.hk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christopher Obbard <chris.obbard@collabora.com>,
	Doug Anderson <dianders@chromium.org>,
	Brian Norris <briannorris@chromium.org>,
	Jensen Huang <jensenhuang@friendlyarm.com>,
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] phy: rockchip: emmc: Enable pulldown for strobe line
Message-ID: <20240411-mushily-pucker-732583c1d340@spud>
References: <20240326-rk-default-enable-strobe-pulldown-v1-0-f410c71605c0@folker-schwesinger.de>
 <20240326-rk-default-enable-strobe-pulldown-v1-1-f410c71605c0@folker-schwesinger.de>
 <20240326-tactical-onlooker-3df8d2352dc2@spud>
 <871f0b24a38208d9c5d6abc87d83b067162c103e.camel@gmail.com>
 <20240328-unnatural-unsorted-e53a13f5e87e@spud>
 <313d5a24b6cffa1a9160e624bb6855aa7f66589e.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aLBybTFZShsDA3p/"
Content-Disposition: inline
In-Reply-To: <313d5a24b6cffa1a9160e624bb6855aa7f66589e.camel@gmail.com>


--aLBybTFZShsDA3p/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 08:28:57PM +0200, Alban Browaeys wrote:
> Le jeudi 28 mars 2024 =E0 18:01 +0000, Conor Dooley a =E9crit=A0:
> > On Thu, Mar 28, 2024 at 06:00:03PM +0100, Alban Browaeys wrote:
> > > Le mardi 26 mars 2024 =E0 19:46 +0000, Conor Dooley a =E9crit=A0:
> > > > On Tue, Mar 26, 2024 at 07:54:35PM +0100, Folker Schwesinger via
> > > > B4
> > > > Relay wrote:
> > > > > From: Folker Schwesinger <dev@folker-schwesinger.de>
> > > > > -	if (of_property_read_bool(dev->of_node,
> > > > > "rockchip,enable-
> > > > > strobe-pulldown"))
> > > > > -		rk_phy->enable_strobe_pulldown =3D
> > > > > PHYCTRL_REN_STRB_ENABLE;
> > > > > +	if (of_property_read_bool(dev->of_node,
> > > > > "rockchip,disable-
> > > > > strobe-pulldown"))
> > > > > +		rk_phy->enable_strobe_pulldown =3D
> > > > > PHYCTRL_REN_STRB_DISABLE;
> > > >=20
> > > > Unfortunately you cannot do this.
> > > > Previously no property at all meant disabled and a property was
> > > > required
> > > > to enable it. With this change the absence of a property means
> > > > that
> > > > it
> > > > will be enabled.
> > > > An old devicetree is that wanted this to be disabled would have
> > > > no
> > > > property and will now end up with it enabled. This is an ABI
> > > > break
> > > > and is
> > > > clearly not backwards compatible, that's a NAK unless it is
> > > > demonstrable
> > > > that noone actually wants to disable it at all.
> > >=20
> > >=20
> > > But the patch that introduced the new default to disable the
> > > pulldown
> > > explicitely introduced a regression for at least 4 boards.
> > > It took time to sort out that the default to disable pulldown was
> > > the
> > > culprit but still.
> > > Will we carry this new behavor that breaks the default design for
> > > rk3399 because since the regression was introduced new board
> > > definition
> > > might have expceted this new behavior.
> > >=20
> > > Could the best option be to revert to =E9not set a default
> > > enable/disable
> > > pulldown" (as before the commit that introduced the regression) and
> > > allow one to force the pulldown via the enable/disable pulldown
> > > property?
> > > I mean the commit that introduced a default value for the pulldown
> > > did
> > > not seem to be about fixing anything. But it broke a lot. ANd it
> > > was
> > > really really hard to find the description of this commit to
> > > understand
> > > that one had to enable pulldown to restore hs400.
> > >=20
> > > In more than 3 years, only one board maintainer noticed that this
> > > property was required to get back HS400=A0 and thanks to a user
> > > telling
> > > me that this board was working I found from this board that this
> > > property was "missing" from most board definitions (while it was
> > > not
> > > required before).
> > >=20
> > >=20
> > > I am all for not breaking ABI. But what about not reverting a patch
> > > that already broke ABI because this patch introduced a new ABI that
> > > we
> > > don't want to break?
> > > I mean shouldn't a new commit with a new ABI that regressed the
> > > kernel
> > > be reverted?
> >=20
> > I think I said it after OP replied to me yesterday, but this is a
> > pretty
> > shitty situation in that the original default picked for the property
> > was actually incorrect. Given it's been like this for four years
> > before
> > anyone noticed, and others probably depend on the current behaviour,
> > that's hard to justify.
> >=20
>=20
> A lot of people noticed fast that HS400 was broken in the 5.10 branch
> but due to another commit (more later, ie double regulator init that
> messed up emmc) this second breakage was not detected. But mostly
> downstream. And most if not all rk3399 boards in Armbian had HS400
> disabled.
>=20
>=20
> It took 3 years to detect that HS400 was broken on a few boards like
> Rock Pi4 in the upstream kernel. Any might still be broken.
> I would not count on the fact that keeping the current behavior equals
> no more broken boards.
>=20
> From the previous exchanges the boards that requires the pulldown to be
> disabled seems well known.
>=20
> Though I am fine with adding a property to set enable pulldown to any
> board definition file where that is required.
>=20
> Only I do not believe keeping the statu quo equal everything works
> because it has been 3 years.

FWIW, I didn't say this. Clearly if that was the case, this patch would
never have arrived.

> In fact this commit reached the downstream kernels way later. Any
> stayed with the 5.10 branch for years.
>=20
> But on the other side the disable pulldown by default is alraedy in
> stable/linux-rolling-lts .
>=20
> > > Mind fixing the initial regression 8b5c2b45b8f0 "phy: rockchip: set
> > > pulldown for strobe line in dts" does not necessarily mean changing
> > > the
> > > default to the opposite value but could also be reverting to not
> > > setting a default.
> >=20
> > That's also problematic, as the only way to do this is make setting
> > one of the enabled or disabled properties required, which is also an
> > ABI
> > break, since you'd then be rejecting probe if one is not present.
>=20
>=20
> I don't understand.
> How reverting to not set either pulldown enabled or disabled by default
> force all board to set either enabled or disabled.
> I was telling about making the pulldown set by kernel optional be it
> enabled or disabled to revert to the previous behavior.=20
>=20
> I mean before the patch to set a default pulldown value (to disabled)
> there were no forced value.

Ah, maybe I misunderstood what the code originally did. Did the original
code leave the bit however the bootloader or reset value had left it?
In that case, probe wouldn't be rejected and you'd not have the sort of
issue that I mentioned above.

> > > Though I don't know if there are pros to setting a default.
> >=20
> > What you probably have to weigh up is the cons of each side. If what
> > you
> > lose is HS400 mode with what's in the kernel right now but switching
> > to
> > what's been proposed would entirely break some boards, I know which
> > I think the lesser of two evils is.
>=20
> More boards (even if not the most wide spread it seems) are broken by
> the current behavior.
>=20
> I agree that only HS400 is broken by keeping the status quo. But as far
> as I understand only HS400 will be broken either way.
> Be that by keeping the current disable pulldown which break the boards
> based on the rockchip default design or the boards that are non-
> standard or have a broken design.
> Both case this lead to data corruption on boot to eMMC.
>=20
> The only pro of keeping the current value the default is that most
> board broken by the new default introduced in 2020 "might" already be
> fixed (but that is just a guess).
>=20
> > It's probably up to the platform maintainer to weigh in at this
> > point.
>=20
> I am not knowledged into the delegation scope. You mean that from now
> on it is up to the rockchip maintainer?
> I am fine with it either way.

Yes, I meant the rockchip maintainer. I'm only a lowly bindings
maintainer, without any knowledge of rockchip specfics or the type of
boards we're talking about being broken here. Someone has to make a
judgement call about which "no property" behaviour is used going forward
and I don't want that to be me!

> I just wanted to point out that maybe we don't have to set a pulldown
> value after all. And that then all boards will be fine as before
> setting the pulldown explicitly was introduced.

By "all boards will be fine" you mean "all boards that expected the
kernel didn't touch this bit will be fine". The boards that need the
kernel to set this bit because it {comes out of reset,is set by firmware}
incorrectly are going to need a property added if we revert the default
behaviour to not touching the bit.

> In fact I am more eager to get this fixed be it by adding a enable-
> pulldown property to the board definitions, than to change the current
> behavior.
> Just wanted to sort out if that was not the wrong way to fix this
> issue. (ie if adding a setting on most boards was wrong).

> During more than 2 years, I tried various patches and discussed on
> forums about the HS400 breakage. I had bisected the regulator init
> issue in the 5.10 branch. Sadly it took so much time for this issue to
> be understood that when the force pulldown to disable commit was
> introduced downstream before the first issue go fixed.
> This only made the matter worse because when one fixed the double
> regulator init issue HS400 was still broken, this time because the
> pulldown was forced to disable. But nobody noticed this commit that
> forced a default pulldown state (that was older than the regulator
> commit from 5.13 backported to the 5.10 stable branch commit, but that
> reached downstream later due to not having been backported to 5.10 from
> 5.11).
> Otherwise we would have emailed immeditaly.
> Bisecting was only able to catch the first breakage (as it was only
> fixed after the second breakage was introduced).
>=20
> Maybe the problem is that me and others did not complained to the
> kernel upstream ML because we were using heavily patched downstream
> kernels (like most if not all downstream ARM kernels). So sadly, the
> forums from back then are filled with complaints but nothing seemed to
> have reached the Linux ML.

Aye, and all I can really say there is to buy boards from a vendor that
doesn't use some horribly hacked downstream kernel, which I know is
clearly an unsatisfactory suggestion. That said, we probably should have
caught that the new default behaviour when the changes were made was not
the default before. There was only one DT maintainer then though, and
things just slip by :/

--aLBybTFZShsDA3p/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhgE4AAKCRB4tDGHoIJi
0vZnAP0TIt845yAiy0oBXp77jO++qGtE1WNNLRxIX6CYf3M/3QEAgrVA1XfZbrbH
qEbevdZeVvM96FmZexF+UTJAHmwC2wo=
=AiwS
-----END PGP SIGNATURE-----

--aLBybTFZShsDA3p/--

