Return-Path: <linux-kernel+bounces-108031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C39880506
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 847611C222DB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809243987D;
	Tue, 19 Mar 2024 18:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5esGHgQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2543A1A0;
	Tue, 19 Mar 2024 18:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710873839; cv=none; b=Z9JtwZRaWHplwHEg90GBIP4WZ7QOPm+eyZOpvfhLwcxbtgS9SeFVtP0EpgxlGQ3rnMw6xTr06yB1r+FIMfvEM9flY7ny8OfJLOsrtwvEKsAE/EbuoRfbqM4X1+SxEkpKyUZC8Eo+6X3DvTUrB6Q15UJO+dqsaLDs5eMgK5MfO8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710873839; c=relaxed/simple;
	bh=4WVGd3ryolDOWniE4Et7L7N0trtC6BrWH/xUDuGh76s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLVmFdvfGlgbATtAatEKXgvso4ClXpQZO3e0OXwzeCXApKdBg00sDpgQE7IWFrXEKfvyrEGuP/+mddrWRTbN0Uo4+bGHOt7crV6A0Qxt07m4wx11bwzg7DcMpAHPmWs9dRQimnSgaz5iwTrMzj9qW483kdopD/1uSylCNc4ryZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5esGHgQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562DDC433C7;
	Tue, 19 Mar 2024 18:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710873839;
	bh=4WVGd3ryolDOWniE4Et7L7N0trtC6BrWH/xUDuGh76s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y5esGHgQ6sOhhtgemGhHL+0eT/KQagb3f9qEzLLS4328PAc47h6jv3opqs6wutcZY
	 QXd3AaYYK/wF7ZQZKMWQwnkrT1pejtChmEFgcvR197Xd5uFRaUVpIH/H2r+5rvxGj/
	 6r0JVka/OrwD1YEjRXASxmH5ve1CM3yw+abFgDxiq+CflkEEWdvylSQleh105vkMjX
	 Y3Sz3h4lU7/RnC8Jit3wLR77ZBmaMmTRQRbOGqrUkCu+boIqBkeapV6Vz8fevaKMdc
	 KR+gR3C50FJmogPhkc8nVE7ZnftCK5AYf/HFUUljVRKo5Uz+DaerxyEpuELHTKXNnP
	 tuCoAFZh9QT6Q==
Date: Tue, 19 Mar 2024 18:43:55 +0000
From: Conor Dooley <conor@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: timer: renesas,tmu: Add R-Mobile APE6
 support
Message-ID: <20240319-dispense-capital-5fa3153bbf00@spud>
References: <cover.1710862701.git.geert+renesas@glider.be>
 <18b3778031f939a8e40a9865f9be0a9ec2e28a1e.1710862701.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hg74Sdz4vwzBP48m"
Content-Disposition: inline
In-Reply-To: <18b3778031f939a8e40a9865f9be0a9ec2e28a1e.1710862701.git.geert+renesas@glider.be>


--hg74Sdz4vwzBP48m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 04:46:03PM +0100, Geert Uytterhoeven wrote:
> Document support for the Timer Unit (TMU) on the R-Mobile APE6 (R8A73A4)
> Soc.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--hg74Sdz4vwzBP48m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZfnc6wAKCRB4tDGHoIJi
0tgxAQCrKkiLK5mzIKOC2F5tOw2td3Zg8usxz3w9FgAEn6+GRwEAglkLnjU56lmS
VagyRQRt4+1k/1+H/6lpnOoGnCyQdQU=
=1kPV
-----END PGP SIGNATURE-----

--hg74Sdz4vwzBP48m--

