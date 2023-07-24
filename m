Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB41875FF27
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 20:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjGXSeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 14:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjGXSdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 14:33:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C76210F6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 11:33:24 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36OFOGFg028728;
        Mon, 24 Jul 2023 18:32:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=x+a9Nbr9CR2E13FzgbMEAZv5FyPJC3+b+d5pW/tdXJQ=;
 b=IN7Dbxw6nKCCxhg+RwruwD7wReTNnq3dIFmDUOKMjhOkChOmEABNhPgqC9F3EuK1kfHs
 xTURYsg9wO8S/GzqZBiuei3/GZ/o80IvX/o/GtmnsHRTxApWlZgxsd2ThbBt0isswJXC
 oy8ePTU16/V2we4B1mz1kA3nwEwhtuDWJzbtXWEocMl+QLG3UjJJe/ggPA+Q2+JpEn4I
 b5rn9bowW625jmuR9WGODmJtl0aqlVwZw5R5zWEMRRIujH+zAO0F8/fI5vm6wfzojqZ8
 3hFhvcWkgzv+wpU+B7vB2jfnQ182m26pwKKXOGYM6VGfiPqchYPHheddvDCHumd+QK9w mw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s05q1ufc4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 18:32:57 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36OINfUB029192;
        Mon, 24 Jul 2023 18:32:56 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05ja2agd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 18:32:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Go3ndBY5lfhjPJb5gb3DsCFcv8NQkoTVdJNAzHUN7JZhFa8DMW7W/FNSc0XZ649JKaPcUT25/QJg2Vl4B3/sZF0Y5otuT4H6kkbvE/DsQa5A3SF8xdwak+JezdqKj7z/OPueQkoFi2BpA2WONfRDodl0WJ6nQhJgpMaeQpjgh4TiruHlZer+Su0ldokSv6AHTD3PDpxLFWONelyIBdvnMdtwBrKipRlVw3TQxDr7iG3BU1Djxzy0puU9sIKvV0zH9uamx1hkNlx7q87UA1oreaFj1z8Dhk2+y2kbYXiyw+E9Mr0qMGd/Hqaw3NVCyggj8lxkEI7YoN8LM0nFsjFuaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+a9Nbr9CR2E13FzgbMEAZv5FyPJC3+b+d5pW/tdXJQ=;
 b=T1cqfJ4QZ3PPpGUz7PMYQTHOytr9xZ6SPpeoJrJ66ng3mDCpQLyL/uA3xcRytM7j2QaPl7WVZNK517UmW7G3LbI7zj4ra/dIKVyHxMFE0daWiqaU+ubkzqYMTYdbaTWbneqrUI9HNjPE68HP2okIkLQ8KKZO8AvhEz+OwpZBGtqKpuumZ9m/LZI5uD9TsRcf89Jvb7Ufaja4pB/ukDQ80GmAtqdCk2b66wkXpY9es43TlwhAEGVlhpo8xtC0RH5ZyrdJHN0L5Kh7B2JlUoVksrjcXFBbPMRJKWz+UKE2U8JWivWPPe3n2UydD85JMaji/3q9xn1h+EUTq9h0SYzprg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+a9Nbr9CR2E13FzgbMEAZv5FyPJC3+b+d5pW/tdXJQ=;
 b=V68GwdSrUjoMHW7iVPClFsf+wo8t6wb4xn8SJ8sL+wDG+SznJUvHutjggOjmqkT82ZwGxCjXVV3qzjRu65+xeRTEwHl0wqb+qFoou61Dgc4bJieVv0KAzCGagbRQ5/tq/sKpqSJuF1KXQTOQZsstz9GYgMYZ33hKk3/FOifFYo4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY8PR10MB6609.namprd10.prod.outlook.com (2603:10b6:930:57::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 18:32:53 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6609.031; Mon, 24 Jul 2023
 18:32:53 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 15/15] mm/mmap: Change vma iteration order in do_vmi_align_munmap()
