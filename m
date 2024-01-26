Return-Path: <linux-kernel+bounces-40341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0174783DEC6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 346611C2120E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BF71D69B;
	Fri, 26 Jan 2024 16:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o6dGIpVK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7986C13FEE;
	Fri, 26 Jan 2024 16:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706286765; cv=none; b=YVOAV7Q6CXYGS+DFLT7eWrQk0San+2es1ewlB2oDlyPkRH81uVjbjKJ2+tIY6FgbHiL7siRc+3MgQIEcCzBNL8w1te+qe204l+kLEszDAxxbVicN1nvF4yJhJ3bmupdl7e+i4ehmDGPTHeeysS28Tw7eScKAGonYUWNphWvKS+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706286765; c=relaxed/simple;
	bh=O2GdFJ088dolrQz4phEpzEs0z4sl/H/4jK6u8SsoYxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VyFYnJNd2oVmAHDcm5CBiHDPd0PCYFHton1M/jW0FQKvEUkKtYd4a6v444ESR9jCmQ8UZ+u0RR+XOp/zZsewR7T6exG4Z3+fBb9xTMbcjoRdiZ1SRzaIeDQEWxbqqYKVXQjiVMpUHDHEc5eZpqavPl7sAdDqkREinNH8dSvK8Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o6dGIpVK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5ACC433F1;
	Fri, 26 Jan 2024 16:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706286765;
	bh=O2GdFJ088dolrQz4phEpzEs0z4sl/H/4jK6u8SsoYxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o6dGIpVKtE7C1XA+I7lHIazTZ9NiJvbbUwwFafXmh25g1ytRSkE++aMo/yA5defwy
	 oQrkn4rvgukDgRo9RVOOSUQGrb6Nx/cLC+ZIxgNCVoEe+KdYH5Ei3Y60VtWnuxyVz8
	 UBfCm+SAZs3JWf3BkwxTCp7SGIWOCRvbT9tYLHJ9Z5ZueoE8p5llfQrgDUJ8+NJtel
	 UsDSoDG2mYwNBdtXqElFFdE7gCdE8EmWHxHPwy+IEvaaOxUNV3snOOmegBxfMyKJE6
	 PBqWgJMS279PW/8i/FzoWJURbuw9zBdXjVsmrSH6FabK5i44n+T+0HeVEl0POw57Zk
	 MprieXZblzGVg==
Date: Fri, 26 Jan 2024 16:32:39 +0000
From: Conor Dooley <conor@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v5 1/4] dt-bindings: mailbox: fsl,mu: add i.MX95
 Generic/ELE/V2X MU compatible
Message-ID: <20240126-confirm-jawless-dca60fc9afce@spud>
References: <20240126-imx-mailbox-v5-0-7ff3a3d53529@nxp.com>
 <20240126-imx-mailbox-v5-1-7ff3a3d53529@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7mFRVebTH76qyLZi"
Content-Disposition: inline
In-Reply-To: <20240126-imx-mailbox-v5-1-7ff3a3d53529@nxp.com>


--7mFRVebTH76qyLZi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 02:29:14PM +0800, Peng Fan (OSS) wrote:
>  examples:
> @@ -134,3 +159,34 @@ examples:
>          interrupts =3D <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
>          #mbox-cells =3D <2>;
>      };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    mu2: mailbox@445b0000 {
> +        compatible =3D "fsl,imx95-mu";
> +        reg =3D <0x445b0000 0x10000>;
> +        ranges;
> +        interrupts =3D <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
> +        #address-cells =3D <1>;
> +        #size-cells =3D <1>;
> +        #mbox-cells =3D <2>;
> +
> +        sram@445b1000 {
> +            compatible =3D "mmio-sram";
> +            reg =3D <0x445b1000 0x400>;
> +            ranges =3D <0x0 0x445b1000 0x400>;
> +            #address-cells =3D <1>;
> +            #size-cells =3D <1>;
> +
> +            scmi_buf0: scmi-sram-section@0 {

If you are resending, the labels here for the section nodes are not used
and should be dropped. Ditto the "mu2" label above.

Otherwise, this looks okay to me.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> +                compatible =3D "arm,scmi-shmem";
> +                reg =3D <0x0 0x80>;
> +            };
> +
> +            scmi_buf1: scmi-sram-section@80 {
> +                compatible =3D "arm,scmi-shmem";
> +                reg =3D <0x80 0x80>;
> +            };
> +        };
> +    };
>=20
> --=20
> 2.37.1
>=20

--7mFRVebTH76qyLZi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbPepwAKCRB4tDGHoIJi
0iznAP9CgtESW4FpxQqe75d/8cvQmVeYyQVWHwa/YljMBuNyZQEAmA2R6OTld8KG
rRaZ/bC0Duc9RlGsPTSY6bfIdxHCpwg=
=cCmD
-----END PGP SIGNATURE-----

--7mFRVebTH76qyLZi--

