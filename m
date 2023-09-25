Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36497ACD2D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 02:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjIYAlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 20:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjIYAlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 20:41:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96145193
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 17:41:07 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38OMgE6b008084;
        Mon, 25 Sep 2023 00:40:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=3vbONjsZvravfMZFWf/jFmc0JqQCVqxQwTo9QP2uYlc=;
 b=F+PJBwmzztUsekG8vqtAwbqjm85aQ3HlPAI7UjIA3NEcdfReVKXxQ0MghsOmgYudBHQM
 KBw4MPBGBuFUUc9fVlPrOMTEfnX3Nb/zXaMMZqhMOUNx+1lfTrNQuvrlZPxxj3SB/5e4
 YQIeZGZE2TlOo9Jkikp8StY/vrPyqYQK3y7WXK4SLf16NgHRaZeC0w2/LNsXywX3c12+
 YXTFfia1DInbctJbEkxqP5Q2FZ6eF+5bX21c+ZcdJTnJXMKYWLITzSKKI1Tq/e1S/FIR
 ylof5Wi4BniuJCDZW6e4fkHVXocAmUvV+EWbyLVuuc2l3n2eWRNFqYHHMJ9fUuBBCrtR 7w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pt3jebu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 00:40:32 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38OMdVUJ034972;
        Mon, 25 Sep 2023 00:40:31 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf418cq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 00:40:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B6NbKBBGo9dhIS3jE2z6o3KkaJNh2MaAynLWX+yOGt7uDIR3iCBL+zzXXlNyvADOBAgRZE1sGzlxwlFg5VrWss+il7NsNlKzGD+rT1f3swsqeD7j6CPLOH0SeYhGVJ944QTkT4E/3rNDOAzE5sGXX7ARF8Z3jXXxOIbYUOg9nDb+Lz+U7ozLQIaULg6771p4kacIHWxbFwAaCFBLxW4LnjS+qJXYHtqM6Q23Lbr1Z+agT/4O13mxF9ODiY4I2GVdjzWgmdh8HtByr+qzFX9kccv2DzhzVPliYQ8Co+01tKjt9KDhsMjRyzNGEwrr9954KFHfUIo/VHo53Iio6fkSYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vbONjsZvravfMZFWf/jFmc0JqQCVqxQwTo9QP2uYlc=;
 b=EY6rrnmLxNuwEYdk0CnZ4iUN6HJHaTuh9fmGgu5HtZYUrVMBa5/MNDUqJuW0h/a/86NuioVXCE7JdK629jffrWXnQnpGbKJPOFCxCzLRmdgeIA3RsKmu3tp3c6AWIprHcqZOFLER+E/gj1CIVegxW3l8MeoMVoTyO/b2MYAHIQ2ZUc7ASOh0VxX+0rPyXA/zzjZI94q25XGP4SIabkbgHzZZW2sxAlsFot1UWo4qvIuZENtddomrM6raSeJ+BOOzaWHSXTb+izpqp/JuU2txFBEvu5CG1rVas26aV3dHm4hdwgOuQfb2Iqo3LUXwz1R5VrfJ+2WVdyVa/YVVRU76oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vbONjsZvravfMZFWf/jFmc0JqQCVqxQwTo9QP2uYlc=;
 b=QLUXRsi2Gidkbk3HfEX8CN+VowLG44K8d1ep5PiOKfLXcDB/3Ah8AL6Pew9f0pSJVdv/MBqsMxt8DOboVdYRj6GfYjD2y7slGX3zN4fVRQ00wvdjBN7kYA9YEpuhVK/pOe06wvusGE7VqyPnGNEOKKQhgovnPwIF/CBDCBNi9Fo=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS0PR10MB7174.namprd10.prod.outlook.com (2603:10b6:8:df::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 00:40:28 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 00:40:28 +0000
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
Subject: [PATCH v5 6/8] hugetlb: batch PMD split for bulk vmemmap dedup
Date:   Sun, 24 Sep 2023 17:39:50 -0700
Message-ID: <20230925003953.142620-7-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230925003953.142620-1-mike.kravetz@oracle.com>
References: <20230925003953.142620-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0110.namprd03.prod.outlook.com
 (2603:10b6:303:b7::25) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DS0PR10MB7174:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e3a11d5-1b6e-4528-78bc-08dbbd6003fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i0ZvPbpF+eV7d+B2C5oyF32Dp18bMHsRqy7H6QVpYQnr3VkX1YtrBY8IIeSZz/24TDXMhNgRCYuYwQe2lIBZCdA/vB8mYMmfjBdPRfEEiQEi7MYIWWRoxWx7FltePbQ40oBeupqUp1TPnN+zeoDWEzA+GnqXZCsjg9gtFL8/1dAeEfqP6USNTKW/TSYF/AOPOH5X57HKVmE5u/qf1fjKUXHP49KPexW0Z43Nx0xNYdrBRQN2zSVb+weIxBYhIx1HMhwBvyEfY2OjAvhm7qJAdNxAOvJ5QBOveHxEK5F86TiKfkIH8+L5Q0DKqawtF6ioURi0x4EQWE0rVC6X7em6dzOh4JHXMigQNCfmiMNraLUBiJ4FrWEsK6+BLBI/yS1ISytHo2IGQOuvW7JzuRGFNN1yIZD+cAHqKDztZZjMDLEgXsJd1lvqBIuU2Zgf76pmACWVUwcaXz5jdT14qrle1Xzj6JJuBPUZIqv4haPAN+C8DR6YwjSD2HEzaFm/HbDbGRzVG2NhwuqfVMUdORzhybmlkw64QNhpsTz0UMGzf3qYREqZzFubObROeePUnevc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(366004)(396003)(136003)(230922051799003)(186009)(1800799009)(451199024)(6666004)(478600001)(6486002)(107886003)(2616005)(1076003)(26005)(83380400001)(36756003)(86362001)(38100700002)(5660300002)(6506007)(6512007)(66556008)(66476007)(54906003)(66946007)(316002)(7416002)(2906002)(44832011)(41300700001)(4326008)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9JT88nIvbWRpTRyc06e0Fwj8iWg7/5ALT9WD36k3MxHe//Kya4IHIxFmVUzP?=
 =?us-ascii?Q?W/pLQ3D7SBqD0Y1t94v+ZRvOvJs/ZHV/4ElXyAApqxfhF+CdHXbVOqFtVAPc?=
 =?us-ascii?Q?+BZwE4lYICa8YJMDRfiYzRmFvb3Z4BcQ55rSj22Mze+gAUPKiQYuM4IWnX4Z?=
 =?us-ascii?Q?Q0tTWdGaBEHq/wSTnX7iyhFfGN4zwxCiwu5VjsIz+5Qc9udJCgU5wYg1T/ih?=
 =?us-ascii?Q?VSY+MKtI//4oyZYfKXPPO/JwqlQe0Dj5H2GDZT1vv0xREbyRX7aiNtFOJRKj?=
 =?us-ascii?Q?Qb+SmP5Fu1naS92nfubgKo2xTBsQjvnKHmoAWAS/6srX91P+gm3FqBwR7liY?=
 =?us-ascii?Q?EhBPRzk1NPcZx0jRV8bnGHwskWBiuXWnAyju2sxRu4B497IQikgyRAaeUcLO?=
 =?us-ascii?Q?LsTzE3DhUYrZTrmhY76cRAtL7dvuXPhPkH2Ctc2xzlwLi0YQ0xh8TB4Fn/PY?=
 =?us-ascii?Q?WK13ZzStiCZ3vIoC27BfRN/udsJoBobiNLuXXXrzSaDvNFWmw1vFY3FCEzrs?=
 =?us-ascii?Q?i+FjF0tqIuw5SgVMZqpW2jjl0NTzAfCUHcAHOe4sE/WurAnznYMhZdunWzAj?=
 =?us-ascii?Q?t78TRRw5micTYOokv3EmiVSpdkDT3EN6yDICe93GRNmAgF4NJb8nE2oH5MFf?=
 =?us-ascii?Q?5YzQzOTvPA3fw89NMgyNAM5djFoNX7lTFP3B4wWejIkE/tmv1c6N05xexSNM?=
 =?us-ascii?Q?wVKB2rA7AZzU1BNIWiNa5YWrws/OWtumBVwWOUS/DYbea6038SJ8S8I3KZeg?=
 =?us-ascii?Q?MecF/tz3qKokWOOnCSfcWy00eL+bFfwzzfcgRiuXX2fsSbn8ePHh19+peN7g?=
 =?us-ascii?Q?8ch+UrJCHuvN6LG8SzVWp5Bqcjq5xr/sndCZ7NiGNu5pq2ElBUmWYQY2h9yS?=
 =?us-ascii?Q?BVJKOUZyWuA6mC1A006em9jIMSfiDzo7eKXhHjw1PJT+5o8rRAPM/A6IVtXh?=
 =?us-ascii?Q?+uhKrZGQukKwFPq3rwzSZ1YSuEJ5k+eubU8tNK7zSaqoHrACMP2cEcxRAtyO?=
 =?us-ascii?Q?vj7uh9ljC9MRXHqKyiYUetiw14NqqBxigJpDCIPoSXMuJgim9knW/lV+l0l3?=
 =?us-ascii?Q?/hC8rJ0OacH3bAzG1WX03xRAdBwLV9tlcg4VidlCICrOzD3SUu+IvSmumkcB?=
 =?us-ascii?Q?LzIMRzKmqsvJEFkJFhGgTWqofSC74uFsVX6VDhCVYZfg8od9LYt9YsryTiMA?=
 =?us-ascii?Q?/Co3O+ZroKad2N7sIHcHUuhR15lU5pqudJsCSXRmm3TmmHIS2btmX/P/Z4mT?=
 =?us-ascii?Q?K12jJFyrmkYLW0tgdlWdCJC7zrZNKWnSMXM4IGMsSBR2GenV3oXF+GNDLEhM?=
 =?us-ascii?Q?7z7RVTC/maZr4sVlS875JzedEO9OUn/Cn+aFjudMxdXlH+nMZDwow62zM3vI?=
 =?us-ascii?Q?8XtqoGIw381TiD3HSnPzrnLbGo+6P9FUWOIBLuDqCXheaiicbRh+yJmBnvT4?=
 =?us-ascii?Q?TyE7xeMPtiLcEAyKy5vJkHjW39HiB6jP86Np8/iicN3K2zWHJHsjoCvtxjFA?=
 =?us-ascii?Q?Cnsbm3mnnf4rmiUu7Ym0Z1k/aafJuer+x4A26vDik2Jv35n+iCrPqgP7O9fI?=
 =?us-ascii?Q?MnzsO9rO2qCNzpKgQ1F/tqlHmwb4FObTfgEaChOq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?8J6jof/3Lm0Wrxd2KipEte5pJFTUyr8ZJ65apVORtS1PPWBQaDvzWR/j2va9?=
 =?us-ascii?Q?2+LbVKOAkN98QQITjsTaHi3C5vpbd9RzEZMze4WgDwo4I8Po95/0ypz70DxF?=
 =?us-ascii?Q?MhfkoZFyU/KLoJhQ585yUM1GjtVSyxyId5Adxxsd5ZpkwnxB6pQrw3A5NS2a?=
 =?us-ascii?Q?AVWN9V6QhtfvFR/nfh53B/7JQpISJj+ct1qAuUNs/4rCxQpriXJhlTh29XrT?=
 =?us-ascii?Q?S9WusKSCWuG+Busi88mrWwtIUjZZu8ENJV1BdKVId3O9/r4ZIvnrCEpsJ0QY?=
 =?us-ascii?Q?oIoSEMc1ige7V2cJPml+tVTJimL+R3vOSUnCx1uCbhZbRbWoIJ73AUNTkiCz?=
 =?us-ascii?Q?yAvDGTuAwLHy2HWWkmaBOeGqOPZVl3ORDxPYAFFAmnOl8LP8iFYMx56f24NE?=
 =?us-ascii?Q?mfCekGFf6P7kWnV3l9Hh1oKwmqwYTEFyv+sxb0HjafcAlgYpGOVGzFeKm7pB?=
 =?us-ascii?Q?B8j5/sSTn5PkyfC3kex59qRhDhTmFMEpqRXj46kEpW9Hlg90F9iFFHzFSEUb?=
 =?us-ascii?Q?EPtsjRDT6RBWnN+R3Bb2ZDVtwoxfm60gNVT1TU3ZYnIQfjF/kziAK7VHNpVB?=
 =?us-ascii?Q?Aw1shSYmsoM1UH1y7hL6JluK6cmZGgvbBKmiMPbaCdLFBZHHa/2HPUyGAA9E?=
 =?us-ascii?Q?p2qxLOFHlylovZ+chcLvxF3cKrq7s5t2Z7ovwuI8knXH/SBwV0tX/Xl5DRe7?=
 =?us-ascii?Q?KH3CStUER7Nueri1023MfyweIn1Pk/8xTTR3dSwFKANFjI+hxyjUekY1wlix?=
 =?us-ascii?Q?aRRrAugQU4GO3bmWpwnbT1+1D6AFCbbey3npWPtBmr+Lsd0OK/RdV08yw3Y1?=
 =?us-ascii?Q?wj3quH5mHPkJoZ9Q23KfHBnXa/RfUUXrUMx5HX1U9kTRHe6lLHJqjHhkXPUO?=
 =?us-ascii?Q?ndGagYZp/L3FgnfmTcwuZHDjRnhJn0SXxOBPTInK5z/hPWgcFCYlNo4ni/XK?=
 =?us-ascii?Q?N6sJmrJ8XKdpePET5CYP8Y99olujaTYKqIx5Ei7ikzmTqA4I0c+yJKCM26hq?=
 =?us-ascii?Q?jW22lLWgRPtDmCnuDj7jiD7Fxi3K3mdcridaU36bRum/fvpbu1gmV/gv3dH4?=
 =?us-ascii?Q?Rq7DXPNOCOe4qOsGSTzN3ChuGjsWkDMYATjj1qBEdFEL1x2LYKsht5DxKjtu?=
 =?us-ascii?Q?qOT6gWrrRg0u?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e3a11d5-1b6e-4528-78bc-08dbbd6003fd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 00:40:28.6340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hxSsbGAF37EVBvpTcUlKUJpRq+NldUGsGqC3YnRbt7ls61TU03hWguJOkoRYzzUGRG5Uri72mtIhehxLWgLg/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7174
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-24_21,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309250000
X-Proofpoint-ORIG-GUID: cNu9uOhmoybWbAmYCp6XNgJa1581flfM
X-Proofpoint-GUID: cNu9uOhmoybWbAmYCp6XNgJa1581flfM
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

In an effort to minimize amount of TLB flushes, batch all PMD splits
belonging to a range of pages in order to perform only 1 (global) TLB
flush.

Add a flags field to the walker and pass whether it's a bulk allocation
or just a single page to decide to remap. First value
(VMEMMAP_SPLIT_NO_TLB_FLUSH) designates the request to not do the TLB
flush when we split the PMD.

Rebased and updated by Mike Kravetz

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb_vmemmap.c | 92 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 88 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 4ac521e596db..10739e4285d5 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -27,6 +27,8 @@
  * @reuse_addr:		the virtual address of the @reuse_page page.
  * @vmemmap_pages:	the list head of the vmemmap pages that can be freed
  *			or is mapped from.
+ * @flags:		used to modify behavior in vmemmap page table walking
+ *			operations.
  */
 struct vmemmap_remap_walk {
 	void			(*remap_pte)(pte_t *pte, unsigned long addr,
@@ -35,9 +37,13 @@ struct vmemmap_remap_walk {
 	struct page		*reuse_page;
 	unsigned long		reuse_addr;
 	struct list_head	*vmemmap_pages;
+
+/* Skip the TLB flush when we split the PMD */
+#define VMEMMAP_SPLIT_NO_TLB_FLUSH	BIT(0)
+	unsigned long		flags;
 };
 
-static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start)
+static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start, bool flush)
 {
 	pmd_t __pmd;
 	int i;
@@ -80,7 +86,8 @@ static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start)
 		/* Make pte visible before pmd. See comment in pmd_install(). */
 		smp_wmb();
 		pmd_populate_kernel(&init_mm, pmd, pgtable);
-		flush_tlb_kernel_range(start, start + PMD_SIZE);
+		if (flush)
+			flush_tlb_kernel_range(start, start + PMD_SIZE);
 	} else {
 		pte_free_kernel(&init_mm, pgtable);
 	}
