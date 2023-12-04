Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8155A8041E0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 23:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbjLDWyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 17:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjLDWyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 17:54:21 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C53C6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 14:54:27 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4MahYQ018094;
        Mon, 4 Dec 2023 22:54:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=ebV+brJyCFcEXIasNDdAte3v+zTgBjXS7OrLB7FoB14=;
 b=fTZ5YK6SMhJ38soaih0+iDnk1jvxiAGDLLwnlaSpo1EWI/6enJd+AtFoOeawUP1spNVL
 8sI3SXXRpeFokICBnCWo3/whCiGL/vZ8JkKDdX/u1AZoxgyj7n3B4uimA1zHptUb9C/0
 cQSrQM+HtR84/gGQqIZYDbfSXUJmxhKovWZVM00yRVWQ2BZ4urPamkOpHOxhHmNLmLXY
 mSLsRLV1Xsf1GYeHJLy2HygvLU+rBO7wGWhoWsK9uXRnQBTrb9/f/XIvLmmT+Ma8w4f5
 eEYjO4i8mi74yTFQBDU8uyAWRSRoBFv9hQC6T8wYTry1eS1MWyjRGIA8P9gN4BUIfVf3 rw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3usqq6r0yy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Dec 2023 22:54:03 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4MIqAT018470;
        Mon, 4 Dec 2023 22:54:03 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uqu16gsxj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Dec 2023 22:54:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2vGdYyPprIukVakiXML/2C8jAYLobhKKR9nFBSbmQOStbcOwUKhn99icc27nAAlagNDJKj+XxgMx1u77/ADhsKIwDQLlmHeAaalAEqvbcXdKucEOPk/fE/9qZUWwEBCYgtF5S3S9+HrVetrnbwR/w3zRJQKrZxVxGUKJPi5aT6gPJ6tx4TNgz8G5PQBn/s+cpM6bbTkqfVjKu5+lIOn1y7ZCgJ5Ynr4E9i3M5e+Ojp3g6HjPVR55jP0u/X3UredluWvBAfo/dg9NEDtCpU8TDzx4sU9cRzQb8nfS6lqpQ2+tZr1nuujsOH2OmW399oKLj4DxXDfTtZnvTVu5u8Gtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ebV+brJyCFcEXIasNDdAte3v+zTgBjXS7OrLB7FoB14=;
 b=hQgkbNy1/ytZZVBNFRlbHmyhhMjh0v6Wyqy4s57AFfJAvG4XwsJ+hY6Ut+ZKr9973ZenojRi1DnlYQ9Q3SRq68XLvKVslKUcnoXd9i000WbwjD+o+dPHsf7uY1GjFD6N8iLMQzwUorjEKjXofR3JzmnS1BNMqKpWAIdSzXi/aGYNA2aSkZZ9L+TS9edd1+ku1vuDa5lff5yfypUNn9C0ZsNgR4/yRNm8watXQ+i+at21c8R2fq/5EPuuXpzBWG5HbaLH1KRDDOEZXIhebAw8+pr0bcDtSc5PIX89B4g6nPXZKoSNh5gUE0o0cfhcDGN+5278zE6gxk89E9gsuXX8NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebV+brJyCFcEXIasNDdAte3v+zTgBjXS7OrLB7FoB14=;
 b=Skzj/FZqWh+WN467KxiCi58kGWqG938fpDI5PrODL4UdqW2mdEtXBgLXHmKyASoZ+xO9Ikht3MxCtn20UiGSOjzBpdqSSAh7JBLqt0Ch6EOQB/RU94GctdkkBgVQPinBQsZJd2cTsS7UQmzT3spD3Xj0K58ltJKK0xKMzHMCqxw=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BLAPR10MB4930.namprd10.prod.outlook.com (2603:10b6:208:323::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Mon, 4 Dec
 2023 22:54:00 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::517b:c692:6b20:19c0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::517b:c692:6b20:19c0%7]) with mapi id 15.20.7046.034; Mon, 4 Dec 2023
 22:54:00 +0000
Date:   Mon, 4 Dec 2023 14:53:57 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     muchun.song@linux.dev, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mm: hugetlb_vmemmap: use walk_page_range_novma() to
 simplify the code
Message-ID: <20231204225357.GC4129@monkey>
References: <20231127084645.27017-1-songmuchun@bytedance.com>
 <20231127084645.27017-3-songmuchun@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127084645.27017-3-songmuchun@bytedance.com>
X-ClientProxiedBy: MW4PR04CA0103.namprd04.prod.outlook.com
 (2603:10b6:303:83::18) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|BLAPR10MB4930:EE_
