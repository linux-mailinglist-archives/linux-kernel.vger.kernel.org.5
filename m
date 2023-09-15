Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E4E7A2A5C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 00:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238053AbjIOWRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 18:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237890AbjIOWQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 18:16:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5261D1FE5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 15:16:52 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38FLvDqx025304;
        Fri, 15 Sep 2023 22:16:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=70YZXjYHeXJTUfHpeVFoC+vRXVEfJ62tlb/36hn+mlw=;
 b=Bm5lLyHgAv4VQclF5sJAonlsRLrM3Aice3CgG6rFyCMkn/Xznq12ABUKJ/txkdui6K1K
 F4kA6s/1SQFemNwSClF2OWj+Q2HqhMO6saQFfI52zopj3hlycM5MmsV60HK8nrmBEI47
 4EfTQaVDGm3CVK9ze6PYdr4N8igMZMz2wRWjMVB8qoIQZuXIx0JrP3U2r27EKvpYttsV
 2WS1pXUPFFFGaRX/azkCr8NhkN6h+BgUBvPup6eI0jD89/oygJrR13R2+jsEAheDtKrx
 6zEh7SxMNk/WUSwA3oTXBAYJuGsv22xudon332fZPnEoVjF/RQMNAPxtcJAhx8atvA3U HA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7n0k4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 22:16:04 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38FKi6Hw036207;
        Fri, 15 Sep 2023 22:16:03 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5gx8ua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 22:16:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jfTHon2UVRZvWWcHCeaslJknwCl5M/qsXAa3ExeRBoN8aEj/eypccX0wLN8HUlXllsE8uD7rAwW3fwPLqVOz0e5RjTzXVAnkJOLgqCgS5pT35hv+X3xiWkSiDo+kjRPoaJpiv2LxM/u2q/D2C7A55x7/ZHhsEbSgnUo8SlhEdq5kdMjlO8SrUhuoRkdfLmNYdzHNbBX++kUDNU1P//sDDPTSIriSRLR6cTB2ffXCu1lVMqS6otX6x6uM97z+IZdQgNLb6U+Q4SgPVsKSBSZaC9SbtP4YZ3NVO0sswTkFcZpLxwYtTQ3f+ZgHHOlfdjiGG+h5qb+EvgqQ9Hh1tOS9yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70YZXjYHeXJTUfHpeVFoC+vRXVEfJ62tlb/36hn+mlw=;
 b=P6Sl/7Vem0LcwoZbCRcmM4sIIQbJWL7cTtVki0rMLrC05+MnyfhWVrdLr0Nm1r7kvE4sdapX9T/5XlzCfF/bP+gNV1u+iCQHl07VAoDe80U8mD0Luq97UbGGsrzB+wL/sPTJFfi7UD3J6A0KnpdteQtHM58enP3hK8giaR3bEIENbw3Uic1dTWqXIBHJ1a2Py9seu7vwSBvbJAk6SA6n0fdRkLz9Obnfn6tYAkZB7iLX6pElP92nfQlUQSupfSwKCFmrPCTOEZw2Lt0KAdmj/9X6wd+NM6MFjClrk0636tRNZ64ZROZV5RYRC1j2z0kEZM43AKSdcSBmeOqC+dFxwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70YZXjYHeXJTUfHpeVFoC+vRXVEfJ62tlb/36hn+mlw=;
 b=jaBnIbJ6Jd63l+zHm4GiCaEvx6B/h/2SKlJycITDOLTxo71AeNKE5n815C/8Q4sjAMZxWRyG5vzgNYe6S9A/bgBGk9NPbZn83murb0irLDN7TKygEVfJhXf56rSuWR4UIKWF4EQmqLhTHe8VoKXYkk0oJ+d7+qh37Oy5XkSwAM0=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW4PR10MB5861.namprd10.prod.outlook.com (2603:10b6:303:180::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Fri, 15 Sep
 2023 22:16:01 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 22:16:01 +0000
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
        Barry Song <song.bao.hua@hisilicon.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v3 03/12] hugetlb: Remove a few calls to page_folio()
