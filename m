Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771CD7E4198
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 15:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbjKGOLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 09:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjKGOLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 09:11:01 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2072.outbound.protection.outlook.com [40.107.8.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFD4C2;
        Tue,  7 Nov 2023 06:10:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5q0N0hwCh5abC9IZSpLGvIWQyzcmrhr9DX9jgFDNMtoy2/Zk8uERAxEWUkLF2qX02Q14BYZZgM6phaGKYiEckiXLI83CJeVwF1FQJahqcyLU/y7yWI9MLSVqCY7gZHH5XL7PrimJlT8E8u/h24ev9+3wE+de9Gxw/o0Qh4eVQmBSebdW66aGCyHZ1xCWYFs6Q2GLGdruNHgDhoKdFjoN39JbjwbZVzGCQ3jQ60PB1phgWlqjemg+9qLigrIrVThzlvrUFBSOp5Yq4OpYKRFj1PowiqN7Ahc64pzRpTU8VxslSZkVfe7pYxGvEidc8rNnvicsj5lh7uuexjYZfpkaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ie6tBhSMP6s9UfSqo93DQGR6qJa+OrY5Wx2hnvkYjJk=;
 b=OMG/2stvdyJgB4NJrfcDrF+R6r+3tmfrET+nEjrXyGZVvOw8EWaRIbrbosRvZ/3koq8EMExOmLWbz+PxNAVQr4pslLZkSFBZfPlMWeb/wpWl8WZ8u4/06Xssa0CluszHmDCwONPDoQs4eVQ0fyA2LrTiM2xEjf+i4frnzX2s9teSKIau1Yp1BqzkvCbs0Up3LylZJhvDyLC+uuZ+m1jMqnrTkAcmAKmc46DXqrwxPzMCoEmfwAwwtcViQHMbJzJ+0LBDHOGxzsfedG2iuxghcdBLtPMy8pBOYBT6iLgXq7qZmkU6jLOxNvzG0aqdHoREPDQx8ezhXl/s/qpq7K/2kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ie6tBhSMP6s9UfSqo93DQGR6qJa+OrY5Wx2hnvkYjJk=;
 b=gE29Npfw4wJNgjg2UW9EaRe3Zu7cvfC4K8Gu6hCDjWGAMix+sgx4AEUL0R7OlZazNU1q3ljdg1cchc9xDrNacLN5LG8oS6bGk7aD/fl1qMjajjy7ho3obbLXIB5Mf/eT4hTEvqb0eaXMAigcWguKjaLKO9r7Jyh2i/g6oSemyN10SZnlkgm+n3w8xaURNE/6yM2bspvQgQUn5YH38oEDvAWBifbmZKB9uPVvzg4Or1qT2id18sClZmt5OHyYhz48Lj6aDUO0rOkrrAwAyYKKciMKBtPEto0D3TRyRcl0PlX7GJ5wvPeoEiqVp5JBYnQfcoZRdOUmofbWomwfe7hxlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by AM9PR04MB8180.eurprd04.prod.outlook.com (2603:10a6:20b:3e2::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.17; Tue, 7 Nov
 2023 14:10:54 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::eeb0:9b32:19a2:8e12]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::eeb0:9b32:19a2:8e12%6]) with mapi id 15.20.6977.015; Tue, 7 Nov 2023
 14:10:53 +0000
From:   Chester Lin <clin@suse.com>
To:     Chester Lin <clin@suse.com>, NXP S32 Linux Team <s32@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] pinctrl: s32cc: Avoid possible string truncation
Date:   Tue,  7 Nov 2023 22:10:44 +0800
Message-Id: <20231107141044.24058-1-clin@suse.com>
X-Mailer: git-send-email 2.40.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0001.jpnprd01.prod.outlook.com (2603:1096:405::13)
 To VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|AM9PR04MB8180:EE_
