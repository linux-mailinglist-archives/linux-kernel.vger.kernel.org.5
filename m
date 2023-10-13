Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD8B7C8DFC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 21:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjJMT40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 15:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjJMT4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 15:56:24 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3244195;
        Fri, 13 Oct 2023 12:56:21 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 09C301C0050; Fri, 13 Oct 2023 21:56:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1697226979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jq/F5+J9wLO4vOEhN66CaFJA8HdsP3GorB/oM4sdsIk=;
        b=NmBrcN46bAlqAc8k37gS9CZrPYzsUOwBg8fUDhRwlNDqgS5VquJq2CY4yjOylgR3A4vz9l
        70V6+FXAp1jm0a2SpCNbYeY0QedxzxEF9hRgRMglLN6A/ryHq7p6V/LEEqAM+SYxLFcb0T
        8YwyenZY1bnk6O3EP/GZ39yZd0sA6kM=
Date:   Fri, 13 Oct 2023 21:56:18 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Werner Sembach <wse@tuxedocomputers.com>
Cc:     ojeda@kernel.org, Lee Jones <lee@kernel.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-input@vger.kernel.org,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: Implement per-key keyboard backlight as auxdisplay?
Message-ID: <ZSmg4tqXiYiX18K/@duo.ucw.cz>
References: <20231011190017.1230898-1-wse@tuxedocomputers.com>
 <ZSe1GYLplZo5fsAe@duo.ucw.cz>
 <0440ed38-c53b-4aa1-8899-969e5193cfef@tuxedocomputers.com>
 <ZSf9QneKO/8IzWhd@duo.ucw.cz>
 <a244a00d-6be4-44bc-9d41-6f9df14de8ee@tuxedocomputers.com>
 <ZSk16iTBmZ2fLHZ0@duo.ucw.cz>
 <aac81702-df1e-43a2-bfe9-28e9cb8d2282@tuxedocomputers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="N7n33QpGAkTgmfyU"
Content-Disposition: inline
In-Reply-To: <aac81702-df1e-43a2-bfe9-28e9cb8d2282@tuxedocomputers.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--N7n33QpGAkTgmfyU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> coming from the leds mailing list I'm writing with Pavel how to best hand=
le
> per-key RGB keyboards.
>=20
> His suggestion was that it could be implemented as an aux display, but he
> also suggested that I ask first if this fits.

Thanks for doing this.

> The specific keyboard RGB controller I want to implement takes 6*21 rgb
> values. However not every one is actually mapped to a physical key. e.g. =
the
> bottom row needs less entries because of the space bar. Additionally the
> keys are ofc not in a straight line from top to bottom.

So... a bit of rationale. The keyboard does not really fit into the
LED subsystem; LEDs are expected to be independent ("hdd led") and not
a matrix of them.

We do see various strange displays these days -- they commonly have
rounded corners and holes in them. I'm not sure how that's currently
supported, but I believe it is reasonable to view keyboard as a
display with slightly weird placing of pixels.

Plus, I'd really like to play tetris on one of those :-).

So, would presenting them as auxdisplay be acceptable? Or are there
better options?

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--N7n33QpGAkTgmfyU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZSmg4gAKCRAw5/Bqldv6
8vs1AJ9BZjtk1gkmyD0cS+oSxeJwzwcjKwCdGTjWT+VUCWYHDh3v+eArFhOO+go=
=OCDY
-----END PGP SIGNATURE-----

--N7n33QpGAkTgmfyU--
