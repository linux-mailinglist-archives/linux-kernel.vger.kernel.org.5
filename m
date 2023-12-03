Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5C48028F7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 00:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbjLCXXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 18:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjLCXXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 18:23:40 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB6AD5;
        Sun,  3 Dec 2023 15:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1701645825;
        bh=eZO5vxfD/lUYdJC60TR0T81E9hSH9cHr9B52b7JkpQ8=;
        h=Date:From:To:Cc:Subject:From;
        b=EPFQ+DvB+acgq1ZBpVnZ6RDhHr7RYrxqqtn299/Lmmj2pWgif9fWfsuxlKjihM64b
         yRTfombERaO+JsT/dcO20d/FXxDGdCikHjE3Lfzx+IAhUYj+21TafDENX9RsoEFl9C
         ldNkRZ5oW2lOrSv4g5ZTW1XKaDJffRc84a75Q+WliEju777K6RhwLgYwHDFwFFDmrS
         b0nh9oNo6yQBGB6nSi7XShkdDpHGDrWr/swObxP7PzlCQ54o7mPyXK2D1d+TKG/sg5
         jhk+2jhqGe1m0CjVQmcoFDwMzVbale95w7hgqfq2CmNIV7zg2ize1TOhthftJDJUF8
         gLR1PS+YJ2+Vw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sk2t91BRmz4xKZ;
        Mon,  4 Dec 2023 10:23:45 +1100 (AEDT)
Date:   Mon, 4 Dec 2023 10:23:44 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andy Gross <agross@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the qcom tree
Message-ID: <20231204102344.3a01ad2b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/i8.1yTm3c=/H=KjbtasY+2u";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/i8.1yTm3c=/H=KjbtasY+2u
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the qcom tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

drivers/soc/qcom/qcom_stats.c: In function 'qcom_ddr_stats_print':
drivers/soc/qcom/qcom_stats.c:167:16: error: implicit declaration of functi=
on 'FIELD_GET' [-Werror=3Dimplicit-function-declaration]
  167 |         type =3D FIELD_GET(DDR_NAME_TYPE, entry->name);
      |                ^~~~~~~~~
cc1: some warnings being treated as errors

Caused by commit

  4a55812229a7 ("soc: qcom: stats: Add DDR sleep stats")

I have used the qcom tree from next-20231201 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/i8.1yTm3c=/H=KjbtasY+2u
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVtDgAACgkQAVBC80lX
0GyLpwf9EP7C8bexCsrw6vmqZZ9EUH1r3Omi5+98tvOUuDLJYW1OmXuowf3yRPPl
OToqRzjlhuaVvJEWtyhmZAMOSJMSTeyfuw8fuQ0bbDh88zLrZHgJ2uI6RvtmbDtl
0oMh2ysEpbaeGO9oeQIfqJXs6CESFVxzYf0QlXGoucPLpHlmfHS/50NsVswsXUh4
ws0zmZWCN13P645bHLb1a1LeyXDQR1Z9vQgx1vNmz93XpkAg/ncEFqs9gcocbroz
DDseWXa1ljYpNkNTIqcBg6EQ2dyJ+d5lzF0y37S2tyLoKOPlCQy7OXjOnQziDtUp
S2HXu7xWkiJJIqtE9rv5TVbHZDXaaA==
=dZdl
-----END PGP SIGNATURE-----

--Sig_/i8.1yTm3c=/H=KjbtasY+2u--
