Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8FB2797C39
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236631AbjIGSst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235414AbjIGSsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:48:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFC5B9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 11:48:43 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 387Ij7mf019253;
        Thu, 7 Sep 2023 18:48:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=Kodk8e5SWNEJQI6RvGETHz/HQOIDcjg35gwo8qfLxWM=;
 b=qhmQjXXBdmzaMqDhct0a3wqGtdv6x8CE/T+MRDFl3p0BhCNmKx8M4fOD68nUy9hUub2k
 516l3MRwTVtQ3P66VQdLK0Belt9f2DN8M1Y8PEjvixYQtCNmgDj0Q2OOAiXcN9fu6jDf
 BJI7/eBGZdQnv/w1y+QS/rLuD1l4+GrDPkNAxQ4QFZ87L7zjwGUrg8GAhCs3BNtopDrt
 a0diYYVrWKOeejNhYOJJ/cAzW3VHSKhKIXTKb80RmlrBoYfiDfFtVYr5BIymadYBys2x
 oDg8INNFt4FAX1Y/Xzckr6tsJ163/Oo6F2AU4vn/c5ArpIFCpiDzD2U4M5xp8NHCrNJf Hw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sym2gg05c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Sep 2023 18:48:08 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 387HDE63005107;
        Thu, 7 Sep 2023 18:48:07 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2046.outbound.protection.outlook.com [104.47.51.46])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3suug83uy2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Sep 2023 18:48:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nlBNwsN0q9ZmzkFMaSPYxz3GOsMY9pQseGJunyHqINW28DtPEUKM2NgEDW0chQdsZ/Aa92keGmOZXEFolfi3MAdGvfHimneSwQfRHQmtYI11dKw4GwCnL0wjm7hIjmkq5T0tg2RXvWrOnTj4C6u81UoQJUeoIMWAVFajmwOv6G7HeTr90TMwFCisdsAgge7c4JGxiISaP7k89oS92ZZtiIRlOX2z5LO/+1iTuvADYwwOpCS9BL75FD1nDIoOtriVDFebb0cKZotmdp5Oyusg3kSrhnGb/lWCL2CYTPC7uA4MOSlc38YT6VM3pztEpL+4jCNRh/WBbfUtwEzo7E3dkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kodk8e5SWNEJQI6RvGETHz/HQOIDcjg35gwo8qfLxWM=;
 b=Mt9kX8teaWRoTWlh08PzVFRWq7YDiIe1URVDcnJpAKA2m2I7IFds3d/M42ebd+E7ffQkzZ3qdQJNDC9PQmOwKawMPRiXziPVkgHpBQGFC6UBiPhrDnFoNTbb+iULWuPbp8eAnY8dj3IMQbMWqyAnFeP6f4UxuntAupXY9fC5Ir/fWYxfkEOp3E+QZXVQZbc8P6y4LCx0eqsUSrAcA4xTNck+o3gWS+7GlCod6iX/IT9XNIUwv1r2HcRnxbJU+NKclrR9qPaotTpPYIfBYDYiS3Fo4zfaapcvEYbG0IAmHZ+qQXg7Bqxej+CtTnmbLXCOCEGM1cEj5h9Tu4t5WodJfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kodk8e5SWNEJQI6RvGETHz/HQOIDcjg35gwo8qfLxWM=;
 b=LFDp6RgySJZLJ/jnCY1lhxFJqkbD3znabZXuJNqO8Aqm58YkGJx7S324Ojr61sD/omkOpVsIP6xqNKtBQKaveXmbRbMLigGDB0bI/Hxb/wTdWxv3DYZW6P4vBo0l9pd8pgBQQDVwY4evg0RXHE2tpbmFUohdLjDPZ/meDtA0uB8=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM3PR10MB7947.namprd10.prod.outlook.com (2603:10b6:0:40::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 18:48:03 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%4]) with mapi id 15.20.6745.035; Thu, 7 Sep 2023
 18:48:02 +0000
Date:   Thu, 7 Sep 2023 11:47:59 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Muchun Song <muchun.song@linux.dev>
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 08/11] hugetlb: batch freeing of vmemmap pages
Message-ID: <20230907184759.GC3640@monkey>
References: <20230905214412.89152-1-mike.kravetz@oracle.com>
 <20230905214412.89152-9-mike.kravetz@oracle.com>
 <b9b7351b-ddee-64c7-e78a-00df85c56e94@linux.dev>
 <20230906213855.GD3612@monkey>
 <9F499C49-3046-4EF2-8C2A-3458A954B2DE@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9F499C49-3046-4EF2-8C2A-3458A954B2DE@linux.dev>
