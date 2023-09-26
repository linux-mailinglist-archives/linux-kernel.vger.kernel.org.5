Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3765A7AED57
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 14:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbjIZM4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 08:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjIZM4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 08:56:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F682FB;
        Tue, 26 Sep 2023 05:56:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D568C433C8;
        Tue, 26 Sep 2023 12:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695732985;
        bh=DkboLss2t1a5JtYCh172h81RMP48iGgistWARFrFkWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MbdWM83JQwKefVUx2T9uRoC5zW6mv9Iux8XOuxN/0MByxiAy8EtIhDK7yTj/LDs/y
         7OfFuJrHJFFvr40qX2RjF2LwzCLenKrxarBApDsZLJd0OzWEPlOih9XDLGoZEakwZ2
         ziNmOMOWYofd4pSdGww4YVWBGcAsOovQZjTVx9dhsZk7DODFQjnvXewfmI8F5AlkzC
         BXWzHs8T+ZTq8PGBo5FLXcxdWJ+6DQBl4qbRQ7jayrFnsTROl+jAVnzl16XGTlt9zY
         DfbYq9ADUgz6TCsF/0j7R5JfMjyEj73xzw878bV2R4/BEO6eyV42JhNn4YgY0nFzRx
         Xb11gybOOT1sw==
Date:   Tue, 26 Sep 2023 13:56:19 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: msm: Add missing
 unevaluatedProperties on child node schemas
Message-ID: <20230926-chemo-autopilot-b9323784886a@spud>
References: <20230925212434.1972368-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="W4wHTtiqSi8PKbBJ"
Content-Disposition: inline
In-Reply-To: <20230925212434.1972368-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--W4wHTtiqSi8PKbBJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 25, 2023 at 04:24:24PM -0500, Rob Herring wrote:
> Just as unevaluatedProperties or additionalProperties are required at
> the top level of schemas, they should (and will) also be required for
> child node schemas. That ensures only documented properties are
> present for any node.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.=
yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> index f12558960cd8..dbe398f84ffb 100644
> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> @@ -114,6 +114,7 @@ properties:
> =20
>        port@1:
>          $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
>          description: Output endpoint of the controller
>          properties:
>            endpoint:
> --=20
> 2.40.1
>=20

--W4wHTtiqSi8PKbBJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRLU8wAKCRB4tDGHoIJi
0siFAQCPIJw0ImQkf/uczQd3qHyCH5x7Fpe36rqmG+BfDzkraQD9FTGjRiM9TQXb
q+Q5fUiiaZa7v9r6fe0HMjHSzIRytws=
=k8M0
-----END PGP SIGNATURE-----

--W4wHTtiqSi8PKbBJ--
