Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFBF793139
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 23:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244657AbjIEVqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 17:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242437AbjIEVqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 17:46:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6959EE42
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 14:45:45 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 385Le0AP020248;
        Tue, 5 Sep 2023 21:44:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=FjiEFcLPHO4DD4C9WEFm/uQerVdf8Ih+bp5vWwT92M0=;
 b=gy7xCZ4kgj5a3fRwXzHd7coO34aKD5aRzVed6A8PeERPUcObk3LFMmWfy9otvsS2Z7NL
 XFdL6m5OAKrmgikxSL5sWlUqzC9kQoDu+qmqmlJhHKC83T8q2stmkIaqvgqQEVTadsmj
 V6N+9kNIvQA/EZjwCngMaff3UGovlqtYmxw7vnN/cNMoe3/ZwWmEBqi6f7MOGtvNRlN0
 aANPDEUxzeuVfyXDZ87B8HpqmvbSws1W7UYlw0mCT8UvGl9GG2Xr9ab9hJU+wGdf6xJf
 Vcf+ClAdZSSQvH3PFF0nnk1admUCuXvSLehHBt6JstJ2VHIc5My4dfvFdjBkkno+B1Xy zA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sxcem807s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Sep 2023 21:44:50 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 385KEUfs028145;
        Tue, 5 Sep 2023 21:44:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3suug5bd4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Sep 2023 21:44:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3ybtoeyRcmB85WHcCOzInlgfEBbTDvLNYSfwzg7tLn76dUlbVlUszKGvLJq4l9l7wYM7e+9f8fS9vo+Cl9ti9Fvvw5zRR4HJ+XXSbhVLEfbHMBJ5FeR81mJgHCf7wTpvIC8hK1sOfj7awcB4dXeO3w49fATEXmIQ546+fe+/140Rg5zYaT6Id34dME4lsCTwqwEFb8wpp6xmwIsVWFbo2ESZUzOFEks/kE5P8h9DEslzZhhBCcx4L9ocS/MMlhNR3HPR24eGVBYVNr/rgga3WU19PD4pa5nOY/RmU8X+a4Bw7Kz3bkz4TvpiG7mHob5rjCTExhbNUtgpadsMWbk8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjiEFcLPHO4DD4C9WEFm/uQerVdf8Ih+bp5vWwT92M0=;
 b=dW3mGvdc1V1fCprAdYIUcA7WTegsbFyuwSza5aUm2VJRDZy5/n4S0oIOlZoE/x1puQ5/W01FkbXlROZvCxS7B1r0ZresDSbIqadlXHxVn3QaKXsZMqh7gRYEXLtZsq//vjCO3Rj4V7bH1f9PLjMHv9p0+q7Kqbl2AuAX68XVOOgQQw2nDiYbSGp/p6OJktLpey7pG2Hu7q2ejYvovx13NvL6CcUovSrXhirufSEgnncAmkxY1h1LkDn+S3umpBiDRkvQCqY53g+HhqgVstdG8kavCNf+wscYfT4X6exyyZttpt+kDs/EzI4X5W88CRL4cCx3ajJn/2/5E5Lf7EON3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjiEFcLPHO4DD4C9WEFm/uQerVdf8Ih+bp5vWwT92M0=;
 b=PKAiOh2kJNenqYgOoAr3lOxVGocim5d1u7zZ7V3z+BkmbTucSgAqBh959wNw0cLaL998PLNfFco3McFBHvoXXDjGlHXIFe7CFEsf47m/WqOe+JbJgozxw0gkqZpR5Aiy/k1DpOVZxpeDHcy1XpLnndzUivaRABrOBqhoz+LZxb8=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW4PR10MB6395.namprd10.prod.outlook.com (2603:10b6:303:1ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 21:44:47 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58d8:cf97:ae4b:1715]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58d8:cf97:ae4b:1715%3]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 21:44:47 +0000
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
Subject: [PATCH v2 09/11] hugetlb: batch PMD split for bulk vmemmap dedup
Date:   Tue,  5 Sep 2023 14:44:08 -0700
Message-ID: <20230905214412.89152-10-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230905214412.89152-1-mike.kravetz@oracle.com>
References: <20230905214412.89152-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0080.namprd03.prod.outlook.com
 (2603:10b6:303:b6::25) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW4PR10MB6395:EE_
