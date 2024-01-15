Return-Path: <linux-kernel+bounces-25732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7C482D512
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12FCF1F21905
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF1963DA;
	Mon, 15 Jan 2024 08:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFVPep7Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F256105
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 08:28:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D5F5C43390;
	Mon, 15 Jan 2024 08:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705307321;
	bh=az/WBOp1OQ6Xfs6EZJ1X+gav/7O1RjelZ2VnMq5MYzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZFVPep7Q08EQy56KAxp7Ru7RaoaL9GcLcMVaxW78ag+YEyFKDsQy0QJt6m06NV6kQ
	 IEL6nLkxGxETwd17LCose+Okrb3PE8C7Npt4c074HK2BDF/zI0Rzhdez2t3G4wpqnw
	 gzaakgRrRHFm0+Cd5ye+DtJPuwYM+M0uzDKqLo3Mmjl+Qs7Yg96oVUnKuk5ODOf2Zg
	 nfp+BTIuRThDNlFqniwBLFKqq07BjbMXl7L/cIsIm7cKyuRh2T3fqzkxYDClyjGUHR
	 XuLOrNCKIhM0hNOuhMFAIPnts3AwbcW5GH2iCEI1kjlwGOL8x9wItfT/mmEO6jL6QM
	 0UX6RwlaHPP6g==
Date: Mon, 15 Jan 2024 09:28:39 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Anatoliy Klymenko <anatoliy.klymenko@amd.com>
Cc: laurent.pinchart@ideasonboard.com, maarten.lankhorst@linux.intel.com, 
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, michal.simek@amd.com, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Fixing live video input in ZynqMP DPSUB
Message-ID: <6jhwss2wego6yoo5mwmphwawhsj5bbj62gwrzcpapoixwkrkli@g4fbxdooopby>
References: <20240112234222.913138-1-anatoliy.klymenko@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n7xcdzwnxhtjrqmv"
Content-Disposition: inline
In-Reply-To: <20240112234222.913138-1-anatoliy.klymenko@amd.com>


--n7xcdzwnxhtjrqmv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 03:42:18PM -0800, Anatoliy Klymenko wrote:
> Patches 1/4,2/4,3/4 are minor fixes.
>=20
> DPSUB requires input live video format to be configured.
> Patch 4/4: The DP Subsystem requires the input live video format to be
> configured. In this patch we are assuming that the CRTC's bus format is f=
ixed
> and comes from the device tree. This is a proposed solution, as there are=
 no api
> to query CRTC output bus format.
>=20
> Is this a good approach to go with?

I guess you would need to expand a bit on what "live video input" is? Is
it some kind of mechanism to bypass memory and take your pixels straight
=66rom a FIFO from another device, or something else?

Maxime

--n7xcdzwnxhtjrqmv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZaTstgAKCRDj7w1vZxhR
xcNuAP9cmMzOSIWhB35PZo2h6GJS6fPvLKG71AcNrtTsLUMFWQEArlTwzA14zz4g
iWpBNljoSviatW38I/qGUvmoR601Nw4=
=TKaZ
-----END PGP SIGNATURE-----

--n7xcdzwnxhtjrqmv--

