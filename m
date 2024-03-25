Return-Path: <linux-kernel+bounces-117734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE2788AEE6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40FB6307230
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B72F6EB70;
	Mon, 25 Mar 2024 18:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLy8bZle"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A735A6EB75;
	Mon, 25 Mar 2024 18:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711392113; cv=none; b=iFXspLyuFN64v7d+O+s+AAjTfrG4lriJ9awt7ShAh/9W5RaQ3i0lffGXUu2HptkhYch1iewFTIH1p8DzUTUQj1gquAslWVcGW64FgZ1FsOzyp1wFNU/+eL6snT1eVH36M0LODe43mdmf2KRG483TKB2pYU38HGr0Z1a4bzlGfiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711392113; c=relaxed/simple;
	bh=l11EKaNUz9GB+4g3b07Q3DH2nIYGQPe6bdaMGVe0pQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUOaXFX46WFcOx43ZMO+QXZh5CwNEZ9YU7qfJ2ECohvxVojJKd4BCzvVOLn6xxSMavA1cxgGxLOufkYEf47bDpceV4xFHelofjjtbSQ4so2oQeK5zkxJSzZQkuehWW3g/sjgrZcs88NIHlchUb21Chtrh04sJC1o9etGKU2Nda8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLy8bZle; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30065C433C7;
	Mon, 25 Mar 2024 18:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711392113;
	bh=l11EKaNUz9GB+4g3b07Q3DH2nIYGQPe6bdaMGVe0pQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GLy8bZleyU7PZdytFpWUA4zVa2WUcfOQs7RGO/3w9CHfXeM131dKg1x+A8iSijVXM
	 jeFb8VCwYJ/EDcHjR0hYoH7mNGNy2joQ/m5DKF3kzDZWsaf7hQ/UepFfBItKpLfdwG
	 vwG1THMSZRrMWFfy/KXpg9cvo6pRlMuBGUE8d+550hRnHv/sMKd8QdkKVI9nvAGh9I
	 rBkUF+QTmYWj3euk6rb0SOeWhRLMAFbO6NWFZfVNt8FEUwJ85HmSXg6LtMW1B/CV7O
	 Y7QBTfGvJOt4i6+oDsEfmFKdzjybciobFQfYwcL9vXumiek96K4m4FiBqKPFoiS3+I
	 424w6TptR9FmQ==
Date: Mon, 25 Mar 2024 18:41:49 +0000
From: Conor Dooley <conor@kernel.org>
To: Julien Massot <julien.massot@collabora.com>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org,
	kernel@collabora.com, linux-kernel@vger.kernel.org,
	mchehab@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	sakari.ailus@iki.fi
Subject: Re: [PATCH v6 2/4] dt-bindings: media: add Maxim MAX96714 GMSL2
 Deserializer
Message-ID: <20240325-mundane-rascal-7ea91354c989@spud>
References: <20240325131634.165361-1-julien.massot@collabora.com>
 <20240325131634.165361-3-julien.massot@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oZEk1+ct/QRLmZun"
Content-Disposition: inline
In-Reply-To: <20240325131634.165361-3-julien.massot@collabora.com>


--oZEk1+ct/QRLmZun
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 02:16:32PM +0100, Julien Massot wrote:
> Add DT bindings for Maxim MAX96714 GMSL2 Deserializer.
>=20
> Signed-off-by: Julien Massot <julien.massot@collabora.com>
> ---
> Change since v5:
>  - Reverse the fallback MAX96714 can fallback to MAX96714F
>  - Use const instead of enum for MAX96714F compatible

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--oZEk1+ct/QRLmZun
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgHFbAAKCRB4tDGHoIJi
0quiAP485hQRBqlw8D/APXClwqmk9pCnKq37vLGUibyIIIiFGQD+Nk15zjIhNj9d
OxNjxYURGjJocr5LEyonMMij5MXj3gM=
=VjMi
-----END PGP SIGNATURE-----

--oZEk1+ct/QRLmZun--

