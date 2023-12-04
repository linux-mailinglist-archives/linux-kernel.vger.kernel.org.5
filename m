Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7B6804248
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 00:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbjLDXDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 18:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbjLDXDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 18:03:30 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25473127;
        Mon,  4 Dec 2023 15:03:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/qr3jHgmay4XiGmk5zwOupo7gtYe0fhTaHCllE1AsXrVfq8AQahkE6VVpWdQ71w/oGL8upOW0PQ6Xv3aNKKwAixr4M1WXA/fA0eSeUOUhbdoAjFTFBbZt5FFY8rufnqSoETZVrPD4hgsPckSWBklhNkYkDR7iFctdGS5ynSA5fss8EnpwQVKKY5tnoj+28Ij2qYR9KFj1BM/v/cCCVDoqi102/M3GoHIn/0S930YtHnp5FtnJP4CUJ7koRGvDbwGh+Np9FMsEiXiJB3B6EExFXpj/jwJsQUSX2tsWSgW0/eFUtgRBGT0yrDuiW7z3FV4uRfwN8/uNN0iPPg0rqqvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHEDBdvCoV5fz5hZlPq8FPRaFmcrCAyV+hty7GQ3xQk=;
 b=GuAK5q6nf3JO896+BfWd9G7/sUmop6L8o6SxvppW5tQoRhCxqK9yOurv8NiOXWSSDfAElhtWDesjcKuVxCKIxoaOoscePIdxLwEvs1MRRK6qMlOF4xEFCDYmJpcXOY94TAYcn4RirSL86Df7GhQnen38DPAGvwPxgSteRhvhEHsRo8nx+7NeEUIn51rSfc66evYicOrur4/VZdsYWVZ0FGzxlSnlUURh7gJ8mF43vdr6czlU7QRcA64dtTkyoMWCUu70QlxkbElaT3OvJdEy7lVFOzm+nnhELkafvCj6MyAibsIe1P+xILaklN62J/mQ9QM+/BXT3Old8XgvdYJQ4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHEDBdvCoV5fz5hZlPq8FPRaFmcrCAyV+hty7GQ3xQk=;
 b=WfhWxUaKfW0q2I7CwU9F/b9VbFiqrTpyzRiaLQzBstyALRuknRTQt+gD6FbcwwGOmaMeRV8qgHZaaBoyKlQpTuLv1DW3PPRyC/Qb90oex0atcEX4tVmmI4vrqEEamBxX3y+ghgnnvSzm4/5no2b3hxHy9loufSaMT6iNZO/w3ng=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS7PR12MB8348.namprd12.prod.outlook.com (2603:10b6:8:e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Mon, 4 Dec
 2023 23:03:26 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%5]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 23:03:26 +0000
Message-ID: <557e7a7c-5cc8-bc3e-a8aa-95c83ae546f6@amd.com>
Date:   Mon, 4 Dec 2023 17:03:23 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   "Moger, Babu" <bmoger@amd.com>
Subject: Re: [PATCH v13 1/8] x86/resctrl: Prepare for new domain scope
Reply-To: babu.moger@amd.com
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20231130003418.89964-1-tony.luck@intel.com>
 <20231204185357.120501-1-tony.luck@intel.com>
 <20231204185357.120501-2-tony.luck@intel.com>
