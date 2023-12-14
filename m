Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D468123E8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 01:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbjLNAam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 19:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjLNAak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 19:30:40 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1023DC9;
        Wed, 13 Dec 2023 16:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1702513844;
        bh=+73VdIH+l1vbZl3wpgzGVdBkqDMH+xbOJV9chvjsKfY=;
        h=Date:From:To:Cc:Subject:From;
        b=qtncVbeCc3b5GRiDeDtwdXtE3IYjreXmcz8XK3opugiLBSqAnJ7uySiqlmF2tEAQd
         Yev4TBHADoYshNogSfM8N5XwHXqj7oNnBj6Dfq3WL5xtDWzTyRtAQ+gQASvOfQsKAG
         GxlWnkIzS4IJttI3pwOyvg/FhLQ68BrkuvWInLHBHynhtvaMSVZfgqQrZlbhtp+SZz
         EY9dsA7eZiYR87SvfMi8Fwmip7aGcv1XzymTINlfvN1tuPIu3nVvpVeLMs+Pv6MISE
         9jVLg8Exlc+EMsHD/0cq+VWAPpmzMnNVR1fgmrQ1qkmiPYY6l/ijZNPWmERW7m+AHY
         ZwL/macoGYxOg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SrCtq6gflz4wc8;
        Thu, 14 Dec 2023 11:30:43 +1100 (AEDT)
Date:   Thu, 14 Dec 2023 11:30:41 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Chan <michael.chan@broadcom.com>,
        Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20231214113041.3a0c003c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hEnblnRG.vC/RW3TIeCOmTM";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hEnblnRG.vC/RW3TIeCOmTM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c

between commit:

  bd6781c18cb5 ("bnxt_en: Fix wrong return value check in bnxt_close_nic()")

from the net tree and commit:

  84793a499578 ("bnxt_en: Skip nic close/open when configuring tstamp filte=
rs")

from the net-next tree.

I fixed it up (I just used the latter) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/hEnblnRG.vC/RW3TIeCOmTM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmV6TLEACgkQAVBC80lX
0Gyduwf/ZqPVHbvKCTdr9wvSTpKY/zAYHIZoyTVPexbE1O5RAqd4axotWLeiL/hB
0zFeE6zT8jdSENUZPr/Qyxb/XSLC3p+BHA8UZu3UC7wDaJcLqo5xPfEku2kuG/0g
gbVy5OEi9aM9c1r+jiC0rcumsK7NHg7/YPoIaF79yXujf8VvXd9aq+rA0at2mupi
ZsdLMMGm0ZHFEU/tPEdIQ63AFOvd2F+jNlKmN7OsIvFGYpEYL8KNgcKRadQWcWpE
dzfqq7Gpkplyu2HFrrtfM72O+Or2+7y5+StBvzG/KS7m9Ef3hgR7I7lmoF+W/4p5
MpDbn6EogDMmrHp6UUmQTJ72RWbxgQ==
=ymwH
-----END PGP SIGNATURE-----

--Sig_/hEnblnRG.vC/RW3TIeCOmTM--
