Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B47B75A036
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 22:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjGSUvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 16:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjGSUvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 16:51:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A971FE2;
        Wed, 19 Jul 2023 13:51:35 -0700 (PDT)
Received: from mercury (unknown [185.254.75.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E2E156607078;
        Wed, 19 Jul 2023 21:51:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689799894;
        bh=c3uH/gG1XWxCmsfa/PtfUqtSiWqoIU9tT6WvHwLXMgM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NHxWKfjTdramqP30Ar8ukCkAzRt5qmjDXa/OA6fMDnoIAfYN+sRNUe7t2CTXt5CVp
         xDIJfwcPhY7p2FuTzRLQv6qKHoheJtYTX8nMFwmxHBN0TWPZiuXnESnkEu5uAgXcyq
         FNEWy89JfqlQ0bFQn8jwnGjgZ0NeIdz+7OH1YhucUn5Ke9r8f7b+z209X/uGDCc0Nd
         K9qqMu/PDT92oYjRnmNX1Ijj76unq76IckCkJCftmPoMFNmqEksETXwB9V3DrdF/D4
         GKWcLVDDYZYcbuXPFJwFbC9ouH4DkxPwEy9C8M0owQa80PnadMWr6duuVuxq5PpUML
         I0konnbQTjCQg==
Received: by mercury (Postfix, from userid 1000)
        id 2A3571061387; Wed, 19 Jul 2023 22:51:31 +0200 (CEST)
Date:   Wed, 19 Jul 2023 22:51:31 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Simon Glass <sjg@chromium.org>
Cc:     Rob Herring <robh@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Support Opensource <support.opensource@diasemi.com>,
        David Lechner <david@lechnology.com>,
        Iskren Chernev <me@iskren.info>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-oxnas@groups.io
Subject: Re: [PATCH v2] power: Explicitly include correct DT includes
Message-ID: <20230719205131.xmfyggy7y2dusjrx@mercury.elektranox.org>
References: <20230718143045.1065100-1-robh@kernel.org>
 <CAPnjgZ0H077Hdq2HoOyrYxjAmXLigRrj+6H3sPLidtDa2w=Wcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o4yglry5cm6klniy"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ0H077Hdq2HoOyrYxjAmXLigRrj+6H3sPLidtDa2w=Wcw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--o4yglry5cm6klniy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 18, 2023 at 07:08:01PM -0600, Simon Glass wrote:
> On Tue, 18 Jul 2023 at 08:31, Rob Herring <robh@kernel.org> wrote:
> > The DT of_device.h and of_platform.h date back to the separate
> > of_platform_bus_type before it as merged into the regular platform bus.
> > As part of that merge prepping Arm DT support 13 years ago, they
> > "temporarily" include each other. They also include platform_device.h
> > and of.h. As a result, there's a pretty much random mix of those include
> > files used throughout the tree. In order to detangle these headers and
> > replace the implicit includes with struct declarations, users need to
> > explicitly include the correct includes.
> >
> > Acked-by: David Lechner <david@lechnology.com>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > v2:
> > - Fix double include of of.h
> > ---
> >  drivers/power/reset/as3722-poweroff.c            | 1 -
> >  drivers/power/reset/brcm-kona-reset.c            | 4 ++--
> >  drivers/power/reset/gpio-poweroff.c              | 3 ++-
> >  drivers/power/reset/gpio-restart.c               | 2 +-
> >  drivers/power/reset/keystone-reset.c             | 3 ++-
> >  drivers/power/reset/ocelot-reset.c               | 4 ++--
> >  drivers/power/reset/odroid-go-ultra-poweroff.c   | 3 ++-
> >  drivers/power/reset/oxnas-restart.c              | 2 --
> >  drivers/power/reset/st-poweroff.c                | 2 +-
> >  drivers/power/reset/syscon-poweroff.c            | 3 +--
> >  drivers/power/reset/syscon-reboot.c              | 3 +--
> >  drivers/power/reset/xgene-reboot.c               | 2 +-
> >  drivers/power/supply/axp20x_ac_power.c           | 1 -
> >  drivers/power/supply/axp20x_battery.c            | 1 -
> >  drivers/power/supply/axp20x_usb_power.c          | 1 -
> >  drivers/power/supply/cpcap-battery.c             | 2 +-
> >  drivers/power/supply/da9150-charger.c            | 2 --
> >  drivers/power/supply/da9150-fg.c                 | 1 -
> >  drivers/power/supply/lego_ev3_battery.c          | 2 +-
> >  drivers/power/supply/ltc2941-battery-gauge.c     | 2 +-
> >  drivers/power/supply/ltc4162-l-charger.c         | 2 +-
> >  drivers/power/supply/max14656_charger_detector.c | 2 +-
> >  drivers/power/supply/max17040_battery.c          | 2 +-
> >  drivers/power/supply/max8903_charger.c           | 1 -
> >  drivers/power/supply/rn5t618_power.c             | 1 -
> >  drivers/power/supply/rt5033_charger.c            | 2 +-
> >  drivers/power/supply/rt9455_charger.c            | 3 +--
> >  drivers/power/supply/sbs-battery.c               | 2 +-
> >  drivers/power/supply/tps65090-charger.c          | 2 +-
> >  drivers/power/supply/tps65217_charger.c          | 1 -
> >  drivers/power/supply/twl4030_charger.c           | 1 +
> >  31 files changed, 26 insertions(+), 37 deletions(-)
>=20
> Reviewed-by: Simon Glass <sjg@chromium.org>

Thanks, queued.

-- Sebastian

--o4yglry5cm6klniy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmS4TMkACgkQ2O7X88g7
+pq7lg//WgZTHis+b/+aR3UeuhJImAXVAknxQX4lPsDZ9Q4pMWR8h1FlZPpwhIol
YkNrPwE1yK6Xxe8kUSnFDI/gqFD+vRqeEaMNSxcwjlzNX+XVe5NPA37mdAruHnNI
JTH5n1isMVQrT3kulswPgAz+X2/CUI31FJQURqHob1c52cS2edrqv2VwWDVC/ozY
NpyhgzJgYwXLODp/SmOW4bo2Lq9Dx8GlqiiNWaPnUu96Z4zW0WEQEYvxRbTWky0Q
SHmKXDzaxbbTRYJ5B4Fbygtoy7cmbN5FKN4Reh6GfieDf5+/VTXiEVUsw1Volas7
bEuSqdw9lICEx0YIpf2WCxP7+R7dZ1UHzgs9CoI8dBpZMNAoMNV48VLoLgDgyBYS
s7IffoU4bs0jMzdBSkCseeEyOUV0wGqQPUbJAJyH7feCrGjVLUf01ay/gyiFy6eu
v64+5g35xbw0Yq6WPG82WsWsZYb7xox3gFFosWLD2O3k6CjIm/AAydx71IIwBiHI
43argw9f+njfusK7PVWwMqQiEkJLcv37M78ZrK/RX3TIy/GdLOpFgPbUovRlF3dk
ojIlqOwDFx9qhwij3Gy6cSawaEeK6A2TnUIdxEi0/QN+ukUcGQHAWetG9aCtPyTq
+RTMvoOUC1qwZJqsrvihAhnnKu5e6XP3rkTshqIYmQUav3z1OO4=
=yzKh
-----END PGP SIGNATURE-----

--o4yglry5cm6klniy--
