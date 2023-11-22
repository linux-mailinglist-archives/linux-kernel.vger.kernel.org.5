Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5EEB7F416B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235218AbjKVJQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjKVJQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:16:33 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B03387A;
        Wed, 22 Nov 2023 01:02:46 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3b2f507c03cso3775175b6e.2;
        Wed, 22 Nov 2023 01:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700643766; x=1701248566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zqf2f1E5RgcLoQ6/aysNL5PDelgy8hGc+g3jRxQV3JQ=;
        b=m5jhwesRX5T0tyTbjzwLGvVAd78neXEdW9oBWhMJKwUFhFlGLyn0eXw9edvXYZgUo4
         8JN1etWZInXXxDBU5ZE70VlL9ExUfVnqvUk6s1YtQ+4/Ct6hXl1dLPInyRMythndldTD
         OhbVlQdorVGxy/KxQkufIFXAzKZksV5wf7C3XFy+/Ax3MGTziM7Htxd1N6lbbRUFCzWZ
         FkWX1Dp+VgaIRWu7HCfcSYcAP04IBcemqu58H5gmju4DnpBCRYGtktNLKG0FIF2vhzqg
         LlEBySkoWZpNMNfun82aOxbSHDLFCOZhWEri8u2Wg6nOYWsJZq3gvCn7mdQGbOxU9Yh4
         0SKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700643766; x=1701248566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zqf2f1E5RgcLoQ6/aysNL5PDelgy8hGc+g3jRxQV3JQ=;
        b=KlPZWPHSNq8CkSTEfqALAJdkHcEKLMoSdHfZJv1EwI9zA5iRClwOvT+Da9HvilTcAS
         Yr0WcRX4UPxUm395SOXGIqUPY4BqoJAIIJ2QYQJx/NE65Uy7erzu1VOG6pDSBX44mPj8
         mGAD0dhVyo1Pvhi9gXVDGA+1aj/7JQK0/Z0eqlIZQqjmV8BJASy2UIPDll7y+d7Cw0PV
         riuUzpPGn/tgM+txqpsU+0+ZJoPwoXF1KTSCSJmlZeXV12H02mdxMW3GlahMRrpKuPvV
         kMy6/L3RwIHXPdDihPVi30jN6C+oR3FjPd1tI5DeMxVVzLr3C3Z9Zq4FGYAKEfuJnkrY
         WKIw==
X-Gm-Message-State: AOJu0Yx+5rRo/4fAGlOjtlxVJddRocEl7v0DnYfE10ALava1VQmLTQbm
        IHoTl7+V4pR7LClbPVDVYio=
X-Google-Smtp-Source: AGHT+IHiVRKW4KTm8m7GqRK+w+yAzqnAJxnbgLQR/rF+/3r0X3UW60I22ZSrhhyddgx23FXQsqMhPw==
X-Received: by 2002:a05:6358:88f:b0:16d:bec8:654f with SMTP id m15-20020a056358088f00b0016dbec8654fmr1912296rwj.1.1700643765989;
        Wed, 22 Nov 2023 01:02:45 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id cm7-20020a056a020a0700b005b92ba3938dsm7953586pgb.77.2023.11.22.01.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 01:02:45 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id C705B10210555; Wed, 22 Nov 2023 16:02:40 +0700 (WIB)
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
Subject: [PATCH v2] Documentation: xfs: consolidate XFS docs into its own subdirectory
Date:   Wed, 22 Nov 2023 16:02:06 +0700
Message-ID: <20231122090206.27040-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5653; i=bagasdotme@gmail.com; h=from:subject; bh=vnFA8fgYKcNflGPlxb0NmukL/RfsNaZS7SB0Bji8NOc=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDKmxhw5PtvBMyZ7v++Pxh5nMDx+nfrz6fIVowcnLB4sLZ dW57us0dZSyMIhxMciKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BWAiO28x/K+dd+O0QUVuz8R1 gZr3HhyIt5aeu/2P8bmEqPgdAc4713xh+B8RvD9kphBL/c6Fzya2v5oYeE91e/T+b9FPNA5YN12 Ij2YGAA==
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

base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
-- 
An old man doll... just what I always wanted! - Clara

