Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A049764320
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 02:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjG0Azu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 20:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjG0Azs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 20:55:48 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2948C128;
        Wed, 26 Jul 2023 17:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1690419341;
        bh=UFMoZKi7V33EmgvjH/R6KMUgI2DKINwbZ0AlLQr3a8E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iI49eekM5Ibc+F1kCgCKAlbAOLNuiLjU/ZMk3aDglJWBC3CRn0p9diAM5tjasXRsz
         LLuJHuulKOUW6KvpZ5BjY/KtkTGTfq+eOG/FuPN8EBDBclts/C4w2PC/wpgKbRIUWj
         JDhI/DOuArq3WWkFbp7ssGK4Vc9iYIlmPtB3DNrj52p2hIy9yRYAGQ9MzroI7lqvdM
         9rPxVQTy/W11iXfBRV7vnEY7zp1fGb4B8DViSpZ7FP39xq5+k5KSRJqof1lPwPdVie
         iN5p5GjKOvKKn16qEgWm/pMVV5lXAduI78DpG0/ThUq3t8SA6WCOU38RW0IKpWqjRM
         ldwQA4Yd9cjhA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RBC4D2WMCz4wqZ;
        Thu, 27 Jul 2023 10:55:40 +1000 (AEST)
Date:   Thu, 27 Jul 2023 10:55:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>, Nishanth Menon <nm@ti.com>
Subject: Re: linux-next: New tree for generic PM domain providers
Message-ID: <20230727105539.55227684@canb.auug.org.au>
In-Reply-To: <CAPDyKFrHVhg_Jt+nd9H7MtF_ZU+SPF2gtuA1QA0DKRAuq6kexA@mail.gmail.com>
References: <CAPDyKFrHVhg_Jt+nd9H7MtF_ZU+SPF2gtuA1QA0DKRAuq6kexA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/uBoA1ELgprHk/LFWY6aWY9v";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/uBoA1ELgprHk/LFWY6aWY9v
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Ulf,

On Wed, 26 Jul 2023 13:37:34 +0200 Ulf Hansson <ulf.hansson@linaro.org> wro=
te:
>
> I would like to add a new tree to the linux-next integration tree. The
> new tree is intended to host drivers for the so-called generic PM
> domains providers (aka genpd providers). Most of the changes that I
> intend to collect will thus be within drivers/genpd/*, which is a new
> subsystem especially targeted for this.
>=20
> These are the branches:
> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git next
> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git fixes
>=20
> The plan is to start collecting patches beyond v6.6-rc1, but that
> isn't really clear yet.

Added from today.

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

--Sig_/uBoA1ELgprHk/LFWY6aWY9v
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTBwIsACgkQAVBC80lX
0Gynywf9Fd0pGDxUiR2Vr/JUFGgbkoVBSRKu5xUO1IaDxMmgbgWcSHTGEDQJYaVv
neTrANlUtqwk3JRWY7fD/k8GdVpgNJacP/s6TvrC3p17i0LmH6hFN10yvlHryh2x
wvtNCr5XBBzWnFnCwMoy1mAqL7VsUDZOCzu1GkNfpJUYrtkZQ18B+6eriRKgUSfX
/KSNUqya/NrxJmvkLoYG1XFvaVejd+UpvYKlt7RtGTZQH8HOai5y86vz+ep0Gy2B
ZJICg6CTSATdamC7qRvIa1FYhjNRcIHwy4tlK31KMBnVp7II/XGf1QQP/6Q4uSpD
cDj76mfWTgE1lmcGxjqwux3Y2G2rvA==
=FiRt
-----END PGP SIGNATURE-----

--Sig_/uBoA1ELgprHk/LFWY6aWY9v--