@@ -127,11 +134,20 @@ static int vmemmap_pmd_range(pud_t *pud, unsigned long addr,
 	do {
 		int ret;
 
-		ret = split_vmemmap_huge_pmd(pmd, addr & PMD_MASK);
+		ret = split_vmemmap_huge_pmd(pmd, addr & PMD_MASK,
+				!(walk->flags & VMEMMAP_SPLIT_NO_TLB_FLUSH));
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
 
@@ -198,7 +214,8 @@ static int vmemmap_remap_range(unsigned long start, unsigned long end,
 			return ret;
 	} while (pgd++, addr = next, addr != end);
 
-	flush_tlb_kernel_range(start, end);
+	if (walk->remap_pte)
+		flush_tlb_kernel_range(start, end);
 
 	return 0;
 }
@@ -297,6 +314,36 @@ static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
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
+		.flags		= VMEMMAP_SPLIT_NO_TLB_FLUSH,
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
@@ -320,6 +367,7 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
 		.remap_pte	= vmemmap_remap_pte,
 		.reuse_addr	= reuse,
 		.vmemmap_pages	= vmemmap_pages,
+		.flags		= 0,
 	};
 	int nid = page_to_nid((struct page *)reuse);
 	gfp_t gfp_mask = GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
@@ -368,6 +416,7 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
 			.remap_pte	= vmemmap_restore_pte,
 			.reuse_addr	= reuse,
 			.vmemmap_pages	= vmemmap_pages,
