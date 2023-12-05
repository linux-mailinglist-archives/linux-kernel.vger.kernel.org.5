Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473DD805C66
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235213AbjLEQ4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235143AbjLEQzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:55:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0EFD41
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 08:55:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C03C433C7;
        Tue,  5 Dec 2023 16:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701795348;
        bh=RwcNNAfsT2+STZzMi5x3BGwN32YgoA2d0mKr4ENbGZE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FjFLZ1Rh+du2h3Xb0bSK4KrUOT6fT/mC3PCn1xTExxYL1Y9m6klM24q5lg1anp4fM
         VNee4O0kp/dYn/OjnEz2zyPba6X5OPGM/zHSORp8+8noc+Fs/VoH4RI6HHM1uFtGVO
         23v3U91sGep4k51vdmQE7QGYYBhrzTH4vVQUoTQ9UCG/yUQ1sQqvO8GzKgQtOOnJlu
         ImKOnsrqWdkJzcwZK9yqxYPuTDOg33Ea9YikvpStDx8Ra+JAHSfou0NygtMVmwEplC
         DTm5Ld0nRrs/7yx92WsNscDE1+9aj/9ztHcwj53aZcD1gyHCOuJZgBM2BSDKNvyQ7S
         /67tlhJmHj2Jw==
Date:   Tue, 5 Dec 2023 16:55:42 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Alex Bee <knaerzche@gmail.com>, heiko@sntech.de,
        hjc@rock-chips.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] dt-bindings: drm: rockchip: convert
 inno_hdmi-rockchip.txt to yaml
Message-ID: <20231205-agency-paralyses-2a7b6df25c66@spud>
References: <49c6afec-022f-02de-99a0-d409b64da198@gmail.com>
 <3f235189-da75-4e9d-ad68-8cbebca12f6d@gmail.com>
 <3331543a-73fb-3565-47c6-d3303c44ba21@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7k2kR/ZshohNs10q"
Content-Disposition: inline
In-Reply-To: <3331543a-73fb-3565-47c6-d3303c44ba21@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7k2kR/ZshohNs10q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 04, 2023 at 09:47:15PM +0100, Johan Jonker wrote:
> On 12/4/23 19:56, Alex Bee wrote:
> > Am 04.12.23 um 18:39 schrieb Johan Jonker:
> >> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockch=
ip,inno-hdmi.yaml b/Documentation/devicetree/bindings/display/rockchip/rock=
chip,inno-hdmi.yaml
> >> new file mode 100644
> >> index 000000000000..96889c86849a
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,inno=
-hdmi.yaml
> >> @@ -0,0 +1,103 @@
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/display/rockchip/rockchip,inno-hdm=
i.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Rockchip Innosilicon HDMI controller
> >> +
> >> +maintainers:
> >> +=A0 - Sandy Huang <hjc@rock-chips.com>
> >> +=A0 - Heiko Stuebner <heiko@sntech.de>
> >> +
> >> +properties:
> >> +=A0 compatible:
> >> +=A0=A0=A0 enum:
> >> +=A0=A0=A0=A0=A0 - rockchip,rk3036-inno-hdmi
> >> +
> >> +=A0 reg:
> >> +=A0=A0=A0 maxItems: 1
> >> +
> >> +=A0 interrupts:
> >> +=A0=A0=A0 maxItems: 1
> >> +
> >> +=A0 clocks:
> >> +=A0=A0=A0 maxItems: 1
>=20
> > The interrupts/clock description exists already in the txt-bindings - s=
o how about:
> >=20
> > +=A0=A0=A0 items:
> > +=A0=A0=A0=A0=A0 - descrition: ....
> >> +
>=20
> It's not common to do so when there's only one clock and nothing special =
to mention.
> Used this style for most of my conversions.=20
> Further rational might be given by Krzysztof and co.

Ye, when there is no ambiguity, having the description is not
required.

--7k2kR/ZshohNs10q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZW9WDgAKCRB4tDGHoIJi
0kOrAP9ylHU9P8zGa7mCfZC4jocgIUPfnviKF/UNsLkrX04RRgEAoOTHJFCbSG0E
PQExNlhDrVVvQL7O9+TCRCb60H04Uwg=
=Ow+j
-----END PGP SIGNATURE-----

--7k2kR/ZshohNs10q--
