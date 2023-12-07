Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E74A808D32
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 17:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443307AbjLGQMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 11:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235401AbjLGQMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 11:12:34 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5783170D;
        Thu,  7 Dec 2023 08:12:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBRYqV/FoCnyWnoO96fVHp180X9cr+PJzw27oMxtIiH6kVuM5Dy4uCQZo3I99GXWo4jtaKlVH0jJC2Pa0BN6QHe1ECEGOSt7jY3PU6iZrRgGgXakKIYhwxTxx+UWB8q1u7BW37q6Gak8biFbeE8iMVcIumSsyzsAiShmN6OBpjxXWP5wGicNxjcwWqtOhwjsveUmM0tftIdIrUNJpDXQWL9L08nNdNf7FihbwWhVFRed0j1OpjuykJqbX9vCNhr2/IGjb1PFk2i5t1OHD/tWUQPTp/+FbXCU09ZJQ+xz9C+x1+9vkk2mJ0fuXwcYZJzaO1L55qwQE8MGaHIp+KW+6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7YgKSO183vpiwISr2h9zYtaPI6Vrq/323TQ6xXBnVeM=;
 b=c5za6FHIp3IHPALGhAWU1Aj9XnyBKcoLlCT2PvnedRazo/spIO5uXg6T/zIrOsQcC6zTlKMPJ5idAikznPiF6yvWrY2CrqWRMePvbrblkmTyvwGYgjBavC+bSVMGwXIRO8EwQtXmJ2CGr+L73Z/7a9SrUjZvQVrp2OUrIhh1zA57Wy0qIpIXXjDMfoIpFNtt39dq3Q1JhKkSUxNyp/3GLNP1AJMCny6UDBIlEh+nDKOl1D4n15WK20JmL74qeaC6NOSl+a7jy2WOCGnOwjJHN6waFJfCwCoBOfToAD/EP5vOMOwtD8rRshvz4X4gfZwDoJJXawwVeJzYKc66ziPUOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YgKSO183vpiwISr2h9zYtaPI6Vrq/323TQ6xXBnVeM=;
 b=Kvk8tMtnX9WpUJU/C/vHhNadDOZxcswHXFgtbJIelFvDTSj3rBNCeaWceuLAmU52gaoDETziQBtpkKPsYe2lD8qEugBDvwHhqadehGhkfqJ+QMZdnAKC2+12ezQFM0WS8B4mkKLnf8hdC0Zxz+wUHLSUeHY/66Hi3ygT47HSXtA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW4PR12MB7117.namprd12.prod.outlook.com (2603:10b6:303:221::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.35; Thu, 7 Dec
 2023 16:12:31 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%5]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 16:12:31 +0000
Message-ID: <5ce67d8f-e207-4029-8fb3-0bc7deab1e9f@amd.com>
Date:   Thu, 7 Dec 2023 10:12:27 -0600
User-Agent: Mozilla Thunderbird
From:   "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH 00/15] x86/resctrl : Support AMD QoS RMID Pinning feature
Reply-To: babu.moger@amd.com
To:     Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
        fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com,
        James Morse <james.morse@arm.com>
Cc:     x86@kernel.org, hpa@zytor.com, paulmck@kernel.org,
        rdunlap@infradead.org, tj@kernel.org, peterz@infradead.org,
        seanjc@google.com, kim.phillips@amd.com, jmattson@google.com,
        ilpo.jarvinen@linux.intel.com, jithu.joseph@intel.com,
        kan.liang@linux.intel.com, nikunj@amd.com,
        daniel.sneddon@linux.intel.com, pbonzini@redhat.com,
        rick.p.edgecombe@intel.com, rppt@kernel.org,
        maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        peternewman@google.com, dhagiani@amd.com
References: <20231201005720.235639-1-babu.moger@amd.com>
 <d97cbeba-af6d-4b64-b5c8-32dc437a67b6@intel.com>
 <71e85bf3-a451-4adf-ad5e-d39f7935efa0@amd.com>
 <e36699cf-c73e-401b-b770-63eba708df38@intel.com>
