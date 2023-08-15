Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B388A77C883
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 09:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234878AbjHOHZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 03:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234873AbjHOHY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 03:24:59 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854B2170C;
        Tue, 15 Aug 2023 00:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692084295;
        bh=WVROmxHmcXHm9z36Ot89dVtDUF9kZWICXVlnnzdqtbY=;
        h=Date:From:To:Cc:Subject:From;
        b=n4Txwx26ZnjiunkoTebpKkdv1r2KvZrAxpLc1+nfCrGDDl6HPEF0+WvsMddldGUk4
         OS+PTQK0qrZoZuTgg/TgpE+fYdmr3brewcEC/JhJWb+teLUSoT93RG/hYHjdNysS3K
         zsrelzNsllRx/L1/GkfvYOeZHZIQNn9DQj7jUA5c3e6RYDcoHtoThcWkwLkbbFuKlz
         eJUBcUbQ0n8BCl545Lh0lEaB+iUv38uq+VzQVDNI9yGF2ptZmwU158agTiR/DklAwV
         SvRw6Q+XhLy0D/Vxlz5a4EvPV6Vg1KPGDbnIKzLL88dqA5VV58izgpF/Q4BtrPt5OT
         uTFqdrhFzUT7A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RQ2pb175wz4wbP;
        Tue, 15 Aug 2023 17:24:54 +1000 (AEST)
Date:   Tue, 15 Aug 2023 17:24:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Ripard <mripard@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the driver-core tree
Message-ID: <20230815172454.138a386b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GV5=6m781WIX8U9LZaZq3bS";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/GV5=6m781WIX8U9LZaZq3bS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the driver-core tree, today's linux-next build (x86_64
allmodconfig) failed like this:

ERROR: modpost: missing MODULE_LICENSE() in drivers/base/test/root-device-t=
est.o
ERROR: modpost: missing MODULE_LICENSE() in drivers/base/test/platform-devi=
ce-test.o

Caused by commits

  06188bc80ccb ("drivers: base: Add basic devm tests for root devices")
  b4cc44301b9d ("drivers: base: Add basic devm tests for platform devices")

I have used the driver-core tree from next-20230809 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/GV5=6m781WIX8U9LZaZq3bS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTbKEYACgkQAVBC80lX
0GwJ8gf8D9poKK6wW1IRp6EFtAJIb9Z37x1mN0JlQLC+TGmDsHSFPI975LXrMNy3
dOCll2d8PrSvwi0jgFAl1en0e8ZMqhkUSSrsudtIPczOERO+LNqpnqH8Z3ikn1RB
8anEGNgiw2ab4QufeREFbcsHPAQNXvCJigJJyAKUffAfu2PtTh5C0t39IVtxHZOt
B7upZArfF66MHBfcnlVRO/UboO4mKIf8gextGRcArJ6rJuH4yJG4Y4TSMFsquzwX
/ezhu5J0e+dD9fyLALXNbfFiMI5UYkdyc4BYCyGdg93n3GKoAz1sUtEGMZAvIeHD
iZdNI6RTYfJeM0+m5sEwikeYTkLDQQ==
=SjAV
-----END PGP SIGNATURE-----

--Sig_/GV5=6m781WIX8U9LZaZq3bS--
