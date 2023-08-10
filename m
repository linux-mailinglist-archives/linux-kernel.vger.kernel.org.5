Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D37B7771DF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 09:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbjHJHr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 03:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjHJHrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:47:53 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD74211D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 00:47:51 -0700 (PDT)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37A702ox014269;
        Thu, 10 Aug 2023 07:47:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :content-transfer-encoding:content-type:mime-version; s=
        PPS06212021; bh=kO2unsl0pxbA2sfGTphXE1MHCO64iOliAz2mFZSmsc4=; b=
        Hmtw/EveHgAe+5MVMEvsozQMtUwCvVt5bmqc80EZLkynw2GdilhjXFIQpbG/QFxj
        wY3MlMvHfX0UvsPZjBcAvtff8DtIyypB3daNzdHsnQVZo+NTyvdega/ueZD3eshX
        vejFrvoMbKEm3dL4k/f0bc7C/eKzU5LmF3R/a9xWppQbMBmCVuNusMMYL1LM+Q+q
        H7zMDWLuD5uGD1s0y/E7JzSGbbfg5HwCATuoalKoPLo9k3AjJzdj3ejkoFoJLywG
        cc5RgzrVzvqf8Ee81iwapSDll98u0SxwJlseHgUwERvMS1t35GJ1Y65KuuhVk2E8
        pKK0oYL3PfkmUCxf5xS+Dg==
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2049.outbound.protection.outlook.com [104.47.73.49])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3s9dd64msq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 07:47:27 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QszQvue1t7qm9J3IxwYscn1IY4OyTQ/8zyYqY6+CTiJj1Igf/3PHyEozJrnohNsG+flFUcuVfrxPBIeePQZSvBk4HzGKuvNgyiWZZ4VV46qZBc5CBRTd+/VvOR8gWZQ/39icTgGW+GrZeo6AVZqFjyhClTMPKQ/sDvazow8vCyTUcqJMt/Xbs3q4UC2yAFYZE+RH6l2DciJO9INLXAYS5YA3CSi2gpd5LQdWWncGSDl2oD+JiCKA6VpYxpTEvIAZd29YJ2uuSTHLiHy5dgMxxofNn/OFq1lSVTdFBHx5a1TrY2A3UcbwwZ1GxE4lsu0rbnVuvhpA76YY+bm4knbacg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kO2unsl0pxbA2sfGTphXE1MHCO64iOliAz2mFZSmsc4=;
 b=O/zeCeG64OMxsAdMOl5xgJRl7AD7f+9a9wypJpQNGeE0PHUcJS0/qpNNp4KGUdUBlsp8lSIGWytSPuwLsVYzQqsh5lFQPP8mus9VSrG18Px8OquaSmQTkCVZOBV9oCLHFjMlrIgUVclZiOerEpR7K733uQEfadW6Yg+YF3AK4Bkx3MKzkPz72O6kACBOZhZPdlMiLwYOhPyDoYYNX+OirOBij+LUSLWlTiaDvw9xACZn0RZjG1ieMD6BgB/nQZpJYi77ZBsBIj71QfrxpQJanRspBb+dg6mximan448h246Q02bqPNUuCM2NTWCgudoHPze8uqBPzGtCC3OHknDiYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB5769.namprd11.prod.outlook.com (2603:10b6:a03:420::8)
 by PH7PR11MB7497.namprd11.prod.outlook.com (2603:10b6:510:270::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 07:47:26 +0000
Received: from SJ0PR11MB5769.namprd11.prod.outlook.com
 ([fe80::1b5d:f77d:a3c1:ce4c]) by SJ0PR11MB5769.namprd11.prod.outlook.com
 ([fe80::1b5d:f77d:a3c1:ce4c%4]) with mapi id 15.20.6652.026; Thu, 10 Aug 2023
 07:47:26 +0000
From:   Xiaolei Wang <xiaolei.wang@windriver.com>
To:     catalin.marinas@arm.com, akpm@linux-foundation.org,
        glider@google.com, andreyknvl@gmail.com, vbabka@suse.cz,
        zhaoyang.huang@unisoc.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] lib/stackdepot: Bail out in __stack_depot_save() if the stack_table is not allocated
