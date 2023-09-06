Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009A2793D7D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 15:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235895AbjIFNNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 09:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjIFNNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 09:13:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4806FCFF;
        Wed,  6 Sep 2023 06:13:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87082C433C7;
        Wed,  6 Sep 2023 13:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694006009;
        bh=VKGhfV962Z8xvMpDY+hCvX8KHsDqyXxexkSt2XfB5oo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S1wdpkkSQpYB2xcICHi0GalW60c7Pm4k2+fuw7y3IWLiHxb0HqC8WecPfT+B+3TqK
         +/O2n44TmEjlaomg4pdUwLWpBunom9pu6g8fzMmRGia6auYAhFM6+Sy/iCaHqvKlqN
         4VIiYXqjF3B3I/269s+xmOhxTV8N2iE6pCSDwiguPTXNTBiSXHfZ9ikOEN/hxhPEeD
         A2T8xkHeHkveVaIJ+MBKtAjVWNNY/RGAprZvpS2un2iDOgHocNS7O/S2jSIW+SA3oa
         F2NadOrknxx+/14LxgdIuyQjYW+R7JFbydHwvzT8z55C7lceRsfQJle10bpCxe3ekz
         AM6/rWXx+OlzQ==
Date:   Wed, 6 Sep 2023 15:13:26 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Helen Koike <helen.koike@collabora.com>
Cc:     Vignesh Raman <vignesh.raman@collabora.com>,
        dri-devel@lists.freedesktop.org, guilherme.gallo@collabora.com,
        sergi.blanch.torne@collabora.com, david.heidelberg@collabora.com,
        daniels@collabora.com, gustavo.padovan@collabora.com,
        emma@anholt.net, robclark@freedesktop.org, robdclark@google.com,
        anholt@google.com, robdclark@gmail.com, airlied@gmail.com,
        daniel@ffwll.ch, jani.nikula@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 2/7] drm: ci: Force db410c to host mode
Message-ID: <czfx23mt73bpqtz6ljurrzfodesojnomna7yvv5e5vrl6pwlsj@shuguijvjzdn>
References: <20230904161516.66751-1-vignesh.raman@collabora.com>
 <20230904161516.66751-3-vignesh.raman@collabora.com>
 <cb1b9fea-d74f-fc32-a771-79713cf15674@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tnansnqalun7wlmf"
Content-Disposition: inline
In-Reply-To: <cb1b9fea-d74f-fc32-a771-79713cf15674@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tnansnqalun7wlmf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 06, 2023 at 09:55:40AM -0300, Helen Koike wrote:
> Hi!
>=20
> On 04/09/2023 13:15, Vignesh Raman wrote:
> > Force db410c to host mode to fix network issue which results in failure
> > to mount root fs via NFS.
> > See https://gitlab.freedesktop.org/gfx-ci/linux/-/commit/cb72a629b8c15c=
80a54dda510743cefd1c4b65b8
> >=20
> > Use fdtoverlay command to merge base device tree with an overlay
> > which contains the fix for USB controllers to work in host mode.
> >=20
> > Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> > ---
> >=20
> > v2:
> >    - Use fdtoverlay command to merge overlay dtbo with the base dtb ins=
tead of modifying the kernel sources
> > ---
> >   drivers/gpu/drm/ci/build.sh                         |  5 +++++
> >   .../gpu/drm/ci/dt-overlays/apq8016-sbc-overlay.dts  | 13 +++++++++++++
> >   2 files changed, 18 insertions(+)
> >   create mode 100644 drivers/gpu/drm/ci/dt-overlays/apq8016-sbc-overlay=
=2Edts
> >=20
> > diff --git a/drivers/gpu/drm/ci/build.sh b/drivers/gpu/drm/ci/build.sh
> > index 7b014287a041..92ffd98cd09e 100644
> > --- a/drivers/gpu/drm/ci/build.sh
> > +++ b/drivers/gpu/drm/ci/build.sh
> > @@ -92,6 +92,11 @@ done
> >   if [[ -n ${DEVICE_TREES} ]]; then
> >       make dtbs
> > +    if [[ -e arch/arm64/boot/dts/qcom/apq8016-sbc.dtb ]]; then
> > +        dtc -@ -I dts -O dtb -o drivers/gpu/drm/ci/dt-overlays/apq8016=
-sbc-overlay.dtbo drivers/gpu/drm/ci/dt-overlays/apq8016-sbc-overlay.dts
> > +        fdtoverlay -i arch/arm64/boot/dts/qcom/apq8016-sbc.dtb -o arch=
/arm64/boot/dts/qcom/apq8016-sbc-overlay.dtb drivers/gpu/drm/ci/dt-overlays=
/apq8016-sbc-overlay.dtbo
> > +        mv arch/arm64/boot/dts/qcom/apq8016-sbc-overlay.dtb arch/arm64=
/boot/dts/qcom/apq8016-sbc.dtb
> > +    fi
> >       cp ${DEVICE_TREES} /lava-files/.
> >   fi
> > diff --git a/drivers/gpu/drm/ci/dt-overlays/apq8016-sbc-overlay.dts b/d=
rivers/gpu/drm/ci/dt-overlays/apq8016-sbc-overlay.dts
> > new file mode 100644
> > index 000000000000..57b7604f1c23
> > --- /dev/null
> > +++ b/drivers/gpu/drm/ci/dt-overlays/apq8016-sbc-overlay.dts
> > @@ -0,0 +1,13 @@
> > +/dts-v1/;
> > +/plugin/;
> > +
> > +/ {
> > +    fragment@0 {
> > +        target-path =3D "/soc@0";
> > +        __overlay__ {
> > +            usb@78d9000 {
> > +                dr_mode =3D "host";
> > +            };
> > +        };
> > +    };
> > +};
>=20
>=20
> Another thing that I was discussing with David and Vignesh, since we will
> need this overlay spinets not only for drm-ci but also for mesa ci (and
> every body who uses the farms), would it be interesting to move it to some
> place more official? like dts folders? Or would that be against Linux
> policy?

AFAIK, the policy was changed recently to allow overlays to be merged,
see $(find arch/ -name *.dtso). So generally speaking, it should be ok
to send it.

Maxime

--tnansnqalun7wlmf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZPh69gAKCRDj7w1vZxhR
xZ0pAP9Tuuixtbr8xNkw8lkk+Su6S0hCQvafwExM+JpYFXjjHwEAsyn1VL2iZWe8
e6DoUUOIu3PsMZrCl33lKhXhoorvcw0=
=gEwQ
-----END PGP SIGNATURE-----

--tnansnqalun7wlmf--
