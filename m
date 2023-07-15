Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF7B754700
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 08:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjGOGXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 02:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGOGXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 02:23:35 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73D4107;
        Fri, 14 Jul 2023 23:23:33 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id F3F771C0DC0; Sat, 15 Jul 2023 08:23:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1689402211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h3LfdKGs0UxPjzB0BynU4i+zXf5U8uBunZusMAra21g=;
        b=LSLSS9A97dd9uMgAE65BakTS7lZ91g6yS/VGEcPg9pI2t8StKF/F6T+gpZQX7xBPwT9bM7
        3q5JmGTlicHewhE7yBDaIUWe2206dct+xIFvW7R2mBsEimcBXORu0a+STYjj2wyLiRRfq/
        gm0rlVliRJ2WFoxFYEOHVEwJNN4zaag=
Date:   Sat, 15 Jul 2023 08:23:30 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "David S . Miller" <davem@davemloft.net>,
        John Allen <john.allen@amd.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] Add dynamic boost control support
Message-ID: <ZLI7YpMhJjU7Xe0g@duo.ucw.cz>
References: <20230420163140.14940-1-mario.limonciello@amd.com>
 <ZEkrZ83fFwiweCTz@localhost>
 <e3e2d438-6d97-57c8-90e0-8fec874ad43d@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZvntLkCFVhX5QPPV"
Content-Disposition: inline
In-Reply-To: <e3e2d438-6d97-57c8-90e0-8fec874ad43d@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZvntLkCFVhX5QPPV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2023-04-26 09:43:43, Mario Limonciello wrote:
>=20
> On 4/26/23 08:47, Pavel Machek wrote:
> > Hi!
> >=20
> > > Dynamic boost control is a feature of some SoCs that allows
> > > an authenticated entity to send commands to the security processor
> > > to control certain SOC characteristics with the intention to improve
> > > performance.
> > >=20
> > > This is implemented via a mechanism that a userspace application would
> > > authenticate using a nonce and key exchange over an IOCTL interface.
> > >=20
> > > After authentication is complete an application can exchange signed
> > > messages with the security processor and both ends can validate the
> > > data transmitted.
> > Why is this acceptable? This precludes cross-platform interfaces,
> > right? Why would application want to validate data from PSP? That
> > precludes virtualization, right?
> >=20
> > Just put the key in kernel. Users have right to control their own
> > hardware.
> > 							Pavel
>=20
> This matches exactly how the interface works in Windows as well.

Windows has different design constrants.

> The reason for validating the data from the PSP is because the data
> crosses multiple trust boundaries and this ensures that the application
> can trust it to make informed decisions.

If the application can not trust kernel, you are already doomed on
Linux.

									Pavel

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--ZvntLkCFVhX5QPPV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZLI7YgAKCRAw5/Bqldv6
8h10AJ9TRbzD34klcp52yn4ZUhUWuRE2nACdG7WaPnyMrL14KJu0Hm/iFjkn3IY=
=NzZ5
-----END PGP SIGNATURE-----

--ZvntLkCFVhX5QPPV--
