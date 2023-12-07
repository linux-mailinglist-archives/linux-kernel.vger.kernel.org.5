Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FD6807E4B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 03:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443005AbjLGCRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 21:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjLGCRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 21:17:49 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3232D4B;
        Wed,  6 Dec 2023 18:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1701915469;
        bh=BJadPeNilwqJMR27SJdY+tSEyAGOn0ZYtO56jJH8lA4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mjAmZdTFLjX6Wg0d3LdKI4bTKH8vpIBlpdFjCdiN2RR603onvLnONhtBrmIluO39P
         kQR8HY9GePMmP0lHinRZxNqPk9keJKyT+gBLY1fizOvTQ5cUn33H1uuCakpaE4Cbr1
         k6C/rPiqL/gtziBANRUJNR/Kdny9yObbix8joDYdtz2XO7IVKOFdYS6YIC6ZCJ8ik1
         6fX7ANCstwnt5ggi5IAWAdwDbqFmi4QdeLX4wr6QIOPWx1kVZlFTAfC7v3B2/8ty+E
         gTvfdf4j+jAw+UDQcmEkAKIGus3PHBAL9By4UzRX1O3gzqUAjit51EJI3YBKMZe6w1
         aaPD+ddeQ1wOQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Slybd1tG4z4wbk;
        Thu,  7 Dec 2023 13:17:49 +1100 (AEDT)
Date:   Thu, 7 Dec 2023 13:17:46 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     "=?UTF-8?B?TsOtY29sYXM=?= F. R. A. Prado" <nfraprado@collabora.com>,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        linux-next@vger.kernel.org
Subject: Re: Adding SPMI tree to linux-next
Message-ID: <20231207131746.5b9ed981@canb.auug.org.au>
In-Reply-To: <87b4577efc5e0e0baf4fcc52d47404a6.sboyd@kernel.org>
References: <facc6759-b222-4912-9d78-deebecc977db@notapiano>
        <87b4577efc5e0e0baf4fcc52d47404a6.sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/N6GLBiiY9IFtaEYk0OsTm78";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/N6GLBiiY9IFtaEYk0OsTm78
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

On Wed, 06 Dec 2023 15:59:47 -0800 Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting N=C3=ADcolas F. R. A. Prado (2023-11-29 13:49:21)
> >=20
> > I've noticed your spmi-next [1] branch is not currently tracked by linu=
x-next
> > [2]. Could you please consider adding it? =20
>=20
> I tried[3] but it didn't get added. Maybe it will work this time?

Sorry about that.  I am not sure what happened (getting old, I guess
:-)).  Thanks for trying again.

I have added it from today.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/N6GLBiiY9IFtaEYk0OsTm78
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVxK0oACgkQAVBC80lX
0GzvoAgApYGmFGViY33taoQGb8f9awp4BivmpY13NcZ5Oj9kKWCMJiLUIJdjNlaO
hbZktdDLYfnmNtmoRmzC+orisVD8U+DF8vOe02Ew71lQ713sUB+DogF5DpoD6QXF
d6WKR4X5jmStmieDDAXpfR0U+11N77b4d3OwZojdnD3Nz9fRFvk/VD74AImHDcUT
kTXQs0oPGXGl3xmmB1HGkjRAOziL1OFcQAoCYSfC9cfxQ2WOWmfGhkXHEtwqy285
4U/j4vCMJujKV796suqm8Is9kQmJyYWT7/M83YZpm8/wQ0NGgZrfPW0h799pMgR7
JwG0BWUFmuRfbsLwZnuNEP9BAjLfEQ==
=j0GH
-----END PGP SIGNATURE-----

--Sig_/N6GLBiiY9IFtaEYk0OsTm78--