X-MS-Office365-Filtering-Correlation-Id: 73d5e5ea-1c30-41d3-c580-08dbdf9b5a9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s4SX1HQcHIma0kTo6L3ZsknbxFz9XSh3LVBCaZynG0QLzX0vZLL7y0pEqsYJ8nWTP56Lbd/7RtXtU7jKFsDfs8rn+KzUjEfnxw4PuMN5Pzhc5jelD7OxyvVVHAJvcr3qVbcHM5CUut/X3RkIYtyDMEwFwPzKpZ2eyiURBV0bGzCDdJVmdup1qOMxXlIpD+g4Q89n9xIVneog0U4A/SSZwigcdXWI48G220p4c7kLksOdRqqGwleabTwdx7jS+Ncp+ufBAPbeSVpQUn53R9zvK+kD4+SYNfzqZUUgsCj7FXVij/EMgry9JBI70X1BCLBcJvohHPyGLoSpaEelG0kClgP30r6U7a59qL9/EL0OXGamfmC8exkeOb52GNXEjF5jni2zaT7/z2L+P1MZl3uBcTp/pkK1/lreeThysw0K9jyoTyaC9TDOBLTCArs7tH6NZwxbA/I6qs6iBzOwh8D9vldJz4fEPhjfoJ9rREMKeS2qJuZt4hwaxJNKfMGt76NplqaqgPSF58di99qCVy4Byo4VOO0xUSfEIC/86OjJ3b1BLNM8F4roVLPwf86qsUCMTVqQFk5auqT8yX4p+4sPtdDhhCI/7MJVvbf+ZDnz060Brit707FRYm4zJdOs0La0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(136003)(366004)(346002)(230922051799003)(230273577357003)(230173577357003)(1800799009)(186009)(64100799003)(451199024)(6486002)(966005)(6506007)(478600001)(6666004)(66476007)(66556008)(110136005)(26005)(66946007)(6512007)(41300700001)(2616005)(1076003)(2906002)(8676002)(8936002)(316002)(4326008)(5660300002)(36756003)(86362001)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Heb2vjvFPf6jYTJTSBx3H9dRCEtRu1tZyhAxv19bs1uRl1inqJqQC8LPWlsm?=
 =?us-ascii?Q?GjvOKMz8r42W4pdtNtIkIw51jYDVvTIp295gqN6XFzwyfHuCyoiVGpQsKfl2?=
 =?us-ascii?Q?a7yOC3zAzFXPc0rVJxQNMmRnZ7Kb7iDlhha6Coftp4IXI9flTAEIgfFXIh9t?=
 =?us-ascii?Q?AiUbMuao9I+8DxlBKP6euZN8qHJnxktRDLjtyk4xvLEmVoZ3QEiMZkBUQSeS?=
 =?us-ascii?Q?S+U3DiglpmbLfCio59dnMiAbAjB6pEhSxlUPOTG0gBcX82ycIBEDSA/IEPj1?=
 =?us-ascii?Q?z9MQE5geDdxwwC6SI7NRBsDiM7YWccZ+/lBARMw9eZ3i1qLbQRBrc0FaFFuZ?=
 =?us-ascii?Q?YGCJr/L1SUdjqmp+jlsUDg790Gyl8GwKAR4xkdm387e2FA/h8Hfs7CaTbShF?=
 =?us-ascii?Q?Yt4Xir0aMQ5KuMpI7XZpOV+Ym3lruPv1NWVLyiSL5ScFxBSiv5DiqjhkQySV?=
 =?us-ascii?Q?yE8igsDqfaMnRfNP3EYUGH1So2hHjzycxbQ8kbMFPMKhv/yhwcgArlU2+0hb?=
 =?us-ascii?Q?lg3GNwu4hH2ahPrqRF9sYFY+nBzXDvRNG82aiVRVpYC5RLJ8ayqOTD6vxcfR?=
 =?us-ascii?Q?tuhLe0TdJUF1Ij12qrAh+mnkfnfAaExLyUhvjtUcaKTc2uxn8PTJGQc5vfVw?=
 =?us-ascii?Q?1kFKl++PU17MDSfWq5a+QgQXWDPafound+ChQaYXYzsDVpOvILKUKDzY9v1g?=
 =?us-ascii?Q?bRdGa3QLr0C2tYL6cVXeb0SZsJsWN6iq12pDrn+M2GN4uNFpv0+BLy3R2o4Y?=
 =?us-ascii?Q?lLC3kpXomvSKViz0y00TaZRiaW8SZGwyKSbNyR6QsRHEY/PQDqTvqFhDMLB7?=
 =?us-ascii?Q?9iZ5s5SVq9PBInl8shXBsT/5IpwI4cz1EUJTiMbI6GLAax5cDYDiHobZrVtS?=
 =?us-ascii?Q?SXEEDMxmZ//x2ut7lE59YGGO3Vj5wTqd2JUPX90Z6Bs2r6XVu3oSkKICK6ST?=
 =?us-ascii?Q?TKRH5aVIGrWUxD/Jim/v0vS1gtKDc7EwabT1fy1NYq4dquTpcsYz+DfNg88R?=
 =?us-ascii?Q?m2+99RfuiO1PruOc4zCswlmxfWe0kVhRMoBiAIA5054YVAPGVzh1AlQeUsTv?=
 =?us-ascii?Q?aZaTRCpDAWcrHsbMpD3JQ1/cvY+gkRDwUYvUlb0wr1X5XKypOqJXoLahtEb9?=
 =?us-ascii?Q?sdfypoiVTlxUob2/yJszmYzbxo+gIPo1R523G30Kg77abOrz5jIsPkhATUDh?=
 =?us-ascii?Q?9xJvG2WaQI2656qkaK+bcS16/Kzt32U7C+tA0AP0KKqpo+Xc5e7/SJnZo+Hq?=
 =?us-ascii?Q?3XHungKHwLW7gNZWF11OYiqE8I3Gl8OYyuwvGTjXIY5DZLKIEeEBg6SKvHK2?=
 =?us-ascii?Q?UxxlDI1QBQxLV3rovQpIzicYdxnl2D4DPuU8tBcgBYGfhRM6eptDf5qENVUd?=
 =?us-ascii?Q?iFA04VkZs9UYizgW+BXC7vNxdvidOSbNbH8/1LMlykv6kzjHZDJYVGcrO3fs?=
 =?us-ascii?Q?wdv407bdYEllbLDKY1JTIVE9sg1MxPb5poEOvLYTv5mvzheC2jJGNyVy7HUu?=
 =?us-ascii?Q?QWXoLRV8ZlCAXtZm1rQQhkI2yBrDK3LP5eFo1Dd244zEvO5ySmR/vCaMgWyl?=
 =?us-ascii?Q?k0hjQ5rZvQngpIaDjr4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d5e5ea-1c30-41d3-c580-08dbdf9b5a9b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 14:10:53.8214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jV/tcLKIGH+SrvLk4kitW9cyw/plof8JtMn05ewgfzhQcRBmKFO0wzIdZ9HqHnWx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With "W=1" and "-Wformat-truncation" build options, the kernel test robot
