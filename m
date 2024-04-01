Return-Path: <linux-kernel+bounces-126621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BA5893A77
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 12:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72E0628213C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 10:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474EF20B2E;
	Mon,  1 Apr 2024 10:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/djbk+g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7941B1119E;
	Mon,  1 Apr 2024 10:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711969032; cv=none; b=aDU7H4wU/tgMDJw9MO+agb2DBa3QN1NASwfk2sryDpIcJFSG//BSBFEetf/y7G/RwxEJSpSYM7+3ORHzdFUrFzd4g9a58tM9HDkFsCj8UR0CpGBB9d1OVLD+c/82RCXYKyUlHi08nGzWQ/aSmkAZ/5OoXCR8G7v/lP8pw4CEPxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711969032; c=relaxed/simple;
	bh=jRpsWbogVcg8DoKpQah04JxMdsxc7vRxdIryL7nab6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rzq3RUqxr9XGCMO+5vJb3Amt6xRlixmKadLIzLjyEmct+Q/BANDEItDHPNHGcA8DyzXoqm7mPEHDW8Ce2XKt2xm97rNjY7P53+n7hq4+Vkp+AYaxD3DrhQvnyZFhI/uzJoenqjm/rkxDztYfl2DRiuEgann377tbUJ9yh+JQmbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/djbk+g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F3B3C433C7;
	Mon,  1 Apr 2024 10:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711969032;
	bh=jRpsWbogVcg8DoKpQah04JxMdsxc7vRxdIryL7nab6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c/djbk+ghlpRgAenqvHBKE4TEWj87ADVeCFBn3COGbgOd7/Vswne2os0bEPG4LWWi
	 YN/IaR8x6cc63nvEloNlErjooCpL6BuMTIdhbvxxoYBbX6AhAh9D3RwxZnUSgk/sFU
	 PlCN6kqEY5pz9inQ7ioBKU9iD0g9SnY2phljw+qM/qqQU5srjbPvJ9HrqvcgfVSRqg
	 JFW/FnBdk8l1oXTnXdVZ8emdeavgqncqKvTmgh8SqX3Cl0oGSjXtx6vv5uLe8WJHlh
	 5/TF6Vw9ThXY665tYa30gjpfX7+Zd/RZSkLakO+pS1W8Z+bFJHmraYbc1NHZflpmoj
	 01NKbbHUWs4Qw==
Date: Mon, 1 Apr 2024 11:57:07 +0100
From: Conor Dooley <conor@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
Subject: Re: [PATCH v2] dt-bindings: usb: qcom,pmic-typec: update example to
 follow connector schema
Message-ID: <20240401-ridden-handpick-2185d8dd02f6@spud>
References: <20240331-typec-fix-example-v2-1-f56fffe4f37c@linaro.org>
 <2024033109-reporter-blooming-5217@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PJKCTyDDSgQqIlcd"
Content-Disposition: inline
In-Reply-To: <2024033109-reporter-blooming-5217@gregkh>


--PJKCTyDDSgQqIlcd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 31, 2024 at 09:17:20AM +0200, Greg Kroah-Hartman wrote:
> On Sun, Mar 31, 2024 at 12:21:15AM +0200, Dmitry Baryshkov wrote:
> > Update Qualcomm PMIC Type-C examples to follow the USB-C connector
> > schema. The USB-C connector should have three ports (USB HS @0,
> > SSTX/RX @1 and SBU @2 lanes). Reorder ports accordingly and add SBU port
> > connected to the SBU mux (e.g. FSA4480).
> >=20
> > Fixes: 00bb478b829e ("dt-bindings: usb: Add Qualcomm PMIC Type-C")
> > Reported-by: Luca Weiss <luca.weiss@fairphone.com>
> > Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> > Update examples to follow usb-c-connector schema wrt. ports definitions.
> > ---
>=20
> Hi,
>=20
> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> a patch that has triggered this response.  He used to manually respond
> to these common problems, but in order to save his sanity (he kept
> writing the same thing over and over, yet to different people), I was
> created.  Hopefully you will not take offence and will fix the problem
> in your patch and resubmit it so that it can be accepted into the Linux
> kernel tree.
>=20
> You are receiving this message because of the following common error(s)
> as indicated below:
>=20
> - You have marked a patch with a "Fixes:" tag for a commit that is in an
>   older released kernel, yet you do not have a cc: stable line in the
>   signed-off-by area at all, which means that the patch will not be
>   applied to any older kernel releases.  To properly fix this, please
>   follow the documented rules in the
>   Documentation/process/stable-kernel-rules.rst file for how to resolve
>   this.
>=20
> If you wish to discuss this problem further, or you have questions about
> how to resolve this issue, please feel free to respond to this email and
> Greg will reply once he has dug out from the pending patches received
> from other developers.

I'm not sure that something updating the example like this needs to go
to stable in the first place.

--PJKCTyDDSgQqIlcd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgqTAwAKCRB4tDGHoIJi
0o+3AQD8d/HFel0B33OnmX67qk+scHD8c2BNetJjW+qY+jRRxQEAwn45hbTGUfQw
VuD6+9irOwAu5NYApjR2fFjnA4BcsQE=
=l7ox
-----END PGP SIGNATURE-----

--PJKCTyDDSgQqIlcd--

