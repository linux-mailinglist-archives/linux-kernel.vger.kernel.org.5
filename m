Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E097A5608
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 01:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjIRXDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 19:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjIRXDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 19:03:22 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA7391
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 16:03:17 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38IK54UE005659;
        Mon, 18 Sep 2023 23:02:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=HVizojME0l9i5OjsslwdvJakCgkz9Uqrfyq+3ppeWTg=;
 b=CNk8QpNWwIMa4cb39CSbIf6Zyhvmn23vHkxlrGIliFgqjZUbVwtr64RNpDYWTiwD9FEm
 6gzzJXCtU8IhfCx1sPdWXCGPLn0fFnkmvho1gKF4aAA/1Vypdyf8UQ7u6NkwtVVY7fi0
 r8xQ8vi3BXhrANwXPQYZVhjVNX5Tw3cxI8F5Q2P7DrhnCmZu5Q2Fgr55zMjD22YDCiFI
 nVAb56NKfgsmDLQsWXby8VV7gTrpcgCR7E3xqAdXHjwZdrtch8zvHvbFkYEs6O+jkPc/
 v5zvDa27FBIkTiItNErnk7I0hu0XNcePtiTPOVt2qOQ71nCNQST5teTYiZ/ei2vAIq12 Rw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t52y1upr1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Sep 2023 23:02:29 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38ILWfWc012091;
        Mon, 18 Sep 2023 23:02:27 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t55a3q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Sep 2023 23:02:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWMZlAwm554txPFGG4lPxDFq/USj/Q2ohagxmoRYuPQwEiqre8D0T5ugchT5oiu02Noqx459D+gN1FrcXHgbAUTIRf2Ohl3xmWMi5feH2RsHO+xFR1Y4A0NF15BvvVhEkLXfIfMGn/jrpksmHFftoIGFXCXPhoKycBNeMASg3Funye7io0xe8W3SV2fgdJcpd0HbwSmjYVLLQgBAoXDEnu9CHU32DtcYZaPIMRrFUrQ7ZhG0/YWKu8dSrKx6x//6R2aqwdThNGxToyubsbytEp4OiFDOJGxtP0upxBbQYbP/sEhXb0fxt/7SVUzaV/AkoXxT0Hhtkoa3Gpd8RG5oMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVizojME0l9i5OjsslwdvJakCgkz9Uqrfyq+3ppeWTg=;
 b=m2/z1BiSljymn1lb6qytTNy0WQew1F82ON+lQdyTfNVvWBgh/1s//mrZlfES8Eh/s+KAL8Yy76c73wcyvhv6gWYME9a8Sb+qDXKnHwLVNXuzqLGQcQ+yXcLAoThDrUZ5YYtQOtHJuXloF0IQYw9a7qvIPdSU1oeOqUQX/Y2Ogzvb1VefkJM+pt5dD8gJlKTklaZNXHgmb6j0w/MfoDvvzhmTGUwRV3mSJvT9B1Tp+XMS/BGtr7P8Pbfa+qZObmzixf6dKE+P8ZKHMFAKy2Wyx5p6kd56hJ/7QqECl2JHJEdEmcVAvLgZ5hFYRn9RHWTMUsFAyTMAMIq/wIiR9cPX3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVizojME0l9i5OjsslwdvJakCgkz9Uqrfyq+3ppeWTg=;
 b=V8aByWVj+QA94h8D6eEKV5WA69JHW1hGdvTixQ83NCjRxUu4V9wOX1s3b3mC717Odnp/ni9gjxn9ensNFMpmuh9BCuwZhsyJtE+qYtTe7bv+ejm0Yv19MINcp65Qbuec7ABH7e1pLmV5mzf5ptW9qvAwV8YNxP2QFPg6F0+sEhE=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH3PR10MB7494.namprd10.prod.outlook.com (2603:10b6:610:163::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 23:02:24 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 23:02:24 +0000
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
Subject: [PATCH v4 6/8] hugetlb: batch PMD split for bulk vmemmap dedup
Date:   Mon, 18 Sep 2023 16:01:58 -0700
Message-ID: <20230918230202.254631-7-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230918230202.254631-1-mike.kravetz@oracle.com>
References: <20230918230202.254631-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0046.namprd16.prod.outlook.com
 (2603:10b6:907:1::23) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH3PR10MB7494:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b4d9536-0c1a-4fc0-4297-08dbb89b522d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MOZf/LfFxG5nO3hBzUzgFULJXxGSCuFexZoe4Ib7XBvVRoXwj45xWVQYhLYHtKtcXoXxboREJRW+VqxCGNWqKbr6bXK6cZRhZkVJUFHyUL4wbreq8U+jkouKB1ONuz4d/eqeV1qA0eAQ+NFnJHV7rg6LMBYGc8iPzx1AA9td/+EFTxK/jaOmf0pS/rgLwdfDQ+7SoZCKP/xFboFprFhVsUvB/beV1D2p3J3oqpKMqB+Cl3fy2Z1nrtnhM6uHLxHmQfwKjUE7qQEnevhGzS/eUIse8lkD2TERmyqiIpcjFY00Xsg+jQR6pdgD19IGJmnqra/Em03y4rz/n6PyXiaJn6Ucz9c7FYXw45N4UiHOCbgQo3KoXuvqnAvECj6vNFEZmZoomP2Ghy1/Vr0vrW5ShErH2cykWvcMOPqLdhOZZtlEKwmzmn9o7w1lVPthOXuF4mYBwb/1ufAk0VAvZ5PnpsUerP0iDWArlVsFc0JLZIxmC0J83PHVIZEA++461oKijNRy52LRK+ttJq/1cto5NPGyQW5jL6MDf/MAjD3YCgA7KVqLHHl7TTOe0gPuQg0f
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199024)(186009)(1800799009)(41300700001)(316002)(66476007)(66556008)(54906003)(66946007)(478600001)(6666004)(38100700002)(7416002)(2906002)(86362001)(36756003)(44832011)(5660300002)(8676002)(4326008)(8936002)(83380400001)(107886003)(2616005)(26005)(1076003)(6512007)(6506007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tRuQOWgnDO7mt50p3A82lgh6EodceLn9Vu5OvmugdKGCMey42fHoINv8Bf2u?=
 =?us-ascii?Q?3g0p3hBjszSYSZhvp2Vt1fyAV7okZbaHZTOB4nYAZK1XanFI+jRiaOPPhaLw?=
 =?us-ascii?Q?byiuqQktW6HP3uGwa+YcmVlMjJ7p517KygHJp9lDGhaFY5MKqqvypLamjPVc?=
 =?us-ascii?Q?4qUh/LrW6xhTqXMN8IEdIscxdXOJ+SlqNPQJ4qe6FbVaAs6/OCeG/yOdcY0p?=
 =?us-ascii?Q?5gcyztBmP33CXrhe3jDaBrGcdA0wrN4OTRbKPg8YwQzcuuWij6a6P7VkIOvA?=
 =?us-ascii?Q?Lcf4rx92Hhj0PmCe/eiVBEY3aWZ58Pbse3ADBhDy085K/+2wDJ2pz+78eUwV?=
 =?us-ascii?Q?VC2ogjwLiyqKVtQ8rYR+DJf8b61HfTNphYU+lHrJDgTk0+5yYX5TqzQ1O3IE?=
 =?us-ascii?Q?IGxi5wTlDzvrhvqOSiFuqqufXPsdseuVLyjgBKuRkSKIHL8wsU7bn/AigSQG?=
 =?us-ascii?Q?pdjvVv6/aTjidriZYTMzc9iIVO9ya2OviQN4f5WwmAfWgLQYBIsHOjjGO2CL?=
 =?us-ascii?Q?MmEqETXWOU1tsaHvdnxHp6/7o94PcKkXrw0tkwXaoLE2wMERAGsbcYSBi/7X?=
 =?us-ascii?Q?2k8vr6N43iv+OSnICUlEIdtoCjiJ0f59SgGU1Oj1PYJpPJIIRXrEkTGkTNgr?=
 =?us-ascii?Q?8H+DPu1UR1J7zawJDOKStlM1xXOnvkf5QyA7IGNC/CrHPJz98SEqTu6U5kkG?=
 =?us-ascii?Q?kAjQmo/TsVUMmxWqOrbfRmK/77JjDyN+HelW93n0ODjLzb2+HHdvy6gDBNfx?=
 =?us-ascii?Q?UURVPbCyIZoOltttBBi3PusWimise39vQwLgxSoBXs8Qyv2INXtPlYwfLTTN?=
 =?us-ascii?Q?yNqWeVC/BoJvocCEU3Pgq4ZdMJ65XPTnJ3TvKhvl+GaWjDwDxtq+/Um2t1rw?=
 =?us-ascii?Q?F+StuAUF5jUcVS815UACq1DWl3oRPzq4tqwcEIhkiW+ZpkRxBEHCbAjLG+Gk?=
 =?us-ascii?Q?GpzGUFL0yJWVeXda/VfM2gEyMW3Hzms0AMF5hkog0M/L6zROm9qbUqxZtsGg?=
 =?us-ascii?Q?oXqY3iKbrHO2Bhf9Dmy1c8SY6RdA0LMX+L2+0xNGZGcjdDuU//FB1wlJYa3c?=
 =?us-ascii?Q?dBuDm5DDRTQ01A2gUfhu3z0WnC4wI66B71zVwcN4I0ylGcse3W4By7KQFRqu?=
 =?us-ascii?Q?+AvX6kJsISrfI/dnsi7vLJLIFRpcZQaeHFps/WjTwkBaxONzb1+R+EnWHZaB?=
 =?us-ascii?Q?mgu+CIM8cWPD8ClwAuNwRkgPJU+yriXehaHyQ3jZt2WzW3CsVN6BxFzWS+M9?=
 =?us-ascii?Q?3mEdzxnI/d7DA6DUSqp5VOBDXscH1oHA+GVi38Ehnze0yNsFKE66nfTHKvVS?=
 =?us-ascii?Q?LCEmM6Vq6WsW3cqrakAS66HopJf5WC3VmFWt7YhvjJRDatQfqyO2RD94u656?=
 =?us-ascii?Q?ubD7X+c7cbwyXRZSB4apV0RVheDphyazshZJWxc+uD3oYZjpuCEAT8pSDNPB?=
 =?us-ascii?Q?dIFudIiZ41CUWyNjfgj/iuSwxevUepAUiLyc8dGkSlxzx7lHlTHfSLzZxr0K?=
 =?us-ascii?Q?AGuAnkdrLXkxZVrdfbpzmlwu9cSSIgh+djI2A1L5nMumfvXNhRge3WfXlnbe?=
 =?us-ascii?Q?JytJMTZKsPlCCLbtxHHt5hAL/nqjKF0uxr9pEb/l?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ZH1+//BY1BGiyqpcWTnWYTAMXxOX4WY/auQOsb4F52HgiFy/nakCAOZ/lrMj?=
 =?us-ascii?Q?nw3VKkh3/zYmpr8PNEY5Na3nQwUbkUmHyhJg1XXfnizh9te+EQuPCKey/YpM?=
 =?us-ascii?Q?f3AAbvHrids64zNGB4F7sZOWEOzu7Iw5oIlSFZnGwAE8laIdpVQBh6NwFZsO?=
 =?us-ascii?Q?FWHa3ZP30gvoj6dl/GC711YziMtq1qVXsuwl81/grcOUCig8aCRIX7qRVYZ+?=
 =?us-ascii?Q?Tp4ijarzR3tJbhr9BC4sU3DaWXho6i64T7tpjpC1BnFOSveCFW4emtl9xRQc?=
 =?us-ascii?Q?TTqUnaM1Q4mTJQuZ7EOuFBcbO5AFmCrU50bswfbHQ+QTFDpAn980qI/udKZJ?=
 =?us-ascii?Q?1rOJW1WjEhw5RVc4BEMInxT2TOuz/ctsDjcY28lRR7+FGV15neFzIh4ffCte?=
 =?us-ascii?Q?nnmfHglbbQYrv95v5CmH6uRgIKId/aAhZYpl8W6LouT4t2AJgDcCmgnXl0KZ?=
 =?us-ascii?Q?UroG88BJyErjCTokcQkerPsNfLhQ9yQp8ajw0glpUHiHc1Q2kIFIY6YmWiWL?=
 =?us-ascii?Q?ZYO7Ctviu7uo2ZkH5c2kl1VnOgHboVkdHDz8HcNgrGk/7Me0EdeeLFXABaTl?=
 =?us-ascii?Q?LFzZiqKQcTU1t/hd62lfVo0CZq1jj8yxaqi3XJQAM9tYnHUtfv9JUr0aUst6?=
 =?us-ascii?Q?i+LnbtuNr90Hafp+RUNRCSGP+1mamGVdVRY3NZNeaXn/dPm+iUbRSIZoYiPd?=
 =?us-ascii?Q?SRZW3KkIQ1xvL/LhdL/UcOFwkHenOIc2K+2b9dOr9tWqF+nu4PUNUWCARRQZ?=
 =?us-ascii?Q?HfLVmbX02Hs5US3NsrSB+LaA+/PQgVdD/6HTwbd/8Gz4UdLtWzM7bk89nD0G?=
 =?us-ascii?Q?fxVsIIF1jWTSucwMBToutBC5jpdvi4HC7je+kPSbgrn/6yXJbjKuPNfWHKDQ?=
 =?us-ascii?Q?4hnLfwBRX1WbitGra9Pqv7VVh4y9A0sw+YXHhc08zuppEmIyaYpn8wwgCwfE?=
 =?us-ascii?Q?obpLoAzH4ZobGIdMZ6JPMt80ahZfPrzgLiykbnT2s/0X1nyVfQoGgp1FyfqK?=
 =?us-ascii?Q?btNzD+DS4QcPCu8kQwvEEgtq76cbX+CC5fOkWEamxLhU0pAUeE3xU2bLFJaG?=
 =?us-ascii?Q?1pnOdKVDaXcCZ9wf5q4avMUmygZpigjj/bwmtdCBdKGh5wLzrJFV8I+JmSMW?=
 =?us-ascii?Q?aTIOc2fiPunB?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b4d9536-0c1a-4fc0-4297-08dbb89b522d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 23:02:24.2419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rVRBlDS3h6nPX7iXYNvpty+/kiy1dVO0vgHLi4Hr4Qp8tkUj4AMmALOJ7R7qU03r9ba/0v1IvdvYuCw9a5mr2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7494
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-18_11,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309180199
X-Proofpoint-GUID: x6y18A2y5YUln9Kv7X7kti_xq7whMdX5
X-Proofpoint-ORIG-GUID: x6y18A2y5YUln9Kv7X7kti_xq7whMdX5
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

Add a flags field to the walker and pass whether it's a bulk allocation
or just a single page to decide to remap. First value
(VMEMMAP_SPLIT_NO_TLB_FLUSH) designates the request to not do the TLB
flush when we split the PMD.

Rebased and updated by Mike Kravetz

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb_vmemmap.c | 79 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 75 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 147ed15bcae4..e8bc2f7567db 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -27,6 +27,7 @@
  * @reuse_addr:		the virtual address of the @reuse_page page.
  * @vmemmap_pages:	the list head of the vmemmap pages that can be freed
  *			or is mapped from.
+ * @flags:		used to modify behavior in bulk operations
  */
 struct vmemmap_remap_walk {
 	void			(*remap_pte)(pte_t *pte, unsigned long addr,
@@ -35,9 +36,11 @@ struct vmemmap_remap_walk {
 	struct page		*reuse_page;
 	unsigned long		reuse_addr;
 	struct list_head	*vmemmap_pages;
+#define VMEMMAP_SPLIT_NO_TLB_FLUSH	BIT(0)
+	unsigned long		flags;
 };
 
-static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start)
+static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start, bool flush)
 {
 	pmd_t __pmd;
 	int i;
@@ -80,7 +83,8 @@ static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start)
 		/* Make pte visible before pmd. See comment in pmd_install(). */
 		smp_wmb();
 		pmd_populate_kernel(&init_mm, pmd, pgtable);
-		flush_tlb_kernel_range(start, start + PMD_SIZE);
+		if (flush)
+			flush_tlb_kernel_range(start, start + PMD_SIZE);
 	} else {
 		pte_free_kernel(&init_mm, pgtable);
 	}
