Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC91C79CC4D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjILJtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbjILJta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:49:30 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2154.outbound.protection.outlook.com [40.92.62.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC1FBF;
        Tue, 12 Sep 2023 02:49:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOT8zoWMf6LDpUfAgTUrjJQouQRTPCDT/ZdQa7kYQJw2XbUYfWjvoOM8AcZ3RhoUQlyqPncIwtYx+FxD2r72DnYFgqmjyLqpQhqwl2739M3FG8PhfksUuefgPJrFJm1cvGh98xvCVx/eEchwb0KndxVHNuQ5qqNYTc/kJTbFJX297bJS23IwAunz/AK2OskHRNQuG0ve8+7dbdrQYR223c+Lc0MwcZuvLdi+GQ6OpAu/ogDLd60KGY5z7bfAYKrRSSDcyO8TpKLLx/MCxjyo35qlgXh1OnKkBxtxuDB155rNWTAVA15xFZcG6cFr3XNh2ETDEq2BqQUDgb9VvTgs9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LgT+/ItCgKV5iqqbKWGsCzs2Q6+PfD37ivhEOy1uiqA=;
 b=dJyoPcxqlO8YBrlzYTna3FugSsmW059m8xFXQPlRXiLJBfhJvMYiUg/KunYYhToABgk6Wk6gQ7Jqhp4BmFrIvTP6Dt+fBxO5p5EAVTiY6oEAkVfOzpELAhjlSGHkuf+P9Nsyo09MnYAB+e7ADHMlY3+EQnwSGC37//Rewjet0nSkX4VoGkRj747zM+8O05dddbPlc8poDJ1zSVODrC89WUSvpRfbAvICQCfLHfeSK++gggFopD7pvtec+AjIOFiTCQ5SRvwMRbAyTn8xgAiyG+iGzN/h8ZpA3NNzAjEwKFz0APOeZ3DJ7ddO5en0Bz/F17oAbi689rroeRYCZNQvsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgT+/ItCgKV5iqqbKWGsCzs2Q6+PfD37ivhEOy1uiqA=;
 b=jeV7tFmVaUHyw0TiXYk835RmTR/lxYh+/RfD1U/je4Zmb7OegeHSNw/CobPDLS+0H1uV5e9YiO0YTD5+JFfIe3/gB3PhezyGRJ0R6Bhyv+RpJGYnnmAwsr4YAfrjUoq2ZXsEVe5wkAYOqxoAPDFqucunVXL/Hx6VgZifLCqqmmBcaIhPtynFodKJlaAWxPiWnMbISXNNEsW6lqqFV4Ve6m/9wJZUO2GxJGUXbjRdRzBNGE05Q3oj9hjg+cEYRqYDH0U83ETI507TbcBsZKO+g/S3f4HkAkaTottv/aFCQOLM8ZSJrt6WFHWr2j7frbiKO/HUL3WQRi7smAd71OWLTQ==
Received: from ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:16b::5)
 by SY4P282MB2981.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:15c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 09:49:20 +0000
