Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079EE802E26
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbjLDJAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 04:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbjLDJAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:00:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D54F101
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 01:00:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92DF7C433C8;
        Mon,  4 Dec 2023 09:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701680441;
        bh=NHppATTzdQBKuC3hOQxnsiBMV4fyRqrL8p5HNiVQcps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oWgSsA9rji0i+syjJ1FMaR5URFRP6mcka0q1wHVgE7RPFcqSxof/st2w8qfn0a6qG
         3mvlHegu1S2+fVaP5C2pXSgYn8pLTO8AOcE3SRZmxwTX5DkRjPyhyVFINZ0SMd/V14
         xlP8VOeOQ6jlAWE+9Zx0NcTgNqTYq78Kpug5b5ko0pAZHZtH/UbP7ZaHqadee4LBIZ
         Qb+sZzzsfS8KYypN8WQMRUaKhyibq3xf+Q3gPgbn0gNjnTvpaPzDXj/8nXcENnVoPe
         /b+A72Ozx49IoCiOighJzQy3rbKlgVPzuwoCrrpGPZsqQi6jNGbH6wmV9dMMwJylMN
         rQff2873D5alw==
Date:   Mon, 4 Dec 2023 10:00:39 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Simon Ser <contact@emersion.fr>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        quic_abhinavk@quicinc.com, ppaalanen@gmail.com,
        laurent.pinchart@ideasonboard.com, sebastian.wick@redhat.com,
        ville.syrjala@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        wayland-devel@lists.freedesktop.org,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Sebastian Wick <sebastian@sebastianwick.net>
Subject: Re: (subset) [PATCH RFC v7 00/10] Support for Solid Fill Planes
Message-ID: <hinlseiuf2l4y2tbaoasx7slaoewnoil2fitavgarrekxhhzte@zood7lj6sbn5>
References: <20231027-solid-fill-v7-0-780188bfa7b2@quicinc.com>
 <170155324921.2215646.4829699354481827834.b4-ty@linaro.org>
 <OiX1EToyQ0JBECS-Vs6IOw1vqLTt42PYkTlTCBhsPUi-VXC2UoLjkRfEW-OFucxsTqz93Q3IIXZZ3Lw_Lqs1dFt4YbuFSUGrKfDPnnKDCbw=@emersion.fr>
 <CAA8EJpom-guy0p_u2kLhXgLZnJaVXCXaHAUGhv2EH=xyrHtL6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d7zlmb36ttt6m7sm"
Content-Disposition: inline
In-Reply-To: <CAA8EJpom-guy0p_u2kLhXgLZnJaVXCXaHAUGhv2EH=xyrHtL6A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d7zlmb36ttt6m7sm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 03, 2023 at 08:10:31PM +0200, Dmitry Baryshkov wrote:
> On Sun, 3 Dec 2023 at 14:15, Simon Ser <contact@emersion.fr> wrote:
> >
> > On Saturday, December 2nd, 2023 at 22:41, Dmitry Baryshkov <dmitry.bary=
shkov@linaro.org> wrote:
> >
> > > On Fri, 27 Oct 2023 15:32:50 -0700, Jessica Zhang wrote:
> > >
> > > > Some drivers support hardware that have optimizations for solid fill
> > > > planes. This series aims to expose these capabilities to userspace =
as
> > > > some compositors have a solid fill flag (ex. SOLID_COLOR in the And=
roid
> > > > hardware composer HAL) that can be set by apps like the Android Gea=
rs
> > > > test app.
> > > >
> > > > In order to expose this capability to userspace, this series will:
> > > >
> > > > [...]
> > >
> > >
> > > Applied to drm-misc-next, thanks!
> >
> > Where are the IGT and userspace for this uAPI addition?
>=20
> Indeed. I checked that there are uABI acks/reviews, but I didn't check
> these requirements. Frankly speaking, I thought that they were handled
> already, before giving the ack. How should we proceed? Should I land a
> revert?

Yes

Maxime

--d7zlmb36ttt6m7sm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZW2VNgAKCRDj7w1vZxhR
xRD9AP9L9eZW/RH/TvF7TEDGDHV3nZjFxt4l2zx4F6EAb9QfXQD/SjP0MhyZzZ+W
nqFhDLoXMhCDz5x+hbAy5SgVdjLrjwQ=
=wTnT
-----END PGP SIGNATURE-----

--d7zlmb36ttt6m7sm--
