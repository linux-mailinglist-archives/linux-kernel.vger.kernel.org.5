Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2107678FCCF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 14:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349312AbjIAMAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 08:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345197AbjIAMAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 08:00:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A7D10D2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 05:00:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDA4762CFA
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 12:00:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0443EC433C8;
        Fri,  1 Sep 2023 12:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693569636;
        bh=lGxyMOQV4gjjzMVNKS8VEdXVaMYhitaRfjfztoeX44c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vr73YzHZ3TMILaS9tBiYclK/jMziRZh4FpshkG6coR/2I3qT64dYus+o75FOAyDiw
         Nw17+4QFqxW0xKJf1LD655pBmBHxI1nXY9GsGCP0UyHiECx/dtYTnKnNOx9C+t9l8q
         ofFAMqK0iLLbNqCNENapdWEueRWuvvU9MEdLOQ8NLk33BIvhZ5FZT3IJulurDWLz+E
         DU3V195JkmkvO89w/7Wc0zQV8qCHZORHPt2jbUS9olmKTXmIGIFNURveWEisZ0oV4J
         BWmCHGetvNZVdPlI62y5BKFcly31JTiGP1qM344+zmrHr6J0LbkfF7wjy668cBsjGw
         kpzZiweAsIc1A==
Date:   Fri, 1 Sep 2023 14:00:33 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [RFC PATCH] drm/ssd130x: Allocate buffer in the CRTC's
 .atomic_check() callback
Message-ID: <4zfgmvfstyjfo5slggfmfuvnirrhrq773el52gkav2r6jxliub@7qjbyy7rkj3g>
References: <20230830062546.720679-1-javierm@redhat.com>
 <zitno3p7tbnld5auedkx5g4wey2csng4ncmtdhzinbuhblunyk@chnwsnsgq36v>
 <CAMuHMdWv_QSatDgihr8=2SXHhvp=icNxumZcZOPwT9Q_QiogNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="byuybil6cm4awtis"
Content-Disposition: inline
In-Reply-To: <CAMuHMdWv_QSatDgihr8=2SXHhvp=icNxumZcZOPwT9Q_QiogNQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--byuybil6cm4awtis
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 01, 2023 at 10:36:17AM +0200, Geert Uytterhoeven wrote:
> Hi Maxime,
>=20
> On Fri, Sep 1, 2023 at 10:22=E2=80=AFAM Maxime Ripard <mripard@kernel.org=
> wrote:
> > On Wed, Aug 30, 2023 at 08:25:08AM +0200, Javier Martinez Canillas wrot=
e:
> > > The commit 45b58669e532 ("drm/ssd130x: Allocate buffer in the plane's
> > > .atomic_check() callback") moved the allocation of the intermediate a=
nd
> > > HW buffers from the encoder's .atomic_enable callback to primary plan=
e's
> > > .atomic_check callback.
> > >
> > > This was suggested by Maxime Ripard because drivers aren't allowed to=
 fail
> > > after drm_atomic_helper_swap_state() has been called, and the encoder=
's
> > > .atomic_enable happens after the new atomic state has been swapped.
> > >
> > > But that change caused a performance regression in very slow platform=
s,
> > > since now the allocation happens for every plane's atomic state commi=
t.
> > > For example, Geert Uytterhoeven reports that is the case on a VexRiscV
> > > softcore (RISC-V CPU implementation on an FPGA).
> >
> > I'd like to have numbers on that. It's a bit surprising to me that,
> > given how many objects we already allocate during a commit, two small
> > additional allocations affect performances so dramatically, even on a
> > slow platform.
>=20
> To be fair, I didn't benchmark that.  Perhaps it's just too slow due to
> all these other allocations (and whatever else happens).
>=20
> I just find it extremely silly to allocate a buffer over and over again,
> while we know that buffer is needed for each and every display update.

Maybe it's silly, but I guess it depends on what you want to optimize
for. You won't know the size of that buffer before you're in
atomic_check. So it's a different trade-off than you would like, but I
wouldn't call it extremely silly.

Maxime

--byuybil6cm4awtis
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZPHSYQAKCRDj7w1vZxhR
xclHAQCxHO1n0wAUnVmlCnD4kzs+2tcRmYcbKobEUyGJbbRvHgD/ch90H2sQ7yZC
M4BSAIwvg4c7OaOi0YX3nDHn7VWJrgM=
=aV+3
-----END PGP SIGNATURE-----

--byuybil6cm4awtis--
