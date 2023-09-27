Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CCF7B0B2E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 19:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjI0RjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 13:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjI0RjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 13:39:01 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01hn2232.outbound.protection.outlook.com [52.100.0.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8B5EB;
        Wed, 27 Sep 2023 10:38:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=anvNKGb8X4b9G/TmwnSIYVpuvxFyIuEHIQBJ3GQmWTz21cFyU/pngQQ4ow7dwKxKL+T/FyWMfbIOfdvo+HN0hlRooqA73I9AChF2zzlqetou6WdtNTZPIR8OcJYiW9RjpPUddIWSAs9rMKufXM5VRQ+/JtnBFzMxaVUrh+rikpuH7kbeK0CCi+NtHMyFRG/UrkrYilrzpegFkApUIjqnIcN55QuvoZodNMiss+TCx/Uqvd2Xe2E8cardtQtOE+TmZ6m9v2t4bfksCsfsUU4xr0Pns4rYmYgcQmoPG9CBQCAIc+N6Y/MoDz7K1lwx/t0skl7o1tSJ40jkFgUQ/IEeZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lYMLLLjjvpmjfLX97jQ9XFP6vJk0sgvRo2vvSjZKp9Q=;
 b=kHob3b+4uxba/MzVexeX6jJODv+Pyn+b1/VRPmknNWWmHRox/SGqJWcCz1rY7i+3Pzfu61bXYPOd9Wod/afLEswIQlVdOXGR/JxLhDyln9HqTtvsqeVoYOOpzd+1n+e5HIiT5/C87xLtLBXdfB+CJL2RY6J0x1KRad1OoHcZUIWLWkbd+KLUYD+2119TYLLlQv/JpkmEgwMsD2mRhiZaA+sfxxd73Y2e/uOtJxedp5ATvTAXvRUs6++h6u9pHIS1L4Au3ZDXVkhXGimd+fD3746Xv7YA+mVPfX5clvmdo8dEYxeJUyCGcjSUnK7zCWsMiLdS9KSAdRwLuY6E6YsfAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=codeconstruct.com.au
 smtp.mailfrom=nuvoton.com; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYMLLLjjvpmjfLX97jQ9XFP6vJk0sgvRo2vvSjZKp9Q=;
 b=BhBD0SQA91P74vfwh2ccilpCmwOf75IRf6G1wwwk3puEdOmWs4CK62yWu5AJ1dmcLHoFoQmf7lx0XczGIqaESdZ6dfjzmbyeYXOusTKUguPdRrutXCow0V+qeZXpR+RSWSSaQInrRQkXE5h1eK+EJB/lzEp4M9jSoRjx1B+9djM=
Received: from SG2PR01CA0182.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::20) by TY0PR03MB6774.apcprd03.prod.outlook.com
 (2603:1096:400:217::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Wed, 27 Sep
 2023 17:38:56 +0000
Received: from SG1PEPF000082E3.apcprd02.prod.outlook.com
 (2603:1096:4:189:cafe::b2) by SG2PR01CA0182.outlook.office365.com
 (2603:1096:4:189::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21 via Frontend
 Transport; Wed, 27 Sep 2023 17:38:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 SG1PEPF000082E3.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 17:38:55 +0000
Received: from NTHCCAS02.nuvoton.com (10.1.9.121) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 28 Sep
 2023 01:38:54 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Thu, 28 Sep
 2023 01:38:54 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 28 Sep 2023 01:38:54 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 363F164740; Wed, 27 Sep 2023 20:38:53 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <linux@roeck-us.net>, <jdelvare@suse.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <avifishman70@gmail.com>,
        <tali.perry1@gmail.com>, <joel@jms.id.au>,
        <andrew@codeconstruct.com.au>, <venture@google.com>,
        <yuenn@google.com>, <benjaminfair@google.com>,
        <j.neuschaefer@gmx.net>
CC:     <openbmc@lists.ozlabs.org>, <linux-hwmon@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 0/2] hwmon: npcm: add Arbel NPCM8XX support
Date:   Wed, 27 Sep 2023 20:38:48 +0300
Message-ID: <20230927173850.103435-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E3:EE_|TY0PR03MB6774:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a398add-d1bd-4334-d47a-08dbbf809f68
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UxMN7h/F8DL5L3UjjDLFpBkTHKqdpuQW4MaYH+NO+J1O7vUlpaeNMqH/nonj?=
 =?us-ascii?Q?MRknY3MgRU26RjqtXzUNOUHi8RYhnKtWEDa+32MnPJFGXQwAg3sbvEzH5RDt?=
 =?us-ascii?Q?N3Q2CQQuqy+Syum65KtRfmivwt/5h7RtBydGqua+ESpX49AC8cJDPhl3j075?=
 =?us-ascii?Q?dc+YBDUjQQBBVhQtBSFd0bHNFKLoyMxytAfui4E/zuqvbacVw26BuwEY1YeN?=
 =?us-ascii?Q?7W5dKDIpGT4EYydnTkJ2/Sc2yxP0tXp7XX45SuZRFaLeNV2PRGmRQv0+HljF?=
 =?us-ascii?Q?/xieyE7ResP2pr5KoZ29Vr/VkzilhXQmFYFxmZ5uNV3y2xDPCqK146LYRw+d?=
 =?us-ascii?Q?8cRwYud1/6xNQJuis4mvjfbXtHukE3QhoLpRFQrzULvt2BwMtatYPNqQ0QEB?=
 =?us-ascii?Q?tMwNz1BZ4bBfXkJ0xvrMxZfQPg/uCW36C3SOCyUOo9n8lf4m3/g2XEak1OGc?=
 =?us-ascii?Q?CbWQdJRURmG47x8jah7ijmTvOMcQKjhDJt5d070Tvp5BfAQa5Dj4sfi2Z6Jy?=
 =?us-ascii?Q?/aIgNLWT8CydDLjjtmPs1ZFEAfylQ9k2V74D7DpSZBkv8LsauCtNxcUT9+4J?=
 =?us-ascii?Q?XrcXFwVZyZBrA24obxpq5FfTsMjGQJ1r43TkyZVUOY03lYxSsn5tp2Nr0O15?=
 =?us-ascii?Q?jlf01vlE3tdFlYs/Ncim/upQ/Ll5T8JC9zWiv2IDLz5i7mOKwU59721/9Fqv?=
 =?us-ascii?Q?Yf1iOdXmgdWlbxQGVnQ/resMREg5SwrlOnNjk8V43/l6teVSB7p4IChkyOkc?=
 =?us-ascii?Q?9BVidCSKMV+ofZIKGZ8iYqs5mCLUHvwIDd2BQBaqlYyx8s9rN9KXD+3pGCVu?=
 =?us-ascii?Q?ecm0AJpnnylEqoYaBYCp+acpBgGVVrGULbEK34X/Y+zHBF9xzf6xQNRKMcwC?=
 =?us-ascii?Q?oVhdQ4PprMADl4sgDvuZp9hnsO5LzFSfCK2JlL1P0OevBLgkQWNdKPwYsr7o?=
 =?us-ascii?Q?SU6UowDmGODh+a1JR5WX91E5xoJN1N4vbQogttGO3/+mTU4vu/NL215C00+j?=
 =?us-ascii?Q?mHxoHOyT10OdJn1NHpUvQzoF9w=3D=3D?=
X-Forefront-Antispam-Report: CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(186009)(5400799018)(451199024)(82310400011)(48200799006)(61400799006)(46966006)(40470700004)(36840700001)(36756003)(40460700003)(55446002)(40480700001)(26005)(82202003)(70206006)(8936002)(6266002)(73392003)(42882007)(1076003)(8676002)(4326008)(70586007)(336012)(5660300002)(54906003)(42186006)(110136005)(41300700001)(34020700004)(36860700001)(316002)(7416002)(83380400001)(47076005)(6666004)(4744005)(2906002)(2616005)(478600001)(76482006)(82740400003)(921005)(81166007)(356005)(83170400001)(45356006)(32563001)(35450700002)(84790400001)(12100799045);DIR:OUT;SFP:1501;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 17:38:55.2973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a398add-d1bd-4334-d47a-08dbbf809f68
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E3.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6774
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

Tomer Maimon (2):
  dt-bindings: hwmon: npcm: Add npcm845 compatible string
  hwmon: npcm750-pwm-fan: Add NPCM8xx support

 .../bindings/hwmon/npcm750-pwm-fan.txt        |   6 +-
 drivers/hwmon/npcm750-pwm-fan.c               | 161 +++++++++++++++---
 2 files changed, 141 insertions(+), 26 deletions(-)

-- 
2.33.0

