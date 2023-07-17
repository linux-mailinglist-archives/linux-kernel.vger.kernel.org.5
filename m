Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F132F7559C7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 04:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjGQCzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 22:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjGQCzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 22:55:53 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2127.outbound.protection.outlook.com [40.107.215.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89A91BF;
        Sun, 16 Jul 2023 19:55:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMGyj1Wala74QuxyxxZeBX8pZKMBKpHuYvt8eHCZQkb376QBhygGD1WJn84fdlPsV+S7Wemde2OWUoQx0uZL4PAc0xxk25elb00OHFSRKEZjCv72sywinXYX/aj5M+NxATWxQhwmn5Y0nY1Y7GwKVUUIDcmkxKqpJE0dZuKPyRYhVDUH5m68Sd8+LWgsmxMGOgWX2TBxXWNt+w45ZvhmELhqrQ3f6dYiQ7bYZSioPSDeKXUd+iTdlCsmy1HO1c7GLWHaAgmmfM8+JhdJXhSPZyQ8amCKCWy4PN5OHfxBKE2b4WJ3Bkfm3FXeBGKqFBi/9oF0HStfUB5C7EkHTdCzAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8F5pejGv1TCPxhTtIktXw96zaJiYIf6+WdTN1NVN9Y=;
 b=c+aJp2w9957Opw2jiExm8b08oAtFsrjt/ADQCu1u7KFbSWOfFSh/H6vclOy67t0P7jnBrGQkMt3B0nlSwHYwGpCw60HtecBjHqRCqCEUy+AJFa0OoLPEnZlvo2mnFT7LHTC1ojVvsyPpY9awIWiOsQL2HOJSVBia9mUSTVlxuWmyglbAmGdDjDCElu4tG86OAyahxCqyAXenazeI0AGNjSgcWFZ0r0KG1XIyMyexPNc4FFd3ZDuNLVwu2jLJ+OkezZljGcLGC7MqBZdSA1VimZT1tHLtWXx7LOAWtVAQPlPrdfB+yP3LmCZwxZWMEcH4E8PeILxg8Ymi7O13qF7VhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8F5pejGv1TCPxhTtIktXw96zaJiYIf6+WdTN1NVN9Y=;
 b=OyUva31w/LR3mS7HLPkqCWb+584ozEu8BfVAxbf96GDFAG5oOTxN8VaReW9Uu2z0K0JE2i9mTt4ON/WTAngEYzEMjVWtIsM4+g8xEcB+NzHHZUVT+V8dXZ6nDt482mEJmPVKwH6CQF/pmkqLJzmtoB0CM0BAv4DhJr/W80QS0So/Y1AQqIc/1k1mkYLIkbDjzZwcaNO6Vezi6fCZloRdDJ7Dt/+ij67AAjoNrZR3F8v+AcdF75gGcQKpEnHIM1mLh4DxTXZOv3fhGkva0OopTXdjb5VJwLvfVrYvP7ebHg1/Rv5Rtbvo6GOKFsrgsJZmKFkUU1oYWRRbdPrl9rnkeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 KL1PR0601MB4371.apcprd06.prod.outlook.com (2603:1096:820:74::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Mon, 17 Jul
 2023 02:55:46 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a%6]) with mapi id 15.20.6565.037; Mon, 17 Jul 2023
 02:55:46 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     simon.horman@corigine.com, Marcin Wojtas <mw@semihalf.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        netdev@vger.kernel.org (open list:MARVELL MVPP2 ETHERNET DRIVER),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>
