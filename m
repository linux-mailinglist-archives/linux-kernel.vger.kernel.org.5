Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09EDC804289
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 00:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjLDX2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 18:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjLDX2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 18:28:21 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7727EFA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 15:28:27 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4NJIfr016216;
        Mon, 4 Dec 2023 23:27:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=F3GLRhdUaHCoJBCfYfOc87+u6zgr7txFn4bM3mQ0aAg=;
 b=GvfBN8Edw9TD8zBBtBDjoko/lB/Yx5GBwGGSJeLgTTkYvylWcc172C7R3zePnvy+3Rew
 QZIAwUtxfb9BbukMlA4qYFatCw0Xsu+N5Thd+Vml/rfwMdiU3lEt3Ou3xIGCkFCVrESP
 yJpYb2TxPI8fsZLfVrcYYD6aOoRaS7XwxJgIXxg9b1Tv3TtgFDDTywS+/nv5/iwiPZC1
 4MS5JG8GPLi346nFHFWPda0kurMqlS+IqnSpD06UidSePiLB67zcNUkAyv+kehlEKB+W
 c9IkOsVRjqcTUuau2aLxd+i8Uvl8gg2O7rywIqa5a6XKsSGfqzauX4rfFIBEGUX7kYrb 5Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3usqq3r204-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Dec 2023 23:27:33 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4MJeXi014121;
        Mon, 4 Dec 2023 23:27:32 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uqu16jwyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Dec 2023 23:27:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdm29HLKg3OqeIMHmtEMllu3PWElIQH/cZWCiy0kZJn8/WN2XRekz2a5rSxKYc3vxlhL6SNCkqODafJ/SGBsRQWkviEio8b3mbWOkBTcAzq2fUXhir8CcR+L08J+xWVBdpbiNuBQjJifBdp0rLgcp0PE/UkXZ2PrDUMWgCbnSsCVbBbVLLQXSf1rIP+1Rp48nuVXseRc3cMeJl0Eg1KRVb/j52NwOhVKchGuOQ2qejrf0tLUtSjbPZBZ5f2S3t9wWjp6kUnJh+8wP0IBp0EZTFKiJ3bTe1IlDQSdxBrsII0EVznuzndnVxwyiyHuTix4vpuZKXRHyhI2wN4I/WyhKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3GLRhdUaHCoJBCfYfOc87+u6zgr7txFn4bM3mQ0aAg=;
 b=VFScymJuLzXvtDd2+wg8b79C4b/URs4FKH1EXFHmPx853ni+PV4ww2uBd1UfMeG6Nme9JmXYWuDnMY1ysTP8zqt0txqbN5DK1Yl0eTE1EF4eGC4dx7FMs4/vCSbF9759yjc+ZHGcNKRUHZROT8M/1AOIJZQrABzpgBOkLEjEd3JCh+QdombDrITAqvWUggj69YmZp7qhyOEQv8+2guo8HrjC51nHb6hQDcTw39ZxiPyWfVSct2RQNU8wLhjQggLQUfx26mH/4b3Yh9jBIRBw2+XPsyISO0Mzg1yB6yf+WeM9BF8Fq84+ZFtv5l4ozwJebnmwMIOW3PEXP6sHMo/5Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3GLRhdUaHCoJBCfYfOc87+u6zgr7txFn4bM3mQ0aAg=;
 b=IKgROR1DsfwFYGbhlxKjC6hRI4IdZHJJpKalCqJhZsLd7PjFkGI7dN9ZXRZYAFyJFiom8UbNOpa/n2jZ7J2gfDezLTr1fykn4Lnu+7SMh8fFJN1IhcyPgvh+R206IDBtxAAfDu6NJwFpJ/z87hIEShkdXwidJqhMwIGQHkIQsDs=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH7PR10MB6284.namprd10.prod.outlook.com (2603:10b6:510:1aa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 23:27:30 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::517b:c692:6b20:19c0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::517b:c692:6b20:19c0%7]) with mapi id 15.20.7046.034; Mon, 4 Dec 2023
 23:27:30 +0000
