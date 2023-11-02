Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18DC37DFC7A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 23:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377508AbjKBWjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 18:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234638AbjKBWi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 18:38:59 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4D2197;
        Thu,  2 Nov 2023 15:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698964727;
        bh=WyzxI/clJruJ4BLPu4RXlK39VrnkLyClpw2spayrCow=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Dj7bHAuYxqQXHKn6q14pF2PVkcp8pSkaofNNHFG0CFPX2K/i4SqezpHGJSrPayRCg
         yUoQJO838jo3dyRvLDKsDQzLoJriLUKD5eNjnk/3JdqrswL+DbirKhk38nrWK35hAt
         mkrnfYWq7VDes2T1keSouBoLGUcZjAQArQxyzM4n0vydgN2CkJeY6NUWmhZnFK+Z/S
         XlQRZ5mQLu/5wQTMhw4luwjx7a5kaXkpfuIwuh9kksVhcXxRfWsjBKdO7IMuo74Om7
         jVoxryil/0eWLYwbxHFf3b91eSkreBzb31zX7QX7EMWsmVbYrrfvAvkqLpXqFudb4N
         nduMoKaWI3QhA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SLzLb0d6qz4wc2;
        Fri,  3 Nov 2023 09:38:46 +1100 (AEDT)
Date:   Fri, 3 Nov 2023 09:38:46 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Hector Martin <marcan@marcan.st>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the pmdomain tree with the
 asahi-soc tree
Message-ID: <20231103093846.489e12db@canb.auug.org.au>
In-Reply-To: <20230925111007.46e31ba2@canb.auug.org.au>
References: <20230925111007.46e31ba2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+uQaB/grItLM5mXUdj0wsLn";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+uQaB/grItLM5mXUdj0wsLn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 25 Sep 2023 11:10:07 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> Today's linux-next merge of the pmdomain tree got a conflict in:
>=20
>   drivers/soc/apple/Kconfig
>=20
> between commit:
>=20
>   6fca0adc61cf ("soc: apple: mailbox: Add ASC/M3 mailbox driver")
>=20
> from the asahi-soc tree and commit:
>=20
>   1bfadf2edd65 ("pmdomain: apple: Move Kconfig option to the pmdomain sub=
system")
>=20
> from the pmdomain tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> diff --cc drivers/soc/apple/Kconfig
> index c5203c388bf4,eff486a77337..000000000000
> --- a/drivers/soc/apple/Kconfig
> +++ b/drivers/soc/apple/Kconfig
> @@@ -4,35 -4,9 +4,22 @@@ if ARCH_APPLE || COMPILE_TES
>  =20
>   menu "Apple SoC drivers"
>  =20
> - config APPLE_PMGR_PWRSTATE
> - 	bool "Apple SoC PMGR power state control"
> - 	depends on PM
> - 	select REGMAP
> - 	select MFD_SYSCON
> - 	select PM_GENERIC_DOMAINS
> - 	select RESET_CONTROLLER
> - 	default ARCH_APPLE
> - 	help
> - 	  The PMGR block in Apple SoCs provides high-level power state
> - 	  controls for SoC devices. This driver manages them through the
> - 	  generic power domain framework, and also provides reset support.
> -=20
>  +config APPLE_MAILBOX
>  +	tristate "Apple SoC mailboxes"
>  +	depends on PM
>  +	depends on ARCH_APPLE || (64BIT && COMPILE_TEST)
>  +	default ARCH_APPLE
>  +	help
>  +	  Apple SoCs have various co-processors required for certain
>  +	  peripherals to work (NVMe, display controller, etc.). This
>  +	  driver adds support for the mailbox controller used to
>  +	  communicate with those.
>  +
>  +	  Say Y here if you have an Apple SoC.
>  +
>   config APPLE_RTKIT
>   	tristate "Apple RTKit co-processor IPC protocol"
>  -	depends on MAILBOX
>  +	depends on APPLE_MAILBOX
>   	depends on ARCH_APPLE || COMPILE_TEST
>   	default ARCH_APPLE
>   	help

This is now a conflict between the asahi-soc tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/+uQaB/grItLM5mXUdj0wsLn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVEJPYACgkQAVBC80lX
0GzpTgf/aehLs0Om0hF/+6Fza0QxKH/hmc/zowU3y12JGlDvhQeq2sXHDxv2s8op
hEC4gnXsaOBKScC4rXXiEZ4vX3ess0WQ6KcFaQnjK3ctCRUqBJvyqdCTKQXIdWjX
P8vg2fHneGEI6sVfy0IIy6FVI1jI5yfjmNqkp7v2N0yilFglTUxvYI4XLPCeK3p3
stIlPU1QQuwaJhYxpDJnGOj1HsncrvA0prnsjIBkXTPvYZUNLcRUERSTsUiM2f3P
coVt9Ke/c7Mo5lLVFhhGhUigIv+aGpH94UP3r62uLcRttA6qwxvR0b6S4Sruu2ua
UDiPBS3fQFeFfj3Si3ja38rFOLBlBA==
=30ox
-----END PGP SIGNATURE-----

--Sig_/+uQaB/grItLM5mXUdj0wsLn--