Content-Language: en-US
In-Reply-To: <20231204185357.120501-2-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0061.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::38) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS7PR12MB8348:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fba21d4-8c5c-432e-0361-08dbf51d3938
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C/XuNcjySNowZqKoK7ZsH7YR5Dk2zfe1wyITe5RJ8VBr/5VSNFbJ/7t4rUa3ambfD3ul2CxfUIQmOQXcRpqidq8jg9I9X4vucgd4Zf9uqFbn8u8mrN0tdu/OP8mNuwkaCXAo0iwPbd4LsVB2P0s5bLDEh3z7OiUu4V+HGLDDS4s+qcmAAFQQ5TwypsPY994rPMD6fl/Ycbho4g0LxqIU3kTwUhPeoEZ1nC+BZLLwUOK+YM4v4ykUkD+hX7cMLYUE5fi2ScY15co37DSZ2ppjz36FPii2GPUcOWkAzzo6xth3olFJf+mLLxpt1iqu25dg79nrtgKb2xAhN2KIG8NPpUU7UqjehplXiCMuTghVqRVugV1Nj6U5dQc2USKZk8HMtNBdEkjn9SGtJKb7/9mGq4GoEMI4ee9DsjsrZubmZK1tG579XAgtK04VDu/Aeu/GYaagH2Bu3qjxhB8t5RsGwkZZUnrF3/90l0C3vFYfcQxe215s2RgpXTjRDRYvFmBqviwDwumQiMziYbIY6mCYXcL1kB5/SaGvJ23GHTj/IS+MjoV/t0CGTaQ66mToaxvK9vrUr8r+MtAXRqq56+3KmbW6ggOcJtqk+21V/zXPo4TfYioyCw42AKa5jc6rFSBdGRfkjUya9PdQldRGcGd3ig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(39860400002)(366004)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(41300700001)(38100700002)(36756003)(31696002)(2906002)(83380400001)(5660300002)(7416002)(26005)(2616005)(31686004)(53546011)(6512007)(478600001)(6486002)(6666004)(6506007)(4326008)(8936002)(66556008)(66476007)(110136005)(8676002)(316002)(66946007)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFFTSGNwcmZJcFZzZzhwUk9ETEFlbkhscFprT0xSZ0FlUkFXam9SeUZWOEVZ?=
 =?utf-8?B?TGtsU2V1d0dnWWZSRG1TWllEY1VOMVFpRlZaa081bldDR2x1NDNKUWUyL0Rp?=
 =?utf-8?B?MjJFTys3ZitXMCtWTE5sVVJpMnVNRGY3bUtRbGJWbjVWNnNXSWw4UzRWTXZF?=
 =?utf-8?B?U050eW1tYWJwNmZCYkY4UWk3NzYvcXZZK3RMQUZ0Qnl6ZUtSUm80RWNMM2ti?=
 =?utf-8?B?RXBaUHJxb21oVGpTN0JEU3gxZ25hM1lMRHNXOTcvR201VDBSWWllMTVBTkNo?=
 =?utf-8?B?eEM1NUIxazVITVlta3BwZ2tSRWRyamlsOVhRVXd1WHNQY0FBZlcxNU9KTEIr?=
 =?utf-8?B?d2RDa0Z0eUw3NGsvcTcrWHFXTjBjUUJnZklySWUvT0lReFc1bXdLbTAzaHcz?=
 =?utf-8?B?d0NJVmRFQVJIOUxZR1R4YnBFY0FTRmw5SFRXYnJqait5NG9EaDlvY1BGZ21S?=
 =?utf-8?B?cWFDWHNkMFh3SFR4S2t6UlVFOVAzT3pDWVBEMVlNUDQ4MWtEeFFxQW5vd2cy?=
 =?utf-8?B?ZGhYNVU3MEFkTy9qSTNBbXhGNkkweTNBM3ZMaXBodXJGV2VmNHFIYUE0WWRl?=
 =?utf-8?B?Um5VMXhOQU9CZ0J6OE5JSGVCdStlUjU2ei9DRytJS1RQNDR0YUFqV014eDdS?=
 =?utf-8?B?S1dMN1pFMVY3OWk3ZjVCMGZGWHQ2Q0NMWlJ0emJ4VENaaUFnQ3JKOTR4SUR2?=
 =?utf-8?B?bVllTjlQV2ZHaml2WEUxakUzcnc0ek4wczh5b0RRWXlta1MwcnRYaEEyQm95?=
 =?utf-8?B?OXp3a0dFeFU3bEhqWTR3VlhUcE92aGRaYVBhakNQL2lNV0ZxL3Q0UXJqUDNL?=
 =?utf-8?B?QnFjeWxvZFpibHBuTDl5d0tGakNOZzRSdWNPSy92WHUwOW16TlJzWXBFV2I5?=
 =?utf-8?B?aFYrVnZVN3BsNFFhY2ZuK2Q4dm5vRGk5UnA5ME5JL0VkNWpucDRMV1lvSm13?=
 =?utf-8?B?TDR0Z2NTVWFud0d2K0N0K2RqQWltYlRHUlFOUnh3TlpNMlJYWnRkVm1vM2dJ?=
 =?utf-8?B?cTBsTnNDUmJkR09EbS9vMjk1bmdYMUh0VXZ4S20zRWVsa0VFVjJ4OGYvcFIr?=
 =?utf-8?B?eGRYVm5vOXljZURSckUxeXNvUmxzQWNGV3FXV3JURWlQNjd2VFZ5L1lncTZo?=
 =?utf-8?B?RnZ2NlljYTNMMXhzY3I1THRValZhUzZ6dER5VHJKVU1iL2hPL3BlQ2w0ekVY?=
 =?utf-8?B?dlovSUMrSVBSMWcybU1USVN1RGtTZEN1dlI2YUFkOG5FQWJ5ZmZRTWl6aHBi?=
 =?utf-8?B?TFc3MFBRTVFyT2ZzUjFab1hXYVRaZVBlWWlUc3R4Wk1pSmRtaHJjQ3BOQ2s0?=
 =?utf-8?B?NFY4cm1qYVl2SVBUU3VmamVMdU9EQ0pyK2xDampXRUo2TFZNODk2bmQ4NXVy?=
 =?utf-8?B?Q2YxcEZmdzgxUjNyTmtsYXdrVEtpQWhsbmpKY3JtTEk4NWV2V2xLWVoxUjlr?=
 =?utf-8?B?ZTJ3YVI4Z1F2WG5OQWRhS2ZWSWNIdzRMYk1vcEhuMTk3eElQcm4rV0JYK3JF?=
 =?utf-8?B?eHVFR0NKejY0N0xZM2Z0bzQ0cnBWVmJ3NUFENjREWHpORVFVandydEZpbkdC?=
 =?utf-8?B?MjVaY1ZFc0RneFpsNVZ3RlZHbW9HK2F5M1Z0bGcwQ252Q3JRbVpGTlRaOTZB?=
 =?utf-8?B?VzR1enlDTXJ0TjQvRXBnRk9yMlpweGZGTnhVNm95bUV6TnYxcDU2MFpWQmVE?=
 =?utf-8?B?aGNndkVjZ1B0aHkzZXJoSnBIb2E4M2tEWGpVZlUxVDVhMm5ZRElQakVFQ0Nr?=
 =?utf-8?B?RmJvWWhDd2M2WTl1dWNhbDJyNkMwSnNUWVpMQ3FVZnhzcTNDdjJmS0RKUnlW?=
 =?utf-8?B?b2ZCNVVpbnRodTRDcEhJRUIya2lSYlFPRDByTHJtQkx4NXphWGpBcjJUb3pp?=
 =?utf-8?B?U2oxMHRNejZKYXMzaVF3MHg4VGxoNmdEYlFvd1daSGFxcmovTkpkcTk3UWtE?=
 =?utf-8?B?ang4a09OZURrUW10MVFYYkFtaWJ2SnkvSUdPK0RFbE0zbHFFS296Q2lLNUZ6?=
 =?utf-8?B?N2RURXo3eGt6V3IycHhFMi9QUHVKUFFDYldyNzZiVUhDNXY0V1l4TWRzN3JX?=
 =?utf-8?B?TUJZaE1ZR1JkMXdtSThtY3U1STR1TlhXMG5IbUZ6TDRIeVJTcHBVRkNmNGEx?=
 =?utf-8?Q?JHXHn6LSKAyGTmb9LmjqHi1ni?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fba21d4-8c5c-432e-0361-08dbf51d3938
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 23:03:26.7589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Zp9olWveMoJLV/erpmh713Q22l8RkEgjqCG1iI56Vdx1RXNZU7TzRyE0rAr0eVW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8348
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/4/2023 12:53 PM, Tony Luck wrote:
> Resctrl resources operate on subsets of CPUs in the system with the
> defining attribute of each subset being an instance of a particular
> level of cache. E.g. all CPUs sharing an L3 cache would be part of the
> same domain.
>
> In preparation for features that are scoped at the NUMA node level
> change the code from explicit references to "cache_level" to a more
> generic scope. At this point the only options for this scope are groups
> of CPUs that share an L2 cache or L3 cache.
>
> Clean up the error handling when looking up domains. Report invalid id's
> before calling rdt_find_domain() in preparation for better messages when
> scope can be other than cache scope. This means that rdt_find_domain()
> will never return an error. So remove checks for error from the callsites.
>
> Signed-off-by: Tony Luck<tony.luck@intel.com>
> Tested-by: Shaopeng Tan<tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Reinette Chatre<reinette.chatre@intel.com>
> Reviewed-by: Shaopeng Tan<tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
> ---
>   include/linux/resctrl.h                   |  9 ++++-
>   arch/x86/kernel/cpu/resctrl/core.c        | 45 ++++++++++++++++-------
>   arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  2 +-
>   arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  6 ++-
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  5 ++-
>   5 files changed, 48 insertions(+), 19 deletions(-)
>
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 66942d7fba7f..7d4eb7df611d 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -144,13 +144,18 @@ struct resctrl_membw {
>   struct rdt_parse_data;
>   struct resctrl_schema;
>   
> +enum resctrl_scope {
> +	RESCTRL_L2_CACHE = 2,
> +	RESCTRL_L3_CACHE = 3,
> +};
> +
>   /**
>    * struct rdt_resource - attributes of a resctrl resource
>    * @rid:		The index of the resource
>    * @alloc_capable:	Is allocation available on this machine
>    * @mon_capable:	Is monitor feature available on this machine
>    * @num_rmid:		Number of RMIDs available
> - * @cache_level:	Which cache level defines scope of this resource
> + * @scope:		Scope of this resource
>    * @cache:		Cache allocation related data
>    * @membw:		If the component has bandwidth controls, their properties.
>    * @domains:		All domains for this resource
> @@ -168,7 +173,7 @@ struct rdt_resource {
>   	bool			alloc_capable;
>   	bool			mon_capable;
>   	int			num_rmid;
> -	int			cache_level;
> +	enum resctrl_scope	scope;
>   	struct resctrl_cache	cache;
>   	struct resctrl_membw	membw;
>   	struct list_head	domains;
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 19e0681f0435..fd113bc29d4e 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -65,7 +65,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
>   		.r_resctrl = {
>   			.rid			= RDT_RESOURCE_L3,
>   			.name			= "L3",
> -			.cache_level		= 3,
> +			.scope			= RESCTRL_L3_CACHE,
>   			.domains		= domain_init(RDT_RESOURCE_L3),
>   			.parse_ctrlval		= parse_cbm,
>   			.format_str		= "%d=%0*x",
> @@ -79,7 +79,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
>   		.r_resctrl = {
>   			.rid			= RDT_RESOURCE_L2,
>   			.name			= "L2",
> -			.cache_level		= 2,
> +			.scope			= RESCTRL_L2_CACHE,
>   			.domains		= domain_init(RDT_RESOURCE_L2),
>   			.parse_ctrlval		= parse_cbm,
>   			.format_str		= "%d=%0*x",
> @@ -93,7 +93,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
>   		.r_resctrl = {
>   			.rid			= RDT_RESOURCE_MBA,
>   			.name			= "MB",
> -			.cache_level		= 3,
> +			.scope			= RESCTRL_L3_CACHE,
>   			.domains		= domain_init(RDT_RESOURCE_MBA),
>   			.parse_ctrlval		= parse_bw,
>   			.format_str		= "%d=%*u",
> @@ -105,7 +105,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
>   		.r_resctrl = {
>   			.rid			= RDT_RESOURCE_SMBA,
>   			.name			= "SMBA",
> -			.cache_level		= 3,
> +			.scope			= RESCTRL_L3_CACHE,
>   			.domains		= domain_init(RDT_RESOURCE_SMBA),
>   			.parse_ctrlval		= parse_bw,
>   			.format_str		= "%d=%*u",
> @@ -401,9 +401,6 @@ struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
>   	struct rdt_domain *d;
>   	struct list_head *l;
>   
> -	if (id < 0)
> -		return ERR_PTR(-ENODEV);
> -
>   	list_for_each(l, &r->domains) {
>   		d = list_entry(l, struct rdt_domain, list);
>   		/* When id is found, return its domain. */
> @@ -491,6 +488,19 @@ static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
>   	return 0;
>   }
>   
> +static int get_domain_id_from_scope(int cpu, enum resctrl_scope scope)
> +{
> +	switch (scope) {
> +	case RESCTRL_L2_CACHE:
> +	case RESCTRL_L3_CACHE:
> +		return get_cpu_cacheinfo_id(cpu, scope);
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
>   /*
>    * domain_add_cpu - Add a cpu to a resource's domain list.
>    *
> @@ -506,18 +516,19 @@ static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
>    */
>   static void domain_add_cpu(int cpu, struct rdt_resource *r)
>   {
> -	int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
> +	int id = get_domain_id_from_scope(cpu, r->scope);
>   	struct list_head *add_pos = NULL;
>   	struct rdt_hw_domain *hw_dom;
>   	struct rdt_domain *d;
>   	int err;
>   
> -	d = rdt_find_domain(r, id, &add_pos);
> -	if (IS_ERR(d)) {
> -		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
> +	if (id < 0) {
> +		pr_warn_once("Can't find domain id for CPU:%d scope:%d for resource %s\n",
> +			     cpu, r->scope, r->name);
>   		return;
>   	}
>   
> +	d = rdt_find_domain(r, id, &add_pos);
>   	if (d) {
>   		cpumask_set_cpu(cpu, &d->cpu_mask);
>   		if (r->cache.arch_has_per_cpu_cfg)
> @@ -556,13 +567,19 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
>   
>   static void domain_remove_cpu(int cpu, struct rdt_resource *r)
>   {
> -	int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
> +	int id = get_domain_id_from_scope(cpu, r->scope);
>   	struct rdt_hw_domain *hw_dom;
>   	struct rdt_domain *d;
>   
> +	if (id < 0) {
> +		pr_warn_once("Can't find domain id for CPU:%d scope:%d for resource %s\n",
> +			     cpu, r->scope, r->name);
> +		return;
> +	}
> +
>   	d = rdt_find_domain(r, id, NULL);
> -	if (IS_ERR_OR_NULL(d)) {
> -		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
> +	if (!d) {
> +		pr_warn("Couldn't find domain with id=%d for CPU %d\n", id, cpu);
>   		return;
>   	}
>   	hw_dom = resctrl_to_arch_dom(d);
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index beccb0e87ba7..3f8891d57fac 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -563,7 +563,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
>   
>   	r = &rdt_resources_all[resid].r_resctrl;
>   	d = rdt_find_domain(r, domid, NULL);
> -	if (IS_ERR_OR_NULL(d)) {
> +	if (!d) {
>   		ret = -ENOENT;
>   		goto out;
>   	}
> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> index 8f559eeae08e..2a682da9f43a 100644
> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> @@ -292,10 +292,14 @@ static void pseudo_lock_region_clear(struct pseudo_lock_region *plr)
>    */
>   static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
>   {
> +	enum resctrl_scope scope = plr->s->res->scope;
>   	struct cpu_cacheinfo *ci;
>   	int ret;
>   	int i;
>   
> +	if (WARN_ON_ONCE(scope != RESCTRL_L2_CACHE && scope != RESCTRL_L3_CACHE))
> +		return -ENODEV;
> +
>   	/* Pick the first cpu we find that is associated with the cache. */
>   	plr->cpu = cpumask_first(&plr->d->cpu_mask);
>   
> @@ -311,7 +315,7 @@ static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
>   	plr->size = rdtgroup_cbm_to_size(plr->s->res, plr->d, plr->cbm);
>   
>   	for (i = 0; i < ci->num_leaves; i++) {
> -		if (ci->info_list[i].level == plr->s->res->cache_level) {
> +		if (ci->info_list[i].level == scope) {
>   			plr->line_size = ci->info_list[i].coherency_line_size;
>   			return 0;
>   		}
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 69a1de92384a..c44be64d65ec 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1413,10 +1413,13 @@ unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
>   	unsigned int size = 0;
>   	int num_b, i;
>   
> +	if (WARN_ON_ONCE(r->scope != RESCTRL_L2_CACHE && r->scope != RESCTRL_L3_CACHE))
> +		return size;
> +
>   	num_b = bitmap_weight(&cbm, r->cache.cbm_len);
>   	ci = get_cpu_cacheinfo(cpumask_any(&d->cpu_mask));
>   	for (i = 0; i < ci->num_leaves; i++) {
> -		if (ci->info_list[i].level == r->cache_level) {
> +		if (ci->info_list[i].level == r->scope) {
>   			size = ci->info_list[i].size / r->cache.cbm_len * num_b;
>   			break;
>   		}
