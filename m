Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF098137D9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 18:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443939AbjLNRNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 12:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235698AbjLNRMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 12:12:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E281A2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 09:12:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8716C433C8;
        Thu, 14 Dec 2023 17:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702573977;
        bh=BAELR7PAtgbHJ26Por16QtKzX2s0QDtbvfohshpvT7k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n9sZrVGqgBfPqr4iuqNawJmRCH6DZnjo9xEv9sc8Jb8tUM5X0p2lHGToKbQ71HmoH
         44fCZG2jogO+9MP9i+gwLpTOOeyiyU8jAzQ1KbHVHCCGg37M6IvFcsH49fsWo4Bj9r
         9YCpvO79dr6domzMwMFfmpRS9yzXx9Pzq5ie9+Pp33xnWN/ahxK5Y3byWThrLVIRzL
         lQbkm57hE1G71W7o7ddnMWQuxFYqhvBVWMz1Y9yTRr89wMBuQ0tvGE9pbIGLfT80zN
         VwNv612w0mqTSyIyJzwwQEthaIO3/MOA2kJ/6s8cYTWUsqwlbnGiZx4yeCY6098KxZ
         sCIYaCsJeKvOA==
Date:   Thu, 14 Dec 2023 17:12:51 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Jie Luo <quic_luoj@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        robert.marko@sartura.hr, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com
Subject: Re: [PATCH v2 5/5] dt-bindings: net: ipq4019-mdio: Document ipq5332
 platform
Message-ID: <20231214-outshine-shush-8a11c68607cd@spud>
References: <20231212115151.20016-1-quic_luoj@quicinc.com>
 <20231212115151.20016-6-quic_luoj@quicinc.com>
 <20231212-caution-improvise-ed3cc6a1d305@spud>
 <11ffc985-3f2b-46b9-ae0b-911f7abe98d1@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LYJ0ceWwoY8jlvlx"
Content-Disposition: inline
In-Reply-To: <11ffc985-3f2b-46b9-ae0b-911f7abe98d1@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LYJ0ceWwoY8jlvlx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 04:26:56PM +0800, Jie Luo wrote:
>=20
>=20
> On 12/13/2023 12:06 AM, Conor Dooley wrote:
> > On Tue, Dec 12, 2023 at 07:51:50PM +0800, Luo Jie wrote:
> > > Update the yaml file for the new DTS properties.
> > >=20
> > > 1. cmn-reference-clock for the CMN PLL source clock select.
> > > 2. clock-frequency for MDIO clock frequency config.
> > > 3. add uniphy AHB & SYS GCC clocks.
> > > 4. add reset-gpios for MDIO bus level reset.
> > >=20
> > > Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> > > ---
> > >   .../bindings/net/qcom,ipq4019-mdio.yaml       | 157 +++++++++++++++=
++-
> > >   1 file changed, 153 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.=
yaml b/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
> > > index 3407e909e8a7..9546a6ad7841 100644
> > > --- a/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
> > > +++ b/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
> > > @@ -20,6 +20,8 @@ properties:
> > >             - enum:
> > >                 - qcom,ipq6018-mdio
> > >                 - qcom,ipq8074-mdio
> > > +              - qcom,ipq9574-mdio
> > > +              - qcom,ipq5332-mdio
> > >             - const: qcom,ipq4019-mdio
> > >     "#address-cells":
> > > @@ -30,19 +32,71 @@ properties:
> > >     reg:
> > >       minItems: 1
> > > -    maxItems: 2
> > > +    maxItems: 5
> > >       description:
> > > -      the first Address and length of the register set for the MDIO =
controller.
> > > -      the second Address and length of the register for ethernet LDO=
, this second
> > > -      address range is only required by the platform IPQ50xx.
> > > +      the first Address and length of the register set for the MDIO =
controller,
> > > +      the optional second, third and fourth address and length of th=
e register
> > > +      for ethernet LDO, these three address range are required by th=
e platform
> > > +      IPQ50xx/IPQ5332/IPQ9574, the last address and length is for th=
e CMN clock
> > > +      to select the reference clock.
> > > +
> > > +  reg-names:
> > > +    minItems: 1
> > > +    maxItems: 5
> > >     clocks:
> > > +    minItems: 1
> > >       items:
> > >         - description: MDIO clock source frequency fixed to 100MHZ
> > > +      - description: UNIPHY0 AHB clock source frequency fixed to 100=
MHZ
> > > +      - description: UNIPHY1 AHB clock source frequency fixed to 100=
MHZ
> > > +      - description: UNIPHY0 SYS clock source frequency fixed to 24M=
HZ
> > > +      - description: UNIPHY1 SYS clock source frequency fixed to 24M=
HZ
> > >     clock-names:
> > > +    minItems: 1
> > >       items:
> > >         - const: gcc_mdio_ahb_clk
> > > +      - const: gcc_uniphy0_ahb_clk
> > > +      - const: gcc_uniphy1_ahb_clk
> > > +      - const: gcc_uniphy0_sys_clk
> > > +      - const: gcc_uniphy1_sys_clk
> >=20
> > > +  cmn-reference-clock:
> > > +    oneOf:
> > > +      - items:
> > > +          - enum:
> > > +              - 0   # CMN PLL reference internal 48MHZ
> > > +              - 1   # CMN PLL reference external 25MHZ
> > > +              - 2   # CMN PLL reference external 31250KHZ
> > > +              - 3   # CMN PLL reference external 40MHZ
> > > +              - 4   # CMN PLL reference external 48MHZ
> > > +              - 5   # CMN PLL reference external 50MHZ
> > > +              - 6   # CMN PLL reference internal 96MHZ
> >=20
> > Why is this not represented by an element of the clocks property?
>=20
> This property is for the reference clock source selection of CMN PLL,
> CMN PLL generates the different clock rates for the different Ethernet
> blocks, this CMN PLL configuration is not located in the GCC, so the
> clock framework can't be used, which is the general hardware register
> instead of RCG register for GCC.

