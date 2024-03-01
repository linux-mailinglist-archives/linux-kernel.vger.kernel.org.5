Return-Path: <linux-kernel+bounces-88690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C42386E566
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 932B21F22C17
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEC37173C;
	Fri,  1 Mar 2024 16:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qAWYWgKW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5B971723;
	Fri,  1 Mar 2024 16:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709310215; cv=none; b=Rw0J6LlFFpS+RPqV0Buef56lb54UAUjPv5b9lXyzLZvF7t/67bRwoCxOgFGhGnImVmWMiIh399HBwlFG4Q6+INUTFBsoOhnQBDE73jX9MZAtdrEpU65UDU0nQF7zKX1wP72wltnesX2u2zBYwjCyDpGknkmB5puAXHPitdZOpag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709310215; c=relaxed/simple;
	bh=RscPVpBVXQTjgLx4AVtkDBetgZa3PwgrTnXE4Ytt5LI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tvep6uLXL+kOuKyNuUHfbuZncTwnNdVTAgP0TziQvBWb3OXGH5gV2hShTktY9Es2XooeLgq65d4M13GECuw62vLh+TgB7vmFkVOHl2ZQaYTdA9LJn3frQSdlqXykFK1sgDPfDhJJh4gUNDklq3J0hMldfd7q6A3Y2oszmlyt07U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qAWYWgKW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB936C433F1;
	Fri,  1 Mar 2024 16:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709310215;
	bh=RscPVpBVXQTjgLx4AVtkDBetgZa3PwgrTnXE4Ytt5LI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qAWYWgKWR46imHIWTbUTXwEWJX9VEMJiyL2E7t653iNAC1A7s0Xqw2lS64yXiddqm
	 XzApDE9AG1cE5xTCg/n+CD6tpS5lE50hIZxWb2wUOKQOywhnrmImqK2iNk6w0DUywc
	 RQjLJLKUFka6pTWwq+9MCUVU/MO/1oY80wUwsfwAb79wuOqj5T21W1BZuqWakiVwNO
	 fui6qQzsNLeDshtWnbYKdWuOBIANpwBH2I7IhAogHJOskVp1TQd3xNEnXA8DzduG+x
	 1gO/HVJVCHM6Ax7cRg34rxqxIbFjZiMKJtRs4pIKNQNgPOu118ZNnPQOEvdv8+GTNn
	 avu68GeDou8Dg==
Date: Fri, 1 Mar 2024 16:23:30 +0000
From: Conor Dooley <conor@kernel.org>
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: mdf@kernel.org, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-fpga@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: altera-fpga2sdram-bridge: Convert to
 dtschema
Message-ID: <20240301-uphold-numerous-305c3702805b@spud>
References: <20240301161648.124859-1-animeshagarwal28@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YxSL1ja5VovT/CjZ"
Content-Disposition: inline
In-Reply-To: <20240301161648.124859-1-animeshagarwal28@gmail.com>


--YxSL1ja5VovT/CjZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Fri, Mar 01, 2024 at 09:46:43PM +0530, Animesh Agarwal wrote:
> Convert the altera-fpga2sdram-bridge bindings to DT schema.
>=20
> Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
> ---
>  .../fpga/altera-fpga2sdram-bridge.txt         | 13 -----------
>  .../fpga/altera-fpga2sdram-bridge.yaml        | 23 +++++++++++++++++++
>  2 files changed, 23 insertions(+), 13 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/fpga/altera-fpga2sd=
ram-bridge.txt
>  create mode 100644 Documentation/devicetree/bindings/fpga/altera-fpga2sd=
ram-bridge.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bri=
dge.txt b/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.t=
xt
> deleted file mode 100644
> index 5dd0ff0f7b4e..000000000000
> --- a/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.txt
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -Altera FPGA To SDRAM Bridge Driver
> -
> -Required properties:
> -- compatible		: Should contain "altr,socfpga-fpga2sdram-bridge"
> -
> -See Documentation/devicetree/bindings/fpga/fpga-bridge.txt for generic b=
indings.
> -
> -Example:
> -	fpga_bridge3: fpga-bridge@ffc25080 {
> -		compatible =3D "altr,socfpga-fpga2sdram-bridge";
> -		reg =3D <0xffc25080 0x4>;
> -		bridge-enable =3D <0>;
> -	};
> diff --git a/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bri=
dge.yaml b/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.=
yaml
> new file mode 100644
> index 000000000000..88bf9e3151b6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.yaml
> @@ -0,0 +1,23 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/fpga/altr-fpga2sdram-bridge.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Altera FPGA To SDRAM Bridge Driver
> +

You're missing maintainers: (shouldn't dt_binding_check complain?)

> +properties:
> +  compatible:
> +    enum:
> +      - altr,socfpga-fpga2sdram-bridge
> +
> +required:
> +  - compatible
> +

Missing "unevaluatedProperties: false".

> +examples:
> +  - |
> +    fpga_bridge3: fpga-bridge@ffc25080 {
> +        compatible =3D "altr,socfpga-fpga2sdram-bridge";
> +        reg =3D <0xffc25080 0x4>;
> +        bridge-enable =3D <0>;

This has not been documented in your binding. You need a ref to
fpga-bridge.yaml. Did you test this patch?

Cheers,
Conor.

> +    };
> --=20
> 2.44.0
>=20

--YxSL1ja5VovT/CjZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeIBAgAKCRB4tDGHoIJi
0iJAAQDDJuMdfxauTAhhp+iYirA+jQjOuNlPeCK7ClcoTKzb3AD/fBRU/wSm7y0r
1NKqN+OtLuM7C+Cjrtin6Sr+PW2A+QE=
=zspR
-----END PGP SIGNATURE-----

--YxSL1ja5VovT/CjZ--

