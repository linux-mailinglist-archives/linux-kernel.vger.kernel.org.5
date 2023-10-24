Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6927D5EAA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 01:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344624AbjJXX0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 19:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344484AbjJXX0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 19:26:54 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A5CD7A;
        Tue, 24 Oct 2023 16:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698190008;
        bh=cmGDdCcUCwFHEDhnWKHytkmnqawZeZ/8KeV8lsmxpRs=;
        h=Date:From:To:Cc:Subject:From;
        b=maMHOY3GMI+cvLqVsSlRh0vLmza25pnuDgJhanopusIjn1sZG9ohkGeAglUO4T5Gk
         1KEQq2Fgh4+8bIcOx07oaOlS8cDU5tHOZbVrUSNLRx5IlzsU4Zm+U4nFSI8BrGxeJm
         ztz2GKZBk95DVnFgPo8K/vq9Bbb9+N57wq5AmbzBA05U7RHpNcrslXeTmlKQlHgbd4
         RlP+t5PXP6S1eJSJwDyNJm8pHjT1ee6vFGgvlv4dST7N1cvuQgPnOIMk3bSON5WkFU
         v7BhL8WaIiaLmfg3/otorN16SH8lqu9/5RsmNjbnUylH7LkrCEr5GpiCsrsRGMBKtL
         p7efVyS2fOusA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SFSr83Vdyz4wcc;
        Wed, 25 Oct 2023 10:26:48 +1100 (AEDT)
Date:   Wed, 25 Oct 2023 10:26:47 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the perf tree
Message-ID: <20231025102647.321c6629@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/BZy762ij+VMO.FPiSO4p/30";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BZy762ij+VMO.FPiSO4p/30
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the perf tree, today's linux-next build (native perf)
failed like this:

perf/util/pmu-flex.c:1812:1: error: unterminated comment
 1812 | /** Setup the input buffer state to scan a string. The next call to=
 yylex() will
      | ^
perf/util/pmu-flex.c:550:24: error: 'yy_fatal_error' used but never defined=
 [-Werror]
  550 | static void yynoreturn yy_fatal_error ( const char* msg , yyscan_t =
yyscanner );
      |                        ^~~~~~~~~~~~~~

I don't know what caused this, but the above file looks fine and redoing
the build works, so it may be some timing problem when doing an
incremental build?

--=20
Cheers,
Stephen Rothwell

--Sig_/BZy762ij+VMO.FPiSO4p/30
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU4UrcACgkQAVBC80lX
0GxH1wf/Rw9gR2u9JuSElF66t53yQqutonKkCOkzOXufVdBmguf9B4kdO9gBNTo7
HKDOe7v0AcyBxQ4T6U+YnHZfUY8cs41AMP9d5JmH7KGr7BMotUb/T0Er00pXJxVT
2q5dWb0hR2B4G5UiNw6GfW0dM/snY4tcD8XGzSzyUXf736pFFrkFeav7Mu8hQRnr
zxCm3uwWoMFe6zy1KVaUhA7SS+NeLNMtUUGmJCfRPWjYr87A6iRtWJazo2Q8ki5b
/LEJpu1DV4NW6wZ8MTQzymqDjUBcN7t3p/MKpq7qSo6Kp3kBWq5n4mdk3u6B5ojj
4GXlaiV9y4AEXLzFuKBFlULrC/RFuA==
=kbyP
-----END PGP SIGNATURE-----

--Sig_/BZy762ij+VMO.FPiSO4p/30--
