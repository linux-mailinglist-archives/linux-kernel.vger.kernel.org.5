Return-Path: <linux-kernel+bounces-3419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77380816C09
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A78E91C22F08
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CA319459;
	Mon, 18 Dec 2023 11:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+QCe0tq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05BF19447;
	Mon, 18 Dec 2023 11:17:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 886C4C433C8;
	Mon, 18 Dec 2023 11:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702898240;
	bh=jhT+AlpmCfyK9JZxXxSNykpbsTEk5+SjdjTlfBVIDyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O+QCe0tqd2vCDzVikw7J9kmofQTYq3GGZXkDl0HrxHbP1Csw36LyitHS1Fl3/fn4f
	 X5BlFoR5vj6mSuaRKiIFqYBaHds9gAO0Y0KwFHSUDWtN1BmbV70TSciYR4o8q7p9Nu
	 IPrsqG2MlzFfWaqSuRZjdheUCQu18z8ek6PjY7tX9LvBlb9vDKajJCWsUEEJ0H7SSl
	 /M3CaAd/COStCa5jev190of+EqNRFOJDciB+Qz3/mEC7YSTF1wraxrvY+pJc+n6FPn
	 ipb0gXtTglGe5lIfg2DW62WORWLnqgbxlcS8m/SA72azZfkd6AJEqjFeCQCB7FSh1U
	 7LMWLxFyMB0ig==
Date: Mon, 18 Dec 2023 11:17:16 +0000
From: Conor Dooley <conor@kernel.org>
To: Joshua Yeong <joshua.yeong@starfivetech.com>
Cc: jeeheng.sia@starfivetech.com, leyfoon.tan@starfivetech.com,
	jassisinghbrar@gmail.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: mailbox: starfive: Add StarFive Meu
 Mailbox Driver
Message-ID: <20231218-pawing-unripe-e45ad62ff8c7@spud>
References: <20231218061201.98136-1-joshua.yeong@starfivetech.com>
 <20231218061201.98136-3-joshua.yeong@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aQrXQ+3ue3EP+Cq/"
Content-Disposition: inline
In-Reply-To: <20231218061201.98136-3-joshua.yeong@starfivetech.com>


--aQrXQ+3ue3EP+Cq/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 02:12:00PM +0800, Joshua Yeong wrote:
> The StarFive Meu Mailbox allow communication between AP and SCP cores
> through mailbox doorbell.
>=20
> Co-developed-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
> Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> ---
>  .../bindings/mailbox/starfive-meu.yaml        | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/starfive-me=
u.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/mailbox/starfive-meu.yaml =
b/Documentation/devicetree/bindings/mailbox/starfive-meu.yaml
> new file mode 100644
> index 000000000000..dbc5cfdb90ff
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/starfive-meu.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mailbox/starfive-meu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive MEU Mailbox Controller
> +
> +maintainers:
> +  - Jee Heng Sia <jeeheng.sia@starfivetech.com>
> +  - Joshua Yeong <joshua.yeong@starfivetech.com>
> +
> +description: |
> +  StarFive's Message-Exchange-Unit (MEU) is a mailbox controller that ha=
s 62
> +  independent doorbells. Each MEU channel consist of 31 doorbells and co=
nsist of
> +  a pair of Tx/Rx links that shall communicates with remote processor. T=
he
> +  sender set the bit in the SET register to indicate data readiness for =
the
> +  receiver. An interrupt will be raised whenever receiving notification =
doorbell
> +  from remote processor. The receiver will clear the bit in the CLR regi=
ster
> +  upon handling the doorbell notification. The sender should poll the ST=
AT
> +  register before starting any transaction to ensure all on-going doorbe=
lls are
> +  processed.

What is/are the consumer(s) of this mailbox?
Is part of your RPMI implementation?

Cheers,
Conor.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - starfive,jh8100-meu
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    items:
> +      - description: mailbox0
> +      - description: mailbox1
> +
> +  '#mbox-cells':
> +    description: represents index of the mailbox/doorbell paired channel
> +      channel  0 - 30 for mailbox0 doorbell
> +      channel 31 - 61 for mailbox1 doorbell
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - '#mbox-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    soc {
> +        #address-cells =3D <2>;
> +        #size-cells =3D <2>;
> +
> +        meu: mailbox@1f370000 {
> +            compatible =3D "starfive,jh8100-meu";
> +            reg =3D <0x0 0x1f370000 0 0x8000>;
> +            interrupts =3D <170>, /* Mailbox0 */
> +                         <171>; /* Mailbox1 */
> +            #mbox-cells =3D <1>;
> +        };
> +    };
> +
> +...
> --=20
> 2.25.1
>=20

--aQrXQ+3ue3EP+Cq/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZYAqPAAKCRB4tDGHoIJi
0pAWAP0UxVroFOC8+v7rhvp42LiCfmH/2N8IRe7QzwShM9OO+wD/ZYMubBEEwj3W
kqYsynjngk1KxjeF1Ez0nidDqz9ndgQ=
=vSfH
-----END PGP SIGNATURE-----

--aQrXQ+3ue3EP+Cq/--

