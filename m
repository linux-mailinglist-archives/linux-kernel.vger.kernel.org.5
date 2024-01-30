Return-Path: <linux-kernel+bounces-45107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8132842BC8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5E3A282B63
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B166157E7B;
	Tue, 30 Jan 2024 18:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9lFyD3o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E9981AD5;
	Tue, 30 Jan 2024 18:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706639310; cv=none; b=LbG+hMmyzzdAJt2LKBV+He4uNU3QynVDD7F5t1qHDTxnC8GrNTZoJMZ2vBKHrXor4TuQzL7ivQPc9I57jsaf2nMMsHqZkYIuiB8Dw2Vct7TlI5o906iXiONRipmPT3JT3fqTJLqQqecTls7xafWqJ59UQGjPLPzWBMulqv/gWoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706639310; c=relaxed/simple;
	bh=422yXU7d3Zx33jspR2LuYeo1DwySHZURHM0VRf+DRa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUeneSML1yaTcytRcsIRbkd/eNJRxujgY6cVOEEICp7ZkmXHu6cT5I1wPWATwWQFu9yuyuTXUl3JFrZmtG9bY3wnOCLaAr19Ag3sOjvEcKAqe61D+kud7F/W+tvjNUyrp8qKvnMYhihD/keDzbgR50TTP9h5Egj/Quc39GtML8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9lFyD3o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F712C433C7;
	Tue, 30 Jan 2024 18:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706639310;
	bh=422yXU7d3Zx33jspR2LuYeo1DwySHZURHM0VRf+DRa4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u9lFyD3ooZqaMx+b4i2ZPoDYhF30yE+/ALvSe24+tvUan8r/9lR3p+xDu0wlvcrw2
	 Wa67DZZwa6j47D26r/LWjWxapkB0rgGpU5NAxaAT9XRoyh/RS7ZLnqlnWlngFceuqh
	 gENljd/TdUuSezTYbTY+ekn/KY3FE6kA1cPDfYlcFjQQ4vPoW9E+e4bLbh6Yp7GrHc
	 fV6F0tnB0rhSrF46/lnMYKZVQRRR4z4WymIzhPV+hMblLK89LbhVXLYvuyn9WQ//DV
	 sw46U9cgLV/xJ4ukfXlI4+MpFkqvbSVPaPz60qZsA6+joYRoEMnceHwdbj2RR4UVdb
	 9suVmd05pT9sA==
Date: Tue, 30 Jan 2024 18:28:25 +0000
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: thinh.nguyen@synopsys.com, balbi@kernel.org, devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	mark.rutland@arm.com, mathias.nyman@intel.com, pku.leo@gmail.com,
	ran.wang_1@nxp.com, robh+dt@kernel.org,
	sergei.shtylyov@cogentembedded.com
Subject: Re: [PATCH v4 2/3] dt-bindings: usb: dwc3: Add
 snps,host-vbus-glitches-quirk avoid vbus glitch
Message-ID: <20240130-eligible-barrette-5b2258e150f5@spud>
References: <20240124152525.3910311-1-Frank.Li@nxp.com>
 <20240124152525.3910311-3-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ougxCNZc1E/5Y4RR"
Content-Disposition: inline
In-Reply-To: <20240124152525.3910311-3-Frank.Li@nxp.com>


--ougxCNZc1E/5Y4RR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

This version seems to be the lastest (v4) for this binding, but went out
prior to discussion actually finishing on the v1!! of this patch, even
ignoring Rob's comment today.
Please wait for conversations to resolve before sending new versions.
I, at least, do not get paid for what I do here, so I often need well
more than a day before I can get around to clearing my review queue.
On Wed, Jan 24, 2024 at 10:25:24AM -0500, Frank Li wrote:

> From: Ran Wang <ran.wang_1@nxp.com>
>=20
> When DWC3 is set to host mode by programming register DWC3_GCTL, VBUS
> (or its control signal) will turn on immediately on related Root Hub
> ports. Then the VBUS will be de-asserted for a little while during xhci
> reset (conducted by xhci driver) for a little while and back to normal.
>=20
> This VBUS glitch might cause some USB devices emuration fail if kernel
> boot with them connected. One SW workaround which can fix this is to
> program all PORTSC[PP] to 0 to turn off VBUS immediately after setting
> host mode in DWC3 driver(per signal measurement result, it will be too
> late to do it in xhci-plat.c or xhci.c).
>=20
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> Reviewed-by: Peter Chen <peter.chen@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

Where is your changelog?

>  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Docum=
entation/devicetree/bindings/usb/snps,dwc3.yaml
> index 203a1eb66691f..8f5d250070c78 100644
> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> @@ -273,6 +273,13 @@ properties:
>        with an external supply.
>      type: boolean
> =20
> +  snps,host-vbus-glitches-quirk:

I specifically recall saying no to adding "-quirk" here, but that
might've been after this patch was sent.

> +    description:
> +      When set, power off all Root Hub ports immediately after
> +      setting host mode to avoid vbus (negative) glitch happen in later
> +      xhci reset. And the vbus will back to 5V automatically when reset =
done.
> +    type: boolean

Rob commented today on the v1 conversation:
https://lore.kernel.org/all/20240130181322.GA2079185-robh@kernel.org/

Please respond (there) to his comment.

Thanks,
Conor.

>    snps,is-utmi-l1-suspend:
>      description:
>        True when DWC3 asserts output signal utmi_l1_suspend_n, false when
> --=20
> 2.34.1
>=20

--ougxCNZc1E/5Y4RR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbk/yAAKCRB4tDGHoIJi
0pt+AQDsmO50jZctRQ5aLsZ+yZXzF35f1dAw2pYzWZrQbVmSrQEA+njvKcH8sqh0
goQW0F0wsLP4GIBXvfKmqvu2YaSz0Ac=
=Xqh1
-----END PGP SIGNATURE-----

--ougxCNZc1E/5Y4RR--

