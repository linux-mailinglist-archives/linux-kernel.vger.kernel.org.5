Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD2B7EA8FD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 04:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjKNDNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 22:13:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKNDNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 22:13:32 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3277C91;
        Mon, 13 Nov 2023 19:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1699931608;
        bh=mEjM4aj+NkL7GUkm5VQRa7ZEFTmJWuTrMYLwB+YCYns=;
        h=Date:From:To:Cc:Subject:From;
        b=rLLBCTa2KsDb0Xhg+fv9eL6HJ7PlKLX/fQfTyabroEY5twa6b9bosOycxzSG0ES1m
         fyuZttRj/+rrOZVSvVY/OzgIe+w7Qw6zuVLLpidFOdM8DErQycSUc+D1kvol81aLJ1
         hTZ6nmAOGA3H6uTzT/4laSmHhmi8wazn+XXOH7S9M+GfychtRjKBBZSYY5ODT2QQVY
         ut1D3n0Ycp6JPlTpUsHijl0DrQ4668Vg1HR4BkQaJno8YMSx2+BE8I810LT9zGTEaB
         g7GsGW8/y6DxM3w04JSxCzrFvxyJ+jWOckk+mEVRvD4V1zGmrPnNZ2eBUTg7PXWD67
         8smnWHGujr2KA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4STrwR5xVKz4wch;
        Tue, 14 Nov 2023 14:13:27 +1100 (AEDT)
Date:   Tue, 14 Nov 2023 14:13:26 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the kvm tree
Message-ID: <20231114141326.38a3dcd4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+DOfe=f.BDu0TPE2QI61Sg+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+DOfe=f.BDu0TPE2QI61Sg+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the kvm tree, today's linux-next build (htmldocs) produced
this warning:

Documentation/filesystems/api-summary:74: fs/anon_inodes.c:167: ERROR: Unex=
pected indentation.
Documentation/filesystems/api-summary:74: fs/anon_inodes.c:168: WARNING: Bl=
ock quote ends without a blank line; unexpected unindent.

Introduced by commit

  e4c866e72563 ("fs: Rename anon_inode_getfile_secure() and anon_inode_getf=
d_secure()")

--=20
Cheers,
Stephen Rothwell

--Sig_/+DOfe=f.BDu0TPE2QI61Sg+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVS5dYACgkQAVBC80lX
0GxaRAf/fSqatinvrWZzaI2/+c9YCjKfIzui+Dbry8Gh8GdZ2g5DlY0/LnxSkMyi
UrFZ1Q6BchZDUHhAcXqbQBC7Gj9/NJ70n3h7stAKfzbd8jIQbpd/Iw+3FWMIT1gk
2MiCrWDOd0wmmPw7KMPzuHGEMaIIjPl4H1LmLB8U17Za1jy+JZ83Sn/KiJmSpw+O
9OjKf2LNMEWkFpv6v0Hw2/nnBHDx2pJHpPADd2YSVPH7Y2VWSUerAs1X+IyJmOed
Ufy19ttVQyNn/TvvPG3xRODXE8aSmiVMn/X7ZUfzFCtbUAGS7Lt/pR5BVxOZfXou
SC2THURxPiB5dqcajinlvvOssEYXaQ==
=Tp1g
-----END PGP SIGNATURE-----

--Sig_/+DOfe=f.BDu0TPE2QI61Sg+--
