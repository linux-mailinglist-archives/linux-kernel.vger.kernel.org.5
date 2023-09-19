Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14AB47A5D4B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjISJER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjISJEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:04:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE192E6;
        Tue, 19 Sep 2023 02:04:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE739C433C8;
        Tue, 19 Sep 2023 09:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695114250;
        bh=0HoaoIryoMNBjclA4E9p8j1l8zhUoytllUXAdhNwV5M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b/l9gCQ0T8EvqzJqFrQ5of1NAyiceRmdIutxOzP5nFXj3+C2NovgXilDrksFhbwvr
         O2trT4x5qScyykTeTddgKkJ2NlqZDVkjd4SgU/cCUlaqymPUgEUXTPUFeKvGo8lScP
         GZhlgg0D2BhDqV/cJGjDZ57+o1v4sJPpkJzlTD6KFHl2Kfor2bSkNVksRaj0EyRNbe
         DMS8CrGEZx1spG8Biu/A6bqshM5iuBDdWbOcp6xHWhWRKbCSO+vcn7DRXbGaa/XVxi
         I2qgLNA3dlYfDkC8y/XoLajqwQBijGz6LRnyVp9+yljnrCyDegNBSYRkf9ASlkdT9h
         imjCEN7Pb+nzA==
Date:   Tue, 19 Sep 2023 10:04:04 +0100
From:   Conor Dooley <conor@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v3 4/6] gpio: vf610: add i.MX8ULP of_device_id entry
Message-ID: <20230919-501837c1104366ba793b0c62@fedora>
References: <20230918-vf610-gpio-v3-0-ada82a17adc5@nxp.com>
 <20230918-vf610-gpio-v3-4-ada82a17adc5@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5zdzlSUyqQ668/XK"
Content-Disposition: inline
In-Reply-To: <20230918-vf610-gpio-v3-4-ada82a17adc5@nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5zdzlSUyqQ668/XK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 18, 2023 at 04:16:08PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>=20
> i.MX8ULP GPIO supports similar feature as i.MX7ULP GPIO, but i.MX8ULP is
> not compatible with i.MX7ULP per binding doc. i.MX8ULP only has one
> register base, not two base.

"per binding doc" is a poor justification IMO, as you literally just
changed it earlier in this series. I think the commit message here
should re-explain the problem so that the rationale here is clear in
isolation.

> Add a new of_device_id entry for i.MX8ULP. But to make the driver could
> also support old bindings, check the compatible string first, before
> check the device data.

Sweet, seems like you have addressed the backwards compatibility stuff
for the old binding :)

Thanks,
Conor.

--5zdzlSUyqQ668/XK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQlkAQAKCRB4tDGHoIJi
0rb8AP993AO2r6CSvVZx8F5s5DBodTKq3cEDVHeH6mdCJSOgpwD/Xiq7LXIzgBfZ
6S8r4rMkPZAmZwZvNhTjZVidIH6ZYwg=
=PSDM
-----END PGP SIGNATURE-----

--5zdzlSUyqQ668/XK--
