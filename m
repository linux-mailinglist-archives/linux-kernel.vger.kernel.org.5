Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E866475437C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 21:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236503AbjGNT4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 15:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjGNT4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 15:56:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F4E30C4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 12:56:16 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36EDQoRY019492;
        Fri, 14 Jul 2023 19:56:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=Y2GhaCMP5kuOs0i8TR/0PGWaib2EC6bHHD4EtCt0MLI=;
 b=X6DynruP8gXJhzkUv4keOOpzeWe+yU3mVy4W9U+WDeA74DUCsDgRG+A48HkOwTToD+DP
 bzDUIOeYp9Pcn0c0vVcPpcNpYWdr0M5fXcQxdB39vJ6J0Wl1i+CnszGsMeyyrkEjYsKq
 +pEVIH7j1Va5paESKUwf58wY8dypZ4ADKAotYL4lkeguORfcJtAGuIRe2TSvkTXlrnrh
 TdIrw3gLJ9MUVPKPwwvOWMNbvs/lPQBw24RFxPyAejvyiZBBxqcnLMvcI/tH1/BE1dEc
 ixyzDhaRLNUy7nLWwZT9OZbVCrFkUpgT1VXXbaw8E9cCYWVMDc4p1y6MYtCEHG6B4nel YQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rtq8at7qe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jul 2023 19:56:09 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36EI0PpZ027115;
        Fri, 14 Jul 2023 19:56:07 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2049.outbound.protection.outlook.com [104.47.56.49])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rtpvydhdb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jul 2023 19:56:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grJw92d9VliZuqt9TPephDdkeHHKY5hu7ilXQxbwAZvFDSeF+zchqMd94YROrxCKxRxRxQfk0QM6Nb5xJdyFxRKUygBMaJonl3hTNdBgS2vWvILhiY/9lQ7XAJ9NWpmx5BTMG80VAU7pmDNJAJURZap7dsWPRIB0XllgtBA0YBlRAGdWUza2DzKb7tEAHhSMuhjqeDxkN46fki9rNljmZyOrBrzRRew0Vc+gxcPHH4HVgDVrXzfchnlECny7k3AeRRO9BhWfPM5GWFuB9kc2iI8aJE/PBqPtCX5JxGwzV/QKM3ADZ3KpD0IXwhwo/15nAEaox/X2aUZQT9N8yQvRNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2GhaCMP5kuOs0i8TR/0PGWaib2EC6bHHD4EtCt0MLI=;
 b=Mrh6Oab+kSZ/1hAhQFokKsIh563qUQfRISm8mCJQvXvfSZUzQLh98d+ByO17wMe1dhwO4LdRAx6hq+r2S69TSW4w1XcjhwHl2a/lLzRbcOBBNnL2WM4FryYUkjzWTTc/ZuV9KYRS0kAKXAa+4/69lMaBhNIr1/atqNyaVlCOAsH75aXp7/YuXmiMRe3SAkfwSL0Z3Tg6X2PiOBCLe83nZb1RbrdL/AsU+eBb5EDq3AZjUCYWNdS9vFSn6iLdOjTmmUbwM+vEmUzE1TbyzMcA6o+mXfqPF28pH9yhfXmcgzlmHl84nRD1MqC6V87ZOxgwWA/L1dHPNdgdoK6nBmKMBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2GhaCMP5kuOs0i8TR/0PGWaib2EC6bHHD4EtCt0MLI=;
 b=UqFnZywdxdgHTjobinkDhY+9AMNrdmrBIEFbnm6U5h47vz5oOmUOcdaQLlnrmWghsHHG0+VQvQ53DRnBaZpiwSPFVkD/RVBkBAbd9mXTe1hOZfbP7uQlK38sDdSIlVUhweddNIsK/xn/xA6fttku7R8jw4YWXjdpgpAsEDi6cyI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB6864.namprd10.prod.outlook.com (2603:10b6:8:103::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.39; Fri, 14 Jul
 2023 19:56:05 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c370:eff7:9ddc:f188]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c370:eff7:9ddc:f188%4]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 19:56:05 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 4/4] maple_tree: Be more strict about locking
