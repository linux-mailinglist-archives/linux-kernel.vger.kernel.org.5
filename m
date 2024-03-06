Return-Path: <linux-kernel+bounces-94351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A75CA873DD4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B79AB23AC5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C23613C9C9;
	Wed,  6 Mar 2024 17:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="thRr20yN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA3F135418;
	Wed,  6 Mar 2024 17:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709747590; cv=none; b=rjRYxu0Pm/IbqjHW3wYDuNV8zunBj/CcYeLVvlrrQOlg9mlfsO4d310AQTdRojJTWmQdkOqUxhXI4lFZ/CxM+E4rbMUIl8FdQOP79TG+yjyEYH6zcCdgS1SKsL2WB6XNZaFJHFK/Kd3RHrQMb9LhNsoeqw142TlhJ38gEidxc48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709747590; c=relaxed/simple;
	bh=J4pW+9sn+ycWvhZXkL8EDJX7Gbm1CDDis3/1Tf2LG7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4UjCaGfDP+zjoeRK+RMgT+JzWmVUOCYAw78nwOHOVoN+E0svbpXrrhRX7YFvgMrAnhz+s3pFNkjQCFdI2z0d+R7Tp1Jew6cyZ9MZRvDgM2dig3lYBjIWGPb9oUAov4yM6LeNWCfNAfsrLwIG1s1vEYHXtmddwo5csuRyz/BE7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=thRr20yN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F7CC43390;
	Wed,  6 Mar 2024 17:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709747590;
	bh=J4pW+9sn+ycWvhZXkL8EDJX7Gbm1CDDis3/1Tf2LG7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=thRr20yNSs4YSLr3Z1rnir4XCdj3nBoHgNa3v8yaRVIvQFRJtI097Cduh7FfZcAoE
	 xu9xdwUhWWOio8ea1MIRPpUeEoPJrgp/pzWYLAXRmFM34BUW0quSOcBGJcViRuT+/a
	 lt9qTqmDGD6Z7j6/sZ+i5eaMJlMNev28SPLM0/XgE7WLHWqU/RvsZJ8xbVhUJSGfHw
	 V8lSsd3xiS9QA6l0wVc34z5bFyyOCQwShYW1RRBKpetgo8c7VdH6cb5LZVPijsz0wd
	 EOC0ya/lRtQxeYyEclJ0tq0ZgiMj9pL/YvkZoeFSd/erCYHF37Lz50wllgP+KdBwEy
	 nALwWxPEiAgFg==
Date: Wed, 6 Mar 2024 17:53:05 +0000
From: Conor Dooley <conor@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
	git@xilinx.com, Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	"open list:REAL TIME CLOCK (RTC) SUBSYSTEM" <linux-rtc@vger.kernel.org>
Subject: Re: [PATCH v2] dt-bindings: rtc: zynqmp: Add support for
 Versal/Versal NET SoCs
Message-ID: <20240306-mystify-playset-5b4ae2f955f3@spud>
References: <70b646d60f53cccc734afbc7f22245d53394075e.1709728587.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="p/fOP0/kzkjNlStW"
Content-Disposition: inline
In-Reply-To: <70b646d60f53cccc734afbc7f22245d53394075e.1709728587.git.michal.simek@amd.com>


--p/fOP0/kzkjNlStW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2024 at 01:36:34PM +0100, Michal Simek wrote:
> Add support for Versal and Versal NET SoCs. Both of them should use the
> same IP core but differences can be in integration part that's why create
> separate compatible strings.
>=20
> Also describe optional power-domains property. It is optional because pow=
er
> domain doesn't need to be onwed by non secure firmware hence no access to
> control it via any driver.
>=20
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>=20
> Changes in v2:
> - Change subject
> - Add compatible string for versal and versal NET
> - Update commit message to reflect why power domain is optional.
>=20
>  .../devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml          | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml b=
/Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml
> index d1f5eb996dba..5652df8ec121 100644
> --- a/Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml
> +++ b/Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml
> @@ -18,7 +18,10 @@ allOf:
> =20
>  properties:
>    compatible:
> -    const: xlnx,zynqmp-rtc
> +    enum:
> +      - xlnx,versal-rtc
> +      - xlnx,versal-net-rtc
> +      - xlnx,zynqmp-rtc

You sure chief? I don't see a driver patch alongside this adding these
new versal compatibles there, so should these versal compatibles not
fall back to the zynqmp one?

Thanks,
Conor.

> =20
>    reg:
>      maxItems: 1
> @@ -48,6 +51,9 @@ properties:
>      default: 0x198233
>      deprecated: true
> =20
> +  power-domains:
> +    maxItems: 1
> +
>  required:
>    - compatible
>    - reg
> --=20
> 2.36.1
>=20

--p/fOP0/kzkjNlStW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeitgQAKCRB4tDGHoIJi
0lR0AQDThWJ+9/UbQ2HAJQImVzfkdbfv85FsDZpRODFQwqT+BwD9GMputTe1LtAz
1aZaDasFqMBFJ8Tn1IH6vfz8bq6C8AY=
=m8/k
-----END PGP SIGNATURE-----

--p/fOP0/kzkjNlStW--

