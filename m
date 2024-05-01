Return-Path: <linux-kernel+bounces-165330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D398B8B59
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 817FD1F219C0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD2A12EBE8;
	Wed,  1 May 2024 13:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GW741CxZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3735E537E8;
	Wed,  1 May 2024 13:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714570732; cv=none; b=PA8U5z6141QpTV8pXyz0i+qB8DdxEznRHZFN2n0MMoWWQbFAPVRIHeedq1viYTyyQY9FPqf4NyFs0yRgJIm2k4KCVkMLq0dmuuk3c2l4PKl+pJ9lxG+Rn2zfOYTWlQtso7RtWrNDPPfXMRxJzVPJlDNsNfx53lTsU8A5bqwpjpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714570732; c=relaxed/simple;
	bh=j0oaQ8b47fGiXoQlbs/2U1ga1tXrWq7nIrgqSM7Za1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CmJcMpG56Qbr0pdXyGtzPjfKj2Ul3xl5t8cwYoZ/pp/3MUSbboxvl5Hj3RVqMMV98TM7E6WwiYUxTKomOfE2oulhCXfOP+FYqYUvQRsb13yipF1NhV0ujB/gcN5j2L16h8FORA/AqAXs2ibm+qontl+DV8V1/ddr0SnREt299/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GW741CxZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C85C113CC;
	Wed,  1 May 2024 13:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714570731;
	bh=j0oaQ8b47fGiXoQlbs/2U1ga1tXrWq7nIrgqSM7Za1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GW741CxZ3vifngI4De6WtyUszYUnbUF3hcVnflui8DwaQMnptn1KTphlQd1wDQSH4
	 HL2RP9djbjlJlmfyMBCrOo0medLFXas7ibGFzlwRaobxmvvAlbx4Q0btbQyxCYAM35
	 JNiu25EVCpdtE15BMAsSHOChyitP9zQ+6Rlx8oD+0bMjR16vra8ySUk9kKX6ng+u7L
	 6xhaA9f0dEjRJN+5Q1d5DffXUnM30RWvjK+Oz8Rv4GwEVucGUUXHigZokqmgCg680W
	 1szCk3uDNk4MNrDF+rnwms9Y/juOpLuzo+csurFlHjeWhiw8xZnj1NJC0Bq6w92BRc
	 31spcPZJH90/Q==
Date: Wed, 1 May 2024 14:38:47 +0100
From: Conor Dooley <conor@kernel.org>
To: Petar Stoykov <pd.pstoykov@gmail.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Angel Iglesias <ang.iglesiasg@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: pressure: Add Sensirion SDP500
Message-ID: <20240501-glare-cyclist-14ecbafde79d@spud>
References: <CADFWO8GC6RP6A7H-Cq5UZHfBY3VJZTCqssdZet61hH031euhwQ@mail.gmail.com>
 <20240430-unnamable-wrench-16c9ad780df1@spud>
 <CADFWO8FnMh3OSXO5c9YnafDEf8dxu7MHuH-J32H_Dgx4VSZ=Tw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Fk66tp7xhewH+tVB"
Content-Disposition: inline
In-Reply-To: <CADFWO8FnMh3OSXO5c9YnafDEf8dxu7MHuH-J32H_Dgx4VSZ=Tw@mail.gmail.com>


--Fk66tp7xhewH+tVB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 01, 2024 at 02:06:12PM +0200, Petar Stoykov wrote:
> On Tue, Apr 30, 2024 at 6:50=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> > On Tue, Apr 30, 2024 at 05:27:20PM +0200, Petar Stoykov wrote:

> > Other than the fact that a fallback compatible might be required here,
> > this looks like a candidate for trivial-devices.yaml.
>=20
> This sounds like a more serious comment. We will definitely continue using
> this driver internally for now. But do you think it's still worth adding
> it as a separate driver instead of leaving it for "trivial-devices"?
> It has been a useful driver for us so we thought it is worth sharing.

trivial-devices.yaml is about the binding, not the driver - you still
get to have a dedicated driver.

--Fk66tp7xhewH+tVB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjJF5wAKCRB4tDGHoIJi
0o+gAQCAjJNBaPvE1tePTSvrQrNPkm1gpvxWn+P66psNWKhgigD7BIRgbvhUSX3H
9/FpdL6lj2GbRaaZYapsd1BkR9c4Fgc=
=YMTs
-----END PGP SIGNATURE-----

--Fk66tp7xhewH+tVB--

