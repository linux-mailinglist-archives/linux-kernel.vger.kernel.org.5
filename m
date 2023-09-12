Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E894679CC60
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbjILJuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbjILJuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:50:04 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2178.outbound.protection.outlook.com [40.92.62.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19E0E6B;
        Tue, 12 Sep 2023 02:50:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lTd2H2FilmVbvA2rd1f2/KmvmGu7inD6/KHQEtCAhERPATS/WxL5UEPbM7dKPddY7GcmAkwAiPFCg2+OI1KRJT40cMK1+cGhhys0d5mYu0YFj45U1CsuPGfdZH3cSul1PGSJp5d7Z2NlgPrHw7QILrP1nVEtsaiQ9TxvtPI2Kl3Vnb8tqCdVXt5BIpGCWoNBWflSbttLmRnt5sJcTuULZ1OTY1gzkm7j0sTTipQr1WFKG4YnWz3n2jiPEhtYYR8x+dQUeu11PTyNco4D5WxeYnuOQnbQ1emhnXxdew6NkgUNk3Kkz3lLWxP2aMcy+mbWX3hG7B3CXNCQqg8uPHs3zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11PJmNmcYjmj5VVgJ7K0q+adbrpE0xocLu9jecU+ClE=;
 b=UssN1aGIpprEQH3IlKZguXJ7Gzlr9ok2Mqx7qyuC57P0at1RyvNLrFno7fmVUJ0yASL2vCgu/2a57qgo31RYfOIrZHNOBx2JgoVeyDB99kNeD92aHs+Og9xHKrC4ZZPr76RsJkMSriNEmZewDQ7f8Ytr0VeVj2YRTo2L8RIUJPqO9TMMmG77jg+5HMsKW/F41bhBkDY0+a8jtk2KVpJ3laqysUr7ek4KUDoWZF9XCaMzk0xH0T4e1AOGwamLtc5tKZYL2pmB2oW9jqun7c+36T9//KiqjgQt19YPSY4W3Gvc9WyuNhdzi5zHggk/3qECcl7wfcmKK99WsVkQ5SZiDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11PJmNmcYjmj5VVgJ7K0q+adbrpE0xocLu9jecU+ClE=;
 b=DmhjbxhDwFmxEcSRRetIMfuePjRjiADfp+V3ohRu7Lu6z4+CKorrJtHeOn5WZsefPpXmEyQu07PHheCRd3yU6D/UE5T6dHX6LcUPYGFTVdPcaXd1jWEI+BbfobCOZGs8RptlsjNbPZVZeMqiD+0khij0lQWeeEU+8fa+tamFFvGO+CoqaHmWC/D5lczBVhDQz7KStvh2t7nsE5olhLKeZmywD+yeief+VaMEJHL5r6U7lAGWn1XHcltrKPPUgo+6gvCkE+h1jyIhAsjBDCr1Susvb998YLUAd8k/Gv+zuLwIjtA7XZuq6YWEvouG24ba9Jd0DfZev7PKB5+ab+NCkg==
Received: from ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:16b::5)
 by SY4P282MB2981.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:15c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 09:49:53 +0000
