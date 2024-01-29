Return-Path: <linux-kernel+bounces-43151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3101E840C76
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4C15B22510
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF50B157027;
	Mon, 29 Jan 2024 16:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXNquljV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E982F155A5F;
	Mon, 29 Jan 2024 16:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706547269; cv=none; b=Jgs9La5mL5FQIagBAxginiit84011OsoeetAMaAGIMx3ZqOkNrm+HdCLJlGf6bWX9iiiKQRBDg0nZbrdCYO9kC9o1yZUDUUpTn2j4vu34MI90GOc3UgjzMbk6X2R4frpsMttoqqTqlo0Th9rnoDKfY1zJi1b0fpd0C69Ol9I39M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706547269; c=relaxed/simple;
	bh=ZsW4lZCtQGP9LISR87ec5aOGOdwxo9b0AO0GiEBptwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUo4p4PF5fg8Gytu3fwoigYDFzua+zjm7Ew0dBC0AzT3XMP9jB2jOVzcr0WOzBkMY+yUHfvnglgMNNKHFJbKxpuHJRKJfz9tfYOfyeboi5vlmsarehzNDCWGHMSOj4QNv7x1vT3xo95lIQ9xxnh2Ra2UnDUpWoJ/LXm9E386FCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXNquljV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 708FCC433F1;
	Mon, 29 Jan 2024 16:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706547268;
	bh=ZsW4lZCtQGP9LISR87ec5aOGOdwxo9b0AO0GiEBptwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YXNquljVDDYjl6CwkqdVVM0agE8ZpU9Bdon5mU311ieJOUGlewp462GTgXd2lZyMA
	 QtkYUlE7xLP3XIbeJiYmdcAUQa1gXTFghR0ONUriMK/RosoXARAlbrVH5wQBW/k83k
	 vTKJTaLenZ+UmMwxh1qeuZM6RuRA5vqn++iiOotVldP3yfOZ9wmPLOGp5xxN/bt96D
	 btlM+3i8cu0BQ33sIDfRpP5Iwi8Z8TpDWUeu3X7HEGrhoCqWtU7VVtpxgYaF/moBm1
	 OlTUxCH+luJdXdbuWNZutImpww0iRC0fKezvKpI7FtzWJWH2iLOsCBZ3BH2kvD8Awz
	 2jDTuTik6mwFw==
Date: Mon, 29 Jan 2024 16:54:24 +0000
From: Conor Dooley <conor@kernel.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: soc: qcom: qcom,pmic-glink: document
 X1E80100 compatible
Message-ID: <20240129-shrivel-moonrise-66da0682afc1@spud>
References: <20240129-x1e80100-pmic-glink-v1-1-e45cf194b964@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1CylUZF2KB1wnOz1"
Content-Disposition: inline
In-Reply-To: <20240129-x1e80100-pmic-glink-v1-1-e45cf194b964@linaro.org>


--1CylUZF2KB1wnOz1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 03:28:29PM +0200, Abel Vesa wrote:
> Document the X1E80100 compatible used to describe the pmic glink
> on this platform.
>=20
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--1CylUZF2KB1wnOz1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbfYQAAKCRB4tDGHoIJi
0jOFAP4qLgrIksboUEuAlchwtdCWKgKHGkPlLAGtYXjFgoCCPAEAzKqWGp5fl5FQ
HVnEpX9Rp/DGsHMR6TCRNOD/uGuYWAk=
=OXsV
-----END PGP SIGNATURE-----

--1CylUZF2KB1wnOz1--

