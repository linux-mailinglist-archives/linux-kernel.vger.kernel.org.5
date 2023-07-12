Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9676F750FCE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 19:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbjGLRjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 13:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbjGLRjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 13:39:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C761991
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 10:39:38 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36CHNpgM025592;
        Wed, 12 Jul 2023 17:39:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=Mu00IWoaiESpur/NU17ypugtUhCHRDo1fWDsl4ikAL8=;
 b=37U9FLt0OzpWApnCHQZvKPy1mwhygr9YHCRtTjUtX7/JtRzPodP5W4P+DYno8c/Dq0HV
 9B64WdHIfP0DIGPpgOmSqBZoBe+NWvjUSEBFtaaj5qkFycEz5QPtQDh/Zv7s79x8yfZx
 wX7nUtdKcYQuZKt5ukMWnv9YhqZqww8W/5tytmia44OMv+uRCrjlyUEPQ1RRdGHRBKVK
 wIOra2RmVqNOIh2iG9q9H3Mpz5tlsexqru1smhfolhJdDNt1eC0MhH19ji4NW8vEdvHV
 CzGSxN4tFBRP5AhsHJymGpM+q9NeOy+0/f8+os5OOBHvyqb3n3YuqBTf0RAWR3/CM7/y Ew== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpyud7ytr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 17:39:31 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36CGUFsL007149;
        Wed, 12 Jul 2023 17:39:30 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx86y097-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 17:39:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N65utcbhr7l1nOoE9tQ4/z3S8LL26kpkvIpu9LMgweYar5rQnuPz5rDoe6sHD45MJYNVLhhieAoIoCmSnxfoIw0QfOJoLZ5Tk/Ax+/aH1rs6iHZpF9iCpJ8D+bakp4EV5wewHOTv2BdWTsrNL/5bm/yGpKb010X0QVEnB2dKoDakkxwL809vMvX0DUqELijRSrJvv6H2jxkwh/sjUBi/vbp+nevZiW4Q0CxV/Yk1tc5DQhwV2vNNJ9PRNL1KC9kpcLsJySDSkkJtKU62lLM5L0gYRJsafvQ+4YDKxKsNwrrlNy/2+yC3kj5vG/031BPDAnvzb2D1gSJ84/QONuXVYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mu00IWoaiESpur/NU17ypugtUhCHRDo1fWDsl4ikAL8=;
 b=e+jf3tNr8Qf8u1eNTWyLBAXnaa8UbtMLgGUCU80T2ZKFc2KP1qfvvEGajAPqydO6rnB1dLGvwGNSK5n7b6fzEqsA9nucn2lH0nS3TSWrBoay7XIANQxwy9c/+0uB11T1aHxl3WbOUNYXUc0f21GKo5K2AwyqJrnzY5N8UFelRokrA+X5R+S9nd1qERt4nBQqS7G23myMn6Xq232GuWZvZnhDuHGe8nT31ZyEPHu13YTs1ANDiHfxl+o0lZfZGSnolT3OCbAG/b+Vb/rPjT+nuPP4vLfrZolzwqQ0+WHAffGLuNorGu9o9vz+M/y3riAdznb3HuFS2x1r6OOeISl7Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mu00IWoaiESpur/NU17ypugtUhCHRDo1fWDsl4ikAL8=;
 b=Bfz2NgjY8g/rlXBLxPbWbdukPBWd2ogYo9eiXbckawCfcsI8ThkhVrkBSnUy6wyts27yTZ0QRV/Kw9J5zA6dXjTbJz3yfTme+6k6D2aLyIWn7gVArvsJbEvzl15JQDgSm3oRNUaRMzVj4KsB9KRJ4DlMlOSD+GdB8Lxz0YAJ/Fo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB7359.namprd10.prod.outlook.com (2603:10b6:208:3fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Wed, 12 Jul
 2023 17:39:27 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c370:eff7:9ddc:f188]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c370:eff7:9ddc:f188%4]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 17:39:27 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 2/2] maple_tree: Fix node allocation testing on 32 bit
