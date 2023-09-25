Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465107AE29E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 01:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbjIYXuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 19:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233628AbjIYXuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 19:50:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2987126
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 16:49:52 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38PNEg29019013;
        Mon, 25 Sep 2023 23:49:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=Tsc70UZvKWYWI+spZQiVZ3u2z8ZAo9dlRTusEOzzs6g=;
 b=MpgtuMtbvdYGqxGxUX2CjdkVcRTIe4ieYi04A7RSr9QgiYTuFtkHlUbbhWqLToWrwUwi
 /2HsHfRulyWFo6RQvCZbPMW2n0P2nIX5Wwq3tq7dk7OZZUksYp5UMOFL5CvqBRYGOzD/
 zuVBDu/f2u4x/qVSmyM4/42cYTVr3JVqIHQxr3c1jfm7NEKpg6XApSYoBLM/qBj4ynnB
 wyCpuGtGKCZn4Pl8E43GjVxPvVdSSCmxV71vW2Xsk0o6g1/CIMBYpHelbV9w4mDPWIGu
 NhobsVNeflvUvY65+RxaS7YJqmsVt8XENtbZFwj6pJ9cOmJeycxb/eH2LJpD54yYDXIp fw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9qwbd5k3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 23:49:08 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38PN1bGh039385;
        Mon, 25 Sep 2023 23:49:06 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfbbdek-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 23:49:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNw3cbgS97vxwMTJ4Elcc5I1umgu7o4yyeWMYMGaPTvzgYQg75KyKW3/Un7OcTO8lZeqGJZ9OMJBSg/inVTJtE7Km4DZa2nwdPkBpMZrhzO419BinbxXIxoyQx5DrnSb092K9FLzC1ToSresoOsSwr24FgHXA19OltAkcofXtKnBkO+9VVO8UJi87jOk4ouSaYdGGs347bKGcIo8Rpot4NFp9R+54NeKwj/jALJ/VNW5jVpFNiGZ4Nm1pjQcYUvsYrLaTQtTI2rtWzpDGEnoMsWsePr0l0OajsRChekwhw/4MUDjDXouErfvi53ohPOaUG5Mk8XOBCFz1qo/Py8P2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tsc70UZvKWYWI+spZQiVZ3u2z8ZAo9dlRTusEOzzs6g=;
 b=DDTcYOFGdDmXuISdRxwpL2EqmEPAumtg2tAdpqLAsfOyxNCorxuGGc2hha+epINxCSVk3fdAJIbwd/BLJ7eZR7KQuRxJBrP6fz7HFoiV0G+R0zuoWBOKJ52pATmD3q+ahrusyrown5TLyMjTtbRzqJxOE3UP/pzEepYXhEIUhvtP6T0n0Nmx5lrapP66zoY1/7q+q4nFc0W+tyJTCGYox0B8U/Uz1m2loVaspMUYCqqpqBy6EJ0VwcVlAA/7gox6cTWFkh8vXuMlsd9ODarcCLlpiG7qTIf0wQewIBSlERJeZwN/eextga0kqom9tTJSsoksOBmXRcTjLV67xb8uqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tsc70UZvKWYWI+spZQiVZ3u2z8ZAo9dlRTusEOzzs6g=;
 b=vq2OWFc3ldzeuUXy+riRBy6sOvJBKNFbUUXEkvOzVuyq04wh1lSj2MpifDw8PwwO33CkwCYUeX3oyrFxszvPoJk2t322EcBmj25rbRk8pP7FJ8grcVoi8AnDSjIOWgJ+3bZWNnVu3Vzjs0J3N0WWTHpK7de42bEuQP09Bm8nltQ=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY8PR10MB6730.namprd10.prod.outlook.com (2603:10b6:930:95::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Mon, 25 Sep
 2023 23:49:05 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 23:49:05 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <21cnbao@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v6 7/8] hugetlb: batch TLB flushes when freeing vmemmap
Date:   Mon, 25 Sep 2023 16:48:35 -0700
Message-ID: <20230925234837.86786-8-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230925234837.86786-1-mike.kravetz@oracle.com>
References: <20230925234837.86786-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW2PR2101CA0011.namprd21.prod.outlook.com
 (2603:10b6:302:1::24) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CY8PR10MB6730:EE_