Date:   Fri, 15 Sep 2023 15:15:36 -0700
Message-ID: <20230915221548.552084-4-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230915221548.552084-1-mike.kravetz@oracle.com>
References: <20230915221548.552084-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P223CA0023.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::28) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW4PR10MB5861:EE_
X-MS-Office365-Filtering-Correlation-Id: 402c1fc4-1750-4fd1-656d-08dbb6395800
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CFHK0shqqS64ZR+cLpIhqLN86Xb8fokj5PQzfkKqVNkQpU8pEcRwU8AQjMPzHPwZU+oHALO7QdVZY03zoESkqa6IFfbRWjccqXOtlLxTXjwhzEBXKElJU2Q1sMOvlwcz3XqhBRQPr5myGyEm9G0pmqvR+y+d5kNUGnyo/stEp3CgZlq9q/K08IiWTiEDhfnWTXuOHc2LUp+2UEeGUYBpLnhhnGkUzRtoCPqzcBddwaXzzjwv3eQiVOFZueTc7IgXKLtJAbuu/9OFW/OMQ3bSQ32WQBKkAKOx1+EAPfEmP4SByeVEoCX0iLeTNRz5DAiPOVCHtPM+iT7Zgv6fRYSh73dIXpV3TMzomEERSYni1vLj07dtAPjPkfS+tcdBjdqoxcAPEWJKQrQIPcRNL2f7tprjMq8MPBlseUXMyRUrnWFTv4m44xz1JT2KXHRqbe6dLNM8Qjs1auupZOe3BeUNTzdR1rHbAhBAW1nhPst1CteVpxBXxxVMymSArOv1LJaoYBjMxz2bPaDCiI0cMoZkyO1nf3qFz1DLuIUE2gfs4KAJEs1kax4r6iFN2bkC4qL7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(366004)(376002)(136003)(451199024)(186009)(1800799009)(44832011)(86362001)(36756003)(83380400001)(2906002)(38100700002)(478600001)(1076003)(2616005)(26005)(107886003)(4326008)(6512007)(41300700001)(5660300002)(6506007)(6486002)(8676002)(6666004)(66556008)(316002)(66946007)(8936002)(7416002)(66476007)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pSOH73TS1b+Y8Qz5azwPTzkii3qTYt7411BCCpC6yOaAVIZQX7EPOmLcVjVK?=
 =?us-ascii?Q?Zi8eCy52y9e3YZv70uBR5qJK3qE7Ocx2XDDAYG7P5DR9Si10i2cveuRj6wc5?=
 =?us-ascii?Q?d95L2tYXNF4gtvsNYyoYjcROe6gSyEgp37/scmxWr6Ha9ChLbM2z7Ho4sRWl?=
 =?us-ascii?Q?FfHt+4hw6t3zoMn0pcydS+47MtxGZ78WygpEvxYb13DNUCCX33nZhgGiq0zB?=
 =?us-ascii?Q?W3GXElKuU3Hlb8Ofvon7egvgJ+N9+2fdLySdVd41W8u5EzMBiOL7RgjgtOGA?=
 =?us-ascii?Q?By5EEpLIsTh7IHw953wXhxAVoxUTyf1c47S0gFsOB0o7ZCbw6aIsFhrpYcVU?=
 =?us-ascii?Q?11OMLRtuny8HnknWwKBWmDf22tx9jHgtrzzUXekhU4T7KSZvjtCtyUF3iu82?=
 =?us-ascii?Q?3SH4lW1e3h8SAShhJjk2yYuCBohrsjiDqL2sMN+XKR5wQbwbjYYCS7wNYQ4N?=
 =?us-ascii?Q?A9X7ZIWm9wFzgSwztubevq0HiYbzzFu6b2VQyU6gN4WtOEMlm7Y0lh3xUtF6?=
 =?us-ascii?Q?sNvWIQEIHdg1fZl7J/a9EZ1uy9QZMCDp3D7+wECpy1GBNVwarWqW0fguQ/OV?=
 =?us-ascii?Q?aDpb60XDI8PMxoRiknKmuwxBg6qJj61WrSAkZ+c/U3xGGmiQ95nZUsH0Rs47?=
 =?us-ascii?Q?TjwLUXaP8W+Rnqli6ZhJSXBDTDJcEHQQD6p2eidYRnQnePcqBmYW5N6Sm98s?=
 =?us-ascii?Q?b1+bQ6wqhGgvkZwKWaSy4mqYyxLANZMyZgQWhkGDk1KJrNZza5+/ZKlBxgVl?=
 =?us-ascii?Q?kj8RU5lVnJng3qyt33yetfbSdT2nqW9oiI0/kXWnHzaL5VkebGK5mKYKBD1W?=
 =?us-ascii?Q?h2Jh+MKdCqgW/BbH7L/jjJ82BVAQNESRpilkJ9I25BSZDOFwIhF+W9BF1R94?=
 =?us-ascii?Q?MOAaZMAUPfq9XAPYhqMsJVKC3aHDiUfg12BOTxSIiS3MMYu1yD4JchhaMGBM?=
 =?us-ascii?Q?4JBbpaIyUKBBSmpO4BcSKrZhiaPccbm/s2quQEYeiA8qQZ+H1eI9kN/q5IX0?=
 =?us-ascii?Q?aHcRbWa1xsUlnVfLNBZqMSPieUOYKotxCvVdkVq/AXZ4IJotbdFmob8MwOzn?=
 =?us-ascii?Q?VoT36663FDXHWTUWBYsi1U5medjdF9THIen8YBmVEvhTfhV7JbbMfviaXaAm?=
 =?us-ascii?Q?n+aJ0SOM99hxwLBw2M53z4B+l2duXjMsddYgFZFVMo89aiPK5zACYBVyGQSA?=
 =?us-ascii?Q?oinfht/NoGFHAjkHG4OkPn/2m5W7duglqpLjudga/if0sBmc+F0dueIecF10?=
 =?us-ascii?Q?ACk8mpjY8wS2YBdebB3eqmJNwutcooUnFfmpcJF5zUbwxuGNcKe6TAnHpvXf?=
 =?us-ascii?Q?QGj8u5TZ979c+WlkUfKXrBusjudw4EROmQ9BdhplhVTdsSNvhQ+qIRg8H0HW?=
 =?us-ascii?Q?N6fCi4DY/X2513AMBAiZx+K7+someizVGaIS4Lq0d2mVYduZ3WJzU9Gvbl6m?=
 =?us-ascii?Q?x2n8WhtVAox+wKmqqOhDzTwWWtsqjJDLaAp8zsXLoR6V/EeZZ02Qp3xEOCbX?=
 =?us-ascii?Q?M2cGh5LZUB3FYcs//MAsiOyFISSUG7i/m3mcCPOS5huO4kkwmYCoW7ZRnsEd?=
 =?us-ascii?Q?l6QSiDP7I7vWImDeM5TCLE6q0vdCziF1zMkfvpbTPP5YFR9+tSApK4GGZ4K2?=
 =?us-ascii?Q?Hg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?lc+2ho3THmk+O1thGUJGWmCnx3oGw84m+qaag5iqkrOpgZV50fRv+csGxKXk?=
 =?us-ascii?Q?kO6CiOiy9NsPwgJRXGl82sGW4YwI9SK14DZFQq96WrS8RL48l0miNZK9fjBF?=
 =?us-ascii?Q?z70dxI11AULF3ATHGqQLTmvA7Ashk0Hu5Y+FwADxPawrQYtvdLaqoowxHst+?=
 =?us-ascii?Q?6OFk9knQnNal+t7gWPC8LvIydlOKnsLPvIp/odMssspxhA8Wc06Q0ogjjya3?=
 =?us-ascii?Q?CFGQhaLFx31BjTUKFgKo7Zd7wWZ70MrSFKizHjvF2bHb+NfWBMSVgMBrOiy8?=
 =?us-ascii?Q?RZFouWhveoCbHYidUpfunPnJmhnZQHA1I7I3e/ggPutm8u9B1nXS0bnPfM+T?=
 =?us-ascii?Q?RYvCATn0PmRiqooWbLLUe+Lpd14CG5R28R5TmMA24KrV5c6+ZXJHym4wG+vR?=
 =?us-ascii?Q?pnUkQhCqxeRJQ2EcZDAW/6IXEn5lS7slgQkJaPM+bcsN+QXLUNYsvNHHKFLx?=
 =?us-ascii?Q?XpdN/BCvTKN7FDXpBBwyot58gTnVvV0t2xeiTONKOejT+/nCVeTO6mOrm/ml?=
 =?us-ascii?Q?6G2vBk7JHMaJ0MAxK7VB+6IDDNQiDrsFE98zdFzbHd5lKnsUIw4lHYC1hsTM?=
 =?us-ascii?Q?mswbntVNj8ayg1N7IBjrUWozQgLBe1RWOTrjIFcZ5J5k6vt0R/u6t0um0CJq?=
 =?us-ascii?Q?4lCTXtFOuAwElf5h8NHQhZ8lSJLwNsNsNWATi7ErnfGsiJpbocqdzrFlyzNc?=
 =?us-ascii?Q?okdglFcYeDwLQHB0jIxY9OXK9V36Z7v3mIj878olBZwcycsxRGP5IDp9BKjk?=
 =?us-ascii?Q?bEIJV9I2zbsqbrsXDpb4fwV8VYqUIHQFDMa3frOrWFOv2jVAU0KT5un+pz3v?=
 =?us-ascii?Q?9vy/8aKjr7c6M+4ueYVbRhEw82fsSGyFutJS8Y4ePZG21JWO/9V7/ee13T4G?=
 =?us-ascii?Q?up+ydNEblcomaeTNt1XGkhEgp+kn++XRhgzLrCJm3194LtumBXKjXvgWAO0t?=
 =?us-ascii?Q?SzEEBULKlwekAEE1CE3uwtMjjBW+tgQCFv/5mEQzq/0w9jAtUnEYNuONQcDJ?=
 =?us-ascii?Q?jwA4VeW3YxPt6oA8jdFRKO35Dmm/QOHqRYY7jckXexaP7f9de2C6B8QyWzvi?=
 =?us-ascii?Q?3tPhn9hNHwmAf6yTFG8TzBdVZHf5kiz8i8M/IL3NEuzbFzxaLVdtqtIcIkA0?=
 =?us-ascii?Q?Lr36XtS4A3TP?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 402c1fc4-1750-4fd1-656d-08dbb6395800
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 22:16:01.2295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b9MrJyBuaJckDndEyeAZscUjW9FgOxgfQMU5Y+7+t+OuPIDyEgkT3AO0iM6eHPVDuJM5MU3JliUmR21IVOeSjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5861
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_19,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309150200
X-Proofpoint-ORIG-GUID: 3cqM8Cb3M-SDhvPsn_zfF0D1U2ZPdhY_
X-Proofpoint-GUID: 3cqM8Cb3M-SDhvPsn_zfF0D1U2ZPdhY_
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Anything found on a linked list threaded through ->lru is guaranteed to
be a folio as the compound_head found in a tail page overlaps the ->lru
member of struct page.  So we can pull folios directly off these lists
no matter whether pages or folios were added to the list.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Cc: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/hugetlb.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6c6f19cc6046..7bbdc71fb34d 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1829,11 +1829,9 @@ static void update_and_free_hugetlb_folio(struct hstate *h, struct folio *folio,
 
 static void update_and_free_pages_bulk(struct hstate *h, struct list_head *list)
 {
-	struct page *page, *t_page;
-	struct folio *folio;
+	struct folio *folio, *t_folio;
 
-	list_for_each_entry_safe(page, t_page, list, lru) {
-		folio = page_folio(page);
+	list_for_each_entry_safe(folio, t_folio, list, lru) {
 		update_and_free_hugetlb_folio(h, folio, false);
 		cond_resched();
 	}
@@ -2208,8 +2206,7 @@ static struct page *remove_pool_huge_page(struct hstate *h,
 						 bool acct_surplus)
 {
 	int nr_nodes, node;
-	struct page *page = NULL;
-	struct folio *folio;
+	struct folio *folio = NULL;
 
 	lockdep_assert_held(&hugetlb_lock);
 	for_each_node_mask_to_free(h, nr_nodes, node, nodes_allowed) {
@@ -2219,15 +2216,14 @@ static struct page *remove_pool_huge_page(struct hstate *h,
 		 */
 		if ((!acct_surplus || h->surplus_huge_pages_node[node]) &&
 		    !list_empty(&h->hugepage_freelists[node])) {
-			page = list_entry(h->hugepage_freelists[node].next,
-					  struct page, lru);
-			folio = page_folio(page);
+			folio = list_entry(h->hugepage_freelists[node].next,
+					  struct folio, lru);
 			remove_hugetlb_folio(h, folio, acct_surplus);
 			break;
 		}
 	}
 
-	return page;
+	return &folio->page;
 }
 
 /*
@@ -3343,15 +3339,15 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
 	 * Collect pages to be freed on a list, and free after dropping lock
 	 */
 	for_each_node_mask(i, *nodes_allowed) {
-		struct page *page, *next;
+		struct folio *folio, *next;
 		struct list_head *freel = &h->hugepage_freelists[i];
-		list_for_each_entry_safe(page, next, freel, lru) {
+		list_for_each_entry_safe(folio, next, freel, lru) {
 			if (count >= h->nr_huge_pages)
 				goto out;
-			if (PageHighMem(page))
+			if (folio_test_highmem(folio))
 				continue;
-			remove_hugetlb_folio(h, page_folio(page), false);
-			list_add(&page->lru, &page_list);
+			remove_hugetlb_folio(h, folio, false);
+			list_add(&folio->lru, &page_list);
 		}
 	}
 
-- 
2.41.0

