Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CE17A2A58
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 00:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237935AbjIOWR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 18:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237769AbjIOWQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 18:16:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C325A9B
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 15:16:46 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38FLxFCn017035;
        Fri, 15 Sep 2023 22:16:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=9cpMarytvHGbkfELIePaEAGmrxRtGSUtw1A3TpXlgaQ=;
 b=iVRntUqY6vn7EmhH2/Q/boKaJ9cdb8/w/wo+mOmRW5xQP01rlNJ0wf9ewWX1iAZPta5O
 WXdqIWQEa+ULO38FgHkRnWEzobuzgOx+gaJ4xmY7fWGO11bGLHED1sxNVDB9uKPzKA9m
 4eXPw+KTHwfzafhR2tPXR3lJMNQCg7j2Ht7DkYa2Z4Yn/M4Vg1t26MSPE6VczCI7Cwrr
 l7QkdjO+0qB5V2zOZK5TwU5WeGVZw3SkuEgj8vzloxXrqfi48jf8+2+QK7n3RrUknU8W
 8yfjmGaHJlWGel++/suVBfPXM2GKDWh/AJXwkXOzzW9TST0q3WuVedjD4I3SL9eaQNP5 /Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7rgxc0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 22:16:14 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38FKi6I0036207;
        Fri, 15 Sep 2023 22:16:11 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5gx8xv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 22:16:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8tCsbvPRqYBfKLpmWCMacXHYMLI//z3mDDJLhZV2tIKcTBFUqRsbn1cHXRD4O26xYcPItoLstTRq2SAWX1hsZbfWvkQ7df/OCEhdOQ06dEQ0bSPbv/2F0HhQKv65OvaRmP14TfK60vWiv7GGKvSKjI1bBdj8Z+oUoArAK7MiwxVUfTmDKwfplQ1RD31ueIGodcNp7j5NYjlT3ZDvk1iZMRT8CfhRGNKhBss3gW+WGmtAyX5Wn7BnJ/qCzZE82uNfpkOWr3jI3uCRcrCGeHG3i12ubqh7gWv7fiTThpkD2EbdBUU/uaCnLS1a/McISTMwOjejQNH6bEWzkFJzcqwgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9cpMarytvHGbkfELIePaEAGmrxRtGSUtw1A3TpXlgaQ=;
 b=G0QEd9asIC7QXiXKFo1RccqCom6u/3DnIGr7q75thMNkEOvM2BUbEGgJR3oTlNkEImriZtPjBU7nNUYfCpbx3bhdCAgDd81h0Zr/YilcJJgfe1SAFgLRVRtBqvdqH8iAjFrczoRPibVjJegyk7lPbAOGC4nisiS9yb6NLRlmC2lg9E9bTKqEeiJwBIyl2XmHeOFhL5q73Af/IeVFGLWUO/WpN70rGnUV3yB8GlaKg1WCg9g+RRa209hXsOYYAsexVq6Xh/u2gpDLoS7iUdf4MnJefIZjgR59AMoq0iwiN/0RVSbRN+cRpPzI34jQpWUz/VbqgeT5SAqE48yIr2B22g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cpMarytvHGbkfELIePaEAGmrxRtGSUtw1A3TpXlgaQ=;
 b=TFnCOJn8GSr7hAFaxj6dUMHKB8ArmeceJGlcAMsYnNIPRwaADDqmYNrZl7v2fkh/HjIaVQfxBxOh+AnbAMK4zyfdFI/P6mjsDmeBUcJ6JrqglD12ZNXkhK1RoAxwehyj+fX/J8mUenE2D4CT9MY1dcHMJWshsKlrwssWqW8x0WA=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW4PR10MB5861.namprd10.prod.outlook.com (2603:10b6:303:180::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Fri, 15 Sep
 2023 22:16:09 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 22:16:09 +0000
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
        Barry Song <song.bao.hua@hisilicon.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v3 06/12] hugetlb: restructure pool allocations
