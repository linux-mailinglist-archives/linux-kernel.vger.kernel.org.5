Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7E8804363
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 01:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343639AbjLEA2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 19:28:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjLEA2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 19:28:32 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2581FA0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 16:28:39 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B508rx8027754;
        Tue, 5 Dec 2023 00:27:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=RW4wrKNMT5fdYhr5k+mlkiFXMNoNQdqvxt+zkV5qwiM=;
 b=ADPtIm85w41JfUL6OWTTcwyMw50XCsqCt60wSQYt+H3Sye9mXenI/kDhXPT4e+wbxBXH
 VKjU+adPLCOPLRx7zKi/96mI+4zFa17gDBGWj8zGFkCMFc+T+isoctIbxz/eCvAygbyp
 zA2BmouOnPr3EKPZLfpZhtQotLZpUfEyLW6VH59CSIW9IRoOKtW64vEOD+44MV0bqUql
 TM+Vv1objxg5jCLkvEBlRKlEDEjGVjK25pCyf0nHncnUNxXZIGLdlk+eyPTi+ENz8VkY
 TTQY3VuCh2ffdjUMWINBqN3itp28y7gRkp91k/qR76GCJcgcTo/3h2uX+IK9jaWZB0XD xQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uss28r115-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Dec 2023 00:27:57 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4MIrhJ018588;
        Tue, 5 Dec 2023 00:15:55 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uqu16kcuv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Dec 2023 00:15:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eEJmAI6P9wIbCrPNMAvee0UGW30zBgEv3Eqtxv66Z6DGWzZhK+fyiEJF+AFELSD9XdQAH0BbPYko9xzIFBnA+BrsxEnkqy6qHcJDEiUqaqGDkF/xMhTATywV9eSMq56pAP235why+OW4igiLRCRw5CLZfz9AsvnKx7kJ7+sW8iGfu6zInOAuJOKzepbAoZJFVsIOHm2D80+QOMZcRTFdiIIuYH3O/98bEbxGqa0bu8UH0yeIDgqEBclhTfwsDgUNEnlqe1KJVtHIJ8qbnKD68zsKVGKKA66fW8vLZWyj/RpMpEpHEIFSKrljQ3wFkOw5I7WCm0C0PcBRpgDvIiGHrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RW4wrKNMT5fdYhr5k+mlkiFXMNoNQdqvxt+zkV5qwiM=;
 b=KuLfyBPN6JspJZkWPXrKfsvopbMT7VnZM+NWw8e4haSeA40bpQrsKpSUxJr04e/rvtxC61GAPfKd5591xWdPiRiirXmbUBnQo1uDEq9RBTcKPtAvVVAZ7hE2Fj2/LmVZVRm0jtSmSivelX5NlDkiyUHex0r2eqCCXJsvx4vJ0tlGpNbKRQcxWga6DlIHMFXVi63cqBhaRfucT6ymHvnqVQ05GZZ+JfsP1/SVG2jA4FyBC1vNnsuK4BjEfqJajg6CD1zM3WAPMnwnHqqZBV7qaXBR4grewmhkkB9UB2+w3gUDR5UFUG1c/gASH6O016s1INgPZmkqcTTKkX97lHpwBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RW4wrKNMT5fdYhr5k+mlkiFXMNoNQdqvxt+zkV5qwiM=;
 b=qN/jiSVbiz05TwmdlC/x78kI3PquCL6wBbI0tQPAQIrhsK0h+5lMWaA5F303rTj9dmjf57Eoq4FfIlma6dgzVhKtdhz1U0F5ZcokWZeZy/mYSOe6suneRVc3WZaMK/THQKuuO7QUFCTcNRcleNkheEfLa+iNWrLy68MQ/hfKPT8=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SA3PR10MB7094.namprd10.prod.outlook.com (2603:10b6:806:31b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Tue, 5 Dec
 2023 00:15:53 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::517b:c692:6b20:19c0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::517b:c692:6b20:19c0%7]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 00:15:53 +0000
Date:   Mon, 4 Dec 2023 16:15:50 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     muchun.song@linux.dev, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] mm: hugetlb_vmemmap: convert page to folio
Message-ID: <20231205001550.GE4129@monkey>
References: <20231127084645.27017-1-songmuchun@bytedance.com>
 <20231127084645.27017-5-songmuchun@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127084645.27017-5-songmuchun@bytedance.com>
X-ClientProxiedBy: MW4PR03CA0313.namprd03.prod.outlook.com
 (2603:10b6:303:dd::18) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SA3PR10MB7094:EE_
