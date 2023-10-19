Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA877CF17E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 09:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344865AbjJSHlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 03:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232829AbjJSHlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 03:41:13 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CE0B6;
        Thu, 19 Oct 2023 00:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697701266;
        bh=Nfv6UJyDAKKCrkkKrL3f0AKIlrVzlfpOWkPNqFh/Qdw=;
        h=Date:From:To:Cc:Subject:From;
        b=fEaMkejOmaHvYo0GhP13LTyx3EXWZY9LTIsrSmWmLJQwd+FLeDIwvNLwdBKCAIobn
         Xb6shwSdEQc9qWHoY+GgvF4H4H4O25EWS1ZpbRyeRM6/fUud8CS8/7MHO3Dm3KHilJ
         ACzwPFo6cP1wlAQbJK1pUnhzt3INUBzEqD2radZd3RsQkLRg61z/aEUCS3CyLWoA7u
         X0pmUDNEPtoB3vELvwoJpw5pQDg0st3+v4HqHOTUY/OOnagEN5UjHoqIXZuAPOZIS0
         XKkez6VTM8NANiVGTqH4gGdMoNS4JssbGlGRwD+HJG25DDiGBZ8jpXbGTPBStgrfau
         j2+eeSAUzAy7w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SB05G2T3Kz4xdV;
        Thu, 19 Oct 2023 18:41:06 +1100 (AEDT)
Date:   Thu, 19 Oct 2023 18:41:05 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the bcachefs tree
Message-ID: <20231019184105.57fe31c3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5kHvYzuhCrYrnxASXPTlQx4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5kHvYzuhCrYrnxASXPTlQx4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  2b31fa6b0a68 ("bcachefs: Make sure to initialize equiv when creating new =
snapshots")

Fixes tag

  Fixes: https://github.com/koverstreet/bcachefs/issues/593

has these problem(s):

  - No SHA1 recognised

Fixes tags are expected to reference the commit that this current
commit fixes.  Maybe you could use a Closes tag for
the above.  See Documentation/process/5.Posting.rst and
Documentation/process/submitting-patches.rst.

--=20
Cheers,
Stephen Rothwell

--Sig_/5kHvYzuhCrYrnxASXPTlQx4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUw3ZEACgkQAVBC80lX
0GyLCAf9HI2O5C9TuRldxAwN48RBFm0z3YWBWFis30+2FGWzs5UldHzQro5ruR13
rM1Eowey3Fx7CNTqHt/iVk+1jBTT0FErTxOlrl8mdiqaRh78oBGFtVkGf7TixaxJ
uFzjJTl79rFDAO4iidz6RVYUQlio75Ibmv/ME7cDB38W4ZVPdRMX52dzhZfp7aK8
elZc38hGS00GNwHtIlvyCpzTzNO7k3tuhVIV96COiv0Zv7Trz9yfQ2GoIgaablnQ
jnlWDz5f2iyXkxfmcVioa47hUKqa9cvI0nF0nz2J+Ve/R6j58rn+5FtDHzcYkJOs
XeGl9kMB/iFuVtM1BeZMiKB/esi82Q==
=vj5d
-----END PGP SIGNATURE-----

--Sig_/5kHvYzuhCrYrnxASXPTlQx4--
