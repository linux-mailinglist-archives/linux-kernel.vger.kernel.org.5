Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC307CEE1A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 04:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbjJSCce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 22:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbjJSCcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 22:32:21 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AA5134
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 19:32:16 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IInDF3013719;
        Thu, 19 Oct 2023 02:31:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=o8COXuu6/TtJ5IDPv6UZqVnZDWI+bSmwncS3etnX9L8=;
 b=CWr//8NbPtQ8BFSSPCDK5rLmVu+pweQzMh5trGMO4dOGK+a3EvJyWH7/5rPMDw3l2zJ0
 yxPGkcGJrafwZUBY3zEE8X3u/g+qa1+uaWcW5D0zr61ssuW1KykiIoyvP4OOdaS40kNl
 huk2/05sEaFu5VyLoorWmU92kJWh8UoeoArYaHsrzyNjtfsQQpo1iBtawxPjLzxT1GE5
 itJfDAUOFMATiSdXyNAGzFGSr+XSjNKMwr9FNaIuuOo+l5YtDugkzH3VQIVtm640IFCI
 jHTPBInmVfaU2qnvIkqZI9yyi1hbXv7zQGw2Nql3tkZKg2R/dBFe3/7ga46r4GZBtD0h 1Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk1d167y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 02:31:35 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39J14qq1021602;
        Thu, 19 Oct 2023 02:31:34 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3trg539w34-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 02:31:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNQaGVXTjSRwLWAF1sA3ar7VowNFGMkbZ8LJFSYIRwgzaGjn0cLN3G4KM68VTDJhfJDpmLBq8zHadiuUxIlAtuuSovwaVN9+bs5fMLc/OlOZoXq1GxHkkZUe+iHm6+k11atry/NZN2b2qdwJV5aWs5LxaTTprfAkG9NJ6YkXdwo2PYioiOKClB63HUKTiaNERCjewzug8DVFwWEyOXq30P63/1lGETAkemxiQiOyJWTXDYsJUlhdQut7yrQhAcwsFws3hdcvLsZszyAC/spDz/rdyv1h7598Pky26N8ETeJsml1QTx2VbodLKpz/XXQqDtCS4t72Ge6eqWXYgwjEyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8COXuu6/TtJ5IDPv6UZqVnZDWI+bSmwncS3etnX9L8=;
 b=S3YMEV5Rgs3sAjHBJKtxjIp/wYEiPiSPgAOIvjCr2x4/iisHQfwUALR/bO+NnUwwT+ylGxJT/9XY/yokCaaMLBsBrWylNUvf37/rAqP7RM73VF+oeXphdJX8H6pDvYrAF/PNfljOG70y8CmDSVtIdBaH0adYvMsi07KY1k8m/m5WdJkcXWVV2CLXf/SLFmJAGRE0aRWAucHvpqDOInhcEe6Ae+r0tQbEH7qygFSjc2MfY3+LjZ0NUHSym/7ebk2vr856ETlYPAN+Ic3LVLA7XYtbvqPl9bq9HNJYpnoLSkzU6Vw/XutHT2qJ0u/1FPNum17y3jGinyVObDygRyd6Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8COXuu6/TtJ5IDPv6UZqVnZDWI+bSmwncS3etnX9L8=;
 b=vn3UpKNCZYtYNYs6/3DLU8cDTqssB9F/LlBSND1e265nFSDGlNhxRtduL8WSrPFz2fJ0CUrNW911mP/3qedM7iFDPZfiXNYGnOnnf94bpvRoqJHDdDMqp19xWNtfIXfUYJOZDp+ZRPwbWTLFar1RlF4OloMtvGcPy72IgE4McJA=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY8PR10MB7123.namprd10.prod.outlook.com (2603:10b6:930:74::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Thu, 19 Oct
 2023 02:31:31 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2%6]) with mapi id 15.20.6863.032; Thu, 19 Oct 2023
 02:31:31 +0000
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
Subject: [PATCH v8 5/8] hugetlb: batch freeing of vmemmap pages
Date:   Wed, 18 Oct 2023 19:31:07 -0700
Message-ID: <20231019023113.345257-6-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019023113.345257-1-mike.kravetz@oracle.com>
References: <20231019023113.345257-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0195.namprd04.prod.outlook.com
 (2603:10b6:303:86::20) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CY8PR10MB7123:EE_
