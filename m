Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F265C7E562E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 13:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344555AbjKHM0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 07:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjKHM0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 07:26:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA1E19A5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 04:26:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F02C433C8;
        Wed,  8 Nov 2023 12:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699446378;
        bh=IAfCCDkyoqMwRgNhZZHV9D9EdJkD+fp8NviqqTM9R0o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CWJaa7vP/INIn8Y/fc9tSougRzydXlE+zcbYQV/yVWuoIQQkU88oDF3J8rgluf1w4
         o3Y918+q/6luxGdfVnKL98mUvhEGzRZCv9NCzm7LOQqwP4eGrGEAuRrJhr8w4qQuzz
         XvnP2NewCKvmW3KIqU0IGZSmTDw3iyZDufsEVDwo+noFH9jRybMEhDc8SfVIUVvLns
         kiqRu7dWltgp/UGQ9AAooKDDGL0NR87CUM+3MVSbIT2rxwZ1b2LtA2i7EUQZMwuyRj
         ULyIpLI+kJU9MYwSuxO2ScQf+slsvZK3RJWFP1tbawO705pVaOCwjdMOa1ydyYB8Vf
         coQGki1WJMKqQ==
Date:   Wed, 8 Nov 2023 12:26:13 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: cache: qcom,llcc: correct QDU1000 reg
 entries
Message-ID: <20231108-hurricane-carefully-d9d3c1348f8c@spud>
References: <20231107080436.16747-1-krzysztof.kozlowski@linaro.org>
 <0f76a5c1-14ce-cbfa-bbd9-b2826c4bbbdb@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3PXY0uOgYwGgqLR6"
Content-Disposition: inline
In-Reply-To: <0f76a5c1-14ce-cbfa-bbd9-b2826c4bbbdb@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3PXY0uOgYwGgqLR6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2023 at 02:25:25PM +0530, Mukesh Ojha wrote:
>=20
>=20
> On 11/7/2023 1:34 PM, Krzysztof Kozlowski wrote:
> > Qualcomm QDU1000 DTSI comes with one LLCC0 base address as pointed by
> > dtbs_check:
> >=20
> >    qdu1000-idp.dtb: system-cache-controller@19200000: reg-names:2: 'llc=
c2_base' was expected
> >=20
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >=20
> > ---
> >=20
> > Recent LLCC patches were not tested on QDU1000 thus the LLCC is there
> > broken.  This patch at least tries to bring some sense according to
> > DTSI, but I have no clue what is here correct: driver, DTS or bindings.
> > ---
> >   Documentation/devicetree/bindings/cache/qcom,llcc.yaml | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/cache/qcom,llcc.yaml b/D=
ocumentation/devicetree/bindings/cache/qcom,llcc.yaml
> > index 580f9a97ddf7..d610b0be262c 100644
> > --- a/Documentation/devicetree/bindings/cache/qcom,llcc.yaml
> > +++ b/Documentation/devicetree/bindings/cache/qcom,llcc.yaml
> > @@ -64,6 +64,7 @@ allOf:
> >           compatible:
> >             contains:
> >               enum:
> > +              - qcom,qdu1000-llcc
> >                 - qcom,sc7180-llcc
> >                 - qcom,sm6350-llcc
>=20
> Thanks, again.
>=20
> Acked-by: Mukesh Ojha <quic_mojha@quicinc.com>

I'm assuming given your employer, this ack means that there is no
llcc2_base on the qdu1000.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--3PXY0uOgYwGgqLR6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZUt+ZQAKCRB4tDGHoIJi
0u8iAP9Q5Ny4RSfKFakhQaf6p2q2ELHTZhnirexsH3kgpTx2xwEAgyelTaZCZv2D
JaOhjbkF1boR3VmcF8YGORNiZXMeVAY=
=L4Oy
-----END PGP SIGNATURE-----

--3PXY0uOgYwGgqLR6--
