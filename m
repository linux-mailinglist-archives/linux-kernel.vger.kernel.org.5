Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBC47A5164
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 19:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjIRR5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 13:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjIRR5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:57:38 -0400
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AF1112
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 10:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=n8pjl.ca;
        s=protonmail2; t=1695059850; x=1695319050;
        bh=fxkOegwM1kWWZhiEUnJVXy5U34ldzgUlKjJMCE+oxYo=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=i4Jg3qh04A5xAwch6FjEguMLOKOgRgBcj3kr5mQ7qbJT8avXbrYYQ0qpcAQmxT01d
         U7t/24O1kn7Nw4y2D42nKrRKElDbmqY0PxDbjnZzIGxb3rzR0v9EWVf2Bt2VfdGCG0
         jb2lvo4/YxbI4k5YgOdL+tArvwuWzb0hvTF3zqVqZMZav/1Yv7YrrzROgOWjQKpAyM
         qiCWktMgYURXrxId3e7Dfexw4TFCB568zse4/KPx57tQMZ8XsAcUgb8zAqbE/o1B4U
         z1+8MR5kKpu4j14vGxx5CPM17qSKmsfi+YLAwdcnAgxVwv0+pqS/+I/GuveVFRDP5s
         ojhDVqhBpilKg==
Date:   Mon, 18 Sep 2023 17:57:24 +0000
To:     linux-m68k@lists.linux-m68k.org
From:   Peter Lafreniere <peter@n8pjl.ca>
Cc:     Peter Lafreniere <peter@n8pjl.ca>, jack@suse.cz,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org
Subject: [PATCH 5/7] arch: m68k: remove ReiserFS from defconfig
Message-ID: <20230918175529.19011-6-peter@n8pjl.ca>
In-Reply-To: <20230918175529.19011-1-peter@n8pjl.ca>
References: <20230918175529.19011-1-peter@n8pjl.ca>
Feedback-ID: 53133685:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ReiserFS has been deprecated for a year and a half, yet is still built
as part of a defconfig kernel.

According to commit eb103a51640e ("reiserfs: Deprecate reiserfs"), the
filesystem is slated to be removed in 2025. Remove it from the defconfig
profiles now, as part of its deprecation process.

Signed-off-by: Peter Lafreniere <peter@n8pjl.ca>
---
 arch/m68k/configs/amiga_defconfig    | 1 -
 arch/m68k/configs/apollo_defconfig   | 1 -
 arch/m68k/configs/atari_defconfig    | 1 -
 arch/m68k/configs/bvme6000_defconfig | 1 -
 arch/m68k/configs/hp300_defconfig    | 1 -
 arch/m68k/configs/mac_defconfig      | 1 -
 arch/m68k/configs/multi_defconfig    | 1 -
 arch/m68k/configs/mvme147_defconfig  | 1 -
 arch/m68k/configs/mvme16x_defconfig  | 1 -
 arch/m68k/configs/q40_defconfig      | 1 -
 arch/m68k/configs/sun3_defconfig     | 1 -
 arch/m68k/configs/sun3x_defconfig    | 1 -
 12 files changed, 12 deletions(-)

diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_de=
fconfig
index 6deb8faa564b..f89f57aedeed 100644
--- a/arch/m68k/configs/amiga_defconfig
+++ b/arch/m68k/configs/amiga_defconfig
@@ -448,7 +448,6 @@ CONFIG_RTC_DRV_RP5C01=3Dm
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_DAX=3Dm
 CONFIG_EXT4_FS=3Dy
-CONFIG_REISERFS_FS=3Dm
 CONFIG_JFS_FS=3Dm
 CONFIG_OCFS2_FS=3Dm
 # CONFIG_OCFS2_DEBUG_MASKLOG is not set
diff --git a/arch/m68k/configs/apollo_defconfig b/arch/m68k/configs/apollo_=
defconfig
index 802c161827f4..ac18b21d4bf1 100644
--- a/arch/m68k/configs/apollo_defconfig
+++ b/arch/m68k/configs/apollo_defconfig
@@ -405,7 +405,6 @@ CONFIG_RTC_DRV_GENERIC=3Dm
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_DAX=3Dm
 CONFIG_EXT4_FS=3Dy
-CONFIG_REISERFS_FS=3Dm
 CONFIG_JFS_FS=3Dm
 CONFIG_OCFS2_FS=3Dm
 # CONFIG_OCFS2_DEBUG_MASKLOG is not set
diff --git a/arch/m68k/configs/atari_defconfig b/arch/m68k/configs/atari_de=
fconfig
index 2cb3d755873b..7cb3b643e57c 100644
--- a/arch/m68k/configs/atari_defconfig
+++ b/arch/m68k/configs/atari_defconfig
@@ -425,7 +425,6 @@ CONFIG_RTC_DRV_GENERIC=3Dm
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_DAX=3Dm
 CONFIG_EXT4_FS=3Dy
-CONFIG_REISERFS_FS=3Dm
 CONFIG_JFS_FS=3Dm
 CONFIG_OCFS2_FS=3Dm
 # CONFIG_OCFS2_DEBUG_MASKLOG is not set
diff --git a/arch/m68k/configs/bvme6000_defconfig b/arch/m68k/configs/bvme6=
000_defconfig
index b13552caa6b3..359c51562db2 100644
--- a/arch/m68k/configs/bvme6000_defconfig
+++ b/arch/m68k/configs/bvme6000_defconfig
@@ -397,7 +397,6 @@ CONFIG_RTC_DRV_GENERIC=3Dm
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_DAX=3Dm
 CONFIG_EXT4_FS=3Dy
