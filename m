Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA9F7C9CED
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 03:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjJPBjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 21:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjJPBjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 21:39:00 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503D9A9;
        Sun, 15 Oct 2023 18:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697420332;
        bh=4/ssYchzIg6w+1UyIH8Gca9PaZF3qh+Rj0MhQBzboE4=;
        h=Date:From:To:Cc:Subject:From;
        b=S0NAEsaBodxV+qGgESHjlR03BjouLsF/3mxf3JdIW219A5LZ+sgMqTiQ4jXB045Os
         DYOzwS8SLdDgXTh/2I+QlgZZjjwJQxa8h1GVD5T7RlaSvjoU01NcU6hMjQPYk2isAV
         xOd3DF1tU4x2j30ADTNXIGd7Iud4e8JgEieAPszzYUwpVdnJxOCAcbGohnYMQTHiYr
         oU2wNmMhzgZA0BvrL+gy+flogrNRowCL2CoHBsR2TCm4Z7YHehH3Dz5omXQ0eFNSFo
         Qing35Va0+W5xNvc+hobX6E1+TZKSbhvwrf1KoY2yQbuqUhQ/h/9pcBQY1qbCEIXbr
         +DEjOtd5zIrYg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S80Bh1Fcxz4wcK;
        Mon, 16 Oct 2023 12:38:51 +1100 (AEDT)
Date:   Mon, 16 Oct 2023 12:38:50 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the tip tree with Linus' tree
Message-ID: <20231016123850.2ee3b736@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/M1hrpfEUIEswjPM5GIbRPa.";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/M1hrpfEUIEswjPM5GIbRPa.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  arch/x86/kernel/smpboot.c

between commit:

  fbe1bf1e5ff1 ("Revert "x86/smp: Put CPUs into INIT on shutdown if possibl=
e"")

from Linus' tree and commit:

  8aa2a4178dc5 ("x86/apic: Use u32 for cpu_present_to_apicid()")

from the tip tree.

I fixed it up (I just used the former which removed the function updated
by the latter) and can carry the fix as necessary. This is now fixed as
far as linux-next is concerned, but any non trivial conflicts should be
mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/M1hrpfEUIEswjPM5GIbRPa.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUslCoACgkQAVBC80lX
0GyUAgf/RJZGINwgeOfRzUbOXJG/EViIRgI66PzwQF39w6QJo81Cw1JDQlyXg7iP
SY1zexkhrjH7+xsMJEfjPEOP2iGIZQwsmHtIX4PH3jvOBcofZXnQCMKoYF5DIuhP
3qlhkvw+2p/4X6oJ/h0AvHZ1Y5lhw0+uMb+L8ZZ1zgsp9pY2zwE1SOjTBhNcIQVc
+QIoJB77DdQAH0tWF4PCYPD/gXqTm7lpOZuJfoEB58pCfRKMaJxT++N0qt/z25m7
VvgDaoMpsOgIY54HJtdDR9fihNTHLdK5b4E03Sg4CZGWR82ljgcaYSz6MlkDhL1e
jQklsLDuf0GDPr1pTCgAYzicB7Zfzw==
=oofA
-----END PGP SIGNATURE-----

--Sig_/M1hrpfEUIEswjPM5GIbRPa.--
