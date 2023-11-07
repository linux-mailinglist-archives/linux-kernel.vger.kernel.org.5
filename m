Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81EA67E4A40
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 22:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbjKGVDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 16:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbjKGVDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 16:03:03 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4681122;
        Tue,  7 Nov 2023 13:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1699390976;
        bh=bIgDyT2YBwCfBvU3UWEnmpIpeokzJ6nGz1+z6pIuiVs=;
        h=Date:From:To:Cc:Subject:From;
        b=H4m8x00dIPwt7N5t0NfwSvNB2+ICpEtKejhEn1MLBlHC/HpiEhCrsGKycdeleZ79o
         feYPLcokklSpg6vNni62+QO8ddcKtekbftCVxP2rIwK/kE3CDDTYQw/67q0RQw8jc7
         oZZpz1+pQcrJcl7dAWx2NuMgUamPpjBb6XdHnOjG6I4OfY6p9nOWlrIg8LHzgMWWGj
         yk4BZ78mg087NE4rsTM3L5KgPofeNvIk0DVoxtRUC90jKZBUbQEcsVlnGmcIbBLIC7
         52y+5pcGQyXQMaofFGvtFaqwPrrBRRwGZ0UOKjEI8EOGLIj8gaMv0CBkPsXvKC4qA1
         3pFc5TAP+qqhQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SQ0zh42PFz4x5s;
        Wed,  8 Nov 2023 08:02:56 +1100 (AEDT)
Date:   Wed, 8 Nov 2023 08:02:41 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the vfs-brauner tree
Message-ID: <20231108080241.1922d92d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/h=vqpR+UanAbI9hwdRCf/D6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/h=vqpR+UanAbI9hwdRCf/D6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  03630940f622 ("fs: handle freezing from multiple devices")

Fixes tag

  Fixes: [1]: 288d8706abfc ("bdev: implement freeze and thaw holder operati=
ons") # no backport needed

has these problem(s):

  - No SHA1 recognised

The "[1]: " is unexpected.

--=20
Cheers,
Stephen Rothwell

--Sig_/h=vqpR+UanAbI9hwdRCf/D6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVKpfEACgkQAVBC80lX
0GzxLQf9GJjHrLDNphK0pOolq1W2ACzzcNFzIy63C3A7hIrfqTYZxOg4ZyhnFo3x
xTrLRAcizvze3geKbxdvILbfuhywzyL6rVzQsaaL8Xmz5GUS56WxiY2els7YDjT6
ViBPAF0fyf3B2iDDXOXVB0HXPmLjaE+vIAgDhDMdxgpVc3ybwlIgNv91rxTHSSee
bEP9sQm3vE7GFmKXkwaQLP/mlE2VKu+n506SGLq2MiipcoUc+qQXMFqTLBe8tz34
rW+cNdzBx+bIOKqOhwjAHDOiHBNssbc8NZZXYwMxDzyfGVJLBhjPwFz+RUEEcG38
KdRNFfvrM255pkL5J66aGifG48HXPg==
=pGWo
-----END PGP SIGNATURE-----

--Sig_/h=vqpR+UanAbI9hwdRCf/D6--
