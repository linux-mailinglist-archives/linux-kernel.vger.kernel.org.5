Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FAF79A52D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 09:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234929AbjIKH5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 03:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjIKH44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 03:56:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF4112B;
        Mon, 11 Sep 2023 00:56:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94B3C433C9;
        Mon, 11 Sep 2023 07:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694418999;
        bh=J4By/wtMEr2AEoDW7IigfXfEKp7/CeZK5KPE57g83AQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZfX6RyGjkbCon6qIymrUuDUmd4zyiw+oq+3UYAwwiRejb+bjeMBacGLrJVk1rq0/6
         Epnri0SlLSNT0lEAGHQvpMVuUcd2/RK9resXaAfohLmxGBCzZIIHrx7Agczwvu/Ee0
         31czy6K1CbffAHojh735ol2bgE4CnY66hmjm0pn6F1mBdWN8voaI8Q2HEOHpFLNRzl
         yvcxdQ6OE9Fl21SakZehyM4rsYmRvesVp8JReZTn2jV8YMCT5/x7nK38rZarLkg1A/
         1oa4bIIvcvkevd5EzXEXDw5eyXcW9i0t/nR43VM6KtPIonud2mgDSNbNgw3I3uFC5u
         oKb6l2ve2JxUQ==
Date:   Mon, 11 Sep 2023 09:56:36 +0200
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
Subject: Re: [PATCH v3 2/9] arm64: dts: qcom: apq8016-sbc: Add overlay for
 usb host mode
Message-ID: <n7pfq63xblrijh7azhqj4zytnq6tuym6dwdw6rrwznnizpoy5p@7vsgezhgs3jg>
References: <20230908152225.432139-1-vignesh.raman@collabora.com>
 <20230908152225.432139-3-vignesh.raman@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gagdd2k3ghthyhjr"
Content-Disposition: inline
In-Reply-To: <20230908152225.432139-3-vignesh.raman@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gagdd2k3ghthyhjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 08, 2023 at 08:52:18PM +0530, Vignesh Raman wrote:
> Due to the presence of the fastboot micro cable in the CI farm,
> it causes the hardware to remain in gadget mode instead of host mode.
> So it doesn't find the network, which results in failure to mount root
> fs via NFS.
>=20
> Add an overlay dtso file that sets the dr_mode to host, allowing
> the USB controllers to work in host mode. This dtso file will be used
> in drm-ci, mesa-ci.
>=20
> Overlay DT file uses the sugar syntax [suggested by Dmitry Baryshkov and =
Maxime Ripard]
>=20
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Suggested-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Helen Koike <helen.koike@collabora.com>
> Signed-off-by: David Heidelberg <david.heidelberg@collabora.com>
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
>=20
> v3:
>   - New patch in the series to add device tree overlay in arch/arm64/boot=
/dts/qcom
>=20
> ---
>  arch/arm64/boot/dts/qcom/apq8016-sbc-usb-host.dtso | 8 ++++++++
>  1 file changed, 8 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/apq8016-sbc-usb-host.dtso
>=20
> diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc-usb-host.dtso b/arch/ar=
m64/boot/dts/qcom/apq8016-sbc-usb-host.dtso
> new file mode 100644
> index 000000000000..a82c26b7eae8
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/apq8016-sbc-usb-host.dtso
> @@ -0,0 +1,8 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +/dts-v1/;
> +/plugin/;
> +
> +&usb {
> +         dr_mode =3D "host";
> +};
> --=20
> 2.40.1
>=20

You need to add it to the Makefile too

Maxime

--gagdd2k3ghthyhjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZP7INAAKCRDj7w1vZxhR
xV6IAQCox48qewzlkPPyfIUdU1lcyOF2tjZGlIie1OkEy+YwewD9HSiqWhPcaU05
UcmcRvKlRMTRddoOLVSVlt6zHhBNPgI=
=Cw8P
-----END PGP SIGNATURE-----

--gagdd2k3ghthyhjr--
