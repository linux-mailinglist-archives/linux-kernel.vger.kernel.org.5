Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4587AF0D5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235279AbjIZQgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbjIZQgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:36:23 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1C8B3;
        Tue, 26 Sep 2023 09:36:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9/osZERrnZwj/JRn+Xy17KX0Sej8RhzLgzupgGHmpxusF4V9dw2mM/HrjSX8FP71nU4TbVkkQQlVONbO+JZmszAOq5gQEtL96NYSq4YTmAijSLQSQIeXWGI7P0rO64OqK+hWKsFaOVrhgXBU4N9Yc22lgVgaWT910MwEbpIYEfNRU6ITtkxz6Zp76Mg13ZFjYRLdlDRGJCQvRvLv8P1sd5x5QopLOF04loIHos9pqpjuGaaiR3RtmWLErOiQKhL7Su/jSApSO1Xv6yPmTY5TcI1lezrunh8+IW+vN3GwiAafTRoiZnejh8OmsWhs1zVi0wlr1uALGjqWrbDGlVqGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1TCQ6Mp76zF828RwpJ7eh8zKO7cfESDHBxEp2jXZ9Oc=;
 b=eKwKRucdtOzWvuqvlgLgKobikL56J8Zy17Wi1FoSfWgAQ5yckSS2pWQlx0hFskgxIjg0NYxYf8M17pODTzyPE9TowliG8dYPeC0jI8v/hNjZEoJUIvk9O7t6LtJ4zj5iyqrhQXDi80lvLknYUUYHhYaUxFu2vY8UZbVvQeadXo7/+Z/juydrp0xdZsvq45HwlS3eLVuir4d5iXe3+1ZQA8dAkTaLr0SSr/fUPSl9fwn++ZnGywq8LKOupLcUQNS6vW7G1gXfY1nDZ80JyUJs+zCxkZMcPtBFgD4tKbzEFd8FW9e+fBdVDGlQEwniMxvkD8i5wnJ/d79YFSL7C3MfBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TCQ6Mp76zF828RwpJ7eh8zKO7cfESDHBxEp2jXZ9Oc=;
 b=uZw5yEp2EloAOi3/svlpx4LK566eLDSzEI+U3xQ1iy4GjEUoWwfjLl1Ye7eh76b4NZjDCsJOOOkhpgC+gLZpXfZuqYIZyQHDqvRK/ttbZFlwZ7EU8G5c16VNgJj1U0E/TGrWFMXbQzK6EpuD+isNaIYpBuEc8wwxXQaWvi1zYPM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH7PR12MB5735.namprd12.prod.outlook.com (2603:10b6:510:1e2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Tue, 26 Sep
 2023 16:36:13 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e%5]) with mapi id 15.20.6838.016; Tue, 26 Sep 2023
 16:36:13 +0000
Message-ID: <e78da512-f8b4-6740-cb40-cac226c008bf@amd.com>
Date:   Tue, 26 Sep 2023 11:36:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 1/8] x86/resctrl: Prepare for new domain scope
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
 <20230829234426.64421-2-tony.luck@intel.com>
Content-Language: en-US
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <20230829234426.64421-2-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0162.namprd13.prod.outlook.com
 (2603:10b6:806:28::17) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH7PR12MB5735:EE_
