Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A934A7A1227
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 02:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjIOAGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 20:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjIOAGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 20:06:34 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4361B2102;
        Thu, 14 Sep 2023 17:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1694736389;
        bh=6uepvn+0kPmSsa3u5o4/Rmc2yEylUDIxsfEFYBN6Df4=;
        h=Date:From:To:Cc:Subject:From;
        b=QfZzhX3mm6DjYj07CQydjvYN/+UHkDloJl+xDvtK7Qb/jd8x1f3ALiZQXeuvCczQ4
         57pLDdA7FMeVmpA7a/HdCQB+09Nx3+6CwLmYawE6UPXjJaIQckl7cukIpTsEdD15aY
         XsJo2XBXEw30RmJGHk4gE+XP/eJmg7zLbm6DbhuxHvL0nM0+qWsYhh2GT0BVN4HYJc
         tHoW6dSmcdsgAVz4GIwyjV9qxAXHb1kPsGdFaAQTTx5PEubGiNitqfLnt+CXmHjI8g
         TEBEJW6ofVo8YIzaMI+b47AuessotsR4XdfRrKgvDncU1Xa1hcC6feWfhZfVWtv03E
         S/qGeWncw0V0A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RmvcN6c1Jz4wxR;
        Fri, 15 Sep 2023 10:06:28 +1000 (AEST)
Date:   Fri, 15 Sep 2023 10:06:28 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alasdair G Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Cc:     Joe Thornber <ejt@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the device-mapper tree
Message-ID: <20230915100628.6eaf7f7d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+fM5AV0/waNAFUI_6yrhWgD";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+fM5AV0/waNAFUI_6yrhWgD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the device-mapper tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

drivers/md/persistent-data/dm-extent-allocator.c: In function 'dm_alloc_con=
text_get':
drivers/md/persistent-data/dm-extent-allocator.c:530:31: error: expected ';=
' before '}' token
  530 |         spin_unlock(&ea->lock)
      |                               ^
      |                               ;
  531 | }
      | ~                             =20
drivers/md/persistent-data/dm-extent-allocator.c: In function 'dm_alloc_con=
text_put':
drivers/md/persistent-data/dm-extent-allocator.c:544:31: error: expected ';=
' before '}' token
  544 |         spin_unlock(&ea->lock)
      |                               ^
      |                               ;
  545 | }
      | ~                             =20

Caused by commit

  59d814674dd6 ("dm persistent data: Introduce extent allocator")

I have used the device-mapper tree from next-2023-914 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/+fM5AV0/waNAFUI_6yrhWgD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUDoAQACgkQAVBC80lX
0Gzc5QgAnJ08z0nPQaIzcuGQjmY9Tg67j8MyyLraHzTNjZ1cdkF6oSN3QMn5TNU1
Nh5pX0IGtVypeZ1+EVinTIG35v1U4A0XPdpcBwJY90QthYZnTZIhXGexkdn7SLG7
8hRwAKx7Nva8x2pPrUSsuJXgSTlRSLyKqo7ItKByp3SoF5fQNdLnFA5u3RE5nlOm
LH3sCAoql2dn4ugMFWNwjKAFJNZmEXVCOz9Bma+amxfhdEOzWFqYEvyrIi3QADVf
PgtllkG21zdvOmo1lrnllNZ7G66fwvePAJo6yBGn1vntVwCE5mI6wIF13OJyxy9P
yItWMm08WjUFwgRP7qx7Bu7Tq5Lu6Q==
=tUzy
-----END PGP SIGNATURE-----

--Sig_/+fM5AV0/waNAFUI_6yrhWgD--