X-MS-Office365-Filtering-Correlation-Id: 265e3905-51ce-4a70-e27f-08dbbe220097
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ACq9scLaREZJQQzSJQNGHaQPeWdQ36JtRxI8Ve03Eusp6nPNJ7Jkk5pb9pQuI8vHCG6E0KEpXQpNUaNPh9xpGK9eekoYWOy7PfD76Ybvm6xulpWAv4l02PiBm/Yd9wkn002wIs8eSw6Xv4FUAB27Z+UGlvZXaqXy0dUsGMv/jQTcpjIl3jDEsKn5oh7VnEKFjjgYrSOqwHKKETmrztQojJ2Uzvlu+48F0Stuf5SJqgdQDmy62oLKNDH2iUE80p8BSxEvGd92bLuJSenmnWmC+do0paPib2cb8cJUQ8BuI01ws6tvb/ovkPkxm10aaGpVA1RPpb8vWG/vRSn3hJi7Nvj6TWGorflnesbmO1XUPnE6IWcRuKJdD2gTXnvrjPN+VbFMq42K9ULM/JsUUKwBn5aqqOEFjyEskPWdec/Wz19u7nBdxqTTInQx1osjbBdvZ3lJQGBivYQ5u2CKi5NXb+D5BbHIuM+1xQ8sWCjMDvFCk9kHi0Pr85RiQhQJ5TtLX3kFHadk/69cD2n7gSyDVNrzBqvLQK4WTHz46SRyGdCNyiu0WOvuXK+JWPgi7mb2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(376002)(346002)(230922051799003)(186009)(1800799009)(451199024)(478600001)(6506007)(6666004)(6486002)(1076003)(2906002)(2616005)(5660300002)(6512007)(7416002)(54906003)(316002)(107886003)(66946007)(8936002)(66476007)(8676002)(4326008)(41300700001)(44832011)(66556008)(26005)(38100700002)(36756003)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZKmLS7zuH8cbCuNleigQuQlw09Q4jKQ47CtlhiQnk//KneBSR/mhXQ1nTWGM?=
 =?us-ascii?Q?E1FUyoYjTMWMXU4eBbCjUpAlu8mwkhlKgfjll8e2sreG3cKfEXu/HlY3Wed9?=
 =?us-ascii?Q?D8fbIw+pnnGq/5lP9td0OnQSPC7BDiNbdJJIC0YVUvnJJZVMqEhJ7fyztyyk?=
 =?us-ascii?Q?ZegvKIdZg7IWzUdcVyW6CzsuKyNXPH6YQ+CS+4B9t49fn8Ez2mVZcAiEAyuc?=
 =?us-ascii?Q?6SHa/ckxrjNg6rHP++Jm6Q91NsJQRRX6OC16xwRoaJPMYdrwz8YYctdVPBFR?=
 =?us-ascii?Q?vLcOILIwaqkn0TFEmzScEfZsynZd/1DB8hxf+MSo3Fysk+arJNoXR4DUA+GQ?=
 =?us-ascii?Q?SASTIiKpyIea99/vcnCVoGa00k12hMc1jrY4c/rcNUnSnE3gqInYaKA3AnG/?=
 =?us-ascii?Q?gPUQMHDBz05rlqy6/qMqRL9qOGt9lnhqVn9L8qMEDZrcH1Q5S+p8wsXi4YRi?=
 =?us-ascii?Q?L5Rn43N8Z6NYrs9jhtYdWdAVBtE3ME1Izz1OgVlFfJQo0MY39ni7JqCoD28S?=
 =?us-ascii?Q?zQyDkTEc6/++0YnIpiZ7aYSor/Y97rQlxV4ZXY56aCZF9QZoc5mP+qErrCkV?=
 =?us-ascii?Q?YTQ27UmGY2xf45nk4wsN9F18UNBXpa2jHqt5knNKscB+GGQW5v0c1sDsljrJ?=
 =?us-ascii?Q?tnW+sZt1QCAwE5bBlEIrC6Cpch6aiBm4XBbsSrkY5v/yGpOWozlMoNzIHvbf?=
 =?us-ascii?Q?ggciHJ/8i7CQWsUKh7/RvdJqyXkihOxDbNprvBPCdzDQ/4qm8eUXO5YXFE1J?=
 =?us-ascii?Q?5XeleA1bwWgfVh6JtmBWH6dLfIo5/Zin5MOhlRWjbjDEIraX77u70cUsC+P5?=
 =?us-ascii?Q?T5u3t7KiViM+lP5xms/mmgSD1oqRCBHYkKhVMmxq+Wj2TvvgkP/nXGmBf2uw?=
 =?us-ascii?Q?vinoIHWD46px7LRqT49IUg8MVu/9gK0qrEJrwHCqjib3Azz4UEYhwGIWcM9O?=
 =?us-ascii?Q?E9Jj1Xqq9aiChNQFA4HmTg44f9UIMJJ0VvlsHyYeDv61wW4Fo8DUOi6AqNlN?=
 =?us-ascii?Q?4D/ERp5Qy5eLt0Ie1nh8MOxufz9A9fAoD1SBjqDWvIHYn3nQevteyiwUuoPg?=
 =?us-ascii?Q?2z2bz0lQWSrx+k1lkBZ1EoWjm+0qyZ3iYBvxR8ltvn65vXPRdrmfqu2zjfFU?=
 =?us-ascii?Q?5zSglP+3KHxZg+APgfFMIgtPtnQhQw23SRjQ2RtvazmpcLocJLsI41GjeffS?=
 =?us-ascii?Q?hxxoOXS+CQS4SutSzfmHE2ih3m6cZ+2fSeJt3oP9E/q9m+xx9ZpoV3Nbm+AE?=
 =?us-ascii?Q?aImbEQ90Mdux0m+8Mx3Zuq+G4PDER1T9trjUACtc8I9glAzHvV4Xk8x5GRHI?=
 =?us-ascii?Q?UOmZ5WbrEtiw3OZdIFLQcvJrjTLzqlMVMbggyHrufkVuA+0ObAmG+Dl3aTNA?=
 =?us-ascii?Q?R6kp+zjknbwEfwrrAy2tKG0RXZgBFojmllIk3sbwHy4GLlnN+mBr88vmN9nU?=
 =?us-ascii?Q?FkYKepohXakxoywK+DkEe3+sQiKWUAXwbBoee61gbQsItYkx208Y6W1mFsoU?=
 =?us-ascii?Q?+1Nga7SRhc/H6Mgz/l10MpNP0IA/BHuKZG3JEHKfo5tSDxeDKh7FkYkweakZ?=
 =?us-ascii?Q?87YbJEWtRr6sGVoGorCUTX9DwD14vVvWKZGOoxLGBRjvWUDQyyH4JjQrhHHO?=
 =?us-ascii?Q?Fg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?5AJ+356RewC1DOh9Rb6JHMSLwIXKPQaYmO18STxSPSKRukbY/c6xFUJepHdp?=
 =?us-ascii?Q?RSDlTIzIgbKNnCeJuik0pXVcoqUwPFAlzuSsd98agD0J33EPzAlWGfDztHIG?=
 =?us-ascii?Q?2bdKr/afi62wsQPSyWSwT0D8FZSTCaQaAjyTgdkcH0bFpVlEV37S+AEIwHNN?=
 =?us-ascii?Q?k64aXrU2SMPq9VKVi/M68Nq2I7WJUL6727sP5uD2CHy3StoHXWjwPgJAjNpM?=
 =?us-ascii?Q?ow29kcfJxNVSVUfYGTHTnGlm67h4tYAaOpVoJ37cKrxdHhuS//HBSC+aSvbW?=
 =?us-ascii?Q?mMVKzTx8yox9tmXhVXcic11xCDsxyPkAd3UTY5qJv5mTSaFnX4SxvE4Xu8Zv?=
 =?us-ascii?Q?ZmyD/LKHAIj8xZsSSz5Lb1i5tukLuCPCbNy4AuZnb1L1AdWDa0gJOA0nM3wN?=
 =?us-ascii?Q?YWhDRdRkXQJW5ssWi2Gv23fRu5BVy6ry0f8VV4QV6AyVmy3q6LEo1m6KOviF?=
 =?us-ascii?Q?cns/aGAJGtfw1h7bPBo37zLdosdhckG2X4/hnwuS4K+4U+bLfqUqRC3lHHK2?=
 =?us-ascii?Q?SPY88POUHqS7wNn3//DECKuMGfQ5AP0lYGaHXyG1M6rPRBCIzwiDqWXM3XLZ?=
 =?us-ascii?Q?6fQhi33znarT78vFALomrO4Qw+XnMSqwAmR9DAf1GS+UL3phIzZfwM22ZD+e?=
 =?us-ascii?Q?ORd6AiW9PCW8Px1dBQ9hS3TYdEQMMDoF5+RrB1UfTy/fqQv4qshZ8vXoi884?=
 =?us-ascii?Q?yZdGjoXeqVC/UPCBhVJaRvmpfmoDINVYscV6R9hhvqAQ4x/bsAFPaHCh7UuU?=
 =?us-ascii?Q?urmVUTOKup/jMVcDFc2o8H4D0dZ3QZ8ulL1YMVQmFoI/Df1bZSLXaWR1VxUa?=
 =?us-ascii?Q?sShScaJI5dkEGWBiW3wi/+FVL6qneTr5ownKK3aCMzujFuQSpGXyC3bZtnHK?=
 =?us-ascii?Q?gYsJ69godUm+TjfA5XxLCQEi6YTKJIWWo8r30fsw4Z9xhk8It66TGqTyIvGU?=
 =?us-ascii?Q?pt7RhccYMBZgK4urySK2QyNnp5DXIBJSe5l+EWGFElOKD9Qi2l3P7G/3gPUe?=
 =?us-ascii?Q?2zZmmuAEOWyEmMClYCls+gqN23uuh9TjcDeY2DwGsxKRSunL17m+XkqjpGsG?=
 =?us-ascii?Q?b66b/aJYrCJnl+elzE8q3xFo1Pfl8T3b6Ujj/IPaSgaOCUkgRzAKfHN/ELJt?=
 =?us-ascii?Q?bdHB35hByD/b?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 265e3905-51ce-4a70-e27f-08dbbe220097
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 23:49:05.2523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0CT6Nb+AcxyncyzFEcEwVvLBWZ9CI/yf1iyEP3Oqkaf2w7zj1UEEhqGHUqw4wvI5B+my7nEwPEsAC2ZlCtOtiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6730
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_18,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309250185
X-Proofpoint-GUID: Ue732tyiVC_0vyydzZLVPZCNLDDqpiBx
X-Proofpoint-ORIG-GUID: Ue732tyiVC_0vyydzZLVPZCNLDDqpiBx
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joao Martins <joao.m.martins@oracle.com>

