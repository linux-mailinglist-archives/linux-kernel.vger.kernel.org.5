Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9CF756BBE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbjGQSTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbjGQSTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:19:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5235F19AE;
        Mon, 17 Jul 2023 11:19:21 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36HEwrGo028923;
        Mon, 17 Jul 2023 18:18:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=rHfjSNkVAEriO7MGs6R9fa/S3F5tV/SjhOCElVSk0lE=;
 b=IQTG7n9HHl1u6ukKU4P6vDxkoXA7Zu4nosuZ+DdXrhEV/NHM5luqB/ZDRXrlqU3pWrJX
 Wt1bv9fbYsGLR+n+iOnfH0vFpOiBfDgNBQSyZ++w/bNEuhzS3PtPbzCu0LzSEHFKKdiU
 n5bdAAbW91DcqVuYed4VTI7j2B2u4OGLKPoCHGSZym5cTgd73MNxcZjznn4HaaIPjRKd
 kl+Gvc46t1yZPgunu4XDvU+UVDat3gxtkLnitpxen3/LPIJSYKaXeQi3d2+psY9KHwZa
 3mzF5gRBVgS7pzo9wFJMiPaxvCUZ5tlNny+5j6spm8kf3is/I0B1/x68yJqtFp+LqFok YQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run88kc0n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jul 2023 18:18:52 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36HHblxq019210;
        Mon, 17 Jul 2023 18:18:51 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw4hfjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jul 2023 18:18:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3fRde6YHbiLsvPqUYR50GUFqtUvurD0kiozyghfVC2eSGI4aHePYLmvStOWscIsDYXWWao2GE9jD8LGwWzUjkTDd0ebG44QWOa2g5csmRnXkshPCp2/+H+g9BYkxl0NjQw41Fk97DzkIR6kmp/EeSYQhaZ7jubzPp6dfYRMU0PZNkDaiysKfsisTK3TyCfxEBVnhaaroGLJ0oRsRNgQDzhRnuPq/mbOTiSuULMsTlu0Pnb5olZvml3d7/9EJvYWkChaT0NZQNmXOEx2FGhJwGSsDZ36CH8WSy4iZMr6QDgH97ZLbv568NAYNSmX5YH0PQ8vIHasl2c78cglZENeTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHfjSNkVAEriO7MGs6R9fa/S3F5tV/SjhOCElVSk0lE=;
 b=eHG/p5vG0wQzeDktZz+ZEdK5NSbp+c5vkMlLdK+vjiwHqeOUxloqBRMen3uZ7QXQFIexMTKIOmmyrfcVqkH+DVf4zgfn//dsD9N7LVNGYh9MwvZgdtrg5msaoMlA3aVronaDSCwyf49n1HyyU6+s6di79gzwWgxPYzfQFEc7ajNVlu08pGBZ+RuUJs2u39aIQQKYVs7L3/mGtzaVRocEwumjsGq2dbVgp1056QY3mJBsMq+W8OokWhEar3ul6BlPH9v+NWsPXi3jT8F8aHslQOBgLgrE/q53hB4AgZAtb76we+MGV1F7J2BATMcMAsJe3krxY1ltm6Vk7e705jEf6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHfjSNkVAEriO7MGs6R9fa/S3F5tV/SjhOCElVSk0lE=;
 b=TTm/rV9Crcg4ljlYZ+lTSQi+WBuSM6/OKSrwZCK2//fy10aJqe5sNIh4M8xFGsQi2LOlUTeG3Mh5g2MTD2bu0rJqDdOKgoVhg+kxdgO4iUhUMll/xIG5GRGZOAaab8BJuUkwsoR+5MGLE0JHxUeav/a+L/g42NQ/BjjJwqTalF0=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by IA1PR10MB7446.namprd10.prod.outlook.com (2603:10b6:208:447::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Mon, 17 Jul
 2023 18:18:25 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::6bff:7715:4210:1e52]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::6bff:7715:4210:1e52%7]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 18:18:25 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        linmiaohe@huawei.com, naoya.horiguchi@nec.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        stable@vger.kernel.org