Content-Language: en-US
In-Reply-To: <e36699cf-c73e-401b-b770-63eba708df38@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0151.namprd03.prod.outlook.com
 (2603:10b6:5:3b2::6) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MW4PR12MB7117:EE_
X-MS-Office365-Filtering-Correlation-Id: 07b2f361-ee68-442a-ee9f-08dbf73f50b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x71+NC+Txeh2nvUCaOcErJrGn0Xmb8dgpXWJFn5L0MbUt9OZbAC8L+CPCmtZ06TiCXRs/qT7IylF32UVJt7Q4rW0Te0wlJB9n0d4pfmzyYwQA5rRqVr7zu/zCfnbQRrfNseL82jiQlJ4CuqxgGvdY5sjReSRewVQRKPUJsxv5kdUh0otbvM71xHb5reIpJr4OapsrOv8mJTfj80mwMRGEHrBdS+tNHr1lja4kJ5Bop9BA7M9y0c2RiyIThL+hmss8BLjzayOyf1+nopOVh7Kc+lPx2zC9PscmGEqkz09hFR8gj31zYCivWeVPq7HC34TSz/YM1+7MhJaVTod4+2ZSWZrUyeEbp+B/QXbIPwQmU1w5fhcLRCBeNIuw56MTncHz49fmwbzgxWN5sCkURwD/1i6Du2x9452fjBZ24KzTXTTGOKIG4GD4OW1JSFz4DEvOmyoXwhk9V5D9PMqC9z/KTJhuPaOLuleQ+SKP5oshKMWzdA2/Myl2A6hhmwiMLiYjg5Nd8z8OfLiTPUZnRWYO399X/a0qknpqEgTxBi82L5CEmyqPi3TGe8JXW0UOQqf/c1ZpsEWo+wh9f9ZcMlamYk0fLaHPWL9Z+m/Gd2AhjeqIkHbQumUJ3hW6TqhwGP8DcY/vvGSNwmpyPcxVGy/vw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(396003)(366004)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(83380400001)(6666004)(66899024)(6512007)(2616005)(6506007)(53546011)(26005)(316002)(110136005)(66946007)(66556008)(66476007)(5660300002)(2906002)(7416002)(3450700001)(8676002)(31686004)(86362001)(8936002)(4326008)(36756003)(41300700001)(38100700002)(31696002)(6486002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2gvdkM3eEFKbDFQNExxbFZtOW1NQVVqdEx6SkVwazh6OVNvY3I3SFlJcHRU?=
 =?utf-8?B?UUNXcHpsbCtzRVMxQzFadGJqbzAyL1NrWm9xQ1J6ZVFrQU10WjJaTnBITjRq?=
 =?utf-8?B?c3NLSkFpL1JCMzRzUXI5R3RjWnpXT01jL2VMNG1haGYrejNxTXU2b3JWMFFt?=
 =?utf-8?B?c250bmJvanU5bmFLS09TY0NTK1grOG5KWmtQYkdCeG5JNXR5ZEJFd25rd3Bl?=
 =?utf-8?B?bGp4b3VKNFF0cStzeS9nd05BT083SisrSjY0eVVabFJYd3FuVlNyU2R5Q3Z6?=
 =?utf-8?B?L3pabEw5Yy9uZ1laUFk3YzVUTDBRMHFtS3NZU2ZEc3U5VEhyQzk4QTc4RkEr?=
 =?utf-8?B?RHhPd3YyVzJMbDhiTGRjVVNkZFhQT2FpdVlkdTh1SitsNFErdzVucmFRMkJP?=
 =?utf-8?B?RTZQMFBtSUJLNFVJd0JReXl5NkdQaVFLc2lUQk56QUh6bHJiNUJUNzRlUWUw?=
 =?utf-8?B?Sjk1MEFEMGNaa1NDNFBxSEs5MlhlL2ROV21QK2FLRVVGREJva2xUUk1CWFJn?=
 =?utf-8?B?ZUVwMXdvdzIyQzJuNUNiTndjTUNNc3AwN2psTDA3ZU5pV3FVclp3dC9lUFox?=
 =?utf-8?B?Z29NL3ZacndzMkt6SVlOVkxGVUJGTkRiVnlhY2xvaEVVUDRwdmlhWDJJZjJY?=
 =?utf-8?B?akkrYmp0N0R3cS83N1NsTE9hUEZjWTBkVlhBTWVSSTVPcGxzZkFkQnF6R1ly?=
 =?utf-8?B?VTQvdVU5eEF5TEdjcUx3eVQ2WGdRVkZ6YmNkQmVjeGZjV0RKT2JUK01tQnUy?=
 =?utf-8?B?ZFZUd0Q4UUZRb0lKZXArSFhORzJZT1NrYWMxa0FZOE5MWmxqSm9iWjU2OU9p?=
 =?utf-8?B?My9MNzZoZFRObHZRZUQ5YWJpR0lEc1p2VFhYUVNsQVo5S05hMy9kTzlNZk1r?=
 =?utf-8?B?TEhud1VxV3E0eHdvU01Kb29hK1hCOEw5RHN0VVRqMlpFWXdYTTJEWnZTTGdi?=
 =?utf-8?B?MG9PaXJVcDJpV1U1YkF1dnJ5SVk4OUxiMmo4NXVZRXo4a1hLMGxkTTlUWUlV?=
 =?utf-8?B?dGVNZmNVMW1zdk1kWnNkZ0JWMzgwaW1BTjJ6WjY3V3IvMmVDM1ZTK2hmU2Q1?=
 =?utf-8?B?RVZRZ2lKeG5YSnZrUGtCSDF4T0JYVEMyNlFqWE1YTlVXYnNlNmFSeXMrQWRJ?=
 =?utf-8?B?dnhtSW9rUXcvS2dCYlJVRzFiZU1OWTMzTDI2S1VGK3YySXg0REtjSkVTZ0Vh?=
 =?utf-8?B?Q3F1KzBwTlJKRXlKcXI3SmtpaUZCMklJNEFYY3NCVVZ5ekVPaDRtSjVqWmhl?=
 =?utf-8?B?akhkOE90RGRLS0IxRzdMV3l3OTNBT0wrTDVxRy81aDNEVGM3UnJXa0F6SEV4?=
 =?utf-8?B?M0ltRHcrN25mdHNjRVVnQ1FCclNYeHhxR1d5SDJEYVl0bkZLeEZ0VTk0WUk2?=
 =?utf-8?B?TUNwNlR2RFJkMnNmZmkrbHV5dm4rSTZDeVBBZ3NwWUh1THB5OCtMSjRwNHFO?=
 =?utf-8?B?ank5eFhFVmN4QVM4a015SXQyR1d1V3pQYWZDNTlLejlFdUhBVFBRSlRLblhw?=
 =?utf-8?B?ZnpBTlNTbUZPRys4OE1VNnBuUWY4ZWcxMS9helpkUm9WRUtlM1ZEcktEK1V4?=
 =?utf-8?B?MUFMT0dhQ2c3aGl1eVNCRld3UU9ZY1F2YlZpRHdNVHQ5MXMwWFZmM0d3RXNl?=
 =?utf-8?B?N0lQNDMvVG5ueVpkYWJhRXUyK3FKaXVyNk0rbm1oWnU5dkdpNTB3NG1BTEpa?=
 =?utf-8?B?RmxyS0V5UEhtamFsNXIvV1ZrelJlTXJ5MlFDMENybzJzNUNaeTRrYjVoelBp?=
 =?utf-8?B?R0YxVUVqeFJub0dTOU9CMEJLZFdhR09HWDErQjZXRS9odXQvUmxjVGN1Ti81?=
 =?utf-8?B?UnhHOUhiNGxDMTN4c0RMMjJEU0NwQVU1RmpZVHFWU0xOeTZIOXB1allyVkdN?=
 =?utf-8?B?c3NxZXlxdE5OUkJuVmc0bWR6S2p3M0VUT2J0SGtTdnBORFBydFgrd0s0MXV4?=
 =?utf-8?B?TTJ6YW5MM0c3cUlXeGtRZmVGYWdmUVhhRjZ3RE9iVVI5L1Rpbi9iaVBmSk9n?=
 =?utf-8?B?Y0dlVkJZUTI3MjN4OU9obms2blV4OHc4YUY1a2JZaUc2MHNPR2dIK0t5eHpH?=
 =?utf-8?B?czlUMlYzSHk3Y1hING5zTU5JVWtYQU80cXNCa2xmU00rWHczcHU3VjRteFBW?=
 =?utf-8?Q?ZzHc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b2f361-ee68-442a-ee9f-08dbf73f50b2
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 16:12:31.3570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bWAtiskjAlXx7KAEYCDt5hLN8qhAcx5dvQlCNiDtOET1rsP6wYz14+Ur+S0yWcSZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7117
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 12/6/23 12:49, Reinette Chatre wrote:
> Hi Babu,
> 
> On 12/6/2023 7:40 AM, Moger, Babu wrote:
>> Hi Reinette,
>>
>> On 12/5/23 17:17, Reinette Chatre wrote:
>>> (+James)
>>>
>>> Hi Babu,
>>>
>>> On 11/30/2023 4:57 PM, Babu Moger wrote:
>>>> These series adds the support for AMD QoS RMID Pinning feature. It is also
>>>
>>> "These series" - is this series part of a bigger work?
>>
>> No.
>> There are some some plans to optimize rmid_reads. Peter is planning to
>> work on that. But both are independent of each other.
> 
> I would propose that you use "This series" instead to avoid creating
> wrong impression.

Sure.

> 
>>>> a. Check if ABMC support is available
>>>> 	#mount -t resctrl resctrl /sys/fs/resctrl/
>>>> 	#cat /sys/fs/resctrl/info/L3_MON/mon_features 
>>>> 	llc_occupancy
>>>> 	mbm_total_bytes
>>>> 	mbm_total_bytes_config
>>>> 	mbm_local_bytes
>>>> 	mbm_local_bytes_config
>>>> 	abmc_capable ←  Linux kernel detected ABMC feature.
>>>
>>> (Please start thinking about a new name that is not the AMD feature
>>> name. This is added to resctrl filesystem that is the generic interface
>>> used to work with different architectures. This thus needs to be generalized
>>> to what user requires and how it can be accommodated by the hardware ...
>>> this is already expected to be needed by MPAM and having a AMD feature
>>> name could cause confusion.)
>>
>> Yes. Agree.
>>
>> How about "assign_capable"?
> 
> Let's wait to learn more about other use case.
> 
>>
>>>
>>>>
>>>> b. Mount with ABMC support
>>>> 	#umount /sys/fs/resctrl/
>>>> 	#mount  -o abmc -t resctrl resctrl /sys/fs/resctrl/
>>>> 	
>>>
>>> hmmm ... so this requires the user to mount resctrl, determine if the
>>> feature is supported, unmount resctrl, remount resctrl with feature enabled.
>>> Could you please elaborate what prevents this feature from being enabled
>>> without needing to remount resctrl?
>>
>> Spec says
>> "Enabling ABMC: ABMC is enabled by setting L3_QOS_EXT_CFG.ABMC_En=1 (see
>> Figure 19-7). When the state of ABMC_En is changed, it must be changed to
>> the updated value on all logical processors in the QOS Domain.
>> Upon transitions of the ABMC_En the following actions take place:
>> All ABMC assignable bandwidth counters are reset to 0.
>> The L3 default mode bandwidth counters are reset to 0.
>> The L3_QOS_ABMC_CFG MSR is reset to 0."
>>
>> So, all the monitoring group counters will be reset.
>>
>> It is technically possible to enable without remount. But ABMC mode
>> requires few new files(in each group) which I added when mounted with "-o
>> abmc". Thought it is a better option.
>>
>> Otherwise we need to add these files when ABMC is supported(not when
>> enabled). Need to add another file in /sys/fs/resctrl/info/L3_MON to
>> enable the feature on the fly.
>>
>> Both are acceptable options. Any thoughts?
> 
> The new resctrl files in info/ could always be present. For example,
> user space may want to know how many counters are available before
> enabling the feature.
> 
> It is not yet obvious to me that this feature requires new files
> in monitor groups.

