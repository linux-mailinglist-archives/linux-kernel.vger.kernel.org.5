Return-Path: <linux-kernel+bounces-40330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7B283DE9A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5C2BB20E5A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192FB1DA40;
	Fri, 26 Jan 2024 16:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnWEJMii"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECEE1D551;
	Fri, 26 Jan 2024 16:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706286285; cv=none; b=oPIzWE3gZWhzVqwedFWKj+xgHDEy010cq3PJdzgZ0VvJfzxc8vs5nWd3K/bL7fjdVfCM9FC5A1w98g8AOIhZnRTvyv1xxBtLjcD7phjLlC/6ZINJu7QWkVOAj4m3N3ejrBkoeYhJral45EQJdtfJvgRTFHmaeiUAk9ZRduQ7AzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706286285; c=relaxed/simple;
	bh=DoqAbsfp/jXuEtftuZQHNgaz372UxSZm/KUcTkXFdmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9rWleizyDgtMP3y/mnmUU74y0Ap4eXymsdikAKPg5u84YFVTHRKRq+dWjPOusJ+LzEkn65HSwe1SQvLOIQVjAvXeHuJg2TlaYLH0NjLsz6kSqCwreb+NJf5bqDflJ+ZvajEUA9tW/eVNSNcAI+5G41ULpAEKUOHpss5iNIK420=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnWEJMii; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A1EC433C7;
	Fri, 26 Jan 2024 16:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706286284;
	bh=DoqAbsfp/jXuEtftuZQHNgaz372UxSZm/KUcTkXFdmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CnWEJMiilY1kj327erSSMTX/4WCpqilT3s9TKiE/MAD1m+mXQCvvMqEXWriQ3zA6K
	 clSMRsn8kMZWChKRCG9XamxXpY4TnBJ3MgFQ4NKPv9InPA+q5sWY90FTzrDxEq2EPt
	 9b7yshKkveUpJvF1ty3suSApmznkUd/uXXDvIlR2pQHTI8KgJyoaxBZGet693aW1V5
	 mhb79CqUe6IegisfRzBmg8vU/BNr6Y8C9cpIcPt/Fr3ulW22lL7Hz028b8vGmrWkOf
	 msifvxpbvKbRkgdDtxp2nLRTOKmwWHmGjUjFc0b/wU8BrxxHu5EGs/0vg3l9xhgNe2
	 pX7VWbflp4WCQ==
Date: Fri, 26 Jan 2024 16:24:40 +0000
From: Conor Dooley <conor@kernel.org>
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, mazziesaccount@gmail.com,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: hwmon: tda38640: Add interrupt & regulator
 properties
Message-ID: <20240126-fleshed-subdued-36bae813e2ba@spud>
References: <20240126112945.1389573-1-naresh.solanki@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qKb9f2iDT7+wsvKn"
Content-Disposition: inline
In-Reply-To: <20240126112945.1389573-1-naresh.solanki@9elements.com>


--qKb9f2iDT7+wsvKn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 04:59:44PM +0530, Naresh Solanki wrote:
> Add properties for interrupt & regulator.
> Also update example.

Feeling like a broken record, given I am leaving the same comments on
multiple patches. The commit message needs to explain why you're doing
something. I can read the diff and see what you did!

>=20
> TEST=3DRun below command & make sure there is no error.
> make DT_CHECKER_FLAGS=3D-m dt_binding_check

Same comment here as elsewhere.

>=20
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> ---
>  .../hwmon/pmbus/infineon,tda38640.yaml        | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38=
640.yaml b/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.=
yaml
> index ded1c115764b..2df625a8b514 100644
> --- a/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml
> @@ -30,6 +30,15 @@ properties:
>        unconnected(has internal pull-down).
>      type: boolean
> =20
> +  interrupts:
> +    maxItems: 1
> +
> +  regulators:
> +    $ref: /schemas/regulator/regulator.yaml#
> +    type: object
> +    description: |

The | here is not needed, there's no formatting to preserve.

=46rom a quick check, most bindings with regulator subnodes restrict the
subnode names with patternproperties. Is there a reason you have not?

> +      list of regulators provided by this controller.
> +
>  required:
>    - compatible
>    - reg
> @@ -38,6 +47,7 @@ additionalProperties: false
> =20
>  examples:
>    - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
>      i2c {
>          #address-cells =3D <1>;
>          #size-cells =3D <0>;
> @@ -45,5 +55,15 @@ examples:
>          tda38640@40 {
>              compatible =3D "infineon,tda38640";
>              reg =3D <0x40>;
> +
> +            //interrupt-parent =3D <&smb_pex_cpu0_event>;

Why is this commented out? Please either restore it or remove it (with
justification).

Thanks

Conor.

> +            interrupts =3D <10 IRQ_TYPE_LEVEL_LOW>;

Blank line here please.

> +            regulators {
> +                pvnn_main_cpu0: vout0 {
> +                    regulator-compatible =3D "vout0";
> +                    regulator-name =3D "pvnn_main_cpu0";
> +                    regulator-enable-ramp-delay =3D <200>;
> +                };
> +            };
>          };
>      };
>=20
> base-commit: ecb1b8288dc7ccbdcb3b9df005fa1c0e0c0388a7
> --=20
> 2.42.0
>=20

--qKb9f2iDT7+wsvKn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbPcyAAKCRB4tDGHoIJi
0teEAQD64Q0ot/0ME0q/yFIeuCDvMzxK6MoqCM3r57v7LnmEuAEAiHZuOa/sLQC2
SpoFQjl7IHHanVwZYyRTpwKNruahDAU=
=ZOVp
-----END PGP SIGNATURE-----

--qKb9f2iDT7+wsvKn--

