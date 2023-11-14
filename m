Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9217EB0F5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 14:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbjKNNeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 08:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbjKNNeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 08:34:12 -0500
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552D1D6A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 05:34:03 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:82cc:3fa:47b0:575d])
        by laurent.telenet-ops.be with bizsmtp
        id ADZz2B00K41ptHZ01DZzdH; Tue, 14 Nov 2023 14:33:59 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1r2tY5-009H0z-QB;
        Tue, 14 Nov 2023 14:33:59 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1r2tYF-005TgX-Ca;
        Tue, 14 Nov 2023 14:33:59 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k: defconfig: Update defconfigs for v6.7-rc1
Date:   Tue, 14 Nov 2023 14:33:58 +0100
Message-Id: <7abb82edd14ee77d985f3949a673c52bb2ee28b5.1699960088.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  - Enable modular build of the new bcachefs filesystem,
  - Drop CONFIG_CRYPTO_MANAGER=y (auto-enabled since commit
    845346841b77af84 ("crypto: skcipher - Add dependency on ecb")),
  - Drop CONFIG_DEV_APPLETALK=m, CONFIG_IPDDP=m, and CONFIG_IPDDP_ENCAP=y
    (removed in commit 1dab47139e6118a4 ("appletalk: remove ipddp
    driver")).

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
To be queued in the m68k for-v6.8 branch.

 arch/m68k/configs/amiga_defconfig    | 2 +-
 arch/m68k/configs/apollo_defconfig   | 2 +-
 arch/m68k/configs/atari_defconfig    | 2 +-
 arch/m68k/configs/bvme6000_defconfig | 2 +-
 arch/m68k/configs/hp300_defconfig    | 2 +-
 arch/m68k/configs/mac_defconfig      | 5 +----
 arch/m68k/configs/multi_defconfig    | 5 +----
 arch/m68k/configs/mvme147_defconfig  | 2 +-
 arch/m68k/configs/mvme16x_defconfig  | 2 +-
 arch/m68k/configs/q40_defconfig      | 2 +-
 arch/m68k/configs/sun3_defconfig     | 2 +-
 arch/m68k/configs/sun3x_defconfig    | 2 +-
 12 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
index 7e6b74b6eecd3925..b4d71fea558f1f0f 100644
--- a/arch/m68k/configs/amiga_defconfig
+++ b/arch/m68k/configs/amiga_defconfig
@@ -453,6 +453,7 @@ CONFIG_REISERFS_FS=m
 CONFIG_JFS_FS=m
 CONFIG_OCFS2_FS=m
 # CONFIG_OCFS2_DEBUG_MASKLOG is not set
+CONFIG_BCACHEFS_FS=m
 CONFIG_FANOTIFY=y
 CONFIG_QUOTA_NETLINK_INTERFACE=y
 CONFIG_AUTOFS_FS=m
@@ -550,7 +551,6 @@ CONFIG_NLS_MAC_TURKISH=m
 CONFIG_DLM=m
 CONFIG_ENCRYPTED_KEYS=m
 CONFIG_HARDENED_USERCOPY=y
-CONFIG_CRYPTO_MANAGER=y
 CONFIG_CRYPTO_USER=m
 CONFIG_CRYPTO_CRYPTD=m
 CONFIG_CRYPTO_TEST=m
diff --git a/arch/m68k/configs/apollo_defconfig b/arch/m68k/configs/apollo_defconfig
index 0b403e2efcd5e3e1..682d8cd3dd3cea94 100644
--- a/arch/m68k/configs/apollo_defconfig
+++ b/arch/m68k/configs/apollo_defconfig
@@ -410,6 +410,7 @@ CONFIG_REISERFS_FS=m
 CONFIG_JFS_FS=m
 CONFIG_OCFS2_FS=m
 # CONFIG_OCFS2_DEBUG_MASKLOG is not set
+CONFIG_BCACHEFS_FS=m
 CONFIG_FANOTIFY=y
 CONFIG_QUOTA_NETLINK_INTERFACE=y
 CONFIG_AUTOFS_FS=m
@@ -507,7 +508,6 @@ CONFIG_NLS_MAC_TURKISH=m
 CONFIG_DLM=m
 CONFIG_ENCRYPTED_KEYS=m
 CONFIG_HARDENED_USERCOPY=y
-CONFIG_CRYPTO_MANAGER=y
 CONFIG_CRYPTO_USER=m
 CONFIG_CRYPTO_CRYPTD=m
 CONFIG_CRYPTO_TEST=m
diff --git a/arch/m68k/configs/atari_defconfig b/arch/m68k/configs/atari_defconfig
index e3febc65f998dcfa..946ac609c0d07da9 100644
--- a/arch/m68k/configs/atari_defconfig
+++ b/arch/m68k/configs/atari_defconfig
@@ -441,6 +441,7 @@ CONFIG_REISERFS_FS=m
 CONFIG_JFS_FS=m
 CONFIG_OCFS2_FS=m
 # CONFIG_OCFS2_DEBUG_MASKLOG is not set
+CONFIG_BCACHEFS_FS=m
 CONFIG_FANOTIFY=y
 CONFIG_QUOTA_NETLINK_INTERFACE=y
 CONFIG_AUTOFS_FS=m
@@ -538,7 +539,6 @@ CONFIG_NLS_MAC_TURKISH=m
 CONFIG_DLM=m
 CONFIG_ENCRYPTED_KEYS=m
 CONFIG_HARDENED_USERCOPY=y
-CONFIG_CRYPTO_MANAGER=y
 CONFIG_CRYPTO_USER=m
 CONFIG_CRYPTO_CRYPTD=m
 CONFIG_CRYPTO_TEST=m
diff --git a/arch/m68k/configs/bvme6000_defconfig b/arch/m68k/configs/bvme6000_defconfig
index 3c160636a2e91342..7395c12caef6e84a 100644
--- a/arch/m68k/configs/bvme6000_defconfig
+++ b/arch/m68k/configs/bvme6000_defconfig
@@ -402,6 +402,7 @@ CONFIG_REISERFS_FS=m
 CONFIG_JFS_FS=m
 CONFIG_OCFS2_FS=m
 # CONFIG_OCFS2_DEBUG_MASKLOG is not set
+CONFIG_BCACHEFS_FS=m
 CONFIG_FANOTIFY=y
 CONFIG_QUOTA_NETLINK_INTERFACE=y
 CONFIG_AUTOFS_FS=m
@@ -499,7 +500,6 @@ CONFIG_NLS_MAC_TURKISH=m
 CONFIG_DLM=m
 CONFIG_ENCRYPTED_KEYS=m
 CONFIG_HARDENED_USERCOPY=y
-CONFIG_CRYPTO_MANAGER=y
 CONFIG_CRYPTO_USER=m
 CONFIG_CRYPTO_CRYPTD=m
 CONFIG_CRYPTO_TEST=m
diff --git a/arch/m68k/configs/hp300_defconfig b/arch/m68k/configs/hp300_defconfig
index 23cf07c49d1411d4..92506bc7f78daef1 100644
--- a/arch/m68k/configs/hp300_defconfig
+++ b/arch/m68k/configs/hp300_defconfig
@@ -412,6 +412,7 @@ CONFIG_REISERFS_FS=m
 CONFIG_JFS_FS=m
 CONFIG_OCFS2_FS=m
 # CONFIG_OCFS2_DEBUG_MASKLOG is not set
+CONFIG_BCACHEFS_FS=m
 CONFIG_FANOTIFY=y
 CONFIG_QUOTA_NETLINK_INTERFACE=y
 CONFIG_AUTOFS_FS=m
@@ -509,7 +510,6 @@ CONFIG_NLS_MAC_TURKISH=m
 CONFIG_DLM=m
 CONFIG_ENCRYPTED_KEYS=m
 CONFIG_HARDENED_USERCOPY=y
-CONFIG_CRYPTO_MANAGER=y
 CONFIG_CRYPTO_USER=m
 CONFIG_CRYPTO_CRYPTD=m
 CONFIG_CRYPTO_TEST=m
diff --git a/arch/m68k/configs/mac_defconfig b/arch/m68k/configs/mac_defconfig
index 619a0d93ce5bb2be..144bc8c0d8b590b3 100644
--- a/arch/m68k/configs/mac_defconfig
+++ b/arch/m68k/configs/mac_defconfig
@@ -269,9 +269,6 @@ CONFIG_RDS_TCP=m
 CONFIG_L2TP=m
 CONFIG_BRIDGE=m
 CONFIG_ATALK=m
-CONFIG_DEV_APPLETALK=m
-CONFIG_IPDDP=m
-CONFIG_IPDDP_ENCAP=y
 CONFIG_6LOWPAN=m
 CONFIG_6LOWPAN_GHC_EXT_HDR_HOP=m
 CONFIG_6LOWPAN_GHC_UDP=m
@@ -432,6 +429,7 @@ CONFIG_REISERFS_FS=m
 CONFIG_JFS_FS=m
 CONFIG_OCFS2_FS=m
 # CONFIG_OCFS2_DEBUG_MASKLOG is not set
+CONFIG_BCACHEFS_FS=m
 CONFIG_FANOTIFY=y
 CONFIG_QUOTA_NETLINK_INTERFACE=y
 CONFIG_AUTOFS_FS=m
@@ -529,7 +527,6 @@ CONFIG_NLS_MAC_TURKISH=m
 CONFIG_DLM=m
 CONFIG_ENCRYPTED_KEYS=m
 CONFIG_HARDENED_USERCOPY=y
-CONFIG_CRYPTO_MANAGER=y
 CONFIG_CRYPTO_USER=m
 CONFIG_CRYPTO_CRYPTD=m
 CONFIG_CRYPTO_TEST=m
diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
index d9430bc2b2dea5b9..07594c72949773f6 100644
--- a/arch/m68k/configs/multi_defconfig
+++ b/arch/m68k/configs/multi_defconfig
@@ -289,9 +289,6 @@ CONFIG_RDS_TCP=m
 CONFIG_L2TP=m
 CONFIG_BRIDGE=m
 CONFIG_ATALK=m
-CONFIG_DEV_APPLETALK=m
-CONFIG_IPDDP=m
-CONFIG_IPDDP_ENCAP=y
 CONFIG_6LOWPAN=m
 CONFIG_6LOWPAN_GHC_EXT_HDR_HOP=m
 CONFIG_6LOWPAN_GHC_UDP=m
@@ -518,6 +515,7 @@ CONFIG_REISERFS_FS=m
 CONFIG_JFS_FS=m
 CONFIG_OCFS2_FS=m
 # CONFIG_OCFS2_DEBUG_MASKLOG is not set
+CONFIG_BCACHEFS_FS=m
 CONFIG_FANOTIFY=y
 CONFIG_QUOTA_NETLINK_INTERFACE=y
 CONFIG_AUTOFS_FS=m
@@ -615,7 +613,6 @@ CONFIG_NLS_MAC_TURKISH=m
 CONFIG_DLM=m
 CONFIG_ENCRYPTED_KEYS=m
 CONFIG_HARDENED_USERCOPY=y
-CONFIG_CRYPTO_MANAGER=y
 CONFIG_CRYPTO_USER=m
 CONFIG_CRYPTO_CRYPTD=m
 CONFIG_CRYPTO_TEST=m
diff --git a/arch/m68k/configs/mvme147_defconfig b/arch/m68k/configs/mvme147_defconfig
index eb6132f29bf50f56..c34de6c1de203f16 100644
--- a/arch/m68k/configs/mvme147_defconfig
+++ b/arch/m68k/configs/mvme147_defconfig
@@ -401,6 +401,7 @@ CONFIG_REISERFS_FS=m
 CONFIG_JFS_FS=m
 CONFIG_OCFS2_FS=m
 # CONFIG_OCFS2_DEBUG_MASKLOG is not set
+CONFIG_BCACHEFS_FS=m
 CONFIG_FANOTIFY=y
 CONFIG_QUOTA_NETLINK_INTERFACE=y
 CONFIG_AUTOFS_FS=m
@@ -498,7 +499,6 @@ CONFIG_NLS_MAC_TURKISH=m
 CONFIG_DLM=m
 CONFIG_ENCRYPTED_KEYS=m
 CONFIG_HARDENED_USERCOPY=y
-CONFIG_CRYPTO_MANAGER=y
 CONFIG_CRYPTO_USER=m
 CONFIG_CRYPTO_CRYPTD=m
 CONFIG_CRYPTO_TEST=m
diff --git a/arch/m68k/configs/mvme16x_defconfig b/arch/m68k/configs/mvme16x_defconfig
index d0bad674cbb7aec9..83bc029d1f335338 100644
--- a/arch/m68k/configs/mvme16x_defconfig
+++ b/arch/m68k/configs/mvme16x_defconfig
@@ -402,6 +402,7 @@ CONFIG_REISERFS_FS=m
 CONFIG_JFS_FS=m
 CONFIG_OCFS2_FS=m
 # CONFIG_OCFS2_DEBUG_MASKLOG is not set
+CONFIG_BCACHEFS_FS=m
 CONFIG_FANOTIFY=y
 CONFIG_QUOTA_NETLINK_INTERFACE=y
 CONFIG_AUTOFS_FS=m
@@ -499,7 +500,6 @@ CONFIG_NLS_MAC_TURKISH=m
 CONFIG_DLM=m
 CONFIG_ENCRYPTED_KEYS=m
 CONFIG_HARDENED_USERCOPY=y
-CONFIG_CRYPTO_MANAGER=y
 CONFIG_CRYPTO_USER=m
 CONFIG_CRYPTO_CRYPTD=m
 CONFIG_CRYPTO_TEST=m
diff --git a/arch/m68k/configs/q40_defconfig b/arch/m68k/configs/q40_defconfig
index dad6bcfcaeed350e..4f551dac2ed72e36 100644
--- a/arch/m68k/configs/q40_defconfig
+++ b/arch/m68k/configs/q40_defconfig
@@ -419,6 +419,7 @@ CONFIG_REISERFS_FS=m
 CONFIG_JFS_FS=m
 CONFIG_OCFS2_FS=m
 # CONFIG_OCFS2_DEBUG_MASKLOG is not set
+CONFIG_BCACHEFS_FS=m
 CONFIG_FANOTIFY=y
 CONFIG_QUOTA_NETLINK_INTERFACE=y
 CONFIG_AUTOFS_FS=m
@@ -516,7 +517,6 @@ CONFIG_NLS_MAC_TURKISH=m
 CONFIG_DLM=m
 CONFIG_ENCRYPTED_KEYS=m
 CONFIG_HARDENED_USERCOPY=y
-CONFIG_CRYPTO_MANAGER=y
 CONFIG_CRYPTO_USER=m
 CONFIG_CRYPTO_CRYPTD=m
 CONFIG_CRYPTO_TEST=m
diff --git a/arch/m68k/configs/sun3_defconfig b/arch/m68k/configs/sun3_defconfig
index eb1b489b3139cc07..b1bf01182bd32fa2 100644
--- a/arch/m68k/configs/sun3_defconfig
+++ b/arch/m68k/configs/sun3_defconfig
@@ -400,6 +400,7 @@ CONFIG_REISERFS_FS=m
 CONFIG_JFS_FS=m
 CONFIG_OCFS2_FS=m
 # CONFIG_OCFS2_DEBUG_MASKLOG is not set
+CONFIG_BCACHEFS_FS=m
 CONFIG_FANOTIFY=y
 CONFIG_QUOTA_NETLINK_INTERFACE=y
 CONFIG_AUTOFS_FS=m
@@ -497,7 +498,6 @@ CONFIG_NLS_MAC_TURKISH=m
 CONFIG_DLM=m
 CONFIG_ENCRYPTED_KEYS=m
 CONFIG_HARDENED_USERCOPY=y
-CONFIG_CRYPTO_MANAGER=y
 CONFIG_CRYPTO_USER=m
 CONFIG_CRYPTO_CRYPTD=m
 CONFIG_CRYPTO_TEST=m
diff --git a/arch/m68k/configs/sun3x_defconfig b/arch/m68k/configs/sun3x_defconfig
index 9395898265465d9e..5c9a3f71f036e361 100644
--- a/arch/m68k/configs/sun3x_defconfig
+++ b/arch/m68k/configs/sun3x_defconfig
@@ -400,6 +400,7 @@ CONFIG_REISERFS_FS=m
 CONFIG_JFS_FS=m
 CONFIG_OCFS2_FS=m
 # CONFIG_OCFS2_DEBUG_MASKLOG is not set
+CONFIG_BCACHEFS_FS=m
 CONFIG_FANOTIFY=y
 CONFIG_QUOTA_NETLINK_INTERFACE=y
 CONFIG_AUTOFS_FS=m
@@ -497,7 +498,6 @@ CONFIG_NLS_MAC_TURKISH=m
 CONFIG_DLM=m
 CONFIG_ENCRYPTED_KEYS=m
 CONFIG_HARDENED_USERCOPY=y
-CONFIG_CRYPTO_MANAGER=y
 CONFIG_CRYPTO_USER=m
 CONFIG_CRYPTO_CRYPTD=m
 CONFIG_CRYPTO_TEST=m
-- 
2.34.1

