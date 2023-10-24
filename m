Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17007D479A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 08:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbjJXGi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 02:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbjJXGiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 02:38:51 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26D7DD;
        Mon, 23 Oct 2023 23:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698129524;
        bh=Yjbi8baLATD/fHzOgylyef37xmECN0dtorEYBlgpJAo=;
        h=Date:From:To:Cc:Subject:From;
        b=bDdUKwTtceJdJmpW1npM8gL05L9yIA6l8I9K6l3S1aeZzuF+uwvzAv2fQqVBIabZN
         ErnhUntr7EB5+K3b12a7j1QZYC/Srm+1F/5C5dg1/51V7vU3uYs/k5dnrgw7nAm77S
         0g7wr/YOedGN1Np95gqYAR6cZRFICQvtgO8G2YSlvZRjQOshPDsHAUz2FMWX1AuefF
         eWBBwN0xoIwf7MDYuUZIIvu2nbv9wCHT+jvJghDoQLv+u82wq7eCxgnr52HATyDTQM
         wX5DSB/Zt4MfQyw3KkSO8O7WSTnsakiS4ePXZEDMzdPas8azsaZML2e+ovdjGBXoJf
         HrQQcI30KG+PA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SF2Sz551tz4wdC;
        Tue, 24 Oct 2023 17:38:43 +1100 (AEDT)
Date:   Tue, 24 Oct 2023 17:38:43 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc:     Sourabh Jain <sourabhjain@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the powerpc tree
Message-ID: <20231024173843.07ca9afc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ZmEuILtJOwo8pcQ9yHFFAfJ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ZmEuILtJOwo8pcQ9yHFFAfJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the powerpc tree, today's linux-next build (powerpc
allyesconfig) produced this warnings:

WARNING: modpost: vmlinux: section mismatch in reference: process_fadump+0x=
2c8 (section: .text.process_fadump) -> fadump_setup_elfcorehdr_buf (section=
: .init.text)
WARNING: modpost: vmlinux: section mismatch in reference: process_fadump+0x=
2f4 (section: .text.process_fadump) -> fadump_populate_elfcorehdr (section:=
 .init.text)

Probably introduced by commit

  c17687d0d62d ("powerpc: make fadump resilient with memory add/remove even=
ts")

--=20
Cheers,
Stephen Rothwell

--Sig_/ZmEuILtJOwo8pcQ9yHFFAfJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU3ZnMACgkQAVBC80lX
0Gzx8Qf+KFI2SR2hDeKrZJa/tECX1cLqRx+/7vMPVE3k7qFJOfHJj/jm5zL9TkuQ
iT6yyzyHcGKfqy1AS7u6vbsjDdeIEXpgOXSxfS9AKboWsDCcMnd4AcKBnjbuR0DV
S0JOEfvjT+YTTXPmzaq7gnJj80y66R+DaAWtylGmnSH+9qZMyU3o9G563kHvUE4d
df7R03M3OmlGXISG75/bS1zpYrEvAp3zRHFZPbkibVlOSCsR+NHvPsmHZhRyP2bc
3DgGFSvLdUAJblONBqH99i0Atm520zencF0HHLWT1OwvhAePEV9WJL33M3NRPSRR
uKvBqKdPxIRs+G8qliqCDUbUrfS2LQ==
=bMPO
-----END PGP SIGNATURE-----

--Sig_/ZmEuILtJOwo8pcQ9yHFFAfJ--
