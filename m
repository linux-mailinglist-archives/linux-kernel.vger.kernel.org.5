Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124987AE23D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 01:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbjIYX2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 19:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjIYX16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 19:27:58 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025F010C;
        Mon, 25 Sep 2023 16:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695684470;
        bh=3Uf9jupJpw2wOBTKLPB0kwH5uFijHtGgkTTexntVOLs=;
        h=Date:From:To:Cc:Subject:From;
        b=CqOvB8oxvfDfQs9MHRnCYrxCBKUT4DeTOVJo+Ndw1OVsoP0ZabKxLVJg1nMj6y60t
         AKJK0MNgCi1CVw15XSLYyrv2HWH0/tA5gffjNeOjT5E3aJiL1Z4GBmqYswgZYp3feE
         Dl8cMQ/gnZBGQqhEBI7BKKvXim24AMlTN9jbXC1u9vDNXaPTbm0G/GIFwIJMJz9J4r
         Yxs430dgoI0jLgJTPQUABGuX4+eUAfMjJ7PfqZ6Mkt+OV4tz/5nqqQeJG1lDj/Gi7N
         uEK9+hrY4MGTkcsisUxg20vIcdW5mOQpy4ayxC7ZYc1mXXMhKDk5IOT00fSZuT/mWB
         jHMTv6J0eRyhQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RvfDj675rz4x5k;
        Tue, 26 Sep 2023 09:27:49 +1000 (AEST)
Date:   Tue, 26 Sep 2023 09:27:49 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the mm tree
Message-ID: <20230926092749.649bf24f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0=SngUnXw2KzLh4NAkOrH65";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0=SngUnXw2KzLh4NAkOrH65
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

fs/proc/task_mmu.c:2022:13: warning: 'pagemap_scan_backout_range' defined b=
ut not used [-Wunused-function]
 2022 | static void pagemap_scan_backout_range(struct pagemap_scan_private =
*p,
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~

Introduced by commit

  93538f467c0f ("fs/proc/task_mmu: implement IOCTL to get and optionally cl=
ear info about PTEs")

--=20
Cheers,
Stephen Rothwell

--Sig_/0=SngUnXw2KzLh4NAkOrH65
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUSF3UACgkQAVBC80lX
0Gwzjgf8Da7+UicbYH6BXKtfbxyvBtPmEtmZb2fRWgyelK+d/n4+drKBRlTLex8C
muoB3IQf6JgkVTuVE6AHZTXsUJZRSkQcL2/wMsyeLGsHSmbn2aEUvg2CtzorNtak
EOy6lLz7tXmEgehgHrHt9FTHRt4dTvQ5G49Lwasj4oJpCrGwkkYTFeE7NRPgScFN
/d1rRCq2Ycy7de00Nf+Q7O7JO4/5IfF8JzkwKALrP2RKftpteS8wrSasOnjg8Y/K
P9ELm5f097JMW5I4DDKv9T3eT0ec+fc2qVQjrm2sMTM/RgXpq8gzANO3IuS/QdBo
1GPNBhoxb/XnVxESeRo8yGHNO4RNOw==
=PwGt
-----END PGP SIGNATURE-----

--Sig_/0=SngUnXw2KzLh4NAkOrH65--