Now that a list of pages is deduplicated at once, the TLB
flush can be batched for all vmemmap pages that got remapped.

Expand the flags field value to pass whether to skip the TLB flush
on remap of the PTE.

The TLB flush is global as we don't have guarantees from caller
that the set of folios is contiguous, or to add complexity in
composing a list of kVAs to flush.

Modified by Mike Kravetz to perform TLB flush on single folio if an
error is encountered.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb_vmemmap.c | 49 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 11 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 10739e4285d5..9df350372046 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -40,6 +40,8 @@ struct vmemmap_remap_walk {
 
 /* Skip the TLB flush when we split the PMD */
 #define VMEMMAP_SPLIT_NO_TLB_FLUSH	BIT(0)
+/* Skip the TLB flush when we remap the PTE */
+#define VMEMMAP_REMAP_NO_TLB_FLUSH	BIT(1)
 	unsigned long		flags;
 };
 
@@ -214,7 +216,7 @@ static int vmemmap_remap_range(unsigned long start, unsigned long end,
 			return ret;
 	} while (pgd++, addr = next, addr != end);
 
-	if (walk->remap_pte)
+	if (walk->remap_pte && !(walk->flags & VMEMMAP_REMAP_NO_TLB_FLUSH))
 		flush_tlb_kernel_range(start, end);
 
 	return 0;
