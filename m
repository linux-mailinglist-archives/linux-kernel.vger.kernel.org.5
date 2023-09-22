Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C9C7AB4E4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 17:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbjIVPja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 11:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjIVPj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 11:39:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3A4139;
        Fri, 22 Sep 2023 08:39:22 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38MEETBJ022692;
        Fri, 22 Sep 2023 15:39:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=as/fYKKuaBR5SblYrUiYVM2b/c0CwsDVCICaaLgl1OA=;
 b=WlV7Cx6ZPp745iFmXQQD/zKuZesjsighFCZDDQKSQi3UQxQ9sT5WUgcOQcyflWTAHjSA
 gGQHSIwFx3hfU9/6uXwJBc+7n0TOxSFsMQaa8josW794GTYTGmUvCqKu2+flcsZurzKV
 xpaOTNgKSpj6erpBg3x1B/PJDkFdlQvvepm4n4/oxyf4SeX0/rHNeQ/EOG3mqrclfP9O
 wVvLFxw6m0O6NNsPhzQqSZQWX+s7uX9Z3JZv11aZPGcwa7lF8jw+dMdIgH8nicxfrRW7
 6IFZdp7odmohl4goKSiD7jUTal5vzJmx5rQFf68napCI/GcRDJzvM+9SvvX4wuvW5cuw 0Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t8tt024xe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 15:39:08 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38MFRTh8035067;
        Fri, 22 Sep 2023 15:39:01 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t8ty2qppt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 15:39:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iXjNUP3a4W3Q3a3SRj3kqvBr95IRddhqRnEnucv9hc431RM+mR4vJiETMhTNM7ATh0sZzAy6ftmk+4WYxM/4Hk43IUzQxSJRqLGPpJsceZtUs2MTKCudxb7sXKMhl3Qvm2mzkpwHxEvexntpNp6KC4bJMmXAKVi3NgPibdQlbdWQa4+uWwwLaGiMsClQ4KPzC6IFyEhOD+4plgGG/vUhJix1ECPGH8Gbw3cA+UeNJTNbbkzSXz/6Aax0tNYZN2JouKzJ+O8hONNVWl8Gsm498QIfwukSl+y1T44jEy1mI7G91Z1DYYmG/eWiWWYB8/XqFrIqmjYtdY+Ey2047rTa4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=as/fYKKuaBR5SblYrUiYVM2b/c0CwsDVCICaaLgl1OA=;
 b=b6oVFHnRFyZwBgzsnfYpo6xeAdLI3pzXyb8ZnW7n1wMnf7QTmbgkIPTEDJFvRMMkyuDNG0YfdA6lDvLTGWblrzn5sgWuk/09kagISi4ryr65fUFU/YMufLN/XhT1LkKklae7Ctox3yhAeMyNoPz8JSHVOkKPLMDm5PkTEw68gvw5kksHADZpw5NaO8BAjwy0xTjOSl4OTtyvGK5iuq0eqFIZ5Z3XBrY6c8gDgoGXPQLFj68QpISxPQwzQ0Cz+vweyGMrj5jBdU6KcPMYw/LMG8F0PQaO2HkkOPjGLIYNQd7tQqn797a5aHc3z4u81tUMKEArEEMLOKUBdwiSgNi9hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=as/fYKKuaBR5SblYrUiYVM2b/c0CwsDVCICaaLgl1OA=;
 b=VTd0mzA1JWTq8Aj5Uo5hx+kLOPSmyyRAS+M5mvgQKnaE/3qwbC/wl9eYaWfss/P+/Ln2ncWhaWRqUWRudHe+pULH50X3k053tNMgkfSFhWaw/5xCMhv9eXNHdSLqzc1Jh3f7RxFA1ssjeaJ6qsTkiF35cVd3XOOT1TnNYbDX19g=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO1PR10MB4561.namprd10.prod.outlook.com (2603:10b6:303:9d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 22 Sep
 2023 15:38:59 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 15:38:59 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pedro.falcato@gmail.com,
        stable@kernel.org, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        stable@vger.kernel.org
Subject: [PATCH v2 1/2] maple_tree: Add mas_is_active() to detect in-tree walks
Date:   Fri, 22 Sep 2023 11:38:52 -0400
Message-Id: <20230922153853.767603-2-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230922153853.767603-1-Liam.Howlett@oracle.com>
References: <20230922153853.767603-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1P288CA0023.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::36)
 To SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CO1PR10MB4561:EE_
