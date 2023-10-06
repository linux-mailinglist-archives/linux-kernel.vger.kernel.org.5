Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809E57BBA1E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 16:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbjJFOWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 10:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbjJFOWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 10:22:02 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4130A6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 07:22:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+McOIvrw2fVFpri/CfD84zg6qG/LUzZ2DssY6ijcBVLLm1T3oVzmJY3ObN2npWlK2d3nmVqzRNRV25jhLD0VNRxkZ5C80HQL9oyqLm7z71Xg7Cr7KoNqz1pEqnY2QqA1e4gEYau5OZQ53DmChGhUXPMHs8VDFaCIFgmqGfj4e4R8m5KaajLMnS4U5wxgjaitiSHDJN2RvwJhdGHn0Gukyrlh/MVzzy/rDHIjeolvjFfWPekkPmVno7w0mvhHF/im40ZHXUWu9+af0QcNnUJ6GEC4wOSs0IwiRTmST9DqMWNb6NhEK1ovfm71LiIMS1nLJL/6PdXlMtWPMaU4OaGQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PuPd8XtD0rP3DSCT/eWhTOOL5HgY0aG8dMKbyZZxTFQ=;
 b=P/06nRrJVpHPW5DXuoVqNlraRWdctaRXJmzwFmz/o9HogU29oIu8UYK7t81b/b3TAZDCakmYyMl1or1LcroDHkyRJj9NIiPzxBKLOdlol2EV9T1H8PizU/akn7hjwMdZ3pNFYR98mUHy50lPwzwcwG5dmYHQPWh9+7iGfF3zdvxcqAkYcx1Tbg0tm9tZO5vZrkTH/DaRe9dxE01A/tFIFctiiJof/km+341IQHu6oqEReeBO9nvZSKaKIErdajRuOsARm+s9H3PJdN38wGsyVd1Qjz7N2IuGPdQly26EI9xnZLHbSkVSGCn3ljMtejU7VeI7ca+fFlkD3RSVoKAE1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuPd8XtD0rP3DSCT/eWhTOOL5HgY0aG8dMKbyZZxTFQ=;
 b=ZX1oKSsS0Igup/o+SafgUtXUFYV+sJ16iXkuBN5HI9tAm5Cf6SFj1h8Td1/QPIww67sQn4o9HwBY7X5nM4GmljH883ETyuR2F2ukedich8z4OPpnn6bfmuQEJRQgI6GX0QNFV1dD2WaMIi5LTVPG1vhS0i9P7FgsULlludTChew=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ1PR12MB6099.namprd12.prod.outlook.com (2603:10b6:a03:45e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Fri, 6 Oct
 2023 14:21:55 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39%6]) with mapi id 15.20.6838.039; Fri, 6 Oct 2023
 14:21:54 +0000
Message-ID: <a0c4c6f0-5a55-a4be-a895-c889f5b9cf51@amd.com>
Date:   Fri, 6 Oct 2023 09:21:50 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v4 1/4] x86/resctrl: Rename arch_has_sparse_bitmaps
Content-Language: en-US
To:     Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Peter Newman <peternewman@google.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <cover.1696493034.git.maciej.wieczor-retman@intel.com>
 <c05d9bab52da55fb98e98147cfe1a412a5089445.1696493034.git.maciej.wieczor-retman@intel.com>
From:   "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <c05d9bab52da55fb98e98147cfe1a412a5089445.1696493034.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0224.namprd04.prod.outlook.com
 (2603:10b6:806:127::19) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ1PR12MB6099:EE_
