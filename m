Return-Path: <linux-kernel+bounces-79013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0057861C41
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EA3A287BBA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F22F1448E0;
	Fri, 23 Feb 2024 19:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDnk4MTR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB151143C6A;
	Fri, 23 Feb 2024 19:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708715073; cv=none; b=ezU3KfjHnwx4SLas+2xiGzbmbTRlZyL+WfukJEmJupWEwqlL9HRrm/6fVFmhNSrBMXL7dSZmoAjHEQKn0sxarlEL9oLN58uTuFT40+EP5oX0cfnPQ8YEix758jWWlaPpVytCljh7J2b0ITZkf4n948z3feSPkHqHZbBYKxA4eE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708715073; c=relaxed/simple;
	bh=kvRBTnpXxJuiMh6rU54+PqzZxLJBaTJYWSM4jkXCnq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ieZbF9/nhtv8wCkqfY4Y/0SuYb0Sg9WBkzPc2gw7WrsZ39R58VC+jQdS9IkmyeE8Ul7ON0FsLG0ejyiIF+lSPrTA3ScLRDdg20ux3Ll+4wcX3+7jGDh8lf4krb89Ek3mQNeRMSn1bZnblaxerRvX7avTPl59rsNY0DoqML/elns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDnk4MTR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F8EC433C7;
	Fri, 23 Feb 2024 19:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708715072;
	bh=kvRBTnpXxJuiMh6rU54+PqzZxLJBaTJYWSM4jkXCnq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kDnk4MTRhS2VGtZczg90fw1dl1rw2wbHYY25dtBT/S6bDviEGFP6FaChJVlw8+5dM
	 U3W0v2XGj4uZ4NnDFbmvJjVsbT6wtStCGQSyBz4+wfkMbJj8DZejfHdad68oGb0Zjf
	 irqro+Mzzl5AevhZTzKnZhoQGJN06azAAc7E1zTpmt/hUEuuPwDrfO2T2D3xOXhDji
	 c8zwUXY8oirTcv2HtNvJz7WyIBpA4gnSh3hw+8Q5W46wkx4v0sopm/ZytISe1Y1tHq
	 JqcnKc1qHE1g67mlNL+qYRwWyyO/sBXbfWpSULAmeSD5qIMYlMDas4a3S7L6Ksk5Gr
	 tEDR6j1zqI6OA==
Date: Fri, 23 Feb 2024 19:04:26 +0000
From: Conor Dooley <conor@kernel.org>
To: =?utf-8?B?UGF3ZcWC?= Anikiel <panikiel@google.com>
Cc: airlied@gmail.com, akpm@linux-foundation.org, conor+dt@kernel.org,
	daniel@ffwll.ch, dinguyen@kernel.org, hverkuil-cisco@xs4all.nl,
	krzysztof.kozlowski+dt@linaro.org,
	maarten.lankhorst@linux.intel.com, mchehab@kernel.org,
	mripard@kernel.org, robh+dt@kernel.org, tzimmermann@suse.de,
	devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	chromeos-krk-upstreaming@google.com, ribalda@chromium.org
Subject: Re: [PATCH v2 0/9] Add Chameleon v3 video support
Message-ID: <20240223-bottle-grumpily-900dabb22491@spud>
References: <20240221160215.484151-1-panikiel@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OQjjAQm+Wl0cgy2+"
Content-Disposition: inline
In-Reply-To: <20240221160215.484151-1-panikiel@google.com>


--OQjjAQm+Wl0cgy2+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Wed, Feb 21, 2024 at 04:02:06PM +0000, Pawe=C5=82 Anikiel wrote:
>   media: dt-bindings: Add Chameleon v3 framebuffer
>   media: dt-bindings: Add Intel Displayport RX IP

I'm happy with both of these patches, but I would like others to look,
so I'll hold off leaving R-b tags until someone else has at least
looked.

Cheers,
Conor.

--OQjjAQm+Wl0cgy2+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdjsOgAKCRB4tDGHoIJi
0kdOAP9exKFk426JGBzS6e5PuRv/hRCsdMzhpIG2OVVZR71KBwEAzXMieV4HnLoJ
WwUH+i5PkLVRTB7IHnBCJVtcCpoTygs=
=COSl
-----END PGP SIGNATURE-----

--OQjjAQm+Wl0cgy2+--

