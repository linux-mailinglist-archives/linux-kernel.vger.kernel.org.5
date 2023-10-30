Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D107DB299
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 06:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjJ3FFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 01:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjJ3FF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 01:05:29 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2FBBC;
        Sun, 29 Oct 2023 22:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698642325;
        bh=Pf0rOFdP1K5vzbDlQa6KD+XnzoGlGFSW8pYFojPzP10=;
        h=Date:From:To:Cc:Subject:From;
        b=nAyWLvY745e2XK27kJB1jSnQM9am0hD41zuoAjc26ctgr0fThUhanCWn0qj4lY9Ru
         HqUFunLohKAI8nNzU0cz67uthbpF9Mrd03bTVUw61BRpCmJK99pTlvB55z6ttelWi7
         BDIiadr45Q4MWk2ggduhlRBFnQWN/I0TtgOH7XhLkXZ5gACF06FQQ1CpPNcAgW4NTZ
         gkw2D6Ka9HuoragvLni5SsmIGWcCug/dMfqmTr9mehLxrA1SjtsYpEtslXCTIvuHZH
         hkKbFwAtREYVUZw6TthKTyDNxPR4lf4PKbMiBy3ZAIZN00WiB89P1zm7KFylnhif/n
         7euzg4QLU7VoA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SJh6Y57rxz4xDB;
        Mon, 30 Oct 2023 16:05:25 +1100 (AEDT)
Date:   Mon, 30 Oct 2023 16:05:23 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Jiang <dave.jiang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the cxl tree
Message-ID: <20231030160523.670a7569@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/NAD5.FqUY3SkbAlxtZ.G_aA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NAD5.FqUY3SkbAlxtZ.G_aA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the cxl tree, today's linux-next build (i386 defconfig
and arm64 defconfig) produced this warning:

WARNING: modpost: vmlinux: acpi_parse_entries_array: EXPORT_SYMBOL used for=
 init symbol. Remove __init or EXPORT_SYMBOL.

Introduced by commit

  a103f46633fd ("acpi: Move common tables helper functions to common lib")

--=20
Cheers,
Stephen Rothwell

--Sig_/NAD5.FqUY3SkbAlxtZ.G_aA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU/OZMACgkQAVBC80lX
0GwIYAf+IiVZ5fo3gcJXUi512XAX3chLwtG95tU9xDTsmPENZwZ63MueBEjYIivq
7md5o45tR3dEx1l5/oSH3W2vjbwFRliKkWSRJLVuOZaoD4mK4fgfgDVH8zloGZ6h
P6pp6Mimv5b3KGAlJY0saak2BMJDOszAcQAPhZeP4OmxjrkUAI1Lg3qtUku/XUYI
QjVLfzY9mXI9Lw5afOIqiY2WItISS+MZfL2fTmu83xHhszedaynjlBm99hrMEZ8g
6Q/cla1tLI9NCOF06jmfwr1muuA56Hh7km5v1pPicdUKY6WJKrbIFYL00JPJ/ltv
9QpFtOC1/ZPvSgCda/CFsEeqBlr83Q==
=JZSC
-----END PGP SIGNATURE-----

--Sig_/NAD5.FqUY3SkbAlxtZ.G_aA--
