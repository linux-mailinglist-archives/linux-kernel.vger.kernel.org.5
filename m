Return-Path: <linux-kernel+bounces-35388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F497839038
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2886283BE1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2995EE96;
	Tue, 23 Jan 2024 13:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGw5zGFA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6125FB8F;
	Tue, 23 Jan 2024 13:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706016642; cv=none; b=hFY+HlTly1S4UM+cB1JxPoTch3mOH7CNlJ6gxF8pun6NQYGFZa96FHkveLy8b94RvL1ASY89eeXjyWicZenrybXG2vkdlB9RrkWjTa0YNugnl3v1+3l4MzE0HhkOejFQ+8MURWmvHzDfR7n1P/WkxpxQwOBvkMTct3l3UedrSu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706016642; c=relaxed/simple;
	bh=KibFd8MBsZByh8wCB8U6lrdmc1z1Zxybm7RMOqyABPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDiMFI8V2aOezeNfAMTdpQhwlXffsNvNuYIHNLrJf8dxDC5RltPn54/sTHqjQpQd5br+aBtlfPELrqQrIegVWgxWz+2/Qz4MpV/a4/VvD/M1yYZSDVzYGS8D70aZqSyqBqha1FiorTM4nX1cM+PtiZIJAcRX1NqnP8HOeBUtIQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGw5zGFA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F576C433B2;
	Tue, 23 Jan 2024 13:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706016642;
	bh=KibFd8MBsZByh8wCB8U6lrdmc1z1Zxybm7RMOqyABPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nGw5zGFANiFKDc3iZ0ueCZ7ClysP/2NF3ZdjrnZL5coRBEPyjzsYvjlnePgGD2sCF
	 Y3Agq+tRsz24/qZtAjyo8hKEfDdaH5KOfUZnlbU9WZRyJfaXaUBt22HSx22oLXkLxq
	 UavKTCxR8hXfsvmORiTAGLn090CrSAONTB4sInp1T/41ESPCjyhvxSi8gUWtVjXHPa
	 mFBkVU+5F8ObhR+tyw9zhLS6genFhYBZjSr0A5fa5wtChksFLRJd1u7PSFbiFNeJSf
	 uFVlrxzw3hwj9sMj2JbGJGEluGW8WxlKXsbRR/H+/2dsS7KxdXfyiAZCptkh8XwhkC
	 YY7O5Gr0SHnVg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rSGre-000000005bR-4ANN;
	Tue, 23 Jan 2024 14:30:55 +0100
Date: Tue, 23 Jan 2024 14:30:54 +0100
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] ASoC: qcom: volume fixes and codec cleanups
Message-ID: <Za-_jrByhGnKJo66@hovoldconsulting.com>
References: <20240119112420.7446-1-johan+linaro@kernel.org>
 <170596045016.161959.16318695944363636291.b4-ty@kernel.org>
 <Za9xnEXYczA5rsw3@hovoldconsulting.com>
 <93fee0e1-ce92-4aba-8e4b-0861f78c32c9@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EIzISCNBNizK6IyV"
Content-Disposition: inline
In-Reply-To: <93fee0e1-ce92-4aba-8e4b-0861f78c32c9@sirena.org.uk>


--EIzISCNBNizK6IyV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 01:05:21PM +0000, Mark Brown wrote:
> On Tue, Jan 23, 2024 at 08:58:20AM +0100, Johan Hovold wrote:
>=20
> > Could you consider applying at least patches 1/4 and 3/4 for 6.8 as
> > well?
>=20
> Please check git and resend anything you think has been missed.  When
> you resent the whole series rather than just the problematic patch that
> most likely confused b4.

Everything appears to be in your for-6.8 branch now, thanks!

The merge commit for the series does not include the volume limit patch,
so it looks like that one got applied separately before you applied the
rest of the series:

	https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/?=
h=3Dfor-6.8&id=3D7c70825d1603001e09907b383ed5d1bd283d61a0

But all four patches are there now.

Johan

--EIzISCNBNizK6IyV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCZa+/iwAKCRALxc3C7H1l
CMtpAP98w7aVuLW19jNSfZ3BUPnjVVkkmnVwtY+jMSRIelgdhQEA7KV427bhDrQn
O88Zy32EeW/p+d9Z70o4eoCMiN5wPAw=
=OcqY
-----END PGP SIGNATURE-----

--EIzISCNBNizK6IyV--

