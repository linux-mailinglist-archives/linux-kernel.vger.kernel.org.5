Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C352B79BE27
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241810AbjIKV7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239857AbjIKOa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 10:30:29 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459C0E54
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 07:30:23 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:a74b:c851:eeda:f0c8])
        by michel.telenet-ops.be with bizsmtp
        id keWL2A00D0nS7QV06eWLNG; Mon, 11 Sep 2023 16:30:20 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qfhvP-00302p-R7;
        Mon, 11 Sep 2023 16:30:20 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qfhvg-007wtj-2I;
        Mon, 11 Sep 2023 16:30:20 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k: defconfig: Update defconfigs for v6.6-rc1
Date:   Mon, 11 Sep 2023 16:30:19 +0200
Message-Id: <43ef623c9053862d93fbc746689d4897b35597ef.1694442486.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  - Enable modular build of the new device model tests,
  - Enable modular build of the glob self-test on configs that didn't
    have it yet (visible since commit b67abaad4d25b5d9 ("kunit: Allow
    kunit test modules to use test filtering")),
  - Replace CONFIG_FB=y by CONFIG_FRAMEBUFFER_CONSOLE=y on the virt
    platform (the former is no longer needed since commit
    55bffc8170bb5813 ("fbdev: Split frame buffer support in FB and
    FB_CORE symbols")), the latter is no longer auto-enabled since
    commit a5ae331edb02b664 ("drm: Drop select FRAMEBUFFER_CONSOLE for
    DRM_FBDEV_EMULATION")).

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
To be queued in the m68k for-v6.7 branch.
---
 arch/m68k/configs/amiga_defconfig    | 1 +
 arch/m68k/configs/apollo_defconfig   | 2 ++
 arch/m68k/configs/atari_defconfig    | 1 +
 arch/m68k/configs/bvme6000_defconfig | 2 ++
 arch/m68k/configs/hp300_defconfig    | 2 ++
 arch/m68k/configs/mac_defconfig      | 1 +
 arch/m68k/configs/multi_defconfig    | 1 +
 arch/m68k/configs/mvme147_defconfig  | 2 ++
 arch/m68k/configs/mvme16x_defconfig  | 2 ++
 arch/m68k/configs/q40_defconfig      | 1 +
 arch/m68k/configs/sun3_defconfig     | 2 ++
 arch/m68k/configs/sun3x_defconfig    | 2 ++
 arch/m68k/configs/virt_defconfig     | 2 +-
 13 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
index 6deb8faa564bc667..7e6b74b6eecd3925 100644
--- a/arch/m68k/configs/amiga_defconfig
+++ b/arch/m68k/configs/amiga_defconfig
@@ -299,6 +299,7 @@ CONFIG_NET_IFE=m
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_TEST_ASYNC_DRIVER_PROBE=m
+CONFIG_DM_KUNIT_TEST=m
 CONFIG_CONNECTOR=m
 CONFIG_PARPORT=m
 CONFIG_PARPORT_AMIGA=m
diff --git a/arch/m68k/configs/apollo_defconfig b/arch/m68k/configs/apollo_defconfig
index 802c161827f4ceba..0b403e2efcd5e3e1 100644
--- a/arch/m68k/configs/apollo_defconfig
+++ b/arch/m68k/configs/apollo_defconfig
@@ -295,6 +295,7 @@ CONFIG_NET_IFE=m
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_TEST_ASYNC_DRIVER_PROBE=m
+CONFIG_DM_KUNIT_TEST=m
 CONFIG_CONNECTOR=m
 CONFIG_ZRAM=m
 CONFIG_BLK_DEV_LOOP=y
@@ -568,6 +569,7 @@ CONFIG_CRYPTO_USER_API_AEAD=m
 CONFIG_PRIME_NUMBERS=m
 CONFIG_CRC32_SELFTEST=m
 CONFIG_XZ_DEC_TEST=m
+CONFIG_GLOB_SELFTEST=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_TEST_LOCKUP=m
diff --git a/arch/m68k/configs/atari_defconfig b/arch/m68k/configs/atari_defconfig
index 4212c365e93d1899..e3febc65f998dcfa 100644
--- a/arch/m68k/configs/atari_defconfig
+++ b/arch/m68k/configs/atari_defconfig
@@ -302,6 +302,7 @@ CONFIG_NET_IFE=m
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_TEST_ASYNC_DRIVER_PROBE=m
+CONFIG_DM_KUNIT_TEST=m
 CONFIG_CONNECTOR=m
 CONFIG_PARPORT=m
 CONFIG_PARPORT_ATARI=m
diff --git a/arch/m68k/configs/bvme6000_defconfig b/arch/m68k/configs/bvme6000_defconfig
index b13552caa6b39864..3c160636a2e91342 100644
--- a/arch/m68k/configs/bvme6000_defconfig
+++ b/arch/m68k/configs/bvme6000_defconfig
@@ -292,6 +292,7 @@ CONFIG_NET_IFE=m
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_TEST_ASYNC_DRIVER_PROBE=m
+CONFIG_DM_KUNIT_TEST=m
 CONFIG_CONNECTOR=m
 CONFIG_ZRAM=m
 CONFIG_BLK_DEV_LOOP=y
@@ -560,6 +561,7 @@ CONFIG_CRYPTO_USER_API_AEAD=m
 CONFIG_PRIME_NUMBERS=m
 CONFIG_CRC32_SELFTEST=m
 CONFIG_XZ_DEC_TEST=m
+CONFIG_GLOB_SELFTEST=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_TEST_LOCKUP=m
diff --git a/arch/m68k/configs/hp300_defconfig b/arch/m68k/configs/hp300_defconfig
index f88356c45440c825..23cf07c49d1411d4 100644
--- a/arch/m68k/configs/hp300_defconfig
+++ b/arch/m68k/configs/hp300_defconfig
@@ -294,6 +294,7 @@ CONFIG_NET_IFE=m
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_TEST_ASYNC_DRIVER_PROBE=m
+CONFIG_DM_KUNIT_TEST=m
 CONFIG_CONNECTOR=m
 CONFIG_ZRAM=m
 CONFIG_BLK_DEV_LOOP=y
@@ -570,6 +571,7 @@ CONFIG_CRYPTO_USER_API_AEAD=m
 CONFIG_PRIME_NUMBERS=m
 CONFIG_CRC32_SELFTEST=m
 CONFIG_XZ_DEC_TEST=m
+CONFIG_GLOB_SELFTEST=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_TEST_LOCKUP=m
diff --git a/arch/m68k/configs/mac_defconfig b/arch/m68k/configs/mac_defconfig
index 7c2ebb616fbad24e..619a0d93ce5bb2be 100644
--- a/arch/m68k/configs/mac_defconfig
+++ b/arch/m68k/configs/mac_defconfig
@@ -296,6 +296,7 @@ CONFIG_NET_IFE=m
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_TEST_ASYNC_DRIVER_PROBE=m
+CONFIG_DM_KUNIT_TEST=m
 CONFIG_CONNECTOR=m
 CONFIG_BLK_DEV_SWIM=m
 CONFIG_ZRAM=m
diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
index d3b272910b38e712..d9430bc2b2dea5b9 100644
--- a/arch/m68k/configs/multi_defconfig
+++ b/arch/m68k/configs/multi_defconfig
@@ -316,6 +316,7 @@ CONFIG_NET_IFE=m
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_TEST_ASYNC_DRIVER_PROBE=m
+CONFIG_DM_KUNIT_TEST=m
 CONFIG_CONNECTOR=m
 CONFIG_PARPORT=m
 CONFIG_PARPORT_PC=m
diff --git a/arch/m68k/configs/mvme147_defconfig b/arch/m68k/configs/mvme147_defconfig
index 4529bc4b843ca0dd..eb6132f29bf50f56 100644
--- a/arch/m68k/configs/mvme147_defconfig
+++ b/arch/m68k/configs/mvme147_defconfig
@@ -291,6 +291,7 @@ CONFIG_NET_IFE=m
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_TEST_ASYNC_DRIVER_PROBE=m
+CONFIG_DM_KUNIT_TEST=m
 CONFIG_CONNECTOR=m
 CONFIG_ZRAM=m
 CONFIG_BLK_DEV_LOOP=y
@@ -559,6 +560,7 @@ CONFIG_CRYPTO_USER_API_AEAD=m
 CONFIG_PRIME_NUMBERS=m
 CONFIG_CRC32_SELFTEST=m
 CONFIG_XZ_DEC_TEST=m
+CONFIG_GLOB_SELFTEST=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_TEST_LOCKUP=m
diff --git a/arch/m68k/configs/mvme16x_defconfig b/arch/m68k/configs/mvme16x_defconfig
index 30824032e4d58abe..d0bad674cbb7aec9 100644
--- a/arch/m68k/configs/mvme16x_defconfig
+++ b/arch/m68k/configs/mvme16x_defconfig
@@ -292,6 +292,7 @@ CONFIG_NET_IFE=m
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_TEST_ASYNC_DRIVER_PROBE=m
+CONFIG_DM_KUNIT_TEST=m
 CONFIG_CONNECTOR=m
 CONFIG_ZRAM=m
 CONFIG_BLK_DEV_LOOP=y
@@ -560,6 +561,7 @@ CONFIG_CRYPTO_USER_API_AEAD=m
 CONFIG_PRIME_NUMBERS=m
 CONFIG_CRC32_SELFTEST=m
 CONFIG_XZ_DEC_TEST=m
+CONFIG_GLOB_SELFTEST=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_TEST_LOCKUP=m
diff --git a/arch/m68k/configs/q40_defconfig b/arch/m68k/configs/q40_defconfig
index 3911211410eda118..dad6bcfcaeed350e 100644
--- a/arch/m68k/configs/q40_defconfig
+++ b/arch/m68k/configs/q40_defconfig
@@ -293,6 +293,7 @@ CONFIG_NET_IFE=m
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_TEST_ASYNC_DRIVER_PROBE=m
+CONFIG_DM_KUNIT_TEST=m
 CONFIG_CONNECTOR=m
 CONFIG_PARPORT=m
 CONFIG_PARPORT_PC=m
diff --git a/arch/m68k/configs/sun3_defconfig b/arch/m68k/configs/sun3_defconfig
index 991730c50957eb2f..eb1b489b3139cc07 100644
--- a/arch/m68k/configs/sun3_defconfig
+++ b/arch/m68k/configs/sun3_defconfig
@@ -288,6 +288,7 @@ CONFIG_NET_IFE=m
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_TEST_ASYNC_DRIVER_PROBE=m
+CONFIG_DM_KUNIT_TEST=m
 CONFIG_CONNECTOR=m
 CONFIG_ZRAM=m
 CONFIG_BLK_DEV_LOOP=y
@@ -558,6 +559,7 @@ CONFIG_CRYPTO_USER_API_AEAD=m
 CONFIG_PRIME_NUMBERS=m
 CONFIG_CRC32_SELFTEST=m
 CONFIG_XZ_DEC_TEST=m
+CONFIG_GLOB_SELFTEST=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_TEST_LOCKUP=m
diff --git a/arch/m68k/configs/sun3x_defconfig b/arch/m68k/configs/sun3x_defconfig
index e80d7509ab1d28b6..9395898265465d9e 100644
--- a/arch/m68k/configs/sun3x_defconfig
+++ b/arch/m68k/configs/sun3x_defconfig
@@ -289,6 +289,7 @@ CONFIG_NET_IFE=m
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_TEST_ASYNC_DRIVER_PROBE=m
+CONFIG_DM_KUNIT_TEST=m
 CONFIG_CONNECTOR=m
 CONFIG_ZRAM=m
 CONFIG_BLK_DEV_LOOP=y
@@ -558,6 +559,7 @@ CONFIG_CRYPTO_USER_API_AEAD=m
 CONFIG_PRIME_NUMBERS=m
 CONFIG_CRC32_SELFTEST=m
 CONFIG_XZ_DEC_TEST=m
+CONFIG_GLOB_SELFTEST=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_TEST_LOCKUP=m
diff --git a/arch/m68k/configs/virt_defconfig b/arch/m68k/configs/virt_defconfig
index 49e649cc29f7b1e8..3afc6762b0946aa6 100644
--- a/arch/m68k/configs/virt_defconfig
+++ b/arch/m68k/configs/virt_defconfig
@@ -48,7 +48,7 @@ CONFIG_VIRTIO_CONSOLE=y
 CONFIG_HW_RANDOM_VIRTIO=y
 CONFIG_DRM=y
 CONFIG_DRM_VIRTIO_GPU=y
-CONFIG_FB=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_SOUND=y
 CONFIG_SND=y
 CONFIG_SND_VIRTIO=y
-- 
2.34.1

