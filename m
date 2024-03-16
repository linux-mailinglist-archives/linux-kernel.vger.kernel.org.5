Return-Path: <linux-kernel+bounces-105236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDB087DAE8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 17:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FECD28212C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 16:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEA71BDD5;
	Sat, 16 Mar 2024 16:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzAPz23f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7777D1BC23;
	Sat, 16 Mar 2024 16:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710607893; cv=none; b=kIYqyosbP1ZAuS/BohUvMLg+S9PL9f1EK2l17jiOEp7wy5om1bfOxzreV7Xau632FNMzljAEacgU/UxrQasXf7KKClC/Jk8dOCbkJ/HAz8u/4UHZv+ya+NyFZ1s8tIA9btsUnmMekU/V6+RoZmJU6hPYHvo8n62K4xU3hXU9vys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710607893; c=relaxed/simple;
	bh=Blsu0CvqJo7HubrNrOKxFJlV86ZtgqCAQWTPcruNjzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcIRLed+wZydIDkU9iKclczRCcIQsr+hxDSxH7aap1KCXvAmzGYoEIRKjmmTX/J0rsBBL8lTN/ISkZ9Okdmbf77bLfBK+/3lYdLEw1TdDBpo6vOj3G38iNNSIU111IeCv1wM6fE200t95imeKKL2+W5ctIEDkIzScMSrY7DBWKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RzAPz23f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D2BC433C7;
	Sat, 16 Mar 2024 16:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710607892;
	bh=Blsu0CvqJo7HubrNrOKxFJlV86ZtgqCAQWTPcruNjzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RzAPz23fd/PxP33AOa4VhBirWHWPNkPf5erhBDr8Pb8F6/lbb/XUlhaCYPt35sB+B
	 iWvAe1E6wVDt30ocj4xMFm3DfWqfdKlW4Dxo8KssXYoihPBeUlWL/SkQG56Amk7AST
	 80OGqWxhIvaYNaqa2EQqNhGjJtEs4jNmJV6QKyef7YBbaJdaGkBgmzTiCoEjoqobD+
	 xIWJoneRYLd1b5zUvtVOMwokPVV7DaX/MAFDiIWMkOxO6TlT61uDk8aB9UDCgblFxb
	 skazrTAb9AuVFTsYJtnGpvBOCTnW0afT7HvuavOPLP1e2cSAu6RPzlp+v+xuTvwiVT
	 AzP71kcxM3WAA==
Date: Sat, 16 Mar 2024 16:51:27 +0000
From: Conor Dooley <conor@kernel.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Amrit Anand <quic_amrianan@quicinc.com>, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, kernel@quicinc.com,
	peter.griffin@linaro.org, linux-riscv@lists.infradead.org,
	chrome-platform@lists.linux.dev, linux-mediatek@lists.infradead.org,
	Simon Glass <sjg@chromium.org>, Chen-Yu Tsai <wenst@chromium.org>,
	Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: qcom: Update DT bindings for
 multiple DT
Message-ID: <20240316-herring-skies-6ee1d4a9c0d2@spud>
References: <1710418312-6559-1-git-send-email-quic_amrianan@quicinc.com>
 <1710418312-6559-3-git-send-email-quic_amrianan@quicinc.com>
 <f6f317d9-830d-4c38-998f-b229b3d9f95a@linaro.org>
 <20240316-germinate-browsing-6865db3a44d7@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PlXcNudSv6CjKVti"
Content-Disposition: inline
In-Reply-To: <20240316-germinate-browsing-6865db3a44d7@spud>


--PlXcNudSv6CjKVti
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 16, 2024 at 04:20:03PM +0000, Conor Dooley wrote:
> On Thu, Mar 14, 2024 at 02:20:38PM +0000, Caleb Connolly wrote:
> > On 14/03/2024 12:11, Amrit Anand wrote:
> > 2. A top level board-id property that isn't namespaced implies that it
> > isn't vendor specific, but the proposed implementation doesn't even
> > pretend to be vendor agnostic.
>=20
> I pointed out previously that the Chromebook guys had some similar
> issues with dtb selection when the OEM varies parts but there does not
> seem to be any of them on CC here.

That's maybe a bit harsh of me actually, I see that there's a
chrome-platform address on CC, but I don't know if that's gonna reach
the guys that work on these devices (Chen-Yu Tsai and Doug Anderson in
particular).

--PlXcNudSv6CjKVti
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZfXODwAKCRB4tDGHoIJi
0k6+AQCM2tTMcQ+gQoITo10RiHQuEEKNYjhYn4Ta1ug4VwhP4gD/cA3EtavNpHi6
nEj6wjurQTCD/TCcfUMUCuRqp9KHZQk=
=KIKJ
-----END PGP SIGNATURE-----

--PlXcNudSv6CjKVti--

