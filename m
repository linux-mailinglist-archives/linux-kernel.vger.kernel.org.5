Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8C77ACF22
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 06:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjIYEbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 00:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjIYEbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 00:31:20 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0B492;
        Sun, 24 Sep 2023 21:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695616269;
        bh=mFtZmp57nNWMU4FuhVoG4kMRNHEtiQUN/DihPuwqMhA=;
        h=Date:From:To:Cc:Subject:From;
        b=pkKXJ+yNrPuxJR2hyRMKEKmiJwqF18HUZfAn5vVCfyFxzW3eJsSAOpCTg0mwDDT/k
         2cjpNF8cKs0qk1A4raslsoBPQzWCdIbUwmYZFuB1v5l+WhkTBhsujBay9SqYSUizWD
         V1SLyB7sqRkStBPaJldbW/YnXRsbgERtfLVvmV2/v7xUY3Xtp6iOZnWR60fheg8+ls
         QFiSba7TwBY/z2tMBNGNgGYRGypobXijgTO7QLaZS/w3xqvE17dUaUAXuJHVQu0kGg
         R5ZHe/A/d2Q267W4eOCDlmwAegusVz5W3S+A33/7oxK42rdqi+ubrF++TKTLc40bz1
         aaBuaSreRSfrg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rv9191C3gz4x5p;
        Mon, 25 Sep 2023 14:31:09 +1000 (AEST)
Date:   Mon, 25 Sep 2023 14:31:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Max Kellermann <max.kellermann@ionos.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the vfs-brauner tree
Message-ID: <20230925143107.27476fcb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/U_zxesrkufRKC2Tx.DQqzff";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/U_zxesrkufRKC2Tx.DQqzff
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the vfs-brauner tree, today's linux-next build (htmldocs)
produced this warning:

include/linux/pipe_fs_i.h:132: warning: Function parameter or member 'pipe'=
 not described in 'pipe_has_watch_queue'

Introduced by commit

  7084dde72592 ("fs/pipe: move check to pipe_has_watch_queue()")

--=20
Cheers,
Stephen Rothwell

--Sig_/U_zxesrkufRKC2Tx.DQqzff
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmURDQsACgkQAVBC80lX
0GwymQf/SSN9OTOSSsrAWVbJx0L6P0Qc8/v3HzPs8/Jfyv0O+vD0ENDh8p/8xRcB
oGaoMkLX/MlHYXJZ0ivdjO2XtCSfVhRnei3LI+PtU2lZzIOPyoqTJkfhMcFkSgfV
3Ot363iN9kMydDPXoTahdaM9/vtEQJzvJGOHTRIUETJu2tDYlY+IRgv5pUDB8yi3
bHgflWBguFvGySDudqlUsPqXYknPi3M//5N30ORDoFZmMK3SYHMRqWBu6isv33SI
J0mEWTtOF9sDZYBni5F0ZSy8HqCjay44ewkgMtNbTyyHgEamYX4NXu9DIUj3H8SB
3yjZ9ConA9IM4A8nSkVmJ2eQrug9ow==
=7RnT
-----END PGP SIGNATURE-----

--Sig_/U_zxesrkufRKC2Tx.DQqzff--
