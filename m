Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF1B7CD293
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 05:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjJRDO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 23:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjJRDOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 23:14:53 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F664FF;
        Tue, 17 Oct 2023 20:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697598888;
        bh=QbZn2EiFiwDHvx9wHeKqwFSiKGXTr0ePiOBTZ5seWUc=;
        h=Date:From:To:Cc:Subject:From;
        b=SMXakDFs6fabPTwv6hB6XhmMoUHTfiPeSJobT38yAeuypa+d96n7QSxt+TXkcxABd
         UlYW0rfSlVbdKkdFSC/Ab7NhmLkTiuIvpDvYZMjYeG45jIUjj6nRzvYvg0dDvgSO1i
         8dpb2bsyObdnrqan/LV+TiTdoTpivtIYzKDNyA8TOs+GF7HGHkSg816ShxTMWA71mO
         mPV3fuxtFtwam7tcPGfkIZii6hS9ShcZBa04JqtGrISORcYdosoL0FQC6lTOfOAo/C
         QEYeqyHeZumWlnMXg8dH6/vZN1PDCLk8E76/ljs6A3SYENaM+STQ3Bkee7Nu9O66jg
         lHDbXNR3g6CEQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S9GDS2gRXz4xG4;
        Wed, 18 Oct 2023 14:14:48 +1100 (AEDT)
Date:   Wed, 18 Oct 2023 14:14:46 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the bluetooth tree
Message-ID: <20231018141446.19fa9b25@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cACtJAbkjx0tUGxLHQ=GT23";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cACtJAbkjx0tUGxLHQ=GT23
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the net tree as different
commits (but the same patches):

  0ebb3699b15d ("Bluetooth: vhci: Fix race when opening vhci device")
  19cb846d0b71 ("Bluetooth: hci_event: Fix using memcmp when comparing keys=
")
  27eb5c50277f ("Bluetooth: hci_event: Ignore NULL link key")
  354eeee644a0 ("Bluetooth: Fix a refcnt underflow problem for hci_conn")
  4025ddca4aa6 ("Bluetooth: ISO: Fix invalid context error")
  47d973dff74e ("Bluetooth: hci_sock: fix slab oob read in create_monitor_e=
vent")
  505fc3b0f198 ("Bluetooth: btrtl: Ignore error return for hci_devcd_regist=
er()")
  58250a6dc86d ("Bluetooth: Reject connection with the device which has sam=
e BD_ADDR")
  81a220a6c891 ("Bluetooth: hci_event: Fix coding style")
  a86e2622de15 ("Bluetooth: avoid memcmp() out of bounds warning")
  bbb24b6a681b ("Bluetooth: hci_sock: Correctly bounds check and pad HCI_MO=
N_NEW_INDEX name")

--=20
Cheers,
Stephen Rothwell

--Sig_/cACtJAbkjx0tUGxLHQ=GT23
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUvTaYACgkQAVBC80lX
0GzlGQf/bL/iSjta1vSF2oQOCx5paQ+RstdJneX5vCPU3qxOCvSLepYzEkMEbpn9
O+rwIADJ1SeO/OCVV4z2onCGL9JjKB9CJDm4I/dX/ujago5mbj/F81VMlg8Bewqb
ukp2S8XE+hA9TZb3t6ATC41hbNHd8+9/FIQD0dWCZHtc/wcmL/O6s/0mDxf9tg3R
CQsdm+GofwPlPwpSESX7drX/SDjaIEsqu3AGNqePGOW1zoc+7Ege/ovJjFqcfo+F
Rcc2HkpW72C0zzw1hWm/0ywUT4a8tfhxfUGWegZuRhB2iS8RaHUQLe0nDWi0yyD8
rzp+dukOSfs23f1RMS57/Dcuy5BsiQ==
=Ad23
-----END PGP SIGNATURE-----

--Sig_/cACtJAbkjx0tUGxLHQ=GT23--