Date:   Mon, 4 Dec 2023 15:27:28 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     muchun.song@linux.dev, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] mm: hugetlb_vmemmap: move PageVmemmapSelfHosted()
 check to split_vmemmap_huge_pmd()
Message-ID: <20231204232728.GD4129@monkey>
References: <20231127084645.27017-1-songmuchun@bytedance.com>
 <20231127084645.27017-4-songmuchun@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127084645.27017-4-songmuchun@bytedance.com>
X-ClientProxiedBy: MW4PR03CA0154.namprd03.prod.outlook.com
 (2603:10b6:303:8d::9) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH7PR10MB6284:EE_
X-MS-Office365-Filtering-Correlation-Id: bf9eee4c-5624-4ff3-fe9c-08dbf52095e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QD0JSU7JpP6e3fR5QcY8enVPdHIShp8D03C7Q+vroictk4snB+Jo50Ufb2bZZA/R6O1cd5VqT9g3Gws+/sH4EF2t256yVSwYY9W56M5ysohyWI2HMJA2ZgFG64kTZEXH5yFfhhqNmu37WgKADKe6gU9GVOHzB/GvsSUxbSlg2gc6ajw7U2Vq/L9Rqm8piryQ3fvK8s4pl+wyQqVD8PwZni/9t28KE33oue4FmwdlpruaSnyXyYI2gFn38cysYTBQYKS4RjB2GS9vTombFHGoHdZhdRizxiqg2fU2h7tnswHspI8oTBX/HkKNHO5/gPFUnykRWocm7uAUHfJpWWUjQIuwipDaIbZeGBYzHPwry/rYyY0dWNe4ak6a2BftYs5axaVDmUE6GrEbnV+Onx3MpWzPNO4r6y/lX23K/7IqBAWzavRXSxzZmV0A/iMuZwlkiiWZE2sUbVMFP6/j2XPCoRm8eWI5Ly6BIeG36Nqs7PvR0/eGJeHWSfUpDCKIoZCfeYz14jHzniGF7E/TtVuPWlJoVALmDhUOIT8yukLjQe4Sxewoq4aArvtcuDSckqdS0/6NPG9t+Ar+T64VljiPotHvaEJElBPlNa3nt+5cFeA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(6916009)(66476007)(8936002)(86362001)(316002)(8676002)(44832011)(4326008)(66556008)(66946007)(478600001)(6486002)(41300700001)(2906002)(5660300002)(33656002)(26005)(1076003)(9686003)(6506007)(6512007)(53546011)(83380400001)(33716001)(38100700002)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CS2U/nUbHcXFXiuUL4FzDfcxNAn/3isMlNe/gu4ytqjN8XvAHUN7pwE7OKMq?=
 =?us-ascii?Q?fv9DMzCeIJnWVAAhEjpBR57NBzO9a21YnkklGgqlgao34QPK/0JAjzmLeGJr?=
 =?us-ascii?Q?kwgRLn6S0jNyaHOpeGPGnOdKVqw0moYhhOpULyoeGA8yG72uOuV+j4ufgzmL?=
 =?us-ascii?Q?MVeY0kIXaYBVFnOHr8kw0k79YWEzc8EOyzP9Fr1vM/3NZ+MyMZ3hvzo1yNYT?=
 =?us-ascii?Q?ydmuywVhq0FR8NxFDrmC+13tC+7/GrtPWe/76td8u6ndEpalZpLcpjklCMTW?=
 =?us-ascii?Q?zDMeXGeQpSZv39xI1CnFK+a09uN9PS72aUyQks9yeB7dpqcW/I0QAk9HdoMy?=
 =?us-ascii?Q?A01exPw5SbpTqkBc/qA/LsQ46yjho6oWPOsKCP1HtWDHq4EclhkyUMMHEx3x?=
 =?us-ascii?Q?Wi5IpkVwtbdL7fYfZIJvO61O6NjB5+hB3wsZGrfy6800R7ceH06WBm2fsCl6?=
 =?us-ascii?Q?9fhQNqzOkfYzJ2l2fzU5h2OADUKDSx66Z8Qbh6JF94sPv94macbEk1PAGg16?=
 =?us-ascii?Q?eSHhJqFuwcXUM28+wevVq67rF3oty7kWzw2OEi6++QDHJgk/2rm+/+VczWi3?=
 =?us-ascii?Q?CJY1OyYbtuMVBS6kz//p080TYeWX82kPwhWp53pYWX0RpvQ1vhtv9ZvLtj+C?=
 =?us-ascii?Q?/ZbnU4LAeRcGu+6cmiOYsxIGpas0CTacWMatgBzMzbYcCkIeWG+1HS07BpGd?=
 =?us-ascii?Q?O09U4o4KznZ6bOGdF7D63PHOM6sL/gbFeVqLsQJ9jSh8zP+oij1fySFcQXJb?=
 =?us-ascii?Q?sFHuf1Hq9Imd8Vfuj4mzKfjVmhL7XsGZqNVPLDJqSIHVqqKBzf+WuPt6cyDq?=
 =?us-ascii?Q?tbJkXAlYQe6Bd1+UbvTVOFmyhX8/V8TjCgFj+4Z6Ng2eEfaNqimQdL6dkLSU?=
 =?us-ascii?Q?DmYmD/jyLKRXyWqvk/RVcVq8I5OXo83f3++DIyB0fwlQNMaaaKEc4nNE4JEe?=
 =?us-ascii?Q?p+JYGKJU3p2pVeh79+tmne3/HPmGvJcVg5qxd1EyOQUPH8Etrqgh2Phj4Sj/?=
 =?us-ascii?Q?3+O4j+XZlQsxMxIBGDFq5a4cQcxVAxb07fx/mDpsbnK/OIBfLJrb8+Tcn4Y0?=
 =?us-ascii?Q?dv8y1G2b1R2PT8r+E0kA4Y+yCHQBnjXs+y1XW8XfRYFipgYMBWzYNRDX9uZc?=
 =?us-ascii?Q?pCqP7RR6eaf8dp7+QAuna29jLaQXkwe2YLJZaYrBREnaM5vRA5met3k+GQMO?=
 =?us-ascii?Q?EPrRVTlNtCx4/NbVOzKDdRiEgHbohECxYqrQNSuXs5EFl4HF3OQ8qxNcT9ur?=
 =?us-ascii?Q?YP8NgWrBrlyHONXU/BUXe1LQdi/EMdI5TCBE9XBamqCzjq/FmGh079vFlkLU?=
 =?us-ascii?Q?ziRvmo9w7FLfv6ncc7uereht4b5UDB5WJkuDkWG8sagj7iZAA5uDCXl2w141?=
 =?us-ascii?Q?Lcvx3HAi53FRc2rurXnBM7qZA8XphdDIWsdff3/tUs6XM0mxC59EBb/Qyh9q?=
 =?us-ascii?Q?w5oZsxgLHsnFviyRAF3EN9CmYaF25YijhDsz4wPuEdx4NROi5lz0g3UpJkvk?=
 =?us-ascii?Q?au59SG71vtt1dL859kBao4+M9Pwq4fAuFCYrQCSEcMtKh8o/8Fyi41nCx4H9?=
 =?us-ascii?Q?19IYKhOr7SLlySfI/TYsqe8tFvrOxifFq78JHeT+bTvKaX6jRn895ahc7PAJ?=
 =?us-ascii?Q?yg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: goNC+A/QiAI1K3HRCvfhm6Q3NqeweRzotLY0ejWKjlmmyfd4hZR1fOgMX28mgJ/J6alWPhpS9nk/s7KdBEz4NB7yGfgPE0y8uCL4BUI3irtL19sUYWYwvAVCLTXUxh8bjYIG2mj3ptD9Q5eVttgFKEGyt35/7z1mWHeaeOb7rhpVi3kG2NeANOKLrdILa9V6uPv6Yu3NIYPxgyKWEm1TuDt1fKmth538XkZrJaX04XlJAKfnbov6idXeHp8+srwERNx/ZL1sI2RGyLvMlFb5XYZ2sHthHTi0tSo2OTBwunGGhPn5Q67PNHRSu8lU4FWMNcQfWFfasXNKk8zk6cy/9uM5IiylQe8qUa4QtEvGqXKA28JOIMCp258g0jlpB2bCNmGN1cJ1P/b50kH8VHBLTh3N48EmF2szh9qhjFPi2uU94xzfKOjs3YzAoALTp4FbKo0+CrFWgZeM42F1joDJ8qMZuzB3poncab3W9Y0cJm1W4MlRFCYg2wDZfpa99dIPwFuBcVyWZRo7QhkNfkHgtvEYwcQYo3M5joSe9VyZPJTlQgK1Qr6STGzw6hOgvIjlCvMVxaVSt20ajC22nM83lLA3+D4N2oKHIgAJ4zHYDucFW0xFM7R0XU1AYwChLFQ3cnEjO2TlE1gh4l2K16Rcmm10i39ddmoUm/fC8PndA1Z2Yy7YxwHSHDwoedM+98hC992opnwqyO2mOdUawqdPA/VG/Eh0aw1OLfp8pfoN+J/A4sHjVE+D5NEQVUhmsZ2h1RIdKli5W42OikOnTuqsOcJrFwis7g+9uXmXJMAaFY4rjPFy8/YRdKNPUrDK0TCyfOMGIhRO1NyXDQhCfwsrOh4N3LbUBAY9aZSMhDPFOJ9gfd4Fo6ERRE2luWu/0vx/Q7fG7YqCXGKTr/chGPQ2GbivH5BlHbosKZ0luzIeNs4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf9eee4c-5624-4ff3-fe9c-08dbf52095e4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 23:27:30.7181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1A9w92jOfLq9q7uSs9E3iTEX4y8/Dk3ShXzzPArTEr1ND9ysh5iKiLIy4yQ/u6HYAq8TPgzavMHFzlfV5NmJGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6284
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_21,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2312040184
X-Proofpoint-GUID: 8wPFlSGbfw0mIfq7xmXifONhnQRbr1is
X-Proofpoint-ORIG-GUID: 8wPFlSGbfw0mIfq7xmXifONhnQRbr1is
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
> To check a page whether it is self-hosted needs to traverse the page table (e.g.
> pmd_off_k()), however, we already have done this in the next calling of
> vmemmap_remap_range().  Moving PageVmemmapSelfHosted() check to vmemmap_pmd_entry()
> could simplify the code a bit.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/hugetlb_vmemmap.c | 70 +++++++++++++++-----------------------------
>  1 file changed, 24 insertions(+), 46 deletions(-)
> 
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index ef14356855d13..ce920ca6c90ee 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -95,6 +95,7 @@ static int vmemmap_split_pmd(pmd_t *pmd, struct page *head, unsigned long start,
>  static int vmemmap_pmd_entry(pmd_t *pmd, unsigned long addr,
>  			     unsigned long next, struct mm_walk *walk)
>  {
> +	int ret = 0;
>  	struct page *head;
>  	struct vmemmap_remap_walk *vmemmap_walk = walk->private;
>  
> @@ -104,9 +105,30 @@ static int vmemmap_pmd_entry(pmd_t *pmd, unsigned long addr,
>  
>  	spin_lock(&init_mm.page_table_lock);
>  	head = pmd_leaf(*pmd) ? pmd_page(*pmd) : NULL;

I was going to ask why you dropped the:
	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
However, without the extra page table reads it really is not necessary.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
