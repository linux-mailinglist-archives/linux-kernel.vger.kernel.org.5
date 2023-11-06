Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65FF67E28E7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 16:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjKFPmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 10:42:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjKFPmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 10:42:02 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C80FFA
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 07:41:59 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6FfUYM030872;
        Mon, 6 Nov 2023 15:41:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=udJJVU2+q41MxzPZ08Yo1PCQuGlZvTPPcPVk+CTkBLc=;
 b=zcL+dGz7/s5DnmTuWKtWJNXv05wLBxMD+P7Gh/NPzPQnk9k7WIiEtuSnLNYEFZFQCfw9
 Ts1av0Er5zVyg4EuG9/lup6PyCLVvY4N1IiJKs5CitFxsgVnnpg77UhjbyLezX7jnkmn
 e1PPPqOrIXBb9xEpzWifAFJpfjkZuWPiJw68ASkNCdMwnZu3Hq1tJYhfKiqzO1PaSlul
 7W6bk4Nzcx/nhrdA9HBaeNda5+0LUTwmFFrJg+Elq6FOuQu2q256lx5btPKPk6FySmQG
 TJjWWJ+xvMnbZTfXYTzWat5C/W0TvP02IpHRb/mIIRdDXiIVUUgVUPOEXM2BVVuXlO8E ow== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u5ccdun58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Nov 2023 15:41:47 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6F0idp026808;
        Mon, 6 Nov 2023 15:41:46 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u5cd5anjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Nov 2023 15:41:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYBFENsMfxrMjJef26MEoDx1+J/lBMC9TbM+vQzzZ9kNNWDH7ueNEIWnAcIMOnjrLLYQMS+zk9PaSRPYGjbWlMDZ8II9d484NcabRnSRuQ/NdzZls9W5UXLulJ5KPRj++7g78f53zzEqEtOq8VQQCkUXQ2yEYQrsuaKC8AoL5Y+VXsKXFMN/nSrVqOIJYaxxOk6DfBm5+tAGD/cP6SZo9/TC1va3XHhLhde2iyQ0V5BQY/3Lz37BNGP8wvkBmuujxIQvxQPKX05QgV4y0lJSZ102e26n0KXADi5QzoBRwJCc4daBvblOpbIjQ4EgBaWSIIApxH5h+9i3qnMVa6ge3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udJJVU2+q41MxzPZ08Yo1PCQuGlZvTPPcPVk+CTkBLc=;
 b=FtPQ17AEdnxOd2JXOzjFhIEuLCQ8NBEH+0MXpFMDzpeR+3TLc5IOtRvP6wqpc8ELK3AvCjfKZifOPhwIAaib9X6HpW91cVmL3us/J7hKKU31V4YWfFmtKbPbKozXB/+am2o25LvtLhpBAEPd7lpURnfnVIgBVkt/2laJqSzdE9XconFCn9Ck6EBk3EucAEy9K+ReKtmobB8rbH3SLVJJkrNRckEI3i2y7ZHW97OgAvmbxzxrlN6PnLJW9OkXfouLLQtoA25bBHcllwPid1SMtFqmvdmS/8HJFOBnomP7jaZ6skUnjPF87Hmg2N6tfMqXmESt8nd0tsPXhddNfwow3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udJJVU2+q41MxzPZ08Yo1PCQuGlZvTPPcPVk+CTkBLc=;
 b=eGjkUZzTIOV5MuEPYfAdOkYzp7B3LwvOT31NvH1FMrZnkD1CH3qLV6PIqUjKcdhLdZKCrwssuaixg4VqCO48yN7QvJjWcmCrk1TS9EBHWwB+SG9zWzjoQddwh/DlTueP0SYEOGYNpdrI5caeoFJ8XvqzrNAVlpZF1++kONF0+10=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB6030.namprd10.prod.outlook.com (2603:10b6:8:ce::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.28; Mon, 6 Nov 2023 15:41:43 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e6f9:64b:ef82:2baa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e6f9:64b:ef82:2baa%4]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 15:41:43 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH] maple_tree: Fix comments about MAS_*
