Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4032E786B0A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 11:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235545AbjHXJDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 05:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240610AbjHXJDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:03:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990B41739;
        Thu, 24 Aug 2023 02:03:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2430E6681C;
        Thu, 24 Aug 2023 09:03:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086BFC433C7;
        Thu, 24 Aug 2023 09:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692867794;
        bh=Z8KlcqN4v0YazhOwIq0aooQp2XTZu97r8b9euGXZqoA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=caA6GBHu/rOcwKFHL012iyP6ZEaKUsOat1S1YC1dfWR4Lqik3t3Y6lKJxSjrghpFl
         eaGr8w/TJGs11oiNM6Egg6TmlvlPAS4K2QfVXmK4JIBGVtL/iEA1vdXseCXtmkBQB0
         6/pNQSqA1csldlXoyrGC/JJt7+FP3BvnB8274YrIHH8Nyt5TEHH30cOhTvjZQt83ox
         nYoAFqA3uE5Q9RZP6HtsfWH7c5ls2gnpCqFhX6He14cgpnh0lwqYWQIGK8w6Y6+b8T
         FyDVC4rNvGvDSsGcfoGn5AF7pT0Oxl/2+A+IhPSUGEkQ4X32P/v89W5LfuKo2YlrFt
         wrdK6+FeYX6jg==
Date:   Thu, 24 Aug 2023 11:03:11 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Danilo Krummrich <dakr@redhat.com>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Fabio Estevam <festevam@gmail.com>,
        Gourav Samaiya <gsamaiya@nvidia.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Jerome Glisse <glisse@freedesktop.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Karol Herbst <kherbst@redhat.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linaro-mm-sig@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-tegra@vger.kernel.org, Luben Tuikov <luben.tuikov@amd.com>,
        Lyude Paul <lyude@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?utf-8?B?TWHDrXJh?= Canal <mairacanal@riseup.net>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        nouveau@lists.freedesktop.org, NXP Linux Team <linux-imx@nxp.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shashank Sharma <shashank.sharma@amd.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stanley Yang <Stanley.Yang@amd.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH (set 1) 00/20] Rid W=1 warnings from GPU
Message-ID: <pkjgu5hfazblvlnolvsbzo6zt7yq4zldjmmuoufgv5txvzdiyc@2vplkaitfypc>
References: <20230824073710.2677348-1-lee@kernel.org>
 <169286759481.453038.12943953579128536191.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s4bcoziyhif3xhyv"
Content-Disposition: inline
In-Reply-To: <169286759481.453038.12943953579128536191.b4-ty@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s4bcoziyhif3xhyv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 24, 2023 at 10:59:54AM +0200, Maxime Ripard wrote:
> On Thu, 24 Aug 2023 08:36:45 +0100, Lee Jones wrote:
> > This set is part of a larger effort attempting to clean-up W=3D1
> > kernel builds, which are currently overwhelmingly riddled with
> > niggly little warnings.
> >=20
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org
> > Cc: Ben Skeggs <bskeggs@redhat.com>
> > Cc: "Christian K=F6nig" <christian.koenig@amd.com>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Danilo Krummrich <dakr@redhat.com>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: Fabio Estevam <festevam@gmail.com>
> > Cc: Gourav Samaiya <gsamaiya@nvidia.com>
> > Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> > Cc: Hyun Kwon <hyun.kwon@xilinx.com>
> > Cc: Jerome Glisse <glisse@freedesktop.org>
> > Cc: Jonathan Hunter <jonathanh@nvidia.com>
> > Cc: Karol Herbst <kherbst@redhat.com>
> > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Cc: linaro-mm-sig@lists.linaro.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-media@vger.kernel.org
> > Cc: linux-tegra@vger.kernel.org
> > Cc: Luben Tuikov <luben.tuikov@amd.com>
> > Cc: Lyude Paul <lyude@redhat.com>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: "Ma=EDra Canal" <mairacanal@riseup.net>
> > Cc: Mario Limonciello <mario.limonciello@amd.com>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: Michal Simek <michal.simek@xilinx.com>
> > Cc: Mikko Perttunen <mperttunen@nvidia.com>
> > Cc: nouveau@lists.freedesktop.org
> > Cc: NXP Linux Team <linux-imx@nxp.com>
> > Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> > Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> > Cc: Philipp Zabel <p.zabel@pengutronix.de>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Shashank Sharma <shashank.sharma@amd.com>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Stanley Yang <Stanley.Yang@amd.com>
> > Cc: Sumit Semwal <sumit.semwal@linaro.org>
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> >=20
> > [...]
>=20
> Applied to drm/drm-misc (drm-misc-fixes).

I got confused with b4 usage, but that wasn't actually applied. Only the
three patches I explicitly mentioned were, sorry for the confusion.

Maxime

--s4bcoziyhif3xhyv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZOcczwAKCRDj7w1vZxhR
xcTFAQCQGXPUBXnODsaFgiEuFrckjOE5PisQ37NiNjGWWZt44gD+LVUnaHSq7tTE
6GayDpzLrPM2MsMV5u6yhfmhsd7IRw4=
=b2pz
-----END PGP SIGNATURE-----

--s4bcoziyhif3xhyv--
