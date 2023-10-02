Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821807B534A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 14:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237082AbjJBMdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 08:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236192AbjJBMdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:33:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D3083;
        Mon,  2 Oct 2023 05:33:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC60EC433C7;
        Mon,  2 Oct 2023 12:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696250000;
        bh=zfM1FqvsBwWNXsM+SVd6ihu1DKnhV/P5iAlzz0qeemA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m2RSUZGpGw9lATIoLt4u3m/ZV8mhpV8IrIGxhGHrXCRX+Nd0hyaWxSivGnZOAAQZG
         jjkPr8+uLuYIAEx8otwRk/IkYJJGZaY/frffJsC4Q6KRjfdxib+tscwOVtNdfsdWU8
         qtvyv6Oj+2wELOc7F9hK0Y9wZCE42R3wnndkMH23+jwyznYbIb00XIbsNJaoxIwSF4
         NGsWPFmp2mwiz6vp9A0rpIqbH2QiQqH0eNZFAMPKW/reuC90k1itfL5zrho6DYjRm0
         h9QqbeQI427K9AcqWyZOti50by70FXRLJjV/XScTmXnYWm3pdCOFCCBWsXqap6rYsZ
         SKfV1aUa6vNAg==
Date:   Mon, 2 Oct 2023 13:33:16 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Vincent Huang <vincent.huang@tw.synaptics.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: input: syna,rmi4: Make
 "additionalProperties: true" explicit
Message-ID: <20231002-reluctant-justice-0c3f63a12ac3@spud>
References: <20230926144249.4053202-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ofFuOQomLN1dqN2A"
Content-Disposition: inline
In-Reply-To: <20230926144249.4053202-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ofFuOQomLN1dqN2A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2023 at 09:42:44AM -0500, Rob Herring wrote:
> Make it explicit that the not yet documented child nodes have additional
> properties and the child node schema is not complete.

Guess I missed this patch while reviewing the other additional property
stuff. Seems like an odd binding with the "Other functions, not
documented yet", but seems to be a relic of the original text bindings?
Patch seems reasonable in that context..
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/input/syna,rmi4.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/input/syna,rmi4.yaml b/Doc=
umentation/devicetree/bindings/input/syna,rmi4.yaml
> index 4d4e1a8e36be..b522c8d3ce0d 100644
> --- a/Documentation/devicetree/bindings/input/syna,rmi4.yaml
> +++ b/Documentation/devicetree/bindings/input/syna,rmi4.yaml
> @@ -164,6 +164,8 @@ patternProperties:
> =20
>    "^rmi4-f[0-9a-f]+@[0-9a-f]+$":
>      type: object
> +    additionalProperties: true
> +
>      description:
>        Other functions, not documented yet.
> =20
> --=20
> 2.40.1
>=20

--ofFuOQomLN1dqN2A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRq4jAAKCRB4tDGHoIJi
0i7xAP4h0c0cCWdV4Op0A+o6eLbX18g5HkRKL/jiSzOzCzfMpgD9Gls2PjWYu+b2
H9lHe1cmUy4dpxo4eaoB8nVVK0fatQk=
=EiZ4
-----END PGP SIGNATURE-----

--ofFuOQomLN1dqN2A--
