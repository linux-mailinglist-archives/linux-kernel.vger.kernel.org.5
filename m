Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C557929D5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353727AbjIEQ27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349894AbjIEE7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 00:59:05 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7084CC7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 21:59:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQrGfBFsU/1Pu5QvlM6gB/4E6ZoGmH88HoSI87dO6VfrVE17s6C2ZGfEEIBmOxIZ/4c/QSTTa/jotn5Fm/9pZj4xJtCQLEW4MFfjAsDnvooD8gkBeKEtwB6qRmuwNRgY7nADLm/y4UOxPco1C0OKSPLtpq/0/VVYo81JDYi4i7lytslG7yNH23FAsiut5rRLaf1TpdMLh67tWjUMAf8vFvsVzHL4ywJm+KrE8Tr1MdNGK9BkJIRCjlvvH/Q4g6oKzu8qOgnJkVNsNCOLort4rlj6sYMu2IfbnB6oyw9m8Ai5ffezeWZ6VG6velLArpzdJcB3SMzhdR5KCbi1E8c6Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XX5FKHJQQlBp0JjIiPqg0q1gyIT8iNTmT5E1zxnQt8o=;
 b=lRMxN28VkykEN7LFFvDxRWaOmyqyoWKIZCPL3BH1pzeLOXucn4tHiqVFGcsJSxUc2Ba8N1fvjuII7to/FnZP7jwpvQ9FgMfrB0cIIihzKH1/xg1JXyrgmdd852oZeNnJwu2xcLs4+6JfScyrK1tNOm+PGzbGVleGhtjY4io3Q/KfWIp2udEcjla/2vtk2hnP29Rl9TgT0askWzM46keneNroAbTBs+SMKVW3AnHw53nSAqx97wSo0YmGSpFuNJBdqiJuPR1VOfU8OsjPxgcwIZvkWSGKR8l7Mf+NLIfupn0ADXjOKeBni1L2hebNFzDiwLsAh3hCu8Pmm1Fh3gcTZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XX5FKHJQQlBp0JjIiPqg0q1gyIT8iNTmT5E1zxnQt8o=;
 b=FfLDBNdlYFHndzcgRo2MFXOw5BoEAhfvtIzfrGdgNL6MA487EFJf5eGQoAwOrxcQjagoDUJixY+cTpiq0rrLStGnUJx4hKSkpEjAYB3Y9v+kpzEi7hVcnrf8JPqZqpRhhXaqL39rQBQ0vwYSNwagQgV7yLQSzO97Wm3s9dEfNVc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS7PR12MB9042.namprd12.prod.outlook.com (2603:10b6:8:ed::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.32; Tue, 5 Sep 2023 04:58:58 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e%7]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 04:58:58 +0000
Message-ID: <3d503305-0c07-cf6f-7f22-ad7a4da55fb7@amd.com>
Date:   Tue, 5 Sep 2023 10:28:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 4/6] mm: Add structure to keep sva information
Content-Language: en-US
To:     Tina Zhang <tina.zhang@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Michael Shavit <mshavit@google.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230905000930.24515-1-tina.zhang@intel.com>
 <20230905000930.24515-5-tina.zhang@intel.com>
