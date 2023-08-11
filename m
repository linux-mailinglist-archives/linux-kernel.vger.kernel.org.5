Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE6C778BEE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbjHKKXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235816AbjHKKXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:23:04 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2077.outbound.protection.outlook.com [40.107.249.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3661030DB;
        Fri, 11 Aug 2023 03:12:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXWyJMgwo9WB0XoD8ptu0cDtROApxWdILSMhwXnt27Jlahp01i8rtH/qNOFdyNcp9kSYQZbj/rB6mguPFpFEPEPkw0313gc0oWs3CFSxXTwCN3XSp/V6Tw6aYQDTqSOJUMA0qyXAW3CbjQbG16b+OdJum4TrWhqK/0A+AhvdIqoDwKLWPKhAytJLqBdI97z7e1UaycyQ0nPcEEEBvhEntAM5fXQ3kV5LJOqYYiHQCIg0/E0PH3xKs45UeDe3+wzqrgos5CtLC7EfiJyATwFKLB/cy7rPy76WpRBHlbFcD1wCaFJJsa5z0Rq8GUkTfCoYXn0FwcKOxxMumbR4mxmyNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKqPWFLx5KjmQfnX3nZLItKtG4rt/X78yTdte3gfTQQ=;
 b=nCPkPenzIYFfMeUZuBKwxA0SD0YBuE5b2Jm8jgni0EBK+YwhQKDlKYmz7DVjvlY/4FZMm1cTJsKKhvRDanFmIwnctOtUipBawP8lZ56rm308ppv5lgnhX+LETtxx9p8EDxnbP1L0tSQ6A4KvoILNI8U2qsAS7qedKBAEgvfxiZ+T6OizznoLjh1z6+/kZXwE+O/4ePdKETVm7p2aQZLip/JNAMQyf8BR77G6MBSioj4fyyReEbrbabi9s82l+2Gf3GqdwKgSePW+B4RN2K/GIHdMY1wpfoPFBMoj885kG8FuGPKdxXrxeXcJUaAthKrOVsn4OTFMu04sH7TTBSe3Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKqPWFLx5KjmQfnX3nZLItKtG4rt/X78yTdte3gfTQQ=;
 b=nlYolAHhTl+IX4GjtU4BAhV1mafLyrnvrXbNKA+sSnpPlucfkL0cfXvvs5QkE1v4/CkVWGMPNB0hQCDljMZzsraoh7XSpz3yrUhVRQN088rLHQNRhZrUx6om+YDHxGk+PYb3el8Hb0mM3UBbTTwp9BYrb2h34BNZtPDsjuSvKSw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com (2603:10a6:20b:43a::10)
 by PAXPR04MB8441.eurprd04.prod.outlook.com (2603:10a6:102:1d8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 10:12:09 +0000
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::7504:9897:4e5d:df25]) by AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::7504:9897:4e5d:df25%4]) with mapi id 15.20.6678.019; Fri, 11 Aug 2023
 10:12:09 +0000
