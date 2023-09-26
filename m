Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485437AF1E5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 19:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234717AbjIZRpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 13:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjIZRpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 13:45:23 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A690E9F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 10:45:17 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38QFOrEp004915;
        Tue, 26 Sep 2023 17:44:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=vxvU3kDQ0YFkBxwolL6mkETXi4KuECFdl33JAa8bkW4=;
 b=Ni+ghtA4mlaj8o7Y5acMdyM/aLWNXs9o97uJQjgUifDCvJ2IDVh1Ygm0fu4rYskzN3b5
 3T1wBfA6Lhu+21vR18wKIvTlZdRS8QYKavNUkeVxUgn/ARTVQLzWMwwWQNcmV4HuwOqr
 o0fv5LamuzGZ+XeuO1ghSgxtRbuu4Bd/T9VQHeIwJpYgEZ1FSEcD59xpGjxw6wbFhE7U
 xZtjdR4h64Pq0Kmsf1ydBo5RCqdTtzmW8DlxJNzqya9LsGgCXvVQK1T+wJcZfSWUWGmW
 OW+3RNFaMQPCYBKYFGWli1k/sb2CfKYaQimXJMrG9KJ0dKMuNhwuW2/UYFTfvSU3b41f Yg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9rjuf7n2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Sep 2023 17:44:49 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38QHi1mm039336;
        Tue, 26 Sep 2023 17:44:47 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfck038-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Sep 2023 17:44:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFC6uN8l0zr06VDdM5t9MqB57vyHEotrMu3QfekkntyN9OHRQ9mi0Yzo2w9Ur54Sm1fJ0aLEDcPabAMTLMuXhP1x1OD4Eo6sni0oBka8RZB/DZPGsUzu61FAP4yjufavacNiqLrQEBbOAxNYn99aNNs415Sn3Vg6Yc5bL6XG7PnBFwExW8IrXUtjzSDgq50+wqZHX7uEN0a4e2WViPMOVbKfFlUPIEFOku7m7autBm87GNoZ1+SHc7eH+AwITE5XUU8YNB6bw5rpNtkHcnKfNj7FOjIvlU8oWAkcHKpwX1Eddl+28qi+NF2m2irZn09f/m5a6wuRYD/n+egBEZuUdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxvU3kDQ0YFkBxwolL6mkETXi4KuECFdl33JAa8bkW4=;
 b=SOKIrvW7cnsJWxIsAmG/N7esje7t213zZYVNQAlwe4jKQPRAaZBcQKhJ5mc3CtFpcxgO3ZK1f/E5tYO0SThYgdjW248I1aeY2tcnLzkdFP7SDKL1SaRf4rEEFS2iteEefR/zWJ1ZtVQPdwM7BrixEQXmfKafkI2e5PfVpHC0gnKSnFx8iUZiJEdXiV9H7MU5GTPIaDO3qxuLNDO71BNRqZFv5l/Hw/Dm7idtbXpEEsye6GkHuAFLLLyqEW7fW2dzBEa7oOebpan7L3vzH8poxGPHts3Zkv0Id3iLObvlwXXoD9PNL9/+DoOwx2+wVqRVdldgdarPS3ow9mLJZgR10w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxvU3kDQ0YFkBxwolL6mkETXi4KuECFdl33JAa8bkW4=;
 b=AZsBN/2G3Q3k/PPXX8WxPMWprA0MavPRfiin5dLBIJC5zxtzcsEQ4sCsaFDtT/FfkYk5Lwb6BCM3uV+kNFCE1o9sPssdFQPDG7rz7AKlLLuZDPTSzhTh+AdNXFTQr6I0TlnEhEPvL8RgMvDrvzp3gcjNTCMTw5ts+sy/80rk7uk=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DS0PR10MB6198.namprd10.prod.outlook.com (2603:10b6:8:c2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Tue, 26 Sep
 2023 17:44:45 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::c96b:bc13:b1d3:2ef]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::c96b:bc13:b1d3:2ef%6]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 17:44:45 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        usama.arif@bytedance.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH] mm/hugetlb: replace page_ref_freeze() with folio_ref_freeze() in hugetlb_folio_init_vmemmap()
