Return-Path: <linux-kernel+bounces-59736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C97484FB12
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CECFE1C21355
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41927EEF3;
	Fri,  9 Feb 2024 17:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqaoQHPZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8907BAF3;
	Fri,  9 Feb 2024 17:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707499988; cv=none; b=YOVTf+CgA2paNmxsbCtYQgMEhb57InHADdLYel+wbO8p6iPwpgitbjFCgglsNRdFMj1Ebp03hpzPyL/JQndvPT5pPeeFoPGSPnchv2yte7PmKPP92rFKPBUyIxEQmJkx3LKy2siN4mgqb9UJCZTc0O12a9QIwTNizP0bJ6HLa9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707499988; c=relaxed/simple;
	bh=1XYzzZb1vCasixfs09H2e68sWjMWNg0oBmQ78FPc+ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uzqp6MLh9dQtYBJfWN7OQrM9AQK+YMGx55B18YAuYXgzx91p602TGZfpRvGaWAOlziemNIcY3a67SUocvwM5zF79raP3puMZ78sqTxMXaIqjQmE3b3MOKWg/8ZqA+rwRJG+pOqgf/thAJhpLSNewSwLPR6e+XeIHLSMGxTWBRI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FqaoQHPZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA33C433C7;
	Fri,  9 Feb 2024 17:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707499987;
	bh=1XYzzZb1vCasixfs09H2e68sWjMWNg0oBmQ78FPc+ks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FqaoQHPZg3IiS027w3h5nnY88F2KRuo1GHsTBznrYloL4oI6fPRKHJdAp9/Yr/jCl
	 VCQpaXPiDZhmX3raswrmjZ4RVU9JZ+Nv7jQ9YtQLZitFXtSyNElBGhBAJZ4i1LAEpy
	 PNYtW8Eeq4P1IrgBBra0qvR7RDCupFZnbWhNAGQt7t3kUrKd+I4FpExZmKp8q2C1t1
	 +3ECsJGDN5O5r//a8dgw4YLwEeDmfd78NQfpePppJCru5s9C566oNhXIpue5EvAi3a
	 bRqMwY3bbZkuNdNSiu8+rGOPXxWgVThBWkwRG78JXThUpVXdP82eNluLz8Ndf9tQfL
	 a6TFTJ1fhO4TA==
Date: Fri, 9 Feb 2024 17:33:02 +0000
From: Conor Dooley <conor@kernel.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sean Wang <sean.wang@mediatek.com>, linux-media@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH V2] dt-bindings: media: convert Mediatek consumer IR to
 the json-schema
Message-ID: <20240209-dweeb-spending-40fe58e644cb@spud>
References: <20240209085616.1062-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="64QFRJ2df7LTNsQc"
Content-Disposition: inline
In-Reply-To: <20240209085616.1062-1-zajec5@gmail.com>


--64QFRJ2df7LTNsQc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2024 at 09:56:16AM +0100, Rafa=C5=82 Mi=C5=82ecki wrote:
> +    ir@10013000 {

I think I prefer "ir-receiver" as the node name, but not worth a respin
IMO.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--64QFRJ2df7LTNsQc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcZhzgAKCRB4tDGHoIJi
0mkeAP49FDBNyOPSTkpBPA2ae5q078viRBKaqvGD3zvqUjUYTgEAjAQGf5apYIg6
uELmyDDlroF4SBmZe+mnR4zgJtRQoQw=
=Hqka
-----END PGP SIGNATURE-----

--64QFRJ2df7LTNsQc--

