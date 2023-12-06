Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B3F806938
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 09:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377048AbjLFIOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 03:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjLFIOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 03:14:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318C0D3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 00:14:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A2E6C433C8;
        Wed,  6 Dec 2023 08:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701850488;
        bh=ECvUPXaxDahnjrvxTOPA4LHdQIbds1Vq8tr+lgMn6iU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mJPT280Bp2c35reI7j/CneCSeRdqkP/kmmsw+yXKVPxyUpKHmpffnxPQM7dcZIZXz
         Zb2w/vSKNoP5KE9LGE/c4UnwzOHVJXmIKVyHbSWBsES0rlCKe5NFtArhKR5TWrjevv
         Yx3c64IOO/UWWIfJND6bhN1W/w4Gc/97gcXyVbRAwJc5Ps9uKtRPivTgAwpumBYTsb
         ZyEBEt2AfnJj1JypKonSFVjNYV6z+ZIOoriWuCxfkCd1WgJ+5YkxdLkQixap7jf1Hy
         pIN9FdoDM+AId0WjfyNvoXezCN0xz9Imk4b4BRwYdJIB4Z8sqFucSxiw8/PQiNY9dX
         zu3locPC5EL8g==
Date:   Wed, 6 Dec 2023 09:14:45 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org,
        airlied@gmail.com, bskeggs@redhat.com, daniel@ffwll.ch,
        kherbst@redhat.com, linux-kernel@vger.kernel.org,
        nouveau@lists.freedesktop.org
Subject: Re: [RFT PATCH v2 04/12] drm/nouveau: Call
 drm_atomic_helper_shutdown() or equiv at shutdown time
Message-ID: <6va36dxrtvniondowm73ehuxp7pbo23bssuob7trmbq22rq4lg@ug3i7abmri3a>
References: <20230921192749.1542462-1-dianders@chromium.org>
 <20230921122641.RFT.v2.4.Ie7588ec6e0f93e8bc700e76b265ad1a7ad6b15ad@changeid>
 <2f7fbd1b606b4d08b8c8c6eefff5898c8faa697c.camel@redhat.com>
 <CAD=FV=XkeicQ3Gq4yaFtXsF7yM_7pXbpNKB56DbOwBmsEsrF_g@mail.gmail.com>
 <CAD=FV=XDhkstFX3e2qPGeYGkFWefRMH24BjNgRujBX5PQyE6MA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="stsdakm3fnwfmzzj"
Content-Disposition: inline
In-Reply-To: <CAD=FV=XDhkstFX3e2qPGeYGkFWefRMH24BjNgRujBX5PQyE6MA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--stsdakm3fnwfmzzj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2023 at 12:45:07PM -0800, Doug Anderson wrote:
> Hi,
>=20
> On Fri, Nov 17, 2023 at 3:00=E2=80=AFPM Doug Anderson <dianders@chromium.=
org> wrote:
> >
> > Hi,
> >
> > On Fri, Sep 22, 2023 at 2:06=E2=80=AFPM Lyude Paul <lyude@redhat.com> w=
rote:
> > >
> > > actually very glad to see this because I think I've seen one bug in t=
he wild
> > > as a result of things not getting shut down :)
> > >
> > > Reviewed-by: Lyude Paul <lyude@redhat.com>
> > > Tested-by: Lyude Paul <lyude@redhat.com>
> >
> > Any idea of where / how this patch should land. Would you expect me to
> > land it through drm-misc, or would you expect it to go through someone
> > else's tree?
>=20
> Still hoping to find a way to land this patch, since it's been
> reviewed and tested. Would anyone object if I landed it via drm-misc?

Nouveau isn't maintained in drm-misc, so I would expect it to go through
the usual nouveau tree. Lyude, Karol, Danilo?

Maxime

--stsdakm3fnwfmzzj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZXAtdQAKCRDj7w1vZxhR
xRMQAQCWR+dGU9QsUAh5lhsGtHlIvbeZ8HKnfwtiDyQDjYRfmAD/cBVkFywpfJZB
pjlMXQGCtMREy8SFYZ6QzfGK508D/A8=
=jJKl
-----END PGP SIGNATURE-----

--stsdakm3fnwfmzzj--
