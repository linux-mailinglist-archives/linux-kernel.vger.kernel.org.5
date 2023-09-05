Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228E1792BAD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346452AbjIEQ4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354412AbjIEL10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 07:27:26 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2174.outbound.protection.outlook.com [40.92.62.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3121BE;
        Tue,  5 Sep 2023 04:27:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFXjT1l/YT3oFX7gtyQvmUtCu72D1W0/i5pGPokDUgA40lWvWAHcGZgnI7R/QsOrYFULRg/4y9EmnZex574NPV6R14MHVPoX+pawIA/iMdxTWTC/ww0NNCOFaBDcSO+1g9lXnqEii7r7CYkBkJdeha8RE2SjzX7jABbMZAE/ToeHLl8U3RCmo1OERQRZlUnUq5KKMhgvx4yQYjy2HHEtmIPyI8kGjpdhsjY4WVCupfdke0LcOLaOJCdVGdqTmOS1HKW0ONajsk+f9MXI+M9QMN5rvE1oOGtfiowxLLOeUuDiwTdAuubo5tMC8H4/yMWju6Z6Z3S5Sv2wHIJTQjw7Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LgT+/ItCgKV5iqqbKWGsCzs2Q6+PfD37ivhEOy1uiqA=;
 b=DYkEYhpoLhwtBBLzI3lUzCOb2WXjylc6/cMWPcjwA8jJobGUWGM9ASNUAfdxv8C2KUreo1tiXPfGHU9jNRipa9TQkwgPdRSjfxGIRTKrinQAGk3rm03smNSm0hoOp9SmgIVk7NsSj1b9BE432c0t2X3bwdIa3o4njU5iulKGrW6v9R1aWRzg1k2rRzc0aSv0y0HJy58OHltTcvDnjA+oyShelzSDIHc42OZnSsHdJrNvQOSU7T4U8h9gPIe4yYgG1uPmG0jOkDZ3752AIOCXEucAVZz6ZFZWyJ/pFS8oqYiU+J6OxyE/DD0/M+M8vDLzg1KTMj1bRv5sUbjN+hIAIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgT+/ItCgKV5iqqbKWGsCzs2Q6+PfD37ivhEOy1uiqA=;
 b=N+2RstP3JaJLm0phLvE+9ThraupngBiCJCZ5Vh6Xx5t/IpwfV7x3IA3kUl8BFRWqohHQ8+0uflCmmk69J0Fuo4x7F4zK9nFWdZNhvkoeq3el2b663N9DOmmt++tarA/rIHOdrmGwCBbDY0ZVggl/1F/e+RdCbzoSX6W14fDShyO0LAcQlUgbZn5YREt94vZpIkLaXkfC8qXMjOefF+tZ/fkvLzvTWX22mkVD1o9QoXYFNfKiERPp7ScAlA6MeOUqJ4oll3j5XDzknYYG6z2DmjIdbi9GUPIAdb43S5IDXo0lUNMwxbZKzkY7QvGU9aZwR14p8rx8cYipS3mziroJpQ==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by SY6P282MB3213.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:164::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 11:27:14 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::beb:8e33:17b1:a347]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::beb:8e33:17b1:a347%4]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 11:27:13 +0000
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
Subject: [net-next v3 0/5] net: wwan: t7xx: fw flashing & coredump support
Date:   Tue,  5 Sep 2023 19:26:32 +0800
Message-ID: <MEYP282MB2697DB3C2C854F72A78BE7F4BBE8A@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [pnkax81OKd+/ZQkHPwuJyHYSzva5LGyj]
X-ClientProxiedBy: SGAP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::18)
 To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID: <20230905112637.18877-1-songjinjian@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|SY6P282MB3213:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b38c148-ea4a-4956-d141-08dbae030d36
