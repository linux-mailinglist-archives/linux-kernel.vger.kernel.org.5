Return-Path: <linux-kernel+bounces-37299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C04283ADF6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3481628D729
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB8D7CF18;
	Wed, 24 Jan 2024 16:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkpFFABp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779257A725;
	Wed, 24 Jan 2024 16:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706112474; cv=none; b=W+97xLwZ+60Qxukcj9cEW3onbfs8VwSl9uVSER9KwCxOoHN2YgzK70bjq3eMGe+c9vH6A2LxxzCdcOo5RWu2Wn77TJTLFGXzX68pO753lLCPeh3nilTM4DHPvH7EcxGgDXblqK4YsnJu70WX+t3HzK7zLMEueKYZOPY/eLnB3lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706112474; c=relaxed/simple;
	bh=T7a150d0tNI47ue4XaQznSfvq2Kxgb5U4vfbNPnQC8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJRpGgOh3VcydrvIhOr3qXUP+Cb+fWLx7aqp1/WkPx7TigNt9Q6iynQZhV21tbuzM7vZumDQYTNh8XyIL3libYFHq70G2dLOJpGJdW1iDY2PtqIKP41XEk5G+wiPciOjL7O1ywXFwSZF9m/pRK7j+UxycDvRCy4O63RUaIPHDUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkpFFABp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09351C433C7;
	Wed, 24 Jan 2024 16:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706112473;
	bh=T7a150d0tNI47ue4XaQznSfvq2Kxgb5U4vfbNPnQC8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AkpFFABpJpTm/W1yHzgIqYaAmRMtNDO5b92DqnfpJ9VvStTZi3E6ggtnDYcXTOVlB
	 iNx4pUbYzt0tcyikh5RqvEpp0BEO3jkA1R0Y/85ophbqGpAqrdZhQntlarok19SYWv
	 tawp6S6Up5fHCAESVLn9OyiV0mshvWYYRBLl+1fLzsLpWUicgiOt6d9FbsjK/td7yd
	 kk0IiuVM/FrFcaNjzCWwDQ0vJ9gmg34xBicaLGB3OaT831MO9mZ4mxl95DOVM9rx6t
	 BcvznleZzDNrXOtRRAB8BjbnRSQbKUyzkmms6eDFIC4iblaWvabJ6ChrazHprXFXF9
	 H0tXWbdwMy2sA==
Date: Wed, 24 Jan 2024 16:07:48 +0000
From: Conor Dooley <conor@kernel.org>
To: Esben Haabendal <esben@geanix.com>
Cc: devicetree@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: net: snps,dwmac: Add
 time-based-scheduling property
Message-ID: <20240124-reptilian-icing-a95b20f123be@spud>
References: <b365dc6f756a3fad4dfaa2675c98f4078aba8a55.1706105494.git.esben@geanix.com>
 <30ce8f45b8752c603acc861ebb2f18d74d2f8a07.1706105494.git.esben@geanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="orGn1OOIBTBi4VY0"
Content-Disposition: inline
In-Reply-To: <30ce8f45b8752c603acc861ebb2f18d74d2f8a07.1706105494.git.esben@geanix.com>


--orGn1OOIBTBi4VY0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 03:33:06PM +0100, Esben Haabendal wrote:
> Time Based Scheduling can be enabled per TX queue, if supported by the
> controller.

If time based scheduling is not supported by the controller, then the
property should not be present! The presence of a property like this
should mean that the feature is supported, using it is up to the
operating system.

That said, why is this a property that should be in DT? If support is
per controller is it not sufficient to use the compatible to determine
if this is supported?

Thanks,
Conor.

>=20
> Signed-off-by: Esben Haabendal <esben@geanix.com>
> ---
>  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Docu=
mentation/devicetree/bindings/net/snps,dwmac.yaml
> index 5c2769dc689a..301e9150ecc3 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -399,6 +399,12 @@ properties:
>              type: boolean
>              description: TX checksum offload is unsupported by the TX qu=
eue.
> =20
> +          snps,time-based-scheduling:
> +            type: boolean
> +            description:
> +              Time Based Scheduling will be enabled for TX queue.
> +              This is typically not supported for TX queue 0.
> +
>          allOf:
>            - if:
>                required:
> --=20
> 2.43.0
>=20

--orGn1OOIBTBi4VY0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbE11AAKCRB4tDGHoIJi
0v8wAP9TtkDEdLKEVA0n+83492ltV8gpozpt7NTDo9bSA8pPRwEAk2CFLW1Ac02u
hfaJxQ8KnrIuHQjJ9wb8ToaEVgPN9Ag=
=Q0u6
-----END PGP SIGNATURE-----

--orGn1OOIBTBi4VY0--

