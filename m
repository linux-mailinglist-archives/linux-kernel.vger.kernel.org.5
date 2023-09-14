Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79BC7A07C2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 16:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240462AbjINOs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 10:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240415AbjINOsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 10:48:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B3B1BFC;
        Thu, 14 Sep 2023 07:48:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E03C433C7;
        Thu, 14 Sep 2023 14:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694702892;
        bh=XlH2++cozlMCXeR9EvUckhmVWrwhR2yKc6Vvzh31WCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mvSBW9JAqDrz6UWIPcFcklUoKB8kHwI/5dWtybKDRXOdLDJTCLwouG0s902rAirPm
         Wql9iXKt+kKfwbKSvsWsT2yx0tKQNVDOKVtR1MFjky+IXIxinawVoF3GIi+Ol6rWPF
         Yp2TGaF2YE9xDE0fUr8Hnt64md6qHOgygQYzXMiqWapAy2ihvhl9mDDx6NZkz3ZDIL
         HzvYiU+HoZpxlVH+y8lUy7Lh6wTOXCAUVTGSsvSY5GQTU+MqB8p8zb2acxI7QJLhdp
         w7dBT5RHBaM3h2FBncEux2uO7SofWur4Gcwtqbpnj4NECdQhA1qTrWXKpy20Wavooz
         sMBoitRfxuizQ==
Date:   Thu, 14 Sep 2023 15:48:08 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Max Filippov <jcmvbkbc@gmail.com>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: serial: document esp32-uart bindings
Message-ID: <20230914-stumbling-smother-2b048381952c@spud>
References: <20230913211449.668796-1-jcmvbkbc@gmail.com>
 <20230913211449.668796-2-jcmvbkbc@gmail.com>
 <d7bf0ae3-d263-4231-9656-2b7af4b372a3@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="w5dGWB6bqtjegC91"
Content-Disposition: inline
In-Reply-To: <d7bf0ae3-d263-4231-9656-2b7af4b372a3@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w5dGWB6bqtjegC91
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2023 at 07:55:35AM +0200, Krzysztof Kozlowski wrote:
> On 13/09/2023 23:14, Max Filippov wrote:
> > Add documentation for the ESP32xx UART controllers.
> >=20
> > Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> > ---
> >  .../bindings/serial/esp,esp32-uart.yaml       | 48 +++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/serial/esp,esp32-=
uart.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/serial/esp,esp32-uart.ya=
ml b/Documentation/devicetree/bindings/serial/esp,esp32-uart.yaml
> > new file mode 100644
> > index 000000000000..8b45ef808107
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/serial/esp,esp32-uart.yaml
> > @@ -0,0 +1,48 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/serial/esp,esp32-uart.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: ESP32 UART controller
> > +
> > +maintainers:
> > +  - Max Filippov <jcmvbkbc@gmail.com>
> > +
> > +description: |
> > +  ESP32 UART controller is a part of ESP32 SoC series.
>=20
> 1. Company name?
> 2. ESP32 SoC series suggests esp32 is a series.
>=20
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - description: UART controller for the ESP32 SoC
> > +        const: esp,esp32-uart
>=20
> Also, the vendor prefix looks incorrect, so again - what is the company
> name?

esp32 is made by expressif, which would match with "esp" as a vendor
prefix.



--w5dGWB6bqtjegC91
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQMdKAAKCRB4tDGHoIJi
0jdGAP4sUKNXkMwoIScWfBLsAsvhasgz8yvWr3ZT714K8R9RTgD+K5NqOOlcTqGa
7guFL9U09dCkKLI+vEoOgY4PtJ3gCwQ=
=ENOh
-----END PGP SIGNATURE-----

--w5dGWB6bqtjegC91--
