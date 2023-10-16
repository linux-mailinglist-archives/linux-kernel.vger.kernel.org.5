Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9787C9D7B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 04:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjJPCmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 22:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjJPCmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 22:42:08 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EC0AB;
        Sun, 15 Oct 2023 19:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697424123;
        bh=88r6X3PDk50GyXQgZtd9PuXNokzEl+ItNURNOh41nBE=;
        h=Date:From:To:Cc:Subject:From;
        b=i+RJLSGNU6tvtokGRy6TFLRwhi5KG2x5iCfPtNqj3TWuHrriJVR3Gl4dVHOXXFj24
         6nzOK8AN+WfhLqoUm3BMzNjDh31ULU5WzJ81jovT9V2st8E+3VHGn/GVVGmGroORvN
         y+vXLwNOen/fRYHjNvQ5oHrd7+lRpzDDj+HvHHKo6/AmEy1WdOgIoWO0LW5byr1YkB
         Mf8IC3h2lgPhf2PkL1iGOE6Wh3aLXddHgMowUhi5WNQrGn/XKhlK/Ysr8ibiMGG5kg
         BOBuTcA/JV3117gYllZQjGhGFOdB6Cw6YbdonwC4oPSuAviZylYj0rnYRijyIRWuCx
         Yv0HMpuxcMiDg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S81bZ24X1z4wcK;
        Mon, 16 Oct 2023 13:42:01 +1100 (AEDT)
Date:   Mon, 16 Oct 2023 13:41:59 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Greg KH <greg@kroah.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>, Wentong Wu <wentong.wu@intel.com>
Subject: linux-next: manual merge of the gpio-brgl tree with the usb tree
Message-ID: <20231016134159.11d8f849@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/29hwr.bLS4F.SScvmFOrI4.";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/29hwr.bLS4F.SScvmFOrI4.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the gpio-brgl tree got a conflict in:

  drivers/gpio/gpio-ljca.c

between commit:

  1034cc423f1b ("gpio: update Intel LJCA USB GPIO driver")

from the usb tree and commit:

  da2ad5fe2292 ("gpio: ljca: Convert to platform remove callback returning =
void")

from the gpio-brgl tree.

I fixed it up (I just used the former version) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/29hwr.bLS4F.SScvmFOrI4.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUsovcACgkQAVBC80lX
0Gxrrwf+ONTK4m5eTlr5sxpiSwCMAN1+Q5x/jwgNG071VDejv+Y7yyOn49Q3eK/u
wBwimZBQFn6M8fg3j2S+vDWuQjCrlHvb1ewwuX9RuknGUKlMQYqtR5bWJtP7tl1R
Htr5jB8HDGsY9sZXQ10QAD+mpWOmhTbd4uynrAsLDBSA0I1dknogWAKeTPhwz276
hvstMAUg2B/ZeHWbe2fl4BQtp7oDz1cqYlP1N4mWzJsAfg8Z4riTAmJRk/k6awOi
8hagOzjgeSqRtxH0/PNazpXJ8W+m8gqFM2JQiEJrNH+npYUqF0cYJqapDFXRd1iV
7cxgDkRsMI1vkYgu7fNXPOlG0MTWoQ==
=/gHM
-----END PGP SIGNATURE-----

--Sig_/29hwr.bLS4F.SScvmFOrI4.--
