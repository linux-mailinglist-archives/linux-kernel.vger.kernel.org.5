Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B757781A5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236537AbjHJTa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236641AbjHJTal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:30:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2139E3AB2;
        Thu, 10 Aug 2023 12:30:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC94C60E9C;
        Thu, 10 Aug 2023 19:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EABBAC433CB;
        Thu, 10 Aug 2023 19:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691695827;
        bh=d4mQBWjLbcx61H9YHtMpK3a+gUbbTesFof4Bts3umRM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NRW7TH8PRNpQmj9Ac3TqlrJ3tWZLVjbp9UDGLNq5AcBE+MB4tkEZtTQOTbdWqU43Y
         XLlsCgfBMUvoEPNoTUiuRr/wVXpaB9rh0pqV0a3qwDlvc5pb2Q/fwRuJkJOBEXMEuo
         0sKIFEzExMs8D1Vt/a1fPagAeeSC9SzGRVPPBStVkxxS8Scjf/gmpHoXSymR55uB0q
         LFr2umbfkFxVZziTbS9DHQImk4qS58tt+BTj5RpSy3gY63SMf+rk/bTAilUwxr9P7S
         6QMtNoAnvtgKlhKrTtsAVfNp4QpqEhuTDBlQV7xNsUVg2Rv0HEBnvToNYiCH5NLAF4
         AJG0/gp4Wb98Q==
Date:   Thu, 10 Aug 2023 20:30:21 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <guido.gunther@puri.sm>
Cc:     David Heidelberg <david@ixit.cz>, Marek Vasut <marex@denx.de>,
        Stefan Agner <stefan@agner.ch>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liu Ying <victor.liu@nxp.com>, kernel@puri.sm,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mxsfb: Exclude i.MX8MQ from power-domains
 requirement
Message-ID: <20230810-embroider-seduce-ee4506e7608b@spud>
References: <20230730184120.94984-1-david@ixit.cz>
 <ZMonFSqutQRqs61n@qwark.sigxcpu.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yVk3JZ7fl+mjKj73"
Content-Disposition: inline
In-Reply-To: <ZMonFSqutQRqs61n@qwark.sigxcpu.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yVk3JZ7fl+mjKj73
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 02, 2023 at 11:51:17AM +0200, Guido G=FCnther wrote:
> Hi,
> On Sun, Jul 30, 2023 at 09:41:20PM +0300, David Heidelberg wrote:
> > i.MX8MQ uses as secondary compatible fsl,imx6sx-lcdif, which triggers
> > requirement of power-domains, thou it's not required.
> >=20
> > Fixes: f62678a77d58 ("dt-bindings: mxsfb: Document i.MX8M/i.MX6SX/i.MX6=
SL power-domains property")
> >=20
> > Signed-off-by: David Heidelberg <david@ixit.cz>
> > ---
> >  .../devicetree/bindings/display/fsl,lcdif.yaml        | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml b=
/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
> > index fc11ab5fc465..2d868276b0f9 100644
> > --- a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
> > +++ b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
> > @@ -129,8 +129,15 @@ allOf:
> >                - fsl,imx8mp-lcdif
> >                - fsl,imx93-lcdif
> >      then:
> > -      required:
> > -        - power-domains
> > +      if:
> > +        properties:
> > +          compatible:
> > +            not:
> > +              contains:
> > +                const: fsl,imx8mq-lcdif
> > +      then:
> > +        required:
> > +          - power-domains
>=20
> We currently enable the mipi power domain for the mipi dphy and nwl
> bridge only but not for LCDIF itself assuming it's not needed (as there's
> other outputs LCDIF can drive). I *think* this is correct but maybe
> Marek or Liu can confirm?

I'm happy to Ack this, but I've been sitting on it waiting to see if
Marek or Liu popped up..

--yVk3JZ7fl+mjKj73
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNU6zQAKCRB4tDGHoIJi
0s2nAP9Dmws9nUO7FWU2dnCYapILH8BgEDhPZlOjfqFaw+mE+QD/atHR0u47ijBF
egbmUZYBYV2cDqiKmos4DpMp6XI4WAY=
=OYJ6
-----END PGP SIGNATURE-----

--yVk3JZ7fl+mjKj73--
