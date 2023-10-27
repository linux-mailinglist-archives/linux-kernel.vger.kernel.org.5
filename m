Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23B97D9154
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 10:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjJ0IYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 04:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjJ0IYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 04:24:04 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0641FA
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 01:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1698395039;
        bh=Xf78J3V/nXWymNnOwH36m1SnWDgSk7e+g5wPMMWhq5c=;
        h=From:To:Cc:Subject:Date:From;
        b=nOB1Bm2cpfX6gPBREdr+tWLK2o9fhlDyjCa9EyhyoECPthDo58JkBkP2hJ4o3gewk
         1eCQG1kuXeehLbAZxJlXDh7zoGujS8fNOTg+iPfhO4bJONcbysFeNFV8/zfmeh7dSK
         pTHdIVa+6M2rICmtDEGj057/sZYcwJDG56e1/INscYP8Kc2HM1XWs2tOwN37WrgnGr
         /y/JcW/0DJFtbaSedl4r528qqqyBbuKM7rR4h/7ZlCKTje7uT2cj1ixUPVbbaITT8n
         4H/RSvj1NG2MmE1J3rSiIZ7O2/g/8hSOhJMe1WJQqXl+IuzBmiz4ZmO9ANu3U0qvx1
         PxWfcx3r1fh9g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SGwg35nyqz4xPM;
        Fri, 27 Oct 2023 19:23:59 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     aneesh.kumar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-6.6-6 tag
Date:   Fri, 27 Oct 2023 19:23:43 +1100
Message-ID: <87edhgv5gw.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull some final powerpc fixes for 6.6:

The following changes since commit f9bc9bbe8afdf83412728f0b464979a72a3b9ec2:

  powerpc/qspinlock: Fix stale propagated yield_cpu (2023-10-18 21:07:21 +1100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.6-6

for you to fetch changes up to 47b8def9358c5eb888e78b24b7e5b7f2e2e97b8e:

  powerpc/mm: Avoid calling arch_enter/leave_lazy_mmu() in set_ptes (2023-10-25 16:08:46 +1100)

- ------------------------------------------------------------------
powerpc fixes for 6.6 #6

 - Fix boot crash with FLATMEM since set_ptes() introduction.

 - Avoid calling arch_enter/leave_lazy_mmu() in set_ptes().

Thanks to: Aneesh Kumar K.V, Erhard Furtner.

- ------------------------------------------------------------------
Aneesh Kumar K.V (1):
      powerpc/mm: Avoid calling arch_enter/leave_lazy_mmu() in set_ptes

Michael Ellerman (1):
      powerpc/mm: Fix boot crash with FLATMEM


 arch/powerpc/kernel/setup-common.c |  2 ++
 arch/powerpc/mm/mem.c              |  1 -
 arch/powerpc/mm/pgtable.c          | 32 ++++++++++++++------
 3 files changed, 24 insertions(+), 11 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmU7ctsACgkQUevqPMjh
pYDD2xAAiDTlWc3AszHLgr/jj3hN++r/D6kso8sMbPPdqdLJ0Cumn41JdeOP3hO4
oEcr5L9ing1LG4KLDy94LCq/V5A7RmAIzOd0Dm6az35TL8J/LyLEFoncHaAG9O0F
mhGeuREsideLCwkeFosXONHPsf+yKpeVDi2yOCHO5wGkGAThgudvhhedVcSLBmco
2MbwuT0IOFhxDZjWUNZR/wslK9CGnOKVtHla7Kg3XX6NxCMKqRSFfO9lPXrBgPTP
EgV5B6aLHdb2JmC2vCNnYpHtkoXs4hotrzLXccFM1APtwbTKz2RYZpjmAtcupcj/
GDzG/n1hK72M1hFVRG9G09n+DLI0RZGOtNkp4F+078AbSMBdyzIMnudmX4b/N1kF
RLFYFri8N9HsYVar+x8jPcm3GV/GGAcFCuVJWKozoaEkojdpk+RZYAipjbQRKyeP
uW5/vfffFp2xNen7poMB/yxXosIW71YiHLtEq6LOOOKF9sioNK85qlJfMfYz6wXw
LRSJj4d3ZZJBZ8gXLN5EaGQ/uweUtqVpekaMW9c+J4cg+qhgoagYnzPoLp2KsDON
1Kr2aSTkX/YpR2d9jANSsO01m4hvoM0DAMTPVZS2EeIRGgNrxzLL9DkHalT4sGq1
tjSS3NV/uLd8OAYGkFqL3Ldcn6PX0tj5yWbYp9yzEAYx9yOgdOI=
=Rmou
-----END PGP SIGNATURE-----
