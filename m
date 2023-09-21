Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D527AA25E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbjIUVPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbjIUVO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:14:57 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE516A5D65
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1695289521;
        bh=RnTI8fNdbZjWAEu2Dfslcn699MAz2b9JB5o2kUxoocI=;
        h=From:To:Cc:Subject:Date:From;
        b=npXDkE07KoiOvtc1s8QOJjUrnNnaxOs9VeIQYpCJ/jUzxIfm/H05icmkVlb7Yo3s3
         TvgAysDQ1KRYvBJ7dsV4smvzY7T+U6NrhFkZEwAMqpJM0/j+UDJmWecy6AxsoqI0tf
         EN1k5ZdqyXH7tJQeojkV3Nd3QrqIfaa5xYksmYdY3iH7xzVa28gbFjRUwYzbh0/zQ0
         3UNWVHJoLPM5W+clap5QcGlv916l7guiUQ2JZkEtfecH7ZAieB+PUTgSmE7goqjW1p
         gIqlK64OdY5zswry+0KkP2WN1NDEHH444bSCoqkf81RYKFSE0FMu7FsFz9MPQUySwF
         RZAy8xe3ChuoA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rrr9Y5YGTz4xP9;
        Thu, 21 Sep 2023 19:45:21 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     bgray@linux.ibm.com, christophe.leroy@csgroup.eu,
        kjain@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, naveen@kernel.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-6.6-2 tag
Date:   Thu, 21 Sep 2023 19:45:21 +1000
Message-ID: <875y43oo5q.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull some powerpc fixes for 6.6:

The following changes since commit ce9ecca0238b140b88f43859b211c9fdfd8e5b70:

  Linux 6.6-rc2 (2023-09-17 14:40:24 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.6-2

for you to fetch changes up to c3f4309693758b13fbb34b3741c2e2801ad28769:

  powerpc/dexcr: Move HASHCHK trap handler (2023-09-18 12:23:48 +1000)

- ------------------------------------------------------------------
powerpc fixes for 6.6 #2

 - A fix for breakpoint handling which was using get_user() while atomic.

 - Fix the Power10 HASHCHK handler which was using get_user() while atomic.

 - A few build fixes for issues caused by recent changes.

Thanks to: Benjamin Gray, Christophe Leroy, Kajol Jain, Naveen N Rao.

- ------------------------------------------------------------------
Benjamin Gray (4):
      powerpc/watchpoints: Disable preemption in thread_change_pc()
      powerpc/watchpoint: Disable pagefaults when getting user instruction
      powerpc/watchpoints: Annotate atomic context in more places
      powerpc/dexcr: Move HASHCHK trap handler

Christophe Leroy (1):
      powerpc/82xx: Select FSL_SOC

Kajol Jain (1):
      powerpc/perf/hv-24x7: Update domain value check

Naveen N Rao (1):
      powerpc: Fix build issue with LD_DEAD_CODE_DATA_ELIMINATION and FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY


 arch/powerpc/Kconfig                            |  2 +-
 arch/powerpc/kernel/hw_breakpoint.c             | 16 +++++-
 arch/powerpc/kernel/hw_breakpoint_constraints.c |  7 ++-
 arch/powerpc/kernel/traps.c                     | 56 +++++++++++++-------
 arch/powerpc/perf/hv-24x7.c                     |  2 +-
 arch/powerpc/platforms/82xx/Kconfig             |  3 +-
 6 files changed, 60 insertions(+), 26 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmUMEHgACgkQUevqPMjh
pYDDQw/+IuTozHtltaJEigsvcf9htmKoTBDqZqX3io+b8tg4dVnHIcfFlwAzr5XE
u7y0ktoqzldKBs2cOJh6hboafhazE/EdJlXEJP/79RQHf7Qyn2qFrH+627Az0dzi
ApuKpJtWqDyx934U+Xoys8dE8vDssGMD5kdjg0QMS6bp5pIXeJVLvxQUp/S+CQg3
MNcPGyFOXPd23FaXLCXuOL1rO4eyJCpiH5JOlBsod3YY85eyVD6Gpl4Uoi488C5j
fFpqOIKI+FmdA2NkbWxXPhC4j95y65l2qPhjANEfr2GnnKTW37RFmXS8OECleCHU
g8XB5quhNMeBkrRB5ZsmJ88M7IeYRJyYnsV+SKiR/NesiUrlWZKaZUdhiTnjDcVo
xzvLq9ZZjOx1opH23luC6HaXs/XiGD7n190OVw/8oBfklUkkqjhSN1pZXRWLsbL3
duGOFS+VuTI6UO4w8mqzQSrUjptR9UaQng/z5iloxzrbvwlnUrbccKFqf7seuv0c
HLyAbl5tMoGIhHWANn+1U0sMrgJy5L2b4es0cEsN0IxhCpNno+YnrtqVBdhDFfJZ
7TLxw6J8rVz5LN0bjXBwAiknGgi9xobJcIqP/nbG/jMjnCJ8w8XVnnOfZhJFSMEZ
nsQii1wmAuUTzFKJ/73Y+X61P1MYfs8sQOfqgqvLkhRNUI7TrFc=
=NfRO
-----END PGP SIGNATURE-----
