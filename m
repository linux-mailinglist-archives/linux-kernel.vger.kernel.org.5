Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2E177C2CB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 23:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbjHNVwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 17:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbjHNVvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 17:51:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB49E10DD
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 14:51:47 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EJOh7e004810;
        Mon, 14 Aug 2023 21:51:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=U7zbBrgo5HCWCc1H8QDpqkWXhvxPoBspODaR/SXTFf0=;
 b=lPLTqf5AJRdwos9hqjpC4qR/ESWBGXIuuBU89LY45JLQgpNvJrbtZI1iYQ9cn+vPeJoN
 1NOMJbqHXyPDOPPIH6NdK9xIeAWJHrTx3cIBi48t+N7Z7QykM0DMLMp8amQQP/3VLeaJ
 IWouH+Zx9Y5Xe5ELLHd/r9lKQNuUjBzC0+1CNIa44c+sR+kSkH/BQpIcU6ztA6OsmlzF
 FBWiaEpqouCF7KS9zpTUaPJhp+D+UFMcVQTPu9NDdTTBpE8ufZOpcCOGO/1y7M0nqK10
 gsNhkpSIhSiusFuIsy9aiQy7+ixgvyO0HZHQvr2gCB5TDRrDvhdE9YmUjyTgxRRfzuv4 VQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se349bpyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 21:51:13 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37EL5KAb005521;
        Mon, 14 Aug 2023 21:51:13 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sey2ce5xs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 21:51:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPctzghViVoqvSWrIHbZnId8Ec6xJSTcNsWIwKSg6/lktcA0u8bcVdrmb5H5rYYYIjcwKU/xhlljqHRie9gOi1BaDohrzu3/Nglw6cD+lJSX+yMomfEUbHt1bCTr1iHyQkc/iJpJRQH1NZqob1gm8y/+dr/6cYsuq959kM9+ioP94j9QxbFlmc7dFsskSy75xUpDaNC9nolFkQxILu0ES+nrfwtIon6SmqJf49UERbzlZup8HHywoo4odoNzv+YlGt3ITC1QrJ0UTGvUTvCpYYTXOT9LufhjJGlNJaAuRlZ8w+Ll+yAWr9eI1Kz8vnstb8RiEnh+gPKMoKPnX5jEog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7zbBrgo5HCWCc1H8QDpqkWXhvxPoBspODaR/SXTFf0=;
 b=S1xr/F7KLlokNK5gAlVhRTS5LC7yEYXFEkvfVuWdFZltcRb0TZavIRFGN0q1CEz5SgwvAWhSdBEI66f3PTy2m+HROpMW2xiFGoOd1Gikod/+I+cPbWzJbAHTNdbz6b6lGPNRYT8o87cATeIKwfhMDzfu0wUuyqayn9o6cgd3DGvKNCXW4Xk7G4WT+hA55AXMpg5cN5dW7GKY2cjjmOYnD8lbpvji2drzjXdPycHHHtO2lrw300CiTJecxkmQRP54EURODkWtsU9ltIkWNRw2VNpl+7VL5NytmoS2fSglwl/F+Y3QLK4pL0/0NZocWPJX45/z6M0VpVcnd60vBCVOBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7zbBrgo5HCWCc1H8QDpqkWXhvxPoBspODaR/SXTFf0=;
 b=p9Ifhhfo2vY6cvxCqkvVLCq9XbumM8vd6IYpot6K/fF/MJviNR/KFRvKklmMgaNlw7ipTuRkq0/5fAxvY+z6qKYw24nW+PYoRJiYKKpF3jzI3z8QWHhtqsrcsvIpgW30uWwL6u6pxVb5WQNStY7yGndVrtNPqw31Qs2Pi3qeuq0=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CH0PR10MB4875.namprd10.prod.outlook.com (2603:10b6:610:de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 21:51:10 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::6bff:7715:4210:1e52]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::6bff:7715:4210:1e52%7]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 21:51:09 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v4] mm/filemap: change ->index to PAGE_SIZE for hugetlb pages
