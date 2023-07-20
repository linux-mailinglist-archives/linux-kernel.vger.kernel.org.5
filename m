Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892E075A8FB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjGTITv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjGTITr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:19:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFA8211F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 01:19:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6794618F6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:19:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2BD2C433C7;
        Thu, 20 Jul 2023 08:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689841186;
        bh=LEYRH+AJ/QqdSK5qdoAlO00DoSaMelRgW8AFErE1MqE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tkGb3cahMC7LB2H4YhamM4rwXjT8oJnHeRpVVyueojgXJW2B0DxyZGpDIy8pCt/+0
         DhLLw14nWEq8C8m4VR7xc2QLw/NFydVyQI8MqaVgwGoFNijBX3cWN1DMPqw5FwO/tn
         iqic0Mu2YdC4Qh+ZadX0Nj95QGhMKrYm7cdfXoptZqJXQQtBcN4HEFH04Otehm0BFe
         L9AOEAG38wLrpgt2rKv5z4hcgZU0acFJLnJuNCgK/xRREAYY75WURrHLnqgk5BQMnC
         saimZORIo2QFx/q5sx7q+OlCtwEjQ0f1qvquAxirFrq3OP3HlBD6gtKki+R5wA8QtX
         HZK43uGtPhlew==
Date:   Thu, 20 Jul 2023 10:19:43 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     suijingfeng <suijingfeng@loongson.cn>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emma Anholt <emma@anholt.net>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 00/11] drm: kunit: Switch to kunit actions
Message-ID: <niypycsz25r4ywlxeula3cc3padis74hr5gbr2rjw4hrxag7my@f55p7c3unf7o>
References: <20230710-kms-kunit-actions-rework-v1-0-722c58d72c72@kernel.org>
 <6a92cbb7-e98b-e93c-6e62-ceddd0dfbc06@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7kqetfm2msju6b5l"
Content-Disposition: inline
In-Reply-To: <6a92cbb7-e98b-e93c-6e62-ceddd0dfbc06@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7kqetfm2msju6b5l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 17, 2023 at 11:24:13PM +0800, suijingfeng wrote:
> On 2023/7/10 15:47, Maxime Ripard wrote:
> > Hi,
> >=20
> > Since v6.5-rc1, kunit gained a devm/drmm-like mechanism that makes tests
> > resources much easier to cleanup.
> >=20
> > This series converts the existing tests to use those new actions were
> > relevant.
>=20
> Is the word 'were' here means that 'where' relevant ?

Yes :)

> Or it is means that it were relevant, after applied you patch it is not
> relevant anymore ?
>=20
> > Let me know what you think,
> > Maxime
> >=20
> > Signed-off-by: Maxime Ripard <mripard@kernel.org>
> > ---
> > Maxime Ripard (11):
> >        drm/tests: helpers: Switch to kunit actions
> >        drm/tests: client-modeset: Remove call to drm_kunit_helper_free_=
device()
> >        drm/tests: modes: Remove call to drm_kunit_helper_free_device()
> >        drm/tests: probe-helper: Remove call to drm_kunit_helper_free_de=
vice()
> >        drm/tests: helpers: Create an helper to allocate a locking ctx
> >        drm/tests: helpers: Create an helper to allocate an atomic state
>=20
> a helper or an helper ?
>=20
> Should this two patch be re-titled as following ?
>=20
> I search it on the internet[1], mostly using a helper.
>=20
>=20
>       drm/tests: helpers: Create a helper to allocate a locking ctx
>       drm/tests: helpers: Create a helper to allocate an atomic state
>=20
> [1] https://www.a-or-an.com/a_an/helper
>=20
> Sorry about the noise if I'm wrong.

You're right, I'll fix it

Thanks!
Maxime

--7kqetfm2msju6b5l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZLjuHwAKCRDj7w1vZxhR
xVLCAQDoNdtlkn5fkt9mcb8tWL1g65x5JVr74/QUKDCaIFJE2QD+KS/NvTymDxRR
OMve6TqPr0ZuQfx3+b4y1NYS9yX6cgc=
=jZNm
-----END PGP SIGNATURE-----

--7kqetfm2msju6b5l--