Received: from ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM
 ([fe80::68b4:6263:97f:9a45]) by ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM
 ([fe80::68b4:6263:97f:9a45%3]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 09:49:20 +0000
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
        Jinjian Song <songjinjian@hotmail.com>
Subject: [net-next v4 0/5] net: wwan: t7xx: fw flashing & coredump support
Date:   Tue, 12 Sep 2023 17:48:40 +0800
Message-ID: <ME3P282MB270323F98B97A1A98A50F8F7BBF1A@ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [4E+s4k5igPVx5aIXihXlFO4KD1GVXUjQ]
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:16b::5)
X-Microsoft-Original-Message-ID: <20230912094845.11233-1-songjinjian@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME3P282MB2703:EE_|SY4P282MB2981:EE_
X-MS-Office365-Filtering-Correlation-Id: 146171e8-d6c8-46a7-cdd1-08dbb3758908
X-MS-Exchange-SLBlob-MailProps: Cq7lScuPrnpsOnJ+52XDvCf+Wy6gy4fTHC4PqJt58PAsw6O11WL3Nr6hoKJ6uD9whsNBYEDp/eS/dmYumi9jayKscCU8i5rD+UiKMpdJb1/5HCwC5mVcwAdQbc0+mAulpyh754dvyjtcbPF4ggv9caUlwxCjd+btvPViW/r3a5D90fhFz1eTODlIgzjIKt1E//q0AvrUHAl4isDt/qJ56w/8KZ+pjKpA+OGqexWe8PmItSCZRXmcNraiMPs1XxIx55x0UFlB7pPEm9vWHoWAZD4H80AxF+Xs8IGUGnKivbaSDqt8g0FWW/aAJCXnxOOczz7Omm14CSB5dI3OZFcvo3lxzApQVYZvNdEEtKAXlDzwZAfZtwwaFdnyeJ2DsvkBAw1RpHciU0/qUyLn+qzWR7/BhCrpyyB8b/1v0I/BqYxkyflpJVJF6R/0GJFAADDM37bFDk69Pw6pOgiRkpZ7lUorVeENTS/xTn+CAn0BpPzP4FglOnFH7+V4VFo0Imn07oRSk5DENFZgXlf43MCcILzqnWzyjAJVdvrYvPRMStIz/oIuSuJCGgEJ4UDixCgibW2KQ4b8j1HBWmEnSyrDt+1Obg9w1Q+DltunhFCPxrjBrqDHnWA0HD1kavyd835uShZbUoB0Uo0Tc5XR+qTeRt56G1wn62XjPm06mrRgqztREVuITMPeWwUmdFDQ2Xv221cWXVGl2DnIXjjA/cA6C9GJ31fjPxqBjy/rSEjabNnqoP2B0aVwEtg4wVJLs5+dsyOt73IJpw8=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GUjSfdg4VB9TPjK8H4kS/X7F+2neR2mkEZ++me9wJiXEQ5wl5xpYFCzsgvdCDNy8/+1uP3Z8nLkfU9wAQCaHdh84Q50YnBbRZg331GerdBhgXzDTNililCMLjPLlSGLN1sAXOg3Zq/fEaC0+6djZj076/6SSHzJ20UbLuIXLJXd9wT4owZD+IRHX4slaa4V/bV+YY0rS+trAdZZsFX5Kc0ddrhYoHXxbysJ8OhNE2voShdm5ZcHP3CP1iAX4OYdWbLkyv3V733IhvyBqws+7nRJWlSRwXVRMHboJWRGrw+7IoljyrtirdkQD/1sXEsTyQkKaj88fyUzii4HzLtkyTl3jsBlZMKb5bOp7gEbKnOTfJAMAX2HgdByiQ13ZHdbFVX31InTnuZRUakRJ4UEVvQ9SY/n9YJjh0qn/zsGRgaK1YsGHmWke/cp3oodKhTdFmLFpjjSSgpklcldT7WyGKSYt/XZtGUh04HyBX3BlRpsXMsUHk6EtPwIL7HQYS8JQK9DFO8R+szBK3sUS8ZxUdLVvIm/uizn/w32D4s3mrL75HbNWqP9FO1L3Cz5gK3wCqt4+b3KwqyC8I+wrW4uJwnmsy9hq/po9tPftg1yjdYLWsysEMNh/keL6amk7iMaS
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gdZh71euaSNxv9gt9bmunB6FwwtHfMb52OUItg5yd1xc4CCFoM76anK7kr2H?=
 =?us-ascii?Q?L0O9SArKYT1lpUT8wl2k6VBICCaPO/gyGapGK6tQL8FVtIhnDlnqgg3Hxkf+?=
 =?us-ascii?Q?STW62hqUrVsHmzUeMXlmjbvBQCcZIuif5VJhEmBgIBHLZZ8nDBHF8rKz5Ixi?=
 =?us-ascii?Q?ov+X8NqpCFypw8KEzbkRN3a2v12mTnI7F7Sc6wbN42HrkS1GIqMOpW96fqWk?=
 =?us-ascii?Q?clMfcQBlEKsQTTQJUGa78fJ6ukpw2EZDWwv0+m2mWhGQPPgwH8MNPvGjPbRh?=
 =?us-ascii?Q?qf5x6HFq6vG54i9Bo+SEHcOK9owjj/ELRpqT0SPKX8wdrzSz/T4TlXVvQy33?=
 =?us-ascii?Q?vuGuToM2cmvdB9Krhyhm8kLUw4vVbpmf7vPJysC0OoyE7Et6w3oDan2NHfk6?=
 =?us-ascii?Q?QgSqFoLovzeG/ExO/ocodVMuCbSqazYZTzNmWWHgf0FrKrMcxYjl5G1OVQjp?=
 =?us-ascii?Q?rDZUYI2Jt5nEVfBqJV8obyXDt5x8pesZvTOOh1jCb/NuDOXAAjgPhVBllXFZ?=
 =?us-ascii?Q?vzw8Qeiqvl7OCHut7Dw8S0qiDG9Fpjw+s+tI+P3ipz46O4qjnGf6UsYqYsX2?=
 =?us-ascii?Q?/HJ7JlGjq1+7/FTD3ZGGjlrLLuY40orySouA6SEkPLf78R7Mtuf8O1scFkZ/?=
 =?us-ascii?Q?dbgZK/Qirs2BkYA5+DPVBbhto1XAbxOFVH+uqsYdd3qqiDEwAz334erLqlVF?=
 =?us-ascii?Q?CCsrwU7v5wx1ijGw3vt/J8gneftuTa/dne80F1emWordRHEae/RHEm2WYRE3?=
 =?us-ascii?Q?/cplEgPWHA28w8F1bg1+hFe+n0KTV2kI/1I6UqB5QhgXoleHehi12PdHDpYi?=
 =?us-ascii?Q?Kz6pqk+63bxL9jNPnDP4gkinvKOsYmgw/m6w5ToCnh1BZKPDyzaSvpya6Bop?=
 =?us-ascii?Q?gUXKSY4ER1mQNUFvNC+GdVvv9icsiFjUlHlW0wVUvCmQT5OkvmU8AU9x7r7T?=
 =?us-ascii?Q?nhTJe427yCqh0/TlYphLsDsXpShAmRO0iYuQVDBVVhZZSJIFi98mrRHF0rNa?=
 =?us-ascii?Q?1nMF+HNb0a+B5TdQRimTAOsVZX37dGa6yNvegXQ9gGEOjvrMkEf+XkKc1Tbp?=
 =?us-ascii?Q?GWHQ3yRnkFw30zxSk1Wwjnyn2SBjflJaIOkI8++H5yNiE55SgIEsTbkpQ1c4?=
 =?us-ascii?Q?mvNfny7s+yAO4HoOAXhCNhURlTyG4tsy/0Qc/fNK8c9k/ninmu9p85AlyWYT?=
 =?us-ascii?Q?A9sJ8MzMfNsZBVA0pBUe07jOxEzjZ2Kj/HwvTeyACJMlhETjUKekwTCOXfo?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 146171e8-d6c8-46a7-cdd1-08dbb3758908
