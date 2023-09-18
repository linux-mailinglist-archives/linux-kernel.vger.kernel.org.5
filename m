Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F137A560B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 01:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjIRXDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 19:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjIRXDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 19:03:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F1CFB
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 16:03:20 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38IK54UD005659;
        Mon, 18 Sep 2023 23:02:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=Y16y6xPVgvI7a8L2xgbgzpDrXOvAdzxTZsCIzk2fyVw=;
 b=3x48z9XgPar73/CgIkpbWSMGfqKQUl3y1yn7I8wh01CQ5gF8vmLLlSxRfde4ANsKBGx8
 gR31H+ADpLFtDhzQTmCm2qu2YlQecFpAAHFj8s8qTAxBeuDV4wkP8O1X73PD7CwcDqYP
 Wy4mdv4DQRH/Z8eHWiJ/dvOIpNCbhcZqml0+BweCt9zT+4EqjvwsG57Cne30TRbqXWHt
 PKap0+n43wb+3GG6ospP9Ozwx7XojBAbli2f1/s3xFYdzjSjYw36PdWjjAAhIegc58zg
 nQ2R8ZC0Xon0L2ctuGOYEqHK2hd6Uj3RgqZDfmI+GvJWpaUpSIiuOiRnWcdrKD1yvOSE LQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t52y1upr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Sep 2023 23:02:26 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38ILubHU016052;
        Mon, 18 Sep 2023 23:02:24 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t4nder-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Sep 2023 23:02:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJ97kMFysiMp9zSD2wkpOXM6R/sZW9PQA2LnVE4dkn5bDE7JjLMY8MtanVM+1ZQLUFrTEOURLQKGZuUHQOGg2i2zQipV6aXPCrzyHOY6BvFATPzo94VzEJ3eAloNB12WZcbGmeHk/GSioTDFWd6iSi3uvyNxb4KsvXalGaLwXPm+fPKbcT8icpuOFu2p/CU2Rczi5qdAc8eKJnV3Mo4w+uacQy32SbuHHcMv1HSI0ehG1M5PjqT0WPgltMnJxuhxGIn5rpVvXVphTBDtExVcDBDjAltdntrRxEMFDvLCx/mp4QvC1BYWuXayg5VnHFnWbAKITf2juXCQWQVXO9tTbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y16y6xPVgvI7a8L2xgbgzpDrXOvAdzxTZsCIzk2fyVw=;
 b=fdyuzvF4X2Fk7NlCPWy4cQt2X6ZV5/CfqPd9uqbksqr93j7ZmV80HZjc0UQRF0zj5YMORfLBW3m/YrPn4X3nfuiMFIuYkBYI2edlr1sw6yQiCkCFqOC8JeGAtEiNpaaM4pyUZ5fuAzQtg/DNyaTrD6hG8u1ZZ/Mknoa2+lM0UFhcvBsvP4zDIBw3Ex3tPjzOpacv76Pn1GLn3MH2BgNlNjwrpsMlujrKNGsxpr2tbP5CTdirJcRl2m8Va1FoBObE0rmRw9cPut+MPVzSx+uiPlAmj7A5+eIvF+49VKey2VY1+dRNmkBrH3vwJxgoeYw236cWXeauA03w48gjG6u/Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y16y6xPVgvI7a8L2xgbgzpDrXOvAdzxTZsCIzk2fyVw=;
 b=wW+yoqMLzOftf+0SXOS94q4bNo8xgEURYGhmGksBI5A92+L6vC/tM6D87ZAVJMrUVqfWz8LLgrr0T66jjNhPmgwXvW4wYn1+lo4W2ftu/g2BmtVYRfSue5jNsvYR5hjUup5HpsuiQfakHyivZi9zdA/lyf6RHIw9DUu6p5xOdKw=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH3PR10MB7494.namprd10.prod.outlook.com (2603:10b6:610:163::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 23:02:20 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 23:02:20 +0000
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
Subject: [PATCH v4 5/8] hugetlb: batch freeing of vmemmap pages
Date:   Mon, 18 Sep 2023 16:01:57 -0700
Message-ID: <20230918230202.254631-6-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230918230202.254631-1-mike.kravetz@oracle.com>
References: <20230918230202.254631-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0049.namprd16.prod.outlook.com
 (2603:10b6:907:1::26) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH3PR10MB7494:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d3de23c-99c0-40e1-9a80-08dbb89b5025
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h9qFBw9tL1ZNaMQ3gUxzkE6jX8P1w0+gx4cGr7Z1kUnG+2Us+0+qY8Nm8TsxyM71EHU1VEdfj3yOl7I/FHKgitdUDR2N6/q0bzuucK79pnAIwHe/vZOF17UUHmWb5aSdVgLv5KhRF7GyifwNqFwDhkDJ1HqMVmsjs5QWmM5UauyCRaw/k9zALcma9/2K9BQ/utN2iXQVwZ92hPF+ruAkclyqTVsvTERnhlx4QNSK5mOHIwGTsvs1SJo7u1uhzXyquGJPYtsGrlq2FnXNkgEaSWWzxI6mWRya8x3zU/e4+uzG/FUaxeCsyZjeXEKErliM+aQ1MpuY9oChyJwHGyuJDySFWNQ5pWP1Y6PxmY/aiojwnwDvzykCRX5c+edAL0KW+wCm8EOzYPQpn9AwuoTs3ZkEBEPsfHEkCbf0Uh2N3uyd/NkbuoNur8n7wyDYkJp7e8U9oAfsQ8tlPJ1yi221bnWN3mkLUgDHycskXL19C/mN1WyCj2R2hD9w8AMkr8KN0yNBW8kVZHNrCbf3n2Mjgq4kpSjVDovNwjZgpWi2ZTr8ex3btOaz+m4/d/Wsh1hE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199024)(186009)(1800799009)(41300700001)(316002)(66476007)(66556008)(54906003)(66946007)(478600001)(6666004)(38100700002)(7416002)(2906002)(86362001)(36756003)(44832011)(5660300002)(8676002)(4326008)(8936002)(83380400001)(107886003)(2616005)(26005)(1076003)(6512007)(6506007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?miGrKbcNZpW5j9hgE8fPdwljQ0DRmW1/XJOTaU2FLv5UirNhYK6M2lfsfQEQ?=
 =?us-ascii?Q?32lZvv6kwg/YQkZ8+kYf3iCcMPm2MSvfVee6nXxTlE2ZTFJ65/5DepQ8aYRL?=
 =?us-ascii?Q?wSAGIyWjLayrIDlUNgzLXvgqYhw/EWL0Xb5Rb50JeKaRNTvAhK3SdkawH/O/?=
 =?us-ascii?Q?uywBIyA1SQiD240gYpabYI65KleibyG67y6qacDMYhurZXBoRhUOb/fmidhC?=
 =?us-ascii?Q?uaKTvbO5WYqiqexTBAD+NdzJoa7PQ8MGHoX/+qtqXx9eu5Ome6y+CTxthlex?=
 =?us-ascii?Q?SFPS018DIv20xHxyK40/8jxjlqm32Fhe0oofhTGMWjy9abkJcQ2MQtVOVds1?=
 =?us-ascii?Q?59ucDXjzk3KGIyi0f/z6K+H098ZYD1A0L3L5yOVTlN/oGrGUFApeyedAX9J1?=
 =?us-ascii?Q?J1qUZcbaK6zG8jl+B0/0f6bez454XzSgyw6BIJXFV7bKZF4eWPyTgZFz1YGd?=
 =?us-ascii?Q?inlb2jkMN0XHXAIUGhJOfbmHtw8CCbFJqRH6J6I/NN/SK7oPl7g6rWCLowx3?=
 =?us-ascii?Q?b01HF5PAVUBUbEgRdYgBSs7EE3HNXLE7yS54QmW5QJf4xcHsotQ/H6CbYCec?=
 =?us-ascii?Q?gYSLOcaJjz6BOQMBlyKUkxIHa/3InS/8c6q27JcgngyAKeMiKBEaCgknf+sz?=
 =?us-ascii?Q?7ut4R51KU1ksftcHxoavZ0uDg3I6+q5SYj3KIF8cySJjJfk+VcMwGoMzV6WL?=
 =?us-ascii?Q?2JhsN+yTFaILCLySX/fG6z0xXG2HuaP2hp2ZQQaSj7UJbX4czETSQZKH9d6A?=
 =?us-ascii?Q?aFal1mNHoKplN8ki5m2ptOsWaRMGFHGmNrFVzIoyyGjrY5P5YE9l1/6xkoAP?=
 =?us-ascii?Q?t/iGKjTpc+nQkjHxxNg01QOlmilYqvOSX997u/mqFQ3/H2a9OkNtMcZyYgzb?=
 =?us-ascii?Q?pM9UvQXA3l9HFeijiGTzFOnbwqay+NeVUNOx/jKXUSRIiApv1sLfNJyKleBq?=
 =?us-ascii?Q?jxA04ED/oQaMf+0HSC0d//BcPfWE/JJh+YbBnuBc8QlOAurmexM07p7CL8G3?=
 =?us-ascii?Q?cm+na0me/libWP3r6LOG/RRY9BjJX7zzuuyU+ARrHVAKPAqWWO6vBOPd9RO/?=
 =?us-ascii?Q?up/kji5yLOwc4XJTcYVN3Kf1HuqNd+SYmoyyIvD2PFz9jmqqgV8f3T36orsC?=
 =?us-ascii?Q?Of9E/7M5LsCeR5XHq6slkgrTQ4NchTApHmxROkgZrls4k5x4rLfDL/ay8M19?=
 =?us-ascii?Q?EE3pOwm9qP2kC/lrPBeivtMmvNEZHP1KS7Mim0kB+l5zW27hVvzlHxYCAfCl?=
 =?us-ascii?Q?WTZx+VfrNnmwRl2UiEyGO1D21HH5Z/rdTVVvTYAwKN2Q6Lt1qPwtr1lO+EJ8?=
 =?us-ascii?Q?AzI0OIffNPeAH/qjSnbNKnH46M8ABM4gVkhb1PuxqTArLakOriui+eXSeh90?=
 =?us-ascii?Q?mHoSb0/2cRjJv4LzQ5yio52KEBm33cidu/YYhcAQHFiWzGE5NgpkJZEX3CVY?=
 =?us-ascii?Q?gg/8lTkPSmvalk8+gYfldu7DUh9boNPOsMEhkegA8XOBJqBCt3Dov2ftTkXM?=
 =?us-ascii?Q?9LeJc/oK/VtzaQ0w4QM79AMGG45/twW03WOy6w4+weX5PGHKO+Wpl7r9aVBl?=
 =?us-ascii?Q?dPe04yHFEYgNkMhO/bWB10DNWmq8nVWkBjNWuKMe?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?L0Bwz1RY7TakwgtaALdP1mLCehayJnJ5os+FKGmg+wfUIDWxbRUv6il69v6z?=
 =?us-ascii?Q?8+BBrbB8EUFEZ1krUUka3YAvpfv4RgEMbmNVpI/9hTh4EvjMflxRMgLApjak?=
 =?us-ascii?Q?3dVuQbOHIHuUynlUlksPU8LD2TP+tp5fia8aEDlblbHZEddeNrAdLAUeI28X?=
 =?us-ascii?Q?uoheLEAZSKiJx5+ZWSCNVpoJ7YODPCru//+0I2nxJk7kxo/7OwuG48HGf+P9?=
 =?us-ascii?Q?R0kjn4jLLuC83dxjfvV6NQxv5D9KQMAPpjdB3s/8OXVnoYqI2wx4Od3eWl0p?=
 =?us-ascii?Q?5HgLdRDvZI6HQBD4eiblQAvk4ph2FGPwPrj1Qysp4VBLIWIZmzNGS/B4ax02?=
 =?us-ascii?Q?XMWYpGFFjlbnMuVueAMdAK0x1jIv4E2VI6i35bEpYwJYOfOGWUFzug7fK95v?=
 =?us-ascii?Q?7WEtdtH2yPvb3dTFrLQ6T5CG0SUrLFz+M3QZihl9TLa6tmG9xPpBF4m0xynw?=
 =?us-ascii?Q?6hoGSpWljZEeqVJShs6OhEs6wW8kgf6WPTgUZiXelOGCnz8y7IelpbfBTrvC?=
 =?us-ascii?Q?QHARpkZwajyN7NrvA/VMXjnatzC9Le+nwEHZSc+ctZ6Kxu7ff1wq3nnpmq2H?=
 =?us-ascii?Q?0z8KcbSN4QDA0E5S0OlGpNzw2V8WnodTewbt2/tKgH2LJsfe2cnYuXtIr1q7?=
 =?us-ascii?Q?4EBgS82m3kgq9IGOUD2XjL9E6ulyPuOQPAljCB2RQgu502JD+efJ4L/V8AeL?=
 =?us-ascii?Q?avIA1gJEb17KmWaib+zaNMdbSourPXV9S87dUdD96UO5xFNDq0xmKR3NkEB4?=
 =?us-ascii?Q?p8nByZzz2Qyms1YCg1jxfD2136v4xF0KZIwnL4V1xX9V4U5Uo36W4stf3apl?=
 =?us-ascii?Q?xfRnea8rNy5phtwiKTQLjD6Tt3KpBemwdR2g8CjBSle1EYFPD6V2X574habk?=
 =?us-ascii?Q?qzxeg31HVk/K/Q3YnCq5G79lgH07+Dteg4aUtK63Y+Q8sJuoL6Cqwt464aTk?=
 =?us-ascii?Q?vCKp1GbYvlsiOdzrYsy1SHBx3+n8aScMQJbHrWW8/lyKwQZx4XK+f7PUstr4?=
 =?us-ascii?Q?hHusGMHoy6/wD657NPjJvnhbNdb3h1l7dmmTXVOLg9MyE1knxxwsSdJRytxX?=
 =?us-ascii?Q?dK1HjMmsu6QcRlSVnFYF08ShDZJVvA+GbvMciPypNK29LKy0qUNNp12gOpwD?=
 =?us-ascii?Q?KCB5GzIqR9gl?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d3de23c-99c0-40e1-9a80-08dbb89b5025
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 23:02:20.8263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tlgvJR8qAn3balXj3gRSu3wCu7RmFuLS41Toijz6B121tSZ8Vv9A+lkIkmqqbD0PH8xASRbI8YVYtYX71Ss/Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7494
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-18_11,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309180199
X-Proofpoint-GUID: 5R7xdpdnCPEO44ZY8QGEPxpw2FGnSMps
X-Proofpoint-ORIG-GUID: 5R7xdpdnCPEO44ZY8QGEPxpw2FGnSMps
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that batching of hugetlb vmemmap optimization processing is possible,
batch the freeing of vmemmap pages.  When freeing vmemmap pages for a
hugetlb page, we add them to a list that is freed after the entire batch
has been processed.

This enhances the ability to return contiguous ranges of memory to the
low level allocators.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb_vmemmap.c | 85 ++++++++++++++++++++++++++++++--------------
 1 file changed, 59 insertions(+), 26 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 463a4037ec6e..147ed15bcae4 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -222,6 +222,9 @@ static void free_vmemmap_page_list(struct list_head *list)
 {
 	struct page *page, *next;
 
+	if (list_empty(list))
+		return;
+
 	list_for_each_entry_safe(page, next, list, lru)
 		free_vmemmap_page(page);
 }
@@ -251,7 +254,7 @@ static void vmemmap_remap_pte(pte_t *pte, unsigned long addr,
 	}
 
 	entry = mk_pte(walk->reuse_page, pgprot);
-	list_add_tail(&page->lru, walk->vmemmap_pages);
+	list_add(&page->lru, walk->vmemmap_pages);
 	set_pte_at(&init_mm, addr, pte, entry);
 }
 
