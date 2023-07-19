Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46EEE7599DE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjGSPfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjGSPff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:35:35 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79293E43;
        Wed, 19 Jul 2023 08:35:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yk9U+XcdYYvb/gLGtWl0IerTv3s0J1vUSEOdr6TvRzVWTIsGF2yy+dch3TIyfWZxzZKbbiJVnJsBLzIUYwOH/4chgkC3HFEgC7WH/ijK7ONqpx4sWEd0RdFKtluhYWCeeUajDIrTWZmZJsz6fE9026RJcVXGG/z4XDN5X1aPLPiTK3zwkRYyRAp6hseOrycHonr1uoAZrrdD73FbsCnS7SRsOn73rLo6sTD/HzpIqRKmD9kN1+qHZT55c6lgT12vlXhn5RdRbiDqnATj0kw9c+dqxPpdxhTkFxAJmRxlToAqpD82sidlVpt+eG/SxDMjJMdK1ssVnP6+5I9TFev6Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hqXwYgt4QMLR+odi0pBx1EtX+Q35KwfC8ZWTiql7wM=;
 b=WA3SVGYnjjjaCyqj7nypcPR/w7QCCBgWINk8x9gZEtVz7ybt3ab6d6rAp+1oWqMiLeGzdGP/d8Ev1TMq1axf3sn7iWj/9dq/FWMKtBtj2p9Q7FwNYqJ+Gyjzeii9UyMOEo/iZofGRiy9bNpACpZs1R/zIKIrbZtKk7DECPATUxcQmUE23qdeUCmoaWfDW6xANM/qGSNVmY8GvtW62QEW1w4bEDniqOSeYAFlLf+04gQ14IJF17v/aC7fNAVhQLhiHHhcu57l6dcnHSS+Hk0wZCP5iK/kGLa7bw+m4qnPNLLeBAI2vt1Pphr+XQ/6GEViykCtqtCf315lyGIq7H8rFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=kernel.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hqXwYgt4QMLR+odi0pBx1EtX+Q35KwfC8ZWTiql7wM=;
 b=0GXn9lFTTxIQZI+5oVAJBz+b3jJxGc3trfiYycE90kaCEeiMhhTMASMQBIDe7SpyvgP0LqgFEHm6s7rN5AW0TjL5pbSnizjgvitM9qfqf/QXNbmUiQzLHmiQJOACdlrWg+znYF+btZWA+OkB1pXaJ9UR/R/AVLBvqyqwEykoqHe+5M/a+NgoM4MHdndEtd7GEOSNqmfBCS5GcaPY39yI4gYo1rQzbEa0AV00ofR8Vx0SxkTGd0yqaI6vZJdJF7TcvNZAXJIwJbPMT59sEOY37hz8M/DrPPKbARWed/Um+zz47SR6F54uCCEc0D6qSntgGVoQG8rAYR0HPZhETmKyVw==
Received: from FR3P281CA0001.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1d::10)
 by DB8PR10MB3800.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:167::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Wed, 19 Jul
 2023 15:35:31 +0000
