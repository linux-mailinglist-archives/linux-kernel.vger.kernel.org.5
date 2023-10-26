Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6AB7D820C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 13:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344848AbjJZLx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 07:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjJZLxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 07:53:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415291AC;
        Thu, 26 Oct 2023 04:53:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C18C433C7;
        Thu, 26 Oct 2023 11:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698321232;
        bh=je+DADXCoX+kCTmWmZq0ysK4G7kIaCSpTWt8Az7jl+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WthaQ/2T2IwZQyvxbjc8i6TLCZH6R0bxGgKm3P19AQmdfpQ6FpjwwvQFGWuJlmFZh
         tm7fXvL65CzQ5c33upmgr/CpnC+NcEfl7NPZYHB61Dli32HyEHjHTAEm7TVcOCAW6u
         WX/pzPDujgTi+qekKeBkEKa/w3xdlsSoHtKQqepic+zDucRuItVq9HOI76c1zy0Fnj
         tcQZxaUmgfx/DxBjhYrjFnhrEajLGZHbOZ1pNFf23+sav93OnPXQUIreqClHVVFSWC
         4P6xH7xxp6pLnMn6QqN5PTG1/GsT6u4FVHAjey/Jdqt/t8/DPsiwi5Y8eT5xbu0gKF
         PO2YZ9C1j9ydw==
Date:   Thu, 26 Oct 2023 13:53:48 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Keith Zhao <keith.zhao@starfivetech.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Shengyang Chen <shengyang.chen@starfivetech.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jagan Teki <jagan@edgeble.ai>,
        Rob Herring <robh+dt@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Changhuang Liang <changhuang.liang@starfivetech.com>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Shawn Guo <shawnguo@kernel.org>, christian.koenig@amd.com
Subject: Re: [PATCH v2 6/6] drm/vs: Add hdmi driver
Message-ID: <344veqjvvwlo7vls2kdlgjggf77of2ijxwc2hmk7tarm75ugcs@bmozk23uqxqr>
References: <20231025103957.3776-1-keith.zhao@starfivetech.com>
 <20231025103957.3776-7-keith.zhao@starfivetech.com>
 <70805ff2-56a8-45e1-a31c-ffb0e84749e5@linaro.org>
 <3twc4zoohon7uujypgjtlnryfmebx4osvpykagnwr5nemmqz2w@w4vw55uswebh>
 <CAA8EJppxQ7J8DEDFsWzPL8bDpNW-KY0nhUA++zDBRpMCpP-bkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6ydghz6j3eeoumtu"
Content-Disposition: inline
In-Reply-To: <CAA8EJppxQ7J8DEDFsWzPL8bDpNW-KY0nhUA++zDBRpMCpP-bkA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6ydghz6j3eeoumtu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 11:57:22AM +0300, Dmitry Baryshkov wrote:
> On Thu, 26 Oct 2023 at 11:07, Maxime Ripard <mripard@kernel.org> wrote:
> >
> > On Thu, Oct 26, 2023 at 01:23:53AM +0300, Dmitry Baryshkov wrote:
> > > > +static int starfive_hdmi_register(struct drm_device *drm, struct s=
tarfive_hdmi *hdmi)
> > > > +{
> > > > +   struct drm_encoder *encoder =3D &hdmi->encoder;
> > > > +   struct device *dev =3D hdmi->dev;
> > > > +
> > > > +   encoder->possible_crtcs =3D drm_of_find_possible_crtcs(drm, dev=
->of_node);
> > > > +
> > > > +   /*
> > > > +    * If we failed to find the CRTC(s) which this encoder is
> > > > +    * supposed to be connected to, it's because the CRTC has
> > > > +    * not been registered yet.  Defer probing, and hope that
> > > > +    * the required CRTC is added later.
> > > > +    */
> > > > +   if (encoder->possible_crtcs =3D=3D 0)
> > > > +           return -EPROBE_DEFER;
> > > > +
> > > > +   drm_encoder_helper_add(encoder, &starfive_hdmi_encoder_helper_f=
uncs);
> > > > +
> > > > +   hdmi->connector.polled =3D DRM_CONNECTOR_POLL_HPD;
> > > > +
> > > > +   drm_connector_helper_add(&hdmi->connector,
> > > > +                            &starfive_hdmi_connector_helper_funcs);
> > > > +   drmm_connector_init(drm, &hdmi->connector,
> > > > +                       &starfive_hdmi_connector_funcs,
> > > > +                       DRM_MODE_CONNECTOR_HDMIA,
> > >
> > > On an embedded device one can not be so sure. There can be MHL or HDMI
> > > Alternative Mode. Usually we use drm_bridge here and drm_bridge_conne=
ctor.
> >
> > On an HDMI driver, it's far from being a requirement, especially given
> > the limitations bridges have.
>=20
> It's a blessing that things like MHL / HDMI-in-USB-C / HDMI-to-MyDP
> are not widely used in the wild and are mostly non-existing except
> several phones that preate wide DP usage.

And those can be supported without relying on bridges.

> Using drm_connector directly prevents one from handling possible
> modifications on the board level. For example, with the DRM connector
> in place, handling a separate HPD GPIO will result in code duplication
> from the hdmi-connector driver. Handling any other variations in the
> board design (which are pretty common in the embedded world) will also
> require changing the driver itself. drm_bridge / drm_bridge_connector
> save us from those issues.

And we have other solutions there too. Like, EDIDs are pretty much in
the same spot with a lot of device variations, but it also works without
a common driver. I'd really wish we were having less bridges and more
helpers, but here we are.

> BTW: what are the limitations of the drm_bridge wrt. HDMI output? I'm
> asking because we heavily depend on the bridge infrastructure for HDMI
> output. Maybe we are missing something there, which went unnoticed to
> me and my colleagues.

A bridge cannot extend the connector state or use properties, for
example. It works for basic stuff but falls apart as soon as you're
trying to do something slightly advanced.

Maxime

--6ydghz6j3eeoumtu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZTpTTAAKCRDj7w1vZxhR
xbLFAP4unIAE0v+sEMAKIEHtzqjUKfaDRvFMhet0vamy7Zof+QD/dgmnLOex7TJ1
wA5XuQ2uivS+Cv7xrc3HS7yTI5xVjAE=
=5wik
-----END PGP SIGNATURE-----

--6ydghz6j3eeoumtu--
