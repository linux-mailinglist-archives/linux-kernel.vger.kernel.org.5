Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6F37C62FE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 04:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376760AbjJLCo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 22:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234107AbjJLCo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 22:44:56 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9049A4;
        Wed, 11 Oct 2023 19:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697078686;
        bh=6G5++7JN8z0/UCIorZo0qOqcgFwiR9j4QZnl4r1vRSg=;
        h=Date:From:To:Cc:Subject:From;
        b=Xp4hWh4NwN/KjLFk8ev0GCBnLQ0ZXb+Cv4mzhnsRYXWlVbu15tyRNMCbtxE4/PyXS
         tcglKZ9fSq4ZJrBJJuwJouUVDzsWtqqWQeIepEc0pBpr/EUXHggMqURIceU7ZEotse
         KT5aMpusiqVyQKlMEEGYF40ZBUMg2lpQ9tdYDTTtQF9dZgdb0W3d1sU8/gW3VrmQ12
         y7HRtt6/BAcAEspUJjhdWeBQdo9i+zXgvK3Gi6O/RZRrX4kmHlZHCa2MoDipH+2dz4
         P8Elta9NOpL+/YgSsBZFh6akk9iSKUNwkDbPkUt0me51HlWWPtIj+sfSQjBCX4PvUI
         h+zbD8di6H4uw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S5YrX15B9z4xVb;
        Thu, 12 Oct 2023 13:44:44 +1100 (AEDT)
Date:   Thu, 12 Oct 2023 13:44:42 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: linux-next: manual merge of the tip tree with the asm-generic tree
Message-ID: <20231012134442.16f3f9f6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ojGD2S=ebZhri7+doRSErDx";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ojGD2S=ebZhri7+doRSErDx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  arch/ia64/include/asm/cpu.h
  arch/ia64/kernel/topology.c

between commit:

  cf8e8658100d ("arch: Remove Itanium (IA-64) architecture")

from the asm-generic tree and commit:

  c4dd854f740c ("cpu-hotplug: Provide prototypes for arch CPU registration")

from the tip tree.

I fixed it up (I deleted the files) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/ojGD2S=ebZhri7+doRSErDx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUnXZoACgkQAVBC80lX
0Gz4OAf/XInZvSp7D9t2YrAkcIm4FHOOVF8XYTFYDd4TRWsQ2WpWEQaZN3B5b0EQ
CPipnh8QDKk7Xvg8iPPkTti468C/lrswneW0kkyxPjBK06eOU6Wfl++1nNkphcov
GeVv0mIhXFy1PXcb01EtfjPLfwX2h7mgdlU6B8GsynB7ZUfW8bSSRlqmpLgGOV6k
5yDiUcdwDYVkct4R00WDwO7ANF7F2rpyWz9wftvkFyCe2xIin+T3hcRjeey2fJA6
WuAHijMRRlkMPAiTvddDIE2T25U+XiC0m+0oLHDvXqAmexr7gR6qnNMzDR/s075a
7+JieTP1W4PM87RYOG1/DS7X9RnYKg==
=EFxs
-----END PGP SIGNATURE-----

--Sig_/ojGD2S=ebZhri7+doRSErDx--
