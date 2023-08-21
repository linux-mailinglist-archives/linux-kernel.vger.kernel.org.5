Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062A478214A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 04:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbjHUCCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 22:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjHUCCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 22:02:17 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199779C;
        Sun, 20 Aug 2023 19:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692583334;
        bh=AAlYUOAFZxo4cFfjXrIywnXyqsV4fN6hA8iruN65/8I=;
        h=Date:From:To:Cc:Subject:From;
        b=oPzxSXePDkuLTArCxrjDUuv/L7VraGC3f0+uxcK4A1kryPOPV2GVl3h6OUhKH8ORv
         unL28lOicLMXSOO8SajDJCycI282ecG3FLxyP9RNgCHrhplcJVxn/BRU5Z4UjxwkiT
         FProlDXHdquu1fDH/4jem54+cSUKsrndDsJGkjfjzql6tsN9p0W25/6jTnsc609b+K
         xGHAV4npMa9eVGwRkXyUg7P4C0AikfLjv5qUITKN2J/tUoY8CzQXcTBZbsBcuI0yBN
         FqpFkqMMoGtJi/L+0R1UqhJ57WJ+r7QCdV+iwIr4SOP7+X23L/tp1gzsQD84G89wRn
         Em4pYmwDRB+LQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RTbMV41vPz4wxy;
        Mon, 21 Aug 2023 12:02:14 +1000 (AEST)
Date:   Mon, 21 Aug 2023 12:02:13 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Md Sadre Alam <quic_mdalam@quicinc.com>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the nand tree
Message-ID: <20230821120213.403fcefe@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/PPcDK=4VV4QZXtiRDRTN1Js";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PPcDK=4VV4QZXtiRDRTN1Js
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the nand tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/mtd/nand/raw/qcom_nandc.c: In function 'qcom_parse_instructions':
drivers/mtd/nand/raw/qcom_nandc.c:2596:38: error: unused variable 'nandc' [=
-Werror=3Dunused-variable]
 2596 |         struct qcom_nand_controller *nandc =3D get_qcom_nand_contro=
ller(chip);
      |                                      ^~~~~
cc1: all warnings being treated as errors

Caused by commit

  5a7688a3e2e6 ("mtd: rawnand: qcom: Add read/read_start ops in exec_op pat=
h")

I have used the nand tree from next-20230818 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/PPcDK=4VV4QZXtiRDRTN1Js
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTixaUACgkQAVBC80lX
0GyUwgf8DswX/eLzgLnjR6W/obgEVLmaYO74DdAG0cZQA765gNiJf7nvA11bkFIf
uf6SUo84a7uxAXW7PUW6mBlflTeU062wlyBfAEc88b/5Lvt0jnAYmGm17FFNxGaK
cM6uxxLfH1JXivr9QyN++xmTt+Naylxhte7asI9mYGZ1uCe/airW3jd8BFIny9Kt
REYzwLtH7TVcRtWo7vxaHhMpQ8S6lt8r5mvjz7gzy0xkijrCAizd6LwR9JW90G7e
dnBQ4PfTidGIlxhBi+mDzTPBcPsWQLIKYgrX/PlBhFs2uzMTFsv7wOty3LFzyJaZ
3E7+bmeEMGcoDU7c3KdCKqo1Y+M4Hw==
=piR0
-----END PGP SIGNATURE-----

--Sig_/PPcDK=4VV4QZXtiRDRTN1Js--