X-MS-Office365-Filtering-Correlation-Id: e6883c09-2add-4725-0230-08dbc6779753
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V1Nl7G9Wu/TGHLOw6ZAIRRlS5dHkqcOwbvQEeft9dMd/2l7WddpE950V0kF+l4Lk3AnAG5oeRtNSFWISa8CAKnZ3rP2rrssj2EsqYGT6lRkJsrWorDL+w7+QkvhaaDFN1WSb/aJOGxilwPitkYZYIm3MIZFTXNc00jp/MM3k37JUjHKO8zC2ngITHLsNtkB5dX1RNYFskfWCiNWY963jaM1yPnqcSNkPY69xN2fkb4d4GkhB6dcoBhKGoYbIKlkpfwnBCNuVMo/KTz4m+No4Jm0QabZ/4NP6kK9mi88sm9YDEFSiqKScLAji9o9KpCwkeVS5Yfy1dGyk/9ZlpLj7OK2mfS6Fbe/KoeiXvMluaXvrixMc0RBppwsdEl6c3X2rM3aP2iRzJvfYy7QHqpw5uK+8TlVx7hmshLORauwCtaK+Zgq/GDQugWTC+C3g+3+fKjrMOWbHmScNmV26zOD7+t4ABMx3BPAMzoEmWhiXXoigYpNpUReLcEzvIWn4FACq9xYh1Aga7EUlRCg5Rfhk3GgsrtWt3iOau77d5sXgbiu8R1M/C7AWgLTatq+GGvY0Fw4GDQYruerCYYBbo2he6Ru9TX0+Nfa+5Pjmz1PAwxhHiU2df6Y/ddiXigwPD+kVy5QnBx+MlCxGFTGZ5M/fKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(396003)(39860400002)(346002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(5660300002)(8676002)(8936002)(31696002)(4326008)(2906002)(7416002)(478600001)(26005)(36756003)(31686004)(6512007)(66574015)(38100700002)(2616005)(53546011)(6666004)(6506007)(6486002)(83380400001)(316002)(110136005)(66946007)(41300700001)(66556008)(66476007)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0ZwZWd1bGtIYy9NTjh6Qm5SUWNlWkNOeTd4RG1idWVZOWFMQU4yeGdNVlNT?=
 =?utf-8?B?MjFEMGFRVW9BLzZka2VPbmhId0YyczBHTDZkVXZyYkNlMW9FWFRaZ0ZrZHhx?=
 =?utf-8?B?Qmd6NG5TcCtJWllFRFB4UHNsMnJLOTFCWVZ4TVVvK3JjZ01JUmJuNW1IYS9T?=
 =?utf-8?B?MFhYYnhwbUFqS2JHU1VaaDBHYW45Zk12TXRzRmFGWmxCaG1ES3FIdmtsa3JC?=
 =?utf-8?B?Q3ozTkd3RzFHWnhiSkluK284djViYkJmVzRFK29MMUlsOG1CUFN0RzRUMUlT?=
 =?utf-8?B?cHFwTmwvOTUxQ3ZiV3VETFRIMVk2Y0xxTWFkQUFNZlVuZGpSK0tBOTdqaGt2?=
 =?utf-8?B?UzZlN3UvcVB2VTFsekxWVjRya1RSNFBBT1VxVnV1bEQxb21iN3VDNlZBOTZn?=
 =?utf-8?B?YVBMTFdvSVhnb0tFVngrYW9TckJTYWI2dlFnK0c3SEh0Vk4xQ3dPSE1mWFcw?=
 =?utf-8?B?VVU1VVJHZDhiS3Eyb0VOS1dOSlFlNkErU1VvVE9tMTFtSFlvL1lNbURBaFZH?=
 =?utf-8?B?aHFmNGp3bFpmNVFpSWRnaG5lMHFMSnZqNzZJMWQ4ck1PUGFrK2gwNXJmallz?=
 =?utf-8?B?Y2QwOTVZalltbnJzWnVPNzJQRUg0SmZGYm9Lcm9NM01GdTBxVURQR0VrQ3Ar?=
 =?utf-8?B?T0RWOVpZWXFERXpCaFRYaE9DeEhPeW1wUURzTmZZQksyR0hvUVU4Y1hjR21C?=
 =?utf-8?B?UzZsc2xRcWtHMG1XK3BML1A1dG10RUFXcG9IalAxay85ZGdtY3dRL1k0Y1ho?=
 =?utf-8?B?S3NVOVh5OFpOUnlHOW9DV0FiMk5OdTl6ZXFJdFRjU2FYeTJDZmx2MGpJUEs3?=
 =?utf-8?B?ZUlBSlFybnptVExkeThYc05maU1Nc2FYTHIvQzh5L2lqK3pkSGFvSyszNjBF?=
 =?utf-8?B?cC94cWtBKzk3dW1QcWZMR0V4QXpONWxWYjBBd0xpdFQzcHFtQXd6WC95dXlY?=
 =?utf-8?B?ZzZSMENVQlp3OCtBZWVuNjJ5REFvWUl4MHJZRUhibjZ1T3VpaHpLTXRjOHI1?=
 =?utf-8?B?dGVVckNTcUI1Y2c3dVd6d2t0dU5OekdTWDRWSW5yZEZyMytHQVJiN3Ryb2ht?=
 =?utf-8?B?cDdNbXZOZ04rVGlSMkRoY0h2QnVqTDZFblpFT2JudVk5R2lpUTRIVW1hUm1Z?=
 =?utf-8?B?ZVVFNmJwVENDbjFDWjdyR0tHRVpOQW9wTlZpbXB5WW1HMmVvN1pHMzVwbC9F?=
 =?utf-8?B?RTIyd05USktmQVBkdVhVK29Nd3VjZ253L0ZNeTYyWE5KQ29QL0tYbThPODNK?=
 =?utf-8?B?dTBSQ0VZUzRaWTFmZk13ZTNXR1g3YWt1WEsvSlFoOVo3N3k4blpJYnNuZDFN?=
 =?utf-8?B?ZVg4TDgybEpVWnVDMUVqUVpMMWpRYlNSTDlhVVd1NDFKY3Vzd0h0VHMrYVh0?=
 =?utf-8?B?cFNoVm9EcTlKenV0K2t3QUlOd2hFbkFxZG1leGx4R04vRXhGUnZTRTUrMU50?=
 =?utf-8?B?RUYrTk5OY2twUEdIMW91UnJ4cTNOdXlvVVVoTVdQYWhUVDQ3Z1dJT0VBOG5G?=
 =?utf-8?B?ejFFVUkxdVhsK1RsR1VhVGl3SnZINWRjNnd6SDd1clFQT2E3WkxsbWZUVktv?=
 =?utf-8?B?cldCbkZxbEFPdk5Mc2kvcldhSzVtbWhWOUJhcDNVMGNkN0ZlTTlCMGpwMmh6?=
 =?utf-8?B?aHdFOHhMSzFBdXpqazF3Z1lNYWFGYkRRZG8rMkU4WDFJSFBKMElUdDI3dy9L?=
 =?utf-8?B?MzVWdmVvY3hNQldlNVIxdFdUbk5vSmV5T01QdFN3UXZ6TDJ5S0ZoaFN3MEsz?=
 =?utf-8?B?NWhjdThMVjhlbmd4NUVTYTFtcDhLREhxMlYrNk0yTW0yMzU2WGlmNnNrVzQv?=
 =?utf-8?B?UjlVVUZYN1RkbjV4Z1c2NjlaVVo0ZDNsSmNidC9jbW1IaUJxd0JLS0d1ZFAy?=
 =?utf-8?B?bytGSjY4OXkwMWlrdGdnbjB5T0c3ZTE5aFNoNzBSQ3B2SmsyczhCaTZEQ0VT?=
 =?utf-8?B?eFZxUjlDY2I1c1dOa0h2WS9CLzZlOG1MY2RuZTVRQkdqVU9jdVFsN0ZianJS?=
 =?utf-8?B?cGZGMEU3L1BJZzl2QzNUYlI0cUdOaERZNURnak45cjFaa3Q0SzVlVk5pTnI1?=
 =?utf-8?B?VCt4YWQvYVF0RnVsN1JoeUNrSXlQRExCUjFCRyttU0RGRGNMdkVyaUVQWU9r?=
 =?utf-8?Q?9UOE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6883c09-2add-4725-0230-08dbc6779753
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 14:21:54.7056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /L6Z+ipxKobdGZE88BCpxEHmIp+0T2fh1dbiEsEA0vLFOP1t4xhGphjsxjEh/2yV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6099
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/5/2023 3:15 AM, Maciej Wieczor-Retman wrote:
> A later patch exposes the value of arch_has_sparse_bitmaps to
> user space via the existing term of a bitmask. Rename
> arch_has_sparse_bitmaps to arch_has_sparse_bitmasks to ensure
> consistent terminology throughout resctrl.
>
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Peter Newman <peternewman@google.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
> ---
> Changelog v4:
> - Add Ilpo's reviewed-by tag.
> - Add Reinette's reviewed-by tag.
>
> Changelog v3:
> - Add Peter's tested-by and reviewed-by tags.
> - Make this patch first in the series. (Reinette)
> - Change the patch message. (Reinette)
> - Drop rmid_busy_llc comment name change. (Reinette)
>
> Changelog v2:
> - Create this patch.
>
>   arch/x86/kernel/cpu/resctrl/core.c        | 4 ++--
>   arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 4 ++--
>   include/linux/resctrl.h                   | 4 ++--
>   3 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 030d3b409768..c09e4fdded3c 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -872,7 +872,7 @@ static __init void rdt_init_res_defs_intel(void)
>   
>   		if (r->rid == RDT_RESOURCE_L3 ||
>   		    r->rid == RDT_RESOURCE_L2) {
> -			r->cache.arch_has_sparse_bitmaps = false;
> +			r->cache.arch_has_sparse_bitmasks = false;
>   			r->cache.arch_has_per_cpu_cfg = false;
>   			r->cache.min_cbm_bits = 1;
>   		} else if (r->rid == RDT_RESOURCE_MBA) {
> @@ -892,7 +892,7 @@ static __init void rdt_init_res_defs_amd(void)
>   
>   		if (r->rid == RDT_RESOURCE_L3 ||
>   		    r->rid == RDT_RESOURCE_L2) {
> -			r->cache.arch_has_sparse_bitmaps = true;
> +			r->cache.arch_has_sparse_bitmasks = true;
>   			r->cache.arch_has_per_cpu_cfg = true;
>   			r->cache.min_cbm_bits = 0;
>   		} else if (r->rid == RDT_RESOURCE_MBA) {
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index b44c487727d4..ab45012288bb 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -113,8 +113,8 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
>   	first_bit = find_first_bit(&val, cbm_len);
>   	zero_bit = find_next_zero_bit(&val, cbm_len, first_bit);
>   
> -	/* Are non-contiguous bitmaps allowed? */
> -	if (!r->cache.arch_has_sparse_bitmaps &&
> +	/* Are non-contiguous bitmasks allowed? */
> +	if (!r->cache.arch_has_sparse_bitmasks &&
>   	    (find_next_bit(&val, cbm_len, zero_bit) < cbm_len)) {
>   		rdt_last_cmd_printf("The mask %lx has non-consecutive 1-bits\n", val);
>   		return false;
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 8334eeacfec5..66942d7fba7f 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -94,7 +94,7 @@ struct rdt_domain {
>    *			zero CBM.
>    * @shareable_bits:	Bitmask of shareable resource with other
>    *			executing entities
> - * @arch_has_sparse_bitmaps:	True if a bitmap like f00f is valid.
> + * @arch_has_sparse_bitmasks:	True if a bitmask like f00f is valid.
>    * @arch_has_per_cpu_cfg:	True if QOS_CFG register for this cache
>    *				level has CPU scope.
>    */
> @@ -102,7 +102,7 @@ struct resctrl_cache {
>   	unsigned int	cbm_len;
>   	unsigned int	min_cbm_bits;
>   	unsigned int	shareable_bits;
> -	bool		arch_has_sparse_bitmaps;
> +	bool		arch_has_sparse_bitmasks;
>   	bool		arch_has_per_cpu_cfg;
>   };
>   
