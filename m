Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1777C78EBBE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 13:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242232AbjHaLNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 07:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238498AbjHaLNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 07:13:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C95E4A
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 04:13:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 75F5FB82268
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 11:13:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18CEEC433C7;
        Thu, 31 Aug 2023 11:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693480401;
        bh=SPHANn9l1aOOZbuKkHiRpjhNj85DHBeIek4xuIuO3qc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qUE+WeUxeiHx3CcuGplbTOAmNIDsGfHBqkHI9/ApYlZTYcB4PoeFDSE007CnC3Jwf
         PNa7W6FxJOsGj9dGa/z38NQ68DPgEvulCKKE+pGfTwJytRVIzNlWZUi2d6DhYJHqEx
         jF6H60I/s8lcvDqgEnsuXV0QNfPFRPsQkZbgJMc+HaWCuSfsxklFgR16sz61hRbWBm
         iCBYHXssVtDZepjaJFMVduY1QBBbQ4TFaJigxPxqakjWEfYMKgxCXlEIEnV8RlEddK
         je69hMuIceU21T0/hItgj6K6O7cSRsJGVfMuVZDAaNq7J/+nme1Gk2aqsye6Yf8xgu
         Rhh0e7O9WkMHg==
Date:   Thu, 31 Aug 2023 12:13:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] regulator/core: regulator_ena_gpio_ctrl: pull in
 ena_gpio state handling
Message-ID: <4434c869-6ef5-40b4-869d-8e4d292ac30e@sirena.org.uk>
References: <cover.1693431144.git.mirq-linux@rere.qmqm.pl>
 <c2551b3da420ab9b69f80ec7a0d646ff69bd0a03.1693431144.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l9GbPXnldKAxL0sa"
Content-Disposition: inline
In-Reply-To: <c2551b3da420ab9b69f80ec7a0d646ff69bd0a03.1693431144.git.mirq-linux@rere.qmqm.pl>
X-Cookie: "Pok pok pok, P'kok!"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l9GbPXnldKAxL0sa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 30, 2023 at 11:38:56PM +0200, Micha=C5=82 Miros=C5=82aw wrote:

> -		if (pin->enable_count > 1) {
> -			pin->enable_count--;
> -			return 0;
> -		}
> -
>  		/* Disable GPIO if not used */
> -		if (pin->enable_count <=3D 1) {
> +		if (pin->enable_count-- <=3D 1) {

The goal isn't to write the minimum number of lines possible - this just
makes the logic harder to follow and for bonus points isn't obviously
related to the chnages described in changelog.

--l9GbPXnldKAxL0sa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTwdcwACgkQJNaLcl1U
h9DlFQgAg1KCgvuzosDYCz5cvzh+BGg9BK6t89Zb3UklQq4XS8Um+ru004DbMb70
wHccOXaqBdVdyyMKK/MnoJ3mU7Yu2wJk5BMErWsIkz0X4ZvEiOjevanAJfU25YvR
xZBbqhnJbACI8A9nUeOCV+puSq7JjKh/iOnzfmp33ojRIlXls3dNjlOxgw6X6wvz
pmxL17uka23CVJXvYACU7hZ9YBqaceRM8eghE0Ti4ox576lBnA6cQrRyhYWgSP4m
0jDzNZTQSMPKeJ9N2cX2nRr3f/HUrOV6pE+9x0VFxle8HAyvTShzxusUhBcUq6Tx
/NQT4DLdZ6G2rMz8fqrBJikpsmm7Bw==
=4Oah
-----END PGP SIGNATURE-----

--l9GbPXnldKAxL0sa--