found a possible string truncation warning in pinctrl-s32cc.c, which uses
an 8-byte char array to hold a memory region name "map%u". Since the
maximum number of digits that a u32 value can present is 10, and the "map"
string occupies 3 bytes with a termination '\0', which means the rest 4
bytes cannot fully present the integer "X" that exceeds 4 digits.

Here we check if the number >= 10000, which is the lowest value that
contains more than 4 digits.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311030159.iyUGjNGF-lkp@intel.com/
Signed-off-by: Chester Lin <clin@suse.com>
---
 drivers/pinctrl/nxp/pinctrl-s32cc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/nxp/pinctrl-s32cc.c b/drivers/pinctrl/nxp/pinctrl-s32cc.c
index 7daff9f186cd..7735d30f2be3 100644
--- a/drivers/pinctrl/nxp/pinctrl-s32cc.c
+++ b/drivers/pinctrl/nxp/pinctrl-s32cc.c
@@ -843,8 +843,8 @@ static int s32_pinctrl_probe_dt(struct platform_device *pdev,
 	if (!np)
 		return -ENODEV;
 
-	if (mem_regions == 0) {
-		dev_err(&pdev->dev, "mem_regions is 0\n");
+	if (mem_regions == 0 || mem_regions >= 10000) {
+		dev_err(&pdev->dev, "mem_regions is invalid: %u\n", mem_regions);
 		return -EINVAL;
 	}
 
-- 
2.40.0