Date:   Wed, 12 Jul 2023 13:39:16 -0400
Message-Id: <20230712173916.168805-2-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230712173916.168805-1-Liam.Howlett@oracle.com>
References: <20230712173916.168805-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0178.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::22) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA1PR10MB7359:EE_
X-MS-Office365-Filtering-Correlation-Id: 875befa3-28ed-466f-676a-08db82fef0a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oDGtCbs254XTT3WtsqW54chV2dbaDrSq+D7EZvnk8aMjd6EagWcf8pXKJ8xu1QZl716hg/OYLPXE8C6pAHizx22g2g6TbPUp7ySsgxNv4jP9HLlXChQjLmG8IGlHsY09ytXFnni5C6qkuIlpYyjpQ611q+Je2V/NASY1J2HhgB1h6hBTxAOSJzApHwVkPxvQXWV53+URhzC2WHFQly2TRUu61EBAGMIFu6/7sReBoBHf/qRcwB4MKSXw+cmPgophdRwv7kI2GmFm/2D+TTIVrD+fkL+dpZrRnBUhW7Nk8729xuZKAQd+rcJ891L/E7pAdehIgK7aPhUmXpCFyjrygwtKdDjUSJuH85oKobsscKo8t9ObNsig1OYNWn1fqnUoadp36okvVe0XsISLhfbP0NJ0XaITynUWtE1eDSJ1A60Uk9ECrHLKs5bKFxeIPTuRMtHuhlJqrih+j14oDSERwg1kiZdpnRZ9rCJN8wwxxEU5FONJaifoyoOi4i4qIHW1fx/XaE80qve203cwEfdoL/wcOskUjw2sVTOfsIZaC1Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199021)(4744005)(2906002)(36756003)(2616005)(41300700001)(83380400001)(5660300002)(6506007)(26005)(1076003)(186003)(8936002)(8676002)(107886003)(6486002)(66476007)(66556008)(66946007)(6916009)(4326008)(6666004)(86362001)(478600001)(38100700002)(316002)(6512007)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+Qhp/wPFjM6vgWIMVyg56tbv9TgoSgnMcaaw+H0zt3a/r9/UMrmIM+Y4tvZi?=
 =?us-ascii?Q?cSF+1pP9Wa1LhiTAYa1QF02cennjq85+tm2UttuFdzIPSN/CvFf4J+K5fI4K?=
 =?us-ascii?Q?Sp8u2/a7MCR9MN1kYK0oOJ2eZVQUCcOiQh5dwULHmwuwO7gJHPxhFZsjmShz?=
 =?us-ascii?Q?/uRwGdo37Jbd4Z6GMS4dOnlNAV0+MwWP7Yeahy/0kEWF0nIU/bMz7fV+oiNz?=
 =?us-ascii?Q?Ffl0UBL8+YpNZOIXmxyccFwftQlHDjabfiBqjz4id5yAXLCfQ/vzPHYMKPm4?=
 =?us-ascii?Q?T6aaDHLvHIEUbFVHhoub/fxEjNZ3P3wLjb/Uy3b5hDEo6IrFHPaTgzxZ1AHL?=
 =?us-ascii?Q?4ZYdSHRmZFN6duMme+yuMFKRcsftyodTATCD+nOymen1PAqJeyeLAghFA+rF?=
 =?us-ascii?Q?YeReq+3XbQsIp+t/plmdSjAbOSA55NIpqPm9pjz/Az3UbAJUGM0u3bbWbApa?=
 =?us-ascii?Q?aLhHI719IVdm+el/QyxUrg86DFe+68Tm34to9ZGSXIS/GgrFRq+O/F0RsdMB?=
 =?us-ascii?Q?qtkafoakqAHwUMrdq9LHv8WDqZl9x8WDJ7ugJyDQKO7pp49/812Do8EHMjR0?=
 =?us-ascii?Q?66PPVaZugvsLx87+0HFVYoVMzWappSQqX+kUfNMSk1YqDpB6+gwkq9qScohO?=
 =?us-ascii?Q?FuW+EZGa+35erW4F9f9MDxJkl0GH6krPF+75zXXb7qLZWiAgJeNcRk8zqii+?=
 =?us-ascii?Q?M3wSTmOo/uLTo1/O8RRYJ9jwcYUU2iR+dVae1Oar8MUFLqcb57hDT3I5dCws?=
 =?us-ascii?Q?MIic7hmtdezcLa9ypHyc1Zd1QlroDz7nRMibaS2Cycn1PXWrUq2YsmVRqKUh?=
 =?us-ascii?Q?vf8vMIx2SV4MW4KWb0BCTzcS0zZj7/aiYmSfKYggWNeXTQ70aI/pkwE60ohO?=
 =?us-ascii?Q?fKboaDE2LnlQS29LNSNhEQMnnHHBLt/KtpnP16iSYIKmbL2GiRU+UI0JAV8t?=
 =?us-ascii?Q?Bz++M2c+Hrhs79Ohd8mmaZiWJ8++5+FOovBt7EuC8/DeSwyFxtMFYmh0H9pZ?=
 =?us-ascii?Q?jrHKoxF7zdeUf9/zIuH5LvCml2UPevEPsD7hc/khZorMbJMl5rnk9/BXRYmc?=
 =?us-ascii?Q?CsWS9ae+G9fB8Sxgc2myH07MQ8gcCxEsDE4APo8QbD6k5i9bS3kR0t8z6lmN?=
 =?us-ascii?Q?IE7P1uvpLLkDpZ6XA4qoY2ipJ4TYF6VY0T+e0AoOdlLPgsEvgpgRWD5XBDDG?=
 =?us-ascii?Q?NRv/U9RRIAEWympXNVVzEJ8UIOuWanKn54swQAkofDrBdiBWdhDVZibdi1Zn?=
 =?us-ascii?Q?LrBsJk2BACPAEFbRpeMPl7UUfe04SvHI06n6VfJnxeH8sKHSwMRCnQItkH80?=
 =?us-ascii?Q?pZmIWNV/IZq04k8CQ9DQ/sErLhlQmS2FLFMsMlMzD6hmlVMufjhfTqsFxBUa?=
 =?us-ascii?Q?FDjjn/TKJpL6k4b/1Lgb8Abqn6MJeBqVZqt0onbZAkkNk9d7ISGbUsdj/wTx?=
 =?us-ascii?Q?rVh8L2nOzTn+Iy8Czw+2Z41ysdPYnk8rzg1EYa4NxaGlFfnhMh+kEbx/1gY5?=
 =?us-ascii?Q?4rvmU/+Q/i31vCp+Trhfbsn3cqdKpVlcD2Oj3pyy7/tL/oVOYtp1g9wqKYTr?=
 =?us-ascii?Q?XdrLwVBekYhq4otf/uUFproLsQuIzB/2ND6Ew1RlwoSi5vE5Dyf+8f4RWNBz?=
 =?us-ascii?Q?RA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /sRn6hjQ2i5hLvJIxBI2ITJZgWlaZRbF87ONiwzHougEUo5KZH9/OQRwrNa5nqrSTb/Z8iMunAZ0FpngySGGExLtvOjyi9ObjaRTyiD8Vp5F3HQ8kOUvQ4BPBjXGawA1PxJRKZV5aHSUCq/3+8D7z0vvLiM52ZrkI/MEtSIBo5ao0dYEsYGS9pzQ2nqINj5esHsevIVAJ9q43FE6KSTbDfQ4QhJ/nCAp4ykIQgJPxA958dSEzueMVsrZDCBerGgMzJTFmjBE2MxaNqgPqQ4+fN7OKdH/5i/rqGx7OJuIpcJ0vmRcfXU1VAr6yS9E7fLQ4NC1WLXKvmOnnLx25vdfZpHGmVhsVN3hu1BpzdBIy9ZgsEiB+uFFifUmNlc5ba0mqJMd+y3gAb63Ue/8GThC3ZzaUhf/Z6ErQWgS/yzqMkarUtPm4HQyvEfJp1eePYUF+XIc+qoRPaRj2ragAXoA3PqjwJW0+UQ4bRf9+hrjxwT9EFFvaxbXZ4jRErg32ZA0CefAFDmg+9doZ+YdnXRsG1zIUIT69SFpkhUulG0NvEvDjnZmcjW6OtgOz+RLk+YK8d3or+qRweGG3/PHSewcnD5OtMMRomDtgVnMlfRQ1ukoV4w415lswmfcs6r58Wx1Sr1Nm4QYFyq59T0JWZin/VXKCyuPdWEckg6H+QB5z0qkKDY2kdhyiK5ZkBSxQEYmOiUEKxmpMe6ZeDOGZG15kzdriUFsX4JFCwmd2DNpH+Mk37yIGNlaz9AUhJlPq9Zqi+xx3pgoEZrffXVj70emH9yK8A4cdqjEzLew0zGI/Y578pLrckkXzegPp0hV76z96DL7D0AXz4qh+Osy5dNivztE2JQsULvtElKwhoY6wRuEpgun+H2T7pJTbedy9hGz/nwR8J/PteA5ATDpJKPqOg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 875befa3-28ed-466f-676a-08db82fef0a6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 17:39:27.4777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M+WZDE9pWiIunY1sIlvlCHQd0tVcmc4+t8Tcdw/s3IghNjM1eHJ16XmVoMjkzJA0SYnP2huRDEVdTeIx5JUcMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7359
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_12,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307120159
X-Proofpoint-ORIG-GUID: RT3iSl__JUb8e-2mGwg_CAZR77ATrWDH
X-Proofpoint-GUID: RT3iSl__JUb8e-2mGwg_CAZR77ATrWDH
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Internal node counting was altered and the 64 bit test was updated,
however the 32bit test was missed.

Restore the 32bit test to a functional state.

Link: https://lore.kernel.org/linux-mm/CAMuHMdV4T53fOw7VPoBgPR7fP6RYqf=CBhD_y_vOg53zZX_DnA@mail.gmail.com/
Fixes: 541e06b772c1 ("maple_tree: remove GFP_ZERO from kmem_cache_alloc() and kmem_cache_alloc_bulk()")
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 tools/testing/radix-tree/maple.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index 312c0d9fcbae..9901ae821911 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -213,9 +213,9 @@ static noinline void __init check_new_node(struct maple_tree *mt)
 				e = i - 1;
 		} else {
 			if (i >= 4)
-				e = i - 4;
-			else if (i == 3)
-				e = i - 2;
+				e = i - 3;
+			else if (i >= 1)
+				e = i - 1;
 			else
 				e = 0;
 		}
-- 
2.39.2

