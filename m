Return-Path: <linux-kernel+bounces-123399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 214918907F7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D05A9297E52
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63611350C0;
	Thu, 28 Mar 2024 18:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amIIv37z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4AD130AF3;
	Thu, 28 Mar 2024 18:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711649146; cv=none; b=iiIR4V4CWHuFNCPpX0vW+Nu4uIL9DTPiiYh9Y18Mm25Q440qnC8j/hCd6gadK4+/QBBkpkW3YCQlcf2Vx0OGVfOsJih505ijys2ce7oQVdNfU3MpdiPViutInYArxT1swbCNoo5Nvr+bhQz5+pvSEU5FYWCGnq7UKadQGKgEUKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711649146; c=relaxed/simple;
	bh=3MqZnBO4d7QJ3guNTI35OK7E3ghU/Al0mtjXKpwqklc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7/Cro398bZwZfjrwXq/iOxut8hezHnXyFCMDjqbhRnZWMc8sLF7fIH8xa4HxT1LArAhuYavB5iSnP1pK5r6xXy1G97WvHDfCeJj8ldLcFv5CwnjZJr1l8osViSmfuLg0EgfpJmhXduGlATR6eDC6z4JtnmIPb+V5RVnwwUXiTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amIIv37z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41042C433C7;
	Thu, 28 Mar 2024 18:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711649145;
	bh=3MqZnBO4d7QJ3guNTI35OK7E3ghU/Al0mtjXKpwqklc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=amIIv37zBVYiCXIBbTF3+xg+ZHST2c8rOQqL4isDGYcoXRGb9vJcqvFpMj2GKPCoS
	 R7p75W1poh0fgdZD2kmlPQw2ZvNze/2ZFXojpmnBedZu/Az4QmyzBvkPuIQRhJUO8f
	 C9FrFHSR6dqsd77QtUr4r370E0IKL3DTZpetsTH1nJekdtcW713qbx3Ezno2ThpDCM
	 r+qhzTyrbq4yNiEp9Tlr78r0xOvlVuvbHOgG97kuTetfuLigRMDQD0xkFhRtq1K9Xn
	 Gb08gXEPodEHKVbXrdxjq0YiNe9qa0ph3z8HGmeHNEBHQiYeWkuXVARadkrYNHVB2k
	 /qmIkVFgDsfCQ==
Date: Thu, 28 Mar 2024 18:05:41 +0000
From: Conor Dooley <conor@kernel.org>
To: Allen Lin <allencl_lin@hotmail.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Rob Herring <robh@kernel.org>, dmitry.torokhov@gmail.com,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	jikos@kernel.org, benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/4] dt-bindings: input: Add Himax HX83102J touchscreen
Message-ID: <20240328-aggregate-greasily-9d57e3ebf3ce@spud>
References: <20240322-mammary-boil-f9a4c347fba1@spud>
 <20240322183009.GA1227164-robh@kernel.org>
 <20240322-rectified-udder-fef9102f58da@spud>
 <TY0PR06MB56110ADEA805B68BE2B887069E352@TY0PR06MB5611.apcprd06.prod.outlook.com>
 <20240326-whoever-spotter-1fe7ace35428@wendy>
 <TY0PR06MB561197578717990F4BEA93D29E352@TY0PR06MB5611.apcprd06.prod.outlook.com>
 <20240326-granite-snipping-7c8b04480b2e@spud>
 <TY0PR06MB5611AE812B72B349E85118D59E342@TY0PR06MB5611.apcprd06.prod.outlook.com>
 <20240327-pegboard-deodorize-17d8b0f1e31c@spud>
 <TY0PR06MB5611F7123B22C4FDEE319C049E3B2@TY0PR06MB5611.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Mfo/8yhR1A6ClAQa"
Content-Disposition: inline
In-Reply-To: <TY0PR06MB5611F7123B22C4FDEE319C049E3B2@TY0PR06MB5611.apcprd06.prod.outlook.com>


--Mfo/8yhR1A6ClAQa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 02:05:17PM +0800, Allen Lin wrote:

> OK, I will list all supplies required by the driver in the Yaml
> document as shown below,
>=20
> properties:
>   compatible:
>     const: himax,hx83102j
>=20
>   reg:
>     maxItems: 1
>=20
>   interrupts:
>     maxItems: 1
>=20
>   reset-gpios:
>     maxItems: 1
>=20
>   vccd-supply:
>     description: A phandle for the regualtor supplying IO power.
>=20
>   vsn-supply:
>     description: Negative supply regulator.
>=20
>   vsp-supply:
>     description: Positive supply regulator.
>=20
>   ddreset-gpios:

I think this should be s/dd// with the description explaining how this
display reset is related to this device.

Otherwise, this looks okay to me.

On another note - every time you reply to me I get it 3 times. Can you
fix that please?

Thanks,
Conor.

>     description: A phandle of gpio for display reset controlled by the
> LCD driver.
>=20
> required:
>   - compatible
>   - reg
>   - interrupts
>   - reset-gpios
>   - panel
>   - vccd-supply
>   - vsn-supply
>   - vsp-supply
>   - ddreset-gpios
>=20
>=20
> Thanks,
> Allen
>=20

--Mfo/8yhR1A6ClAQa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgWxdQAKCRB4tDGHoIJi
0vS2AQDVKCfNhoux/bC73lKwK5MggLxe6/BaQ+SFiWnlPp5UmwEA7qgpLq6NEiIz
Q/jEyL++OjVlGLmSuojJktze+2x77gk=
=LUxA
-----END PGP SIGNATURE-----

--Mfo/8yhR1A6ClAQa--

