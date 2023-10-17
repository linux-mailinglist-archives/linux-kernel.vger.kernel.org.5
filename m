Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54FE57CB97B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 06:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbjJQEAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 00:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJQEAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 00:00:23 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E8183;
        Mon, 16 Oct 2023 21:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697515219;
        bh=jGDR2Zwbs2Lpc9XLlomjkKU+2fXHEuCiylkyXFOsWU4=;
        h=Date:From:To:Cc:Subject:From;
        b=plD63xHz/he7SkQqaD9ajaigBnrvXZ+AFDmPA4M4YEygijeTZAo+ITlJ3aKY1c81r
         KzYf5vZKsLoWIGjv81Jyv0Rn8hxR5kYaa0RwvHRTCeOhuYfBGstVIVe+vKD2mX6bTp
         fYIbGPZpz/t5MJKPyekfxHNBEpdfNAt5qapxovErMnTNqeuXUmUGqKfN7pV/74Q7gC
         Qtyg2EekDldq48XGdp13uT73jEaEqZxtfI0Ano/+/aUYenXOqPeD7FkkuPUOBctauX
         FFEP0i9QWGL5n7NvB0O/s0Cwxa8S8lbNPs106Lev404MKVoIsX5PpDLbgq/fk3QKSL
         01rRlnT6alxMQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S8gHQ0SmZz4x1w;
        Tue, 17 Oct 2023 15:00:18 +1100 (AEDT)
Date:   Tue, 17 Oct 2023 15:00:17 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Srini Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>
Subject: linux-next: duplicate patches in the fastrpc tree
Message-ID: <20231017150017.01bedf80@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/T.EUqDcZ7D7Pmj4p4dCASHE";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/T.EUqDcZ7D7Pmj4p4dCASHE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the char-misc.current tree as different
commits (but the same patches):

  9fffb8240581 ("misc: fastrpc: Clean buffers on remote invocation failures=
")
  3f01aaeb9fd3 ("misc: fastrpc: Free DMA handles for RPC calls with no argu=
ments")
  c44e396924d3 ("misc: fastrpc: Reset metadata buffer to avoid incorrect fr=
ee")

These are commits

  1c8093591d1e ("misc: fastrpc: Clean buffers on remote invocation failures=
")
  206484303892 ("misc: fastrpc: Free DMA handles for RPC calls with no argu=
ments")
  1c29d80134ac ("misc: fastrpc: Reset metadata buffer to avoid incorrect fr=
ee")

in the char-misc.current tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/T.EUqDcZ7D7Pmj4p4dCASHE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUuBtEACgkQAVBC80lX
0GxqpAf+PrUH0cz/ecWrVJ9h94Wsj23E/z5+p8Mx9O9VTz6MrIBetda3MFLsotfr
RvmhtUVwPZMsLby7n7kC4ZcaUVogUeWBXd3FeqfhOKyeiSll+4QYUUMfiU5NDAi7
/jovF9epWjhEM7f7KiZqK8E/2IBJv8yWcduurZsEzdIQ+pxD2nMzWFqGQn0uFfad
4JRx10vyBV9IdYbr8FzCh/Zqg+xFeSbLb5nymnVjF+1/ccmBnEoW/r+9xE1CIoen
AAB+13RP2X2qNvTz9dwz/D1ZeMdfnjhJh689/72zcUKnK8i7VWhz2N9DB70lCRbt
mLyRkcTw80fkB+T6Tn4bY7WM7CHkMw==
=i9/d
-----END PGP SIGNATURE-----

--Sig_/T.EUqDcZ7D7Pmj4p4dCASHE--
