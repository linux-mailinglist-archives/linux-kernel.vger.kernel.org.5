Return-Path: <linux-kernel+bounces-22084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E38F8298EE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2ED71C2622F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EA747F5F;
	Wed, 10 Jan 2024 11:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFbdmt5J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3949747F46;
	Wed, 10 Jan 2024 11:23:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C84AC433F1;
	Wed, 10 Jan 2024 11:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704885804;
	bh=RCE2y0eor3dKdkA/sjI7c35eXtYn52uyvFYjl/ELECE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fFbdmt5JAETnqcBpMj304al9iIy+OKopuhuAL8TSGKC17wOLB3U0RnSvhLpcQhvOV
	 h38dNnVcUhYxNo+DMqTDLF/dhvo7rHfjz31dEGPUzs+/Vg102gdxl3dUOLPha3LEsq
	 8EYdNAiLk3uL/OqKann72I2YA9wS3jMA2echwuEDJFsk0bUktIhhg1rrLTckS9yx9H
	 DiVZZdFLcWb7t5qNNugp0MRoLjJcu3B/T3SHnkcQs/TOWdNOD5U4q+/yHcki1VwEsY
	 htIA2SwfsDx8kktKtv6xIZelEmNchGn0sJLkR0H4eDdXu259z40QNc1TZyAllcEqDY
	 yAUWl+yCsKUVw==
Date: Wed, 10 Jan 2024 12:23:21 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, ~postmarketos/upstreaming@lists.sr.ht, 
	phone-devel@vger.kernel.org, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm7225-fairphone-fp4: Enable
 display and GPU
Message-ID: <2zkiop7xg7w4vkpjpol25qna5wwbq4ja5o6iwuqh25m34k6mgd@aemrbzqgx2oe>
References: <20240105-fp4-panel-v1-0-1afbabc55276@fairphone.com>
 <20240105-fp4-panel-v1-3-1afbabc55276@fairphone.com>
 <3fdc6e74-d817-4341-bf64-9096608990d6@linaro.org>
 <CYAZ37LBKG4E.2096GKVUXN8Y2@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rxtk5satlzcpouxq"
Content-Disposition: inline
In-Reply-To: <CYAZ37LBKG4E.2096GKVUXN8Y2@fairphone.com>


--rxtk5satlzcpouxq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 12:00:23PM +0100, Luca Weiss wrote:
> On Wed Jan 10, 2024 at 11:58 AM CET, Konrad Dybcio wrote:
> >
> >
> > On 1/5/24 15:29, Luca Weiss wrote:
> > > Add the description for the display panel found on this phone and rem=
ove
> > > the simple-framebuffer that was in place until now
> >
> > Why? They should be able to coexist with a smooth-ish handoff
>=20
> Does that work upstream? I'm aware that downstream can do this but
> thought this was still missing upstream.

It depends what you call smooth-ish I guess, but KMS handles the
handover just fine. You're likely to get a flicker during the transition
though.

Either way, the DT isn't the right place to choose, you should enable
both, and the distro will choose its policy through configuration.

Maxime

--rxtk5satlzcpouxq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZZ5+KQAKCRDj7w1vZxhR
xVOLAQDvZ9TCy7oTZ8R3ORWkJYRiOzes6hRevRhddXAk7aj6JAD5ARIiiJFNSXvY
jIoRZnBI9TvNc0CDDCeZEGZ2XFkj2AI=
=AWk3
-----END PGP SIGNATURE-----

--rxtk5satlzcpouxq--

