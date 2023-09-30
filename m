Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5947B7B4069
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 15:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbjI3NMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 09:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjI3NMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 09:12:00 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43A9E6
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 06:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1696079511;
        bh=JlLHDIrwoEqeeY+xa3WB3jmigoRfwNeCnr/KLMh86hs=;
        h=From:To:Cc:Subject:Date:From;
        b=EPBsmtVebPJlKFZm2m2N91Nf1h8Ig8NB/xLT8wpqeECV85d5r1IM/jU/lKalC23Ai
         wgw/hFRUedYyggejR6xcsnqWBHoA7WOIqzlfBTnvjURaXQPAdcOAO4jj+vgrCcfkHl
         Ri+fzq2p5pm2tPz/k+1QODdEGCU/uu4VVKZErnOb+TQpg4bsQuTbYeRPIc4+sEf2yA
         5wnyRK5AxCCc9HZ7KJSJmOhYAugzzpIg1QQbnXNbE5Zp/+0ZmtzDbvSt/aDZ9Z6cUb
         Kp9q2P+c8pMQE5mT44PNNH8blrSFEFa907ZIPcfxCtGYFJFak+XTaXhgIJwaNSQ5Ny
         4uJ+9hgnVXtKg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RySKf4K8Gz4x5J;
        Sat, 30 Sep 2023 23:11:50 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-6.6-3 tag
Date:   Sat, 30 Sep 2023 23:11:46 +1000
Message-ID: <87bkdjolf1.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull some more powerpc fixes for 6.6:

The following changes since commit c3f4309693758b13fbb34b3741c2e2801ad28769:

  powerpc/dexcr: Move HASHCHK trap handler (2023-09-18 12:23:48 +1000)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.6-3

for you to fetch changes up to 58b33e78a31782ffe25d404d5eba9a45fe636e27:

  selftests/powerpc: Fix emit_tests to work with run_kselftest.sh (2023-09-22 20:29:48 +1000)

- ------------------------------------------------------------------
powerpc fixes for 6.6 #3

 - Fix arch_stack_walk_reliable(), used by live patching.

 - Fix powerpc selftests to work with run_kselftest.sh

Thanks to: Joe Lawrence, Petr Mladek.

- ------------------------------------------------------------------
Michael Ellerman (2):
      powerpc/stacktrace: Fix arch_stack_walk_reliable()
      selftests/powerpc: Fix emit_tests to work with run_kselftest.sh


 arch/powerpc/kernel/stacktrace.c             | 27 ++++----------------
 tools/testing/selftests/powerpc/Makefile     |  7 +++--
 tools/testing/selftests/powerpc/pmu/Makefile | 11 ++++----
 3 files changed, 14 insertions(+), 31 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmUYHX8ACgkQUevqPMjh
pYBvDBAAoCipzzNry+rTrf2bc9dOyCCyRsUhTsujXye+rGuxKMEiTalds8+t6F68
8LOJ1X2sFeGk25R5VSqjxbFqxRAyfcTMttnOJs5QTBomZAa4EWyQT/+JRAnj1sS3
XspFNjFpgENQ3qyDtRBCXBGZ55EGv45yXTrXmOS7mvHvrMEQyU2H4XZPyvuBf3kz
5/uz0rb+aZsYvq1Hq5PGX+3dWSa4VYeB9FYOwZeGTe9ycpwvw1nvYJ7sBTS+MBkh
oISlPrq0cUGFP/4cr0DBlekyyIrdgs6wHArX7uTflR0P6M59AQeArwzqDWwHMzY0
DdbpH4104YKkv9bE2nfywgvGveKkBIAiCd8aEG0yH/cc8emrAabbvgWem+TrN1Yf
ELehUuEjL442T3m5QpDJUxgrFeF9INFnuztYupgZuQIhEQxqmg1tXXcsLqAlgnL2
uU++CS7SfYKiLtGNxmxGtQB+zYA8qQZ8z+9mzDm7qNmjfm9Zfye1WKYIOJRpJP1N
wt/MYJVbOCI5ZXqIAdOHGZDFu7KkcSpGiRt7634epGgY5JHGQnmXIJq0g0Tir4uE
lrHCJOwrStUfbaKKEB0K9tvbS+Q/l3N3LBYVJFkyYU9lCzjT83OPE9BS5mY2LxZg
86PmrwTP/9DPWh5i/u6Fj+CAIt3SpD57Jmdtxnn7gGVPd2nGEbQ=
=uC7L
-----END PGP SIGNATURE-----
