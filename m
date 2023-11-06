Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892C27E1BAA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 09:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjKFIGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 03:06:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjKFIGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 03:06:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A417E1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 00:06:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A2DC433C7;
        Mon,  6 Nov 2023 08:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699258003;
        bh=Whd5oMeK1I9z/RUheGQ8JiStxsgf9qTYIkZSz85OYdI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PNdxyDS3jworj1+C0NH2REiaGfzncqug8QtE6qfBuuUIVF8DSAPW/gJmDozHtomCa
         gMo9aGUD6TEcDQp610EUrhWJZnMx/QVRPkCRoy9JLgmkuNSpItEaOFwdrusQQn8Y4m
         SC9zIcjtG2MD5oh+KFoH/2SvdULeQHPtZ/DIPtp9J28OPmZ3wqLnNUUsg+KkvmEaLa
         ljyebD1W8HLi4uOB51GNcTAqxdiV1Du+uQ7FQeeJsagrF+t/saZwBfE4siAaP/IV9H
         10ZgVLZRE5+dNlDjzlm4yMh1OW0GlpGkbQp5xIqbMQxZfI9j/A3vl/Mwl4vCU2h4hL
         PURoXRQv7gq1g==
Date:   Mon, 6 Nov 2023 09:06:41 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 3/3] drm/panel-edp: Choose correct preferred mode
Message-ID: <ze5xz52jt4helttcmntzmr6fr4ohu7wtslywalbxc4w7w6uvly@nwweqyyl4wf2>
References: <20231101212604.1636517-1-hsinyi@chromium.org>
 <20231101212604.1636517-4-hsinyi@chromium.org>
 <CAA8EJpoPMkQRhCD-9SPSheiio1dH8V6BUv89MZKfZdrBzsBW-w@mail.gmail.com>
 <CAD=FV=WHzCdiYumsxUm_am+ALqq9SOOrjf=JYHqJuiKFB+Dnsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p2nzhnzkeentgd7g"
Content-Disposition: inline
In-Reply-To: <CAD=FV=WHzCdiYumsxUm_am+ALqq9SOOrjf=JYHqJuiKFB+Dnsw@mail.gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p2nzhnzkeentgd7g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 02, 2023 at 07:33:48AM -0700, Doug Anderson wrote:
> Hi,
>=20
> On Wed, Nov 1, 2023 at 11:31=E2=80=AFPM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Wed, 1 Nov 2023 at 23:26, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> > >
> > > If a non generic edp-panel is under aux-bus, the mode read from edid =
would
> > > still be selected as preferred and results in multiple preferred mode=
s,
> > > which is ambiguous.
> > >
> > > If a hard-coded mode is present, unset the preferred bit of the modes=
 read
> > > from edid.
> >
> > Can we skip the EDID completely if the hardcoded override is present?
>=20
> Yeah, I wondered about that too. The blending of the hardcoded with
> the EDID predates my involvement with the driver. You can see even as
> of commit 280921de7241 ("drm/panel: Add simple panel support") that
> the driver would start with the EDID modes (if it had them) and then
> go onto add the hardcoded modes. At least for eDP panels, though,
> nobody (or almost nobody?) actually provided panel-simple a DDC bus at
> the same time it was given a hardcoded panel.
>=20
> I guess I could go either way, but I have a slight bias to adding the
> extra modes and just making it clear to userspace that none of them
> are "preferred". That seems like it would give userspace the most
> flexibility

I disagree. "Flexibility" here just means "the way to shoot itself in
the foot without knowing it's aiming at its foot".

If a mode is broken, we shouldn't expose it, just like we don't for all
modes that require a maximum frequency higher than what the controller
can provide on HDMI for example.

> and also is closer to what we've historically done (though,
> historically, we just allowed there to be more than one "preferred"
> mode).

I have no idea what history you're referring to here

> One thing we definitely want to do, though, is to still expose the
> EDID to userspace even if we're using a hardcoded mode. I believe
> that, at least on ChromeOS, there are some tools that look at the EDID
> directly for some reason or another.

If the EDID is known to be broken and unreliable, what's the point?

Maxime

--p2nzhnzkeentgd7g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZUiekQAKCRDj7w1vZxhR
xR1VAQCofZ+KM2NOqwhY9yNFvg4GhfbYs4dwJhQgF3RshcktIgD9Ehj8YqDSWbBH
P1yONCZAX6hgfJfa9PsZWOv8UxAyPg8=
=L+kT
-----END PGP SIGNATURE-----

--p2nzhnzkeentgd7g--