X-MS-Office365-Filtering-Correlation-Id: 06b18e07-c825-4acd-4d6c-08dbae595317
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JMc8wGd9JLazJvIhvcsxaXnk+Wpho5bVm4aWBZOdOarbY2ip+DOj4GHs2rDKBl5rVGWQAjO+EjznfjlOo0IX0v00EVzST/lDZg/8xLqFrb+hpAlFZ6s+XfJ1po5xOiNgpNUaRV7bwg7lXL9fjmzR4QF4jtCvZ8QNOoVZasiKPHkTOs5e9Vb++k9wghW9JJh8Kqq6zBSAIxF3UBztwy3C2Ppyp8IVO2l18XyQrOnFk1n2nmBwv8bLg+T27avlPOhC9sqYFxXIoEO1NTHki/6RJkxFdTQCEFZmJeUi8BMvdK7PFoYy1D9iUinZShIZWvHCIQ0cd51y9JWiN+Hc2GoXKFpKzebtQ2DR5T/u3elQg/Wm9kYbGBN6v+1yOdirNAjIUU2rBgCbb2RDu+NP+/DvNEbJ97FqqO6eFbTvkrCTL7WA7eh1NRZQE92Y66+v+R4/U1orySejubpudC3ieMy01HLXH5ynNmDexiRYE2JrFsVVkFL/lyXIT8CCGveC/rBNLRyFkzriVjWZumLEQCwcpXJxI8xKSliLnFuwmLOmbi1UIcga57K01/abPu3kPikk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(39860400002)(396003)(136003)(186009)(1800799009)(451199024)(6666004)(6486002)(6512007)(6506007)(478600001)(38100700002)(2906002)(7416002)(107886003)(1076003)(2616005)(26005)(83380400001)(86362001)(36756003)(66946007)(5660300002)(54906003)(66476007)(66556008)(316002)(44832011)(8936002)(8676002)(4326008)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MKsyrStyfowNZO6nsFCqQKY5aMpsjBAUYEleu8eZd+tq8cHlNfnq/2Lu6xDb?=
 =?us-ascii?Q?k3N+iRvxQ6wD8WPSVx36KRF9a/6mhbBKMGYpkV6R8D1FY5mEF3pk/hdbDLpU?=
 =?us-ascii?Q?Pn1DlfXTiqqbnugmOiVKTyNeJ8dEIYq/LZvh9IL84/KMsLYAeSGfF8Mn399O?=
 =?us-ascii?Q?eqAsBU2cdeIgHPczkuZ3DU9gIW9MHkMY/c+XTBKzhAs4tK3oFmG5/kPwjh2B?=
 =?us-ascii?Q?xlM8bjEOUz8RktISKkK2JqfDhNUQeUQo6pgzJMPnuMFZoG4dslFgCSiBpNHR?=
 =?us-ascii?Q?pc/kU6gehy/mx++SJc/R+2UI7LzIjdiZNLGu+NuO/QaACMUQjmkx2K8Zgsua?=
 =?us-ascii?Q?B9u4KNb3yOI5wm/ArxB9Xg+1TeA2YkJbzKKMzkq7tSpm/pRriJEYJ4F2VgFO?=
 =?us-ascii?Q?Rl6kUZ9WfKDohKecZg5xJWyCDkelBXKMCaiOEWJDHpRlezGG0umiZtHO9whd?=
 =?us-ascii?Q?b/rQXy3HYAosru7BBDggQAWNmKseYIQE6qhXrkqU704u0yCaNCTgjRziLgUJ?=
 =?us-ascii?Q?Mq+DGjrskNE8TgUq09qVnkunX8WnNH0V036lJtd5XeqWzuACAMNaUK7ESo4x?=
 =?us-ascii?Q?jKDynbA/yt5Do5mftdFdqwO7+rQVVf/iFSajdDNIYPTEV6cvVlPEYuqeC05R?=
 =?us-ascii?Q?UAHFiZ2jzXmQu1Wk7YYMT2aT0kv3UbaDnIrI3Brtn0pGfe5/iwzua8xLlgYQ?=
 =?us-ascii?Q?e4r01P/fZbpX3FC7NzWOaHxmpbY0rW2/WkNGWsJm7wjEtjtQPc8J+aJU+FWc?=
 =?us-ascii?Q?qGN1cBm4jB2fDNutuF6IaG+1+OcQcYJSbrfMHQU1xR8F7AOVh3BuIoMdmQvb?=
 =?us-ascii?Q?8e/XXsKpFh7grhUspIFs6moGaKJ+z6Rs+VSDzDN4iMA4dQCqv6K5rV+VUsi9?=
 =?us-ascii?Q?nbMvSl4LC2X3/smJqsgGpD+VEck7X7VeuohEb7f73UAyBRrnpnNsf8/sJrqp?=
 =?us-ascii?Q?Gt/70hSCVr+KkHtEY1V+qB+LkS8vGPiCCYiR7W2mFq7cfByz7xrN/EhcfXMr?=
 =?us-ascii?Q?BYtAVcd/XtRT+UiIwoM0HgOzxVBj05rGS9QI3C7ApdP/MZvxWT3XQLZ8rJxb?=
 =?us-ascii?Q?S0ISS9PDle6bFl+IETSgTVGdKW8SnATsU3KT/EPV1oJQtgswKU/ZbHvDxncA?=
 =?us-ascii?Q?gvhwPnHqWO0iIuK8cQXlpVKex9OZ9OZyvgLQpTL9ipbCiqGwEUer/+8s4xX8?=
 =?us-ascii?Q?8iUjDL+x585m+0TPURcDEoVRny1zGHj3pCTdLr2Kbj7WRv0ylMBiYvP3RskY?=
 =?us-ascii?Q?jB1vcsWvhKds9sgEfdVJIsdt+B4zZWikg7cqwDkMjZtYEf3Rd9dlZcoX1R0v?=
 =?us-ascii?Q?Z0G9xIqCKzzxqzCyU5QQQZ7SNTFiT2VRMV3Apvr3/aNd0uotHgHczvOcEp+N?=
 =?us-ascii?Q?d2oxf425VMwo8wfrQ/hClxpMPME7Wm3gcUauGm1f/qAr3GTEkHVLFpLi0NrH?=
 =?us-ascii?Q?UX32i0VHOVBZ0zRLwk0L+p6nvWfEQtZKz0y+yRVg09bgX3+EfMZY0De6cMFs?=
 =?us-ascii?Q?UcW3dHdZ5jMcH8PawOEpoWhrclgjVbRV2ZObSn1qsY6CXUbzX9JNY+um6ss2?=
 =?us-ascii?Q?sVUx70EPfgiv2pYp5enPYqbJWxkuZw/kHRA4xDPg7gN37EAPrS4n8rqX6C8N?=
 =?us-ascii?Q?tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?CQ4OEmir/yiudi9dtt9Fyl+ifmT0u0O9QGzilCxE9GzNz912+1aj3UEoOeVv?=
 =?us-ascii?Q?vcvB4pj5R90+EeGq/xeBLiCQFnmJX/1ou9a/31PDWbEfUzSlrwq7X1xwb1yn?=
 =?us-ascii?Q?s6u4yHxHcekPnwdibEK6G9+Eda56oZcSsPHGEAdjVFUdsbmQfgGOAnhgGXyf?=
 =?us-ascii?Q?WNiBWNWY+0vn1PU+IpHdzo8KCFG4zuwwIjyWfddFtYZpQBZrizXqWxNd4HFp?=
 =?us-ascii?Q?LB7QllnzYb/YJ8Q2CQY+rArY5Gut9OCMyl4Eg1GRCS1yjQS7FNq6rw+91J4A?=
 =?us-ascii?Q?+SYOg8U6UBvXx0vavJW78WM4aMKWnz9/wk9oWRcCItvyh4zXXYcNCCLdn7om?=
 =?us-ascii?Q?VitAHCc6VPkvz5mMaabJDS2py1iOETCb76hPqY9b7Bsxvw2kjdT+WNeX8pAc?=
 =?us-ascii?Q?6IgKOq8mKoYMTZhO2/xBjMbh2wEsd+ynjqWFOULZ/azOM1wdpGzft4jr6ypO?=
 =?us-ascii?Q?49DN+f+7QemVWd0pD8zUVPacJGlbnQMQW+Refsm13E1Ko+4IFLjvlBOE3ddS?=
 =?us-ascii?Q?Cnz/qDbqwlZLX0Ch6ldPiyjbjJs1NrfutQ+oRQI2iTteG1V8SR3D2qqUxZGz?=
 =?us-ascii?Q?x9o7xbEkM35moakoAEsaZxeqlQoS8+CZBf23uqRHDxk1dZ31K9lWzoVhPnZa?=
 =?us-ascii?Q?jbLnmyrxYvM7d8SvPnLKoUgkkp21N0ZJo8xR+2/uo1I7OcAjpimlvq0kzs3W?=
 =?us-ascii?Q?NMtfP5bc41fERNF9h3XpO7fcpTPHU4KQpEOtc6GPSuSpM2RLJVsG5XvBnNHL?=
 =?us-ascii?Q?jZgTve2x+lduN/6uB0LyQVjEtSwGxM2x5oZEGnOdL8CIb9/lhbf+tsZmtAtZ?=
 =?us-ascii?Q?mP01ggFfUYSzSSA3LgJjzGno+GTmnpK4wc2x7lo95fSzgr6tC0JS3lAJ0h7I?=
 =?us-ascii?Q?6P7Lwk0wuOzD8P9EyNWgYCvL8NRlnoRvWtHwrUXAQ0/ggCv7t9c7jfwe7giB?=
 =?us-ascii?Q?+nwnrr5LQJcPgEpoiIn5vX1kjqhmsm5IptveSqMMhc3L7/CoauGWQPGNAqnm?=
 =?us-ascii?Q?iZZFOHquvYquLx5lkAOtVopIGslAai82Y5MIIsMZpLxyy+UbsnkPug/ChHnh?=
 =?us-ascii?Q?ltdjyOZ8kANcdicLttQVnG7xgy26sQwiCorg4wREpYhMz3N2slUoWub27eFx?=
 =?us-ascii?Q?ZfXGU6TtWt0V?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06b18e07-c825-4acd-4d6c-08dbae595317
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 21:44:47.4098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z23esX+Hqqxc95HZxZIW2fTuO0GbwYuGyzcj/rad4jDOidbER4yz2GSvFsxfcE8jC9RKcOnIKdVvmJDXJ07nbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6395
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309050189
X-Proofpoint-GUID: 2ebrnMTaCSdFEW2h5N-BVX-FdItjkdss
X-Proofpoint-ORIG-GUID: 2ebrnMTaCSdFEW2h5N-BVX-FdItjkdss
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joao Martins <joao.m.martins@oracle.com>

