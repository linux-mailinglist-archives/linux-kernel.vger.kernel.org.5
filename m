Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED14C7F2979
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 10:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbjKUJ5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 04:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234117AbjKUJ5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 04:57:11 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD6E10E;
        Tue, 21 Nov 2023 01:57:06 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6c39ad730aaso4330094b3a.0;
        Tue, 21 Nov 2023 01:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700560626; x=1701165426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ka1cD2Bwmz44NS9VOtFyYCz3XAOOJeOGdzsr6w0dbzg=;
        b=ScO8zGFvQa5SHqShlJIWoT0gQnPVGfuA5/nhXurEY7Zs4K7cmHIFllsV8s5I828Jai
         fFzwjThO76NmxMvam0IefU2QEh1JhEwJP54SyzaPACDq2wMVbLWIeCb5tghO7Z5MjNb8
         SbSb6cXM8HX4y4B9Ihbsml+baALw10UwmIYoUXWDAbD91wm1OJw8M2UtQ9eflZ4aE8ns
         xnY5cZHfXVSDx/UCR5qnLyBLF1R+udzLl86c226hPXJO59vRZbuH3reDmB3fMEoJUNyM
         O5c5UKDf+8gQzV85QYEEPtIIKei0ZqwtWQQiOhcFe7tbTvs3aPedtqc2G5HkrDJVPOG4
         d2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700560626; x=1701165426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ka1cD2Bwmz44NS9VOtFyYCz3XAOOJeOGdzsr6w0dbzg=;
        b=Ah+PQpGWEsjnbFUyqfiDw7OyxSGyMjcisr2SOcti/OKOzVwfaQTLLHT3r59IYX6JvO
         oPB4r+HFchKcNr4iGAGhoYciULhWazgXqqfurbO4+Rvg4egKq8bRh4ICvJP6JDZwC7m8
         V+27S0Mg6bsy4vCcDXpwz1xOgl6hfuj98H4zKEKqVpV9KdujuTlX0ge51eZIWQoKcZua
         Wcc9MIwULqZnl9p++CZJSq0wcSE0ZWTX1rolqbgOiNUhv9O3JQL9qVSovAfJIxr2+jP5
         St+7eJRHHyIhpup/WIWflYGsL8VZ6WoLC0CpQyiD3sLRxUHQpjQdXhkaYIII472H2V3U
         TkDQ==
X-Gm-Message-State: AOJu0YxzNXTVg2mCbauXnLspFjgQmjjtDs+66EenTE4ujZ14TBNwydUT
        Q/qdG822dCybFIomrn0yqqM=
X-Google-Smtp-Source: AGHT+IHFjOu7YbojQq1PeZl9YrECG/pPN3fCUGfp/6gEV5LyTTPVJc/Wba5hfzQXH/anBJaHwD8BfA==
X-Received: by 2002:a05:6a20:d38c:b0:166:82cf:424a with SMTP id iq12-20020a056a20d38c00b0016682cf424amr9289456pzb.33.1700560625873;
        Tue, 21 Nov 2023 01:57:05 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id g7-20020a170902934700b001ca4c7bee0csm7536341plp.232.2023.11.21.01.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 01:57:05 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id 84D8A102106CF; Tue, 21 Nov 2023 16:57:02 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux XFS <linux-xfs@vger.kernel.org>,
        Linux Kernel Workflows <workflows@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Allison Henderson <allison.henderson@oracle.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Charles Han <hanchunchao@inspur.com>
Subject: [PATCH] Documentation: xfs: consolidate XFS docs into its own subdirectory
Date:   Tue, 21 Nov 2023 16:56:58 +0700
Message-ID: <20231121095658.28254-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4131; i=bagasdotme@gmail.com; h=from:subject; bh=YcVBndo3Vf30ZXt3UnAKYl//U5fISnvK9iyQHm73b6k=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDKkxdarv/O6evnf6wi//GHaJ/WEaGfPyf1jx/P5dIl620 Kd497F7HaUsDGJcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZjIWX1GhkemD+Y/dmmruL/n vK7xedu/mzXVLadPfXhcsHuh6e7705YxMjy/de3upIDzL+19RV7tLDivzym3I+jO/ee71wnvCXh QfZgfAA==
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
 Documentation/filesystems/index.rst                |  5 +----
 Documentation/filesystems/xfs/index.rst            | 14 ++++++++++++++
 .../{ => xfs}/xfs-delayed-logging-design.rst       |  0
 .../{ => xfs}/xfs-maintainer-entry-profile.rst     |  0
 .../{ => xfs}/xfs-online-fsck-design.rst           |  0
 .../{ => xfs}/xfs-self-describing-metadata.rst     |  0
 .../maintainer/maintainer-entry-profile.rst        |  2 +-
 7 files changed, 16 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/filesystems/xfs/index.rst
 rename Documentation/filesystems/{ => xfs}/xfs-delayed-logging-design.rst (100%)
 rename Documentation/filesystems/{ => xfs}/xfs-maintainer-entry-profile.rst (100%)
 rename Documentation/filesystems/{ => xfs}/xfs-online-fsck-design.rst (100%)
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
similarity index 100%
rename from Documentation/filesystems/xfs-online-fsck-design.rst
rename to Documentation/filesystems/xfs/xfs-online-fsck-design.rst
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

base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
-- 
An old man doll... just what I always wanted! - Clara

