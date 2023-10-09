Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E59B7BD20C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 04:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345028AbjJICrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 22:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbjJICrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 22:47:12 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6E6A4;
        Sun,  8 Oct 2023 19:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1696819624;
        bh=uAjQtozBaePXZ1td6c6A6uLg10Aec3ih9uhNvEBYF+E=;
        h=Date:From:To:Cc:Subject:From;
        b=bjRXJyn07jgHYigYoMEJkq9TmTol8hKRyarJd77UoPVu35biv/NHXTWiSyVIvlnw4
         eeIg4G3Nn9yvMjHICCchYPXcCdBFdZyDtucgdTUoh5DCCRmoZrFNQxAwzspnvK6/1L
         oF+P/6ZH/M6VLKZ1tauH+8mtfHZ0R/7UsgNSMfoyuqkDrrBvivWX6f7w6Mm68u3sCH
         U2f13NcvwEQilUXlPGUiJZSwD2fqwU8HINTTTC1YsB47glQX62cklGXOPt6flYLL1P
         WoockzU74nHkXmNfdJI7PU4skzwR86DH2a8ENktLt5aBLV5mf9+vqxF/eLIiNNgy8k
         fHEXG9UfmxDMw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S3k2Z4kHRz4xPc;
        Mon,  9 Oct 2023 13:47:02 +1100 (AEDT)
Date:   Mon, 9 Oct 2023 13:47:01 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Muralidhara M K <muralidhara.mk@amd.com>,
        Suma Hegde <suma.hegde@amd.com>, Vicki Pfau <vi@endrift.com>
Subject: linux-next: manual merge of the tip tree with the pci tree
Message-ID: <20231009134701.17ab655e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/YC2iVetli5G3AUnxDwC4D9H";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YC2iVetli5G3AUnxDwC4D9H
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  include/linux/pci_ids.h

between commit:

  7e6f3b6d2c35 ("PCI: Prevent xHCI driver from claiming AMD VanGogh USB3 DR=
D device")

from the pci tree and commit:

  24775700eaa9 ("x86/amd_nb: Add AMD Family MI300 PCI IDs")

from the tip tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/linux/pci_ids.h
index 3a8e24e9a93f,91b457de262e..000000000000
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@@ -579,7 -579,7 +579,8 @@@
  #define PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3 0x12c3
  #define PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3 0x16fb
  #define PCI_DEVICE_ID_AMD_MI200_DF_F3	0x14d3
+ #define PCI_DEVICE_ID_AMD_MI300_DF_F3	0x152b
 +#define PCI_DEVICE_ID_AMD_VANGOGH_USB	0x163a
  #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
  #define PCI_DEVICE_ID_AMD_LANCE		0x2000
  #define PCI_DEVICE_ID_AMD_LANCE_HOME	0x2001

--Sig_/YC2iVetli5G3AUnxDwC4D9H
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUjaaUACgkQAVBC80lX
0Gzn/Af8D9MdpLiMde1xuXcD9H+cQoRqy5CFZAZ8Fi5BLKDstBmUNvtjZ+PUsEsK
u2uSZ+UanHjM3CL1Eig/VsV/475HUb6u9Bk5m5gegbV/VywwVvWzIDWIDNno4b0r
C0kT2WgkS6K62rUHA+Bad3343Q/oopxCS2XH2xNUAo76NzxWafo8NIHNJkv9izH0
P0/w5GzmlI/5IqunrkUKHMBDM6Nc72Ccjlcyxr8IiISpxm1VohsxheD7oAax1cl2
C5ybVaqevWChv0R0IPiEHuVtuCkpKkV7lmUBNYjWd//a/wxWrblO2fsMK4XcOQP3
ODjE4878OnnWkEjgp2QEoHeOj5g8XQ==
=Pou1
-----END PGP SIGNATURE-----

--Sig_/YC2iVetli5G3AUnxDwC4D9H--
