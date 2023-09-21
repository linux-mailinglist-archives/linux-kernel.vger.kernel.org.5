Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C727AA584
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 01:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjIUXRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 19:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjIUXRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 19:17:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFA48F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 16:17:26 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38LIsngS009319;
        Thu, 21 Sep 2023 23:17:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=XuAOiy2W2jhrkfOwR1reEYDzhMCp4i+zs74aaAYsTCg=;
 b=eSC9DJccA3cCFDQE3G+eW3DHjqzWqIl9onXUaXD3Siv2CUMaGcsValtfJjNUBEWRqicI
 o9NBJoKAq8UTcc0ZpJxzJSaIdNHG28lmejjm6N5ODbKj8oxoOVwLK2Fziemwb5lp/tsb
 BKsTMWu1anFFcNu9Qpfm14T4prg/yPcZVX5Vz9i1LHrGrR2ufwDz+MrTBqiRKQ3UCxaT
 09RS1WMkih1igiDS8k1SLlhln72yz8zVuEY0R+iZsMZMyljqJClAdDQhLuYhqkOKx4zn
 UUTFfG9MMIqIxWSGYu/Bp7oNTqiY2dq78bMCoZKj6VtOGI5pr4maHFvaTMVp0OjCIqJH 3Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t8tsxrfnx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 23:17:10 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38LMgNJu015626;
        Thu, 21 Sep 2023 23:17:09 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t8u0u930x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 23:17:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQxcIm1Z9CvR3DK6V2wI43YorXenxbcJYv923gpBJ1sk8I3CaY5d05JYM5nDeD46nE/unl8MYPQDpmasP7Tsadh20QVkaB2FygmZq5ytIOMn6DacP11j2CEdxx1cZ4OyS/s1R2jE+rFng3OovNT6oxND7ETmmfEDj7Q7BqfF5Bm3SqSgF37dJBMNwuWLG5iy+VRKDdrVeHPMce+noZ6GuYEHG1dkRfNGiGxoCt4yHacubmK6GV0Sz9mBulpgS+6xnAWoXA9gSwDgiNGCDM+KlThx2L3HcpeDMvoU0U7Vkd9Teif4bf3axDQ0HesI71dSPWOWdMuP/a9WpVpdPFLzsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XuAOiy2W2jhrkfOwR1reEYDzhMCp4i+zs74aaAYsTCg=;
 b=Hw3H4go4Pvra0coe0hnwacRvfyhe9UbCA/lWYh5+5trnyN2nrrE4+bMWh9o9cepM6wmAftLGhRwvZeOxvfeMHn8n3TkVm9Y2V/QDlwQT544ZuvQr0sCShmPhvj9oNCMyVdmAkr0yBxf/MBrVFRCkluXk1O2Qnbnek3vGkx9XE1xDLJZ33oikYDAi+dTlRAeATN7fXK9gSgQh3C5vJLKmHUsy1CuAJBFjK7VtK2zOMwBUmqj9tPmg3pPZFG7ZrxvSNDbpnbhknUQb3QLrY69NN567XtrpBsBoR6bWCWLlT/6uaQueTbCoMWS25hO0Ev2VEKKcgHJV6IzcyX8lrqYFSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XuAOiy2W2jhrkfOwR1reEYDzhMCp4i+zs74aaAYsTCg=;
 b=XCWzFLTpuY792XDUgXHP2YcmclY71ALn9+Pz7uIytHL88osM8TcL2OCUOiyD7ZbcWAm8oR2velX8O7C9ur2FgRI99GuXZ/61Nnp1djib646TpjuL2W1DNuMZziWmMdi/Cnm5kzB7goDcIEV6BVfEJ13UPU4D93t7wKnjzgZohYs=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH7PR10MB7034.namprd10.prod.outlook.com (2603:10b6:510:278::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Thu, 21 Sep
 2023 23:17:06 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 23:17:06 +0000
Date:   Thu, 21 Sep 2023 16:17:02 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     riel@surriel.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        muchun.song@linux.dev, leit@meta.com
Subject: Re: [PATCH 1/2] hugetlbfs: extend hugetlb_vma_lock to private VMAs
Message-ID: <20230921231702.GD21193@monkey>
References: <20230920021811.3095089-1-riel@surriel.com>
 <20230920021811.3095089-2-riel@surriel.com>
 <20230921224201.GB21193@monkey>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921224201.GB21193@monkey>
X-ClientProxiedBy: MW4P221CA0017.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::22) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH7PR10MB7034:EE_
X-MS-Office365-Filtering-Correlation-Id: 132098a4-5b7e-4621-51fe-08dbbaf8df1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5KEMIXpMdhVl8GzUlE3r8ZoOEAxSkCZ2pzEv4nemBPcwlSKF8tnpUC9/D5ZItwEr/Yuxk2l+rP1DQJIyxaQkFF0dUmQfrgzZL6QcVCd8Pz79POUa4WsCDOGsIcKu3TZhUHtXD0ug1MRiGUwOy9ThI3HzCBvzMd+InfwFrLqnxkkG6IEZBkELHKKYWz+Q1+AebunmZZoC6sLnmMFcqYkku8oyXzrJyIhyT1m9M+sAT5KZVijg2xFgbGEkKbpUQQsToCEkXYyzwKvIHyxwddyQTQO9nVCuZ2nWlbT99x3P+bsB44uy8w5I4TgukxAuUAu/sZfBF8NX7Kikwgh/IUK/r7ib5gQggo6xvM1fW/gkIGN9+Zapll6jjaWH5Lh4Fu6OHHgcMhQtKc+ihIqLsQxOPYEkcEdDtRVHVN5oKLYBNQiHAU8rRuoW0UUX1/Z9pEOOIwhsyIn7g1MRXGKLCyMmMlxgjOz7CYaqXyQb8LEGbBQ1tJumUXb925yrzZYMvaLP3IvGVikP9OJp5Ha75F2TJWhyw20CAZXlrUwaHEE6KpXLijXhLkWtLyC6aRDjsUluuddQU73kMBqf3i4mDCgwePfo4HyPVfCOO0Znw7w3mhw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(376002)(366004)(396003)(136003)(346002)(186009)(451199024)(1800799009)(478600001)(6486002)(53546011)(6666004)(6506007)(83380400001)(33656002)(38100700002)(9686003)(2906002)(33716001)(26005)(6512007)(8676002)(44832011)(41300700001)(966005)(4326008)(86362001)(66556008)(8936002)(5660300002)(6916009)(1076003)(316002)(66946007)(66476007)(505234007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gvz8lUKoUyAd6gI7ajrLAYtCEZWtqhR8onuNJAKHXA5PAcF9Ndy9/002yRX8?=
 =?us-ascii?Q?ez68rAUZb0nIWOYdCc7hTj/ksolv8pvLfgT6sWuWLzWuzNlyJcCSL+wt5Lr4?=
 =?us-ascii?Q?29H3JyteVhpb4YArAU/A9esAJ31AfSK6cbBOWG75+/xY2S9ztx8WDb1vPNcc?=
 =?us-ascii?Q?SD3SIrbzi1DgmaFyNbSMKJB/yip4pQLJ5hUMKnSpRLyM86H0IImh5kS9zWOT?=
 =?us-ascii?Q?WZ//QwNn+/BahLic8sQnIFtW+kG1WJhyrrGLd2CG8Z9FJciDTHCjygIdIWgp?=
 =?us-ascii?Q?rVnH+mbSwhFt4DhnsH16arBN5U9sNmCVR/glaa1zNAoG+IXXG97CVhxweBX6?=
 =?us-ascii?Q?qIBWQYX4azQgGqVlogkC/IZ77O1JS1YmU++hJ2HbCabSBVUXDyPI300mngNs?=
 =?us-ascii?Q?dYsFhGTG5n/9Y3bSzC6aSmCGOjKyYM6rLwCtyqIykK/4em+4TgcXOxGb7b3C?=
 =?us-ascii?Q?FpCP9aCYde9rL33aD55woM3Bf4TamEivsXivhT9UO5IAw7yVs9MBN+voKiUP?=
 =?us-ascii?Q?xrlO1TKBsFy+tCg8odXlAR1ZT0sAZgez3g1jk+PURFbIxqUTQCmiSo/PCOA5?=
 =?us-ascii?Q?xAVqvSHd4st2xIIg68AHceEN9+as9xnsm2maZsQUxUdikmq0CWAinUFGCQCT?=
 =?us-ascii?Q?f1yofS7WNTPdvWOpLhnCby7J6u6Qe1u/Y8kt9VDID40CmLs0xAt0e932jeR9?=
 =?us-ascii?Q?qLhpo2UIlqX3dhfkbsmAbhDIGmEIe4lZ0w1EkzKDvzMBRC5TRdCa0ENbyVL9?=
 =?us-ascii?Q?bF7N1TZhI01ENNNL/sFw55y4V+KEtnynsg9s3ipiHIU53Xc2+TiZ2YnTxVwq?=
 =?us-ascii?Q?OoQZD6iywI7ur0HNUn/YZ0/CsKlBpB82w+Nh9dnRU1Z8ycOw2qqP1El4usUk?=
 =?us-ascii?Q?zvyDdzw+tJo+4CXqTW7GJEB1lpnCFYZD2zPI95oT3GRpOyyvoXbdlwSiYew8?=
 =?us-ascii?Q?0zJ89eS2yQK3NaXT2qDmhznixRXmtXbvQme0Di74ebWl/+KrB7IJoAIm8fs+?=
 =?us-ascii?Q?Bpdxqhfrkm4OY1rZctRe0qHBBoSXdGooEH6+K+HbxNGN57dVo8ISM6PfLziP?=
 =?us-ascii?Q?DHrI8z9CM83R5s0u0fqSJqKggw8CScREI7RQEkF9sMTFZBuooyc3Hzp82ag6?=
 =?us-ascii?Q?IOXeiUK3z+GD65kDf0hNxixgvA/36rogXp5V68J5MsJ36gDc9pWLm9qXZT21?=
 =?us-ascii?Q?+5xYppwbpqSzM/IaHv/EQr4+pHh0rhM5cMxjlmJNFq1dwcREY9kFu9Ti61gz?=
 =?us-ascii?Q?0UthYpCgkRxkqO80wPUvQkE/FQ1uy58xh41rWdc4VlX4LKBu2/hYhJwrWa3Y?=
 =?us-ascii?Q?GRye9DPljcaNd76kzORVA967kexKlEI7t9CrUFoKaSwaocMWcrPOkq6o0GRh?=
 =?us-ascii?Q?9YUcs0o9TBm87K9KIG7gdhZoQLKjDYaOFEYEVGe+PG4q5fGNMRJXTX3WjtsG?=
 =?us-ascii?Q?O5V9KzBcDkJL6f2I51MKWJJhBk76T5BtdmPSkKQ1E4fZXaY/KK6Pgr63ZFVb?=
 =?us-ascii?Q?YC1NPSb88m0qui3ZIvOuzvScllM+4vMXaxL7tm4jDnVPBYNPSSOOWCBUyO4t?=
 =?us-ascii?Q?jqiJ2GjF7AoUeonwhr1WFhTWPyYT4k4X6ZugrnMOv/v1sePw1ik+h3xJt05h?=
 =?us-ascii?Q?Gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ys6TGkYiKBWib4aHoUNXdPYBQLTK1Q2oFCcW12E+xLZWsXIeEmXejHOaj+NT926tP58gnui17BdMox/x4KoBKG0rYzVLuOh6/ZdUhoUcMBo4hoC6PTZoAcEkUyd1vTMumf5WlGAG4Kk3HvTc4wwH/iNncGBAAQqO8bg/zqP3cJoo5feREKibnkPJY8hc2uHPsBgoSfOyf+JW8DRYvTyzV2QWMNjd7esNjyp30/yex5YsWY3JYIHULeQLKgNeT125shluFD8yM9cg0Y6jkFa3dpfMgBwOM6SKK1f4qHbvB/nu7XaVtNEDDrmn0PaAe4HvQuQA+9Do3LKnymIrEMPK6/Ul693J7Q0pM3DuPhHovR0tDe83HbYbG8uFmWDxL1CLAUmyhD6CWDcK2h81uww+VA1nlIOeS+sMw3n1aN/XjRz2SbPuqb3P8TgKut2lD5JmYrCAUn4Hjz7ZgZPEAJTxBvX/RT289Fje2pY1q4gpi45YX1VHApgrNz5E+V0X2mbZIwTGr1r9h6PvBXDQ2GFDO/y7ISGSLAlfNM1swzRpS3ixSJfk6KE79em56wS7bclpMnyXpnRHs/IgsKzgYDH2No2wvKE/pSJsmXf3PYi7zOBFfMbdU8NjP+FCdkLZMhaXCPODncQZbCGmIlFUJQEctInSsVrJ9uJ8omm5p3vwDm9Tvo7K1qmeKh7OUAzB3iEnrlHNyHlHBh9MCODMoZTHqm1GQ3AuZYAfe9G/hto+SmvqbYu0tm0wCnrJQcRTYNH6j45OTB0PqYD6zmCrHOybAcy8LrfZB+DmArbpEcXgjgF/P8Qq21SDmXVSGOC4s2vHXBzYJgvQWXi5Vo7kgbeVPwpgi/wESD5sS9Hn+ZZtiuI0liCL+Jru+sFTzR3JRn52XngBt56I2u36goxWADG1za3CaZyUeDZnyvA81KP4zyU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 132098a4-5b7e-4621-51fe-08dbbaf8df1b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 23:17:06.2082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5HEfcfuqJvtgtcsn7OpIllXGHCnjMyuHlrsP/BIxQsCld1RMZElzp0ml5weNNIu9EQLEcwZ8gdAx7t4I2TH83Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7034
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-21_19,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=513
 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309210202
X-Proofpoint-ORIG-GUID: Hjdxz2Wqef2a26151FUgrBLugth5LWio
X-Proofpoint-GUID: Hjdxz2Wqef2a26151FUgrBLugth5LWio
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/21/23 15:42, Mike Kravetz wrote:
> On 09/19/23 22:16, riel@surriel.com wrote:
> > From: Rik van Riel <riel@surriel.com>
> > 
> > Extend the locking scheme used to protect shared hugetlb mappings
> > from truncate vs page fault races, in order to protect private
> > hugetlb mappings (with resv_map) against MADV_DONTNEED.
> > 
> > Add a read-write semaphore to the resv_map data structure, and
> > use that from the hugetlb_vma_(un)lock_* functions, in preparation
> > for closing the race between MADV_DONTNEED and page faults.
> > 
> > Signed-off-by: Rik van Riel <riel@surriel.com>
> > ---
> >  include/linux/hugetlb.h |  6 ++++++
> >  mm/hugetlb.c            | 36 ++++++++++++++++++++++++++++++++----
> >  2 files changed, 38 insertions(+), 4 deletions(-)
> 
> This looks straight forward.
> 
> However, I ran just this patch through libhugetlbfs test suite and it hung on
> misaligned_offset (2M: 32).
> https://github.com/libhugetlbfs/libhugetlbfs/blob/master/tests/misaligned_offset.c
> 
> Added lock/semaphore debugging to the kernel and got:
> [   38.094690] =========================
> [   38.095517] WARNING: held lock freed!
> [   38.096350] 6.6.0-rc2-next-20230921-dirty #4 Not tainted
> [   38.097556] -------------------------
> [   38.098439] mlock/1002 is freeing memory ffff8881eff8dc00-ffff8881eff8ddff, with a lock still held there!
> [   38.100550] ffff8881eff8dce8 (&resv_map->rw_sema){++++}-{3:3}, at: __unmap_hugepage_range_final+0x29/0x120
> [   38.103564] 2 locks held by mlock/1002:
> [   38.104552]  #0: ffff8881effa42a0 (&mm->mmap_lock){++++}-{3:3}, at: do_vmi_align_munmap+0x5c6/0x650
> [   38.106611]  #1: ffff8881eff8dce8 (&resv_map->rw_sema){++++}-{3:3}, at: __unmap_hugepage_range_final+0x29/0x120
> [   38.108827] 
> [   38.108827] stack backtrace:
> [   38.109929] CPU: 0 PID: 1002 Comm: mlock Not tainted 6.6.0-rc2-next-20230921-dirty #4
> [   38.111812] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc37 04/01/2014
> [   38.113784] Call Trace:
> [   38.114456]  <TASK>
> [   38.115066]  dump_stack_lvl+0x57/0x90
> [   38.116001]  debug_check_no_locks_freed+0x137/0x170
> [   38.117193]  ? remove_vma+0x28/0x70
> [   38.118088]  __kmem_cache_free+0x8f/0x2b0
> [   38.119080]  remove_vma+0x28/0x70
> [   38.119960]  do_vmi_align_munmap+0x3b1/0x650
> [   38.121051]  do_vmi_munmap+0xc9/0x1a0
> [   38.122006]  __vm_munmap+0xa4/0x190
> [   38.122931]  __ia32_sys_munmap+0x15/0x20
> [   38.123926]  __do_fast_syscall_32+0x68/0x100
> [   38.125031]  do_fast_syscall_32+0x2f/0x70
> [   38.126060]  entry_SYSENTER_compat_after_hwframe+0x7b/0x8d
> [   38.127366] RIP: 0023:0xf7f05579
> [   38.128198] Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
> [   38.132534] RSP: 002b:00000000fffa877c EFLAGS: 00000286 ORIG_RAX: 000000000000005b
> [   38.135703] RAX: ffffffffffffffda RBX: 00000000f7a00000 RCX: 0000000000200000
> [   38.137323] RDX: 00000000f7a00000 RSI: 0000000000200000 RDI: 0000000000000003
> [   38.138965] RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000000000
> [   38.140574] R10: 0000000000000000 R11: 0000000000000286 R12: 0000000000000000
> [   38.142191] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [   38.143865]  </TASK>
> 
> Something is not quite right.  If you do not get to it first, I will take a
> look as time permits.

Just for grins I threw on patch 2 (with lock debugging) and ran the test
suite.  It gets past misaligned_offset, but is spewing locking warnings
too fast to read.  Something is certainly missing.
-- 
Mike Kravetz
