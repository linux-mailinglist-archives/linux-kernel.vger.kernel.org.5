Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA3B7B48AF
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 18:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbjJAQ46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 12:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235184AbjJAQ44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 12:56:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C8EC9;
        Sun,  1 Oct 2023 09:56:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2739C433C9;
        Sun,  1 Oct 2023 16:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696179413;
        bh=7GEDIDM2CZQfuVWXUXqevuu15Za7aaDemQVmFgqIfXA=;
        h=From:Date:Subject:To:Cc:From;
        b=q0WITblhD5KBMSq3YbwJNwOHysFE4C1KmUM2jGFd6AxEihFOzVFj88vIiEgE2Z90L
         /KycVIuGwwWJ1L+HiTkphNuoSWIt35drXifY7kzY2SBX+6FZPIQW0RhHve9wA0up9+
         YBxVF7jqFp+Yc+bWa5qght38hCkSxoDbrtMCVePYGCt1kM6pvBBn40H3mcEPsAUZmv
         yQdpWQVYvdhoC3AXddN/R1cmzjjmy9oFgY0/pVDKhozuiZFlgg84usL1blZM6is+JB
         LYFWldf/Bnkk+s2cKxHkTDk07XQHi0fH0R1yT/ak2KfY7Hi7FgIiMMF3FQ3uZGwQID
         aTyohGFCchejA==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1dce0c05171so7318070fac.3;
        Sun, 01 Oct 2023 09:56:53 -0700 (PDT)
X-Gm-Message-State: AOJu0YwxqHu2/y8BDxKbRHzKSbV+apKdpf8foh6E7ir59fFrPAIWcPOY
        rUqppuwrlx9Op4ylKgNk43bW9JsNL+oKkmvOD/k=
X-Google-Smtp-Source: AGHT+IFWDvaN11V5bbggOPZp8I8yT6LNbYShxtKNldE0YAjtAKJqdS3PZVO9kXHnZDC1PNYfjJ4o4JEB4Fi9df2a+xE=
X-Received: by 2002:a05:6871:8ac:b0:1b7:308e:6cd9 with SMTP id
 r44-20020a05687108ac00b001b7308e6cd9mr12554195oaq.5.1696179413218; Sun, 01
 Oct 2023 09:56:53 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 2 Oct 2023 01:56:16 +0900
X-Gmail-Original-Message-ID: <CAK7LNAToVL02t9rApELSbCFfA=PYbgDzyLsJO+J3RV0h0Ry2hA@mail.gmail.com>
Message-ID: <CAK7LNAToVL02t9rApELSbCFfA=PYbgDzyLsJO+J3RV0h0Ry2hA@mail.gmail.com>
Subject: [GIT PULL] Kbuild fixes for v6.6-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Please pull Kbuild fixes for v6.6-rc4.
Thank you.


The following changes since commit 6465e260f48790807eef06b583b38ca9789b6072=
:

  Linux 6.6-rc3 (2023-09-24 14:31:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-fixes-v6.6-2

for you to fetch changes up to 2d7d1bc119a4d7f54cfe0b1be480c34e8c712d06:

  kbuild: remove stale code for 'source' symlink in packaging scripts
(2023-10-01 23:06:06 +0900)

----------------------------------------------------------------
Kbuild fixes for v6.6 (2nd)

 - Fix the module compression with xz so the in-kernel decompressor works

 - Document a kconfig idiom to express an optional dependency between
   modules

 - Make modpost, when W=3D1 is given, detect broken drivers that reference
   .exit.* sections

 - Remove unused code

----------------------------------------------------------------
Arnd Bergmann (1):
      Documentation: kbuild: explain handling optional dependencies

Martin Nybo Andersen (1):
      kbuild: Use CRC32 and a 1MiB dictionary for XZ compressed modules

Masahiro Yamada (2):
      vmlinux.lds.h: remove unused CPU_KEEP and CPU_DISCARD macros
      kbuild: remove stale code for 'source' symlink in packaging scripts

Mauricio Faria de Oliveira (1):
      modpost: add missing else to the "of" check

Uwe Kleine-K=C3=B6nig (1):
      modpost: Don't let "driver"s reference .exit.*

 Documentation/kbuild/kconfig-language.rst | 26 ++++++++++++++++++++++++++
 include/asm-generic/vmlinux.lds.h         |  7 -------
 scripts/Makefile.modinst                  |  2 +-
 scripts/mod/file2alias.c                  |  2 +-
 scripts/mod/modpost.c                     | 15 +++++++++++++--
 scripts/package/builddeb                  |  1 -
 scripts/package/kernel.spec               |  3 ---
 7 files changed, 41 insertions(+), 15 deletions(-)


--=20
Best Regards
Masahiro Yamada
