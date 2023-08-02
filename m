Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5F576D929
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 23:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjHBVFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 17:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjHBVFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 17:05:49 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EFD26AB;
        Wed,  2 Aug 2023 14:05:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aucV1NxWmpuIRRoA54t48IZ1otdZfzEkfYOsA3F8p2MjnWg2Kdw6jN9vUTViBm1fk1EP5XxIsUGya5BczsFMNRw6QkqSfI3QWqRRoK26EjN+CC7DpiyQv1Bz0q/XOnlveJEtwxHLr2DZJjUwOfqGCITFC0bJT9OqzFiwV1MJkBFTYt7R5Jtf0ZgGmiYpDBxK+ttyq+P9bBtjTLksGkzxitfjqfOAODTPjfcA1qgpjqfkTnVoLMXTM5foHCw0eaaRaBafjd4opk4kcH1ZFu77gwCdcCVn9CloM2kqqvRXP805vggmLHv/SaTZCrbBjueofZ1Ap3hSyrACn0jSEugPow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fTM+P4DSB5m5R3cygpCxGz9SWfBpdDe7xutjQwP+P3A=;
 b=BrDH/cr0Ild2239hs9UqBSywYP0sP+CdFHzREBESVUUb0owSGgGwOoLMD+ZBKqaFzN9cEmCb2A/f69fdVwn1R5NJNIE4oiZtY5MF105mZqA+uY5Fk5+xi6BJxrxb91kbuGNV3Gzsse7B6xED+scjolKYbj92WUkd1CjOl/b5hKch8ESBKYOJCWQW2ezNSyaxY8z8/fnVoeOds6zgDMUENkqh5uNKK+5vp00Qo80JWo6tqNRl8BHbeBscd3r5qDTdah3WBfp4hiNoxLxWUaNrS9MsH8UK1RO1yeMpFMc6bMrB5rNiHIs8+I6KzZuR1x+vDuElC9OhIemkaZFDBw7EFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sightlineapplications.com; dmarc=pass action=none
 header.from=sightlineapplications.com; dkim=pass
 header.d=sightlineapplications.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sightlineapplications.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTM+P4DSB5m5R3cygpCxGz9SWfBpdDe7xutjQwP+P3A=;
 b=LT8IlWxvyshUnSAxr58A+5ahY7zInL/MV2Eo69VJEW/AFJIoIBCHE1PpNWyn5cG4W5IRPGCdRtTUGWi7pXcZdYrcuEMmdEYyhuYX5k9o5DvK4K4/LzACt5sPZfGQ0eylV9oYDZqIgi3eTgHnCz9adAh2pFIgHxnAtKRzCqAIcG6pdZT0VPGcomUCY90VwVxIkwvnseWpmmIJ0FF24Tc3dpGsWs1fpzrwUbeMSQW7HIbIIRxJvlQsI0thW/nsxeE0qWgYBl5syyZ8eJf9rq24oFQm2YAMdQBCwhDFeg1FcqfmtW8oxu0A9yKUOGc1tEliW7aY7pc6ElVpPMnFD5IO5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sightlineapplications.com;
