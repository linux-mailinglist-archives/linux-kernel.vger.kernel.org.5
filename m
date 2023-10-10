Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0335B7BFEF4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbjJJOTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbjJJOS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:18:56 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A250C9;
        Tue, 10 Oct 2023 07:18:54 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39ADAAXl028146;
        Tue, 10 Oct 2023 14:18:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=LE4nEUorFob4QdD11pVqcGU/2ozQj4mURy2C8tTDA5I=;
 b=1WmzYeYpd1tjVpriySIPDK7jm3Wmj7JmLE+0VgdvvQeaXoxmtdVnaoIb1604PIBRin7i
 gSqF6ZGWOLWdEskfNRRfhNojJr/NDa4q/qNowEWVXkCy44uoC4q7nEifaExgqCXQG2LG
 10XVcmqfyapMx0Hh0uO/9UnrTxeJnbG2x1aVGQ8PW2jjN+Buhb1EgC72WaDlW70dT5P9
 18+6wuUNAuN6Ril4fdKA/p6vFnmtpIwDgsQ/8kJDRw413PIjkjTTwS0BIYXpBwlcxpN6
 w12O5qH2WzBG/EOO4k0a5WgvuIDs1dHd9UUZDBSuuvhT6IlcTxHu3xM2ucyAgy8eDXSs 5g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tmh89tnuy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 14:18:24 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39AEIMhr016292;
        Tue, 10 Oct 2023 14:18:23 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tjws6x0uf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 14:18:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VxSszYTcLH9oD/MCAR4lLPLllcYla2taCHlxAhHnDWMsWJoEAX75P0JYWSDQEsob4Fc9RMUbBW0f6gfFBMA2w6cEJEM1PDjSGqJtBmr2u6lbo6txw2XcIR/4Q0mDDuL5tbEDwRwFGvcjxC+Orn0g0ZC0WQdTc/IgECNeMItXTYobfavCsS1t5Gly5byvk6FCAnOjYF3hO+wDYiwPqKyjotAPpsfkEiaJpo5LT0ohR0CuhZFuOEuEeXcdQOR9gumPkkfikSShCF24DBikos4GoiGZlBaeWb6FuWCwsyB4H/zA2AnyMLenrzSXH+dvKR+joStoPcfLRu4OihUkyLID3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LE4nEUorFob4QdD11pVqcGU/2ozQj4mURy2C8tTDA5I=;
 b=MLOK0sFywcXWW+2Heewl1w24p8VIGpOXY5/55X7IluPf1amJneSqw/JC0Sz4tcA6+PhKzgFDmncmBhL+oakzGCMfZAiqYrzJ4ossBAEnaKwobzpZ+QfPpmSvO+MsArrqP+QyClDco/PjPghW8qckZ2xQ8KWaj5lvowhHF2Vwydd+kWwZd2m6LOacyNAU/U1v6AEJrfq7ihO4Nx7ryI2W1E8AB7PHDUHvIVBEbHV1c0DEDB/nV+JfAYSgviHqZdyFteEVKPXDHCSj6zSvQJVohdAFTjFn7iVFaUG/AIHOLejoL4HIb/uCSYhIhaToeOZvOnVosA7ThG33DkuS4LgUkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LE4nEUorFob4QdD11pVqcGU/2ozQj4mURy2C8tTDA5I=;
 b=CIBI9VWhBAzCCzyrjVdJn3JTh7ap1TzmP0HtJfFcPLll9yJgbn7phtM9WTANZSroglnQ6rw6HyZ5BxhUpO6a9ysY393JPiV9zE3FN28P8iXDBh/Iz10jgj5jWuvfHLclYyc4V34AHmacLQx0SHNamWKW5Rh8HWgF8dSHqEiaWZ0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL3PR10MB6090.namprd10.prod.outlook.com (2603:10b6:208:3b6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Tue, 10 Oct
 2023 14:17:56 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 14:17:55 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        stable@vger.kernel.org, jason.sim@samsung.com
Subject: [PATCH] maple_tree: Add GFP_KERNEL to allocations in mas_expected_entries()
Date:   Tue, 10 Oct 2023 10:17:37 -0400
Message-Id: <20231010141737.1592866-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0380.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::18) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BL3PR10MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cb36f36-2c3e-49a9-dc3b-08dbc99bb28f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ahWYoTElO/UMLMuaYtlJ+bvG+S1UAJKykZxQvDVRmcamktRr3cS6FvgSRhmxHad/OhYUcq+I2qG5UEopGX1yGh0S1ROVj40E7UysJ37fKOLKf0NEHQGAHGy+LsvRthUoXS8cUDkxJo3vH8DosKsqSOWqspL5tDlYnMfXhHzDS+fyQvQ1qaW87+40b2ld1MtHapXLT4drCF7QHYbcV8568VJlDNGXCGKkihBn7aENMMNH4Wp3mFsz2t+lDGjlCJKyMcMS47VLQE4aTutjgO0/DW9DsEfbL9WcQ7lq3ZvuJwDDRk6mzxzvpC2ygCHCU7S2SFjaJkt3G1ba3kpuWite/Oww7g5njbpfknHaQbu6mJLXVvRvRrQy3reNztiACrB1rw4FnouBmxaOgJFlBHIwKptW/HkE+Dix0aj5runNdFiJVnA5mFCgGy2KexdGGlypkoWdFhBz1PQ071HS8dFZx3DOlfH8YWQLxYM+rhxYFhGGFIViDfZ/EaEOVc/VplFKHZHuf+KMf6Xj+AGFdRIm6V1KG/rMVCy5r54RHAxZYOE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(366004)(136003)(39860400002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6666004)(6506007)(2616005)(1076003)(6512007)(86362001)(36756003)(38100700002)(83380400001)(2906002)(966005)(6486002)(41300700001)(316002)(478600001)(8676002)(8936002)(4326008)(66946007)(26005)(5660300002)(66476007)(66556008)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PEn7rjio4kcSl8UmIbYJNGGcCxICaOC1zg5xAKmV/0kiV5UeTVCC3rsPbGxE?=
 =?us-ascii?Q?TWJAnKm8srgmaLxyZNXe8dRhO0jkoqkjTXhAacpbc+xVPCtAr/Q5MFX8FNmy?=
 =?us-ascii?Q?WLmCbO9Lpbawlv7q/6FMJ4dtcjia5J+pcSqJ0CTfavujkGukzp+3MK1EZqiU?=
 =?us-ascii?Q?JqXaj4COLK9G04pr6P9RxmAJEYmFhZ2WVcQpNTM9KYY4kK2F2qM3sdTYVFNp?=
 =?us-ascii?Q?lMyv5l/roIydIOmML3xruYff1KQJLa1daWh928kmr2MD465mgo+PHHZRJ3TL?=
 =?us-ascii?Q?XekAytz7R/f4EYkc4Wyn5HTzQjExm7UpjBAMyHWeus7yc3flyrduVoxfihvc?=
 =?us-ascii?Q?sXsYXxsl6VFB7Fkx16UFUWZnTH2IXEdxrqNWlrIgIshApB5FlRYOCOYfYApU?=
 =?us-ascii?Q?LC55NLK2o19DCYwRlpIXujNf+EjsLMJZRW/Hk8p43ESfV28eFAK5xlYUcuWS?=
 =?us-ascii?Q?zx95tlhN6J8iFjMKw1mTRKZ/433+5euNeJLwOHSiZw4hvjDSrOP8GEtd6p8b?=
 =?us-ascii?Q?xQUx30dJDmIYauyiBFpOnsepwKqSlLZY1zQL1IcvWQu24+tbAiTQtCFSsGP2?=
 =?us-ascii?Q?ZA+0PjOFvh2BvxnhpXVV3cwtAg6yTXml5pgsXY5lH8sRtgIo0JObDgF2RraU?=
 =?us-ascii?Q?SrGKUyj/xpEv/uEI8X5HnZZuhvlS5DOfIcxzmdsgWwHrLt53nKE+pUnL6VE2?=
 =?us-ascii?Q?Hw45RgfA8YA1FlHHuULO/VvtmlNHIF/3d3nfzhDmJOj8Fo/hiUF4LCarSE8i?=
 =?us-ascii?Q?HK23AAhQidVzu2afr5nD4rYVubj+mdo8UzeSKmm7Yd5PiRcZVSfSdW3P/wjv?=
 =?us-ascii?Q?top+Q+EbX6O14nbFHfVfIIjjZd1DmphJliwGa/9cpHxvZFXlqJdc0kEcK1my?=
 =?us-ascii?Q?dmnY47i10PTAwWDngMVxcS2hz4XxIef2CG9xqx/ZyBCu97gOuiUFAtzhCn3O?=
 =?us-ascii?Q?+af55fU5WXPtZkUszHOtxH40/7dxwMZ6JA9F5zYc7mJHCdVU1P2QRb7OicZ3?=
 =?us-ascii?Q?6DesCMDJuac8VmgfZy7SbblRMPyDHkmOcUH4bXkLmFvt/BugyAaNmeh8C94o?=
 =?us-ascii?Q?0FNb921WcG3v9vEZmzUwSS+VD/loAnxSdZdKFQdZYf9TNDLQbR+5KiCnJLll?=
 =?us-ascii?Q?2o38zrebbjmXUZvjmSOoiwOp7CDMN9UuEJcA6iFNrykE/YREpSU8yEoSyWT3?=
 =?us-ascii?Q?zwEV6gqAznyVrihrZ1PRMvIYTbG90WR5nxHccN0j54sGujex5Y75sOUxNgGN?=
 =?us-ascii?Q?lu4KrcCaqSdYejS3WU5FKTHGm+BJjLj5ES90eVSlSwaJDW6viJVq8IrsFvri?=
 =?us-ascii?Q?qbPBqp7oEGrLPssuTk92xlwkMpe/T+w8dkkSeh0JnHJVQbTY2OQnIl2KaU5a?=
 =?us-ascii?Q?jgM6TAnhE8/D55zTodLqcocezXmizfhykXKzorq6lZSKkhnp7FKIQ+NpcTxy?=
 =?us-ascii?Q?f5ULpbS+hUNrLQhuLu2fW0HbHW/6B4pY7S6m+ii0tctWxv1mraJeOCKqDoTj?=
 =?us-ascii?Q?VCIwuzmqwimd/hfaJLWxVI7AHzz4HtvPPRrecF4FmcKmosnwKnpyXGtFoDep?=
 =?us-ascii?Q?aHUT+X2YAQW1HmDqii1QopZCvKnjFwObtzhJcdRR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?xNLMO3rQzSZ5aYgvoz/3dMGPfINtk3lGG/n+0JLt4aYhsPsWHfPRXDwXnt38?=
 =?us-ascii?Q?csrmZa8ir2mKJT7cqkg2lwSXg/ybw0uaIdRQEzhcpgnq/wd/OyEyscrljTwk?=
 =?us-ascii?Q?K5TGMNSNEmsWGEHpJjMsFQSW57MkAFZGEdTWcW7de5gcKkNv6RCUNJ+wap4V?=
 =?us-ascii?Q?AQPMl264aq/eV57gsRMjc8W1mf7ePj04fUtFbsj5SB87S012Bnl+FuKzVe98?=
 =?us-ascii?Q?IGnIkHPh+EQnmGAaaCXd0hGhYO0aFft8VmiVvDhgYZkozWJ76hBPNx5TbFg6?=
 =?us-ascii?Q?5BeEqaW2TmrKfDfSoqLGrPhnJ7Xs/E8y2SUC7S6U9NZx1kk+73/BooVkj/k8?=
 =?us-ascii?Q?d3hx65fuDU2Qo139J+frqtDe1NinerO6AjTu8I2glBT9EW/K22A67dJ1nJA7?=
 =?us-ascii?Q?w5PLsowLEIQg464MhsEBSpgYVl+4MF6fi8VlIqKISCr0LFAcTEAKlwUpM3fS?=
 =?us-ascii?Q?QlYigqGqqMCZuPdayTfRJuiBIYBnGjGabZ1adEDq4gF0LTXh8HBFVb8ZpZWV?=
 =?us-ascii?Q?ULOn0RZV/oV5hQGawHC0JhSpH6RsUA0ffxwXPyaQ8993ePiyysM9dH7pjvp1?=
 =?us-ascii?Q?wsuqn5CqIDrBA0y8hwbTBeTEV95Qv1I0RBnWuuzRAokL0Tja1qF9xZlTNnDs?=
 =?us-ascii?Q?d0HLdYQuuECKgUvo3y8ACItUFa8zRdCQMhO5XtevVlUDda2FeqHs36NMvtaU?=
 =?us-ascii?Q?zUga6wFR7n+0ophKGRHPKi1d9jCNAGfGZbsP55ki9aIUX1QB2XWJDMZtn/HL?=
 =?us-ascii?Q?OiLBCFM/zC0VwWT6OyzLastB7t6GBDPGx/gb0hz3NlhWwqE0kc1hNZxp49yD?=
 =?us-ascii?Q?A1RMLlxfbtb38xBNIKKhvr1QPz4YSr7nyjPEK8sP1q+6kCxiu6Id61tffIyA?=
 =?us-ascii?Q?ERQe54ME3enfI7qFCbQV3n3trgpOHhJJEyqedAbubK1MhPt0TR2B7tZDNxuV?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb36f36-2c3e-49a9-dc3b-08dbc99bb28f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 14:17:55.7028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rFG2CA5t1ed+wpxcS9p7/BsQLqHRvQWqreppWKyaFbww/Rn719GnjsG5W7wnZsBn8vEziXKkatln/ej6EoMg6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6090
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_10,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310100105
X-Proofpoint-GUID: s7zJzm2Nh3jh3YdHZQn3amZ6ogEo9MKx
X-Proofpoint-ORIG-GUID: s7zJzm2Nh3jh3YdHZQn3amZ6ogEo9MKx
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Users complained about OOM errors during fork without triggering
compaction.  This can be fixed by modifying the flags used in
mas_expected_entries() so that the compaction will be triggered in low
memory situations.  Since mas_expected_entries() is only used during
fork, the extra argument does not need to be passed through.

