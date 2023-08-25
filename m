Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74848788C88
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 17:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241743AbjHYPgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 11:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242706AbjHYPfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 11:35:54 -0400
X-Greylist: delayed 2481 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 25 Aug 2023 08:35:48 PDT
Received: from mx.dolansoft.org (s2.dolansoft.org [212.51.146.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03E02137
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 08:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=brun.one;
        s=s1; h=MIME-Version:Message-ID:Date:Subject:Cc:To:From:In-Reply-To:
        References:From:To:Subject:Date:Message-ID:Reply-To;
        bh=T3SoMggWQU9QDC3JzPWHOLjCpIniafz0l32O6ZjmZIo=; b=OyJKnRWFxE/QMt51QstCWNOyt1
        2LRxEafsfxHOjnZQSVyDmhOrh3WQfkFQ4KCtrhMcQPHvzD1sLLnAPgW/7I6ngYxeSOi9WA40GG/0V
        eEx0qkDUPjhaNO17TGE3KwqF92maMdGuDmYEezkL83X2004aj/27JrBXNfkFJZpoF2oKjqoNml7Oo
        y63UCLYWU8mCou7HnowSpuw7VRzXfn2OpXezKrv93EUWRIpRv0e9O+e7L6D7oI/ojUClM2UsszhYS
        VdjQWpKXYiOu1Z4bxX20M8BZtzK9xieAR0dLPtMroar43W96i4G5y33rlNEb+P9kCL+Vcy+uzWX1O
        DU8qs6JA==;
Received: from [212.51.153.89] (helo=blacklava.cluster.local)
        by mx.dolansoft.org with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <lorenz@dolansoft.org>)
        id 1qZYCR-006lKz-0Q;
        Fri, 25 Aug 2023 14:54:11 +0000
From:   Lorenz Brun <lorenz@brun.one>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: defconfig: add support for MediaTek MT7986
Date:   Fri, 25 Aug 2023 16:54:05 +0200
Message-ID: <20230825145406.1372848-1-lorenz@brun.one>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: lorenz@dolansoft.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Considering that there are boards based on this SoC with 2GiB+ RAM and
PCIe out there (BPI-R3) I think it makes sense to have support for these
in defconfig as people can conceivably use these with stock Linux
distributions.

AFAIK this only adds modules, it should not increase the size of the
main vmlinux binary.

Signed-off-by: Lorenz Brun <lorenz@brun.one>
---
 arch/arm64/configs/defconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a25d783dfb95..13a1e09524d4 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -162,6 +162,7 @@ CONFIG_IP6_NF_TARGET_MASQUERADE=m
 CONFIG_BRIDGE=m
 CONFIG_BRIDGE_VLAN_FILTERING=y
 CONFIG_NET_DSA=m
+CONFIG_NET_DSA_MT7530=m
 CONFIG_VLAN_8021Q=m
 CONFIG_VLAN_8021Q_GVRP=y
 CONFIG_VLAN_8021Q_MVRP=y
@@ -177,6 +178,8 @@ CONFIG_NET_CLS_ACT=y
 CONFIG_NET_ACT_GACT=m
 CONFIG_NET_ACT_MIRRED=m
 CONFIG_NET_ACT_GATE=m
+CONFIG_NET_VENDOR_MEDIATEK=y
+CONFIG_NET_MEDIATEK_SOC=m
 CONFIG_QRTR_SMD=m
 CONFIG_QRTR_TUN=m
 CONFIG_CAN=m
@@ -267,9 +270,11 @@ CONFIG_MTD_SST25L=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_DENALI_DT=y
 CONFIG_MTD_NAND_MARVELL=y
+CONFIG_MTD_NAND_MTK=m
 CONFIG_MTD_NAND_BRCMNAND=m
 CONFIG_MTD_NAND_FSL_IFC=y
 CONFIG_MTD_NAND_QCOM=y
+CONFIG_MTD_NAND_ECC_MEDIATEK=m
 CONFIG_MTD_SPI_NOR=y
 CONFIG_MTD_UBI=m
 CONFIG_UBIFS_FS=m
@@ -407,6 +412,8 @@ CONFIG_BRCMFMAC=m
 CONFIG_MWIFIEX=m
 CONFIG_MWIFIEX_SDIO=m
 CONFIG_MWIFIEX_PCIE=m
+CONFIG_MT7915E=m
+CONFIG_MT7986_WMAC=y
 CONFIG_MT7921E=m
 CONFIG_WL18XX=m
 CONFIG_WLCORE_SDIO=m
@@ -529,6 +536,7 @@ CONFIG_SPI_MESON_SPICC=m
 CONFIG_SPI_MESON_SPIFC=m
 CONFIG_SPI_MT65XX=y
 CONFIG_SPI_MTK_NOR=m
+CONFIG_SPI_MTK_SNFI=m
 CONFIG_SPI_OMAP24XX=m
 CONFIG_SPI_ORION=y
 CONFIG_SPI_PL022=y
@@ -645,6 +653,8 @@ CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
 CONFIG_CPU_THERMAL=y
 CONFIG_DEVFREQ_THERMAL=y
 CONFIG_THERMAL_EMULATION=y
+CONFIG_MTK_THERMAL=y
+CONFIG_MTK_SOC_THERMAL=m
 CONFIG_IMX_SC_THERMAL=m
 CONFIG_IMX8MM_THERMAL=m
 CONFIG_QORIQ_THERMAL=m
-- 
2.41.0

