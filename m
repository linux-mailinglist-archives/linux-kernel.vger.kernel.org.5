Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975EB7E5A7F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 16:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbjKHPwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 10:52:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbjKHPwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 10:52:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CD21FD8
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 07:52:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64294C433C7;
        Wed,  8 Nov 2023 15:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699458737;
        bh=PyJnUw52xaJdt+qorcyNyHLF7M540bcPNwMFJlwFyck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L8TQ6UhZsA/bjyxC4AJbD6rPwTX6WVEchB2F775eU8/kTYNTDGJ+WSg6ZPbwIjMGz
         aJOc3osG0JITpvpDm9jUybHOvPkXQmIOJoe7FyWLbBcGG5iDcIqjBS9IXYHE4DeNdc
         zVI/VpBTa8KQj9O6AGibuLqnCIvgtXAU3+wz8Z43sNQUpUZ9hnL51ENJjCuXlrk37q
         6vAwwgBrMIO0TcU+foI8dQF3+O1CMzklQ7ujYIN6iJVeDykyUgScDkINBQiWY0bOUw
         wGrIkWA6mwne15L4T12Lwm8+aVLahU7gndkH9zsu8P6H/gN8Ay+NADlS/Iv/MFb4a4
         U53hiMSHmCmNw==
Date:   Wed, 8 Nov 2023 15:52:11 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_vpernami@quicinc.com, quic_parass@quicinc.com
Subject: Re: [PATCH v2 1/3] dt-bindings: phy: qcom,qmp: Add PCIe
 qcom,refclk-always-on property
Message-ID: <20231108-surgical-yelling-7314b68c0289@spud>
References: <20231107-refclk_always_on-v2-0-de23962fc4b3@quicinc.com>
 <20231107-refclk_always_on-v2-1-de23962fc4b3@quicinc.com>
 <CAA8EJpqvCJsft3Y-m2ZYORBg=6P7EhT-PsCSkuQ4xaxuf3KOwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="I6wTmWiXLXK+QyIQ"
Content-Disposition: inline
In-Reply-To: <CAA8EJpqvCJsft3Y-m2ZYORBg=6P7EhT-PsCSkuQ4xaxuf3KOwA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--I6wTmWiXLXK+QyIQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2023 at 03:01:47PM +0200, Dmitry Baryshkov wrote:
> On Tue, 7 Nov 2023 at 14:26, Krishna chaitanya chundru
> <quic_krichai@quicinc.com> wrote:
> >
> > Document qcom,refclk-always-on property which is needed in some platfor=
ms
> > to supply refclk even in PCIe low power states.
> >
> > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > ---
> >  .../devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml        | 7=
 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pc=
ie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-=
phy.yaml
> > index 2c3d6553a7ba..263291447a5b 100644
> > --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.=
yaml
> > +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.=
yaml
> > @@ -93,6 +93,13 @@ properties:
> >    "#phy-cells":
> >      const: 0
> >
> > +  qcom,refclk-always-on:
> > +    type: boolean
> > +    description: If there is some issues in platform with clkreq signal
>=20
> nit: there are some
>=20
> However this still doesn't describe what kind of issues with clkreq
> you observe. I mean, clkreq is just a GPIO pin.
>=20
> > +      propagation to the host and due to that host will not send refcl=
k, which
> > +      results in linkdown in L1.2 or L1.1 exit initiated by EP. This p=
roperty
> > +      if set keeps refclk always on even in Low power states (optional=
).

Dimitry's issues with the property aside, putting "(optional)" in the
description is meaningless - qcom,refclk-always-on isn't listed in the
required properties section, so therefore has to be optional.

Cheers,
Conor.

> > +
> >  required:
> >    - compatible
> >    - reg
> >
> > --
> > 2.42.0
> >
> >
>=20
>=20
> --=20
> With best wishes
> Dmitry

--I6wTmWiXLXK+QyIQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZUuuqgAKCRB4tDGHoIJi
0ovuAP9SjB4TsXVP8krtEq82yxlmdE8R8V9/Q2naFBd1Ga9iywD/fwj/ihvpTrtK
dvKdXSys+LPMPUK6nrpMhwYZkqMJTg0=
=kRX+
-----END PGP SIGNATURE-----

--I6wTmWiXLXK+QyIQ--