X-MS-Office365-Filtering-Correlation-Id: 4306140a-566e-43c0-5105-08dbbb820a2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mxAXr9ZAZ0oW/ePBnSeiWES9NikMBytbqbQUsji3uOTRVbafBttsZahHBK2FVl98MTepQ7tgrmCMwYddwEuWX0tETZjHOWuXB/gfsXSSuEztdCqxoOOGuq08g9Nw5aSVfmuSdKFw1BrHSe+JjLSzV2aOwsTNEWd+6tG6NNtQcNhlGD9fl/aujg5GylJLa+4oNXy0xM/HnRAxO9/7yU8uUuAeB2aeePKp/tLB8NuiK3YG2OKvK5R2ILHHHESQg1GFog/qjmh5tI1g9wzdK5tkqKC8kPYScH9G9O8yIFVF/nwVBJlWcM0pjHqkl+AHAdvhEj3bYMPstAPBbIQ1BMtNiLKZZJFmMoihBEb0RqIDq9TNcp6ZaW9mYbftugCiYBam1eTEdSzJxg12YPVeyWj+4c5QPCBIfYugOU/ElBvBjcQUiKc+j4SPZVmvcRDcUL1XlCwT3sSYsg+GeMeVmEkXP4x9IL2d5+PAs1AYQae6WWxsKkZaWqI5w6CsCGLnkXOuuznnGfk3IS8y3T33u1Kq7lL/w4b+zKfMe1TYbWDRsv9k08aN+SM2sCrJ7rIaGagN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(39860400002)(366004)(346002)(1800799009)(451199024)(186009)(316002)(66556008)(66476007)(6916009)(66946007)(6512007)(6666004)(6486002)(6506007)(1076003)(2616005)(26005)(36756003)(478600001)(5660300002)(2906002)(38100700002)(8676002)(8936002)(4326008)(86362001)(4744005)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oKv693aXgx6t1dKjwvMuZ9qcyNPwjGN4CL7HtQOg6P7PSgcqkNgJCyY4Ar6s?=
 =?us-ascii?Q?lh4y8QN0qimmLHv9nx4+dZLmQZ5xKXmfNO4nvQMk9A5Fg6NuRqIW9rg/fGYq?=
 =?us-ascii?Q?QmfQk4axvXMFIn4I7ze2A0UrXBk4gDjRNwkpIsxNA51/fJPfJnbUD0FPB72M?=
 =?us-ascii?Q?QrkQM/iBAOUzuvw20YSopB9llGjEXw8Tza7ve/AWwL2yEbsGpDr6iODZu9B9?=
 =?us-ascii?Q?D74wdjQB9OJ51Flo/bA/cyTL6EF1+y82Rf+nBC8Jpx+XGqWBltEKZIVVc0HO?=
 =?us-ascii?Q?dB+ZCfO8IgiotrdT9y90mHPN0nrPoyFZTGeKy3vsYofPuXtcQSHb5X7ca+8+?=
 =?us-ascii?Q?a1pdAOAOBN1HehBDsN8CcrkCvVMBHbPWXZe/B+Jwg/HwKFigN9zNbRdNrX6O?=
 =?us-ascii?Q?a/lNMPkQ4E3YQfZr9v2xHQBQt/vbscWyNh7NczxXTbm8ePj0gnlJNMWSr2Ml?=
 =?us-ascii?Q?Bo1UMm89H1Y1EKuT79rCLCAg6oE4xM09B51O0vzeiJJBzlB3XEutyrSbGptz?=
 =?us-ascii?Q?ILGBlBNk28ATcGiGqBT2/+/yaVSifhCdyAH2fyf724ekVUkDw9bbZ6z2KImG?=
 =?us-ascii?Q?+YJM+OVdh0ly6JYHpLHqzSSOtOwAZpuOc9THxOoeVwpNS5F+FJKbHlg8VaSE?=
 =?us-ascii?Q?yLsdmFqH3pAVIek6anlDRCbzYmr+rh3e+G99/od7ERd7j6XrprxJTWyP9aUr?=
 =?us-ascii?Q?r/OpCwdbA0gfD6NJ2auNj7/rMGxm/fBc9YH8hYoZrS6lomwMsYDTd6QVv2U0?=
 =?us-ascii?Q?GWXkqiQNXSMyK/rQWRLiUOOyMNF58ZBklAX6OKjDH8W/D+cE1NeUl5F1iXwv?=
 =?us-ascii?Q?lDZe3GTRuPomMlU4DmC2+yRYnuWaC8xrjvhQqpGXA6yPEJhaXDsCnYPpaBI/?=
 =?us-ascii?Q?fgHQZOU8jFwv9QPsNXbtXnc//g9BxTanhCebqQ+QG6/0igA6+WHIytwyK1Pa?=
 =?us-ascii?Q?Q6J8k2g286N5TEZ2HlBW68/YMMr4c4eM2hGmNdOEOO6jopctunuGQLL/lq5E?=
 =?us-ascii?Q?EHFXGVnoZrPpb4h0aS4Aqxl2a+fOhnyZIsMGtusUcBgialiMh3lhhbqLECSH?=
 =?us-ascii?Q?lenDux/A4rAFhN4KA+5DyO6jJODgegB5eI47z9FB4YFJy/uttyywqopYE29x?=
 =?us-ascii?Q?8KP2jB9kKPBokTpd81+VJ+OasMp6UD85jm3X0tT015l1HaqkUoHdCCBlsMfP?=
 =?us-ascii?Q?eEq4gBVDsjrKhTVmJVHPVBxy0ql0xvX4V0Mj7+8HocBCuG5xzx0uKEmEvgiD?=
 =?us-ascii?Q?RemLTnybKuF4Y2ddW3C8ZhFUkOOrdLPgjm/OrKvdFWm7atY2LvpemRt+9lZH?=
 =?us-ascii?Q?yhAW/D8LbzOEd+dvfhb1xFzs9KwmXHkENiasjkYo86USijqOw2apAAfCH2Yt?=
 =?us-ascii?Q?/47XEgKIpuxMPbLjm5gPYIPNnDK2bRGF50uV/8bIrZPglNggrZeFMBJVDgj2?=
 =?us-ascii?Q?c2aLD2ItgETasPno498DXLeiavHvVix5sqhW5xmJunsE9zavy14sJVJRZctY?=
 =?us-ascii?Q?LBf9ybN0tNKPc9LGcwakI05Azx/GSZOCSUT6a7VkNr361Rp9+BOCJk1OpIWG?=
 =?us-ascii?Q?DL8pmpcsTa0bOSyKDEduCpoNoENx0nOOwhUOe4pLBs37vRxqvdYl1FO0DtiZ?=
 =?us-ascii?Q?7A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?3Rmzqsv+2CLGcpa4FG+RrSSuGDIqh96k8m9xgxUZ7q/zuMfyjzLxnoUzjf7x?=
 =?us-ascii?Q?KAmWhsolVfY5whMCXMsDUIIzCRx5v5mUS9G3GLbJLrHa0C6KznP8tgqfGAZN?=
 =?us-ascii?Q?dJpOLAxN4FhgxXR/gAzbSp4AjEZw7QQktgHM+NGCatJ8zAYo99sZy/5JWrYI?=
 =?us-ascii?Q?5yXRmm5GEQ2xOVa3/NhKdQd6iKkGOXBOdlPRdrxeF7TKB7lYX9osMvllWhAg?=
 =?us-ascii?Q?Dq3+VQx32DV7srhMGgHkGVCDtx9yLAKH3bR+tuMslmf1B/OPiBMDc3YokRFt?=
 =?us-ascii?Q?YxQUNwkNQblfH49yrkfaTjxVVXpgkJE6Om0xlgYqUoqIOV52tBw5JU4Ake/V?=
 =?us-ascii?Q?muYBMsmZyurErwTRork/0LDD1Naoj80HcVLGZmNcDgADTzyBvHSLrduXvQ7G?=
 =?us-ascii?Q?l4lvjpE9EvTogchJNp1Hmyh86YXSW40p5Af0RECgTNVpBk3gfIgphiWn4H6o?=
 =?us-ascii?Q?0inxCGdAPz4pKpXbYErn8mc9RIpLaoMvzmQcFo8vP+g4HBsgYTDZINdyl0v4?=
 =?us-ascii?Q?Fmw7ANbjKpgQfnd41Hc6FeFT5H5lGRZrgVETf5v79b5hgmWlyNrmKYJaIxkB?=
 =?us-ascii?Q?y+/V1Qte9IGFfGw2qxujPFBCodLeBRQm4vguiCYLkr8I0f2ODVus/nBAmuiZ?=
 =?us-ascii?Q?1TUMo/lXTKY72iYz8Zo1yFFseM2Lbf6Zh/0LiQMkWZTFm2Djyyq35tWgW8+d?=
 =?us-ascii?Q?Muietu5u84jf+ccM2BYFJm/YkdE+W8XhRP6iA/iyKR+vQjm7+B9iG2L5GO5r?=
 =?us-ascii?Q?GgS4fxDytWA5ebvojZIJDRWWAtvwcDrs8a623Nlm8unKcEKab1ucQd81ZDmI?=
 =?us-ascii?Q?bS+DzAiX/u6IpIKZ64kovsCqObFIjY9hrZignMMfdCP9nZmxCPLDS0IX7J4i?=
 =?us-ascii?Q?O7MpCy6xjo9V3i17pWQS4VpoLO57EREoB5ZwggkOfQ/LqJwbvXaebVF3cFH/?=
 =?us-ascii?Q?petag95OVwHRiT6b/np+ng=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4306140a-566e-43c0-5105-08dbbb820a2c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 15:38:59.4660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K7Iup9L7VPgtFk+sb+zUtIN091pDiXXbFj0KWLUnRsHv5ATy4oop0Oq8quPS4MCHpZW4qA7v86J1qJ5/mg8wog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4561
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_13,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309220135
X-Proofpoint-GUID: 8GHqLJ1NXscxddU5ITDEKPXRuXHBoDs_
X-Proofpoint-ORIG-GUID: 8GHqLJ1NXscxddU5ITDEKPXRuXHBoDs_
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of constantly checking each possibility of the maple state,
create a fast path that will skip over checking unlikely states.

Cc: stable@vger.kernel.org
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/maple_tree.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index e41c70ac7744..f66f5f78f8cf 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -511,6 +511,15 @@ static inline bool mas_is_paused(const struct ma_state *mas)
 	return mas->node == MAS_PAUSE;
 }
 
+/* Check if the mas is pointing to a node or not */
+static inline bool mas_is_active(struct ma_state *mas)
+{
+	if ((unsigned long)mas->node >= MAPLE_RESERVED_RANGE)
+		return true;
+
+	return false;
+}
+
 /**
  * mas_reset() - Reset a Maple Tree operation state.
  * @mas: Maple Tree operation state.
-- 
2.40.1

