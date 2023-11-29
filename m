Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6522C7FD6CC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 13:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbjK2Mcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 07:32:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbjK2Mco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 07:32:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050538F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 04:32:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF37C433C9;
        Wed, 29 Nov 2023 12:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701261170;
        bh=3rg6InLFJYoj0t56EbSzonGCmEtUIs3+UyoC8G9109k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vJlY2rBoX/wUunC8QosbeZWCaearH7/13ya1mqQXLqYSRWaNk6vTPX37FlaTuOvQw
         pJmuZ46UWl8lXat1EEuUg7gYCOJSdxSTEvbZyk8s/mD0FiuGmP0Bor0304jfbMox+M
         BbU7LXd/o7peBNq++BKgkUhipr1dnlmBktw89Ba8mbX2AJqgKTh1udfDED5bjSVao4
         /qD84HoSYXilbTniRywx3EEd2Tz21kPJqDwKgQu9pF47KtIGyGkoV4m+XL9SNfk9a5
         RVn+4Sa+xqJM4IPKiFenquD5EbVP1r9VAMex54H7sCexwXz9sTTmGBxa5/cL1AwEPF
         Q2tzV0QoCberA==
Date:   Wed, 29 Nov 2023 13:32:48 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>, daniel@ffwll.ch
Cc:     Liu Ying <victor.liu@nxp.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-next@vger.kernel.org,
        sfr@canb.auug.org.au, gregkh@linuxfoundation.org,
        rafael@kernel.org, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
        tzimmermann@suse.de, airlied@gmail.com,
        angelogioacchino.delregno@collabora.com, ulf.hansson@linaro.org
Subject: Re: [PATCH v2 0/2] drm/bridge: panel: Check device dependency before
 managing device link
Message-ID: <d33ovl3ox2u74jbik2bcraeqiqplqoc57p4quapdyydqlyzrf5@vlhszortxfio>
References: <20231127051414.3783108-1-victor.liu@nxp.com>
 <CACRpkdZAtxh5muhbPKvmUQGtQogs3UhGxNZqnSGWoWQNUL7=9g@mail.gmail.com>
 <k65hxlckssjd46nsrlly6vjrr5nnkrakouzw5pmxgbf6ui3mdl@5ny7j7blkwyj>
 <CACRpkdbKwycpjuhMfnriqMUcbmwCTb3vJzgzCF7+ARax54q7WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yrzhzqk3x47g4p6g"
Content-Disposition: inline
In-Reply-To: <CACRpkdbKwycpjuhMfnriqMUcbmwCTb3vJzgzCF7+ARax54q7WQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yrzhzqk3x47g4p6g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Mon, Nov 27, 2023 at 11:13:31PM +0100, Linus Walleij wrote:
> On Mon, Nov 27, 2023 at 5:29=E2=80=AFPM Maxime Ripard <mripard@kernel.org=
> wrote:
> > On Mon, Nov 27, 2023 at 05:03:53PM +0100, Linus Walleij wrote:
>=20
> > > > Liu Ying (2):
> > > >   driver core: Export device_is_dependent() to modules
> > > >   drm/bridge: panel: Check device dependency before managing device=
 link
> > >
> > > I just applied patch 1 directly to the drm-misc-fixes so we don't hav=
e to
> > > revert and then re-apply patches, because that is a bigger evil. (We =
can't
> > > rebase these branches...)
> >
> > Erm, you did wait for GKH or Rafael's ACK to do that, right?
>=20
> No.
>=20
> It is a bigger evil to leave the tree broken than to enforce formal proce=
ss,
> and it is pretty self-evident. If any of them get annoyed about it we can
> revert the patch, or both.

Yeah, I definitely understand why you did it, but I don't think it's
something we would encourage in drm-misc.

We've discussed it with Sima yesterday, and I think we would even need
the extra check in dim to make sure that a committer shouldn't do that
without dim complaining.

Sima played a bit with it, and it should be doable to get something
fairly reliable if you use get_maintainers.pl to retrieve the git tree
(through scripts/get_maintainer.pl --no-email --no-l --scm) and figuring
out if only drm.git, drm-intel.git or drm-misc.git is involved.

If it isn't, then we should check that there's the ack of one of the
maintainers.

Could you write a patch to do so?

Thanks!
Maxime

--yrzhzqk3x47g4p6g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZWcvbwAKCRDj7w1vZxhR
xXfXAQD+NPkwoY0m8+ozRhmrZbtB+qRlugYpDd5BPUriECj8VgEAk7LOfR+2wGYS
hf8XQcHi0BQQjrr2sfXIgq5DKevijgI=
=CWHT
-----END PGP SIGNATURE-----

--yrzhzqk3x47g4p6g--
