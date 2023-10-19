Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBCE7CEFE5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 08:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbjJSGLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 02:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbjJSGK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 02:10:56 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5231986;
        Wed, 18 Oct 2023 23:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697695266;
        bh=qLAkmNxASkcIDfpf2MBjaSSl9HbuFVsFTNTN7+hztDQ=;
        h=Date:From:To:Cc:Subject:From;
        b=PkpWbDcADDZyHm/COT5knKsy2BJ0QS4IBsWlcKGyxbCYK/ms2zmCzSGbKRANN91o6
         JdDeD1YFKMWCPWMj/aknCoc+lm1GN1q74/p8lMs2AtIfo5sGmCcT/Mm7Er5C5CFgSb
         zGM6iZyrn649zUjgLnn+9+J33O0d9TR5pxGbMO8IuHSX5MmcudyLh2c69iA3nf7Yue
         E6LR10fj43X0rX/de+zQ3wCudS/xg+wxyrV2IXXHwC3UAXStY/q7lVx7XkEFEUfoEJ
         adO8KQIGu2tyJU2wY1y9PpvFai2hl6IJ1PxIZeac/7cztGlTxhcmsmXL17nCg2FGzM
         YTWMtqL5WnZSA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S9xst5Qhrz4xbh;
        Thu, 19 Oct 2023 17:01:06 +1100 (AEDT)
Date:   Thu, 19 Oct 2023 17:01:06 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the bitmap tree
Message-ID: <20231019170106.4159eac5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/q72MceMo+b_zmxbLo0UESz7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/q72MceMo+b_zmxbLo0UESz7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the bitmap tree, today's linux-next build (native perf)
failed like this:

In file included from /home/sfr/next/next/tools/perf/util/header.h:10,
                 from /home/sfr/next/perf/pmu-events/pmu-events.c:3:
/home/sfr/next/next/tools/include/linux/bitmap.h:5:10: fatal error: linux/a=
lign.h: No such file or directory
    5 | #include <linux/align.h>
      |          ^~~~~~~~~~~~~~~

Caused by commit

  ed46ac8199f0 ("bitmap: introduce generic optimized bitmap_size()")

I have used the bitmap tree from next-20231018 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/q72MceMo+b_zmxbLo0UESz7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUwxiIACgkQAVBC80lX
0GxL/Af+M5Jiu0JruUBhWgoMM9eGEUdZArLmooCqEAGyAyJE1Mj7Bbp7K+jr33hb
zY3qPm9L01DsLU5/IdxmNqfVuNBAkKwcbXw535mamAKMuGv2aJVniHpJlgfM/4on
ynaTV1Mg0HwFH+0bx4L3obJbGEyVw6w2XW5lHTpiRubDIXSoL2Gj+XPtnRP++QkK
RfV2cGKKOiUtXVZt3VqH/xnzKmru4coFXYs9cc6cMpWqsVh+mR0K5/0M1p6Gj6tu
SDYW2ZDKsU6r3LW405Dc8IPgGR/ZU6eDz1Sq2Uv2C2Lkqcx4fxyRilx2oFXFdwVh
tLNzEeHfGLBUr43xXTz++4qo85H/AQ==
=SGd2
-----END PGP SIGNATURE-----

--Sig_/q72MceMo+b_zmxbLo0UESz7--
