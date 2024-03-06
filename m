Return-Path: <linux-kernel+bounces-94447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A35873FED
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4AE81C220BD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1204A13E7C8;
	Wed,  6 Mar 2024 18:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgFkNQyx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4395412CDBC;
	Wed,  6 Mar 2024 18:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709750860; cv=none; b=gssJEfon1usQ4Is4NVHreyHyXcT8G86Go3sDxYjsZXmOZhK+2v4V8FUXagEahi9RlQRl3666uX15gQIlXTbFodr3KqsU8cqH+riYzwV4XNC48ve1wHNPNMgnBfs3huvi/KwAeSeKOFHRutIQMRcH66pxvJK0WRu9d96My856Mfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709750860; c=relaxed/simple;
	bh=uH5Kmmrd2ZBsTEsbwqs/vCHfrforb0VOsgmnEzRMKzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NHj4gDOzJnx0HP0unOiFQDK80QRwj2EOR+lqYkE4NSk6d6q15cE3V5NGEvYsp82hSQ1EeAYW8s7kNO/U+L64sXGlHCABOHewwQ/ZBPOIRVA3BxAF09WZAbdJLuTvIr6UYfqR0P1Yzy17ivy5ES9fGX/MUOuaPLHWx38ndlH80kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgFkNQyx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92708C433C7;
	Wed,  6 Mar 2024 18:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709750859;
	bh=uH5Kmmrd2ZBsTEsbwqs/vCHfrforb0VOsgmnEzRMKzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FgFkNQyxK0pSoutjf+BBdRb6Xt75FDermKEwVYbByaRkvwH2Zrx2Vnhp8fOu3Wtrm
	 LhL4BJ3KhCRLNzlxYVft/W4sAKejgNEtW1Xui0ECG7XvJenOB3WS475SBpFDgcRQa9
	 Qq58Ymt1AvxmvsxC28udXo82n7n7/YrODjN56Ys05aaAiCA10jAeHjO1pirWmv3vvX
	 NlQPr4nAn1h/+8PJVU5ceBDHk4hM0EMab7wCZ7dTDhDVgGawBJwjd8NojXq9300g12
	 0ITja07klZcmjaNS8oLVR6qXRIybABP/7jwr3ehI+B6gTwlttigMR8D1zdvxnli2Pm
	 lMnn8Ube/ZzAQ==
Date: Wed, 6 Mar 2024 18:47:34 +0000
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] ASoC: dt-bindings: fsl,imx-asrc: update max
 interrupt numbers
Message-ID: <20240306-evergreen-foster-ccdabb6806e4@spud>
References: <20240305-asrc_8qxp-v4-0-c61b98046591@nxp.com>
 <20240305-asrc_8qxp-v4-2-c61b98046591@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aQb0iygPV1zknTJ9"
Content-Disposition: inline
In-Reply-To: <20240305-asrc_8qxp-v4-2-c61b98046591@nxp.com>


--aQb0iygPV1zknTJ9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2024 at 12:33:03PM -0500, Frank Li wrote:
> fsl,imx8qxp-spdif and fsl,imx8qm-spdif have 2 interrupts. Other platforms
> have 1 interrupt.
>=20
> Increase max interrupt number to 2 and add restriction for platforms exce=
pt
> i.MX8QXP and i.MX8QM.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--aQb0iygPV1zknTJ9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZei6RgAKCRB4tDGHoIJi
0pBwAP9P/iOz/WJsDWRql3i55Z27q9gL867xW6ceF0t3tPnDxAD/dfd0C0xerdAw
E/NBarjCE1F+Yct5lpuyMQJgoqt8nAc=
=i5DV
-----END PGP SIGNATURE-----

--aQb0iygPV1zknTJ9--

