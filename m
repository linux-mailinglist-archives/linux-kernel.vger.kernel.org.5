Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4557ACDB7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 03:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbjIYBuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 21:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjIYBuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 21:50:37 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9004BA;
        Sun, 24 Sep 2023 18:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695606630;
        bh=r1RErhCOzc4Zba5XkLN3yKBLxn9U/qude/wkr/IWXfE=;
        h=Date:From:To:Cc:Subject:From;
        b=uoZbwByVcGgiIdJiSmLNuso8n74kLZXILuwtkMEmeldEg3hMaB+mDaBh8Gy4lqUeg
         bpQWr6BZGf0+EBoEykRm/ABt56l5AmAkhBsMQkAU4zrbLsOXAq1EKW7i2RytI2xxEG
         1LBS2t4wqeCdJQNFU0Gz8Ckh8IVUp9tT+pDxasvC8TMraYN/DZgP6gIUqXlGs7rwy8
         5UJ92dhrSGcBUE3rWvsqjF3V4P6GDTqyb2bJqJmqJvmQaAQqtSQZtXAY9Z8o/vJaTC
         BKwwGjgfZYyElOrPVBUU4wwUmOfGk5uIh3LKWTw10r0mBu2lRsISXYMB7WRx3VQ0TJ
         tXm7KFIGruvMw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rv5Rp3H1Dz4xM6;
        Mon, 25 Sep 2023 11:50:30 +1000 (AEST)
Date:   Mon, 25 Sep 2023 11:50:29 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.cz>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the btrfs tree
Message-ID: <20230925115029.360eda49@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/PVdAF2MZurao8v8Dqs8r6P6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PVdAF2MZurao8v8Dqs8r6P6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the btrfs-fixes tree as different
commits (but the same patches):

  206d0430707b ("btrfs: properly report 0 avail for very full file systems")
  2afcde54d137 ("btrfs: log message if extent item not found when running d=
elayed extent op")
  43b96807089b ("btrfs: make sure to initialize start and len in find_free_=
dev_extent")
  bf5aa1d8054b ("btrfs: initialize start_slot in btrfs_log_prealloc_extents=
")
  c2243b212bee ("btrfs: return -EUCLEAN for delayed tree ref with a ref cou=
nt not equals to 1")
  c363b4283ef5 ("btrfs: remove redundant BUG_ON() from __btrfs_inc_extent_r=
ef()")
  d299419f7fb7 ("btrfs: reset destination buffer when read_extent_buffer() =
gets invalid range")

--=20
Cheers,
Stephen Rothwell

--Sig_/PVdAF2MZurao8v8Dqs8r6P6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUQ52UACgkQAVBC80lX
0Gyhdwf+LnrTtGGND1KiiL5S8bljUdRuAAmmbu43uTIcdGr9hOIv8m2kgK/HZnx3
VLaVg1MKsXtzWGMO/N34+14gZCKBBf+rMnKNcEykVmsWYC4PcrmXbH3+2xudjqw+
SmLPuEd6us381k09WjxSxKZABOHili11f9DbxafhujUpNebbS6sAEW6cmCwTxIJF
kG5ZHc4QZAukjlmfcwvz+z4FtbDNBI2xD4IXaSZnJTaLdoINwNguO5JVhomc41r0
4+10MzS2TtBqX+LoK1v0Jqzd+o87KcQ4SC/IVt7Gix7mGuMavRqZxpMtHF6AkfYu
BuoHtl6frcwKDpLRO92ZeO7Lx3EJEQ==
=x8ZK
-----END PGP SIGNATURE-----

--Sig_/PVdAF2MZurao8v8Dqs8r6P6--
