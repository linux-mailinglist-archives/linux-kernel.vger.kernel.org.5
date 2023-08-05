Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3028E770FB3
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 14:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjHEMqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 08:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHEMqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 08:46:13 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3F6E68
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 05:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1691239559;
        bh=Dq/kgQVeaZglrkSNoxqzWeJJbDhpw1hq63ItYejKrSI=;
        h=From:To:Cc:Subject:Date:From;
        b=CUSJ3d8LXvWKpwZ7UMqO2GISXEuA9tTbga6+qir3nMM3oBdO83Rs6eqsuIiixtdfO
         rMN8yuBwjL4RmMGgnjbya+09KNFD4DMbAUTn3ZKR/vg6gG5B5xwCS69+8yJYifJaKa
         Z0v8TCOVlAnMkjM1Jb1tlxVrjfFRicBKP4CaUQm5CrrPeA7VFtByz0EGZnB7y1hO7w
         1bnU9hd7KG7Kd7/VShRVh5WQET/4nuk9XjzgEF8c4BC2vgTXDRtKsy2wZfVmS6moLW
         lAOx8E/wy0ZPxLqRyM+grM/bs69Y9U0qSQpUz7af4zBAWvwMS9EoABMH9U/zld2uJq
         56jmI5UlrMvDQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RJ2Pf6MF1z4wxV;
        Sat,  5 Aug 2023 22:45:58 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     aneesh.kumar@linux.ibm.com, bgray@linux.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        naveen@kernel.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-6.5-5 tag
Date:   Sat, 05 Aug 2023 22:45:58 +1000
Message-ID: <87sf8x4pyx.fsf@mail.lhotse>
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

Please pull some more powerpc fixes for 6.5:

The following changes since commit 106ea7ffd56b0f9454cd4f625474967f12ac4dbd:

  Revert "powerpc/64s: Remove support for ELFv1 little endian userspace" (2023-07-19 21:28:35 +1000)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.5-5

for you to fetch changes up to 86582e6189dd8f9f52c25d46c70fe5d111da6345:

  powerpc/powermac: Use early_* IO variants in via_calibrate_decr() (2023-08-02 22:57:22 +1000)

- ------------------------------------------------------------------
powerpc fixes for 6.5 #5

 - Fix vmemmap altmap boundary check which could cause memory hotunplug failure.

 - Create a dummy stackframe to fix ftrace stack unwind.

 - Fix secondary thread bringup for Book3E ELFv2 kernels.

 - Use early_ioremap/unmap() in via_calibrate_decr().

Thanks to: Aneesh Kumar K.V, Benjamin Gray, Christophe Leroy, David Hildenbrand,
Naveen N Rao.

- ------------------------------------------------------------------
Aneesh Kumar K.V (1):
      powerpc/mm/altmap: Fix altmap boundary check

Benjamin Gray (1):
      powerpc/powermac: Use early_* IO variants in via_calibrate_decr()

Michael Ellerman (1):
      powerpc/64e: Fix secondary thread bringup for ELFv2 kernels

Naveen N Rao (1):
      powerpc/ftrace: Create a dummy stackframe to fix stack unwind


 arch/powerpc/kernel/head_64.S               | 3 +--
 arch/powerpc/kernel/trace/ftrace_mprofile.S | 9 +++++++--
 arch/powerpc/mm/init_64.c                   | 3 +--
 arch/powerpc/platforms/85xx/smp.c           | 2 +-
 arch/powerpc/platforms/powermac/time.c      | 6 +++---
 5 files changed, 13 insertions(+), 10 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmTOP28ACgkQUevqPMjh
pYD/Dw//VVGuOe1yChY9X/ChgIqZ2PMTw4H+NpOal9xtPT9zjPG1mufNusA1rOh7
IhhxhvEvWu2Swy7m9zT9jC7KIj/5XQXM0UFrpMry/WiuOBd61c1dyB8R6VvH5Js1
yN1VfsWYP5lOLGBMInFu4ov+gzejvXHQbT6DlRjvlDbwALrcjO6rBlJ+lAlNzw/Y
/dFBbpwbEKwXBdez4yEsS5yH7ZlyMfh3Y4sJ+fh/k/q6ijGqU+EinMRfO5x40wB0
DvQjVX15Ns0fNFZK2You261igSjovDjS2GqukVXL91gxNPBhuoFEZSZXlOjziPfy
guJVWYnmfiKjcsMPkRCDJTKMkbOq8rcdk/lc6murLdt1HawTQPK91589cc9PfNzX
XbHrn6UybmQH7dzO1ZFkF/SdyimGWgt7QnwyZ9rKf13CmYJdDoA0Z01T3T3FH+O7
VIqaKNJZh7hYrpugH5cWtcJ1gQVVbf1/v4tolIDuBC3vhLSBWiwJ5CVX846Q9lzS
y5MzE3zh7T9FFh9vQw7yNMW00StCq2yV/UZwDpRqy8bkrlPExi3tZrcxODCl1t3V
kOAIzgcj1eunSDL1nEzZPcqEnk+IX8IKUk/XMr4GomqXLM7KPyUFmKaJLNOTdElm
LNK+oN6mTnaYInkISGImZXAGePY0s8GeHUyyE+W34OGU844HWI0=
=ZRFy
-----END PGP SIGNATURE-----
