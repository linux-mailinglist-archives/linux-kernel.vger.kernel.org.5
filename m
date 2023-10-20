Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF567D137D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 18:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377878AbjJTQDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 12:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377814AbjJTQDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 12:03:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C018AB3;
        Fri, 20 Oct 2023 09:03:33 -0700 (PDT)
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1B29F660731B;
        Fri, 20 Oct 2023 17:03:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697817812;
        bh=gdDLnZkjmHu+Sk+/2xbwhd6fH/+pG0s/huYMTIz5rp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IQFefCmvfeF1DgM1gwp4s6N4cgiJZSOLMPM4KqmFPhcDEqYra/6qGuzOZ8uXfsM1G
         dndXiXqb3HzXVk1aMsaSQ0S56EMTjnZjF64NXuuVRQQz8/270jgTiqIxtulr4wGb7c
         OPhUDYPn+hXJEAf4rl9wOAcZA/tf/eSSJYQQzh0N/+XupthBNbSDHU/kqHqFhTr5Z6
         x0j1cSz2oJoChJT4pr/9Vo3CP/ji3vHYFZ8GgNTQvXtN7ZRdbaJeFsp0+fPOob5UUU
         Tu62TlLLx4w2HAGI92a3SiNLOaUFO/rvEo7+sxOqggfemBvjNEz+vG+DrTd/1cZKNv
         kvpOyb/vt5z8A==
Received: by mercury (Postfix, from userid 1000)
        id 1E11910603FC; Fri, 20 Oct 2023 18:03:29 +0200 (CEST)
Date:   Fri, 20 Oct 2023 18:03:29 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-rockchip@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v4 1/3] dt-bindings: usb: add rk3588 compatible to
 rockchip,dwc3
Message-ID: <20231020160329.uqgjjr6ubfrcqjkj@mercury.elektranox.org>
References: <20231020150022.48725-1-sebastian.reichel@collabora.com>
 <20231020150022.48725-2-sebastian.reichel@collabora.com>
 <20231020-shudder-tackle-cc98a82f1cd0@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bdmk4yrcxo3we24y"
Content-Disposition: inline
In-Reply-To: <20231020-shudder-tackle-cc98a82f1cd0@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bdmk4yrcxo3we24y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Conor,

On Fri, Oct 20, 2023 at 04:36:19PM +0100, Conor Dooley wrote:
> On Fri, Oct 20, 2023 at 04:11:40PM +0200, Sebastian Reichel wrote:
> > [...]
> > +allOf:
> > +  - $ref: snps,dwc3.yaml#
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: rockchip,rk3328-dwc3
> > +    then:
> > +      properties:
> > +        clocks:
> > +          minItems: 3
> > +          maxItems: 4
> > +        clock-names:
> > +          minItems: 3
> > +          items:
> > +            - const: ref_clk
> > +            - const: suspend_clk
> > +            - const: bus_clk
> > +            - const: grf_clk
>=20
> minItems for clocks and clock-names is already 3, is it not?

Yes, but the following 'maxItems: 4' implicitly sets it to 4,
so I had to set it again. The same is true for clock-names -
providings new 'items:' effectively drops the "minItems: 3"
=66rom the generic section.

> Otherwise,
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> Thanks,
> Conor.

Thanks,

-- Sebastian

--bdmk4yrcxo3we24y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmUypMQACgkQ2O7X88g7
+prWug//YTS5WE0ntNTSommlUibet+KcZPc5blw/2DH/Lx7UHSPecqtfjAWpAB/j
Cg9pHPgOumi0wJSdmqKRkJST7bKaCOkpw4N4HLqnrNBL+PNLG7sQOo9qMwaV2x7B
3nFbsXLjoxlHuYGrupRoFAUL/LevwpWC1vgnrKdk37p0uJzmhRVyUtMrjE3wqzVU
FbiI4NgxpflWpRQ8VqtUzZVGA/15RXZVqnFjHgGZ624NhDD/2KsIUYOscvwq5qYa
1QylGUeTFE3D7EGbmTLd/voxlGKTntEPbYw+hP8JVf/oA7d01zlFRFa3MLmVM4vg
cRbaTt96A6ugCjBdUdkHYhw0aEROd4u/5hCdRv5whBOqWmz5HJ4jKsc+hrneNE7T
M9tHr6WpbtHu/s4Gepx+AxScNwOEF/A93pOuQXcy1CYOjF/hvx9zP0PYsQwD7b03
Qtr6Qnp95rozYYFt/2NforFTdFAwcGxR3XtUmd7qAMkIQYmApzgaQiDzLoJb/Gtv
1nSAiW0lvgHALq+PefTqKCqPXs28wJXdojJJscTIRk7RbkoLkxScdnaZG85kp+Qj
xSAtSGrvjE6PLvTdwxP3G+R9Qlh1O5mzze9iydGtwY4UsW6vR+Xybvu6e8V5rC8B
R/C1la6YhCZoGPgK93jn4tVCqwHxiOX3TMY1NlCj4hn+2WU2AxQ=
=a1sC
-----END PGP SIGNATURE-----

--bdmk4yrcxo3we24y--
