Return-Path: <linux-kernel+bounces-55120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B2184B7FF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1355D280C93
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958C6132C20;
	Tue,  6 Feb 2024 14:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q7jNBJ38"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE11133402;
	Tue,  6 Feb 2024 14:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707229978; cv=none; b=m3LQZREYKsPivkYW8Vy9FgdWYtCKebFfXk5oxmIefkqlX7QAvPklHEFSlsK4qkKnnF88nt3I8MZxrmNXwbBwkaM2k9CxqXfTsxZOhEhZe5wTOS1SSWV5MvtOOHpJfejZBKpgi1IoCWWt+4h3EkQnpXnOx6IjuAy+kiss93uv1SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707229978; c=relaxed/simple;
	bh=9UD8b+TFEEK4uaC9hJArAphziHujlpaWwwUyIgLBMxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WhlpqjEEjE4emdEyizvScn+xMxS8q8vK24Z+Lva08VObi57BBxBPQhcWASFQtpMa9QjEl7sEI69IwIrjvAC/Tbhdxbp5f5+M5am5TAcxbZOfqMSzfT5eT55ZtcGOZbO1YD8LKTXOgc0j2GO8Ne5seoQ6JkslE+yP/bR6IP96qII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q7jNBJ38; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91ADC433C7;
	Tue,  6 Feb 2024 14:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707229978;
	bh=9UD8b+TFEEK4uaC9hJArAphziHujlpaWwwUyIgLBMxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q7jNBJ38XIV3H3zCuCxJsKOiGWqCQhJwh2J4ojbgeQQlLzZ9I39+4pY+LK5QR5UJD
	 KVk6U7n6+3DRXpTHA4fzjgSdepmDinVheDwDpOKJM50iSKlp27Fw5WH9KfztmuPae0
	 i4Wc8DUZMspWmB2dIn0ZTmtSxbtxASicKnXisYz+/GNTTCAb1mncM7lrhR39vA/jA/
	 qQE8r/wWcI+/1a9ALjyMFhCJ6oRsGps1mmNAiscAAfwI7WTBxENuVYlu7wAzZ/ixJW
	 tr54XmjUxaB8ymcwokWfi8gMDLuVU5fjAzlUSAm58lE3rK/1rQUdxeh50sWfmwGYug
	 YWVifAk5sTWsw==
Date: Tue, 6 Feb 2024 14:32:54 +0000
From: Mark Brown <broonie@kernel.org>
To: Javier Carrasco <javier.carrasco@wolfvision.net>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Kaehlcke <mka@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 6/7] ASoC: dt-bindings: xmos,xvf3500: add XMOS XVF3500
 voice processor
Message-ID: <ZcJDFi+iIQOWzgYw@finisterre.sirena.org.uk>
References: <20240206-onboard_xvf3500-v3-0-f85b04116688@wolfvision.net>
 <20240206-onboard_xvf3500-v3-6-f85b04116688@wolfvision.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="09qaS/n52Yq+UYa2"
Content-Disposition: inline
In-Reply-To: <20240206-onboard_xvf3500-v3-6-f85b04116688@wolfvision.net>
X-Cookie: You might have mail.


--09qaS/n52Yq+UYa2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 06, 2024 at 02:59:34PM +0100, Javier Carrasco wrote:

> The XMOS XVF3500 VocalFusion Voice Processor[1] is a low-latency, 32-bit
> multicore controller for voice processing.

Acked-by: Mark Brown <broonie@kernel.org>

though...

> +  vdd-supply:
> +    description:
> +      Regulator for the 1V0 supply.
> +
> +  vdd2-supply:
> +    description:
> +      Regulator for the 3V3 supply.

..it's a bit weird that the supplies are named like this, usually
there'd be some sort of meaningful name (even if it's just VDD_1V0 and
VDD_3V3 or something).  Are you sure these are the actual names?

--09qaS/n52Yq+UYa2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXCQxYACgkQJNaLcl1U
h9BNHgf+JiPymHHAj2dWCTh3dcHIcsDDkVwzN5R4Ue5BSiQ+iVD4G0zQZHA9KlEc
7TNtUN+LdLUnPZ9DldK5GMEfoNJAflLR5MSyICkP3YPJl+9pcMaT98l9asluFMqS
Qex5uI3PwAMH9vqgj+xvk2OJM0Bp8LvTD9thGRXXh6N0QukDwovKqtVTLEVSUTkb
/v5VhN6YhrOGy6Mlo27m0otmD2ERRhK2uGMHbf5Ghgp8qObCCHXVmEeRNRs8fulC
WKjunt8FUP48V18SRPNKAxZl6bFJPzPer/IAF2CXd/crpUP5EdBxTbke8aJwe0vm
JHzm5NTNpB9v+Ou15VrdXNWi1iPXHA==
=6G9h
-----END PGP SIGNATURE-----

--09qaS/n52Yq+UYa2--

