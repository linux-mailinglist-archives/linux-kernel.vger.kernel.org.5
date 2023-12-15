Return-Path: <linux-kernel+bounces-623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4E18143B2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBA101C2267D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD58171C1;
	Fri, 15 Dec 2023 08:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQZdR34U"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84EC168B7;
	Fri, 15 Dec 2023 08:34:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F6FC433C9;
	Fri, 15 Dec 2023 08:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702629245;
	bh=rss/R2yr8u3xOa9j+hUBTknCPEWH5RN5Y0uY7UIDmog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cQZdR34UJ/BTJ7VG/KfJZNszJHl9kgkTwTsZp5FVTai07fg3xqRGfN3856pAsbtpk
	 NgiI4h16ZpxpV7UwaEbOlJfwOCFTHAGN7p8U3HtimC84vbx8ymhwEmUTxmHiKx+Olv
	 ghfAY7z3JY0SDklpjDZB0qKz7KaSH1fCtV5ZvExyKcpe23j/D6q/lt/SVmyzUpg+7V
	 xvwRtgHO4wheC8ypj2ApkwfMt1qwoAObp5Ekh0GPQ7Bc5BifIsBM0P1LFFC00UbRBe
	 WQFj0jdMOZRf4DlvwI481Cs+CduR38zEm/88DObRH1+Uu3cV/BfDyDgecBbeZmO1Jp
	 EpZxaFYf+kexg==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rE3dw-0007LZ-1w;
	Fri, 15 Dec 2023 09:34:00 +0100
Date: Fri, 15 Dec 2023 09:34:00 +0100
From: Johan Hovold <johan@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] gnss: ubx: support the reset pin of the Neo-M8
 variant
Message-ID: <ZXwPeJFdEERbhj3b@hovoldconsulting.com>
References: <20231113005152.10656-1-wsa+renesas@sang-engineering.com>
 <ZXfTwscAltoVY1lV@shikoro>
 <ZXsk4i/OTGFhiCk9@shikoro>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jMxtUNg6do9ROjXB"
Content-Disposition: inline
In-Reply-To: <ZXsk4i/OTGFhiCk9@shikoro>


--jMxtUNg6do9ROjXB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 04:53:06PM +0100, Wolfram Sang wrote:
> On Tue, Dec 12, 2023 at 04:30:10AM +0100, Wolfram Sang wrote:
> > On Sun, Nov 12, 2023 at 07:51:48PM -0500, Wolfram Sang wrote:
> > > The Renesas KingFisher board includes a U-Blox Neo-M8 chip with its
> > > reset pin wired to a GPIO. To support that, we need "reset-gpio" supp=
ort
> > > (patches 2+3). But first, simplify regulator handling with a new help=
er
> > > (patch 1).
> > >=20
> > > Changes since v4:
> > >=20
> > > * don't touch reset during open/close. Only deassert it during probe.
> > >   [patch 3]
> >=20
> > Johan, all good now?
>=20
> If there are no further comments, can we have this series in 6.8.?

All good. Now applied for 6.8.

Johan

--jMxtUNg6do9ROjXB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCZXwPdAAKCRALxc3C7H1l
CLHtAQCcwG7tS+xoay2ulLA84bKG3CfqhW0ec8vHzF+qVEhRwAD9HSRu2FD/yDJc
cQqJm4HM5XgX8VtoR9uqmHZxAxQfiw0=
=pi5t
-----END PGP SIGNATURE-----

--jMxtUNg6do9ROjXB--

