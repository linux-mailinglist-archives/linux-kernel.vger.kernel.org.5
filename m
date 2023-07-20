Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE8A75AFCF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbjGTN2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbjGTN2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:28:09 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84BB270F;
        Thu, 20 Jul 2023 06:27:42 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d9443c01a7336-1b8ad907ba4so4542525ad.0;
        Thu, 20 Jul 2023 06:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689859661; x=1690464461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AAIAY+cO7qocGEY3Hb27qRK+EBx4cy55A4noWZT0+PU=;
        b=grjDB9Emn8tU7gt1j6PpGPioCKc/qbwUXK4McElsAC4DZqdVAWzfxZRa35at/lzsLw
         kAoLJIxyVLhs9j4vVo8qpn8HTzsS7rESVBnuox5zM4gx0JlyYe05FCY09fHgmIMiDC/a
         A/YAWt6oYQwa60X5Vo9d7KdWmR8CXDJTOBpQH/tUQK12DoovDE9oyivVmR3GtESi/HPy
         vgFV3hPMuRNH/M1aAMPkT28vxYbOJnun68ROcVjYA4sZFIOi2sGAlrssVNZSM9Bi8clN
         j+P1KYQS1qK7VSkBXes0ABVLPL/U+lGIWfasjm1KvHo2pmN7LEejGuJdGw8SqB/MjSZp
         sZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689859661; x=1690464461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AAIAY+cO7qocGEY3Hb27qRK+EBx4cy55A4noWZT0+PU=;
        b=Qn+57ZfjALiuUjSuCJfHJjvnWsfY6ZB6urwfHQY8FYjgUCDrvilvi2MdTOtUtuKJmS
         85CgtH2PYXxi7O7oM1fZGlH6c2aXKqYJ7lPqMZnjXOHN4Jj1uB0VJ8BXthpu4YazvYUG
         cbE0K98ETB+nZj6DkqcHD2yjsvai+e3YckLQ6LCPleVmH7SwdA+ZPXIFps2iexnDBIK9
         n3ePEQbeA7PU4HyYIgNrgwvdE4g4wKNQBczMwJNdQZFq8c/JKYHyv/idZpQEDXIHmuVP
         jDfzx4Jp+dMP+Ooa2f1FY7qDOe79VMunK0AwmK8KMvx6qneR/nkHAZyM5Sz5BAiszPir
         XkFA==
X-Gm-Message-State: ABy/qLZ+L9lJXVShkwUBHTLBKyFTMroBTQcmxQpGRm2Sb7AMeVeUF30f
        vOy/sGcaDn3slYrdEEh5CeM=
X-Google-Smtp-Source: APBJJlH4yr+ruaV/UXaqSoPLQE4SHcsRnLioV/BA3H1cpzaIdymcEsxMkwYeiFJcegt21ZWHgcd0AA==
X-Received: by 2002:a17:902:f688:b0:1b8:987f:3eaa with SMTP id l8-20020a170902f68800b001b8987f3eaamr21803045plg.58.1689859661384;
        Thu, 20 Jul 2023 06:27:41 -0700 (PDT)
Received: from localhost.localdomain ([113.251.0.121])
        by smtp.gmail.com with ESMTPSA id u19-20020a170902a61300b001b830d8bc40sm1346309plq.74.2023.07.20.06.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 06:27:40 -0700 (PDT)
From:   Hu Haowen <src.res.211@gmail.com>
To:     corbet@lwn.net
Cc:     Hu Haowen <src.res.211@gmail.com>,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 0/6] docs/zh_TW: update zh_TW's documentation from an ascensive aspect
Date:   Thu, 20 Jul 2023 21:27:23 +0800
Message-Id: <20230720132729.1821-1-src.res.211@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update zh_TW's documentation concentrating on the following aspects:

    * The file tree structure changes of the main documentation;
    * Some changes and ideas from zh_CN translation;
    * Removal for several obsoleted contents within the zh_TW translation
      or those which are not exising anymore in the main documentation.
    * Replacements for some incorrect words and phrases in traditional
      Chinese or those which are odd within their context being hard for
      readers to comprehend.

