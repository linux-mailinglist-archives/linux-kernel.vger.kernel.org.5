Return-Path: <linux-kernel+bounces-55086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1B984B77A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6D5B1C25470
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FB713175B;
	Tue,  6 Feb 2024 14:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNWuza2T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E266DCED;
	Tue,  6 Feb 2024 14:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707228601; cv=none; b=VLFytjfk2M/p8K/6us/ezdlJm2m82qElabvCtLBayISakyEHN0o+kXx9y30pIMnziSsKRo5lyu6oduJr1odPV0RNd1k+JmINAkojeiu/vy9gjQDaOf/5Tb2/z/iw2NyUDyQU3J3gB/lijm1yIY0ZZuzvuJvgcdZXcBc5TEEYkYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707228601; c=relaxed/simple;
	bh=hvmqSmkmFWutE9hUmwv9X3rui7sLEKtbeE/rAUiiKJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tk8O/hEOi+R4CPM3gIkpg0FndOr5dBaaQ+ySaF6AgCsW2emTqQ83Ki/haKtS2CrlXWKWZ149ZHq3pDfJPp9SPSr8fwuxNMSvLX+mK5AV1l/RcmLwLBKaxn7zRDJyIYiIREBHBXmSHBGi0Izoiag1aS0ZeRcyz0yrQOl8gZMwOuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNWuza2T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F85C433C7;
	Tue,  6 Feb 2024 14:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707228601;
	bh=hvmqSmkmFWutE9hUmwv9X3rui7sLEKtbeE/rAUiiKJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CNWuza2TVVhuJEoZDi6iwLXYMDjDdzW4VERhWUfGkG1M23Pb8FCjXdb4tCWEfU/gD
	 18Wl6j0ThMgFAlr4yprL0217oNh5eHX9+1jWqrQOzELUixvMA5wRMIwtLFk0nBErUu
	 s+Ev6oG3+cqJ77C+iV6hUMWCNzx2gwN9a39c6Yf52+tNnTbXhWdwQxfHxvDXmSkxOA
	 ezmWrPN4eNIqWSzxv+hFeGWqY6ba4JBl5ck5YjE4c3Xi0OsqpOIVFNvsYI1ayC6XsT
	 Tkjmvr3sRbMBXRY3/okBob+bW/xCmYY1zMK1WyaqYkFOQWklHT64fgwmwe63q2KwdQ
	 Tock1+TTUF3Vg==
Date: Tue, 6 Feb 2024 14:09:57 +0000
From: Mark Brown <broonie@kernel.org>
To: frut3k7 <frut3k7@gmail.com>
Cc: Robert Marko <robimarko@gmail.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] spi: spidev: Add Qualcomm spidev device compatible
Message-ID: <ZcI9tWsthu8XMiZ1@finisterre.sirena.org.uk>
References: <20240205191808.998754-1-frut3k7@gmail.com>
 <ZcH9u7Vo2sFERIHJ@finisterre.sirena.org.uk>
 <CAKEyCaB2Cw0Ey73je96xDgofuXDnsC4DgeS9=HkOM6Kufrwbaw@mail.gmail.com>
 <ZcIwGRU5NEZGpRy9@finisterre.sirena.org.uk>
 <CAKEyCaCQk+iL_zOr_0LFOA4Fw+SwyuzSWOvVgmO0Tn8Ygv-4hw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y7mmJmroElizUbXr"
Content-Disposition: inline
In-Reply-To: <CAKEyCaCQk+iL_zOr_0LFOA4Fw+SwyuzSWOvVgmO0Tn8Ygv-4hw@mail.gmail.com>
X-Cookie: You might have mail.


--y7mmJmroElizUbXr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 06, 2024 at 02:57:49PM +0100, frut3k7 wrote:
> On Tue, Feb 6, 2024 at 2:11=E2=80=AFPM Mark Brown <broonie@kernel.org> wr=
ote:

> > This is out of tree, it's not exactly a good guide for mainline.  The DT
> > should describe the hardware, not how some particular software stack
> > chooses to drive it.

> Will changing from "spidev" to "qca4024" be enough?

Should be I think.

--y7mmJmroElizUbXr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXCPa8ACgkQJNaLcl1U
h9AEoQf/dpUGORasBT+OGcDX7Qyt5KaqiCxjXrnGDZBRyJCuvIlnm8lLcAmVSAiZ
fgxhwUHEVQNvU3s88a3E+AVvCeZ+l58BqSuZfgbm5CMx+RB/gRbJv994bi3LzuVt
2wmjrJ+1Ge+eYL2J5/O13eGez9bWrgcglQRGqBoVaXcSeLDjpP03QR0IAurW+XCK
/r8IE6qbz1M/kyymjgrgVDA3Da34FdkVsRCajSE6TeIuD88haRJdO21y6WydpNQU
IDmohpPCVcyFYjcB71dewDn7/mPrebMlAuCS3CiJEPyyro/qn+BB6MfZvc1fr4WC
tIPUf/vcih5fOWEeDASAhHZ1OYhc3A==
=ZDS1
-----END PGP SIGNATURE-----

--y7mmJmroElizUbXr--

