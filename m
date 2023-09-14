Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F40B7A086E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 17:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240405AbjINPE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 11:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbjINPEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:04:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA39E1FC2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 08:04:21 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38E8mwR6015373;
        Thu, 14 Sep 2023 15:03:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=uIg85peirKSGHe8+VGKY7A6LhDVklF09UuOftqJS2TI=;
 b=Aiex7mXvYis9U8uLN/OcGyWERmgke42hE5G0Mq0AsjrdmagQENX+cWeyoHkYG9eTorJ0
 CUojrHPlj1qtKC57ylwDFsnQpV8/wQ2H5vRl/39KoB6fPdBmSWhxz0jswzV9o+vz5Tdz
 FdJoqWcrlkNpfy8tOyfGr3qCxEOXLH+fFrek7WqfFso6JoeMuLWnz56Z7xbjHn9xz6cp
 IfFWId6utWr4hahTCnAAj/j0/hmQZ/2kLRnlX5375a4qZx9L9dtrhiIFvsifc9RfpoD+
 kdB+r9Agm33h7neKL8i9sSv2bOkfV0bZX88H1CGqtRJtNChEosa8PKOjH2aCECRLvMPp eQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7kdpjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Sep 2023 15:03:55 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38EF1txM036244;
        Thu, 14 Sep 2023 15:03:54 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5f331e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Sep 2023 15:03:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JVyzJL3YIPFwzOhzBJnS8drZMXdJI4miXvmyi7B2njd1pd/5QIMS5PmT2Fw3o6qMPUZ3OoaN3DGeA/9sWwr5n3ZQvR3qCN4Yl/aB3CDvT4iVmqyeXZedCM7kNuGQzFJ297ugSmEf0hXeuqM1eFfgVPfbkJ7vWhkeEK7Z8+bzI+zKX9Tl9rMlCJALV9sG+ySE6XH7GxZbPbNJhVwdFgshmAdxg/S83ichacHrX+uVwmfQESJNs0geM6/yJzeufFwJm1zuFCeQdEtUMSIFL4JiI6aBmvypkfLusynBO3d5BGYilMjTUJ2Lr3tBy6RYzbQBDHc+AVjcKpNF6qFjl6Airg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIg85peirKSGHe8+VGKY7A6LhDVklF09UuOftqJS2TI=;
 b=jSMVC+ocEGDYCuwS3gLURSXTUKZAJ7FLYTMwH8RxpZe3GIT1r6PP7SMqugXFRJGx9r3Fqm2Nia37+d68ZpVlgvRbB4nPbPIJQW6oeLijI/pa4VMDWpMIPfZgFQrTG3WYeLGBUaJJxLdNWo6tqjVs+v2QuMQCly8vbVqj42ryvdEtLSwr0paLprTSKS0LZfAixps//Yhb4iu+uwBL/EY6Gmwr59trDwro2UA2l2DoFRt3KEHHVLjhmlGWtFqBGa/Vr0Sqbwaoey+XqOv8ga75lipY4IJmIaL2hTCIl4ZNdotSU1xQe0EyxcSxOuV6tCpbSy8tZx3bdif/kxl+a4gQBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIg85peirKSGHe8+VGKY7A6LhDVklF09UuOftqJS2TI=;
 b=WSZDkJjieZneowCyGtkoZFKnYcqM9LoQT4w1ez1CpQ7hnIoUm0+4TgPTYmhmmPP7+NXVln05AewqNFHEM+YsOwNaxgfgatOAE7/5VAT7LNu21Xgd7L3NXmc8xKPOAxgWBngIT8DSwSCRLDsOXuLOJQ7vBlBy0KfPRfrJWY3AGRg=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY8PR10MB6468.namprd10.prod.outlook.com (2603:10b6:930:60::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 15:03:51 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6792.020; Thu, 14 Sep 2023
 15:03:51 +0000
Date:   Thu, 14 Sep 2023 08:03:48 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Usama Arif <usama.arif@bytedance.com>
Cc:     linux-mm@kvack.org, muchun.song@linux.dev, rppt@kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        punit.agrawal@bytedance.com
Subject: Re: [v5 4/4] mm: hugetlb: Skip initialization of gigantic tail
 struct pages if freed by HVO
Message-ID: <20230914150348.GA129171@monkey>
References: <20230913105401.519709-1-usama.arif@bytedance.com>
 <20230913105401.519709-5-usama.arif@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913105401.519709-5-usama.arif@bytedance.com>
X-ClientProxiedBy: MW4PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:303:8f::14) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CY8PR10MB6468:EE_
X-MS-Office365-Filtering-Correlation-Id: a47700aa-47dc-4440-ef57-08dbb533ce74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1ivabkR+p62wJeZ3iM8CZUgN08kKy4E+WW3crnmXNYzzlNWofHrKjfQP2NQ2o5AmLxJVDi8IBtJulWFlAhKKfg8e+PtZcY11IcKEARyyjM01Ru2q1DCzmlP6CEsWjzxQIXN9JAxT4xDfYcx7W8nsRPsrjDpDXalC0mmOoPQYc4MvQ5HsDaG55hApbRsmxHDEmPrH1tqeWGep+5EhJz28DSvEf1Vw+xLGy6aCQ0TLeyDxajsdCUThP34BjzbnEFBNsmdg6SRp9scUd4rNNC8J2Gqb/UUZbPr766dvH6mNoI14QqE9Qlhfd3qNNKsa+/WdJ5NdUkzdW5pbQhO8UOAtp06bXWECmPHCjc+WFHJLw4RNi7NQrWDmflTPMYMn5Z4tKCyGLQknj5IoGivlwCKBlH43MWohX4m0F5vFRAIR5uYsFRCu7mTq84Fr+WSBGODgjLNfwVfBviTk/Ni90O9KBxD4zvHI91UH7v6dfYBO8V4jqrJxRghiANVTo3nCtzm5+j5H7oMtBS06sl0URhH3M11VDCoXRdt6xPT8XgZ1tpc8BWzRteMi6pKFB3N37ziw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(346002)(396003)(136003)(39860400002)(1800799009)(451199024)(186009)(66946007)(66476007)(6916009)(66556008)(316002)(26005)(33656002)(1076003)(478600001)(6512007)(6506007)(6486002)(53546011)(6666004)(9686003)(38100700002)(86362001)(83380400001)(5660300002)(44832011)(2906002)(33716001)(4326008)(8936002)(8676002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7MK5reVh9ZUepIFUS6A6xWujm2+bv/7hESSWn7kBqXQUrNtqY86TtIWa0i9X?=
 =?us-ascii?Q?nkfBZsbgits2NWW8i3PYFq8/xN6w+eqZ8t2cPpFdk6CnPfUYyf9qMJ8jrUJR?=
 =?us-ascii?Q?OQL5e2VAv6/OZChJ1v9wTshARhKQEJf5EQ4dNNQuH9VGuXmYLhIo6Br61z2L?=
 =?us-ascii?Q?NaPL4Vp20W72IGMsurRIaK8wMUNmRi1a0qn4FwINOSA70SsXJPspGa4FBaQ4?=
 =?us-ascii?Q?wPyzstjkH99weuJIE3tR0pNhk9Q16aPXSDwgJwa/+Cx2XpU2cU+9AxlXuxzA?=
 =?us-ascii?Q?GsMDfIzgND0d2fnUHUxCUNVJbWd5k7q7CYvave775LNj4qhCJpUlK0lpjcVw?=
 =?us-ascii?Q?uJuZzhKEwj4frmQqsFu4MbQwAedgHfJq5iMeGOp8T+McyTVI5oewkxEA0vzR?=
 =?us-ascii?Q?cxfMDhOSt5zm3+ifMwLs0CDKp//UxZ/VBY0wGzXTjpOnQamXHNi7iy+mD5et?=
 =?us-ascii?Q?LulmH8oGdPc6Fav+znDlpJlThzpGZ2PFL0tQnTlcjEzuIOxW8S5Vr6fb/C+Q?=
 =?us-ascii?Q?4Sv9Ni/O32Vzc4cZ4uU+S7ZzzKIMdTBXW5k+CUJO0fLN9/7a9bWBkMsS+U3x?=
 =?us-ascii?Q?UYO+hTLLn28yzlOb4uMPAI1Wod+MgzF+Tt1ZVCkb2T3E3MPaglWkJJVWknsh?=
 =?us-ascii?Q?SgIImsuy3wCUcMcNf+hC7jB3JIkz9gi+ciNP1ANzMeLJbkfvT3L6omSvM4Ka?=
 =?us-ascii?Q?T+SpuuAhpGzy1taFYk/uu/wzpawzwvJBjuYCMGdEUC7fWJiUJjABE6YqxMNM?=
 =?us-ascii?Q?ikwX/r+kek0DRVxqsXQ46/uXpkD6CzKosfNcuAqLG7c3BTzfwvKbMdrVLf9S?=
 =?us-ascii?Q?J5pX/cYD2te1mc8rshLRID87PX639veSJSdGRVYaAxoU86zUN5IJSSrEWMB6?=
 =?us-ascii?Q?S5npW3d/6NuExVx2Y1ZfFzvea87uWPVlXryYAPwk40R5XrUBy+VjJLDWmTkk?=
 =?us-ascii?Q?+wYEW79gXnfCfLnH2gpudDTRkPHth0v1/5hlMydq7TIdGCROZqbDgiqZ5yjF?=
 =?us-ascii?Q?UhSvc1ycttsWZvJpsPRHcaUV/XaqDPOyxFonRKtUQf4eUhM5yRB4k2bmVwY9?=
 =?us-ascii?Q?s5NWkWYWExSWyWRU4acl01NSurAkNYxSwlBL6GTzloWj+WFacDi0bxMdvVOZ?=
 =?us-ascii?Q?XRsdsQ0+jxnf/oicPZpLsHcaNH6Rb1ofKTHpVAOWIV9VqYuoE/36/yGpuwnc?=
 =?us-ascii?Q?iGoJGWEJ6vPGNuxNQ1YON5CsgvhwppvYcT+cH08x9V+LxfQJ+jXVSTflyF22?=
 =?us-ascii?Q?CAFMh3LgylrrQv75Rx780fAqHOkjL+p153JQxE6auKBorvjbD20g2uZ+Du/v?=
 =?us-ascii?Q?Z/hTUm2g7BnFQdW2VohvWsIW1eKRWLllxdtmwwFEqSkFyibivJEYcGxQz0Jg?=
 =?us-ascii?Q?DWUg+XU62Gp11aWgFA+qBLlIksWPFdZ5xbFjU/Ll9acZArqn+tkNTJYWNLTL?=
 =?us-ascii?Q?wLfQO3z/gLTI5sI4ig4+b6pOYe1gXnYgSQOUUZ+/BK0F+KnOmifQVdVeYUAI?=
 =?us-ascii?Q?DAJ7ssw7tJoRmedUEfbIfbZFuHTP7LijHnPmVorNSthe5UkhylmEP33oG52u?=
 =?us-ascii?Q?/HquCjGzHAy3nO5KU4+YgNqrADRdsn2vFxxZci5h?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7wnrSSGsvQL4lFoVHDcKkvlBTp5MUsL98XynKRH3M6tP7sfDJveZWup+ChYSIEiwOFc2ZRPxKPm/Dr9nroxegEjCr6G49hppDT8Ey1KpPNSwSM6Go/XByCjczpDWEvGfZ81dJQCTtATt6BdzAOpN7JCnM8o6gM0NNH94sOHjYab//XFg49M5YvMJhjtXs+tsGfiFhU0/tRiYD6cYfGbCCC3KDXDvOspoJWmyf92P13YQ4wCT1FcEPSHXTktU2neVdVTesuPwAQgcV8TkOo/kwu98ene932YiulcrBrCop1ufQjPTRKCY90WvF1U/Ahuo79sWZLWuPkopFqGDS1h9fJrKdsf2TeBvyYacQjoMcRbedTmJ9WKZIDhOFMFipwc+DzteNEFU7RHXGADsxJu9S6/PR+DMCbOI1OI4zTsN3Eq2VO0m+8gxu6yIxhVU3/53HjKF1/SPI+eLb9HPm3JrjqUFL5vPIbadmKhFQtUjdoxjnR/1TnQTbKTmcBZ3Hj2x8qT1ZBjYFi0W/PSoYLQAzMVf4dkLu3iw9kjoQAnEXweutnnQwHy/P4p7N9n85GqnKg45pN15olYgtRGQ+Ndjs8kER96Z+J/F03RT7UrjKtK7YTFwuLL+csJX+bfmdDMw7YG+5rx+KdS80ItjXd030EagVLNt5Skhx6Z9rkl4iRxs9eLKbVOsJ+j86fc8OcGc4WKVbgiR7ZIM93ys4LThhlcfnY+Ra/YA1P13jSVdO/8o3eW1jIHPNDqpoe4X/M5oQPVytPGVEjxui1FwXoy9hvL366smc2t0A58L7edZTvEWgPh/gquM6XylvoUI9QcTU8foaM//1ZMIx5PsvUlOACOc1glGsyIqQrtrmjfwNBYkErTUIEfTVtOcWtgWCbSsd6/SYYVvr47noLjDpLFvbc+coCqrTn5k8qQHyVBM04I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a47700aa-47dc-4440-ef57-08dbb533ce74
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 15:03:51.6937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dzunrvN1OH7a76r3UJ4j+WGkhAQzy71h2Qq13hjBTKPSAnF+GZasIbmis0gjZyEbXDPUtsHmY7l8q5KjM40axg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6468
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_09,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309140130
X-Proofpoint-GUID: Q_WXF4DlTKwKDwKjf-l9Z-eZWhDMAdI8
X-Proofpoint-ORIG-GUID: Q_WXF4DlTKwKDwKjf-l9Z-eZWhDMAdI8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/13/23 11:54, Usama Arif wrote:
> The new boot flow when it comes to initialization of gigantic pages
> is as follows:
> - At boot time, for a gigantic page during __alloc_bootmem_hugepage,
> the region after the first struct page is marked as noinit.
> - This results in only the first struct page to be
> initialized in reserve_bootmem_region. As the tail struct pages are
> not initialized at this point, there can be a significant saving
> in boot time if HVO succeeds later on.
> - Later on in the boot, the head page is prepped and the first
> HUGETLB_VMEMMAP_RESERVE_SIZE / sizeof(struct page) - 1 tail struct pages
> are initialized.
> - HVO is attempted. If it is not successful, then the rest of the
> tail struct pages are initialized. If it is successful, no more
> tail struct pages need to be initialized saving significant boot time.
> 
> The WARN_ON for increased ref count in gather_bootmem_prealloc was changed
> to a VM_BUG_ON.  This is OK as there should be no speculative references
> this early in boot process. The VM_BUG_ON's are there just in case such code
> is introduced.
> 
> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
> ---
>  mm/hugetlb.c         | 63 +++++++++++++++++++++++++++++++++++++-------
>  mm/hugetlb_vmemmap.c |  2 +-
>  mm/hugetlb_vmemmap.h |  9 ++++---
>  mm/internal.h        |  3 +++
>  mm/mm_init.c         |  2 +-
>  5 files changed, 64 insertions(+), 15 deletions(-)

Thank you con continued changes.  Code looks good,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index c32ca241df4b..ed37c6e4e952 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3169,6 +3169,15 @@ int __alloc_bootmem_huge_page(struct hstate *h, int nid)
>  	}
>  
>  found:
> +
> +	/*
> +	 * Only initialize the head struct page in memmap_init_reserved_pages,
> +	 * rest of the struct pages will be initialized by the HugeTLB subsystem itself.
> +	 * The head struct page is used to get folio information by the HugeTLB
> +	 * subsystem like zone id and node id.
> +	 */
> +	memblock_reserved_mark_noinit(virt_to_phys((void *)m + PAGE_SIZE),
> +		huge_page_size(h) - PAGE_SIZE);
>  	/* Put them into a private list first because mem_map is not up yet */
>  	INIT_LIST_HEAD(&m->list);
>  	list_add(&m->list, &huge_boot_pages);
> @@ -3176,6 +3185,42 @@ int __alloc_bootmem_huge_page(struct hstate *h, int nid)
>  	return 1;
>  }
>  
> +/* Initialize [start_page:end_page_number] tail struct pages of a hugepage */
> +static void __init hugetlb_folio_init_tail_vmemmap(struct folio *folio,
> +						    unsigned long start_page_number,
> +						    unsigned long end_page_number)
> +{
> +	enum zone_type zone = zone_idx(folio_zone(folio));
> +	int nid = folio_nid(folio);
> +	unsigned long head_pfn = folio_pfn(folio);
> +	unsigned long pfn, end_pfn = head_pfn + end_page_number;
> +	int ret;
> +
> +	for (pfn = head_pfn + start_page_number; pfn < end_pfn; pfn++) {
> +		struct page *page = pfn_to_page(pfn);
> +
> +		__init_single_page(page, pfn, zone, nid);
> +		prep_compound_tail((struct page *)folio, pfn - head_pfn);
> +		ret = page_ref_freeze(page, 1);
> +		VM_BUG_ON(!ret);
> +	}
> +}
> +
> +static void __init hugetlb_folio_init_vmemmap(struct folio *folio, struct hstate *h,
> +					       unsigned long nr_pages)
> +{
> +	int ret;
> +
> +	/* Prepare folio head */
> +	__folio_clear_reserved(folio);
> +	__folio_set_head(folio);
> +	ret = page_ref_freeze(&folio->page, 1);
> +	VM_BUG_ON(!ret);
> +	/* Initialize the necessary tail struct pages */
> +	hugetlb_folio_init_tail_vmemmap(folio, 1, nr_pages);
> +	prep_compound_head((struct page *)folio, huge_page_order(h));
> +}
> +
>  /*
>   * Put bootmem huge pages into the standard lists after mem_map is up.
>   * Note: This only applies to gigantic (order > MAX_ORDER) pages.
> @@ -3186,19 +3231,19 @@ static void __init gather_bootmem_prealloc(void)
>  
>  	list_for_each_entry(m, &huge_boot_pages, list) {
>  		struct page *page = virt_to_page(m);
> -		struct folio *folio = page_folio(page);
> +		struct folio *folio = (void *)page;
>  		struct hstate *h = m->hstate;
>  
>  		VM_BUG_ON(!hstate_is_gigantic(h));
>  		WARN_ON(folio_ref_count(folio) != 1);
> -		if (prep_compound_gigantic_folio(folio, huge_page_order(h))) {
> -			WARN_ON(folio_test_reserved(folio));
> -			prep_new_hugetlb_folio(h, folio, folio_nid(folio));
> -			free_huge_folio(folio); /* add to the hugepage allocator */
> -		} else {
> -			/* VERY unlikely inflated ref count on a tail page */
> -			free_gigantic_folio(folio, huge_page_order(h));
> -		}
> +
> +		hugetlb_folio_init_vmemmap(folio, h, HUGETLB_VMEMMAP_RESERVE_PAGES);
> +		prep_new_hugetlb_folio(h, folio, folio_nid(folio));
> +		/* If HVO fails, initialize all tail struct pages */
> +		if (!HPageVmemmapOptimized(&folio->page))
> +			hugetlb_folio_init_tail_vmemmap(folio, HUGETLB_VMEMMAP_RESERVE_PAGES,
> +							pages_per_huge_page(h));
> +		free_huge_folio(folio); /* add to the hugepage allocator */
>  
>  		/*
>  		 * We need to restore the 'stolen' pages to totalram_pages
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index 3cdb38d87a95..772a877918d7 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -589,7 +589,7 @@ static int __init hugetlb_vmemmap_init(void)
>  	const struct hstate *h;
>  
>  	/* HUGETLB_VMEMMAP_RESERVE_SIZE should cover all used struct pages */
> -	BUILD_BUG_ON(__NR_USED_SUBPAGE * sizeof(struct page) > HUGETLB_VMEMMAP_RESERVE_SIZE);
> +	BUILD_BUG_ON(__NR_USED_SUBPAGE > HUGETLB_VMEMMAP_RESERVE_PAGES);
>  
>  	for_each_hstate(h) {
>  		if (hugetlb_vmemmap_optimizable(h)) {
> diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
> index 25bd0e002431..4573899855d7 100644
> --- a/mm/hugetlb_vmemmap.h
> +++ b/mm/hugetlb_vmemmap.h
> @@ -10,15 +10,16 @@
>  #define _LINUX_HUGETLB_VMEMMAP_H
>  #include <linux/hugetlb.h>
>  
> -#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
> -int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head);
> -void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head);
> -
>  /*
>   * Reserve one vmemmap page, all vmemmap addresses are mapped to it. See
>   * Documentation/vm/vmemmap_dedup.rst.
>   */
>  #define HUGETLB_VMEMMAP_RESERVE_SIZE	PAGE_SIZE
> +#define HUGETLB_VMEMMAP_RESERVE_PAGES	(HUGETLB_VMEMMAP_RESERVE_SIZE / sizeof(struct page))
> +
> +#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
> +int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head);
> +void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head);
>  
>  static inline unsigned int hugetlb_vmemmap_size(const struct hstate *h)
>  {
> diff --git a/mm/internal.h b/mm/internal.h
> index d1d4bf4e63c0..d74061aa6de7 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1154,4 +1154,7 @@ struct vma_prepare {
>  	struct vm_area_struct *remove;
>  	struct vm_area_struct *remove2;
>  };
> +
> +void __meminit __init_single_page(struct page *page, unsigned long pfn,
> +				unsigned long zone, int nid);
>  #endif	/* __MM_INTERNAL_H */
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 50f2f34745af..fed4370b02e1 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -555,7 +555,7 @@ static void __init find_zone_movable_pfns_for_nodes(void)
>  	node_states[N_MEMORY] = saved_node_state;
>  }
>  
> -static void __meminit __init_single_page(struct page *page, unsigned long pfn,
> +void __meminit __init_single_page(struct page *page, unsigned long pfn,
>  				unsigned long zone, int nid)
>  {
>  	mm_zero_struct_page(page);
> -- 
> 2.25.1
> 
