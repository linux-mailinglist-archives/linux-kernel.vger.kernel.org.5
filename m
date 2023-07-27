Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79AB7765CC2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 22:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbjG0UCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 16:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjG0UB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 16:01:56 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1265130DC;
        Thu, 27 Jul 2023 13:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690488096; x=1691092896; i=svenjoac@gmx.de;
 bh=bsLwwhFoP0n5ZIkQPMJFliLf9pV9i7/hQosqjnnBdPk=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=N+q39g1FQXajj9SQ6XNK8hyQa8BLKAz7I31X0QPpW1MCMijpyGBnY5jP2K3Wrz5BphtuMNS
 k94MwkPUpf2+cMtmljfakzBNhAk79TeFOsNQ7+9QXPSDGb0h1KMre9NP7C6wooYO+2E0MonxA
 RNOVatieUnrsoGFFmVdVB7Eg5iTNE5G5bIZ0LLNM6ca0ztl//KQLY/gRvReMGG2Hz1dkcA/6l
 H2FXw7k3t5I/upPvrj5BLzJx9HT1JtDex9m4d6nxWS/M/ipw+5MRHfyFQ9/P2hBJSLd0qLcIe
 RAbPxDq9hExUzAJaJXWtLIBx+2bkWDbWpKR5GC9T02LtMCYJzoWw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([79.203.84.168]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MUXpK-1qGHUO1OOu-00QR1M; Thu, 27 Jul 2023 22:01:36 +0200
Received: by localhost.localdomain (Postfix, from userid 1000)
        id 7601D8008A; Thu, 27 Jul 2023 22:01:35 +0200 (CEST)
From:   Sven Joachim <svenjoac@gmx.de>
To:     Ian Kent <raven@themaw.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     autofs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sven Joachim <svenjoac@gmx.de>
Subject: [PATCH] arch/*/configs/*defconfig: Replace AUTOFS4_FS by AUTOFS_FS
Date:   Thu, 27 Jul 2023 22:00:41 +0200
Message-Id: <20230727200041.21404-1-svenjoac@gmx.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/SWfuzHdwK9l7+uELHnMQafAADQebrCzayxvxspQX1YnEc01M9M
 D6pce6RwS9/TfJFhhb+/qsVVr5DBVLWLPDWexUsrUVa+jSPukgvjGMiwGfttH6kO1sK7SUj
 4u3qe4oitZC3mRGwl8IPLiuwh8fUlQLrTpMqZqpTbB5oHmkBMUh6GE4IeY1cvZIZAPs8+Dh
 W3+SlarhTCgN4Y7tm/bBQ==
UI-OutboundReport: notjunk:1;M01:P0:W1MQIR7fO9U=;kdGoQno0VkJOfaWmEAjzwoE9SoT
 uL64oUeZArnIxYgMJ9DxKQIEAzqdweU2TqX1VUWy6hGcCoG8ftUsrbILr0PYdvnA4LYMUIj9E
 RIgEmONMTiTNjqrDWZw9mDMMD0zt2uwn6xBc6lBuEslPZ5ua7NDpS3w5SqsfwtVuPxnuwvJia
 iXRn+IgH06NmHVNUvPn3j2SdPu1n9aumkDuUzlj2MnPuJjg4xAPHrsErQh/+s7zqR+z6sQIUr
 /tdFRZTmWA46wAru+sYfkuSmh7gIQvKrB/QJKZixKVzDyVa9lyLH6/c9FiKehuBxuc2rKFrxS
 8nauveIrWgSi8A6UryiLe71rOJzTNxDTZ9nhIu7n32vUX8KtRmnJrKLZrSIw2mB2z1x6bGJfP
 jvIrbWj9UC4WKGAf8lD1fEICY0YTxOrhImxZ6tT3IBhKRe+GXgzrtz+2/Yx4cJZlp8pfydoGX
 eBQAo98jv2JFX14FjRSm4MncR7tGR4SBpgHN8l9BctmqsJ0rbz+LWbkSfbD4zCl1aNDjDE5KJ
 cMNR6U5N+yxFBJI6wfxTK+gPmJdVPiewBv3R2cVQetyC89HXjYdPty+DmKtkEbYG+phm9az1f
 00cc3nahKrd59TkHd6H3ebpl0eBzmELY6g9sPc0pJeTD75xnm43s+uVEzLNL3JZB8aHp662Zv
 1cr+pjpIHsy0uUVbAiMFQjqLwtjdwoCho+DmPo1g5FrhHNXATlRhz61p5hzag8EaZtF+nvHYh
 GOaw7OsaRypCEFfvTBarBqwfX4M05ic1Vub0T2Tp6/jAoiqTDk/XlNT7NovWu+Q2mLbTXJ0jB
 NMt3uUs/lFsoxI6yML+HaSIoFhmyc0JAtpKbRNFQvjuiCEo2g9cVwI1FpeAMlT6zZAyAaWLr3
 6liD/uRkKY9MUQdXk8Rg1a++tc7TeoFRn5vqsVK8zqMDYAu6lC1j9jV44peOyEmU59UIQdEhR
 kMtAn8KuzSJfxmp1rtHxk7cW3CE=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a2225d931f75 ("autofs: remove left-over autofs4 stubs")
promised the removal of the fs/autofs/Kconfig fragment for AUTOFS4_FS
within a couple of releases, but five years later this still has not
happened yet, and AUTOFS4_FS is still enabled in 63 defconfigs.  Get
rid of it mechanically:

find arch -name "*defconfig" -exec sed -i 's/AUTOFS4_FS/AUTOFS_FS/' '{}' \=
;

Signed-off-by: Sven Joachim <svenjoac@gmx.de>
=2D--
 arch/arm/configs/axm55xx_defconfig          | 2 +-
 arch/arm/configs/davinci_all_defconfig      | 2 +-
 arch/arm/configs/exynos_defconfig           | 2 +-
 arch/arm/configs/footbridge_defconfig       | 2 +-
 arch/arm/configs/imx_v6_v7_defconfig        | 2 +-
 arch/arm/configs/keystone_defconfig         | 2 +-
 arch/arm/configs/lpc32xx_defconfig          | 2 +-
 arch/arm/configs/milbeaut_m10v_defconfig    | 2 +-
 arch/arm/configs/multi_v7_defconfig         | 2 +-
 arch/arm/configs/omap1_defconfig            | 2 +-
 arch/arm/configs/omap2plus_defconfig        | 2 +-
 arch/arm/configs/pxa_defconfig              | 2 +-
 arch/arm/configs/rpc_defconfig              | 2 +-
 arch/arm/configs/s5pv210_defconfig          | 2 +-
 arch/arm/configs/socfpga_defconfig          | 2 +-
 arch/arm/configs/spear13xx_defconfig        | 2 +-
 arch/arm/configs/spear3xx_defconfig         | 2 +-
 arch/arm/configs/spear6xx_defconfig         | 2 +-
 arch/arm64/configs/defconfig                | 2 +-
 arch/ia64/configs/bigsur_defconfig          | 2 +-
 arch/ia64/configs/generic_defconfig         | 2 +-
 arch/ia64/configs/gensparse_defconfig       | 2 +-
 arch/ia64/configs/tiger_defconfig           | 2 +-
 arch/loongarch/configs/loongson3_defconfig  | 2 +-
 arch/mips/configs/bigsur_defconfig          | 2 +-
 arch/mips/configs/fuloong2e_defconfig       | 2 +-
 arch/mips/configs/ip22_defconfig            | 2 +-
 arch/mips/configs/ip32_defconfig            | 2 +-
 arch/mips/configs/jazz_defconfig            | 2 +-
 arch/mips/configs/lemote2f_defconfig        | 2 +-
 arch/mips/configs/loongson2k_defconfig      | 2 +-
 arch/mips/configs/loongson3_defconfig       | 2 +-
 arch/mips/configs/mtx1_defconfig            | 2 +-
 arch/mips/configs/pic32mzda_defconfig       | 2 +-
 arch/mips/configs/rm200_defconfig           | 2 +-
 arch/parisc/configs/generic-32bit_defconfig | 2 +-
 arch/parisc/configs/generic-64bit_defconfig | 2 +-
 arch/powerpc/configs/44x/sam440ep_defconfig | 2 +-
 arch/powerpc/configs/85xx/stx_gp3_defconfig | 2 +-
 arch/powerpc/configs/cell_defconfig         | 2 +-
 arch/powerpc/configs/ep8248e_defconfig      | 2 +-
 arch/powerpc/configs/mgcoge_defconfig       | 2 +-
 arch/powerpc/configs/pasemi_defconfig       | 2 +-
 arch/powerpc/configs/pmac32_defconfig       | 2 +-
 arch/powerpc/configs/powernv_defconfig      | 2 +-
 arch/powerpc/configs/ppc64_defconfig        | 2 +-
 arch/powerpc/configs/ppc64e_defconfig       | 2 +-
 arch/powerpc/configs/ppc6xx_defconfig       | 2 +-
 arch/powerpc/configs/ps3_defconfig          | 2 +-
 arch/riscv/configs/defconfig                | 2 +-
 arch/riscv/configs/rv32_defconfig           | 2 +-
 arch/s390/configs/debug_defconfig           | 2 +-
 arch/s390/configs/defconfig                 | 2 +-
 arch/sh/configs/espt_defconfig              | 2 +-
 arch/sh/configs/sdk7780_defconfig           | 2 +-
 arch/sh/configs/sdk7786_defconfig           | 2 +-
 arch/sh/configs/sh03_defconfig              | 2 +-
 arch/sh/configs/sh7763rdp_defconfig         | 2 +-
 arch/sparc/configs/sparc32_defconfig        | 2 +-
 arch/um/configs/i386_defconfig              | 2 +-
 arch/um/configs/x86_64_defconfig            | 2 +-
 arch/x86/configs/i386_defconfig             | 2 +-
 arch/x86/configs/x86_64_defconfig           | 2 +-
 63 files changed, 63 insertions(+), 63 deletions(-)

diff --git a/arch/arm/configs/axm55xx_defconfig b/arch/arm/configs/axm55xx=
_defconfig
index bfbaa2df3be5..d1c550894a65 100644
=2D-- a/arch/arm/configs/axm55xx_defconfig
+++ b/arch/arm/configs/axm55xx_defconfig
@@ -197,7 +197,7 @@ CONFIG_EXT2_FS=3Dy
 CONFIG_EXT3_FS=3Dy
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_EXT4_FS=3Dy
-CONFIG_AUTOFS4_FS=3Dy
+CONFIG_AUTOFS_FS=3Dy
 CONFIG_FUSE_FS=3Dy
 CONFIG_CUSE=3Dy
 CONFIG_FSCACHE=3Dy
diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/dav=
inci_all_defconfig
index 821d966c95a5..05ea71778ef8 100644
=2D-- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -232,7 +232,7 @@ CONFIG_EXT2_FS=3Dy
 CONFIG_EXT3_FS=3Dy
 CONFIG_EXT4_FS_POSIX_ACL=3Dy
 CONFIG_XFS_FS=3Dm
-CONFIG_AUTOFS4_FS=3Dm
+CONFIG_AUTOFS_FS=3Dm
 CONFIG_MSDOS_FS=3Dy
 CONFIG_VFAT_FS=3Dy
 CONFIG_TMPFS=3Dy
diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_d=
efconfig
index b0f0baa3a6c4..53b1d41b4a8b 100644
=2D-- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -327,7 +327,7 @@ CONFIG_PWM_SAMSUNG=3Dy
 CONFIG_PHY_EXYNOS5250_SATA=3Dy
 CONFIG_EXT2_FS=3Dy
 CONFIG_EXT4_FS=3Dy
-CONFIG_AUTOFS4_FS=3Dy
+CONFIG_AUTOFS_FS=3Dy
 CONFIG_MSDOS_FS=3Dy
 CONFIG_VFAT_FS=3Dy
 CONFIG_TMPFS=3Dy
diff --git a/arch/arm/configs/footbridge_defconfig b/arch/arm/configs/foot=
bridge_defconfig
index 87c489337d0e..c9f4594b7ca9 100644
=2D-- a/arch/arm/configs/footbridge_defconfig
+++ b/arch/arm/configs/footbridge_defconfig
@@ -94,7 +94,7 @@ CONFIG_LEDS_CLASS=3Dy
 CONFIG_LEDS_TRIGGERS=3Dy
 CONFIG_LEDS_TRIGGER_TIMER=3Dy
 CONFIG_EXT2_FS=3Dy
-CONFIG_AUTOFS4_FS=3Dy
+CONFIG_AUTOFS_FS=3Dy
 CONFIG_ISO9660_FS=3Dm
 CONFIG_JOLIET=3Dy
 CONFIG_MSDOS_FS=3Dm
diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v=
6_v7_defconfig
index 05706696a5fb..0a90583f9f01 100644
=2D-- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -442,7 +442,7 @@ CONFIG_EXT3_FS_SECURITY=3Dy
 CONFIG_QUOTA=3Dy
 CONFIG_QUOTA_NETLINK_INTERFACE=3Dy
 # CONFIG_PRINT_QUOTA_WARNING is not set
-CONFIG_AUTOFS4_FS=3Dy
+CONFIG_AUTOFS_FS=3Dy
 CONFIG_FUSE_FS=3Dy
 CONFIG_ISO9660_FS=3Dm
 CONFIG_JOLIET=3Dy
diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keysto=
ne_defconfig
index d7a0bca641eb..1cb145633a91 100644
=2D-- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -207,7 +207,7 @@ CONFIG_RESET_TI_SYSCON=3Dm
 CONFIG_EXT4_FS=3Dy
 CONFIG_EXT4_FS_POSIX_ACL=3Dy
 CONFIG_FANOTIFY=3Dy
-CONFIG_AUTOFS4_FS=3Dy
+CONFIG_AUTOFS_FS=3Dy
 CONFIG_MSDOS_FS=3Dy
 CONFIG_VFAT_FS=3Dy
 CONFIG_NTFS_FS=3Dy
diff --git a/arch/arm/configs/lpc32xx_defconfig b/arch/arm/configs/lpc32xx=
_defconfig
index d7df0486850f..e2b0ff0b253f 100644
=2D-- a/arch/arm/configs/lpc32xx_defconfig
+++ b/arch/arm/configs/lpc32xx_defconfig
@@ -162,7 +162,7 @@ CONFIG_MAX517=3Dy
 CONFIG_PWM=3Dy
 CONFIG_PWM_LPC32XX=3Dy
 CONFIG_EXT2_FS=3Dy
-CONFIG_AUTOFS4_FS=3Dy
+CONFIG_AUTOFS_FS=3Dy
 CONFIG_MSDOS_FS=3Dy
 CONFIG_VFAT_FS=3Dy
 CONFIG_TMPFS=3Dy
diff --git a/arch/arm/configs/milbeaut_m10v_defconfig b/arch/arm/configs/m=
ilbeaut_m10v_defconfig
index 385ad0f391a8..7d4284502325 100644
=2D-- a/arch/arm/configs/milbeaut_m10v_defconfig
+++ b/arch/arm/configs/milbeaut_m10v_defconfig
@@ -81,7 +81,7 @@ CONFIG_SOC_BRCMSTB=3Dy
 CONFIG_MEMORY=3Dy
 # CONFIG_ARM_PMU is not set
 CONFIG_EXT4_FS=3Dy
-CONFIG_AUTOFS4_FS=3Dy
+CONFIG_AUTOFS_FS=3Dy
 CONFIG_MSDOS_FS=3Dy
 CONFIG_VFAT_FS=3Dy
 CONFIG_NTFS_FS=3Dy
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_=
v7_defconfig
index f0800f806b5f..c7b2550d706c 100644
=2D-- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -1226,7 +1226,7 @@ CONFIG_COUNTER=3Dm
 CONFIG_STM32_TIMER_CNT=3Dm
 CONFIG_STM32_LPTIMER_CNT=3Dm
 CONFIG_EXT4_FS=3Dy
-CONFIG_AUTOFS4_FS=3Dy
+CONFIG_AUTOFS_FS=3Dy
 CONFIG_MSDOS_FS=3Dy
 CONFIG_VFAT_FS=3Dy
 CONFIG_NTFS_FS=3Dy
diff --git a/arch/arm/configs/omap1_defconfig b/arch/arm/configs/omap1_def=
config
index 53dd0717cea5..7c2cc7a89511 100644
=2D-- a/arch/arm/configs/omap1_defconfig
+++ b/arch/arm/configs/omap1_defconfig
@@ -188,7 +188,7 @@ CONFIG_RTC_DRV_OMAP=3Dy
 CONFIG_EXT2_FS=3Dy
 CONFIG_EXT3_FS=3Dy
 # CONFIG_DNOTIFY is not set
-CONFIG_AUTOFS4_FS=3Dy
+CONFIG_AUTOFS_FS=3Dy
 CONFIG_ISO9660_FS=3Dy
 CONFIG_JOLIET=3Dy
 CONFIG_MSDOS_FS=3Dy
diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2=
plus_defconfig
index 9bd36dd39bd0..b685018dcf54 100644
=2D-- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -678,7 +678,7 @@ CONFIG_EXT4_FS_SECURITY=3Dy
 CONFIG_FANOTIFY=3Dy
 CONFIG_QUOTA=3Dy
 CONFIG_QFMT_V2=3Dy
-CONFIG_AUTOFS4_FS=3Dm
+CONFIG_AUTOFS_FS=3Dm
 CONFIG_MSDOS_FS=3Dy
 CONFIG_VFAT_FS=3Dy
 CONFIG_TMPFS=3Dy
diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconf=
ig
index b46e39369dbb..b0c3355e2599 100644
=2D-- a/arch/arm/configs/pxa_defconfig
+++ b/arch/arm/configs/pxa_defconfig
@@ -589,7 +589,7 @@ CONFIG_REISERFS_FS_XATTR=3Dy
 CONFIG_REISERFS_FS_POSIX_ACL=3Dy
 CONFIG_REISERFS_FS_SECURITY=3Dy
 CONFIG_XFS_FS=3Dm
-CONFIG_AUTOFS4_FS=3Dm
+CONFIG_AUTOFS_FS=3Dm
 CONFIG_FUSE_FS=3Dm
 CONFIG_CUSE=3Dm
 CONFIG_FSCACHE=3Dy
diff --git a/arch/arm/configs/rpc_defconfig b/arch/arm/configs/rpc_defconf=
ig
index 65a3fded55be..b1d12a2c2ef8 100644
=2D-- a/arch/arm/configs/rpc_defconfig
+++ b/arch/arm/configs/rpc_defconfig
@@ -79,7 +79,7 @@ CONFIG_RTC_CLASS=3Dy
 CONFIG_RTC_DRV_PCF8583=3Dy
 CONFIG_EXT2_FS=3Dy
 CONFIG_EXT3_FS=3Dy
-CONFIG_AUTOFS4_FS=3Dm
+CONFIG_AUTOFS_FS=3Dm
 CONFIG_ISO9660_FS=3Dy
 CONFIG_JOLIET=3Dy
 CONFIG_MSDOS_FS=3Dm
diff --git a/arch/arm/configs/s5pv210_defconfig b/arch/arm/configs/s5pv210=
_defconfig
index 4c1e480b5bbd..72df854878f8 100644
=2D-- a/arch/arm/configs/s5pv210_defconfig
+++ b/arch/arm/configs/s5pv210_defconfig
@@ -103,7 +103,7 @@ CONFIG_PHY_SAMSUNG_USB2=3Dm
 CONFIG_PHY_S5PV210_USB2=3Dy
 CONFIG_EXT2_FS=3Dy
 CONFIG_EXT4_FS=3Dy
-CONFIG_AUTOFS4_FS=3Dy
+CONFIG_AUTOFS_FS=3Dy
 CONFIG_MSDOS_FS=3Dy
 CONFIG_VFAT_FS=3Dy
 CONFIG_TMPFS=3Dy
diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga=
_defconfig
index 70739e09d0f4..d6dfae196f84 100644
=2D-- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -136,7 +136,7 @@ CONFIG_EXT2_FS=3Dy
 CONFIG_EXT2_FS_XATTR=3Dy
 CONFIG_EXT2_FS_POSIX_ACL=3Dy
 CONFIG_EXT3_FS=3Dy
-CONFIG_AUTOFS4_FS=3Dy
+CONFIG_AUTOFS_FS=3Dy
 CONFIG_VFAT_FS=3Dy
 CONFIG_NTFS_FS=3Dy
 CONFIG_NTFS_RW=3Dy
diff --git a/arch/arm/configs/spear13xx_defconfig b/arch/arm/configs/spear=
13xx_defconfig
index bfde0c86cdc5..c8128a6180e7 100644
=2D-- a/arch/arm/configs/spear13xx_defconfig
+++ b/arch/arm/configs/spear13xx_defconfig
@@ -85,7 +85,7 @@ CONFIG_EXT2_FS_XATTR=3Dy
 CONFIG_EXT2_FS_SECURITY=3Dy
 CONFIG_EXT3_FS=3Dy
 CONFIG_EXT3_FS_SECURITY=3Dy
-CONFIG_AUTOFS4_FS=3Dm
+CONFIG_AUTOFS_FS=3Dm
 CONFIG_FUSE_FS=3Dy
 CONFIG_MSDOS_FS=3Dm
 CONFIG_VFAT_FS=3Dm
diff --git a/arch/arm/configs/spear3xx_defconfig b/arch/arm/configs/spear3=
xx_defconfig
index a96ed5cf778e..97ea2e9a6f07 100644
=2D-- a/arch/arm/configs/spear3xx_defconfig
+++ b/arch/arm/configs/spear3xx_defconfig
@@ -68,7 +68,7 @@ CONFIG_EXT2_FS_XATTR=3Dy
 CONFIG_EXT2_FS_SECURITY=3Dy
 CONFIG_EXT3_FS=3Dy
 CONFIG_EXT3_FS_SECURITY=3Dy
-CONFIG_AUTOFS4_FS=3Dm
+CONFIG_AUTOFS_FS=3Dm
 CONFIG_MSDOS_FS=3Dm
 CONFIG_VFAT_FS=3Dm
 CONFIG_FAT_DEFAULT_IOCHARSET=3D"ascii"
diff --git a/arch/arm/configs/spear6xx_defconfig b/arch/arm/configs/spear6=
xx_defconfig
index 3e2c2abae5ba..a7a3413ac968 100644
=2D-- a/arch/arm/configs/spear6xx_defconfig
+++ b/arch/arm/configs/spear6xx_defconfig
@@ -54,7 +54,7 @@ CONFIG_EXT2_FS_XATTR=3Dy
 CONFIG_EXT2_FS_SECURITY=3Dy
 CONFIG_EXT3_FS=3Dy
 CONFIG_EXT3_FS_SECURITY=3Dy
-CONFIG_AUTOFS4_FS=3Dm
+CONFIG_AUTOFS_FS=3Dm
 CONFIG_MSDOS_FS=3Dm
 CONFIG_VFAT_FS=3Dm
 CONFIG_FAT_DEFAULT_IOCHARSET=3D"ascii"
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0777bcae9104..a25d783dfb95 100644
=2D-- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1469,7 +1469,7 @@ CONFIG_BTRFS_FS_POSIX_ACL=3Dy
 CONFIG_FANOTIFY=3Dy
 CONFIG_FANOTIFY_ACCESS_PERMISSIONS=3Dy
 CONFIG_QUOTA=3Dy
-CONFIG_AUTOFS4_FS=3Dy
+CONFIG_AUTOFS_FS=3Dy
 CONFIG_FUSE_FS=3Dm
 CONFIG_CUSE=3Dm
 CONFIG_OVERLAY_FS=3Dm
diff --git a/arch/ia64/configs/bigsur_defconfig b/arch/ia64/configs/bigsur=
_defconfig
index 3e1337aceb37..7cb96db9a25d 100644
=2D-- a/arch/ia64/configs/bigsur_defconfig
+++ b/arch/ia64/configs/bigsur_defconfig
@@ -77,7 +77,7 @@ CONFIG_EXT3_FS=3Dy
 CONFIG_XFS_FS=3Dy
 CONFIG_XFS_QUOTA=3Dy
 CONFIG_XFS_POSIX_ACL=3Dy
-CONFIG_AUTOFS4_FS=3Dm
+CONFIG_AUTOFS_FS=3Dm
 CONFIG_ISO9660_FS=3Dm
 CONFIG_JOLIET=3Dy
 CONFIG_UDF_FS=3Dm
diff --git a/arch/ia64/configs/generic_defconfig b/arch/ia64/configs/gener=
ic_defconfig
index f8033bacea89..4581240013dd 100644
=2D-- a/arch/ia64/configs/generic_defconfig
+++ b/arch/ia64/configs/generic_defconfig
@@ -146,7 +146,7 @@ CONFIG_REISERFS_FS_XATTR=3Dy
 CONFIG_REISERFS_FS_POSIX_ACL=3Dy
 CONFIG_REISERFS_FS_SECURITY=3Dy
 CONFIG_XFS_FS=3Dy
-CONFIG_AUTOFS4_FS=3Dm
+CONFIG_AUTOFS_FS=3Dm
 CONFIG_ISO9660_FS=3Dm
 CONFIG_JOLIET=3Dy
 CONFIG_UDF_FS=3Dm
diff --git a/arch/ia64/configs/gensparse_defconfig b/arch/ia64/configs/gen=
sparse_defconfig
index ffebe6c503f5..c9e806616544 100644
=2D-- a/arch/ia64/configs/gensparse_defconfig
+++ b/arch/ia64/configs/gensparse_defconfig
@@ -127,7 +127,7 @@ CONFIG_REISERFS_FS_XATTR=3Dy
 CONFIG_REISERFS_FS_POSIX_ACL=3Dy
 CONFIG_REISERFS_FS_SECURITY=3Dy
 CONFIG_XFS_FS=3Dy
-CONFIG_AUTOFS4_FS=3Dy
+CONFIG_AUTOFS_FS=3Dy
 CONFIG_ISO9660_FS=3Dm
 CONFIG_JOLIET=3Dy
 CONFIG_UDF_FS=3Dm
diff --git a/arch/ia64/configs/tiger_defconfig b/arch/ia64/configs/tiger_d=
efconfig
index 45f5d6e2da0a..d7d8fb5c7b71 100644
=2D-- a/arch/ia64/configs/tiger_defconfig
+++ b/arch/ia64/configs/tiger_defconfig
@@ -110,7 +110,7 @@ CONFIG_REISERFS_FS_XATTR=3Dy
 CONFIG_REISERFS_FS_POSIX_ACL=3Dy
 CONFIG_REISERFS_FS_SECURITY=3Dy
 CONFIG_XFS_FS=3Dy
-CONFIG_AUTOFS4_FS=3Dy
+CONFIG_AUTOFS_FS=3Dy
 CONFIG_ISO9660_FS=3Dm
 CONFIG_JOLIET=3Dy
 CONFIG_UDF_FS=3Dm
diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/c=
onfigs/loongson3_defconfig
index 6cd26dd3c134..d64849b4cba1 100644
=2D-- a/arch/loongarch/configs/loongson3_defconfig
+++ b/arch/loongarch/configs/loongson3_defconfig
@@ -769,7 +769,7 @@ CONFIG_QUOTA=3Dy
 # CONFIG_PRINT_QUOTA_WARNING is not set
 CONFIG_QFMT_V1=3Dm
 CONFIG_QFMT_V2=3Dm
-CONFIG_AUTOFS4_FS=3Dy
+CONFIG_AUTOFS_FS=3Dy
 CONFIG_FUSE_FS=3Dm
 CONFIG_OVERLAY_FS=3Dy
 CONFIG_OVERLAY_FS_INDEX=3Dy
diff --git a/arch/mips/configs/bigsur_defconfig b/arch/mips/configs/bigsur=
_defconfig
index b0cbfa781ffc..e463a9acae03 100644
=2D-- a/arch/mips/configs/bigsur_defconfig
+++ b/arch/mips/configs/bigsur_defconfig
@@ -153,7 +153,7 @@ CONFIG_QUOTA=3Dy
 CONFIG_QUOTA_NETLINK_INTERFACE=3Dy
 # CONFIG_PRINT_QUOTA_WARNING is not set
 CONFIG_QFMT_V2=3Dm
-CONFIG_AUTOFS4_FS=3Dm
+CONFIG_AUTOFS_FS=3Dm
 CONFIG_FUSE_FS=3Dm
 CONFIG_ISO9660_FS=3Dm
 CONFIG_JOLIET=3Dy
diff --git a/arch/mips/configs/fuloong2e_defconfig b/arch/mips/configs/ful=
oong2e_defconfig
index 5458573286a2..1843468f84a3 100644
=2D-- a/arch/mips/configs/fuloong2e_defconfig
+++ b/arch/mips/configs/fuloong2e_defconfig
@@ -178,7 +178,7 @@ CONFIG_EXT3_FS=3Dy
 CONFIG_EXT4_FS_POSIX_ACL=3Dy
 CONFIG_EXT4_FS_SECURITY=3Dy
 CONFIG_REISERFS_FS=3Dm
-CONFIG_AUTOFS4_FS=3Dy
+CONFIG_AUTOFS_FS=3Dy
 CONFIG_FUSE_FS=3Dy
 CONFIG_ISO9660_FS=3Dm
 CONFIG_JOLIET=3Dy
diff --git a/arch/mips/configs/ip22_defconfig b/arch/mips/configs/ip22_def=
config
index 897e55579af0..44821f497261 100644
=2D-- a/arch/mips/configs/ip22_defconfig
+++ b/arch/mips/configs/ip22_defconfig
@@ -245,7 +245,7 @@ CONFIG_QUOTA=3Dy
 CONFIG_QUOTA_NETLINK_INTERFACE=3Dy
 # CONFIG_PRINT_QUOTA_WARNING is not set
 CONFIG_QFMT_V2=3Dm
-CONFIG_AUTOFS4_FS=3Dm
+CONFIG_AUTOFS_FS=3Dm
 CONFIG_FUSE_FS=3Dm
 CONFIG_ISO9660_FS=3Dm
 CONFIG_JOLIET=3Dy
diff --git a/arch/mips/configs/ip32_defconfig b/arch/mips/configs/ip32_def=
config
index 418a4181e2fe..930c5f6ed182 100644
=2D-- a/arch/mips/configs/ip32_defconfig
+++ b/arch/mips/configs/ip32_defconfig
@@ -95,7 +95,7 @@ CONFIG_EXT3_FS_SECURITY=3Dy
 CONFIG_QUOTA=3Dy
 CONFIG_QFMT_V1=3Dm
 CONFIG_QFMT_V2=3Dm
-CONFIG_AUTOFS4_FS=3Dm
+CONFIG_AUTOFS_FS=3Dm
 CONFIG_FUSE_FS=3Dm
 CONFIG_ISO9660_FS=3Dm
 CONFIG_JOLIET=3Dy
diff --git a/arch/mips/configs/jazz_defconfig b/arch/mips/configs/jazz_def=
config
index 6b5d7e963ed9..fdf374574105 100644
=2D-- a/arch/mips/configs/jazz_defconfig
+++ b/arch/mips/configs/jazz_defconfig
@@ -76,7 +76,7 @@ CONFIG_REISERFS_FS_POSIX_ACL=3Dy
 CONFIG_REISERFS_FS_SECURITY=3Dy
 CONFIG_XFS_FS=3Dm
 CONFIG_XFS_QUOTA=3Dy
-CONFIG_AUTOFS4_FS=3Dm
+CONFIG_AUTOFS_FS=3Dm
 CONFIG_FUSE_FS=3Dm
 CONFIG_ISO9660_FS=3Dm
 CONFIG_JOLIET=3Dy
diff --git a/arch/mips/configs/lemote2f_defconfig b/arch/mips/configs/lemo=
te2f_defconfig
index 7e598d338979..83d9a8ff4270 100644
=2D-- a/arch/mips/configs/lemote2f_defconfig
+++ b/arch/mips/configs/lemote2f_defconfig
@@ -240,7 +240,7 @@ CONFIG_XFS_POSIX_ACL=3Dy
 CONFIG_BTRFS_FS=3Dm
 CONFIG_QUOTA=3Dy
 CONFIG_QFMT_V2=3Dm
-CONFIG_AUTOFS4_FS=3Dm
+CONFIG_AUTOFS_FS=3Dm
 CONFIG_FSCACHE=3Dm
 CONFIG_CACHEFILES=3Dm
 CONFIG_ISO9660_FS=3Dm
diff --git a/arch/mips/configs/loongson2k_defconfig b/arch/mips/configs/lo=
ongson2k_defconfig
index 0ab029ecad21..ec3ee8df737d 100644
=2D-- a/arch/mips/configs/loongson2k_defconfig
+++ b/arch/mips/configs/loongson2k_defconfig
@@ -296,7 +296,7 @@ CONFIG_XFS_QUOTA=3Dy
 CONFIG_XFS_POSIX_ACL=3Dy
 CONFIG_QUOTA=3Dy
 # CONFIG_PRINT_QUOTA_WARNING is not set
-CONFIG_AUTOFS4_FS=3Dy
+CONFIG_AUTOFS_FS=3Dy
 CONFIG_FUSE_FS=3Dm
 CONFIG_ISO9660_FS=3Dm
 CONFIG_JOLIET=3Dy
diff --git a/arch/mips/configs/loongson3_defconfig b/arch/mips/configs/loo=
ngson3_defconfig
index 3087e64e6ebe..129426351237 100644
=2D-- a/arch/mips/configs/loongson3_defconfig
+++ b/arch/mips/configs/loongson3_defconfig
@@ -352,7 +352,7 @@ CONFIG_QUOTA=3Dy
 # CONFIG_PRINT_QUOTA_WARNING is not set
 CONFIG_QFMT_V1=3Dm
 CONFIG_QFMT_V2=3Dm
-CONFIG_AUTOFS4_FS=3Dy
+CONFIG_AUTOFS_FS=3Dy
 CONFIG_FUSE_FS=3Dm
 CONFIG_VIRTIO_FS=3Dm
 CONFIG_FSCACHE=3Dm
diff --git a/arch/mips/configs/mtx1_defconfig b/arch/mips/configs/mtx1_def=
config
index b64172179160..935585d8bb26 100644
=2D-- a/arch/mips/configs/mtx1_defconfig
+++ b/arch/mips/configs/mtx1_defconfig
@@ -601,7 +601,7 @@ CONFIG_EXT3_FS=3Dm
 CONFIG_EXT3_FS_POSIX_ACL=3Dy
 CONFIG_EXT3_FS_SECURITY=3Dy
 CONFIG_QUOTA=3Dy
-CONFIG_AUTOFS4_FS=3Dy
+CONFIG_AUTOFS_FS=3Dy
 CONFIG_FUSE_FS=3Dm
 CONFIG_ISO9660_FS=3Dm
 CONFIG_JOLIET=3Dy
diff --git a/arch/mips/configs/pic32mzda_defconfig b/arch/mips/configs/pic=
32mzda_defconfig
index 8397f28355d5..0e494c24246f 100644
=2D-- a/arch/mips/configs/pic32mzda_defconfig
+++ b/arch/mips/configs/pic32mzda_defconfig
@@ -66,7 +66,7 @@ CONFIG_LEDS_TRIGGER_DEFAULT_ON=3Dy
 CONFIG_EXT4_FS=3Dy
 CONFIG_EXT4_FS_POSIX_ACL=3Dy
 CONFIG_EXT4_FS_SECURITY=3Dy
-CONFIG_AUTOFS4_FS=3Dm
+CONFIG_AUTOFS_FS=3Dm
 CONFIG_FUSE_FS=3Dm
 CONFIG_FSCACHE=3Dm
 CONFIG_ISO9660_FS=3Dm
diff --git a/arch/mips/configs/rm200_defconfig b/arch/mips/configs/rm200_d=
efconfig
index 7475c2cbea89..e0e312dd968a 100644
=2D-- a/arch/mips/configs/rm200_defconfig
+++ b/arch/mips/configs/rm200_defconfig
@@ -317,7 +317,7 @@ CONFIG_REISERFS_FS_POSIX_ACL=3Dy
 CONFIG_REISERFS_FS_SECURITY=3Dy
 CONFIG_XFS_FS=3Dm
 CONFIG_XFS_QUOTA=3Dy
-CONFIG_AUTOFS4_FS=3Dm
+CONFIG_AUTOFS_FS=3Dm
 CONFIG_FUSE_FS=3Dm
 CONFIG_ISO9660_FS=3Dm
 CONFIG_JOLIET=3Dy
diff --git a/arch/parisc/configs/generic-32bit_defconfig b/arch/parisc/con=
figs/generic-32bit_defconfig
index 9651f4390029..ee4febb30386 100644
=2D-- a/arch/parisc/configs/generic-32bit_defconfig
+++ b/arch/parisc/configs/generic-32bit_defconfig
@@ -237,7 +237,7 @@ CONFIG_EXT3_FS_SECURITY=3Dy
 CONFIG_QUOTA=3Dy
 CONFIG_QUOTA_NETLINK_INTERFACE=3Dy
 CONFIG_QFMT_V2=3Dy
-CONFIG_AUTOFS4_FS=3Dy
+CONFIG_AUTOFS_FS=3Dy
 CONFIG_ISO9660_FS=3Dy
 CONFIG_JOLIET=3Dy
 CONFIG_VFAT_FS=3Dy
diff --git a/arch/parisc/configs/generic-64bit_defconfig b/arch/parisc/con=
figs/generic-64bit_defconfig
index 6758c030b09d..f6ded7147b4d 100644
=2D-- a/arch/parisc/configs/generic-64bit_defconfig
+++ b/arch/parisc/configs/generic-64bit_defconfig
@@ -259,7 +259,7 @@ CONFIG_BTRFS_FS=3Dm
 CONFIG_QUOTA=3Dy
 CONFIG_QUOTA_NETLINK_INTERFACE=3Dy
 CONFIG_QFMT_V2=3Dy
-CONFIG_AUTOFS4_FS=3Dy
+CONFIG_AUTOFS_FS=3Dy
 CONFIG_FUSE_FS=3Dy
 CONFIG_CUSE=3Dy
 CONFIG_ISO9660_FS=3Dy
diff --git a/arch/powerpc/configs/44x/sam440ep_defconfig b/arch/powerpc/co=
nfigs/44x/sam440ep_defconfig
index ef09786d49b9..51499ee6366b 100644
=2D-- a/arch/powerpc/configs/44x/sam440ep_defconfig
+++ b/arch/powerpc/configs/44x/sam440ep_defconfig
@@ -79,7 +79,7 @@ CONFIG_EXT2_FS_POSIX_ACL=3Dy
 CONFIG_EXT4_FS=3Dy
 CONFIG_EXT4_FS_POSIX_ACL=3Dy
 CONFIG_REISERFS_FS=3Dy
-CONFIG_AUTOFS4_FS=3Dy
+CONFIG_AUTOFS_FS=3Dy
 CONFIG_ISO9660_FS=3Dy
 CONFIG_JOLIET=3Dy
 CONFIG_ZISOFS=3Dy
diff --git a/arch/powerpc/configs/85xx/stx_gp3_defconfig b/arch/powerpc/co=
nfigs/85xx/stx_gp3_defconfig
index ecbcc853307d..e7080497048d 100644
=2D-- a/arch/powerpc/configs/85xx/stx_gp3_defconfig
+++ b/arch/powerpc/configs/85xx/stx_gp3_defconfig
@@ -50,7 +50,7 @@ CONFIG_DRM=3Dm
 CONFIG_SOUND=3Dm
 CONFIG_EXT2_FS=3Dy
 CONFIG_EXT4_FS=3Dy
-CONFIG_AUTOFS4_FS=3Dy
+CONFIG_AUTOFS_FS=3Dy
 CONFIG_ISO9660_FS=3Dm
 CONFIG_UDF_FS=3Dm
 CONFIG_MSDOS_FS=3Dm
diff --git a/arch/powerpc/configs/cell_defconfig b/arch/powerpc/configs/ce=
ll_defconfig
index 06391cc2af3a..53f43a34e1a9 100644
=2D-- a/arch/powerpc/configs/cell_defconfig
+++ b/arch/powerpc/configs/cell_defconfig
@@ -172,7 +172,7 @@ CONFIG_EDAC_CELL=3Dy
 CONFIG_UIO=3Dm
 CONFIG_EXT2_FS=3Dy
 CONFIG_EXT4_FS=3Dy
-CONFIG_AUTOFS4_FS=3Dm
+CONFIG_AUTOFS_FS=3Dm
 CONFIG_ISO9660_FS=3Dm
 CONFIG_JOLIET=3Dy
 CONFIG_UDF_FS=3Dm
diff --git a/arch/powerpc/configs/ep8248e_defconfig b/arch/powerpc/configs=
/ep8248e_defconfig
index b9dfa3a0713b..0d8d3f41f194 100644
=2D-- a/arch/powerpc/configs/ep8248e_defconfig
+++ b/arch/powerpc/configs/ep8248e_defconfig
@@ -47,7 +47,7 @@ CONFIG_SERIAL_CPM_CONSOLE=3Dy
 # CONFIG_USB_SUPPORT is not set
 CONFIG_EXT2_FS=3Dy
 CONFIG_EXT4_FS=3Dy
-CONFIG_AUTOFS4_FS=3Dy
+CONFIG_AUTOFS_FS=3Dy
 CONFIG_PROC_KCORE=3Dy
 CONFIG_TMPFS=3Dy
 CONFIG_CRAMFS=3Dy
diff --git a/arch/powerpc/configs/mgcoge_defconfig b/arch/powerpc/configs/=
mgcoge_defconfig
index ce220ceeb91c..2101bfe6db94 100644
=2D-- a/arch/powerpc/configs/mgcoge_defconfig
+++ b/arch/powerpc/configs/mgcoge_defconfig
@@ -60,7 +60,7 @@ CONFIG_USB_FSL_USB2=3Dy
 CONFIG_USB_G_SERIAL=3Dy
 CONFIG_UIO=3Dy
 CONFIG_EXT2_FS=3Dy
-CONFIG_AUTOFS4_FS=3Dy
+CONFIG_AUTOFS_FS=3Dy
 CONFIG_PROC_KCORE=3Dy
 CONFIG_TMPFS=3Dy
 CONFIG_JFFS2_FS=3Dy
diff --git a/arch/powerpc/configs/pasemi_defconfig b/arch/powerpc/configs/=
pasemi_defconfig
index 96aa5355911f..61993944db40 100644
=2D-- a/arch/powerpc/configs/pasemi_defconfig
+++ b/arch/powerpc/configs/pasemi_defconfig
@@ -143,7 +143,7 @@ CONFIG_EXT2_FS=3Dy
 CONFIG_EXT2_FS_XATTR=3Dy
 CONFIG_EXT2_FS_POSIX_ACL=3Dy
 CONFIG_EXT4_FS=3Dy
-CONFIG_AUTOFS4_FS=3Dy
+CONFIG_AUTOFS_FS=3Dy
 CONFIG_ISO9660_FS=3Dy
 CONFIG_UDF_FS=3Dy
 CONFIG_MSDOS_FS=3Dy
diff --git a/arch/powerpc/configs/pmac32_defconfig b/arch/powerpc/configs/=
pmac32_defconfig
index 019163c2571e..05ed58576464 100644
=2D-- a/arch/powerpc/configs/pmac32_defconfig
+++ b/arch/powerpc/configs/pmac32_defconfig
@@ -254,7 +254,7 @@ CONFIG_LEDS_TRIGGER_DEFAULT_ON=3Dy
 CONFIG_EXT2_FS=3Dy
 CONFIG_EXT4_FS=3Dy
 CONFIG_EXT4_FS_POSIX_ACL=3Dy
-CONFIG_AUTOFS4_FS=3Dm
+CONFIG_AUTOFS_FS=3Dm
 CONFIG_FUSE_FS=3Dm
 CONFIG_ISO9660_FS=3Dy
 CONFIG_JOLIET=3Dy
diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs=
/powernv_defconfig
index e02ab94a09bf..ee84ade7a033 100644
=2D-- a/arch/powerpc/configs/powernv_defconfig
+++ b/arch/powerpc/configs/powernv_defconfig
@@ -270,7 +270,7 @@ CONFIG_BTRFS_FS=3Dm
 CONFIG_BTRFS_FS_POSIX_ACL=3Dy
 CONFIG_NILFS2_FS=3Dm
 CONFIG_FANOTIFY=3Dy
-CONFIG_AUTOFS4_FS=3Dm
+CONFIG_AUTOFS_FS=3Dm
 CONFIG_FUSE_FS=3Dm
 CONFIG_OVERLAY_FS=3Dm
 CONFIG_ISO9660_FS=3Dy
diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/p=
pc64_defconfig
index 268fa361a06d..c0f4bbc2c975 100644
=2D-- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -327,7 +327,7 @@ CONFIG_BTRFS_FS=3Dm
 CONFIG_BTRFS_FS_POSIX_ACL=3Dy
 CONFIG_NILFS2_FS=3Dm
 CONFIG_FS_DAX=3Dy
-CONFIG_AUTOFS4_FS=3Dm
+CONFIG_AUTOFS_FS=3Dm
 CONFIG_FUSE_FS=3Dm
 CONFIG_OVERLAY_FS=3Dm
 CONFIG_ISO9660_FS=3Dy
diff --git a/arch/powerpc/configs/ppc64e_defconfig b/arch/powerpc/configs/=
ppc64e_defconfig
index 776c32964e12..624c371ffcc3 100644
=2D-- a/arch/powerpc/configs/ppc64e_defconfig
+++ b/arch/powerpc/configs/ppc64e_defconfig
@@ -185,7 +185,7 @@ CONFIG_JFS_SECURITY=3Dy
 CONFIG_XFS_FS=3Dm
 CONFIG_XFS_POSIX_ACL=3Dy
 CONFIG_FS_DAX=3Dy
-CONFIG_AUTOFS4_FS=3Dm
+CONFIG_AUTOFS_FS=3Dm
 CONFIG_ISO9660_FS=3Dy
 CONFIG_UDF_FS=3Dm
 CONFIG_MSDOS_FS=3Dy
diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/=
ppc6xx_defconfig
index f21170b8fa11..1034aeabdd6c 100644
=2D-- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -969,7 +969,7 @@ CONFIG_XFS_POSIX_ACL=3Dy
 CONFIG_GFS2_FS=3Dm
 CONFIG_FS_DAX=3Dy
 CONFIG_QUOTA_NETLINK_INTERFACE=3Dy
-CONFIG_AUTOFS4_FS=3Dm
+CONFIG_AUTOFS_FS=3Dm
 CONFIG_FUSE_FS=3Dm
 CONFIG_ISO9660_FS=3Dy
 CONFIG_JOLIET=3Dy
diff --git a/arch/powerpc/configs/ps3_defconfig b/arch/powerpc/configs/ps3=
_defconfig
index ea3ee0719bb2..1ea732c19235 100644
=2D-- a/arch/powerpc/configs/ps3_defconfig
+++ b/arch/powerpc/configs/ps3_defconfig
@@ -129,7 +129,7 @@ CONFIG_EXT2_FS=3Dm
 CONFIG_EXT4_FS=3Dy
 CONFIG_QUOTA=3Dy
 CONFIG_QFMT_V2=3Dy
-CONFIG_AUTOFS4_FS=3Dm
+CONFIG_AUTOFS_FS=3Dm
 CONFIG_ISO9660_FS=3Dm
 CONFIG_JOLIET=3Dy
 CONFIG_UDF_FS=3Dm
diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 0a0107460a5c..ab86ec3b9eab 100644
=2D-- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -192,7 +192,7 @@ CONFIG_EXT4_FS_POSIX_ACL=3Dy
 CONFIG_EXT4_FS_SECURITY=3Dy
 CONFIG_BTRFS_FS=3Dm
 CONFIG_BTRFS_FS_POSIX_ACL=3Dy
-CONFIG_AUTOFS4_FS=3Dy
+CONFIG_AUTOFS_FS=3Dy
 CONFIG_OVERLAY_FS=3Dm
 CONFIG_ISO9660_FS=3Dy
 CONFIG_JOLIET=3Dy
diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_d=
efconfig
index 38760e4296cf..89b601e253a6 100644
=2D-- a/arch/riscv/configs/rv32_defconfig
+++ b/arch/riscv/configs/rv32_defconfig
@@ -98,7 +98,7 @@ CONFIG_RPMSG_CTRL=3Dy
 CONFIG_RPMSG_VIRTIO=3Dy
 CONFIG_EXT4_FS=3Dy
 CONFIG_EXT4_FS_POSIX_ACL=3Dy
-CONFIG_AUTOFS4_FS=3Dy
+CONFIG_AUTOFS_FS=3Dy
 CONFIG_MSDOS_FS=3Dy
 CONFIG_VFAT_FS=3Dy
 CONFIG_TMPFS=3Dy
diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_d=
efconfig
index aa95cf6dfabb..d03d4cb9332c 100644
=2D-- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -624,7 +624,7 @@ CONFIG_QUOTA_NETLINK_INTERFACE=3Dy
 CONFIG_QUOTA_DEBUG=3Dy
 CONFIG_QFMT_V1=3Dm
 CONFIG_QFMT_V2=3Dm
-CONFIG_AUTOFS4_FS=3Dm
+CONFIG_AUTOFS_FS=3Dm
 CONFIG_FUSE_FS=3Dy
 CONFIG_CUSE=3Dm
 CONFIG_VIRTIO_FS=3Dm
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index f041945f9148..1855759cdc6a 100644
=2D-- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -609,7 +609,7 @@ CONFIG_FANOTIFY_ACCESS_PERMISSIONS=3Dy
 CONFIG_QUOTA_NETLINK_INTERFACE=3Dy
 CONFIG_QFMT_V1=3Dm
 CONFIG_QFMT_V2=3Dm
-CONFIG_AUTOFS4_FS=3Dm
+CONFIG_AUTOFS_FS=3Dm
 CONFIG_FUSE_FS=3Dy
 CONFIG_CUSE=3Dm
 CONFIG_VIRTIO_FS=3Dm
diff --git a/arch/sh/configs/espt_defconfig b/arch/sh/configs/espt_defconf=
ig
index 623012d9af9d..67716a44463e 100644
=2D-- a/arch/sh/configs/espt_defconfig
+++ b/arch/sh/configs/espt_defconfig
@@ -61,7 +61,7 @@ CONFIG_USB_STORAGE=3Dy
 CONFIG_EXT2_FS=3Dy
 CONFIG_EXT3_FS=3Dy
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-CONFIG_AUTOFS4_FS=3Dy
+CONFIG_AUTOFS_FS=3Dy
 CONFIG_PROC_KCORE=3Dy
 CONFIG_TMPFS=3Dy
 CONFIG_TMPFS_POSIX_ACL=3Dy
diff --git a/arch/sh/configs/sdk7780_defconfig b/arch/sh/configs/sdk7780_d=
efconfig
index 41cb588ca99c..cd24cf08210e 100644
=2D-- a/arch/sh/configs/sdk7780_defconfig
+++ b/arch/sh/configs/sdk7780_defconfig
@@ -105,7 +105,7 @@ CONFIG_EXT2_FS_POSIX_ACL=3Dy
 CONFIG_EXT3_FS=3Dy
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_EXT3_FS_POSIX_ACL=3Dy
-CONFIG_AUTOFS4_FS=3Dy
+CONFIG_AUTOFS_FS=3Dy
 CONFIG_ISO9660_FS=3Dy
 CONFIG_MSDOS_FS=3Dy
 CONFIG_VFAT_FS=3Dy
diff --git a/arch/sh/configs/sdk7786_defconfig b/arch/sh/configs/sdk7786_d=
efconfig
index a080c5d05a7b..cf59b98446e4 100644
=2D-- a/arch/sh/configs/sdk7786_defconfig
+++ b/arch/sh/configs/sdk7786_defconfig
@@ -168,7 +168,7 @@ CONFIG_EXT3_FS=3Dy
 CONFIG_EXT4_FS=3Dy
 CONFIG_XFS_FS=3Dy
 CONFIG_BTRFS_FS=3Dy
-CONFIG_AUTOFS4_FS=3Dm
+CONFIG_AUTOFS_FS=3Dm
 CONFIG_FUSE_FS=3Dy
 CONFIG_CUSE=3Dm
 CONFIG_FSCACHE=3Dm
diff --git a/arch/sh/configs/sh03_defconfig b/arch/sh/configs/sh03_defconf=
ig
index f661ef816f09..48f38ec236b6 100644
=2D-- a/arch/sh/configs/sh03_defconfig
+++ b/arch/sh/configs/sh03_defconfig
@@ -60,7 +60,7 @@ CONFIG_EXT2_FS_XATTR=3Dy
 CONFIG_EXT3_FS=3Dy
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_EXT3_FS_POSIX_ACL=3Dy
-CONFIG_AUTOFS4_FS=3Dy
+CONFIG_AUTOFS_FS=3Dy
 CONFIG_ISO9660_FS=3Dm
 CONFIG_JOLIET=3Dy
 CONFIG_ZISOFS=3Dy
diff --git a/arch/sh/configs/sh7763rdp_defconfig b/arch/sh/configs/sh7763r=
dp_defconfig
index ae726745d9a0..57923c3296cc 100644
=2D-- a/arch/sh/configs/sh7763rdp_defconfig
+++ b/arch/sh/configs/sh7763rdp_defconfig
@@ -63,7 +63,7 @@ CONFIG_MMC=3Dy
 CONFIG_EXT2_FS=3Dy
 CONFIG_EXT3_FS=3Dy
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-CONFIG_AUTOFS4_FS=3Dy
+CONFIG_AUTOFS_FS=3Dy
 CONFIG_MSDOS_FS=3Dy
 CONFIG_VFAT_FS=3Dy
 CONFIG_PROC_KCORE=3Dy
diff --git a/arch/sparc/configs/sparc32_defconfig b/arch/sparc/configs/spa=
rc32_defconfig
index 7c489e7f19b7..5010164de3e4 100644
=2D-- a/arch/sparc/configs/sparc32_defconfig
+++ b/arch/sparc/configs/sparc32_defconfig
@@ -65,7 +65,7 @@ CONFIG_EXT2_FS=3Dy
 CONFIG_EXT2_FS_XATTR=3Dy
 CONFIG_EXT2_FS_POSIX_ACL=3Dy
 CONFIG_EXT2_FS_SECURITY=3Dy
-CONFIG_AUTOFS4_FS=3Dm
+CONFIG_AUTOFS_FS=3Dm
 CONFIG_ISO9660_FS=3Dm
 CONFIG_PROC_KCORE=3Dy
 CONFIG_ROMFS_FS=3Dm
diff --git a/arch/um/configs/i386_defconfig b/arch/um/configs/i386_defconf=
ig
index 05ae535ba0dc..630be793759e 100644
=2D-- a/arch/um/configs/i386_defconfig
+++ b/arch/um/configs/i386_defconfig
@@ -62,7 +62,7 @@ CONFIG_UML_NET_SLIRP=3Dy
 CONFIG_EXT4_FS=3Dy
 CONFIG_REISERFS_FS=3Dy
 CONFIG_QUOTA=3Dy
-CONFIG_AUTOFS4_FS=3Dm
+CONFIG_AUTOFS_FS=3Dm
 CONFIG_ISO9660_FS=3Dm
 CONFIG_JOLIET=3Dy
 CONFIG_PROC_KCORE=3Dy
diff --git a/arch/um/configs/x86_64_defconfig b/arch/um/configs/x86_64_def=
config
index 1c757238be7f..8540d3370272 100644
=2D-- a/arch/um/configs/x86_64_defconfig
+++ b/arch/um/configs/x86_64_defconfig
@@ -60,7 +60,7 @@ CONFIG_UML_NET_SLIRP=3Dy
 CONFIG_EXT4_FS=3Dy
 CONFIG_REISERFS_FS=3Dy
 CONFIG_QUOTA=3Dy
-CONFIG_AUTOFS4_FS=3Dm
+CONFIG_AUTOFS_FS=3Dm
 CONFIG_ISO9660_FS=3Dm
 CONFIG_JOLIET=3Dy
 CONFIG_PROC_KCORE=3Dy
diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defco=
nfig
index 3cf34912abfe..75a343f10e58 100644
=2D-- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -245,7 +245,7 @@ CONFIG_QUOTA=3Dy
 CONFIG_QUOTA_NETLINK_INTERFACE=3Dy
 # CONFIG_PRINT_QUOTA_WARNING is not set
 CONFIG_QFMT_V2=3Dy
-CONFIG_AUTOFS4_FS=3Dy
+CONFIG_AUTOFS_FS=3Dy
 CONFIG_ISO9660_FS=3Dy
 CONFIG_JOLIET=3Dy
 CONFIG_ZISOFS=3Dy
diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_d=
efconfig
index 27759236fd60..0902518e9b93 100644
=2D-- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -242,7 +242,7 @@ CONFIG_QUOTA=3Dy
 CONFIG_QUOTA_NETLINK_INTERFACE=3Dy
 # CONFIG_PRINT_QUOTA_WARNING is not set
 CONFIG_QFMT_V2=3Dy
-CONFIG_AUTOFS4_FS=3Dy
+CONFIG_AUTOFS_FS=3Dy
 CONFIG_ISO9660_FS=3Dy
 CONFIG_JOLIET=3Dy
 CONFIG_ZISOFS=3Dy
=2D-
2.40.1

