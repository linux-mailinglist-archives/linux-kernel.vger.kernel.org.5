Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5387FD65A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 13:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjK2MMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 07:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjK2MMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 07:12:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F8C91
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 04:12:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19CECC433C7;
        Wed, 29 Nov 2023 12:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701259962;
        bh=O90B4Q0S1Q+25NbVYezH5mjoV/3TQBVl6kKEY21UdBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dNaZjDzlPm9hargk7WwoEBpWiULnK5zXGjWFr4jJRVNrO6rKAOnHDjrH0yNf2rRh0
         F4w1IjdcgUhsVUJ5fMAjZeouxDAP+fayP8yO0E81JSico4hHagDsGkQ1LnQXgY6liP
         r4TFuZFn4pE18UFGTkuK1pNLlcBljsIFFe6YTkfMsJi6S6hCVoxmK2+bp1s5oLgR4M
         zQlG1MWGEf/69f0YY9jMSx805g4qV86Dk2Pmg3BXngNhMA79aOQYWdzR4xfXn0Dw/R
         cl/8v/KFNMGjOpKzSYtmtoe4KC8WR/fwyXeGmXdY9UUULe4cj92mqiAROQCU24akRG
         0cEQvOaRvio6w==
Date:   Wed, 29 Nov 2023 13:12:39 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Donald Robson <donald.robson@imgtec.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, frank.binns@imgtec.com,
        matt.coster@imgtec.com, maarten.lankhorst@linux.intel.com,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] drm/imagination: Fixed clang warnings for initial
 upstreamed patches.
Message-ID: <ewky6qzrzzh56pgrl3arkr5cvwncbonefmhdrjoxyvpaexlfbh@eyxh6p7znjis>
References: <20231129112014.137407-1-donald.robson@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lkhfry2wxo7bon2c"
Content-Disposition: inline
In-Reply-To: <20231129112014.137407-1-donald.robson@imgtec.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lkhfry2wxo7bon2c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Donald,

On Wed, Nov 29, 2023 at 11:20:14AM +0000, Donald Robson wrote:
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202311242159.hh8MWiAm-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202311241752.3iLyyFcA-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202311250632.giVEx7MU-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202311250226.Da2yiSKp-lkp@intel.com/
> Signed-off-by: Donald Robson <donald.robson@imgtec.com>

The expectation is that you send one patch per type of warning or bug report

Maxime

--lkhfry2wxo7bon2c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZWcqtwAKCRDj7w1vZxhR
xcEjAQCmFNuRLlP8MT+UK0jKa63G5J3hYc4h5qVuaAmTQju1uAEAqENb8fcwuHG7
PKDe5N+lmxJDWQH3VgZ0nUTrlN5J4wk=
=pnBq
-----END PGP SIGNATURE-----

--lkhfry2wxo7bon2c--
