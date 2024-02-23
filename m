Return-Path: <linux-kernel+bounces-78987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BE6861BD1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 597B41F27C1F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5CD125D1;
	Fri, 23 Feb 2024 18:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObaUTUni"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27AC12B74;
	Fri, 23 Feb 2024 18:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708713313; cv=none; b=PxPGWig+DrprNukVFKQBvf3LZ3H2Ttcp/6BBH+jvlkcd2N5nJJ9t4d2S5koy4E1mTY/ctqTgag4HtN512lEpWS50U63HWrebPWP+9ab/fnr/k7z3U3lHCfflWiNs6bDtqy+olD6LNOepOhK38xfz7N8NWBpGSuBg3QDM5548ylg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708713313; c=relaxed/simple;
	bh=dzLKfzy4qN2ZJmuazd8NWs7T6X0ZwiQjUtE3XISc66E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qa446B/NV2Trum3huwMitHV5iyEQfMC4dAQ9tIMLJr974/hnWLuYjxyCtiyhvca1WPi8WdTsr08DLNEPA0eP+4eobyJd439anpN1ZhiPiKvjU06NE3hSCGPIXCdLvj3l4hZyaKN6MJKFMpK/n5YrCVqfRDmH3+Jhy1i4wgSqCg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObaUTUni; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1C1C43390;
	Fri, 23 Feb 2024 18:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708713313;
	bh=dzLKfzy4qN2ZJmuazd8NWs7T6X0ZwiQjUtE3XISc66E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ObaUTUni+nzMjfVuUXcj5zrrKj7uYwID+IB0FfAdxGr0HWZvS1M4sX18AA+lC0DHU
	 Dij/2nKVmO58U4OVzUcQVOF8Lgotkkjit4FKSi7LBYhrhyKVaiyW2JInRvekixxQOI
	 DPbZ2RVyadjhD8gEHuSehvsU2AVQ7uH5Ngsm0RNVfrU10B+4CqW1PwqFYi7wnT6S2c
	 TfSa7QNp9IfM+kyRCxTFaCkqpVVTf1s+vFYZWIjjg1LeJg7K9gwd+/AaCphd3y4M9p
	 3KWDE4rcMKhbOxVmwAklMbz2agmihXViWhr6ujH8+MZqF7NTrRmWn2u1M63JuMIBpJ
	 ISH7jbwnt/hGw==
Date: Fri, 23 Feb 2024 18:35:07 +0000
From: Conor Dooley <conor@kernel.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-media@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] media: dt-bindings: sony,imx290: Allow props from
 video-interface-devices
Message-ID: <20240223-catchable-parsley-a36bf8064154@spud>
References: <20240223124744.545955-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5puNpy5RKYZuYJmf"
Content-Disposition: inline
In-Reply-To: <20240223124744.545955-1-alexander.stein@ew.tq-group.com>


--5puNpy5RKYZuYJmf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 01:47:43PM +0100, Alexander Stein wrote:
> Allow properties from video-interface-devices. This aligns the bindings
> to sony,imx415.yaml. Changes inspired by commit e2e73ed46c395 ("media:
> dt-bindings: sony,imx415: Allow props from video-interface-devices")
>=20
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--5puNpy5RKYZuYJmf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdjlWwAKCRB4tDGHoIJi
0tDQAQC4+givpTsy86WpI85b7iYw/qekLE8F7yEcFknXMNyHegD+NX04CtbNrfkv
wRqhttiggsftIVt3lDCG2HUllAQxkwM=
=wIkp
-----END PGP SIGNATURE-----

--5puNpy5RKYZuYJmf--

