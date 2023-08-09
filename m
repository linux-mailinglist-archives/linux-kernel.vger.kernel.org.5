Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8178C776AFC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 23:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbjHIVb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 17:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjHIVb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 17:31:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B8510DC;
        Wed,  9 Aug 2023 14:31:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56BFB6425F;
        Wed,  9 Aug 2023 21:31:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B95FC433C8;
        Wed,  9 Aug 2023 21:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691616684;
        bh=eWvluBXpvacYU7SWRx3U7+YdX4o4iOBGL2WgtTPQ5Vc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZFredjg3pqzvUlwqfbjLgf8p5I99gCUWJJgf94yUKMDhgac6rREaLlV3Zovdtm26G
         +Gxhd5VBeE7qjkJs1YnGxzqJbBBB8iCSyAxKUpEigBfyNu3m/wuZLlO/1MKKlwOdYB
         987uKGAOUN21RvuW51xUS5VpK+9S9vtKK29qpHTqbpURoFDnhqcxJp74G+AmSYlvA2
         aM1qEcKsmtFe2SvgGkZAP90JP3jef3Ajyxw9cy6XFOUlEYDybUe9DPVtw45+2tAkyw
         u7hWu6rYPEasnmQJ0qELDjTJ5x5DVL3dq0rMSk/tEOK3YXjZa2WLHuAV50K0/6uvF0
         MlLu6Ce65sqSg==
Date:   Wed, 9 Aug 2023 22:31:19 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Aradhya Bhatia <a-bhatia1@ti.com>
Cc:     Andrew Davis <afd@ti.com>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: mfd: syscon: Add ti,dss-oldi-io-ctrl
 compatible
Message-ID: <20230809-boxing-unsoiled-0ca242cac892@spud>
References: <20230809165752.46133-1-afd@ti.com>
 <28cf3fa3-c9ea-aba1-2e45-94142a818849@ti.com>
 <1ec72d58-de81-d367-3dc6-900a00b6dac4@ti.com>
 <90e34ca5-3380-8a66-1041-efea85838236@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FOGGleyvWUr454OO"
Content-Disposition: inline
In-Reply-To: <90e34ca5-3380-8a66-1041-efea85838236@ti.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FOGGleyvWUr454OO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2023 at 12:30:03AM +0530, Aradhya Bhatia wrote:
>=20
>=20
> On 09-Aug-23 23:29, Andrew Davis wrote:
> > On 8/9/23 12:39 PM, Aradhya Bhatia wrote:
> >> Hi Andrew,
> >>
> >> Thank you for quickly whipping up these patches! =3D)
> >>
> >> On 09-Aug-23 22:27, Andrew Davis wrote:
> >>> Add TI DSS OLDI-IO control registers compatible. This is a region of 5
> >>> 32bit registers found in the TI AM65 CTRL_MMR0 register space[0]. They
> >>> are used to control the characteristics of the OLDI DATA/CLK IO as
> >>> needed
> >>> by the DSS display controller node.
> >>
> >> As long as the driver takes care of it, we can reuse the same compatib=
le
> >> even when OLDI IO Ctrl registers change from SoC to SoC, (in this case,
> >> AM65 to AM62), right?
> >>
> >=20
> > That depends, is the register space still "compatible" with the AM65
> > version of this space? If not then we would want to qualify these
> > with their SoC versions.

Even if they are compatible, having soc-specific compatibles with a
fallback to the common oldi compatible string would be ideal.

> It is certainly not compatible. More on this below.

But as they're not compatible, that's kinda moot anyway.

> > A quick check of the documentation shows the register space is still
> > 5 registers, 4 DATA and 1 CLK. The contents are different though, but
> > since this compatible string is not used to match with a driver that
> > would care (that is handled by the DSS node which does have different
> > compatibles for each device), I'm actually not sure.

> > Guess we can leave
> > that decision to the DT binding maintainers..

I'm not 100% sure what this decision actually is. Could you elaborate?


> Exactly. The DSS driver in our, as you like to call, evil-vendor-tree
> uses the compatible information to decide which register offsets to
> write to, and what to write.
>=20
>=20
> On the register compatibility situation...
>=20
> AM62 OLDI IO Ctrl has, in total, 12 registers (as opposed to 5 in AM65).
>=20
> There are 4 Data and 1 Clk registers (per OLDI). And there are 2 OLDI
> transmitters in AM62. However, their contents are different as you
> noted.
>=20
> There are 2 more registers in AM62 (unlike AM65), that control
> power-down and loop-back. And it is the power-down register, that will
> be primarily used by the driver.

> >>> [0] https://www.ti.com/lit/pdf/spruid7
> >>>
> >>> Signed-off-by: Andrew Davis <afd@ti.com>
> >>> ---
> >>> =A0 Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
> >>> =A0 1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml
> >>> b/Documentation/devicetree/bindings/mfd/syscon.yaml
> >>> index 8103154bbb529..5029abd6d6411 100644
> >>> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> >>> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> >>> @@ -69,6 +69,7 @@ properties:
> >>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - rockchip,rk3588-qos
> >>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - rockchip,rv1126-qos
> >>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - starfive,jh7100-sysma=
in
> >>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - ti,dss-oldi-io-ctrl

So it sounds like this compatible, that appears to be generic, should
instead be soc-specific as the register layout is different between
SoCs?

Apologies if I have misunderstood.

Thanks,
Conor.

> >>> =A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - const: syscon
> >>> =A0=20
>=20

--FOGGleyvWUr454OO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNQFpwAKCRB4tDGHoIJi
0tclAP90Wuo72E0qvJdSqzNOjqOkqtc6imA1gDU41FSk5uC+0wEAjgjCSSKCgPX9
OLFlmVBZeUhh/fmbQaRp20VoSfaEjQY=
=jJaz
-----END PGP SIGNATURE-----

--FOGGleyvWUr454OO--
