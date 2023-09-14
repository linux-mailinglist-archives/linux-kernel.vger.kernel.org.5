Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3527A11DB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 01:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjINXcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 19:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjINXcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 19:32:23 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730E71AE;
        Thu, 14 Sep 2023 16:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1694734338;
        bh=eUWIG1s5BYy4XyEX38uS42u7StqIJ5olVlOcN4LhB+E=;
        h=Date:From:To:Cc:Subject:From;
        b=m39VrIb0sCejauUWQgHfa3TANQ1mrm3VDI8e1ykkYBOE6fl6Y9Wa8M+LcKX/7ivBb
         0QsRRy0r1PzbG21sYhHQpfDqzUUip2RjDbN8js3IH8fHdaFL+gtoT3GaFqM7j8kXL+
         4AsMU1iULIkRIfvUJXep2x6t6iSGBNTdhG6rVBY/fQSQYN+CqicsWSoYza8kmwN1bR
         fSbvdiRc4KHBQsSYUnciOErr7HneBw4wjr6Q7T/wgyEMeqjfVmF6orkJSL1fUc8MtZ
         Om9y/SFpPyJ0Kv4GfMnY156ue+btelqmjo1Iie8sHMfIiZKY3ju5prrY03Y57ekLWS
         BIlN6iggHanDw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rmtry01HMz4x3D;
        Fri, 15 Sep 2023 09:32:17 +1000 (AEST)
Date:   Fri, 15 Sep 2023 09:32:16 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.cz>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the btrfs tree
Message-ID: <20230915093216.3fc19bd8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/VHxI9Oqo.fa8Xafcy.+8gOV";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/VHxI9Oqo.fa8Xafcy.+8gOV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the btrfs-fixes tree as different
commits (but the same patches):

  5801ee67a0dc ("btrfs: fix race between reading a directory and adding ent=
ries to it")
  e663f5e72c50 ("btrfs: fix race when refilling delayed refs block reserve")
  418040f46bf7 ("btrfs: refresh dir last index during a rewinddir(3) call")
  9c053ecc08e2 ("btrfs: set last dir index to the current last index when o=
pening dir")
  aa97c8e4f2ca ("btrfs: prevent transaction block reserve underflow when st=
arting transaction")
  8e7f82deb0c0 ("btrfs: fix race between reading a directory and adding ent=
ries to it")
  e60aa5da14d0 ("btrfs: refresh dir last index during a rewinddir(3) call")
  357950361cbc ("btrfs: set last dir index to the current last index when o=
pening dir")

Some of them are also duplicated within the btrfs tree itself.

--=20
Cheers,
Stephen Rothwell

--Sig_/VHxI9Oqo.fa8Xafcy.+8gOV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUDmAAACgkQAVBC80lX
0GwusAf/SDxDhOCG4yXVA4Kcb10VbV2yVCX4p5+e3I6gfiQwp1yx2+XzB04kgKNW
9ueMXEhY0EFXf2JRCrUF4euzSuuLaINLpccMXMdr8C4rX2FKfmel7ma+1yZAnW1O
cupoUfqdLXy2fvZVumZiIcPwBHPCCTn1G8nRm1k/3BytuxfTk53ZyVEeOBUekTVw
R2BhY+jTXePGo7oKHp5E9jYJCUsIo4hM/Ti+XbhQW7mAbQvOVtRVia0t0qM56eY1
3t3LKFyVa9UXqtArHtz7k4iAW3JNosNqcqMvdjNnOKjLPj1/hiKQjQ0GnYibUvzX
xWvRLqduVt8ybOhFCGY5TN2dJqbt7w==
=t9F0
-----END PGP SIGNATURE-----

--Sig_/VHxI9Oqo.fa8Xafcy.+8gOV--