Date:   Mon, 14 Aug 2023 14:50:35 -0700
Message-ID: <20230814215035.222688-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::27) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CH0PR10MB4875:EE_
X-MS-Office365-Filtering-Correlation-Id: 15132a4b-d50c-4810-8219-08db9d1091ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fI+zmtSLY/bvoNJz8FznPWw9BoNrvaeb7MawdSqbD6eLZ44y8u0iBDHbqvmrVgeg614iWAYAjTdDJpM6LbwJMjBPUvqxKeA3V/W74MPD08xxt2BX6NBG6sBl2tfocrzC2OemKPySVKi/ecXGcEfQZtauUX+KAPM47+b4HJu6vXl7w/mFBmXsZun5h1a+P02LQWU//mlsFWDfArlWPQfdtMfQ5vlr5w6J6HcWiCo677W2WGB43QdoWMPNIXoYD3dBGRfd9BaMbxqmTm28gp5mIBHNXxRWWZQ1cc0gSVzp75qqELmDt12c90C1VqunsQ4kWMT5iQVC2C0scyZuefgZBWJ05z6BEGHquX9QGg6EY4lPwgF7S0sMaU7M4SkkLx8Z+woNBt6M93r2l6kJGl9/0yljvGW8j8BJxTFfWbe5F/kLZU4v/a+ht+zB3QnY4YbMBrVNFr2fmS3DlnrFqqZNPyqQnCkwTfcJukm6X4/abMH4USA8j+YNh97rOpkrELQe3GfUGOqvMGf3QMbK+BoCSmbr6+eC1Yu6gvhCeF4t5vFMU2k9s2LcTReafhZcbhmXDRGVP3EoC5uo07z4TOuzDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(396003)(366004)(346002)(39860400002)(451199021)(186006)(1800799006)(38100700002)(6486002)(66899021)(478600001)(44832011)(5660300002)(2906002)(36756003)(6666004)(30864003)(86362001)(4326008)(66476007)(66556008)(66946007)(8936002)(41300700001)(8676002)(316002)(107886003)(83380400001)(6506007)(1076003)(2616005)(6512007)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mWDnc6EkMYoTFIjm+YugyO9QKbC8MugwMKyS4jlxx3t4pKjZVcctvYMaPKUx?=
 =?us-ascii?Q?lr9UI/qIrYBSKbrh1liFN+VyYUiNDpspkG38lwtI0H6wGzo+loAz5VpNnSKA?=
 =?us-ascii?Q?qAZ7h8SSCUqKIaIuxYrbP82nEI3qgTEjH5BuV56I+RJtEi6fCUodS0y4Fp5d?=
 =?us-ascii?Q?OHpftRGFdpWlD7MCvAT+v5SKKVHWqUH8IuswEkKnrKebmsWgxlNnEfAsDito?=
 =?us-ascii?Q?3lSr/R6lfZLMCRmnZ81nMzd3UykPm66mfXBfi8OZHX0yL5RjmoXfLhLBvXyu?=
 =?us-ascii?Q?Lj5D+Xc/HxKt3d3KUlkhxKj0arAgqXx75RGc5aoXjpqMc7ZeqY254zZBSEf9?=
 =?us-ascii?Q?MZWRs3EdwJhtf00Zd1ehwiewPRq/4lhTqXpMIUgxgkGgCVV1j+upI9scZnjo?=
 =?us-ascii?Q?5TNcUK0R9q30OXs5e5h+bD4FeoAeXpec94p1gRAG6IcQRyjzaXM9a/BfdXmE?=
 =?us-ascii?Q?B39EpqBkuhCVZvo9Xhe+Q1PPid4IO9fO5MFQD8NVMROj7C6dUZWOzIXL6BwU?=
 =?us-ascii?Q?9IzM+iVG0TJhlqE5g0vQ5McI6FVaivhmSFnz4AmWdwqy6JRNqJIxtSBjUhHV?=
 =?us-ascii?Q?YGWW5vFMJtx8OGJcJ2oksh9xD4+UkPEnSMS+HIbIuKM+0o/GknY1Mij7o2No?=
 =?us-ascii?Q?fGYEwLua2vdyuX2lIHMAmFgBMHRIJSJapj4k8UokRRxRZ72V9E0JOEaTO0/6?=
 =?us-ascii?Q?20I+yNIJ1uJGYZ8AKdTWvJSQc0framORisH7TDC4tRpO5m+zBqNNE28Z7Eau?=
 =?us-ascii?Q?ZMLEHukPZFzYXnqv9jnDG57n8Z2KxafbvgmrBWgsbhIvBzNfSRA+aBvIGp7c?=
 =?us-ascii?Q?I/rnsIy7XtWPwdE6lwa/FqBCKZeg2EDXUpWAIsGu9JI1gsQ1yV1rzqI91Ljx?=
 =?us-ascii?Q?XeYx1RFlgijnUEBuamaeyCgfd1BpHMkqIr+vinc42yk/GbU2Ye2ZMQGVcTcG?=
 =?us-ascii?Q?Zw/Yx6Nldn5i42pTeCKxLWbqw3D4Qk3KEORAWJI84UFTnDiLJguqSWsArCHl?=
 =?us-ascii?Q?h3z9hZ3VzxwDcaJWjsonHxuCaqE95MOAkNO33N1ujjyNOHPudEiix7Xqtb6M?=
 =?us-ascii?Q?Kyp1GO7wCYW1s/4+4n8Tuu7m0U3EItwl5SMqRI6AmYwHczhXuKKmFx1WLCPz?=
 =?us-ascii?Q?DYoUkJZg80fEjvoU4NxzggMiZLxoufz14v1znN9OnNReJHD2UnxwKY/2nTE9?=
 =?us-ascii?Q?dI6Y7CUR3yVs562UAdmZMKMqyqyyVARPYaQfdtNdLPNl/vPaAo+AhlXrOSrG?=
 =?us-ascii?Q?y3ETf0NILtzOatbDz2Pedv17ghi4ShmGPLPYmkdrJ5FAgpgwmfRl+2BZuVMH?=
 =?us-ascii?Q?/Ky8JfkMy+hNI4lC16Gihjo50mj5rxsbmRAcV+bSGdz93mtN98lUWiZ76Acd?=
 =?us-ascii?Q?u1eLnBBgv+6au9jEhaEykwAVfD2d2Dz1cAnlUL562Nxi60+2giUiy6rDHTML?=
 =?us-ascii?Q?oAOsz8/PKUR553/W5miarYPX6PHr4I7iWSGj4IYPQQ2LE/0VbpKceK0JEye1?=
 =?us-ascii?Q?YFICf3X4NWstjsP1kq5XWeL7fsvjgHewW3lrXDpkHS4Mu02gNXnP5mIe+vEp?=
 =?us-ascii?Q?0A80incBgD6YAoNdQBQ1pFfp/HbHDnb25dMxZUgOQ/EAo4bhlft9y/j98Of8?=
 =?us-ascii?Q?6PFJh/PLLf/JynEc3oAtpIQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AwQLdf6PojoBpcnYc+6aGCyzSOu1cUFoYB8ioRxbtY2UX/DPi4Kb1keuDA0EFFgsr4dvfHkmtbt+oqucFbit4WjLNKiALm4jaVsV+pb+F8qkAMV8Xk9Eal7u+FcL5+zzTpMEjOPd/nNIcdp8WM5uQ4Xiu/dx7/6tYecB9Q/FMBcyhtLHVJUToBK8DvcX0Wj8WdgLEi7sLhqZUptu12+icJWBDzdXzxDl2QjCbmOFMt1wLYOnN1vR3pajLLOO/lIK7ccIHCKo6qXPq6L4W4VDMijnht9yJsm5bHAWuznv+XevIZDshL5kO09DSL841Kb5/1ovpT04GoScMOrc7wO2BSUpLL+V885c+RsQJYm1JLWxMJqa6XlFvV+B+arxVMnBvOS2GfML3PBh85XIne07BUVsIE6EhxNXEMnf5Yet/N1QfK6WU9zVWgi09wsYpeaj3o+k4jfa5Lu61UKY1L4IaFgW2VhfZUdbSonSDafS6XKyxmCvZgzZ/7JYbtirA0h9Bx+5LmBQ9Z+NeAEokhgOFWejoMT3Alw3ADB+3n8VczxTNJzWPP6HqJVQ+MP9s1SENpS406iAksxvbYEUlifJF0B0slBrm2RAjZ0C5ochifSjdiIr75hqKqgMWeUjbqBTnm/9osNzl+46LRdemz8fYnvY2iSHU96B5HUD6sQy2BU23XavedTGwZ22rvrUNa6OdGkRtQiFpsT7YmCfJos3+QnTG2XNDbWWISbzshmTeHlF7XfAIC+Ci2YQ7dLv0HWlNRwPFzhA0yZSFsPikhk7b5cVqpo6Q/i2VOBm2lvOG+zpe1OxYybkuDOYD3L8/sEabfwgqPUHqt8ocuS3qRpK6nVnN4d3YCDJOL5cdzsAQEiYITaho0tHQ/Y/+cL1nKRrcCTyIBulMwKB8FjaIt5EvWW0JLcg6BXDwaI9JZMeHLQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15132a4b-d50c-4810-8219-08db9d1091ec
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 21:51:09.7812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oZyklrZhxtzQ4X3jVQSsUJyhbmsWfW/KTvyqUP8I/yIg/pB6/98iYSmt3ol81bPi6JtPBrD/fxoSCCjzFlkMfkHI0AGSG/sUMep0hMuU5Vc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4875
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_18,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140200
X-Proofpoint-GUID: yMxf0saECVk6oywuHo5oaKuMoMHW0E5k
X-Proofpoint-ORIG-GUID: yMxf0saECVk6oywuHo5oaKuMoMHW0E5k
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset attempts to implement a listed filemap TODO which is
changing hugetlb folios to have ->index in PAGE_SIZE. This simplifies many
functions within filemap.c as they have to special case hugetlb pages.
New wrappers for hugetlb code are used to interact with the page cache
using a linear index.


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

