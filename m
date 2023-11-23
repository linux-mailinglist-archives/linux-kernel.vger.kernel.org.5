Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E705C7F552B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 01:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjKWAKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 19:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKWAKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 19:10:12 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B72DD;
        Wed, 22 Nov 2023 16:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1700698206;
        bh=F3hUK3Y0jf6mS8cm4SBZe1aq3dM/e7j0/uTA65TSOTE=;
        h=Date:From:To:Cc:Subject:From;
        b=PRll5c2AoJNykMGptGa6+/VDK3EWaqvRu1+ZgltEQee7Vhckm3AJji5OjOxetaOrD
         pg3B6YD6FMrE76APsslOa8b8oONNzVtjF7yTKjjJrVjNbaj67l5jzaLt4BzAVaV9hT
         J6JXLGr5VcZzVN9IxqcSI5X+l7UVpP3WBA8JsSTgDN/LQQbARhf+ERHWWd7QoHNn+H
         TO5WUnw5RCYcUH9nM9xE9yBKUjQaHErdLU3BB5fyDnRzTe7pE/ydGcbBjN5iNXXDLq
         noQamLNEI6k0eAMxFBGZT91M5d27ynztmohUeSzsMhyjEcax09fTiLAoTDgGhApITZ
         njTGh6y1uoXVw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SbJQj6nrMz4wdB;
        Thu, 23 Nov 2023 11:10:05 +1100 (AEDT)
Date:   Thu, 23 Nov 2023 11:10:05 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paul Moore <paul@paul-moore.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the security tree with the perf-current
 tree
Message-ID: <20231123111005.432dfc56@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ka_w7hWow747h/p/rsdKFwU";
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

--Sig_/ka_w7hWow747h/p/rsdKFwU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the security tree got a conflict in:

  tools/perf/arch/s390/entry/syscalls/syscall.tbl

between commit:

  d3968c974a24 ("tools/perf: Update tools's copy of s390 syscall table")

from the perf-current tree and commit:

  5f42375904b0 ("LSM: wireup Linux Security Module syscalls")

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

diff --cc tools/perf/arch/s390/entry/syscalls/syscall.tbl
index 86fec9b080f6,5a422443cb16..000000000000
--- a/tools/perf/arch/s390/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
@@@ -455,7 -455,6 +455,10 @@@
  450  common	set_mempolicy_home_node	sys_set_mempolicy_home_node	sys_set_m=
empolicy_home_node
  451  common	cachestat		sys_cachestat			sys_cachestat
  452  common	fchmodat2		sys_fchmodat2			sys_fchmodat2
 -453  common	lsm_get_self_attr	sys_lsm_get_self_attr	sys_lsm_get_self_attr
 -454  common	lsm_set_self_attr	sys_lsm_set_self_attr	sys_lsm_set_self_attr
 -455  common	lsm_list_modules	sys_lsm_list_modules	sys_lsm_list_modules
 +453  common	map_shadow_stack	sys_map_shadow_stack		sys_map_shadow_stack
 +454  common	futex_wake		sys_futex_wake			sys_futex_wake
 +455  common	futex_wait		sys_futex_wait			sys_futex_wait
 +456  common	futex_requeue		sys_futex_requeue		sys_futex_requeue
++459  common	lsm_get_self_attr	sys_lsm_get_self_attr	sys_lsm_get_self_attr
++460  common	lsm_set_self_attr	sys_lsm_set_self_attr	sys_lsm_set_self_attr
++461  common	lsm_list_modules	sys_lsm_list_modules	sys_lsm_list_modules

--Sig_/ka_w7hWow747h/p/rsdKFwU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVemF0ACgkQAVBC80lX
0GzPuQgAkjP506h+ukQtYp4SvCpuCsXiZlPpImj4FpnNz3B2JVUYwi+c7//OOFx2
DasVpvnZdFfxjadZKM15HEeOpzVTi/Fe7MYjVTlzeKTMF3kto+4IwuvfkCoXEey9
fVr2so9Mndo1PHAZOoNGwoyTPpJNzq5pjv2WBRSWj8f2jpdebtwtENyBlNzOvQnR
H9gozjIYWD+7zSDqUWp7FiRT7WX+LMcTKcfsL2DJ0cX9hXNwhGufQgEgfcppFN6L
VUYN2M/Xmg2lb+Ht3ZJk+p7zw6OvzM+3cr6j0NMlyyyAazlPi09IQuclhet21pQS
5nT8EGvGJRmWwkCZ9bDI04Hzmy9ouw==
=uq7O
-----END PGP SIGNATURE-----

--Sig_/ka_w7hWow747h/p/rsdKFwU--
