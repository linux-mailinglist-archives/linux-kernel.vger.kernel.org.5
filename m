Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7D67822BB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 06:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbjHUEV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 00:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjHUEV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 00:21:58 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE4993;
        Sun, 20 Aug 2023 21:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692591711;
        bh=CftIs09yf/pwmz1hoN5TS+6593RXp5QcPkjoWjnJ19Q=;
        h=Date:From:To:Cc:Subject:From;
        b=FQXSlkhMydN6++XO549gGeeQAzepoHasPFMT9I+ooSjFBEkiboi6l6qPwr82wfJBf
         DtAuWhhvSduhxoz5ofKE6nOUHiOdw/IgjvRGqCAHf984LKqQ7vlRcvpCh1tzNGcIXa
         TQlmkJJq4rCvBGluXWbkpiRIkxZCoYJbOb/BnbIt+hsAXIeVteNkyduGh4O1rgdE/S
         9TGXMJn1onJ6h5jTJvusHehAL66oHtHmDczexk04v+oFEObegzAGtppZ2XfZZrpEmD
         RYXfHJt+qFe/YqXGGZV99WOcD+PgPhoNmeb52sCy7vHcDfIyqUvnSCGZOKAVyhL79A
         +tnQ59yKmzPAw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RTfSZ151tz4x2D;
        Mon, 21 Aug 2023 14:21:49 +1000 (AEST)
Date:   Mon, 21 Aug 2023 14:21:48 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Jonathan Corbet <corbet@lwn.net>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the usb tree with the jc_docs tree
Message-ID: <20230821142148.14b1b4be@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/sozIqTv3MEBEyWUZq/idQKF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/sozIqTv3MEBEyWUZq/idQKF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the usb tree got a conflict in:

  Documentation/ABI/testing/sysfs-bus-umc
  Documentation/ABI/testing/sysfs-class-uwb_rc-wusbhc

between commit:

  ebab9426cd73 ("Documentation/ABI: Fix typos")

from the jc_docs tree and commit:

  f176638af476 ("USB: Remove Wireless USB and UWB documentation")

from the usb tree.

I fixed it up (I rmeoved the files) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/sozIqTv3MEBEyWUZq/idQKF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTi5lwACgkQAVBC80lX
0GxmMgf/coLXJ8BwL/wEabKUyL5fhgdNqEYdglTKpwSlLQ9l9UTR/1vGhJzUyE9c
+Pc8iNY6ey0ghxy23TLs2AMEjPsYbqpoZpjPLHMQ1b819lTkuX1pyha5T9IIQefr
frWUv02VectWY1XRoAX8msg9++oCK1ScfWy7c4YSTzyanp/Zr8sFt8m+O42XesFe
B21hAXc2AGIPEWISyqvg67UqGwVycaBOtXgjcSCeYVhYbRpHDrY/AhP9+YJWTYKx
CCBo43bMs9s7rRBec8Hn9H+hcVifQkZs0LJu38yIHLOAybnjc17tDSrSNvxa0zdT
rbSG687pnSfuRogtXhoPSh1vc8QMMw==
=mykT
-----END PGP SIGNATURE-----

--Sig_/sozIqTv3MEBEyWUZq/idQKF--