Date:   Fri, 15 Sep 2023 15:15:39 -0700
Message-ID: <20230915221548.552084-7-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230915221548.552084-1-mike.kravetz@oracle.com>
References: <20230915221548.552084-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::9) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW4PR10MB5861:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b1828a1-c844-493a-42e4-08dbb6395cc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BZB+1sTU4I/jA9cNCjUw9gEp40h21/CesPm0+nnYUFylFqL2M1nu1gVU+HOrce5gF5GInqF41nelUEfRaFtIsTbB5hQt+6LFMVmdKEnExc1OB4IRCUvQRrR9Ay17n374nO6Xtvr6OsiknpUnVLDFkU3t8+XaVimJkZYVgO4Pi7GjP+xrM3mewjrfGzJ+mobzjdwEgRmNJ8Q2OAebtr5DSE72P7Zs7oBy7O4RgH2+IPfqSfPt5wP7jeVI098inFXuAs085QyXm4cqOGR5q8u/vP7975AunvYaQRXnDhuXcpVqWye+ifz3o0cbpIBq5M25jVIjFjMG7dhsSnRTZ+atPfluWfSCFigl2Qf9pikRImrsO0eEBTG9+XyB6Ngcf1Vgm9mxWPqVWQ4QLA5NAUsGhc7CVqEOC9CV4/G5UJnwLk2goCHiurJ9NymjUyOqZ7Nyr9Uthow4A/Cs0MeRjtIlyJsMAYj6LIJ2kCPGjqQuysuheWKKEpFL4rkUmXlaZevkA+7ZIQPxWWW0sL1A2WPbjv/IpivQe407IlkEyfJKR/aESyfsEI/WgBAr66Bf+nU5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(366004)(376002)(136003)(451199024)(186009)(1800799009)(44832011)(86362001)(36756003)(83380400001)(2906002)(38100700002)(478600001)(1076003)(2616005)(26005)(107886003)(30864003)(4326008)(6512007)(41300700001)(5660300002)(6506007)(6486002)(8676002)(6666004)(66556008)(316002)(66946007)(8936002)(7416002)(66476007)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8uy2Scp7BgU4odLXIztEx2zkfjkGtR5nWdir9fyKA+hE9Sg747RwNHadab6Q?=
 =?us-ascii?Q?fKMyJvW60KeVZPXeUPV5XDyotc8228iOwZqPrGLZ+8vH7zg+JBQ0CgeIziD8?=
 =?us-ascii?Q?rOLGLOnBIQOLqjdkiTTzO+c6jGaHJQDwhhtdbVG2oAOWqFO+45ljRIJrqQev?=
 =?us-ascii?Q?0tuFawn6R/ONPwX6JPWUCJQM2vKoSBipkQj4Px5prjDkeNFSqg0t7G8eN49Q?=
 =?us-ascii?Q?cH/foY4/Dd2uJrQVHX1mIx+4vB9YN+9NSaEz+n0zhIWUG2L+sDkx/MstsU2d?=
 =?us-ascii?Q?qOKrx698vR9+Hj6QaVsQmuL6lFWlDRLFT6lFi7GGVbp9E9cKM4V57tWdbiX/?=
 =?us-ascii?Q?zwZDarlsKffDEEGUuTPd9CAXJzH8u+blZ3PRi/H4BT3yP8DfXJuiENQbIrw7?=
 =?us-ascii?Q?vLnunO8nbceJXOtdosWRaz7ZtRVORtdHpH4u0+6+POsZrhNZot71dSksUST5?=
 =?us-ascii?Q?NbF4uhvTIkFG4K4qZMwvU5LgJizdoVGRwVc3BqTZ0vikE0BfFzB6Dq6vEVNT?=
 =?us-ascii?Q?fxV8p+3vGlR9KXoiwYVJItdVAV/ojdUjzv3vIyh6C8sfGpJprYZyqJOOme1R?=
 =?us-ascii?Q?o2Oa7smKhRadbs0fKGURWFvl2+sYBO2yBKpWMAvT9TPR5WixtAgw1WvLaOa4?=
 =?us-ascii?Q?os97PBIszHAqzmCm+zJsyIBjEGoPyZ4qk5nHc/LRpl9YMab3zqiIVu3CbqXD?=
 =?us-ascii?Q?2L2f+t5hOzPUb1IV+zCyYG0K8tpTlUnkeGFyVewAQo6R0qSFliGpKzmOrqtq?=
 =?us-ascii?Q?/6E7I0AjHZSOdNC7K33iYOF7RKuB5UbSKF6sXwGX0g7XYmJSB9o8E12JzmRk?=
 =?us-ascii?Q?PJ39DH9aP1JrmJ9Fw8GP+gXuj39bgc1pCEq5wOuiQAG1GEeBY+eqc0wIwHMG?=
 =?us-ascii?Q?MUm1eLzf6Q6TlChaOoWpBQx9nwvyVXvO1RdOb/1G3mIb1qE77Bykz1MGBveo?=
 =?us-ascii?Q?9xGilhRyGDf644EBSGF4t34oIrrcbhmhFaFEODHpUO0BC6l0I5pmP2TMGbP9?=
 =?us-ascii?Q?zhZH+QOi1sico6AMP9n+574P2z0MeIdnZ63BL2wZbdwnclUNT8+v/Uto/ubk?=
 =?us-ascii?Q?F7KkdftEti//EA4zmsPTYCYE6cwJ7TAAZL+l21SPwM1rxNloEv4UK38N1g0+?=
 =?us-ascii?Q?ckuohKHKdDtl/JnDAj6WcvaGZSQb8oHC5E1/M3iMYJsA9/xXbhmQk8nXsvXQ?=
 =?us-ascii?Q?HBEF2ui7NT+VUVCT95yJ90/fHyNdVMGiSyRtalMXYEERtIU9Pxt6gcdZaKJM?=
 =?us-ascii?Q?wq6Eff5YmvEdbFF9+Quc8OsRdoKs8GXRO2l4sm0+3O7/1YibzetGgIOJD88l?=
 =?us-ascii?Q?5yiYMuj4yREf12dF5BSfB7uRljIXt0+TdaWyCqj/BsWGqKgchEkUIW/fvOwb?=
 =?us-ascii?Q?6bVd0Bev9ESkVx7T5k5hQMaypfPnme7gcGmo4BJY9oqOZC/5PkPC3+7S9sTk?=
 =?us-ascii?Q?c5GjgvQfrfv4GvR2kY4BpusvRE/UFHA5Imx8ueinn7Xk/tXhXe6i3SBQghLj?=
 =?us-ascii?Q?M2OoEs3S9f6poddos0zV+6SWTbORxpRpLd5OSCCgWK++VL6gIlVfvQgxlhZN?=
 =?us-ascii?Q?Dcd7IDWFSM9G4Dn+MHZB/rb0JWTusq3blMLq1KmgIRIWcxnVBxiTYLhpAvwx?=
 =?us-ascii?Q?5g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?TZhEnqBU/5EZ3tCZoY7qRsDQWqcruOuwCRWBPt+A6a1qog4hSaRqfLFS+HyO?=
 =?us-ascii?Q?pgY2dv4HujnjZoPJ4AKqjd/vIZvtOW9JWDVlN3RYBIm/9iVHcUZoNs/Hjomo?=
 =?us-ascii?Q?efKajqrX1AdSUUsNmWlD/dr76JGfKmhxdjJMLmi8ab8X2q2L59ek7gmchvC+?=
 =?us-ascii?Q?Sq2ZnVPRk+fVZoDr2OG1yYAhiUX5pq5PMKI1jutXTzN5K9LK4ZQnm/SMFm6E?=
 =?us-ascii?Q?kwD2NIfI7NZUdN7cW3rM8L+ZJnKF4Dh3Qb5jlm29M3phK5may8sPTIGYTqox?=
 =?us-ascii?Q?wZwwaoZ1kzghBVAT/WAOLFooje3DoGamyb7lhrU84BKeftIwd/Icjzm6YBL4?=
 =?us-ascii?Q?USBvBgQWgxONJYvLKJR0RPXT9miwXBbdwLWh0fn5uaqel30HIkRMNrm2hzLe?=
 =?us-ascii?Q?Rfd2KZszuKHULwvPne8B77JfD50bxCzS6mDesoN3dZz05SgiyC6tAZtM9ta7?=
 =?us-ascii?Q?ohRB71LS0LpqLvWYGmgzwXoKG5tAcjtTmZ1FYZuk6sVWlDPzrNSBXrvxte6n?=
 =?us-ascii?Q?MsEIY/6epBMcW6vZxly7SjPQffbsYgDB0Zb7BWknSLGbVBz9pxTdqUs4RIun?=
 =?us-ascii?Q?uIp6UJlLePoohBDIvBBcBV2ee2lJbdrEcw2XVowz7rXALCW2wB6rdSfWeXo4?=
 =?us-ascii?Q?ISbqENetTxhrM01J0QmF94EAFwXAFglSqo0f8to1G39XiLJcFCR98Qk1Atkk?=
 =?us-ascii?Q?DZ648bgImzHGlPfk/XvbnQLW93txCPFRu9/rm+tfwAIVxB9QEgJ6uDM5kCjQ?=
 =?us-ascii?Q?ksLxhAY39UnwhiDhMLW+5ReN/HqkaFg6R+1b+brZ2Gdc8RhRh94lQ+azr8Yf?=
 =?us-ascii?Q?oVEPmQnwH2SJMVZk8jMnwlh/QcMAeCqBGtZlZ1UU0EBMWeSRkY+qkmu5uIPz?=
 =?us-ascii?Q?3IRYOXOE23hD49rfHgT8dJFeZCx9cBmGyIUXlxDc6qvZFA0rbyhOpmheSQlD?=
 =?us-ascii?Q?MJRW/cxUtjFmMq9ZTiWZfuWzV+TefrFdpLIt/s4vJC3QTNr7DJLR8pCzRTH1?=
 =?us-ascii?Q?iTlA9xetJ8VgoZ4JhNSwb0JHrXrF7kiTQ52BWNzeJvfgtS89syc/DP8lgZGV?=
 =?us-ascii?Q?It4LagNaHkdfCsA+kZpKhyyGfkXgjHHLgy/NKSXZHh0FhsYBYM/ynLxtm6XL?=
 =?us-ascii?Q?iEJd6JiTNHZj?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b1828a1-c844-493a-42e4-08dbb6395cc7
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 22:16:09.0587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bLXmHMzMIsm/cGhc/2RSF28XS7jxTINZIOfskSv1ooUoIG8rWpJ1+eq5y+AqbvyD7/KpVRx5lJxzonLhpUkiDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5861
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_19,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309150200
X-Proofpoint-ORIG-GUID: CPlRNB8FOKYYRd0A00-ads4OsbUDU1DJ
X-Proofpoint-GUID: CPlRNB8FOKYYRd0A00-ads4OsbUDU1DJ
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocation of a hugetlb page for the hugetlb pool is done by the routine
alloc_pool_huge_page.  This routine will allocate contiguous pages from
a low level allocator, prep the pages for usage as a hugetlb page and
then add the resulting hugetlb page to the pool.

