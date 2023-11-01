Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB667DE52B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 18:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344717AbjKARRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 13:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344705AbjKARRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 13:17:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996F7119
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 10:16:57 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1GYns2011163;
        Wed, 1 Nov 2023 17:16:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=PGGPZkBfMPqaWIX7oee9bFsdlqDpITkuaeredf/Tkiw=;
 b=1TX0YGJ19cS9gAV7JLeK8O+ojrKh3obyy9HNvbYh+UXY0fnFG8LmfNVPAAaa424q5l6W
 GluZ0tDpsFjNMm7dJGLUntrPOY6g5nqMeTLTyelzkail+vAUCbuijuupCuIOyBEzjFhM
 fBe9y71kpdNjWiEp9OWO+9DmTxvnNeFEFyhfZSEO7BW0K+oKcVaeUrzjJdTw+CfqA0kC
 /SuBE/YafHDpq1OcpXo2MUYUJDuwpvgN3hPkSdPhCxgEmXDBPTrvy2esA4ePvoRraNSh
 KPGd96MOqUhYBI5V1bmjmemnAnJ5sfokFw9/AUqtnLAB7uFg48ZfLp6cXyaYmp1Mj000 yg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0s7byxsr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 17:16:50 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1GcOVj009098;
        Wed, 1 Nov 2023 17:16:49 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u14x774r4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 17:16:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRjH4H0MQXlYfz6KiwezedaHElh5eyhkHhRmQzEoXP3/WdBLjLqZp0AVZamE2aHsjLxm3Lkcp0ekgw1dYuBMAFpEdph6GSvQ9aXoh86iFTWGQ2WgLbOsgw4ouwvR+CJItbbTA5XqF6q9Uz6fhGiHQIKjNqHaodtwZAP3hB9Ir9NITjbO19y5VwJg4sBdip7qMSW5MkszqFBAZafBh9OpMQePq8RCkbXLx1TpijJlwmsxxPtgAvynGNLuhZvMJM3ulbXCsY/gO0AjziUBn6k3IDk6aJ5NyUsuIGNStz06E55gqNLry8vHJhXfH+vx1zrFd92k4HvOH9cnLGYikWTUdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGGPZkBfMPqaWIX7oee9bFsdlqDpITkuaeredf/Tkiw=;
 b=aPLPaFkPnnZ26QFd4WS6s7fiET3Xwm4aLiVUn8DVzOOldH4YYrg2WvuOc/HIN0v6XaYAnmfJ7Q4jfwdSwozYR7fU1fSS7GJeV103kCDxlwgX4MXeC5nuG1QqwHBGNTOnhczvjULZTawQn9LcAsDrGS+krOzsJbftYB+roDgXoMHAJvMphuhrsTboW+9N9Jwqfc/5OwHgrXzd1dtprvo21p8/m/fWMCTQHXHzdzNQw7h8thbLB3AzgZt+DK59z5rfp468B+KfGML71W4eZeymzXGsmopAjsgn02RbeGu1w8OLbt6V53d9qK0NapMHbtsQDPLo4FtGlfsYljOqACjhzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGGPZkBfMPqaWIX7oee9bFsdlqDpITkuaeredf/Tkiw=;
 b=f5r6XDo2J0hyyQHK5eKe6yK15OjZr01HqY3c/TIDVLzYd8nH4WWhHIlHIRZ7094op8WXtAsCGJHJIYMGgwBIikajay0NinTQz0Mo3B6JTUP1TjZ64fSSdP46rYilQ2CbsXE3Xj9tb6Sz0DHxASEByjkxr7YBv9XRY/wRZ/uOK/A=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB7684.namprd10.prod.outlook.com (2603:10b6:806:38e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Wed, 1 Nov
 2023 17:16:47 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6907.025; Wed, 1 Nov 2023
 17:16:47 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 06/12] maple_tree: Use cached node end in mas_destroy()
