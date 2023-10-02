Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2257B518D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 13:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236766AbjJBLjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 07:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjJBLju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:39:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C63C6;
        Mon,  2 Oct 2023 04:39:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A238EC433C7;
        Mon,  2 Oct 2023 11:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696246786;
        bh=O7NFR64zOPLmC/QNpKeZgYJ7AuhogpiJTIeNItFSlV0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c9zSq/8im9O/OMdqhtSjRVXbE79zcjQWNT9FpK6FUUxMTrOdkZ5ESETXThYD30tue
         tulTimyVSjR5hwl3iayVlTqsjCCBtzJn7Pcg7oRofQ+Byd/clT3+U7XNc47UXB3SHt
         0rWEpDoZMCMISEUPZjfeUXUyeSgM+3m0ZoJplvSu1fzH95q45SqxWK2VlqcYMKRJEX
         HZkqfCl9Tarx7Jzmw2sCStEGvGZk05y5n86MrmebfY/fYqAZRoHyZYEhF0c/eMmxLf
         3pxkxHQcTjpNH9j8ZqL6MpjFJjMDHcE4nXmY6/2t4GlsB0jV8QY5hOM7WFIIVInGNH
         OMdYyw2PA6EPw==
Date:   Mon, 2 Oct 2023 12:39:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH RFC v4 6/6] input: ads7846: Move wait_for_sync() logic to
 driver
Message-ID: <d55bc5aa-0d23-42ac-8056-649e9dcb416b@sirena.org.uk>
References: <20231001-pxa-gpio-v4-0-0f3b975e6ed5@skole.hr>
 <20231001-pxa-gpio-v4-6-0f3b975e6ed5@skole.hr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="M4Zq+ZQdxjC6Bd+a"
Content-Disposition: inline
In-Reply-To: <20231001-pxa-gpio-v4-6-0f3b975e6ed5@skole.hr>
X-Cookie: Postage will be paid by addressee.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M4Zq+ZQdxjC6Bd+a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 01, 2023 at 04:12:57PM +0200, Duje Mihanovi=C4=87 wrote:
> If this code is left in the board file, the sync GPIO would have to be
> separated into another lookup table during conversion to the GPIO
> descriptor API (which is also done in this patch).

Acked-by: Mark Brown <broonie@kernel.org>

--M4Zq+ZQdxjC6Bd+a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUaq/oACgkQJNaLcl1U
h9Dt/Qf+MSd/mMCZ5OeKKKxAHpF1kvtA5HYwERVpgdRl25JhE/oHIAPXqiqWxquN
cmA2UMzMdGVebBDbjli7wPf5RBtNwZ/B2oTGvUzesyS4cqssMa4DuWJ4JC0huDnt
nQHBqKKORTUL/aUDVUTFjAd/GX/aSUdP+DxpT/5FK3v5BDrVBGIyhMZuHws8mQGX
1MYnpDAAjNrKWEzavwf/KIff+v+mgg2/0XvNgC74/+4V1P7txO/fy5hoz+U5IuK4
NBISeh6GyHXc0mNJ3sDKFCscaWDyYv1Zw6+iK0x29+wQhUia8JDo++hrPrlN+qB7
QDKXiNNMV+m2IwEfp92IOumo45fINw==
=CmBU
-----END PGP SIGNATURE-----

--M4Zq+ZQdxjC6Bd+a--
