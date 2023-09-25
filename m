Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B240F7ACD71
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 03:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjIYBKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 21:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjIYBKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 21:10:22 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E2FC4;
        Sun, 24 Sep 2023 18:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695604209;
        bh=NZtOTu9nfPR2vyU3CtBKvKUXPFl6+5told3vzt5YVTY=;
        h=Date:From:To:Cc:Subject:From;
        b=m0nuTNWHXJqlyf1dQTvOua6J+IOtmyoNrCaXlNyrVGDihrdcsxjE4JAtkMK5Gaq4T
         gw2Kbp4Ce/vT1u4c8tyruJ1aWXepPwq1/KvNZLDd4JugSGGrMlRerC/YTU78TcM7Rs
         tvfwO/bnJFBl/mJS4pT77R7mq2qYAkLN+9/x9sKNVr9+9WJNQ9vcNWrqFr4lhF4fY/
         0jj2Ar+j5qsKDWYo4MSafZeLl5bUgVInKdfX5W/7+2LLf9eMQ/pGACsSD3kluh39Qa
         SxdLg3ItSimSaZj/Yer2IgzhjdbKOXQ6KhJsm+7gTBT0XdmqY1LsBqxIaWjYteBzME
         9tDeEjjPrMhiA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rv4YD6dk2z4xF1;
        Mon, 25 Sep 2023 11:10:08 +1000 (AEST)
Date:   Mon, 25 Sep 2023 11:10:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Hector Martin <marcan@marcan.st>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the pmdomain tree with the asahi-soc
 tree
Message-ID: <20230925111007.46e31ba2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ltiG98nSm+H76LejjrqZ81W";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ltiG98nSm+H76LejjrqZ81W
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the pmdomain tree got a conflict in:

  drivers/soc/apple/Kconfig

between commit:

  6fca0adc61cf ("soc: apple: mailbox: Add ASC/M3 mailbox driver")

from the asahi-soc tree and commit:

  1bfadf2edd65 ("pmdomain: apple: Move Kconfig option to the pmdomain subsy=
stem")

from the pmdomain tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/soc/apple/Kconfig
index c5203c388bf4,eff486a77337..000000000000
--- a/drivers/soc/apple/Kconfig
+++ b/drivers/soc/apple/Kconfig
@@@ -4,35 -4,9 +4,22 @@@ if ARCH_APPLE || COMPILE_TES
 =20
  menu "Apple SoC drivers"
 =20
- config APPLE_PMGR_PWRSTATE
- 	bool "Apple SoC PMGR power state control"
- 	depends on PM
- 	select REGMAP
- 	select MFD_SYSCON
- 	select PM_GENERIC_DOMAINS
- 	select RESET_CONTROLLER
- 	default ARCH_APPLE
- 	help
- 	  The PMGR block in Apple SoCs provides high-level power state
- 	  controls for SoC devices. This driver manages them through the
- 	  generic power domain framework, and also provides reset support.
-=20
 +config APPLE_MAILBOX
 +	tristate "Apple SoC mailboxes"
 +	depends on PM
 +	depends on ARCH_APPLE || (64BIT && COMPILE_TEST)
 +	default ARCH_APPLE
 +	help
 +	  Apple SoCs have various co-processors required for certain
 +	  peripherals to work (NVMe, display controller, etc.). This
 +	  driver adds support for the mailbox controller used to
 +	  communicate with those.
 +
 +	  Say Y here if you have an Apple SoC.
 +
  config APPLE_RTKIT
  	tristate "Apple RTKit co-processor IPC protocol"
 -	depends on MAILBOX
 +	depends on APPLE_MAILBOX
  	depends on ARCH_APPLE || COMPILE_TEST
  	default ARCH_APPLE
  	help

--Sig_/ltiG98nSm+H76LejjrqZ81W
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUQ3e8ACgkQAVBC80lX
0Gz89gf7BT/JmoWiimBRTKLQ5T8vdYn2btkR9Ux+Y4g3RNdUrAimK6yXIWMN0EPL
ah9xqmmau9zD7bJzDu0dsIv3ovGEhe+1gQJgIXiyY5RXs9zTz8oalKqkPX2Lwltn
CX2n3bUCMvEhJ0gOB1yuNyesDNGAncGpV+gzFWs54JejvjtxLBNNAzazujbmFTk7
PqjLTIatFeBgMMv7TPyho6TBs53VbFw1rovf9hEEeAYrlr8/1CVGulOvESG23Pga
cx092HSWyV2bEsCIho0VFAuMkEw8pKBJ58/pmHElQyUO6904rOri2SL+VW9m+5fU
fYocbtCRGF7xXufRmwgq83Hqk4RlQw==
=v6Xj
-----END PGP SIGNATURE-----

--Sig_/ltiG98nSm+H76LejjrqZ81W--