Additionally, the testing in the maple tree fork testing needed to be
altered to use the correct locking type so that allocations would not
trigger sleeping and thus failures in the testing.  The additional
locking change requires rwsem support additions to the tools/ directory
through the use of pthreads pthread_rwlock_t.  With this change
test_maple_tree works in userspace, as a module, and in-kernel.

Users may notice that the system gave up early on attempting to start
new processes instead of attempting to reclaim memory.

Link: https://lkml.kernel.org/r/20230915093243epcms1p46fa00bbac1ab7b7dca94acb66c44c456@epcms1p4
Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Cc: <stable@vger.kernel.org>
Cc: jason.sim@samsung.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c            |  2 +-
 lib/test_maple_tree.c       | 13 ++++++++----
 tools/include/linux/rwsem.h | 40 +++++++++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 5 deletions(-)
 create mode 100644 tools/include/linux/rwsem.h

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 0e00a84e8e8f..bb24d84a4922 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5627,7 +5627,7 @@ int mas_expected_entries(struct ma_state *mas, unsigned long nr_entries)
 	/* Internal nodes */
 	nr_nodes += DIV_ROUND_UP(nr_nodes, nonleaf_cap);
 	/* Add working room for split (2 nodes) + new parents */
-	mas_node_count(mas, nr_nodes + 3);
+	mas_node_count_gfp(mas, nr_nodes + 3, GFP_KERNEL);
 
 	/* Detect if allocations run out */
 	mas->mas_flags |= MA_STATE_PREALLOC;
diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index 06959165e2f9..204743bc161c 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -9,6 +9,7 @@
 
 #include <linux/maple_tree.h>
 #include <linux/module.h>
+#include <linux/rwsem.h>
 
 #define MTREE_ALLOC_MAX 0x2000000000000Ul
 #define CONFIG_MAPLE_SEARCH
@@ -2616,6 +2617,10 @@ static noinline void __init check_dup_gaps(struct maple_tree *mt,
 	void *tmp;
 	MA_STATE(mas, mt, 0, 0);
 	MA_STATE(newmas, &newmt, 0, 0);
+	struct rw_semaphore newmt_lock;
+
+	init_rwsem(&newmt_lock);
+	mt_set_external_lock(&newmt, &newmt_lock);
 
 	if (!zero_start)
 		i = 1;
@@ -2625,9 +2630,9 @@ static noinline void __init check_dup_gaps(struct maple_tree *mt,
 		mtree_store_range(mt, i*10, (i+1)*10 - gap,
 				  xa_mk_value(i), GFP_KERNEL);
 
-	mt_init_flags(&newmt, MT_FLAGS_ALLOC_RANGE);
+	mt_init_flags(&newmt, MT_FLAGS_ALLOC_RANGE | MT_FLAGS_LOCK_EXTERN);
 	mt_set_non_kernel(99999);
-	mas_lock(&newmas);
+	down_write(&newmt_lock);
 	ret = mas_expected_entries(&newmas, nr_entries);
 	mt_set_non_kernel(0);
 	MT_BUG_ON(mt, ret != 0);
@@ -2640,9 +2645,9 @@ static noinline void __init check_dup_gaps(struct maple_tree *mt,
 	}
 	rcu_read_unlock();
 	mas_destroy(&newmas);
-	mas_unlock(&newmas);
 
-	mtree_destroy(&newmt);
+	__mt_destroy(&newmt);
+	up_write(&newmt_lock);
 }
 
 /* Duplicate many sizes of trees.  Mainly to test expected entry values */
diff --git a/tools/include/linux/rwsem.h b/tools/include/linux/rwsem.h
new file mode 100644
index 000000000000..83971b3cbfce
--- /dev/null
+++ b/tools/include/linux/rwsem.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+#ifndef _TOOLS__RWSEM_H
+#define _TOOLS__RWSEM_H
+
+#include <pthread.h>
+
+struct rw_semaphore {
+	pthread_rwlock_t lock;
+};
+
+static inline int init_rwsem(struct rw_semaphore *sem)
+{
+	return pthread_rwlock_init(&sem->lock, NULL);
+}
+
+static inline int exit_rwsem(struct rw_semaphore *sem)
+{
+	return pthread_rwlock_destroy(&sem->lock);
+}
+
+static inline int down_read(struct rw_semaphore *sem)
+{
+	return pthread_rwlock_rdlock(&sem->lock);
+}
+
+static inline int up_read(struct rw_semaphore *sem)
+{
+	return pthread_rwlock_unlock(&sem->lock);
+}
+
+static inline int down_write(struct rw_semaphore *sem)
+{
+	return pthread_rwlock_wrlock(&sem->lock);
+}
+
+static inline int up_write(struct rw_semaphore *sem)
+{
+	return pthread_rwlock_unlock(&sem->lock);
+}
+#endif /* _TOOLS_RWSEM_H */
-- 
2.40.1