X-ClientProxiedBy: MWH0EPF00056D04.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:c) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DM3PR10MB7947:EE_
X-MS-Office365-Filtering-Correlation-Id: e0bbceb1-7e00-4d23-4846-08dbafd2f700
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XtP20JtJojYeJJcJx1glE8HlWzpgkh1N9lhb1ZDaTUcaPo2JnuBw5XAsSB2UfwyeWnGUxdq2gaqSef3Ae6Gnv7UtY74vDyGyGvhvI3Yn/KwQ0He0NGILkyLCSCF4JYgmFZrfavqzyvO9TDfcYwV2cdCqw71R9whHO9iPeDkFDoszpDsrd3D2CARrvmgEm2qLCXhDf2KXRljWw/5XduJk4VK9EIWvmsSjio/QCzlu0PMsqIo6NgGZdQjHNBkMIuPGD7lrYUCTCvAC+oYthv27cIT0gZFAh4DLirwuPieU//U+31oNi/a/QQ6JLeTN+mx8fWy3pYVKp80isGcZQi5C78jjoXd48kuJyap9JXSVrav5reN1LgLxpinRlziZLv94VmVe+TTOi2nA8wBHCswrZjubjJqttcNuhffE2brpjeiBx07tue8YQJMp0328v+GGH8NXVZEy9pgp1A066PRCL1pW/1AH2N8/VgOcWaonQypqqj0tnjDlLLRMVhSokjvxFTUhFz45alaXeHnrfQVfBCkA788E22nuOvePMfZBs7MkM+lalT0pC/kpKDxBeqXX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(39860400002)(376002)(366004)(396003)(346002)(451199024)(1800799009)(186009)(316002)(6506007)(6512007)(6666004)(6486002)(9686003)(53546011)(86362001)(33656002)(38100700002)(26005)(2906002)(83380400001)(1076003)(8676002)(4326008)(8936002)(5660300002)(478600001)(66946007)(66476007)(66556008)(41300700001)(6916009)(7416002)(54906003)(33716001)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/IuVHOltxzweDI5bHqce2kPKl6hOpL0+ilSjIrh5a8rlloWHWZKQ29Akbs8N?=
 =?us-ascii?Q?AOToDcu28rDB6SKWFueAIPVx9L3ajXQFRi8BXlfjrKduq4sZSmErRnvbSwgN?=
 =?us-ascii?Q?/TWNBsIVSFayZjSfiKs/7zdpb3N9MRYQ4RdO4mpceiYk+4+243TOTEvKX5IK?=
 =?us-ascii?Q?j4VHVEpENlvRrexPHonBomzePhuLkdc76koqhX3H0bS5EFGzN4QsfhigzAKb?=
 =?us-ascii?Q?elP7WTSB5ILByS468r1RpDCvw1y4kG6xx/xXODrlZRKHIJZDrAkOqDwBDY+w?=
 =?us-ascii?Q?xa76qjtaNtfzOaymh2/gh7ItNqUSV2JHAFLSZ37YHR7bydhc7WDp1QaEtwEV?=
 =?us-ascii?Q?74Tq1I2FlKGWcFWDWvZWBOFpfvs8HQ8ojPIilYPgPT5cCGaGAdt+caUGKVtf?=
 =?us-ascii?Q?d/WMpd6nPfSjYdIHMjeVnEROfcXQUBXXgTQaYbM6MSDCIp+hGE5M23mo8DCY?=
 =?us-ascii?Q?By7Zv8rHKpNA1hrPELulKiWWDk5AuXNxswHt4AU4XB6mqSU1sZWCjNbIuYip?=
 =?us-ascii?Q?LM7WZ5pwDUoKT003/1AdKtMSeGisIxD5zya9itUl4jG5FpVFu7CefeBKJue4?=
 =?us-ascii?Q?azBmzkodj4DgmFICym6l8nCjmv9DTsgyA2VUf3ciJ1FS5K3S4sB80Pj5qq55?=
 =?us-ascii?Q?TipsS7XIGnE7ZUsknil7coF8+yFtOo1xzvnfgO9vY/II8pXA0Ip3cMLxpaiJ?=
 =?us-ascii?Q?Mzdo/eG/qMZTtr4wlF2CHXnxzwX6Fc91wBo0dB56DVOXk/g9N8ZiWyhUekNB?=
 =?us-ascii?Q?vb9+bnfsQbfraxEGhIYnrUCaHfhBph0p3K9c53a/vA+LCuQrnOiuLqaT1ZZd?=
 =?us-ascii?Q?uwB+aGahi7r45LkbtE8uMi6vbD0Ucpa+5bzMnkcXI2CkjzOBYrZisQME1/3p?=
 =?us-ascii?Q?sCx3YA9TjR2DRagL6eRLgw6W3KY/W6JR6vvEXMusds0qD3i7KnxyIsBThcPl?=
 =?us-ascii?Q?B/y1SqWrJDpaeaXtBA6sGMZ9WNLxq5I585ydv0VIxO05HsdcIIHyaue2GW0d?=
 =?us-ascii?Q?Kbsan2RloWgCxzagT28hZl1fUw5ujU3qFgyFutUGp/uiz8bRAPRVRtHAgTav?=
 =?us-ascii?Q?0nB9oSDb5f/Ogh9uYcOkLjpkagysRUnf0UI7JpD14sUuMMC9xHMMl17B1QCx?=
 =?us-ascii?Q?DUwsIwNcgUcc3f0u/ynB9LCy/dCsySx/TVSEEYh4meCBuzmBM0WinEoqw0Qp?=
 =?us-ascii?Q?P5G7u3Cuf7GKO3U7GhCidpqGqC/HaTn1eLSWrhKeNns6Srd0eDHyVDNRXBHJ?=
 =?us-ascii?Q?mO7q62xFNBJX7ogJ281Vr1nbwun2SIB22ZG6tj90bt+r8YlmUhz7QohUlllE?=
 =?us-ascii?Q?KjC/mbjFpi0gTb1KwO6NjjgF0FkP9Lp7nC1dTQkmLa12J3o9maTG0czr6uXq?=
 =?us-ascii?Q?YO6Ab+6wk7wrSrs6KLT9dO1nunRzgNZCC4iddG3fW6I09NnJS9OD0h2W+E8v?=
 =?us-ascii?Q?yhnCQzgcKc4u+XAs3GK8LELd6wnEP4pTSdPaWlcVbdaqKmh9K+QvlV6iFhbL?=
 =?us-ascii?Q?jYr1pCm0kg6JGRqAlaWwa50Gjh3Eev3dLXUpH3+h9xkx6zfGEaUsTy7dFEqh?=
 =?us-ascii?Q?GmlD3u5gLOQf4ATCjsQqGAoLfhzAbbNTWrtW2DqKnVPDDJybNGrjqa6e9ZBv?=
 =?us-ascii?Q?1g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?TiJ0Kbd5E1WpGGy5bXqM/pifji6GNacOoqgNvENWIYMEk6jH8jG4beRxemd7?=
 =?us-ascii?Q?MVLtCyKIhz3BmjCgm/KC8cBFi+wLD4d58rEJ/ZCAefcaMWmebyX5Yg42AQg5?=
 =?us-ascii?Q?9D5O27j0Kahi9qODrp9+ow/SR7lbSQnTAA4RZMfzlxOOC0VUOSwMby3c88TQ?=
 =?us-ascii?Q?ZqznAhSjgCGyht73KFKit/52kxsqePpDh7X12LvCLbAV3vaC979BdBGP8OCD?=
 =?us-ascii?Q?gUXI4PpW3xZ37mph9cHgZamADb5hZjqWNEct6gW4wPybN32k2HglPGM4Jaar?=
 =?us-ascii?Q?yofQAXqpGcmZkhyjABhFl6qHdAqJENC4XwPx0/s+lbgkJEFap3wurK8KS13m?=
 =?us-ascii?Q?jtq7dKVZ3eKbnYrkSM36lixlHjOQycKt9nGS5iBJC4hRfx5am1qiSbd+/Suf?=
 =?us-ascii?Q?51nP4tMCwc+7grc80iUvszwTcKbHYfWQC9JdFUW2wByqeQ5iE/Ivy3eurXaY?=
 =?us-ascii?Q?quOzH3YC+wi4uO5vgFPIErwJeiasmGLQErarziyWLBJkY8Wb8wg+2m+LBjIf?=
 =?us-ascii?Q?hkqUp0AXflUICOtWaVqhrX3r3bvNrt8ozeIOPOPcH7cTT4RmrzYPo/aFi9iQ?=
 =?us-ascii?Q?6qh2FukK7GnLVu7BIuykYZ3kriU3P9ajKHBn2st1bEj8x+v9TMFw/Z/0sAh+?=
 =?us-ascii?Q?UaghZOWLGDTUBgukUfe6RX4zxeQkpfqUesiEamnPJHBwkFpGLxWDY9lsHqhl?=
 =?us-ascii?Q?sKRNF2g3paEMwxYJ2iayCDI/4Uld/cfNFTedcReQEPnKKrcvr4qaF4VUhHcy?=
 =?us-ascii?Q?hEduyTw/X00Iyed8TcUuOQjwuGA8Pg0cYCSWkqneA1hk2Ldl4RGTrHvSUKj0?=
 =?us-ascii?Q?pRHkPus/1Nxudq/hU9Xvv9uXmXQDeQtYgDbyQmCLrNHXqWGRk0hS03e4QK+L?=
 =?us-ascii?Q?nph2i2LlC80iBi4c5uXH4yXOZtFmbIK4QhUxthZdGzMUhmNVb5Vm9zTni5c5?=
 =?us-ascii?Q?iklIPvUi5d4E8CfY9C3gh5cV/6/EhTZ5r4zBlgKnVq0qA3ECwqgg4Re8PyFl?=
 =?us-ascii?Q?j1M3DViyKkPnQ9mVxLbUjHdc4KOKyIdyUJ9bV44p9IcdQ6YaT2mulMHctuZH?=
 =?us-ascii?Q?Z0k3MsHqzfA1bJEG90448Xb9ePhTqA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0bbceb1-7e00-4d23-4846-08dbafd2f700
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 18:48:02.8851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dAyWBpN6/QxJcKKMbgjKlfiTvzBDdbWtTjYSxWsGJNbKkkjWJ+1naGGxsOLRmfT20dVc/fU9YQZ5iUAhRMNFFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7947
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_11,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309070165
X-Proofpoint-ORIG-GUID: iAb-u4mG7jJtyvbBEzkhaARgTkYmn1Ep
X-Proofpoint-GUID: iAb-u4mG7jJtyvbBEzkhaARgTkYmn1Ep
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/23 14:19, Muchun Song wrote:
> 
> 
> > On Sep 7, 2023, at 05:38, Mike Kravetz <mike.kravetz@oracle.com> wrote:
> > 
> > On 09/06/23 15:38, Muchun Song wrote:
> >> 
> >> 
> >> On 2023/9/6 05:44, Mike Kravetz wrote:
> >>> Now that batching of hugetlb vmemmap optimization processing is possible,
> >>> batch the freeing of vmemmap pages.  When freeing vmemmap pages for a
> >>> hugetlb page, we add them to a list that is freed after the entire batch
> >>> has been processed.
> >>> 
> >>> This enhances the ability to return contiguous ranges of memory to the
> >>> low level allocators.
> >>> 
> >>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> >>> ---
> >>>  mm/hugetlb_vmemmap.c | 60 ++++++++++++++++++++++++++++----------------
> >>>  1 file changed, 38 insertions(+), 22 deletions(-)
> >>> 
> >>> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> >>> index 79de984919ef..a715712df831 100644
> >>> --- a/mm/hugetlb_vmemmap.c
> >>> +++ b/mm/hugetlb_vmemmap.c
> >>> @@ -306,18 +306,21 @@ static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
> >>>   * @end: end address of the vmemmap virtual address range that we want to
> >>>   * remap.
> >>>   * @reuse: reuse address.
> >>> + * @vmemmap_pages: list to deposit vmemmap pages to be freed.  It is callers
> >>> + * responsibility to free pages.
> >>>   *
> >>>   * Return: %0 on success, negative error code otherwise.
> >>>   */
> >>>  static int vmemmap_remap_free(unsigned long start, unsigned long end,
> >>> -       unsigned long reuse)
> >>> +       unsigned long reuse,
> >>> +       struct list_head *vmemmap_pages)
> >>>  {
> >>>   int ret;
> >>> - LIST_HEAD(vmemmap_pages);
> >>> + LIST_HEAD(freed_pages);
> >> 
> >> IIUC, we could reuse the parameter of @vmemmap_pages directly instead of
> >> a temporary variable, could it be dropped?
> >> 
> > 
> > I was concerned about the error case where we call vmemmap_remap_range a
> > second time.  In the first call to vmemmap_remap_range with vmemmap_remap_pte,
> > vmemmap pages to be freed are added to the end of the list (list_add_tail).
> > In the call to vmemmap_remap_range after error with vmemmap_restore_pte,
> > pages are taken off the head of the list (list_first_entry).  So, it seems
> > that it would be possible to use a different set of pages in the restore
> 
> Yes.
> 
> > operation.  This would be an issue if pages had different characteristics such
> > as being on different nodes.  Is that a real concern?
> 
> A good point. Now I see your concern, it is better to keep the same node
> as before when error occurs.
> 
> > 
> > I suppose we could change vmemmap_remap_pte to add pages to the head of
> > the list?  I do not recall the reasoning behind adding to tail.
> 
> I think we could do this, the code will be a little simple. Actually, there
> is no reason behind adding to tail (BTW, the first commit is introduced by
> me, no secret here :-)).

Ok, I will change the way pages are added and removed from the list so
that in case of error we get the same pages.  Then I can remove the
local list.
-- 
Mike Kravetz
