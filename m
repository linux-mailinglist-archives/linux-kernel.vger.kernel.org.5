Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2CA7DE970
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 01:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbjKBAgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 20:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjKBAgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 20:36:08 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC9E101;
        Wed,  1 Nov 2023 17:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698885360;
        bh=DilUg6V/8gKKGvd5+lbnLmizPY1cJYZW7oWRbeuiWU8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JOE2+wXuVan86xnVL6IJaTfdJZ7odPv41V883z+cXO4T43TccoXbN1R1ywO1DzfL1
         EM2H7sThTQR14/N4U/EpmNePNqgLAkfahjz+XP8cnIk6347HGyZNC7XjS5s1/4gOLi
         aOVMxBT47W4kRrS7u9EAMIYy8pGqT3Q8kX2FYvHDXJ5i4ZTeVrRBN6VQ1O39DfHs+8
         0xPAYqIvtHuiVVzfm3EcCM5c7kJzjbIaaEwt+3VBYPOa2HIdyybbxwGipsPuEy/GFR
         sBqSyyTe+WXKNm8LSIwgQJhumOPLPZbgnIZmRdnOdDQTBi9lONf4smymqoVyQfbS6W
         OtB5HZdO3HWhQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SLQ0H514Zz4xWR;
        Thu,  2 Nov 2023 11:35:59 +1100 (AEDT)
Date:   Thu, 2 Nov 2023 11:35:58 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dipen Patel <dipenp@nvidia.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the hte tree with the gpio-brgl
 tree
Message-ID: <20231102113558.7f70323d@canb.auug.org.au>
In-Reply-To: <20231024151138.74b045ce@canb.auug.org.au>
References: <20231024151138.74b045ce@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/CuJq0SZXgVK89hE4tl+DR/l";
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

--Sig_/CuJq0SZXgVK89hE4tl+DR/l
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 24 Oct 2023 15:11:38 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the hte tree got a conflict in:
>=20
>   drivers/hte/Kconfig
>=20
> between commit:
>=20
>   9bc633117d6a ("hte: tegra194: add GPIOLIB dependency")
>=20
> from the gpio-brgl tree and commit:
>=20
>   63137bee5a7a ("hte: allow building modules with COMPILE_TEST enabled")
>=20
> from the hte tree.
>=20
> diff --cc drivers/hte/Kconfig
> index 8e0fd818a73e,083e67492bf2..000000000000
> --- a/drivers/hte/Kconfig
> +++ b/drivers/hte/Kconfig
> @@@ -16,8 -16,7 +16,8 @@@ if HT
>  =20
>   config HTE_TEGRA194
>   	tristate "NVIDIA Tegra194 HTE Support"
> - 	depends on ARCH_TEGRA_194_SOC
> + 	depends on (ARCH_TEGRA_194_SOC || COMPILE_TEST)
>  +	depends on GPIOLIB
>   	help
>   	  Enable this option for integrated hardware timestamping engine also
>   	  known as generic timestamping engine (GTE) support on NVIDIA Tegra194

This is now a conflict between the hte tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/CuJq0SZXgVK89hE4tl+DR/l
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVC7u8ACgkQAVBC80lX
0GwwkQgAhr+AC7KGLdiBAzPcWcQmH929+NI0My+54gvGplsOjT6Xpd9uorD+k4bm
hPUNNWuGzsi0+EvuFexAld7cxUydrvMzVBQueJ/+JR43sTCyKTUscAeCV7BW8zT8
Kv8qGxO40fxNVHMvnWij3eLt0NKI/gayEJK9+5GTHALUR/eFJNI1OxToOcHpzcsD
3JpHrouA9NCZPNlDiglsNp9ZHl5FRSinnhgIGr4FU8Ujh2ugg8pP7pWXOUwZVz9/
bBhKKnb41yfslOZ0kl6/3DkmbtMudZfXnOBMdLxhb8p1J2WoaeVcMRefWc6CjLO1
sd+OyzWtv9ZfN5HItZRJyuLDQCRjIw==
=ZNDj
-----END PGP SIGNATURE-----

--Sig_/CuJq0SZXgVK89hE4tl+DR/l--
