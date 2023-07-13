Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E8F752D18
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 00:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbjGMWig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 18:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjGMWie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 18:38:34 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74728193;
        Thu, 13 Jul 2023 15:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1689287906;
        bh=k4XnIjK6ebSg25IbLY00UEGSy0HK0hpFaLKBgGTASgM=;
        h=Date:From:To:Cc:Subject:From;
        b=ABg3rhbosuWojfqdeoJjZY8FGkzCcnexZK7Ba7ggPSUk36aDAT3UfAci8XmkAzf2S
         8ntOaGaTNfw2Qlgtnj7Wy3pbkRrzEmNOt7ORAUTjMA5/9V9F7FeFuxrL/ofcM7Zx+3
         lzJgwWywzICXhgL8QSzZebbDhScMM5A8/stacduYbZII68MqbDX7STunQf+RrhNzfF
         sRzNS3xDJB+X3JYD4m4CJPeqmopbvJtHFImr9Jo9KXWgQEOpXQ24MKFM9ZJZ1gV9t/
         /drk/xS2N8BGceW3TFpW+15BgRANdQ2y+/6+fvsvYr4DuH8SiDwYaq2D2OsVFtePg+
         P5P2GGap635Dw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R28dt1Ddgz4wZw;
        Fri, 14 Jul 2023 08:38:26 +1000 (AEST)
Date:   Fri, 14 Jul 2023 08:38:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the v4l-dvb-fixes tree
Message-ID: <20230714083645.4e587f71@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fCKO2jLwqjLHmn.sDCkD3kx";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fCKO2jLwqjLHmn.sDCkD3kx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  b0b43354c345 ("media: tc358746: Address compiler warnings")

Fixes tag

  Fixes: 80a21da3605 ("media: tc358746: add Toshiba TC358746 Parallel to CS=
I-2 bridge driver")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

Also, please keep all the commit message tags together at the end of
the commit message.

--=20
Cheers,
Stephen Rothwell

--Sig_/fCKO2jLwqjLHmn.sDCkD3kx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSwfOEACgkQAVBC80lX
0GxZtgf/ZBmJAhX0ZcLFZUvcbnA+XtNE/kcMEAK5Ht31YZ1KlH963VWz4PNeBPIK
sxWYSvxOJMP3EA9I88YEX1dITBT5VXeqOuLpK/BYYW26mvHln2/R4Hwtoej7UY4d
V2pyh0vBQWXx75bED0C6R+G5nbytDJ5H904E7CFaKGX2cMUsbWVCLXbyRgZNBdqi
1ocrbk4r0YyhU3ped1bWwxlTUtXjrwMkAEUHE0Wuqbkmx1jin+pmt0RDXmHhNPkH
IgQYizWUtWjmgBrhw0Iv06Xyk2MLga0RHFdDYeV6Y6NrvVLAQFn1A7cRxA0w+0nV
VGvF6T1qStwjL2W2GoleoMXSWMGqHg==
=ZDdO
-----END PGP SIGNATURE-----

--Sig_/fCKO2jLwqjLHmn.sDCkD3kx--
