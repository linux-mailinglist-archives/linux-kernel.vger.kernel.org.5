Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4967725A0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjHGN23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbjHGN21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:28:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2268D18C;
        Mon,  7 Aug 2023 06:28:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7645615AD;
        Mon,  7 Aug 2023 13:27:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0CEBC433C7;
        Mon,  7 Aug 2023 13:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691414858;
        bh=MAP66GDGt6xrx+xf3NGlYghPQ2Z4QU95/7gkBxq0OTc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TIBxbDQ/LW0ULwNUOI112Xm4KrJPovc4Q5ZanIAsR20ju+hWTkJmkJTeoSzGLZaru
         YNgQ9ipmaqT2hRgPjPVGH3ko09kbdRg8xb61ecAP6YciCmS2M44BRAP10caGfexDd0
         UpWTwD+uVBwUnBGwHBVYVweyWKHOUhHxgkgiEG9s5xQ0UpPTZqiqjrs0AbfOnWe9ov
         qXtcc+K4GLQVoL+HcE4Kp1wd9FF0Dw952pVGGhfEjc3w1RGSZyVlgbefgQOyZtsPQa
         f5dxG3z+fmKmLbKghbXnVrzGDSRyxn0qjXNKs21mB2UXqv9ux6RyANKyCRtWoyMfwQ
         dk6Qvv2wSYLHQ==
Date:   Mon, 7 Aug 2023 14:27:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andrei Coardos <aboutphysycs@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        nick.hawkins@hpe.com, verdun@hpe.com, alex@shruggie.ro
Subject: Re: [PATCH] spi: gxp: removed unneeded call to platform_set_drvdata()
Message-ID: <c867e685-7665-420b-9478-bce6eb067463@sirena.org.uk>
References: <20230807130217.17853-1-aboutphysycs@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zAdnmFfTpGPFqY1x"
Content-Disposition: inline
In-Reply-To: <20230807130217.17853-1-aboutphysycs@gmail.com>
X-Cookie: idleness, n.:
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zAdnmFfTpGPFqY1x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 07, 2023 at 04:02:17PM +0300, Andrei Coardos wrote:

> This function call was found to be unnecessary as there is no equivalent
> platform_get_drvdata() call to access the private data of the driver. Also,
> the private data is defined in this driver, so there is no risk of it being
> accessed outside of this driver file.

That isn't enough of a check here - people can still reference the
driver data without going through the accessor function.

--zAdnmFfTpGPFqY1x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTQ8UUACgkQJNaLcl1U
h9CYIAf/ROUAMJppuOVv7Ed0Jy9dMhO/EAh/6Zcy7y1tcWtyBsxYwiJc4gbub7lN
mr40zoxh993xeWFpyFbB7J+pQnPV6G+be9COxUK6RsIqVm2e0ybLC5lNv/o1pefh
3+otfuxQs0UxN6JPlRpTqNOfZW39sgKhLKxZduInP8Rwad/NszlPbTxvtQZjk4BL
tyt57gqHOHHn/dfgMB1kOnPS3LZ8H+oJoGLBulgoSa1RcCj1FMrRk4zqCQi/Sd+x
zYYNTUWR0Fcco/eqDIDjfPB3C/GGXQPL2cigV+tKcYwFznUsRzqnh48esqgxn5Gv
qV7kKyj5w54yGuz7mH6Rp+k1o9JJNg==
=esZH
-----END PGP SIGNATURE-----

--zAdnmFfTpGPFqY1x--
