Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B277803A21
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344659AbjLDQY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjLDQY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:24:57 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2061.outbound.protection.outlook.com [40.107.100.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E442B0;
        Mon,  4 Dec 2023 08:25:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZhM+pWtsUTMe/9zLDt3RQuMWpSlkWdLqs89Pe8EnrgCQRXf0Rj0Xv1TR/lkNuXudYYG9XMVjaRJRwKn8cnZ7RArD9yZah59tgRI3urjOQK7BUowVh3tX6ednrDHlogRgTDKfMdsXct2DBM+1VO0PHqiaxSo6hTvzm7BFhziaJd4r5WVy09BWX4bFdlvmEoZ83WOxlVlyEOQMPBGnDi40IkcBdQ6zl0mDogAXCFUPpteNilw0siR/K4pWAWI9oaF3OJY6eBlESNKaCHdzzRpuktKSU3TfAYFrYlGNMc/N526FAKWrUmiu84FI4P5Zy0SmrqPzCYBxYzycOcYsndlbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZ5OgL0BFnOupkuhi2JFcTShGy8GISqaeVRB0cdQMGw=;
 b=M6KidFGD9pZdIB6l/AJyu42VWcD/ErJwJCZzHUCnZVTOzsk+KH9a4aWfovLEj21lT5NRSew68Phyo8oPmtuSwpU+flKYrX3VGmrnfIgJ1WWK0EuUddmfdZxMOutIAzuZExtz29viIaBOhHyvY841yPMT5zLMSszYnd5BREbEXqGabe8TlKg34jbZDSLUJQtVQjerYyxHpaPnWosFxR0jvidrMQt1blqbIAc4xi9k7eF39aM3S6P2cGBg9n+bkyq6uhv3nd3mL1G06kn5/Cgw9gF0SKhZqedDLem26cG/Ou3QuBMhf2zXAI4sWv7ak7FTVvV5Z01Ik8m/hhvwZEx9AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZ5OgL0BFnOupkuhi2JFcTShGy8GISqaeVRB0cdQMGw=;
 b=Kqi+Pbqu9J4kg5ItUIkJqF0zNDb5QawLIvXEVRBHXm3FMXlBR6H7FS4IWpo/dytQC0qCERDWFranfw2/iz4a1E/HmL3youxRXsDzmeLxZEAtBVRXApqM7sGNPKMxFSQm0rszTkAjSP2scMvulYta7V+c7QHOrivQH0c1z1vCGbs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS0PR12MB8020.namprd12.prod.outlook.com (2603:10b6:8:14f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 16:25:00 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%5]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 16:25:00 +0000
Message-ID: <fd8a44a1-9001-4e3e-a1a9-63e7f737e6e1@amd.com>
Date:   Mon, 4 Dec 2023 10:24:58 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5] x86/resctrl: Add event choices for mba_MBps
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
References: <20231128231439.81691-1-tony.luck@intel.com>
 <20231201214737.104444-1-tony.luck@intel.com>
Content-Language: en-US
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <20231201214737.104444-1-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0110.namprd02.prod.outlook.com
 (2603:10b6:5:1b4::12) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS0PR12MB8020:EE_
