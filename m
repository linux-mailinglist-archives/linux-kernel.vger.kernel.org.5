Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DD5786373
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 00:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238685AbjHWWgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 18:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238694AbjHWWfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 18:35:55 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FAAA8;
        Wed, 23 Aug 2023 15:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692830151;
        bh=nDgzbVgzmc6B9Q8dUTTGYttUONiog/2nKBusHVObnNw=;
        h=Date:From:To:Cc:Subject:From;
        b=mcxV8AclRj062vorxpbrv6LzHiS6FADiv++w1dFeeJakiyUgsL8ZSBDK8IByGqUmF
         7/NZcI1UF4DsPyUgRDgfXVA7JVj/3roMmgZ47vrHsWvd57cC+kF/QSNzRd6qwfGWDu
         g10FW68pF2ojqBIWExe5/5qugFGQrTDHVO7ozkoJLlRnipQN+jw3jysfnlH1TBR4J5
         mNWC9/CX8gbYxkhghIgg4+pOWwFr8urA8FugSmq8YCUrULDNYOECIsBM+A/Gc/INi2
         3w3dBXd7cLgUliXRiNNQ5Uat1UeKJqSlaRfLGCOTsutDZ5LSIeqEl78nV9cxP+aedv
         mkG0U4sCaY2sw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RWLdz49gNz4wb0;
        Thu, 24 Aug 2023 08:35:51 +1000 (AEST)
Date:   Thu, 24 Aug 2023 08:35:50 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Asmaa Mnebhi <asmaa@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the pinctrl tree
Message-ID: <20230824083550.49539f4b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/74d.IU/uf4wU.el_uk_XVH=";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/74d.IU/uf4wU.el_uk_XVH=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  28042b2a1ec3 ("pinctrl: mlxbf3: Remove gpio_disable_free()")

Fixes tag

  Fixes: d11f932808d ("pinctrl: mlxbf3: Add pinctrl driver support")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/74d.IU/uf4wU.el_uk_XVH=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTmicYACgkQAVBC80lX
0GwB0ggAgnh8/jmGtgHjkP5QPb82+/kVTfksR+YDAZ6fNxIZ6XClGq3oLaJ1f4pZ
AQ1GCEvO+yy9GHrYU2x8hWQRpdY85+PoiLUEZ2D5G0jFxIQH0PZsTtOTjlzR+CKH
NB56YxKvhCO9GAlIefnzYuG+t+e74RnN6pOe3Ulr4Yx9vOnC7mVVeWyTidzdzs5M
iGf08mRyVhTnN0uds6y48SEXIZ7N7CcPXtbdeRtA582xgcWIW74aSV+1XazUNw7j
bNRr/cmm/a0s/ZadX5+YR8UXC+pQAHRqf09o5KXe8/nHUvgDClK8fKdtq9W6FUzb
aUxg1Sx/Uv3DxJ7JSBuyMK/Wf3VZ1A==
=IiYE
-----END PGP SIGNATURE-----

--Sig_/74d.IU/uf4wU.el_uk_XVH=--