Received: from ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM
 ([fe80::68b4:6263:97f:9a45]) by ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM
 ([fe80::68b4:6263:97f:9a45%3]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 09:49:53 +0000
From:   Jinjian Song <songjinjian@hotmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, corbet@lwn.net, loic.poulain@linaro.org,
        ryazanov.s.a@gmail.com
Cc:     jiri@resnulli.us, johannes@sipsolutions.net,
        chandrashekar.devegowda@intel.com, linuxwwan@intel.com,
        chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com,
        m.chetan.kumar@linux.intel.com, ricardo.martinez@linux.intel.com,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, nmarupaka@google.com,
        vsankar@lenovo.com, danielwinkler@google.com,
        Jinjian Song <jinjian.song@fibocom.com>
Subject: [net-next v4 5/5] net: wwan: t7xx: Devlink documentation
Date:   Tue, 12 Sep 2023 17:48:45 +0800
Message-ID: <ME3P282MB27037E574DB3685216A0DF56BBF1A@ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912094845.11233-1-songjinjian@hotmail.com>
References: <20230912094845.11233-1-songjinjian@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [0tyZKwlvml3QWeml2v5sWNFNmeExt5Z6]
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:16b::5)
X-Microsoft-Original-Message-ID: <20230912094845.11233-6-songjinjian@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME3P282MB2703:EE_|SY4P282MB2981:EE_
X-MS-Office365-Filtering-Correlation-Id: 45576c39-06a7-4af6-2ce8-08dbb3759d1c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zs7oW/5CfsiKFabRl24+0Mi/CGOJ4ksvAjNX09hdzBF2txwEZ7zH3Zkp0HJeSOMRGvds8VXGKvE5J9K6mw3zYOEWVsMa2Rw6wSfBKyL7S7YyKXeO2/DpEUKQfT9ho/HsODpnyWoeTknJmUmY59+oHG9gqMTqJ0Bgy84K9rN6t39ZEDCtFubdb3QlkekCnkcEVtaUc/V7Qte/ZjPa23OXRrCPzzDPmuZqcZ+3p0RbjMxeme4jTwNFxNXHNIagfr3T3aVEfvUYCGSiCGLPDJbh9TjKQpdVuuVbKECdGXHbc1Qc+MjIqwHVPw/oUb90IzEXgHiNaAOolYacSN31fxUxEblVEm4kaptsniwR2+ypbTk5p3V7MPGqWCIuQVEThlY+vxkkEwJL3jffeXtBLWwaHIlTn3EYaEdi4OUr6jHWgUaosB9mT3cRSXlX+IaWLl9UEdnZG+i+vzVLoZN930GNHLsuh5XZqBw4FwQSt5ZwxBTKPSL+HaycjBkl4Xiup/QBuNOrnEDEETz3MhrIFj2kQolqUZgBjQGNBoJ/FL+pROhFUSeSwmGLfjtCajPgJ8zbCTNy/rKPjxZupyDesxMVPi8wTGzckm924sGn4ll+VyQ=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/e/BXWVkX3l6xpYIsxjYLimsrssC+hmIVJMqmMrzhsmlVTbA5EApM50eM8Pq?=
 =?us-ascii?Q?ikby6HoDRrjcFXCCTEiniGVMDL1LUWUUoiQr/Kr05C8rHufIFHNL4Rh+IA8U?=
 =?us-ascii?Q?CtCgh64Utk0fNYaUDMusfl4H72vD9Cr3T4VISDpoZz5XfPdbc14MphNUvoyb?=
 =?us-ascii?Q?C8g3iBSW//hMjnnThZ3AKNe+X3aUq2tNFpZzC+cjeS749Y50XrZ7lG+P5IQP?=
 =?us-ascii?Q?wBDPNMXjt9EGTrtK07jGc4f69REEDBVozXq4om5dp3HfthNv5IhB7Zl0dSZd?=
 =?us-ascii?Q?6+wKOX3IxmGHUNJuYTcX8cBzPfBFpaKPuz6VLPHGQrX9gZmtVxORfPph/8z8?=
 =?us-ascii?Q?viQtrLE6ytAVNDMsqCpdaXOzwAMd7C8PZMDMst3R77RqyxejWeCkwjKxATQ5?=
 =?us-ascii?Q?BJZoTxScPreiw1vbkwc1YmKOwnuHRTLliu29vq4M9oO6tlXTqAdgIpnuqioO?=
 =?us-ascii?Q?jrNLTksVwyYr2BjrWHPDjQlSh8nwWC/KSfulL32uI+ebtt+tFak3fW865e80?=
 =?us-ascii?Q?UYgbWJKHACQQ76QTEGNoLLiqon0li4lXTquMHy9KJd3DvwzQVO8KnmwxEj8i?=
 =?us-ascii?Q?BfM3lHUarsGXt5bbaKCjmHjpxJkwjhUmY4+NO1mVXL/Le6KkjKeCtMRtNPwv?=
 =?us-ascii?Q?u9oIP/BsFi9sK+OJNHdRtKEqgeT4c0xDWeGt/0GpDhH//SaewEMFRfVHcEVI?=
 =?us-ascii?Q?BU2qjcRNfAIIwS0XEdbn52Oq3PFURA5wEFxq5SKJDUJIiGuLQ7rnMG4oJ89k?=
 =?us-ascii?Q?O3lCeN9YnrcP0AwZdyK3omwcSLUbtwaqEQrbR0MTh13cJe2f3D7z4jsPADHU?=
 =?us-ascii?Q?WW2HK+VV6fwoUByIUZMKOG3EtbLON8XAE32p3CTPgXkAshmxJL/ktOEeUrSJ?=
 =?us-ascii?Q?+VgII3TNF78J9vJMFdcG4CUKachmn9UmWJI6oZINQ7ehvEoDMQzPFqpRdrss?=
 =?us-ascii?Q?Ir1iVkUC4yPnNbpWYo/J1XDM7m4xIUdFXDshrmI8OghPwbRHAQJnMf+qwXph?=
 =?us-ascii?Q?2GuQhEQ3OsPJlTCrTocAnwWJU8ffvqu3PlOxx5n72/Nfc11mFWtHu6El2bGn?=
 =?us-ascii?Q?+a3xu4RhS1FfG9BPDrTq2aC+R3Zl9vqXkZ+cToE0QN4wEi6cN7ly33rZc9wo?=
 =?us-ascii?Q?87FxuVyQR+6ZWSBBNe9xqbjx/Bd/LLf4Q0tVioJqieGl2sgFEbkK4PfGf+pS?=
 =?us-ascii?Q?y9OVnSSYP+5qQrSuvvRc/tcGYsGorPSuzym+REud1iNhv34H2Ul1YITxrD8?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 45576c39-06a7-4af6-2ce8-08dbb3759d1c