X-MS-Exchange-SLBlob-MailProps: 0wLWl8rLpvtTivgWW+sCOa5Ki5B5X387drGJ7Jcymve7vktlkPrU1QZhxi6KEdEcB1YLh5FQXFXSt8+y9Lsi5EW69O7HXOZm2L7ZZNUvQQFWxESpNMaps/jAiHTyv5tmvj5gr46UhObgvQ15C2mtVTxDuJBPSBklgYM1bpl/XGRVHY/xFDA1+8EUjZlWxO24E9jTkibBKeOc0zeGqKdXTFzFccSSu7gLD84wucWxTW2vxpHl/IeqkNVTQX9RQa/bcoJw4rNPi6CXOU9ciAYZILJaQRo8drMrq36MrCY5JiQyIYNElrFyo3j3cLpGq0b7GFz1rvqTO8BXVuHgCdMyqj7so9/CTaJKmCN+2IOsnswrKGBN7P7M0d+7dQIWJCwJjRVUgUyppo8ppAwO/PkjSp8CiK4Yo6bqoJk24GKo0VGgi3QTa7cW7eGDT8Vz0fB705c6rihgZ/9vN+8gOMmd52u3O97pWgjFKHe2pVm7WTp0Oxlr1HFtPjI5wXv2i2IkZOaD5c/ExWlV01EdyJoWOLXRxVFh+Y4yxMM2MuCRUpdAv/wlESgSA8SjJivTj6oj/6TNCFo5RM4YrzmF/fJ69xnShy6qrIY6Kh7Ar6r7fTDYuqQkuI0phl7AywX5KDeCIKwLeUhT9kLN75j+vTuyXgBCbvGq7Mm2AcoP3NwRaUkSl64fST9Z7RaOSyaR23YWu8gSie4+XsIAdraHZe/nDN04pJvcnTuLF7kaa0mSofbc0bue3coFCUgMUPTcpvfXdvSJs8Eyblg=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bRS2U2DzhlgIaiLhzXrRvZaM7prP8o+N8xi/vxPIjYWQWBEnwihYlW9RPhDxMuGeind5Bokdl2iTu+Czqy2EnuKB3g5xAW/PJBa3APoyt99rcV/ArjCeui1Ej442UqPZIQ131pHjEvEZiJ4YjLDQZI20R9+yeRveadJTqzQ6Rb1cVwmDPwQKM2CPiJnkd6CPdJtPNWXcILT2Qu/KxtWgCYmg9kqtU85yGE1ZhFEmYrzqDxQcE/6U96v1SoZu+Mgdgxv3Ks7zmE1qp0A4NFVZSKge4B2g9dytTdjr4LYr9p5pd94fqz4h1Dv9C8evWb+VJxoi0bpLwUW/bvBru+DN+qgYhLH0cTTS0IHwjAvQYgdINj8fSDzeOC9Ch/Irx+KLUDhTAn0abX8HewNX8j9Jci78ETVXLd4NIA6R5SETq5VzAaqv/anL6IJpa7k/E++Dd0pXU9KZi2Oyf6Usw6UYkwrr5IwDLKy9dZ/KyOqSpMtKRboXXgSuSP/EQb4AMncOj79+o+Am+f2lcNCDA55ISEgTj5Y29ORqMcAYbs4d9qmS/qvZbU0VTW1NgejSfzXYF6mXVtoRvvgKCuVhxbp2qbG9nD3eae0Vjbriyf5fUoYh0AlznEXzESBJe5h0R6Gw
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pQ9PgG51kVtm81qmPCyPOGgwFUo5h2Fb/G+By6ntKFGt9ilayBhUIks1Qla3?=
 =?us-ascii?Q?k1eCMDQHwXlB/z8jqrSPygReVQ289jWerTIa17m1Lpax+aDUwWcIPZ+kRZJM?=
 =?us-ascii?Q?W4ctSDomJG1JQoSBiTP+WqiscYlXo5Ldx+yJ7EWFqL2Jy/iX133sP4mCR4cj?=
 =?us-ascii?Q?FSPCMwmoqvFUuL/x4kLQZD4ziwDNkfF3wxv08NJLKliE3B5gOkz0P4u0EIC1?=
 =?us-ascii?Q?PsA2dCa2Uy2UgV/ljTnfGKlD0+inyI0Nl91X8YTUjCOn4zC/QDQPAFjerlRm?=
 =?us-ascii?Q?Ip/j6En37ullVCGCrETUaZBpevcrLaSloEpZXbPzZTf5B65vNtS9gzbUVFiK?=
 =?us-ascii?Q?mOpr86D+ZNxWyv3Kc2yqqdRUXAKNtIWZtRqQHQvt1IPzNKD15PP6fzkJhqTT?=
 =?us-ascii?Q?NO/cKh2j81wg7q6909lEfIBXlzduRfhpVLnPatkfDK52LeFFNJGpvy2l3OB/?=
 =?us-ascii?Q?Tf0DAmYW8dK1DxLJDaUD1oMvUC3BleB/qTWz9inzK0nHCbkvuNoLNlvHIqfE?=
 =?us-ascii?Q?gQ7P91+tUCxoBBbdR+oKohMiWyRqqThE8zB1/Bw+eEKWmxPOSD78gnD086m6?=
 =?us-ascii?Q?LeAu9RBnzsXgqf8IZY3uNU9RKYNtjbA/EMZyEsbNzG2IsEUhWUOVWNUQn+3W?=
 =?us-ascii?Q?KfgyoaPYR3f6IIjTELIpJpUBwkUdfjpJ2l5z6zdBGnmjfHcM6gLDNKO1KhqS?=
 =?us-ascii?Q?ixCEsovhs0OwEk5CFP20xkpk9mu7lCbg/SgixvMnXPoICoAqD8ZJZe/Scws0?=
 =?us-ascii?Q?M9k9Z0FP8gcKPmWWHj2dgvpESbrZnj2pRIxfAs0rbc99RsOv01hCK1BIqJEN?=
 =?us-ascii?Q?VvkzBqG0o9zEhoCMcAONjJo2NIUGmXigm77uc3X0aV2Qpd97D8cqfCzIZcGO?=
 =?us-ascii?Q?RWEgH0OkyKAetcsa8x8z/gmT5o2Dz77N+5kBLfx1zZBZuVkysp6NHsol9KqF?=
 =?us-ascii?Q?w6Be5eEuAPuTvpNeGmOT5mcIa8mEKG0CxRtIWI8CkVyyxP7rfWp1ghGViowT?=
 =?us-ascii?Q?EXJFt9SyjqidGEg5nfZ6gIAt6TUP9Fm/ZkiAnV2wPr871ndyfKzXKLDtj6t3?=
 =?us-ascii?Q?Qsm402SagV4JK5O4CWsH1E+oNvwIwI7IMmnLWWbIuWobZpWUEmeZ8Iv+SBI7?=
 =?us-ascii?Q?IauY4waipvSKA3Tyiy/59+5HkHFz55vn8UOKSkYSgEIWbB4MsTeYf7tH9EIC?=
 =?us-ascii?Q?GhXXH2u8ZapDG37TPeKttG70ej2r/EXHUyxkuECFQMbBm7AKLqemclbFM2w?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b38c148-ea4a-4956-d141-08dbae030d36
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 11:27:13.8625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY6P282MB3213
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

