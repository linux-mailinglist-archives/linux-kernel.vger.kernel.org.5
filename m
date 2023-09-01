Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A4A78FA18
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 10:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242707AbjIAIlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 04:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233494AbjIAIlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 04:41:10 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432BC10E5;
        Fri,  1 Sep 2023 01:41:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNK75PVDkPWRnUgM/qH9l94Jvmtf6zka3K+qlhX8rekVbZvd50LhbUl+1PXolxW/6heFUKTN64S+vClZYD9i3dz/XD+uJtN2ZV4GTA68scbI43o3BiQZdgSJ7K0WjM439vUamVU3f3G655y7UHJwo4lWq1YNIKng/PtHsleBQ3D4BgvZBscpCcmAZt9XBizqM74m59V+iZ8LRZhRntgJN0BH3p4+7R7tNDgVPFk9Bd6irlpAjvZCvf6dJxIXPq5tsuRaB2awcHP7NMXbh7wMKukUhE7PyUKCyWfkOqITi3SJyowIrpl+XBMBqfA9LiIWbT15eawXbNReCF83KBu3Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZZbTYX8RMw96wG7sOtk4iAfZ8jgJt9JMwFOWywAR7k=;
 b=gKf/HXt4N7sORyhXJ9MsxJubNTS20koDfo7WRDyh55gDl7ER/BCRlj7u1u03mTSkdX5swn++w9X+Jk7mfxCR03oadG3QBKvCTvcw250vLmBoSjyrkaGNLGKEEY4RjPdDKEFsewqQ7lbrbrNiOq9Ntr2/MVFtPiYVcaGlzpiep26Ej75Bedg6FVY+kqbqokg91IumfqkfXa8Se9+/2Zn/lwYbh083WYat4rOx9QHLdLvc27/YPIFYcfbqs4QepbGgpowJC38EAiupqx5OuUHG8X21GKjxFGejnpwoVi2ONbS9/xKGsO6T1Ye/WSWBgFVaWHb0Jgs6A4NM4LGTGqrxxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=grandegger.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZZbTYX8RMw96wG7sOtk4iAfZ8jgJt9JMwFOWywAR7k=;
 b=es/LLj+mcLQO3yFPVQ0oxkdaIn4IFRGfaxvrVBjkaAWyErU5uGEfqGRpbFz5+5BaVPjZXqmuDwQU8T8tiEmNQFsJjo27kojqyRRATafqZaTk/JEScFQ50ybIMEzBRLmFu1d9D1PBY67o4FP/fAfhLfE4Z4IBhryIhTJl4IIPal4=
Received: from BL1PR13CA0247.namprd13.prod.outlook.com (2603:10b6:208:2ba::12)
 by CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.23; Fri, 1 Sep
 2023 08:41:04 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::a) by BL1PR13CA0247.outlook.office365.com
 (2603:10b6:208:2ba::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.15 via Frontend
 Transport; Fri, 1 Sep 2023 08:41:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.20 via Frontend Transport; Fri, 1 Sep 2023 08:41:04 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 1 Sep
 2023 03:41:03 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 1 Sep
 2023 01:41:02 -0700
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 1 Sep 2023 03:40:57 -0500
From:   Srinivas Goud <srinivas.goud@amd.com>
To:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <p.zabel@pengutronix.de>
CC:     <git@amd.com>, <michal.simek@amd.com>, <linux-can@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <appana.durga.rao@xilinx.com>,
        <naga.sureshkumar.relli@xilinx.com>,
        "Srinivas Goud" <srinivas.goud@amd.com>
Subject: [PATCH v4 0/3] can: xilinx_can: Add ECC feature support
Date:   Fri, 1 Sep 2023 14:10:42 +0530
Message-ID: <1693557645-2728466-1-git-send-email-srinivas.goud@amd.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|CH2PR12MB4101:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a818a07-a5d1-46e7-987b-08dbaac72db8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UZ/H04M2VFMGLehHXis8ncB3Pt/7YRpb+D9g0g3rwpJhT89Mm8HC9dEJTlXrYUY5r7/GuW/PwWhGf5a4GRjAvxtksfJwSN4sBrQJTCgGaGbq3pSoSdiZ+Tjb8Y8cBBkfwxwOP0+dXm+HMEM5XfuM3pxeHVw+/LAqL1RI7qpSJ4viePgHySDvZyOZ41ndBcSc0oTVknBjzzrCG5Z4iYOyQ+KchhzGE5wXMGPllG3nrL5VOeiHhDh3LNRilIZurdlG742Axuaq9FZS6Un6MvOjnPitPCR+DRnup1hW6aag3+Ef89ve+70NdXz9FNXclylhDriGWqu0RhzWvsTD2DYgS4mifXV7qoqOdD/xaVY8B5N10M1PU8RtwNDpmxwKpc7h1jYKN37Z/1XHzZ+i6t8ChdvF/qos7Q8WXFZRr3//vx84oLpx+f+ooJttfryUXriEkU3JoRlwvURB68x/x/N7aqxWLF1deayIMC3v74En0KVnxZeQEyUhTrJtZyBYTo2gVlGPiLkmE5ZNDS1TBq8lzrKpYcJSqC89G77lc/g8+udAJiak8AVDUxlNboqYvlsspVhd/fGzFMUyCL+ck8DsYOiTVhl6FUE78Q5g78r1GkXTXxqOsRnJSxEbZz2By1Gh10RqDUalmC7t0EQVzg6NHpThBUJGBC9H1u2cjjyVWSV18BkC2ydQG6q6m4TdBKedS6WCN80LgOpc+mv1W1ShGsrEzfkGyKJ9E73iTu7Hk5FjCEKaeeJ0/K8FFIv35y9EDPS+JpLZ7jfpCZNrmMqxLt+AwyVlFBxJ2sjWOv0xUlg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(82310400011)(451199024)(1800799009)(186009)(40470700004)(36840700001)(46966006)(6666004)(478600001)(83380400001)(2616005)(336012)(426003)(26005)(2906002)(7416002)(44832011)(54906003)(316002)(41300700001)(70586007)(70206006)(110136005)(5660300002)(8936002)(8676002)(4326008)(40460700003)(36756003)(40480700001)(47076005)(36860700001)(86362001)(81166007)(921005)(356005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 08:41:04.4874
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a818a07-a5d1-46e7-987b-08dbaac72db8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4101
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ECC feature support to Tx and Rx FIFOs for Xilinx CAN Controller.
Part of this feature configuration and counter registers added in
Xilinx AXI CAN Controller for 1bit/2bit ECC errors count and reset.
Also driver reports 1bit/2bit ECC errors for FIFOs based on
ECC error interrupts.

Add xlnx,has-ecc optional property for Xilinx AXI CAN controller to
support ECC if the ECC block is enabled in the HW.

Add ethtool stats interface for getting all the ECC errors information.

There is no public documentation for it available.

---
BRANCH: linux-can-next/master

Changes in v4:
Fix DT binding check warning
Update xlnx,has-ecc property description

Changes in v3:
Update mailing list
Update commit description

Changes in v2:
Address review comments
Add ethtool stats interface
Update commit description


Srinivas Goud (3):
  dt-bindings: can: xilinx_can: Add ECC property 'xlnx,has-ecc'
  can: xilinx_can: Add ECC support
  can: xilinx_can: Add ethtool stats interface for ECC errors

 .../devicetree/bindings/net/can/xilinx,can.yaml    |   5 +
 drivers/net/can/xilinx_can.c                       | 154 +++++++++++++++++++--
 2 files changed, 144 insertions(+), 15 deletions(-)

-- 
2.1.1