Date:   Fri, 14 Jul 2023 15:55:51 -0400
Message-Id: <20230714195551.894800-5-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230714195551.894800-1-Liam.Howlett@oracle.com>
References: <20230714195551.894800-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR14CA0014.namprd14.prod.outlook.com
 (2603:10b6:208:23e::19) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM4PR10MB6864:EE_
X-MS-Office365-Filtering-Correlation-Id: 93719744-b80f-4313-2f82-08db84a45bdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TJgPCEIeHwZOy3uYJfncp2WuCbTRJCJzlvLYEqvngRQrun97EotQ0PyedYrHDTiQHRMBEXC1u7OexydQRgvlitSUJXv9lyEvf+7r7jtGU5O6H3QMC54Usq06OkoeoPQEVNdnmqd8gCrCc17+xWe0UztiVXapiTfXLvPZNcEtUTF9hNWGQ7x5t/DQzzSKVWlvZQRIV+oH1oPjXssRKPG6uwVTYEAOV071o2mFkfo/eVdk6DF9xPtjn60rQuJYBmrS4glOXUueT68NG/JtuSsGSPpduQlUD/rJy6s+diXiQK/gB1c+hvFYxv5uk9dVhPlEP91x3IEaF2luwaV74iewXcicSqsH9U+cF6XIVAOg3hr1gaN9zvg0zFMxJrBS7eeV07VE6VUF1I1SuWHDfqETtN6jbGJVxyZW/xkVi6zm5fnBhSDa88LbV5XH3jheJaPxZkJPr82DA5xV/CyCv3W2qjWg7azeTDG6rrZ/EVG9Nb0wYXH3P3tnL3+J0MWV3bXO8Yk7jLmIzjGwDkSLR4MDg8Ay25T4G8Uf3DcmIDWTaliW3kRlwldjFPMYYR/3Mz07
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(346002)(376002)(366004)(396003)(451199021)(316002)(5660300002)(41300700001)(38100700002)(8936002)(8676002)(86362001)(36756003)(2906002)(6486002)(6666004)(107886003)(6512007)(478600001)(2616005)(83380400001)(186003)(26005)(1076003)(6506007)(66556008)(66476007)(66946007)(6916009)(4326008)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p6g2teEw4fTeJGsvo384M85wzf6tQqooYMCn2admz0n6Y7wOoDe+dNpVi9VB?=
 =?us-ascii?Q?t0KuDH/LMKG4EYbp0onQ3hOTwIUQy7XqpAo3ybokXw8bK8WCZBDXVdHC0U3x?=
 =?us-ascii?Q?jqIR7zlw8GP2iB8uymG5j4peDiSe81EoclJapZmzT4TSXvnG7wAVD9G/kb0U?=
 =?us-ascii?Q?T6fz5KUzj/A4AUwzruWODcN6xJnRnUa7qdS88PMj0y9GlfqS3e2b8kCEdy2u?=
 =?us-ascii?Q?ASWT52KJvsmfOaaUzce3TFYQ1J0v3JQASReIX4QASuxV0EFxcFE2CWJkUb5I?=
 =?us-ascii?Q?uBoz8C7Ha27INm1e/vTvFG/ElJBC8CqwpcJsTYEFTh4UVWbEkjDrLUevL275?=
 =?us-ascii?Q?WkClLj/ZtHYISRtOeaBUtgVcCzc9agigREoSqGjAKbAcnCHRyvRwrb7CDAm6?=
 =?us-ascii?Q?t6BJq+4r9JV0U4uPjbfFgpDp+bjMwKYdN4HKXlgrfqrY9Dri4hDqERXVeyqS?=
 =?us-ascii?Q?7d4hiJ39PYOb4PsdAXgkf8In5YuA/7BOyXjCzkoRCgQGOYa4VBEI2NurEyn1?=
 =?us-ascii?Q?lvvKmUe2bNxdOaw5IPkPikYMRYYPb2NgA7NuJMxVdZ27IBJHwlvR1zgpcHFj?=
 =?us-ascii?Q?qK7iI2QF/ahrsK8VbbMLaS6khKxqEwZs3J4Q/G26qci4O8NQcvFsu33JzGne?=
 =?us-ascii?Q?E/v2+dJgZLyKQr2uhF141Zb6veQJBQ3r97DYP6+bAvyEeVcj4DOlMA+ig3VV?=
 =?us-ascii?Q?rJaHill+nIW5FX3RlQMnwzPjPRC9O51wvZn7ZpoHfIJ4XuphaujixXeyyHqk?=
 =?us-ascii?Q?kqJxOkw7z8XRkUvTPTLEP9P9+tkCiGzPlcOl/N7Hh0hR4QRs71OIrJa5No4e?=
 =?us-ascii?Q?c4WBC4AyTsldKxWSejBLMDXvrttzGzWiwl0GToxZYGDI8xjf1srXIeNEteSR?=
 =?us-ascii?Q?UtUztKYT4YfwNXZEXQITLmFZjYbEVq/4qrfapinwbsXDCEgIwbaIACx+89b4?=
 =?us-ascii?Q?/Ny3ehSZ5g452GOA0dYgIWwOCVVMgw1OpQYBdFf1TrUfm8JSeI2RCW78gjXH?=
 =?us-ascii?Q?4IhRnIc+RY5h3lt5PBdz/5QJ2Zvm7lSNEIvZlppywqzEcNx6PK3FfbkeTe6U?=
 =?us-ascii?Q?oCiY0CT6535+MEGrsz+I/eHgdjL+GQh6XJaESJXGwu4zgwcexi9fvnrxYBvC?=
 =?us-ascii?Q?9rmnJDOvcpbPFmn6Qrd48DFtvvBG3rbtBqQ83ai0DVHgencTEVDmbC4+K9Cy?=
 =?us-ascii?Q?SnxrEcb3hJ5xcdnR5LE+C7IZFUs+PMI8qFFKlVowAjncipPLOh1wiO/MAYkq?=
 =?us-ascii?Q?fiCVYHB2hK4eoZbb+yqEQEO16ZDTk0GKJwQw02YvdYRFZh0dgCV50l2l7rbH?=
 =?us-ascii?Q?NzbYBFQD5lUjFhWTP0aATzYMLu2nb6Z9xCCJEfOAR/IpiLRGoHxcFQ3vCYor?=
 =?us-ascii?Q?kRf57NuXKco9FR2LBFxkQ8r8Oq9/JWYMf2yo0oJN8tZK7he3kCkiTjUz6Vq7?=
 =?us-ascii?Q?W2lDxM1csGm8LlIvlTdw/K+wrqcd5Ty9NXILuHdinhMcoVORZDYJ/FsgiHTo?=
 =?us-ascii?Q?Y7JRKrneo210njdYe7+YHXff2wHdOJlNSg082A+abfI4A65ctVaSRregKnDm?=
 =?us-ascii?Q?6XYBJ1YujZMXNQHfXooTkz1wPBOHBHFiBkqqoHi/BdmOStTzK/Jk0MCDWYYz?=
 =?us-ascii?Q?Fg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CU0mdSjjuQm7fjAVTpCutQvWRjH9b1+OvjLQ4MF/Fsteck/lZFHbTE2cJFizoyNENAYEP3+mtLDt6Fb7VWOwaXwVdp+//9DCJLnKYb6Mb/LKi2jOGLYokrcsMz88pvv9trL0nxTc5KVKV0YnYLK+hvsWEzTQ83UxO1hAUH3HqWkRgu9tD3022eNrxCvcGsOnOrAzWu2LXCModM4nqKRymr+NG751l19rB/6wiERPGjST8nYjlOt9ZkmGikgsIRJ1XrPqnvaUfJg9YhR4k95j9ApmMdXJPJ8p6utvSp5GZrox3gYrVdQaTdrynsKUXtPBE3EI0uEUqYU7kBtr2TxiyVGnv5NkZ3gGrYHZ/qly2ZkYdYbUW6yAHyNXjJl6V6s+upA5v9MK0I7ow5kftG16/nARM7QoAqxTw9qbAbPwbB1CNi/dKRLSoyPdb2TAHowJlwUt1CrO2I8rQtByB1U869tEDMKq3+qQ1PBrsfu/lHSdY6QyCIna6jkrLMqtnRxj5V4MvKeebaeTi8rSYfCfkF0qgP63chRdxSgPeurLVNvuQCa/X6F/+1kNvmuD28Z962r+N0Cf5NSGXF2lJjzpDQ0R4t6fcVOhk3bgsPtou00ovhE1gjLAwgH4ar8G+hvAhYcbhqZyPZMNvTEaWbUeepEkFP5prVd2r2LN1y5cICcRiBBTHkO2m74XUrDPJTB+VQaeWJJB6BtZ+/H2AfE8HdSTs1XkLoDHTrHAWtIKPjeUb19PjoyfmN1125xAGwy4dXKoSULGbkSmmd7ZmTuzREqvn3AEHueVQ5g8SnlwSTqaOR9DiZqIR4nH+2iTtJwbi/0KUPSxIH9GoXaoCWNBAHezhKxAGjh6Escj/WOsoeZRESCqMmOgfnlzUQB3e8IUfhKqJETOZcIF2gVCelXf7g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93719744-b80f-4313-2f82-08db84a45bdb
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 19:56:05.4939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Unmj57IakXWo8WR8HnnEuqWyT2BhL84t79QMRPWkey20hGmNhmlEDhEHs5ahINTablveZukDH51LnvOzKeLXUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6864
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_10,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 spamscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307140182
X-Proofpoint-GUID: aC_tBsQ-9dqElXJz315IV1zK3u9YpN4Z
X-Proofpoint-ORIG-GUID: aC_tBsQ-9dqElXJz315IV1zK3u9YpN4Z
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use lockdep to check the write path in the maple tree holds the lock in
write mode.

