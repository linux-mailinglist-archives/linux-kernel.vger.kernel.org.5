Return-Path: <linux-kernel+bounces-22166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C013E829A5A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FFCC283047
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02159482CB;
	Wed, 10 Jan 2024 12:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uu9RuhCm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FE4482C3
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 12:23:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE89C433F1;
	Wed, 10 Jan 2024 12:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704889401;
	bh=RmqLaP+Kk6Jp1WMroZujkVgchNxIXlfMEu/L4asaegM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uu9RuhCmgJiIKPPFH/crrXgtjOZcmNtcSBPEhCkFvMewtZuUSEMiyBpwtpaJmIT6H
	 qgnmngiw5d+H1UzvzglMz0ZAVjBplRat14jfD4yt+oO/yga5NE+40LdEu29fOYmSct
	 Rm8iOF5NeitCZf4CQ8jw4J+FhK+RY0tzKlZXnEErUOWvdIukxEqlWUGRoLHxy2z1p5
	 mi+qI1A2JzsyPTKRXTh4oUCoIdbGjfPBCqhw8g90cYWMZ68q+oc/C12ubV16hvXGDD
	 Ou8dawlaAMM8HDHs7z+E43L1nGOztS8d7XBDa0nql/kqTw5NyH9dmY/VVz9LSDsbtI
	 V+zKbhBzkEn6w==
Date: Wed, 10 Jan 2024 12:23:17 +0000
From: Mark Brown <broonie@kernel.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] regmap: debugfs: runtime resume a device when
 reading registers
Message-ID: <3bc9c762-3573-4d8b-bfcf-6c8e91938dcd@sirena.org.uk>
References: <20240110095358.473663-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YrSREqyZLnd3MIVp"
Content-Disposition: inline
In-Reply-To: <20240110095358.473663-1-alexander.stein@ew.tq-group.com>
X-Cookie: Do you have lysdexia?


--YrSREqyZLnd3MIVp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 10, 2024 at 10:53:58AM +0100, Alexander Stein wrote:

> If the registers shall be read from device, runtime resume it in order
> to enable a possiblly attached power domain before accessing the device.

The idea is that the debugfs interface isn't supposed to be disruptive
to the thing being debugged.  It would be better to detect if there will
be problems and report the status as busy.

--YrSREqyZLnd3MIVp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWejDUACgkQJNaLcl1U
h9BFHwf/ZWrijlLkToJHTynu3O4IYB18wvXywpEQwjFXE30JeiPzYnuaxRKGVZHX
E105Qll44Om7abfheQ3zgcCZYvcYPsFSlGHs6DN/xB8nfcJUYddFwa5HHEOjR186
6bI4EL1FUPoSGPrZZm9iS8E7Vdzq2KaN9mM4smoFaKd29hxxF3VRupXSOcfxhlbe
jmxNLudmk99uh92j+uKNo7XjRD43ZBDFNmV2+94RqNBfx2B/1X5PW5l1zTtuZHSJ
8P/RdZYN4WH+J6EGWfpdDWbiy2iK3ALHOuvAaEHt1/NI+FhhceHmWJRstP2uyqfW
ns93lBGVs3eEgSLVB7uZpX2pgZCfWA==
=47IP
-----END PGP SIGNATURE-----

--YrSREqyZLnd3MIVp--

