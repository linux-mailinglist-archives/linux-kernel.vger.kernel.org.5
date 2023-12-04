Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E497A804256
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 00:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbjLDXFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 18:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbjLDXFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 18:05:00 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A955BD3;
        Mon,  4 Dec 2023 15:04:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tvhgh7HzehBAkePqNhhSB8t4EhnmJj3WUDA3xIQjmrCsF7Y6Hm6HV7RmkZli4ugBhitH7D9YG9yEZlvADnZQ7m3jxNZahdaqqEVQCBdTgIdTX9mcacqzELT+Hi6AmL7ln5EjW6wVyBkJpCFv154rmirsEO8nqdElrRbIfJlO/jEo44KBK7yeisMOkuKkC1MTaMvvywz9m8FBYDkduOKCP4nAhtM06sI9p96t6397ovbOsBUJ4AC65cDOMtkdIrEvzmsDenUIqY1r4r6QM5ZMyHkzsYzW+fW0v8Lh8rtW7yN4Jufsa0I0TqZxBZ37orNbae+FV12nrEtTW2FDPE8ifg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vad1flW6mOMHPWDPsXFvcRYuUO1FZO6ziugCEN7E/6c=;
 b=eE8AooQzhkAxxsTkib/7svlyjRK7b6SErMlAApvJlxuU334nCkEpHAkKoQkmlgkOHf64VhIhQYwY9oUaBjJbkNb6B61A4Z7uglrw8fGLjC2d7AxK7eohtnDP51mfVbJNM5eEJOIeiT9hEHP/G4Nzu8aoG9sZDnHVp6qi3Jxmwa9As4tbHBuXk11ppVkGwPcrPB2Xc0ffbR+PGBJeTavaJ/bsx1t9I8oZtYSC48MiXA+0wnDex1W8t5+TvmXyiM+1QReiYP1Tw0Qcze6iXJUBt9RPpXePNswNo77dTEzVlFaoM6yQiZo7MMUfEeBChj5/cLpUBKWvwP9xfAUbx8kKcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vad1flW6mOMHPWDPsXFvcRYuUO1FZO6ziugCEN7E/6c=;
 b=5lq/duY0zat1DM+M5XKK5S3fajF8wN4RDg5FNCUTGZLRU4ZoKwVPRy3DhqcBOiV+v6HSY03axHVy1OvJT47vQgMDx/wus106CvXG4L3HZ+F8KjhCtkM07QwQ+SW7wOa3puLtHfi1i8V90v1iUu11g3P4K+U/LObxExdvZH6Md3U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS7PR12MB8348.namprd12.prod.outlook.com (2603:10b6:8:e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Mon, 4 Dec
 2023 23:04:22 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%5]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 23:04:22 +0000
Message-ID: <41632a26-a9cc-de41-de40-ea428cff16e5@amd.com>
Date:   Mon, 4 Dec 2023 17:04:18 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   "Moger, Babu" <bmoger@amd.com>
Subject: Re: [PATCH v13 6/8] x86/resctrl: Introduce snc_nodes_per_l3_cache
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
 <20231204185357.120501-7-tony.luck@intel.com>
Content-Language: en-US
In-Reply-To: <20231204185357.120501-7-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0174.namprd05.prod.outlook.com
 (2603:10b6:a03:339::29) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS7PR12MB8348:EE_
