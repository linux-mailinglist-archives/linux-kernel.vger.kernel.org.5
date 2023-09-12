Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597AB79C61F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 07:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjILFDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 01:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjILFDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 01:03:00 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1053198C;
        Mon, 11 Sep 2023 22:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1694494957;
        bh=X042UORL7EMfCugIAB+lsMZTtZnLrw1UoZ0/PnMHchI=;
        h=Date:From:To:Cc:Subject:From;
        b=FvqJYbfUpW4uO4ldv2ukZ1x7Qy7g4ibuxqP0lKDtNBnhN1sGXQPqoewpWDW4SaC1P
         XVt5K0b77VLuShQY5ZFXx26ROlqie4L3e2OHVO0Fk68cD7fqJxlfPAH2LgbXO7vV+3
         Vym0xZg80XVVwlv0maRgapN1BatdXCw46ej66OPlopgkHwADDHwFdPG+NlczUUJ7Xi
         qBFGQU7USdu1YBELmD+o6jLmzyfcDbH+JbUBJSY87oNlL4m874sTray1hgmBIBb8pY
         b3LRBqATc3PAOGdUq5IlHTwy4V7TRZdK5WBExyqzxo+6AjGqltlvaYS6vrtwZS3zdx
         AoGma1OSUZFDQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RlBKT0T7yz4wZw;
        Tue, 12 Sep 2023 15:02:36 +1000 (AEST)
Date:   Tue, 12 Sep 2023 15:02:32 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the bcachefs tree
Message-ID: <20230912150232.1ab82094@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/TONFZer5ekrW8Hy=KMdLPrK";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/TONFZer5ekrW8Hy=KMdLPrK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the bcachefs tree, today's linux-next build (htmldocs)
produced this warning:

include/linux/generic-radix-tree.h:206: warning: expecting prototype for ge=
nradix_iter_peek(). Prototype was for genradix_iter_peek_prev() instead

Introduced by commit

  f39d409a1584 ("lib/generic-radix-tree.c: Add peek_prev()")

--=20
Cheers,
Stephen Rothwell

--Sig_/TONFZer5ekrW8Hy=KMdLPrK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmT/8OgACgkQAVBC80lX
0GwaHgf/eK4bAbZM5b+xaxEKWQ39UFobEQe+YhN2li9NT+dDwY1036CrQBHcNp7T
UeagrXhhsLz5rzE71Qcrb+G5ZcgOzD4XsiQbTrqFdUjez3n6yJGV1k4FUji1u18i
K6khPL3VPSo8+ljpjrqQ06jQ5h9O3jz4hEeM5fzBMWBYIel8HV2//V3m9h/XYJcr
BFxOq04Ith1N2gjThuSr5ClqgjuBfK0Ta7vAxvCg+9v4k4DGH5OAQyeQZj/ladaE
Qh4vlZxn7bLsupdmD+mWvKMlNQvrt+mHR3+b1yiNnk0tQBbSWuCNwmo7QfP7p6lQ
RNvKakR+v9MfVbvK6hDz+HrPlJNGPg==
=By8d
-----END PGP SIGNATURE-----

--Sig_/TONFZer5ekrW8Hy=KMdLPrK--
