Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131C877C4DE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 03:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjHOBGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 21:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbjHOBGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 21:06:31 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5AFE73;
        Mon, 14 Aug 2023 18:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692061588;
        bh=vBKHbMek8gTpxT5K5+M08GO/s+UwFmTqnTPilrIFMok=;
        h=Date:From:To:Cc:Subject:From;
        b=eS4OM70ce0nD3bUmqhR/RAzwqSCUKKNnhYl0JtDswA50hF388noiaq2jvbFMkRExK
         ob6LZc+PPhkp53Sy2ZpEajvmyILBj1QJtQxDNNuV7cluvOg9HnvlYYZubuH5dlmjEW
         bpV9oOT5RcPJgStXpa18ifUSOxQ+umW1FjX8qvfP8Ffm/DXCQ1R4oCKZbVel9iKyX2
         PSMGNgIIX/fxMpuNqym5gpoB3scctKu113HXWGH8izk1BSPGvP8urOwIDWEYqC06af
         sDCR4pGksOdkFweRGGUv7mF2qopkTT56RK/EahfqP6eUWt6aKzVPWJs4HngLPMNvkG
         L4lUc/PVRfwdw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RPtPw2Hpjz4wb5;
        Tue, 15 Aug 2023 11:06:27 +1000 (AEST)
Date:   Tue, 15 Aug 2023 11:06:27 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the nfsd tree with the nfsd-fixes tree
Message-ID: <20230815110627.5d985043@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/TvM+.Ra3rV_6Hi23+P=0Ji.";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/TvM+.Ra3rV_6Hi23+P=0Ji.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the nfsd tree got a conflict in:

  net/sunrpc/svcsock.c

between commit:

  c96e2a695e00 ("sunrpc: set the bv_offset of first bvec in svc_tcp_sendmsg=
")

from the nfsd-fixes tree and commit:

  62c25ceb29a6 ("SUNRPC: Convert svc_tcp_sendmsg to use bio_vecs directly")

from the nfsd tree.

I fixed it up (I just used the latter) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/TvM+.Ra3rV_6Hi23+P=0Ji.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTaz5MACgkQAVBC80lX
0GwHMwf/bCVT5ZnqBQyHGHqx9FjdOYj6RCi/7hZkbPk37GGQwK97iiBZcyUB9BLN
DSWZpFRH79oNg7MTLgd/uGvrdl9cJ75sqpDG/iZooryH5CGSV+ObSwkHmq0bIfPq
uId2Wf04gLqXBWkrlbPp0T0IkJ3OkFqjgX6VJufZ6t+ndbq4N+6SuCJw7t+WD6Rx
an1hE9ZZg9VM+j/w3A5+rf+bbMLGLTDfqzNTi2dKGKa/4u26KYnchV3t8PT7ZL6d
/x5ZHdOHIQY1w1qJGRnNkVcKxXmT/ZTdi3WWuLbL6e5YkUGvbn1oQcPFvzD4itPb
PWtP+lSd3pS4KCwv+SY+nh3uhK3a1g==
=Nsyg
-----END PGP SIGNATURE-----

--Sig_/TvM+.Ra3rV_6Hi23+P=0Ji.--
