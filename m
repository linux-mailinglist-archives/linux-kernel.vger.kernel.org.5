Return-Path: <linux-kernel+bounces-11502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADF281E758
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 13:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CA6D1C21444
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 12:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A952F4E62D;
	Tue, 26 Dec 2023 12:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UiOe5otO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC634E60D;
	Tue, 26 Dec 2023 12:22:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 899D4C433C7;
	Tue, 26 Dec 2023 12:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703593322;
	bh=rK4HXQ1qO1d7lh9yVCYbnNYVfqLfj8dMaZYVCapbDEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UiOe5otOvMvYx0koqhZ7MLdIUI+TtM2bnkF9reKlF/yKjx7HFT+uZ8zHAWIN3nO+O
	 Hnn6hgvpqQMf0Iky4vsYOTxHzcyHMYu9uYHhav2Adqg2FFCrcVaz0mfjxXEo/CpOaP
	 DzTypBpbKdeZAuiEM/hJvjYBIP07bqIxnvebrWIKaEX2b2N9mD3F4YMhHKKhtmJyOH
	 JzFdBnz78Ey6TmWAh7KtcQNDALXYqYQu0Ye1Cj/o1c/ZwTOJfYYQhRTwQnXYLEfuYC
	 A8+snHELHs/HflVecEvpQmXQQjhmWTCF9wo+8Oz7Sa+qaxF1NylX9E7exkOjM7wvYf
	 D1uaUc10zYYQg==
Date: Tue, 26 Dec 2023 12:21:56 +0000
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Jie Luo <quic_luoj@quicinc.com>, agross@kernel.org,
	andersson@kernel.org, konrad.dybcio@linaro.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	linux@armlinux.org.uk, robert.marko@sartura.hr,
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_srichara@quicinc.com
Subject: Re: [PATCH v4 5/5] dt-bindings: net: ipq4019-mdio: Document ipq5332
 platform
Message-ID: <20231226-twine-smolder-713cb81fa411@spud>
References: <20231225084424.30986-1-quic_luoj@quicinc.com>
 <20231225084424.30986-6-quic_luoj@quicinc.com>
 <dee72ce8-b24e-467a-b265-1b965588807f@linaro.org>
 <aeb364a3-6c05-4a1b-ba32-e687a89f20f8@quicinc.com>
 <58dde1a7-ed4a-442c-bb5c-c3f6d926fb7e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YKoQgfQHX/tQukT9"
Content-Disposition: inline
In-Reply-To: <58dde1a7-ed4a-442c-bb5c-c3f6d926fb7e@linaro.org>


--YKoQgfQHX/tQukT9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 26, 2023 at 10:28:09AM +0100, Krzysztof Kozlowski wrote:
> On 26/12/2023 08:25, Jie Luo wrote:

> >>> +  qcom,cmn-ref-clock-frequency:
> >>> +    $ref: /schemas/types.yaml#/definitions/uint32
> >>> +    enum:
> >>> +      - 25000000
> >>> +      - 31250000
> >>> +      - 40000000
> >>> +      - 48000000
> >>> +      - 50000000
> >>> +      - 96000000
> >>> +    default: 48000000
> >>> +    description: |
> >>> +      The reference clock source of CMN PLL block is selectable, the
> >>> +      reference clock source can be from wifi module or the external
> >>> +      xtal, the reference clock frequency 48MHZ can be from internal
> >>> +      wifi or the external xtal, if absent, the internal 48MHZ is us=
ed,
> >>> +      if the 48MHZ is specified, which means the external 48Mhz is u=
sed.
> >>
> >> This does not resolve mine and Conor's concerns from previous version.
> >> External clocks are defined as clock inputs.
> >=20
> > No matter the external or internal reference clock, they are the clock
> > source selection for CMN, there are only 48MHZ can be external or=20
> > internal, other clocks have the different clock rate, so the internal
> > 48MHZ reference clock can be implied when the=20
> > "qcom,cmn-ref-clock-frequency" is not defined, which is suggested by=20
> > Conor in the previous
> > comments.
>=20
> I don't think he proposed it, but maybe I missed some message (care to
> point me to his message where he agreed on usage of
> qcom,cmn-ref-clock-frequency?). I am pretty sure we both stayed on the
> same page, that the presence of clocks defines choice of internal clock.
> This property should go away.

Exactly, I wanted this property to be removed. My suggestion was about
defaulting to the internal clock when the "clocks" property did not
contain the cmn ref clock.

> It is tiring to keep discussing this.

Yup.


--YKoQgfQHX/tQukT9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZYrFZAAKCRB4tDGHoIJi
0tZUAQCG5wZXdhtGuFoHbSVtP0vu3felLI56vgP8Wu0OCd58qQEA2ambCadg33Gp
9MKVnpm0Trug6Fr9/z7dkNXJhR7+4wk=
=NGC5
-----END PGP SIGNATURE-----

--YKoQgfQHX/tQukT9--

