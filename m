Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D04786B5C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 11:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240610AbjHXJRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 05:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236673AbjHXJQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:16:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB053E67;
        Thu, 24 Aug 2023 02:16:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 448A065FAE;
        Thu, 24 Aug 2023 09:16:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23845C433C8;
        Thu, 24 Aug 2023 09:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692868613;
        bh=CK8K59YUSjL1xNRSA2L3H9ryMd1YgDDJ0Z4R5P4hlKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rMfiUcU+r8StcsuNXLiXVRVuNozQ3m7/INGX5Bn3oWmlVIAOoCZ29NDSJyvrv5J4C
         3FhBhrWdEKlMFE2/ltWxQSb6iMzVFdLM+MIcxCT9/FSRXQEDunYAPgiA0oWOUVDh+1
         udCbunZY04xzrkYZk7hh4l2S9NMaghj3pHreMCWS/m0/lU9GWyWwrVZ1jY62VTWrIK
         h3e0/azQPDZBVAAnxcziTw9uFys3FVh7F2oQ4SrJ909pnXS7OWtR0LACIgLHU7kIZr
         JlxetDuvbPnvY0gtpZJl0Av0mvAuct8w3WCgOqoDgcBdRvIUkVY8I8cleiwCOJSJuo
         NSx4tFkmi+qpA==
Date:   Thu, 24 Aug 2023 11:16:51 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Lee Jones <lee@kernel.org>, Karol Herbst <kherbst@redhat.com>,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Mikko Perttunen <mperttunen@nvidia.com>,
        =?utf-8?B?TWHDrXJh?= Canal <mairacanal@riseup.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Shashank Sharma <shashank.sharma@amd.com>,
        Michal Simek <michal.simek@xilinx.com>,
        amd-gfx@lists.freedesktop.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Danilo Krummrich <dakr@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>, linux-media@vger.kernel.org,
        Stanley Yang <Stanley.Yang@amd.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linaro-mm-sig@lists.linaro.org, linux-tegra@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        Jerome Glisse <glisse@freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Gourav Samaiya <gsamaiya@nvidia.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Subject: Re: [PATCH (set 1) 00/20] Rid W=1 warnings from GPU
Message-ID: <vkoj32cjbaozwcgfrp2mowkm6koqtl6espou6vms2pvfhxr5z7@ofabj6kd2j4r>
References: <20230824073710.2677348-1-lee@kernel.org>
 <87wmxk4xt3.fsf@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="utl4vsmjm3ff53l2"
Content-Disposition: inline
In-Reply-To: <87wmxk4xt3.fsf@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--utl4vsmjm3ff53l2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2023 at 12:03:20PM +0300, Jani Nikula wrote:
> On Thu, 24 Aug 2023, Lee Jones <lee@kernel.org> wrote:
> > This set is part of a larger effort attempting to clean-up W=3D1
> > kernel builds, which are currently overwhelmingly riddled with
> > niggly little warnings.
>=20
> The next question is, how do we keep it W=3D1 clean going forward?
>=20
> Most people don't use W=3D1 because it's too noisy, so it's a bit of a
> catch-22.
>=20
> In i915, we enable a lot of W=3D1 warnings using subdir-ccflags-y in our
> Makefile. For CI/developer use we also enable kernel-doc warnings by
> default.
>=20
> Should we start enabling some of those warning flags in drm/Makefile to
> to keep the entire subsystem warning free?

I think that's a good idea. At least the documentation fixes I just
merged could have been easily caught before submission.

Maxime

--utl4vsmjm3ff53l2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZOcgAgAKCRDj7w1vZxhR
xRGuAQDGwZPeKdcZoqTDIIBQZmkNfIvC9zdZcx372SnD7nYQuAEA+1cA8HP2QUBw
CvoouWKq/gGveaBLwNG3zjffzRx2agE=
=eJTh
-----END PGP SIGNATURE-----

--utl4vsmjm3ff53l2--
