Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A7E7DC7C4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 08:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjJaH6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 03:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbjJaH6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 03:58:22 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01hn2247.outbound.protection.outlook.com [52.100.0.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7276010D;
        Tue, 31 Oct 2023 00:58:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZfHZ/tuUSk4VLQuf+MoIvP/K2hhDdHz8HjJP3yGmeO9J463ogfpF1hQdu7y3MEEH/mNrTd7mcoH8P66727+qyugVUSYqRk6b45fGyV2bNEx+Amf+DQfqVBKBrtLQ4xuoNw/PS1pT3uqd5nQnGrSpqFQe4ond3KtGMp90ptGbrWO/PsA50bL0kpRwIBq41if0Wc97O2q1cQVYpL2hML760w3613Ys6lVe4IwquoUGrKUb2FpOAvMvr/piUF7Q5cfjdrUqecY9bVljareubsQfSEyMZ7ODcSidZzmI1tYg4qL7bfqLHKGOfSVUeTCwBh3UdnVa+96luo9utdSBFId1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDpjdoW9MHtdw/NXIlzbyGSj9RbMxxSnuk4poM4+aTo=;
 b=kpvjf98ALs+cOEcCFsMo1zA196VrEUsY8rYmlRRMvDUCODpGKfXElrU6Wf/VZTHdYU6hQkCgqC8FVwgJpir7PKcbqgftpIVL9PbGXL3Ad3GmRmBpOVxG8goZmYuYkMnKCFUI0q+l78DvcHPIUaVcYAucxbpw/iv5Mql/UQ6b3VcEQDy41jNOAH/GEzft7icReQoqMC27kgdjiBwjqNboXPoI1E15QL8pUZaqU8ricLupq7FaOVMoxMEv5qfjg5i2sKLHy7xlx/SfbHgnarCvnZKia7Da+8X0G05bMln8ZV7qb7n6ZU4D5GPPJtv7dKQCPhef86QJ7/XJNovidFRltA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=codeconstruct.com.au
 smtp.mailfrom=nuvoton.com; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDpjdoW9MHtdw/NXIlzbyGSj9RbMxxSnuk4poM4+aTo=;
 b=n5RCJsk6QaPGbWmYCPbOicXQC0vuKgTxX6oZMiwvqGpzvqGT65AoAs8q+2MirzTZmaI3upIUbpT4X+uX95mcVv8U0xcAd8x9L89q40Opo9IkkDUludFBadSvnCPn3DLB/xOrH10B6AXCvvzlCkPuU3C9ZbgBbhJOKHLezJJKLvc=
Received: from SG2P153CA0034.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::21) by
 KL1PR03MB5745.apcprd03.prod.outlook.com (2603:1096:820:65::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.29; Tue, 31 Oct 2023 07:58:12 +0000
Received: from HK3PEPF0000021D.apcprd03.prod.outlook.com
 (2603:1096:4:c7:cafe::32) by SG2P153CA0034.outlook.office365.com
 (2603:1096:4:c7::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.2 via Frontend
 Transport; Tue, 31 Oct 2023 07:58:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS04.nuvoton.com; pr=C
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 HK3PEPF0000021D.mail.protection.outlook.com (10.167.8.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 31 Oct 2023 07:58:10 +0000
Received: from NTHCML01A.nuvoton.com (10.1.8.177) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.14; Tue, 31
 Oct 2023 15:58:10 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01A.nuvoton.com
 (10.1.8.177) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Tue, 31 Oct
 2023 15:58:10 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 31 Oct 2023 15:58:09 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
        by taln58.nuvoton.co.il (Postfix) with ESMTP id 225B85F59F;
        Tue, 31 Oct 2023 09:58:09 +0200 (IST)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 03850235CE0F; Tue, 31 Oct 2023 09:58:08 +0200 (IST)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <linux@roeck-us.net>, <jdelvare@suse.com>,
        <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
        <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <j.neuschaefer@gmx.net>
CC:     <openbmc@lists.ozlabs.org>, <linux-hwmon@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v4 0/1] hwmon: npcm: add Arbel NPCM8XX support
Date:   Tue, 31 Oct 2023 09:58:05 +0200
Message-ID: <20231031075806.400872-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021D:EE_|KL1PR03MB5745:EE_
X-MS-Office365-Filtering-Correlation-Id: 037cf5e5-5208-4b07-13a9-08dbd9e72071
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?D/7aoeU/igtqG5X/3xcMmX3ctArx9m/NJdfj8B1EDh/NqNfqJUJJXZ5c8t4v?=
 =?us-ascii?Q?ucgglhHpZeYjbUDTXcdq0ZlSWgorvug7lYrwoqPPIzatBBPSSHXTyC+JrtVo?=
 =?us-ascii?Q?hiR/2cb1I7qkBGKzkKbVduyBk6gWaYY4J05rMK/RfdcGezQz/IwFtjUBFTh8?=
 =?us-ascii?Q?UPscqd3VsfVLeV35rEzArhj52gpX3JqC/4dsvv07RJk7mDQLMsK0y8ClEBmq?=
 =?us-ascii?Q?GGlMn4hYgm1aMF3HTNJzN6pgLnq3pKNYGoqHt64NOTBTza2FfnAzuCHpBC+c?=
 =?us-ascii?Q?mtzRlWsJ1Nd4Cs3iOYcpJJeGCwt8juPeU9IPeVjnkCuXrXOruPonqeRnkqCB?=
 =?us-ascii?Q?+R7uDDF4Z7UMRceRd+XKZw8ZrK5+I8GFBaz4Wg8kvNO3XKXuR30JmkxDECgv?=
 =?us-ascii?Q?UlYqRlCQmUZyHnXEIT3lmwl/E+vlsOpOtU1kOMzxt2kZfWghzvQeqZmIcuJa?=
 =?us-ascii?Q?VoVq4/bRkxKla2y3Vez89D009GdbbbkRnlhgcFImhmMW4h7n3Vs4RlVUS4OZ?=
 =?us-ascii?Q?dmoA02P4zrX8Bz5dddpIsJr/xdKQwpmQz7sSEt6WZtU1d1DsCS/zp6FUTvUU?=
 =?us-ascii?Q?WYrIA20oIawGJEX27ognV9qGZjePPVbyGbOUiL8yaWg2/W5eyrQrytbbbClp?=
 =?us-ascii?Q?z5AWTPe/4p7OaDRbc6JCRSf8qj9+Wm++fZa4x9es3nXiUxE7NnpWGgQECEJx?=
 =?us-ascii?Q?+1zMdCr/uv8SFnmlGQLmOUx1XXAb1UKEs4aTF6wjBCmrYbqk4hYTUg9lyeL9?=
 =?us-ascii?Q?30XLMH4p7CQHpxT96KOiJyrJ3rs40wsFYJGFXqvzciIJMaXxLCh+Bv2/RL+M?=
 =?us-ascii?Q?iSQSrLTPMtXVgzlryCs6PAicjcMrtZH2/bDLoDa+UjEpBIRey5zKqZEQjYvi?=
 =?us-ascii?Q?PtKIB7Nyb7Q55qPvSrR2+vzTPRIOVEvVR09rMTWPVquOuBnTNQOBGXyt2Msq?=
 =?us-ascii?Q?nED5EBJehDWHVuMDzzn98l2aJMrqyz+mEv9QAZrst6mCPxqS7dCfQe5y4cr0?=
 =?us-ascii?Q?HewX?=
X-Forefront-Antispam-Report: CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(5400799018)(48200799006)(61400799006)(64100799003)(82310400011)(186009)(451199024)(46966006)(40470700004)(36840700001)(83170400001)(82740400003)(40460700003)(73392003)(40480700001)(34020700004)(7416002)(2906002)(4744005)(55446002)(36860700001)(41300700001)(42882007)(36756003)(6666004)(82202003)(336012)(83380400001)(6266002)(2616005)(26005)(478600001)(1076003)(316002)(5660300002)(8936002)(8676002)(4326008)(42186006)(966005)(47076005)(110136005)(70586007)(70206006)(76482006)(54906003)(356005)(81166007)(921008)(45356006)(32563001)(84790400001)(35450700002)(12100799048);DIR:OUT;SFP:1501;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 07:58:10.7698
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 037cf5e5-5208-4b07-13a9-08dbd9e72071
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF0000021D.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5745
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds Arbel NPCM8XX Pulse Width Modulation (PWM) and
Fan tachometer (Fan) support to PWM FAN NPCM driver.

The NPCM8XX supports up to 16 Fan tachometer inputs and
up to 12 PWM outputs.

The NPCM PWM FAN driver was tested on the NPCM845 evaluation board.

Addressed comments from:
 - Guenter Roeck : https://www.spinics.net/lists/linux-hwmon/msg21914.html

Changes since version 3:
 - Moving the visible handle to the npcm7xx_pwm_is_visible function.
 - Modify the commit message.

Changes since version 2:
 - dt-binding commit applied and remove from the patchset.
 - Using _is_visible() function to support NPCM8XX.

Changes since version 1:
 - Add Rob Ack to the dt-binding commit. 

Tomer Maimon (1):
  hwmon: npcm750-pwm-fan: Add NPCM8xx support

 drivers/hwmon/npcm750-pwm-fan.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

-- 
2.33.0

