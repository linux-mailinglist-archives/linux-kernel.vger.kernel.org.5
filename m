Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6456B7C8F75
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 23:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjJMVjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 17:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjJMVjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 17:39:35 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2065.outbound.protection.outlook.com [40.107.100.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34B8BE;
        Fri, 13 Oct 2023 14:39:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zk1El7AEcSDGw62kAMRRN1s7qB54hJmjnvjpIlfU3n6aooAC6dA80P4huqQXyWMQTyzmU8zuRih9qC/kZ/y1lOH//WFUsze70B22szUQ7CRBqIss4I99go84YWN0NRV8GMCV6Lk3ZTjNO9iNIAJhuRWpsbKKknw5RCOyy76QDzH99c2njaUJ2mRaeL8Cm04R8/Ncinz44akVDPGmOr4Tuqu1dLNCwAKNnb4KsRiB70+xr2qbyyIi1YlrBpx6lG8vwod4CqCEwStB2AdNMZ9JZyWRd8zPI9WccmQrN0wdtIR8ZeX38U8qVoECkuJiJH+BwLczCo7bGRiV5WwlVfXFoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ciVAbNlJ2y0EEUbAoNisxsb70a9QunANVNcLzNfHAy0=;
 b=iAPk5LNLtDfl1BLCttr8oYpqJP9jhbmiZRPMIfexW6bVdBho6GJmae6ZxmC/M5XsUwJ0Yi5q0jA1ZLXdZCN8QtQvbsOYXni2tBxGOdSOitq8MVzzlnLdxBhsqJUvKaTSjvLXTsZ2j1VRNO5CbZciroVEIgyxY7GsC4bzS97h3RbsIV7JFaoGIIrpZu6JLbhxJUuftRn7KQsyAJ46mqMyimVNn8qD5RZ1jBhD7ZZdb0JE2wrhFX4waTMmjtH0dnRB5zwhWKOLcSqUMPajE56IFoCs3mu8uvvFB6pPcy7wYidjP4S6t5Mk5VpgK5Uj8f4yBFUskIvpMslOR0/QMw9KYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ciVAbNlJ2y0EEUbAoNisxsb70a9QunANVNcLzNfHAy0=;
 b=MdIl9MfgO2yzEayA1hg7R6Z4kgSrf6fIGnD7qsCaiudL3dndUp/77W5DOz5fshEF2QApbF2SaqZnbI86iCjE9Lg5D9G52V0yEjqxLZ9K5OuQcSloCJk7RHWGGbUgsfbumJWtHtbIrf5rF/f6clhdEdG+elSer+dp91zHkBOmRUM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH3PR12MB8481.namprd12.prod.outlook.com (2603:10b6:610:157::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Fri, 13 Oct
 2023 21:39:30 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39%6]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 21:39:29 +0000
Message-ID: <0acbb031-a84e-1cbc-0857-f087b07a9056@amd.com>
Date:   Fri, 13 Oct 2023 16:39:23 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v13 04/10] x86/resctrl: Add comments on RFTYPE flags
 hierarchy
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
References: <20231013202602.2492645-1-babu.moger@amd.com>
 <20231013202602.2492645-5-babu.moger@amd.com>
 <d4a33013-0448-4c36-a168-b3a953024962@intel.com>
