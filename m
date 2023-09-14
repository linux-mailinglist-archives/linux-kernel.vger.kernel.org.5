Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293A179FEAB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 10:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236420AbjINIoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 04:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236575AbjINIn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 04:43:58 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A170E1FE0;
        Thu, 14 Sep 2023 01:43:52 -0700 (PDT)
X-QQ-mid: bizesmtp81t1694681014t16evqhx
Received: from main2-ubuntu.tail147f4.ts.net ( [202.201.15.117])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 14 Sep 2023 16:43:32 +0800 (CST)
X-QQ-SSF: 00200000000000907000000A0000000
X-QQ-FEAT: oAZ4GxcAC/VI+ncbe/WqybxXh1XLEZFy2YK7qRtVv2+fw7xXSYHohLX83MT8d
        mEoTgvURjNRAYPiadjffRz5EeFgJS6n1Q5mC80c3KI3jso9spEaqrM7ARb4oLBeaugqU0xQ
        bsrRdtjd5LKA71ZjXTkOI4R+0ZUHWDnc6Bcyd1KYFDPvDynTfpgjUj82mFRaOBCioXVG88u
        jV/7l2WX1Z5ALc9Rwo84S6VIdyW2NkRH7IfHP4X+dHMQXE3yVwLXG4GmgsyMlyDokarg0Yo
        rEVi1DH2q8C72V5jL0x1NpW3OVxn776Z18tkajgDtxI5ymnmikx9bNLi9xM5m21FJoX4IJD
        PnJ3N10yEFT3NPULCsB3qy+xJ815b0hFIvtQBvmtfiNhAufmaw=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10233896525640872337
From:   Yuan Tan <tanyuan@tinylab.org>
To:     tsbogend@alpha.franken.de, 42.hyeyoo@gmail.com, philmd@linaro.org
Cc:     linux-mips@vger.kernel.org, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, falcon@tinylab.org, w@1wt.eu,
        linux@weissschuh.net, tanyuan@tinylab.org
Subject: [PATCH v3 1/3] MIPS: Cleanup malta_defconfig
Date:   Thu, 14 Sep 2023 16:43:31 +0800
Message-Id: <0b4450f083b612f78207e17499fc6ea6c65c6f3b.1694680448.git.tanyuan@tinylab.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694680448.git.tanyuan@tinylab.org>
References: <cover.1694680448.git.tanyuan@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use 'make savedefconfig' to cleanup malta_defconfig.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
---
 arch/mips/configs/malta_defconfig | 39 +++++++------------------------
 1 file changed, 8 insertions(+), 31 deletions(-)

diff --git a/arch/mips/configs/malta_defconfig b/arch/mips/configs/malta_defconfig
index ae1a7793e810..7ae07d57b79a 100644
--- a/arch/mips/configs/malta_defconfig
+++ b/arch/mips/configs/malta_defconfig
@@ -6,18 +6,17 @@ CONFIG_NAMESPACES=y
 CONFIG_RELAY=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
-# CONFIG_COMPAT_BRK is not set
 CONFIG_MIPS_MALTA=y
 CONFIG_CPU_LITTLE_ENDIAN=y
 CONFIG_CPU_MIPS32_R2=y
 CONFIG_PAGE_SIZE_16KB=y
 CONFIG_NR_CPUS=8
 CONFIG_HZ_100=y
-CONFIG_PCI=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
+# CONFIG_COMPAT_BRK is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -133,19 +132,6 @@ CONFIG_IP_NF_RAW=m
 CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
