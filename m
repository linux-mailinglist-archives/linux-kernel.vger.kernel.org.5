Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3F677FDAB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 20:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354356AbjHQSUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 14:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354231AbjHQST3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 14:19:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1AB2D59
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:19:27 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37HI4TVG027140;
        Thu, 17 Aug 2023 18:18:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=PmB4YNJlEHSD2bWMABX8JeG/Mxxgg1r08XHXBeI0pZc=;
 b=kZMNUQPmTH4ZU/MB2OSjp/KPHGYt+TuXblcJKxM+7k+hPDqwBGrGQNj/0Nh91/UM0eS8
 lmhcxjn0oTtbdDF8r75XyVASNeJD2/U747ev2baAaPR+P9yUpQO8IVyKSqFJ+YO9xppF
 z8eldHZH0s4MoZfQ832rq7ojDE3WRVqLjHPovPrg/mVFjh0PqfSFMoPOVt/xHRtCtqIn
 uIrqaYxkrZzbxefsD6SvJSzuqT/eaXoxobE0IYfR1m+Y6ldcOS1SduV9Zxp+tVHC0c7x
 MwQyTsWnI7MhY0K+vqxuiAdhrWt34gLdKqNZ7fWRCsWz5ZnB7DLaMfXpw2L0jONa8rVv 4g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se349j8cq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 18:18:52 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37HIHZj1003669;
        Thu, 17 Aug 2023 18:18:51 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sexymymcv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 18:18:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4zypUaLCy8uQ9SQaTDJC2OA0hWxwFmi+SU/k9vqUHkZwr3w4j4jIAulg4phfEN2Up3CnU5r8hkUbkMaiCr9eq8brUjen7+AOC74eeodGz4XwBAbJx04C78cje2Bo50A0ECGRagdn6qbMUzBgmsWypmd/+3iDJiuVz7rPfb9bDBMSDxjiY1ZOrORrakTlfArD7LuzaO0a1ZZz7ONaYLNjnWbo5XJUIljutCqnVJni6/Z/qNPmcSa9ts7YNDr0rMFnBEz+fXp/FMhppnCrANwN/g6EvYUP1Xi2/6abbuirnPbJdcp5zWyfKx32LtAcPCel0iTzLwYvmBacy4Myebqsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PmB4YNJlEHSD2bWMABX8JeG/Mxxgg1r08XHXBeI0pZc=;
 b=ZNfAFv5f+YoBggGjLdVvTGYYCu0T/YYTad5Xthb5NXbN6ez6++w+T4kdTeUKHoWHlYW3r8AhiW/wv7lrEMTo6aJI7k9S15hyku0vUqz26eEhWzLLyEWsiWD6LkoQYTapjSDDwMdmZq3zglYpM02qa055pXlWvp0OLFJ6HuJzdrM/IsVeFSkp9fu8PbTd+MfIHfy6ElWh8FGoFsKlj2YqHUpd9r0l3n2mXKVvQXxMmNr5PcYpdgdtOnroMa0m6SYltPT9oQCErytUEX91MIJOxoUqxEwK2pJBmqk6/xRinzuiax8azz/w7owyAkHpdnch4MEa1Q2ajrirzMVOFRzdLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmB4YNJlEHSD2bWMABX8JeG/Mxxgg1r08XHXBeI0pZc=;
 b=HdZOcQG41FxZyvW8olbRSR1Qy4ZtE3jGJSutF2cvkPyyWeGnwuAJY7YOF4daVZr3S6nxsvi/eTzDNv/UekvVJQYxNYDQiKDVNQm2mJCyr9xXz/pmqYRYM6wJl/qlUKNfJCGOCmoImwrrUPDVLp7K2y8xXhMTBV+Q+ByVhJM4N9M=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DM4PR10MB7449.namprd10.prod.outlook.com (2603:10b6:8:17e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Thu, 17 Aug
 2023 18:18:45 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::6bff:7715:4210:1e52]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::6bff:7715:4210:1e52%7]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 18:18:44 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v6] mm/filemap: remove hugetlb special casing in filemap.c
Date:   Thu, 17 Aug 2023 11:18:36 -0700
Message-ID: <20230817181836.103744-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0170.namprd05.prod.outlook.com
 (2603:10b6:a03:339::25) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|DM4PR10MB7449:EE_