X-MS-Exchange-CrossTenant-AuthSource: ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 09:49:20.0811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB2981
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for t7xx wwan device firmware flashing & coredump collection
using devlink.

On early detection of wwan device in fastboot mode driver sets up CLDMA0 HW
tx/rx queues for raw data transfer and then registers to devlink framework.
On user space application issuing command for firmware update the driver
sends fastboot flash command & firmware to program NAND.

In flashing procedure the fastboot command & response are exchanged between
driver and device. Once firmware flashing is success, user space application
get modem event by sysfs interface.

The devlink param fastboot is set to true via devlink param command.

$ devlink dev param set pci/0000:bdf name fastboot value 1 cmode driverinit

The wwan device is put into fastboot mode via devlink reload command, by
passing `driver_reinit`.

$ devlink dev reload pci/0000:$bdf action driver_reinit

Note: user space application get the fastboot download event of devcie
from /sys/bus/pci/devices/${bdf}/t7xx_event then do remove(echo 1 >
/sys/bus/pci/devices/${bdf}/remove) and rescan(echo 1 > /sys/bus/pci/rescan)
to let driver goes to firmware flash process.

Below is the devlink command usage for firmware flashing

$ devlink dev flash pci/$BDF file ABC.img component ABC

Note: ABC.img is the firmware to be programmed to "ABC" partition.

