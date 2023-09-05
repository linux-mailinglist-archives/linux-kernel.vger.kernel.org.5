Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21FB792BA9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346205AbjIEQ4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353940AbjIEIoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 04:44:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8BACCB;
        Tue,  5 Sep 2023 01:43:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C915460ABD;
        Tue,  5 Sep 2023 08:43:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD5E4C433C7;
        Tue,  5 Sep 2023 08:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693903438;
        bh=DwiI5lyTh5bUNu73RK8eFU7X1ZQGBwm/VemwAZ1Cpb8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iPyTX6BznVbDgamxksQvlZZd/yJ7wvYrwLTGZ8lOGFcK2o7cwvFZvbYfHsqR9UkRe
         5E0ojMi78/TcC5yHF0Tq0YId7hb3VrVeiajU9MHCmL1YNHKQEg1cP2oC+7uh7R+rkm
         ypendgexNlI8CLurRC8vPK3Jcju2UhI8OdtPDGwLQO5DV8Bq1+eh8F6ppICzMH9Q7U
         8LFYc9dZ+p/iWyXNv3lgZ06zVf8jfYifatBj49V/e2mjsOY3wqYYDrNCq//zJPtt0r
         yvb9Y3opK6kYL/jDayDqRvJmQ5eb/DWiXOpxH3bPqVtZd6Fech8tPCZ5PiVK/9cYDe
         71t3zQ9eTSMzg==
Date:   Tue, 5 Sep 2023 10:43:55 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Vignesh Raman <vignesh.raman@collabora.com>,
        dri-devel@lists.freedesktop.org, helen.koike@collabora.com,
        guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com,
        david.heidelberg@collabora.com, daniels@collabora.com,
        gustavo.padovan@collabora.com, emma@anholt.net,
        robclark@freedesktop.org, robdclark@google.com, anholt@google.com,
        robdclark@gmail.com, airlied@gmail.com, daniel@ffwll.ch,
        jani.nikula@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 2/7] drm: ci: Force db410c to host mode
Message-ID: <ueznsu2dlvq5zp3ls262fww54bnlqa3e2ssr6f65vrrionloms@ir2ywgeajj4w>
References: <20230904161516.66751-1-vignesh.raman@collabora.com>
 <20230904161516.66751-3-vignesh.raman@collabora.com>
 <CAA8EJpq_cmFQ6TGy1xELh3ButWKLfSkQcp5ix049s_iqKw6DvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAA8EJpq_cmFQ6TGy1xELh3ButWKLfSkQcp5ix049s_iqKw6DvQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 04, 2023 at 07:59:26PM +0300, Dmitry Baryshkov wrote:
> On Mon, 4 Sept 2023 at 19:16, Vignesh Raman <vignesh.raman@collabora.com>=
 wrote:
> >
> > Force db410c to host mode to fix network issue which results in failure
> > to mount root fs via NFS.
> > See https://gitlab.freedesktop.org/gfx-ci/linux/-/commit/cb72a629b8c15c=
80a54dda510743cefd1c4b65b8
> >
> > Use fdtoverlay command to merge base device tree with an overlay
> > which contains the fix for USB controllers to work in host mode.
> >
> > Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> > ---
> >
> > v2:
> >   - Use fdtoverlay command to merge overlay dtbo with the base dtb inst=
ead of modifying the kernel sources
> >
> > ---
> >  drivers/gpu/drm/ci/build.sh                         |  5 +++++
> >  .../gpu/drm/ci/dt-overlays/apq8016-sbc-overlay.dts  | 13 +++++++++++++
> >  2 files changed, 18 insertions(+)
> >  create mode 100644 drivers/gpu/drm/ci/dt-overlays/apq8016-sbc-overlay.=
dts
> >
> > diff --git a/drivers/gpu/drm/ci/build.sh b/drivers/gpu/drm/ci/build.sh
> > index 7b014287a041..92ffd98cd09e 100644
> > --- a/drivers/gpu/drm/ci/build.sh
> > +++ b/drivers/gpu/drm/ci/build.sh
> > @@ -92,6 +92,11 @@ done
> >
> >  if [[ -n ${DEVICE_TREES} ]]; then
> >      make dtbs
> > +    if [[ -e arch/arm64/boot/dts/qcom/apq8016-sbc.dtb ]]; then
> > +        dtc -@ -I dts -O dtb -o drivers/gpu/drm/ci/dt-overlays/apq8016=
-sbc-overlay.dtbo drivers/gpu/drm/ci/dt-overlays/apq8016-sbc-overlay.dts
> > +        fdtoverlay -i arch/arm64/boot/dts/qcom/apq8016-sbc.dtb -o arch=
/arm64/boot/dts/qcom/apq8016-sbc-overlay.dtb drivers/gpu/drm/ci/dt-overlays=
/apq8016-sbc-overlay.dtbo
> > +        mv arch/arm64/boot/dts/qcom/apq8016-sbc-overlay.dtb arch/arm64=
/boot/dts/qcom/apq8016-sbc.dtb
> > +    fi
> >      cp ${DEVICE_TREES} /lava-files/.
> >  fi
> >
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
> > --
> > 2.40.1
>=20
> Can we use normal dtso syntax here instead of defining fragments manually?

What Dmitry is hinting about is to use the "Sugar Syntax". There a good doc=
umentation here:
https://source.android.com/docs/core/architecture/dto/syntax

Maxime
