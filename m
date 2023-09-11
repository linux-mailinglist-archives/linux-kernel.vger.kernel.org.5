Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4781679B1FA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344673AbjIKVS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242624AbjIKP6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:58:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1396D1B6;
        Mon, 11 Sep 2023 08:58:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36E2C433C7;
        Mon, 11 Sep 2023 15:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694447880;
        bh=TZqMa028quiSQSHPEyotkXIBKsiJ+ehaCJ4ItKr3fr4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W9DI1iQ3Ai1faZto8k6V5a1/4EuSBX3Z9Rhu+CEy4exXRelKDiDxPGuleeVzBB6j8
         Zr4GQ0mpDtzmjzriohiZDwQUQUl0sgid7HA0ay5PGNX2whgHzHoA+95rISUk2M8e9R
         C3Ey9fveYbYnuNJTS4I//CKT0moZhAXRV1qg+oS4BmTBhjFmDxkDSR3QAF/b5M+adU
         u4nlkvT5fDj0DTOtk/mtoKUZ828YVQ1M6YH56496f/wKl/wEBdvw3eACJGs5DW1uJv
         IyIagmBTRQiqw1k86eE0zA20FIl6uE1bvsXDN3H0RO/E61jGCUa4EAg63hFw9b1ZYV
         9sNCPUtsl6a2A==
Date:   Mon, 11 Sep 2023 16:57:55 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     Mihai Sain <mihai.sain@microchip.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        andre.przywara@arm.com, andrei.simion@microchip.com,
        jerry.ray@microchip.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        cristian.birsan@microchip.com
Subject: Re: [PATCH 1/2] dt-bindings: ARM: at91: Document Microchip SAMA5D29
 Curiosity
Message-ID: <20230911-chevron-overture-002166f20aad@spud>
References: <20230801111151.6546-1-mihai.sain@microchip.com>
 <20230801-unbalance-baguette-cd0d4e7e0107@spud>
 <d0296fbd-63d9-10af-4326-68857c6580be@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QhFBVfyMkBitxQNP"
Content-Disposition: inline
In-Reply-To: <d0296fbd-63d9-10af-4326-68857c6580be@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QhFBVfyMkBitxQNP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2023 at 05:03:07PM +0200, Nicolas Ferre wrote:
> On 01/08/2023 at 17:35, Conor Dooley wrote:
> > > diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/=
Documentation/devicetree/bindings/arm/atmel-at91.yaml
> > > index dfb8fd089197..89d75fbb1de4 100644
> > > --- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> > > +++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> > > @@ -79,6 +79,13 @@ properties:
> > >             - const: atmel,sama5d2
> > >             - const: atmel,sama5
> > > +      - description: Microchip SAMA5D29 Curiosity
> > > +        items:
> > > +          - const: microchip,sama5d29-curiosity
> > > +          - const: atmel,sama5d29
> > > +          - const: atmel,sama5d2
> > > +          - const: atmel,sama5
> > What is the benefit of adding the two familial compatibles? Is there
> > software that actually uses these?
>=20
> "atmel,sama5d2" is used by arch/arm/mach-at91/sama5.c file
> "atmel,sama5" is used by drivers/soc/atmel/soc.c file, so yes they are
> needed to instantiate a sama5d29 SoC.

Okay.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--QhFBVfyMkBitxQNP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZP85AwAKCRB4tDGHoIJi
0tq7AQC31b777BGi1fMhydSbFoJ0l4+ytEoMg4vr7HbkC3GOMQD/Y3QYEk4qcMAv
agWAci9nMQ/vVJ6irhfb07mu4xCpsQw=
=9YnG
-----END PGP SIGNATURE-----

--QhFBVfyMkBitxQNP--