X-MS-Office365-Filtering-Correlation-Id: de2382f2-93cf-4e3a-a4a0-08db9f4e6476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +TZvM+3gh7YWw9M36VGTpqMYfgXfjsOjWfO30BYznDad+PVBK1c1qVzRO/4Eqvha0dKHhalH01a2uIWoc2SJ19CO5/EfOBKY5KP/jYI8oS0cbuuPdGI80nWab9CbcbOKdL2qAC3+GhM5jnuICQ96rKQ0ZJ4REHnkEVTTfx6/13RhzXioQpl1y1jQqNedAuzJTvDxk/o5uzwSHrV2ehCAuyM/IuvxLL1Hr9RwK7N/eHc7Km2/QM3+7m2I9DztjZwaSaxuDaf/VDq1rwDhQN58sAoFJbb5FD8zwAOTufoAb+gQpLOVWmILnxlSo1965zLkNCJwelcBglTsHDaHmsNI3XCBgKwIAqVBl6DDKXrbofddJphf+VAO5TfHwxlmbM3ICQdhN8KqgHE59wgXxypyo56xaY1NMwzHLrV531Bq98jtHEmn5T/oxfXrh1du4COF2LmKBDPAMDgWbQtadYhrhFaYy/0JdRn9EMnuwogUqJC9NjM1NXW3eZ64QAPSyoQ+NgzxWMFY0KMPlOv2XNO0g9Uh3VSlqDj5DdsDm/kXtMJ0Y6r9ASnkxS9h+6Nb/WGwBqXxIxlfhQudSZbcq49ZNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199024)(1800799009)(186009)(36756003)(86362001)(8936002)(4326008)(5660300002)(8676002)(2906002)(30864003)(41300700001)(1076003)(6486002)(6506007)(6666004)(2616005)(107886003)(44832011)(6512007)(83380400001)(66899024)(478600001)(316002)(966005)(66946007)(66556008)(66476007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?abwCskh7KjB8O+cs52Fyv3DuxBgwFfjX9ekfrhWA+rWQX+4ME29b6T7pYYHs?=
 =?us-ascii?Q?RaC8joExG7ok+1k/GY4QqFcgVhqqpLrxRueCCuIQBbVSeOnODeuNz0YD+yMr?=
 =?us-ascii?Q?nZAYsltQj319pj61hQYr/3j8N/zfS44B4hVG8Bpp6acZgGiSR4RWM2vR7ORG?=
 =?us-ascii?Q?TPiJXtrtOZ7a7xh7bw4BLKVgFbNo5poNXbYehn9yzggC6jbo3TmD+pxGEZpe?=
 =?us-ascii?Q?IgBDXFbqXUZYltdADOr1FN2OO+nMfRq+TlOyGtDiMeL9+1ttS2P4vQkogAej?=
 =?us-ascii?Q?FWThxEBthfeNrmQWx35UInYG1WhnAZwIFRXxeeVU4K6MAv2TaPej9MG/7C+H?=
 =?us-ascii?Q?vKGmLttOSoZsyRJW97TXakloW+M0rOQ0TPeIJmV8dUXQzORanNQgX97MDGct?=
 =?us-ascii?Q?DYwsKawia3Aw1wgvz2JXzH6CW1NifAX+KdGs1ZWpEMTvqVW+FScoocPwxFf7?=
 =?us-ascii?Q?/gWyXkcGqWkKhc1qH9DebtXxJkPrM2XTdSmdxbR6UyyoWttmcoRSyxlNfGtl?=
 =?us-ascii?Q?vinfuvaJF6Bjxfx9K0LMPzbh0lhstWCeq643VjVXRLZGcn8WmrWXqvIuWPqx?=
 =?us-ascii?Q?NtwxnZO+2zykecVPoTNy5aqBH3MOFklINqVCQeABioNPWn7UIPMJGhnXZzW9?=
 =?us-ascii?Q?79eifDAaTQDGGmohpnij/Itx95HtlFKJ1F37qyqx9Vcmobqhr9jDPjE430zw?=
 =?us-ascii?Q?hJ4utouIwNgW5g1ZLnV8Fuixf4PLIttp7JuWKZL+h9m8uV+l2Kiv4N35yuOZ?=
 =?us-ascii?Q?bz4KQ//Kfq1ILNgQNwVALXf8QtxeHX2heCNL1QR06sPWlaG05311xJFzxBjf?=
 =?us-ascii?Q?MDcAzzAZzAfOYPpfZIeps+trZc3KTLVvMc1UdG63AFiK3PipwsKCHF/kZ7Wz?=
 =?us-ascii?Q?VW41fGJSxQ9rS1tO6dKq0D9P80+i8SVzkBfCXxe/6kDY5tjRWNo2X/9MP9tD?=
 =?us-ascii?Q?KbNQmYDnoSn70XpRGMG5ae+s5DExaNguijf7wlvaFJ++Rxd6sIZjSJHL10AV?=
 =?us-ascii?Q?LNegqBQaWleFzOwz2SWIZ7PhgWvr9yX+1Irmhq0BCva+JTzOrNJAy/OvR4QC?=
 =?us-ascii?Q?17Iv/UWQuSs6TxmzyzYLfs265+OAjSfLAjGXMIGx67aCDt8o/Qx7nTjvF7v/?=
 =?us-ascii?Q?dYik6CxX0mSjXI7GSdWxQW+WhULiTdS+XHIcZr+O0SXqlVU9ORi13aHHdyuj?=
 =?us-ascii?Q?rZ4TmfHHHdJ+M1NjnDK3JvtR/GU/y8SX7qTckpzmsQcwvPAt+6xwkB+oXb7B?=
 =?us-ascii?Q?4wkmqkKrKN69SdwYMr413bt5UFHzEBvQSkwms+gtXquKnads3coBXClhs4SN?=
 =?us-ascii?Q?i11I1VNaufg4EqQlLgfkQM1+QSRaXt5bmCUcTTamvHtjgu3zy72m9jzDImNG?=
 =?us-ascii?Q?FsZKvDt9LclDvD7KBGtfWIhH9vtdRXpi5MCdoVfKJ+GOVujyxLyLf085o+h/?=
 =?us-ascii?Q?Ja5bByVqQ2NjAnEHnQ+wBzzqdHVzuyHQb0+ZS0KHpNEl6cuoM/G8m8fP1rmx?=
 =?us-ascii?Q?BEZfCkalv7vHJn7b6RRZ94Uf+S9zKRdUKBqWaoYb6EVO3HGNn6+KY7wH8G7V?=
 =?us-ascii?Q?oNnstMuK0k2nT/275OzHRcqcN9wuWTZvShIdiuhLqyvpMQTunSdTBka3dr4d?=
 =?us-ascii?Q?e05qZDciKqM+OfImuLyb/Z0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kzw/B6NebeeCyqgdmtfRNtdLr4LbDJ+rH3zeM3HvYB8o8AP6IqVEJvoj4qE/BJ6qtacg3rN/8Atn5X3MYHy6vMkvUv/nGTT9WoquwhEtjQZxkGokuTuoOmQjdJtfOJeO+Y7g81onJ4XO29e2yzBt/B9gILYbGd725fqoHzFZE1xo4ESHOWX2qxwxa4VXA74k5mWA3/gCqmTMsVrf7cDPaA4FPIHs6Crdt1Mque9g9fsPNUrI9+8YY+Fapg5o3rwxFrs1aMmq5s7so6ASgbcV1dl5tPFbXvlWrgmYnWvnNLHD5av3jIGsp0wGv0xaa6UwzocTM4RH8vnR6cCSm7GRtaO3Cm9fOPi9HkoRtUM4dsySivzwSl51m5L4tDB4/9ceeh5ARDrzPAcKAbL8/17mpGgcauDHGKV/aNumo4VKPCSg/Ky9aJf1Es1d+OOoGhLemTtNrq9d1hkqGRoEg+bj3XkSN+1jK40h6K/GrkgAdruMqfxOg6/6R/2Mdl15ZEICjt4H05kLJCzd/j4H6PR1NUvafRqu/1wf8ndmRw/LtdG0DqNQH7RMLqlpuI4zVRyKJYuh4ve521Fl/tyNSvX17665kgzqc2fJukcMGb83nK605FwFx743I7lluMDHV1v8PPOleH7bqlOcnfrkt4iKVezZPOf+MdiN0w21RA4bjfuAaOCzUlSkyvgicn41+tA8SilzJZxMhSpjXt0bQFwxZIN3++0FiYWcNg3kerUjMqROc0a0eMahdkn+2br3e4XbRcqNCrsC4S5lQIIKnmH3MLjonwXxMLxqt9Sp3DaSe0vev2KEiAGb1NHWr/js8OlYf+eesijD6NOdp0JuKqT4Zdjji9bOpvOJXOgiTh29wrKS6HOrRUjPDjSh0yFDWZeiE+jUl0H2jpC+2P5ph7D8jfoEEpyPKG8QKxTnHlFwlLI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de2382f2-93cf-4e3a-a4a0-08db9f4e6476
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 18:18:44.7279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1LWXRGydmjYAhTA2jnnJxn4msE0aLYlvZ60EM7maIThx8hqK+4Xqsty8EEgNsCKv5qIIfVyfqZ9Q9q2CDIOnDiyEHbOzFLiZ05KuWKMVbyY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7449
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-17_13,2023-08-17_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308170165
X-Proofpoint-GUID: hi4FhKPzSnFbnUTGcwbrPsAbSByznUyW
X-Proofpoint-ORIG-GUID: hi4FhKPzSnFbnUTGcwbrPsAbSByznUyW
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove special cased hugetlb handling code within the page cache by
changing the granularity of each index to the base page size rather than
the huge page size. Adds new wrappers for hugetlb code to to interact with the
page cache which convert to a linear index.

========================= PERFORMANCE ======================================

Perf was used to check the performance differences after the patch. Overall
the performance is similar to mainline with a very small larger overhead that
occurs in __filemap_add_folio() and hugetlb_add_to_page_cache(). This is because
of the larger overhead that occurs in xa_load() and xa_store() as the
xarray is now using more entries to store hugetlb folios in the page cache.

Timing

aarch64
    2MB Page Size
        6.5-rc3 + this patch:
            [root@sidhakum-ol9-1 hugepages]# time fallocate -l 700GB test.txt
            real    1m49.568s
            user    0m0.000s
            sys     1m49.461s

        6.5-rc3:
            [root]# time fallocate -l 700GB test.txt
            real    1m47.495s
            user    0m0.000s
            sys     1m47.370s  
    1GB Page Size
        6.5-rc3 + this patch:
            [root@sidhakum-ol9-1 hugepages1G]# time fallocate -l 700GB test.txt
            real    1m47.024s
            user    0m0.000s
            sys     1m46.921s

        6.5-rc3:
            [root@sidhakum-ol9-1 hugepages1G]# time fallocate -l 700GB test.txt
            real    1m44.551s
            user    0m0.000s
            sys     1m44.438s

x86
    2MB Page Size
        6.5-rc3 + this patch:
            [root@sidhakum-ol9-2 hugepages]# time fallocate -l 100GB test.txt
            real    0m22.383s
            user    0m0.000s
            sys     0m22.255s

        6.5-rc3:
            [opc@sidhakum-ol9-2 hugepages]$ time sudo fallocate -l 100GB /dev/hugepages/test.txt
            real    0m22.735s
            user    0m0.038s
            sys     0m22.567s

    1GB Page Size
        6.5-rc3 + this patch:
            [root@sidhakum-ol9-2 hugepages1GB]# time fallocate -l 100GB test.txt
            real    0m25.786s
            user    0m0.001s
            sys     0m25.589s

        6.5-rc3:
            [root@sidhakum-ol9-2 hugepages1G]# time fallocate -l 100GB test.txt
            real    0m33.454s
            user    0m0.001s
            sys     0m33.193s


aarch64:
    workload - fallocate a 700GB file backed by huge pages 
    
    6.5-rc3 + this patch:
        2MB Page Size:
            --100.00%--__arm64_sys_fallocate
                          ksys_fallocate
                          vfs_fallocate
                          hugetlbfs_fallocate
                          |          
                          |--95.04%--__pi_clear_page
                          |          
                          |--3.57%--clear_huge_page
                          |          |          
                          |          |--2.63%--rcu_all_qs
                          |          |          
                          |           --0.91%--__cond_resched
                          |          
                           --0.67%--__cond_resched
            0.17%     0.00%             0  fallocate  [kernel.vmlinux]       [k] hugetlb_add_to_page_cache
            0.14%     0.10%            11  fallocate  [kernel.vmlinux]       [k] __filemap_add_folio

    6.5-rc3
        2MB Page Size:
                --100.00%--__arm64_sys_fallocate
                          ksys_fallocate
                          vfs_fallocate
                          hugetlbfs_fallocate
                          |          
                          |--94.91%--__pi_clear_page
                          |          
                          |--4.11%--clear_huge_page
                          |          |          
                          |          |--3.00%--rcu_all_qs
                          |          |          
                          |           --1.10%--__cond_resched
                          |          
                           --0.59%--__cond_resched
            0.08%     0.01%             1  fallocate  [kernel.kallsyms]  [k] hugetlb_add_to_page_cache
            0.05%     0.03%             3  fallocate  [kernel.kallsyms]  [k] __filemap_add_folio

x86
    workload - fallocate a 100GB file backed by huge pages 
    
    6.5-rc3 + this patch:
        2MB Page Size:
            hugetlbfs_fallocate
            |          
            --99.57%--clear_huge_page
                |          
                --98.47%--clear_page_erms
                    |          
                    --0.53%--asm_sysvec_apic_timer_interrupt
                
            0.04%     0.04%             1  fallocate  [kernel.kallsyms]     [k] xa_load
            0.04%     0.00%             0  fallocate  [kernel.kallsyms]     [k] hugetlb_add_to_page_cache
            0.04%     0.00%             0  fallocate  [kernel.kallsyms]     [k] __filemap_add_folio
            0.04%     0.00%             0  fallocate  [kernel.kallsyms]     [k] xas_store

    6.5-rc3
        2MB Page Size:
                --99.93%--__x64_sys_fallocate
                          vfs_fallocate
                          hugetlbfs_fallocate
                          |          
                           --99.38%--clear_huge_page
                                     |          
                                     |--98.40%--clear_page_erms
                                     |          
                                      --0.59%--__cond_resched
            0.03%     0.03%             1  fallocate  [kernel.kallsyms]  [k] __filemap_add_folio

========================= TESTING ======================================

This patch passes libhugetlbfs tests and LTP hugetlb tests

********** TEST SUMMARY                                                                                                                                                                                                                    
*                      2M                                                                                                                                                                                                                  
*                      32-bit 64-bit                                                                                                                                                                                                       
*     Total testcases:   110    113                                                                                                                                                                                                        
*             Skipped:     0      0                                                                                                                                                                                                        
*                PASS:   107    113                                                                                                                                                                                                        
*                FAIL:     0      0                                                                                                                                                                                                        
*    Killed by signal:     3      0                                                                                                                                                                                                        
*   Bad configuration:     0      0                                                                                                                                                                                                        
*       Expected FAIL:     0      0                                                                                                                                                                                                        
*     Unexpected PASS:     0      0                                                                                                                                                                                                        
*    Test not present:     0      0                                                                                                                                                                                                        
* Strange test result:     0      0                                                                                                                                                                                                        
**********

###############################################################                                                                                                                                                                                                                                                                                                                                                                                                           
    Done executing testcases.                                                                                                                                                                                                      
    LTP Version:  20220527-178-g2761a81c4                                                                                                                                                                                          
###############################################################

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

---

rebased on mm-unstable 08/14/23

RFC v2[1] -> v1[2]
    -change direction of series to maintain both huge and base page size index
     rather than try to get rid of all references to a huge page sized index.

v1 -> v2[3]
    - squash seperate filemap and hugetlb changes into one patch to allow
      for bisection per Matthew
    - get rid of page_to_index()
    - fix errors in hugetlb_fallocate() and remove_inode_hugepages()

v2 -> v3[4]
    - gather performance data per Mike Kravetz
    - remove start variable in remove_inode_hugepages() per Mike Kravetz
    - remove hugetlb special case within folio_file_page()

v3 -> v4[5]
    - rebase to current mm-unstable
    - include time data per Mike Kravetz

v4 -> v5[6]
	- fix build issue by removing hugetlb_basepage_index() definition 
	   per intel test robot

v5 -> v6
	- remove folio_more_pages() from result of incorrect rebase

[1]: https://lore.kernel.org/linux-mm/20230519220142.212051-1-sidhartha.kumar@oracle.com/T/
[2]: https://lore.kernel.org/lkml/20230609194947.37196-1-sidhartha.kumar@oracle.com/
[3]: https://lore.kernel.org/lkml/ZLtVlJA+V2+2yjxc@casper.infradead.org/T/
[4]: https://lore.kernel.org/lkml/20230811233939.GA105247@monkey/T/
[5]: https://lore.kernel.org/linux-mm/202308151231.L2pfzOmu-lkp@intel.com/T/#t
[6]: https://lore.kernel.org/linux-mm/20230815191932.273054-1-sidhartha.kumar@oracle.com/T/

 fs/hugetlbfs/inode.c    | 15 ++++++++-------
 include/linux/hugetlb.h | 12 ++++++++++++
 include/linux/pagemap.h | 29 ++---------------------------
 mm/filemap.c            | 34 ++++++++++------------------------
 mm/hugetlb.c            | 25 ++++++-------------------
 5 files changed, 38 insertions(+), 77 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index e7611ae1e612..ec0f856a1228 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -661,21 +661,20 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 {
 	struct hstate *h = hstate_inode(inode);
 	struct address_space *mapping = &inode->i_data;
-	const pgoff_t start = lstart >> huge_page_shift(h);
-	const pgoff_t end = lend >> huge_page_shift(h);
+	const pgoff_t end = lend >> PAGE_SHIFT;
 	struct folio_batch fbatch;
 	pgoff_t next, index;
 	int i, freed = 0;
 	bool truncate_op = (lend == LLONG_MAX);
 
 	folio_batch_init(&fbatch);
-	next = start;
+	next = lstart >> PAGE_SHIFT;
 	while (filemap_get_folios(mapping, &next, end - 1, &fbatch)) {
 		for (i = 0; i < folio_batch_count(&fbatch); ++i) {
 			struct folio *folio = fbatch.folios[i];
 			u32 hash = 0;
 
-			index = folio->index;
+			index = folio->index >> huge_page_order(h);
 			hash = hugetlb_fault_mutex_hash(mapping, index);
 			mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
@@ -693,7 +692,9 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 	}
 
 	if (truncate_op)
-		(void)hugetlb_unreserve_pages(inode, start, LONG_MAX, freed);
+		(void)hugetlb_unreserve_pages(inode,
+				lstart >> huge_page_shift(h),
+				LONG_MAX, freed);
 }
 
 static void hugetlbfs_evict_inode(struct inode *inode)
@@ -741,7 +742,7 @@ static void hugetlbfs_zero_partial_page(struct hstate *h,
 	pgoff_t idx = start >> huge_page_shift(h);
 	struct folio *folio;
 
-	folio = filemap_lock_folio(mapping, idx);
+	folio = filemap_lock_hugetlb_folio(h, mapping, idx);
 	if (IS_ERR(folio))
 		return;
 
@@ -886,7 +887,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
 		/* See if already present in mapping to avoid alloc/free */
-		folio = filemap_get_folio(mapping, index);
+		folio = filemap_get_folio(mapping, index << huge_page_order(h));
 		if (!IS_ERR(folio)) {
 			folio_put(folio);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 0a393bc02f25..1bb3fcacdcdd 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -811,6 +811,12 @@ static inline unsigned int blocks_per_huge_page(struct hstate *h)
 	return huge_page_size(h) / 512;
 }
 
+static inline struct folio *filemap_lock_hugetlb_folio(struct hstate *h,
+				struct address_space *mapping, pgoff_t idx)
+{
+	return filemap_lock_folio(mapping, idx << huge_page_order(h));
+}
+
 #include <asm/hugetlb.h>
 
 #ifndef is_hugepage_only_range
@@ -1005,6 +1011,12 @@ static inline struct hugepage_subpool *hugetlb_folio_subpool(struct folio *folio
 	return NULL;
 }
 
+static inline struct folio *filemap_lock_hugetlb_folio(struct hstate *h,
+				struct address_space *mapping, pgoff_t idx)
+{
+	return NULL;
+}
+
 static inline int isolate_or_dissolve_huge_page(struct page *page,
 						struct list_head *list)
 {
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 71dd79b4ae0a..6816d3ccbd7e 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -729,9 +729,6 @@ static inline pgoff_t folio_next_index(struct folio *folio)
  */
 static inline struct page *folio_file_page(struct folio *folio, pgoff_t index)
 {
-	/* HugeTLBfs indexes the page cache in units of hpage_size */
-	if (folio_test_hugetlb(folio))
-		return &folio->page;
 	return folio_page(folio, index & (folio_nr_pages(folio) - 1));
 }
 
@@ -747,9 +744,6 @@ static inline struct page *folio_file_page(struct folio *folio, pgoff_t index)
  */
 static inline bool folio_contains(struct folio *folio, pgoff_t index)
 {
-	/* HugeTLBfs indexes the page cache in units of hpage_size */
-	if (folio_test_hugetlb(folio))
-		return folio->index == index;
 	return index - folio_index(folio) < folio_nr_pages(folio);
 }
 
@@ -807,10 +801,9 @@ static inline struct folio *read_mapping_folio(struct address_space *mapping,
 }
 
 /*
- * Get index of the page within radix-tree (but not for hugetlb pages).
- * (TODO: remove once hugetlb pages will have ->index in PAGE_SIZE)
+ * Get the offset in PAGE_SIZE (even for hugetlb pages).
  */
-static inline pgoff_t page_to_index(struct page *page)
+static inline pgoff_t page_to_pgoff(struct page *page)
 {
 	struct page *head;
 
@@ -825,19 +818,6 @@ static inline pgoff_t page_to_index(struct page *page)
 	return head->index + page - head;
 }
 
-extern pgoff_t hugetlb_basepage_index(struct page *page);
-
-/*
- * Get the offset in PAGE_SIZE (even for hugetlb pages).
- * (TODO: hugetlb pages should have ->index in PAGE_SIZE)
- */
-static inline pgoff_t page_to_pgoff(struct page *page)
-{
-	if (unlikely(PageHuge(page)))
-		return hugetlb_basepage_index(page);
-	return page_to_index(page);
-}
-
 /*
  * Return byte-offset into filesystem object for page.
  */
@@ -874,12 +854,9 @@ static inline loff_t folio_file_pos(struct folio *folio)
 
 /*
  * Get the offset in PAGE_SIZE (even for hugetlb folios).
- * (TODO: hugetlb folios should have ->index in PAGE_SIZE)
  */
 static inline pgoff_t folio_pgoff(struct folio *folio)
 {
-	if (unlikely(folio_test_hugetlb(folio)))
-		return hugetlb_basepage_index(&folio->page);
 	return folio->index;
 }
 
@@ -890,8 +867,6 @@ static inline pgoff_t linear_page_index(struct vm_area_struct *vma,
 					unsigned long address)
 {
 	pgoff_t pgoff;
-	if (unlikely(is_vm_hugetlb_page(vma)))
-		return linear_hugepage_index(vma, address);
 	pgoff = (address - vma->vm_start) >> PAGE_SHIFT;
 	pgoff += vma->vm_pgoff;
 	return pgoff;
diff --git a/mm/filemap.c b/mm/filemap.c
index 014b73eb96a1..94e8d96159bc 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -134,11 +134,8 @@ static void page_cache_delete(struct address_space *mapping,
 
 	mapping_set_update(&xas, mapping);
 
-	/* hugetlb pages are represented by a single entry in the xarray */
-	if (!folio_test_hugetlb(folio)) {
-		xas_set_order(&xas, folio->index, folio_order(folio));
-		nr = folio_nr_pages(folio);
-	}
+	xas_set_order(&xas, folio->index, folio_order(folio));
+	nr = folio_nr_pages(folio);
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 
@@ -237,7 +234,7 @@ void filemap_free_folio(struct address_space *mapping, struct folio *folio)
 	if (free_folio)
 		free_folio(folio);
 
-	if (folio_test_large(folio) && !folio_test_hugetlb(folio))
+	if (folio_test_large(folio))
 		refs = folio_nr_pages(folio);
 	folio_put_refs(folio, refs);
 }
@@ -858,14 +855,15 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 
 	if (!huge) {
 		int error = mem_cgroup_charge(folio, NULL, gfp);
-		VM_BUG_ON_FOLIO(index & (folio_nr_pages(folio) - 1), folio);
 		if (error)
 			return error;
 		charged = true;
-		xas_set_order(&xas, index, folio_order(folio));
-		nr = folio_nr_pages(folio);
 	}
 
+	VM_BUG_ON_FOLIO(index & (folio_nr_pages(folio) - 1), folio);
+	xas_set_order(&xas, index, folio_order(folio));
+	nr = folio_nr_pages(folio);
+
 	gfp &= GFP_RECLAIM_MASK;
 	folio_ref_add(folio, nr);
 	folio->mapping = mapping;
@@ -2038,7 +2036,7 @@ unsigned find_get_entries(struct address_space *mapping, pgoff_t *start,
 		int idx = folio_batch_count(fbatch) - 1;
 
 		folio = fbatch->folios[idx];
-		if (!xa_is_value(folio) && !folio_test_hugetlb(folio))
+		if (!xa_is_value(folio))
 			nr = folio_nr_pages(folio);
 		*start = indices[idx] + nr;
 	}
@@ -2102,7 +2100,7 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
 		int idx = folio_batch_count(fbatch) - 1;
 
 		folio = fbatch->folios[idx];
-		if (!xa_is_value(folio) && !folio_test_hugetlb(folio))
+		if (!xa_is_value(folio))
 			nr = folio_nr_pages(folio);
 		*start = indices[idx] + nr;
 	}
@@ -2143,9 +2141,6 @@ unsigned filemap_get_folios(struct address_space *mapping, pgoff_t *start,
 			continue;
 		if (!folio_batch_add(fbatch, folio)) {
 			unsigned long nr = folio_nr_pages(folio);
-
-			if (folio_test_hugetlb(folio))
-				nr = 1;
 			*start = folio->index + nr;
 			goto out;
 		}
@@ -2211,9 +2206,6 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
 
 		if (!folio_batch_add(fbatch, folio)) {
 			nr = folio_nr_pages(folio);
-
-			if (folio_test_hugetlb(folio))
-				nr = 1;
 			*start = folio->index + nr;
 			goto out;
 		}
@@ -2230,10 +2222,7 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
 
 	if (nr) {
 		folio = fbatch->folios[nr - 1];
-		if (folio_test_hugetlb(folio))
-			*start = folio->index + 1;
-		else
-			*start = folio_next_index(folio);
+		*start = folio->index + folio_nr_pages(folio);
 	}
 out:
 	rcu_read_unlock();
@@ -2271,9 +2260,6 @@ unsigned filemap_get_folios_tag(struct address_space *mapping, pgoff_t *start,
 			continue;
 		if (!folio_batch_add(fbatch, folio)) {
 			unsigned long nr = folio_nr_pages(folio);
-
-			if (folio_test_hugetlb(folio))
-				nr = 1;
 			*start = folio->index + nr;
 			goto out;
 		}
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e327a5a7602c..dfd5bc63e61a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -952,7 +952,7 @@ static long region_count(struct resv_map *resv, long f, long t)
 
 /*
  * Convert the address within this vma to the page offset within
- * the mapping, in pagecache page units; huge pages here.
+ * the mapping, huge page units here.
  */
 static pgoff_t vma_hugecache_offset(struct hstate *h,
 			struct vm_area_struct *vma, unsigned long address)
@@ -2113,20 +2113,6 @@ struct address_space *hugetlb_page_mapping_lock_write(struct page *hpage)
 	return NULL;
 }
 
-pgoff_t hugetlb_basepage_index(struct page *page)
-{
-	struct page *page_head = compound_head(page);
-	pgoff_t index = page_index(page_head);
-	unsigned long compound_idx;
-
-	if (compound_order(page_head) > MAX_ORDER)
-		compound_idx = page_to_pfn(page) - page_to_pfn(page_head);
-	else
-		compound_idx = page - page_head;
-
-	return (index << compound_order(page_head)) + compound_idx;
-}
-
 static struct folio *alloc_buddy_hugetlb_folio(struct hstate *h,
 		gfp_t gfp_mask, int nid, nodemask_t *nmask,
 		nodemask_t *node_alloc_noretry)
@@ -5750,7 +5736,7 @@ static bool hugetlbfs_pagecache_present(struct hstate *h,
 			struct vm_area_struct *vma, unsigned long address)
 {
 	struct address_space *mapping = vma->vm_file->f_mapping;
-	pgoff_t idx = vma_hugecache_offset(h, vma, address);
+	pgoff_t idx = linear_page_index(vma, address);
 	struct folio *folio;
 
 	folio = filemap_get_folio(mapping, idx);
@@ -5767,6 +5753,7 @@ int hugetlb_add_to_page_cache(struct folio *folio, struct address_space *mapping
 	struct hstate *h = hstate_inode(inode);
 	int err;
 
+	idx <<= huge_page_order(h);
 	__folio_set_locked(folio);
 	err = __filemap_add_folio(mapping, folio, idx, GFP_KERNEL, NULL);
 
@@ -5874,7 +5861,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	 * before we get page_table_lock.
 	 */
 	new_folio = false;
-	folio = filemap_lock_folio(mapping, idx);
+	folio = filemap_lock_hugetlb_folio(h, mapping, idx);
 	if (IS_ERR(folio)) {
 		size = i_size_read(mapping->host) >> huge_page_shift(h);
 		if (idx >= size)
@@ -6183,7 +6170,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		/* Just decrements count, does not deallocate */
 		vma_end_reservation(h, vma, haddr);
 
-		pagecache_folio = filemap_lock_folio(mapping, idx);
+		pagecache_folio = filemap_lock_hugetlb_folio(h, mapping, idx);
 		if (IS_ERR(pagecache_folio))
 			pagecache_folio = NULL;
 	}
@@ -6315,7 +6302,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 
 	if (is_continue) {
 		ret = -EFAULT;
-		folio = filemap_lock_folio(mapping, idx);
+		folio = filemap_lock_hugetlb_folio(h, mapping, idx);
 		if (IS_ERR(folio))
 			goto out;
 		folio_in_pagecache = true;
-- 
2.41.0