X-MS-Office365-Filtering-Correlation-Id: 39307bd8-45bb-4cc0-d93a-08dbf4e58ffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +04Mf/ryF/cAZZ6VHSacVa3niB7AT7Ictq3YJUON3zUIKh2sT8EizeyQtPtFX0yyJFfNac5oT+mF6lN4f3Nq95/m1btzJ6igfOZXlSbu8EqrX2Ko4BGeVj6TvSLU2YOCf6RkYz52UFadB3ZWttuyJ25dAiGFO5o+NPkKHzqzGh7X4FBy0RTFpiVnYpHej+G0kiuVTRgNfkJfhaMG0t57NO0iG3kFNwS+d7Qv8BpKlkh5xDGZwOY6VtHwW6jPbcM50ZDqOgp2kHEbXNi1L1sfiRizE9S4qY7HC/A+tWgkbmoI3P5ac4Ar1Fs62h7GAV9X2Ijj3ARyTr0ke2ksNVEdonq9r8O/dI20xFLVVx2CKzTbzWcaYEr/D6jCpC11DzfM3extSwvF21+w71+1VHCLPVTwXbNr3iuJrPa2SBMYjmLhQDSHQdpRDjG34Ui3gWEDhnZRkapj/mBJYz1+XXUnsNH2VMVbnd7UW51SZpMYPWIrBZkSJm2vYJ8KqYw+a2FRTI1Dwf8BCWMjh5pDIkR3shTUauzAj15rOIAMTD9CcrQlMXPM42Fsz6oB2voZ5na5jlhEa0X5XZZu2f1E9q/Wv9Am51bxr4dA43lRY4YFxQG/7ijV+dHruOc//Q9tzMbf4Zdx/68mrONbZ2ZvvIdrKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(136003)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(31686004)(2616005)(8676002)(4326008)(8936002)(6512007)(6506007)(53546011)(83380400001)(26005)(6486002)(478600001)(66476007)(66946007)(66556008)(54906003)(110136005)(316002)(2906002)(36756003)(41300700001)(38100700002)(86362001)(31696002)(7416002)(5660300002)(3450700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TyswdjFRb3JBeHA2Z1h2NWo1Wi8rcmNMdlJoT2hNUjJSai8wWTdlVXdNUFMw?=
 =?utf-8?B?VlhSc2IzR1ZpeXRyR2d1TlBjR0RJL2RsV2ZXaXFSalpQemxMSmc2OTJsanVW?=
 =?utf-8?B?cEpaZnpUcU9mVnBmNkhjS25mNEZWYXNaLy9ncktGVlFsZXBvQ0VkVmV2TGVN?=
 =?utf-8?B?M1hvOHUwL3RwVXgxN0k5QXgxZmR3ajZ4N1NTU1VjRlJnYWswY1ZNbmxHcUFX?=
 =?utf-8?B?QUxtUHhKSmhIQzVmemJscUdBS2JCMmtpN0hranFWWVZ6YXAwY2NTOURheGVC?=
 =?utf-8?B?b3V4SEJyQys5alh3UFBLSE9NVVRDdnNCNVdOODhSTDdxckJ2V0JEN24ycnJM?=
 =?utf-8?B?RDVtbTIrcTdiYXdWVkU1MFdRNmd3NUF5YUtNWEU1TXhPVnFYSkxwZy9lMTky?=
 =?utf-8?B?eU5JaFJucEN1T21uZXVBYzJ4a2xTNFRVRi83cnpTZUpNREJXRDkwa2lVU0NP?=
 =?utf-8?B?OTFqbHZhcU9EclgzUE1GbnNwakFCMGlXczNRZDNidlJ3SmxnTVU4YkN3dVh0?=
 =?utf-8?B?WTFGYkVTYWJNM1B3VGIveGNoYm9HNWE4cU9NVWVST2VSUExORmRFMERZWElr?=
 =?utf-8?B?ejZyL2NzZGM2eUZGS3R3VVR3WHM4bUhLMG5zMkRYM1ZxRThUM1U4YXZOL3A2?=
 =?utf-8?B?Y2J1a3hqMlZ4MTN4cWJXdGRWSlVoR0lmbXpTT29TaTdtU25vRE5pN0RzVm1H?=
 =?utf-8?B?cEdTK2NTSm91ZE8xdHFOMHEzZjVmeERRR2F3dEw4NDhDT3JOZUxtamZpd2J4?=
 =?utf-8?B?ZTNlbXkwVnpjOCtncVZuWFM2aHhZdXJDM1ZyLzdzQTc0YkN0OG9NRmxIQTFX?=
 =?utf-8?B?OFZvdGovMlZmZ3k0ZzdxN2hUcm9uemRNdWFGZC9EaktaMjk0MGl3NU1xT0dn?=
 =?utf-8?B?L1k0dC9jYUh2UjRmMEdTSWx0MUt1STN3bnNPbjJ0aXByQy85VEljbnlML3pG?=
 =?utf-8?B?d01WbHVnRDJhVTVZalQvUldrSXN0NXJhV2V1cWFQeDdZRlVxSklYQzllQlp1?=
 =?utf-8?B?UjFvdUtpSzBhNVo1bVVTRFNuNFJvdzB5ZXhrYlhWYklzekprT0l6RXBmc0ZZ?=
 =?utf-8?B?bllscy9FSjBEWURuWU9iZk9JWDVhR01SeXpWMHY1VzY1T0ZxdjRpVWE1R0pC?=
 =?utf-8?B?c1NWOHFzVHpWeUVlUm5MRzdMOWlMUm1DSEJhdmJ2WksyT04yY09zWTJWMDRN?=
 =?utf-8?B?aWp0T3A1cFVESkFxT1FNbG1LVTV0Rm9mNy8yTEtmZjlOalJ3eVEycFRhWDJJ?=
 =?utf-8?B?WW15K3lnQVJIVmZVZThhVGs5ZCtQUldScVYvQWV2ZzJnK0R6V0QzWnhWNGJx?=
 =?utf-8?B?NkxOY01aQ0Vab3R6Znppa2tnaWU3TlJwVDB5UGFCTlFuVmlKOHFwcVM2SEQv?=
 =?utf-8?B?Q1QrbFdiQ1RTNHdQZU1EQzF4bERMdCtOYmd3cVo1cm9rRTdZRzNYWHh3L3hp?=
 =?utf-8?B?aEpxWHZrTlU2cm55SEdYcEpma1NIWmVvSTlGZjZUcUR0THVBdTJwU3ZrOWJX?=
 =?utf-8?B?U2pHeE1zanBYdlB4bnoxVUxPTUliT0wwMGZYSSsrenBqYzZOZzVaenR4WVB5?=
 =?utf-8?B?eENZN3VqMjJYZERGeVRDVDRYVlBOMVZwYjkzcWtwN3lxaXdhSjFjZUwvYVBx?=
 =?utf-8?B?Vk5FZzJyN0xiRk1Vbi85am9MRDlHYlZBbWEvcWUxdklxVW4rRjQvT0hkYUZx?=
 =?utf-8?B?Sk90eDlrWlFQbmRqa3Z4VDZyYVg5N3VuTEJkRm8rOWRPZ0R1SlVzUGpwNzdK?=
 =?utf-8?B?UFFmVVQ1cktrbTdvMEU2TjRSOElYcDZtb0FLa0tpcUk3Z0xQNzQ4bGo0VnBw?=
 =?utf-8?B?TlFYdGlyNlF4U2sxOStQQVJEMnVKL3dMOXJmK01KMTY2ancyK2pUaVR0dGJY?=
 =?utf-8?B?c0taL1AvWjRwWHB1R0dpclFoOWF1LzV2RUhIRHhoV0RUSmsrSlBzV2s3djZI?=
 =?utf-8?B?clZZUU55RzY0U0FRLy8wK2lpajhGS1NSL25zRXorVFZjU254V1Q2eHRMcVUx?=
 =?utf-8?B?U1hEZUZITkhyeit2TVdScUpBamJWbVhaUTEwZkNBTkd0QkRqY0JrN0dDSGRW?=
 =?utf-8?B?UWFra0YzOURIbDBvMytxbDZnVkdSbEZvbjB0b0NGdUZTaHJVa2FvTXd1WDk0?=
 =?utf-8?Q?oRJ8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39307bd8-45bb-4cc0-d93a-08dbf4e58ffc
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 16:25:00.4786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3NrWVQkQh4KXBhKHzMOspkWCte1a0FePCAlTylEeOCvLDrNgxTGk0hP/6eR3LxZY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8020
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

