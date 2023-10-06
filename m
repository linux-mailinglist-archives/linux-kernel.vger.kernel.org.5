Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A947BBA43
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 16:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbjJFOau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 10:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbjJFOas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 10:30:48 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB887C6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 07:30:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKUGd8f4MvqcUjVmM/I28j9ybQv+uH2VE0xyiIXj/tcapMAO5VKgKRwMBx3zMSM2PjsQZP6nXFX+vA4EgImW5ANIjhK0LEzcTrti4AXvCoicZ4TTzhaRQqmEli0BsK2ZlLMzWQSRjzkEttpNfKCWcdDKKEXgZvI5oW4LvG640nLvJBqPR3naZvyLoJb/lLipyoD5QqShWwaLl530KczJZJNe8T+6psxDjfwkFQwfReuUEA2h/7lR7qZfyseHUHlVJd2wVwZrRfhP7RsHGLpwswUEnYCVqHLuGpnm1hKaOGaak11r4Q0nKWOIL351yw8EQvVD3XKpiO9wd1Ig+gwmWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZtZG0WSNFUFO7JKDPWf7V8Eow248q5TIOmahl6kMR4=;
 b=YPuCq7KML0Lom30I1IUAdcxwdxaZtRqZp1guIJ+s1jFvnJeo2IEo3P/pE5MVSQOBBrcbTQVb+B4cLNNUFcpo3v9GhNnQ0q0GOT4f9oxdKZQ54GWAdT+sRAJ7zQMGxOpTcKudQG1vL961V0yBP5pEapbeeUExVKLCxYBCmrQ0aRm94nsvHq8qXRvl+uGBrKGNRPVC6BytnIvjZcDyccRHRy+E5UBv05Q9/2dZrJbvFiLjLu1PVVFOSJlFawEcnnB1PAtRzQPNfkNLkhoYdI/ilnoyTmDfaSv5yHugi47kudBO9UFABbbytTiAQUTk14THPK5WS6NvGKl9QOpSm+VOcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZtZG0WSNFUFO7JKDPWf7V8Eow248q5TIOmahl6kMR4=;
 b=mK43RNu2zvJSqbx25mbfwLnwi6CXo4SNuaRLdnU3qsVEcuCm2yGarEukZqDGaWoXLcW8gKTD0TYqNSEShZxpSzHheCDxJHnG2tmymO0viwwc5nDckuklLXGvwE9k/M032g/zx6J5dyvj5qVi8E4JVe6pK66Nfk8/BoXlc2WzuGE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA0PR12MB8256.namprd12.prod.outlook.com (2603:10b6:208:407::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31; Fri, 6 Oct
 2023 14:30:41 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39%6]) with mapi id 15.20.6838.039; Fri, 6 Oct 2023
 14:30:41 +0000
Message-ID: <603c42c5-8059-a400-a920-3e6c14689dca@amd.com>
Date:   Fri, 6 Oct 2023 09:30:37 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v4 3/4] x86/resctrl: Add sparse_masks file in info
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
 <684da427338d68b216c1f5636a4930bba06f7b60.1696493034.git.maciej.wieczor-retman@intel.com>
