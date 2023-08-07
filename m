Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910FB77197E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 07:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjHGFin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 01:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjHGFil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 01:38:41 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B215E10EC;
        Sun,  6 Aug 2023 22:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1691386714;
        bh=+ISN04mNu06WFRtYgAC9oTdpn6CdoAbXmm/nvDa4tRA=;
        h=Date:From:To:Cc:Subject:From;
        b=OlFLoMMwTlr9N3DlA9r8/lGE5wp2M69s4XQgzyH2ccKH8JD8ZvA6NgQXg5Lts9G1I
         jt/gf5vLPNfrxfstEvXqXWcgfzaa/cVo3SBe8Z/1YqtvG2lREKDpDPWrCJz8IodqZZ
         2ODaVDzwE5g3S6i0y0qILQiRnaeIPMGEpKaHwq9A84nqn6Kbb5dAcirSwGyxaj6qsB
         hrI7wGbFRcRV6a+RA6WGGab9fCXHTK2gjSxkixx7J9P16ehM57dn+ijDMj9zDyUJfh
         AUKiW2FafSc0bFRDyJDmcEFkanEyD6wacR6dfQzm7XrUKBD+fyq/Bry9pUdT3TC5OA
         wYeHuLQlDE0gQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RK4qY6P99z4wjG;
        Mon,  7 Aug 2023 15:38:33 +1000 (AEST)
Date:   Mon, 7 Aug 2023 15:38:31 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the vfs-brauner tree
Message-ID: <20230807153831.0c640ebf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6GCaXPzI0r2wmVG=BYUbgsX";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6GCaXPzI0r2wmVG=BYUbgsX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the vfs-brauner tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/filesystems/api-summary:38: fs/super.c:558: ERROR: Unexpected=
 indentation.
Documentation/filesystems/api-summary:38: fs/super.c:559: WARNING: Block qu=
ote ends without a blank line; unexpected unindent.
Documentation/filesystems/api-summary:38: fs/super.c:561: WARNING: Enumerat=
ed list ends without a blank line; unexpected unindent.


Introduced by commit

  c9eca69d372c ("fs: add FSCONFIG_CMD_CREATE_EXCL")

--=20
Cheers,
Stephen Rothwell

--Sig_/6GCaXPzI0r2wmVG=BYUbgsX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTQg1cACgkQAVBC80lX
0GxbUQf5AXjX7MNTXdkxLr7Vxbzzt8RunuQsfF8cmqWHHzfxx7UhNUMDeSt9RPJC
ogj8RsIWl9XchttUrxRaxrjXBxmEk6DFXVLCz6anx+8QVRSpTdt2Apn4pukNL4qQ
dbBBrz+e/a3HhvTXtnMi10iUtSK7jm6ZNwByRgU9Tl0h3qd3m+Sc0sWnbND++5E4
e0MRA+2AOxswsqewFltf8HkpHrK/rwsqeinzGBmMtq7sk+5wxZh+weFeom8MrPbx
UOPtizMfQBAyjpag5DFYYplgnol/BhJ7c4GsNQUMNSYKyCPNvF98VRzHOXciXHYB
EQrqcyuBFJpKmg/mMbKGc9xkD/oQrA==
=nM6a
-----END PGP SIGNATURE-----

--Sig_/6GCaXPzI0r2wmVG=BYUbgsX--
