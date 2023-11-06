Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C067E1827
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 01:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjKFA25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 19:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjKFA2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 19:28:55 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F98C0;
        Sun,  5 Nov 2023 16:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1699230528;
        bh=WBDiGAvOcuom6RXSMC7UAIATNC5vZ3xQhXeA/DL21yk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DHJs5h7+ep/7dtt2Mtl131Bex2vMyh3QovrsDMXS5R5PY36cA7LFhY63urVYOQ88D
         2CWzS2cMoxucCHJU3EGVrqnXHUptKK2U90sdEOjpSXGfGSQAEPd01EnTMdP/kzzKOG
         1A4lK6tYM3ikSshJn9pLiLjF4ighBAJyMG0W83HSet4kbZ4GiIF/aF5cRn3S9hhhm8
         TPmBsKwWdBs5AX5fgvvXgpUdzMNwRXyVaTNDrGYrx+VOllb8TfOR5EO3ks/T0XYx/h
         amD0u2QL8F87wWe4/dYquMV9zW0Fuph9N8/psf7GKpMYHbxm+1W5uuES0wz7DW6YeG
         mjkHpKJsBbrIw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SNsf75HC7z4xPh;
        Mon,  6 Nov 2023 11:28:47 +1100 (AEDT)
Date:   Mon, 6 Nov 2023 11:28:46 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paul Moore <paul@paul-moore.com>
Cc:     John Johansen <john.johansen@canonical.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Subject: Re: linux-next: manual merge of the apparmor tree with the security
 tree
Message-ID: <20231106112846.4c2a5c64@canb.auug.org.au>
In-Reply-To: <CAHC9VhQkUVCAboT78M3g6LabmzFqKYdsxMHQ7ePETJKnzDiV+Q@mail.gmail.com>
References: <20231027130320.69469330@canb.auug.org.au>
        <CAHC9VhQ+Nt7CrLxSZcOVNEtAypruOmM0ST0P0JJMrOq4XYmAkw@mail.gmail.com>
        <4b4eb40c-b65a-46e2-9e23-5412a9cdcad0@canonical.com>
        <CAHC9VhQbxJ4-z4Hp7CSmtcTNOWGFeQF2eEyct9=nHCMN_89YXw@mail.gmail.com>
        <20231031074649.3bdbec45@canb.auug.org.au>
        <CAHC9VhR=x7qB3gmQg+GPYLnXtGU88S3KCiZGjRYtDKSJHp4P1g@mail.gmail.com>
        <20231106101434.70c62773@canb.auug.org.au>
        <CAHC9VhQkUVCAboT78M3g6LabmzFqKYdsxMHQ7ePETJKnzDiV+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/I7r/1MZsaKk4CDvcdNuj3FV";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/I7r/1MZsaKk4CDvcdNuj3FV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Sun, 5 Nov 2023 18:36:49 -0500 Paul Moore <paul@paul-moore.com> wrote:
>
> The LSM, SELinux, and audit dev-staging branches will no longer flow
> into the next branches, and I've reset the current lsm/next branch so
> this should not be an issue the next time you pull.

Thanks for that.  It can all come back after the merge window, of course.

--=20
Cheers,
Stephen Rothwell

--Sig_/I7r/1MZsaKk4CDvcdNuj3FV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVIMz4ACgkQAVBC80lX
0Gy9sAf9FNd/8ccln5G1l6Ck9uvjjHpMWwQq35C3MRL4GWfVd9tN1AdEQHjyBWMf
AohJ27AqvSd0ibWZUGskzeo9eYY6QfMksJpHFZbmyftfJOfe26Y/ElJZ3l1jAwgj
XZcPK8aIP4rREioMi8ToNZNw0ad4j6V6Xo1OBl0hgQCA4btw/29wdoSj3eLXqxDC
6LFm8F9PVpc4QrtLYxHBlqZNGXP7h8JVHotXSgOrW5tkcKtulLuJBsQ9gPvK+UMs
+wVvJ63O0FASLuIyF/9sPaOirzbCI6NId2pkI4VsqkB6RgzIhOdHXCd2XFjwdrw2
zQYVzegWupWz8zHzISWW8pza9yHOsQ==
=4Hji
-----END PGP SIGNATURE-----

--Sig_/I7r/1MZsaKk4CDvcdNuj3FV--
