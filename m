Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C32377EF8A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 05:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347855AbjHQDbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 23:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347853AbjHQDbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 23:31:13 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B18A2D59;
        Wed, 16 Aug 2023 20:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692243068;
        bh=6B5v6CnVWiOTuDsYHYyyAGv4lC31pyW4NkX7OYNZpgI=;
        h=Date:From:To:Cc:Subject:From;
        b=bTqzJn4MRP5bPayzXg4mqb/Tbv73YnE+wH4fvj5usGbay9ELHxfxO4aISkManiP+t
         9Pv4+iFRGHdjq+WELg6LFRcBFl3ekJeAUwEuUi9l2TdzCmk9preTXs5phS6owNFodi
         vfMn1ss80iKyO+srVFUQvRNOqECx39rWkc7aBmGp/8MW/GwHv2AKMpyJqiFn2n6BAP
         BLFyq6XHDGaj3mmJlDwUlFS2uZnLdFfW0FqNB3jsoOv8hFujL8zlpS2XDhtbSDilbO
         5iH68CqQvb5uodspANaA6YA8VtWAGgoPqG4lzF6blkYTBvEF3X4rOgcYX7+Lmy2h0m
         O2i7QJDstqTIQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RR9Ws3hYGz4wy3;
        Thu, 17 Aug 2023 13:31:05 +1000 (AEST)
Date:   Thu, 17 Aug 2023 13:30:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shuah Khan <skhan@linuxfoundation.org>, Willy Tarreau <w@1wt.eu>,
        Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas@t-8ch.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <linux@weissschuh.net>
Subject: linux-next: manual merge of the nolibc tree with the mm-stable tree
Message-ID: <20230817133053.76d9f850@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/IbhPTujlXNx4yrQUYpuzRiB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/IbhPTujlXNx4yrQUYpuzRiB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the nolibc tree got a conflict in:

  tools/include/nolibc/stdio.h

between commit:

  08d959738a95 ("selftests: line buffer test program's stdout")

from the mm-stable tree and commits:

  65ff4d19f792 ("tools/nolibc/stdio: add setvbuf() to set buffering mode")
  2e00a8fc4f47 ("tools/nolibc: setvbuf: avoid unused parameter warnings")

from the nolibc tree.

I fixed it up (I just used the latter version of this file) and can
carry the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/IbhPTujlXNx4yrQUYpuzRiB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTdlG0ACgkQAVBC80lX
0Gy4zgf/SS9eOJgzPLhGkz+XBxQu82+jR+hlcFSB+KtG2q/CAXRMcFeVDkn+d08p
w/rujFSsuLbDw8ozhlL280uSp6nFYfEeB6gut6i14BZ1czo+npCeoNk/NE9lmjyK
kuCRMRXVhdzkMWiiY4BUk3aHqzGmsJaQuAaZKmf+RTAN9ArdtzjElkGG7rjFwiIM
6Mjqm9Gukn/Vz+nvM0Nc3IXQMeXNVCiDVNJ1f2AV11fEtdQhoe9vptKEibjpgoWz
HQNMjEGF/4mzqcFIcJqDfxDi/9HxDitBRvA/RKu8e8RYWWy1oI0ku01Ky8S/TSQ3
uL4xIJpVlmBwIfOJ/gyyL9mibJMROQ==
=kXZt
-----END PGP SIGNATURE-----

--Sig_/IbhPTujlXNx4yrQUYpuzRiB--