Date:   Mon,  6 Nov 2023 10:41:24 -0500
Message-Id: <20231106154124.614247-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231101171629.3612299-9-Liam.Howlett@oracle.com>
References: <20231101171629.3612299-9-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0009.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::14) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS0PR10MB6030:EE_
X-MS-Office365-Filtering-Correlation-Id: a6878d07-7656-4940-2a1d-08dbdedee05b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PnHOhtoDFumQU/yqhFb6SohkYo+boYbxEZx7+6qfW2pMjUO/TsYJ5gxZuu2Ona9n6vE07sGCfjV90Uwif4mptn98fN26YrX+uwgQGHZBlv82cwC+vmtcI8Dep5EA9I3wjuV8A2YRqbySXBNsYeY+gDs4UfqchVb4FmiL86osfFQwVCihAdH5XNmP7pkJrS8DBSmTyWnORDGV9ESr9q6lsRwetjZRZwbMJA2OSO0ombERA5ToftrM4pQKQXnxkMUOwtjeU8WCsuXnOCqXChhyqmqdENGMgGs8Ni2gFGmpGCzsz7vvSRmmLdp2eYbECd0ZGucPyGy6uAJJGAzuIhsXCqf3sII60RTbXQRZtVr5Ww20RsSF71iKe4mmryhPr4jGmjCUsRhuhdmBe1EP76QLdLgr6IJ1LB8FUpRtkYnEWgR2EfTUCFVrMBNE+A304yw0w7/A0PlXiI3XT8a9JisL1I7WZRdZvXD0PCuqTwB7ND/AlLHbz60VjsvkA49pYDyUu8/EFq1Xd9US3Whix9qQX5E0hu+Q8tkl8swsQFaFzA5yx6Gu6+Q1SeQ0GfZP/j72
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(39860400002)(346002)(366004)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(2906002)(5660300002)(86362001)(66946007)(316002)(6916009)(66556008)(66476007)(8676002)(8936002)(4326008)(36756003)(41300700001)(107886003)(1076003)(26005)(2616005)(83380400001)(6512007)(6666004)(6506007)(38100700002)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PijEg4JsQP9iuGMrdHikXpJUarcR1d8qNoGWi4rVLoqiKOHmOxqGK51TeKPT?=
 =?us-ascii?Q?U+KjwwzJAQ4MAc+V6xfSbmAsC6kwqdTTgVtteEX5ZYfnOUmI/YbZg/4QgsL6?=
 =?us-ascii?Q?x3Gw/xNskMfMGYQJXQVYmMLF4RdrhunXh+r9ui1w80RD6/lHL0gre4QKz7mU?=
 =?us-ascii?Q?3h+dqREkr91+Zw8avlx8Vl+G+YkcU+foONUj3gemcm2l5XXQX8WqkIIFTX6J?=
 =?us-ascii?Q?r2qevhZND8M6ThjYl0v+LHALK4QPHIdta6uOrEKnWhBWP9ZS3IYmXRG/AtOi?=
 =?us-ascii?Q?kqyqfLmHBC6xHlz7XdyiMjyfC4pm4uFHGL342OmbgVU8COqI/q5Er9jx8iJr?=
 =?us-ascii?Q?IK2MqVUJzLBJYTvAut/K+Dq9U1j9zGy0LxWd8ML35UoG/zviL5ymZBac+vUB?=
 =?us-ascii?Q?yZ5+zvQgvrRS3gdtVWCiuL29/f/ugka4mHHbYFqtCdqi0y7JbuGucHE/IlNI?=
 =?us-ascii?Q?dg8QP/Ds2BRrqb+dDe/aebvxDBX3S0JkB/DgIu3Bo+vR+Km+8G+gCcc6dDB+?=
 =?us-ascii?Q?EK906z7eGbZ7sDO1Sx6dWHeMubuZK16Z/OXVsz8SKYsJVSm7stYn6MU1LOXa?=
 =?us-ascii?Q?MmsfUIskgptMF0C6wIT4OlOZ4KnJ4f87Ih57dn3ODeobGEgdTYWBlhAa9zZv?=
 =?us-ascii?Q?+AYgRzZAabVAuxBO2nqrxMGowK1k5rufou9o0BdNcD6CQQ5c5ykZQBS+siYZ?=
 =?us-ascii?Q?EYrZ8IFYlVGLvAlagdxl8f50uFy6gTvdfKol2Mtp4kGn75o/G9SvCuXZizJK?=
 =?us-ascii?Q?LzwEHqf5sJF3zQdNhoKpMIZTh/FLQM4BC0Yq8rDKACI0T5wT+E0Mv+Ud8Pq4?=
 =?us-ascii?Q?IrcxYRLfK9XWHzQNdt+Ong3TUiKEZjajt7OaYfdCQb1LhCjrsxZa8N8jBbQl?=
 =?us-ascii?Q?hC9+KyEYjXuF1Ldz1XYK56ujI6nCtr6OUhVVQ8o+FhptZtqgR0Ov2qGhFYbG?=
 =?us-ascii?Q?pixlrBBWeVowEDyIPWpVv/w/oOM9CKUMrn+tS7xS4fJXLNfAbTANPODZLb+w?=
 =?us-ascii?Q?qcrV2vz/kNSocOPbO6IiAQmDY3bATzaxhjrQsgvCFUEb7QcDCzDjBh2Vwgz4?=
 =?us-ascii?Q?xEuxy39sGgiyDs8MJgna+Jdi9Jh/QzNc3UpGmANrnPWJvAxwn0pttjoUrLfd?=
 =?us-ascii?Q?2/nlMgVvj88qRxziedpUoN78a+rkx4uiSQhpl4Cmp8nxOBoIiHXm9hxGowK9?=
 =?us-ascii?Q?cJ1bhxsGgIbRnGEGesdV2ZduxU9yhgvqKdMwQzD3dsTMPvff1DUyroqSrbf9?=
 =?us-ascii?Q?vvGlpm3tCDHkbAyMicxVRoGTY2dw8zf/DBRWE90y0WBoBI5vNDt72uQW2Vs1?=
 =?us-ascii?Q?TdIZ6NlbBO825ASXh7EGjUpgW7CG4yQ6yyYPWLoVGoxRnc97V5vp7xXhJ6dp?=
 =?us-ascii?Q?aASUlb9tyMInelbayDo2L2JFgJ4MSS5bqKhCGrmMjeRW2qFomk+EcDgSY9jT?=
 =?us-ascii?Q?5peiqQSobdIoNCFOFrnUsfbpta44N5a+RXVsbKoupY+iOU3pe2bsgaJPnjk0?=
 =?us-ascii?Q?hJjhKvQlLbYq2O1c94LlQcghKls0gkSE0QVWJnB812eVAZtfJ5w38+Tztqhi?=
 =?us-ascii?Q?6Wk/AdCqXC1RiFXQf0IpYRNEg/p4elCI9FHuGN0e?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5/YuuUsUHFch4sMvoAOdAvFI2FQ2rgNHPqwyUvaSIIsYiyAYxXAQ2SS4DntswJTW7sELeprpFXZ2DLRT3McQZki6BkwItYy9Y0czSI8TsKC+atIg5vygbM2LBAHs3n2lv2g/KkUHKfGAc983k1hcUtuUkfxc0QMAkceS/gQx+rlRHGzbbPX0tBEAX042jRvxUFIXAi+5w+Vrt8h1CyczzIabFeZ6PiOyW61Gw6KAqADPVWULreaGYpJg2UXlKLrfp1tK+QPlaOHaVhm2CAMkEln4aKGFevADejn2GMln6O6KbEZHOLC3IiPvlbzVzm5jIBKQHLR4+TFcpm4zr+uPRvIrsAQbXP6ie3NnVaPUQL0mdsC1mhOHqEgZ5wfHog6LWsLcVW+xKX3o2MB4FJb4A5CFMZnQk7E84Y/FsTlWM5X4N3IIbw8ReX3apA1KyaSzhLvkyeYl4rGd8M/k70lQu0NDHAr9bihZqucHolt8aA28FCHf6LoAyHIAvbNtTZ0Q5jRTR3QLWj6VA5gkMQSExuTQKrVJltzYbzSX/49mrNyFqDU/pPKNyj0pZDv6nvtmQ7MMUzha+KCqwPNYHtIPxjdK9k8f0r+uXoXz2vEJZtlKAkNbKcRSIHE+Hv7LetIkcXcSJOR7HMFUKoacFpVsCwoSUi4rmfdPdM7TOuFdyLQxQHN4VyM8A30oMySmgF8OgJH3PCPui9kvx14AVljTz60Rp/ngllrB1nVaMgU4EgjA5wsn7UjQWGxwNbBKBUt7X/lVrqS68y+ufm3++/Ta+0curJsktlC81ZlyFpO/+x+Jp/sB/mJ8zoIoTsv5dTZaeTIOmNG3EQE2k03fmLKzbBzr0UOrsoQ8Ri5MEUZ+5fURb1wDQsIecF7Hpp9AsJSSc/PELtKb3hzI8CkRRgmzMQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6878d07-7656-4940-2a1d-08dbdedee05b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 15:41:43.2606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9BDFKZB2/D/e3XDufI+4XZ6lyJk8IG0eiwXsN1JIaKl4Y/JHAQGiZ4KUsuZpEazOPp/zFlw9gAztM7J0ivq8lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6030
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_12,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311060126
X-Proofpoint-ORIG-GUID: 2pVZvhVfjIZVEVyvKDD9ay6KFYb_Zo5a
X-Proofpoint-GUID: 2pVZvhVfjIZVEVyvKDD9ay6KFYb_Zo5a
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Missed some documentation changes when separating the nodes from the
status of the maple state.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

