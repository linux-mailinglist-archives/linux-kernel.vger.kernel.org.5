Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C4E7D46D3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 07:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbjJXFOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 01:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjJXFOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 01:14:31 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A683111;
        Mon, 23 Oct 2023 22:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698124467;
        bh=wzR8CLBa7QGBbZgrmvfs3ZY6gA8A24eEIQIAttMtqjY=;
        h=Date:From:To:Cc:Subject:From;
        b=etfA2Gn1XPFyC6LbBRzXA0IRy+bC1jbS/BDzAyTV14UTj/6VrVVRGNHGErlZnHWzq
         SQKIErWm8MgrpysFWdEoOBB10W7M1vPXlYoll1QmXpYFUjvvuF4ht1BBp1HACHHN6m
         /YerYZNqtHjIUXL/pOhmTTWF1g91ErIAQcdUgh2l28BhnRZPXown2VCOyA+jzwd/Zp
         8qSlsSiPjdXZ4mEeVRgSvBQvkeiuVwbj3G8xOxCjHXavhCDvRaQbO2lJ7Q1qtarPEs
         4lXSIbpXIi0KAv04AtTA0a5gSDIrAkjSvIslKTHIrbXgo/x7Mo3mrDKjvebWXQZJbP
         X/mgeSriCS6dQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SF0bk6RNbz4wx5;
        Tue, 24 Oct 2023 16:14:26 +1100 (AEDT)
Date:   Tue, 24 Oct 2023 16:14:25 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>
Cc:     Ilpo =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the pci tree
Message-ID: <20231024161425.0b382725@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/c9D.sJVtCE1BbXKOv91s9LP";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/c9D.sJVtCE1BbXKOv91s9LP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the pci tree, today's linux-next build (arm64 defconfig)
failed like this:

In file included from <command-line>:
drivers/pci/controller/dwc/pcie-tegra194.c: In function 'tegra_pcie_ep_irq_=
thread':
include/linux/compiler_types.h:435:45: error: call to '__compiletime_assert=
_497' declared with attribute error: FIELD_PREP: value too large for the fi=
eld
  435 |         _compiletime_assert(condition, msg, __compiletime_assert_, =
__COUNTER__)
      |                                             ^
include/linux/compiler_types.h:416:25: note: in definition of macro '__comp=
iletime_assert'
  416 |                         prefix ## suffix();                        =
     \
      |                         ^~~~~~
include/linux/compiler_types.h:435:9: note: in expansion of macro '_compile=
time_assert'
  435 |         _compiletime_assert(condition, msg, __compiletime_assert_, =
__COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_a=
ssert'
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
include/linux/bitfield.h:68:17: note: in expansion of macro 'BUILD_BUG_ON_M=
SG'
   68 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?      =
     \
      |                 ^~~~~~~~~~~~~~~~
include/linux/bitfield.h:114:17: note: in expansion of macro '__BF_FIELD_CH=
ECK'
  114 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ")=
;    \
      |                 ^~~~~~~~~~~~~~~~
drivers/pci/controller/dwc/pcie-tegra194.c:498:29: note: in expansion of ma=
cro 'FIELD_PREP'
  498 |                 val =3D 110 | FIELD_PREP(PCI_LTR_SCALE_SHIFT, 2) | =
LTR_MSG_REQ;
      |                             ^~~~~~~~~~

Caused by commit

  18ca6c2c2d0e ("PCI: dwc: Use FIELD_GET/PREP()")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/c9D.sJVtCE1BbXKOv91s9LP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU3UrEACgkQAVBC80lX
0GxwkQf9FdfHiiEqqE90vNjgsYiESrccCbTsycZ+0vfWkuIrBgkVcQ2nm6quxaXv
uiFaHAOOJLLRvEBK4baZxvC+YpjXv+2L80vmVCLwjgJQx4trfV7myjM8SkPAYPe2
BFVmPi6hE1jaSbLZR8y+O9d3bcVHk9eEalIpRaZWuHyyRuFPDU6qNXLfnDo2iBOV
Un5fP8hF/ljHfJO4wWSyJNBP8l2rynSbV+yj2ChMwzvpbMLM90ETdEmJiJ32uV6E
kRxCTWa2TyEixr6quRfb/bGBKvSmijCTpneqDSA5PujHDzb+o7BfOmPBU1KOGsAI
NttfMI9fI5JZoLAQC+vKycUa4nVANw==
=HnH0
-----END PGP SIGNATURE-----

--Sig_/c9D.sJVtCE1BbXKOv91s9LP--
