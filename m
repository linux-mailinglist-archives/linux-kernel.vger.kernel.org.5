Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E0E804250
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 00:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234741AbjLDXER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 18:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235350AbjLDXEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 18:04:05 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F0C107;
        Mon,  4 Dec 2023 15:03:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BL88nHCOAr5PZXFBsEx50pwJsBzzTD6OxWGDfx2SYQqsb1WoHESdTh8VHz2xTxehN5IGynCVjYW83Yf3ZcRR0e80SUtxQ3du3XLXR9kw4AIOD+DCQzy7bUCQqwKMw1AHadrAzSvUuT+ASrayo9cyHt13cwO5huMe4w7GB0qEa3Rye2zynhoQJmgdOimHP/xHxvNsvmOROYzbP1GehOHYMDRw+3ZtubqTLIsR7dI0WqgKs98pPg7Os1fYxtvGxyeOUYUBawGUn6y6yk7KNycEbwSXB1zZrCWA/yu2c0K9PplpmVtt5IlK7xA1/fhFgxnLLwRsRT+WIrWsv5bhhEcj3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d07j4bMm7PqrwV4ROps9lPB5vCs3aLVtcKLKBfc2zQI=;
 b=L5mid9bubZQn53xcbyhBbXblRgEjiqRKwnzcvb8/eAHOSSeLPFDxt9ZhfIMT7CJxSD4+gZbiantbq2Boqycnj8OHixvDKARynhaoOpv3x7pELcFrPrSObJlI7XgP+69k3jaxwNiRbCEcGiNAhJy+vz3rjJp1T5hOjuUrlzjNfWUF4GrawugGK4VkVq/LHKDV0mxmFoLaLlJ0bS19O1zm4tXMsKSefOlBBHRAlab9csE/j8AxAFCnG5xP+Lyn/zAIZRGbX7X2TK9H2s4sekKw2bPCOFbuidgU1Ouy1Y6dWn23Y++jBEkI2vLZihnUeupFQVFSii+gua/aYT+JqSZnTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d07j4bMm7PqrwV4ROps9lPB5vCs3aLVtcKLKBfc2zQI=;
 b=eXc6s6FL2JqUY0HzfNv7inYrtEGdTPz7tuilbEIJRfTP5NXZMZ0ysiMSv9DNitJxKf5gOO2OgwRkkfkRmnEJ3DOHTNEFVB3Gf1+uLY+HWr0lIiO1ybTynN9NMPTb6G7Zg/e9mkamWyjv9QpkWZ+07AKtQ/i1+TiCFUgGMN6Ei9Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS7PR12MB8348.namprd12.prod.outlook.com (2603:10b6:8:e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Mon, 4 Dec
 2023 23:03:49 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%5]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 23:03:49 +0000
Message-ID: <a5749a11-a4c6-7652-b4b7-4a221d39dad4@amd.com>
Date:   Mon, 4 Dec 2023 17:03:44 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   "Moger, Babu" <bmoger@amd.com>
Subject: Re: [PATCH v13 3/8] x86/resctrl: Prepare for different scope for
 control/monitor operations
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
 <20231204185357.120501-4-tony.luck@intel.com>
Content-Language: en-US
In-Reply-To: <20231204185357.120501-4-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0039.namprd07.prod.outlook.com
 (2603:10b6:510:e::14) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS7PR12MB8348:EE_
