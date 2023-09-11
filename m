Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DEF79A528
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 09:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbjIKH4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 03:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbjIKH4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 03:56:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0185FB;
        Mon, 11 Sep 2023 00:56:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9DB8C433C7;
        Mon, 11 Sep 2023 07:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694418973;
        bh=TcDeqP1CdFF7Zks/G2rBv/cmEg5YhRmWxiNQGI/6MpM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CZhIdbXc9hdjIVI1sHlh3znecvhGjFlRNouiyFQACPX5/jkuvW2wvMrRC4vtDsmBz
         69q4krqK8cnjCs8zzBXRfu1V0cQYyFso9nW12l2dv8zSQj81KqFqwj2L6JI36thMyA
         TAHyT2ULHNFDNcsGl5pl9iZAc0BLL+/a8BNRLCl8De0EaNGm19Hs8nJS1VhDcLfEOE
         0wtsCgsJgnhZ3g/AEmTtpyIM0fL2NiagvTpAZV3u5AjaelqrLiycvWrV2j0y8/dluC
         zKDxEvNt8M1B95ZbsTKiNjqOjvjsZOc4V+K6ZkeqvGGEgk3qhC5uiLOPBHHyU29b5Q
         BltSCR7O/arIw==
Date:   Mon, 11 Sep 2023 09:56:10 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Vignesh Raman <vignesh.raman@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, helen.koike@collabora.com,
        guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com,
        david.heidelberg@collabora.com, daniels@collabora.com,
        gustavo.padovan@collabora.com,
        angelogioacchino.delregno@collabora.com, emma@anholt.net,
        robclark@freedesktop.org, robdclark@google.com, anholt@google.com,
        robdclark@gmail.com, airlied@gmail.com, daniel@ffwll.ch,
        jani.nikula@linux.intel.com, dmitry.baryshkov@linaro.org,
        matthias.bgg@gmail.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 3/9] drm: ci: Force db410c to host mode
Message-ID: <4sejhbn246lxcfdogzlcv5u6gunjcwuplk4victzc223n4cohu@mmdjj6je62p2>
References: <20230908152225.432139-1-vignesh.raman@collabora.com>
 <20230908152225.432139-4-vignesh.raman@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cb6hdljgta37swja"
Content-Disposition: inline
In-Reply-To: <20230908152225.432139-4-vignesh.raman@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cb6hdljgta37swja
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 08, 2023 at 08:52:19PM +0530, Vignesh Raman wrote:
> Force db410c to host mode to fix network issue which results in failure
> to mount root fs via NFS.
> See https://gitlab.freedesktop.org/gfx-ci/linux/-/commit/cb72a629b8c15c80=
a54dda510743cefd1c4b65b8
>=20
> Compile the base device tree with overlay support and use fdtoverlay
> command to merge base device tree with an overlay which contains the
> fix for USB controllers to work in host mode. [suggested by Maxime Ripard]
>=20
> Suggested-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
>=20
> v2:
>   - Use fdtoverlay command to merge overlay dtbo with the base dtb instea=
d of modifying the kernel sources
>=20
> v3:
>   - drm-ci scripts to use device tree overlay from arch/arm64/boot/dts/qc=
om and compile base device tree with overlay support
>=20
> ---
>  drivers/gpu/drm/ci/build.sh | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/ci/build.sh b/drivers/gpu/drm/ci/build.sh
> index 7b014287a041..092c195af242 100644
> --- a/drivers/gpu/drm/ci/build.sh
> +++ b/drivers/gpu/drm/ci/build.sh
> @@ -91,7 +91,12 @@ for image in ${KERNEL_IMAGE_NAME}; do
>  done
> =20
>  if [[ -n ${DEVICE_TREES} ]]; then
> -    make dtbs
> +    make DTC_FLAGS=3D-@ dtbs
> +    if [[ -e arch/arm64/boot/dts/qcom/apq8016-sbc.dtb ]]; then
> +        dtc -@ -I dts -O dtb -o arch/arm64/boot/dts/qcom/apq8016-sbc-usb=
-host.dtbo arch/arm64/boot/dts/qcom/apq8016-sbc-usb-host.dtso

You don't need to compile it by hand, make dtbs should do it for you

> +        fdtoverlay -i arch/arm64/boot/dts/qcom/apq8016-sbc.dtb -o arch/a=
rm64/boot/dts/qcom/apq8016-sbc-usb-host.dtb arch/arm64/boot/dts/qcom/apq801=
6-sbc-usb-host.dtbo
> +        mv arch/arm64/boot/dts/qcom/apq8016-sbc-usb-host.dtb arch/arm64/=
boot/dts/qcom/apq8016-sbc.dtb
> +    fi

That is also supported by the build system already, see
k3-am642-tqma64xxl-mbax4xxl-sdcard-dtbs in
arch/arm64/boot/dts/ti/Makefile for example.

Maxime

--cb6hdljgta37swja
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZP7IEgAKCRDj7w1vZxhR
xf+VAQCKBhzxM+xyY+/4paz1ptXJnwy/l2JYhG19lwvhdmqzEQEAu8ymNH0xWLT9
fjwD62FM8tQ1u0IqCUncUJpj3vx5+A0=
=V7+f
-----END PGP SIGNATURE-----

--cb6hdljgta37swja--
