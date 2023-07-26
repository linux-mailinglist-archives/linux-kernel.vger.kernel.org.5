Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E944762AA2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 07:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjGZFOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 01:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjGZFOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 01:14:50 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD82D1FEC;
        Tue, 25 Jul 2023 22:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1690348487;
        bh=v/nOn018FuyUeunv3oP3EnLz/kJOL3qEeAcH6dwgPkI=;
        h=Date:From:To:Cc:Subject:From;
        b=L43aSJdDV3IU9TU9LoOuVwE/Bvopay7QwkDfkFlcwGIjw2vQfp/CCVSmY0V8mWDU3
         VMHbt9LwF42BqS8wdBI5ikwCP66xDA+VrXMv/VWEfEIVLEbpGVLujx/6ccMBK5+t7O
         o1m/S5+rQQZYWgR5Cor2ir2GFAMB25GJJ3hHnhlxzUU1jzeHcsTRKQ2MTDbHT1WJ/Y
         WY5vRORaTFvXg0yladl41qIG5Dt/OWjNEQBGjLMUTVEPQW07zfKdnk8SVoQvMhQu9e
         Hhy5DUue7uJLdo/+9BlyN5lZ/6TKc8zq7oNapJr/m9kHendU1bgTQEVaPTQnAED9q7
         0HoSfdLq/Mz6g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R9hsg0cd2z4wZs;
        Wed, 26 Jul 2023 15:14:47 +1000 (AEST)
Date:   Wed, 26 Jul 2023 15:14:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20230726151446.1fc68a86@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=Q79tXWhwHOqojYB5dF_yS7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=Q79tXWhwHOqojYB5dF_yS7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (s390 defconfig)
failed like this:

scripts/gdb/linux/constants.py.in:26:10: fatal error: asm/memory.h: No such=
 file or directory
   26 | #include <asm/memory.h>
      |          ^~~~~~~~~~~~~~

Caused by commit

  dc7e66b9c82a ("scripts/gdb/aarch64: add aarch64 page operation helper com=
mands and configs")

I have reverted that commit (and the following 4) for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/=Q79tXWhwHOqojYB5dF_yS7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTAq8YACgkQAVBC80lX
0GyCGgf8DYAXUm6ZY3j4g4IFO/9F99TyAgk/o226k7DkLPFcNsnbLzRMGetnMBX4
u6IGibp1El3DhTaOK1C7IAwSlVloXmr3roBUi0trmiruM6cUMrMdvbs4m8PrcEnd
GEfBn2X55qgIpwwGny7I40AI4izyGuLsv9hKb8HS4r8m5vOgYTvNW5N2evjCkEmF
Tdfw6sE59DteDm+VR+ZLEne5si9nM/dgO190gUpSoISKiFB+DqxM5eJGyuHeRDar
lJshfxQsI7gC5EDAa9f2E9blauxj1yQNi2M+ZMZXw5FQftFH2NbBfdP6UadPoQOM
6cJcA8y8uxoEcKDX8BluJZtBQTkzHw==
=rXjd
-----END PGP SIGNATURE-----

--Sig_/=Q79tXWhwHOqojYB5dF_yS7--
