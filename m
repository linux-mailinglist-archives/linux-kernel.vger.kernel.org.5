Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29CBC7516D2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 05:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbjGMDhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 23:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbjGMDhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 23:37:01 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2118.outbound.protection.outlook.com [40.107.255.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C6BE53;
        Wed, 12 Jul 2023 20:36:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNOTpKeTipUP/jWMsZtlwj7bvPTfokXENr9mqq1erL0KFz5IepWyc/oLpE+PnNsNtJiiq4YgZ3/n7pT0K+GOmv8issIbOEvSx7+r9izeVPDFE23Xrzo5jp/Taq05COvf9iMWimePD+UPx50MIVuS0lzG1gxHwPRPf+eJ8PAkioF88vTcoFncfdVbegSAJrJCssSIRCwWb2Glq1fC2jgHcxjpEZyD1JmRsNGOmlDNthVPbyaiWeo1EhK0eLI3+Bbl+9K2rdNRhxqTzmSxetPEvNnbqahRJvimZyavv+QmUSkraDxye3hJsCCbgukSy9iob4BbUwcnOfLUmz9xknBnvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3/3qlIXwVPRPyKlMNcrLBv/i6fIcJuFfkgPWbrCiMI=;
 b=bl5fBqEppngvLQzZXwGFQPt8iJWqoUw0YyJX/K64Tc6RR0rQmpGapExoIu4bI98AO7AdkgsX2EdlE4gGcNUPtMWsraqujR1SReCpXG96A4rTjB5xZjpU7PSmnePjCBmyKN1/HNoSLtl0PNd4uHJQeASV0Hr89fKlfa7q0J9fQawQkEMuitCSdudN4k7lLmxMyFgCgNedynVBRDayOD23IBQk3WUpAfow+ZqMaoQ3yNkAD/BAZhM7Ph64IiAnVtSFj9b5DCO9qRyWBV00x2oYx1Qd2FgUF1AdapDKmuPHQ5H+HrareTJdOVtfbbY924j5LSUZEFgnYur65JJSZEDvMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3/3qlIXwVPRPyKlMNcrLBv/i6fIcJuFfkgPWbrCiMI=;
 b=VHnH5pvLJ871Qdt+S6lpcCgkK/EpW9Qm7wF+IRwqhLlfxO27pSmpkh6tjJP7sYjrWjmgd/eaeILXYvebcd+cJKP+DsvBouktY0hT5WQW2KgK/p5dsL9aAMGoQ1ZyO+HdoiQNGVM3+VQWlhbakcqjCdaBzrYJ6TwHRqi/Artia/B6A6Nf6L2uUyOmqd/ms8XbFxdgGpyx8vuT9C+N72yI77Mm7GOKJezbv0uVRT9cAvwCJdnok1wd1bE0vdhGhmiqdBiSSyPRTNa+hb77EWJfb2p8aIMbq7c3kgOFqVsZBkL0ONB3TkMj2HQbQ4ZthvZej9oCmiX5kzYecEwti5CZWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 KL1PR06MB6579.apcprd06.prod.outlook.com (2603:1096:820:f3::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.24; Thu, 13 Jul 2023 03:36:55 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a%6]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 03:36:55 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     Jiri Slaby <jirislaby@kernel.org>,
        Nick Kossifidis <mickflemm@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kalle Valo <kvalo@kernel.org>,
        linux-wireless@vger.kernel.org (open list:ATHEROS ATH5K WIRELESS DRIVER),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>
Subject: [PATCH v2] drivers: wireless: ath5k: fix parameter check in ath5k_debug_init_device()
Date:   Thu, 13 Jul 2023 11:36:47 +0800
Message-Id: <20230713033647.2109-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::17)
 To SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|KL1PR06MB6579:EE_