In an effort to minimize amount of TLB flushes, batch all PMD splits
belonging to a range of pages in order to perform only 1 (global) TLB
flush.

Rebased and updated by Mike Kravetz

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb_vmemmap.c | 72 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 68 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index a715712df831..d956551699bc 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -37,7 +37,7 @@ struct vmemmap_remap_walk {
 	struct list_head	*vmemmap_pages;
 };
 
-static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start)
+static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start, bool flush)
 {
 	pmd_t __pmd;
 	int i;
@@ -80,7 +80,8 @@ static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start)
 		/* Make pte visible before pmd. See comment in pmd_install(). */
 		smp_wmb();
 		pmd_populate_kernel(&init_mm, pmd, pgtable);
-		flush_tlb_kernel_range(start, start + PMD_SIZE);
+		if (flush)
+			flush_tlb_kernel_range(start, start + PMD_SIZE);
 	} else {
 		pte_free_kernel(&init_mm, pgtable);
 	}
@@ -127,11 +128,20 @@ static int vmemmap_pmd_range(pud_t *pud, unsigned long addr,
 	do {
 		int ret;
 
-		ret = split_vmemmap_huge_pmd(pmd, addr & PMD_MASK);
+		ret = split_vmemmap_huge_pmd(pmd, addr & PMD_MASK,
+				walk->remap_pte != NULL);
 		if (ret)
 			return ret;
 
 		next = pmd_addr_end(addr, end);
+
+		/*
+		 * We are only splitting, not remapping the hugetlb vmemmap
+		 * pages.
+		 */
+		if (!walk->remap_pte)
+			continue;
+
 		vmemmap_pte_range(pmd, addr, next, walk);
 	} while (pmd++, addr = next, addr != end);
 
@@ -198,7 +208,8 @@ static int vmemmap_remap_range(unsigned long start, unsigned long end,
 			return ret;
 	} while (pgd++, addr = next, addr != end);
 
-	flush_tlb_kernel_range(start, end);
+	if (walk->remap_pte)
+		flush_tlb_kernel_range(start, end);
 
 	return 0;
 }
