Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE8B7CEE18
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 04:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbjJSCc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 22:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbjJSCcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 22:32:18 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E6911D
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 19:32:15 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IIp6nE018131;
        Thu, 19 Oct 2023 02:31:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=F7HOzsss5pD7Ha2I86cR52DxAyPm8ftvPm1KZ647UUc=;
 b=0rn0oKPZCd5LEFplhcFa+6zdjZCWGJtGUrUpAw+jP30KfjkM8l30lLfdXNihZ5fwVHj7
 lDZ9NzpICfZff8Z76dt3UQq89B9VMRcsYTmVPi4yXbc2eSXdZER2SlUVT7dNok289Bb3
 0KOqmBPQWOB9SEat8YAN6iqiIJoCDUj3yDMPIlu5RduCdwrDY1LH2dpRvWKGM8jdZvqN
 NSn46lrHuRiqHygHWXe8EW2p2AkmnGfaPOjRvOvc3agdmxNBiJlPTdEGqSqBFMuCTysX
 m38eEp4cvLhjDGz2Wd3YBUIgz8MDjhzOaYGHGvnDwWKLACXjjcfysHVVadTiaXGUAgGJ bg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqkhu993a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 02:31:33 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39J0lDbK009825;
        Thu, 19 Oct 2023 02:31:31 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3trg0q30gr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 02:31:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dhtCihzeYcANU4Objz1xO03a1QTczQpsTqX1XfEvYEj18uDXAp/9lPPjkDtu7hqMrUmK3lbdOqyqZiVQiVSopeQMOLlb98Q3qNqf5U8ThXq3QiJujlytmz7sKAkcieDR8s/UD9ostJedkiqaqHZheaXrfKqqsALy7wboD0SxB/MRoRAm04JWQhitydcTZZjGScYEgTJsPs+VLsmBQ1Rg8mVZk5JKQRjo1EtO6eRZm+kAPJOYZroi3+q/2ZA9Tl6Ludir7w+LyKWtZwR6WncZiKv86pX91yLuZZdRdE/tBMen201Vw8XD2lGDpUziXsW7hOdwReD/SOY3tWlnsEDj+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7HOzsss5pD7Ha2I86cR52DxAyPm8ftvPm1KZ647UUc=;
 b=XGIfBjqxOq59H5myVxxT8kSqsenHU9WaydgVDnte9XMcvZjWfWDlUEKUg7Z8rxvVKOHwxBYZ9GWGHziJcdP862bojI1EkbbDtfhBpyFXZiQKzEsrFigssSWWWNt796xNSniWPLBbQIb1gE5NFEZjlRD3CGbCpQ8uMAQ628vOIv82q11hUE9h1TzEoU/Tgz+w+chDZIL0dgeKVLFLNWSsx07eC7vKeaHc2VAQ0w+Kn86YDhnW+IDb7VNQa+LYpeSqTJCMjQWQ98cJ2ckLRgWnJC9G1biJQwpGmNkM22kI/99qa3Ozan1fvvCxcEuHBVXQfjDRv4iX4cN2zRxE8RF3Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7HOzsss5pD7Ha2I86cR52DxAyPm8ftvPm1KZ647UUc=;
 b=y7X0EuUqT/0Jr2U4J/TR2wdC5/zgHRN9nA/Kmli1jCtM9cXxrzC/3MY0PnrldTpbah0ru1Jw/GeRBMWn/C/gABm4hf2Nf6SFnzBt3ZYsGi/3nhqOiORq0kQu8+XoPoy4mhfibnUO1q+kAyqNvd8GKYrNu2ZXaVIZNbL3k4KX4YY=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY8PR10MB7123.namprd10.prod.outlook.com (2603:10b6:930:74::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Thu, 19 Oct
 2023 02:31:29 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2%6]) with mapi id 15.20.6863.032; Thu, 19 Oct 2023
 02:31:29 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <21cnbao@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Usama Arif <usama.arif@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v8 4/8] hugetlb: perform vmemmap restoration on a list of pages
