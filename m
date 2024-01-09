Return-Path: <linux-kernel+bounces-21152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB0E828AD4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3953E1F24891
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 17:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086803A8F9;
	Tue,  9 Jan 2024 17:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iASeUiit"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AD83A1B7;
	Tue,  9 Jan 2024 17:16:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF81C433F1;
	Tue,  9 Jan 2024 17:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704820562;
	bh=8vHH4TA7YAbmHU9PwkkVzfxY8bEZBUphiHO0pMprnow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iASeUiit0WvZcOUa1bS5XKWgTQQLqrKQdIP+Fl0Uwmma7hSan2dyQOvG6RPeY8O94
	 gcsXiR9Hafm3TDy7AZgDQGiOioEFsx0JIbHtVjWjlhD8+FZscQoz38LVm/B9Xi1DR0
	 ZGIjqdJpa7vgCmz2wqjDailt7hDiA1/3h9+lb3Pf+nU3amxvDNb49nWi61He8WS7kB
	 uXW9LI9cjgROFBnwocWC+sbcFLSk5r2TUkUvL+UpeewafF1nn4oYq/0JFHXLf9afBB
	 r3tEY2SfIlTWQkvzXSAnByrdIxOzDFQBBucG1KX6Gm7pTe/hjD4SYBmVaKxzzOBU/A
	 xx8yx6Uom6vwg==
Date: Tue, 9 Jan 2024 17:15:57 +0000
From: Conor Dooley <conor@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Conor Dooley <conor+dt@kernel.org>,
	William Qiu <william.qiu@starfivetech.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Hal Feng <hal.feng@starfivetech.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v10 1/4] dt-bindings: pwm: Add bindings for OpenCores PWM
 Controller
Message-ID: <20240109-sleeve-squatted-e0943e659b2e@spud>
References: <20231222094548.54103-1-william.qiu@starfivetech.com>
 <20231222094548.54103-2-william.qiu@starfivetech.com>
 <t3w2p765fs633nanqsx5yqres7taqpk6juwyl4iex5v4jpobo2@rqw6r4myjmv3>
 <p22vjdwk35yc66mb4pkntnst6kjyhhmnv3eb2n25c3dhi5bdeo@bj7amwepprab>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="l1ROEXz9Iy/Ywcok"
Content-Disposition: inline
In-Reply-To: <p22vjdwk35yc66mb4pkntnst6kjyhhmnv3eb2n25c3dhi5bdeo@bj7amwepprab>


--l1ROEXz9Iy/Ywcok
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 08, 2024 at 10:03:49PM +0100, Uwe Kleine-K=F6nig wrote:
> Hello Conor,
>=20
> On Thu, Jan 04, 2024 at 11:43:13PM +0100, Uwe Kleine-K=F6nig wrote:
> > On Fri, Dec 22, 2023 at 05:45:45PM +0800, William Qiu wrote:
> > > Add bindings for OpenCores PWM Controller.
> > >=20
> > > Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> > > Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > Looks fine to me. I'll assume you reiterate the series for patch #2 and
> > so I will mark this patch as deferred in patchwork.
> >=20
> > Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> If you want, pick this patch up that it goes along with the dts changes.
>=20
> To make this formal:
>=20
> Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Cool. I'll do that after the merge window closes :)

Thanks!

--l1ROEXz9Iy/Ywcok
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZZ1/TQAKCRB4tDGHoIJi
0v7HAQCyHgwcpyb9uqwBTi+Ww/Qblt+7MpgHC270lUcxAYkU4QEA3DWB4bXtpFA1
qblPMvrOJPbChkjkwy2FCF9finMrhAI=
=ZZGb
-----END PGP SIGNATURE-----

--l1ROEXz9Iy/Ywcok--