Andrew, please squash this into [PATCH 08/12] maple_tree: Separate
ma_state node from status.

I missed some comment changes.

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 97ae58cd93ad..59dd0e2325e4 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -2219,12 +2219,10 @@ static inline bool mas_next_sibling(struct ma_state *mas)
 }
 
 /*
- * mte_node_or_node() - Return the encoded node or MAS_NONE.
+ * mte_node_or_none() - Set the enode and state.
  * @enode: The encoded maple node.
  *
- * Shorthand to avoid setting %NULLs in the tree or maple_subtree_state.
- *
- * Return: @enode or MAS_NONE
+ * Set the node to the enode and the status.
  */
 static inline void mas_node_or_none(struct ma_state *mas,
 		struct maple_enode *enode)
@@ -4359,11 +4357,13 @@ static __always_inline bool mas_rewalk_if_dead(struct ma_state *mas,
 
 /*
  * mas_prev_node() - Find the prev non-null entry at the same level in the
- * tree.  The prev value will be mas->node[mas->offset] or MAS_NONE.
+ * tree.  The prev value will be mas->node[mas->offset] or the status will be
+ * ma_none.
  * @mas: The maple state
  * @min: The lower limit to search
  *
- * The prev node value will be mas->node[mas->offset] or MAS_NONE.
+ * The prev node value will be mas->node[mas->offset] or the status will be
+ * ma_none.
  * Return: 1 if the node is dead, 0 otherwise.
  */
 static int mas_prev_node(struct ma_state *mas, unsigned long min)
@@ -4885,7 +4885,7 @@ static inline bool mas_anode_descend(struct ma_state *mas, unsigned long size)
  * @mas: The maple state.
  *
  * mas->index and mas->last will be set to the range if there is a value.  If
- * mas->node is MAS_NONE, reset to mas_start
+ * mas->status is ma_none, reset to ma_start
  *
  * Return: the entry at the location or %NULL.
  */
@@ -5854,7 +5854,7 @@ static bool mas_prev_setup(struct ma_state *mas, unsigned long min, void **entry
  * @min: The minimum value to check.
  *
  * Must hold rcu_read_lock or the write lock.
- * Will reset mas to MAS_START if the node is MAS_NONE.  Will stop on not
+ * Will reset mas to ma_start if the status is ma_none.  Will stop on not
  * searchable nodes.
  *
  * Return: the previous value or %NULL.
@@ -5877,7 +5877,7 @@ EXPORT_SYMBOL_GPL(mas_prev);
  *
  * Sets @mas->index and @mas->last to the range.
  * Must hold rcu_read_lock or the write lock.
- * Will reset mas to MAS_START if the node is MAS_NONE.  Will stop on not
+ * Will reset mas to ma_start if the node is ma_none.  Will stop on not
  * searchable nodes.
  *
  * Return: the previous value or %NULL.
@@ -6032,7 +6032,7 @@ static __always_inline bool mas_find_setup(struct ma_state *mas, unsigned long m
  *
  * Must hold rcu_read_lock or the write lock.
  * If an entry exists, last and index are updated accordingly.
- * May set @mas->node to MAS_NONE.
+ * May set @mas->status to ma_overflow.
  *
  * Return: The entry or %NULL.
  */
@@ -6059,7 +6059,7 @@ EXPORT_SYMBOL_GPL(mas_find);
  *
  * Must hold rcu_read_lock or the write lock.
  * If an entry exists, last and index are updated accordingly.
- * May set @mas->node to MAS_NONE.
+ * May set @mas->status to ma_overflow.
  *
  * Return: The entry or %NULL.
  */
@@ -6171,7 +6171,7 @@ static bool mas_find_rev_setup(struct ma_state *mas, unsigned long min,
  *
  * Must hold rcu_read_lock or the write lock.
  * If an entry exists, last and index are updated accordingly.
- * May set @mas->node to MAS_NONE.
+ * May set @mas->status to ma_underflow.
  *
  * Return: The entry or %NULL.
  */
@@ -6197,7 +6197,7 @@ EXPORT_SYMBOL_GPL(mas_find_rev);
  *
  * Must hold rcu_read_lock or the write lock.
  * If an entry exists, last and index are updated accordingly.
- * May set @mas->node to MAS_NONE.
+ * May set @mas->status to ma_underflow.
  *
  * Return: The entry or %NULL.
  */
-- 
2.40.1