Subject: [PATCH v2] net: mvpp2: debugfs: remove redundant parameter check in three functions
Date:   Mon, 17 Jul 2023 10:55:37 +0800
Message-Id: <20230717025538.2848-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0148.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::28) To SG2PR06MB5288.apcprd06.prod.outlook.com
 (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|KL1PR0601MB4371:EE_
X-MS-Office365-Filtering-Correlation-Id: a307876a-2b81-496d-1247-08db867151b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I1z1ftRx34Wpjw9cZCHXCXP6DLdBRT4RwqBWbIshJMuYXMK4xBy8sh4rlzNGB99nmCUxQbocNhWiCU7GPH0CON+rU7EWq1jXhLbT/8uzWsQIloiGJzau3DBIR4xSYoLEh6Ap7e21TmW9hbJGQG1TatNAr8KZDleHKre8toHW6u8V50OJkSjgB0jhVa9VWN4QlW4NMrayp3QdQ7YVAOGbGiITdnbgnT28kAknOdxYG3ZJe+RmHo8RLWbE9rej1YVD9wc3yu0M6PqofIaYdWbyiPU2e769XCCUWQtWxKh9d1L5FtqmtsnZ38cxYacplTpJ1g+PLQhsTvxaIZRTw65sek7Ehkb5dmdF0Yda5t7KKS+PQTB6PMrX4WP6ohRgKcP963UFXZs6sS+MQUgBaWKm/IZ/ce+qkQI/H+5wOwUkz4FbrX8QAYb4xEy99Kb5zHyxH65FZPthm06lfG2RMVXmJq7H9ykPo8RR5TVwSd6dtsCbRDu8ZNIgAOEpFAHBSX3+IJgWxOoYYXP12aD3ITmmV6Olnl+J2dyC8QkS19a55mB7Ag5VeHyzPlVYeDqViqb+hg+pP0+sbpXWd++Yr+x/yh6Cp+rWqw+Ix1C8tBopXVL0z6GXKO7bIvi9tzFxwhBATFdboXWOdzUOrVG8k1yvlzljena1s+La9WQM8/QJ9ak=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(366004)(346002)(396003)(451199021)(2906002)(38100700002)(38350700002)(6512007)(83380400001)(186003)(2616005)(107886003)(26005)(1076003)(6506007)(5660300002)(86362001)(8936002)(36756003)(8676002)(478600001)(110136005)(52116002)(6486002)(6666004)(316002)(41300700001)(4326008)(66476007)(66556008)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OVg8N+HlKMaRmddV0xysrT69PkYKkpO/sxvWGeEgdLqvlXja1jz/xsMhbQ9w?=
 =?us-ascii?Q?dBP51oWPb5FISQqrBNyo6qSgYdjUVWN9YvrnA0NGTKtZ8MlNvj0T7ebahJmu?=
 =?us-ascii?Q?MCZ4ffbnrU1xjY9RQ6RUV3tBAYP0T/DJZluXgpZDSENjNNV4S64ihniNVqrz?=
 =?us-ascii?Q?R0eLkUErIagXGwb+iH4UKt9iuny83lrpzYRhMbOmMnqK0Fm6yWKyUzYwDNMm?=
 =?us-ascii?Q?WzUBElN/nUshIR+JpyShDMT3qeL/ozB8VcsSlFF5wRJ3JEot0b7mHuEDZdXm?=
 =?us-ascii?Q?eGrjC2qchtZrA4bsAdI5lyO0oo7AkFGuvxScRffov6zAMGKRbfEEJRYZAuc5?=
 =?us-ascii?Q?anXjfvB+spndxEyjuwxXMIIiAkm51Vz/wPtRmkrXArr1X5OKj0fZeBoI92JQ?=
 =?us-ascii?Q?q3NN9XHFImm9ZgRweDVPNGbYEOWH33XfGImmEzCgzCbad/gpV0F/3U//kP3i?=
 =?us-ascii?Q?gaYWVH68VkA9ssLaMMYeiopgldpfWmJXlgG+AJE3CQdLV2/yKzplyeBD6a10?=
 =?us-ascii?Q?/4DeLpdgBPLRY3Szye5dThSk+xFHduxZSXP159gyrG2zWArVT2PvG8p4FoBy?=
 =?us-ascii?Q?KhvuHkF4fGugZUXqXEqD8T1AYBj44fB7A6lQ/pCPUnnZ1iB0ptu7I9hB+W3N?=
 =?us-ascii?Q?G0Ylh6xFKgyCBzjeGArYZSYNibMxshEpRNSOL4GCEqQOuzbYaFqb3qarJ88k?=
 =?us-ascii?Q?u9J3rIsiA6jppMjdtr17hy9o+QUBzZ54ZgA86lrC7yh3W9nT8Eqwx8RPJlYm?=
 =?us-ascii?Q?a9s27SsQ9Iuzh41bO3F9dVPutQsociLVabu04NufCcbIWY77crmNzWnLPFxH?=
 =?us-ascii?Q?7xvd5Lb1xyX7X0bqstDcuP+P1Y405cFidTDbkX0eA64vLww63TD7nqsSJlZc?=
 =?us-ascii?Q?s6Yxp2fFVqjBgvkH4b8TXiMEHI4TE0U2Q9puDfHWNFDFqzdDxCdzPWFG0aAs?=
 =?us-ascii?Q?4o7CR+GVn8lfvtDxTf6XdORNYlpwV15aDkbYfxWU7ejMCIuyLmhLuOU5M3ui?=
 =?us-ascii?Q?hsNY4uWFy53Ii8sXuE/nT91o3i8AydNnJ5nmHKrGAnIUZjqcAuZnC4kcldOm?=
 =?us-ascii?Q?2V6RtcQiJMAuGtWxqv7RqBOY/3WruKviFmZBKezE2LZBUGYDoSgUxTpg97HU?=
 =?us-ascii?Q?088SjqwbL72us0u8OWhBIFSMToySuL2h3EianQurP2VjgVGM0sixZ7s+kCci?=
 =?us-ascii?Q?cpWWD9QuGRmS+ZEO7IMeBVNMfJJkOoR2xDELgQxWYQ0wA49R44DXiWVK9dFs?=
 =?us-ascii?Q?+VVri+J0r8l6Xe/4ijbsfvd7TraIw36MX/a6hESyoX/ynA43LVAsFJ62k53e?=
 =?us-ascii?Q?xd0/lrnIv+VThx+jHnFp+OjN+94n73xOuUuepPB8PfVfhRuXj8D4Fn51vd3K?=
 =?us-ascii?Q?1JA7rPc28p/fdpWbGFnA6U5OLTg0l0WmIi8BG/IKtIboPGHjRK4kCxe4ieiA?=
 =?us-ascii?Q?GKA1pOP5GrBYx+xqQMagljy393L3j5fb3jY1ZSBTqgf5+3Lzx4JOmC2Nfz+j?=
 =?us-ascii?Q?dKA+TSYeiCXaabbzt1tDgiOrNZdhyasZ0JX4lHNPBQqofmEvqscV2Rqj0l0J?=
 =?us-ascii?Q?VfUU3KwWnip/nTllb3E9XJOgIUzNO3+Oy6TEVrWN?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a307876a-2b81-496d-1247-08db867151b6
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 02:55:46.4734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5RhloPfUgwO9Wp0H/opxgWqqMWhbmsCK93WxrMEtJnsR4j3CUdQrlzh7s/Br0TPg1xnRPQ+j+417d5ifUjU12w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4371
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the comment above debugfs_create_dir(), it is not expected to
return an error, so an extra error check is not needed.
Drop the return check of debugfs_create_dir() in
mvpp2_dbgfs_c2_entry_init(), mvpp2_dbgfs_flow_tbl_entry_init()
and mvpp2_dbgfs_cls_init().

Fixes: b607cc61be41 ("net: mvpp2: debugfs: Allow reading the C2 engine table from debugfs")
Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
index 75e83ea2a..0f9bc4f8e 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
@@ -593,8 +593,6 @@ static int mvpp2_dbgfs_c2_entry_init(struct dentry *parent,
 	sprintf(c2_entry_name, "%03d", id);
 
 	c2_entry_dir = debugfs_create_dir(c2_entry_name, parent);
-	if (!c2_entry_dir)
-		return -ENOMEM;
 
 	entry = &priv->dbgfs_entries->c2_entries[id];
 
@@ -626,8 +624,6 @@ static int mvpp2_dbgfs_flow_tbl_entry_init(struct dentry *parent,
 	sprintf(flow_tbl_entry_name, "%03d", id);
 
 	flow_tbl_entry_dir = debugfs_create_dir(flow_tbl_entry_name, parent);
-	if (!flow_tbl_entry_dir)
-		return -ENOMEM;
 
 	entry = &priv->dbgfs_entries->flt_entries[id];
 
@@ -646,12 +642,8 @@ static int mvpp2_dbgfs_cls_init(struct dentry *parent, struct mvpp2 *priv)
 	int i, ret;
 
 	cls_dir = debugfs_create_dir("classifier", parent);
-	if (!cls_dir)
-		return -ENOMEM;
 
 	c2_dir = debugfs_create_dir("c2", cls_dir);
-	if (!c2_dir)
-		return -ENOMEM;
 
 	for (i = 0; i < MVPP22_CLS_C2_N_ENTRIES; i++) {
 		ret = mvpp2_dbgfs_c2_entry_init(c2_dir, priv, i);
@@ -660,8 +652,6 @@ static int mvpp2_dbgfs_cls_init(struct dentry *parent, struct mvpp2 *priv)
 	}
 
 	flow_tbl_dir = debugfs_create_dir("flow_table", cls_dir);
-	if (!flow_tbl_dir)
-		return -ENOMEM;
 
 	for (i = 0; i < MVPP2_CLS_FLOWS_TBL_SIZE; i++) {
 		ret = mvpp2_dbgfs_flow_tbl_entry_init(flow_tbl_dir, priv, i);
-- 
2.39.0

