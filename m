Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D947A96BF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjIURHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjIURHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:07:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1E9E5E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:05:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB7EC4E686;
        Thu, 21 Sep 2023 13:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695302561;
        bh=TDkHjuBAUHGaA9x0jaeflmG3lngMSTMxWnqRP7KO9WE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hDx0Pr44vyHbTUmSchVYbhM2n5mFxeA8rzoLd2GYz+TceZEKtqSphUUIUdmm2K7bh
         eqgACJcTy+PJXs5P0sRjVMpALU+yhfiHVvhi9547tC1axdSmUJD4jo+LDBmMUVaZLC
         XZpjfjilEBMuX++ajKrHU2vlCCBe3rVOSIRGdHJlXgsJZ8PK6b6XcS1tTtgXenfTfx
         SJVCKdtbtragyRUoxLKX3eNnGegzX37KexTYgzNcCmD94RI8mY0lZG91+jarSYVRC8
         xdprc6PRR2mPuWooCPjlpw0ULY1UnS7ie2izMnQryTRWzpc0tWpomkOPylGnPD2i11
         OKjWwKT8CPXjg==
Date:   Thu, 21 Sep 2023 15:22:39 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/ssd130x: Drop _helper prefix from struct
 drm_*_helper_funcs callbacks
Message-ID: <tqllt5ddlmho5corvdpnqab2ghz2344tbdtczett263y4uajlo@agdoqol4esir>
References: <20230914195138.1518065-1-javierm@redhat.com>
 <f5620d32-2705-498b-a65c-7dc663340a6d@suse.de>
 <87wmwo3q50.fsf@minerva.mail-host-address-is-not-set>
 <552hpgr7qzbjxuyei3n5m7rsn7ekwbdgzv25oe5vy6qb35gf23@q4etussk5jwl>
 <d1f26dbd-5f32-4eb2-af16-f15fe95cc2ec@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4sox4ca5522j7baz"
Content-Disposition: inline
In-Reply-To: <d1f26dbd-5f32-4eb2-af16-f15fe95cc2ec@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4sox4ca5522j7baz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 21, 2023 at 10:52:14AM +0200, Thomas Zimmermann wrote:
> Am 21.09.23 um 09:44 schrieb Maxime Ripard:
> > On Mon, Sep 18, 2023 at 09:19:07AM +0200, Javier Martinez Canillas wrot=
e:
> > > Thomas Zimmermann <tzimmermann@suse.de> writes:
> > >=20
> > > > Hi
> > > >=20
> > > > Am 14.09.23 um 21:51 schrieb Javier Martinez Canillas:
> > > > > The driver uses a naming convention where functions for struct dr=
m_*_funcs
> > > > > callbacks are named ssd130x_$object_$operation, while the callbac=
ks for
> > > > > struct drm_*_helper_funcs are named ssd130x_$object_helper_$opera=
tion.
> > > > >=20
> > > > > The idea is that this helper_ prefix in the function names denote=
 that are
> > > > > for struct drm_*_helper_funcs callbacks. This convention was copi=
ed from
> > > > > other drivers, when ssd130x was written but Maxime pointed out th=
at is the
> > > > > exception rather than the norm.
> > > >=20
> > > > I guess you found this in my code. I want to point out that I use t=
he
> > > > _helper infix to signal that these are callback for
> > > > drm_primary_plane_helper_funcs and *not* drm_primary_plane_funcs. T=
he
> > > > naming is intentional.
> > > >=20
> > >=20
> > > Yes, that's what tried to say in the commit message and indeed I got =
the
> > > convention from drivers in drivers/gpu/drm/tiny. In fact I believe th=
ese
> > > function names are since first iteration of the driver, when was mean=
t to
> > > be a tiny driver.
> > >=20
> > > According to Maxime it's the exception rather than the rule and sugge=
sted
> > > to change it, I don't really have a strong opinion on either naming T=
BH.
> >=20
> > Maybe that's just me, but the helper in the name indeed throws me off. =
In my
> > mind, it's supposed to be used only for helpers, not functions implemen=
ting the
> > helpers hooks.
>=20
> Tying the function name to its _funcs structure makes perfect sense to me,
> as it helps to structure the driver code. So I always use the _helper_
> infix.
>=20
> In contrast, the DRM helpers that implement certain functionality does not
> seem to follow any naming scheme. For example drm_atomic_helper_check()
> implements struct drm_mode_config_funcs.atomic_check. To me, it's not
> obvious that these two belong together.

Right, but then we end up with functions that have helpers in their name
and are indeed helpers, and then we have functions that have helpers in
their name but are not meant to help anyone or be reused anywhere else.

> And in the same structure, there's fb_create, which is provided by
> drm_gem_fb_create_with_dirty(). This one doesn't even mention that
> it's a helper.

We should fix that then I guess?

Anyway, we're way past bikeshedding there :)

Maxime

--4sox4ca5522j7baz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZQxDnwAKCRDj7w1vZxhR
xfIlAPoCfb2reRTsVtu9qhrHlPz2UwCkF0z2C+wLodtroBc6IwD/WKlUWcJnrYCe
LHprscyABhnpC6rvcpeGF6+mLyQopg0=
=WXlm
-----END PGP SIGNATURE-----

--4sox4ca5522j7baz--
