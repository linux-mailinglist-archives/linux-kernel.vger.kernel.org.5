Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A99C7875EE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242622AbjHXQro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242735AbjHXQr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:47:26 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D87A198;
        Thu, 24 Aug 2023 09:47:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGOxnV1Yv/VBTGrTWLJQ5Xl5GhcxAAD4cDv+gL4Zzcs1g31rOQMkagWT7w3oU24mRsvjl6xjn7QT83slOCqatU9t9iZLGrv/Zsj1ySucj7hQ75Dkd5tP6QfIgM21RzMJ7YbIJHjrdgF/y5VVAP9ntmR0T3nMIVIDux1azSqrPadJC7ExJN92vbd1iOqczY8xwDTTrKk+B6f1pP4e8OPCVlT4efVkBv6RkaVF4b2bSP2OBGQeu8OukhZVo1xF96qdkdXG4lNsGLgFnWDCbgtZ19DLBoTOvBPERBTQRPKsLvDJwWw+KKPsxE67UIW1w3s7CDRE1n1JAtUW6EuhKCQaxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FfQ/J9shbH3jakLMK0+cTAmLm83T8euyqmLPvP3fMI=;
 b=KkPoKY+9hQTQxeTn1pPm9f/e2SNg5xtAuy9rruo8yABBAUiA6FjBcXZNPWc8d7Wxb/TvLgrMXicAOP/njREqUSYiVeZRGzxLWErEi6kQa5z0ROQLLm7gzGGxH2obXLlr/9dTN0/U5P/SqbZNiejqnN+mZD4k2CsbcHbGzTUZv06AXtJN35q/lRGGNqY8htzEx5jbaunxg7D0o+l3mqdecpXxjYgtyLE/b1DZiNFuO6qlfDwhyKPzpq8uUN0owqAqyp5Qmxg7hrMLUwFjlgkZxH7a5u0SOgbzBCjHKKrba58hRENWcwj1Yb4d0D6+gVAg2sujV8/DcT4q83z7B5Y5sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FfQ/J9shbH3jakLMK0+cTAmLm83T8euyqmLPvP3fMI=;
 b=Zw54/r0hgA/eoOyL+q4bVhbfpAtpjI/Y9eKwEyDaiilWLv1PRpcjWatgRO+F200HrJUPAvkF9dkSoyP6H1tSPO7MPxm1gn/ahnBTX3+2NNAkML/FiiOkoBvUnYV2x25fPM69k2QyvZFEzfPJnmA5Mj485efaZS0J7Y2S5RriqSk=
Received: from PH8PR05CA0009.namprd05.prod.outlook.com (2603:10b6:510:2cc::26)
 by CH0PR12MB5153.namprd12.prod.outlook.com (2603:10b6:610:b8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 16:47:20 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:510:2cc:cafe::4b) by PH8PR05CA0009.outlook.office365.com
 (2603:10b6:510:2cc::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.15 via Frontend
 Transport; Thu, 24 Aug 2023 16:47:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Thu, 24 Aug 2023 16:47:20 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 11:47:18 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 09:47:14 -0700
Received: from xcbalexaust40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 24 Aug 2023 11:47:12 -0500
From:   <alex.austin@amd.com>
To:     <netdev@vger.kernel.org>, <linux-net-drivers@amd.com>,
        <linux-kernel@vger.kernel.org>
CC:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <richardcochran@gmail.com>,
        <ihuguet@redhat.com>, <ecree.xilinx@gmail.com>,
        <habetsm.xilinx@gmail.com>, Alex Austin <alex.austin@amd.com>
Subject: [PATCH net] sfc: Check firmware supports Ethernet PTP filter
Date:   Thu, 24 Aug 2023 17:46:57 +0100
Message-ID: <20230824164657.42379-1-alex.austin@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|CH0PR12MB5153:EE_
X-MS-Office365-Filtering-Correlation-Id: a9ab6f73-e936-4a36-993c-08dba4c1c8b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jq99HhDWq34hbE6tO1yarU1E9C6p0V+HWgoGTF46/d8FSuHsG81YBId/FqB72pTMAVHPmpLUQydQ7PHu7pNksIlpmoGgg7ziHbpJMMORwfGlW8PI840rS4cUdmNbQbUplj4Y7xNIGhEy2kbkQ8oAHI/EK7wgk2OV37Rh03822yyF+TaJmLLpFghS67q02B5/N2x8seoouO7K1dY3lcHtT8j0FTnqmvAR9Nw1OSzOErkX7grUCT5MAQVvwiU6NVhHpCpWz0tF9p3DwKN3uoYBHZyuLiFcvapy7wSCmjMPmq1DcCperXoQJlvDr2sa+/MfyVufCM4khvB+/MCjSu87t/3IipJflDR6wSLtHoG1veuye2XzoImcXbLy4ABH7bpK24FNeWQLg0U1B344nfRMRbypaUvCfLr9uWjpILq2aiH5CXoYaBJeaBq5JZQmTqNQTfORZQv3MBbMmE5pooMtq4YsxFuxnUcsAyrypbP1ncruiUb7qc3THTB1+2Z9M72YCDvrZ913E/64JQvptTW5f5IJOLtj96xZcqkBnqcxuiNXZ/6w5QRp+ByJ3roF01t47OKP9A+bXibuaWufvZmlmxg5KbjhxMU5siPOg/CmRGDjgYiJ6C5VE4CmWqRe+d04GTX9BZRSUd4FvJFSUyhOetxsNGldzFjr/O7QAAOHbDc2unguk0QwBX1KeRZ19EsDr6dvDiFXixS3I9fuU/Ei4zv5IJMGzYV/6agW7wwEdBuhgKEw8e4Ju641YmGhHynOumN4uKZhXfJAE/7z+Z7cp/HHh8wZuTCujAjj4brSrhM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199024)(82310400011)(186009)(1800799009)(40470700004)(36840700001)(46966006)(54906003)(70206006)(70586007)(316002)(478600001)(110136005)(26005)(36860700001)(356005)(6666004)(40480700001)(82740400003)(81166007)(41300700001)(86362001)(2906002)(8936002)(8676002)(4326008)(1076003)(40460700003)(2616005)(5660300002)(7416002)(83380400001)(2876002)(4744005)(36756003)(336012)(47076005)(426003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 16:47:20.5682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ab6f73-e936-4a36-993c-08dba4c1c8b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5153
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Austin <alex.austin@amd.com>

Not all firmware variants support RSS filters. Do not fail all PTP
functionality when raw ethernet PTP filters fail to insert.

Fixes: e4616f64726b ("sfc: support PTP over Ethernet")
Signed-off-by: Alex Austin <alex.austin@amd.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
---
 drivers/net/ethernet/sfc/ptp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/ptp.c b/drivers/net/ethernet/sfc/ptp.c
index 0c40571133cb..00cf6de3bb2b 100644
--- a/drivers/net/ethernet/sfc/ptp.c
+++ b/drivers/net/ethernet/sfc/ptp.c
@@ -1485,7 +1485,9 @@ static int efx_ptp_insert_multicast_filters(struct efx_nic *efx)
 			goto fail;
 
 		rc = efx_ptp_insert_eth_multicast_filter(efx);
-		if (rc < 0)
+
+		/* Not all firmware variants support this filter */
+		if (rc < 0 && rc != -EPROTONOSUPPORT)
 			goto fail;
 	}
 
-- 
2.17.1