Hu Haowen (6):
  docs/zh_TW: update admin-guide
  docs/zh_TW: update arch
  docs/zh_TW: update cpu-freq
  docs/zh_TW: update filesystems
  docs/zh_TW: update process
  docs/zh_TW: turn zh_CN's folder references and headers into zh_TW's
    ones

 .../translations/zh_TW/admin-guide/README.rst | 166 ++--
 .../zh_TW/admin-guide/bootconfig.rst          | 294 +++++++
 .../zh_TW/admin-guide/bug-bisect.rst          |  12 +-
 .../zh_TW/admin-guide/bug-hunting.rst         |  40 +-
 .../zh_TW/admin-guide/clearing-warn-once.rst  |   6 +-
 .../zh_TW/admin-guide/cpu-load.rst            |  10 +-
 .../zh_TW/admin-guide/cputopology.rst         |  98 +++
 .../translations/zh_TW/admin-guide/index.rst  | 136 ++--
 .../translations/zh_TW/admin-guide/init.rst   |  38 +-
 .../zh_TW/admin-guide/lockup-watchdogs.rst    |  69 ++
 .../zh_TW/admin-guide/mm/damon/index.rst      |  31 +
 .../zh_TW/admin-guide/mm/damon/lru_sort.rst   | 265 +++++++
 .../zh_TW/admin-guide/mm/damon/reclaim.rst    | 230 ++++++
 .../zh_TW/admin-guide/mm/damon/start.rst      | 126 +++
 .../zh_TW/admin-guide/mm/damon/usage.rst      | 593 ++++++++++++++
 .../zh_TW/admin-guide/mm/index.rst            |  52 ++
 .../translations/zh_TW/admin-guide/mm/ksm.rst | 201 +++++
 .../zh_TW/admin-guide/reporting-issues.rst    | 729 ++++++++---------
 .../admin-guide/reporting-regressions.rst     | 371 +++++++++
 .../zh_TW/admin-guide/security-bugs.rst       |  28 +-
 .../translations/zh_TW/admin-guide/sysrq.rst  | 283 +++++++
 .../zh_TW/admin-guide/tainted-kernels.rst     |  86 +-
 .../zh_TW/admin-guide/unicode.rst             |  12 +-
 .../translations/zh_TW/arch/arm/Booting       | 176 +++++
 .../zh_TW/arch/arm/kernel_user_helpers.txt    | 285 +++++++
 .../translations/zh_TW/arch/arm64/amu.rst     |   6 +-
 .../translations/zh_TW/arch/arm64/booting.txt |  28 +-
 .../zh_TW/arch/arm64/elf_hwcaps.rst           |  10 +-
 .../zh_TW/arch/arm64/legacy_instructions.txt  |  14 +-
 .../translations/zh_TW/arch/arm64/memory.txt  |  16 +-
 .../translations/zh_TW/arch/arm64/perf.rst    |   2 +-
 .../zh_TW/arch/arm64/silicon-errata.txt       |  30 +-
 .../zh_TW/arch/arm64/tagged-pointers.txt      |  10 +-
 .../translations/zh_TW/arch/index.rst         |  30 +
 .../zh_TW/arch/openrisc/index.rst             |  33 +
 .../zh_TW/arch/openrisc/openrisc_port.rst     | 129 +++
 .../translations/zh_TW/arch/openrisc/todo.rst |  25 +
 .../zh_TW/arch/parisc/debugging.rst           |  47 ++
 .../translations/zh_TW/arch/parisc/index.rst  |  32 +
 .../zh_TW/arch/parisc/registers.rst           | 157 ++++
 .../translations/zh_TW/cpu-freq/core.rst      |  26 +-
 .../zh_TW/cpu-freq/cpu-drivers.rst            | 147 ++--
 .../zh_TW/cpu-freq/cpufreq-stats.rst          |  41 +-
 .../translations/zh_TW/cpu-freq/index.rst     |   4 +-
 .../zh_TW/filesystems/debugfs.rst             |  38 +-
 .../translations/zh_TW/filesystems/index.rst  |   2 +-
 .../translations/zh_TW/filesystems/sysfs.txt  |  16 +-
 .../translations/zh_TW/filesystems/tmpfs.rst  |  32 +-
 .../zh_TW/filesystems/virtiofs.rst            |   8 +-
 Documentation/translations/zh_TW/index.rst    |   5 +-
 .../translations/zh_TW/process/1.Intro.rst    |  78 +-
 .../translations/zh_TW/process/2.Process.rst  | 130 ++--
 .../zh_TW/process/3.Early-stage.rst           |  44 +-
 .../translations/zh_TW/process/4.Coding.rst   | 102 +--
 .../translations/zh_TW/process/5.Posting.rst  |  66 +-
 .../zh_TW/process/6.Followthrough.rst         |  46 +-
 .../zh_TW/process/7.AdvancedTopics.rst        |  56 +-
 .../zh_TW/process/8.Conclusion.rst            |  10 +-
 .../code-of-conduct-interpretation.rst        |  52 +-
 .../zh_TW/process/code-of-conduct.rst         |  18 +-
 .../zh_TW/process/coding-style.rst            | 383 ++++++---
 .../zh_TW/process/development-process.rst     |   2 +-
 .../zh_TW/process/email-clients.rst           | 254 +++---
 .../process/embargoed-hardware-issues.rst     |  74 +-
 .../translations/zh_TW/process/howto.rst      | 142 ++--
 .../translations/zh_TW/process/index.rst      |   5 +-
 .../process/kernel-enforcement-statement.rst  |  15 +-
 .../zh_TW/process/license-rules.rst           |  52 +-
 .../zh_TW/process/magic-number.rst            |   1 +
 .../zh_TW/process/management-style.rst        |  60 +-
 .../zh_TW/process/stable-api-nonsense.rst     |  86 +-
 .../zh_TW/process/stable-kernel-rules.rst     |  36 +-
 .../zh_TW/process/submit-checklist.rst        |  80 +-
 .../zh_TW/process/submitting-patches.rst      | 734 +++++++++---------
 .../process/volatile-considered-harmful.rst   |  32 +-
 75 files changed, 5744 insertions(+), 2039 deletions(-)
 create mode 100644 Documentation/translations/zh_TW/admin-guide/bootconfig.rst
 create mode 100644 Documentation/translations/zh_TW/admin-guide/cputopology.rst
 create mode 100644 Documentation/translations/zh_TW/admin-guide/lockup-watchdogs.rst
 create mode 100644 Documentation/translations/zh_TW/admin-guide/mm/damon/index.rst
 create mode 100644 Documentation/translations/zh_TW/admin-guide/mm/damon/lru_sort.rst
 create mode 100644 Documentation/translations/zh_TW/admin-guide/mm/damon/reclaim.rst
 create mode 100644 Documentation/translations/zh_TW/admin-guide/mm/damon/start.rst
 create mode 100644 Documentation/translations/zh_TW/admin-guide/mm/damon/usage.rst
 create mode 100644 Documentation/translations/zh_TW/admin-guide/mm/index.rst
 create mode 100644 Documentation/translations/zh_TW/admin-guide/mm/ksm.rst
 create mode 100644 Documentation/translations/zh_TW/admin-guide/reporting-regressions.rst
 create mode 100644 Documentation/translations/zh_TW/admin-guide/sysrq.rst
 create mode 100644 Documentation/translations/zh_TW/arch/arm/Booting
 create mode 100644 Documentation/translations/zh_TW/arch/arm/kernel_user_helpers.txt
 create mode 100644 Documentation/translations/zh_TW/arch/index.rst
 create mode 100644 Documentation/translations/zh_TW/arch/openrisc/index.rst
 create mode 100644 Documentation/translations/zh_TW/arch/openrisc/openrisc_port.rst
 create mode 100644 Documentation/translations/zh_TW/arch/openrisc/todo.rst
 create mode 100644 Documentation/translations/zh_TW/arch/parisc/debugging.rst
 create mode 100644 Documentation/translations/zh_TW/arch/parisc/index.rst
 create mode 100644 Documentation/translations/zh_TW/arch/parisc/registers.rst

-- 
2.34.1

