Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B927F5684
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 03:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbjKWCpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 21:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbjKWCpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 21:45:43 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12A91A8;
        Wed, 22 Nov 2023 18:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1700707547;
        bh=TEx2hkCoBOjDhspfbnS7KuTYyc0yi6VsIhBcpQ2tTB0=;
        h=Date:From:To:Cc:Subject:From;
        b=gORI8rUnblpr9Lw1cfWvbInBtOy2a0x4y6bEn+8EfFGqaUTJwvuALeIOLYlw3MOtm
         Lqda1/TgvngfSvT5M96wEpjP6JeAABlJxpMd/l9O91zBIyU651M+SIKM7M9rPKBYRS
         aSFYFJIy6+PUjOB2cWAC4SYUWU1uS9t9rMkxl2Cz8UemqHjvl31kfCH+19wsRCsYPo
         1Hr90mdP25eYPg0fytn7XqxMfmHxlH7V8ttOZTTEdhOxEEYmH/ntc3zsfp1r9lkJHS
         TOMTCscDuqabktBPpL/dz6s3FE3zGvU8V2q5VGzlOO2Wpgm2n0UQObobloLARqWTFX
         zPOXCuD4pswMQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SbMtM1MByz4x1R;
        Thu, 23 Nov 2023 13:45:46 +1100 (AEDT)
Date:   Thu, 23 Nov 2023 13:45:45 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the net-next tree
Message-ID: <20231123134545.3ce67bd4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Ud56VJJErToe/mhvryWCuaP";
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

--Sig_/Ud56VJJErToe/mhvryWCuaP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the net-next tree, today's linux-next build (htmldocs)
produced this warning:

include/net/page_pool/types.h:73: warning: Function parameter or member 'ST=
RUCT_GROUP(' not described in 'page_pool_params'

Introduced by commit

  5027ec19f104 ("net: page_pool: split the page_pool_params into fast and s=
low")

--=20
Cheers,
Stephen Rothwell

--Sig_/Ud56VJJErToe/mhvryWCuaP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVevNkACgkQAVBC80lX
0GwPywf/abEsjOtqlmt08zTsQZq4NBY743XvHVD3DcubT43lnsKyFliy2FlGs4mC
Gu7dcVinO3zHhhD/b/B42xl8FegYMP6S1HSoR47SEzfOvzcEScmyMkmqr7CKywld
lYhwQ9TD6ISd29YbW1lb5x2ZuuVh8nOGb40bhSDZnucKSoxKXUjWnQDEbicZB71J
D9DieZIaa4ILuGoZ/LstLKkQUDo/9L+qjc+SE62PlKZNUOg4YrXsVkTHBifGI+tu
ThZDYQGR/Ms6rqAmrbcDSv0832ElRqWYbi28M6bgbAf2wDTEQk+PidmZQ7RA1vIM
GnOmvsoGJanCjCsqZwwxKNBAAUdzsg==
=Xz/B
-----END PGP SIGNATURE-----

--Sig_/Ud56VJJErToe/mhvryWCuaP--