From:   "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <d4a33013-0448-4c36-a168-b3a953024962@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0156.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::11) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH3PR12MB8481:EE_
X-MS-Office365-Filtering-Correlation-Id: a8f80eb1-ebea-4210-6090-08dbcc34e133
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GKAkewvMWKUdna+o532CLZ3/q7OJpRyUvlGU+SDfkXB6FWpfCpV/fc9QW///JMC7G46DEVzEKqkpliO5r0KDG9Yl/whAU6meIikp31XlbJwMavJHQB+aoW+u2zwlz4qCFgueoZHWyN/5W9Gm2Vg8pVsJ8wfFnF4aNLlS55Dsb9gYRqebMKRlHpK+Tv9LEvPMMRvWwlTaOJTEU9h2LkSUPSoKWLmQ+rGDbE88+1nJtsHgR2keaeSj43N3FllHKzzo1jdnPg4GazhPS83PR6UAy31pyDKnZmRj+nFoooFGpF4PePivj8TxfqWUfXFF/pTC33P0ITdVfyO2WSfFnHRuRZOGgcXnmR7uv5yXJT8TR6YW/VksCtak/Ao4PvuzAyh6V97H4rwZ3J2Nb3wn1vNmfr9lMwUBk+IpzQXOYSvDxw9IXJ1Cf6wsvpd3lzQW/xsW+Icc+jZQfVSCkGsyBe1zRgdTqViXWucf7hdrVMrs8xM0FZhGhRqxRC4E5SY6YGVQpTFTbsh4EVvpwz0nPj3PmHwGH+VRmM4RCoNwm3peVG0AilKUfYrdHgCbV/QrmuXFEQsWQx3ZapRT3yn4JWIuS3yRS9NrpM/JwuZsw0iCf9eDDuPtoSxYyBeYkdUux67Gky7+e+iA4L9UpeiYfN78ew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(39860400002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(36756003)(31696002)(31686004)(2906002)(41300700001)(66476007)(7416002)(7406005)(478600001)(2616005)(5660300002)(66556008)(66946007)(6486002)(6666004)(6512007)(53546011)(8676002)(110136005)(6506007)(316002)(26005)(4326008)(8936002)(38100700002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlRNL0tpN09YMGNKZS9GVUNHMmpLQ3JKN0NKR3daeWltZlIxbjc1Y2dpVmgr?=
 =?utf-8?B?cWVQVTBnQVNzQ0d2ZU1ndWNQcGgvdW0rNEFYeUVHVVMwOVNzS3hFaWEwMkht?=
 =?utf-8?B?YVcxbG05RjYyejlQTnNwNy80RDFudVExVWN1SHdRQ3RiSVdaNEo3NE1kUkJK?=
 =?utf-8?B?TVcxaUlaVkczSmNsQVJyUnpjT21UNGRNM0dncUpsalRHZ3FlcFVHeE5HTzVx?=
 =?utf-8?B?Vm1jdm1zK2x5Y0VlMjlqTzlxWElsNWJGRjVvZTlKbFErU1I0OUNRdFU4Y0tG?=
 =?utf-8?B?dnV2RmdnTmU2RVcwT1dCb0RTcDM2WWUvVDVTTC91dE5vem5QWlc5ZjdUeFU2?=
 =?utf-8?B?TzdWbWhKSXBta2dWS3NnUitMU3BQOFdjVlFFNDBtbjQ0eGtxM1grcFVycHY4?=
 =?utf-8?B?RXlKRTlaOHNZRnNVRkRyUC9HN1VyOFpGQ3phaldFaEs5bGg3djFnQ2xmWlZm?=
 =?utf-8?B?b1huMWp6OGQramw1OTE0aUJFK216RTN2My9nNmMxMzU4VzJhSHIza01nZGY0?=
 =?utf-8?B?dkJKeEg5UlRVUnMyWWlRVVcwWEFlZ0dJaDhja1dJUXIxcHJLcWFmeTR1Zm5Z?=
 =?utf-8?B?bktXRTc2N2tva2VwNzdlUlNlbTM3M21WSy9hVkViWkNJcThTem8xNUZPZE45?=
 =?utf-8?B?RXUrVWtXVTFEZU81R0lMczNsY0pSZjlHeFhma3E5TzJiN1BSTkZiWE5KaGg2?=
 =?utf-8?B?RGlnT2hCN2d0MjZhLzRMYW8rMjNXMnNTMzlWRlhKZXhxRENucUpSeUhRRVpU?=
 =?utf-8?B?YTg3aHVYN2tmN0xuSjZIVWxqdFo3LzN4UXErNFJ1TUFKenBuS1l3ejVNMnVR?=
 =?utf-8?B?M0xGb0Z5dDhFdktaNUpyNzdxM3JjN2k5bWpuL3J6aUNPMHpFcVI0WHJiWnMv?=
 =?utf-8?B?SVc3d3NNVG5xWXBzRXlRZkYycVhhUmZ6MmpRS0dWUVZCM0FZRjdwbnNzbm8w?=
 =?utf-8?B?VC9lTjJ6SkFubjdQZ0lrUkV3OTY3b0REM3JuSVhqRHNuYy9VL2RHNjN6djdn?=
 =?utf-8?B?a3dmb013aklSSWlWTzAwOTlZVEtvYU16Z0xvZnhua2dFUDE3d1AxUldWb2Fz?=
 =?utf-8?B?L1FVSzRYTWlmM2lxL3JSZjBNcWgvNXdyRjZSN3Vra3hIL2NxZER5YW1kUmFk?=
 =?utf-8?B?ZDUyOXJ0NXB3cm9odTJ3S0pDc3RpQnYrVTg5bnorQ09OWmxXTlVoNEMxSlAz?=
 =?utf-8?B?ejVrL05HRUJ6OWVSOHZLYWZwaWErY2Vld0hFWTlHK1dNbGhmNGlKUytpUVI1?=
 =?utf-8?B?TlhGNk4wdFVQTlNzSkUvWFpxNEF3VWR1eUxzOU1QQjNIQnVpRXp5TXJsL3hK?=
 =?utf-8?B?YnZOaEhRQi9IaDFCSVlGaklWcFY0dnExaHhBM2lKTnNYRVFaSzhrZmI2NXUw?=
 =?utf-8?B?MDg2K0ltSlJhdkYyblpOTzg4UHRIbXpVc1ZKUUZkWWlDbGFCaEZINGdMZGZr?=
 =?utf-8?B?eWdHa1JBZXNiMExZVDNRbmlyUzMvaGJDRVJtd1ppQXpLRHV6dVpZS3poUWhC?=
 =?utf-8?B?S0dGdXZFdHJUcmRiN1EyMGFsQWlrUjhQT28zamhoQ05IazdrVTk5dVR2aE44?=
 =?utf-8?B?ZDFiaDV6MGs5b2dHaDVTdUZLTGQwc05oZlhtTWNmNU1UUHNzL0NJbE5Ldlhl?=
 =?utf-8?B?a21Bc3huOU1ZK2kyQUo2alh6dmZKNWphNlNiZktKdW0wZTAybTNSNUVyQmNl?=
 =?utf-8?B?TE1PK2RlS1IzOUxPcmQrSmwvMlVqWURBbG1vakVOZFFzMmlYTCtDQk9uUjQ1?=
 =?utf-8?B?b0N1SVdqbGFoQjc0cE84bWxXTHhmb2hGNVduVUZ2UU5PL2ZiZjhxUnMxVUNB?=
 =?utf-8?B?anNkN0dvS292WUxTczF0LzRQdTlSSkVOdEpDMTRIaFVHUjZiUXNNMTZkT0dQ?=
 =?utf-8?B?OU9OTEQ4dXI3ajlHMDYzVmVaZ3lpcjFVLzc4Z3lZK3BwMFZxY0UzM1l6Mm1u?=
 =?utf-8?B?VHhnZk9BZkZXTEoyWC9hR2tjbzlDcUVqd3NLNXBMRW9pNnBUZHhzVE83U0xx?=
 =?utf-8?B?S0FqNUFYR0NCcTRxOVFzbWgyTkJQZVFmMnpwMFA3VEZkb0l0M3FkQkIvWk5l?=
 =?utf-8?B?SzJRb3N1bmNmSjl1NzhVSmEvQkRGQXNBeWU2bWw3TjhwZFc0WnZwVzcvUWVt?=
 =?utf-8?Q?RLKQPYKyrVx8G3EnHzGoPuijs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8f80eb1-ebea-4210-6090-08dbcc34e133
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 21:39:29.3197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YEskCUpTzwK575BD0CgN23+P1CNuQX8yiTgH4fEOVXXLimmQcAnN+F/zlWauASzo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8481
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 10/13/2023 4:23 PM, Reinette Chatre wrote:
> Hi Babu,
>
> On 10/13/2023 1:25 PM, Babu Moger wrote:
>> resctrl uses RFTYPE flags for creating resctrl directory structure.
>>
>> Definitions and directory structures are not documented. Add
>> comments to improve the readability and help future additions.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v13: Fixed the format issues in the documentation. Needed few minor format
>>       changes to address the syntax issues.(Reinette)
>>       Removed "Reviewed-by and Tested-by" flags as the patch has changed.
>>
>> v12: Moved the comments from arch/x86/kernel/cpu/resctrl/internal.h
>>       to Documentation/arch/x86/resctrl.rst. (Boris)
>> ---
>>   Documentation/arch/x86/resctrl.rst | 64 ++++++++++++++++++++++++++++++
>>   1 file changed, 64 insertions(+)
>>
>> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
>> index 178ab1d8f747..1163da74f734 100644
>> --- a/Documentation/arch/x86/resctrl.rst
>> +++ b/Documentation/arch/x86/resctrl.rst
>> @@ -369,6 +369,70 @@ When monitoring is enabled all MON groups will also contain:
>>   	the sum for all tasks in the CTRL_MON group and all tasks in
>>   	MON groups. Please see example section for more details on usage.
>>   
>> +RESCTRL filesystem implementation notes
>> +=======================================
>> +RESCTRL filesystem has two main components
>> +	a. info
>> +	b. base
>> +
>> +	/sys/fs/resctrl/
>> +	|
>> +	-> info
>> +	|
>> +	|  (Top level directory named "info". Contains files that
>> +	|   provide details on control and monitoring resources")
>> +	|
>> +	-> base
>> +
> Could you please do a "make htmldocs" and then ensure that the output looks sane?
> The resulting output does not look right to me. For example, the above turns into
> a single line that looks like:
>
> /sys/fs/resctrl/ | -> info | | (Top level directory named "info". Contains files that | provide details on control and monitoring resources") | -> base
>
>
> The spacing also looks off when viewing this in html.


Yes. Messed up again.  Thought fixing the syntax was enough. Will look 
into this.


>
>> +	   (Root directory associated with default resource group as
>> +	    well as directories created by user for MON and CTRL groups.
>> +	    Contains files to interact with MON and CTRL groups)
>> +
>> +	Note: resctrl uses flags for files, not for directories.
>> +	      Directories are created based on the resource type. Added
>> +	      directories below for better understanding. The RFTYPE flags
>> +	      are defined in arch/x86/kernel/cpu/resctrl/internal.h.
>> +
>> +	info directory structure
>> +
> You removed the separator in order to pass the syntax issue but now there is
> no indication that this is a heading and the content becomes harder to understand.
Yes. I played with this little bit. Dont know how to make this look as 
header. Will check it.
>
>> +	-> RFTYPE_INFO
>> +	   Directory: info
>> +
>> +	-> RFTYPE_TOP (Files in top level of info directory)
>> +	   File: last_cmd_status
>> +
>> +	-> RFTYPE_MON (Files for all monitoring resources)
>> +	   Directory: L3_MON
>> +	       Files: mon_features, num_rmids
>> +
>> +		-> RFTYPE_RES_CACHE (Files for cache monitoring resources)
>> +		   Directory: L3_MON
>> +		       Files: max_threshold_occupancy,
>> +		              mbm_total_bytes_config,
>> +		              mbm_local_bytes_config
>> +
>> +	-> RFTYPE_CTRL (Files for all control resources)
>> +	   Directories: L2, L3, MB, SMBA, L2CODE, L2DATA, L3CODE, L3DATA
>> +	          File: num_closids
>> +
>> +		-> RFTYPE_RES_CACHE (Files for cache control resources)
>> +		   Directories: L2, L3, L2CODE, L2DATA, L3CODE, L3DATA
>> +		         Files: bit_usage, cbm_mask, min_cbm_bits,
>> +		                 shareable_bits
>> +
>> +		-> RFTYPE_RES_MB (Files for memory control resources)
>> +		   Directories: MB, SMBA
>> +		         Files: bandwidth_gran, delay_linear,
>> +		                 min_bandwidth, thread_throttle_mode
>> +
>> +	base directory structure
>> +
> Same here.

Yes. Will check it.

thanks

Babu