Date:   Tue, 26 Sep 2023 10:44:33 -0700
Message-ID: <20230926174433.81241-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0223.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::18) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|DS0PR10MB6198:EE_
X-MS-Office365-Filtering-Correlation-Id: a096fa9f-680c-49ee-b470-08dbbeb8455a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Y4L5J9IgbgPZcJ7V6H/aDu43j+BspyEC06XS8LXZjXtYjWKAH3IgM+6SEmXpfgVuIxcmYrjPKN0m8eRwsYq3218pGhulQQru8yTDMFHOc2oDIliLooSj9C8WOLu/0AMlzCO0/Pp6YWgS9FimtHTkidDNilUredBZYdQWZ+yT1P79qD5Xhg5qzViq/GbU8hMsTvQg+Zv6uF5ZVN/m2NlVECVtutBSt4xSqNnUka7lT7XZ0fOsjsHcuOWgurG8MnAcIrFbDgfKwCFG6f+YAJhVXDgav9jYZF3OxJEo2Pki2AOmju0ApX/2Y+Berol2/kKuk92Gv44+CR2A/2N3y3HGc9EPLvXrLjp9N+eiTGbgKfT16yFqzTP6hqHN1M6M/j39NDL1pSJ97SfImzCWf6XpB+5bWwNi6o4NFmM2A0wFgqAojwLqxHVuYUb5i1sk0ksT7ygogLvJYFDC03feB1JLmezpEWza7j2zocvWwHD+s6okLK7UYhnPZiARsUDI7dYcHaQhggiyO3osw85yfIhHfGMh5bWV/7F40MR2Fk1O+KY7QsEm/EDL4Pv9aOnTASw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(451199024)(1800799009)(186009)(6486002)(6666004)(6506007)(83380400001)(478600001)(5660300002)(36756003)(86362001)(1076003)(4744005)(107886003)(6512007)(2906002)(66476007)(8676002)(316002)(8936002)(38100700002)(44832011)(66556008)(41300700001)(66946007)(4326008)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O0HqqLE8xkBa9jHo5v1m3MZLfWnMRTed1AFmg/+SgHRqYfePLqq9/LM3JdI1?=
 =?us-ascii?Q?emuXJqtgydVsmzQrtjn4oUYBFcG41d0J6J7YY2r4OuJZMnXA+d5cTPaIgJZt?=
 =?us-ascii?Q?LcR3IHxXa5GqagL/X2Q0c1OGMiwhjAVM2aqAysAfrLZAY28LnbB2I9bcOVO+?=
 =?us-ascii?Q?g3BcuTngv67RFAtf/oWa6XGo8sJ97RwHwgMQGx9GQko0sVKPqis/GAfRz7DU?=
 =?us-ascii?Q?sCd5o9qV8bz0Y8skJdZuzIVHsRs4qwQjcYdF1xRkQj2PeIgB1ffh/SJ1nRkm?=
 =?us-ascii?Q?H5ke2jrdVMbCrKxP0U6WRGIWR8/4RGSbEjNkpMTceXTMXoB9c0KQkLbL4bfo?=
 =?us-ascii?Q?s2ucaFCIwZQd32ZfQCFmEvml1pSZ7IlrVEawCGB5BJrbn3X87SicBSKT/AIl?=
 =?us-ascii?Q?ixmRYOdiYS8Uha/aR00SuhE7JZt9F/gxqmO35iXEGYjl8aCj4Qp8g56T6B6f?=
 =?us-ascii?Q?TOKT3KdQmPH08I49KMdI5FnyC7MN0PvSXQg+dkr0bE2lss+R6Xkz4RPEzHNi?=
 =?us-ascii?Q?oxHHnMELUbFLId090BQ2uRpMM+rJT/9GuCqQGkWXMB7N46GmTD8cUZA5J/oT?=
 =?us-ascii?Q?nkTj46Tm3CAgBtTVHP3i3syuyssRgNoULphfuEJ0dQgEaACjebcTKH5xwdg7?=
 =?us-ascii?Q?gLjOX5dHDq0Bg3u2Y+fjs8D54JMuiT4aO1onwFlL8mk+0FBDWnTkjppYd/LG?=
 =?us-ascii?Q?I+CpBEtvS3IvsOQJdaA8sf0b/8VpCnBhBMsjCVb0qgJzivRyGbxQWvGMef0b?=
 =?us-ascii?Q?UUG8Wg74pQyXQOiVhT/7LZZj4aUuoh+txmOBMCVM+cS426bqJwSLMpAnNqP9?=
 =?us-ascii?Q?vo5gMHRQP/6wuLQEzJ8ecgL+ozWOaqovyEmxZAkhPLZoB5eRiY7RR9oORwwg?=
 =?us-ascii?Q?dihw7YBeReb2I1rTHTopvb1QYipgxSUSADiAcyOtX09WlPbVHS6QIcVitEKt?=
 =?us-ascii?Q?LuOPVrVP8uw9Q8w07RiUX6415NgGYQsqerMblFMC+C9ekgLKy1L8ftly2y7u?=
 =?us-ascii?Q?JM7k9iFoXxKX0MNOoJ+n7MKJvF3CAwmpDBChp9EIRs/eC19X9nDN3iR/suYD?=
 =?us-ascii?Q?T4FytA38HCn0D5M5OIeIXdgFQhxsOCic2+UokzEgEzbc+pIieuMeRCkGw+OH?=
 =?us-ascii?Q?ZuVRBWjU7UniPoH/nT8oRAGOUuaZ8I0l+sbTO4x8Jei2pKP4MbXOkm6c74Hv?=
 =?us-ascii?Q?OcIpCye/Eq885/5T3DuDuw3fTl541eqXU791tp4nIsv6yPVz25p1FwQHmuv6?=
 =?us-ascii?Q?pT7n22sfzBnHazvDvOnbQ09IGyo/eq6YC+B9jqUyc3HQfldpfFcJYqMUwCm+?=
 =?us-ascii?Q?aH921OUXxr6T3vHNO/ZXKzPyMSfJcZqjE1RZ7J63cnwXgiVIKP7I9x+7byOi?=
 =?us-ascii?Q?p11d8rqOCInAF3tL1Vqup1AT107Td4+2ASV+NWG2B13/NnzuppWDuBo+LXTv?=
 =?us-ascii?Q?iCDF/qH4oa5xNJiodNcumzVj5QqqnPx0szf+oXoMlE/kbwY9hctar59JNMhv?=
 =?us-ascii?Q?zgcMDV/1+44cEY9oa2acnymUQyJA6HLWUJ95dzpuQOPDFKUxpmypz4ky4qji?=
 =?us-ascii?Q?h4N5ePjJs5t7AIWZuD5Iei8rJLW+D34Wy3bZGNMq+6/8hveM86dVO8nj5gGZ?=
 =?us-ascii?Q?UZ62ePpe13cgIdoM0l432YE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GEyXqP82BA2UWmWRkUpL45x+/M6aoi6n8vB+jLIe7cxTYGyzKNBn4jw8yb8mB3DPzqbKfMrs1gReEcTZAIPXpTl9M1CU32dvYBSuRQgOJ7F30U6DPZU7cw9teDWGlDYumYSPOkMmCuVxzCV6PPaIDXczRsVGzsnNDtz4rqgXm/cTe6QooTGmGfc8k++NK3wMCq2RQLaxj3tC4IqCZxc2ugBjJTzQNNPF3IMbcIiWHzI5B1RYO9pB3B3ILmvI88RzgYiV+IrzyZrR9TG6pZj28xwkkkaXpTHHNlMGbML90MQOEucNcwAijvixg1KwIIKexbUFkTkaY6j9p/03ZUzdd5ifU4iuYGCavBWSKRqPFRLtvLJW9aoFql+HD8fCAZwRrYZ2YDZG+mm5C5nj4aC9vwM4QVycfzEn5tVtWVaJRXxpxcv1PsLL8ltncogBg1bqQOBgvG/7T0sULSgN+wdlZEOwIzgilekky9TwxiSeYzcMdoHS25/PgQ6G2T5D/XDoPoDP58vytRwOBPk1SZMVy7YJ991ubEnF04Fwxxa40NpsiMNdfYxzNZvMxgth7p2BxO9C4aIbQG/UoOOlmPcp3ajtAbxJMRyS2lWmq6JX6v/JQRiJyvh4J7l9GNbrlLqz83GF6rPc1wF5FUu72K1Pb5E3CtkouQ5WTytKyYvUFsAKKWBtBA4jTZAh8kBxx1l+KMYRwrwH8joLZMDt4hYa7veNLQAy/ktyFKTO2zvUelTUVzKWjwD8UB6ycYfkrPlHWryeIu0j2i7s8YSO++qXNxnbf3XuhOUFx+au59WffR0ZBnXtYAUoI+norXFFboFvkka6Rjrja9MsI5vCV9IRQaxwG0gbIt2Ua/KZfjM1M0/NfY4EkBLQ7FjqEotqoXeyhEqVmXOHLCgdOxcmpZeKdBOOqRPSVIhI8CdqYYdTKaU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a096fa9f-680c-49ee-b470-08dbbeb8455a
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 17:44:45.1289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ntv0Wm4IWNJEeWoXDorZDalepLRLSSx054PctBzlrgKBLZGdUYN8FcC5XC+c9Ps4mDugITQI4O8yVftVlgfa+/eUIL9Yk9ZOyQVdGPrQS2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6198
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_13,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309260154
X-Proofpoint-ORIG-GUID: 2Gl-sD2cUini18FBVLin7M4jln7bMNC_
X-Proofpoint-GUID: 2Gl-sD2cUini18FBVLin7M4jln7bMNC_
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


No functional difference, folio_ref_freeze() is currently a wrapper for
page_ref_freeze().

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

---
 mm/hugetlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index dc35ae8fdd61..77a399afb60a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3191,7 +3191,7 @@ static void __init hugetlb_folio_init_vmemmap(struct folio *folio,
 	/* Prepare folio head */
 	__folio_clear_reserved(folio);
 	__folio_set_head(folio);
-	ret = page_ref_freeze(&folio->page, 1);
+	ret = folio_ref_freeze(folio, 1);
 	VM_BUG_ON(!ret);
 	/* Initialize the necessary tail struct pages */
 	hugetlb_folio_init_tail_vmemmap(folio, 1, nr_pages);
-- 
2.41.0