X-MS-Office365-Filtering-Correlation-Id: 16d2d2e6-9d24-419d-9e43-08db8352675a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: //X270S7jejxZI4fWO5toKjOJPbi0WFSuBSYxmJca3G1qvMsHFFB+rmeMTjb4s1lLvfimUh8NpsKYOPrXslQpWpNGI0t9O+OQN9bxHZFu6WUJxj++U0qzZYKnMDkaP0TSE40ew6GIsDAGIcrNBdaqWEBEc+fYaMbwzE4mmh+GAFnYMrRkeoUpzAHKZl5cK9CjT47mittx33i27MHEdEUEeW50UEsLwzMkwyebm9lryO0yzF34tb/szw3847r+Fmsxp4jxjZfgpWim7WRLi05TEUBh5+3IOQ/KUmGT1yzKaGSBqOkTXCOM5z8XErVTDpjE2qfgFTEFD6pqWcbtg05+cQIt8Kys6fjohN3zUaBu9r6xvVVP/xkyvREYxWT+Cko0Lz+nOIayANbAtbd5XXFaPyw3I7hKfAZM+eVosHy/4I8e1W70ssVxHnEmpMi59L6uZe+um/abG5B+v8Z9i/nhZb1Z+ag/PAq/P47yhmKY0cd4YhC1OhVOT6Qbjigz8LnWtQ9RD7Aq+BUAF+WnZ/N4qCLawsl7iWHf+09lJjbNVTDOn7RLD9g6eMjmOinUgbvAWMfqrmhEyAU3JDerMxityoucUFoaf0D6R5kMtkr56sN/outeJVjoxY5dBaNsO7DHSx8pkXj8Ws0a9k3PRkYKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(451199021)(478600001)(52116002)(6486002)(6666004)(110136005)(186003)(26005)(6506007)(1076003)(6512007)(107886003)(2906002)(4744005)(316002)(41300700001)(66476007)(4326008)(66946007)(5660300002)(66556008)(8936002)(8676002)(38350700002)(38100700002)(86362001)(36756003)(2616005)(83380400001)(32563001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pDcVBShTGCtmNSkTDmgnixJspKMRTjPrlLLrkkRcW9rS1+yfXqNZhb2FcXcI?=
 =?us-ascii?Q?HZ6CIwkSSL7K1PYjlLjCl/H0MJAvvbEe2mcfHqRTYdMWfRFD/a2y8BQ9RHUx?=
 =?us-ascii?Q?bO3AvNpvXLp9xjb8V48P8b9PPDUhMGuQmFFm/dOFDlYVz+MHdvlKDzOa2w7f?=
 =?us-ascii?Q?K4MzGgAcsMBr5YYmNaM+8rGztQ0m5NOFdx4PfpFD0s6BLtFzvn2zdMwaOGSz?=
 =?us-ascii?Q?2EUYXapVK8+0jSlfRLFVh/lm6UJV17v2QbDcyJD0JMvmpbMJhydaZFrPkd2W?=
 =?us-ascii?Q?5IJYWStEfOhDKs4UuofhAvBIaiOaxaBIFVKBWWtV/9XKSe4C28Fz2KwAhL2a?=
 =?us-ascii?Q?j89Y8YdtzcptjGXxPrbc0JylwOCCCN3fZTztDNt2tZr13LcHh1q9E85OnShj?=
 =?us-ascii?Q?5QcpxmuL9eEr7zK47m0xljjIMtPonk8knePa/ADw4heCzSV6R+XWLy1yeiaY?=
 =?us-ascii?Q?yrU2fxI7x3Q7STSg7ejw6uH3/ovaTmZgu10JOdChJt0LwJIUGMqbXt6/Wgbu?=
 =?us-ascii?Q?z8iaHYyw9smk0F2hncsI0ce40c+wAvyko6JEuJEPElAfJOZqp38l+GfLGb6O?=
 =?us-ascii?Q?vq9SHpm3iiMX3q3K7gIFaJ6FIgMzQfxSYNbB7scgrKncU3i2WNw+oL/ZrEj0?=
 =?us-ascii?Q?iOqO941C9KGb4V65T478CQgEGxInO+TiAxQPaY32qm7iu/9CzzuFwrEHhzSc?=
 =?us-ascii?Q?D2igy3DGAoT4GIDJg8NhQ81XyZ2xJwEthnoJu3wf71EEWGMtSUd6IlQpp3cp?=
 =?us-ascii?Q?S+Ll4/FCUKvDj6i5jE9mLsix5soYZ/OqFr+dP+fVDgfheYlp6h81DjQyXfgn?=
 =?us-ascii?Q?w/ufuonvZcvk2m5l/mg3HJsLRe0FmtiN8v3eD0iWO1u36QMKOdHC9qEkwfIP?=
 =?us-ascii?Q?jKwKkrjTZ2pbF6h1nIKG/lLeFXGC9s9xss0ntDeQ7TxWdPGDYQHzT/dkM4Pa?=
 =?us-ascii?Q?NVlRoQUClFKprhiIi485RrDxgX1H9UfnzrxqQTKDyPGL5RfMO0q8k1KTnfwL?=
 =?us-ascii?Q?M2ec6x6KfAZOZrHjb6o3II8DZT8gNusWyQUjPgQEJbFU4+bHLRp0h1liwILk?=
 =?us-ascii?Q?OcndswXbaP7A8FhdrTYG9PelOeaWI66TQp7SPuSTcmP20HjgUWoS/TuQrdgj?=
 =?us-ascii?Q?CR3Xw5854nErjJft2jmOXKrQbqdYVN0UyN8L8CwC7aTEY+z1fWgwoGkRHlWn?=
 =?us-ascii?Q?DeZvUEz5Edb6UepEi/GuiO99UDZeLbRBX8vHionJ/CvKrI3RrAsipWy+GQ1c?=
 =?us-ascii?Q?dSm3PRnocTlAc8rbZlw2JTFr6h6eZzK3SMlrLi/bX3Y/k1sK5t/d+nx2qDg/?=
 =?us-ascii?Q?cGFPFhtUwh7PZB6brfNRKJZgWGj1lXLGZu6TWedtvuDdo+YmarztTiL2dunf?=
 =?us-ascii?Q?0B/WCj3Z1y3FXJTNmNPAKKxNyooBIPLsc5QxPVn3gvyUoZcU2DfqhJRDwMks?=
 =?us-ascii?Q?sVCGYJ4AEMApm5aIBXkVgXaQwZdRUcesHavi+FyFGPAfMRt8cJivRMMryOVg?=
 =?us-ascii?Q?U39Fpc7eK/0/oIi1R1CZdCVjEOtMWNQw4yfcT2osuaxm42D/EZbgLBeH5urZ?=
 =?us-ascii?Q?wSU/bIZD7CE6YrSPDmqCZ4Gz/J3T1mIRkt8OtdL1?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d2d2e6-9d24-419d-9e43-08db8352675a
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 03:36:55.6539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xq8IGI7XkvzKo+XwzsvSIW/0l9tZpSQou85MmxUNtdxMxoH2ENAD57358O5wPXEQqnkRZ5DhvaTDNqQntduzIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6579
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make IS_ERR_OR_NULL() judge the debugfs_create_dir() function return
in ath5k_debug_init_device().

Signed-off-by: Minjie Du <duminjie@vivo.com>
Acked-by: Luis Chamberlain <mcgrof@kernel.org>
---
v1-v2:
use IS_ERR_OR_NULL() instead of IS_ERR()
---
 drivers/net/wireless/ath/ath5k/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath5k/debug.c b/drivers/net/wireless/ath/ath5k/debug.c
index 4b41160e5..7c8823759 100644
--- a/drivers/net/wireless/ath/ath5k/debug.c
+++ b/drivers/net/wireless/ath/ath5k/debug.c
@@ -982,7 +982,7 @@ ath5k_debug_init_device(struct ath5k_hw *ah)
 	ah->debug.level = ath5k_debug;
 
 	phydir = debugfs_create_dir("ath5k", ah->hw->wiphy->debugfsdir);
-	if (!phydir)
+	if (IS_ERR_OR_NULL(phydir))
 		return;
 
 	debugfs_create_file("debug", 0600, phydir, ah, &fops_debug);
-- 
2.39.0

