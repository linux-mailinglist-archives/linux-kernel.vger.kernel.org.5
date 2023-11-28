Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E837FBA6F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 13:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344850AbjK1Mpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 07:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344687AbjK1Mpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 07:45:43 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2341BEC;
        Tue, 28 Nov 2023 04:45:35 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-35cb5b21c41so8798355ab.1;
        Tue, 28 Nov 2023 04:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701175534; x=1701780334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l59sLPegN1fDsu66rSuuCLp/yRRxYIU/BkresE88jUI=;
        b=hzezjavTwir2WpoD7tz97aIJvOYbmlTGE9t3BkfozP0adjWAqbaUC7Fzon2sf73F4y
         v8eB9BRyz3Vt7RYEHksttPfQDu1nXtyykIowyiMc6kJiZ5DnM7ZFEM9Ub6BeCcKpxbsi
         WLyUVie1WR1xjaWelOif4mVXYa/Vs/em/7hkXtVLl8PKnCpMRZf4jXC9hBrD6SqzJN0U
         OFwyMvfnjYpYAqdD3G7KgCVjqcrT/am4GlbeOzaxk8u6VhO7GQMdQfRU8RiKyXsgUY7Q
         3MZWkIRP7pTdfumrg3F50abauyd3t82v9ZdoOaBGhdpEwCO0NZjRDVyfve9Vyf/KUMlI
         +ERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701175534; x=1701780334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l59sLPegN1fDsu66rSuuCLp/yRRxYIU/BkresE88jUI=;
        b=VWgfQN7wkHZB3dIWUlQgAkDjBfzFVrW5kXUv0/di0zwNxicX6GNAWG8imE3GwiaF3K
         T/z/eWD6SV4dWtyXAOtQupRI4Vz3iXRN35h4WMbw1v7VXcPfQtcwk6y+2mz7K+gE/C5k
         d551pHhXVEs5ULRyltvhP6qK1KpdzsGwB/+LC9QzqVEyraoX7ZPrch5tqa3iXZ+oM1zI
         c9PXCN1LrEGvAEZ8I+XjkzlsbFSg96Q0fYonqj4lhEcYMLEGPmgltzcoYtrHZH+t2UlC
         VwNaqiF33BFMZehNquhS4WHAdMjqhAMb/W91bQEWS8/w4S2bbd+ek55E6xHLOlwy8ypL
         UMzg==
X-Gm-Message-State: AOJu0YzhZcD9jo/NMmTVnVOg0lfocWui+ny09uDeqEDWIHBw64qzx8rP
        71/5yBWuVDjdwI3zsomWc5E=
X-Google-Smtp-Source: AGHT+IH37NCK5YZX5pRanYp5XFBJqXj8YDveWJKzSc7jDwsbzMwfZZyeCtWrlDUtrRKTvjKKnB58kA==
X-Received: by 2002:a92:d446:0:b0:35d:1ea0:f252 with SMTP id r6-20020a92d446000000b0035d1ea0f252mr784028ilm.28.1701175533763;
        Tue, 28 Nov 2023 04:45:33 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id s12-20020a056a00194c00b006c4d4d5a197sm9076478pfk.171.2023.11.28.04.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 04:45:33 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id E1B4C100EE62F; Tue, 28 Nov 2023 19:45:29 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux XFS <linux-xfs@vger.kernel.org>,
        Linux Kernel Workflows <workflows@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Allison Henderson <allison.henderson@oracle.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Charles Han <hanchunchao@inspur.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH RESEND v2] Documentation: xfs: consolidate XFS docs into its own subdirectory
Date:   Tue, 28 Nov 2023 19:45:22 +0700
Message-ID: <20231128124522.28499-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5653; i=bagasdotme@gmail.com; h=from:subject; bh=2P9AXl78KfG0g8eCnYV7l8hPNPJiwGakqJSYbpOC4Ck=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDKmp97d9r2mVW6p8zSRT9Y5bkdqmM0ossxqsV70+0mx+4 FKC9Z+GjlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAExk51RGhr5ZP5kWXqiczRtY kHZPsiWzbcGnzV+8hRwPRs0yefLZ7Dcjw4mFl08X6QX4nNhz+KSRzVH16Nw4473T2aSuv7s1973 /X3YA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

XFS docs are currently in upper-level Documentation/filesystems.
Although these are currently 4 docs, they are already outstanding as
a group and can be moved to its own subdirectory.

Consolidate them into Documentation/filesystems/xfs/.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
Changes since v1 [1]:

  * Also update references to old doc path to address kernel test robot
    warnings [2].