Received: from SN4PR18MB4918.namprd18.prod.outlook.com (2603:10b6:806:215::8)
 by LV8PR18MB5653.namprd18.prod.outlook.com (2603:10b6:408:191::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Wed, 2 Aug
 2023 21:05:44 +0000
Received: from SN4PR18MB4918.namprd18.prod.outlook.com
 ([fe80::44da:62f6:a0e2:812b]) by SN4PR18MB4918.namprd18.prod.outlook.com
 ([fe80::44da:62f6:a0e2:812b%7]) with mapi id 15.20.6631.046; Wed, 2 Aug 2023
 21:05:44 +0000
From:   Patrick Whewell <patrick.whewell@sightlineapplications.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        William Gray <william.gray@linaro.org>,
        Patrick Whewell <patrick.whewell@sightlineapplications.com>
Subject: [RESEND PATCH v2] clk: qcom: gcc-sm8250: Fix gcc_sdcc2_apps_clk_src
Date:   Wed,  2 Aug 2023 14:04:00 -0700
Message-Id: <20230802210359.408-1-patrick.whewell@sightlineapplications.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR08CA0012.namprd08.prod.outlook.com
 (2603:10b6:805:66::25) To SN4PR18MB4918.namprd18.prod.outlook.com
 (2603:10b6:806:215::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR18MB4918:EE_|LV8PR18MB5653:EE_
X-MS-Office365-Filtering-Correlation-Id: 23dd95ea-d005-4471-32d2-08db939c3c37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I/gEUYKSWiI/ywUqUc4I63QiUODAPUq3LjT8osGVhZQD7Rf8ksw7xO/NNWRK++NhGd0Y8+Q3T+9jYiUd28j+8WNcuvtdulGjb7fplSfgaJsIbMVAR7Au2PvcnnDt2b7KdrA6IEs1ld+UrEC7HJKOEeJLJrpMkwD29IvOmBJCRiB2GdFwTuUs66yhrtyJQILsbze/9SKpaGOhLcQn2GZF2RJZxTlRbvz0XC2657wpvUoOztUINkiDEXxeLsR/frNAMHB9vVmr73Ta6Ip+o22LnzPBUkwAFmIOh4OQG7LciaD8vkbeYvYoE0wXrFdB2gam6z/LzmgiNMP7r80w7MOFVZYwjed4EG0yfD/2uCryf5KXsXLxBSSFW2Iw6d0/IRkY5iIYs8VcNFIgDiOwn1s+0PgyOoTuMDO3giWM83XNdwTzt4tcZ2ln26y75cV+MwT5e/Ex7uMXwrVjJwF2+LOlzZgVPlFpkKTfRbpnSFtKmYW1dY/ZNoFZ8OFIgQcO0yvc2LekgcGUQ3pObzkR5RjSn0m5VaaJ762oqBRfTF1NVi0Kj08l/Lj2KTYoKHRaKTxmx7J3HoOBmhz783B8fXvzB46O9rwItSEO3DsljCb23Q/FJnKpSXu4ahmZMwQWPplx+MbkHMv4td4rITFFALuKpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR18MB4918.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39840400004)(366004)(396003)(136003)(451199021)(38350700002)(38100700002)(478600001)(6666004)(6486002)(6512007)(110136005)(921005)(86362001)(54906003)(52116002)(83380400001)(2906002)(36756003)(66476007)(66556008)(66946007)(2616005)(44832011)(4326008)(316002)(8676002)(6506007)(1076003)(41300700001)(186003)(26005)(7416002)(8936002)(5660300002)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N+2LmO6ZI94UdMNk3mygVY1kxWqlhbcAi2gHNX5I/U9MNFCz2xK/cj1R4pJR?=
 =?us-ascii?Q?GpjK4kS9xpG9J3sMRzJzkegqb030w/sXaSbaUpdUC/6i4HtvjL4GFSAhchsy?=
 =?us-ascii?Q?nA6kvoKiIHxBo+IdDavK7uf2QK34YQw6ROhbzXr3Mbp2kwfuZpQK5i61ufi0?=
 =?us-ascii?Q?WEfNq74LbhzIEub4nDnb61zK7ncyrErBnjLSk3vGX9PCPMja41tSfxpxm8Bc?=
 =?us-ascii?Q?fR5Nkge41LVtz3/HJYcC3RkZY7SLOuIwGmbC+T7PrYYg2+BEc+ytGmioXjXg?=
 =?us-ascii?Q?dVnJ+88uVHvt+1ij8QAA+jqW+dpsENL//d2RsQGCjWO6jtJb9zAYrHgr18il?=
 =?us-ascii?Q?5QlHD1C5nUyMXeFWI0StzI7OVgfGSGJ7/QjbdBYQNeKstCwR6Iff6tyQxQ0N?=
 =?us-ascii?Q?mxaUgZb5z6St4Eh0OL4+Q6hwlhbcX36v58CKkv6GGhKKuTtfQuqaNCWfUkC9?=
 =?us-ascii?Q?CAh8ZOf0ZBiT6MwecH2Bzc8BJaAhn7hPZIbyEIhYI0Ijr1ChbulwOR7Q8ayE?=
 =?us-ascii?Q?R3e7cNVUB/nG+EHZLG3NiZ4seyZusNbVKZ1xhW4+TLz1PZIY6MBjAC5yEfEu?=
 =?us-ascii?Q?KNueirrLS9K9QLD/b35d4DfyqXimIWF1WnOH29Pwvrb+Dn9Sr2IcBmJgb72w?=
 =?us-ascii?Q?QmoRJAw4WjlszbGyISPugZzmw+Ri9LX3lKYiyJV2qdE9/xjzQ5o9Mxsf45I7?=
 =?us-ascii?Q?pzxdg48Hb+V0sokUtSpQ3c676EjYEl8NojGYq5HCybJgS+bGvAGi0pgw6tyh?=
 =?us-ascii?Q?JFtgDC008tt1LJnXrH2r59xVQ91nfBVd547yk+QxZMYuMqGY/7pVYVpEyX6B?=
 =?us-ascii?Q?UrbR0BY1A+pXUxRdGJie3AHXuP5eQIw50z5iYubRUvIS8j4gClLmapIah/qB?=
 =?us-ascii?Q?NBsSp4HnKQonb3JS8s+0lZb1/bpzSOAkOq3Meuo1pirGEGQ751SD7CMuGz+t?=
 =?us-ascii?Q?RO3XUbbCtqDMW8gQgmpcUD4MiwowcTeX6yav6Y3c1xle7MlpFFKUo/EyB82w?=
 =?us-ascii?Q?Y4igkdneNrmiXvyXV7loLMZeYCYjOqZ0UB1fHD2uqeIjY0TWYs83KSzsX59m?=
 =?us-ascii?Q?u95w3YhIuplMNulESOEv9W+sf7gV03DO3RR+Ot+itNRhEW1Bg6Ub82IpRu5D?=
 =?us-ascii?Q?WK7zhGhF9Hb9bs+Zl8lEerdodoQ3V/oAY8tdsOfvqdabCnbz05DLb47RjezL?=
 =?us-ascii?Q?H7kYA8nY3WC1ILWuhG/BOxml7Vyxo5X491RLtj13vSwSPE2ls43TxHyc+nzK?=
 =?us-ascii?Q?awG2nBaYKJ3m1xP9oUZn2tShP4ETWAB+vzguVGg79WgDr8VtJJdsuFCIMP02?=
 =?us-ascii?Q?ddkX4R3Idjhwz9Lqrbl9cW64kmB/PSLtMjKKf3zjMXeM+mV+cYogKL8ORLUv?=
 =?us-ascii?Q?iDIB2j59KIAK3nv3Sll5K96GuFQ5pox4yu8raR0csahJgkyDar6kM56O4k8N?=
 =?us-ascii?Q?1KB3FqAsV1My1zoUPAQ2J8DkG0rnfZzPnuleKAkuuDpjtpuDooG5YedH7oGx?=
 =?us-ascii?Q?f4og1rhFSdEYUYi0fzO6Dg5lHZiKkfNP8ds2Me6kobSru9T4zgIT0uyhynRp?=
 =?us-ascii?Q?pZDHOs+e+TEWU+IVnGnibFiytjR1x2VRGkoRpH61AUGZce8d4p62IR7QdjCg?=
 =?us-ascii?Q?tHz+g31N1FaBxG5hMXwmycxyv2GddsB2ycysh8rdbODw?=
X-OriginatorOrg: sightlineapplications.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23dd95ea-d005-4471-32d2-08db939c3c37
X-MS-Exchange-CrossTenant-AuthSource: SN4PR18MB4918.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 21:05:43.9870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6f56283c-2197-4913-9761-239c8b420cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: seNAaPxU1SOlbagMeg72ertTobyZiLJpgMqtRAPhUln2dI9Nz3BpfSoXiXPNohhH2FuCiz4f72TIXqof5mPP8KQhzHVQt0KJDgqv+IPJh8taLEDqFfHAgLHyhVXJWo7ac92gOq9Wll4ohBL/Kkj/NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB5653
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPLL9 is not on by default, which causes a "gcc_sdcc2_apps_clk_src: rcg
didn't update its configuration" error when booting. Set .flags =
CLK_OPS_PARENT_ENABLE to fix the error.

Fixes: 3e5770921a88 ("clk: qcom: gcc: Add global clock controller driver for SM8250")
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Patrick Whewell <patrick.whewell@sightlineapplications.com>
---
Changes in v2:
    - Updated commit messaage to mention GPLL9 not being on by default
      being the cause of error
    - Moved Signed-off-by line to the bottom.

 drivers/clk/qcom/gcc-sm8250.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/gcc-sm8250.c b/drivers/clk/qcom/gcc-sm8250.c
index b6cf4bc88d4d..d3c75bb55946 100644
--- a/drivers/clk/qcom/gcc-sm8250.c
+++ b/drivers/clk/qcom/gcc-sm8250.c
@@ -721,6 +721,7 @@ static struct clk_rcg2 gcc_sdcc2_apps_clk_src = {
 		.name = "gcc_sdcc2_apps_clk_src",
 		.parent_data = gcc_parent_data_4,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_4),
+		.flags = CLK_OPS_PARENT_ENABLE,
 		.ops = &clk_rcg2_floor_ops,
 	},
 };
-- 
2.25.1

