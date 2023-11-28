Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE457FC199
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346679AbjK1PM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 10:12:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346677AbjK1PM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 10:12:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5487D64
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 07:12:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A308C433C7;
        Tue, 28 Nov 2023 15:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701184353;
        bh=EreEuo3ByevFdxyj2xZ343mwDCOQFDjI9HUYNeB8qMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZEoh+vW0OQftZ9iSM+pSRAtdLZ0zQ9uW00oeELJA6Y7FXtS9IFsTAMfDp1e8MqDMm
         SrvZogELxuM10C8TdtH40z3Syt8/4hvtAqMY8M4S5hXbFUQh70GveTisFE361PR5ef
         9LyW9XZD3lle+hXXX2BOLP9/NdtjvmiMUgisVwbQ5xcwxMygeeHkRZ6QBM5EHwAGFv
         Hd034FjlzqIzlXhYzThgIT4KBpDpLWJa8fmO83/8gxrz21ctQ7XdaTFVa+00p/eZAb
         BsjBOgdTwEjcIpORqR+G0wtCwZ4cEzYM32eqYzeItQDoRyveZO3vfzuKK8fhrj1OBr
         WHHZZI5RpX61g==
Date:   Tue, 28 Nov 2023 16:12:31 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Daniel =?utf-8?B?RMOtYXo=?= <daniel.diaz@linaro.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
        Arthur Grillo <arthurgrillo@riseup.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        kernel-janitors@vger.kernel.org,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        kv-team <kv-team@linaro.org>
Subject: Re: [RFC] drm/tests: annotate intentional stack trace in
 drm_test_rect_calc_hscale()
Message-ID: <pqaahxdy4lk3kof3z6p5balhkjb7zkcodfbvofoxpuwuspmu77@4b2zkf3odalp>
References: <02546e59-1afe-4b08-ba81-d94f3b691c9a@moroto.mountain>
 <CA+G9fYuA643RHHpPnz9Ww7rr3zV5a0y=7_uFcybBSL=QP_sQvQ@mail.gmail.com>
 <7b58926a-a7c3-4ad0-b8a3-56baf36939ca@kadam.mountain>
 <s4blvjs4ipcqdzodmgsbvgegqh2kxgdnoerpwthvc57hpsulu5@gb2kh7vbv7nq>
 <8489c4db-6639-43f5-b6c4-8598652cdce6@suswa.mountain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f3ytx2rrawo75fs2"
Content-Disposition: inline
In-Reply-To: <8489c4db-6639-43f5-b6c4-8598652cdce6@suswa.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f3ytx2rrawo75fs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dan,

On Wed, Nov 15, 2023 at 05:42:17PM -0500, Dan Carpenter wrote:
> On Mon, Nov 06, 2023 at 02:58:12PM +0100, mripard@kernel.org wrote:
> > > But a similar thing is happening here where we have so many bogus
> > > warnings that we missed a real bug.
> >=20
> > IIRC, there was a similar discussion for lockdep issues. IMO, any
> > (unintended) warning should trigger a test failure.
> >=20
> > I guess that would require adding some intrumentation to __WARN somehow,
> > and also allowing tests to check whether a warning had been generated
> > during their execution for tests that want to trigger one.
>=20
> I think this is a good idea.  I was looking at how lockdep prints
> warnings (see print_circular_bug_header()).  It doesn't use WARN() it
> prints a bunch of pr_warn() statements and then a stack trace.  We would
> have to have a increment the counter manually in that situation.
>=20
> I'm writing a script to parse a dmesg and collect Oopses.

Do we need to? I was only expecting a boolean to be set or kunit_fail to
be called in the WARN/lockdep warning code path if a test is running?

> So now I know to look for WARN(), lockdep, and KASAN. What other bugs
> formats do we have? Probably someone like the syzbot devs have already
> has written a script like this?

I think you got most of it covered, I can't think of any other source of
failure right now.

Maxime

--f3ytx2rrawo75fs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZWYDXgAKCRDj7w1vZxhR
xe+PAQCPKkPfBpRK1+qczjNj3c+A6ZhufldsIRpm3uIfqbui9wD+Jyk05rhSakGj
+srHLHnrqrGTmcbIXi4CaSax0l0TDQg=
=YA0J
-----END PGP SIGNATURE-----

--f3ytx2rrawo75fs2--