Date:   Wed, 18 Oct 2023 19:31:06 -0700
Message-ID: <20231019023113.345257-5-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019023113.345257-1-mike.kravetz@oracle.com>
References: <20231019023113.345257-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0188.namprd04.prod.outlook.com
 (2603:10b6:303:86::13) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CY8PR10MB7123:EE_
X-MS-Office365-Filtering-Correlation-Id: ff2fed62-3252-440e-8b11-08dbd04b7ffe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wJDSH4W6/HwrGXXwlO43hqe2b0Q34iQctJ9S7FmovMQD1JTTzPE/mKSWCqSKLVMNmI2SKWVcox5BQVzwRoSSU8qsDwLzYKG8/s5Hk/sEsHH2Fofe/KrILtMzKLD6n9Kpwvi118QE/6ZL6VBReWAE4Jx+5LwozECwkwSA6vqeeRS4Hq9PNmnymF+atlNSlsmjqeRdwGzg7snlVTwv1e9D01A9mH7ujo+6N/1eKB/XPfX2QyzVx6QQjOfAIgQWksF/v3tlgAnF4yncjmvFESFiVZZm6VC+00hrFKKJHKrxVvK86vrJdLZAkl8hChNRAdoldGks6fFc/ViIo/IX9A6UjWL1VomjikTzoip6Zxky+oYyLQep3O5SVMkxvRDCAc6m/Nlf52jOfdRwDVmzAP+wQId9kgq0Dg4sCnZCvNTtVdnJUBOinO1XhBR4rjANvg6L9rWy7zVrsJUfbtP8JgBIXP/kSRl4q1TrnzDTNcTbG+FMKj/pmOeCNgEaDdbegko1oVnB+a6w/omWxBcFNXPO1TjZw4x+BGJM8rMVwjqpRQSiB1EtiC5S+yVdHIvtQjd/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(396003)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(478600001)(54906003)(316002)(66946007)(66476007)(6486002)(66556008)(6666004)(1076003)(86362001)(2616005)(26005)(6506007)(36756003)(107886003)(6512007)(8936002)(2906002)(4326008)(8676002)(7416002)(44832011)(41300700001)(83380400001)(5660300002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VlgxpEHMsI7AZl69NOXbqzxL/IBUyjl/zvY3A6jOpAsaHlaQ+jI5M2oxJkcu?=
 =?us-ascii?Q?gdpi5OgBItI16aUdEbCk6LQYLMGW3LllKOhrkuI0mfxPzHP2kAwP2EfB3usb?=
 =?us-ascii?Q?aT2M/4NZyJr2R+4iWW3CzneKNKWbgU0ZGC5AJ4dy8/qne3eu24dwUcUVnm5K?=
 =?us-ascii?Q?bkC09DlJU1zLjhCxmRloMCIY+r+DT6OGNRCXluWdaS0wOdFKl4TvmmqNbAjp?=
 =?us-ascii?Q?TCPD+TOjqvohFJ4aRI3IFBzpVdavLH12W0+21AupjCsDbE+bRgphm4QWQoOU?=
 =?us-ascii?Q?xUKrQNjZe/gd58anWI9JPTK84atLTZjuOnppdAJFQNzGA4JDMI2tm3GuE1MA?=
 =?us-ascii?Q?IbGcfi7mVTaapA13evYklH3ACH4FW25tNYscGgf8VegGHOG4yO+ENRfINj/H?=
 =?us-ascii?Q?K9L7chEzjjiUMXIyu1uIR6Kh43Dg2sSuqOKXyupcd7L5cUZAcyigY7booy88?=
 =?us-ascii?Q?/DjV1WKXGTcX6teTZXh/Xt1Ozvhdve9iyoLqmgBhjZhAJ8UFnf17nK+gqcic?=
 =?us-ascii?Q?4kU+FcqTrW+f7x+VcflgvVUJK6K93iDkH7Y1vmXp5v5XesVoKkuJv0hnlLDP?=
 =?us-ascii?Q?4F1E/m5WxEd4hEqW0FB02yZtM4rFOgcSY3yRloTXTg5jiLgFhYHWfwyzodaq?=
 =?us-ascii?Q?mhiSqSYtZ4kR+yQ5HoTBWboZAFItDgnowM8hM+PQd3qRGyUjo9PD320J7x+6?=
 =?us-ascii?Q?xhs0mLS/SX9wKHm5cplQWbamD+uMV/zBqZV8eTxtETZcycMbowGO0jCQaJOH?=
 =?us-ascii?Q?niTuOoS4NgV6Es3gUsGikk3Qce9D9xIPSggbEBVWq4dDuDsblsfauuJii+x9?=
 =?us-ascii?Q?WXeEfH0qXcl3CnV7TGKNqHX0c7CyRmfOWtD0cSOaMaXdb5QrJZLU3jypP8Wf?=
 =?us-ascii?Q?OA+80ls7e6S7wCyqDiaNxNyF1prT04nRhq9z2yBR7wdCZ4etvMQfbPhnD2Ip?=
 =?us-ascii?Q?ojtpXoMR/4ckS6/56qwdz9I4eDFPqLUq3VNDPEpUw5ZFPFY3uDYp3BZ09Otc?=
 =?us-ascii?Q?oijaGfJQK7q0qk3bWRMVndj3Uh1TLeMP7Biw14F77BS0t4qDnNzRVvdd6vkP?=
 =?us-ascii?Q?W/LZxusBeJ/4CBLNikeWra/fIsvAtIc65yjlrFsARtiW5zcvf0BZTJbC3sLz?=
 =?us-ascii?Q?XLLJieg3Y3dsIIp7sA/d2fkr7ZQ+atEgGP11zKRVgmQrVCTFHIcsrWfWr0w5?=
 =?us-ascii?Q?ofg0rbGa9pOxUt/x4HAM5y8yG4SS5eL9LFThTraHUdyANAYknX09uAZ03o3T?=
 =?us-ascii?Q?LyMDEYwrshSofookSDrES83OMJOhOQ1I9vb9UdjkIQh9pUyfLQn15QvGCxE9?=
 =?us-ascii?Q?66Z+Q7bIyGuarRi2xmVkeyNiuGniloazahab7ZXLF19US33zNorqWgbomeis?=
 =?us-ascii?Q?aRimy5QxvyLePrXATf7EQ9wD9nxdeNDE4GEmdCYLuYr5w57TRcfMYZhsIYv7?=
 =?us-ascii?Q?3YyDKTcqjC6R8sqfwiv9x/SsidZ3VVJUWd5Y/PEtCX9tXhtZMizTA30O9+Jz?=
 =?us-ascii?Q?XanDor9ZROr6Ny/j21MXog1NMFU8+vqrLgeqHxs5cbj0hBSvaPM/hJ7pSg3g?=
 =?us-ascii?Q?3h+/jrtVzNSPvq/yM2UZwcThQwxR1+s3r3eFZzZnzO7xMb/xzQ+8hjnNhq+K?=
 =?us-ascii?Q?gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?yAvtgVevPX6cv2jRFB/LDiomVPD3Mmk6t3JiUqepD74rAj+5eXQ8Mtkmm+4x?=
 =?us-ascii?Q?v5YWcyVJaB/RfuwXHdJ35o158ZXPGyBv5+I2hDDif/niBbVkpmYRAdCpZ7dp?=
 =?us-ascii?Q?XQH8otM5kFlhfi5fRDBNZrpgg7vtpxsksTU20dL6CKaD3+FoaR8vIQxJPOBb?=
 =?us-ascii?Q?Vs5TjmQBe43EfbXppordvMi7HcBfVNtqrnqggIJeoz89bW8aTadpGiezTXi/?=
 =?us-ascii?Q?vrzN6qpPyjQJibaKs+OjBY4FofI+HMWCDW/WKxNqIvJoxv9LX1Zs1olVefwE?=
 =?us-ascii?Q?Fd2LxKZyiirhC8itFlG2CfuaTsG1CE38SR0l4PgsKx7rAG94+uDibliKnsCL?=
 =?us-ascii?Q?l553bdXXTxXKcDCBCIew6uo6/rgiFy3aFjDj7CVLdHRxd4+63+ctPPz/XH74?=
 =?us-ascii?Q?J9t5+oCLb6pu4tft1waYT1G4JoBEkpS9GQvVrgX4F5fMvvLdEW8P27pjJyQ1?=
 =?us-ascii?Q?ZgKk7SNcmJiErELrEaKMRA2zvmLTkmMmdXFoijtHRhgCDeQKqxCRTDsFg4p9?=
 =?us-ascii?Q?2yUT/KSQ1FWyopb96K3SsN6JzyuUSUcGA6c+a0F7WyREf8P6Q85eZ9SuOeZr?=
 =?us-ascii?Q?M+29b0UBRcLckQImPyOk9qbBgLv1VDRlEYqTf6hAzl5R0ynN9ISW8wtTGagO?=
 =?us-ascii?Q?/Zxcu9zBr8xme9fQylzonw5KtqjUedaMSAlSc9yVDPyNkklRpN/vuouTQ92K?=
 =?us-ascii?Q?QG4N1GrViL/rHQRr3kW0ydvbJ7Tz/QTi21UXiLbmKlvEglmocIDNmdb9XJoL?=
 =?us-ascii?Q?z/aVcVBi3MfAf/D3HFhAAIzBeKvzQuYkU0yugXRmXclVDgyFCEt529RIHPlU?=
 =?us-ascii?Q?1HoRsrJGl7zniL1CEvMSAr0GRmIkMellMQ6GDwc9YCPKkBLS20Wa4Fbe2SzV?=
 =?us-ascii?Q?t5TYHDOfuIfck02Pi1iUTncVHyYPnbhVzK8ELrI4X1AD/UlaQ39lCtdJgwYv?=
 =?us-ascii?Q?31isdT2a0OmV4aehYdU3I9DtTsAqs/ecfDjRS7a4WC3lfSd/2z2oECtNXqY9?=
 =?us-ascii?Q?CMh3GdZ/JAGHqV2t4hdScxvtD1+l6PECXGiUeOQSlEp1ckeLBWe7sffLqw/U?=
 =?us-ascii?Q?v+j+JkgOYJm6kKD0F26voEQ38CU4QSQ+h2kPElgp+TXd+T8FPwaEPGt1H9IL?=
 =?us-ascii?Q?NdTLBMyTjde1sL2QHK7YAGGzy5RUbZrBXDeBMd+1wW11zKGhLfkP2pPDbYLI?=
 =?us-ascii?Q?zCZx0BGi7yQ/zH/y?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff2fed62-3252-440e-8b11-08dbd04b7ffe
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 02:31:29.2612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nmab/6qFqW3Wh+Bc2tpQw28muoJCUzd2aPOULvOT0uY1mhWj170DEqyftMuZCfHOV8i7J5xxS85BXLRjvV9P0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7123
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_02,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310190019
X-Proofpoint-GUID: Sn2pgpwYgNkYxnsJNThS7AaSogg-IlYB
X-Proofpoint-ORIG-GUID: Sn2pgpwYgNkYxnsJNThS7AaSogg-IlYB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The routine update_and_free_pages_bulk already performs vmemmap
restoration on the list of hugetlb pages in a separate step.  In
preparation for more functionality to be added in this step, create a
new routine hugetlb_vmemmap_restore_folios() that will restore
vmemmap for a list of folios.

This new routine must provide sufficient feedback about errors and
actual restoration performed so that update_and_free_pages_bulk can
perform optimally.

Special care must be taken when encountering an error from
hugetlb_vmemmap_restore_folios.  We want to continue making as much
forward progress as possible.  A new routine bulk_vmemmap_restore_error
handles this specific situation.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c         | 99 +++++++++++++++++++++++++++++++-------------
 mm/hugetlb_vmemmap.c | 38 +++++++++++++++++
 mm/hugetlb_vmemmap.h | 11 +++++
 3 files changed, 120 insertions(+), 28 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8b171f866d0a..cf834bb7f820 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1859,50 +1859,93 @@ static void update_and_free_hugetlb_folio(struct hstate *h, struct folio *folio,
 		schedule_work(&free_hpage_work);
 }
 
-static void update_and_free_pages_bulk(struct hstate *h, struct list_head *list)
+static void bulk_vmemmap_restore_error(struct hstate *h,
+					struct list_head *folio_list,
+					struct list_head *non_hvo_folios)
 {
 	struct folio *folio, *t_folio;
-	bool clear_dtor = false;
 
-	/*
-	 * First allocate required vmemmmap (if necessary) for all folios on
-	 * list.  If vmemmap can not be allocated, we can not free folio to
-	 * lower level allocator, so add back as hugetlb surplus page.
-	 * add_hugetlb_folio() removes the page from THIS list.
-	 * Use clear_dtor to note if vmemmap was successfully allocated for
-	 * ANY page on the list.
-	 */
-	list_for_each_entry_safe(folio, t_folio, list, lru) {
-		if (folio_test_hugetlb_vmemmap_optimized(folio)) {
+	if (!list_empty(non_hvo_folios)) {
+		/*
+		 * Free any restored hugetlb pages so that restore of the
+		 * entire list can be retried.
+		 * The idea is that in the common case of ENOMEM errors freeing
+		 * hugetlb pages with vmemmap we will free up memory so that we
+		 * can allocate vmemmap for more hugetlb pages.
+		 */
+		list_for_each_entry_safe(folio, t_folio, non_hvo_folios, lru) {
+			list_del(&folio->lru);
+			spin_lock_irq(&hugetlb_lock);
+			__clear_hugetlb_destructor(h, folio);
+			spin_unlock_irq(&hugetlb_lock);
+			update_and_free_hugetlb_folio(h, folio, false);
+			cond_resched();
+		}
+	} else {
+		/*
+		 * In the case where there are no folios which can be
+		 * immediately freed, we loop through the list trying to restore
+		 * vmemmap individually in the hope that someone elsewhere may
+		 * have done something to cause success (such as freeing some
+		 * memory).  If unable to restore a hugetlb page, the hugetlb
+		 * page is made a surplus page and removed from the list.
+		 * If are able to restore vmemmap and free one hugetlb page, we
+		 * quit processing the list to retry the bulk operation.
+		 */
+		list_for_each_entry_safe(folio, t_folio, folio_list, lru)
 			if (hugetlb_vmemmap_restore(h, &folio->page)) {
+				list_del(&folio->lru);
 				spin_lock_irq(&hugetlb_lock);
 				add_hugetlb_folio(h, folio, true);
 				spin_unlock_irq(&hugetlb_lock);
-			} else
-				clear_dtor = true;
-		}
+			} else {
+				list_del(&folio->lru);
+				spin_lock_irq(&hugetlb_lock);
+				__clear_hugetlb_destructor(h, folio);
+				spin_unlock_irq(&hugetlb_lock);
+				update_and_free_hugetlb_folio(h, folio, false);
+				cond_resched();
+				break;
+			}
 	}
+}
+
+static void update_and_free_pages_bulk(struct hstate *h,
+						struct list_head *folio_list)
+{
+	long ret;
+	struct folio *folio, *t_folio;
+	LIST_HEAD(non_hvo_folios);
 
 	/*
-	 * If vmemmmap allocation was performed on any folio above, take lock
-	 * to clear destructor of all folios on list.  This avoids the need to
-	 * lock/unlock for each individual folio.
-	 * The assumption is vmemmap allocation was performed on all or none
-	 * of the folios on the list.  This is true expect in VERY rare cases.
+	 * First allocate required vmemmmap (if necessary) for all folios.
+	 * Carefully handle errors and free up any available hugetlb pages
+	 * in an effort to make forward progress.
 	 */
-	if (clear_dtor) {
+retry:
+	ret = hugetlb_vmemmap_restore_folios(h, folio_list, &non_hvo_folios);
+	if (ret < 0) {
+		bulk_vmemmap_restore_error(h, folio_list, &non_hvo_folios);
+		goto retry;
+	}
+
+	/*
+	 * At this point, list should be empty, ret should be >= 0 and there
+	 * should only be pages on the non_hvo_folios list.
+	 * Do note that the non_hvo_folios list could be empty.
+	 * Without HVO enabled, ret will be 0 and there is no need to call
+	 * __clear_hugetlb_destructor as this was done previously.
+	 */
+	VM_WARN_ON(!list_empty(folio_list));
+	VM_WARN_ON(ret < 0);
+	if (!list_empty(&non_hvo_folios) && ret) {
 		spin_lock_irq(&hugetlb_lock);
-		list_for_each_entry(folio, list, lru)
+		list_for_each_entry(folio, &non_hvo_folios, lru)
 			__clear_hugetlb_destructor(h, folio);
 		spin_unlock_irq(&hugetlb_lock);
 	}
 
-	/*
-	 * Free folios back to low level allocators.  vmemmap and destructors
-	 * were taken care of above, so update_and_free_hugetlb_folio will
-	 * not need to take hugetlb lock.
-	 */
-	list_for_each_entry_safe(folio, t_folio, list, lru) {
+	list_for_each_entry_safe(folio, t_folio, &non_hvo_folios, lru) {
 		update_and_free_hugetlb_folio(h, folio, false);
 		cond_resched();
 	}
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 4558b814ffab..77f44b81ff01 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -480,6 +480,44 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
 	return ret;
 }
 
+/**
+ * hugetlb_vmemmap_restore_folios - restore vmemmap for every folio on the list.
+ * @h:			hstate.
+ * @folio_list:		list of folios.
+ * @non_hvo_folios:	Output list of folios for which vmemmap exists.
+ *
+ * Return: number of folios for which vmemmap was restored, or an error code
+ *		if an error was encountered restoring vmemmap for a folio.
+ *		Folios that have vmemmap are moved to the non_hvo_folios
+ *		list.  Processing of entries stops when the first error is
+ *		encountered. The folio that experienced the error and all
+ *		non-processed folios will remain on folio_list.
+ */
+long hugetlb_vmemmap_restore_folios(const struct hstate *h,
+					struct list_head *folio_list,
+					struct list_head *non_hvo_folios)
+{
+	struct folio *folio, *t_folio;
+	long restored = 0;
+	long ret = 0;
+
+	list_for_each_entry_safe(folio, t_folio, folio_list, lru) {
+		if (folio_test_hugetlb_vmemmap_optimized(folio)) {
+			ret = hugetlb_vmemmap_restore(h, &folio->page);
+			if (ret)
+				break;
+			restored++;
+		}
+
+		/* Add non-optimized folios to output list */
+		list_move(&folio->lru, non_hvo_folios);
+	}
+
+	if (!ret)
+		ret = restored;
+	return ret;
+}
+
 /* Return true iff a HugeTLB whose vmemmap should and can be optimized. */
 static bool vmemmap_should_optimize(const struct hstate *h, const struct page *head)
 {
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index c512e388dbb4..a0dcf49f46ba 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -19,6 +19,9 @@
 
 #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head);
+long hugetlb_vmemmap_restore_folios(const struct hstate *h,
+					struct list_head *folio_list,
+					struct list_head *non_hvo_folios);
 void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head);
 void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list);
 
@@ -45,6 +48,14 @@ static inline int hugetlb_vmemmap_restore(const struct hstate *h, struct page *h
 	return 0;
 }
 
+static long hugetlb_vmemmap_restore_folios(const struct hstate *h,
+					struct list_head *folio_list,
+					struct list_head *non_hvo_folios)
+{
+	list_splice_init(folio_list, non_hvo_folios);
+	return 0;
+}
+
 static inline void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
 {
 }
-- 
2.41.0