-CONFIG_IP6_NF_MATCH_AH=m
-CONFIG_IP6_NF_MATCH_EUI64=m
-CONFIG_IP6_NF_MATCH_FRAG=m
-CONFIG_IP6_NF_MATCH_OPTS=m
-CONFIG_IP6_NF_MATCH_HL=m
-CONFIG_IP6_NF_MATCH_IPV6HEADER=m
-CONFIG_IP6_NF_MATCH_MH=m
-CONFIG_IP6_NF_MATCH_RT=m
-CONFIG_IP6_NF_TARGET_HL=m
-CONFIG_IP6_NF_FILTER=m
-CONFIG_IP6_NF_TARGET_REJECT=m
-CONFIG_IP6_NF_MANGLE=m
-CONFIG_IP6_NF_RAW=m
 CONFIG_BRIDGE_NF_EBTABLES=m
 CONFIG_BRIDGE_EBT_BROUTE=m
 CONFIG_BRIDGE_EBT_T_FILTER=m
@@ -177,7 +163,6 @@ CONFIG_IPDDP=m
 CONFIG_IPDDP_ENCAP=y
 CONFIG_PHONET=m
 CONFIG_NET_SCHED=y
-CONFIG_NET_SCH_CBQ=m
 CONFIG_NET_SCH_HTB=m
 CONFIG_NET_SCH_HFSC=m
 CONFIG_NET_SCH_PRIO=m
@@ -186,16 +171,12 @@ CONFIG_NET_SCH_SFQ=m
 CONFIG_NET_SCH_TEQL=m
 CONFIG_NET_SCH_TBF=m
 CONFIG_NET_SCH_GRED=m
-CONFIG_NET_SCH_DSMARK=m
 CONFIG_NET_SCH_NETEM=m
 CONFIG_NET_SCH_INGRESS=m
 CONFIG_NET_CLS_BASIC=m
-CONFIG_NET_CLS_TCINDEX=m
 CONFIG_NET_CLS_ROUTE4=m
 CONFIG_NET_CLS_FW=m
 CONFIG_NET_CLS_U32=m
-CONFIG_NET_CLS_RSVP=m
-CONFIG_NET_CLS_RSVP6=m
 CONFIG_NET_CLS_FLOW=m
 CONFIG_NET_CLS_ACT=y
 CONFIG_NET_ACT_POLICE=y
@@ -211,6 +192,7 @@ CONFIG_CFG80211=m
 CONFIG_MAC80211=m
 CONFIG_MAC80211_MESH=y
 CONFIG_RFKILL=m
+CONFIG_PCI=y
 CONFIG_DEVTMPFS=y
 CONFIG_CONNECTOR=m
 CONFIG_MTD=y
@@ -220,7 +202,6 @@ CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_CFI_STAA=y
-CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_MTD_UBI=m
 CONFIG_MTD_UBI_GLUEBI=m
 CONFIG_BLK_DEV_FD=m
@@ -396,20 +377,16 @@ CONFIG_NLS_ISO8859_15=m
 CONFIG_NLS_KOI8_R=m
 CONFIG_NLS_KOI8_U=m
 CONFIG_CRYPTO_CRYPTD=m
-CONFIG_CRYPTO_LRW=m
-CONFIG_CRYPTO_PCBC=m
-CONFIG_CRYPTO_HMAC=y
-CONFIG_CRYPTO_XCBC=m
-CONFIG_CRYPTO_MD4=m
-CONFIG_CRYPTO_SHA512=m
-CONFIG_CRYPTO_WP512=m
-CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_BLOWFISH=m
 CONFIG_CRYPTO_CAMELLIA=m
 CONFIG_CRYPTO_CAST5=m
 CONFIG_CRYPTO_CAST6=m
 CONFIG_CRYPTO_FCRYPT=m
-CONFIG_CRYPTO_KHAZAD=m
 CONFIG_CRYPTO_SERPENT=m
-CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
+CONFIG_CRYPTO_LRW=m
+CONFIG_CRYPTO_PCBC=m
+CONFIG_CRYPTO_HMAC=y
+CONFIG_CRYPTO_MD4=m
+CONFIG_CRYPTO_WP512=m
+CONFIG_CRYPTO_XCBC=m
-- 
2.34.1

