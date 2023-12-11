Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1661680BECE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 02:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjLKB3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 20:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjLKB3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 20:29:19 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1763CE4;
        Sun, 10 Dec 2023 17:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1702258160;
        bh=ORry25Z5o/8D2R+y4DclrXluDctJV4FlEMOgt6MNs7k=;
        h=Date:From:To:Cc:Subject:From;
        b=a0dg6gWuufHxVVlOP3prS7t4P9O/S0S8DR+Lq0s9dQX6PBKKq6zYDX5ot1F77Ev26
         46uEIRz+sMOgLWhvb9XX1RI67sTN82qS75Qk493pkHzwBEuZTRvx1IUehDqGaPdCzo
         dUDCreAq0ld4WbAwqgKbAKdiWxvN+HOReVlmjM+IbCG94CINmYITqMI+AzcTOoA4pP
         D+JlgxmPZE3IAauj9/OTwft5AvsHnoYwTbTKxo2DygremvRU4esW/D2GsQfjaNmhAc
         ponLHX+7UuVFjBQ0VU9gz23TiFz/LE1GDqheQyQndLQxa/5mB0/fML3gLeeUssP+Yv
         5qrP9g8dI27HA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SpPKq44Wrz4wbQ;
        Mon, 11 Dec 2023 12:29:19 +1100 (AEDT)
Date:   Mon, 11 Dec 2023 12:29:17 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paul Moore <paul@paul-moore.com>, Jonathan Corbet <corbet@lwn.net>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>
Subject: linux-next: manual merge of the security tree with the jc_docs tree
Message-ID: <20231211122917.138d141b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/VHdyE0Ee2I.oPd+91Q7uGKY";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/VHdyE0Ee2I.oPd+91Q7uGKY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the security tree got a conflict in:

  Documentation/userspace-api/index.rst

between commit:

  50709576d81b ("Documentation: Destage TEE subsystem documentation")

from the jc_docs tree and commit:

  f3b8788cde61 ("LSM: Identify modules by more than name")

from the security tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/userspace-api/index.rst
index 93174ffc7350,8be8b1979194..000000000000
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@@ -30,7 -33,7 +30,8 @@@ place where this information is gathere
     sysfs-platform_profile
     vduse
     futex2
 +   tee
+    lsm
 =20
  .. only::  subproject and html
 =20

--Sig_/VHdyE0Ee2I.oPd+91Q7uGKY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmV2Ze0ACgkQAVBC80lX
0Gx4iwf/TWC7G21TDZQHjthHM9Xjt5Kq8T4vggBhw+gFwjgG34ErZQdCO/kAqGzZ
kfrbeammVxfVeWJ61O1/D3ZAhJD8ZKv4YvHx3suX87ymOxeLtD+u2IOmSIku4rgu
hdj1l7rqEJAZ+IKcSsbwVSDwzl1lofvdObi4DEBRZ1xAek6iA7a0vIGdeYr+ChPM
gm1JqZGDnTOsTR9BXlu7arO3jCCwI1tRHR8eDf0d+8gUSWl96i1gkh0GzethA0kq
OpTWqwCnMre5d6Y/UMLP3zzT+VbN+wmHyDdrt2h+aiiN6szxzU94ZoYwh5OtTVaQ
rF4jJp1KDSOALJlyyMf+QMHAeA6LcQ==
=8jcW
-----END PGP SIGNATURE-----

--Sig_/VHdyE0Ee2I.oPd+91Q7uGKY--
