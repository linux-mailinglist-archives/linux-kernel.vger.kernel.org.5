Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDDF7E003A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346755AbjKCIyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 04:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346393AbjKCIya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 04:54:30 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE53AD47
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 01:54:23 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3A384Hde022531;
        Fri, 3 Nov 2023 09:54:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=selector1; bh=Pe2rrPs
        Z3WZeByEaBg6ZSoHCMY4XSUsW3RCMBo/D3gk=; b=yQbctxYKCgajZJYC/h5uBxU
        AHmF8kJgDO3EFBgmYqPXa/sGFA/Mc/awIdPf0eFOuxKhKZzEM2XlFak8DdZJY7xs
        hvzATl/OTtavplhKUimZW56vXfdchCJy+cgKtBuF39Xexe4oTCAN32LsGX+hEltG
        yE4DwsxMhYp0vHnMzpnpXQ7wwLObkdZjSsYhmCtvmq7qW7OAsKNs5F7NiFPTFgGB
        Q1AGmaTdY9zL7ue8i1xwY/Z0y/pFWQXUF3YA2W5W10u3GatfPq9zho0VhnZwCLfV
        /ryFr9j4p7DhnrFnguHUq5WDRR1/xBiOnpvwOGxJU8qmGsEgkgfqpi3UsixYWIQ=
        =
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3u0tufs77e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 09:54:04 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 33A27100060;
        Fri,  3 Nov 2023 09:54:03 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0295D20B60E;
        Fri,  3 Nov 2023 09:54:03 +0100 (CET)
Received: from localhost (10.201.20.20) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 3 Nov
 2023 09:54:02 +0100
From:   Etienne Carriere <etienne.carriere@foss.st.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Kevin Hilman <khilman@baylibre.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <soc@kernel.org>, <arm@kernel.org>,
        Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH] ARM: multi_v7_defconfig: Add SCMI reset support
Date:   Fri, 3 Nov 2023 09:54:00 +0100
Message-ID: <20231103085400.2924282-1-etienne.carriere@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.20]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_09,2023-11-02_03,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SCMI reset controllers are used in the ARMv7 STMicroelectronics stm32mp
boards:
- for STM32MP13: stm32mp135f-dk
- for STM32MP15 boards with SCMI variant, introduced by commit 5b7e58313a77
  ("ARM: dts: stm32: Add SCMI version of STM32 boards (DK1/DK2/ED1/EV1)")
  * stm32mp157c-ev1-scmi
  * stm32mp157c-ed1-scmi
  * stm32mp157c-dk2-scmi
  * stm32mp157a-dk1-scmi

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 23fc49f23d25..01b3797f9317 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -1189,6 +1189,7 @@ CONFIG_PWM_TEGRA=y
 CONFIG_PWM_VT8500=y
 CONFIG_KEYSTONE_IRQ=y
 CONFIG_RESET_MCHP_SPARX5=y
+CONFIG_RESET_SCMI=y
 CONFIG_PHY_SUN4I_USB=y
 CONFIG_PHY_SUN9I_USB=y
 CONFIG_PHY_BRCM_USB=m
-- 
2.25.1

