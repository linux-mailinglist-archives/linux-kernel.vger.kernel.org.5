Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B91772348
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjHGMAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbjHGMAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:00:35 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303FF1724;
        Mon,  7 Aug 2023 05:00:19 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d2e1a72fcca58-686f19b6dd2so2890926b3a.2;
        Mon, 07 Aug 2023 05:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691409618; x=1692014418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Oe8svXv9B1041pe8a5N/qRze8R8miXOCLMRPdSD659A=;
        b=mwLYv+Dl4nJU4RaSybPosJbvsYjAux6mqcLQyotlgzqljltlU6cVS4sXFZENHCYtgh
         sV7FWWBF8MdroQYozVGEtlJT8Lfqr2M4p2maGBY9QZ4CDxgSfHB9F2sf+cbl+aAkm6sd
         zoJ/Dcs510TqGpLZGyaNvE1V4oOB0/ywLP/wOTKEfI5nzo+cJdXx+R/iIgTcWWFDQk8M
         +B2OupcZYcp59PCzmGlvLa8HkzmZBG0CTWXQ27dfltBsN1jWSnooBaPDCwFp9z4mSw6p
         UZT9aYL9g64XyMgWmR7/wDekGFIqZvMbHHIV6mJxe/udahWYGNwzezcKevJ+o89y1h1d
         rMOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691409618; x=1692014418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oe8svXv9B1041pe8a5N/qRze8R8miXOCLMRPdSD659A=;
        b=VO8zYJQr91wMDWF87DMy9MWYppN0SIZ/VV9xyOGWXH8D6t7wIkEwUQWNogf/CaoEfx
         9MtCW5dVjxiqXOsylOEpBniBGCJjfjLoH9CrwYvBorL+cxbLXNgdN9zsz5SBtZKcLVdh
         M3AezbnQlv3Smq9h1u3q2GKejJwM6XpP6q7aHBZnOvplIli00/diyrECs9ZkNFwDtvR8
         fDa2I9AwA88iTCzdqqXrH01LMd+z1yBz3lFQ21C9EhjJ7xvFCKfglKapbhb3wkcY7vum
         px5mv+5fRhQKfK1KiP7IqunKVtI67g5Vx9nc1BPPwd6Zj5rDO6Q784lGDM6dSIZ8R2tq
         y5Dg==
X-Gm-Message-State: AOJu0Ywn3EA98MNL0AV33NazWP0ebuLqELmBvElhfSgdMkpf8Bsd98xg
        Yf4OXdK9iWlf8hpjGOCEGFJsOLSSiTSJHWPNfwg=
X-Google-Smtp-Source: AGHT+IFa5uUkz5PYmUx9Q+rOT9bJMVAHQCLGXL4zkyulDTB4cmmF0l8Rb87fpgEtQHwfzs47fonxdA==
X-Received: by 2002:a05:6a20:a1a0:b0:133:bc8:e362 with SMTP id r32-20020a056a20a1a000b001330bc8e362mr6036993pzk.24.1691409618504;
        Mon, 07 Aug 2023 05:00:18 -0700 (PDT)
Received: from localhost.localdomain ([113.251.7.202])
        by smtp.gmail.com with ESMTPSA id e16-20020a62ee10000000b00686940bfb77sm6013108pfi.71.2023.08.07.05.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 05:00:17 -0700 (PDT)
From:   Hu Haowen <src.res.211@gmail.com>
To:     corbet@lwn.net
Cc:     Hu Haowen <src.res.211@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/6] docs/zh_TW: update zh_TW's documentation from an ascensive aspect
Date:   Mon,  7 Aug 2023 20:00:00 +0800
Message-Id: <20230807120006.6361-1-src.res.211@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

v3:
    * Remove the fancy character thoroughly asked by Corbet.

v2:
    * Remove the fancy character U+feff (ZERO WIDTH NO-BREAK SPACE) reported by Corbet
      in https://lore.kernel.org/lkml/87bkg5dp6x.fsf@meer.lwn.net/.

v1:
    https://lore.kernel.org/lkml/20230720132729.1821-1-src.res.211@gmail.com/

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
 .../zh_TW/admin-guide/mm/damon/lru_sort.rst   | 265 ++++++
 .../zh_TW/admin-guide/mm/damon/reclaim.rst    | 230 ++++++
 .../zh_TW/admin-guide/mm/damon/start.rst      | 126 +++
 .../zh_TW/admin-guide/mm/damon/usage.rst      | 593 ++++++++++++++
 .../zh_TW/admin-guide/mm/index.rst            |  52 ++
 .../translations/zh_TW/admin-guide/mm/ksm.rst | 201 +++++
 .../zh_TW/admin-guide/reporting-issues.rst    | 729 +++++++++--------
 .../admin-guide/reporting-regressions.rst     | 371 +++++++++
 .../zh_TW/admin-guide/security-bugs.rst       |  28 +-
 .../translations/zh_TW/admin-guide/sysrq.rst  | 283 +++++++
 .../zh_TW/admin-guide/tainted-kernels.rst     |  86 +-
 .../zh_TW/admin-guide/unicode.rst             |  12 +-
 .../translations/zh_TW/arch/arm/Booting       | 176 ++++
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
 .../translations/zh_TW/process/2.Process.rst  | 130 +--
 .../zh_TW/process/3.Early-stage.rst           |  44 +-
 .../translations/zh_TW/process/4.Coding.rst   | 102 +--
 .../translations/zh_TW/process/5.Posting.rst  |  66 +-
 .../zh_TW/process/6.Followthrough.rst         |  46 +-
 .../zh_TW/process/7.AdvancedTopics.rst        |  56 +-
 .../zh_TW/process/8.Conclusion.rst            |  10 +-
 .../code-of-conduct-interpretation.rst        |  52 +-
 .../zh_TW/process/code-of-conduct.rst         |  18 +-
 .../zh_TW/process/coding-style.rst            | 400 ++++++----
 .../zh_TW/process/development-process.rst     |   2 +-
 .../zh_TW/process/email-clients.rst           | 273 ++++---
 .../process/embargoed-hardware-issues.rst     |  78 +-
 .../translations/zh_TW/process/howto.rst      | 144 ++--
 .../translations/zh_TW/process/index.rst      |   5 +-
 .../zh_TW/process/kernel-driver-statement.rst |   2 +-
 .../process/kernel-enforcement-statement.rst  |  14 +-
 .../zh_TW/process/license-rules.rst           |  54 +-
 .../zh_TW/process/management-style.rst        |  60 +-
 .../zh_TW/process/stable-api-nonsense.rst     |  86 +-
 .../zh_TW/process/stable-kernel-rules.rst     |  36 +-
 .../zh_TW/process/submit-checklist.rst        |  92 ++-
 .../zh_TW/process/submitting-patches.rst      | 755 +++++++++---------
 .../process/volatile-considered-harmful.rst   |  32 +-
 75 files changed, 5781 insertions(+), 2079 deletions(-)
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