Date:   Mon, 24 Jul 2023 14:31:57 -0400
Message-Id: <20230724183157.3939892-16-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724183157.3939892-1-Liam.Howlett@oracle.com>
References: <20230724183157.3939892-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0042.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::22) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CY8PR10MB6609:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f75949b-a828-4d1c-b37b-08db8c7464ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uVIGIzYCbjkRPCfOsq8hD7D+ZQ0FFdaGI8z0qWkJjreZ2GDJOWDX417MPd/N8QTBAQlMx6ZclEI0RFPzNTZklOk73hUy5F+HoZI6UkgAM4CDhNOHcUmb8hBvSHj9kc6abd8AJaAqUXFSlZyoGTV0VZ4XXO1oLbVfShMiJ+v4L6CS5VRU+g//6LxDnB8BPVK2hoK8jZtzHYRlSWbobBUsaFtWDJU917Jp5B9FvpwAtg1a/c8Eo1OxKGT70pWz0SZ53Kn4G9ad6TR9sqw+PDxe82Zl5LUg3dKYdudtR+FpnDosFm6uRYqBOjkXGbDh3OU58zQj4I1AVgbRjn2Lul3s/uOilrjaqC/GMuwa7SxBqFiAubXJpcDFHAMvtxXM8vk7rKClnLmYyjfyti7RmVQp/pB5dzgRfWzcI/qXinvk5KzyLxXuXc6yxS4c9srLHSHjkU66ay/ajL3o93eySe2eusloF1ZQ0CP/CJLR7rEBP4D899gC8pSXoosPbvsN3qJafEwaY8AdKJ7NrcB4b+BjM2nYnuxN1hB9S2PMYnSgG2ECwqSyqmMj0cqSazYoWWOD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(136003)(396003)(39860400002)(376002)(451199021)(38100700002)(107886003)(2616005)(36756003)(83380400001)(8936002)(8676002)(5660300002)(478600001)(54906003)(66556008)(316002)(6916009)(4326008)(66946007)(41300700001)(1076003)(26005)(186003)(6506007)(6486002)(66476007)(6512007)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7xowYHcq3wwq6aCBMJ+yXuI/dWc3gue3PgQ8DjOVivVTTgKRTvUZ2kBg71Gq?=
 =?us-ascii?Q?3TKufla+iO1ef1TTXFY8nE5RZ39QhWt4dFKcrP0eqRnaJJIkPyZEbskmnEqa?=
 =?us-ascii?Q?iPoko4FlrMzbI9CHWZ5uKfjDoPNxQZJeAw1+oBM9cdxNATsom+EFUwU85gha?=
 =?us-ascii?Q?lI/DJbaNUfZBRR6xY8PDADTtZBCD+Kyct9n0NKUmckFuy5et66NnHhn+PHj5?=
 =?us-ascii?Q?EdVSPhwQVcGNv+HRCqmXmSiONh+znpBi02yEjYLcERr1ltmJWmRZ0tsQUYA+?=
 =?us-ascii?Q?d2EIOAQvR6fmong618oB9pq0JWP1EsntIhYr3QQhD6F/2ysW/sbQkM+FUSF2?=
 =?us-ascii?Q?8yYshF9mv5vHqpuRB4mdxgwHZgHkY1v/Z73RVLgVuwsQrgtMhpog8ZPxE9Cy?=
 =?us-ascii?Q?8NBxUGvmw17CZXqIL2kb2NFO8v68ofXIQ4/UD00uoHYTJPJB6/lG5bOsvZsh?=
 =?us-ascii?Q?iPhBE9BMUNxrGaMpEk/2L8o0LAXKFwPrXD0L8OOeK4d0yh7kaSwZVhCaju00?=
 =?us-ascii?Q?fOUJrVu5rj+tstvgtzpfdc3KJ7cJ1CTRBjxYdINHhUDTQfXbEcqzEmQYTgwX?=
 =?us-ascii?Q?T/vJKYrPvnbpnXRrUm//g1eHxyCQolfc3GVqTXwrr6Ovmy+ki0lT8t8b/gdw?=
 =?us-ascii?Q?+uaEgOntcfW14D3UmLriTkiAESGL9/AZyKakJHEuV0N/oT2EnEGmMyXgQSon?=
 =?us-ascii?Q?WOWQnk9TEyC+/R2Mhx2WDqCboiHD18AFbNQvv1yYXIL2jytomyCnRlWVmp1X?=
 =?us-ascii?Q?nNbVhqkzT9O66XNF48F0I9EMZtcfjubpPNslM4mx3llJvxYSGb/Gn26Q2uMN?=
 =?us-ascii?Q?Vp7Uj0c0Rbm2jV+WZo0WcmY7vbrV0rkXQ3gleSUQg8bb3JuUST+disj1S/jW?=
 =?us-ascii?Q?A2ZNTdWhy7aGFn0XTdkz0s7UNNAjAEjYhpPMPjJoZL31PzpHg72Dc8pgqH4O?=
 =?us-ascii?Q?/Z60BkyYrfYAkSfP3beq5oHw86WX2kIE0zhcH6mayerg1rvRLsKWgke+rAhr?=
 =?us-ascii?Q?JLurRqru3yQdfEUn3TddAHR8KC4scxDq/FTBPsAyikjusJ8cV66LHER0iciJ?=
 =?us-ascii?Q?mvV07xtlf0N4OQD0HBrYP1Fm4+To3uIkMfQnPohn65BPx86zQnTLC6gWNrm+?=
 =?us-ascii?Q?bUpGtNec+F13Tsj02eMDlKEaWGdtsFPiSvtaxdxzJ4mPyvLaFvh3kNa3xlEk?=
 =?us-ascii?Q?Vy8UzKpRRIxsdTwKIN9Mvu1P7C2mOs6dZULQ0lCXltgapY13HXAgg+s0NxRM?=
 =?us-ascii?Q?Oa62h01yLn7b8yEs5dPxMiBqduBilrqeVpS1HV3KVKnN9MsorW1gXHh7v3uz?=
 =?us-ascii?Q?rBaqQojiIwP6BnRvtP4pBlg5kT5M/xXtDGRTbjkp8mMO0ja2iBHeYxdsqlzk?=
 =?us-ascii?Q?ac7N/1ssu4U6PKPohh6dWzstanh1uVEzAhs2oHe/bqxKyoTRTm5jopqUbOFu?=
 =?us-ascii?Q?vn5UPm4Ep8RVsPpIp3qhpnYGm52PI1OekKXi5kvS9TxR6X6fQLjsU0A5b6Y3?=
 =?us-ascii?Q?0zYvwSqukRIUTfoO+VAH6DXSUmlBp4G6qLodDTu5UtS7uNfn6h87LS4vCBYF?=
 =?us-ascii?Q?3fe+2uMD/GIAcGGGL/tD9pKAY9n5oxoUfrSFqoEHPJEFxSDXoZj+Jspltokl?=
 =?us-ascii?Q?wA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: i/h681NxnEOqMLDD6IoWCBET2jjt1t+aDsvGGeigLak3mmmD5EkK1Jqcz1GL1axFscbeAufoU4RB3KdMU+hfvVagxsX5mO0I2forFIczVg/sbEzTHkDZhtxMkJwBmMjQ68NtfrTByhw3ZXEPVD0ZcRwYJ6u4ANZla1Dtu5adXO+iaCDs4PCZY6wlkz5A3ywlc4m25CipJ1c6t49K8DADe47fzR6acbtNouIHglfVKljO5iCSClaPrpLWm34xat/3NaqojvRtbylCrDu231LEdEpmEjlJSuv96+uRsiX4YdLB1+Miw8luDFQPKTEVy+8Z12QIaJ2d1xX/mj8xoLXIthV19jqRYz4zX+9jAYU5b90DvNjI7yIgXIb+JV4zudOI0Y1fEsX+30ao9jlMRfu53SWt67y6Oalq1SiFZR0DNmCM9vFb0TAB/eeenCeHmpMZG2DrPtu/amuDvMUWJIC65RI2Ap7CLLkeCLemCS4d3QxQp6bRtMdVWqJB1hxRaEuK55ax3lZiQJDD34DP/NsnRS2fqez5rBAdsAAnYu9dY15bBbQKP3tj6bX6hPadwx521bRPYiUh+WRIGG6tozKD4qq19YRHkgEQPWbHUyrp9lrQDPZmjbz3Tto8KuraCk5SX9aHO2X3rxOjy0WhyPKVAg9dEx2CCmBq4mdPqSI9Jyq0tiMyCw/TVTO8yaqB5UA0NvH8zHmDSGeOJRN/nxdl4MbdBHjfbjm6T9ZGS+H5qoKNoTPBMOhdKk6OuxeSq1tA1YdHObrdD06tkW9ev+Uoq1ts3iAO/Q5X4zz3cOrZUTlFTybDUJCS2gEaYegtVfxdsvbuNy8c2YnpK7JaWymD2YsdnVD8nr/ajHCMe45RuJO11cWswheJV3pLC7DTwz+dn5s6kYS7v59GYTPrhug+R/xIgzzLbd3fOa2u+8EeJAI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f75949b-a828-4d1c-b37b-08db8c7464ba
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 18:32:53.8253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Tn1MX6NoQ/PaDJ6/Z7El475W2JQw7ZTKnF/B4vfi7QYnokwvgtF4dPKNJ7B2LWxGYUAGwfgQKulCFZfasu0Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6609
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_14,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307240164
X-Proofpoint-GUID: RRwY_R1WWK4KNr0ggUCRQyNoxoWEsgsa
X-Proofpoint-ORIG-GUID: RRwY_R1WWK4KNr0ggUCRQyNoxoWEsgsa
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By delaying the setting of prev/next VMA until after the write of NULL,
the probability of the prev/next VMA already being in the CPU cache is
significantly increased, especially for larger munmap operations.  It
also means that prev/next will be loaded closer to when they are used.

