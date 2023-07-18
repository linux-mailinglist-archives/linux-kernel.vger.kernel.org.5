Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125FF7579A3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 12:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjGRKwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 06:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjGRKwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 06:52:30 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2056.outbound.protection.outlook.com [40.107.241.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33C9E43;
        Tue, 18 Jul 2023 03:52:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSG3c3D+E+h1oTHh8cV2GKS8XqhfA6eN4pIm1qAghxZ03jr/YlweNd/d+5V+04DAZde3ohMCrt4K6ogYtR0PghYdSENiiASJJc7d5yM7Urd+FuPy7SRRgc3O6zpShPhqGHLjgbe6eLuenrkWTUzggyYu5twPY9QOil05SK6t5sMHuEES3mKYtngd2uzZWaZWU6JQDDznxzOaeGwgPhbYBlWoPYCAZuk+4hO01/ZDj2RJwd4dXNACOwqSn5ALdE3xWBxOG60EMZybNtf/PG37LX3JYIcMiC/9KM3CtmykYK28k8vs9hLTvs4zmJ2QodkViYzBUwpebwg+SSDhM+Dg7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+dAzglP96A13C3v7/s8KLnceIOBujvE9nkmsvdQ6wl0=;
 b=LU7k6Ai9d9hRN0lmkftyXbIrrmqr3yE7oWOQbo0Ri7/uh9WsJg/sOOJlLb7KLe2oW0wQpBPiMLPDW5ynFaj0C/BUsLPlD3faxbJ1EUG/ojXx1l9wZ/N90/kJsBR5i4/4qs7XwuNNfIp+ANRIaSqwvAuAplPyN/EUpGaH/7n3N9l9qzFK2Or2Ut3YMuaYEgv08n/9QfplWTPrbJMDodFdf5e963kdDbcS7bWYrgOS6Pa+ISPOX8h5SxAa/49IjPUQz7p3OOZ+k+2L4vDLBv33jY/X/g/0CFRXFYAV5efj99tHWTGAeOnc7P1rrXWMoUsULcpfCFCjs3lzPH19BC1qDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=kernel.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+dAzglP96A13C3v7/s8KLnceIOBujvE9nkmsvdQ6wl0=;
 b=gEiJdYH5uvNxI8ZcVgIbw/I6tFxUEIrPUdfAQQ2mr4/GXEikAr1YdAFmJQu/IUf7EKT+F3eqp6ZZYrg8G/xg3mSeFh0RN72BW4pGK1/oImDNwmmP3cspLdhZgx2oumc5uqNo2w26vDBTlHHGmVRzYhJxkQQeQg+6rc3+riaZh4tL1KL/dapPLyrCwA2UnZ1E4Zk6oIGPe4O9ZZp+ybNo3ReGawh1FdpPvU+LEdMsfjRajy1CHTELUp/x9F7yeLWAuwNdJ4fhGm95ygQPJgTTGS9rewuQQeGTjH8Om6D9I+yMPuiVMlIIsw/lwE7MHPSt2uf0OUDXVRpQes9q/65C3g==
Received: from DU2P250CA0001.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::6) by
 AS8PR10MB5806.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:509::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.33; Tue, 18 Jul 2023 10:52:26 +0000
