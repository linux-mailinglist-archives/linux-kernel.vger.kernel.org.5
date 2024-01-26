Return-Path: <linux-kernel+bounces-40376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B1883DF39
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FA8F1F27514
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BE51DDEC;
	Fri, 26 Jan 2024 16:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZV36HO8n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98821EB2B;
	Fri, 26 Jan 2024 16:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706287920; cv=none; b=gj0T4SxdXcxHtSxdIPr82RrybfRxgyIO3H3c6LXvAtgjLDSp+s53sakxAS3sSSw/zdydt1a81czgW09M9Gf3ZDO+1vndlJJgq3E+8B1SXNIfnsmiPO9IPwtQb2e62YzvKbXnXz6CrxeBYRAXtutOPHMqAPGbvdMedKX5YmJ+vXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706287920; c=relaxed/simple;
	bh=GWEG1pvrI+MwWb68hTru7MaLpFsvtOWJhlMETqjxkGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tIzaV3vynA0FI/SCfW1YkkLGsSyhpO+NhFiNV/lWaiECHevi1Z23r6ns2QFWdB0z3kJ5mIOxn3CYy6+xmLMHAY4bCgc9fbKR9uu7laxR0MMELXxcChc8qVV3T2vaNgosv6K836x7yz0LOHbicSoEWnGxuq2udDfqSPbm1PXeFQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZV36HO8n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE48AC43394;
	Fri, 26 Jan 2024 16:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706287920;
	bh=GWEG1pvrI+MwWb68hTru7MaLpFsvtOWJhlMETqjxkGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZV36HO8nEh0sbpEE+al90RlqRlqtNBjdBQt/DDP/URQGyscFpkKHhNYr/DDNCjYTt
	 EvOFMtK0d4SA1Jl7evOdoLVrCjoWdjESWjc8iSS7RDJ58otXkaLdt5TW31Isj3WKwb
	 oh9SWfeZjDC+yMZz62dT/8afYb3ZGwRSAgx5is0m0S82rcRjKL/KthEpXSK1kNSisq
	 pSp1HX7ABHP5/ckiR0+SEh+Yso2BTc5bruYhEzw/yeNqlqixSRMVx9HAfTi26NEHn1
	 A03bEISaAnviWidcqxfjvEq6AGLeUCqeh3R57f4j1LhG7iRpfZ2OtcnqQ3T+jLHk2B
	 Jq3MLWPoBoeiQ==
Date: Fri, 26 Jan 2024 16:51:55 +0000
From: Conor Dooley <conor@kernel.org>
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, mazziesaccount@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: afe: voltage-divider: Add
 io-channel-cells
Message-ID: <20240126-scale-serrated-33686467d91b@spud>
References: <20240126115509.1459425-1-naresh.solanki@9elements.com>
 <20240126-cinnamon-flatware-e042b5773f17@spud>
 <CABqG17hzZf2mme0v7hALhpd6-N3ZHqxdH-AhFg5eF9sbLSC2gw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="N6MGnwo5iGnJRjKO"
Content-Disposition: inline
In-Reply-To: <CABqG17hzZf2mme0v7hALhpd6-N3ZHqxdH-AhFg5eF9sbLSC2gw@mail.gmail.com>


--N6MGnwo5iGnJRjKO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 26, 2024 at 09:55:20PM +0530, Naresh Solanki wrote:
> On Fri, 26 Jan 2024 at 21:47, Conor Dooley <conor@kernel.org> wrote:
> > On Fri, Jan 26, 2024 at 05:25:08PM +0530, Naresh Solanki wrote:
> > > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> > > ---
> > >  Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml b/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
> > > index dddf97b50549..b4b5489ad98e 100644
> > > --- a/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
> > > @@ -39,6 +39,9 @@ properties:
> > >      description: |
> > >        Channel node of a voltage io-channel.
> > >
> > > +  '#io-channel-cells':
> > > +    const: 1
> >
> > The example in this binding looks like the voltage-divider is intended
> > to be an "IIO consumer" but "#io-channels-cells" is an "IIO provider"
> > property.
> >
> > Are you sure this is correct?
> I'm not aware that #io-channels-cells is only for IIO provider.

#foo-cells properties are always for resource providers

> But I do get some kernel message as mention in commit messages
> if this is specified in DT.

Can you please share the DT in question? Or at least, the section that
describes the IIO provider and consumer?

It should look like the example:

    spi {
        #address-cells = <1>;
        #size-cells = <0>;
        adc@0 {
            compatible = "maxim,max1027";
            reg = <0>;
            #io-channel-cells = <1>;
            interrupt-parent = <&gpio5>;
            interrupts = <15 IRQ_TYPE_EDGE_RISING>;
            spi-max-frequency = <1000000>;
        };
    };

    sysv {
        compatible = "voltage-divider";
        io-channels = <&maxadc 1>;

        /* Scale the system voltage by 22/222 to fit the ADC range. */
        output-ohms = <22>;
        full-ohms = <222>; /* 200 + 22 */
    };

Thanks,
Conor.

--N6MGnwo5iGnJRjKO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbPjKwAKCRB4tDGHoIJi
0nY1AP44EPKrD/YVhzhSSSGxDT1gAA+j8QE5xfM8BbQHmjVH5wD/dC2/py8OFaCJ
D665p0DJMTkjUQnUjZlxzYNEoTJAUAk=
=YaJ5
-----END PGP SIGNATURE-----

--N6MGnwo5iGnJRjKO--

