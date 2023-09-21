Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053A37AA58D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 01:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjIUXU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 19:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjIUXUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 19:20:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7027DA9F2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:07:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D01C116D5;
        Thu, 21 Sep 2023 08:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695286301;
        bh=2+pljEhHPpECFX9HUqc8WA+cUF3GqSlRSTmRXo3wy7s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ku9ihcIro8BAf5sXD67a08F3/JbSI7c2WN3oWjCrlKwlyQrIrN7X+0mQowomnJK77
         y+ORdVvSdyiF/rZdGqptp5h3GctvB2DbzyrxUKH6e7ViW/k5UfWmic95Sbpfnl7ti7
         h+HTvRoE7eqFVT/RNtQZyaRdDbp4od+13Oh2sn2cVRMKkkxwqaosK7BIskQr6+LXf5
         OI+AdhhQzO6TqxRqMD6P1WPU3+YkoSGiwUByCp1ASV+rpaxtccu5hqdMQnqongCEf/
         Kh1x0YQMZkbeWAM4u06UwiknxqEvlcF5OipzQZeI+y93rNmih4zPl0NfO1d1SaJl+8
         kCpaAQk+RC3MA==
Date:   Thu, 21 Sep 2023 10:51:38 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/ssd130x: Drop _helper prefix from struct
 drm_*_helper_funcs callbacks
Message-ID: <yz2wo76us5bsshdsyiybanpsxa2izqwuj6ts3b76lnfo74ypgz@kx5vqwi6cjap>
References: <20230914195138.1518065-1-javierm@redhat.com>
 <f5620d32-2705-498b-a65c-7dc663340a6d@suse.de>
 <87wmwo3q50.fsf@minerva.mail-host-address-is-not-set>
 <552hpgr7qzbjxuyei3n5m7rsn7ekwbdgzv25oe5vy6qb35gf23@q4etussk5jwl>
 <CAMuHMdUGVgj6V+N865QZaAusqD7O2f1askE544Z4MF0h4zBERg@mail.gmail.com>
 <2p53aei56tlr7k6w5oawlwpmv2k7agpbb6wfwpxcg3rqyueyrx@2as7tijrgnh4>
 <CAMuHMdV9Q=F6D=FgBYazjxGL8HY1cRLJUxdfdvr8=6fwgn+EHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xausph7vkn4i5qzv"
Content-Disposition: inline
In-Reply-To: <CAMuHMdV9Q=F6D=FgBYazjxGL8HY1cRLJUxdfdvr8=6fwgn+EHQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xausph7vkn4i5qzv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2023 at 10:46:05AM +0200, Geert Uytterhoeven wrote:
> On Thu, Sep 21, 2023 at 10:12=E2=80=AFAM Maxime Ripard <mripard@kernel.or=
g> wrote:
> > On Thu, Sep 21, 2023 at 09:57:22AM +0200, Geert Uytterhoeven wrote:
> > > On Thu, Sep 21, 2023 at 9:44=E2=80=AFAM Maxime Ripard <mripard@kernel=
=2Eorg> wrote:
> > > > On Mon, Sep 18, 2023 at 09:19:07AM +0200, Javier Martinez Canillas =
wrote:
> > > > > Thomas Zimmermann <tzimmermann@suse.de> writes:
> > > > > > Am 14.09.23 um 21:51 schrieb Javier Martinez Canillas:
> > > > > >> The driver uses a naming convention where functions for struct=
 drm_*_funcs
> > > > > >> callbacks are named ssd130x_$object_$operation, while the call=
backs for
> > > > > >> struct drm_*_helper_funcs are named ssd130x_$object_helper_$op=
eration.
> > > > > >>
> > > > > >> The idea is that this helper_ prefix in the function names den=
ote that are
> > > > > >> for struct drm_*_helper_funcs callbacks. This convention was c=
opied from
> > > > > >> other drivers, when ssd130x was written but Maxime pointed out=
 that is the
> > > > > >> exception rather than the norm.
> > > > > >
> > > > > > I guess you found this in my code. I want to point out that I u=
se the
> > > > > > _helper infix to signal that these are callback for
> > > > > > drm_primary_plane_helper_funcs and *not* drm_primary_plane_func=
s. The
> > > > > > naming is intentional.
> > > > >
> > > > > Yes, that's what tried to say in the commit message and indeed I =
got the
> > > > > convention from drivers in drivers/gpu/drm/tiny. In fact I believ=
e these
> > > > > function names are since first iteration of the driver, when was =
meant to
> > > > > be a tiny driver.
> > > > >
> > > > > According to Maxime it's the exception rather than the rule and s=
uggested
> > > > > to change it, I don't really have a strong opinion on either nami=
ng TBH.
> > > >
> > > > Maybe that's just me, but the helper in the name indeed throws me o=
ff. In my
> > > > mind, it's supposed to be used only for helpers, not functions impl=
ementing the
> > > > helpers hooks.
> > >
> > > With several callbacks using the same (field) name, it is very helpful
> > > to name the actual implementation by combining the struct type name
> > > and the field name.
> >
> > I can't think of any (at least for a given object). Which one do you ha=
ve in
> > mind?
>=20
> E.g. atomic_check():
>=20
>     drm_crtc_helper_funcs.atomic_check()
>     drm_encoder_helper_funcs.atomic_check()
>     drm_connector_helper_funcs.atomic_check()
>     drm_plane_helper_funcs.atomic_check()

Right, but that's between objects, not between drm_$OBJECT_funcs and
drm_$OBJECT_helper_funcs. So conflicts for a single given driver is unlikel=
y,
and can be solved by using, say, $DRIVER_crtc_atomic_check and
$DRIVER_plane_atomic_check.

> Interestingly, drm_mode_config_helper_funcs does not have an
> atomic_check() callback, but drm_mode_config_funcs has.
>=20
> > > Anything else confuses the casual reader. Perhaps the real question i=
s whether
> > > the structures should have "helper" in their name in the first place?
> >
> > Those structures are meant for functions used by the helpers, they are =
not
> > helper functions.
>=20
> That might be how they started, but to me it looks like all these helpers
> are no longer helpers, but part of the core...

They are part of the core, but very much optional still. i915 doesn't use a=
 lot
of helpers, vc4 (used to?) rolls its own atomic_commit implementation, etc.=
 It's
really not uncommon.

Maxime

--xausph7vkn4i5qzv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZQwEGgAKCRDj7w1vZxhR
xYz7AQCBEp34X1kCaihJf5Lq28yeEGdWAmNA3zyOuq9raBubOQEA04SOQI8XPbCN
6cD8oulAR+yTmqwrZazae7cFizHObQw=
=kv2D
-----END PGP SIGNATURE-----

--xausph7vkn4i5qzv--