In the 'prep' stage, optional vmemmap optimization is done.  For
performance reasons we want to perform vmemmap optimization on multiple
hugetlb pages at once.  To do this, restructure the hugetlb pool
allocation code such that vmemmap optimization can be isolated and later
batched.

The code to allocate hugetlb pages from bootmem was also modified to
allow batching.

No functional changes, only code restructure.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 183 ++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 144 insertions(+), 39 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 52f695222450..77313c9e0fa8 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1963,16 +1963,21 @@ static void __prep_account_new_huge_page(struct hstate *h, int nid)
 	h->nr_huge_pages_node[nid]++;
 }
 
-static void __prep_new_hugetlb_folio(struct hstate *h, struct folio *folio)
+static void init_new_hugetlb_folio(struct hstate *h, struct folio *folio)
 {
 	folio_set_hugetlb(folio);
-	hugetlb_vmemmap_optimize(h, &folio->page);
 	INIT_LIST_HEAD(&folio->lru);
 	hugetlb_set_folio_subpool(folio, NULL);
 	set_hugetlb_cgroup(folio, NULL);
 	set_hugetlb_cgroup_rsvd(folio, NULL);
 }
 
+static void __prep_new_hugetlb_folio(struct hstate *h, struct folio *folio)
+{
+	init_new_hugetlb_folio(h, folio);
+	hugetlb_vmemmap_optimize(h, &folio->page);
+}
+
 static void prep_new_hugetlb_folio(struct hstate *h, struct folio *folio, int nid)
 {
 	__prep_new_hugetlb_folio(h, folio);
@@ -2169,16 +2174,9 @@ static struct folio *alloc_buddy_hugetlb_folio(struct hstate *h,
 	return page_folio(page);
 }
 
-/*
- * Common helper to allocate a fresh hugetlb page. All specific allocators
- * should use this function to get new hugetlb pages
- *
- * Note that returned page is 'frozen':  ref count of head page and all tail
- * pages is zero.
- */
-static struct folio *alloc_fresh_hugetlb_folio(struct hstate *h,
-		gfp_t gfp_mask, int nid, nodemask_t *nmask,
-		nodemask_t *node_alloc_noretry)
+static struct folio *__alloc_fresh_hugetlb_folio(struct hstate *h,
+				gfp_t gfp_mask, int nid, nodemask_t *nmask,
+				nodemask_t *node_alloc_noretry)
 {
 	struct folio *folio;
 	bool retry = false;
@@ -2191,6 +2189,7 @@ static struct folio *alloc_fresh_hugetlb_folio(struct hstate *h,
 				nid, nmask, node_alloc_noretry);
 	if (!folio)
 		return NULL;
+
 	if (hstate_is_gigantic(h)) {
 		if (!prep_compound_gigantic_folio(folio, huge_page_order(h))) {
 			/*
@@ -2205,32 +2204,84 @@ static struct folio *alloc_fresh_hugetlb_folio(struct hstate *h,
 			return NULL;
 		}
 	}
-	prep_new_hugetlb_folio(h, folio, folio_nid(folio));
 
 	return folio;
 }
 
+static struct folio *only_alloc_fresh_hugetlb_folio(struct hstate *h,
+		gfp_t gfp_mask, int nid, nodemask_t *nmask,
+		nodemask_t *node_alloc_noretry)
+{
+	struct folio *folio;
+
+	folio = __alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask,
+						node_alloc_noretry);
+	if (folio)
+		init_new_hugetlb_folio(h, folio);
+	return folio;
+}
+
 /*
- * Allocates a fresh page to the hugetlb allocator pool in the node interleaved
- * manner.
+ * Common helper to allocate a fresh hugetlb page. All specific allocators
+ * should use this function to get new hugetlb pages
+ *
+ * Note that returned page is 'frozen':  ref count of head page and all tail
+ * pages is zero.
  */
-static int alloc_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
-				nodemask_t *node_alloc_noretry)
+static struct folio *alloc_fresh_hugetlb_folio(struct hstate *h,
+		gfp_t gfp_mask, int nid, nodemask_t *nmask,
+		nodemask_t *node_alloc_noretry)
 {
 	struct folio *folio;
-	int nr_nodes, node;
+
+	folio = __alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask,
+						node_alloc_noretry);
+	if (!folio)
+		return NULL;
+
+	prep_new_hugetlb_folio(h, folio, folio_nid(folio));
+	return folio;
+}
+
+static void prep_and_add_allocated_folios(struct hstate *h,
+					struct list_head *folio_list)
+{
+	struct folio *folio, *tmp_f;
+
+	/*
+	 * Add all new pool pages to free lists in one lock cycle
+	 */
+	spin_lock_irq(&hugetlb_lock);
+	list_for_each_entry_safe(folio, tmp_f, folio_list, lru) {
+		__prep_account_new_huge_page(h, folio_nid(folio));
+		enqueue_hugetlb_folio(h, folio);
+	}
+	spin_unlock_irq(&hugetlb_lock);
+
+	INIT_LIST_HEAD(folio_list);
+}
+
+/*
+ * Allocates a fresh hugetlb page in a node interleaved manner.  The page
+ * will later be added to the appropriate hugetlb pool.
+ */
+static struct folio *alloc_pool_huge_folio(struct hstate *h,
+					nodemask_t *nodes_allowed,
+					nodemask_t *node_alloc_noretry)
+{
 	gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
+	int nr_nodes, node;
 
 	for_each_node_mask_to_alloc(h, nr_nodes, node, nodes_allowed) {
-		folio = alloc_fresh_hugetlb_folio(h, gfp_mask, node,
+		struct folio *folio;
+
+		folio = only_alloc_fresh_hugetlb_folio(h, gfp_mask, node,
 					nodes_allowed, node_alloc_noretry);
-		if (folio) {
-			free_huge_folio(folio); /* free it into the hugepage allocator */
-			return 1;
-		}
+		if (folio)
+			return folio;
 	}
 
-	return 0;
+	return NULL;
 }
 
 /*
@@ -3196,19 +3247,29 @@ int __alloc_bootmem_huge_page(struct hstate *h, int nid)
  */
 static void __init gather_bootmem_prealloc(void)
 {
+	LIST_HEAD(folio_list);
 	struct huge_bootmem_page *m;
+	struct hstate *h, *prev_h = NULL;
 
 	list_for_each_entry(m, &huge_boot_pages, list) {
 		struct page *page = virt_to_page(m);
 		struct folio *folio = page_folio(page);
-		struct hstate *h = m->hstate;
+
+		h = m->hstate;
+		/*
+		 * It is possible to gave multiple huge page sizes (hstates)
+		 * in this list.  If so, process each size separately.
+		 */
+		if (h != prev_h && prev_h != NULL)
+			prep_and_add_allocated_folios(prev_h, &folio_list);
+		prev_h = h;
 
 		VM_BUG_ON(!hstate_is_gigantic(h));
 		WARN_ON(folio_ref_count(folio) != 1);
 		if (prep_compound_gigantic_folio(folio, huge_page_order(h))) {
 			WARN_ON(folio_test_reserved(folio));
-			prep_new_hugetlb_folio(h, folio, folio_nid(folio));
-			free_huge_folio(folio); /* add to the hugepage allocator */
+			init_new_hugetlb_folio(h, folio);
+			list_add(&folio->lru, &folio_list);
 		} else {
 			/* VERY unlikely inflated ref count on a tail page */
 			free_gigantic_folio(folio, huge_page_order(h));
@@ -3222,6 +3283,8 @@ static void __init gather_bootmem_prealloc(void)
 		adjust_managed_page_count(page, pages_per_huge_page(h));
 		cond_resched();
 	}
+
+	prep_and_add_allocated_folios(h, &folio_list);
 }
 static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
 {
@@ -3254,9 +3317,22 @@ static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
 	h->max_huge_pages_node[nid] = i;
 }
 
+/*
+ * NOTE: this routine is called in different contexts for gigantic and
+ * non-gigantic pages.
+ * - For gigantic pages, this is called early in the boot process and
+ *   pages are allocated from memblock allocated or something similar.
+ *   Gigantic pages are actually added to pools later with the routine
+ *   gather_bootmem_prealloc.
+ * - For non-gigantic pages, this is called later in the boot process after
+ *   all of mm is up and functional.  Pages are allocated from buddy and
+ *   then added to hugetlb pools.
+ */
 static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 {
 	unsigned long i;
+	struct folio *folio;
+	LIST_HEAD(folio_list);
 	nodemask_t *node_alloc_noretry;
 	bool node_specific_alloc = false;
 
@@ -3298,14 +3374,25 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 
 	for (i = 0; i < h->max_huge_pages; ++i) {
 		if (hstate_is_gigantic(h)) {
+			/*
+			 * gigantic pages not added to list as they are not
+			 * added to pools now.
+			 */
 			if (!alloc_bootmem_huge_page(h, NUMA_NO_NODE))
 				break;
-		} else if (!alloc_pool_huge_page(h,
-					 &node_states[N_MEMORY],
-					 node_alloc_noretry))
-			break;
+		} else {
+			folio = alloc_pool_huge_folio(h, &node_states[N_MEMORY],
+							node_alloc_noretry);
+			if (!folio)
+				break;
+			list_add(&folio->lru, &folio_list);
+		}
 		cond_resched();
 	}
+
+	/* list will be empty if hstate_is_gigantic */
+	prep_and_add_allocated_folios(h, &folio_list);
+
 	if (i < h->max_huge_pages) {
 		char buf[32];
 
@@ -3439,7 +3526,9 @@ static int adjust_pool_surplus(struct hstate *h, nodemask_t *nodes_allowed,
 static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 			      nodemask_t *nodes_allowed)
 {
-	unsigned long min_count, ret;
+	unsigned long min_count;
+	unsigned long allocated;
+	struct folio *folio;
 	LIST_HEAD(page_list);
 	NODEMASK_ALLOC(nodemask_t, node_alloc_noretry, GFP_KERNEL);
 
@@ -3516,7 +3605,8 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 			break;
 	}
 
-	while (count > persistent_huge_pages(h)) {
+	allocated = 0;
+	while (count > (persistent_huge_pages(h) + allocated)) {
 		/*
 		 * If this allocation races such that we no longer need the
 		 * page, free_huge_folio will handle it by freeing the page
@@ -3527,15 +3617,32 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 		/* yield cpu to avoid soft lockup */
 		cond_resched();
 
-		ret = alloc_pool_huge_page(h, nodes_allowed,
+		folio = alloc_pool_huge_folio(h, nodes_allowed,
 						node_alloc_noretry);
-		spin_lock_irq(&hugetlb_lock);
-		if (!ret)
+		if (!folio) {
+			prep_and_add_allocated_folios(h, &page_list);
+			spin_lock_irq(&hugetlb_lock);
 			goto out;
+		}
+
+		list_add(&folio->lru, &page_list);
+		allocated++;
 
 		/* Bail for signals. Probably ctrl-c from user */
-		if (signal_pending(current))
+		if (signal_pending(current)) {
+			prep_and_add_allocated_folios(h, &page_list);
+			spin_lock_irq(&hugetlb_lock);
 			goto out;
+		}
+
+		spin_lock_irq(&hugetlb_lock);
+	}
+
+	/* Add allocated pages to the pool */
+	if (!list_empty(&page_list)) {
+		spin_unlock_irq(&hugetlb_lock);
+		prep_and_add_allocated_folios(h, &page_list);
+		spin_lock_irq(&hugetlb_lock);
 	}
 
 	/*
@@ -3561,8 +3668,6 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	 * Collect pages to be removed on list without dropping lock
 	 */
 	while (min_count < persistent_huge_pages(h)) {
-		struct folio *folio;
-
 		folio = remove_pool_hugetlb_folio(h, nodes_allowed, 0);
 		if (!folio)
 			break;
-- 
2.41.0