[1]: https://lore.kernel.org/linux-doc/20231121095658.28254-1-bagasdotme@gmail.com/
[2]: https://lore.kernel.org/linux-doc/a9abc5ec-f3cd-4a1a-81b9-a6900124d38b@gmail.com/

 Documentation/filesystems/index.rst                |  5 +----
 Documentation/filesystems/xfs/index.rst            | 14 ++++++++++++++
 .../{ => xfs}/xfs-delayed-logging-design.rst       |  0
 .../{ => xfs}/xfs-maintainer-entry-profile.rst     |  0
 .../{ => xfs}/xfs-online-fsck-design.rst           |  2 +-
 .../{ => xfs}/xfs-self-describing-metadata.rst     |  0
 .../maintainer/maintainer-entry-profile.rst        |  2 +-
 MAINTAINERS                                        |  4 ++--
 8 files changed, 19 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/filesystems/xfs/index.rst
 rename Documentation/filesystems/{ => xfs}/xfs-delayed-logging-design.rst (100%)
 rename Documentation/filesystems/{ => xfs}/xfs-maintainer-entry-profile.rst (100%)
 rename Documentation/filesystems/{ => xfs}/xfs-online-fsck-design.rst (99%)
 rename Documentation/filesystems/{ => xfs}/xfs-self-describing-metadata.rst (100%)

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 09cade7eaefc8c..e18bc5ae3b35f8 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -121,8 +121,5 @@ Documentation for filesystem implementations.
    udf
    virtiofs
    vfat
-   xfs-delayed-logging-design
-   xfs-maintainer-entry-profile
-   xfs-self-describing-metadata
-   xfs-online-fsck-design
+   xfs/index
    zonefs
diff --git a/Documentation/filesystems/xfs/index.rst b/Documentation/filesystems/xfs/index.rst
new file mode 100644
index 00000000000000..ab66c57a5d18ea
--- /dev/null
+++ b/Documentation/filesystems/xfs/index.rst
@@ -0,0 +1,14 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============================
+XFS Filesystem Documentation
+============================
+
+.. toctree::
+   :maxdepth: 2
+   :numbered:
+
+   xfs-delayed-logging-design
+   xfs-maintainer-entry-profile
+   xfs-self-describing-metadata
+   xfs-online-fsck-design
diff --git a/Documentation/filesystems/xfs-delayed-logging-design.rst b/Documentation/filesystems/xfs/xfs-delayed-logging-design.rst
similarity index 100%
rename from Documentation/filesystems/xfs-delayed-logging-design.rst
rename to Documentation/filesystems/xfs/xfs-delayed-logging-design.rst
diff --git a/Documentation/filesystems/xfs-maintainer-entry-profile.rst b/Documentation/filesystems/xfs/xfs-maintainer-entry-profile.rst
similarity index 100%
rename from Documentation/filesystems/xfs-maintainer-entry-profile.rst
rename to Documentation/filesystems/xfs/xfs-maintainer-entry-profile.rst
diff --git a/Documentation/filesystems/xfs-online-fsck-design.rst b/Documentation/filesystems/xfs/xfs-online-fsck-design.rst
similarity index 99%
rename from Documentation/filesystems/xfs-online-fsck-design.rst
rename to Documentation/filesystems/xfs/xfs-online-fsck-design.rst
index a0678101a7d02d..352516feef6ffe 100644
--- a/Documentation/filesystems/xfs-online-fsck-design.rst
+++ b/Documentation/filesystems/xfs/xfs-online-fsck-design.rst
@@ -962,7 +962,7 @@ disk, but these buffer verifiers cannot provide any consistency checking
 between metadata structures.
 
 For more information, please see the documentation for
-Documentation/filesystems/xfs-self-describing-metadata.rst
+Documentation/filesystems/xfs/xfs-self-describing-metadata.rst
 
 Reverse Mapping
 ---------------
diff --git a/Documentation/filesystems/xfs-self-describing-metadata.rst b/Documentation/filesystems/xfs/xfs-self-describing-metadata.rst
similarity index 100%
rename from Documentation/filesystems/xfs-self-describing-metadata.rst
rename to Documentation/filesystems/xfs/xfs-self-describing-metadata.rst
diff --git a/Documentation/maintainer/maintainer-entry-profile.rst b/Documentation/maintainer/maintainer-entry-profile.rst
index 7ad4bfc2cc038a..18cee1edaecb6f 100644
--- a/Documentation/maintainer/maintainer-entry-profile.rst
+++ b/Documentation/maintainer/maintainer-entry-profile.rst
@@ -105,4 +105,4 @@ to do something different in the near future.
    ../driver-api/media/maintainer-entry-profile
    ../driver-api/vfio-pci-device-specific-driver-acceptance
    ../nvme/feature-and-quirk-policy
-   ../filesystems/xfs-maintainer-entry-profile
+   ../filesystems/xfs/xfs-maintainer-entry-profile
diff --git a/MAINTAINERS b/MAINTAINERS
index ea790149af7951..fd288ac57e19fb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23893,10 +23893,10 @@ S:	Supported
 W:	http://xfs.org/
 C:	irc://irc.oftc.net/xfs
 T:	git git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
-P:	Documentation/filesystems/xfs-maintainer-entry-profile.rst
+P:	Documentation/filesystems/xfs/xfs-maintainer-entry-profile.rst
 F:	Documentation/ABI/testing/sysfs-fs-xfs
 F:	Documentation/admin-guide/xfs.rst
-F:	Documentation/filesystems/xfs-*
+F:	Documentation/filesystems/xfs/xfs-*
 F:	fs/xfs/
 F:	include/uapi/linux/dqblk_xfs.h
 F:	include/uapi/linux/fsmap.h

base-commit: 9c235dfc3d3f901fe22acb20f2ab37ff39f2ce02
-- 
An old man doll... just what I always wanted! - Clara

