Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF73D76C406
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 06:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjHBERi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 00:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjHBERg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 00:17:36 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C986ED;
        Tue,  1 Aug 2023 21:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1690949848;
        bh=69JA6VXWUTgRLsz7PxBrqQSG1C41fIAroKeeuYqPBqc=;
        h=Date:From:To:Cc:Subject:From;
        b=Ix4GB1iGSA5v2hQt51sg4ZZSd1w6BysdUfinwzuEvhYXjLteFn3ME6HJnO3HIv98z
         IzfDcEegzXSlU4gJyPhevVsmfZydi7MQzcsU9Ek81kKLZp9CdQUtx/3QKiFg71d8+T
         3LookLThfbLkPnvWW5vCuG6pPsFE6apRHdN+Xi2uCmEJg6q3U+GA+fHTDfEWnC5gxl
         40YN418ZrHzfC2iuI7Q21+mIJAF6GgmpTFlp7nsRXWXCLX4V8UKHkk8cBBXjc8FgWP
         xVAxROqm+PmRBGdS+ZRD4mDsH4m2Gi8WD+63mnxF+bVeguw7L+Y2cgZjqx3DC/f5ZH
         9Dl9euqbTnLbg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RFzGH2GFtz4yMF;
        Wed,  2 Aug 2023 14:17:26 +1000 (AEST)
Date:   Wed, 2 Aug 2023 14:17:24 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Douglas Anderson <dianders@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the drm-misc tree
Message-ID: <20230802141724.0edce253@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/uw.=bM5hs7oyf8sUtMa/5lE";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/uw.=bM5hs7oyf8sUtMa/5lE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-misc tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/gpu/todo.rst:469: ERROR: Unexpected indentation.

Introduced by commit

  d2aacaf07395 ("drm/panel: Check for already prepared/enabled in drm_panel=
")

--=20
Cheers,
Stephen Rothwell

--Sig_/uw.=bM5hs7oyf8sUtMa/5lE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTJ2NUACgkQAVBC80lX
0Gz79wf46U98cGjZLm5WmRE/ttBYM4yp713DtPACxadrudWtjCksTlQXOTIlkwt4
WpWXBDGhNaI5belvGhQV4zF/4vTisKpat5ofUMqpkP31uy/e5jPNEV53OmOMAaP3
Q1QBMYlIlTiFuoVLhBfNzoi1Yj9VyFAUkv8gvxqR6SJ4WJ0OFZNZQ/cDhL957NPt
c3NHjyXmJ60E0j3Fxkv57/+8T6IukyYqagpJz4deKPpCJycIUH7/9jJgnGJ0O9y6
cheIXy9CYBeodZNH+WdY+VhG0LFMW4gN5YUDwLrWpYM4PVGDSppWEN+jVpBINE30
a7sZLV28Ru7eIrNkRZqYm5awxn/q
=hhRa
-----END PGP SIGNATURE-----

--Sig_/uw.=bM5hs7oyf8sUtMa/5lE--
