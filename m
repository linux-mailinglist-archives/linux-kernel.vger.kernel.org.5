Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54DBB77C576
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 03:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbjHOBxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 21:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbjHOBxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 21:53:30 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8544DB0;
        Mon, 14 Aug 2023 18:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692064408;
        bh=/yI6gnWPXeMs75/SF7gnZEHG4nmUt3Yp6v7q6Xf82kE=;
        h=Date:From:To:Cc:Subject:From;
        b=U0ysCnF2KMLJdAJQUUpRiQRtzeUEF1xjCeFr905CLIgyqHIccdcOiHe/Hmok2OVpj
         JxKxO+p+wj2qjmjLSt/R46+SVxWXhRAnlky4Za9VX8Sx9f8n94KoZm/2Rg9HIMo96k
         AxPjBqmAiEfXP22AEA6+cx7qrln0Lwz5rylpuvaQydbKIs1kFFroMUbMz/bSGf0/LL
         wbZYuu90RGvJilqC0+0NiyLhBIaH1UQOmMqVqPk9yNWUKn56MC4Ujh++Z/B6ErSpXl
         mEQXc0O6TC0W+6qkyj1Rn0DlrENycHeuJP9EH5QsTDxsLHbCjnWKQNz3RE4VWf9z/4
         u0BYawOkNG7Ng==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RPvS73DVcz4wb5;
        Tue, 15 Aug 2023 11:53:27 +1000 (AEST)
Date:   Tue, 15 Aug 2023 11:53:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        David Rheinsberg <david@readahead.eu>,
        Jiri Kosina <jkosina@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the hid tree with Linus' tree
Message-ID: <20230815115325.0d20b960@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/jf=mXhClskyeMoY0yKNBYqE";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/jf=mXhClskyeMoY0yKNBYqE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the hid tree got a conflict in:

  .mailmap

between commit:

  286812b041cc ("mailmap: update remaining active codeaurora.org email addr=
esses")

from Linus' tree and commit:

  0c4b9411f363 ("MAINTAINERS: update my email address")

from the hid tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc .mailmap
index 5dd318121982,cea699139e6d..000000000000
--- a/.mailmap
+++ b/.mailmap
@@@ -138,10 -119,10 +138,13 @@@ Daniel Borkmann <daniel@iogearbox.net>=20
  Daniel Borkmann <daniel@iogearbox.net> <dborkman@redhat.com>
  Daniel Borkmann <daniel@iogearbox.net> <dxchgb@gmail.com>
  David Brownell <david-b@pacbell.net>
 +David Collins <quic_collinsd@quicinc.com> <collinsd@codeaurora.org>
+ David Rheinsberg <david@readahead.eu> <dh.herrmann@gmail.com>
+ David Rheinsberg <david@readahead.eu> <dh.herrmann@googlemail.com>
+ David Rheinsberg <david@readahead.eu> <david.rheinsberg@gmail.com>
  David Woodhouse <dwmw2@shinybook.infradead.org>
 +Dedy Lansky <quic_dlansky@quicinc.com> <dlansky@codeaurora.org>
 +Deepak Kumar Singh <quic_deesin@quicinc.com> <deesin@codeaurora.org>
  Dengcheng Zhu <dzhu@wavecomp.com> <dczhu@mips.com>
  Dengcheng Zhu <dzhu@wavecomp.com> <dengcheng.zhu@gmail.com>
  Dengcheng Zhu <dzhu@wavecomp.com> <dengcheng.zhu@imgtec.com>

--Sig_/jf=mXhClskyeMoY0yKNBYqE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTa2pUACgkQAVBC80lX
0GxPzgf+L3QhsDc9Hr1KPqZwQre48dudDb9lyhDaNonLWTO9sbbchrv6H4tQAZ9I
VzjvZCmiUv0yWaGDxjEva72EwXkCT2W0zV3KFZ3HUbgZqKKu/8tIutJ8urV6rfH5
tHeCs9W+VPyf9VvCJC8rQ0gzXba5VvR+4WoqhBL8OEVBTgpKHVWwjiHiofCNt4WR
Ld349i3M58A6My08Zc4VI1l/OZXcY+EDxR+1vzDV88ZpyMcmDjrgjjFn+tM/zyMo
QSYU3T/9lJImCbgOUc7Se2ANUt/0Od4NSsZob2/j9VR+T7VouXH0cxAMwlgApZLg
c955sSO1vKMVYG9jJwXVMZ/iifSojg==
=Ji3X
-----END PGP SIGNATURE-----

--Sig_/jf=mXhClskyeMoY0yKNBYqE--