X-MS-Exchange-CrossTenant-AuthSource: ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 09:49:53.4538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB2981
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jinjian Song <jinjian.song@fibocom.com>

Document the t7xx devlink commands usage for firmware flashing &
coredump collection.

Base on the v5 patch version of follow series:
'net: wwan: t7xx: fw flashing & coredump support'
(https://patchwork.kernel.org/project/netdevbpf/patch/f902d4a0cb807a205687f7e693079fba72ca7341.1674307425.git.m.chetan.kumar@linux.intel.com/)

Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
---
v4:
 * no change
v3:
 * supplementary separator '~'
v2:
 * no change
---
 Documentation/networking/devlink/index.rst |   1 +
 Documentation/networking/devlink/t7xx.rst  | 232 +++++++++++++++++++++
 2 files changed, 233 insertions(+)
 create mode 100644 Documentation/networking/devlink/t7xx.rst

diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
index b49749e2b9a6..f101781105ca 100644
--- a/Documentation/networking/devlink/index.rst
+++ b/Documentation/networking/devlink/index.rst
@@ -67,3 +67,4 @@ parameters, info versions, and other features it supports.
    iosm
    octeontx2
    sfc
+   mtk_t7xx
diff --git a/Documentation/networking/devlink/t7xx.rst b/Documentation/networking/devlink/t7xx.rst
new file mode 100644
index 000000000000..20057bda3923
--- /dev/null
+++ b/Documentation/networking/devlink/t7xx.rst
@@ -0,0 +1,232 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+====================
+t7xx devlink support
+====================
+
+This document describes the devlink features implemented by the ``t7xx``
+device driver.
+
+Parameters
+==========
+The ``t7xx`` driver implements the following driver-specific parameters.
+
+.. list-table:: Driver-specific parameters
+   :widths: 5 5 5 85
+
+   * - Name
+     - Type
+     - Mode
+     - Description
+   * - ``fastboot``
+     - boolean
+     - driverinit
+     - Set this param to enter fastboot mode.
+
+Flash Update
+============
+
+The ``t7xx`` driver implements the flash update using the ``devlink-flash``
+interface.
+
+The driver uses ``DEVLINK_SUPPORT_FLASH_UPDATE_OVERWRITE_MASK`` to identify the type of
+firmware image that need to be programmed upon the request by user space application.
+
+``t7xx`` driver uses fastboot protocol for firmware flashing. In the firmware
+flashing procedure, fastboot command & response are exchanged between driver
+and wwan device.
+
+::
+
+  $ devlink dev param set pci/0000:bdf name fastboot value 1 cmode driverinit
+
+The devlink param fastboot is set to true via devlink param command, by
+passing name ``fastboot``, value ``1`` and cmode ``driverinit``.
+
+::
+
+  $ devlink dev reload pci/0000:$bdf action driver_reinit
+
+The wwan device is put into fastboot mode via devlink reload command, by
+passing ``driver_reinit`` action.
+
+::
+
+  $ devlink dev reload pci/0000:$bdf action fw_activate
+
+Upon completion of firmware flashing or coredump collection the wwan device is
+reset to normal mode using devlink reload command, by passing ``fw_activate``
+action.
+
+Flash Commands
+--------------
+
+::
+
+  $ devlink dev flash pci/0000:$bdf file preloader_k6880v1_mdot2_datacard.bin component "preloader"
+
+::
+
+  $ devlink dev flash pci/0000:$bdf file loader_ext-verified.img component "loader_ext1"
+
+::
+
+  $ devlink dev flash pci/0000:$bdf file tee-verified.img component "tee1"
+
+::
+
+  $ devlink dev flash pci/0000:$bdf file lk-verified.img component "lk"
+
+::
+
+  $ devlink dev flash pci/0000:$bdf file spmfw-verified.img component "spmfw"
+
+::
+
+  $ devlink dev flash pci/0000:$bdf file sspm-verified.img component "sspm_1"
+
+::
+
+  $ devlink dev flash pci/0000:$bdf file mcupm-verified.img component "mcupm_1"
+
+::
+
+  $ devlink dev flash pci/0000:$bdf file dpm-verified.img component "dpm_1"
+
+::
+
+  $ devlink dev flash pci/0000:$bdf file boot-verified.img component "boot"
+
+::
+
+  $ devlink dev flash pci/0000:$bdf file root.squashfs component "rootfs"
+
+::
+
+  $ devlink dev flash pci/0000:$bdf file modem-verified.img component "md1img"
+
+::
+
+  $ devlink dev flash pci/0000:$bdf file dsp-verified.bin component "md1dsp"
+
+::
+
+  $ devlink dev flash pci/0000:$bdf file OP_OTA.img component "mcf1"
+
+::
+
+  $ devlink dev flash pci/0000:$bdf file OEM_OTA.img component "mcf2"
+
+::
+
+  $ devlink dev flash pci/0000:$bdf file DEV_OTA.img component "mcf3"
+
+Note: Component selects the partition type to be programmed.
+
+
+The supported list of firmware image types is described below.
+
+.. list-table:: Firmware Image types
+    :widths: 15 85
+
+    * - Name
+      - Description
+    * - ``preloader``
+      - The first-stage bootloader image
+    * - ``loader_ext1``
+      - Preloader extension image
+    * - ``tee1``
+      - ARM trusted firmware and TEE (Trusted Execution Environment) image
+    * - ``lk``
+      - The second-stage bootloader image
+    * - ``spmfw``
+      - MediaTek in-house ASIC for power management image
+    * - ``sspm_1``
+      - MediaTek in-house ASIC for power management under secure world image
+    * - ``mcupm_1``
+      - MediaTek in-house ASIC for cpu power management image
+    * - ``dpm_1``
+      - MediaTek in-house ASIC for dram power management image
+    * - ``boot``
+      - The kernel and dtb image
+    * - ``rootfs``
+      - Root filesystem image
+    * - ``md1img``
+      - Modem image
+    * - ``md1dsp``
+      - Modem DSP image
+    * - ``mcf1``
+      - Modem OTA image (Modem Configuration Framework) for operators
+    * - ``mcf2``
+      - Modem OTA image (Modem Configuration Framework) for OEM vendors
+    * - ``mcf3``
+      - Modem OTA image (other usage) for OEM configurations
+
+
+Regions
+=======
+
+The ``t7xx`` driver supports core dump collection in exception state and second
+stage bootloader log collection in fastboot mode. The log snapshot is taken by
+the driver using fastboot commands.
+
+Region commands
+---------------
+
+::
+
+  $ devlink region show
+
+This command list the regions implemented by driver. These regions are accessed
+for device internal data. Below table describes the regions.
+
+.. list-table:: Regions
+    :widths: 15 85
+
+    * - Name
+      - Description
+    * - ``mr_dump``
+      - The detailed modem component logs are captured in this region
+    * - ``lk_dump``
+      - This region dumps the current snapshot of lk
+
+Coredump Collection
+~~~~~~~~~~~~~~~~~~~
+
+::
+
+  $ devlink region new mr_dump
+
+::
+
+  $ devlink region read mr_dump snapshot 0 address 0 length $len
+
+::
+
+  $ devlink region del mr_dump snapshot 0
+
+Note: $len is actual len to be dumped.
+
+The userspace application uses these commands for obtaining the modem component
+logs when device encounters an exception.
+
+Second Stage Bootloader dump
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+::
+
+  $ devlink region new lk_dump
+
+::
+
+  $ devlink region read lk_dump snapshot 0 address 0 length $len
+
+::
+
+  $ devlink region del lk_dump snapshot 0
+
+Note: $len is actual len to be dumped.
+
+In fastboot mode the userspace application uses these commands for obtaining the
+current snapshot of second stage bootloader.
+
-- 
2.34.1