v3 -> v4
    - rebase to current mm-unstable
    - include time data per Mike Kravetz

[1]: https://lore.kernel.org/linux-mm/20230519220142.212051-1-sidhartha.kumar@oracle.com/T/
[2]: https://lore.kernel.org/lkml/20230609194947.37196-1-sidhartha.kumar@oracle.com/
[3]: https://lore.kernel.org/lkml/ZLtVlJA+V2+2yjxc@casper.infradead.org/T/
[4]: https://lore.kernel.org/lkml/20230811233939.GA105247@monkey/T/

 fs/hugetlbfs/inode.c    | 15 ++++++++-------
 include/linux/hugetlb.h | 12 ++++++++++++
 include/linux/pagemap.h | 29 ++---------------------------
 mm/filemap.c            | 34 ++++++++++------------------------
 mm/hugetlb.c            | 11 ++++++-----
 5 files changed, 38 insertions(+), 63 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index e7611ae1e6120..ec0f856a1228c 100644
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
index 0a393bc02f25b..1bb3fcacdcddf 100644
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
index 71dd79b4ae0ad..6816d3ccbd7e2 100644
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
index 014b73eb96a1d..94e8d96159bc2 100644
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
index 5f498e8025cc5..3520c83c56f6f 100644
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
@@ -5750,7 +5750,7 @@ static bool hugetlbfs_pagecache_present(struct hstate *h,
 			struct vm_area_struct *vma, unsigned long address)
 {
 	struct address_space *mapping = vma->vm_file->f_mapping;
-	pgoff_t idx = vma_hugecache_offset(h, vma, address);
+	pgoff_t idx = linear_page_index(vma, address);
 	struct folio *folio;
 
 	folio = filemap_get_folio(mapping, idx);
@@ -5767,6 +5767,7 @@ int hugetlb_add_to_page_cache(struct folio *folio, struct address_space *mapping
 	struct hstate *h = hstate_inode(inode);
 	int err;
 
+	idx <<= huge_page_order(h);
 	__folio_set_locked(folio);
 	err = __filemap_add_folio(mapping, folio, idx, GFP_KERNEL, NULL);
 
@@ -5874,7 +5875,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	 * before we get page_table_lock.
 	 */
 	new_folio = false;
-	folio = filemap_lock_folio(mapping, idx);
+	folio = filemap_lock_hugetlb_folio(h, mapping, idx);
 	if (IS_ERR(folio)) {
 		size = i_size_read(mapping->host) >> huge_page_shift(h);
 		if (idx >= size)
@@ -6183,7 +6184,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		/* Just decrements count, does not deallocate */
 		vma_end_reservation(h, vma, haddr);
 
-		pagecache_folio = filemap_lock_folio(mapping, idx);
+		pagecache_folio = filemap_lock_hugetlb_folio(h, mapping, idx);
 		if (IS_ERR(pagecache_folio))
 			pagecache_folio = NULL;
 	}
@@ -6315,7 +6316,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 
 	if (is_continue) {
 		ret = -EFAULT;
-		folio = filemap_lock_folio(mapping, idx);
+		folio = filemap_lock_hugetlb_folio(h, mapping, idx);
 		if (IS_ERR(folio))
 			goto out;
 		folio_in_pagecache = true;
-- 
2.41.0

