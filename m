Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A334C7E5A1C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 16:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbjKHPet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 10:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbjKHPep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 10:34:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710701FE3
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 07:34:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94ACDC433C7;
        Wed,  8 Nov 2023 15:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699457682;
        bh=J9xVmtM/HahuIILcD7pLHb56PQSjwAI5+CwSkKmNpGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iyVfJBF7fXKlOtm1WvcN5O8kT5/+9NYO/ne6r7s83tLaGrK734b0RiQglJLgQpQX9
         b0ah39xOIlMlJizyF5PR0ks7h8GFZrMJm9AsLb+bTEBqcnPUB5FyYikeV3wxD+zcwy
         rSNkm7F7Z9+V9JSNcYAHa2eUisu9KxQU0UKISGz8NPywhUJBfBQz+rU9gFVotd3BKo
         ViGT8fKsQcF6+fH/91OXxX9OVdjeI8OfVP2902KWrihzd/D2jr15+2O8XAnY1RNyeX
         QGVohtf5olxrYqhmwt7SC8pDiAwahzN8+fNWXhNF5/HS9+lhx/UkyGGlDpcDRUJHfy
         bGuCiIP3F+Lxg==
Date:   Wed, 8 Nov 2023 16:34:39 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Marek Vasut <marex@denx.de>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org
Subject: Re: [RFC PATCH 03/10] drm/mipi-dsi: add API for manual control over
 the DSI link power state
Message-ID: <kuzbg4a52onojyfh2cc7h7c4iruzfbbbo2lm2jve72rnrpfk6f@2hars5pwujg3>
References: <7e4ak4e77fp5dat2aopyq3g4wnqu3tt7di7ytdr3dvgjviyhrd@vqiqx6iso6vg>
 <CAA8EJpp48AdJmx_U=bEJZUWZgOiT1Ctz6Lpe9QwjLXkMQvsw5w@mail.gmail.com>
 <uj6rtlionmacnwlqxy6ejt5iaczgbbe5z54ipte5ffbixcx3p4@pps7fcr3uqhf>
 <1696f131-83fb-4d0c-b4d7-0bdb61e4ae65@linaro.org>
 <mxtb6vymowutj7whbrygwlcupbdnfqxjralc3nwwapsbvrcmbm@sewxtdslfoen>
 <CAA8EJpozZkEswnioKjRCqBg4fcjVHFwGivoFNTNHVwyocKprQw@mail.gmail.com>
 <2z3yvvtd6ttsd7qw43sl5svtfijxevdr6omxxmws64k6l5qv55@5nnh2b32h2ep>
 <2023110704-playback-grit-7a27@gregkh>
 <hkzoi4sazufi5xdgr6hacuzk72cnbtmm6dwm2bzfgwh5yij6wj@2g4eb6ea4dgd>
 <2023110704-deem-jigsaw-0bbf@gregkh>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kxv6ogo77qrteawk"
Content-Disposition: inline
In-Reply-To: <2023110704-deem-jigsaw-0bbf@gregkh>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kxv6ogo77qrteawk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for your answer

On Tue, Nov 07, 2023 at 04:26:34PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Nov 07, 2023 at 01:18:14PM +0100, Maxime Ripard wrote:
> > On Tue, Nov 07, 2023 at 12:22:21PM +0100, Greg Kroah-Hartman wrote:
> > > On Tue, Nov 07, 2023 at 11:57:49AM +0100, Maxime Ripard wrote:
> > > > +GKH
> > >=20
> > > Why?  I don't see a question for me here, sorry.
> >=20
> > I guess the question is: we have a bus with various power states
> > (powered off, low power, high speed)
>=20
> Great, have fun!  And is this per-device or per-bus-instance?

Per bus instance

> > low power is typically used to send commands to a device, high speed to
> > transmit pixels, but still allows to send commands.
> >=20
> > Depending on the devices, there's different requirements about the state
> > devices expect the bus to be in to send commands. Some will need to send
> > all the commands in the low power state, some don't care, etc. See
> > the mail I was replying too for more details.
> >=20
> > We've tried so far to model that in KMS itself, so the framework the
> > drivers would register too, but we're kind of reaching the limits of
> > what we can do there. It also feels to me that "the driver can't access
> > its device" is more of a problem for the bus to solve rather than the
> > framework.
>=20
> This is up to the specific bus to resolve, there's nothing special
> needed in the driver core for it, right?

Yeah, we weren't really looking to handle this into the driver core, but
rather if there was a set of guidelines or feedback on implementing
those kind of features for a bus.

> > Do you agree? Are you aware of any other bus in Linux with similar
> > requirements we could look at? Or any suggestion on how to solve it?
>=20
> There might be others, yes, look at how the dynamic power management
> works for different devices on most busses, that might help you out
> here.

Thanks for the pointers, we'll have a look
Maxime

--kxv6ogo77qrteawk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZUuqjwAKCRDj7w1vZxhR
xapoAQCtWDINqjYiWVkPAhUtwPTWoT7+cKNl5hbZl54zepr90gD9FFWar6/phKvE
jZfxo3gFVnhRNdVW8qbKy5lV+L6ivAw=
=+xHz
-----END PGP SIGNATURE-----

--kxv6ogo77qrteawk--