Date:   Thu, 10 Aug 2023 15:47:03 +0800
Message-Id: <20230810074704.2042664-2-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230810074704.2042664-1-xiaolei.wang@windriver.com>
References: <20230810074704.2042664-1-xiaolei.wang@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:194::8) To SJ0PR11MB5769.namprd11.prod.outlook.com
 (2603:10b6:a03:420::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5769:EE_|PH7PR11MB7497:EE_
X-MS-Office365-Filtering-Correlation-Id: 204e435a-0cae-4280-0c50-08db997609fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ocYoDtvZvI2IdH4t1oJTzKBxV+B3mJkzys/E62kbmA7O7w7SBc+IJmF6+PLGdPpi0fbFYErk/hQ7zs7ZgE+bfBL96Dd63EvN04jLn2uer+e/mMQjRShjuHKFU3vfUn1c7ZfIgMTQS5Q4r1AwaqM0j3AyQnPQGJVQwTTFYVn3dd5EeHs7cw0RaJBF3kDB2r5jfidynt3rbK2SE8tAOTnMJfXh1KDCMSkaOCEA6EJ74vx+iz4l+tSQ61AQRJmuq2BsKLgvyxSUP3jXOpm6kT17hixQZ2obBFebKpGx1l52PdvIYdk2l5JVNLzaeSWyK9CfDRicqB7RVShX/Lm6TbSrQPPJV7iJzcW3nSvr+/VgO5c6Izo9kq85wj8VCZ7sVJZB8u/R4wN+I7Ovejz847BGP1I6jrQn+zo8xfjn9xTzPBf89nN+Gqqb5FnersNHTuHLGUEjE/OXZ5jWuQTpQJ7ZMBaWck8StV8xQYxZEdNCg0srs0C94dR3z3cwQJE8V3juk6W80CyycBPGG+z4GQvXdmqSIvLL6m3vCk2aMNc0gMkxeObyy6OVMrkLHCuA6H8M/mzv4jqazET+XJvzidRWv7fTlsqM0CXj2rLKu/s8kCM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(366004)(396003)(39850400004)(186006)(1800799006)(451199021)(2616005)(316002)(86362001)(478600001)(6666004)(6506007)(26005)(1076003)(36756003)(5660300002)(8936002)(8676002)(44832011)(6486002)(41300700001)(6512007)(52116002)(4326008)(2906002)(38350700002)(38100700002)(83380400001)(66476007)(66556008)(66946007)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iP3OaXL1JR7WFvIXLAnb1cnoK8BLABl86HmKV7icXHHPuSs7kvM/+oZPZchT?=
 =?us-ascii?Q?EE3qAMJPPdJvmVnpghoxbLFqq/DjX3gh9jczg1plPamsnrclddcKsKWyyDPZ?=
 =?us-ascii?Q?KF1EcS9YJFwfNX3ymZwkB6Xsdpd0V/wzcLO2Cy6URXk/ZeGlTmD/zi73Mlsx?=
 =?us-ascii?Q?8W4bUuV05yLi3VbNW6tC1phd8Cjoux6tDJkXumveez2wM3TB06B3sNpNiX8U?=
 =?us-ascii?Q?VhOEfxlkFi7p6Oz5Y6fZ+cXEL1YaYGoWvPKHaHUKjxDUZbS3pFyV18Wnq0Fv?=
 =?us-ascii?Q?BTHo7bxrDD7AjqlWQo/mm9sPOBzTh8X2PjzpVAIBqpIxYEpoIjGfTighMmdm?=
 =?us-ascii?Q?ADK6W9XaWFSTw7xlzVhndb5rCV6qN4j4CqY8MzdcxjjFPBaqHF9lkplpZzt9?=
 =?us-ascii?Q?V7Sw42+9vV1tA4yGHr+IcEmoR2ahupzb0UIPrEdoNsXXLGUxMjt9FYXdXiNF?=
 =?us-ascii?Q?F8gT8T3PMO9/mxq9i85QGuEuHZbHDWcn5D1vJDgZxh3NvUaL3tSZtI2fmRKE?=
 =?us-ascii?Q?MayIMnVIhzGyjRAkiW6SjpksBkpjkETceWJnjppxq1kWlP8sH0EWnNEpf8tg?=
 =?us-ascii?Q?AemOQgsTtHszvRqtHFqVd83tIdDYQR/MReOPaTvi52szOP3DS8/H9cgmfk7M?=
 =?us-ascii?Q?GoI8acHAY7daAN2xFS2fJeGpdwbcQHOa7weEYPADNMpb9nYU/TM6qpE0qr2O?=
 =?us-ascii?Q?jYenBNlWHp6lytd+x8T0epTDl4j0zxLqia9KpqOx9WcC7tc8ZXIwIq9m1PaC?=
 =?us-ascii?Q?UxdstlE49T2n7RaTW9qpt/FCq/RWkdI0kvIeVoznic5LI+StNARu8JXm9bhf?=
 =?us-ascii?Q?rKbMUriP+KIAeu4dPIsPi6azu/nOsTxMEQqaEh/9JNyypKJjx0Mbec5Fggw1?=
 =?us-ascii?Q?KLLTE8CVVWWKSY5BABNev6VWPSKkT/ljyoPeFkAISMnOvyEG6JMSLtwWmA3G?=
 =?us-ascii?Q?ydthaahX/omdpkpD7zbUEOcyBwmd+vKI/QjrWTO4sBekI98J4xaLx01R1h2e?=
 =?us-ascii?Q?CwVRizPS6iGHDhCKS2nkmtp2z30uBHE1seEd2GvLdXDRLJfpJxkOuv2mU5Dg?=
 =?us-ascii?Q?Ld9xNhqkaRp8AyZtYLXXJB5/Ad/LDBh7McZ0+Q5bcZC65zt4ruq2u/gVAupa?=
 =?us-ascii?Q?+pEPIydTYcAMkfm1xR1fHiovQRbiIl45vkc2FtoyxwwEkQgAzvYX54EsZGQf?=
 =?us-ascii?Q?nJcRbpo1pekPrhi/gGtr2Y7dqRZTxYwGAc87T+vTASzQhyTu5ESVO+s7t9cs?=
 =?us-ascii?Q?MGILsAVh+wtc0KE08PNM4afkFzOJ4g9BxS9Un0540kkGrFrN4AYzCFRuig/+?=
 =?us-ascii?Q?gigh4CgLoJ63bvRRxBbKfp1KpFVEQZw352ADvgE0Y4q4jXiyXy14hXoTM6l+?=
 =?us-ascii?Q?sNoVyYwTyCsxw9U0IvCk94yursQi9AkH9qTuu9ywLgzhs2Xxs4woiLnZqOd7?=
 =?us-ascii?Q?YysYmxfi6jnbnf22EGHXY18BzujI1nmzb1K8nlkHRl3gMXi1kFB8r/5/Zztb?=
 =?us-ascii?Q?H4KN6YehzLtJtZqe74RmOdkYtAV9gQ5fA8IYKkT/nKGCak5ZqyOhCRAAAxWt?=
 =?us-ascii?Q?VDrEELN5zhPKmLhe+0Fzwod6zzDMX+zudpzFAmrCTX1+pycsbK+Kr0fSXeVq?=
 =?us-ascii?Q?Mg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 204e435a-0cae-4280-0c50-08db997609fc
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 07:47:25.9542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CndRtmNA/YyU8Bcd65+FHXNLfmjaDsIwfNGEVoOcv7Hd4ANwPiCPhzpoP5yBz7At7xbbv//hG++hu0K4Pi9TJJX/3/nkgwh3brqHJ6GNonY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7497
X-Proofpoint-GUID: 24tkBtBO4qCJRhzpj64h80Heo7lmGNAY
X-Proofpoint-ORIG-GUID: 24tkBtBO4qCJRhzpj64h80Heo7lmGNAY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_07,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=645 impostorscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2308100065
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __stack_depot_save() may be used by some subsystems even before
the stack depot is initialized. So add a check of stack_table in
__stack_depot_save() to make sure no oops in this case.

Fixes: 56a61617dd22 ("mm: use stack_depot for recording kmemleak's backtrace")
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
---
 lib/stackdepot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 2f5aa851834e..a0651d013a0d 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -376,7 +376,7 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 	 */
 	nr_entries = filter_irq_stacks(entries, nr_entries);
 
-	if (unlikely(nr_entries == 0) || stack_depot_disabled)
+	if (unlikely(nr_entries == 0) || stack_depot_disabled || unlikely(!stack_table))
 		goto fast_exit;
 
 	hash = hash_stack(entries, nr_entries);
-- 
2.25.1

