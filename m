Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1BE7CEC60
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 01:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjJRXyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 19:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjJRXyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 19:54:11 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2D1B6;
        Wed, 18 Oct 2023 16:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697673247;
        bh=pZQOYLEmRp8XKzGG50czVgLtAv6PDRjCUr5lNelzZ8c=;
        h=Date:From:To:Cc:Subject:From;
        b=nURqdBbmIVMioDaEGxHTL4lQj2F6ybn0cMryZ1cWg9IaFXGFGs/GmIrgf+xiGKq/h
         YK5iToczyJyI71Jjo2J3htkO0mpZYb4UuUkQovx3n8TFjy+hpGMH3+ozTwSEr2Mvo0
         9Jd26EW4MsEpUTsu00zVsR7uxDclo3h6nkzHP/lIkaifagfJT/VFt2JXwRVBa6TaRw
         tC/uVQOfO28m7Y4lHnzXpLO+M4iTHOp5nxDMCIuwLYQLDx7MifP1FRUUdgqHBVFg9I
         ieB1FbS+1ZW+gzYPQryRY0Od+yzXrPEyyhbYhYESG7+IRzUtANZojQXFI/isueTXAe
         Lj0xf3vh4rxRA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S9nkQ4pbcz4xNq;
        Thu, 19 Oct 2023 10:54:06 +1100 (AEDT)
Date:   Thu, 19 Oct 2023 10:54:05 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the vfs-brauner tree
Message-ID: <20231019105405.6ed2f53d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Nu_IY3DkkME3u+LW1b.wP+7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Nu_IY3DkkME3u+LW1b.wP+7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the vfs-brauner tree, today's linux-next build (x86_64
allmodconfig) failed like this:

ERROR: modpost: "bdev_mark_dead" [drivers/block/floppy.ko] undefined!

Caused by commit

  3b97609801fa ("block: move bdev_mark_dead out of disk_check_media_change")

I have used the vfs-brauner tree from next-20231018 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/Nu_IY3DkkME3u+LW1b.wP+7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUwcB0ACgkQAVBC80lX
0GyHCwf/T8OQI509pNKulGpzrjmPxh1Z4+D7EOeldMqyONxSpmGI2ZKlwFIXcV9C
kdjOo2h+WslADyuAZYDGkZvvgzEyjWdZzWQzPpAFE0WYYfx3/Xu/K6TsF6LyZoOZ
cVuBs8zC9KrVOVECvAiC6aVESubXXq/NcbEDMzEzzeKpFSf1TsHBwg4+6ECw3VjH
JwJ7PupLQWwgIvLN7o+iZ2eolNoey03B/ldHSFsmQTNRhW4zyaUCIPaty/GcIIIp
gLtj6227MkyktJV/PSxd5SRiHPNpWDouxZH9n3OyFwlwGs44XiPDR5TfVGoesTHZ
Yp4VuqhmMkUx7YzxTG0vlq3ZfFnP5Q==
=Rimz
-----END PGP SIGNATURE-----

--Sig_/Nu_IY3DkkME3u+LW1b.wP+7--
