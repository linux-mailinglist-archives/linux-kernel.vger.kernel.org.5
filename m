Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D29F7718F8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 06:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjHGEWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 00:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjHGEWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 00:22:43 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A11F10F3;
        Sun,  6 Aug 2023 21:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1691382159;
        bh=Lt83dWTxfO6OHECaW4EVfsRsCIdHIfb6eFu8hepTjrg=;
        h=Date:From:To:Cc:Subject:From;
        b=gA+xY+TeQBjTK17RhcUggz3V2lb9KImH/uuGV2bVa0voRJvZ3gv3JLbmxZGf6f2bj
         nq/dmPloRdrwbJRtgPi3dpD8rvvuRg1PqugByp2eyoGw1pLRBdzE+SS55IqEmF9ugU
         aZvlhexsxXqbjBgs1HTlj/cZFi0I00/JjDtuWVfLz7CUYbEgW2ne18N03a04w+o+Dq
         vN/mpymhpMaNqVmWUvSmcvC9SaDzwpBvwUDPN/WqYREtacM8we5pZxOuR3BesLonCs
         qbrAkNSOayBBWyNw8o/x8oUlZjq5SRlpPwLv88VHmYzAKezjESzFbzrlLzcFTcBG88
         BWggxnXcBbb6g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RK37z2N12z4wbv;
        Mon,  7 Aug 2023 14:22:39 +1000 (AEST)
Date:   Mon, 7 Aug 2023 14:22:38 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the hyperv tree
Message-ID: <20230807142238.50616687@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ENx3r7njWSZbED4kaIadS_H";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ENx3r7njWSZbED4kaIadS_H
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the hyperv tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/pci/controller/pci-hyperv.o: warning: objtool: .altinstr_replacemen=
t+0x0: weirdly overlapping alternative! 11 !=3D 6
drivers/hv/hv_balloon.o: warning: objtool: .altinstr_replacement+0x0: weird=
ly overlapping alternative! 11 !=3D 6
drivers/hv/hv_vmbus.o: warning: objtool: .altinstr_replacement+0x3: weirdly=
 overlapping alternative! 10 !=3D 5
vmlinux.o: warning: objtool: .altinstr_replacement+0x633: weirdly overlappi=
ng alternative! 11 !=3D 6
incomplete ORC unwind tables in file: vmlinux
Failed to sort kernel tables

I have no idea what caused this.

I have used the hyperv tree from next-20230804 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/ENx3r7njWSZbED4kaIadS_H
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTQcY4ACgkQAVBC80lX
0Gy/6Qf/bcETFVjbupqMiO1iqrs/3XaotyrgUnZwzSyr5RNgP6XJh3hCAgkMgs7W
QRQtGb1A8SsekjLoFcew27VuPF/xsX6XS2+lvvTKcv6whO4VFSlIo0KPZ01k0QC5
6og+lAdRfpLHgcUnmTdZAbMgF00LhueFyCyJzEKM+eVbz6MmCYUhGDql1AsQGx2J
QDbT7UFseWLV9MYIhsgXZj91vaPdU6fMmgpRr8goTyA/Zcf3MnSHp1AEUZiVgTKA
+kRqIHg10Tfh8dRr7dRMnYJJSaZywiAZTMuNWnl11bIC2GmOjBP6gkvTcZCPE3fO
Zq4RxAjQ/te5dTrbKufVDGvQV1P6bA==
=E+cS
-----END PGP SIGNATURE-----

--Sig_/ENx3r7njWSZbED4kaIadS_H--