X-MS-Office365-Filtering-Correlation-Id: 79230c75-7eda-4351-8460-08dbf51d5a3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tOKoRSxO12UhW4TOKR3flm8yVoTojHNWju9+lTJXvLRI9oEsqbulZj9C2m6h2QSPteSvZp/qQkhq7XWypti3keKlXi46bbXgxwoQUAZT4PU4Ik+3UMyh6oQ1PuVx642jw8h+oEn19vnJp1t3K2vm/wfdTwZ+smys589Voq6XMA3c9zRug5OzVTFkf/1C29sEJbTyBLKArNAeWIop58X6CbCvm2LaL8j1WBye/SbrIqjLCWK98jmsPoHFLrX9jxcn9c7lDfby15cECpf1wwxgrumI/78TGxo4ERowEQD2QlbZXYqXwCkDSq9wiT8QVzxQG7RW780AM+mev7K4oT3kqoRxfBQ6nWGb8XqpjaF1sFg0eyss8awW9gnBW2uAhG/JLgKEbvPJ2v7UY7qm+WLlTacjQkDxLc0XFV7fs82iwviGtmyGgzAePXuY7p7GCRH+Cw4x4dmdEJqOy4hvJQKUkwgLvLQ0k8rsqNyuC2F4vYXwD2e8zwVIIiFE67jSdOLnyijmcYqXRTw00NMMD/KJ3RuI+OUBqPq8915Err7udb3jup1jeCf5v6y1f5/Eyc/6mRg3NMd0V6fqMIzBlNMRjISe8Fwe5XTjYb8Vt17+m4g4yrjp2usWIKPxFtF/P3GF1V6PYb0eS8shKGnWzsTGfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(39860400002)(366004)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(41300700001)(38100700002)(36756003)(31696002)(2906002)(83380400001)(5660300002)(7416002)(26005)(2616005)(31686004)(53546011)(6512007)(478600001)(6486002)(6666004)(6506007)(4326008)(8936002)(66556008)(66476007)(110136005)(8676002)(316002)(66946007)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0lnRDJZaXgvQk9EMHNxTE1OcVU5cEY1NFZFUmVjWWlNTkxsZlJJS290WTVv?=
 =?utf-8?B?YTh1Y2xRWnh1VmxHc0s3SEgxdWhrVXNFU1ZscG5FdUdOVW9sRGlZZ3NCS0Uw?=
 =?utf-8?B?RDE0b3A5bVFNUEhLSG50YnJCcUs3NjRxU0VXSWVtZXRDTm5YcGpVYXJHeTNP?=
 =?utf-8?B?OTg5TzZsR0FQbTVWNXdEd3JxUFN0bHRXalJDaFJBdkNVUndkUVZ6SFpGTWo5?=
 =?utf-8?B?NWhNNmFRSFZFWkF5aFVjS2N1K0YxZ1E5T3BCc3BMdlNSSTNaN1Q3ZExUK2RH?=
 =?utf-8?B?NXdHd0s5Y3BNY2cxcVdzeS9Eck1OMTV0YjRjOW9QZmlBRkNzRVd0bjk5T3RM?=
 =?utf-8?B?ckZZcHVhM083Y005VWQ4WkJwT1h6RmQ1V0sxeVZvZ0tKSWV4am1sRW53YWxp?=
 =?utf-8?B?QXp5bzRSYytTMCs5R3ZybTlZbFRPNlJxd09NdlpoNWF5ZjNqYWtLaENVb0tU?=
 =?utf-8?B?dHhGTjlVWFJmRmczcmt4d0xkNzV4TVJOWFgxNjhzU2hzeU5nejBkRTVyNVRL?=
 =?utf-8?B?TFhhWUo5N0tVZHVwYnFPdWQ0NGtPaWh0MnlyZXpmWWdrem1GYnFSTkVwM0hr?=
 =?utf-8?B?dmd0YSs1YnRXOEY1ZnQxNnVDUFZyK3RQREN2VUtrVWNFRFhDZ2J1Y081cmZy?=
 =?utf-8?B?ZWRMTnpzUFZEU1ZrY0c5QVEvTXl6elpMZW9iWEhXTGJJc3ZpWXBZUVMrSWxy?=
 =?utf-8?B?NlhVVTFQY0VOekJOOXhNaWVrZnlPYnlmdlFCR01DQkJWUC9NZnhBU2NQM0VB?=
 =?utf-8?B?S1o3M0RXbnNLMTdubzlqUk5mcGt5d2VvUzI5SGNiT1hqRGJpQUJZUjQ2SnNX?=
 =?utf-8?B?WkIwU01oSzR2VUxsTHpGUDFJY0YxV2VxNG9hVkVnREJpSGhQbWpHWkZ2M1Nr?=
 =?utf-8?B?YzVJRDlxZ0dPekNGeTVEbHJFQzFWYUFyQ1JJVkxZUk9wVnN5R0FCb2NMcUJY?=
 =?utf-8?B?R3BUREU4TWVQQThIbnpuUXlkT09idFhsM2tDS205NkxlL2orb0duV0xzdmw1?=
 =?utf-8?B?eDFFditMMDdMWThrQ0xUcXdkMFNpYkhIcXk1UFJOWG1CSFMrZXJNUGFnZ0lU?=
 =?utf-8?B?TlIvdERkUjlwakxnVnBjbjFZcDRZTGpRYUdGZngrL2RHeTF5N3NIZXRaa2Nl?=
 =?utf-8?B?bm1WV3JZcVJicStPZWxMa3FEZEx5SFp6T1plWTBILzNWYndpVFhkTklHMlBR?=
 =?utf-8?B?akN4Z050NmtXSTVIcTBJMGQwV3VSdjBTbWF3Ny9oM1ZRM3U5R3BpbzdKZGwr?=
 =?utf-8?B?N0VNTnhKTVpTTzcyWlZMbllFc1d3cWp0RHpUeGhyeEw3S2UrR0JFUUNPYUN2?=
 =?utf-8?B?OWNhZDZBdEJoV1orTGU3MHhYdTh5SFZqdFZZTkNyN1J3Y0JKRXE1VnY3YVEv?=
 =?utf-8?B?UHgwZ1dNa1cvb2JNTWhqWHg5azZRTkx5NlZ3enFCTU55SWkzMWNvYlczcHVM?=
 =?utf-8?B?aVhkMGNuRXlLdm80ODd3SmVYTlZHMkJhWGQwNXRYVC94Ri9kT0NmZFpmaFNu?=
 =?utf-8?B?NTdOUUV6NEVPQ0xkenFMSUxaWTlQcmNVUFlVU1BuMHZ2YmxaSTRTLzh5UThM?=
 =?utf-8?B?dWN3MHZpZzdyT2RpZWlpV3lIZ3kvaUFINm5mZCtISG1ZVzllLzUrN1FERmJV?=
 =?utf-8?B?cVNBdk1tQS9DSEw0RjRTMjJwd2xOMitWTU1YNHlNVkRUaHV4TE9aMU9uMWlY?=
 =?utf-8?B?TGtxb21zM1E1T2E5R2R3TTIyZm5YNEpvTEk0QVJDajlZbkFzQThUd0NOZ1ZK?=
 =?utf-8?B?SC84a1pRcFNQaDR2aWxIU1lQRGNUaGJsRWhiRldMMXU2eXNGdUgzNE5XRW1S?=
 =?utf-8?B?dGwxSkNPNVNlbFpIaGJYVis0MHV4V1VKd1UzNDBaUU94RFE2RCtnaGVlbUtm?=
 =?utf-8?B?V2kvSE5mYzZ6akxtQ0VzRUNlR0lSeDJmQjg0R3JXdklza2lVa2lrU0RXV2Rm?=
 =?utf-8?B?dmxCb25TSk54ekNKaTVnZVl3ZEwzL3M2Sm1RWFVETjJsYUpMdXdJNTVydHli?=
 =?utf-8?B?VndhMTNNMnRSemR0MWZIKytITUNCSmhBRXV0M0VyeHBZUWxIMk9GYUlaa0Vw?=
 =?utf-8?B?UWd6K2RaUzg3UzBMcXIrOGFUaVZpL1NZdEdmbUFJQU9ueTQ5RG05TUt6MXFF?=
 =?utf-8?Q?6LTNrlV8BpfWs3Q85Vr4gIyP6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79230c75-7eda-4351-8460-08dbf51d5a3c
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 23:04:22.0789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0y0b1njRkLKb9Pt1sonSWiEcNhbPlaOx35v58AF98bVnOYGQMknTV/TQ5AQ7rQdv
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
> Intel Sub-NUMA Cluster (SNC) is a feature that subdivides the CPU cores
> and memory controllers on a socket into two or more groups. These are
> presented to the operating system as NUMA nodes.
>
> This may enable some workloads to have slightly lower latency to memory
> as the memory controller(s) in an SNC node are electrically closer to the
> CPU cores on that SNC node. This cost may be offset by lower bandwidth
> since the memory accesses for each core can only be interleaved between
> the memory controllers on the same SNC node.
>
> Resctrl monitoring on an Intel system depends upon attaching RMIDs to tasks
> to track L3 cache occupancy and memory bandwidth. There is an MSR that
> controls how the RMIDs are shared between SNC nodes.
>
> The default mode divides them numerically. E.g. when there are two SNC
> nodes on a socket the lower number half of the RMIDs are given to the
> first node, the remainder to the second node. This would be difficult
> to use with the Linux resctrl interface as specific RMID values assigned
> to resctrl groups are not visible to users.
>
> The other mode divides the RMIDs and renumbers the ones on the second
> SNC node to start from zero.
>
> Even with this renumbering SNC mode requires several changes in resctrl
> behavior for correct operation.
>
> Add a global integer "snc_nodes_per_l3_cache" that shows how many
> SNC nodes share each L3 cache. When "snc_nodes_per_l3_cache" is "1",
> SNC mode is either not implemented, or not enabled.
>
> Update all places to take appropriate action when SNC mode is enabled:
> 1) The number of logical RMIDs per L3 cache available for use is the
>     number of physical RMIDs divided by the number of SNC nodes.
> 2) Likewise the "mon_scale" value must be divided by the number of SNC
>     nodes.
> 3) The RMID renumbering operates when using the value from the
>     IA32_PQR_ASSOC MSR to count accesses by a task. When reading an RMID
>     counter, adjust from the logical RMID to the physical
>     RMID value for the SNC node that it wishes to read and load the
>     adjusted value into the IA32_QM_EVTSEL MSR.
> 4) Divide the L3 cache between the SNC nodes. Divide the value
>     reported in the resctrl "size" file by the number of SNC
>     nodes because the effective amount of cache that can be allocated
>     is reduced by that factor.
> 5) Disable the "-o mba_MBps" mount option in SNC mode
>     because the monitoring is being done per SNC node, while the
>     bandwidth allocation is still done at the L3 cache scope.
>     Trying to use this feedback loop might result in contradictory
>     changes to the throttling level coming from each of the SNC
>     node bandwidth measurements.
>
> Signed-off-by: Tony Luck<tony.luck@intel.com>
> Tested-by: Shaopeng Tan<tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Peter Newman<peternewman@google.com>
> Reviewed-by: Reinette Chatre<reinette.chatre@intel.com>
> Reviewed-by: Shaopeng Tan<tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
> ---
>   arch/x86/kernel/cpu/resctrl/internal.h |  2 ++
>   arch/x86/kernel/cpu/resctrl/core.c     |  6 ++++++
>   arch/x86/kernel/cpu/resctrl/monitor.c  | 16 +++++++++++++---
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c |  5 +++--
>   4 files changed, 24 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index ce3a70657842..e7a75a439c16 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -446,6 +446,8 @@ DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
>   
>   extern struct dentry *debugfs_resctrl;
>   
> +extern unsigned int snc_nodes_per_l3_cache;
> +
>   enum resctrl_res_level {
>   	RDT_RESOURCE_L3,
>   	RDT_RESOURCE_L2,
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index c9315ce8f7bd..cf5aba8a74bf 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -48,6 +48,12 @@ int max_name_width, max_data_width;
>    */
>   bool rdt_alloc_capable;
>   
> +/*
> + * Number of SNC nodes that share each L3 cache.  Default is 1 for
> + * systems that do not support SNC, or have SNC disabled.
> + */
> +unsigned int snc_nodes_per_l3_cache = 1;
> +
>   static void
>   mba_wrmsr_intel(struct rdt_ctrl_domain *d, struct msr_param *m,
>   		struct rdt_resource *r);
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 4e145f5620b0..30b7c3b9b517 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -148,8 +148,18 @@ static inline struct rmid_entry *__rmid_entry(u32 rmid)
>   
>   static int __rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
>   {
> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +	int cpu = smp_processor_id();
> +	int rmid_offset = 0;
>   	u64 msr_val;
>   
> +	/*
> +	 * When SNC mode is on, need to compute the offset to read the
> +	 * physical RMID counter for the node to which this CPU belongs.
> +	 */
> +	if (snc_nodes_per_l3_cache > 1)
> +		rmid_offset = (cpu_to_node(cpu) % snc_nodes_per_l3_cache) * r->num_rmid;
> +
>   	/*
>   	 * As per the SDM, when IA32_QM_EVTSEL.EvtID (bits 7:0) is configured
>   	 * with a valid event code for supported resource type and the bits
> @@ -158,7 +168,7 @@ static int __rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
>   	 * IA32_QM_CTR.Error (bit 63) and IA32_QM_CTR.Unavailable (bit 62)
>   	 * are error bits.
>   	 */
> -	wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid);
> +	wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid + rmid_offset);
>   	rdmsrl(MSR_IA32_QM_CTR, msr_val);
>   
>   	if (msr_val & RMID_VAL_ERROR)
> @@ -783,8 +793,8 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>   	int ret;
>   
>   	resctrl_rmid_realloc_limit = boot_cpu_data.x86_cache_size * 1024;
> -	hw_res->mon_scale = boot_cpu_data.x86_cache_occ_scale;
> -	r->num_rmid = boot_cpu_data.x86_cache_max_rmid + 1;
> +	hw_res->mon_scale = boot_cpu_data.x86_cache_occ_scale / snc_nodes_per_l3_cache;
> +	r->num_rmid = (boot_cpu_data.x86_cache_max_rmid + 1) / snc_nodes_per_l3_cache;
>   	hw_res->mbm_width = MBM_CNTR_WIDTH_BASE;
>   
>   	if (mbm_offset > 0 && mbm_offset <= MBM_CNTR_WIDTH_OFFSET_MAX)
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 21bbd832f3f2..79d57dade568 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1425,7 +1425,7 @@ unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
>   		}
>   	}
>   
> -	return size;
> +	return size / snc_nodes_per_l3_cache;
>   }
>   
>   /*
> @@ -2298,7 +2298,8 @@ static bool supports_mba_mbps(void)
>   	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
>   
>   	return (is_mbm_local_enabled() &&
> -		r->alloc_capable && is_mba_linear());
> +		r->alloc_capable && is_mba_linear() &&
> +		snc_nodes_per_l3_cache == 1);
>   }
>   
>   /*