X-MS-Office365-Filtering-Correlation-Id: aad28495-4af1-44ce-42cc-08dbf5275819
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nesUNX3ghTQV7x4ZJ79OwS0ueq9f6qw6jpQjUhzZt2V9KbgC+RW+m2Mr8YIw2EGfOhlSwZln3g6DCU0NHPkCjC7rGASYhaA+uP+24mvUjsNpeqYnw+ICh6hoSmFiI5ManHQrME+rT260n1VQ68ihNO+5P8pjaO6sshzb41/OEjJTWmP27vdQ9wwhBtM4XZrBbcsBgKh/AEsQUhdPeU3DYzAQou6abS8ldq9iOfCL8cWe5AGqcyDNHxe+zDhAUWh4O6qw9cmYqTN2InyvIdCjqtRwd7yjI58E9icJAmya82b/yz4Bp1I1/B19/6AAU0k/MpmSkI0CL16SQ2IyHPE8scbnJRW3o8+uHF6JmtkuGtwQGptB+IWlivAiOi+mgvAU7W3U8Owh0xeAiRxecZEPbIHYGvcLVcBhGXjVIKSHRd6qzTb6NuKnUsFP6zjMEYtrXqO/32IXv83nDGT2rkJed4/ENmokLCsuCnAOFnm5Cj+OZv/rV4l5/jRYBy4LYIWZMBHMAnTYmqzTVbZkSC1rWkyv0yRpshvZIza6RVByfXw4im6pbuaZaytzDaQe8+Hm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(396003)(39860400002)(346002)(376002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(5660300002)(44832011)(86362001)(4326008)(8676002)(8936002)(2906002)(33716001)(41300700001)(33656002)(6512007)(9686003)(1076003)(6506007)(53546011)(83380400001)(6486002)(478600001)(26005)(38100700002)(316002)(6916009)(66476007)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?it3STp8Xp5Dy2I8QEPPShPDd1zqPqeX1hzRIpyEXyvl5NbQ8a16Z8yKcCOuG?=
 =?us-ascii?Q?YnbYXIQalFGRkIljT2QecYnlkvQMbYak/g7QA57PNdoHL1kRpLexMB300i0Z?=
 =?us-ascii?Q?EmDXopG+/NMJlL+9M4jyv+DIKD6XSTHtOpJIMalJJx/Z0eSD9HEigwuC6+1G?=
 =?us-ascii?Q?M/wh90Es7RUhYLCIAkic5AVm2T3/doC5PSVqmyNG1Mm+EBSjGX41oAY1DCE/?=
 =?us-ascii?Q?du0YWtKV7kC2FEyGqzVelM4U1l8UIy8bwG9NX/Q4i7K8S8qL4zv8x+70DTtE?=
 =?us-ascii?Q?fucmNISIgS/d3lHPSjfUKnuyQtZk5QcOuwtKnBN362AM1dXKH4c/Wl3Dh0Gy?=
 =?us-ascii?Q?yIfI4g9QcuZicNGCXSTpUwBTFazhMAi9Axgba5AuirFCGYMm2cOz2/xHPf/k?=
 =?us-ascii?Q?SmgbYtE2hXwBEI5q97/QkVa0xZkfI3K1ErtHxf3aDeh2hRY6BuGXZwIRTH3U?=
 =?us-ascii?Q?/1gQSZhd5lyXl//JVVgDWCiimYCQqRD8q0mrlzbrR3cl6fA+MhZ4rA9W7Ddy?=
 =?us-ascii?Q?37tFEZOiRlY53uDIqcJ+BPg9nDKRs9bEMOhGBgYVuW229zJ6b3Im/o/SnrJE?=
 =?us-ascii?Q?xhJ8xjuBFPbRtzcbZ30FaGWges/2PAbMIhvXEalrGYwQwdzm+dJ7/lUXgwGf?=
 =?us-ascii?Q?lH3z+3ZW/5tsY6jUUZwc5ZVpnyGUIXhDAKjuB1OTy5GfZ0Si0vFXsIKMWzbH?=
 =?us-ascii?Q?/OBoIquUoGOWTDAGRBogKFsgBiVVesXHmSwxnflZ9cdd9kp3FQTSemloxaKx?=
 =?us-ascii?Q?KK2e6OUL/XK6BudxK5tPKZsgXd9A8ewDHTlCEncEAUlBjppdJsBkQuivdDXD?=
 =?us-ascii?Q?Sc26Fh2lfGmb8WaEqiwZnNHRUksWuglAaooRc+l46MoRhO3Ma/4/3/GEyEjC?=
 =?us-ascii?Q?Az4Ek6mwnmi26SWewdWW43aGdMRoqmvdiTBRSUh8WdmkfWvchm/4XE5uE+hh?=
 =?us-ascii?Q?K22I8tuEoYFEd82TQgMwajNHEBxYB52C9pQR9fbMK8W8ramVtlJadDLN67hF?=
 =?us-ascii?Q?KYk8bgjNEAik2ml88pdDady2uLCJPp/9ZbEcVLH4usqgNoy2YV2+vN1d6KRn?=
 =?us-ascii?Q?3XjGk68+cnA+5HYgmLlKjYtVr/aRwToX/HCQy49/MJ02jqjUjdbXbuyiKIJF?=
 =?us-ascii?Q?K4iydAaslM1IoO2IcQ0/UoNwUvAzQg7mjMroRHYH8duMheb6VHIIk7TjN2uk?=
 =?us-ascii?Q?UcS+yncyiRXRPBkOuyVzqkAW/y9n8kY830tjRlwB7CBA0txUVRFPskyYx/7I?=
 =?us-ascii?Q?sxUO8u1ls4B9h88ZGVvTBXfUwUi2bil0aFkguDzjs1YrUxL7Ys0Jz1Ft7mgc?=
 =?us-ascii?Q?4/0Tw+9C5enmg2ybcScpOQoJhr6aAztSdXPt2BmRFgI2eVL2JWf25+3byux5?=
 =?us-ascii?Q?+nt/LIbZK6sfcot6oyeRPDyat+GGUy8TEV4WrtG2xeQwLpx0ZLa0BghtFakg?=
 =?us-ascii?Q?ai6xLSL+8D1kV0nIYXkSzfQzafD89cGN/K0XXR7d8LzZCal9igd49Pslf1U1?=
 =?us-ascii?Q?oJsEq0Kt7n/OXpouXJ6DsbapGlp+WaGjQhHv9p38JtKkAAEA9UZZadbMoIf7?=
 =?us-ascii?Q?uiVFQz/bXqjVh28P9abZxrvE73PA05fKdBDnhXQP1fJYoJNydfBuFY/L7prc?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KTKHi//0sUH13ihBOR9E5ox/pviHVmZgMK3aiJHmAVJu5kKQ7rtfju5lmR+FiOu1XGbeLdSNmTyjsU3RbOxAEFZERAlXA2SP98Oujl7feG8xr5pSTaARhfkLUOV8xwpM46RNwT6ETgAusIIDYZ92qSmofHz7QkdlJ8l26jc3WIcslkLh8JkRfkiev+sybMBOLqsLBywJ8lMjpp6VqMCcWzPrLgWpGKZQ64j+ChOGLRodkCbFFxH2ihjhELTCOVMBctNlY8+T/V65d/enbA8xj+Y5bYDC4iA3mA+Sb2xQHH+rpKhpTx0d4ntfdm8G1viLcfJ62gM76U+OR+b9jLAA5xg62lPhb3rYrsDLTxlVeXgpBgyvOejlUCJD9Fgb+kRVT219YLuD9GARjj7N1rHMhE/6AY/TovJNPrssdc8Ug9VL+ipYDfO+CZgmFO7JmGOgN20rLSIJEmn1cLVSHioqNeFUF9qGqzu+39OJHLu1DywNIrtRo3146bnTysYT7n22MuO+1fs9NSHzdkH8as4d7t/DhpE1J0FRvkhmzMHy9AJKloW5E/2/JYDGLukSnXNRcHvn/R56qERSmCkWsrCE5S6zz4+6a40WqcLSm3NL3tY26IwLc0y5udae+a5CfCdUlDFjsBc/LZAyCOH4ClZSUsr9hiE2ItROH9ZTHBSkFtwX3fylwOF9f7u8NvC2yRyQZMWJyKmPgyjHHWJEUaszeDki+jzyI9wGN6gVFojU1pJdGMutubxjK9HyXNnqct0UgyU0aT4TQYCGyTlrJHNajJn0ygfeWF/LcXH24GHM4zKq9R+CEKcz54fmlFMBnGQcOCzjJeoHLuiduPg/MD4WIkmJYs1ZmlD+G1A5CgOGDMj62/vMpWHav93DBao7rzy9odjJDj17JPskD91jVwzBAWW+0qtXctBDjtqlZVppZYA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aad28495-4af1-44ce-42cc-08dbf5275819
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 00:15:53.5426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jxWHCr5aVU3DRUqTc2B51ytpzayxTXK3Faec+vtnvSXk/k7Orl/+nnquE5vmJ+BAz/uX+fkoQpBNLOPen7jtyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7094
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_22,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312050000
X-Proofpoint-ORIG-GUID: sI8RZx8kbbSEYJcIapbotD-IWReszCvc
X-Proofpoint-GUID: sI8RZx8kbbSEYJcIapbotD-IWReszCvc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/23 16:46, Muchun Song wrote:
> There is still some places where it does not be converted to folio,
> this patch convert all of them to folio. And this patch also does
> some trival cleanup to fix the code style problems.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/hugetlb_vmemmap.c | 51 ++++++++++++++++++++++----------------------
>  1 file changed, 25 insertions(+), 26 deletions(-)
...
> @@ -535,9 +535,9 @@ long hugetlb_vmemmap_restore_folios(const struct hstate *h,
>  }
>  
>  /* Return true iff a HugeTLB whose vmemmap should and can be optimized. */
> -static bool vmemmap_should_optimize(const struct hstate *h, const struct page *head)
> +static bool vmemmap_should_optimize_folio(const struct hstate *h, struct folio *folio)
>  {
> -	if (HPageVmemmapOptimized((struct page *)head))
> +	if (folio_test_hugetlb_vmemmap_optimized(folio))

Nice!  After this, there is only one remaining use of 'page based'
hugetlb specific flag macros.

	mm/memory_hotplug.c:            if (HPageMigratable(head))

When that is converted, all those macros can be removed from linux/hugetlb.h

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