I don't see how the clock being provided by the "GCC" (whatever that is)
or by some other clock controller or fixed clock makes a difference.
Why can't the other clock provider be represented in the devicetree?

> > > +  clock-frequency:
> > > +    oneOf:
> > > +      - items:
> > > +          - enum:
> > > +              - 12500000
> > > +              - 6250000
> > > +              - 3125000
> > > +              - 1562500
> > > +              - 781250
> > > +              - 390625
> > > +    description:
> > > +      The MDIO bus clock that must be output by the MDIO bus hardwar=
e,
> > > +      only the listed frequecies above can be configured, other freq=
uency
> > > +      will cause malfunction. If absent, the default hardware value =
is used.
> >=20
> > Likewise.
> >=20
> > Your commit message contains a bullet point list of what you are doing,
> > but there's no explanation here for why custom properties are required
> > to provide clock information.

> This property clock-frequency is optional to configure the MDIO working
> clock rate, and this is the MDIO general DT property, since the hardware
> default clock rate is 390625HZ, there is requirement for higher clock rate
> in the normal working case, i will update this information in the
> next patch set.

I'm just realising that this particular one is not a custom property,
the unusual `oneOf: - items: - enum:` structure here threw me. This can
just be
  clock-frequency:
    enum:
      - 12500000
      - 6250000
      - 3125000
      - 1562500
      - 781250
      - 390625

but you're missing a default, given your commit about the last element
in that list being one.

Thanks,
Conor.

--LYJ0ceWwoY8jlvlx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXs3kwAKCRB4tDGHoIJi
0vu7APsHtU2RskKEI44XxHTB9wAjvT2zciB0zeCci/YTbg5d6gEAqM9G7uRaWzhA
33QIM6/PicVe6pC2JOVaFUlBDKnW0gM=
=Cypi
-----END PGP SIGNATURE-----

--LYJ0ceWwoY8jlvlx--
