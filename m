Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067E77FD1D0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbjK2JLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:11:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjK2JLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:11:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73CC85
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:11:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0045CC433C7;
        Wed, 29 Nov 2023 09:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701249089;
        bh=cAQDm1OHi6AwpFtu2oyoP4lirQiWSiJNR9l7GsKXbG0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nwbfrj7Pk2t2Z7wByu0jHudFVV4zAocI0bejf4VNuJ94Gv2F5DMNrfE6wB3QNldRG
         z7A40mmCnCiugGuIop83o5nbsu/un4/gm+L4OOyqOZJplUGWVy/fy/5V0Ah0fTKds9
         uirW/8qj7vfQGn5bztbUXZUFHO0buy0PYmdbSucg5HbE2qjcBV261rqO1/NFYhSkkL
         e0on0p9J42TspyvoUFNBGMB/Ol6v34YBgC3waQmjoDLU7fUO4D4w9YGZ09qh7H51YI
         z5suLwGP2CTJLldp9JIdJfUJghx2Nxbf1Dp07okJGX4uvEwzQQOFvu+Xv1trZEo4hX
         sKILXaByCcPog==
Date:   Wed, 29 Nov 2023 10:11:26 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emma Anholt <emma@anholt.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>,
        Sandy Huang <hjc@rock-chips.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-doc@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>,
        linux-rockchip@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 05/45] drm/connector: Check drm_connector_init
 pointers arguments
Message-ID: <2mnodqvu2oo674vspiy4gxhglu3it5cq47acx5itnbwevgc4cf@c7h2bvnx3m2n>
References: <20231128-kms-hdmi-connector-state-v4-0-c7602158306e@kernel.org>
 <20231128-kms-hdmi-connector-state-v4-5-c7602158306e@kernel.org>
 <87h6l66nth.fsf@intel.com>
 <v3hplco5fdedv6bnc6mwx2zhhw4xxdiekha26ykhc5cmy7ol77@2irk3w4hmabw>
 <ZWXv1Oi_sH0BRWao@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5yeernlclvkai5mu"
Content-Disposition: inline
In-Reply-To: <ZWXv1Oi_sH0BRWao@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5yeernlclvkai5mu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ville,

On Tue, Nov 28, 2023 at 03:49:08PM +0200, Ville Syrj=E4l=E4 wrote:
> On Tue, Nov 28, 2023 at 02:29:40PM +0100, Maxime Ripard wrote:
> > On Tue, Nov 28, 2023 at 02:54:02PM +0200, Jani Nikula wrote:
> > > On Tue, 28 Nov 2023, Maxime Ripard <mripard@kernel.org> wrote:
> > > > All the drm_connector_init variants take at least a pointer to the
> > > > device, connector and hooks implementation.
> > > >
> > > > However, none of them check their value before dereferencing those
> > > > pointers which can lead to a NULL-pointer dereference if the author
> > > > isn't careful.
> > >=20
> > > Arguably oopsing on the spot is preferrable when this can't be caused=
 by
> > > user input. It's always a mistake that should be caught early during
> > > development.
> > >=20
> > > Not everyone checks the return value of drm_connector_init and friend=
s,
> > > so those cases will lead to more mysterious bugs later. And probably
> > > oopses as well.
> >=20
> > So maybe we can do both then, with something like
> >=20
> > if (WARN_ON(!dev))
> >    return -EINVAL
> >=20
> > if (drm_WARN_ON(dev, !connector || !funcs))
> >    return -EINVAL;
> >=20
> > I'd still like to check for this, so we can have proper testing, and we
> > already check for those pointers in some places (like funcs in
> > drm_connector_init), so if we don't cover everything we're inconsistent.
>=20
> People will invariably cargo-cult this kind of stuff absolutely
> everywhere and then all your functions will have tons of dead
> code to check their arguments.

And that's a bad thing because... ?

Also, are you really saying that checking that your arguments make sense
is cargo-cult?

We're already doing it in some parts of KMS, so we have to be
consistent, and the answer to "most drivers don't check the error"
cannot be "let's just give on error checking then".

> I'd prefer not to go there usually.
>=20
> Should we perhaps start to use the (arguably hideous)
>  - void f(struct foo *bar)
>  + void f(struct foo bar[static 1])
> syntax to tell the compiler we don't accept NULL pointers?
>=20
> Hmm. Apparently that has the same problem as using any
> other kind of array syntax in the prototype. That is,
> the compiler demands to know the definition of 'struct foo'
> even though we're passing in effectively a pointer. Sigh.

Honestly, I don't care as long as it's something we can unit-test to
make sure we make it consistent. We can't unit test a complete kernel
crash.

--5yeernlclvkai5mu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZWcAPgAKCRDj7w1vZxhR
xdiAAP9/Y3QZYC3QOV7WWulwxqeWACuHSjmA+KHPl8qOdVnh+AD9HTqYM7+ypKLa
CFZu3zXCIPjDPQmXptfe2oXEaBjpwQA=
=KUBI
-----END PGP SIGNATURE-----

--5yeernlclvkai5mu--
