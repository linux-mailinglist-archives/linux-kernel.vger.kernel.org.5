Return-Path: <linux-kernel+bounces-35764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A53083962B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14BCF287EFE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5BE7FBCA;
	Tue, 23 Jan 2024 17:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlayBYEe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A55F7F7D5;
	Tue, 23 Jan 2024 17:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706030335; cv=none; b=tVrnvtqQ7m3NBeoY/ERY+vFKUDnBmFa0JVb5uYReK3Szqr2OjDzgyUOrkQGli58O1ovHlZvmEqwzXAcddjvEhplUr1kSGlnKHlDSMeYWxy9+A6b0vHFLpbZOBns8lWajUDpcivc+godF/zXDYx+GnB0QPNAFBE207ZmRuYQ8FrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706030335; c=relaxed/simple;
	bh=0wMeDfc73Gn1DQIXcfw63fW0wPa62nNYYv2UJ2XjRoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=up0zan0fg1ZMlzqeQCRF+TO2YFCiPG7s2KpexuHi8N9QKck2Ugu+lROF9gdoy11amvMYCJ+ttgZ9zPmNXEJ20IwuEKCYmLlMAvtmJ4umrP3n/bJh/j/S/GPwHUU10eMepmkdvf6xVGOMiDpKX85BgXZJ+a1b/in2kB/mwoUVec4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlayBYEe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3408C433F1;
	Tue, 23 Jan 2024 17:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706030334;
	bh=0wMeDfc73Gn1DQIXcfw63fW0wPa62nNYYv2UJ2XjRoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MlayBYEee9P9deuv4w7vuSIdCirTJUVZ4mLPRwr7WZKGWSj4SjGC2F+caHWFMvs55
	 GJZq7JLwz9YzKoaAWcWKl7Wy3Fev8p8AcrxkPREkoKwl6l2bC2yRWp47XxLap78J3/
	 Z37Emq/2NCia7mEMAxSkMFNniUVnVZEESs86wySG5O7DPO2zmOSaM2Uxm1w/oAB4oV
	 IN3c2cbUSoqNFYR3tAdFAF+HsuLtQUlrX3OhpolWfhGl499is6eDWp2Ak7dP/32Mh0
	 YFgHrwLv9SMh1W/S88PnGpQRD0hGDealdHb2nRp7HRQpimPVzJBMqcycHv+daN+IPe
	 iNwiST09MGJmg==
Date: Tue, 23 Jan 2024 17:18:49 +0000
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Amrit Anand <quic_amrianan@quicinc.com>,
	Trilok Soni <quic_tsoni@quicinc.com>, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, kernel@quicinc.com,
	Elliot Berman <quic_eberman@quicinc.com>
Subject: Re: [PATCH 1/2] dt-bindings: hwinfo: Introduce board-id
Message-ID: <20240123-sterilize-flap-8971aa3bad4b@spud>
References: <1705749649-4708-1-git-send-email-quic_amrianan@quicinc.com>
 <1705749649-4708-2-git-send-email-quic_amrianan@quicinc.com>
 <6e40dd60-884f-be23-0052-d14f7194f844@quicinc.com>
 <f21bc259-45fa-d14b-a556-625b813287f4@quicinc.com>
 <499320f4-f6b1-4582-9512-89ab505305b6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kvYeh59jSJy6fFk4"
Content-Disposition: inline
In-Reply-To: <499320f4-f6b1-4582-9512-89ab505305b6@linaro.org>


--kvYeh59jSJy6fFk4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 12:50:07PM +0100, Krzysztof Kozlowski wrote:
> On 22/01/2024 11:10, Amrit Anand wrote:
> >=20
> > On 1/21/2024 12:40 AM, Trilok Soni wrote:
> >> On 1/20/2024 3:20 AM, Amrit Anand wrote:
> >>> From: Elliot Berman <quic_eberman@quicinc.com>
> >>>
> >>> Device manufacturers frequently ship multiple boards or SKUs under a
> >>> single software package. These software packages will ship multiple
> >>> devicetree blobs and require some mechanism to pick the correct DTB f=
or
> >>> the board the software package was deployed. Introduce a common
> >>> definition for adding board identifiers to device trees. board-id
> >>> provides a mechanism for bootloaders to select the appropriate DTB wh=
ich
> >>> is vendor/OEM-agnostic.
> >> Please extend CC list to more architectures? linux-arm-kernel, risc-v =
etc; since
> >> the proposal below is not specific to ARM but any architecture is usin=
g the
> >> devicetree.
> > Wouldn't devicetree@vger.kernel.org will have concern folks from all th=
e=20
> > architectures?
> > Please correct me.
>=20
> No.

The chromium guys should get a CC on future versions of this stuff,
since they like doing wacky things with compatible strings in their
bootloader and this problem is one they also face. Doug Anderson and the
mediatek chromebook folks would be a good start.

Thanks,
Conor.

--kvYeh59jSJy6fFk4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZa/0+QAKCRB4tDGHoIJi
0qB7AP42fS7MNFt5UODw5B7spVcNF/7hGiIarR6n0iOpN3AzmgD/cMEs6dkMWUtS
y5D3damHboQN4NAPiVxw3DHhtl+s3gw=
=7faU
-----END PGP SIGNATURE-----

--kvYeh59jSJy6fFk4--

