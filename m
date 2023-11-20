Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077CB7F166C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbjKTOyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbjKTOyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:54:00 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2071.outbound.protection.outlook.com [40.107.105.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6324A1729;
        Mon, 20 Nov 2023 06:53:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HcP73maYdeNYE0lcazMMjNNRW9yvKtx8t2+yvK4VMyMxgeDuI/6UaEhK1S6CF/j0bfuJvm56PYzRnbNlXbdjzuRTBsgNwYjlcAVcC3kLAuhcTPEqH1+opaz+Udv/iIM/GNOvD7veqVT0TTILQOM6JV4RiA7ZzCaSChg+ZuN1QYR2ourynKCwj7IW6lGf8Fnh7lRUG9yvNk+eBxnM5+uQDD/ZGeXdFDNFd04tMJW7Z1fLoWh4VlYZeI431EHkvFmadN9FujZXDGmmoqLCH/1f9+0ECNSO0A6IhRUn4xtRKEjqVARk3bUMtz3bMkG4Z1Hmi5xtA/wy8lZb82z7Mj4SEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xb2RdeJklodRVFCPYxWUzIE3G/N8mBYCGxjgeGOZQYY=;
 b=Gd47lQUzFsOtlhk9ySrIDhZpr2QgyeukxkT+LhAVvfMIOIerij/Pq2PITPw80uF09BbdpAJRZrvq6REo6dNNhI3J//TEdmmTb01nXI4XewrkhfVDcIq3OVGM3VVhlHD0BOq0OhBe8p325Fa4+VG/XcNLc+FYI4vE/vytht9JPMpV+t5n6/2s6TM9I3GfoqbhruydDLaIkUhjL91v5+gokQb59dPqS7GS7GB8TESGd56SgR4VOAVAzW/xAXUpfBjRgwa2cFdm1V5riJbDzq65UxVq1HNw0IpkM+h6CP7Jw6qZsYBluxCurL4UoZIu6D3gS5bkyFxZ+o0SgI8/2DMBYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xb2RdeJklodRVFCPYxWUzIE3G/N8mBYCGxjgeGOZQYY=;
 b=TbJxU6GujvMlGxi9XU9J7xZM1UugGW6jQSaWfUdHDJWj5xeWlX9FlGMJgwK7i+KcZiWtD3LWZ9S9Cyz8N4AvbQt3Nnwm+IuSQBICSsMkjWvcy25VT31jNlAVNJ/9iPZaXLsbhQ3lQKFxShwjshFx/XqjTkMzPwC50TCn2gXldyk=
Received: from AS9PR01CA0019.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:540::21) by DU5PR02MB10583.eurprd02.prod.outlook.com
 (2603:10a6:10:528::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 14:53:16 +0000
Received: from AMS0EPF000001A4.eurprd05.prod.outlook.com
 (2603:10a6:20b:540:cafe::54) by AS9PR01CA0019.outlook.office365.com
 (2603:10a6:20b:540::21) with Microsoft SMTP Server (version=TLS1_2,
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
 2023 15:53:16 +0100
References: <cover.1700491765.git.waqar.hameed@axis.com>
User-agent: a.out
From:   Waqar Hameed <waqar.hameed@axis.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <kernel@axis.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: rtc: Add Epson RX8111
In-Reply-To: <cover.1700491765.git.waqar.hameed@axis.com>
Date:   Mon, 20 Nov 2023 15:49:25 +0100
Message-ID: <4823f303ec8308762430f4f3aaa462be20baef54.1700491765.git.waqar.hameed@axis.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A4:EE_|DU5PR02MB10583:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a6a850b-ca8e-4c19-5d84-08dbe9d86dd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TNTyCwXgp86AYznd9kl+uQAz6SAazHxewMtCJYyhnIgXqEt4a32Z2++4GJG6bVLUBRKVfb6IKuxyDiSyO7jaaJC9y5+HLB5Eh4vAlt3HJAyBjRayw5P2GIbI4JjjdM9TN5fjzu67/LUZOI264+SRcow1GrJFVXypUx9qwx8zYiOcc0SoV/RrHgCtdR21k5i886qMHWECqWHWKA5QB8fjHYH6wwrnICmDs+5KfRREcyp7N+KVX6oA3mim1LKqXRG50H+tmgCL4xmRvJvy3od1J9b+Cq8Va+XMapdgSfoH0/vbeMvJVhBg1xh/fMhq7Ou4SAmsYwfrI4tMFf1f9SOt758IK7wjhVekg7mXJpgsRymTnxGjodvlZ87c7aHS5pwJCgVXUqlmhDAtv6/kPoUUHSOkFKoeaCoQtu+aCzH7438AgnGfQuFCJflBpIIP3KAWfJ4avXcwd/HAlkaQxXMIYvWLbMvQ5GuqkW9uS7nQ2w4DdE6/6bRZ8SGnnwHmZBPN6GCohyaA3IQE5JCtWqBJQgEZfLVlRB5aRZwzgJICoCPy34+XT/bIaR1oAHMW+lKc1eSG+RmLh3rbqjJ20PoRf41hnkA4x3rRdQZHN/+hZAX+1e2vuHS2OGHCc4V13XFILK98u/YTUX5xFz4YRSjLZYCxusCEyJQn2jYSIkN6W3tYIYsB5gJnZqRwWaNrLppvMCI3dVuukzfxJPVnALQvc1wdRTzinV7XwSp9JM6v/fm4pGd5ZumCqElR3ma8judNeE5D7YsR2aKsMbVDvjFHVA==
X-Forefront-Antispam-Report: CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(82310400011)(186009)(451199024)(64100799003)(1800799012)(46966006)(36840700001)(40470700004)(47076005)(81166007)(2616005)(356005)(40460700003)(36860700001)(41300700001)(426003)(336012)(83380400001)(16526019)(36756003)(26005)(82740400003)(44832011)(8936002)(4326008)(8676002)(40480700001)(4744005)(478600001)(5660300002)(86362001)(70206006)(6666004)(2906002)(70586007)(110136005)(316002)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 14:53:16.7364
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a6a850b-ca8e-4c19-5d84-08dbe9d86dd3
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A4.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR02MB10583
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Epson RX8111 is an RTC with timestamp functionality. Add devicetree
bindings requiring the compatible string and I2C slave address (reg)
through `trivial-rtc.yaml`.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 Documentation/devicetree/bindings/rtc/trivial-rtc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml b/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
index c9e3c5262c21..3d1bdddcd4d8 100644
--- a/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
@@ -38,6 +38,7 @@ properties:
       - epson,rx8025
       - epson,rx8035
       # I2C-BUS INTERFACE REAL TIME CLOCK MODULE with Battery Backed RAM
+      - epson,rx8111
       - epson,rx8571
       # I2C-BUS INTERFACE REAL TIME CLOCK MODULE
       - epson,rx8581
-- 
2.30.2

