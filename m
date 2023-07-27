Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A539764615
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbjG0Fr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbjG0Frc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:47:32 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF0E3A90;
        Wed, 26 Jul 2023 22:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1690436491;
        bh=/Dgf+ZQcoCmW2zZg+QiLcmAWHhDU2MxqOceMEJwdS+U=;
        h=Date:From:To:Cc:Subject:From;
        b=XdtGIcK6NZRBq/4eM4Au4zcnGisTcxtR5lY25h9VUBj/0e23/i3IzQ/gfhn3m66f3
         r4qIZglFJsyLqCbwFbkKZNuxUkwzXVHZCd8witH/kzMvVpXkg7vbofW7YciDQnfKMZ
         l65DrHuNgoh/xkKuNBoB3b2YCby4jurGQ19LoiYYggQuc7pudZZI8sZCNy+jNHANYO
         jH/y7ofaJiiG9W5oZiEl/2o9u6ufLLzDiOSA1nYb0iuPWi9uGd8XXwuRHyoiaUaxYa
         lYmwi9YVOVTU2Tknz9TZjL07XL6Dh1Cf0giecoCwxmc2XRoq84c4BH1jvR8lwinJ75
         Zq7AnS0TIsDug==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RBKQ20bC5z4wbP;
        Thu, 27 Jul 2023 15:41:29 +1000 (AEST)
Date:   Thu, 27 Jul 2023 15:41:28 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Andre Werner <andre.werner@systec-electronic.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the hwmon-staging tree
Message-ID: <20230727154128.6fcdb6d9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LiiUbrF.rVvy2LyhhCAMOna";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LiiUbrF.rVvy2LyhhCAMOna
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the hwmon-staging tree, today's linux-next build (htmldocs)
failed like this:

Sphinx parallel build error:
docutils.utils.SystemMessage: /home/sfr/next/next/Documentation/hwmon/hs300=
1.rst:34: (SEVERE/4) Missing matching underline for section title overline.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
temp1_input:        temperature input
humidity1_input:    humidity input

Caused by commit

  33faa6fcc93f ("hwmon: Add driver for Renesas HS3001")

--=20
Cheers,
Stephen Rothwell

--Sig_/LiiUbrF.rVvy2LyhhCAMOna
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTCA4gACgkQAVBC80lX
0Gy5lAf+M2d/2c4Q+aBvZXW+NcLAOkxBHc4c8JrAOcRdzY75UqaVfCWCTH0k8hzC
TPH9YUw8cpCFQEXPrYWhfRiPmg2e/ASAk9Vp/LjTuiqAtMhH8TiMsKVysHCIBJCV
p00r5axOrC+Fwo0hZW8uSMpBlmqmj//pJPlut58uHv45BYYODPhUELXkonmlJL+h
tGTIgFVpE04grcsucDQzAbuyDPquGYLfb1Uho/M3PDAU6biC+FacWXXYGOgE2OaM
dP1efeT8NXqe9szDTQavWTEjIwQsN0UjyyUmwPcZUQ7JiXTtAvoiEUpktnQ1fW7s
ZHU1ycE30B14uHdnLnATY5kCPPtgUQ==
=Pxxk
-----END PGP SIGNATURE-----

--Sig_/LiiUbrF.rVvy2LyhhCAMOna--