You are intending to achieve two things at once here.
1. Adding new mount option
2. Changing behaviour for the current option.
I think you need to split this patch into two. Few comments below.

On 12/1/23 15:47, Tony Luck wrote:
> The MBA Software Controller(mba_sc) is a feedback loop that uses
> measurements of local memory bandwidth to adjust MBA throttling levels to
> keep workloads in a resctrl group within a target bandwidth set in the
> schemata file.
> 
> But on Intel systems the memory bandwidth monitoring events are
> independently enumerated. It is possible for a system to support
> total memory bandwidth monitoring, but not support local bandwidth
> monitoring. On such a system a user could not enable mba_sc mode.
> Users will see this highly unhelpful error message from mount:
> 
>  # mount -t resctrl -o mba_MBps resctrl /sys/fs/resctrl
>  mount: /sys/fs/resctrl: wrong fs type, bad option, bad superblock on
>  resctrl, missing codepage or helper program, or other error.
>  dmesg(1) may have more information after failed mount system call.
> 
> dmesg(1) does not provide any additional information.
> 
> Add a new mount option "mba_MBps_event=[local|total]" that allows
> a user to specify which monitoring event to use. Also modify the
> existing "mba_MBps" option to switch to total bandwidth monitoring
> if local monitoring is not available.

I am not sure why you need both these options. I feel you just need one of
these options.

