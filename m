Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5389D7B07D1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbjI0PMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbjI0PMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:12:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D516F5;
        Wed, 27 Sep 2023 08:12:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE04C433C8;
        Wed, 27 Sep 2023 15:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695827536;
        bh=DcRNA9OfKi/fCALpJwPBIv4plNYmp5Y1i6dc+yueQDc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B9ipkHGSg12B+M1Pu1tL0DxKXFdj/hS163OLvYF0TeHA+hrfV5aNzMgf1ramAj1Gm
         QkLWJbUW8Koyn8+e2ao0Ud81PEHCEDqn8MNMGN9RHkkPTAKB98PhnRPyYdArrCfmUG
         OAT6MTt9lwkYKklqvUgS0yigwmDFpn1/64s3t/U1sQBFfyG8PUFCvASDxAPhYwsWK7
         v1RjL+hylXrz819UJdxgrQfGNHM7elgxyJiyn3T8P3Dl8LuCIzh4QyA9+dq7DqQqyt
         sA0CcSNGeq0M0tu9MMCSzGcr8jZ8UBX1R530aqhDv5Ahou9fHJ6CpYQK9OsYyTTBPG
         vJSibG6FsKFqQ==
Date:   Wed, 27 Sep 2023 16:12:11 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: remoteproc: mtk,scp: Add missing
 additionalProperties on child node schemas
Message-ID: <20230927-unmovable-spender-63bbbceae9ae@spud>
References: <20230926164513.101958-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k5h0Si8SbS8mkeKk"
Content-Disposition: inline
In-Reply-To: <20230926164513.101958-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k5h0Si8SbS8mkeKk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2023 at 11:45:08AM -0500, Rob Herring wrote:
> Just as unevaluatedProperties or additionalProperties are required at
> the top level of schemas, they should (and will) also be required for
> child node schemas. That ensures only documented properties are
> present for any node.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Acked-by: Conor Dooley <conor.dooley@microchip.com>


>  Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml b/=
Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
> index 895415772d1d..24422fd56e83 100644
> --- a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
> @@ -91,6 +91,7 @@ allOf:
> =20
>  additionalProperties:
>    type: object
> +  additionalProperties: false
>    description:
>      Subnodes of the SCP represent rpmsg devices. The names of the devices
>      are not important. The properties of these nodes are defined by the
> --=20
> 2.40.1
>=20

--k5h0Si8SbS8mkeKk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRRGSwAKCRB4tDGHoIJi
0vdoAPwITfmBTlb9ktA+ucCanQ8H71ISLdcJKhmBNc6dLvKgMgD+LdOpppLFXS08
K2Gh6f8c9V/4BAnDSlZYhZCbo3rNQQA=
=x2FK
-----END PGP SIGNATURE-----

--k5h0Si8SbS8mkeKk--
