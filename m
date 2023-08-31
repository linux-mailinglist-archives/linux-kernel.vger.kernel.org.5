Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C7E78F093
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 17:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346534AbjHaPru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 11:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjHaPrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 11:47:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3771A3;
        Thu, 31 Aug 2023 08:47:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29241B82336;
        Thu, 31 Aug 2023 15:47:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24ED3C433C7;
        Thu, 31 Aug 2023 15:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693496864;
        bh=5mQXYKt6vGAv9319MthmUhxTFPuM6XRnJS1sdwqwBB0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=byDFihe2+iK0CORw/mKsL0Y2hRd5XulSDVEduYeIv3NpQvpNuVJy9V1V4dNtsD0wO
         8aGI4E+L5UxtqUFBCqNqNJC0obGY/pJfZKR28ABTMXVNf6QbIroM94O4pz6ZGCjTQy
         yqldoUbyxJflxoPfBG6OanGcqELTkP2Hawg90PYjd697uiLch/TO/GOCAv3ovcOEb4
         Gva/o1fd58zHf+SI41K1ogecu1ucbrjd4F+elitaSo0kYqu456RDHO5h6T4GGBwVCo
         AYcijWddsPSFJ22IGw4/G4rwoFY4YrUGBgJwOCalb2LGT8izwwlnDkyUc0l+r7Ub18
         GQvWdMqoPMGAg==
Date:   Thu, 31 Aug 2023 16:47:39 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: phy: qcom,usb-snps-femto-v2: Add REFGEN
 regulator
Message-ID: <20230831-asleep-revisable-17e16524f886@spud>
References: <20230830-topic-refgenphy-v1-0-892db196a1c0@linaro.org>
 <20230830-topic-refgenphy-v1-1-892db196a1c0@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0wmHf2n6L8Edbw7d"
Content-Disposition: inline
In-Reply-To: <20230830-topic-refgenphy-v1-1-892db196a1c0@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0wmHf2n6L8Edbw7d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 30, 2023 at 11:13:51PM +0200, Konrad Dybcio wrote:
> The HSPHY is (or at least can be) one of the users of the reference
> voltage generating regulator. Ensure that dependency is described
> properly.
>=20
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2=
=2Eyaml b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
> index 0f200e3f97a9..e895b6c4ee49 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
> @@ -53,6 +53,9 @@ properties:
>      items:
>        - description: PHY core reset
> =20
> +  refgen-supply:
> +    description: phandle to the REFGEN regulator node
> +
>    vdda-pll-supply:
>      description: phandle to the regulator VDD supply node.

My OCD isn't keen on the inconsistent full stop usage but that's a
nitpick of the context, not of the patch itself.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor,

> =20
>=20
> --=20
> 2.42.0
>=20

--0wmHf2n6L8Edbw7d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZPC2GwAKCRB4tDGHoIJi
0vJaAP9rRzGpps5j5CxJkm7BgsWK5+zfGZT7HUjJD7fwv1yhHwD42Ji6OwShQoNl
BWABX5M3jTUiImtdZq+sIulqU7bKDA==
=s7w1
-----END PGP SIGNATURE-----

--0wmHf2n6L8Edbw7d--