From:   Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        amitkumar.karwar@nxp.com, rohit.fule@nxp.com, sherry.sun@nxp.com
Cc:     neeraj.sanjaykale@nxp.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Bluetooth: btnxpuart: Add support for IW624 chipset
Date:   Fri, 11 Aug 2023 15:42:30 +0530
Message-Id: <20230811101232.844769-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0010.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::13) To AM9PR04MB8603.eurprd04.prod.outlook.com
 (2603:10a6:20b:43a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8603:EE_|PAXPR04MB8441:EE_
X-MS-Office365-Filtering-Correlation-Id: bd5c5ab2-cb9c-4276-f3d8-08db9a536c19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d4ipYVquEvVloRiDD8b19Gp6jskEYowwIUNNO6/MCwgvkJtfQ2MP8IKYGhwWLx6al5M/yfd2PkdPWhfWegMnN+udfJqOoR8itzv/NKYIK+VptrV+ECCRYeIQ4waxBDld8R0EqPc4F5ewg9pXErBwKQyzmw3SPbelrXrSX5yemcY//cA2HdX3oGNOr1tv8g65W4WLmzM1szXx63PhGBH4R+aAFFCYmfOGw6QOl0YkxNIwLAPgvuT3QXY3XvHz7yhEUgioepBJ4j1xuSGnKD1+L20GQQXyozATROfgzrAdmDUo5oi4ZZ/jzRWYDc07SStS9Md0FumOV02IX9NuSbjJ8tdJ/WnUDEx2B0mJAaSdpyrIi0aTyLOkaFRn5/n1p9eLwKEL1zH76q9iyQpoDq/DlTOzAJehmA2aTx5O59lcIlZA2WadwhkD+qia8BjX04gAqrc2VKTIAHoXyKQzdllWvXnxoP42a4clcsDyCO1AhaR8e3Vdih4bhn07MgSRfty++mVTz01jO3ABizd2uDwIZ5Z20Hz2UOJHBGMDnkKwjn9x0XgY1Uau4FOoOp/ZcmkFRdd74qVcp4O5QvEMk9jGRHJjjimPb/DSe6DFG/EmlEPXuIRRhjYAuNdgf2zdsWGr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8603.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(39860400002)(376002)(346002)(186006)(451199021)(1800799006)(6666004)(4744005)(83380400001)(2616005)(2906002)(478600001)(41300700001)(6512007)(26005)(316002)(1076003)(4326008)(6506007)(36756003)(66946007)(66556008)(66476007)(6636002)(38350700002)(38100700002)(52116002)(86362001)(8676002)(8936002)(5660300002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gdqlbO6cNfpsOZIK51EPyuc5JIDDL5qUTO4WKys3T+qBxGH1/Ei2yoq7tsix?=
 =?us-ascii?Q?MlN2S0dUYNSW6HxFnqYMaERweQc83/V21lce4EiprGy80AQKeP8LMNrdRxh3?=
 =?us-ascii?Q?01Fe8vg4L5IcQGaDOQ9C9BmcRMFryG6jT5fD+/IuOFCmcU7OzTBdJmnMn760?=
 =?us-ascii?Q?MKtv8R1qHGIKeDlYZYcLZ+xmHGO2ecnAayJW2GIo5U/A4TNshmmRcXREM5Db?=
 =?us-ascii?Q?Jz0vFRQ6zqi8bSzCuzMLECmI9Ce3KixswPjVvSxskxvVh32NzD4C8lDPUrux?=
 =?us-ascii?Q?lBYWcHClNaGdtwAPYRNNhmm950meEft7EYlaaQ4H6Ei3JzIUD4MZ1k1oeWQl?=
 =?us-ascii?Q?Rndpy3X+q29qdSCGJ4brcenTQ5LRUmM7w97tFeOqzmRsQmbvBkoJvm1AhVcy?=
 =?us-ascii?Q?qUis2QurOK58kyHPpd9C8AKbiaZUbzt6F1Tz7vwfGfLFfkCXRVVKWk1edBJa?=
 =?us-ascii?Q?6o/EFl2EpO7Sm8rsR+F1Xc7sqfZgRAOl0LGOTwIMCI5HnmtpSZIHf+xCOp43?=
 =?us-ascii?Q?mT4h1XZ+F2vcMRgUo9V/k+66BCMoMM+xq0/QeplMGuQQ9n1VDqgz0zF5ia2q?=
 =?us-ascii?Q?76GHhEhM3HNrgFDT4qAcf8CYQEU1PfP3vu3R/WksWJNGtywHjK139v04gnin?=
 =?us-ascii?Q?jJ9/mSqEIDEesV+LdzrUIPn4rKUAHA+uEfcNEf2cYm2xw6yNqwCI3LlotpEo?=
 =?us-ascii?Q?Wr/MMqcubO64oj/mFPnpQrtnmhGHQGhP7v89f1CwNB/51CttN6vasyHAQEWM?=
 =?us-ascii?Q?DnkX7XYUSDrWROdJWcOYdvxETBmbtjL+4GPltbE99YKaKjEy3yq7B8x0+Wmt?=
 =?us-ascii?Q?qyuke3AaqTb0wEno6eu/P3p+xadN7w1Gf6g7iXRlFrgMEulrd/VUcDDXNFUO?=
 =?us-ascii?Q?rzzV2M0tRffScyiXUN2t5eHZdPwLk4TJbelcwHRUtKpLyp1PAC2U1vxjw5zW?=
 =?us-ascii?Q?CgqIjfNa3aI+scfZdJ86YzUXoPPlNBqcPfzmFf7fgVuAOJdt25b9SqTdEucZ?=
 =?us-ascii?Q?d2igGGLbAjhNW8pPstpGRquZ+eC49ZnHebEe9Kgr4tCNb63UjkOEbTa3qEu9?=
 =?us-ascii?Q?9MxXipqmb1fgodQiGvDKHV4WYO4idSkVmDMGYXjoxy+pGoNl3VxZyA7tRtVj?=
 =?us-ascii?Q?l/5u3O5x3N3sbTo4On5XoBL6hrknkaKW/k8dOF73CwMaOkOPR7K5MFpaRpJy?=
 =?us-ascii?Q?WRVv2lcMXTOQzr8Qy7kIm/NfzXQXq0hP2QbxcZCfwzY8thrzTV3t32DE6yzd?=
 =?us-ascii?Q?BpdX7Pazv4pMlgl5MoPWqzX2Apw31D/6+yTj8xrYUs4grREh0VQWS0uzutyb?=
 =?us-ascii?Q?XiYlalekQnB6/j/Wo8LpgZe+/7lkrBTOqjv+PPhq7IlERjJB4AuHa80Utpol?=
 =?us-ascii?Q?O/2y/0Yh+nSwnN8efZ+bmSZi92pwwJxXxwArXVR2YEisG8dcAgNqBehQMQJF?=
 =?us-ascii?Q?gVEgObNB3sKVPuZf1dczTLxTC1wICCHSqYc3+tACMc/NCPuhmPGmxrNe0/V9?=
 =?us-ascii?Q?8z54DkYEIUG5kACYokmjChY4vH7PS1baWLiB6/SBrFxujqZV3IzaSIZE8iEj?=
 =?us-ascii?Q?mJT7oKL6lVbGqC3X2/hIBJIjfAcFeDugK7ATAIs/YRNxWJ008yi0/CU2+ur+?=
 =?us-ascii?Q?7Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd5c5ab2-cb9c-4276-f3d8-08db9a536c19
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8603.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 10:12:09.2975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ETou5CwunKIKCsjYrd5SZEA9UjjztOHMVwm8ob86MkD0Ho7W8dnu978MMgXnmAW7OrADGxw4iUB5ei15X+yeQ6brOIrYDBAtukr1kOSgdCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8441
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for IW624 in btnxpuart driver.

The first patch removes check for CTS low after FW downloaded as
it was found to be redundant. It increases the delay from 1000msec
to 1200msec after FW download as IW624 requires more time to complete
FW initialization.

The second patch adds bootloader signatures and FW file names for
IW624 chip in btnxpuart.

Neeraj Sanjay Kale (2):
  Bluetooth: btnxpuart: Remove check for CTS low after FW download
  Bluetooth: btnxpuart: Add support for IW624 chipset

 drivers/bluetooth/btnxpuart.c | 44 ++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 13 deletions(-)

-- 
2.34.1