+			.flags		= 0,
 		};
 
 		vmemmap_remap_range(reuse, end, &walk);
@@ -419,6 +468,7 @@ static int vmemmap_remap_alloc(unsigned long start, unsigned long end,
 		.remap_pte	= vmemmap_restore_pte,
 		.reuse_addr	= reuse,
 		.vmemmap_pages	= &vmemmap_pages,
+		.flags		= 0,
 	};
 
 	/* See the comment in the vmemmap_remap_free(). */
@@ -628,11 +678,45 @@ void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
 	free_vmemmap_page_list(&vmemmap_pages);
 }
 
+static int hugetlb_vmemmap_split(const struct hstate *h, struct page *head)
+{
+	unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
+	unsigned long vmemmap_reuse;
+
+	if (!vmemmap_should_optimize(h, head))
+		return 0;
+
+	vmemmap_end	= vmemmap_start + hugetlb_vmemmap_size(h);
+	vmemmap_reuse	= vmemmap_start;
+	vmemmap_start	+= HUGETLB_VMEMMAP_RESERVE_SIZE;
+
+	/*
+	 * Split PMDs on the vmemmap virtual address range [@vmemmap_start,
+	 * @vmemmap_end]
+	 */
+	return vmemmap_remap_split(vmemmap_start, vmemmap_end, vmemmap_reuse);
+}
+
 void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list)
 {
 	struct folio *folio;
 	LIST_HEAD(vmemmap_pages);
 
+	list_for_each_entry(folio, folio_list, lru) {
+		int ret = hugetlb_vmemmap_split(h, &folio->page);
+
+		/*
+		 * Spliting the PMD requires allocating a page, thus lets fail
+		 * early once we encounter the first OOM. No point in retrying
+		 * as it can be dynamically done on remap with the memory
+		 * we get back from the vmemmap deduplication.
+		 */
+		if (ret == -ENOMEM)
+			break;
+	}
+
+	flush_tlb_all();
+
 	list_for_each_entry(folio, folio_list, lru) {
 		int ret = __hugetlb_vmemmap_optimize(h, &folio->page,
 								&vmemmap_pages);
-- 
2.41.0

