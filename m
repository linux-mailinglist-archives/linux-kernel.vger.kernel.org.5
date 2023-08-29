Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7073978BC7D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 03:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbjH2Bv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 21:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbjH2Bu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 21:50:59 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440A718B;
        Mon, 28 Aug 2023 18:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1693273848;
        bh=gz+SpYsJZoNJIbXhISglKVKiezAx/o2Szzs3ikQzhcU=;
        h=Date:From:To:Cc:Subject:From;
        b=ZkNRRuvwTxCGbQ+aJ6OE0jSlwOpBgEbDoPqjHSBIPKhrFH5tkGbuq+Be6yd55/fen
         Z2lmVcMT4Svjp0e/UXF/FFyYiMeTZFy7WXAOaxx62GpfhIdVLz0lLczgHFBHwJ+FPM
         ox3YKFzP8YEap078MUGM0yRbaYjK32V58cTGdWpayxYsNpTQUDWFJF3ZNVe6/hQ2+H
         JlnE5u1xobGs8ziNdAuaQXjsdgxmXPnGj4xEmS7sqEBeYdKN2cTdi/PAZamxflBPAy
         NLBb/m8IOUguHJ2m2WxBiG39UHa5a/522VwrBst2cuzIfA9IUWTUY0nDf2UzQbpF89
         FioRY2Sx4xYPw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RZVkb4mg8z4wbP;
        Tue, 29 Aug 2023 11:50:47 +1000 (AEST)
Date:   Tue, 29 Aug 2023 11:50:35 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Herring <robh@kernel.org>, David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Networking <netdev@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Harini Katakam <harini.katakam@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Pranavi Somisetty <pranavi.somisetty@amd.com>
Subject: linux-next: manual merge of the devicetree tree with the net-next
 tree
Message-ID: <20230829115035.3ccb367a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1jy1a8atENSjDEZREbKmQP0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1jy1a8atENSjDEZREbKmQP0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the devicetree tree got a conflict in:

  Documentation/devicetree/bindings/net/xilinx_gmii2rgmii.txt

between commit:

  c639a708a0b8 ("dt-bindings: net: xilinx_gmii2rgmii: Convert to json schem=
a")

from the net-next tree and commit:

  47aab53331ef ("dt-bindings: Fix typos")

from the devicetree tree.

I fixed it up (the former included the change from the latter, so I just
deleted this file) and can carry the fix as necessary. This is now fixed
as far as linux-next is concerned, but any non trivial conflicts should
be mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/1jy1a8atENSjDEZREbKmQP0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTtTusACgkQAVBC80lX
0GwpiAf/f0NNtmPKnpEuhwAMJSlN1G6vSXuy5R1y7u9yGZDt6R9pw27y83y0xHkM
GXxrddFz1ETqnWPPhK5y0XRGEdNhFTJKReoKfg79pNbBzoMtbYAQK6MlePYlpV4w
/mqq9h0acWEAc825o20Br9cFOvK844a6xvGbERj8cMY6WtTilSoqvaP0aNbryLmx
83NiQnJCtwhvVKxjHaYatVq8s+4mWwwXxclLXZStSAvQnnGD6WIcq3HHtxRqt8ys
DKxGSg1Ohf/VTvxfumpXBHhualD2ZeixAxI/yEWe2TRZHiyapTwa/WeR0quxo9Jb
79Je9YlKz3yMJTU/kPWSJ74qxzle3A==
=mnzC
-----END PGP SIGNATURE-----

--Sig_/1jy1a8atENSjDEZREbKmQP0--
