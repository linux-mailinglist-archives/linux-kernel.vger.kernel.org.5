Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32AD7D2765
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 02:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbjJWAGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 20:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJWAGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 20:06:12 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD89AC;
        Sun, 22 Oct 2023 17:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698019558;
        bh=KxLfW+ZtEAVbPJoTJUsnJhN3cdkO2yMH519HclBRn1k=;
        h=Date:From:To:Cc:Subject:From;
        b=lnL2qXpwJro9weM9wgM4dSn5sC3EWQmPQVsknY1tyuzuitQ3m2bGhCuegyd2O2By6
         AQSSQ90CFFNGdezhEKOTSrWQKuss2yKmjrYz3WGSmdncegYYHl2Ih7aKbIEzxou1mz
         0yurEI9VkeF+kbte+L4kX4jmf9iTNbDFw95rjFHlvDiMki1l6n4zpmG4S1H2vsGpFG
         KDARiInwgLcWN6WfOO0x/LA13GIzEziAd4q1KXvQl8m0EeaFmO905grp+lhYEqxDZ9
         +/qupYyBng+xjTTQvA0F3BU6BSuVPOvCO/DYNlP7wk6mxMANedvOQLi1FcZFeUK2d9
         ZVCB+BJaFyS/A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SDFpF6qkVz4x7q;
        Mon, 23 Oct 2023 11:05:57 +1100 (AEDT)
Date:   Mon, 23 Oct 2023 11:05:56 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>
Cc:     Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kwilczynski@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the pci tree
Message-ID: <20231023110556.6f704b95@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/B9hnPTZ7Heo/zFk3OY83G_4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/B9hnPTZ7Heo/zFk3OY83G_4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the pci tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

ERROR: modpost: "dw_pcie_write_dbi2" [drivers/pci/controller/dwc/pcie-rcar-=
gen4.ko] undefined!

Caused by commit

  8227bf7a81e6 ("PCI: rcar-gen4: Add R-Car Gen4 PCIe controller support for=
 host mode")

or

  d3c54d8ba855 ("PCI: rcar-gen4: Add endpoint mode support")

I have used the pci tree from next-20231020 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/B9hnPTZ7Heo/zFk3OY83G_4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU1uOQACgkQAVBC80lX
0GwYRAgAigrZ33bmhiyrP5YrQUdqJwHq6430sN60nGKaFZlMbq4/h9yp5SRU3x/M
cbt+hhiuROV8JmcsiJjGnICVLFCOZcELKGMc+KwFQ1tGP9JvoLnyoKnRRj11lmse
PaQgoIx/nknH6Ui0dz9vyHXhupvEiYDtCB4TpIHvSz758rbfSuWulMVuxALW6HAX
bNTBMn1Z/TIsGsJkIQz2ynTl46kX/SfjaVtVPa9BoY2j7kDHHdasxhELPIiuhV8P
28/mBhc3oioFwmukU8YvwKKLtCeRjl5rZxlEAaJhoSPrKw5zslyJK3MQ3s6HF2OQ
e4BCxDbF81HWP5Fy89rbnpnEGcG00w==
=encu
-----END PGP SIGNATURE-----

--Sig_/B9hnPTZ7Heo/zFk3OY83G_4--
