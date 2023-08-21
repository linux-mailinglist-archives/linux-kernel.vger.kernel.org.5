Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE8D7822C1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 06:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbjHUEZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 00:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjHUEZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 00:25:55 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD2899;
        Sun, 20 Aug 2023 21:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692591952;
        bh=QHP4/ScTADNlkdUO5kiWe32Y9eBYZcifYSXLpN4bqos=;
        h=Date:From:To:Cc:Subject:From;
        b=UfN/xatQXFhE2szHQvpPiyZqJNq5Ok7M7cBMxK6CXD7UM8LLKetCk0VJsSDGBsdMl
         HwyHe+aUDCE1/JGRtdG4a13g0dclyitOX9gEEhSs6bj1CSx+uIEOF/ZSPm5EHWFdq6
         sV1quZp1zvyPHBangR6e8j07GITGCu2nQNOnLmsrLb6zzVuwQFqKW3S5FC8ucWPV5G
         Jauf5W1CFMGyk9XOtf9c3z9tAYUXRC7SY3R7ARkYynL3riygSqI8ChFJdLlAza83Pj
         L+uxRu+/LYkiv0VOjPTOVRUOkxjyRlIznB5pGN8qIGDlK5vGjYWo0BEKYDI1BfzI42
         MzqIeqRZH1eCA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RTfYC5LB6z4wb5;
        Mon, 21 Aug 2023 14:25:51 +1000 (AEST)
Date:   Mon, 21 Aug 2023 14:25:50 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Joel Stanley <joel@jms.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: linux-next: manual merge of the char-misc tree with the jc_docs
 tree
Message-ID: <20230821142550.232faf95@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/g9K7Af3c8fXET0tbLeMsDuB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/g9K7Af3c8fXET0tbLeMsDuB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the char-misc tree got a conflict in:

  Documentation/ABI/testing/sysfs-bus-fsi-devices-sbefifo

between commit:

  ebab9426cd73 ("Documentation/ABI: Fix typos")

from the jc_docs tree and commit:

  2cd9ec2a5147 ("docs: ABI: fix spelling/grammar in SBEFIFO timeout interfa=
ce")

from the char-misc tree.

I fixed it up (the latter is a superset of the former) and can carry the
fix as necessary. This is now fixed as far as linux-next is concerned,
but any non trivial conflicts should be mentioned to your upstream
maintainer when your tree is submitted for merging.  You may also want
to consider cooperating with the maintainer of the conflicting tree to
minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/g9K7Af3c8fXET0tbLeMsDuB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTi504ACgkQAVBC80lX
0GwKyQf+JvDAf2PyVGNZsw4Xe6ZslCpnyDfS7YayxzoXqhMneNMWC6VbKWNKjkab
SXrKUUQrIa4C1T+6Pco5k4EDCRJ7ouPYiWItVg3JLVlj2jXCXmv9497PSn/Ll3lX
4Onn+KUgjxBbXJ3qSUBFJIfbYC2wmRLKCQ8cSiXyICfarqUtSfmINIl5l+UFFtFC
Sr9iYT3HWRlaIIKfBdDTyz0vnj2jLqK9zBdpOw0OhFMxeEpQTfnLDv3qAaWigV6/
qUwIwg9v3sfj5v1o5do+3hOXXfuFe+V9Hm19x0ZIdOlrZq4NuY2YqftnOZM3aWJk
Q4ijotIfJeACc8wB/Rp7iM1NpsqdLQ==
=MVlu
-----END PGP SIGNATURE-----

--Sig_/g9K7Af3c8fXET0tbLeMsDuB--