Thanks
Babu

> 
> Update the once-per-second polling code to use the chosen event (local
> or total memory bandwidth).
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  Documentation/arch/x86/resctrl.rst     |  7 +++-
>  include/linux/resctrl.h                |  2 ++
>  arch/x86/kernel/cpu/resctrl/internal.h |  3 +-
>  arch/x86/kernel/cpu/resctrl/monitor.c  | 21 ++++++-----
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 48 ++++++++++++++++++++------
>  5 files changed, 58 insertions(+), 23 deletions(-)
> 
> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index a6279df64a9d..f06cb189911a 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -45,7 +45,12 @@ mount options are:
>  	Enable code/data prioritization in L2 cache allocations.
>  "mba_MBps":
>  	Enable the MBA Software Controller(mba_sc) to specify MBA
> -	bandwidth in MBps
> +	bandwidth in MBps. Defaults to using MBM local bandwidth,
> +	but will use total bandwidth on systems that do not support
> +	local bandwidth monitoring.
> +"mba_MBps_event=[local|total]":
> +	Enable the MBA Software Controller(mba_sc) with a specific
> +	MBM event as input to the feedback loop.
>  "debug":
>  	Make debug files accessible. Available debug files are annotated with
>  	"Available only with debug option".
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 66942d7fba7f..1feb3b2e64fa 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -129,6 +129,7 @@ enum membw_throttle_mode {
>   * @throttle_mode:	Bandwidth throttling mode when threads request
>   *			different memory bandwidths
>   * @mba_sc:		True if MBA software controller(mba_sc) is enabled
> + * @mba_mbps_event:	Event (local or total) for mba_sc
>   * @mb_map:		Mapping of memory B/W percentage to memory B/W delay
>   */
>  struct resctrl_membw {
> @@ -138,6 +139,7 @@ struct resctrl_membw {
>  	bool				arch_needs_linear;
>  	enum membw_throttle_mode	throttle_mode;
>  	bool				mba_sc;
> +	enum resctrl_event_id		mba_mbps_event;
>  	u32				*mb_map;
>  };
>  
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index a4f1aa15f0a2..8b9b8f664324 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -58,7 +58,8 @@ struct rdt_fs_context {
>  	struct kernfs_fs_context	kfc;
>  	bool				enable_cdpl2;
>  	bool				enable_cdpl3;
> -	bool				enable_mba_mbps;
> +	bool				enable_mba_mbps_local;
> +	bool				enable_mba_mbps_total;
>  	bool				enable_debug;
>  };
>  
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index f136ac046851..d9e590f1cbc3 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -431,9 +431,10 @@ static int __mon_event_count(u32 rmid, struct rmid_read *rr)
>   */
>  static void mbm_bw_count(u32 rmid, struct rmid_read *rr)
>  {
> -	struct mbm_state *m = &rr->d->mbm_local[rmid];
>  	u64 cur_bw, bytes, cur_bytes;
> +	struct mbm_state *m;
>  
> +	m = get_mbm_state(rr->d, rmid, rr->evtid);
>  	cur_bytes = rr->val;
>  	bytes = cur_bytes - m->prev_bw_bytes;
>  	m->prev_bw_bytes = cur_bytes;
> @@ -521,19 +522,21 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
>  	u32 closid, rmid, cur_msr_val, new_msr_val;
>  	struct mbm_state *pmbm_data, *cmbm_data;
>  	u32 cur_bw, delta_bw, user_bw;
> +	enum resctrl_event_id evt_id;
>  	struct rdt_resource *r_mba;
>  	struct rdt_domain *dom_mba;
>  	struct list_head *head;
>  	struct rdtgroup *entry;
>  
> -	if (!is_mbm_local_enabled())
> +	if (!is_mbm_enabled())
>  		return;
>  
>  	r_mba = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
> +	evt_id = r_mba->membw.mba_mbps_event;
>  
>  	closid = rgrp->closid;
>  	rmid = rgrp->mon.rmid;
> -	pmbm_data = &dom_mbm->mbm_local[rmid];
> +	pmbm_data = get_mbm_state(dom_mbm, rmid, evt_id);
>  
>  	dom_mba = get_domain_from_cpu(smp_processor_id(), r_mba);
>  	if (!dom_mba) {
> @@ -553,7 +556,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
>  	 */
>  	head = &rgrp->mon.crdtgrp_list;
>  	list_for_each_entry(entry, head, mon.crdtgrp_list) {
> -		cmbm_data = &dom_mbm->mbm_local[entry->mon.rmid];
> +		cmbm_data = get_mbm_state(dom_mbm, entry->mon.rmid, evt_id);
>  		cur_bw += cmbm_data->prev_bw;
>  		delta_bw += cmbm_data->delta_bw;
>  	}
> @@ -616,18 +619,14 @@ static void mbm_update(struct rdt_resource *r, struct rdt_domain *d, int rmid)
>  		rr.evtid = QOS_L3_MBM_TOTAL_EVENT_ID;
>  		rr.val = 0;
>  		__mon_event_count(rmid, &rr);
> +		if (is_mba_sc(NULL) && rr.evtid == r->membw.mba_mbps_event)
> +			mbm_bw_count(rmid, &rr);
>  	}
>  	if (is_mbm_local_enabled()) {
>  		rr.evtid = QOS_L3_MBM_LOCAL_EVENT_ID;
>  		rr.val = 0;
>  		__mon_event_count(rmid, &rr);
> -
> -		/*
> -		 * Call the MBA software controller only for the
> -		 * control groups and when user has enabled
> -		 * the software controller explicitly.
> -		 */
> -		if (is_mba_sc(NULL))
> +		if (is_mba_sc(NULL) && rr.evtid == r->membw.mba_mbps_event)
>  			mbm_bw_count(rmid, &rr);
>  	}
>  }
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 69a1de92384a..79141d33d5b4 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2294,7 +2294,7 @@ static bool supports_mba_mbps(void)
>  {
>  	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
>  
> -	return (is_mbm_local_enabled() &&
> +	return (is_mbm_enabled() &&
>  		r->alloc_capable && is_mba_linear());
>  }
>  
> @@ -2302,7 +2302,7 @@ static bool supports_mba_mbps(void)
>   * Enable or disable the MBA software controller
>   * which helps user specify bandwidth in MBps.
>   */
> -static int set_mba_sc(bool mba_sc)
> +static int set_mba_sc(bool mba_sc, enum resctrl_event_id mba_mbps_event)
>  {
>  	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
>  	u32 num_closid = resctrl_arch_get_num_closid(r);
> @@ -2313,6 +2313,7 @@ static int set_mba_sc(bool mba_sc)
>  		return -EINVAL;
>  
>  	r->membw.mba_sc = mba_sc;
> +	r->membw.mba_mbps_event = mba_mbps_event;
>  
>  	list_for_each_entry(d, &r->domains, list) {
>  		for (i = 0; i < num_closid; i++)
> @@ -2445,13 +2446,14 @@ static void rdt_disable_ctx(void)
>  {
>  	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
>  	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, false);
> -	set_mba_sc(false);
> +	set_mba_sc(false, QOS_L3_MBM_LOCAL_EVENT_ID);
>  
>  	resctrl_debug = false;
>  }
>  
>  static int rdt_enable_ctx(struct rdt_fs_context *ctx)
>  {
> +	enum resctrl_event_id mba_mbps_event;
>  	int ret = 0;
>  
>  	if (ctx->enable_cdpl2) {
> @@ -2466,8 +2468,12 @@ static int rdt_enable_ctx(struct rdt_fs_context *ctx)
>  			goto out_cdpl2;
>  	}
>  
> -	if (ctx->enable_mba_mbps) {
> -		ret = set_mba_sc(true);
> +	if (ctx->enable_mba_mbps_local || ctx->enable_mba_mbps_total) {
> +		if (ctx->enable_mba_mbps_total)
> +			mba_mbps_event = QOS_L3_MBM_TOTAL_EVENT_ID;
> +		else
> +			mba_mbps_event = QOS_L3_MBM_LOCAL_EVENT_ID;
> +		ret = set_mba_sc(true, mba_mbps_event);
>  		if (ret)
>  			goto out_cdpl3;
>  	}
> @@ -2683,15 +2689,17 @@ enum rdt_param {
>  	Opt_cdp,
>  	Opt_cdpl2,
>  	Opt_mba_mbps,
> +	Opt_mba_mbps_event,
>  	Opt_debug,
>  	nr__rdt_params
>  };
>  
>  static const struct fs_parameter_spec rdt_fs_parameters[] = {
> -	fsparam_flag("cdp",		Opt_cdp),
> -	fsparam_flag("cdpl2",		Opt_cdpl2),
> -	fsparam_flag("mba_MBps",	Opt_mba_mbps),
> -	fsparam_flag("debug",		Opt_debug),
> +	fsparam_flag("cdp",			Opt_cdp),
> +	fsparam_flag("cdpl2",			Opt_cdpl2),
> +	fsparam_flag("mba_MBps",		Opt_mba_mbps),
> +	fsparam_string("mba_MBps_event",	Opt_mba_mbps_event),
> +	fsparam_flag("debug",			Opt_debug),
>  	{}
>  };
>  
> @@ -2715,7 +2723,27 @@ static int rdt_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  	case Opt_mba_mbps:
>  		if (!supports_mba_mbps())
>  			return -EINVAL;
> -		ctx->enable_mba_mbps = true;
> +		if (is_mbm_local_enabled())
> +			ctx->enable_mba_mbps_local = true;
> +		else if (is_mbm_total_enabled())
> +			ctx->enable_mba_mbps_total = true;
> +		else
> +			return -EINVAL;
> +		return 0;
> +	case Opt_mba_mbps_event:
> +		if (!supports_mba_mbps())
> +			return -EINVAL;
> +		if (!strcmp("local", param->string)) {
> +			if (!is_mbm_local_enabled())
> +				return -EINVAL;
> +			ctx->enable_mba_mbps_local = true;
> +		} else if (!strcmp("total", param->string)) {
> +			if (!is_mbm_total_enabled())
> +				return -EINVAL;
> +			ctx->enable_mba_mbps_total = true;
> +		} else {
> +			return -EINVAL;
> +		}
>  		return 0;
>  	case Opt_debug:
>  		ctx->enable_debug = true;

-- 
Thanks
Babu Moger