X-MS-Office365-Filtering-Correlation-Id: b3e2d3c6-4fa0-4d09-56b4-08dbd04b815f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tumvawd7qTZvmZpu8YuvwP8PTfpDjhlpCQlIrTNJqRFmAy2DQFO7taA1JxCrcnYCPKE/RdKK9MQ0/wRsly7E6q69YhSHsH7fMIzFL4+b/IClAywGrpU8c7Md67dk20iPrIEvbjK+ty5nGUad8wuPioBN915oN35Z/6sXHwk8IRwM4ZztBlLSY6zIR6O9WcEzgeNI43Mj96e50sgqC/dS9Kvz3Vx+dV1rwaSnjK7RxRIoGB3xP+D6qM2Gj0ki1b1GrSKQYPITtYByaLUdPMMsIPHEEOhiZGwIFtX+3fNg5Ca/AMwfuGvn5lGu2s0ampuYUakrK/ts06CD941E6pDawQ+NmSea7CfenybUHxkPCrllX/NyWa58DMX9tEGCb+dm8x2Qyf7mkOrxVFPBO637TDN2cf0NSHZOmU224ZGyEmOfeNdJP1iQWG2hHbxjnLVYuTcYOlLXsWjMUvqlNm7+OgYTkWvT14eHIHL8XhbPWkhcpLU9Sf86kNvR87ZpAEg/da6gB2naQGMIRPfMRSTv6elj5ric1Qy2eiSBxKyp5PDcBESXFkykuhdifPoE0ywt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(396003)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(478600001)(54906003)(316002)(66946007)(66476007)(6486002)(66556008)(6666004)(1076003)(86362001)(2616005)(26005)(6506007)(36756003)(107886003)(6512007)(8936002)(2906002)(4326008)(8676002)(7416002)(44832011)(41300700001)(83380400001)(5660300002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZZW5NNxkHWBabGOytlALlQEt+FutEFkn7+TxdJ1NMgGcAJ9kA4GlsR/78vvm?=
 =?us-ascii?Q?j2UUsG2WFFJpMQhHkLNQPvFZF8YcmTzHimqs2sHTVtSr+jL1DWsVOjHjaqkK?=
 =?us-ascii?Q?6nyR72DIM+lBnZrTJ18VvyO/Lwshgjv7LEWTjg/erUQ/FKtBr0UX8cad87me?=
 =?us-ascii?Q?0MdfPlDUP0z+XimtqHVSTGcPuxEi/yxzXWEpQnPnGPfGXMjGfkn0GwjUMu+9?=
 =?us-ascii?Q?velMibd37XKIyg0FHzBuoQ8JYn+E2TVsha+K7h6iFuvGLesADTD67ciPn4xM?=
 =?us-ascii?Q?vZ50M9Lxf2deIYQ2OEz9eiW7fCUihNs4NecWF2LA6M+jnK3e3MCvwHXo/rcZ?=
 =?us-ascii?Q?ma15AHkAh54+LXNh0JHQSSPSvSSCm2TeEWs+FYKgGjaS/yTzK/ZwA9BKLZTT?=
 =?us-ascii?Q?/FmjZXfLTv19AJwPhQrSu/4ZBjcwTOSsfc/G9RTrt2GRpwIkOZI7ytFYAZoB?=
 =?us-ascii?Q?1rLrmI/GBMTvb61/YbKazp0AOJp0Tc4pUZ30UPwuFFZgMRufwfqos/LCYH58?=
 =?us-ascii?Q?/yCH+H0W+p2/ppauGlHhds3COOjNAg/0ssST/C7laR/AXLT8K++jT/I71+Ri?=
 =?us-ascii?Q?aIBKhaExX5oD98t34gEqSh/c94bGERMyizVG4JGchLL+Bne5RsC3hbyuMVfv?=
 =?us-ascii?Q?dtkIZ78WVaj7BREsHTJsxuEy570INKt9DNa1LjPp49fZ63queJ1MZQSPC7Pt?=
 =?us-ascii?Q?Qq31Uf3yfyQuAge9hRjVxtnJX77mOb+XWkPrjLXJf6NfIt64NRMo/+zn/b9p?=
 =?us-ascii?Q?I0vI524cixaa16mkHDeECkUs5zVm2sERWiqKEB41hGVs56euYdQ15TAHK7Il?=
 =?us-ascii?Q?5MmmomwwuDZWId+p/x+ANm25uh5EiJn86OVOflS8iTd6W9/HpOYPTyEEA3jJ?=
 =?us-ascii?Q?aGxFl5F4s90PqiqJ66UMP7xfADSHIxOkBNm3WSoODN/2/j7t1/zvgzschMTv?=
 =?us-ascii?Q?u6raFwKJ/7tOQBdr9zlUl7BX3dD5xGGOho2C3qa7RPreeBXhkKFlFc4AzorE?=
 =?us-ascii?Q?zVgFlsFRs3zuY42YDYY2oJ1arg7KBkgf72f6t/5qZkwBtN/Dw8NmJYxUmOyP?=
 =?us-ascii?Q?Iefur98p0ieK2kQ2epU0ON4EApT164IZZH/zxxSavAsklK3V2TltwcKgTAxs?=
 =?us-ascii?Q?DvlR4ViEVT237Qgt0JCYxiiw8cNLFaVkM53HKG7W1QdGa2pBOFZWCBvgmnNj?=
 =?us-ascii?Q?ZrZwlkF1PdC57RNYjgxXON5dOBPRiTfQq6nAibdQrgx4tsz5U7SR8JlzUCaE?=
 =?us-ascii?Q?7cyaQt9C1hSdk3U6QDs7O0LIG3xcS6mqLSsayZICMPLraYbpMI3y1hbcPcaD?=
 =?us-ascii?Q?pfv5nxyBEdwsVsajxlbdYePmTvwC7XSOd/W451YURgc1W/Aq9adOhK3exfwk?=
 =?us-ascii?Q?/wI/5WSj1wzVRxaL6lfFN+/bJxmIAq8amXR3+EzLOY54WWLuHZXpyX9BQxcq?=
 =?us-ascii?Q?p2dIAI9U5GxIjyL/zDwOR4g5zTtvApZ5fDE7hi4x7xKIeGssKufrRZQp+MND?=
 =?us-ascii?Q?21CQBDy7vxc7eW7MAZFhBZjhb7FW1BaXGXcRM/F4L81OqMa7brejZfgEHtY2?=
 =?us-ascii?Q?LAuwCRk5YuHcwQV2sXWIRvhLmuWtvjz5IDQfWyh80LPeO+qFNp92j24/41Eo?=
 =?us-ascii?Q?ZA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?FElUXM4pZfVy/zUBleaWpQdiPGSIQhuOTX0AKDDOEZavDTvdbPjXkLKf1aDU?=
 =?us-ascii?Q?1q6NSUpI50Tx71AGaCwPDom81/JaasjXvPl0WC49i0UlMXK4uulzWRkNOaVz?=
 =?us-ascii?Q?gbDk0zxSOHYB9SEdbADHqH1eytUBY3f2vhBPcGm4DFcv1PvssSRyIUUAfDTV?=
 =?us-ascii?Q?w6hlLNk8Bsqk6t8R4ERgCB0/rJqOFJfxW3xjcixF81SJPazRYX6BIOeRNeFa?=
 =?us-ascii?Q?B+UcjpumoKKTxmtu/PM3pU7Md8eN8ehfFHOSTUqLYruyZMhKPCaBCH0zjMnO?=
 =?us-ascii?Q?Mto7PyQRx8ddasiQJ2K0xRmWJx046ZnuspzLoHcW3rlHF2ZErc3a0Bf57zl7?=
 =?us-ascii?Q?YomPtISYwEKrwjZT92bC5z6CbHiOvssKDZZbcA8oj6eexP4F2sV09HeFNzlV?=
 =?us-ascii?Q?gUe5AIeLmmFyBTaE3V7X1ChaMLOsvCdfVCykYl9jVn/epWDF+Br8CBISI7yB?=
 =?us-ascii?Q?fVM91hf7og4bs2X3d0G/yeWcmczNv79lxqo1qz4gPO6t6Xw7czqIy8rrWSDs?=
 =?us-ascii?Q?tbLBK1mjEx0u/NgtYPAKZI9PJ1+qPWkmP2QhpBQtaBRsNo+0ptR1qZqaYZKZ?=
 =?us-ascii?Q?JoNx/SWTb3ZSA0sYlYaXfLzPJE8mXBbAT/2CjS1MQmrVAawg3oobfRnui/+z?=
 =?us-ascii?Q?//8E29l0g5dFZl7flMT1swKwqSz/33rS4qLhS+r27HO43c4jVJhLDHFrB1N1?=
 =?us-ascii?Q?08zG0Plmbko4srD70uwqBxDU1KuWJQtfHncQtekgj4PsCVj7jtzWwt32r5ll?=
 =?us-ascii?Q?9iRPdMpkXEMyClb3D6tMG/fZF1LntJi/T4UYd1lFf34kfGpYs/hqL3tJQa0d?=
 =?us-ascii?Q?hmO5EVLe018QQQtyMImrSEfkhzCfc5Nf5CfcCZ8QA6S89cuXZdnQ8KNosxJf?=
 =?us-ascii?Q?9UowvGgLywEHk1rhrnrY+CEmdc9RHgayXaNbRWPu8QeGzcssyzunNlwM6wmh?=
 =?us-ascii?Q?2ruvoIPIRruTLWubqrBDYL788hcPxPP0en7/ZtljqtifV1HZGiDy1XiPiIYA?=
 =?us-ascii?Q?OI4r3H4u9sJhQzIlm/Z5D57ZixTKo1PF9PBq2+aIm9U1Zm4S5WWi5fxk6eBy?=
 =?us-ascii?Q?MEMP0hPSs9j7gnDda+1Pmb18yB2mKLJG7ZEb4qu8XSum01aY5z3P5EtcmQvs?=
 =?us-ascii?Q?C7w+u+QL8ZRE5VvRDGiCjmEbCdQtM1tLzlqzIHFuXgoGPLIArupshkXfyRnG?=
 =?us-ascii?Q?UV3WzXHTEhFYKTF6?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3e2d3c6-4fa0-4d09-56b4-08dbd04b815f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 02:31:31.6623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IB6PUx/72yjRvJu8Yl40s53/JOvfphT1OGtNBDGGov6gUYQV4s4dy4DXdlu17v9gZQnCggOhYjjeDqNXBzHUVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7123
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_02,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310190019
X-Proofpoint-GUID: CbApSzPz9J45Fy7Qgb_BzFLvIhBy_Iuy
X-Proofpoint-ORIG-GUID: CbApSzPz9J45Fy7Qgb_BzFLvIhBy_Iuy
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
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb_vmemmap.c | 82 ++++++++++++++++++++++++++++++--------------
 1 file changed, 56 insertions(+), 26 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 77f44b81ff01..4ac521e596db 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -251,7 +251,7 @@ static void vmemmap_remap_pte(pte_t *pte, unsigned long addr,
 	}
 
 	entry = mk_pte(walk->reuse_page, pgprot);
-	list_add_tail(&page->lru, walk->vmemmap_pages);
+	list_add(&page->lru, walk->vmemmap_pages);
 	set_pte_at(&init_mm, addr, pte, entry);
 }
 
@@ -306,18 +306,20 @@ static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
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
@@ -334,7 +336,7 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
 	if (walk.reuse_page) {
 		copy_page(page_to_virt(walk.reuse_page),
 			  (void *)walk.reuse_addr);
-		list_add(&walk.reuse_page->lru, &vmemmap_pages);
+		list_add(&walk.reuse_page->lru, vmemmap_pages);
 	}
 
 	/*
@@ -365,15 +367,13 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
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
 
@@ -389,7 +389,7 @@ static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
 		page = alloc_pages_node(nid, gfp_mask, 0);
 		if (!page)
 			goto out;
-		list_add_tail(&page->lru, list);
+		list_add(&page->lru, list);
 	}
 
 	return 0;
@@ -577,24 +577,17 @@ static bool vmemmap_should_optimize(const struct hstate *h, const struct page *h
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
 
@@ -604,21 +597,58 @@ void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
 
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
+
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
 
-	list_for_each_entry(folio, folio_list, lru)
-		hugetlb_vmemmap_optimize(h, &folio->page);
+	free_vmemmap_page_list(&vmemmap_pages);
 }
 
 static struct ctl_table hugetlb_vmemmap_sysctls[] = {
-- 
2.41.0