Date:   Wed,  1 Nov 2023 13:16:23 -0400
Message-Id: <20231101171629.3612299-7-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231101171629.3612299-1-Liam.Howlett@oracle.com>
References: <20231101171629.3612299-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0079.namprd04.prod.outlook.com
 (2603:10b6:408:ea::24) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SA1PR10MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: dc0e28b0-6446-476e-13fd-08dbdafe546d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nq8A6KRba6T69BpOqoX+hlTilwNVkkhr0lCCHwr8NtB3w2OtQ21gofI8Bwur5sJYNHA1ckNfvYWBKDOB408UrAPQdPTLijrx8D1kaH78IVne5F//XWf1JAa7JCzuoJvXqKc5wkD8yopBcJbwl6JqQ7mEKYN/wBq1t+w8pHog5Me9Epyl2oc8i0ZncIiNOCX8yLzEabgTeqD0rkHhN6HyF1ZFd5OTR7I1ddvR7Iv5RP8dMcVVpu13wW0r6hW3K2+kaRzFq22dRqJs3tm8m2+z/IivDruszqNXHClDzXzhaQCLZWIeLByce/+aNxEsZ9xaF/HsrD9hebZLmSPX2QAut2F7cu72OZxQ6vLvc16+3+PSKMZj+naUk7I1ouk4gVLoD1gBoGENvjuFxE8jk26x203X7GXMQf1TZo9KWLsQWPwc9upaq2lrNrJVYarwjA80NFiRPrdyWHWVkSaYRNnHX9rt9MvOLWKmOxs4zsJhrjoLGwXIhz1NL6R1QdoJ2WtrmwzN3uSiuVlf5OjwwlXlzlDdSMLfZFiAmz+G6CM3OWTmKmpQRdESmSnWTgUGESz4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(396003)(39860400002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(6486002)(8936002)(2906002)(4326008)(41300700001)(4744005)(8676002)(5660300002)(6666004)(6506007)(66476007)(107886003)(83380400001)(1076003)(2616005)(36756003)(26005)(6512007)(38100700002)(316002)(86362001)(478600001)(66556008)(6916009)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BQzenmx95BFYs975kRJa1uM6niclkXNjMHRC8gvCJRyRtB50OoE7Or5iI19G?=
 =?us-ascii?Q?QhM8MOI2KXt2tA7BOoBtYCoTPduCC5Ei304aY0A4UFOmlilneYHOrpNwLWSr?=
 =?us-ascii?Q?rNJkjP1HfqI8eR0+njj0bCDM5X9e7uxfQJx0c3QC5+IpfERbVIbe/xZUllev?=
 =?us-ascii?Q?1z6XGdhDwhQO8V1fEn+qhk6Slc/J5lTahcYwgvdAtZUC5hKWwkK2U4YqG4j0?=
 =?us-ascii?Q?zxVvZICQ2LY9/xjksXnj9+A3QvEDWrdQXe+yg8VNLf6IMwC0b1PBBJrFDL1K?=
 =?us-ascii?Q?C8Ge6qYn4EqFQeihyDPN/rMA4h06z4/juvVMF0Ogz3sKTnxquL+XpAFxnuiT?=
 =?us-ascii?Q?7aF/nh/lftQlsBHg1C635UKEptxhnnBScu2M+MWYFJIwjDE5tCvWZ/ktqSoc?=
 =?us-ascii?Q?/v1imgqFjkxB+j14HZnIr97+0LGTJ75dL0hGXbRbXjct5zs+J/UlRVghuA5Z?=
 =?us-ascii?Q?tRTW/D/CM62ASOFsZgX+Tv9yZCPpKLt43/z5Rl4fMEjdW4Q+7rW2LVlQ1UzU?=
 =?us-ascii?Q?H47suQq07OXhdVBYmAY8gY2RcvKNZOS7hrfd/l4WaLGD5X5Y/XwHXKuoAQ+r?=
 =?us-ascii?Q?nyZ9TMqkP+GGJoZ0PIByr9dDbGCJud7iJmDfKong5//eNGdSaQmzh84NvA+y?=
 =?us-ascii?Q?LuCKdZ+SUe38/9d7RrWUYERFMXXfldCcgs8wPaLv9R+O8PpTdC3iWkQjJmau?=
 =?us-ascii?Q?G3z3PcVx3BGS+NphycB+opagJraxHTh04dNYD9mnRmRcx34CKLCpzF+dtbrf?=
 =?us-ascii?Q?wTug2692jZDBcVSlJdXQLse8JS0Doh82nIvECHy+h6ph2/e4zfW244PMKmiP?=
 =?us-ascii?Q?ga9mnbU4Y+zBV6eczZUxfX5xmh8vdib/fmY0dQb30mUtVQECnpJpoEla6LSK?=
 =?us-ascii?Q?/qfjB5/LdpcQX6PTSLJ4GUXdeWndEp09PdyatHJFpvlr2okNcwUol9F16eQ7?=
 =?us-ascii?Q?hYuLIAmKU2Ll9iGisHJ2mGnAAv3c4vRoehN+G1QI8h3cIbHiUGZy+HIhsms+?=
 =?us-ascii?Q?IKdEPNuk+uCUXpxkDUygl3tBTcHawHq3OQ6rfnQGAnHiORGS2Li+TlKE/bU8?=
 =?us-ascii?Q?w8LvWmMEFgJlu1VJD20cgYh/Oxhi8qyaTFqK4/gQIhCSbBYnBUyK41A3yU2m?=
 =?us-ascii?Q?8FWEmBtI4FXTGZ1ybxk/KsgsaOeBqifosaARj9uqcNxsICswfrq6rF9aBF2i?=
 =?us-ascii?Q?QS8mXTrduADoq/dTbeJaH3g/WbKCGIbtarsdd2fJRXBptC5PCrArlfJ50ffD?=
 =?us-ascii?Q?J7UqKDTxXkL/kBlvYtenk8wB0+DnzH1DjZj9D2qIFeLv7Brf3S1yA5odgZn9?=
 =?us-ascii?Q?RVPyvXonohaxYrwOyuwzNYppAPC0/Z7daoRcqlYjLODYssFpErQxE1lmRC3e?=
 =?us-ascii?Q?M+3Z2HScUYxOwAURP4FlLIh+N/MmTM2lDdbFEByJLbRCiAnIBUZTQ8okr1rL?=
 =?us-ascii?Q?J3X99gttF63ZI5Lb8C4Karj7mZWFi6vqg5afq7TZMi6gPhaQhcYeh5lhtuui?=
 =?us-ascii?Q?y/FydP4c98xYHXfdQoK3ts3GqLQ10tCPRZOfkG1uQt7DcUGMubAV3S7H/MGG?=
 =?us-ascii?Q?6dr/XKSFaxOg5TmeeMAdqgeVC0k3xFbDXbAHHJWglTg6M6IkGza3+OvCx+7D?=
 =?us-ascii?Q?pg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oeEllSe0iPiCVrAPMAOfpw80MOUSZsS+/A/lhL+qZNsxY4mtB2alJgdKJrTIGbC1qXVojfyojjb6EHj4sCkD/L8shGRPoQbCOBJXobo2U/2D+eQjHruEZW7bwSXcRLMpK8R5CW2zwxUrk8CzR+m2sSZ64vAXHcGxCcJYbb+qArOgR43p7IBT4rraKkcPWLM8hzq1Sl8IuvRB8qNcZEJtrJOG+ZAW5M15W38UKZIaRBiCFqmhThESE4fMhNNZy+RaIjD1Vhb/0jDHuJPf6pzwN52CkNhWrta9/Xz0pit9THiejfJW8g5nEiqTUO5rYlgv9AH/7Q2qMV35QekOYGECpEyoG/UDP0yoSEwFcU7wjmrUHdYoE94/NmoEN3lZrDgBnbECuIId2dwZ+beASqw6U9FYxOBFl6bOfudTCdAArdqCrT8pQHy0NP5Bj2Hi6RN6RPQ5L9H9zr+CdfLUt7hstDGp1ucvhitc6jySeriohlJRXDUITIYLLlSaccYjkhvi12NG+sI5lEWoGb95QMZUjPXEtf+2agnQDmobvJhYNBbIfy0lGqWFzApMuuy3PfOuf3XkqulCcOP8sRB1m00GnFmicMUr41n1vK7drV6UfQiSTrvg+IURWRDlBF8Axkge9jXmDRkAE8UfE60vEiJcUaja7sIYJBQRu8XnzVra5/rWKuPZvi76IRksdE3zuWM66+DUZvR6gOm5N6kEI7/vkrFu1q3TzV+HYuDZ6CFAKPaxwyO4bTtQ3tv3fR15c1qyE3LYnom6PsWyNwwL55GQrSwTpgYiKLBBS0glSR2sd1YXbZY8g+Q7T6Z5In6EwdzotAjyioqPbiQo51MAqdi/3vQII+kr3z8UapUSNupu7orRc6UO8sfJYrYL7bRcrwZWH5VU4hsiojULKlEHuX3Qdg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc0e28b0-6446-476e-13fd-08dbdafe546d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 17:16:47.6930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O830QPufJ3oZTCM+dMM/AxhvmZFurR/nQTrQ8UaYFlBRiSMDiyvLNkoPwA7D1PJ4rvlkwsHOqS2q4GHW2w+EUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7684
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_15,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311010134
X-Proofpoint-GUID: ilc13ZvevpcGSjdUY-FN-7EzN-sd1Hlq
X-Proofpoint-ORIG-GUID: ilc13ZvevpcGSjdUY-FN-7EzN-sd1Hlq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node end is set during the walk, so use the resulting end instead of
re-fetching it.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 6c0ed71844e6..36ccb0ef9e69 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5564,7 +5564,7 @@ void mas_destroy(struct ma_state *mas)
 
 		mas_start(mas);
 		mtree_range_walk(mas);
-		end = mas_data_end(mas) + 1;
+		end = mas->end + 1;
 		if (end < mt_min_slot_count(mas->node) - 1)
 			mas_destroy_rebalance(mas, end);
 
-- 
2.40.1

