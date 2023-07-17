Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FCE755ECC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 10:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjGQIxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 04:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjGQIxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 04:53:31 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2099.outbound.protection.outlook.com [40.107.215.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA03FE4E;
        Mon, 17 Jul 2023 01:53:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mzC5iG4gb4+2SJDjgnl2nL7nV6BcTV9fcfxGKojbCSbTSWNl1+I0F4/hxfvlYCh5vphPsV8JExp5zcMh5WQVjMld09Lx4WqZor+MPyfJ3seCiQGaH0o7JckydurkHVaZzk9Cq3GW/5N6UO3hfb2jTHM3l/OxTiP/lXB5lc14+OYszJxWk1e6sD59iu0gyiSK1MIhyjOBBOqhL9RW6YejDx1u3tmWLXXx4g9j+Knmr+sOIyFuqNVwJ+afTSy7QYvaKKdw67kjvXqkgMabUu/bACwJIfnaKTYRQDvH8UCiqjKG6/+ikR279q8HFgm9bT8tgY1JH3r5R/He2oLs9S3zyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ozj7U/KdZufDx2AyksLbN9Dp46BnuY9szfJmoh84GA=;
 b=XVfLotmsC8MJxlWFKcsv4zwWA6F2gjLAD+V3XUirWXi6hlRvP/QOU2rv1oHuIbF2kPJPSzsNtz3hzdcFtf0jmcFR02I/NZe18hwd2KLvurXoGQ4NF1YluFlOL6VRB10Gh2cOpqTwAZNNS5Ld2sFaOMQnVRhgdOuUTZqfeCsmjPmJe84xB4OljoPtVIrVQL8L1ubI9AdcbLsBQsL+cuPiZA4oC+E5F/p5Rsko935p0VKnhJTPq3L26sjQjg/oteySQUT6JLz4wmkvcAza5IcqIXTDUUAMZ3mjMw7Z5bSHB0X/yDtJh8JicJrjLYwRc99bEWBVcv8D1dcCQG9yFDhIOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ozj7U/KdZufDx2AyksLbN9Dp46BnuY9szfJmoh84GA=;
 b=WCUTGsVLjeCPsT932KJxN1TGxdXJAv7BQ3Aeu2wP5UzyK5eddPa8WnMnxXAbREVvPf0wGz85O7hPkvp64RikXyapwpi8qU3zJRlwE48FAYpCrWgXjfSyHs3RO1q5mZxJgpx2AA3zrkbKKm624wpBuxvXUu4jZUWSvKJ1hz3H7THEwIgPU5LZS6RRFgPoF4VS+5Q/YCd3cTHfstVrKpcRLGcjWdcS6KW+04rpiX7RiohxnjtaY0nv/+ppsjM5H0lA2nA6YnbbA3+EbLCg54PbMWPy26VjInpHNUerlDN0kTMkhqty5sv+YG1EtBFB/R13D8U1C0oKRTIW76eU9y0jAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 TYUPR06MB6099.apcprd06.prod.outlook.com (2603:1096:400:356::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.31; Mon, 17 Jul 2023 08:53:26 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 08:53:26 +0000
From:   Wang Ming <machel@vivo.com>
To:     Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Yufeng Mo <moyufeng@huawei.com>,
        Guangbin Huang <huangguangbin2@huawei.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, jay.vosburgh@canonical.com,
        Wang Ming <machel@vivo.com>
Subject: [PATCH net v3] net: bonding: Fix error checking for debugfs_create_dir()
Date:   Mon, 17 Jul 2023 16:53:02 +0800
Message-Id: <20230717085313.17188-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::16) To SG2PR06MB3743.apcprd06.prod.outlook.com
 (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|TYUPR06MB6099:EE_
X-MS-Office365-Filtering-Correlation-Id: a59c4cd5-d46b-4ef2-1888-08db86a348a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UkdLwc4JOrRUI7xcvqzT0Loq1mXN/r5z0udh+RDkvT8GMdqG8mA1/7pkj20OSrZlXOtz0gob580xb3eQFmNjs23rRhoSRLJs5cirOVpTPS8PiGfCrADqPzuOaNEXV+MqUfrpuCAzdfwYFZdtLvfueTJ0bhd0hEbJ6nFjbgxk6vmoQNeHZKOAfO9pMvDVxyQDzSv6J3itGda0Fsn6KXNp/lUL7RRzksaDSQsaRrEW5gFjRoJug4oPQ1yj0klaYG5g3nTnZZSQSySObHpPVikp2ftms5WkaNVwkoxXz2PiYszXsDQ86ZfiTjJ007ACvmCw86KNQEtuexJIbTUv1gK8z/zZDAbmAboLh2rS8rkMHltlikOMfJ85X5ExxmTE7fpQU7YRBILihYDOlAxbNXN8+SyIm2vw5pFoNtozvemEOKntMtSoUzRwvfTqtFFOU55sDpvVPUMvpdjoKb6/2myK2+Ptu8J3aXVTndlgFFKTjsIEEhpKQjVYqswuUGSSPFtq1fbf5RAefpZJNo9/IyiTxJM7BNzlHWa2sMjd01xcgKnL0pw5Z+tJTN5UXWUZyvXQE0kLV0RYAJL9jz9FfCt3XnQTb46ov4CYKW0xmBYovHLezw6mgtnrr3MM11BS13KN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(376002)(136003)(39860400002)(451199021)(107886003)(6506007)(83380400001)(1076003)(38100700002)(186003)(26005)(38350700002)(110136005)(478600001)(6666004)(6486002)(7416002)(8676002)(41300700001)(66476007)(2906002)(8936002)(66556008)(4744005)(66946007)(316002)(4326008)(5660300002)(36756003)(6512007)(2616005)(52116002)(86362001)(921005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WxRXVzhH24xdGEXcWOcTRiR7TlsXK4lZBZYvP1U8laVhvU5rHmj6bbigT4uP?=
 =?us-ascii?Q?5KpgpfFyceBS0hi43eNuYIkfw26sO5Jp/88CcDRffuZczf6WV+D3pd8Oioni?=
 =?us-ascii?Q?lYrwCj24S6dL1oDv9lACFQyAtEpD9YZrpORVw3o3foAzmafF5aAXVLUv4Cbr?=
 =?us-ascii?Q?KuwLwloJ2qh1nsv8J/KLDmneog1AQyhRWFOa4n7oaHyYZL1QZvcDtbUj91km?=
 =?us-ascii?Q?nUANCKwD5uwRNNIYXYGqc1dbHgvJKAPCAO134Gza+3EzssESj1c3bQSEi1L0?=
 =?us-ascii?Q?ibXsy2BydarfPaoZxVxiLMgTTYR+rUjErlqbPKfOHtDb3lJwwipS9pJCpEzU?=
 =?us-ascii?Q?w2JDRz2OKtdSDtqf9K+kAMwF81X/SvQtIiWgXn99Ts8dCgCJ4eoP2arvSgc+?=
 =?us-ascii?Q?HehbkSbSqGXStKTzTaWWc2TJZEGjhRJkstbCbRi/YQpFQOtjn52O7NM+u16E?=
 =?us-ascii?Q?zqVcrNi4J5YCOM+Bco1x04bOJ+GfjIS2f2ieU9+gTCjmFGNNxJJPt/WsX3v3?=
 =?us-ascii?Q?y87KCjVC8tT8sTEoQRzQNnvmmQDS2HcsHgZogfvBbcKpmBazmCNHOgjpf22j?=
 =?us-ascii?Q?AyCnBePqdo8n/gAv5A5WboSJXBnF9y78z2RWj6ZsejAHjBqSSC7H0+ih7nT5?=
 =?us-ascii?Q?O+DtZfx1B+kVvhb24VPzuc1U2wW5O918ajeK9hf+3eHN7QmYFICwwnFaZm1n?=
 =?us-ascii?Q?jmzlUVFVInKuQRCVoVpyIUKH1mwlA4jPWENDsUjVh3BsPYumCVRJ2OVonLGK?=
 =?us-ascii?Q?dLGPy7GhhYDudPNkeOPe+ugy4W4muYiAlAjzTPHpaPbsATVuxROnD3+xbLuq?=
 =?us-ascii?Q?ILV0sSizZoj4NtOITpYyyzbbwMsoot94rQa+ckq/aME3mj9Ef0KTs4aT9LCE?=
 =?us-ascii?Q?xHufODcnYaSSq34T050qqxnHT5DMkzJh2XZM3Z4Vn05DJarz7z49GcykOVgV?=
 =?us-ascii?Q?QaJ9VN52p5qbk5DmVs2c93/aj0VKsS+gPV5bdG9YpJRoGMzZ6lcoSG3Crkqd?=
 =?us-ascii?Q?tQGHJpYElP0hdYnOOSy2RgSfYhPymLYj7aFq62Od7mxKvaVw8tsdPuKANrBP?=
 =?us-ascii?Q?wC4iv+eQfEDpwfhYlu92kX4sxaCvwDuZqA9PHjRdshGY3neIR3UEIFz5esVq?=
 =?us-ascii?Q?qdq49/z1/zwkNCQyq5VPB29QiJYJcHodU6KrpT/OoiFGMdYNQfqam529gq9z?=
 =?us-ascii?Q?FrxAdVixksVX8qcyZgeySvo9H7VIELAfISNZxr3Lh80d6HJvFF4PItHNAbxg?=
 =?us-ascii?Q?9yvcNYxmyXXqIcsqtkcyyNvFg3CEYDvcssf9RKT4/wB6qm6Gh38vNcRjPYo/?=
 =?us-ascii?Q?E3jXx0xq/oIkczoldY/88Mzg83O0m3kxJc7LKvIEL6eSN+9hD+AhawV/gRYI?=
 =?us-ascii?Q?X0NG5c3ht2iMDK46cTWD1BPgy1K5KWmpM7PiHY8aKFeNsuZ4tt0s7svHXjoW?=
 =?us-ascii?Q?dfoz5iIFm+b+SobWM2Ezx20N997ACVEcV1j7SvhwFeVmBlyfeG5uGZvdo9WX?=
 =?us-ascii?Q?ANeq2kFwAQSZ3N+MyEes2BEatKhx0CYZR+b73LPJi5JIkbnNZEzr+QxesIQg?=
 =?us-ascii?Q?So0aiZdgmGfI8NBCaozGbU7EBeFZI7euGbGLYe1J?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a59c4cd5-d46b-4ef2-1888-08db86a348a5
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 08:53:26.3301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q7k8Y8+tGfB6FPBTbkT7tewt27ERa3rG1HIM7sfKH9i/e34EbXkjG2glItDDV8jVavqXtPEIJL4AgMeglTrFZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6099
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The debugfs_create_dir() function returns error pointers,
it never returns NULL. Most incorrect error checks were fixed,
but the one in bond_create_debugfs() was forgotten.

Fixes: 52333512701b ("net: bonding: remove unnecessary braces")
Signed-off-by: Wang Ming <machel@vivo.com>
---
 drivers/net/bonding/bond_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_debugfs.c b/drivers/net/bonding/bond_debugfs.c
index 594094526648..d4a82f276e87 100644
--- a/drivers/net/bonding/bond_debugfs.c
+++ b/drivers/net/bonding/bond_debugfs.c
@@ -88,7 +88,7 @@ void bond_create_debugfs(void)
 {
 	bonding_debug_root = debugfs_create_dir("bonding", NULL);
 
-	if (!bonding_debug_root)
+	if (IS_ERR(bonding_debug_root))
 		pr_warn("Warning: Cannot create bonding directory in debugfs\n");
 }
 
-- 
2.25.1

