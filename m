Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDD675CADD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjGUPDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjGUPDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:03:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8F419B6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 08:03:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CA5861CB7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 15:03:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC14C433CC;
        Fri, 21 Jul 2023 15:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689951794;
        bh=3lQEccUgeoU+LY7Bm4F8/tc5wNmTkF9n8gZCKBDPIE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XJgW5+AVRoMwwXCgB+5fIKuV86ywrR73Q3qbstfYFiQ4Hp9YIptRpce+xBUGPprQm
         vlynbOTEDASOsTQcqHlSdbIDcQ7BQTqO2GyOGbtyFwhJA3HNRWUSF6gW7KeIGbuAON
         S2GE0RC1HY3wEl+l9RYPktoKA4oFd1YO9avNf/PBwKaWFIOP3Dvy5JdSJbCU+ses8L
         Om6l+DQm4Z9AaDcVEj4TnmgKFZeEnrlv3Gu6Ola8rjp1TH22UhIxOyWSPd7oQs39fi
         X8BqVkbRjCE3PYYXRl0VkkkcBctM3piQRGb6UTmi5DG3P+Q2C74v7A2+s3HHsBZNH+
         wkitWJtmiW/lw==
Date:   Fri, 21 Jul 2023 16:03:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Andy Yan <andy.yan@rock-chips.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [RFC PATCH 2/2] regmap: Reject fast_io regmap configurations
 with RBTREE and MAPLE caches
Message-ID: <fe31bb86-40ec-4b77-9edd-eeaa61bb5e08@sirena.org.uk>
References: <20230720032848.1306349-1-linux@roeck-us.net>
 <20230720032848.1306349-2-linux@roeck-us.net>
 <CGME20230721145342eucas1p12e658a54d36d985b2811e2c21f7810ee@eucas1p1.samsung.com>
 <c2bba4df-da1f-5666-89aa-28c6700575ca@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gAes5fkevpu9MOKk"
Content-Disposition: inline
In-Reply-To: <c2bba4df-da1f-5666-89aa-28c6700575ca@samsung.com>
X-Cookie: Do, or do not
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gAes5fkevpu9MOKk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 21, 2023 at 04:53:42PM +0200, Marek Szyprowski wrote:

> This patch, which landed in today's linux-next, breaks operation of the=
=20
> RockChip's VOP2 DRM driver=20
> (drivers/gpu/drm/rockchip/rockchip_drm_vop2.c). I'm not sure what is the=
=20
> proper fix in this case. Should one change the cache type to REGCACHE_FLA=
T?

Actually Guenter and Dan have made the required updates to support this
so the warning will be gone soon (hopefully Dan will send his patch
properly shortly).

--gAes5fkevpu9MOKk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS6nisACgkQJNaLcl1U
h9DRMQf/b5AYjPE1YkF6k5CtGZC6CmcOf86Od3fDegvUhYac6CqTNT/M0j3BpfZa
ayrjkV/9QU8asxZJXJpXCXCq8NPaV5pu0s1e7TYpcE+RW+KYJ4V17ulBdrGNw0Ue
Ib1oNDKwIZ0tB48/kuGA4xJ7vFkhBx8G0NQx65YQgT/nzRA672SFyF0CeKE00kht
kcPbPql6i6fbqzgEmuwePoAhAkcQ0LyVNwYHQo8BraiJa0sevHZhgOvuhLH/2sh7
kTU0edqsT76yxi42GNtqOByc7qLvlj+L9aGufyQl/egHI9ycPKrVmNoNeksjBIOQ
EcrwwECJM56mzh+Zpi98I9Ja8Taraw==
=P+fK
-----END PGP SIGNATURE-----

--gAes5fkevpu9MOKk--
