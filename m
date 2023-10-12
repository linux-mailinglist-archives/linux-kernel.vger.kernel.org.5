Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8F17C7A96
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 01:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbjJLXs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 19:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjJLXs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 19:48:27 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C41C0;
        Thu, 12 Oct 2023 16:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697154498;
        bh=OBqYhC4FTqQwvIwKBzMFWi+ThPwP9AJoU0p3mh9y3Es=;
        h=Date:From:To:Cc:Subject:From;
        b=ZvZHMbSX040P4yTXbxAi3X7GxDHhT/EE5jLSb8ryUtHosiwUWBi3QTgWh+mDXnvq6
         AFWYvZetsBzfwyCJ9FYLretj77hU+pVQ0cohmHouJ8qyi7OzS5v5HpdZuCuIG3cWtQ
         Xvkv0qvxoOM4GVBppe3tsn34iKXS1BXWFAm0jdQfcECrIJw+jXP8i1tjS05mgluIVd
         1YC0xcoup02J3HTXa75rZPX9bB+jw6I6IxSbCOYXTbRpYH1A2WEcchUb8z5g1eIvu+
         HBOa6KKco9iN9bl5fISfv7AZTlIVY+KGSQdG+L8V80miQFD+c0H2MTnUh/JKYoPPhm
         lrBU86+VLqIEw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S65tT4C8Kz4xGM;
        Fri, 13 Oct 2023 10:48:17 +1100 (AEDT)
Date:   Fri, 13 Oct 2023 10:48:16 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the vfs-brauner tree
Message-ID: <20231013104816.103ea713@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8FnIL7ZQf2y0vPQy12AhsQu";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8FnIL7ZQf2y0vPQy12AhsQu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the overlayfs tree as different commits
(but the same patches):

  149f455798a6 ("smb: move cifs_xattr_handlers to .rodata")
  295d3c441226 ("net: move sockfs_xattr_handlers to .rodata")
  2f5028604f08 ("shmem: move shmem_xattr_handlers to .rodata")
  375aa21d36ee ("xfs: move xfs_xattr_handlers to .rodata")
  3d649a4a832e ("overlayfs: move xattr tables to .rodata")
  c08a831c74f0 ("squashfs: move squashfs_xattr_handlers to .rodata")
  c25308c326db ("ubifs: move ubifs_xattr_handlers to .rodata")

Looks like the overlatfs tree has merged a previous verion of a topic
branch from the vfs-brauner tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/8FnIL7ZQf2y0vPQy12AhsQu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUohcAACgkQAVBC80lX
0Gya+wf9Foqou4O0hwjmxHqwfeXhalPnuIamQTu6rZb2lUSQNnSv8ng8UAdpGoh5
T602jcD+theUdB9wIF9wfwPVva5ss7c0EYUrEmXLpQg9tTwB17wbN769ZbcFfWLf
5c0ml8bEslZN/yAvzz5AK5+S/e4YiyfA2OM3ECatPM1VRHK0uoQ/mZO4D18T7L1i
CbVQS7uUjnlCiJ6we4GGFDFR8EaoU9TquDkxdr5jlI+4Jke8mFpX0nwvUSwQnhau
I12Ffrb7KvNsHSt0sFCjsLAFnyShiW8GJstc8JqGyNiQdlRRjj6N1AIr/8MjUxek
j/01a9ITJm5VRYqXPgsMoQ06HdAAWA==
=Q/nq
-----END PGP SIGNATURE-----

--Sig_/8FnIL7ZQf2y0vPQy12AhsQu--
