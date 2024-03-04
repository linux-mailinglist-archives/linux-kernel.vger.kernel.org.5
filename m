Return-Path: <linux-kernel+bounces-91177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A23F870AAD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9E56280C75
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCBC79948;
	Mon,  4 Mar 2024 19:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvYNXVFR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABB77869E;
	Mon,  4 Mar 2024 19:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709580550; cv=none; b=gI9ahKJuyR4W3o22TpYoj4DyCNNJ8Ug7zrrm+lDxjGvTAtuxmFULO1BO6GXBsH0xPCJPdvCPZmZxNZFpO6YZWS0TXl5Sk+vF07zezlwosXH49Uj68NxrDKxH8ncZq0CzISw2EGUByZitiyKcolabGwrYjSid/cPivM9uUoJfEWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709580550; c=relaxed/simple;
	bh=V8gmN+cucgc/503pO37ENBKhzWyVzgTTUpxzw+uscCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ags2AcpBk03Ddi2bkONM4RX3Yq78LeBhGP0CxLqBTUcCXJkHhER83a1gtKit12kys5sVKX0ai2rmifLfuZJi1PwnKTlrXtZjZ13rBHmn5z2uKvQf99xn5pqSPeDA1jbG3n7w54DXpUnUdH+XmxCxTokUTDDkSiJoCc3k7t3ox+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvYNXVFR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF2CC433C7;
	Mon,  4 Mar 2024 19:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709580550;
	bh=V8gmN+cucgc/503pO37ENBKhzWyVzgTTUpxzw+uscCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LvYNXVFRMh4C/CW9oQo7AnwCsurlRlFLoO3zdy8DQqw+gA/tTAU8+Hj3CAXE9kqE2
	 0kDm4U3+4fQNf5PMRJuQdxVQWwkqjMxbDWXg6MOpuTgmkUbYMGDXQ0aFEvF0sLQrr6
	 idA/WDl3GfUewLIDCNhnjjXns2Jd6Lg7ylYgCa+/DbunU2ExrE3pq0G8RwmYbjDqTt
	 mq8/I3WRbuDmkLnEEqCTqtw3x5SjEVnlTlTHEg1SiqdHZrTOAjddYiv3W2ktfUt/Ku
	 x6DNCc+y5658KPyzjutARzwEZIsZ2B8ci7e/ImBtYazayHt1u64lI67/lXAYOJhFDI
	 L3rZy45BO7kkg==
Date: Mon, 4 Mar 2024 19:29:04 +0000
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?Q?J=E9r=E9mie?= Dautheribes <jeremie.dautheribes@bootlin.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Yen-Mei Goh <yen-mei.goh@keysight.com>
Subject: Re: [PATCH v2 0/3] panel-simple: add support for Crystal Clear
 CMT430B19N00
Message-ID: <20240304-drivable-property-feaeba782880@spud>
References: <20240304160454.96977-1-jeremie.dautheribes@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rI073bo/OhsyVdFq"
Content-Disposition: inline
In-Reply-To: <20240304160454.96977-1-jeremie.dautheribes@bootlin.com>


--rI073bo/OhsyVdFq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2024 at 05:04:51PM +0100, J=E9r=E9mie Dautheribes wrote:
> Hello everyone,
>=20
> This patch series add support for the Crystal Clear Technology
> CMT430B19N00 4.3" 480x272 TFT-LCD panel.
> It also adds Crystal Clear Technology to vendor-prefixes.yaml.
>=20
> Please note that unfortunately there is no public datasheet available
> for this panel.
>=20
> Changes in v2:
>   - add link to the Crystal Clear Technology website in commit message, as
>   suggested by Conor Dooley and Neil Armstrong.

You forgot however to add the acks that I gave you for the two
dt-binding patches.

--rI073bo/OhsyVdFq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeYhAAAKCRB4tDGHoIJi
0nAcAQCc3o01bI3Ifa5xoNkCxhVQ62sJgXDVhXy3VZlzzE4KmgD8D61G2EON3aLG
RtxPHF0vPEGYsIXGqwyz/wkAwB4j3w4=
=fyIn
-----END PGP SIGNATURE-----

--rI073bo/OhsyVdFq--