@@ -127,11 +131,20 @@ static int vmemmap_pmd_range(pud_t *pud, unsigned long addr,
 	do {
 		int ret;
 
-		ret = split_vmemmap_huge_pmd(pmd, addr & PMD_MASK);
+		ret = split_vmemmap_huge_pmd(pmd, addr & PMD_MASK,
+				walk->flags & VMEMMAP_SPLIT_NO_TLB_FLUSH);
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
 
@@ -198,7 +211,8 @@ static int vmemmap_remap_range(unsigned long start, unsigned long end,
 			return ret;
 	} while (pgd++, addr = next, addr != end);
 
-	flush_tlb_kernel_range(start, end);
+	if (walk->remap_pte)
+		flush_tlb_kernel_range(start, end);
 
 	return 0;
 }
@@ -300,6 +314,36 @@ static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
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
@@ -323,6 +367,7 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
 		.remap_pte	= vmemmap_remap_pte,
 		.reuse_addr	= reuse,
 		.vmemmap_pages	= vmemmap_pages,
+		.flags		= 0,
 	};
 	int nid = page_to_nid((struct page *)reuse);
 	gfp_t gfp_mask = GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
@@ -371,6 +416,7 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
 			.remap_pte	= vmemmap_restore_pte,
 			.reuse_addr	= reuse,
 			.vmemmap_pages	= vmemmap_pages,
+			.flags		= 0,
 		};
 
 		vmemmap_remap_range(reuse, end, &walk);
@@ -422,6 +468,7 @@ static int vmemmap_remap_alloc(unsigned long start, unsigned long end,
 		.remap_pte	= vmemmap_restore_pte,
 		.reuse_addr	= reuse,
 		.vmemmap_pages	= &vmemmap_pages,
+		.flags		= 0,
 	};
 
 	/* See the comment in the vmemmap_remap_free(). */
@@ -630,11 +677,35 @@ void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
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
+	vmemmap_end	= vmemmap_start + hugetlb_vmemmap_size(h);
+	vmemmap_reuse	= vmemmap_start;
+	vmemmap_start	+= HUGETLB_VMEMMAP_RESERVE_SIZE;
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
 	list_for_each_entry(folio, folio_list, lru) {
 		int ret = __hugetlb_vmemmap_optimize(h, &folio->page,
 								&vmemmap_pages);
-- 
2.41.0

