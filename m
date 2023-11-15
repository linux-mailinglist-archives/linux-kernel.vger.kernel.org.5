Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94207EC7CD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbjKOPvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbjKOPvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:51:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33C31706
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 07:50:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69AEAC433C7;
        Wed, 15 Nov 2023 15:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700063443;
        bh=AxRQ9Y/RrzRtP29GRL6CccyXYunQ633DeTBzGsCyGQw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fMot+BPSYUpgf34K5i4JQ4ytk8SMMk5K04pNrSisd4s52Sgg3qskLmpuuaxeqgnRP
         avc6wU1wKa0XdWVGrLU8iWAPY0EjnnZythPnnuWVEYCGYdqPbHF3o8ow8W8Qiwl+Iw
         gNkYj9UY/fVTbP4J8CHROmI2LBIvrLHbpqOOBVHtwDNAgG/ofmLka5ea9J7pQP1Wuf
         OJauXAq4mew6jupJKgFp8jlZWqJkyRgzWmMCmnADYqyu39eNtK0e+TXn3h2cYz/q4s
         8m59XLl/PZ8VUtx+RFs1KHwRrpaS7XJCd7I8/bEV9vDzuZy+ZALLQV6N7j2uxKykNE
         bNvNb6MI7HmzQ==
Date:   Wed, 15 Nov 2023 16:50:41 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     David Gow <davidgow@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Rae Moar <rmoar@google.com>, dlatypov@google.com,
        Arthur Grillo <arthurgrillo@riseup.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        =?utf-8?B?TWHDrXJh?= Canal <mairacanal@riseup.net>,
        Sami Tolvanen <samitolvanen@google.com>,
        kunit-dev@googlegroups.com, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Benjamin Berg <benjamin.berg@intel.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emma Anholt <emma@anholt.net>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/3] drm/tests: Use KUNIT_DEFINE_ACTION_WRAPPER()
Message-ID: <6gfqtuhscq2z2obvx3xh6ve4kj5hrqniyegfywldtx2vowdp5z@ikix547w3vff>
References: <20231110200830.1832556-1-davidgow@google.com>
 <20231110200830.1832556-2-davidgow@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n3zmtdttqoymp72e"
Content-Disposition: inline
In-Reply-To: <20231110200830.1832556-2-davidgow@google.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n3zmtdttqoymp72e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi David,

On Sat, Nov 11, 2023 at 04:08:27AM +0800, David Gow wrote:
> In order to pass functions to kunit_add_action(), they need to be of the
> kunit_action_t type. While casting the function pointer can work, it
> will break control-flow integrity.
>=20
> drm_kunit_helpers already defines wrappers, but we now have a macro
> which does this automatically. Using this greatly reduces the
> boilerplate needed.
>=20
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>=20
> This patch should be a no-op, just moving to use a standard macro to
> implement these wrappers rather than hand-coding them.
>=20
> Let me know if you'd prefer to take these in separately via the drm
> trees, or if you're okay with having this whole series go via
> kselftest/kunit.

You can merge it through your tree with

Acked-by: Maxime Ripard <mripard@kernel.org>

For the patches 2 and 3

Maxime

--n3zmtdttqoymp72e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZVTo0QAKCRDj7w1vZxhR
xQeXAP9Cc0Xaqj0i9btSv7+sdwGcJtBfv0nHvQIAVwKgmgijaAEA+a3M3Ed+B0yC
CAa0ilav0pfJVeTj5jGOnK+886mpQw4=
=9flX
-----END PGP SIGNATURE-----

--n3zmtdttqoymp72e--
