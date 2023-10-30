Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549347DBC3D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 16:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbjJ3PBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 11:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbjJ3PBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 11:01:31 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01hn2202.outbound.protection.outlook.com [52.100.223.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8B2C6;
        Mon, 30 Oct 2023 08:01:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htfkr4l5PXe6Xy6MnKSR2Z0nYNTm4GTr6beX096LNsWP4Tas7QazSxYWQ1y6GYqE4ogCs4p3lit4BvCtL06FfYDDGQFHCmh2LSWX22WNPuXCDhn55JEmGq6JIqu9kF/xHkbhr+L+RYOsSJZTssKz8AoOnfzzENDSeH9S+/iHUoReWFiP+6b7BP8FzRJ78qNyaXzDcFTHgF2iURbxxPZpnQ+z+U+A0RCHTsEUNof2BAcVFit1Nlc9dRC//DOaJUoq7a2TI7td32Oj0hp0KPdV/65XEl3XG5hWhLi5P3NFXwh092r/osuRdN9NRcccLkMwkYnFMyFJUJhle/DjH0t84Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvtqHAwFvZW5EEFA0eHOI2gNtbMhYLFMOJBnOYWbGdM=;
 b=FywFjuEEtfamlCCYywn0EhDhax4odpcgQi5tS/YLa525BYQ7lXiky0aAVSm4PZuqt1Sb6soRpRBC36Mbcwnf0l11/xLHw4NhGd6JOijEOnUQS4vupuineRvQjcuvGws9xQjlpgMXLbN0X/VXn9FW8qr0wG75PTz4uRqo14pe26FFS6UCe0n7wQqw3Lu3DgqiId7jJ9IhrWlDtwtFVSE9wcfmtSLDLhXZd11qunAMdFg46Hv/RnGzVifbkcohHR2LlcXEH6YQLaxG7aFzH1oCJnYzcflh5acLymnFjgDwaw8s3Sm8OhSYWD1It9BlO3JC7jYnlIEdVUO+1RIj5OC7gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=codeconstruct.com.au
 smtp.mailfrom=nuvoton.com; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvtqHAwFvZW5EEFA0eHOI2gNtbMhYLFMOJBnOYWbGdM=;
 b=YZHzX9Mxb6Bvda7vPKItlz2ejNN7VEL2lwL9LRcvjTK8SbFlKpz+xljNuabdrkmSFX5F1alFs42jeiiBq06y2X9oyb2+B1xp1QyudNFnEBRDah/VSxzIOTNeLOoPMON5dmLuX55eD4t9d8hZOGI9YZCxnpDCHnAaD5i2hmjlD1w=
Received: from PS2PR01CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:300:58::13) by SEYPR03MB8362.apcprd03.prod.outlook.com
 (2603:1096:101:1ae::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26; Mon, 30 Oct
 2023 15:01:23 +0000
Received: from HK2PEPF00006FB5.apcprd02.prod.outlook.com
 (2603:1096:300:58:cafe::f) by PS2PR01CA0025.outlook.office365.com
 (2603:1096:300:58::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.27 via Frontend
 Transport; Mon, 30 Oct 2023 15:01:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS04.nuvoton.com; pr=C
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 HK2PEPF00006FB5.mail.protection.outlook.com (10.167.8.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 30 Oct 2023 15:01:23 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.14; Mon, 30
 Oct 2023 23:01:22 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 30 Oct 2023 23:01:22 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
        by taln58.nuvoton.co.il (Postfix) with ESMTP id 651D35F48F;
        Mon, 30 Oct 2023 17:01:21 +0200 (IST)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 4070F235CE0F; Mon, 30 Oct 2023 17:01:21 +0200 (IST)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <linux@roeck-us.net>, <jdelvare@suse.com>,
        <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
        <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <j.neuschaefer@gmx.net>
CC:     <openbmc@lists.ozlabs.org>, <linux-hwmon@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v3 0/1] hwmon: npcm: add Arbel NPCM8XX support
Date:   Mon, 30 Oct 2023 17:01:18 +0200
Message-ID: <20231030150119.342791-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB5:EE_|SEYPR03MB8362:EE_
X-MS-Office365-Filtering-Correlation-Id: ea4d476d-7b28-42ba-390f-08dbd95914ff
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tHQqjLdbzDJ0hDWlGhNg3dut4hdlSQikKJat5OWz3qlTS3tIPpbSbPOafsoG?=
 =?us-ascii?Q?FVqO+UXxI719HsP0Bi7F00wUiZ0zn/GO6pTW75fGqRSH2MGseaJuEaWSk9so?=
 =?us-ascii?Q?IJOyIYCxtYmzSI+qCSh6nzOffBLsZfiw9gyEyTxPCp+viax+VmSChdjdH6Kg?=
 =?us-ascii?Q?9qG8B9/bdexT2epueGux5T+kPViQRTe1i3j+LQ4l5/ihQ6rC7Atyf3I1LFVL?=
 =?us-ascii?Q?SFMqHRvKvvNBR83h+8clbykJ4Pm6LQgon+2WjktDGFnWqNyy3WtUQljTyow8?=
 =?us-ascii?Q?YoecVyGqUUedevDgFCwt3T90C3Nq0kAVE8+pUVGx8qqcEBNUNYHqexxWGzCR?=
 =?us-ascii?Q?SDjdDKGBjy3kh65Vly6cmTVdjrGe4FRGuVq5ibNK9aAqe2xiFta734mqyvuE?=
 =?us-ascii?Q?Q0YHfVpBPv2EwFIibG30QyLBZ+KSlTwyEX0Tolp6OWcBrgWEu+rdw/k3Cz1M?=
 =?us-ascii?Q?m+k168oPqGo7GkSd3p+wWhINbIW15huoCzOkkS+9tcsWBC1WmVP6DdjJPXko?=
 =?us-ascii?Q?TfmD9TGJIfmR8DU+E5O8GYOecwYBs9dNmmrmJKgPXiwEGwIdEKRgdPbt9N5O?=
 =?us-ascii?Q?TN2WGSwmZqOYhQFu0YZCx2XInaawc4xfrtm7yAG0l8Et/RjLZbb4nWkA84T9?=
 =?us-ascii?Q?LyLuY07dPXtKtU/qr7VlzmPRz5RxLCg15rXhXdgROFal3qpWLRe653gp6ILH?=
 =?us-ascii?Q?5kvHpHOvztoo4y/zM8QbXmISUUAGnL3IfYtLwQlN9B8FfSCUwQ6Dc/IAuDdO?=
 =?us-ascii?Q?pzB0doCbx0WWRK8h/lWjo+olv3Od7bkUUFIPyRN+PT22q0bU8QX1g1Sjaiqd?=
 =?us-ascii?Q?FKc8Mu21mEIfidd1Iva6GGmaUPBcvDuqOPnDHDMEg8EIWxKl7lnMEX1venLo?=
 =?us-ascii?Q?fnnuDVHJ5rQCfyHFfR/Ozxvyqrgh3o63jykqLrwtuyebISH5X1lroL7MMUNO?=
 =?us-ascii?Q?Oaj4S26NldCGA3Hk8pkyG64tcCk6Zuqs+q1jpHDdQ/i53YDewEVFiK6hMCmP?=
 =?us-ascii?Q?sGti?=
X-Forefront-Antispam-Report: CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(61400799006)(48200799006)(5400799018)(451199024)(82310400011)(64100799003)(186009)(36840700001)(46966006)(40470700004)(1076003)(82202003)(2616005)(26005)(40460700003)(47076005)(921008)(83170400001)(356005)(81166007)(55446002)(82740400003)(36756003)(34020700004)(36860700001)(42882007)(6266002)(73392003)(336012)(40480700001)(83380400001)(5660300002)(7416002)(54906003)(42186006)(70586007)(76482006)(70206006)(110136005)(4744005)(8936002)(4326008)(8676002)(41300700001)(316002)(6666004)(966005)(478600001)(2906002)(45356006)(32563001)(35450700002)(84790400001)(12100799048);DIR:OUT;SFP:1501;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 15:01:23.0175
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea4d476d-7b28-42ba-390f-08dbd95914ff
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FB5.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8362
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
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
 - Guenter Roeck : https://www.spinics.net/lists/linux-hwmon/msg21801.html

Changes since version 2:
 - dt-binding commit applied and remove from the patchset.
 - Using _is_visible() function to support NPCM8XX.

Changes since version 1:
 - Add Rob Ack to the dt-binding commit. 

Tomer Maimon (1):
  hwmon: npcm750-pwm-fan: Add NPCM8xx support

 drivers/hwmon/npcm750-pwm-fan.c | 34 +++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

-- 
2.33.0

