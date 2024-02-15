Return-Path: <linux-kernel+bounces-67076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D62A8565D9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBE1A283EA4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E015131E54;
	Thu, 15 Feb 2024 14:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGOsKXZQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FBC131E31;
	Thu, 15 Feb 2024 14:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708006954; cv=none; b=i/bR9lNqfdkY4StU9tHhC5l0EvmBRfJTKU83niPAFUouTaI7k9j4z1cy2Bg4uqo7ZMWM7ClgnR8KTYZRgJw/x663bETr8WtMoa8EWOo38neQiFx4LuSZfcqQxtA5O7HGRoN/TKeVEfiT6YmfTX0MrA/XSKQGLN0KPuYVj4ce+BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708006954; c=relaxed/simple;
	bh=I3PqLIUTAqJB6Y7FtjSDQxRujjCC+9S7whKOrCfAIKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJKarOloFJbaQJSifFYsDHDn1xh7zn9ZboSn6SROWK1zQk66t532+RTEnGxmWR6QmmSnfBRyTrndzZPRn/AusOJDPrlV7oas4JvB9rWpnZW6UVgbxHbhogoRyiJ/CK2lgmN6AJqeLNZhrPn4is73yvRevqqGfhIq/U2Cmkvj9mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGOsKXZQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12DAFC433C7;
	Thu, 15 Feb 2024 14:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708006954;
	bh=I3PqLIUTAqJB6Y7FtjSDQxRujjCC+9S7whKOrCfAIKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QGOsKXZQKcTaGLN+G8awa42ygsqJi28biVwvObmNYWygcOlqEeyI9WTsBaFfmH0lK
	 Jyfbr35PPHRMcKql6Dnsb5zpuq/9UbqTfknJAvNosODAJHfWyfZ0bxzXgnT8j8RuZd
	 LeCgqMx6iaeuIzo08YhV4HdTBYnw8Urnmpxnjm2jea+KyQAnhoRF2pHoLeboVBgo4U
	 lWie0cqlxbXTLdkIHUEigle0vo8BL4PZKOsNfJUCCsO8PsUU8UuvwoBA5oZ4y2+E0o
	 09D0XyiGN5iWDFqqp+u2vFWLt0R42OBomSTdVakYtq40grzRmaVcrNItzvi8dCdJ1j
	 ABnaUu47ZHNOg==
Date: Thu, 15 Feb 2024 14:22:28 +0000
From: Mark Brown <broonie@kernel.org>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
	quic_srichara@quicinc.com, quic_varada@quicinc.com
Subject: Re: [PATCH 1/5] spi: dt-bindings: add binding doc for spi-qpic-snand
Message-ID: <ab55fcde-f3ee-426c-ae24-2e76ffb20a2b@sirena.org.uk>
References: <20240215134856.1313239-1-quic_mdalam@quicinc.com>
 <20240215134856.1313239-2-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2csQjU5l3LaA5RPk"
Content-Disposition: inline
In-Reply-To: <20240215134856.1313239-2-quic_mdalam@quicinc.com>
X-Cookie: Pass with care.


--2csQjU5l3LaA5RPk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 15, 2024 at 07:18:52PM +0530, Md Sadre Alam wrote:

> +  clocks:
> +    minItems: 2
> +    maxItems: 3
> +
> +  clock-names:
> +    minItems: 2
> +    maxItems: 3

The driver requests the clocks by name but this does not document the
expected set of names.  The driver also unconditionally requests all
three clocks so won't work with only two clocks.

--2csQjU5l3LaA5RPk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXOHiMACgkQJNaLcl1U
h9Bs8gf5AeVDl5A5NLKeeCU9eg710unicAjbLogdVKMnVejjdUC0v4uk4sfxSLer
X8VBBJAl9HfbmBfbXLHsRmyM6keu3hPFl4GJyAWo0yK4sMmPeGRl138cdPZLYW5k
cWaWnByMVUmJhRS+vzx/+NvZsr28LnnvhNhTwK7VEgd7/vDj6j8Iz/6bzMBaA3Mq
whPUldObYURrMzojCoUYM/hdnos2MXRqauACX6GRivbRYP15eowVxAiGcQpBbuRP
IhUiku9ujdwyU39SeSFrrpghK7UiFft1/rSqyXmZUOyUS8xOZGXUDACUJztKfQ6G
20MK0dUD0t2Z8IFIJ7wQLl7qn/dk8w==
=pWun
-----END PGP SIGNATURE-----

--2csQjU5l3LaA5RPk--

