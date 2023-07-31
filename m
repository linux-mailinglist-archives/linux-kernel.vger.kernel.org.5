Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62007768A80
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 05:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjGaD6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 23:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjGaD6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 23:58:19 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F48AD;
        Sun, 30 Jul 2023 20:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1690775896;
        bh=MeLLwg7NtC51pUH0tkJRisJExxHLv7iXcYqosGvk0pQ=;
        h=Date:From:To:Cc:Subject:From;
        b=s/Dz5dE/OHnoREwN5UtyL+B4GH5ET79LGTTZvnGtwRg7AKfxevXLOVonAVBCeW80y
         GcnBgH4g5wXsX117EkIjzzGCCXufKZ2is3Ud24U60BGg8fTEI6xVNc66maA1JnMweV
         mdgZziSipKdwV0LBbZSSE8alXARComM0dOAQIXOFn1xDpV+pojEde3+F15O698a0Ma
         Evyn3JuMrJJ7dNqpATf7wmw/oFkDoO8j8+W0ghyQ/ZN/UvHskvaEfCX6/aCc8XnCX/
         W5dDIfHUqBwW3GpKRlEKQ2oUzsMP3hWDcfQp6DLkCXJKmuF6/iWw0RHvN2WFjYuZb8
         LP5rQqSr9OVPA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RDkx36Mpqz4wqW;
        Mon, 31 Jul 2023 13:58:15 +1000 (AEST)
Date:   Mon, 31 Jul 2023 13:58:13 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the vfs-brauner tree
Message-ID: <20230731135813.1423c4fe@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LvQdkfjq9FTHFs8=aaKoYQM";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LvQdkfjq9FTHFs8=aaKoYQM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the vfs-brauner tree, today's linux-next build (htmldocs)
produced this warning:

fs/stat.c:79: warning: Function parameter or member 'request_mask' not desc=
ribed in 'generic_fillattr'

Introduced by commit

  0a6ab6dc6958 ("fs: pass the request_mask to generic_fillattr")

--=20
Cheers,
Stephen Rothwell

--Sig_/LvQdkfjq9FTHFs8=aaKoYQM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTHMVUACgkQAVBC80lX
0GwNCAf8CwfiPwJxCrhQwgK3gjLa497OeXlTAaauDDEaAMS68hpPN+Edgrf+kkHG
HSdwEFAc6zc4EZ4kEv0AL8ZZ/1nFQw5B+0N1wlzW4Zb+kwiBPUzHe3QQ8kkmZLUl
aO2YT4Ykh3A3Rr+9ifjITFERlMAcP3NSQSqZ+b/DVPke6ToYX3nE8y+7vrJT5duB
+GkuCvkJXlQHK+ZtOqc0dGxVTs6acvHeGPfPy7lqUj7d4cjUGYWpCwiE29Cb9AoX
H5cDI1F0Id/zSvEkMsb8/DvxaCn2jlZ+Otvj8w9KvbaeH7WVMNMYIM4eG/Lakaxz
D65K/8mBEb8RoLIn6rQvJSAvrMupgw==
=KVCF
-----END PGP SIGNATURE-----

--Sig_/LvQdkfjq9FTHFs8=aaKoYQM--
