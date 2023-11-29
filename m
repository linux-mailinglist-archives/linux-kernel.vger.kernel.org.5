Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1EF57FD53A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbjK2LOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbjK2LNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:13:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F97E273F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 03:10:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9AAAC433C7;
        Wed, 29 Nov 2023 11:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701256259;
        bh=TgKyGRCEeshKQvQjUN7AFNof2EniJcjgu0CRQnVYZ/w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O5zVZl8he0ZR2AllaDzQjsJvcC48I2DVX+YcZFM4U4lJRKdlzKQj01rXDkKkH+LiF
         lHPugHnBXU9Lz3GIPchKCA3swnNkGfRCeEF7Buegp/GVjESt8XFaaaMPn8uO0Np3fb
         QH4uoT6GVpVu5f8G7K3G8tLfTfynCUbzOB/07Y+ZEgy164kJsj+v5TkYpKomkznNh+
         o5wraA67njkrtd/dGw69TlIN3Ax9ir38Qz9LqnnMp4EoQtIsRef7Y62C7rehvUiPF4
         ju3lZ56sfX8cpuSMTaWug99glEWX2Km1aBuUBK4q0AvF6dx7s7cm86D7FR90U6fgLj
         W0tL9BmfmuMqg==
Date:   Wed, 29 Nov 2023 12:10:56 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
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
Message-ID: <kygezdrfz56zj6lmq6l5s5yyys2urgq3id7r5n4mb3afn5kc5q@eswnd6a2ihqc>
References: <20231128-kms-hdmi-connector-state-v4-0-c7602158306e@kernel.org>
 <20231128-kms-hdmi-connector-state-v4-5-c7602158306e@kernel.org>
 <87h6l66nth.fsf@intel.com>
 <v3hplco5fdedv6bnc6mwx2zhhw4xxdiekha26ykhc5cmy7ol77@2irk3w4hmabw>
 <ZWXv1Oi_sH0BRWao@intel.com>
 <2mnodqvu2oo674vspiy4gxhglu3it5cq47acx5itnbwevgc4cf@c7h2bvnx3m2n>
 <8734wo7vbx.fsf@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yiklpqzxs4i4jbph"
Content-Disposition: inline
In-Reply-To: <8734wo7vbx.fsf@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yiklpqzxs4i4jbph
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 11:38:42AM +0200, Jani Nikula wrote:
> On Wed, 29 Nov 2023, Maxime Ripard <mripard@kernel.org> wrote:
> > Hi Ville,
> >
> > On Tue, Nov 28, 2023 at 03:49:08PM +0200, Ville Syrj=E4l=E4 wrote:
> >> On Tue, Nov 28, 2023 at 02:29:40PM +0100, Maxime Ripard wrote:
> >> > On Tue, Nov 28, 2023 at 02:54:02PM +0200, Jani Nikula wrote:
> >> > > On Tue, 28 Nov 2023, Maxime Ripard <mripard@kernel.org> wrote:
> >> > > > All the drm_connector_init variants take at least a pointer to t=
he
> >> > > > device, connector and hooks implementation.
> >> > > >
> >> > > > However, none of them check their value before dereferencing tho=
se
> >> > > > pointers which can lead to a NULL-pointer dereference if the aut=
hor
> >> > > > isn't careful.
> >> > >=20
> >> > > Arguably oopsing on the spot is preferrable when this can't be cau=
sed by
> >> > > user input. It's always a mistake that should be caught early duri=
ng
> >> > > development.
> >> > >=20
> >> > > Not everyone checks the return value of drm_connector_init and fri=
ends,
> >> > > so those cases will lead to more mysterious bugs later. And probab=
ly
> >> > > oopses as well.
> >> >=20
> >> > So maybe we can do both then, with something like
> >> >=20
> >> > if (WARN_ON(!dev))
> >> >    return -EINVAL
> >> >=20
> >> > if (drm_WARN_ON(dev, !connector || !funcs))
> >> >    return -EINVAL;
> >> >=20
> >> > I'd still like to check for this, so we can have proper testing, and=
 we
> >> > already check for those pointers in some places (like funcs in
> >> > drm_connector_init), so if we don't cover everything we're inconsist=
ent.
> >>=20
> >> People will invariably cargo-cult this kind of stuff absolutely
> >> everywhere and then all your functions will have tons of dead
> >> code to check their arguments.
> >
> > And that's a bad thing because... ?
> >
> > Also, are you really saying that checking that your arguments make sense
> > is cargo-cult?
>=20
> It's a powerful thing to be able to assume a NULL argument is always a
> fatal programming error on the caller's side, and should oops and get
> caught immediately. It's an assertion.

Yeah, but we're not really doing that either. We have no explicit
assertion anywhere. We take a pointer in, and just hope that it will be
dereferenced later on and that the kernel will crash. The pointer to the
functions especially is only deferenced very later on.

And assertions might be powerful, but being able to notice errors and
debug them is too. A panic takes away basically any remote access to
debug. If you don't have a console, you're done.

> We're not talking about user input or anything like that here.
>=20
> If you start checking for things that can't happen, and return errors
> for them, you start gracefully handling things that don't have anything
> graceful about them.

But there's nothing graceful to do here: you just return from your probe
function that you couldn't probe and that's it. Just like you do when
you can't map your registers, or get your interrupt, or register into
any framework (including drm_dev_register that pretty much every driver
handles properly if it returns an error, without being graceful about
it).

> Having such checks in place trains people to think they *may* happen.

In most cases, kmalloc can't fail. We seem to have a very different
policy towards it.

> While it should fail fast and loud at the developer's first smoke test,
> and get fixed then and there.

Returning an error + a warning also qualifies for "fail fast and loud".
But keeps the system alive for someone to notice in any case.

Maxime

--yiklpqzxs4i4jbph
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZWccQAAKCRDj7w1vZxhR
xQWeAP9Ze0DmGeFKXN1BEGWfARxDJxHLh2vej5D8shdyccTj2AEAop8XqkWN1XF3
9wqNkaKiWk7HPoVA26RTjT1FaSG8DA8=
=jh/M
-----END PGP SIGNATURE-----

--yiklpqzxs4i4jbph--
