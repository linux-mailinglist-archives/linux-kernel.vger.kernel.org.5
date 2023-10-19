Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BAF7CEE1D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 04:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbjJSCdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 22:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbjJSCcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 22:32:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278E6D60
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 19:32:31 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IIp6k7018146;
        Thu, 19 Oct 2023 02:31:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=ts++G+BYdmdUFqdAtNKLn3GW8JSwEPzR7WlqhqbkpgY=;
 b=AD36YTGeiZWnEukAcKv0QYQWZZxxSHFOc3xkUPoH53ep9B7UFKGHdl4gKR+GO4cqdS1+
 fthTbuTNMWGwrisGAWwQOmN1mvGG2U0e5pWUcKoflMQJrWdF4+nnH0vmzQD3Ob/brPp6
 urBJAspsynyqCLu5oOUfc9HmA65uHWVoC9JHcGcgrZTYVyBP21mzMqJxK560yRo5yMih
 XSvyqExDHrOYmDUFXwpvsz7y/XOkFRk+pYcmdb5hqwv91em/Fp9ljnNSAcrvr/uNhKlE
 Jh0xVogF71GV93f3IwkLVQK1up2TCgvpHelsZz6HwHVnDJzZon8xvY+GZOtKNhJidByX Mg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqkhu993d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 02:31:42 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39J24XwW015185;
        Thu, 19 Oct 2023 02:31:41 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3trg1hah69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 02:31:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A3NquWCZeno14c7qAxUMu9UErDakrtgLvYMlX8sof8frvJd8wEwzsV+De1gXtLd86Z1oecAR6YXQoJ8lkvn1u5h9Bziao3lcvbjuxiFfby8zNWLI2klZm8LKXcuq6wK/h5EZ5VR9vHUYFCULaXoSVyQMGSBQHs2u2rtRUJFsD5Vif1LtPC69edWA5ujqZkdxmXJ8ehWGvgXnxZpW8MYUOACUwcbVEsiZdvXEUOC2121mid+u+6hQcH78NEzgBW8X5PRAkvM6IT6JPSK/0PP1LNcSRDd8PfTmGyTkbMUt135CkczAtixTi/qj4TV/Aa2do6T6dPn25kjjNnd8IDg2dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ts++G+BYdmdUFqdAtNKLn3GW8JSwEPzR7WlqhqbkpgY=;
 b=SNq/KgM65DG37gPOdZVPafGGdUF8V3LjH0YFIsL9QYkQF8U7HggDayIf7BgrjhRaT3kVHBmHwz+UknUnS9D50RJ1NkHyPI6uSMfy+0YQ+MVsx02hngHXS1gm9zs/1JIYDYIkQhJ60QmUHkxb6l3x7qkamhZsJKKHPtl+uaU2Z2chZipvMWWJe2ryylTdcFZFNTko+CGVpkHMCkcRkX2BvzyiTx5svOKJpA0KsaSuMAWBeDHLQuUHx3cNAM4V+ATAW/CKr90Nd3LaTSadLa3tPxDV9XM7yyhFC5jRM4/UM44LEWzeC7mCaeYoMS5GC70dw98uFgNXatvc8rzQHRVGIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ts++G+BYdmdUFqdAtNKLn3GW8JSwEPzR7WlqhqbkpgY=;
 b=NAW1kA7Sygn7Y7GzHGBKKAeurvE1Ok36V75dzSZaXhzWu8xlhiKS7+M6z/PcAV3C0L2kt84AjuutZPG1Um+1CyURmJ1waUHJfwGrh83mzcn/UKTblufeeMRVDemkaBglAXeRz6/J97+39zjTQ0LryMoO8dkKH/yS8BjOvWvs62A=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY8PR10MB7123.namprd10.prod.outlook.com (2603:10b6:930:74::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Thu, 19 Oct
 2023 02:31:39 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2%6]) with mapi id 15.20.6863.032; Thu, 19 Oct 2023
 02:31:39 +0000
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
Subject: [PATCH v8 8/8] hugetlb: batch TLB flushes when restoring vmemmap
Date:   Wed, 18 Oct 2023 19:31:10 -0700
Message-ID: <20231019023113.345257-9-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019023113.345257-1-mike.kravetz@oracle.com>
References: <20231019023113.345257-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0109.namprd03.prod.outlook.com
 (2603:10b6:303:b7::24) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CY8PR10MB7123:EE_