X-MS-Office365-Filtering-Correlation-Id: 829a4daf-8227-4bf5-825c-08dbf51be78e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lLO3mqFBRkF6ft1JV+W7iThCTOD57lecDm/1Q2ta/XPNwnPEri9vceT6Lkkf6coy/7/Z9eiybXoH3YB5o7bcWuGNiKcv//85H94frFEGJ7gf9VJLjlL3lcu/THbGcp9Wgy1A9BiDRy0Mw7xEJockQXfYAzs4QWc0J3jNosju04g77lcxVJrmW+N1Cq8ahWDVz8hS38eJJL5aqIPndmqtft7wcMv4epcNXOfwEOD2PCs2NWKUl4WC9XxDHMSAmC5hRFNsGlAoPZIc3ySZf2SH6kPY6FqWrd3oOQl5et4moqlLLvdKmsIhsLie2MKapfGBLDvHCh2fxl4tvPESyF4xmvtFE1bslpVFoRTLjOBuvijZidR3rYpaa9P0OhyT8psa/mVcX9A5qPFYwaSWCLrnw/cYwmXShOqHiLBenWUOMYzQ4eAeTLVifVjet5KP+xal2zdqR3/7JobHePGND6WBFHPwDKjGwagSvvs4M2YGm+xlpC+CerUuFt9cIkAd/Q3ZqsQB+MIJcEmSodnZ/zYBdR8xYgeKpb5jXIgXHdU+dv1qpAgxpyANrg0LI4sLXUiz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(39860400002)(136003)(396003)(366004)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(66556008)(66946007)(66476007)(316002)(6916009)(478600001)(6486002)(6666004)(38100700002)(4744005)(5660300002)(41300700001)(33656002)(2906002)(33716001)(86362001)(44832011)(4326008)(8936002)(8676002)(1076003)(83380400001)(26005)(9686003)(6512007)(53546011)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?smPdB1tGfrAOYRHLURUUIOB7aTFt/968+GlTa7PEX6tyfaunKCjuM+O/Bp8B?=
 =?us-ascii?Q?HZv4PG2ZxH1P4UDKZItc/fBmqLrrbjA1eCLKP90t3x05gR1VS0F6pQybZLj7?=
 =?us-ascii?Q?zq9ZqAt7PQ+kJsxoj4iyj7n36GN4NvvHRjSi087ioV4h4OQ+tHT7woAPuUAy?=
 =?us-ascii?Q?E2IU5oC+zdPGu818IV2idPs1h5S6I/vH3uW6uFHIGThl32l9Mi451k9myzM9?=
 =?us-ascii?Q?0jBw2RH8uy0o/7JsARKYowHwTF3gAAoLz1jKJp5YiLOxw54NeSdDKzgBcOEq?=
 =?us-ascii?Q?5fHHPo4WPXIw+3oz+NsSLP3mOiNCKv/5vmD3ImIw9AeGZGE0VwabmaVKne4G?=
 =?us-ascii?Q?nJA2/JJwKuMNZl7i7Fbn69v2sXipohoUJKXjU4XOY8gXd4xlRfnOpg6oO5CS?=
 =?us-ascii?Q?R7F+lCQaQVC+0rP0eshsALZLeMJDlBZb7kTsS/CPCN+qskBUfK3Fq89avqsS?=
 =?us-ascii?Q?sYdSR6dqH2wERbHRmJNsqeeQ7UufDEw7HV67ahV2xEg2E0rggzsTUz7+q4X3?=
 =?us-ascii?Q?Lkrgxc+R0ghgYoV2Vj3bAF2hYhHBNqYu5MwdUJ5rLButs7+26XqfGnuqBTEF?=
 =?us-ascii?Q?8G4SO30uT6A4+IpGMBW42lMhMOEpwfPqhU34XwCD/e7PYnhhEPHLVoIusjIc?=
 =?us-ascii?Q?0RlONPvMZMe9TmwTOPvyMmnx9ZD32VIT+0/S32vzdWq7PtQ2fweGZ+kAJCjU?=
 =?us-ascii?Q?nuHWl2dofJS5+qvPmIDD74ZQSmQBzl1Nc2/WZeBg5PRm6jNto/9UofDcFtIn?=
 =?us-ascii?Q?F2ChxZN6RR4e4+JoHW72JuKd5oRif4qGElZF9bqdnpY3QXbrGwIdNI5LFzPl?=
 =?us-ascii?Q?PvLIZm2Gj/MH0emR6+9ZRbNRENMsqHH6h182dAAYepaXxH27wKEf8niKdcoL?=
 =?us-ascii?Q?hdOA7jtd9shBKhzZZ/uzWe9M99eQYLA+DzHMIbviAEUD65mF1KJvlw7sK8ch?=
 =?us-ascii?Q?Vakf5T9T7ddzsb9UbDxP1uV7oLsDx1rBzR7A45S+PnUeL7WQVaeNWPTJAT6W?=
 =?us-ascii?Q?10KVjAFlUi0wTxRTsFfbzVh//veoTZml4hT3KcYROjY4uMGUU5UATexDRzYT?=
 =?us-ascii?Q?/4vseS0rHhApCggowOXAFN0uPxGqbZrSF5XGGH1a0h+k0y0+DaWeFY1Kw93+?=
 =?us-ascii?Q?JoqfAKAhBD4zg0qBc+q5cx+1wyt4RVPKqxdM0kRcU+e8yd2PhoC/vCMtPo/8?=
 =?us-ascii?Q?mf8MAK7zLYNsTMedWv3usAmXcStoyTs4suzDVjRknNVhvBViNQRcL7xS1Mgg?=
 =?us-ascii?Q?rRAL/hLf2X5P6O1LpqWLY6TMgIQh8v1Z/BrwMa+3XAYeECly+ecunnO85eAz?=
 =?us-ascii?Q?6k0T53tD+XxwxRz05TQRBzKjj4t9t12wYjOvShsta4qCJK33AdCBTV1J5VMr?=
 =?us-ascii?Q?GUif0pyoryaRePtVKGOajH1hLBLNT9PEF7/sbVs17rnaLRVluPBXYFMZgELl?=
 =?us-ascii?Q?V0RumTzLei9zkTvXzdJVfY9Tdc/JdgckJk/brWEJelHdjpjJPn3EZ3xZ55W5?=
 =?us-ascii?Q?j12H0ws+l8uY/yNo2bMjl3GC0S5beNOcA9hYDC5MWfiRyyn1HOHhC642HLC2?=
 =?us-ascii?Q?4ukWbKKRxn7P7+Oawnmcvw8WAs6HJOVJpIL/xdMxqpdcSzTo0kYq5mtcjtgw?=
 =?us-ascii?Q?5A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EWqVOD8ZsXklKmgVkrg8Y+Q+Kpx2SJGms8FeCl4NX3BKOGUDmPTD/VZUb/khDrsNUuZgaia0jmnSB6L6o03vmph/1CZeW24YLUbQvDncc7Snfe5jGkOOtkRKAu3qXkJWwXnKJMx0yKIUAOpUl+dZ5p6bvyNcteoIbBt2gTWQvhqx8yi0qi5CZOGv2MifrCysVrJQpji7Yjc3Z4Qh8/YNtnxvjIkZifEyfhonIdaGjTXmbuhmwGVEVSJK16HsYXO5WDB8oM0ZUT8nYAADbofzvtN7R6yxYfu8c7z3orSouHAERiYQcROLQeXLbilWoQA0TrQI8Hw+jJWQHRsnEoekmvsn5XmTnF9chOme6EyLDLr4i/DZ5YbB9aJ4VbZ/9184AJNHVvrC9N+3plZTaxjUoyAtSIIchpKPTdvSbNTzgjPdvTRMsvyTAszem8pg/ZLXVF16yd0z3JnLiQC5QMlwt6pSx3GWsQXwX34vHVPgm12rgfuVhscw8rjZh+DVdOb6uLtQ8mqz0EKZAshDFiFQvR0z7VTI7u/uG5OBoXaaZ1lM86i5hNhccsppnHi3KJ2hSkpydquTND2a52t2+vEKAvc8TyteZxYo967WGVFyrXnOnm8JAwhzQRRnhp71OKu+VUh6SJ6nkzNsD7JYi1i+csfpNVCyomWyG9o11yMALM01ADp3yfvRaMRYGC7mb3jShZo5RBLGqDlopJuXTXDAOhkxPwaRM7SrOSO/TElZzsa02Rkz7lkHsRyi84Md/2Xt7aTA+smaOc3SbLjOgkjKWhZtztCFDZZFNKwpLZbpVp8bA0ft+bmsY0B3R/SQ0/PW/JMl3sUi/VynvHlmSfm/Id8CjhR7iD/1BmO2cUrF/hBBNjY82WaCS7POyhy6qdvw2d0sDstyblPNxJ3/FmKSlH/OrPd4NxugP49Sopy9hB4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 829a4daf-8227-4bf5-825c-08dbf51be78e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 22:54:00.3402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T3julh0lr5YXDbxoZBnwwUDt0t/KZD8AOtjOd54ETvJmIF5KMWiQJL3BHX1Fwa8fA3KG9zKXz+oSTXW7K0OJ0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4930
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_21,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040180
X-Proofpoint-GUID: gYAfawvRRsqJauXM62HWKrrBu7zpmsN-
X-Proofpoint-ORIG-GUID: gYAfawvRRsqJauXM62HWKrrBu7zpmsN-
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/23 16:46, Muchun Song wrote:
> It is unnecessary to implement a series of dedicated page table walking
> helpers since there is already a general one walk_page_range_novma().
> So use it to simplify the code.

That is a very nice cleanup!
Much code is removed, but I could not find any issues.

> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/hugetlb_vmemmap.c | 148 ++++++++++++-------------------------------
>  1 file changed, 39 insertions(+), 109 deletions(-)

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