X-MS-Office365-Filtering-Correlation-Id: 555c6379-6d3c-4f98-40f7-08dbbeaeb27c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zL1sfUXyf3wSgfzD7GUphqM/oawcX9ZqIeFvBZhQD8euY1tIesa0SVtAuQPf58GdtYCDw8XNQv7fp7PTNZpshKvta0hihMXbJoTmNoH6N5HXZnl7XVI/24tvMJEA0Lyp3mbvGq8C8aeh0oL+1BKo/jLf+bWDnIS9+X2x+CNSL2pA/bmdGAXH44Evw4MAJkoYp+LMpa45fJxBqiG0saBzJvOeG6/EHoYggAld9tKdoOxO7SMCtY7y8IW0IaVETOLxKCXtEnjThFxQprJKeNfZGL4DR+FTWN4uPbIe4hM1j9sCdmhXKvuGQzll8Xb5h5/exuUdlw+RtzatAYNarB5J2J6hKNXv4Xrys19ukl//73Gv/wIX7CJ18URM9/CW9MWcrO+y+DwztqzZ5em8Pb8axIaDKhWZeTu2iE/UexWPA/QyGJirnfZMZSNR4327OabtqMCx9uzfCeYu4xDgXA+rnGSoaRaB/sTSNnOh1960zHCBAdyCLSLKIxtzJTlDGnbHYPRLNhWrNr9tIh/hXUL++HmONyA4YCvIyFR3CGKNJsckumE0NbMTHlKmczHtIjybhdXyWqtj/hJZsklwATueu7s8MChRI146Zya9E5Fxw5yRfOvh35hooToDhRzoW0voYn2k+oI4SRfrk1e6NcPD5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(39860400002)(366004)(230922051799003)(186009)(1800799009)(451199024)(6512007)(6486002)(6506007)(53546011)(26005)(2616005)(41300700001)(36756003)(316002)(110136005)(54906003)(66476007)(66556008)(66946007)(2906002)(7416002)(3450700001)(8936002)(8676002)(86362001)(38100700002)(31696002)(31686004)(4326008)(5660300002)(478600001)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnJTRGlzWDhTbVdrMSsxZGpHcDV5Y3lraytBSWROV0FxQXNjRzk1WUQ5Tk9T?=
 =?utf-8?B?RVAvRWpvR3dUNURZVnZqZEdRRzRGdlU4TEpSVnRrOVUwSGxDWmRFRVF0SDIz?=
 =?utf-8?B?UnRqODd5ZmVGWHFpL2laUUM0ZXdQb3JqSW5oUDN3U3pBU2NBbWp4eENGME1o?=
 =?utf-8?B?Zi8vNGd2NFZ4UWZHN0hmT2JRQ3RnOGMxd0pHTmJjNXNJb0hqY1lZUlVpTGVl?=
 =?utf-8?B?Y1ZzenNTSEpXckJ1ZnpIYXNHbENtNkFiQ3FNYTdpcTJ5Q3Uva29TYzQxMkhZ?=
 =?utf-8?B?aWYyNnhHV1BwVWtsSFFmaWdZc0NZeUxmeDJ4TWpZVmVjUnFYNWpvTmUxMVVG?=
 =?utf-8?B?akVSa1BGWmtuVUZoUkVodG9oRVFxQnczVW9NQkhPQjVxQ3VHd0pDOFJiRFQr?=
 =?utf-8?B?TExSc25jbU50c1ZqR1JwR1JPaWpXUmM2WGQ5bzZQZ1RFQmg0WEpoRGZuV0hG?=
 =?utf-8?B?bWU0SllpRXllMExLbFlKV1ZETndHQ0xHMkladGhPZ0hEWjVBdHJ5cnkxQTht?=
 =?utf-8?B?RlM2WGFjcUlkdVQydTRVTW44dDdMNFRuL1NsS2ZiTUY1OFFobmFyY0Y5L1VI?=
 =?utf-8?B?ZzdMbG9pY2trRE12T1dNa2NwYXptejRQR3lnWEpyYWhnTDZTNzU0dHRybEs4?=
 =?utf-8?B?OW9MNE1leGVaWHpXRStnU1RwRmN3SnczNmhFbnIrbmszdXZEcTFHU2dOMnJJ?=
 =?utf-8?B?Z3BsZUpMS1RnYWQzM1JvMUhHYXVIM01TaFFYWUNLOFlmRWdNdHBEa1dDNERj?=
 =?utf-8?B?WjgzM1JHYzNNaXFxbmdpUCtES2ZHSXVpSXpLTXhFcTVhN0MxcGx4eVlsczlh?=
 =?utf-8?B?bmtIYjZ5dEh2LzJTZG16TEdIRFhHUDVjTTRkUmlOc3BXZ25zVm1Sams4eDFR?=
 =?utf-8?B?R05CUmlyWkJvNmxDMHJTTGNxWm5nRjdtbWxLMnJsSU4vU2FxRnZXaWNRTy9D?=
 =?utf-8?B?M1lyNTQ2eGJLeEhYTG03akNPOTltSWEwVjRrYS9lc1R0MEpTbXM5ci9iQUIr?=
 =?utf-8?B?U0U0SFd3T2ZmdGV4V1R1OWNPSW1pL1RaRVZOemhOMm04NGE0c0FtUlZxVjh3?=
 =?utf-8?B?N3l5ekxxcXVxMVVHRjRCTGlUK2xsY3ZSNElOeGMxeEdTNTFDSGhRcTVvWFgx?=
 =?utf-8?B?aUwrR0R5WjVRSXNPSUNCTk1hMndiNCtJSXdLaHpjclQrYVQ4dzFNVVI5Ry9D?=
 =?utf-8?B?Zk1DR0xpVWRZWFhRMzNIOXJwbUFkejVBdjdxY2cya0R1TU0yRkxWUTRHNVA3?=
 =?utf-8?B?NlpOZTBJUG9pN1hBdGJqNVJPL0lsWmREb2dVRTc3QUJ0Z3BhNEtkK1IvczFt?=
 =?utf-8?B?TlRVU1NhTFhUTU9ndFNJemliZXgwK3Z3WkxIVnVRRzBOdGFhVjVXNnJITDhH?=
 =?utf-8?B?dDBCY3pvbHhRYmpJeXF4U2hwOWo2cG5Ed25BLzZYWmViYjRHOHgwckJNUElp?=
 =?utf-8?B?TmJWbzlGV1JtR1ltejkvRkNYbXhmTTIvWXo0TFkwUHVXZjM1VTBCSmg5cFF4?=
 =?utf-8?B?YmR1MUJrcWdaeDloSmF5MGVVMGoyTG1WZktXTnNnbUt4bUgwaXZQektxVHo3?=
 =?utf-8?B?V3dmV0dMK0VSVGlyWEZyaFFzaEh2eHVjUnN5N3lrZkRyazFkYWdXSWdOams0?=
 =?utf-8?B?cmd3UTFqYkFiVjlXTTFtK0dSMVA4K0U2ci82SzAralFPdnlJNlQvUlcrMFBO?=
 =?utf-8?B?b2dnTTVHdGhCUmFPcE5hRUxESUtGZFBzRmpwWjZYa2lIWFpiMnZudjh0Vksz?=
 =?utf-8?B?ZG14aHB4S25oRHIxK0c2Y2x0VHdsWVVBL1hTNHBUT3puc3ZISXQyTEs5d2hx?=
 =?utf-8?B?QU1IYzZOSE1mVGVHUjNNejg2cmswWnNpNDlJUTU1Q3VMcHNBK1ZyV0h6Wm1X?=
 =?utf-8?B?SnNqcTZUVnNtMUFLYko1UlNLL1lxRHBZTmRTdjREa0ZZK2ZvU00wTm9mMlU0?=
 =?utf-8?B?WWN4L1hpd3NKbEdwb2VuWEluSk5DYnR0dW5Fc0JzTUdJWmJ5QmNDN3plSTU0?=
 =?utf-8?B?RmlBZHoya1lHUE13VzlNUTIyWnc3SXlYRFNXd3RmMGtxbU8zcmlkcmY4cHQ3?=
 =?utf-8?B?bTRjbnh2L1M2Zzd3UEw3RDNrUUdyZUV4RE1MbEtTUmt2allFWDBRclV4QjVQ?=
 =?utf-8?Q?heXU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 555c6379-6d3c-4f98-40f7-08dbbeaeb27c
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 16:36:13.2556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x6cHjxfBljsaN6pKXtmPNwLT9b+uLF+heGyZkMJ4ipXO3C9dPjOsfWkoBUlUuaRm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5735
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 8/29/23 18:44, Tony Luck wrote:
> Legacy resctrl features operated on subsets of CPUs in the system with
> the defining attribute of each subset being an instance of a particular
> level of cache. E.g. all CPUs sharing an L3 cache would be part of the
> same domain.
> 
> In preparation for features that are scoped at the NUMA node level
> change the code from explicit references to "cache_level" to a more
> generic scope. At this point the only options for this scope are groups
> of CPUs that share an L2 cache or L3 cache.
> 
> No functional change.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  include/linux/resctrl.h                   |  9 ++++++--
>  arch/x86/kernel/cpu/resctrl/core.c        | 27 ++++++++++++++++++-----
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 15 ++++++++++++-
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 15 ++++++++++++-
>  4 files changed, 56 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 8334eeacfec5..2db1244ae642 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -144,13 +144,18 @@ struct resctrl_membw {
>  struct rdt_parse_data;
>  struct resctrl_schema;
>  
> +enum resctrl_scope {
> +	RESCTRL_L3_CACHE,
> +	RESCTRL_L2_CACHE,
> +};

How about?

enum resctrl_scope {
       RESCTRL_L2_CACHE = 2,
       RESCTRL_L3_CACHE,
};

I think this will simplify lot of your code below. You can directly use
scope as it is done now.


> +
>  /**
>   * struct rdt_resource - attributes of a resctrl resource
>   * @rid:		The index of the resource
>   * @alloc_capable:	Is allocation available on this machine
>   * @mon_capable:	Is monitor feature available on this machine
>   * @num_rmid:		Number of RMIDs available
> - * @cache_level:	Which cache level defines scope of this resource
> + * @scope:		Scope of this resource
>   * @cache:		Cache allocation related data
>   * @membw:		If the component has bandwidth controls, their properties.
>   * @domains:		All domains for this resource
> @@ -168,7 +173,7 @@ struct rdt_resource {
>  	bool			alloc_capable;
>  	bool			mon_capable;
>  	int			num_rmid;
> -	int			cache_level;
> +	enum resctrl_scope	scope;
>  	struct resctrl_cache	cache;
>  	struct resctrl_membw	membw;
>  	struct list_head	domains;
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 030d3b409768..0d3bae523ecb 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -65,7 +65,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
>  		.r_resctrl = {
>  			.rid			= RDT_RESOURCE_L3,
>  			.name			= "L3",
> -			.cache_level		= 3,
> +			.scope			= RESCTRL_L3_CACHE,
>  			.domains		= domain_init(RDT_RESOURCE_L3),
>  			.parse_ctrlval		= parse_cbm,
>  			.format_str		= "%d=%0*x",
> @@ -79,7 +79,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
>  		.r_resctrl = {
>  			.rid			= RDT_RESOURCE_L2,
>  			.name			= "L2",
> -			.cache_level		= 2,
> +			.scope			= RESCTRL_L2_CACHE,
>  			.domains		= domain_init(RDT_RESOURCE_L2),
>  			.parse_ctrlval		= parse_cbm,
>  			.format_str		= "%d=%0*x",
> @@ -93,7 +93,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
>  		.r_resctrl = {
>  			.rid			= RDT_RESOURCE_MBA,
>  			.name			= "MB",
> -			.cache_level		= 3,
> +			.scope			= RESCTRL_L3_CACHE,
>  			.domains		= domain_init(RDT_RESOURCE_MBA),
>  			.parse_ctrlval		= parse_bw,
>  			.format_str		= "%d=%*u",
> @@ -105,7 +105,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
>  		.r_resctrl = {
>  			.rid			= RDT_RESOURCE_SMBA,
>  			.name			= "SMBA",
> -			.cache_level		= 3,
> +			.scope			= RESCTRL_L3_CACHE,
>  			.domains		= domain_init(RDT_RESOURCE_SMBA),
>  			.parse_ctrlval		= parse_bw,
>  			.format_str		= "%d=%*u",
> @@ -487,6 +487,21 @@ static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
>  	return 0;
>  }
>  
> +static int get_domain_id_from_scope(int cpu, enum resctrl_scope scope)
> +{
> +	switch (scope) {
> +	case RESCTRL_L3_CACHE:
> +		return get_cpu_cacheinfo_id(cpu, 3);
> +	case RESCTRL_L2_CACHE:
> +		return get_cpu_cacheinfo_id(cpu, 2);
> +	default:
> +		WARN_ON_ONCE(1);
> +		break;
> +	}
> +
> +	return -1;
> +}
> +

You may not need this code with new definition of resctrl_scope.

>  /*
>   * domain_add_cpu - Add a cpu to a resource's domain list.
>   *
> @@ -502,7 +517,7 @@ static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
>   */
>  static void domain_add_cpu(int cpu, struct rdt_resource *r)
>  {
> -	int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
> +	int id = get_domain_id_from_scope(cpu, r->scope);

You can directly call
        int id = get_cpu_cacheinfo_id(cpu, r->scope);

>  	struct list_head *add_pos = NULL;
>  	struct rdt_hw_domain *hw_dom;
>  	struct rdt_domain *d;
> @@ -552,7 +567,7 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
>  
>  static void domain_remove_cpu(int cpu, struct rdt_resource *r)
>  {
> -	int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
> +	int id = get_domain_id_from_scope(cpu, r->scope);
>  	struct rdt_hw_domain *hw_dom;
>  	struct rdt_domain *d;
>  
> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> index 458cb7419502..e79324676f57 100644
> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> @@ -279,6 +279,7 @@ static void pseudo_lock_region_clear(struct pseudo_lock_region *plr)
>  static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
>  {
>  	struct cpu_cacheinfo *ci;
> +	int cache_level;
>  	int ret;
>  	int i;
>  
> @@ -296,8 +297,20 @@ static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
>  
>  	plr->size = rdtgroup_cbm_to_size(plr->s->res, plr->d, plr->cbm);
>  
> +	switch (plr->s->res->scope) {
> +	case RESCTRL_L3_CACHE:
> +		cache_level = 3;
> +		break;
> +	case RESCTRL_L2_CACHE:
> +		cache_level = 2;
> +		break;
> +	default:
> +		WARN_ON_ONCE(1);
> +		return -ENODEV;
> +	}

Again this may not be required.

> +
>  	for (i = 0; i < ci->num_leaves; i++) {
> -		if (ci->info_list[i].level == plr->s->res->cache_level) {
> +		if (ci->info_list[i].level == cache_level) {
>  			plr->line_size = ci->info_list[i].coherency_line_size;
>  			return 0;
>  		}
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 725344048f85..f510414bf6ce 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1343,12 +1343,25 @@ unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
>  {
>  	struct cpu_cacheinfo *ci;
>  	unsigned int size = 0;
> +	int cache_level;
>  	int num_b, i;
>  
> +	switch (r->scope) {
> +	case RESCTRL_L3_CACHE:
> +		cache_level = 3;
> +		break;
> +	case RESCTRL_L2_CACHE:
> +		cache_level = 2;
> +		break;
> +	default:
> +		WARN_ON_ONCE(1);
> +		return size;
> +	}

Again this may not be required.

> +
>  	num_b = bitmap_weight(&cbm, r->cache.cbm_len);
>  	ci = get_cpu_cacheinfo(cpumask_any(&d->cpu_mask));
>  	for (i = 0; i < ci->num_leaves; i++) {
> -		if (ci->info_list[i].level == r->cache_level) {
> +		if (ci->info_list[i].level == cache_level) {
>  			size = ci->info_list[i].size / r->cache.cbm_len * num_b;
>  			break;
>  		}

-- 
Thanks
Babu Moger
