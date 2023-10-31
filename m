Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7537DD92E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 00:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbjJaXPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 19:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235302AbjJaXP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 19:15:28 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F0BE4;
        Tue, 31 Oct 2023 16:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698794123;
        bh=/76Xugrew87xiLqcZFqXvqoM0IUWyml2vPqmzgwbdsg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=r6yChABplSocrvD2adOhza3xhSf9fQD3NOD4auFXeog+qFTYbjqGVZEVyJMfQ1b4P
         ZsMg1OKXVq+G3uR9006h9Fh11wS/2OKIbvSVTT6ncFyklS5MkZZcBSxxvxPAicU4gd
         MO8U4nChIoN998f6EfWQh9fY4AmET5hAfcgyyzxq4J2tdfUWj+6bMb5dmSiRFVJrpO
         yXy8MtWnFmUkDNbEDVK8doRFM6sdy5Zgz870cEF48CuKc6LSytzTDrQuNOvcbGIabF
         fH7q/n7zBamp9PleAKJI8M/0yPQQTQfbXZ/j0b1V/DzfYsMZg3+EUvE3yQOqnbtDjc
         XBy49MznqPnSg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SKmFk4rbGz4x1v;
        Wed,  1 Nov 2023 10:15:22 +1100 (AEDT)
Date:   Wed, 1 Nov 2023 10:15:21 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Muralidhara M K <muralidhara.mk@amd.com>,
        Suma Hegde <suma.hegde@amd.com>, Vicki Pfau <vi@endrift.com>
Subject: Re: linux-next: manual merge of the tip tree with the pci tree
Message-ID: <20231101101521.1d28e795@canb.auug.org.au>
In-Reply-To: <20231009134701.17ab655e@canb.auug.org.au>
References: <20231009134701.17ab655e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9JZx.ip1=.jBiTY=3Q3Y8PS";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9JZx.ip1=.jBiTY=3Q3Y8PS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 9 Oct 2023 13:47:01 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>=20
> Today's linux-next merge of the tip tree got a conflict in:
>=20
>   include/linux/pci_ids.h
>=20
> between commit:
>=20
>   7e6f3b6d2c35 ("PCI: Prevent xHCI driver from claiming AMD VanGogh USB3 =
DRD device")
>=20
> from the pci tree and commit:
>=20
>   24775700eaa9 ("x86/amd_nb: Add AMD Family MI300 PCI IDs")
>=20
> from the tip tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc include/linux/pci_ids.h
> index 3a8e24e9a93f,91b457de262e..000000000000
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@@ -579,7 -579,7 +579,8 @@@
>   #define PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3 0x12c3
>   #define PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3 0x16fb
>   #define PCI_DEVICE_ID_AMD_MI200_DF_F3	0x14d3
> + #define PCI_DEVICE_ID_AMD_MI300_DF_F3	0x152b
>  +#define PCI_DEVICE_ID_AMD_VANGOGH_USB	0x163a
>   #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
>   #define PCI_DEVICE_ID_AMD_LANCE		0x2000
>   #define PCI_DEVICE_ID_AMD_LANCE_HOME	0x2001

This is now a conflict between the pci tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/9JZx.ip1=.jBiTY=3Q3Y8PS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVBiokACgkQAVBC80lX
0GwJUQf/ULq/xFm5IJ2GvxVUWIgtuit7oh7nVtXXrHo+LfhEdzAIobfscbvjNHtW
ktQjq3VlzHHim9TssmTxNMX95tl9OvoCiyC+J77hqFOEo77pA9gx/Cq35c8y9bdH
NW4wNNf8IMY7512xXhn97wGKG7AuQD/DUpYJeZstPMJq6UNuOLGeAvGoXD0XNQFB
/59E6UqZ0g3KwVVuvc1p1m18Fla0kJhidKxK09yervnGDYDFbUcNF+wJQ3RGGFGN
8Ei4y8fMwWsHqqPVxtiQqB2/Gg9xmsAB/Z/p4m+l6OrKjCefoSC/KvPb7z/bJAZn
Tq9lPXqJ8u9KAI6JJHQRYB24lNzUSw==
=AgUB
-----END PGP SIGNATURE-----

--Sig_/9JZx.ip1=.jBiTY=3Q3Y8PS--
