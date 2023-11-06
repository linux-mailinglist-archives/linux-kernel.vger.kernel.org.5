Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148277E1BB3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 09:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjKFIJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 03:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjKFIJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 03:09:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72F5AB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 00:09:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0559C433C7;
        Mon,  6 Nov 2023 08:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699258140;
        bh=cQd+azsc2oimsjoDW+JNBoyhlpbKfDDSir8RkjpSStI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NZuFwbyfcJ9n4MbPS3NTDxWXf8dc/DZRPA2EkILBNwTduseifJa3Tm2dlWB/Qf6hk
         rueTRIMmZgWx8SFUOJwOVr3sNJXvZv4ZtRI1xl7dgGCQ1BVT8Okd2zCD4fTm2l4Qjq
         BLp1CCYqcLHHFDgN3tkIfGbUKPBi7EEhmKXD1QYA99zy1aflGkPASb2iUO6B+sgK8m
         zOmd+mKe0G6OY6G0B+TdyiR/FTcgBN+qPQsMOddBWtTlJNre6o1JJyuoOc+GoBWAmI
         GbA5i3KcgOv8+3smAVof21QsCdW4N/Zm4jqpMTMnvoYOvIc1xfG3c4v1GDrXVqL92K
         xtV5Q1aptclpw==
Date:   Mon, 6 Nov 2023 09:08:57 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] drm/modes: Add a function to clear preferred modes
Message-ID: <sezmpwogythlst6hnmrpq4hepkdcd764vbgcojidlfotm5boa6@txbcylifakwz>
References: <20231102221309.1971910-1-hsinyi@chromium.org>
 <20231102221309.1971910-4-hsinyi@chromium.org>
 <CAD=FV=VUNdSzppccDO=y0iu_QR8nEe3poRLMmWvFMfZsnWZo4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zqnepkdr67hu4afr"
Content-Disposition: inline
In-Reply-To: <CAD=FV=VUNdSzppccDO=y0iu_QR8nEe3poRLMmWvFMfZsnWZo4A@mail.gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zqnepkdr67hu4afr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 03, 2023 at 09:02:33AM -0700, Doug Anderson wrote:
> Hi,
>=20
> On Thu, Nov 2, 2023 at 3:13=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org>=
 wrote:
> >
> > Add a function to clear the preferred bit of a connector's existing mod=
es.
> > This is useful for edp panel to unset the preferred modes read from edid
> > if the panel has hard-coded modes.
> >
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > ---
> > v1->v2:
> > - fix doc string (reported by kernel test robot).
> > - split mode and panel patches.
> > ---
> >  drivers/gpu/drm/drm_modes.c | 16 ++++++++++++++++
> >  include/drm/drm_modes.h     |  1 +
> >  2 files changed, 17 insertions(+)
>=20
> This seems fine to me.
>=20
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>=20
> Since it introduces a new API to the core and Hsin-Yi and I work
> directly together, I'd probably give this ~2 weeks on the list before
> landing so there is adequate time for people to comment. That'll be
> right in the middle of Plumbers, though, so it might be more like 3
> weeks. If someone non-ChromeOS wants to review and/or apply sooner, I
> certainly wouldn't object.

FTR, I just made some review on v1 that still applies to that version.

Maxime

--zqnepkdr67hu4afr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZUifGQAKCRDj7w1vZxhR
xdH7AQC1JzbaPpA3miMXGslhsTqX06/6ak67NTh9Xg6ELjtkkwD/eI7TgL8/stY9
lgUDUqvMS5ffwioajaaqRDIPwJ+V/gY=
=Usd2
-----END PGP SIGNATURE-----

--zqnepkdr67hu4afr--