Introduce mt_write_lock_is_held() to check if the lock is held for
writing.  Update the necessary checks for rcu_dereference_protected() to
use the new write lock check.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/maple_tree.h |  7 ++++++-
 lib/maple_tree.c           | 10 ++++++++--
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index 6618c1512886..43f18230cfa4 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -185,11 +185,16 @@ typedef struct lockdep_map *lockdep_map_p;
 #define mt_lock_is_held(mt)                                             \
 	(!(mt)->ma_external_lock || lock_is_held((mt)->ma_external_lock))
 
+#define mt_write_lock_is_held(mt)					\
+	(!(mt)->ma_external_lock ||					\
+	 lock_is_held_type((mt)->ma_external_lock, 0))
+
 #define mt_set_external_lock(mt, lock)					\
 	(mt)->ma_external_lock = &(lock)->dep_map
 #else
 typedef struct { /* nothing */ } lockdep_map_p;
-#define mt_lock_is_held(mt)	1
+#define mt_lock_is_held(mt)		1
+#define mt_write_lock_is_held(mt)	1
 #define mt_set_external_lock(mt, lock)	do { } while (0)
 #endif
 
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index cef47ce8eddd..722c78077b25 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -777,6 +777,12 @@ static inline void __rcu **ma_slots(struct maple_node *mn, enum maple_type mt)
 	}
 }
 
+static inline bool mt_write_locked(const struct maple_tree *mt)
+{
+	return mt_external_lock(mt) ? mt_write_lock_is_held(mt) :
+		lockdep_is_held(&mt->ma_lock);
+}
+
 static inline bool mt_locked(const struct maple_tree *mt)
 {
 	return mt_external_lock(mt) ? mt_lock_is_held(mt) :
@@ -792,7 +798,7 @@ static inline void *mt_slot(const struct maple_tree *mt,
 static inline void *mt_slot_locked(struct maple_tree *mt, void __rcu **slots,
 				   unsigned char offset)
 {
-	return rcu_dereference_protected(slots[offset], mt_locked(mt));
+	return rcu_dereference_protected(slots[offset], mt_write_locked(mt));
 }
 /*
  * mas_slot_locked() - Get the slot value when holding the maple tree lock.
@@ -835,7 +841,7 @@ static inline void *mas_root(struct ma_state *mas)
 
 static inline void *mt_root_locked(struct maple_tree *mt)
 {
-	return rcu_dereference_protected(mt->ma_root, mt_locked(mt));
+	return rcu_dereference_protected(mt->ma_root, mt_write_locked(mt));
 }
 
 /*
-- 
2.39.2

