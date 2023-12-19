Return-Path: <linux-kernel+bounces-5506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8033E818B77
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34A441F23D9E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D451CA9D;
	Tue, 19 Dec 2023 15:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ruy+D2B+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D191D140;
	Tue, 19 Dec 2023 15:43:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44529C433CB;
	Tue, 19 Dec 2023 15:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703000593;
	bh=NyVtTMnS4rpOkdtnXq7yeFUBVSUwdAoPi+FuPOJPfOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ruy+D2B+a3xGnqI4RafDT7LFrPb4m8ifwlm8/VtvaC7/Wyck5hmSIY7ZVkPMlhsRE
	 Shc+2aDkeDNXa2A8DQstzJ8BskzN8s6Vk/XQMGFi20MMR7Z5BhbcI4UylLpkf2Eip8
	 j/DHUfqYwJMQT8gjFp9Yf409U277m3SpIic+mScWAQDiKVHYo6Z8q7wNuX+Ww4++5j
	 6YV7gUPmZWo5R7U0OhvqfhIYwUQlh5hu7+NTg2a00aVDS9qIxVWXmp9LNWkmPg1LmV
	 DrtvOz23HaRdS5vtCoZWQLVbNjD6kdt9SWt9KUSjaaFf2C/GqQ1BpLhHROJ0qhZSD2
	 02ijDkYPsIVpA==
Date: Tue, 19 Dec 2023 15:43:07 +0000
From: Conor Dooley <conor@kernel.org>
To: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
Cc: krzysztof.kozlowski@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
	leyfoon.tan@starfivetech.com, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux@roeck-us.net,
	robh+dt@kernel.org, samin.guo@starfivetech.com,
	wim@linux-watchdog.org, xingyu.wu@starfivetech.com
Subject: Re: [PATCH v4 1/1] dt-bindings: watchdog: starfive,jh7100-wdt: Add
 compatible for JH8100
Message-ID: <20231219-hankering-console-7de049490dab@spud>
References: <1d7f9cbe-9ca1-4ccb-b90f-6e474c0740ad@linaro.org>
 <20231218153738.1054393-1-jisheng.teoh@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lh67mthVTQWcRrez"
Content-Disposition: inline
In-Reply-To: <20231218153738.1054393-1-jisheng.teoh@starfivetech.com>


--lh67mthVTQWcRrez
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 11:37:38PM +0800, Ji Sheng Teoh wrote:
> On Mon, 18 Dec 2023 15:41:37 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>=20
> > On 18/12/2023 15:27, Ji Sheng Teoh wrote:
> > >>
> > >> I have real doubts that you ever tested your entire solution with
> > >> this binding. Where is the DTS?
> > >> =20
> > >=20
> > > Currently, the DTS is still in internal and yet to upstream as it
> > > depends on [1]. =20
> >=20
> > Yeah, so you send untested code which cannot work or pass tests.  If
> > you do not test your code, we need to be able to at least verify it,
> > so send your DTS. Otherwise I cannot trust that this works at all.
> >
> Will submit it with DTS once things have cleared up.
> Thanks for the comment.=20

[1] is not going to applied for a while since the SoC doesn't actually
exist yet and is pre-tapeout on an FPGA. I would just send the dts patch
adding the watchdog alongside the series, or else you'll be waiting for
quite a while. Or even link to the node on github or whatever.

--lh67mthVTQWcRrez
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZYG6CwAKCRB4tDGHoIJi
0v//AP9ptXXWLaTpbN1hfhivvCOkAxz9G8QvhBald6lq3UuxxAEA3Vzl0QyXQqLJ
JBFmGXsq8799LeODq0XILF9lAsnwRgw=
=esPB
-----END PGP SIGNATURE-----

--lh67mthVTQWcRrez--