Subject: [PATCH] mm/memory-failure: fix hardware poison check in unpoison_memory()
Date:   Mon, 17 Jul 2023 11:18:12 -0700
Message-ID: <20230717181812.167757-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0018.namprd07.prod.outlook.com
 (2603:10b6:a03:505::22) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|IA1PR10MB7446:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f17901c-7f8f-4a54-88e4-08db86f23637
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ncO29eV0RZlirGjaIKdMHtWS4wYOrK28XB76kGEPGKgdFJ5YYFteCxPnzEyM93FyS7U6byBwLOkV+QzVsGytrcgPn0dDV6lJW7h3tI5AAslX+2nnhk/OSOY2kfkUSAfghG3L/OBSbXBTAjuHsxTswLCTTlUQ0JcW9csSL70BQMz7T/nqkIbvFtgLsnJ6csCxe76GMtnQyIbN++OpJ+EAhBgQ2EfQ20cdcXrCQAWP4SBNqAe2BVSM1wfwpe70hcVJml/LitbPK6P0AJLhsI07XG8FOAw80K09080LrwgsDZr43gTWUaoZeIjtzp8s4ruwDW0Bylv9vcv5hCqHdztDIYQqzI0WZl0y5it+r2R1JBO8LRwr1VFjTzLEonQFwGFiVutCKTKEbLNiDjhAEq8HuD4njgSdgSey0cMiyZGtLVX6SOzYIw3OVqvkzQap4N8hFGdWMQ0Sg+Ls5hMY/6b/oe1yGlFETlJc2qhR1/zFxkKKq73ICQ76HrizH8fFNo//SxWNwSp/pwnBpJpccD+q8XzdG4lgXfBbUMkX20DLs4E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(376002)(396003)(39860400002)(346002)(451199021)(8676002)(41300700001)(66476007)(66946007)(966005)(2906002)(4744005)(66556008)(8936002)(6666004)(6486002)(6512007)(86362001)(4326008)(316002)(2616005)(36756003)(5660300002)(44832011)(38100700002)(1076003)(6506007)(83380400001)(186003)(26005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PwE6BOpO153nZLK61WQ8GxfM4vOlzZWISpsp8vEWjVGsa37hAWY9bxF+QwH3?=
 =?us-ascii?Q?ooJoTGv0/gT0R7uQoGtfwW4dAsZM1xgGFaFsmCHke9/bUL6nL+ZcastqPR8L?=
 =?us-ascii?Q?i5JZ/tIDdwoncobO7eo2XIgVNN9k83JSpA8a40gjFNNZ3QhtDp8S0/ZY98+5?=
 =?us-ascii?Q?ktVGvWIH6XpyfFKdFKlLce72MX9vz7xLBnGrz//zNm9ILmfH5NeRPmqmVPrh?=
 =?us-ascii?Q?VLz/agVS3TEmCel+0MBJfdHdSe6x9b2/XK3a/uVv78ZLr7ycWsbbaeV62HyX?=
 =?us-ascii?Q?3cb1JytFFSivnLfkjC8QdgdG4b+JGJ3pKwFfAatTCEh53pY509QYfmz2w2d5?=
 =?us-ascii?Q?sx7CMCKtkzOAtXs9DtDxeC/Hwd/Krf4+8mmSuKhki7GlHLtIn1bjdJrTLWwW?=
 =?us-ascii?Q?h9eYYBSfGVdHKwLEvWwDW9ty/bMdaqSSHMEOG642SdG5sdOkBHaz5eWqnwrd?=
 =?us-ascii?Q?hKyWxVB+OseAJat20i4cTKcw6fIf/3kEeveW0OWkuXSalfKV/Rx7IRy6Nv2R?=
 =?us-ascii?Q?8ptFf1wMAHQxsSSbZS0+5iaejOgPQyZEhGjUzvNzdCCAuF1Qepu7GW+s8T3u?=
 =?us-ascii?Q?KI0Wnm7K92C5dAKVGvvl0EeuaD9ga4CDTckAwsXPyxtwoIuFRsn/AmUxYnGh?=
 =?us-ascii?Q?BNgucbRF8YtQSB32XPlw6U1vfshGlaQZfllwIGSH9ZAFDrWzsRjHFvICWM3F?=
 =?us-ascii?Q?0xbOPcS/pFR492X8Lmr32UBFpfp9yRqdBJz3ivrcs4GpeX0gf1smefG2NCh3?=
 =?us-ascii?Q?2nNhVwcsUuWAYEzy3mX2IM609UWNS3vyNMMo6Lbq0DU0ldbZ9Jyt6cK28HC5?=
 =?us-ascii?Q?ryxV+KqWtopB1AMlvy/k2oHd8xTJ250XTkAK27RCk3h/eN7BYXC4W6t+MV2k?=
 =?us-ascii?Q?CbAOo4foiZQONbBMvFsSutN220pj5mvMBu0yIhW3NS46eON3aWvh5PiBSSrW?=
 =?us-ascii?Q?5Kv6DByp3OkNg00VeKDJUq9MJRy4n3mid5e5a6LQawXDETllC58NAQ2iWVcg?=
 =?us-ascii?Q?LPxxHQa5hPk9KIxRHmZhXwGAdCtDBaCyTcvkt43ogu7ZjM4p9r6n09iN4Ksj?=
 =?us-ascii?Q?94i7Vlc32nHdla9US2O5Gtu9Yx0S4j+8JlS1AJqLwoF8E5IhjKyJeQ+/ypVn?=
 =?us-ascii?Q?8vFKwqiqvVlqnBHrALE4P0XVk6IpyLAqHQAqx8THIyTwuLxbqia6h4rMpaT5?=
 =?us-ascii?Q?9CotmTQ14m1GBhOf4ext6pLu5pXuZGAJbKS9aJUXNbEITl2h18X235lmSine?=
 =?us-ascii?Q?/ylgTzOZrOAKm/yV8luqf3SxYRnJ3kLU8nSBKlwoyADZcBhOEr2YRUBGf9MW?=
 =?us-ascii?Q?3Ok0UkgHvarQ7yqLekf8BTl37HoIpqHcKX2xlVhjx58TUc9bj7m9Fogf6fjA?=
 =?us-ascii?Q?jw7MEMbkxbxlICVzKMt+MCiR0Co/lhmLEtWyCyhqqiDrLUI/TjmwVVSjKG+1?=
 =?us-ascii?Q?sQ8uu7ocFCGnBzP8Z47uVd/0kukbTiHcZys+2mu9w7/DsJzcNhPRVvy2WdTW?=
 =?us-ascii?Q?h8ccJiBU2TxPas4VZOHEqGzMmgUE3z4RviWJXehsYMA1AbleGn+DivF/Yrl8?=
 =?us-ascii?Q?19JDj88N0DyLLv7+wcyjWUW0WtlISxH5QacQ8tx+YsiWN4eFO/AQRZHsFnXt?=
 =?us-ascii?Q?rA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?9E+XN07FpyWyvZPW70x1ammkWCEAaTMM4je1Bd6usJBTTxKHm5ywqb5awaqJ?=
 =?us-ascii?Q?6lK1WB6ZCOO37qk+y4diaAc2f8FW9bhIQGWcSRgp8nC6hXR9znOL8Ea6T1km?=
 =?us-ascii?Q?9hhERkGVaItbXeE0ZRuqZU2x1yw98u5Ubw1t32SRa7VT5/Qb5+LyXheGX28q?=
 =?us-ascii?Q?ym3JDK0JQj3vUdavoli9Zx7Hq0pKdpaEmfogTu5VN3bxExniuurZysJKbwJ7?=
 =?us-ascii?Q?9y/7iwQzzrRt0njom4rC9CEgAWiMU763Ki5dWkFz/nt0C5CDQIiZTJXTAVHG?=
 =?us-ascii?Q?8xQ0eQbb0X36huuQqVyFd0od8CPgRAHhhqlAEGj/ZDF0dcvAj2AJchZ1stKI?=
 =?us-ascii?Q?GE26NaBYuDexT0Jc8i2ltG8eDdor+n8BBiOTJOXU3wjwgAvlGJGZ8Lc4MfUt?=
 =?us-ascii?Q?Bi5zoMWxIsGbfpRhqkNBjGt/U4Z4Qq4adBdIvSH4CVctTJi3Cn+grFH/Ggn0?=
 =?us-ascii?Q?DX8jpp4eKgs/aDTNPxzcomToYufhfVjRojAVJ0sK4s+t0Ot8k5TcYCQiOO9w?=
 =?us-ascii?Q?k8iap0y2tqZkYGtSLWl9ovPv5n4dDDBbAmVkoUbXZn59YvaQGcfuulHndKyE?=
 =?us-ascii?Q?hcbbfoVhQcSAVfazI+iA6DzSo6RKvmVqm5hWDt5qC+xOvCHVP/2bkVe6d4lP?=
 =?us-ascii?Q?s3+0xoxgUvXQ1FQnH8VjS+jlDFtBuzDFEoz14oy4SUnIl6PpjBA8r3zJwjrB?=
 =?us-ascii?Q?/uqqfE9M8Gnav04tBMfGnM9vWT6pzAVM9W4H3kjAPJUxuLzdA5DqP3M+ZIwZ?=
 =?us-ascii?Q?GUNPaw9ix0VEwTCTJPLu8umme11p8LMQj2Hl0MvgcWAGeepAA3TTv21LlGf+?=
 =?us-ascii?Q?HFsSYRZ51W8TynpD2uzrE7eGoFV3pWE14/+Krv7i/rblMOGFupsL+JWHJi2W?=
 =?us-ascii?Q?r44W525s3NhW300RLQLZeovnZQnG4vx4bvt+np2463baqr4lhZr8EyHalDi2?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f17901c-7f8f-4a54-88e4-08db86f23637
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 18:18:25.4548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OyOkGiBmNacoqQwEFQ3WCsBI/oLlsCw/MsC4GOTBvTsSRhQVzwKdVYg8ppYwMC/AHEe2FU3d+ar0bo2MqJkdRSQhTPN9cM1wB1tT9EGlHOE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7446
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_13,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=989 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307170167
X-Proofpoint-GUID: P67nX16UgWE2s0RlTlaYly8OddGQPhMg
X-Proofpoint-ORIG-GUID: P67nX16UgWE2s0RlTlaYly8OddGQPhMg
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was pointed out[1] that using folio_test_hwpoison() is wrong
as we need to check the indiviual page that has poison.
folio_test_hwpoison() only checks the head page so go back to using
PageHWPoison().

Reported-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Fixes: a6fddef49eef ("mm/memory-failure: convert unpoison_memory() to folios")
Cc: stable@vger.kernel.org #v6.4
Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

[1]: https://lore.kernel.org/lkml/ZLIbZygG7LqSI9xe@casper.infradead.org/
---
 mm/memory-failure.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 02b1d8f104d51..a114c8c3039cd 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2523,7 +2523,7 @@ int unpoison_memory(unsigned long pfn)
 		goto unlock_mutex;
 	}
 
-	if (!folio_test_hwpoison(folio)) {
+	if (!PageHWPoison(p)) {
 		unpoison_pr_info("Unpoison: Page was already unpoisoned %#lx\n",
 				 pfn, &unpoison_rs);
 		goto unlock_mutex;
-- 
2.41.0

