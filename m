Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BD275E5A2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 00:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjGWWol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 18:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjGWWok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 18:44:40 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390AE1AA;
        Sun, 23 Jul 2023 15:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1690152277;
        bh=FFJbRmWPuFn+hHeXw5R3llNT9JS3TxX+Z3Uz0Aa1ehE=;
        h=Date:From:To:Cc:Subject:From;
        b=GhtUV9N9pUteSBkU2oRhZ82icl/XWFvt+j82XnRqwOAcr1ZH9WO4Yo7R0Q616pmhE
         oF2xCXOuAQbrEvZ9NkwbcCNeb0rqXAJbbTHn5CFaWesQFQl8wXgcJHeSN1bjW81ZFe
         wNgm358325hB6d/ePa8m4j4la+IDo8Z2hsA0cHYbfvZCE7tYCMtNzYhuQUYWZhPuAv
         lk99lrw9+oJjl+TB/4Mh6G6L+fNmF9jl2pjXQn5vufcPG8uHppsb9BBNbKWpxkcn9d
         0wyxj0jNlCoHEvWdako0eT5Wh2HlL/YCqs7aaH72cWl78EoPYvso3DnGAZMH0e81uZ
         nn1CvDE1QDLKw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R8JJP2DvGz4wyC;
        Mon, 24 Jul 2023 08:44:37 +1000 (AEST)
Date:   Mon, 24 Jul 2023 08:44:36 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the bluetooth tree
Message-ID: <20230724084436.0ebf8cee@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Onjev0jTMukVx.TVM9PB=du";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Onjev0jTMukVx.TVM9PB=du
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  1097b9b5a14b ("Bluetooth: hci_event: call disconnect callback before dele=
ting conn")
  1a43e2538e5a ("Bluetooth: ISO: fix iso_conn related locking and validity =
issues")
  2a9bc19e9d39 ("Bluetooth: use RCU for hci_conn_params and iterate safely =
in hci_sync")
  45018a3caf9b ("Bluetooth: coredump: fix building with coredump disabled")
  5beaf842b507 ("Bluetooth: SCO: fix sco_conn related locking and validity =
issues")
  64068b2b948a ("Bluetooth: MGMT: Use correct address for memcpy()")
  752a4a227d35 ("Bluetooth: btusb: Fix bluetooth on Intel Macbook 2014")
  7728d4d43b78 ("Bluetooth: hci_sync: Avoid use-after-free in dbg for hci_r=
emove_adv_monitor()")

--=20
Cheers,
Stephen Rothwell

--Sig_/Onjev0jTMukVx.TVM9PB=du
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmS9rVQACgkQAVBC80lX
0GzuZggApFWUB4/v7gPrmnlA8tLtQ53PtRBv20gSH59Ml7t6PVON6/XDDLYat8QX
znAtyyOFXxFQlu8o74t25AACBmkDEQInlcUXa6qWwe9VetmqXmC8xLy66AA84uEA
88AgzETsuCSRz87jpxfOvxyRNSn8d6sklJBQuFVrgDODdNnuqyL1VvSwS0BQ0Vuo
udYu3s0srIztbjsRmYJUtTYa5CHMfG30sj7KSTTllwO0aivYuHzQOA031XzOSyBI
HJW9fgj5x4iZdXSPERMgxk30xSlqQ7oLeiCwGZzP/cMv9mXePAhxf5nREd19PgZt
8S3NpBkY4tszSg6j7A/a+6LI/HO8rQ==
=vQNY
-----END PGP SIGNATURE-----

--Sig_/Onjev0jTMukVx.TVM9PB=du--