X-MS-Office365-Filtering-Correlation-Id: 56c4f069-2e88-4c37-0167-08dbd04b85ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kQEOqk2kwcERpCV+is9Y9uHmqYaG27mSBtqqF0mIYojoA/zeXRFVlU0FNMtsWCzVpjU7qwOdosJXyWXmw8wzAWY7DzWTYZHdPton4e7AZuxH+4cSuZAyU4+eT1Ol6AqtkVypW8cRupCpfZP+turvy1PPTFcVR1VvD5tY3MXaPQHPGMIcRpNgHRUJOBCcT7dop0RaEWENdbJdSRRCJ6EncnrxWN64j3s4gYRkJ6BvJVvvA3Iu5bsgspZoZKsTAf37/BCS+rxDZJp2uScT9ilfUrZVbyenFHihlVGujviBRCsyFri1pT8HmvmrwCpwYCeLzhaNkhqBKQF2KnU5MgmC8WkVc3/a2IL+8hZRIL4+e94kiHYFsgiO28nwpjyKZXZECvoI9hJ1/qzwyzZYF36abJTHCpn+VN6AfwPtVXQyBHfC75tffnADXxqxmcpzKRPizxRwThAkV28C/enM7p5lgUliNB55M017SKMJttdfKkwmNDgwl0giCLFDDaYFfyE0D900zlGaqcBlfLgak0LH+0NV3QHPoTQNnCm4cfbKwMPVDVmbbG4N3eNeQmzpB5Kf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(396003)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(478600001)(54906003)(316002)(66946007)(66476007)(6486002)(66556008)(6666004)(1076003)(86362001)(2616005)(26005)(6506007)(36756003)(107886003)(6512007)(8936002)(2906002)(4326008)(8676002)(7416002)(44832011)(41300700001)(83380400001)(5660300002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nL2WEc6YYaP0NtdXfehwv04o3mChqWPBz40r29lSqmBlQGYY3m4hcnRmu+TS?=
 =?us-ascii?Q?79OIDsoTSFc+d51QCAnsWNg1xnmkuTb68NOF9FVLIX2khlHo9/2sVFdI9Nqs?=
 =?us-ascii?Q?uWaBF8ZNil47JUQgBi5FYnWht/yegJ5PEzKVoE4tCjr4tgm5em9W67dHaxn2?=
 =?us-ascii?Q?1JaP1tdqHn17YkwFnGonb8RocxY5gKpwqEFf1KZ14ryenEpsEnW+USz7702U?=
 =?us-ascii?Q?CRXvV4bxc0v4AV5DB3eFB9/M9Dupws/kaakOGPGgP5taKjuQRRjsDiQY97HB?=
 =?us-ascii?Q?f9sQWSMSePNWcta25w9/0gywaHeIVNpc7pKAMjBKChj9WfaOOLQhHxTJGTA9?=
 =?us-ascii?Q?RiVcVy7FdtTEMpmHM+IlSR4cjmLICJXUWkhIxHeBVBmBQSHlKOi0RpPIRzkL?=
 =?us-ascii?Q?jO7mDJ0nlKyCKuQxHu1r2sMFgRTv8RfuAhj4YbSYlyuJG+uYij58KuGrYrY4?=
 =?us-ascii?Q?SUmGlqNMVfdLHjagUMtJeVXJi8RmKnOTCabNyYRvCVlEj+7V6YA+lTZw/xHe?=
 =?us-ascii?Q?3Ra0Myc08xn/masUa+IzAp+6m7LUTvly9eQDtz2b3c0qnlxBye+RODj5izH9?=
 =?us-ascii?Q?eVGJrMFkNlIbGVpbcPJ/YRHrHL49jo9XhtgBz6L9P5HcMyYO0sQcN/1uRyEU?=
 =?us-ascii?Q?MVarVebl4YL+aZ5UBtVVRGl1cG5skt45yHjOuVh5hUg6IK7aGuszEaiGXpJo?=
 =?us-ascii?Q?xHvgfJ5MmB4WaH97PH+7L+REQpePRI+wNtouiYb0BBGhmrjBF4qpsF7+7nQD?=
 =?us-ascii?Q?+hF99z4oXi5p6jXO0Gj0hWHFKAa87qlYRGJ+w3s/cGqwiiPCSeuYXJgORjga?=
 =?us-ascii?Q?qh5zBECENZCAE7CJ23cwyO27ezF1FASNLWg4sHCNQsnWXQhl75QwUEohfwXj?=
 =?us-ascii?Q?9pLslKnMbA2860SMjXHkNBIsyW0SpYua9K9BW0GNCEx+SrpMsrmLhn1TwtNj?=
 =?us-ascii?Q?ZxgYnpzExDSwOoalaqMkJzxfib2qAQU0S+tR2JIvtgnEaKq4VkhSda+k1gA1?=
 =?us-ascii?Q?AzphjO4WqD8r5hgPoGIFUdcReQgPMK4tOXp3YukuQyTHeOwbelgEmCtbuZU1?=
 =?us-ascii?Q?9y2o1u1FsJJqLQvenLaDgwidN4KG22DyuY6L/6QFGKrVEPxWIomKStdWX6xa?=
 =?us-ascii?Q?ATp0LgeqyKRsoJ5HOgY9n5oeT6zmlk+sab4Ya08NHvoEOg9f0ERoe+1MEWhH?=
 =?us-ascii?Q?XQafu95BVu51zeIh1teKHlX7E56Ji2ieOaoO4nmhxhkBdYTG1Ua/Vsboge9/?=
 =?us-ascii?Q?UiQDx35fx3ukXCqRmL+Zou7igWEUXmhnHZLyDJf9xSk1r2Mx90kQQk0jFhTO?=
 =?us-ascii?Q?UjaaFAQY2U2SSYEbkd73wnxSxcCy+BV0nruCxEa5yf0aX/upO+icI7NjyrmP?=
 =?us-ascii?Q?KfQVFVAx/2MrWWqC7jNzs+sJrSYG3eBdGhFX95UaI3IE6K3xXPb6tOItjJ31?=
 =?us-ascii?Q?jbhCdlMUz2LCk/4ly5n3n+l7dYLITNCQZlIUJN6QKm3blUtY7hwe7llIl0KR?=
 =?us-ascii?Q?Mqc0jO+/8O7iAFL+060De2ed2y82ayOol9fyd1BIaUwhUQAkQnQRvnO8Crlj?=
 =?us-ascii?Q?ggjIKf8292GIimTUZT4TxCqu9sDMsRbKT9Iu+ZMBaE3eFehnG+gfjDaj+XiE?=
 =?us-ascii?Q?jw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?gTgJwKsbanJhaRrKCQ1BgyQSaRQv2xAfTYviuyZfPRBpFp7Euk5Xp7KtZD3g?=
 =?us-ascii?Q?oIzlIjXbK3BVOal3Rap9e/M+iSwvbwTwR3mkKPwMhkBfEivBmYJdjx/wune3?=
 =?us-ascii?Q?l58N8h19Ss20rw1QCennZyF7YWVLS0Pt+MWTr9hj5c6uncN7k0Lok1QJWaPs?=
 =?us-ascii?Q?Fvnz2vBkTlDoOIDgxDtGOwq6n4mpP1X5qb043ykNxI53EoVTrJENL3PRV4wt?=
 =?us-ascii?Q?vAz4fFSKAMSU5YbCxJomq+qRrRoiTmD6OSZzfJvAg1WuajfstF0ijR48/4RJ?=
 =?us-ascii?Q?rIp5BEs8B941tyJCsc2YdXQCvkG1QqK4qJH6srzHuOJ1S2jAaM7P+udPpdhv?=
 =?us-ascii?Q?m2mwRfeV6/87paLezIzqvJ7G8s+M3IZ+0qYHO2vHRhhus1kwlUgRbQsd6gUH?=
 =?us-ascii?Q?1YoM2xXeU8p3vZKRhHk+FDkU2ueVFVM9qp1VbEQ2ZlMEBCtr+bVmGKEFcIYf?=
 =?us-ascii?Q?USGTdD2kcFi5vkNY3aD1gtBsiWuobZbcRGvBUBaNifQn0l7DUSmHVXGu3cly?=
 =?us-ascii?Q?91ZQ7RfQFULUXn7ThKZqblcZV2xmxhkZ0pNCYdZ4K0rXlT4BDEWNT6WHlj/3?=
 =?us-ascii?Q?QiHds8JjxUG6scUaPD/pZ4U74obkavM/pQEjNB3bUcikG7CqzKK/lxMn2OVd?=
 =?us-ascii?Q?aTVqE73N6RO0tRiIzsj3q10plHsRY0qwKaZn6WpqWqBvtFlYuVO47zR6S96k?=
 =?us-ascii?Q?yJukqK/kn3sngVLGux3mqexMxzD5xTn8E+HshPj/UZlmd1+YW5kRF+sorrau?=
 =?us-ascii?Q?yAZsXSRhAp5vSfT9GdKXQ+GgW3SeOUqRGY1ToeNTr9p5EgTLm19f9slyDH0q?=
 =?us-ascii?Q?Sa611R0vxY3IOjOa3/TVCw67gx+u8U8n5x/lLk0IpdEF6b+87wCYOBOP33u6?=
 =?us-ascii?Q?2RUbK1SsihReH9YNGew7Fs0PBvHUXCSG4H5AYVIXk85wsBmguweJVMw8N8Vu?=
 =?us-ascii?Q?FBnpU37mRexY8ATnt9jB68g8HQJ/s3OpNenVlJ4CkQ3Q7jSQ4IZWkJ0ihTr/?=
 =?us-ascii?Q?U7XhkWpEK958HLOOBQqTr8GpfxFCYja/x7ETyUrJXwIG0hLj2lAfIcOJ1Pgb?=
 =?us-ascii?Q?QL7ZfQoDvJN+fdb/zGWryuRRd3GL2tZ90F2VSb2fMj34zK+hz+SXtbknCVdO?=
 =?us-ascii?Q?/GcuAlJhfTpEi0CTINvRVWE2nmaLVY35mbgDUIozTVIOx8TlN3dIhovEPpYI?=
 =?us-ascii?Q?O8y5OJgHqizB/SIk?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c4f069-2e88-4c37-0167-08dbd04b85ce
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 02:31:39.1280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /DIjKm6n+/qZUGSFLQpWEi6l34Opv7w9oG5bGqxbbFYQmN2mue9LDJzXbdnZKP3vt7Jt5DPIgVviAbMCi0DkAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7123
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_02,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310190019
X-Proofpoint-GUID: jCP4Z08mt3Ti3JgrqwfzBLSAnPG0v9FG
X-Proofpoint-ORIG-GUID: jCP4Z08mt3Ti3JgrqwfzBLSAnPG0v9FG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the internal hugetlb restore vmemmap code path such that TLB
flushing can be batched.  Use the existing mechanism of passing the
VMEMMAP_REMAP_NO_TLB_FLUSH flag to indicate flushing should not be
performed for individual pages.  The routine hugetlb_vmemmap_restore_folios
is the only user of this new mechanism, and it will perform a global
flush after all vmemmap is restored.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb_vmemmap.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 9df350372046..d2999c303031 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -461,18 +461,19 @@ static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
  * @end:	end address of the vmemmap virtual address range that we want to
  *		remap.
  * @reuse:	reuse address.
+ * @flags:	modifications to vmemmap_remap_walk flags
  *
  * Return: %0 on success, negative error code otherwise.
  */
 static int vmemmap_remap_alloc(unsigned long start, unsigned long end,
-			       unsigned long reuse)
+			       unsigned long reuse, unsigned long flags)
 {
 	LIST_HEAD(vmemmap_pages);
 	struct vmemmap_remap_walk walk = {
 		.remap_pte	= vmemmap_restore_pte,
 		.reuse_addr	= reuse,
 		.vmemmap_pages	= &vmemmap_pages,
-		.flags		= 0,
+		.flags		= flags,
 	};
 
 	/* See the comment in the vmemmap_remap_free(). */
@@ -494,17 +495,7 @@ EXPORT_SYMBOL(hugetlb_optimize_vmemmap_key);
 static bool vmemmap_optimize_enabled = IS_ENABLED(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON);
 core_param(hugetlb_free_vmemmap, vmemmap_optimize_enabled, bool, 0);
 
-/**
- * hugetlb_vmemmap_restore - restore previously optimized (by
- *			     hugetlb_vmemmap_optimize()) vmemmap pages which
- *			     will be reallocated and remapped.
- * @h:		struct hstate.
- * @head:	the head page whose vmemmap pages will be restored.
- *
- * Return: %0 if @head's vmemmap pages have been reallocated and remapped,
- * negative error code otherwise.
- */
-int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
+static int __hugetlb_vmemmap_restore(const struct hstate *h, struct page *head, unsigned long flags)
 {
 	int ret;
 	unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
@@ -525,7 +516,7 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
 	 * When a HugeTLB page is freed to the buddy allocator, previously
 	 * discarded vmemmap pages must be allocated and remapping.
 	 */
-	ret = vmemmap_remap_alloc(vmemmap_start, vmemmap_end, vmemmap_reuse);
+	ret = vmemmap_remap_alloc(vmemmap_start, vmemmap_end, vmemmap_reuse, flags);
 	if (!ret) {
 		ClearHPageVmemmapOptimized(head);
 		static_branch_dec(&hugetlb_optimize_vmemmap_key);
@@ -534,6 +525,21 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
 	return ret;
 }
 
+/**
+ * hugetlb_vmemmap_restore - restore previously optimized (by
+ *				hugetlb_vmemmap_optimize()) vmemmap pages which
+ *				will be reallocated and remapped.
+ * @h:		struct hstate.
+ * @head:	the head page whose vmemmap pages will be restored.
+ *
+ * Return: %0 if @head's vmemmap pages have been reallocated and remapped,
+ * negative error code otherwise.
+ */
+int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
+{
+	return __hugetlb_vmemmap_restore(h, head, 0);
+}
+
 /**
  * hugetlb_vmemmap_restore_folios - restore vmemmap for every folio on the list.
  * @h:			hstate.
@@ -557,7 +563,8 @@ long hugetlb_vmemmap_restore_folios(const struct hstate *h,
 
 	list_for_each_entry_safe(folio, t_folio, folio_list, lru) {
 		if (folio_test_hugetlb_vmemmap_optimized(folio)) {
-			ret = hugetlb_vmemmap_restore(h, &folio->page);
+			ret = __hugetlb_vmemmap_restore(h, &folio->page,
+						VMEMMAP_REMAP_NO_TLB_FLUSH);
 			if (ret)
 				break;
 			restored++;
@@ -567,6 +574,8 @@ long hugetlb_vmemmap_restore_folios(const struct hstate *h,
 		list_move(&folio->lru, non_hvo_folios);
 	}
 
+	if (restored)
+		flush_tlb_all();
 	if (!ret)
 		ret = restored;
 	return ret;
-- 
2.41.0