Received: from VE1EUR01FT067.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:1d:cafe::9f) by FR3P281CA0001.outlook.office365.com
 (2603:10a6:d10:1d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24 via Frontend
 Transport; Wed, 19 Jul 2023 15:35:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 VE1EUR01FT067.mail.protection.outlook.com (10.152.3.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.24 via Frontend Transport; Wed, 19 Jul 2023 15:35:30 +0000
Received: from DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 19 Jul 2023 17:35:29 +0200
Received: from md1za8fc.ppmd.siemens.net (139.25.68.175) by
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 19 Jul 2023 17:35:29 +0200
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
Subject: [PATCH v2 0/3] platform/x86: move simatic drivers into subdir
Date:   Wed, 19 Jul 2023 17:35:15 +0200
Message-ID: <20230719153518.13073-1-henning.schild@siemens.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.68.175]
X-ClientProxiedBy: DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT067:EE_|DB8PR10MB3800:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c01e2dd-3664-4a7b-181c-08db886dc8f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yLxEYnEQCAVOWRFy7gyYcVAO0gIScYFRtK6DqNA6vgN3E8e+lVxQvIyf9qxGCmY7xeINOpFTpVZqTpwhVaZiLsUrpIm65z93FkiuiACUI/LtUrdUjFY8p9TCgkadj85whZvISvqHaDcusHxCLnxQXwci5McE6wIOGJVBfEb72jJq2u6B1DH2xoT5ceBVhUPHyzSArDcrYLidzdUKRgjr2EpHjeAyraTYawwYebWcySET2tIgUzr6HDftBA2kHyWF1IKUt9N3Jq96PIiTImCS7GuapnJ37/5UH89lDh4kWFFvdAypNFs8vzmaeC9VXfLE7erQADWoA6fhWDWX4xQgSfAOPbbvyyOIIlflGNrxTLKkEpvic5whh19xqkv+1ojatFsM9o46dEj/VY/DgAb/Fy5SiCtWGevKH2RJcON/5Vsz+YkkQ9OxXBlIZGRZCONe1BFNdQDwl3IYZdMh1xo+AUwi46NCoea15hQSuiY6NNbybXF2nfYJWPD9XSM6I+x2CJqis2UIpm2CP5ntUUuY14KXGm4BvfoSzrulDJKclFTb3nXnflzPkdZit9HfjrAR1QgLDWwyi6fGqbWjT3t40Tgloev2MinZbibm54Iqpf7jkK37PalfcPL8JlkB3CkzaSFpLWNuGzRqFKc/lDgHO68zLKbWPr4fYNQccMOz5LjWs539tExCzA17pHo1YccxRLcY9Nb4za+FkDZZozLTXv6WGC0ouO6vR3lPJY6wCBPLYhhNJc5kkOmFwvu83QL+XPmNgdr8IJmfWtNDwcIkws2KzQxTPt7Lqh9rE7VwzyI=
X-Forefront-Antispam-Report: CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(26005)(1076003)(186003)(107886003)(36756003)(83380400001)(47076005)(36860700001)(2616005)(86362001)(82740400003)(82960400001)(81166007)(356005)(956004)(40480700001)(40460700003)(336012)(16526019)(70206006)(70586007)(4326008)(316002)(8676002)(7416002)(8936002)(5660300002)(44832011)(41300700001)(2906002)(110136005)(54906003)(478600001)(6666004)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 15:35:30.6554
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c01e2dd-3664-4a7b-181c-08db886dc8f2
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT067.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3800
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

change since v1:
 - switch LED/wdt Kconfig to "default y"
 - remove guard which could hide whole siemens submenu, and default m

This series does two things. It builds up a Kconfig inheritance chain
for all platform device drivers, namely Watchdog and LED. And then it
puts all Siemens Simatic IPC drivers in the platform/x86/ directory in
a subdirectory called "siemens".

That is so that users have to flip less config switches, and to ease
maintenance.

Henning Schild (3):
  watchdog: make Siemens Simatic watchdog driver default on platform
  leds: simatic-ipc-leds: default config switch to platform switch
  platform/x86: Move all simatic ipc drivers to the subdirectory siemens

 drivers/leds/simple/Kconfig                   |  1 +
 drivers/platform/x86/Kconfig                  | 59 +----------------
 drivers/platform/x86/Makefile                 |  6 +-
 drivers/platform/x86/siemens/Kconfig          | 63 +++++++++++++++++++
 drivers/platform/x86/siemens/Makefile         | 11 ++++
 .../simatic-ipc-batt-apollolake.c             |  0
 .../simatic-ipc-batt-elkhartlake.c            |  0
 .../{ => siemens}/simatic-ipc-batt-f7188x.c   |  0
 .../x86/{ => siemens}/simatic-ipc-batt.c      |  0
 .../x86/{ => siemens}/simatic-ipc-batt.h      |  0
 .../platform/x86/{ => siemens}/simatic-ipc.c  |  0
 drivers/watchdog/Kconfig                      |  1 +
 12 files changed, 78 insertions(+), 63 deletions(-)
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

