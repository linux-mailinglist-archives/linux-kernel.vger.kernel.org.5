Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E8F77C5BF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 04:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbjHOCQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 22:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233989AbjHOCQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 22:16:48 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AE4B0;
        Mon, 14 Aug 2023 19:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692065804;
        bh=RbPJKD85sdXvV/JOwBisKKoBIXJ6GbBhJ++W7MfDoYA=;
        h=Date:From:To:Cc:Subject:From;
        b=DJYWhSBrncHtgj3EKz74BGZQrXoJQ7QDXFpbYz0ICrFb78JQlvnKoj3L3Y86OgbzU
         8/Mmh/euJ+5gRp3zPRumWqFbrzEA6gzuzsMy2IptfLI5BGC2+U6WEJ9sEPjc2jzSx5
         CYtC5xVf3MerUlFhefgkN1XQTHa0whY0CbyNVxsjm0bWBt+fdA7m7hekxodLJaBhTu
         yDGd4JcP7z8zAVqUEFPMx5fEIUotE6/ivXRrxFUsGKXLQ1jwIY64e+jeX3etO/lu0i
         5jiz5lPCWZSO9FJIdZtsazR/q2TPIc2rpCyf0OAuvt+BKDWUZ/svc4XIP/Skdqq4di
         8aB5WQrW6SBDA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RPvz05fj0z4wb5;
        Tue, 15 Aug 2023 12:16:44 +1000 (AEST)
Date:   Tue, 15 Aug 2023 12:16:43 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Wolfram Sang <wsa@the-dreams.de>,
        Andi Shyti <andi.shyti@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the i2c tree
Message-ID: <20230815121643.047c564f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/v.cuq5c2nUXKHBozJtcdz.6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/v.cuq5c2nUXKHBozJtcdz.6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the i2c-host-fixes tree as different
commits (but the same patches):

  27ec43c77b5d ("i2c: tegra: Fix i2c-tegra DMA config option processing")
  3253f6923a78 ("i2c: tiny-usb: check usb base class before assuming the in=
terface on device is for this driver")
  49d4db3953cb ("i2c: designware: Correct length byte validation logic")
  69f035c480d7 ("i2c: designware: Handle invalid SMBus block data response =
length value")
  b610c4bbd153 ("i2c: imx-lpi2c: return -EINVAL when i2c peripheral clk doe=
sn't work")

--=20
Cheers,
Stephen Rothwell

--Sig_/v.cuq5c2nUXKHBozJtcdz.6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTa4AsACgkQAVBC80lX
0GzeXgf9FcKYKQpceyPJITZPOJ/jaJuIp2BoIc+ciLVSV+AYtxBOBgU0wjIEhUjq
3lcIztfcAiC6Fa/PDN74f9/VHSyfLntRjvHq8ygTjSGSgHlJw4k+qIAuIDVtwLmP
7D6Z/Bq65kiYIA4vKSC2QAtQkwUwjJPpWKVJsf28k74GRRhzDU4nCRA7PUsBJGcE
gf7D+tVT2cEa0Il0AK+cEzOp3KARixu54o0GjwVd6LPSW0fGV8EWAgtwQaCCO7P3
UdFu6lzve7Rg6c5hDxn3UszI1GMxiQ9RFgrG0y7KAkWEkfy2vPwnFulmBY0XtwzB
pxIIIhrdA0NLKXLT0JryQz2eAQP4mg==
=/AaF
-----END PGP SIGNATURE-----

--Sig_/v.cuq5c2nUXKHBozJtcdz.6--