@@ -306,18 +309,20 @@ static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
  * @end:	end address of the vmemmap virtual address range that we want to
  *		remap.
  * @reuse:	reuse address.
+ * @vmemmap_pages: list to deposit vmemmap pages to be freed.  It is callers
+ *		responsibility to free pages.
  *
  * Return: %0 on success, negative error code otherwise.
  */
 static int vmemmap_remap_free(unsigned long start, unsigned long end,
-			      unsigned long reuse)
+			      unsigned long reuse,
+			      struct list_head *vmemmap_pages)
 {
 	int ret;
-	LIST_HEAD(vmemmap_pages);
 	struct vmemmap_remap_walk walk = {
 		.remap_pte	= vmemmap_remap_pte,
 		.reuse_addr	= reuse,
-		.vmemmap_pages	= &vmemmap_pages,
+		.vmemmap_pages	= vmemmap_pages,
 	};
 	int nid = page_to_nid((struct page *)reuse);
 	gfp_t gfp_mask = GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
@@ -334,7 +339,7 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
 	if (walk.reuse_page) {
 		copy_page(page_to_virt(walk.reuse_page),
 			  (void *)walk.reuse_addr);
-		list_add(&walk.reuse_page->lru, &vmemmap_pages);
+		list_add(&walk.reuse_page->lru, vmemmap_pages);
 	}
 
 	/*
@@ -365,15 +370,13 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
 		walk = (struct vmemmap_remap_walk) {
 			.remap_pte	= vmemmap_restore_pte,
 			.reuse_addr	= reuse,
-			.vmemmap_pages	= &vmemmap_pages,
+			.vmemmap_pages	= vmemmap_pages,
 		};
 
 		vmemmap_remap_range(reuse, end, &walk);
 	}
 	mmap_read_unlock(&init_mm);
 
-	free_vmemmap_page_list(&vmemmap_pages);
-
 	return ret;
 }
 
@@ -389,7 +392,7 @@ static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
 		page = alloc_pages_node(nid, gfp_mask, 0);
 		if (!page)
 			goto out;
-		list_add_tail(&page->lru, list);
+		list_add(&page->lru, list);
 	}
 
 	return 0;
@@ -576,24 +579,17 @@ static bool vmemmap_should_optimize(const struct hstate *h, const struct page *h
 	return true;
 }
 
-/**
- * hugetlb_vmemmap_optimize - optimize @head page's vmemmap pages.
- * @h:		struct hstate.
- * @head:	the head page whose vmemmap pages will be optimized.
- *
- * This function only tries to optimize @head's vmemmap pages and does not
- * guarantee that the optimization will succeed after it returns. The caller
- * can use HPageVmemmapOptimized(@head) to detect if @head's vmemmap pages
- * have been optimized.
- */
-void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
+static int __hugetlb_vmemmap_optimize(const struct hstate *h,
+					struct page *head,
+					struct list_head *vmemmap_pages)
 {
+	int ret = 0;
 	unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
 	unsigned long vmemmap_reuse;
 
 	VM_WARN_ON_ONCE(!PageHuge(head));
 	if (!vmemmap_should_optimize(h, head))
-		return;
+		return ret;
 
 	static_branch_inc(&hugetlb_optimize_vmemmap_key);
 
@@ -603,21 +599,58 @@ void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
 
 	/*
 	 * Remap the vmemmap virtual address range [@vmemmap_start, @vmemmap_end)
-	 * to the page which @vmemmap_reuse is mapped to, then free the pages
-	 * which the range [@vmemmap_start, @vmemmap_end] is mapped to.
+	 * to the page which @vmemmap_reuse is mapped to.  Add pages previously
+	 * mapping the range to vmemmap_pages list so that they can be freed by
+	 * the caller.
 	 */
-	if (vmemmap_remap_free(vmemmap_start, vmemmap_end, vmemmap_reuse))
+	ret = vmemmap_remap_free(vmemmap_start, vmemmap_end, vmemmap_reuse, vmemmap_pages);
+	if (ret)
 		static_branch_dec(&hugetlb_optimize_vmemmap_key);
 	else
 		SetHPageVmemmapOptimized(head);
+
+	return ret;
+}
+
+/**
+ * hugetlb_vmemmap_optimize - optimize @head page's vmemmap pages.
+ * @h:		struct hstate.
+ * @head:	the head page whose vmemmap pages will be optimized.
+ *
+ * This function only tries to optimize @head's vmemmap pages and does not
+ * guarantee that the optimization will succeed after it returns. The caller
+ * can use HPageVmemmapOptimized(@head) to detect if @head's vmemmap pages
+ * have been optimized.
+ */
+void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
+{
+	LIST_HEAD(vmemmap_pages);
+
+	__hugetlb_vmemmap_optimize(h, head, &vmemmap_pages);
+	free_vmemmap_page_list(&vmemmap_pages);
 }
 
 void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list)
 {
 	struct folio *folio;
+	LIST_HEAD(vmemmap_pages);
 
-	list_for_each_entry(folio, folio_list, lru)
-		hugetlb_vmemmap_optimize(h, &folio->page);
+	list_for_each_entry(folio, folio_list, lru) {
+		int ret = __hugetlb_vmemmap_optimize(h, &folio->page,
+								&vmemmap_pages);
+
+		/*
+		 * Pages to be freed may have been accumulated.  If we
+		 * encounter an ENOMEM,  free what we have and try again.
+		 */
+		if (ret == -ENOMEM && !list_empty(&vmemmap_pages)) {
+			free_vmemmap_page_list(&vmemmap_pages);
+			INIT_LIST_HEAD(&vmemmap_pages);
+			__hugetlb_vmemmap_optimize(h, &folio->page, &vmemmap_pages);
+		}
+	}
+
+	free_vmemmap_page_list(&vmemmap_pages);
 }
 
 static struct ctl_table hugetlb_vmemmap_sysctls[] = {
-- 
2.41.0