From:   "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <684da427338d68b216c1f5636a4930bba06f7b60.1696493034.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0038.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::19) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA0PR12MB8256:EE_
X-MS-Office365-Filtering-Correlation-Id: d12410d7-af80-4ccf-df1f-08dbc678d136
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SExf5M1GVJ76R+oUvBJDecVFEkPq8BocuqPulzxxvFiwiPdtQwkVs7W2rGeW5VVV+okcy2AyMdZ/p/JavnzMmhh4C6jGcCib471c5cRILXLb3oF41c6+gndyQSJSv2Cdx34A22xxaATzwJsh+poFqnY1TgVioZ3tiVJCwjA0sLCEmcrGF36gKN+h69NAclarPFlpYv28SxnewnVcjpmzDhuJ6Ex7mhB8CclrdX/PBicGRpzuvoGEvJOXw8kM+w+mVTc0tEGk3R0HnFenD9jBIXlyPBNJFGpjAwpcrUwg7M/4jgT3SLXm0gVzbhUajpCjMW74e3fjAkXqMNp3TdaiGl4KUETq3cPylNrbxTiPTTxL6WkMtu6VVyJaM+0gljb3MWV1xT+IbRDt21J682AXDt4+LWS0L5enehs3Hgxs7RLStH88kU/JtWzDRlSKmnEeJIZL1dRRhzbF26U5BNKiguK4zXNGt6te1xIH3bfPaBYBunm49zIei+tiUhPc84hvx7d7apqfpJ6egfd7SjjalV9AG+3JRq1Wiw8lRNf8g+nlsEKsuLAbOR7jKPpj3nEfYCzgSCh+2qQxzS2nH0QcQdWLDiyZXcjOJZsPItqWOavvkfIlVy67qefzZXyL2gm0Qz4itD9no/icLH1E/25S6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(136003)(376002)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(36756003)(478600001)(6486002)(2616005)(26005)(6512007)(38100700002)(83380400001)(31696002)(6666004)(66476007)(316002)(110136005)(53546011)(54906003)(66556008)(7416002)(66946007)(41300700001)(6506007)(8936002)(31686004)(5660300002)(2906002)(8676002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTByUEFZa3dWN2FEemRiWjhmZVdNMy9PZGtsemNLV1NEdEZaL3Y1UENHakYv?=
 =?utf-8?B?MXdSbk1XejR5dHkweUpBdmVSUzZiOGp1NEQvcDBsTjlGK1gwSFZrS2tzaEtG?=
 =?utf-8?B?QWtVN1FOQ2VjVk02dGkrOXhpM3dEcGtTUXZSaGVrRlV0TnpEM2JCZE5aTnpS?=
 =?utf-8?B?UjZIVG5KOFRGUnRGejNhVkhIakdmUjBQSzQ4NDgvZHpNV01xSGhZd2VZSU80?=
 =?utf-8?B?cHBIZVVDY0RLUEtsdXFrNS9namZHbHlQaEl6VGVEM3BoZ2FSWXgxTVhyVWY4?=
 =?utf-8?B?Y0JLUmNkTlBTMlViSm14OG1RSEhYbWhGMjBKTEVoTFdYM3hQWHFScUJrL3JZ?=
 =?utf-8?B?UXh1eUlMRXlua0xsbm9rV2hjK1d1NkowU1VIQ216STZlR3p2bnU3UWFPenFQ?=
 =?utf-8?B?MjV0L2VtMWJQR2xFNlg0ei9wR2NFcnlPOHJNRUdPUCtkTWVXaHJIbDlMa2NO?=
 =?utf-8?B?eHQwSFZPQnlxeWhDVGNYYVNIUzhxQXg4MHpkb21LK1pXWTNPQkxDTnV5VTRE?=
 =?utf-8?B?NWR3MEtlaFcybDZaMjVCeXBQaGg5ZjBteWxucjlaVE5vdS9zYkhDZGRFdU1C?=
 =?utf-8?B?WVhoRFRkNDFtYTl5dWlaNWtka3ZscnhTSFNzeGo2ZFNFOWd6OVJHdVlqUlA3?=
 =?utf-8?B?NW1YREZsYTJibW5pVzEyaGdneEQ2Q2Q0YlFRN3NoWkJrWTlyakxTQ2FJQWZs?=
 =?utf-8?B?TzIyRzRWcXd0RFBjWnNxaDdxRWc3TVNoVXRvSHpENXpSZHJlVFk2elh4UDhP?=
 =?utf-8?B?MUlJZlhQaVJ6bVNyY3MzOTBMQTRnMTZBUXdQcUpVYVdkZ2ZpNXN4Rk0zdlA0?=
 =?utf-8?B?VlY5ZFhjQW83RnZvOEF4Mmx1TFVCY01mMWJGWHA0c1BOYzJDRFZjTkNIcWRl?=
 =?utf-8?B?K2tPWnRlb2I3U0hoZGxLTHk4Q2lSS3U3N05xUVBnb21FdXBNREQxVWVPeUFW?=
 =?utf-8?B?TzVyc2piTGF3ZE15MWhwcW4wMVI2YVJBYTF1Tm9ZSm5neFB6cmVoZE0xZ3NV?=
 =?utf-8?B?WXpDb25BcXFMRnVFRXIxMUNBQ0xSbG01alNxRi8xZDJYTEF4ejMzRk5ZS2RW?=
 =?utf-8?B?Uy9FS0NtbTN3RU9oUGcxQjMrZy85NWNlcnBER0pPNnZlNkUvRzk3cmJ6ZHVv?=
 =?utf-8?B?dTE2NVFsR0I2SHpJNG5WZ2dNbkp4VVN5KzRYTGthQXJVaUErVXhIREJQdDdD?=
 =?utf-8?B?Sk5aMkJCRVlTZjVtUGZ0SmZZcFZGdHdWV01MRWcrZElmNDRkbDFyTUFoNUxW?=
 =?utf-8?B?T3dyMU1sSkhnT01PbFFaeEJZUGVYM2FwWHg1VFJ0SmswQXpWV09udTJKTzdW?=
 =?utf-8?B?bnlVemZxcVBNOWpNckxhZ2dOUGorZ1dQMTVvUTZjY29DOWtwdmxsenFBekUw?=
 =?utf-8?B?NkF4WkJTUXdlSFkwdk5iOHQyK2UzQVh4cnBhL0VrNkhNS0RLSE1oTDRWOG54?=
 =?utf-8?B?R004ZTJ6OVRsa3pWV3hwdEpkRXQzU3RueWdjNXdleTFzM05Qd3p1aTZ6RjlD?=
 =?utf-8?B?ZHF2VVpyL3N0ZWlFeWEyZFdLWVJoc01tM2hMK3hUTkxoTVpwbkpsNWZJNXFG?=
 =?utf-8?B?M3luZi9kdHUwMThBb3dza3RUbTl2cVN4alJsZ2oxVTdBRERTSlFzK0x0aFEz?=
 =?utf-8?B?ZjlocU54UjBxblhSZWYyaDR5MEpieENhQlg2UUlDSVJ4SUZrTjF5WUgwQzhs?=
 =?utf-8?B?eDBwcC9DWFduNTVYR0VES3lLM24vSkgyK1p6dFZoUmRNTlA1K1ZLdmNUUnI5?=
 =?utf-8?B?QWhRNEhvTEJOYWpvZUNTSFZmc0pJWVNxZ2F6UmJJMjB6Z0V0R1ZLVm5wczd4?=
 =?utf-8?B?T1BTeUpRekFPYkxweVJEWmNNNTRrWmpzREFEWkhuTWhFU2JDQjQ1dEtEbWZG?=
 =?utf-8?B?clVtV3R0YStva3dNbUxRcDFUWnp3cTBMdU5wNHl0YTEzZkIrY2RMelBQd2Ft?=
 =?utf-8?B?V3ZzSDdCM1JSWjVDMWl6NXBzWDkrT1hWSFhCNWNKd0lKYVNQQ1NhbkEydUJn?=
 =?utf-8?B?Zmg1Q0pWTnpzSStMcnRIZU9KZCtZZmtRa25GR3c1QzF0T2JHV01pVVpKbHFs?=
 =?utf-8?B?NHBORjAzTjhBRXNBdWdCTExudzhXbGVmeW9GcEd5WkVJcC9pU09lemxOV2Vh?=
 =?utf-8?Q?EKvIuovbGxJF262eiUr+ufoEE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d12410d7-af80-4ccf-df1f-08dbc678d136
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 14:30:41.2886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +of9qzcFghvdsyyKXkqXP7r03n4esCTVKDBSboemZPLI1rGsqWvDWJBD1o2XAAAG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8256
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
> From: Fenghua Yu <fenghua.yu@intel.com>
>
> Add the interface in resctrl FS to show if sparse cache allocation
> bit masks are supported on the platform. Reading the file returns
> either a "1" if non-contiguous 1s are supported and "0" otherwise.
> The file path is /sys/fs/resctrl/info/{resource}/sparse_masks, where
> {resource} can be either "L2" or "L3".
>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
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
> - Reword patch message slightly. (Reinette)
>
> Changelog v2:
> - Change bitmap naming convention to bit mask. (Reinette)
> - Change file name to "sparse_masks". (Reinette)
>
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
>
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 725344048f85..945801898a4d 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -895,6 +895,17 @@ static int rdt_shareable_bits_show(struct kernfs_open_file *of,
>   	return 0;
>   }
>   
> +static int rdt_has_sparse_bitmasks_show(struct kernfs_open_file *of,
> +					struct seq_file *seq, void *v)
> +{
> +	struct resctrl_schema *s = of->kn->parent->priv;
> +	struct rdt_resource *r = s->res;
> +
> +	seq_printf(seq, "%u\n", r->cache.arch_has_sparse_bitmasks);
> +
> +	return 0;
> +}
> +
>   /**
>    * rdt_bit_usage_show - Display current usage of resources
>    *
> @@ -1839,6 +1850,13 @@ static struct rftype res_common_files[] = {
>   		.seq_show	= rdtgroup_size_show,
>   		.fflags		= RF_CTRL_BASE,
>   	},
> +	{
> +		.name		= "sparse_masks",
> +		.mode		= 0444,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.seq_show	= rdt_has_sparse_bitmasks_show,
> +		.fflags		= RF_CTRL_INFO | RFTYPE_RES_CACHE,
> +	},
>   
>   };
>   