@@ -297,6 +308,35 @@ static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
 	set_pte_at(&init_mm, addr, pte, mk_pte(page, pgprot));
 }
 
+/**
+ * vmemmap_remap_split - split the vmemmap virtual address range [@start, @end)
+ *                      backing PMDs of the directmap into PTEs
+ * @start:     start address of the vmemmap virtual address range that we want
+ *             to remap.
+ * @end:       end address of the vmemmap virtual address range that we want to
+ *             remap.
+ * @reuse:     reuse address.
+ *
+ * Return: %0 on success, negative error code otherwise.
+ */
+static int vmemmap_remap_split(unsigned long start, unsigned long end,
+				unsigned long reuse)
+{
+	int ret;
+	struct vmemmap_remap_walk walk = {
+		.remap_pte	= NULL,
+	};
+
+	/* See the comment in the vmemmap_remap_free(). */
+	BUG_ON(start - reuse != PAGE_SIZE);
+
+	mmap_read_lock(&init_mm);
+	ret = vmemmap_remap_range(reuse, end, &walk);
+	mmap_read_unlock(&init_mm);
+
+	return ret;
+}
+
 /**
  * vmemmap_remap_free - remap the vmemmap virtual address range [@start, @end)
  *			to the page which @reuse is mapped to, then free vmemmap
@@ -602,11 +642,35 @@ void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
 	free_vmemmap_page_list(&vmemmap_pages);
 }
 
+static void hugetlb_vmemmap_split(const struct hstate *h, struct page *head)
+{
+	unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
+	unsigned long vmemmap_reuse;
+
+	if (!vmemmap_should_optimize(h, head))
+		return;
+
+	vmemmap_end     = vmemmap_start + hugetlb_vmemmap_size(h);
+	vmemmap_reuse   = vmemmap_start;
+	vmemmap_start   += HUGETLB_VMEMMAP_RESERVE_SIZE;
+
+	/*
+	 * Split PMDs on the vmemmap virtual address range [@vmemmap_start,
+	 * @vmemmap_end]
+	 */
+	vmemmap_remap_split(vmemmap_start, vmemmap_end, vmemmap_reuse);
+}
+
 void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list)
 {
 	struct folio *folio;
 	LIST_HEAD(vmemmap_pages);
 
+	list_for_each_entry(folio, folio_list, lru)
+		hugetlb_vmemmap_split(h, &folio->page);
+
+	flush_tlb_all();
+
 	list_for_each_entry(folio, folio_list, lru)
 		__hugetlb_vmemmap_optimize(h, &folio->page, &vmemmap_pages);
 
-- 
2.41.0

