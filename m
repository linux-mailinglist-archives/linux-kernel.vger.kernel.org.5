Return-Path: <linux-kernel+bounces-48733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6E184606C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5A74B2AB59
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E3084FAC;
	Thu,  1 Feb 2024 18:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcYN3Bx+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4478E84FA4;
	Thu,  1 Feb 2024 18:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706813587; cv=none; b=G87U21DihpBrqhzL3IWYIrDkFGbij2SHT7s3oDhJg/HbHocbj03c4Bi7S4dZ+ZtmLXVuv5jJO8fENt5SbStBxoLUHoT7E8CVA8sTLB+FEErDC3WHizRQMN6apJ7Kw3YKWls6RDZ42BDHqP64+DM34RjHAsnWL17O2H2YLthMGL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706813587; c=relaxed/simple;
	bh=hn6KWUJsg7QMVb1YKITYVJPIHabhwsJrPCRKqDD8JsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfIlniwIsZLvd0s455iU/uF6MXbtT4tlnMn1TsBwZ3CrcakfKSnLtwVH5KqWnuuBIaGGBn911xhWJB2xvkOXK91hfEPRgsHz1qCpfjoLCml4P4O8OFVqHQ5EUrR+uJnhQI4UzVLDf0oK8YmUm9jkwkT25amrPrMSZb2I512nMbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcYN3Bx+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A53CC433F1;
	Thu,  1 Feb 2024 18:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706813587;
	bh=hn6KWUJsg7QMVb1YKITYVJPIHabhwsJrPCRKqDD8JsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mcYN3Bx+py4jPwGusxAPSr91dfhPbsysnAALcnrUdj/imtlQVXvZd6kBzCYS8KbJr
	 +rEACQruYT6OcH+CJOxRsBZV0Kn+8yuQ8fA/tHD6YwJTzjYkPgXTneBmgTdwCnGmv/
	 OhAhrvkbbK4GoLGg5y5PXQAdRZ/S5ytQ3ro/5r5mAe8bfKx3x4xfFHF/9Q40OpLbdr
	 l8rrY3yV9LK1deRzEmsNYIkIXNbIoFMfaeUIF2GmVsMV2W6xyujgptOhYfhb6bqbsi
	 xczhGyV3JSS7Lmfyr+4BxtfXJTCWGtnxbp/UJXCAnMoMPInIfZgNKSCmxeMOaIYaN4
	 AQt4ZAg3zpisA==
Date: Thu, 1 Feb 2024 18:53:02 +0000
From: Conor Dooley <conor@kernel.org>
To: Andrew Davis <afd@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 01/12] dt-bindings: power: reset: Document ti,sci-reboot
 compatible
Message-ID: <20240201-ambiguous-swan-a927ae8f126f@spud>
References: <20240131221957.213717-1-afd@ti.com>
 <20240131221957.213717-2-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qZaAzCjNUu3le7WH"
Content-Disposition: inline
In-Reply-To: <20240131221957.213717-2-afd@ti.com>


--qZaAzCjNUu3le7WH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 04:19:46PM -0600, Andrew Davis wrote:
> This calls into the system firmware using TI-SCI to reboot the system.
> Used as a fallback when PSCI is unable or not available to reboot
> the system.
>=20
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  .../bindings/power/reset/ti,sci-reboot.yaml   | 33 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/ti,sci-=
reboot.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/power/reset/ti,sci-reboot.=
yaml b/Documentation/devicetree/bindings/power/reset/ti,sci-reboot.yaml
> new file mode 100644
> index 0000000000000..aa628be33d122
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/ti,sci-reboot.yaml
> @@ -0,0 +1,33 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/reset/ti,sci-reboot.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI-SCI reboot controller
> +
> +maintainers:
> +  - Andrew Davis <afd@ti.com>
> +
> +description: |
> +  Some TI SoCs contain a system controller (like the Power Management Mi=
cro
> +  Controller (PMMC) on Keystone 66AK2G SoC) that are responsible for con=
trolling
> +  the state of the various hardware modules present on the SoC. Communic=
ation
> +  between the host processor running an OS and the system controller hap=
pens
> +  through a protocol called TI System Control Interface (TI-SCI protocol=
).
> +
> +  This reboot controller node uses the TI SCI protocol to perform a devi=
ce reboot.
> +
> +  Must be a child node of the associated TI-SCI system controller node.
> +
> +properties:
> +  compatible:
> +    const: ti,sci-reboot
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    k3_reboot: reboot-controller {
> +        compatible =3D "ti,sci-reboot";
> +    };

I'd drop the example since this has no use standalone and just rely on
the one in the parent. Otherwise I think this is fine.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--qZaAzCjNUu3le7WH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbvojgAKCRB4tDGHoIJi
0lQjAQD9jRgISimwK5XXqRkIOSmfbFMop/J2bMV+Hq0W/jsK4wD/V+Mx0ZYHEweK
6yVr+pLxeofwsOmv/jSXGp+DcgHJiAo=
=8HJw
-----END PGP SIGNATURE-----

--qZaAzCjNUu3le7WH--

