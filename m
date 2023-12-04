Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144A2803261
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343730AbjLDMT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjLDMT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:19:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE375C3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 04:20:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7D2C433C8;
        Mon,  4 Dec 2023 12:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701692403;
        bh=0qvMhFDnM/7yiCgOLoXikHI+tn389Ae71sX3tu1wBsk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rQBSuz20375Yd2A4Th4NyYhFUSw5dUpR7u3d5g2SWqweNcGTMC05TZw7w98hdkJwW
         nAgj1cY/sNIgPQEIyzzC1h13fVGHTQIMXnd5qby7ctA9JxrQYOS/wogPGrToxzPldE
         dJZvj9RTKQNMaIFSDmIBKMMNmFb7DHJp7SHbTy/eMDdabXbsUSUfgUQzT7bLMhitKt
         /K21c/RXLkMbNrC3RN+ffzSBoI9m8JdnWYmcluzEVxwskt7Woj2lqDlpvcYFe0f1nm
         W2df/dqn9acBHOMhBypdCfU4DCR9vv22WZIk5V9vRpVXey9NliU99ouT4rIDR2iW0p
         mVT31Wewa36/A==
Date:   Mon, 4 Dec 2023 13:20:00 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     Pekka Paalanen <pekka.paalanen@collabora.com>,
        =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        'Marek =?utf-8?B?T2zFocOhayc=?= <maraeo@gmail.com>,
        Michel =?utf-8?Q?D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
        kernel-dev@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com
Subject: Re: [PATCH] drm/doc: Define KMS atomic state set
Message-ID: <orevvhcz7e4p7ztincqegggfstkfz5jv7w2ugqpdqadvkfwzig@oxf5k2pgdd4t>
References: <20231130200740.53454-1-andrealmeid@igalia.com>
 <ZWn1EC04wBSN9hu2@intel.com>
 <20231201181616.4c1f0acc.pekka.paalanen@collabora.com>
 <ZWohUl3Ma6Q2fccG@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pz2s7ou5ixdylful"
Content-Disposition: inline
In-Reply-To: <ZWohUl3Ma6Q2fccG@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pz2s7ou5ixdylful
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 01, 2023 at 08:09:22PM +0200, Ville Syrj=E4l=E4 wrote:
> > When I was working on Weston atomic KMS support many years ago, I
> > created a framework that emitted KMS property changes only when they
> > actually needed changing. By review feedback (*), all that machinery was
> > dropped in a re-design, and today Weston always emits all KMS
> > properties it knows to program for a specific CRTC update including all
> > relevant planes and connectors.
> >=20
> > (*) Why do we need to repeat the same state tracking that the kernel
> > does anyway, and also risk getting out of sync with the kernel due to
> > bugs which then become more difficult to diagnose. I guess (assumed)
> > kernel internals leaked to userspace. Oops.
>=20
> The kernel does track the full state sure, but it doesn't generally
> go out of its way to figure out what specifically changed in that state.
> Doing so would be a lot of extra checks, and kinda less convenient to
> do inside the driver since at that point the state is already spread=20
> all over the various structures. And the fact that those structures
> are a mismash of uapi and internal bits of state (and other metadata=20
> for the single commit that really shouldn't be stored there) doesn't
> help matters. I did propose to split the state cleanly into pure uapi
> vs. internal stuff but that didn't gain any traction unfortunately.

Also, that's not how drivers are modelled, so even though we could
possibly figure out the entire state of the device, we don't have any
code for it because no one really needs to.

Maxime

--pz2s7ou5ixdylful
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZW3D8AAKCRDj7w1vZxhR
xfuBAP44RTvwxwTOGMBqJ8ApzDoUdsKylzTHDJ1y7Xp8o9Eb5QD+PrvitvNf4ZWM
mUo/xz1bP19ktkumOT0biPRVFs6ZiAc=
=CVBx
-----END PGP SIGNATURE-----

--pz2s7ou5ixdylful--