Received: from DB5EUR01FT050.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:231:cafe::e3) by DU2P250CA0001.outlook.office365.com
 (2603:10a6:10:231::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Tue, 18 Jul 2023 10:52:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 DB5EUR01FT050.mail.protection.outlook.com (10.152.5.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.23 via Frontend Transport; Tue, 18 Jul 2023 10:52:26 +0000
Received: from DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 18 Jul 2023 12:52:24 +0200
Received: from md1za8fc.ppmd.siemens.net (139.25.68.216) by
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 18 Jul 2023 12:52:24 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Lee Jones <lee@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        "Wim Van Sebroeck" <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>
CC:     Pavel Machek <pavel@ucw.cz>, Mark Gross <markgross@kernel.org>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Tobias Schaffner <tobias.schaffner@siemens.com>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH 0/3] platform/x86: move simatic ipc drivers into subdir
Date:   Tue, 18 Jul 2023 12:52:10 +0200
Message-ID: <20230718105213.1275-1-henning.schild@siemens.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.68.216]
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT050:EE_|AS8PR10MB5806:EE_
X-MS-Office365-Filtering-Correlation-Id: e5a476ff-ce8f-4048-35f8-08db877d12f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tCEg8tKH61idSTGaRDNmCGKGjaGc93b5T91Rbi/ezdCyg1nlunYhd6op+KHkt7quoHIt3tw3vwQHaWDl3zi8BzV+usA3QzSW17rGisJ2FRDW0m8uyT7dou8FFGrnYvDbiXY+v1sF6TB8LPiH6WsYqFB5rbjuNeXMl2zrJsSX4LWfGs0E0h9rNO53qIBDIOPBHju+epLr52XA10vQDccZ2GaqJndJ6siDm8pUtWqWjKedaA4G0KvrU/ozYd/fnXfu2zCPR7wdST5rmWiyfAiod6rF7EXEAC/H4xj2E8xppYg6sVS534gwu5kB6CvwRsaFK/qPvjS9yVkrmwrFLzMKSi7B43wXH+Fasgr1MZ8j19hOM4smNTACYwCF48Uwn8BM8EEeVjq9Sr+UQPs7ugb8mxg2/WnsrEd8/ZV8iTwx52nhG95Rzaj1AMHVOicV2kBZ+yTEcCwJuM4FUuUPGKV64fMp+wHrvNuJFnpVUD10Ua1sCW64l+zdZuXK7uLSMtSTCiiFljJ0PWKT1qvpkSVNn8GC1bNqrv7yRG+sKZYEY8oucm+cQEIJhsceR2IofJSl+0KHyt0GD3Ht0oJhbahDgxf5bCBPqheJCljYy9U8AX0ryP1lRn3A0b8vZPXL1ozL5e4/MSAoGUS9B4VcTVWjWkR4VPEZFRYIyxK8dxSD7HeHX06iDkI5CAsIpnG19VXaoZ/LHnLXyk1vTYVdYTo05Ccq5h/Z2rcC2/z3VrUXLJNyt/xPX+J6GfsX55k+hTlj5o7LgQMq4jAO4pvMFmODALhOt2thtRMvdD1a9yR4ySw=
X-Forefront-Antispam-Report: CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(136003)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(47076005)(36860700001)(2616005)(956004)(83380400001)(4326008)(40480700001)(70206006)(70586007)(316002)(6666004)(110136005)(54906003)(16526019)(186003)(336012)(478600001)(1076003)(26005)(107886003)(2906002)(36756003)(40460700003)(86362001)(41300700001)(81166007)(356005)(82960400001)(82740400003)(5660300002)(8676002)(8936002)(7416002)(44832011)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 10:52:26.1194
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a476ff-ce8f-4048-35f8-08db877d12f8
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT050.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB5806
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series does two things. It builds up a Kconfig inheritance chain
for all platform device drivers, namely Watchdog and LED. And then it
puts all Siemens Simatic IPC drivers in the platform/x86/ directory in
a subdirectory called "siemens". Where we create a new Kconfig item to
allow users to centrally enable support for Siemens devices, which will
pull in the rest.

Henning Schild (3):
  watchdog: make Siemens Simatic watchdog driver default on platform
  leds: simatic-ipc-leds: default config switch to platform switch
  platform/x86: Move all simatic ipc drivers to the subdirectory siemens

 drivers/leds/simple/Kconfig                   |  1 +
 drivers/platform/x86/Kconfig                  | 59 +-------------
 drivers/platform/x86/Makefile                 |  6 +-
 drivers/platform/x86/siemens/Kconfig          | 77 +++++++++++++++++++
 drivers/platform/x86/siemens/Makefile         | 11 +++
 .../simatic-ipc-batt-apollolake.c             |  0
 .../simatic-ipc-batt-elkhartlake.c            |  0
 .../{ => siemens}/simatic-ipc-batt-f7188x.c   |  0
 .../x86/{ => siemens}/simatic-ipc-batt.c      |  0
 .../x86/{ => siemens}/simatic-ipc-batt.h      |  0
 .../platform/x86/{ => siemens}/simatic-ipc.c  |  0
 drivers/watchdog/Kconfig                      |  1 +
 12 files changed, 92 insertions(+), 63 deletions(-)
 create mode 100644 drivers/platform/x86/siemens/Kconfig
 create mode 100644 drivers/platform/x86/siemens/Makefile
 rename drivers/platform/x86/{ => siemens}/simatic-ipc-batt-apollolake.c (100%)
 rename drivers/platform/x86/{ => siemens}/simatic-ipc-batt-elkhartlake.c (100%)
 rename drivers/platform/x86/{ => siemens}/simatic-ipc-batt-f7188x.c (100%)
 rename drivers/platform/x86/{ => siemens}/simatic-ipc-batt.c (100%)
 rename drivers/platform/x86/{ => siemens}/simatic-ipc-batt.h (100%)
 rename drivers/platform/x86/{ => siemens}/simatic-ipc.c (100%)

-- 
2.41.0

