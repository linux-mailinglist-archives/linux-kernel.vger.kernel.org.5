Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FB77F169D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 16:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234187AbjKTPCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 10:02:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234013AbjKTPCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 10:02:46 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2058.outbound.protection.outlook.com [40.107.6.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108661BE2;
        Mon, 20 Nov 2023 06:53:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYmfdSg2MzVlbL3iTKcy/XXncmXkLCq0cwp4qrUEx8PrKcvF8HYyMKQrwN2XLMMot9n30ExSCplAfdMSselefExo9ajJphkAa2jIexzt/kNTaCm28jJTgUuB1xWjiXgK2hCaZXsMvlQNxdi1ya2w4pF4sxPTCm5xW2GIfsXdjuvkEbb7mblr+053efmNEQ6x7pcHrZv9o0M/cE90F/G9ifgK/P3iNE1g2pQYfn+4IR3kfUsiRxRNdCAEZlisLz6IsI/LtptrKPcqd3l2SpaioM9iyCKuhczNalDMNmmcgdsrBBZa62+3bNNDkJm2cMGhK3JkyPgDRwU6uaaKYunUJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0fNGA9J90tFGTuWrZXjMluTc9UFJQzBbW3WxIz0iibg=;
 b=H7cxZpOEW3sVVr2EFzy6MCjbukpw5JWePmAMGhSQFCoSChoop5XjwFsqHxbD+ccA5V/ZFBgLfXVoEpJuwrByES2TZ6bIglPBsnpxt4tln1ahbj6iH+xTHYE91kBPfCcy35EWLRHrkxXNNXUIlhxeWkJTItSAR70IZBaBy3/K3VTqr/lZRpSyvSl2qppHl1sBSQ9nWqm4u56YOWaFwueoOCDHM3qmvCo+Gx/wUxww5gWs30j6+W6l612yI1ifFNn/d3LTDahCQwf2SMil5ELBikxKckk+zDsSoEttLmyZefhhE6Yc/oI38oWcvqYXJI4jlPnu1A8H6Ek7/tZfns2J0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fNGA9J90tFGTuWrZXjMluTc9UFJQzBbW3WxIz0iibg=;
 b=nNfmlff8HBDWOsaw979jNrca4O6g1EIeKk/ZBtzAYU4BQXaFwx5pj2le3ZTjtPOcAe9i96LrR8ON81GJ3eb1SQQHVjSUaNaDag4uFml67/adOnpLi3z+IQYzoKw+78UqK7jWjAah9FUczjwLR409uZ0avW3SviPvOcEiT/OPDLg=
Received: from AS9PR01CA0003.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:540::7) by AM9PR02MB6772.eurprd02.prod.outlook.com
 (2603:10a6:20b:2c4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 14:53:16 +0000
Received: from AMS0EPF000001A4.eurprd05.prod.outlook.com
 (2603:10a6:20b:540:cafe::41) by AS9PR01CA0003.outlook.office365.com
 (2603:10a6:20b:540::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27 via Frontend
 Transport; Mon, 20 Nov 2023 14:53:16 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF000001A4.mail.protection.outlook.com (10.167.16.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Mon, 20 Nov 2023 14:53:16 +0000
Received: from pc52311-2249 (10.0.5.60) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 20 Nov
 2023 15:53:15 +0100
User-agent: a.out
From:   Waqar Hameed <waqar.hameed@axis.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <kernel@axis.com>, <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 0/2] Add a driver for Epson RX8111 RTC
Date:   Mon, 20 Nov 2023 15:49:25 +0100
Message-ID: <cover.1700491765.git.waqar.hameed@axis.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A4:EE_|AM9PR02MB6772:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ba4b22d-6488-418e-c24a-08dbe9d86d97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aGIgirWqCNVAP/5AWgRBQLJTKhdbF+dz1j3mgSoXUhXVNfKiSyE/BRBN2MHR4R6+GwFrqFb+Z99abrUBU06EAswhNQjLThkfxCFfotd6Fu8dzZwtR/I6ArirsM+D8j8AiLP2KXuR9G1qivF60dXp7BTh82R5y/7chAAHxv4IhMNsZjoTWBB7p+EYxtEGyDHTC8NPjkcCDQgDyGuW6CQ86B0WtE9udCfSSjhebRXCFMaFHoRDNn4ml4W0qxeeSqfmVOCvcgjWWyDjC9p04rC3927c5Va+4ynZnbgB/4vag2Gq7dSM/Lkr3fLEsClvVKs3BDCoyvkhS87cjrA9+fziLpuJhPNkVptvNJ3UdvhgBknwA+nPbJymenVuMhpDYL70bdPJ649cXt2TCbVKEVKRN4OsVwmL1NoMIQOYWd1kEMlsNONCc2ON8c+aOQbA2ns4H4A7aVbcs55Ls0gIOic75OzcxYH5KfTJVvGFtKF1RnVQ7ndGDAOBVmt5qhsBwSyYmmQQjJniA/2gozjtUEDjYVV1OnTWu4XqdqL3PM/haxPaOuTM1TYB0zTNnnFnqQ6mqv1hI+OMlD4GUGd2GiNpoGAzCoZFnnGSjhH+ol3zNFFVB1qMT6+jze8PnVzu28CCYp1I21xmCBPwBg/BhCbCpO8pPIF+NQinzgUN8kBhyyekLNCVXbLI1Hs35XtSNhNd3W4gmkWKkB4Vt6L3+VgTl11BFHs1bGvkA4zmOs3rXNHoClCxFLDrDvPy0II94Em5
X-Forefront-Antispam-Report: CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(82310400011)(46966006)(36840700001)(40470700004)(2906002)(5660300002)(4326008)(8936002)(8676002)(36860700001)(40460700003)(82740400003)(86362001)(36756003)(16799955002)(41300700001)(81166007)(356005)(478600001)(54906003)(70586007)(70206006)(316002)(40480700001)(426003)(336012)(26005)(2616005)(16526019)(110136005)(966005)(83380400001)(47076005)(6666004)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 14:53:16.2833
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ba4b22d-6488-418e-c24a-08dbe9d86d97
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A4.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB6772
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this patch series we add a basic driver for Epson RX8111 RTC with
support for only reading/writing the time and the `ioctl`s `RTC_VL_READ`
and `RTC_VL_CLR`.

Datasheet: https://support.epson.biz/td/api/doc_check.php?dl=app_RX8111CE&lang=en

Changes in v3:
* Remove macro define `RX8111_DRV_NAME` for the driver name.
* Remove macro function `RX8111_TIME_BUF_IDX` and instead use the
  offsets as indices directly.
* Remove `rx8111_setup()` that disabled extended functionality and
  interrupts.
* Remove comments explaining register value conversions in
  `rx8111_read/set_time()`.
* Check/clear register flag XST (oscillation stoppage) in
  `rx8111_read/set_time()`.
* Change `vlval` to `unsigned int` in `rx8111_ioctl()`.
* Remove `case RTC_VL_CLR` in `rx8111_ioctl()`.
* Convert all `dev_err()` to `dev_dbg()`.
* Convert all `dev_err_probe()` to `dev_dbg()` in probe.
* Return without printing from `devm_rtc_register_device()` in probe.

Link to v2: https://lore.kernel.org/lkml/cover.1692699931.git.waqar.hameed@axis.com/

Changes in v2:
* Move dt-bindings to `trivial-rtc.yaml`.

Link to v1: https://lore.kernel.org/lkml/cover.1691158774.git.waqar.hameed@axis.com/

Waqar Hameed (2):
  dt-bindings: rtc: Add Epson RX8111
  rtc: Add driver for Epson RX8111

 .../devicetree/bindings/rtc/trivial-rtc.yaml  |   1 +
 drivers/rtc/Kconfig                           |  10 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-rx8111.c                      | 356 ++++++++++++++++++
 4 files changed, 368 insertions(+)
 create mode 100644 drivers/rtc/rtc-rx8111.c


base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
-- 
2.30.2

