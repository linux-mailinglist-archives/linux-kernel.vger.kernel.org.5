Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C617DB2A2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 06:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjJ3FPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 01:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjJ3FPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 01:15:14 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4E0BC;
        Sun, 29 Oct 2023 22:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698642905;
        bh=nkR7rKzVgCACwyc1T2doNhbBLXYl9bbMPKCkgUjax5w=;
        h=Date:From:To:Cc:Subject:From;
        b=X80Q7xaavOxOGTWuEDQAgl0j9fFNDawf46ZUjoFg2cHym2uGvYb6KGvNKTEt9itNJ
         lmh6/Z8G6cBjGzm3vh9k68NdXIgZrBROCuECMMyS43c/+yZ6jQQqXQnVxSMR8PoeXo
         7xsImhSnsurGVOW8xUPa6XyDxdHVzIzGUdLrG3a3jHQJopJzoc1i3Oz5ss1nVynOip
         RLtrSeay2qjKibtkyeJbi7scIswpWLUz0u8rgeb6uI8EVJyD2jJ6gtewTS5t1sYIiy
         DHJBz0W9Xr++OrepkkddaT1zMkdrCNlfruBOCQ9+2hbA6+1zIKjHz16TVvIEwJvUs7
         eC6Jbmnc0ejbQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SJhKh67Jxz4wbr;
        Mon, 30 Oct 2023 16:15:04 +1100 (AEDT)
Date:   Mon, 30 Oct 2023 16:15:03 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the hwmon-staging tree
Message-ID: <20231030161503.153a9de1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8emF1YKsseALO7TtS1wbuLc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8emF1YKsseALO7TtS1wbuLc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the hwmon-staging tree, today's linux-next build (htmldocs)
produced this warning:

/home/sfr/next/next/Documentation/hwmon/ltc2991.rst:35: WARNING: Title unde=
rline too short.

sysfs-Interface
-------------

Introduced by commit

  522ea9d023df ("hwmon: Add driver for ltc2991")

--=20
Cheers,
Stephen Rothwell

--Sig_/8emF1YKsseALO7TtS1wbuLc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU/O9cACgkQAVBC80lX
0GxoKwf9GX/RDh5yODXWxUi3SE6jhfgVDQO/kyK1d9toWGhau4yzhIuONX8oOGFF
VjqpZsoQM4qK+KEGqvHd8LuO80oVDAdCkjVbJNDMk6rT/I9ujzGjgOauNqyIpBfz
zgEgOnUh5RZ6TtG4dZCHx+tqkrBS3TBkJ/s1azWGiel4r80pOGxhojetANEFlY3H
uEnNAt6uzvAJ5xUsU8Tvsc6N3YOWwwS58j86r3la8b1emiWqbXDqa3FQCB6zb/Ia
ybkYxG8uUHAhQAMXp/NmS1byUT0LdV2x/AvybEWU8F8F9bFSMpvBmaNtNAHzR2Ou
M/tuR9lmr6J5vVbbGgcHg3on3mbMAw==
=wf0H
-----END PGP SIGNATURE-----

--Sig_/8emF1YKsseALO7TtS1wbuLc--
