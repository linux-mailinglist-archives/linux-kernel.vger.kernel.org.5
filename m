Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB38F7FD6EE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 13:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbjK2MkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 07:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjK2Mj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 07:39:59 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02D6D4A;
        Wed, 29 Nov 2023 04:40:04 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-35ba5e00dc5so26617545ab.1;
        Wed, 29 Nov 2023 04:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701261604; x=1701866404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J18qit5Z0iKKA8YjGWidpFR+jQCxMImqQq5so4h0DKY=;
        b=GDuN3Gp4pYk6GIaBAiWPDT3I6IaV5CFdlYSyOL4mAKZ4Ioa0RV5NXtkFqUyWAbJeQ/
         OzHSfhxNe7dursUc7Z2GgFEWhuuhm/+bucLeIT1kquIQ0k3x4bljPQog94DIIyQfrKVd
         csZk6NtNzonEAMj3L+qvC9vR2ABtKFSEXH+DZh85aTPCyYDfOwaz8UvC8Hy6j7ZVNEBD
         D2HwF4w4uznkxGVNpnNZm/DJu7KT1FlJGKAdV4mECmg1UOLjRKOpl2bw34+XPLaOeMr0
         9RreN/bgocWNK1twyJIKZD57z5SqFgV78lTemFU7uIBKPDHKOEaCaZBtP7ngUAVsTL9u
         kENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701261604; x=1701866404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J18qit5Z0iKKA8YjGWidpFR+jQCxMImqQq5so4h0DKY=;
        b=gM18lNTMhKOCIy3MOGIybFjQYG/WUfDtvsZWWPi63L2GhZ31c8Y0iXCbvUuUKrFU2M
         ZMk6IZcuuwP6gQqwvzveaGvj1UoZ97q6ltkYj6EI7o4YHC0xPiCDyemb84O2/gd3O8DR
         nw+nSvd+08oV2gvlGYzvlJ70o5vqokIC/irfMNTkoaHcdVCAtItxTGZCc8u8FEN0HWL+
         pUw67V9JRZgsdzQGif4C4isznVJmoj5iQOnC6gG6WjNAX0cLdXm4VZPqhHT/2rC3HoBk
         +i9lvLy1nwtPH5t3GayA5xow2mwrihm+wCkUABMqN2TukfVllcQW5coXoA8oEk3/+6ia
         1fgw==
X-Gm-Message-State: AOJu0YzSqAdBjXQHMVY5EdGwPjY3E9Mx9mXRbdf7ubnp5MFyJM9hkb6p
        OuTSIoeSVbQZsJRDZDRpkJOhCZRyHMP4Hg==
X-Google-Smtp-Source: AGHT+IF0xGKiUv5adaCHraeo+BlX6sD+VFezOrMmpx26MCvs2HQABcSx70zfB3uEyTQ/TMJFpPg+2Q==
X-Received: by 2002:a92:3f04:0:b0:35c:d2ed:d807 with SMTP id m4-20020a923f04000000b0035cd2edd807mr10705966ila.20.1701261604131;
        Wed, 29 Nov 2023 04:40:04 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id s13-20020a62e70d000000b006cb8e394574sm10766056pfh.21.2023.11.29.04.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 04:40:03 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id D840610205C79; Wed, 29 Nov 2023 19:39:58 +0700 (WIB)
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
Subject: [PATCH v3] Documentation: xfs: consolidate XFS docs into its own subdirectory
Date:   Wed, 29 Nov 2023 19:39:47 +0700
Message-ID: <20231129123947.4706-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5565; i=bagasdotme@gmail.com; h=from:subject; bh=E7SCxviNqr8B4kMTD16DIR3yCkpEsH8yH+zCkY0neiA=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDKnpBkZpzH4/7io/47/G/X3vFImSFPF/1xMbt/XkKQUa3 QjP5V7YUcrCIMbFICumyDIpka/p9C4jkQvtax1h5rAygQxh4OIUgImYPGb4X9i+4QLjKcHHH4xd Z5XLnOPb0b71zHOBW3ynTQ9Ml1D0ecjwz3BfaK/qDvuJL3I//busIu5VlzCf5YJqzT9TkbcMciJ 6bAA=
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
Changes since v2 [1]:

  * Adjust MAINTAINERS pattern to include all docs in the subdirectory
    by using wildcard.

[1]: https://lore.kernel.org/linux-doc/20231128124522.28499-1-bagasdotme@gmail.com/

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
index ea790149af7951..5ad039cfe9c794 100644
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
+F:	Documentation/filesystems/xfs/*
 F:	fs/xfs/
 F:	include/uapi/linux/dqblk_xfs.h
 F:	include/uapi/linux/fsmap.h

base-commit: 9c235dfc3d3f901fe22acb20f2ab37ff39f2ce02
-- 
An old man doll... just what I always wanted! - Clara