X-MS-Office365-Filtering-Correlation-Id: 41398d25-ad74-47b6-a272-08dbf51d460d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9iJltpYaVPtmmNdn9wn5sTzYu7vUrm62YIDDlBtcn8JeQ6LPS9vMtN22WJIuZVZCsHxWYMZ8PSboFybXYg11ssZ5AVyRa5BgaPKRp+sEdgRJqlbMrRvK9dD+tQaDDavb6ZV85kUtV8vkMxCbSH9/8pveA30DlBZ2e/uhnXib3b7gCcTA2ew6r2/iLjMHOTvHmhpuhEYonAuuPs3SazvcZIQgsURk10ojy6EshFPTEnI0BiNHvxb6CQdRBbknnq+XgUNcAzD1ek9yZtdUQql4+Guo8B69/d+qzAABJEm7N4iHr8Lo9oAP3L43ixthQSmzCHDBroAAW8witTmKgzS8qc+iIv1yEnbUZigO4dG3KONTJc6tso01nkdkKvYWOnzkR65GPClQtxEvB0Pipn0QyxwM0xgutAZym1VsJ1nqJOrO8wxbbK51sc7mdpydIQB7fDrlVXNLYxe0WaKD9yWQsbgQgVK0Ud+EGkK5UpRWqtUFZ8Hk1wG7z2UCcFU48c2Kl/kXRd11sJ1VtQgIewZUd0oHdEqjCAQ+xHZPvSWAhWcS3pIz7sZbBv7RtEUVBX31hmltQ44qIsnskWq6m+OtLBOYLoR73LWwtlJF9I/faZvCDB5q8sW0Z9jqc8EC/pCfapPXuRFEG/TYAxtV2Dz5nA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(39860400002)(366004)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(41300700001)(38100700002)(36756003)(31696002)(2906002)(83380400001)(5660300002)(7416002)(26005)(30864003)(2616005)(31686004)(53546011)(6512007)(478600001)(6486002)(6666004)(6506007)(4326008)(8936002)(66556008)(66476007)(110136005)(8676002)(316002)(66946007)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azBwQWZuQnZ2Q04zRnNydG9mQzRleGVHTXhkRVdhMnluV0ZKdXVVYjZlMGh5?=
 =?utf-8?B?Q2x1Y2x3UHJZSm9BQ0FxNjI0VkJ1OUUrcnFVMm5PTEozYmVPUjVidHlVQjdZ?=
 =?utf-8?B?UjkzSytjN1ZTMzlJMlBCQWZGR0t2d1h0a2xwUW5zanFKQ3pLNTNabHdvM0hN?=
 =?utf-8?B?Ylp4RmdJWmNyNk9STHpHQzlFTjJoWmgweXp5Z1JrdEtwUlB6S2hKZHVPbkxm?=
 =?utf-8?B?MlJGR1BTY2J4MGQvVytDQmFoSXBTUjU5OFN4SE8yVkRicldsUStWd1pGcFFa?=
 =?utf-8?B?ZkcycFJZaDlJUnMxUmJxSnkwbnMrRjF3VzdLUU10Rzk4Z0QxOTg5K0NnZTJx?=
 =?utf-8?B?UzA3dTkyckVPQXVrQVc4bmdKQjRnL2srcEZBTlVSWHByQ1NUQVFTT3M5YXMr?=
 =?utf-8?B?engrdmFhTi9YbS92Mlc1NlBmcWZWaFJyTUp0SkFNVUhjampUa2Vnb29ONnE4?=
 =?utf-8?B?b0gvalVhQWxOaTVndm9iSFBybTEvSUgzZHJYSU5FRTU3OXdoczJMY256S1l1?=
 =?utf-8?B?NU9JcjYzSFYySjRVLzdSTFJnNVc3QlU2VlFsVlRuUFlhZFNJK0N2RUljZ1U0?=
 =?utf-8?B?bUZFRjd1dkNxeWlmeUh3OVJ4VVQvcCt4Y1FqQzNNRlhra250RGd6c0ZoazhS?=
 =?utf-8?B?aTBYRXpPZmlNMTZHNG5KNVJWVlZXZ3Mya09rNTFOZzNJZHMxUmZrNVd1NS9N?=
 =?utf-8?B?YStHdUYzRnNMOStYNUFib1pWaFY4NmhMQkhOSDNXdHZKV21zYkZpcUhqcWtv?=
 =?utf-8?B?OVJPbXh1eEJwa0NRTWNrSUNVdU9aOFVNYTJlcGowZzEvckJHQlBGbEIwTWxt?=
 =?utf-8?B?NDcwV21PalQxU3ljWnNTSUVDdVg4MHNHdkpzR28xbHMwa2M5ZmFTdm9JenVh?=
 =?utf-8?B?V1o0L2dBbFlPVmVrQjZEeFFFSGJqK0pHeSt6SVhJSlI1K1l3RDNnWXFvd2V5?=
 =?utf-8?B?eHp4bFBleldGSE1SaU1ZeVdFL3NaaUJydHhIdW5uMFRvbU4yMzN0VmFHN0J0?=
 =?utf-8?B?aFZoU2V1OFBZKzFQejlyTVVQMTFVU3Y5d3pDWlQyVUYrUG9MZW81clpNU0Zr?=
 =?utf-8?B?bTJ6OHFod0pDMXdaQkR6YkNvckhROHFxeEdlbDlaR2MxbElwYjdiQ0ZaNGRi?=
 =?utf-8?B?OHo0R1BjZThadjVTeTlScEZ3bTVPUWtQM1R5eG93NGNhMTZ6SURVSHl1R1l3?=
 =?utf-8?B?eWk2dG1kdGhRdm9scjlPQjNkYWt0WElxY0JNdUNOWDJSS2lIUHJOaUEzdTJH?=
 =?utf-8?B?dzNobmhVSTdoaDVDRDVLUXg1OW1YRWduckwyRksrUzIyVDR0K1kyNkJqZ2pJ?=
 =?utf-8?B?aFBYNm9PTEh5MGFYUVdtdm1BSUdsWXdCWFEvRGxrak1lR2h0QzEzSDJOVXRI?=
 =?utf-8?B?S2NBdUxFd0ozTTRiN25JZlZvZkQwQ245QTMzRzlvdVdaR0VFWDVGNnNBcmlO?=
 =?utf-8?B?aHEyaFVQMTFxTGZqOUNOL0xBem9ETGhjMmU3bWplU1ZwajZ6VVVZdTZoUE8x?=
 =?utf-8?B?ZDRPR3RYVEsxV01qN0R0MmJ6U0tRYkxYTmxZZGI2ZHBLeXRoa1VFbkM2ZWhx?=
 =?utf-8?B?bXdVSnJKaVF3Uno1WjZadHJvQVg1MFJhZ0JPeEJMS1JYTzFFcm03eUdaSEMz?=
 =?utf-8?B?czhlMElIZFB4djhHNzZacjBOS3lETmNZV0ZkL1YwYkwrQmE4dXdKSkNhU0pi?=
 =?utf-8?B?K2tNb1VrekY4YjZlUW5wazNPelMzcTltMnpYaWpwR3RuMnlWMG1NQ3dtQXVt?=
 =?utf-8?B?UEpvSjErbmxRdXRnSmpyUGtraXpvenYvL2R3U21nT3pjT05zd041K1B4QWIy?=
 =?utf-8?B?SDFNL2hvbUl2S3RSVFhseVpJaGlvaXFXaDBTNE5KcVNqbkxtVmJ1U1VidzI1?=
 =?utf-8?B?Rkh6b1JPbXhrSkV1NnNpVmcxUzBsSzBWSmZqM2tTRXUvbkwvd1dWYUdzSUM5?=
 =?utf-8?B?TENJSWpWdk9NajFuMW9IQnRHTXRaeWJLQitGWXVnUG5aeW5pR2VSeko4d1Iy?=
 =?utf-8?B?dXFJTHJybnp5aEY0cER6dElOaEhtNzZ4MWpNY0E1NjEyR28vd3BPbkJ2dlFC?=
 =?utf-8?B?ZEVwa0dCR3NmdW85clVETEgrZDY0N2grM0lOMFhlT2dvZ2VpdHp6d2lKblkw?=
 =?utf-8?Q?V7nS0BYUpSMNNVP/ZHIJg1wRM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41398d25-ad74-47b6-a272-08dbf51d460d
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 23:03:48.7338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C/ITicWctEUDNLnWT7M8wgF6cVibsqAxuy+lc9GkllMoAkSE7AV1xkZLuQrY6VlM
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
> Resctrl assumes that control and monitor operations on a resource are
> performed at the same scope.
>
> Prepare for systems that use different scope (specifically Intel needs
> to split the RDT_RESOURCE_L3 resource to use L3 scope for cache control
> and NODE scope for cache occupancy and memory bandwidth monitoring).
>
> Create separate domain lists for control and monitor operations.
>
> Note that errors during initialization of either control or monitor
> functions on a domain would previously result in that domain being
> excluded from both control and monitor operations. Now the domains are
> allocated independently it is no longer required to disable both control
> and monitor operations if either fail.
>
> Signed-off-by: Tony Luck<tony.luck@intel.com>
> Tested-by: Shaopeng Tan<tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan<tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Reinette Chatre<reinette.chatre@intel.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
> ---
>   include/linux/resctrl.h                   |  25 ++-
>   arch/x86/kernel/cpu/resctrl/internal.h    |   6 +-
>   arch/x86/kernel/cpu/resctrl/core.c        | 211 ++++++++++++++++------
>   arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  12 +-
>   arch/x86/kernel/cpu/resctrl/monitor.c     |   4 +-
>   arch/x86/kernel/cpu/resctrl/pseudo_lock.c |   4 +-
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  55 +++---
>   7 files changed, 220 insertions(+), 97 deletions(-)
>
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index c4067150a6b7..35e700edc6e6 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -52,15 +52,22 @@ struct resctrl_staged_config {
>   	bool			have_new_ctrl;
>   };
>   
> +enum resctrl_domain_type {
> +	RESCTRL_CTRL_DOMAIN,
> +	RESCTRL_MON_DOMAIN,
> +};
> +
>   /**
>    * struct rdt_domain_hdr - common header for different domain types
>    * @list:		all instances of this resource
>    * @id:			unique id for this instance
> + * @type:		type of this instance
>    * @cpu_mask:		which CPUs share this resource
>    */
>   struct rdt_domain_hdr {
>   	struct list_head		list;
>   	int				id;
> +	enum resctrl_domain_type	type;
>   	struct cpumask			cpu_mask;
>   };
>   
> @@ -163,10 +170,12 @@ enum resctrl_scope {
>    * @alloc_capable:	Is allocation available on this machine
>    * @mon_capable:	Is monitor feature available on this machine
>    * @num_rmid:		Number of RMIDs available
> - * @scope:		Scope of this resource
> + * @ctrl_scope:		Scope of this resource for control functions
> + * @mon_scope:		Scope of this resource for monitor functions
>    * @cache:		Cache allocation related data
>    * @membw:		If the component has bandwidth controls, their properties.
> - * @domains:		All domains for this resource
> + * @ctrl_domains:	Control domains for this resource
> + * @mon_domains:	Monitor domains for this resource
>    * @name:		Name to use in "schemata" file.
>    * @data_width:		Character width of data when displaying
>    * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
> @@ -181,10 +190,12 @@ struct rdt_resource {
>   	bool			alloc_capable;
>   	bool			mon_capable;
>   	int			num_rmid;
> -	enum resctrl_scope	scope;
> +	enum resctrl_scope	ctrl_scope;
> +	enum resctrl_scope	mon_scope;
>   	struct resctrl_cache	cache;
>   	struct resctrl_membw	membw;
> -	struct list_head	domains;
> +	struct list_head	ctrl_domains;
> +	struct list_head	mon_domains;
>   	char			*name;
>   	int			data_width;
>   	u32			default_ctrl;
> @@ -230,8 +241,10 @@ int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_domain *d,
>   
>   u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
>   			    u32 closid, enum resctrl_conf_type type);
> -int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d);
> -void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
> +int resctrl_online_ctrl_domain(struct rdt_resource *r, struct rdt_domain *d);
> +int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_domain *d);
> +void resctrl_offline_ctrl_domain(struct rdt_resource *r, struct rdt_domain *d);
> +void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_domain *d);
>   
>   /**
>    * resctrl_arch_rmid_read() - Read the eventid counter corresponding to rmid
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index a4f1aa15f0a2..24bf9d7989a9 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -520,8 +520,8 @@ void rdtgroup_kn_unlock(struct kernfs_node *kn);
>   int rdtgroup_kn_mode_restrict(struct rdtgroup *r, const char *name);
>   int rdtgroup_kn_mode_restore(struct rdtgroup *r, const char *name,
>   			     umode_t mask);
> -struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
> -				   struct list_head **pos);
> +struct rdt_domain_hdr *rdt_find_domain(struct list_head *h, int id,
> +				       struct list_head **pos);
>   ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
>   				char *buf, size_t nbytes, loff_t off);
>   int rdtgroup_schemata_show(struct kernfs_open_file *of,
> @@ -540,7 +540,7 @@ int rdt_pseudo_lock_init(void);
>   void rdt_pseudo_lock_release(void);
>   int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp);
>   void rdtgroup_pseudo_lock_remove(struct rdtgroup *rdtgrp);
> -struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r);
> +struct rdt_domain *get_ctrl_domain_from_cpu(int cpu, struct rdt_resource *r);
>   int closids_supported(void);
>   void closid_free(int closid);
>   int alloc_rmid(void);
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 62a989fd950d..1fd85533b4ca 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -57,7 +57,8 @@ static void
>   mba_wrmsr_amd(struct rdt_domain *d, struct msr_param *m,
>   	      struct rdt_resource *r);
>   
> -#define domain_init(id) LIST_HEAD_INIT(rdt_resources_all[id].r_resctrl.domains)
> +#define ctrl_domain_init(id) LIST_HEAD_INIT(rdt_resources_all[id].r_resctrl.ctrl_domains)
> +#define mon_domain_init(id) LIST_HEAD_INIT(rdt_resources_all[id].r_resctrl.mon_domains)
>   
>   struct rdt_hw_resource rdt_resources_all[] = {
>   	[RDT_RESOURCE_L3] =
> @@ -65,8 +66,10 @@ struct rdt_hw_resource rdt_resources_all[] = {
>   		.r_resctrl = {
>   			.rid			= RDT_RESOURCE_L3,
>   			.name			= "L3",
> -			.scope			= RESCTRL_L3_CACHE,
> -			.domains		= domain_init(RDT_RESOURCE_L3),
> +			.ctrl_scope		= RESCTRL_L3_CACHE,
> +			.mon_scope		= RESCTRL_L3_CACHE,
> +			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_L3),
> +			.mon_domains		= mon_domain_init(RDT_RESOURCE_L3),
>   			.parse_ctrlval		= parse_cbm,
>   			.format_str		= "%d=%0*x", .fflags = RFTYPE_RES_CACHE, @@ -79,8 +82,8 @@ struct 
> rdt_hw_resource rdt_resources_all[] = { .r_resctrl = { .rid = 
> RDT_RESOURCE_L2, .name = "L2",
> -			.scope			= RESCTRL_L2_CACHE,
> -			.domains		= domain_init(RDT_RESOURCE_L2),
> +			.ctrl_scope		= RESCTRL_L2_CACHE,
> +			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_L2),
>   			.parse_ctrlval		= parse_cbm,
>   			.format_str		= "%d=%0*x", .fflags = RFTYPE_RES_CACHE, @@ -93,8 +96,8 @@ struct 
> rdt_hw_resource rdt_resources_all[] = { .r_resctrl = { .rid = 
> RDT_RESOURCE_MBA, .name = "MB",
> -			.scope			= RESCTRL_L3_CACHE,
> -			.domains		= domain_init(RDT_RESOURCE_MBA),
> +			.ctrl_scope		= RESCTRL_L3_CACHE,
> +			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_MBA),
>   			.parse_ctrlval		= parse_bw,
>   			.format_str		= "%d=%*u",
>   			.fflags			= RFTYPE_RES_MB,
> @@ -105,8 +108,8 @@ struct rdt_hw_resource rdt_resources_all[] = {
>   		.r_resctrl = {
>   			.rid			= RDT_RESOURCE_SMBA,
>   			.name			= "SMBA",
> -			.scope			= RESCTRL_L3_CACHE,
> -			.domains		= domain_init(RDT_RESOURCE_SMBA),
> +			.ctrl_scope		= RESCTRL_L3_CACHE,
> +			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_SMBA),
>   			.parse_ctrlval		= parse_bw,
>   			.format_str		= "%d=%*u",
>   			.fflags			= RFTYPE_RES_MB,
> @@ -352,11 +355,11 @@ cat_wrmsr(struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r)
>   		wrmsrl(hw_res->msr_base + i, hw_dom->ctrl_val[i]);
>   }
>   
> -struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r)
> +struct rdt_domain *get_ctrl_domain_from_cpu(int cpu, struct rdt_resource *r)
>   {
>   	struct rdt_domain *d;
>   
> -	list_for_each_entry(d, &r->domains, hdr.list) {
> +	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
>   		/* Find the domain that contains this CPU */
>   		if (cpumask_test_cpu(cpu, &d->hdr.cpu_mask))
>   			return d;
> @@ -378,7 +381,7 @@ void rdt_ctrl_update(void *arg)
>   	int cpu = smp_processor_id();
>   	struct rdt_domain *d;
>   
> -	d = get_domain_from_cpu(cpu, r);
> +	d = get_ctrl_domain_from_cpu(cpu, r);
>   	if (d) {
>   		hw_res->msr_update(d, m, r);
>   		return;
> @@ -388,26 +391,26 @@ void rdt_ctrl_update(void *arg)
>   }
>   
>   /*
> - * rdt_find_domain - Find a domain in a resource that matches input resource id
> + * rdt_find_domain - Search for a domain id in a resource domain list.
>    *
> - * Search resource r's domain list to find the resource id. If the resource
> - * id is found in a domain, return the domain. Otherwise, if requested by
> - * caller, return the first domain whose id is bigger than the input id.
> - * The domain list is sorted by id in ascending order.
> + * Search the domain list to find the domain id. If the domain id is
> + * found, return the domain. NULL otherwise.  If the domain id is not
> + * found (and NULL returned) then the first domain with id bigger than
> + * the input id can be returned to the caller via @pos.
>    */
> -struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
> -				   struct list_head **pos)
> +struct rdt_domain_hdr *rdt_find_domain(struct list_head *h, int id,
> +				       struct list_head **pos)
>   {
> -	struct rdt_domain *d;
> +	struct rdt_domain_hdr *d;
>   	struct list_head *l;
>   
> -	list_for_each(l, &r->domains) {
> -		d = list_entry(l, struct rdt_domain, hdr.list);
> +	list_for_each(l, h) {
> +		d = list_entry(l, struct rdt_domain_hdr, list);
>   		/* When id is found, return its domain. */
> -		if (id == d->hdr.id)
> +		if (id == d->id)
>   			return d;
>   		/* Stop searching when finding id's position in sorted list. */
> -		if (id < d->hdr.id)
> +		if (id < d->id)
>   			break;
>   	}
>   
> @@ -501,35 +504,28 @@ static int get_domain_id_from_scope(int cpu, enum resctrl_scope scope)
>   	return -EINVAL;
>   }
>   
> -/*
> - * domain_add_cpu - Add a cpu to a resource's domain list.
> - *
> - * If an existing domain in the resource r's domain list matches the cpu's
> - * resource id, add the cpu in the domain.
> - *
> - * Otherwise, a new domain is allocated and inserted into the right position
> - * in the domain list sorted by id in ascending order.
> - *
> - * The order in the domain list is visible to users when we print entries
> - * in the schemata file and schemata input is validated to have the same order
> - * as this list.
> - */
> -static void domain_add_cpu(int cpu, struct rdt_resource *r)
> +static void domain_add_cpu_ctrl(int cpu, struct rdt_resource *r)
>   {
> -	int id = get_domain_id_from_scope(cpu, r->scope);
> +	int id = get_domain_id_from_scope(cpu, r->ctrl_scope);
>   	struct list_head *add_pos = NULL;
>   	struct rdt_hw_domain *hw_dom;
> +	struct rdt_domain_hdr *hdr;
>   	struct rdt_domain *d;
>   	int err;
>   
>   	if (id < 0) {
> -		pr_warn_once("Can't find domain id for CPU:%d scope:%d for resource %s\n",
> -			     cpu, r->scope, r->name);
> +		pr_warn_once("Can't find control domain id for CPU:%d scope:%d for resource %s\n",
> +			     cpu, r->ctrl_scope, r->name);
>   		return;
>   	}
>   
> -	d = rdt_find_domain(r, id, &add_pos);
> -	if (d) {
> +	hdr = rdt_find_domain(&r->ctrl_domains, id, &add_pos);
> +	if (hdr) {
> +		if (WARN_ON_ONCE(hdr->type != RESCTRL_CTRL_DOMAIN))
> +			return;
> +
> +		d = container_of(hdr, struct rdt_domain, hdr);
> +
>   		cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
>   		if (r->cache.arch_has_per_cpu_cfg)
>   			rdt_domain_reconfigure_cdp(r);
> @@ -542,51 +538,114 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
>   
>   	d = &hw_dom->d_resctrl;
>   	d->hdr.id = id;
> +	d->hdr.type = RESCTRL_CTRL_DOMAIN;
>   	cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
>   
>   	rdt_domain_reconfigure_cdp(r);
>   
> -	if (r->alloc_capable && domain_setup_ctrlval(r, d)) {
> +	if (domain_setup_ctrlval(r, d)) {
>   		domain_free(hw_dom);
>   		return;
>   	}
>   
> -	if (r->mon_capable && arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
> +	list_add_tail(&d->hdr.list, add_pos);
> +
> +	err = resctrl_online_ctrl_domain(r, d);
> +	if (err) {
> +		list_del(&d->hdr.list);
> +		domain_free(hw_dom);
> +	}
> +}
> +
> +static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
> +{
> +	int id = get_domain_id_from_scope(cpu, r->mon_scope);
> +	struct list_head *add_pos = NULL;
> +	struct rdt_hw_domain *hw_dom;
> +	struct rdt_domain_hdr *hdr;
> +	struct rdt_domain *d;
> +	int err;
> +
> +	if (id < 0) {
> +		pr_warn_once("Can't find monitor domain id for CPU:%d scope:%d for resource %s\n",
> +			     cpu, r->mon_scope, r->name);
> +		return;
> +	}
> +
> +	hdr = rdt_find_domain(&r->mon_domains, id, &add_pos);
> +	if (hdr) {
> +		if (WARN_ON_ONCE(hdr->type != RESCTRL_MON_DOMAIN))
> +			return;
> +
> +		d = container_of(hdr, struct rdt_domain, hdr);
> +
> +		cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
> +		return;
> +	}
> +
> +	hw_dom = kzalloc_node(sizeof(*hw_dom), GFP_KERNEL, cpu_to_node(cpu));
> +	if (!hw_dom)
> +		return;
> +
> +	d = &hw_dom->d_resctrl;
> +	d->hdr.id = id;
> +	d->hdr.type = RESCTRL_MON_DOMAIN;
> +	cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
> +
> +	if (arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
>   		domain_free(hw_dom);
>   		return;
>   	}
>   
>   	list_add_tail(&d->hdr.list, add_pos);
>   
> -	err = resctrl_online_domain(r, d);
> +	err = resctrl_online_mon_domain(r, d);
>   	if (err) {
>   		list_del(&d->hdr.list);
>   		domain_free(hw_dom);
>   	}
>   }
>   
> -static void domain_remove_cpu(int cpu, struct rdt_resource *r)
> +/*
> + * domain_add_cpu - Add a CPU to either/both resource's domain lists.
> + */
> +static void domain_add_cpu(int cpu, struct rdt_resource *r)
>   {
> -	int id = get_domain_id_from_scope(cpu, r->scope);
> +	if (r->alloc_capable)
> +		domain_add_cpu_ctrl(cpu, r);
> +	if (r->mon_capable)
> +		domain_add_cpu_mon(cpu, r);
> +}
> +
> +static void domain_remove_cpu_ctrl(int cpu, struct rdt_resource *r)
> +{
> +	int id = get_domain_id_from_scope(cpu, r->ctrl_scope);
>   	struct rdt_hw_domain *hw_dom;
> +	struct rdt_domain_hdr *hdr;
>   	struct rdt_domain *d;
>   
>   	if (id < 0) {
> -		pr_warn_once("Can't find domain id for CPU:%d scope:%d for resource %s\n",
> -			     cpu, r->scope, r->name);
> +		pr_warn_once("Can't find control domain id for CPU:%d scope:%d for resource %s\n",
> +			     cpu, r->ctrl_scope, r->name);
>   		return;
>   	}
>   
> -	d = rdt_find_domain(r, id, NULL);
> -	if (!d) {
> -		pr_warn("Couldn't find domain with id=%d for CPU %d\n", id, cpu);
> +	hdr = rdt_find_domain(&r->ctrl_domains, id, NULL);
> +	if (!hdr) {
> +		pr_warn("Can't find control domain for id=%d for CPU %d for resource %s\n",
> +			id, cpu, r->name);
>   		return;
>   	}
> +
> +	if (WARN_ON_ONCE(hdr->type != RESCTRL_CTRL_DOMAIN))
> +		return;
> +
> +	d = container_of(hdr, struct rdt_domain, hdr);
>   	hw_dom = resctrl_to_arch_dom(d);
>   
>   	cpumask_clear_cpu(cpu, &d->hdr.cpu_mask);
>   	if (cpumask_empty(&d->hdr.cpu_mask)) {
> -		resctrl_offline_domain(r, d);
> +		resctrl_offline_ctrl_domain(r, d);
>   		list_del(&d->hdr.list);
>   
>   		/*
> @@ -599,6 +658,42 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
>   
>   		return;
>   	}
> +}
> +
> +static void domain_remove_cpu_mon(int cpu, struct rdt_resource *r)
> +{
> +	int id = get_domain_id_from_scope(cpu, r->mon_scope);
> +	struct rdt_hw_domain *hw_dom;
> +	struct rdt_domain_hdr *hdr;
> +	struct rdt_domain *d;
> +
> +	if (id < 0) {
> +		pr_warn_once("Can't find monitor domain id for CPU:%d scope:%d for resource %s\n",
> +			     cpu, r->mon_scope, r->name);
> +		return;
> +	}
> +
> +	hdr = rdt_find_domain(&r->mon_domains, id, NULL);
> +	if (!hdr) {
> +		pr_warn("Can't find monitor domain for id=%d for CPU %d for resource %s\n",
> +			id, cpu, r->name);
> +		return;
> +	}
> +
> +	if (WARN_ON_ONCE(hdr->type != RESCTRL_MON_DOMAIN))
> +		return;
> +
> +	d = container_of(hdr, struct rdt_domain, hdr);
> +	hw_dom = resctrl_to_arch_dom(d);
> +
> +	cpumask_clear_cpu(cpu, &d->hdr.cpu_mask);
> +	if (cpumask_empty(&d->hdr.cpu_mask)) {
> +		resctrl_offline_mon_domain(r, d);
> +		list_del(&d->hdr.list);
> +		domain_free(hw_dom);
> +
> +		return;
> +	}
>   
>   	if (r == &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl) {
>   		if (is_mbm_enabled() && cpu == d->mbm_work_cpu) {
> @@ -613,6 +708,14 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
>   	}
>   }
>   
> +static void domain_remove_cpu(int cpu, struct rdt_resource *r)
> +{
> +	if (r->alloc_capable)
> +		domain_remove_cpu_ctrl(cpu, r);
> +	if (r->mon_capable)
> +		domain_remove_cpu_mon(cpu, r);
> +}
> +
>   static void clear_closid_rmid(int cpu)
>   {
>   	struct resctrl_pqr_state *state = this_cpu_ptr(&pqr_state);
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index 23f8258d36a8..0b4136c42762 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -226,7 +226,7 @@ static int parse_line(char *line, struct resctrl_schema *s,
>   		return -EINVAL;
>   	}
>   	dom = strim(dom);
> -	list_for_each_entry(d, &r->domains, hdr.list) {
> +	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
>   		if (d->hdr.id == dom_id) {
>   			data.buf = dom;
>   			data.rdtgrp = rdtgrp;
> @@ -318,7 +318,7 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
>   		return -ENOMEM;
>   
>   	msr_param.res = NULL;
> -	list_for_each_entry(d, &r->domains, hdr.list) {
> +	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
>   		hw_dom = resctrl_to_arch_dom(d);
>   		for (t = 0; t < CDP_NUM_TYPES; t++) {
>   			cfg = &hw_dom->d_resctrl.staged_config[t];
> @@ -466,7 +466,7 @@ static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int clo
>   	u32 ctrl_val;
>   
>   	seq_printf(s, "%*s:", max_name_width, schema->name);
> -	list_for_each_entry(dom, &r->domains, hdr.list) {
> +	list_for_each_entry(dom, &r->ctrl_domains, hdr.list) {
>   		if (sep)
>   			seq_puts(s, ";");
>   
> @@ -542,6 +542,7 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>   int rdtgroup_mondata_show(struct seq_file *m, void *arg)
>   {
>   	struct kernfs_open_file *of = m->private;
> +	struct rdt_domain_hdr *hdr;
>   	u32 resid, evtid, domid;
>   	struct rdtgroup *rdtgrp;
>   	struct rdt_resource *r;
> @@ -562,11 +563,12 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
>   	evtid = md.u.evtid;
>   
>   	r = &rdt_resources_all[resid].r_resctrl;
> -	d = rdt_find_domain(r, domid, NULL);
> -	if (!d) {
> +	hdr = rdt_find_domain(&r->mon_domains, domid, NULL);
> +	if (!hdr || WARN_ON_ONCE(hdr->type != RESCTRL_MON_DOMAIN)) {
>   		ret = -ENOENT;
>   		goto out;
>   	}
> +	d = container_of(hdr, struct rdt_domain, hdr);
>   
>   	mon_event_read(&rr, r, d, rdtgrp, evtid, false);
>   
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index dd0ea1bc0092..ec5ad926c5dc 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -340,7 +340,7 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>   
>   	entry->busy = 0;
>   	cpu = get_cpu();
> -	list_for_each_entry(d, &r->domains, hdr.list) {
> +	list_for_each_entry(d, &r->mon_domains, hdr.list) {
>   		if (cpumask_test_cpu(cpu, &d->hdr.cpu_mask)) {
>   			err = resctrl_arch_rmid_read(r, d, entry->rmid,
>   						     QOS_L3_OCCUP_EVENT_ID,
> @@ -535,7 +535,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
>   	rmid = rgrp->mon.rmid;
>   	pmbm_data = &dom_mbm->mbm_local[rmid];
>   
> -	dom_mba = get_domain_from_cpu(smp_processor_id(), r_mba);
> +	dom_mba = get_ctrl_domain_from_cpu(smp_processor_id(), r_mba);
>   	if (!dom_mba) {
>   		pr_warn_once("Failure to get domain for MBA update\n");
>   		return;
> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> index fcbd99e2eb66..ed6d59af1cef 100644
> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> @@ -292,7 +292,7 @@ static void pseudo_lock_region_clear(struct pseudo_lock_region *plr)
>    */
>   static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
>   {
> -	enum resctrl_scope scope = plr->s->res->scope;
> +	enum resctrl_scope scope = plr->s->res->ctrl_scope;
>   	struct cpu_cacheinfo *ci;
>   	int ret;
>   	int i;
> @@ -856,7 +856,7 @@ bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_domain *d)
>   	 * associated with them.
>   	 */
>   	for_each_alloc_capable_rdt_resource(r) {
> -		list_for_each_entry(d_i, &r->domains, hdr.list) {
> +		list_for_each_entry(d_i, &r->ctrl_domains, hdr.list) {
>   			if (d_i->plr)
>   				cpumask_or(cpu_with_psl, cpu_with_psl,
>   					   &d_i->hdr.cpu_mask);
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 04d32602ac33..760013ed1bff 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -91,7 +91,7 @@ void rdt_staged_configs_clear(void)
>   	lockdep_assert_held(&rdtgroup_mutex);
>   
>   	for_each_alloc_capable_rdt_resource(r) {
> -		list_for_each_entry(dom, &r->domains, hdr.list)
> +		list_for_each_entry(dom, &r->ctrl_domains, hdr.list)
>   			memset(dom->staged_config, 0, sizeof(dom->staged_config));
>   	}
>   }
> @@ -984,7 +984,7 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
>   
>   	mutex_lock(&rdtgroup_mutex);
>   	hw_shareable = r->cache.shareable_bits;
> -	list_for_each_entry(dom, &r->domains, hdr.list) {
> +	list_for_each_entry(dom, &r->ctrl_domains, hdr.list) {
>   		if (sep)
>   			seq_putc(seq, ';');
>   		sw_shareable = 0;
> @@ -1302,7 +1302,7 @@ static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
>   		if (r->rid == RDT_RESOURCE_MBA || r->rid == RDT_RESOURCE_SMBA)
>   			continue;
>   		has_cache = true;
> -		list_for_each_entry(d, &r->domains, hdr.list) {
> +		list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
>   			ctrl = resctrl_arch_get_config(r, d, closid,
>   						       s->conf_type);
>   			if (rdtgroup_cbm_overlaps(s, d, ctrl, closid, false)) {
> @@ -1413,13 +1413,13 @@ unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
>   	unsigned int size = 0;
>   	int num_b, i;
>   
> -	if (WARN_ON_ONCE(r->scope != RESCTRL_L2_CACHE && r->scope != RESCTRL_L3_CACHE))
> +	if (WARN_ON_ONCE(r->ctrl_scope != RESCTRL_L2_CACHE && r->ctrl_scope != RESCTRL_L3_CACHE))
>   		return size;
>   
>   	num_b = bitmap_weight(&cbm, r->cache.cbm_len);
>   	ci = get_cpu_cacheinfo(cpumask_any(&d->hdr.cpu_mask));
>   	for (i = 0; i < ci->num_leaves; i++) {
> -		if (ci->info_list[i].level == r->scope) {
> +		if (ci->info_list[i].level == r->ctrl_scope) {
>   			size = ci->info_list[i].size / r->cache.cbm_len * num_b;
>   			break;
>   		}
> @@ -1477,7 +1477,7 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
>   		type = schema->conf_type;
>   		sep = false;
>   		seq_printf(s, "%*s:", max_name_width, schema->name);
> -		list_for_each_entry(d, &r->domains, hdr.list) {
> +		list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
>   			if (sep)
>   				seq_putc(s, ';');
>   			if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
> @@ -1566,7 +1566,7 @@ static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid
>   
>   	mutex_lock(&rdtgroup_mutex);
>   
> -	list_for_each_entry(dom, &r->domains, hdr.list) {
> +	list_for_each_entry(dom, &r->mon_domains, hdr.list) {
>   		if (sep)
>   			seq_puts(s, ";");
>   
> @@ -1689,7 +1689,7 @@ static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
>   		return -EINVAL;
>   	}
>   
> -	list_for_each_entry(d, &r->domains, hdr.list) {
> +	list_for_each_entry(d, &r->mon_domains, hdr.list) {
>   		if (d->hdr.id == dom_id) {
>   			ret = mbm_config_write_domain(r, d, evtid, val);
>   			if (ret)
> @@ -2232,7 +2232,7 @@ static int set_cache_qos_cfg(int level, bool enable)
>   		return -ENOMEM;
>   
>   	r_l = &rdt_resources_all[level].r_resctrl;
> -	list_for_each_entry(d, &r_l->domains, hdr.list) {
> +	list_for_each_entry(d, &r_l->ctrl_domains, hdr.list) {
>   		if (r_l->cache.arch_has_per_cpu_cfg)
>   			/* Pick all the CPUs in the domain instance */
>   			for_each_cpu(cpu, &d->hdr.cpu_mask)
> @@ -2317,7 +2317,7 @@ static int set_mba_sc(bool mba_sc)
>   
>   	r->membw.mba_sc = mba_sc;
>   
> -	list_for_each_entry(d, &r->domains, hdr.list) {
> +	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
>   		for (i = 0; i < num_closid; i++)
>   			d->mbps_val[i] = MBA_MAX_MBPS;
>   	}
> @@ -2653,7 +2653,7 @@ static int rdt_get_tree(struct fs_context *fc)
>   
>   	if (is_mbm_enabled()) {
>   		r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> -		list_for_each_entry(dom, &r->domains, hdr.list)
> +		list_for_each_entry(dom, &r->mon_domains, hdr.list)
>   			mbm_setup_overflow_handler(dom, MBM_OVERFLOW_INTERVAL);
>   	}
>   
> @@ -2777,10 +2777,10 @@ static int reset_all_ctrls(struct rdt_resource *r)
>   
>   	/*
>   	 * Disable resource control for this resource by setting all
> -	 * CBMs in all domains to the maximum mask value. Pick one CPU
> +	 * CBMs in all ctrl_domains to the maximum mask value. Pick one CPU
>   	 * from each domain to update the MSRs below.
>   	 */
> -	list_for_each_entry(d, &r->domains, hdr.list) {
> +	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
>   		hw_dom = resctrl_to_arch_dom(d);
>   		cpumask_set_cpu(cpumask_any(&d->hdr.cpu_mask), cpu_mask);
>   
> @@ -3050,7 +3050,7 @@ static int mkdir_mondata_subdir_alldom(struct kernfs_node *parent_kn,
>   	struct rdt_domain *dom;
>   	int ret;
>   
> -	list_for_each_entry(dom, &r->domains, hdr.list) {
> +	list_for_each_entry(dom, &r->mon_domains, hdr.list) {
>   		ret = mkdir_mondata_subdir(parent_kn, dom, r, prgrp);
>   		if (ret)
>   			return ret;
> @@ -3232,7 +3232,7 @@ static int rdtgroup_init_cat(struct resctrl_schema *s, u32 closid)
>   	struct rdt_domain *d;
>   	int ret;
>   
> -	list_for_each_entry(d, &s->res->domains, hdr.list) {
> +	list_for_each_entry(d, &s->res->ctrl_domains, hdr.list) {
>   		ret = __init_one_rdt_domain(d, s, closid);
>   		if (ret < 0)
>   			return ret;
> @@ -3247,7 +3247,7 @@ static void rdtgroup_init_mba(struct rdt_resource *r, u32 closid)
>   	struct resctrl_staged_config *cfg;
>   	struct rdt_domain *d;
>   
> -	list_for_each_entry(d, &r->domains, hdr.list) {
> +	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
>   		if (is_mba_sc(r)) {
>   			d->mbps_val[closid] = MBA_MAX_MBPS;
>   			continue;
> @@ -3849,15 +3849,17 @@ static void domain_destroy_mon_state(struct rdt_domain *d)
>   	kfree(d->mbm_local);
>   }
>   
> -void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
> +void resctrl_offline_ctrl_domain(struct rdt_resource *r, struct rdt_domain *d)
>   {
>   	lockdep_assert_held(&rdtgroup_mutex);
>   
>   	if (supports_mba_mbps() && r->rid == RDT_RESOURCE_MBA)
>   		mba_sc_domain_destroy(r, d);
> +}
>   
> -	if (!r->mon_capable)
> -		return;
> +void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_domain *d)
> +{
> +	lockdep_assert_held(&rdtgroup_mutex);
>   
>   	/*
>   	 * If resctrl is mounted, remove all the
> @@ -3914,18 +3916,21 @@ static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
>   	return 0;
>   }
>   
> -int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
> +int resctrl_online_ctrl_domain(struct rdt_resource *r, struct rdt_domain *d)
>   {
> -	int err;
> -
>   	lockdep_assert_held(&rdtgroup_mutex);
>   
>   	if (supports_mba_mbps() && r->rid == RDT_RESOURCE_MBA)
> -		/* RDT_RESOURCE_MBA is never mon_capable */
>   		return mba_sc_domain_allocate(r, d);
>   
> -	if (!r->mon_capable)
> -		return 0;
> +	return 0;
> +}
> +
> +int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_domain *d)
> +{
> +	int err;
> +
> +	lockdep_assert_held(&rdtgroup_mutex);
>   
>   	err = domain_setup_mon_state(r, d);
>   	if (err)