This requires changing the loop type when gathering the VMAs that will
be freed.

Since prev will be set later in the function, it is better to reverse
the splitting direction of the start VMA (modify the new_below argument
to __split_vma).

Using the vma_iter_prev_range() to walk back to the correct location in
the tree will, on the most part, mean walking within the CPU cache.
Usually, this is two steps vs a node reset and a tree re-walk.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 58f7b7038e4c..f11c0d663deb 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2451,20 +2451,17 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		if (end < vma->vm_end && mm->map_count >= sysctl_max_map_count)
 			goto map_count_exceeded;
 
-		error = __split_vma(vmi, vma, start, 0);
+		error = __split_vma(vmi, vma, start, 1);
 		if (error)
 			goto start_split_failed;
-
-		vma = vma_iter_load(vmi);
 	}
 
-	prev = vma_prev(vmi);
-
 	/*
 	 * Detach a range of VMAs from the mm. Using next as a temp variable as
 	 * it is always overwritten.
 	 */
-	for_each_vma_range(*vmi, next, end) {
+	next = vma;
+	do {
 		/* Does it split the end? */
 		if (next->vm_end > end) {
 			error = __split_vma(vmi, next, end, 0);
@@ -2500,13 +2497,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		BUG_ON(next->vm_start < start);
 		BUG_ON(next->vm_start > end);
 #endif
-	}
-
-	if (vma_iter_end(vmi) > end)
-		next = vma_iter_load(vmi);
-
-	if (!next)
-		next = vma_next(vmi);
+	} for_each_vma_range(*vmi, next, end);
 
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 	/* Make sure no VMAs are about to be lost. */
@@ -2527,7 +2518,10 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		BUG_ON(count != test_count);
 	}
 #endif
-	vma_iter_set(vmi, start);
+
+	while (vma_iter_addr(vmi) > start)
+		vma_iter_prev_range(vmi);
+
 	error = vma_iter_clear_gfp(vmi, start, end, GFP_KERNEL);
 	if (error)
 		goto clear_tree_failed;
@@ -2538,6 +2532,11 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	if (unlock)
 		mmap_write_downgrade(mm);
 
+	prev = vma_iter_prev_range(vmi);
+	next = vma_next(vmi);
+	if (next)
+		vma_iter_prev_range(vmi);
+
 	/*
 	 * We can free page tables without write-locking mmap_lock because VMAs
 	 * were isolated before we downgraded mmap_lock.
-- 
2.39.2

