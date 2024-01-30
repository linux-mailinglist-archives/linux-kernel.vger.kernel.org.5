Return-Path: <linux-kernel+bounces-45067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B72F6842B56
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CEC21F24C73
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683D2157E6F;
	Tue, 30 Jan 2024 17:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5dAbHzq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5685C14E2D1;
	Tue, 30 Jan 2024 17:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706637519; cv=none; b=pbcs6CzPV4MwtDjTyHpTNl3r+qqQDdQPX5dMwBCoFaqdxLPJStSWuT1nvIe9rrIZdZ45xfqFd8RmRBVkmQtHqmObnWkjKmyuvrjyH+s+2AjWwQ8t7YLqlwFz/9LdYNoIEvs4A4YBPp7y+0FiY2rUhPkyzOmVn2Gv2cJu4IT9V6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706637519; c=relaxed/simple;
	bh=eRO58rhLkDC3XGVDbdIcragPqA1KWB4/whLzh4oIseI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9GNVC01K0Apm/KKvLBV1BobxzWwHVfP00VraxsevVGnKupd9QMwCRlAgJrlQAOYriVa2UzP/LEPCPoqvdcQaPpMrjLmFy7pfphd8YSZV5ExZT8RXxpDdvsV3vtgF6FxJ7pjTKeF1ZDTf6+VgjUb3yxdXcUw9fxSEK51oD3/Qrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5dAbHzq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6185AC433C7;
	Tue, 30 Jan 2024 17:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706637518;
	bh=eRO58rhLkDC3XGVDbdIcragPqA1KWB4/whLzh4oIseI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B5dAbHzqxmhoTlyK9egPKCyXc5D9IJkcVjxVLzsvwumOCy+fmTd70T8BqBUcKBcxf
	 bXLUphvCq5sUVr8q+gCuumt2latEVIbQHW24HnhUCJOC8mKNGE25dDINl/25e/JBSX
	 7WFcb5SGyWTCp2swIobZJ+RWEbD4qspuLrdUcrtEFToO7K9FHqA32jLtP2RiJOBLgp
	 bA2oLO4tHLjGd5bGxO/qJrpoRjGcz9WDr+IOn6ey3F5+UVA6EsGDeOGVMSIHHrai3l
	 a5szKTjg60P4WUbQjyyEq/BjJrrU7GgBnFGioPiQ4by+dWj83zNbP69Dw4BEoZcrBS
	 ubWb6JbvNzKtg==
Date: Tue, 30 Jan 2024 17:58:34 +0000
From: Conor Dooley <conor@kernel.org>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: gregkh@linuxfoundation.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	piyush.mehta@amd.com, michal.simek@amd.com,
	francesco.dolcini@toradex.com, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH] dt-bindings: usb: microchip,usb5744: Remove peer-hub as
 requirement
Message-ID: <20240130-blazing-jovial-8c15bbfd9ca1@spud>
References: <20240130073505.8916-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wUsBcy9YsbXTTG7j"
Content-Disposition: inline
In-Reply-To: <20240130073505.8916-1-eichest@gmail.com>


--wUsBcy9YsbXTTG7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 08:35:05AM +0100, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
>=20
> The peer-hub is used to model the relationship between the USB 2 and USB
> 3 hub. However, it is possible to only connect USB 2 without having
> USB 3. Therefore, the peer-hub property should not be marked as required.
>=20
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--wUsBcy9YsbXTTG7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbk4ygAKCRB4tDGHoIJi
0nQ7AQC2snoup2KWag8GoxVgNdDzgpVNDKIv6nxn8T1ciJa76AEAq9OtUNaVd1zk
8GIFEffIl8Iyh/5I125yK0Ex4BScYgU=
=6jsI
-----END PGP SIGNATURE-----

--wUsBcy9YsbXTTG7j--