From:   Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20230905000930.24515-5-tina.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0174.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::29) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS7PR12MB9042:EE_
X-MS-Office365-Filtering-Correlation-Id: e9172a3c-0363-4bf4-ed5f-08dbadccd042
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8e9DBInMcScY5woXqIxaFLYPV13w4EmH6FTilRXDtivvgOkjmFXjLtbNxogdJO71n+u7ruxT9Ujv1h01e2Y5uSnpv7RGVKkuZ/2hsmX1nAPUnFDSgfqCL79CgyftVl6E00mG44Ml3j1pFffAMpJvnkLRfr8q0r4dQY4qFy7p7+Ck7do+vGbU1c8wiw13n1cDnuwA1X9y7VUhmlumeswTkbbT1E4CYFC6Rf0NzYhRm2bl4wj7904Aw+07pGFRmNH8ORP1t0JoaLws/GS1J5G1OfTEsKOucawFxN5EYDIlUaaFV4q8Q2r3/lmkTkepdADSLL6qZyLUcAPH2qL6tFfXnIkyE7SaES+YqFOO1fKpLJXyh3lxsLrdqfXdKqxPpK09GnmuxLm1BB9Ub5XB5Umhf4qkUxCogPki3cTQzwRb4y4u3+8136ZpigFl9FcApkpHMPK9RevXkbRmhecpURMsDZqV4cNRh6Yzfy+buuXyYleO7pCzxcj4p+HyU8QZd8rg/aqmHxEeIK1QQvQDGkLeVrZB/wjmnG8w+hDQukLaXiwYrxD1bkQk4jCm3RpzemK73o0+DfNdoav5PUDOR8FEeoGLUg8scrDs7qoT2BoGn10ig1dnEbInGPDH7VdeldnvgD7juYsmt8pBLtJVZlXmSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(39860400002)(136003)(346002)(186009)(1800799009)(451199024)(41300700001)(6506007)(6486002)(6666004)(53546011)(478600001)(2616005)(26005)(6512007)(38100700002)(66476007)(36756003)(2906002)(110136005)(66946007)(316002)(66556008)(86362001)(31696002)(31686004)(5660300002)(8936002)(44832011)(8676002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkRsL1k3cjhpcnEyNk5ueEJTNkh6WWRQamF6WUdnZytGZUE3aHJzTjRhMGhW?=
 =?utf-8?B?L3pFenFUSTM2eHFncENnbGZOaUliU0JqSHArQU1PNDdaTlliM0hSZUR5NjE3?=
 =?utf-8?B?Zk5mRDZLaVZaTG1XT3VBTVJObVlJU3lXT0g2MDJrOHh0MXA5NWpMcXp4SGEy?=
 =?utf-8?B?eGNJTDZsWXNYbUtER1NlajE2eDUrTmxobkFjZVI2SlNPdVc1enBlMnBZSDBY?=
 =?utf-8?B?OUwxS3BLOU16cHhpbkJiUXV3cWJTK1JLM0labmFFZnBiYjYwYzBHVTdFelNR?=
 =?utf-8?B?amd4Wit0cnNpYWJPblIrNlkxbXd2MWNscm5uYkZKdjdkNDFEanJHbXp0V2hR?=
 =?utf-8?B?b1BHODVNajlOb0pGbm50MmIzdXlmK0VRT3ZWRDBvN0hORzFKcUtvcVdjZlQx?=
 =?utf-8?B?azJyVUtoUUZiRHJjYm1pL2VYSTdOZ1doOW10RXNOM2RwNnJ0L0JySEJxcDJz?=
 =?utf-8?B?amZ2Nm8zT2dPRkNvOG5OSkg3NGRwMVc2TkZIQnZabkZjd29uZGlWK21zZTIz?=
 =?utf-8?B?WVdyYkNMR3JteVV4ZGRjWW91NDVWUTRnaVNSY0VUeUdELzZjM24zLzhsdGx0?=
 =?utf-8?B?eWtXc25uaHRVaVJWT2MvUWMwZE4zdGV6R2RUZTV1L244VkJJSVZySGZmakxv?=
 =?utf-8?B?SnZHaG5aUW9vWnR6dDFRTmV0S0FSODdaUlZFU2ZjMEIwSmhDTWREMms0T2RH?=
 =?utf-8?B?Rld3U053M3RaSG4zcXMyblpwTmJvQjROYU9UdCs1TmtLMDVKT1JERi9PRVJJ?=
 =?utf-8?B?MWQyd2VPV1B5SklJMzdFQXRmUnVaZVArdWp3clU2TFFJanJxNUhpTlEyRk9O?=
 =?utf-8?B?OTRFbWZFN0lNb1NOQkN3aWhYTjVSbUgvaU9rL1UvdEo2dEE2a0g3aEFpTVMr?=
 =?utf-8?B?cjJFNVRjMUdFMFhvWTdVU3kwekErNzMvMUZuOU9tL3h1QVpIV1BCbi9WQVZD?=
 =?utf-8?B?WXpFbnk2cXdVNW9TaTlpSmQ2bkVpU3RDSkZhd0hMVUVJeExTK0kyVTRRS1Uy?=
 =?utf-8?B?cEcvL1ltc1k5S0hqek5oMHV1YTNxTVZNNnE3QVJleW0wODY5MzQ2Y0FsRnhQ?=
 =?utf-8?B?RmZzRjRRY0lNSFFEdW1mNnJ4MXJEVDlpdUFhNmNNS21JQWtubkMwVGVOb2h0?=
 =?utf-8?B?Y3U3RkZvL1lZYjdYSi84b0F6U0hLRStPbk1vNHlFNlYyNGtQRTgyUmQrL1FP?=
 =?utf-8?B?TzZaNFRDWlVWb21PSnhaWUE3enAya3k4dEswbEhCVjZLL0I3dTRqVkRDM1dG?=
 =?utf-8?B?UlpYVkpPWnMwaERQbkdnblU4K3F1bnJEcGd5aFk5eEdtTldlZkljZFJFS2hj?=
 =?utf-8?B?Vkh1OTluYVFBR0tWc1RpVHBFVFhQNi9DQVdHWG9nMWRtNWFhdmtPSXEvZVlI?=
 =?utf-8?B?RUd3Z0JPWEVZeWprMXBDLzVaaEhyTjZQdmZXUFV2aEFOQ1o4WFRMK0Y5aEtG?=
 =?utf-8?B?eng0Nm92dldUTWEvZ1RzOExJUE1xcncrSGJmYWpabDlyUUxQUDZhcnNLdk00?=
 =?utf-8?B?d1RZSitycUl0Sy9JY1c0YXlvSEl1czdVRHQ1Umt6dmxFZXFzWnExQ3N5aUd3?=
 =?utf-8?B?ZDM5dk5PcHVyV2xVcW4yRkZaSXZObkgvRzFXZitkTzdGS29KYkNUeGpDOTZu?=
 =?utf-8?B?QWEwanNGREZOWllKdjZtclc1ZUMyRmk5ZlhlZ0RTeUdUa1hvQ3BYSHJIUEhI?=
 =?utf-8?B?MVlid1pJMW9DUzh6RW1Rd2dENjIxc2FIR1NzNmhXVFFCdnJQc3JGV1NFWmtX?=
 =?utf-8?B?TDNrVHNPbjlhY0UvUGV1NXZCZmpMaFYvVXc1UFZMZmVEQ0tWTDE0bDBIa2pB?=
 =?utf-8?B?WDU2akFoWXpNSCtUTmoyRnkrckpIUlQ1S0ZWcVBSb3BFaUFmQnhtS2E1YVB2?=
 =?utf-8?B?TXkvT2FVK0tpcTJJaTZNY1NGSnBCU2JwR1c5K0Yva1lGWFZCd1l5azkrblE4?=
 =?utf-8?B?cmRQZ3NRZVdDRmJvbjhaSVNFMWdLb3dBN2wyNzNjc3JUQmJDbTVZRFBubi8y?=
 =?utf-8?B?WnBTT0tiZkt5a3pkWW9UOHRNNVdsNTYwUmVkUjZ0UkZ1OERBM3R6elBDbEF0?=
 =?utf-8?B?OXl4VjBkMnBTRlRleHRpaEN3S0JSNFVHUFBZWDM5WnFoRmJJYXBjZ09tRTBC?=
 =?utf-8?Q?Z9NP4SLle2p6EVrg3pVs4awVE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9172a3c-0363-4bf4-ed5f-08dbadccd042
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 04:58:58.5771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9IgPTdwDcUKWE2fDs3cZ8gLCSxEKw48ZZxwm2u06FiS2ykK0KfsaZjWRO5YKllzyafXSK3vqcOBZECDGhXLHgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9042
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/5/2023 5:39 AM, Tina Zhang wrote:
> Introduce iommu_mm_data structure to keep sva information (pasid and the
> related sva domains). Add iommu_mm pointer, pointing to an instance of
> iommu_mm_data structure, to mm.
> 
> Signed-off-by: Tina Zhang <tina.zhang@intel.com>

Looks good to me.

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant


> ---
>  include/linux/iommu.h    | 5 +++++
>  include/linux/mm_types.h | 2 ++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index ab8784dfdbd9..937f3abc26f2 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -670,6 +670,11 @@ struct iommu_sva {
>  	struct iommu_domain		*domain;
>  };
>  
> +struct iommu_mm_data {
> +	u32			pasid;
> +	struct list_head	sva_domains;
> +};
> +
>  int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
>  		      const struct iommu_ops *ops);
>  void iommu_fwspec_free(struct device *dev);
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 7d30dc4ff0ff..b486f521afee 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -595,6 +595,7 @@ struct mm_cid {
>  #endif
>  
>  struct kioctx_table;
> +struct iommu_mm_data;
>  struct mm_struct {
>  	struct {
>  		/*
> @@ -808,6 +809,7 @@ struct mm_struct {
>  
>  #ifdef CONFIG_IOMMU_SVA
>  		u32 pasid;
> +		struct iommu_mm_data *iommu_mm;
>  #endif
>  #ifdef CONFIG_KSM
>  		/*