There are two MBM events(total and local) in each group.
We should provide an interface to assign each event independently.
User can assign only one event in a group. We should also provide an
option assign both the events in the group. This needs to be done at
resctrl group level.

> 
>>>> c. Read the monitor states. There will be new file "monitor_state"
>>>>    for each monitor group when ABMC feature is enabled. By default,
>>>>    both total and local MBM events are in "unassign" state.
>>>> 	
>>>> 	#cat /sys/fs/resctrl/monitor_state 
>>>> 	total=unassign;local=unassign
>>>> 	
>>>> d. Read the event mbm_total_bytes and mbm_local_bytes. Note that MBA
>>>>    events are not available until the user assigns the events explicitly.
>>>>    Users need to assign the counters to monitor the events in this mode.
>>>> 	
>>>> 	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
>>>> 	Unavailable
>>>
>>> How is the llc_occupancy event impacted when ABMC is enabled? Can all RMIDs
>>> still be used to track cache occupancy?
>>
>> llc_occupancy event is not impacted by ABMC mode. It can be still used to
>> track cache occupancy.
>>
>>>
>>>> 	
>>>> 	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes 
>>>> 	Unavailable
>>>
>>> I believe that "Unavailable" already has an accepted meaning within current
>>> interface and is associated with temporary failure. Even the AMD spec states "This
>>> is generally a temporary condition and subsequent reads may succeed". In the
>>> scenario above there is no chance that this counter would produce a value later.
>>> I do not think it is ideal to overload existing interface with different meanings
>>> associated with a new hardware specific feature ... something like "Disabled" seems
>>> more appropriate.
>>
>> Hardware still reports it as unavailable. Also, there are some error cases
>> hardware can report unavailable. We may not be able to differentiate that.
> 
> This highlights that this resctrl feature is currently latched to AMD's 
> ABMC. I do not think we should require that this resctrl feature is backed
> by hardware that can support reads of counters that are disabled. A counter
> read really only needs to be sent to hardware if it is enabled.
> 
>>> Considering this we may even consider using these files themselves as a
>>> way to enable the counters if they are disabled. For example, just
>>> "echo 1 > /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes" can be used
>>
>> I am not sure about this. This is specific to domain 0. This group can
>> have cpus from multiple domains. I think we should have the interface for
>> all the domains(not for specific domain).
> 
> Are the ABMC registers not per CPU? This is unclear to me at this time
> since changelog of patch #13 states it is per-CPU but yet the code
> uses smp_call_function_any().

Here are the clarifications from hardware engineer about this.

# While configuring the counter, should we have to write (L3_QOS_ABMC_CFG)
on all the logical processors in a domain?

No.  In order to configure a specific counter, you only need to write it
on a  single logical processor in a domain.  Configuring the actual ABMC
counter is a side-effect of the write to this register.  And the actual
ABMC counter configuration is a  global state.

"Each logical processor implements a separate copy of these registers"
identifies that if you write a 5 to L3_QOS_ABMC_CFG on C0T0, you will not
read a 5 from the L3_QOS_ABMC_CFG register on C1T0.


> 
> Even so, this needs to take other use cases into account. So far Peter
> mentioned the scenario where enabling of one counter would do so for all
> events associated with that counter and then there could also be a global
> enable/disable.
> 
>>
>>> to enable this counter. No need for a new "monitor_state". Please note that this
>>> is not an official proposal since there are two other use cases that still need to
>>> be considered as we await James's feedback on how this may work for MPAM and
>>> also how this may be useful on AMD hardware that does not support ABMC but
>>> users may want to get similar benefits ([1])
>>
>> Ok. Lets wait for James comments.
> 
> Reinette
> 

-- 
Thanks
Babu Moger
