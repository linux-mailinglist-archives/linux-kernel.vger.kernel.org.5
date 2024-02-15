Return-Path: <linux-kernel+bounces-67596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B668856DDC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ADFAB227ED
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE91C13A869;
	Thu, 15 Feb 2024 19:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xj4aDh/w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B945DF16;
	Thu, 15 Feb 2024 19:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708025972; cv=none; b=ffompPJnM8qLgDl5Z8ic8MHpgkaW5z2DTH8zMvaUH+Kbmzfy2wp1NTBbXu/aDjkPaq9aBqtyWlxPHgwjj0viNGBD2Wt6bzywlTF6/sMwqevtQosZ0W/lzHrfMduNYHL2gXrGgyVtO4/P0LNTV2VTrbVYFJPnFA8Zoxr/W1VBKzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708025972; c=relaxed/simple;
	bh=lnJROVnckTmteDEbP/T2C4WoTvrQNTHlrX+h6G5UKQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SoPOHCSvLKFkOy+H6KsDHtdiV+MtEcLayMJHOrkxM7Trbqm4uJiuRmqNsfssPYwK0RnW+xWYogfvfdxYKVdBy5CcB/11rzP4EkI4eoF/rb3TCsM8tsciSOM03SbwnTzDUq++PCPu4aTBap9cULZ1KeTa7c4NPUNGoPpGkk9DEjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xj4aDh/w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B7DDC433F1;
	Thu, 15 Feb 2024 19:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708025971;
	bh=lnJROVnckTmteDEbP/T2C4WoTvrQNTHlrX+h6G5UKQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xj4aDh/wvg83T77RgYb8/CZYmPb03V+3YOM0ahGjqlCiHI04YTLEmtszPZEpGv6aN
	 5ujsRcBXBAFC087z4SaWgVfocoJTbzAoKbnrjsTrkra+Ix2kbDOB4EK05BJtjlpAtD
	 /AkijIN2sZiDLYEXlzwbTEqAcjGRAzVW1bYqpKa2QFm70K8YCOsR/W7yHMzsnVXLlL
	 KgGeTq+ilB+srMbqxdAb1GU802bqB0vE5CPnauB3XYXe16U6ihnobhCf4huYqGYUq6
	 qSC408dCYejb5Nh388pL59LEFbaMaE/7NEmCG4kpBSSlP/gIjIVvnnZKqU+lVgTNwn
	 uEirmsKEjH1Pg==
Date: Thu, 15 Feb 2024 19:39:26 +0000
From: Conor Dooley <conor@kernel.org>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: gregkh@linuxfoundation.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	balbi@kernel.org, Thinh.Nguyen@synopsys.com,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, git@amd.com,
	Piyush Mehta <piyush.mehta@amd.com>
Subject: Re: [PATCH] dt-bindings: usb: dwc3: Add snps,enable_guctl1_ipd_quirk
Message-ID: <20240215-crying-lunchtime-977afb05e45f@spud>
References: <1708023665-1441674-1-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n9jI1ZoH10PjuklW"
Content-Disposition: inline
In-Reply-To: <1708023665-1441674-1-git-send-email-radhey.shyam.pandey@amd.com>


--n9jI1ZoH10PjuklW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 12:31:05AM +0530, Radhey Shyam Pandey wrote:
> From: Piyush Mehta <piyush.mehta@amd.com>
>=20
> SNPS controller when configured in HOST mode maintains Inter Packet
> Delay (IPD) of ~380ns which works with most of the super-speed hubs
> except VIA-LAB hubs. When IPD is ~380ns HOST controller fails to
> enumerate FS/LS devices when connected behind VIA-LAB hubs.
>=20
> To address the above issue, add 'snps,enable_guctl1_ipd_quirk' quirk,
> This quirk set the bit 9 of GUCTL1 that enables the workaround in HW to
> reduce the ULPI clock latency by 1 cycle, thus reducing the IPD (~360ns).
>=20
> Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> ---
> In the zynqmp public database GUCTL1 bit 9 is reserved but it is used to
> enable a fix related to Inter Packet Delay in HW. The documentation team
> is working to update GUCTL1 bit 9 description.

Does this just affect the zynqmp?
If it does, then you don't need a property - do this based on
compatible.=20
If it does affect other devices, what prevents the workaround being
performed for all dwc3 controllers?

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Docum=
entation/devicetree/bindings/usb/snps,dwc3.yaml
> index 8f5d250070c7..b226457a6e50 100644
> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> @@ -280,6 +280,13 @@ properties:
>        xhci reset. And the vbus will back to 5V automatically when reset =
done.
>      type: boolean
> =20
> +  snps,enable_guctl1_ipd_quirk:

No underscores in properties please.

> +    description:
> +      When set, HW reduce the ULPI clock latency by 1 cycle, thus reduci=
ng
> +      the IPD (~360ns) and making controller enumerate FS/LS devices
> +      connected behind via-hubs.
> +    type: boolean
> +
>    snps,is-utmi-l1-suspend:
>      description:
>        True when DWC3 asserts output signal utmi_l1_suspend_n, false when
> --=20
> 2.34.1
>=20

--n9jI1ZoH10PjuklW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZc5obgAKCRB4tDGHoIJi
0l7TAQCNQRDS4vsEFSVQ8ov4nOn8FfznlW91DryqSTYqunOlVwD/f90BI+v2r4Xy
xBG6YLClNWWmnSMN2ve5dAOyW5SDeAc=
=aXB9
-----END PGP SIGNATURE-----

--n9jI1ZoH10PjuklW--