In case of coredump collection when wwan device encounters an exception
it reboots & stays in fastboot mode for coredump collection by host driver.
On detecting exception state driver collects the core dump, creates the
devlink region & reports an event to user space application for dump
collection. The user space application invokes devlink region read command
for dump collection.

Below are the devlink commands used for coredump collection.

$ devlink region new pci/$BDF/mr_dump
$ devlink region read pci/$BDF/mr_dump snapshot $ID address $ADD length $LEN
$ devlink region del pci/$BDF/mr_dump snapshot $ID

Upon completion of firmware flashing or coredump collection the wwan device
is reset to normal mode using devlink reload command, by passing `fw_activate`.

$ devlink dev reload pci/0000:$bdf action fw_activate

Note: user space application get the reset event of devcie
from /sys/bus/pci/devices/${bdf}/t7xx_event then do remove(echo 1 >
/sys/bus/pci/devices/${bdf}/remove) and rescan(echo 1 > /sys/bus/pci/rescan)
to let driver goes to normal process.

Jinjian Song (5):
  net: wwan: t7xx: Infrastructure for early port configuration
  net: wwan: t7xx: Register with devlink and implement firmware flashing
  net: wwan: t7xx: Creates region & snapshot for coredump log collection
  net: wwan: t7xx: Adds sysfs attribute of modem event
  net: wwan: t7xx: Devlink documentation

 Documentation/networking/devlink/index.rst   |   1 +
 Documentation/networking/devlink/t7xx.rst    | 232 +++++++
 drivers/net/wwan/Kconfig                     |   1 +
 drivers/net/wwan/t7xx/Makefile               |   4 +-
 drivers/net/wwan/t7xx/t7xx_hif_cldma.c       |  47 +-
 drivers/net/wwan/t7xx/t7xx_hif_cldma.h       |  18 +-
 drivers/net/wwan/t7xx/t7xx_modem_ops.c       |   5 +-
 drivers/net/wwan/t7xx/t7xx_pci.c             |  79 ++-
 drivers/net/wwan/t7xx/t7xx_pci.h             |  19 +
 drivers/net/wwan/t7xx/t7xx_port.h            |   6 +
 drivers/net/wwan/t7xx/t7xx_port_ap_msg.c     |  78 +++
 drivers/net/wwan/t7xx/t7xx_port_ap_msg.h     |  11 +
 drivers/net/wwan/t7xx/t7xx_port_flash_dump.c | 695 +++++++++++++++++++
 drivers/net/wwan/t7xx/t7xx_port_flash_dump.h |  85 +++
 drivers/net/wwan/t7xx/t7xx_port_proxy.c      | 118 +++-
 drivers/net/wwan/t7xx/t7xx_port_proxy.h      |  14 +
 drivers/net/wwan/t7xx/t7xx_port_wwan.c       |  27 +-
 drivers/net/wwan/t7xx/t7xx_reg.h             |  28 +-
 drivers/net/wwan/t7xx/t7xx_state_monitor.c   | 137 +++-
 drivers/net/wwan/t7xx/t7xx_state_monitor.h   |   1 +
 20 files changed, 1528 insertions(+), 78 deletions(-)
 create mode 100644 Documentation/networking/devlink/t7xx.rst
 create mode 100644 drivers/net/wwan/t7xx/t7xx_port_ap_msg.c
 create mode 100644 drivers/net/wwan/t7xx/t7xx_port_ap_msg.h
 create mode 100644 drivers/net/wwan/t7xx/t7xx_port_flash_dump.c
 create mode 100644 drivers/net/wwan/t7xx/t7xx_port_flash_dump.h

-- 
2.34.1

