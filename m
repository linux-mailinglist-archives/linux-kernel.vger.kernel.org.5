Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56A47C9E74
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 07:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjJPFG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 01:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjJPFGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 01:06:25 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E391AE6;
        Sun, 15 Oct 2023 22:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697432778;
        bh=uiCy8bAS/UGuONXr3DvHcoElnX27qF9wKMRx4Bt6I4E=;
        h=Date:From:To:Cc:Subject:From;
        b=sciHCCP5hlIpJZWhP70dsKFm+gvtoPZ84kjdZn62w0Lb1KhLTocVRUJnSnvv/vkUJ
         O6wPoxxOdFPMQgFkpIaBRqzkxMvMnJ2kCkqSpMQ5q6Kxmeanx7EhTATBiQA4UGXpUg
         WbtuLN3mb9JbpiFm5R/vENfsWf9ofvhnXDnsShGe9oasDag2jdlHKIQrc9UPZC22dt
         Qk48RgLjPzbflsz+FIOGSePPZbHoPVRWr0eNI6/9FTm01Dchqh2sWsiCSR4BlB6K0X
         lLQwWm9QTtiUY+rxEiverWodV/ZltNQ9a4PL9h7UKD134JWojC3V7PWlrqwcp6tx/0
         rP2Yo/DeelC7w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S84p23TJhz4wx8;
        Mon, 16 Oct 2023 16:06:18 +1100 (AEDT)
Date:   Mon, 16 Oct 2023 16:06:16 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Mike Christie <michael.christie@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the scsi-mkp tree
Message-ID: <20231016160616.0286cf0c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vaUgDsH/AvtHaNTqYqpmzyv";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vaUgDsH/AvtHaNTqYqpmzyv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the scsi-mkp tree, today's linux-next build (htmldocs)
produced thess warnings:

drivers/target/target_core_transport.c:1930: warning: Function parameter or=
 member 'se_cmd' not described in 'target_submit'
drivers/target/target_core_transport.c:1930: warning: Excess function param=
eter 'cmd' description in 'target_submit'

Introduced by commit

  e2f4ea40138e ("scsi: target: Allow userspace to request direct submission=
s")

--=20
Cheers,
Stephen Rothwell

--Sig_/vaUgDsH/AvtHaNTqYqpmzyv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUsxMgACgkQAVBC80lX
0GytuAf/dyuzARu1j0hh2mdLCRqRJOFSBhW6ZfmyCkCXT8ZmXjpNZGdhUzC+bNoO
Z5aeO4WyMoZKGWT+K371oatZwbjkQJS47Vt9kC8RGnE+6drTSkLMCMs3akQsUlo+
rFB3Zt4BuW6RkTZmoHUjQwkjGA/2tfWshr4OTcgLecZZdmyjUjRSi6t9/V1jBSVO
dFeC3Ggmb/d4xsR+wF8RRgVEJlthJpUcUOHJdj6J9phbmCuFDegGKHTJpe5cNM2Z
eosJTdq0cyfItaWCcm3BRL4stx4Mz1QvHJA+picyiMDei7dXIsqbwZGOczCoZ5NX
w5Vv7KLlnL3ncBtkwzvPU9SZbxC5yg==
=ApUL
-----END PGP SIGNATURE-----

--Sig_/vaUgDsH/AvtHaNTqYqpmzyv--
