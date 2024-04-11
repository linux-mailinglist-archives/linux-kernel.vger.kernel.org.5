Return-Path: <linux-kernel+bounces-140726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8625B8A1850
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25BB81F227C1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5734171C8;
	Thu, 11 Apr 2024 15:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2A2hrdj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09A910788;
	Thu, 11 Apr 2024 15:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712848309; cv=none; b=gB8bcXUkx7dO3Dm/6OgMRcGSMKqIw/IDQZRUwgvMqcdc5Y766bzt/P1S4Qkmf3Pe/Sompvo0Eu8wCCb9zNAalSgFG98+H7SqXoJjmN8cIHfymeze7Za199I/lyn02tK/fCnyHM3di17mOUezg5ZcXD4bdSvJ5QfLlryLb1Gs91w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712848309; c=relaxed/simple;
	bh=6T6KZL6GFm5dCTrVlwn00hy4RM4V0SGfVe6aPd1R7eA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXjP49Ltkg862doEPnF9ndHmggsblbg1YW0Lo5VvTuAu0jKtNjhe2TSnyO3h85XOy+OEwvlsURUwGiuhA1Le+BcdwkDglpl64Xl+bND0fKMxecKERbrH6vTqHuulFXg6sQZA4mM96oDAIgrYXr88hUylDI3O4BHPCej2efjmJes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r2A2hrdj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BDB7C072AA;
	Thu, 11 Apr 2024 15:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712848308;
	bh=6T6KZL6GFm5dCTrVlwn00hy4RM4V0SGfVe6aPd1R7eA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r2A2hrdjEIVuibFBNrpS6BXjfhhCO05wWLAaKYLRqQcVPWKaqNLFKaPHciCf3PO+F
	 mj/sg8ThQ0VSWezR2Ba75wqGNZOulphcaRR3aChjQbQ+Cl9PdIPdbfzxKzCYDUeBXV
	 yYXUVuThosnEIAeahGHEiqkyTG565GwMW1PJ8ZYRN84BB2CgsqM0d3FM1zO3jVYhGf
	 /rRDrgcSDXhXdoMCORo9IqTgYHSttoNdoqoHSK9/B5s5wzsAPKKr/WTmWwUoN5Yg0T
	 N5Czod5VdhjhP/CjgtlndGxZ13eDoXQkV8j2tR5HsbENJ1Jt6RcXJdwVSsQlM1o8aa
	 aiSi8C2dYJSuQ==
Date: Thu, 11 Apr 2024 16:11:42 +0100
From: Conor Dooley <conor@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-scsi@vger.kernel.org, alim.akhtar@samsung.com,
	avri.altman@wdc.com, bvanassche@acm.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	peter.wang@mediatek.com, chu.stanley@gmail.com, jejb@linux.ibm.com,
	martin.petersen@oracle.com, lgirdwood@gmail.com, broonie@kernel.org,
	matthias.bgg@gmail.com, stanley.chu@mediatek.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 8/8] dt-bindings: ufs: mediatek,ufs: Document optional
 dvfsrc/va09 regulators
Message-ID: <20240411-oaf-stove-b291a21ef404@spud>
References: <20240411114300.169055-1-angelogioacchino.delregno@collabora.com>
 <20240411114300.169055-9-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eEVVjrii83EVReKE"
Content-Disposition: inline
In-Reply-To: <20240411114300.169055-9-angelogioacchino.delregno@collabora.com>


--eEVVjrii83EVReKE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 01:43:00PM +0200, AngeloGioacchino Del Regno wrote:
> Document the optional dvfsrc-vcore and va09 regulators used for,
> respectively, crypt boost and internal MPHY power management in
> when powering on/off the (external) MediaTek UFS PHY.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

btw:
<stanley.chu@mediatek.com>: host mailgw01.mediatek.com[216.200.240.184] sai=
d:
    550 Relaying mail to stanley.chu@mediatek.com is not allowed (in reply =
to
    RCPT TO command)

We should probably delete them from the binding (and maybe add yourself).

--eEVVjrii83EVReKE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhf9rgAKCRB4tDGHoIJi
0gdGAQCnKsqnZe2hv36Mjb03LruoALs7tf9nb2U0ZuIQcbhPMQD+LNrShTAhHbLs
R7ovr7nrZo1R+StUSKtpTyBux4Z+KQ8=
=LZcM
-----END PGP SIGNATURE-----

--eEVVjrii83EVReKE--