@@ -355,19 +357,21 @@ static int vmemmap_remap_split(unsigned long start, unsigned long end,
  * @reuse:	reuse address.
  * @vmemmap_pages: list to deposit vmemmap pages to be freed.  It is callers
  *		responsibility to free pages.
+ * @flags:	modifications to vmemmap_remap_walk flags
  *
  * Return: %0 on success, negative error code otherwise.
  */
 static int vmemmap_remap_free(unsigned long start, unsigned long end,
 			      unsigned long reuse,
-			      struct list_head *vmemmap_pages)
+			      struct list_head *vmemmap_pages,
+			      unsigned long flags)
 {
 	int ret;
 	struct vmemmap_remap_walk walk = {
 		.remap_pte	= vmemmap_remap_pte,
 		.reuse_addr	= reuse,
 		.vmemmap_pages	= vmemmap_pages,
-		.flags		= 0,
+		.flags		= flags,
 	};
 	int nid = page_to_nid((struct page *)reuse);
 	gfp_t gfp_mask = GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
@@ -629,7 +633,8 @@ static bool vmemmap_should_optimize(const struct hstate *h, const struct page *h
 
 static int __hugetlb_vmemmap_optimize(const struct hstate *h,
 					struct page *head,
-					struct list_head *vmemmap_pages)
+					struct list_head *vmemmap_pages,
+					unsigned long flags)
 {
 	int ret = 0;
 	unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
@@ -640,6 +645,18 @@ static int __hugetlb_vmemmap_optimize(const struct hstate *h,
 		return ret;
 
 	static_branch_inc(&hugetlb_optimize_vmemmap_key);
+	/*
+	 * Very Subtle
+	 * If VMEMMAP_REMAP_NO_TLB_FLUSH is set, TLB flushing is not performed
+	 * immediately after remapping.  As a result, subsequent accesses
+	 * and modifications to struct pages associated with the hugetlb
+	 * page could be to the OLD struct pages.  Set the vmemmap optimized
+	 * flag here so that it is copied to the new head page.  This keeps
+	 * the old and new struct pages in sync.
+	 * If there is an error during optimization, we will immediately FLUSH
+	 * the TLB and clear the flag below.
+	 */
+	SetHPageVmemmapOptimized(head);
 
 	vmemmap_end	= vmemmap_start + hugetlb_vmemmap_size(h);
 	vmemmap_reuse	= vmemmap_start;
@@ -651,11 +668,12 @@ static int __hugetlb_vmemmap_optimize(const struct hstate *h,
 	 * mapping the range to vmemmap_pages list so that they can be freed by
 	 * the caller.
 	 */
-	ret = vmemmap_remap_free(vmemmap_start, vmemmap_end, vmemmap_reuse, vmemmap_pages);
-	if (ret)
+	ret = vmemmap_remap_free(vmemmap_start, vmemmap_end, vmemmap_reuse,
+							vmemmap_pages, flags);
+	if (ret) {
 		static_branch_dec(&hugetlb_optimize_vmemmap_key);
-	else
-		SetHPageVmemmapOptimized(head);
+		ClearHPageVmemmapOptimized(head);
+	}
 
 	return ret;
 }
@@ -674,7 +692,7 @@ void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
 {
 	LIST_HEAD(vmemmap_pages);
 
-	__hugetlb_vmemmap_optimize(h, head, &vmemmap_pages);
+	__hugetlb_vmemmap_optimize(h, head, &vmemmap_pages, 0);
 	free_vmemmap_page_list(&vmemmap_pages);
 }
 
@@ -719,19 +737,28 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
 
 	list_for_each_entry(folio, folio_list, lru) {
 		int ret = __hugetlb_vmemmap_optimize(h, &folio->page,
-								&vmemmap_pages);
+						&vmemmap_pages,
+						VMEMMAP_REMAP_NO_TLB_FLUSH);
 
 		/*
 		 * Pages to be freed may have been accumulated.  If we
 		 * encounter an ENOMEM,  free what we have and try again.
+		 * This can occur in the case that both spliting fails
+		 * halfway and head page allocation also failed. In this
+		 * case __hugetlb_vmemmap_optimize() would free memory
+		 * allowing more vmemmap remaps to occur.
 		 */
 		if (ret == -ENOMEM && !list_empty(&vmemmap_pages)) {
+			flush_tlb_all();
 			free_vmemmap_page_list(&vmemmap_pages);
 			INIT_LIST_HEAD(&vmemmap_pages);
-			__hugetlb_vmemmap_optimize(h, &folio->page, &vmemmap_pages);
+			__hugetlb_vmemmap_optimize(h, &folio->page,
+						&vmemmap_pages,
+						VMEMMAP_REMAP_NO_TLB_FLUSH);
 		}
 	}
 
+	flush_tlb_all();
 	free_vmemmap_page_list(&vmemmap_pages);
 }
 
-- 
2.41.0

