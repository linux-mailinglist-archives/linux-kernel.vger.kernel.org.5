Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DAE771988
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 07:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjHGFpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 01:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjHGFpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 01:45:02 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0C01703;
        Sun,  6 Aug 2023 22:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1691387099;
        bh=m6FA2rBMbm7njQ/kbwsb7fdfHZeDj7qRjTLE8VXj4Pc=;
        h=Date:From:To:Cc:Subject:From;
        b=vKGooG3UgylJs4BPDSPr2jVFJizHiIQgWme57kV0LjnxIhUyin6FX5HKRxcMV6YZ9
         agcOySmLcwsiZ6aiFCQrVGHq2PnTC2ReXgQHzdPTLu8m2rAyo458+dU+3zAcrxo1XJ
         CNsvfPe5XTO9YbyIw9DU7k2F1z33HbqqHGdHrPgVhxskhHZ0R7ewI9YL580We9cqUk
         8jIo1vUabBKGXvbjsFrzmbXiUKLr7oXjAnOnkieocOfI+R4hU8GOtMqZTvZNp7LJBh
         QDcDJr8IKZn9zVPTnbo8OKpg+MjTaFdeKeRBOpmmVF8U27cpDxqru6ORH9d7uM7fCE
         EEqGKCv7gSckw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RK4yy5dzfz4wy7;
        Mon,  7 Aug 2023 15:44:58 +1000 (AEST)
Date:   Mon, 7 Aug 2023 15:44:57 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Baoquan He <bhe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the char-misc tree
Message-ID: <20230807154457.062a8a1a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6I4X7h6gzwNEiexljH54EQb";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6I4X7h6gzwNEiexljH54EQb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the mm tree as different commits
(but the same patches):

  acdbfa04816a ("pcmcia : make PCMCIA depend on HAS_IOMEM")
  aefc8b57af77 ("misc: open-dice: make OPEN_DICE depend on HAS_IOMEM")
  806eb9e4160d ("char: xillybus: make XILLYBUS_OF depend on HAS_IOMEM")

These are commits

  2ef95c7f4177 ("pcmcia : make PCMCIA depend on HAS_IOMEM")
  3650ce6d8409 ("misc: open-dice: make OPEN_DICE depend on HAS_IOMEM")
  420d959a77fe ("char: xillybus: make XILLYBUS_OF depend on HAS_IOMEM")

in the mm tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/6I4X7h6gzwNEiexljH54EQb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTQhNkACgkQAVBC80lX
0GyzPwf8DhJ2XexfbY5YSAkWNM9ynyT0JuKc9xljWktU2jOLYIDeBwXKE/pu+dIh
0S3GufLnUtoIiL42Vm0h3RzOhtUkXsAR87qwraTg/w6QXBitILVigcER6bQtDUfH
ZZnQXEemGCCfvdCiiQpy1TXUF6GKBnu2GRzIxir8j9SmqLprHPxLt2miMJNdo4mD
4GpUKu63lRtidUvdfvB9eCmmCmhWGlYw/kCL9Dm9P1+IzjsTWWW379nxjVZ6uGZg
MMZ3X1TcdB76zIybDbDzblB/0vSBnIbCaewjN+nZakzwOc5Yw7PhtdBbhVWb9/iP
16WgkuUrabXJEBpDDygTu2ygXNKqyA==
=PgYA
-----END PGP SIGNATURE-----

--Sig_/6I4X7h6gzwNEiexljH54EQb--
