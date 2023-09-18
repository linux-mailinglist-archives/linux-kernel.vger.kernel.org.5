Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57B17A3EED
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 02:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbjIRAK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 20:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjIRAKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 20:10:38 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17191FE;
        Sun, 17 Sep 2023 17:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1694995830;
        bh=EFuCLWm2/WJqw+coRMdZXEZgpuEQVi6kahF+mUPDnlI=;
        h=Date:From:To:Cc:Subject:From;
        b=abFLjgJmWRNqL3bI8oPTjchqhV0KQ/vkmHO0tYoPxDZ5TUQDoyCLrvQZfR4ZuEFsT
         hF5byCR3dTRNcdb7JIkFFVMRDDZE5Ydh5FnG1+ZTk7b+vVdT8OizaGHLoh/BjfviVG
         vhtJ8q4YKxvNzEmbIGsFZaKY7bXxjVS/aDD6wHjJFzIyNOVAmXfLFnkG3xk3hHb/0h
         qXguMCKLhS0YzmB3zBPY7n9UFfeXrhQHHsnIFn6hVlRnJ2HV6QImKmQaV+CREM1MT2
         +A8hGdBf2DwJOY/U3mObZ0GTuB3PlylNvSCi9GeNF/T+jrkmGnisQzS02yidxPaE0H
         APYfX3YSXT6iQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RplYf3L7dz4wxP;
        Mon, 18 Sep 2023 10:10:30 +1000 (AEST)
Date:   Mon, 18 Sep 2023 10:10:27 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the asm-generic tree with the mm tree
Message-ID: <20230918101027.7506b71e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cHTpL9FtrLeFl5GD6seFh+R";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cHTpL9FtrLeFl5GD6seFh+R
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the asm-generic tree got a conflict in:

  arch/ia64/kernel/setup.c

between commit:

  52f40d9a3c11 ("crash_core: change the prototype of function parse_crashke=
rnel()")

from the mm tree and commit:

  cf8e8658100d ("arch: Remove Itanium (IA-64) architecture")

from the asm-generic tree.

I fixed it up (I removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/cHTpL9FtrLeFl5GD6seFh+R
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUHlXMACgkQAVBC80lX
0GydHgf9GlJwZi5rdrHCWVGYziJ/n+unRVeA9zawFk8koP9kCrspDwlRP/MhCTxZ
iWjEWGqcM2jtOipr0ueEkD+vnQJKaT6M//J67kSQ073S/qGhqEL9XwlxFlE/PLlV
3AQhxRwpzKjpRs/iEBlgdEKz2zlGwvO61iW5Mj0RHLbypNQr5LVFipNSffKgI/jR
ltVnV/V7BhT4uWfIiB0s1AZWlU+VRxuhrRnOKfRT0gk2f5aaaYWgOD4LDjtEYF9+
2SN+Nz7A9RZBl6whHQMUTUHeaAVdMzEAUcKGTJK9lsWovURMK/zZFl0O8rntQB0e
0kn2ybNujUrCxiWUayPweF1MBUh8tg==
=Mpwn
-----END PGP SIGNATURE-----

--Sig_/cHTpL9FtrLeFl5GD6seFh+R--
