Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9FA7F6A92
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 03:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjKXCNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 21:13:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXCNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 21:13:32 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A10B93;
        Thu, 23 Nov 2023 18:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1700792012;
        bh=Y1hUnn+pQbhuBfNsxpEj/QRwkQ4NeXzcw+dSpFhqfwU=;
        h=Date:From:To:Cc:Subject:From;
        b=p+nm8drqOCBwpWd34ThRCiYAMAOabK+e9oNJ0NPJ+IUbTJH0EIRk9mZ7DIEnaEfcP
         yDI9/G4IKL5sIRCnQicktAmuK4dc/uoaxXJa9xz/N9eoB3HoWf6pAYn+AxBNlftau0
         wimGcKmFBPZK5BHJaID+tx8EaPc+earaf9L6ea442ruGvjeXrQScWv+GpCOLtKzX3A
         zL33oFkVXeeFTQEB934WyW+Mp8lhXiiHwcXsDytNpYsEHLqWYGHu/rvMoAX+/6nQib
         dgaJFgiWWOSAWlVLND6Y97bxUJwT7JyA3dJw9lGcgDeIz+wJhFh/loIIn6Q5k1ibLY
         5/8MSrODHrvAA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sbz6h5SZGz4wcJ;
        Fri, 24 Nov 2023 13:13:32 +1100 (AEDT)
Date:   Fri, 24 Nov 2023 13:13:31 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the vfs-brauner tree
Message-ID: <20231124131331.23279543@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/d99G7c6CcuxNJrumwDqQ7jK";
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

--Sig_/d99G7c6CcuxNJrumwDqQ7jK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the vfs-brauner tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/filesystems/api-summary:14: include/linux/fs.h:1655: WARNING:=
 Definition list ends without a blank line; unexpected unindent.
include/linux/fs.h:1658: warning: Function parameter or member 'level' not =
described in '__sb_write_started'

Introduced by commit

  2a7b49f698d0 ("fs: create __sb_write_started() helper")

--=20
Cheers,
Stephen Rothwell

--Sig_/d99G7c6CcuxNJrumwDqQ7jK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVgBssACgkQAVBC80lX
0GyMUAf/fIjiVg40PcnniY4LBGE63ozKqMmhYuhoR47viE+Ni9ZQBNKXFeNtr1BP
0Zshnj6VUHWHYX0SV0zkryx/hgE7TfnoKZoi70A7gtrQYNQJZGL3UZS3DptwQMAh
LN9Z1juQmCMBOlsEcrjYZmDI8LdM9MwRgUOyD+LP/ii1n+RCg7ZiRQ4gTzmvpC3h
FSfZQZjHLhLv7lSrG6qWqSma07I4cJuPImJxV2e9gxvclVEsrTNX/oNXjkmJG54a
DqcHxQiau892m1khfh0nlMrgagIe2G37cBoRHDmwTUdu+aFjP22SNljQmBBoTLmU
PRSf8Esmjhy33+2Glhsx1Qc8eFCg6w==
=C6AZ
-----END PGP SIGNATURE-----

--Sig_/d99G7c6CcuxNJrumwDqQ7jK--
