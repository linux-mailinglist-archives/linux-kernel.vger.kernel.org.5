Return-Path: <linux-kernel+bounces-103110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8557587BB23
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A74D1F23651
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD906E614;
	Thu, 14 Mar 2024 10:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3jZCmdL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE226BFA9;
	Thu, 14 Mar 2024 10:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710411612; cv=none; b=bx9GocTXYkW/JNVgvtsuVHmNsAg4Ql1OnbPHxvJcBxSX82TVvLjUrqkRXgDhNDDpXR/6l/ag4zMgLD4NTVpFjZpiKJdV7BQIPcCi63b8T0yYECE7qw1VBNmNlR8IH8H8XwiNFK7zYPxIR/MYQEON9qhTHYz60mUsP+4yPQuTLJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710411612; c=relaxed/simple;
	bh=fBCom8ToeEHNjaY4G4ZUw7DCMQHUdPGYRbplhPNNJdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1MRZ++958csvS2MsHypkXkHpkdbxeiPoWFMB54YQ68PY4x8dIvcKnWz+RZyfBLYP7KkwYRGOuFaj8z+ipOuiOt6aGNeBW/wIOn9McKRxf4AgvP0hMaEpDOZHXqnxHc9PTZkkUnGMybV9tNG0O91OSOwgHnjUmCbNALtCkrOKh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3jZCmdL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC75C43390;
	Thu, 14 Mar 2024 10:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710411611;
	bh=fBCom8ToeEHNjaY4G4ZUw7DCMQHUdPGYRbplhPNNJdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o3jZCmdLz0MJiL87yzSPhpH3N4OXRQqpvwtPd9bkpdzIDFbwCYwOz7qazVlamnJc+
	 yvfyj1dV9jdCcGaa2v0awM+1BjEKjxj+wLxT4gc2PjRVxJVRJ2f2SUEQnSaVVtD6ps
	 c7/z+xyjToqTsVWsBsqt5zPkNgHAqmjUWZ6vqQsRMMCxOspwhO5GsymU7RWvFTgDFb
	 +aKvRsiZ5872SfRhsZIjc0oDC+e4aSn9vHs4bjYD/7+dk6ud9Ep/fhZRaWli1V9aDz
	 81OaQ/Nr0WnKXIoVwRK5UblC1CBe4vnqSUFOFHn3q74ZlTmbO7ddwNbnS3LvfUNtsG
	 EMbWa8/KuHd9g==
Date: Thu, 14 Mar 2024 11:20:09 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Sebastian Wick <sebastian.wick@redhat.com>
Cc: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Jonathan Corbet <corbet@lwn.net>, dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm: Document requirements for driver-specific KMS
 props in new drivers
Message-ID: <20240314-portable-pragmatic-weasel-7dd91e@houat>
References: <20240311155904.323488-1-sebastian.wick@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w57l5nqlkliw3m2d"
Content-Disposition: inline
In-Reply-To: <20240311155904.323488-1-sebastian.wick@redhat.com>


--w57l5nqlkliw3m2d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 04:58:58PM +0100, Sebastian Wick wrote:
> When extending support for a driver-specific KMS property to additional
> drivers, we should apply all the requirements for new properties and
> make sure the semantics are the same and documented.
>=20
> v2: devs of the driver which introduced property shall help and ack
>=20
> Signed-off-by: Sebastian Wick <sebastian.wick@redhat.com>

Acked-by: Maxime Ripard <mripard@kernel.org>

We probably want to have Dave or Sima ack on that one too

Maxime

--w57l5nqlkliw3m2d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZfLPWAAKCRDj7w1vZxhR
xfghAQC7OSZf7yywB2sm09qtEq9WVbV1okCQlxILrOaq2QR50AEAmpIZIpqTPGyg
bxCHCG25dSkSR8Z7mCnUI41Wkl38DQg=
=SJRy
-----END PGP SIGNATURE-----

--w57l5nqlkliw3m2d--