-CONFIG_REISERFS_FS=3Dm
 CONFIG_JFS_FS=3Dm
 CONFIG_OCFS2_FS=3Dm
 # CONFIG_OCFS2_DEBUG_MASKLOG is not set
diff --git a/arch/m68k/configs/hp300_defconfig b/arch/m68k/configs/hp300_de=
fconfig
index f88356c45440..41eb91c33eae 100644
--- a/arch/m68k/configs/hp300_defconfig
+++ b/arch/m68k/configs/hp300_defconfig
@@ -407,7 +407,6 @@ CONFIG_RTC_DRV_GENERIC=3Dm
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_DAX=3Dm
 CONFIG_EXT4_FS=3Dy
-CONFIG_REISERFS_FS=3Dm
 CONFIG_JFS_FS=3Dm
 CONFIG_OCFS2_FS=3Dm
 # CONFIG_OCFS2_DEBUG_MASKLOG is not set
diff --git a/arch/m68k/configs/mac_defconfig b/arch/m68k/configs/mac_defcon=
fig
index 7c2ebb616fba..cf384a98323f 100644
--- a/arch/m68k/configs/mac_defconfig
+++ b/arch/m68k/configs/mac_defconfig
@@ -427,7 +427,6 @@ CONFIG_RTC_DRV_GENERIC=3Dm
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_DAX=3Dm
 CONFIG_EXT4_FS=3Dy
-CONFIG_REISERFS_FS=3Dm
 CONFIG_JFS_FS=3Dm
 CONFIG_OCFS2_FS=3Dm
 # CONFIG_OCFS2_DEBUG_MASKLOG is not set
diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_de=
fconfig
index d3b272910b38..7472b6d949fa 100644
--- a/arch/m68k/configs/multi_defconfig
+++ b/arch/m68k/configs/multi_defconfig
@@ -513,7 +513,6 @@ CONFIG_RTC_DRV_GENERIC=3Dm
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_DAX=3Dm
 CONFIG_EXT4_FS=3Dy
-CONFIG_REISERFS_FS=3Dm
 CONFIG_JFS_FS=3Dm
 CONFIG_OCFS2_FS=3Dm
 # CONFIG_OCFS2_DEBUG_MASKLOG is not set
diff --git a/arch/m68k/configs/mvme147_defconfig b/arch/m68k/configs/mvme14=
7_defconfig
index 4529bc4b843c..064a5906e8a6 100644
--- a/arch/m68k/configs/mvme147_defconfig
+++ b/arch/m68k/configs/mvme147_defconfig
@@ -396,7 +396,6 @@ CONFIG_RTC_DRV_GENERIC=3Dm
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_DAX=3Dm
 CONFIG_EXT4_FS=3Dy
-CONFIG_REISERFS_FS=3Dm
 CONFIG_JFS_FS=3Dm
 CONFIG_OCFS2_FS=3Dm
 # CONFIG_OCFS2_DEBUG_MASKLOG is not set
diff --git a/arch/m68k/configs/mvme16x_defconfig b/arch/m68k/configs/mvme16=
x_defconfig
index 30824032e4d5..6ff79eae70ed 100644
--- a/arch/m68k/configs/mvme16x_defconfig
+++ b/arch/m68k/configs/mvme16x_defconfig
@@ -397,7 +397,6 @@ CONFIG_RTC_DRV_GENERIC=3Dm
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_DAX=3Dm
 CONFIG_EXT4_FS=3Dy
-CONFIG_REISERFS_FS=3Dm
 CONFIG_JFS_FS=3Dm
 CONFIG_OCFS2_FS=3Dm
 # CONFIG_OCFS2_DEBUG_MASKLOG is not set
diff --git a/arch/m68k/configs/q40_defconfig b/arch/m68k/configs/q40_defcon=
fig
index 3911211410ed..922804e0e2cd 100644
--- a/arch/m68k/configs/q40_defconfig
+++ b/arch/m68k/configs/q40_defconfig
@@ -414,7 +414,6 @@ CONFIG_RTC_DRV_GENERIC=3Dm
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_DAX=3Dm
 CONFIG_EXT4_FS=3Dy
-CONFIG_REISERFS_FS=3Dm
 CONFIG_JFS_FS=3Dm
 CONFIG_OCFS2_FS=3Dm
 # CONFIG_OCFS2_DEBUG_MASKLOG is not set
diff --git a/arch/m68k/configs/sun3_defconfig b/arch/m68k/configs/sun3_defc=
onfig
index 991730c50957..3583ac7c8986 100644
--- a/arch/m68k/configs/sun3_defconfig
+++ b/arch/m68k/configs/sun3_defconfig
@@ -395,7 +395,6 @@ CONFIG_RTC_DRV_GENERIC=3Dm
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_DAX=3Dm
 CONFIG_EXT4_FS=3Dy
-CONFIG_REISERFS_FS=3Dm
 CONFIG_JFS_FS=3Dm
 CONFIG_OCFS2_FS=3Dm
 # CONFIG_OCFS2_DEBUG_MASKLOG is not set
diff --git a/arch/m68k/configs/sun3x_defconfig b/arch/m68k/configs/sun3x_de=
fconfig
index e80d7509ab1d..a6df5013f915 100644
--- a/arch/m68k/configs/sun3x_defconfig
+++ b/arch/m68k/configs/sun3x_defconfig
@@ -395,7 +395,6 @@ CONFIG_RTC_DRV_GENERIC=3Dm
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_DAX=3Dm
 CONFIG_EXT4_FS=3Dy
-CONFIG_REISERFS_FS=3Dm
 CONFIG_JFS_FS=3Dm
 CONFIG_OCFS2_FS=3Dm
 # CONFIG_OCFS2_DEBUG_MASKLOG is not set
--=20
2.42.0


