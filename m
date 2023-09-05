Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1F97929F3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355063AbjIEQaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354417AbjIEL1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 07:27:53 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2149.outbound.protection.outlook.com [40.92.62.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B6C1AD;
        Tue,  5 Sep 2023 04:27:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jONtlyxhCkMKEeUxkuGupxF8d/tyKLviM0j48FBHphbp32ozrWB0sGrT/VdNeEEfKtE7lbiJ9JRSjD8iSUFKF69udPWyjedBL12mMJqIMsBxokFY7rhtQkn+DFLvU5eMn+IYASwooI3GimxBfJZRilzWn2JdJcStxJea4ZRhkkZ+quIIIZQ9ytbwGVGWI/iln7a+riGeqqN7fX0CqPD583M8MClfQKEH0rxAAuDfeEqZtEF3xrM9u2pYR0k+14WyDDzB4Ql6uPFQTTcHtQBFfH36gNT23x1rRmLSWF08aOZR1lcmqYFB+/GDWZkQRzmVNN6B0SrATFTsVey7gpmlSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8PFbMC95shG1VszT+wYO5vVC55/zpOiNBE06jOrGIw=;
 b=ml+mhHXz6WL0RF572APuqwwk1kqOUmduWX6ClVFrN/2jpz+193hnuA3fiG+0q5rXq41Oq7sm5yZjVsAtojX0coV1kzW56p9bGjwNWWThSJc2iXp9SyotYnNdCVLc8doVZo18U3ewzT75zoeDmmzXdJU5YP4rBJ1F+R3LCe0abohGGSqOwzxgW3tN19/CeS9uM6uTqj42QzLpaFGUzu3kTPeOxiCmwsZ1/onkDltbrIkb9FOnuOzC125Jm3fpAqI4mIf1rs+WAm6TiO/2LsfnLfQfH2mTkWyXy6YpGOwci1wcYvrIsXXD52MEVIJq24LfBA0FG2uAno+4XjitcYxg9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8PFbMC95shG1VszT+wYO5vVC55/zpOiNBE06jOrGIw=;
 b=TLuCT9KB5KD17ogL65qZFNOBz3stjOGjoYVvYp+Bsq3zl2u+KtyWBjuncQoG1gJFj/39J3BxvsGxIkLIC6bsKAkBQydgRWVLASH4SG1Bo2D6gW7yAxeeUteORYbEloJWvWR6wOPWPQX98NFTh2JDcAr7jPuZKu860j/jHIr3bx4ZWFPY/azDetdKVUtcv6RZfEPlm2lqSqL6etDoIRjRZcfgg7Q0Q8pD5jBeMrxlqXuorYO0axCZ5tMwgmuDjw8GoDGzjNWNGVPLroj7unrzvmaaZqE6yA1/mgr9k8J3cFpup9Zq9NdfpFYFLXIGMFEZUeGdFD9s4KmaMlfWn+Q82w==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by SY6P282MB3213.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:164::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 11:27:43 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::beb:8e33:17b1:a347]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::beb:8e33:17b1:a347%4]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 11:27:42 +0000
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
Subject: [net-next v3 5/5] net: wwan: t7xx: Devlink documentation
Date:   Tue,  5 Sep 2023 19:26:37 +0800
Message-ID: <MEYP282MB2697DB50DD70C7B755E04578BBE8A@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230905112637.18877-1-songjinjian@hotmail.com>
References: <20230905112637.18877-1-songjinjian@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [Su1kXluObHKZ17sNiTTcdGTllkWRsfFn]
X-ClientProxiedBy: SGAP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::18)
 To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID: <20230905112637.18877-6-songjinjian@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|SY6P282MB3213:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c4d8455-5189-4e58-f737-08dbae031ea9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RpFN2E90E71raooRQhQvn8x12MeNxaEJUNsaeVN9M6HQ7gGYaW7t777Ub1y6q57TWTq2w4qS5tW1NZggqq8pyF+q4LNzj25sc5PaabugCMfyf5oaFirdGSb7FzAsB/3lZakqAGc0YuZKOFpuUm/FRclWeuGgzfUwZUBPoHytFIUmMViN6LcXebNUxM7tQNT6vkgBQDKBttNGlv4dUopKhsVOI5BTCf7VzHMdFIpaAc4BFylvPDiSfK2Dk7aCUW3SLYG1EuA+wknoLxdQqI596oex3DW5NoNphno2+X2lemAYYfd8Z7PUJ3r6esqrMmlLhe+UTstGFhKyaYCm7Wsa4F/Ur6+6ROcjbscdWl1oN35m2bIYtI4wGzPYsuZVSHubuBIL/hBo7bSKv0eI+wexvmmjEAUObHIEqJQU+904p3dJDffZMFVHedjIfJY7//uxxv232dbkK45MWa6j+g5qR1hqhlg0PciAFlCCFIk3MLC5jNd6NBCQle4OcyBdGbSB02Z0tsCUo3iXD63OwcH2+EJ0+tlMuwFNJi69TkUx0hI=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WlwGMv9yAZ6eq4V5DxwBrVXt8P7j6cEbFo1uaSuZt+QXykcp6k0aSht0NrFm?=
 =?us-ascii?Q?LuZ1vq+vDyl/m6kMAgf+OV9AiSSTaELR70YLfHaRD4M73va+ZnmaInNkPWho?=
 =?us-ascii?Q?uJaKowfODq3bxdt6U1N/apmoWWvhB5CmAmVXIWYKzMVX5Oqlbj9N/H0trvEq?=
 =?us-ascii?Q?Tf9dd3UVflHRDt28MR9vE9fzcJoiZbM2oh+kw8O2sIY3UwT0ztzs0EKMmUA6?=
 =?us-ascii?Q?dLeb5YIn3KazP+OG0C8Gb0EjvSXh9APNPEcaFM/1Ixwg4nfqQuyMeLZRQDkk?=
 =?us-ascii?Q?iBO45yzqVFxSDp/u5n5osyUREpb/UfsVPNREyaAEYqVmcTjnROETNKK8mHoD?=
 =?us-ascii?Q?mmLvzSobRMwmypsrraWMGxnPU4o/NZxExbEZyqWShDdfySDPUqR29SpqQ9A1?=
 =?us-ascii?Q?99CsD8OiyuhjzS6T4tC+cSplgQFCI8C97Ww9+XqPNbd3iB5Hmp7fB/QZiOrl?=
 =?us-ascii?Q?8jQ5m3VTbyMAnljbG0thPlpwbrUmu/hEYaWfzeH8sPo+AkT6AVWhaDWdj1hg?=
 =?us-ascii?Q?APwVHghcLFcvNcqYpPgl+2unLzRFYs8CYxLXxzH5HFtfaul5XtJeOLebBoZp?=
 =?us-ascii?Q?A6FnUy2dBz1vAY1sSdtC57dshcXKdO95tiiJpB+Q7d8WnqbL+JaE2nRJeRgq?=
 =?us-ascii?Q?IyDSaWI0r2+CcLnFFiE8fcZGhyJSfmB2UMg/+83S54CWmKMJ6UlXGC5t1GS9?=
 =?us-ascii?Q?493DarLcb4X8h830CKWNVxNh7QWfk9q/yKaGofWJ8rKaEZswE3AHFSQTe9GY?=
 =?us-ascii?Q?73zKoyDyLf3tpuKMt0Yy/1BshQlESQjeNf6uaogVuiUIAEXruMbwQ/nS/Woc?=
 =?us-ascii?Q?C8l5fO210i4dvcHNJFARdPRS/BOQSfYS1Fi+4Ew8HPWgQL5zRFnynE6NYud8?=
 =?us-ascii?Q?KLC+gvnSz22NMIdThJZKEJivegU90RqRTQLR7mFOmbgaFAa4uTF0/eiJ9YX5?=
 =?us-ascii?Q?wOiaeF3ELDUsY3iVoc2KertFjK9c3nzJOPSbffDqgtiJazxRrdgbQ+6iET/B?=
 =?us-ascii?Q?dZsagUTCtz2lYmNtuak6pqs12BNFiwPw/WrIgLoAzhqIRAS/ciskc6uC+H8v?=
 =?us-ascii?Q?/HEylwox+Bl6QG4wqsBa+Dlp8onb3Ar50viLyPhpqRSy3ekgF0EXipOGau34?=
 =?us-ascii?Q?4osVck6Zt/t0nIPGFKZy5Lm30c2B/fQ4KXaqjErzf8OtSBrsJo3MA0ZsHZ++?=
 =?us-ascii?Q?Jq16gpFJ3XCBYUkpfa0yD5CP4XAozl9UHQTK3f3NnYCxC26c/l3KIK8P1zw?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c4d8455-5189-4e58-f737-08dbae031ea9
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 11:27:42.8861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY6P282MB3213
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

