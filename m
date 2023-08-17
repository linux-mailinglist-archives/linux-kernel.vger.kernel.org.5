Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B40A77FE79
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 21:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354683AbjHQTYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 15:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353492AbjHQTYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 15:24:19 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2050.outbound.protection.outlook.com [40.107.101.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367661FF3;
        Thu, 17 Aug 2023 12:24:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CshJerAbLde6jejJiNp8mYM7F6jGUIRoiujJUUi2HK2R0qNw4hBfTMRKdrvuAtt8/FuxTqNm2VJPLHxJGzlRQD3w1GfantJGTg5qFPXP4rnQ2DbVStTOpu75G3lFndNNlDZoPk0X45LvxUVDqPTz++bduyc605xSFXAHn50gAIW88MPm+5EqPrBAAv3RVffWVqvX5N5lamJsJ8r12BWAKQBVCC3JvmeN0nRrU5V2LDc24MJGhfJmR12foCqY5qWNoFWsXQfARmnjNMRssArQtu+LWajYwVuhnGsTinMjW0/IENJRj7tPFi+Ms8Pa+FCnm0+5o/CfanhompBHkhdABw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvWZCwrnPS1CHZpQdNReKLK9/KnxpXzCIQhndh9UirY=;
 b=lE8hIjKwEn2X7CRv2hMsMdgpnAbZM3hkAjagRT80VyxoTSVAl+q+x1ILxNdEkhMdAyLcT0nFLJO38nn5ygR5CTN6ITV0B/IdTw8krSuM3hQWvqOIafLfl34s6GI0VM237lO+kIGAjiYqWOn98g4hCLF6iwmgcNwyJr9w77V8sHpG7yrCWRl61JGMtik+gU3L9yFaU27Sut+X/S12SJs/8AsYBsu04z6YK9XmerRSJkbDaIUoG8hY7mRUr/7R3u+VhbyObO3L7WjeSrg7xhmkV0JH2AO1flQWOVmYwh5LBqfT3LYgQ0cAaW8JJ9VdjeY/NgwKu5bYBbtkF+6f1Rpj0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvWZCwrnPS1CHZpQdNReKLK9/KnxpXzCIQhndh9UirY=;
 b=Et/A2XQWFYxi9poj+K1w3vlf8fPnb4a8sf1CQhidDN5KIjnmed4DY98snNpmsUX2ndn/YzrxMMBzZ/rUB/uuzkxG2R+tzHRTepi/h854O/V1ExrW99ummV1h55rHr6195/CHgpsoiRDpzH9MbebQ9eWO5/kmhhuTdybwoMEZcW4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by SA1PR12MB7319.namprd12.prod.outlook.com (2603:10b6:806:2b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Thu, 17 Aug
 2023 19:24:14 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::93bd:7d4:6a9a:45ad]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::93bd:7d4:6a9a:45ad%6]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 19:24:14 +0000
Message-ID: <97b97085-ab0d-b14f-e566-dc4071ef4bb8@amd.com>
Date:   Thu, 17 Aug 2023 14:24:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 8/8] x86/resctrl: Display hardware ids of resource
 groups
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
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
References: <169178429591.1147205.4030367096506551808.stgit@bmoger-ubuntu>
 <169178465701.1147205.1483883019768336774.stgit@bmoger-ubuntu>
 <ec286003-bdd5-590e-1290-2d3268ecdc2c@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <ec286003-bdd5-590e-1290-2d3268ecdc2c@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR07CA0073.namprd07.prod.outlook.com
 (2603:10b6:5:337::6) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|SA1PR12MB7319:EE_
X-MS-Office365-Filtering-Correlation-Id: c71bbda3-0aa7-4791-2dca-08db9f578aac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 06+wIktv5g7uX6Bc9kpGekeIO0OeRev2/GA5aw6e1lJf5gKWvGPf0SSRDIDMjWOhMBBiOvWGdFHA6jQaugZ0j+YtQ7f8oMrbKXTKFnk2Xrztd162b0qwrHzDAyfEiN+QD0u+UYyjwyzZtmzO25BpfLdt3MwSHGTtCsxHb8Mg4xRtmVqU+rp9idWpw4Uk4LHuyYYcp9XZvA+40OyVz5bTllWRPpMYBIKV8YfpRIgKiuTZTYUZy9JZ5rogM2AUOVHcTcR64wE8AH/ekTMZb+zkgqm2LbqkTcDOKGNZmk23Y2et/WpKnG9sM1uRM39WAz3NU/JIds13buIis1jIVJLpRtHkG7MHiM+WQYzTtPsBewj9JHeusmEuv8tCrmI2kwvK+O6QsS1St3eWyUQQxFxySkYelNQXFd8HvQ3BSm3PHt69SaIDgTxGcMU5I14FNvw6M1OVy83EVrgcpYjv7rjCqwyvU85nRhiBMm5rslVSFn1lLqJAPKntfLbGEE40jYu5W7ZZOW4Fl8xtIzayNurR8/JAbOk2CZg/Rox4LX7qTR7/IJeDjIJuxuxDme4Sq4N35UQGBrCwuwt6bANHyca5cRb0hzbPwf+9d6bVZ5FfqWkpp+jVQnEDQ2fT8WchC7qFXOg3CGGkn1wdl6dsXBfzjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(39860400002)(346002)(376002)(186009)(451199024)(1800799009)(31696002)(2906002)(3450700001)(83380400001)(26005)(7406005)(86362001)(7416002)(478600001)(6506007)(6666004)(2616005)(6486002)(36756003)(6512007)(53546011)(5660300002)(41300700001)(316002)(66476007)(66946007)(66556008)(31686004)(4326008)(8676002)(8936002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1RhSmwzb0ZOWm5MVE9HNjhieXpLVm1sOVRBbm00L3dUOUJwcEJCbTJnSGhv?=
 =?utf-8?B?R1E5VlEvTnRuRFA4czV3TmowQXVtcllZVVRDdEJUNFRWZkZkelA0T2Vkakcw?=
 =?utf-8?B?ZkpHWHQzeWxzMUU2T2FZWjFsVzBHOFV1SzVPWVVlcUNHSUUzbmtPSDh4VGYz?=
 =?utf-8?B?VlNHcitRclNjU1o4bW0zSm9JcHVvSTdUWGtRendJclcvL242SnZNYXhRZ1lz?=
 =?utf-8?B?U2t0cGlpVG5vMnBJVW8wRTJGdlkzV3RqeTltbis0VnBXYWZ4MjFUbjBLazUy?=
 =?utf-8?B?eFdXVXllbEVyTmt4WlpaU2ZGQjBqQU1hMFZ6Mk9vOTNOOTdaWU00RnpRSlJM?=
 =?utf-8?B?aUxleGd6SE82U1lnVThLU2JTOElGK1Y5UzJjVmo2djdRcVVBbkxZM2hkT0po?=
 =?utf-8?B?eVVTMWEvY05vSmdMZExkZjk2YlBpR0hoc2tuRUFHdGtwOEU4Qmd6V1lEK0Zn?=
 =?utf-8?B?cDJKbkpuQ3VZWmZkVnZFZU8zdE1tVzRNYXRiUU9rUGxFdmRYZUdLZEdENWN0?=
 =?utf-8?B?cG1ZZFNXZmJ0U29SbmRxRXZ5OVkrell3OWVJUmR5d1BhdFBNZTlScHQxRjIw?=
 =?utf-8?B?dmRtVTFKWUxLQjQ5VFAzVDBkOHZybmVTM2wzWktRdXNWU0tNSWh4dnF5cmRJ?=
 =?utf-8?B?M3ZPM1lWdUZRNk14QXg1Y2FmV1g5bDI5aUdwcmEwRXR0NUFySWh6WjZOU3Iz?=
 =?utf-8?B?V05wRTB5S0pIbG9weXY3SUViS3JBZU4rNGN4eDN4Y0RkT1Jzc1NVR3lhS0xZ?=
 =?utf-8?B?ME56b0RzU1d2aFlMcCtFQTAwUG5aYi9xNDNzdlNYbm92VUxpNG4rMVA1OGtp?=
 =?utf-8?B?bDJGYmVtZW9FZ0NEUWl6TFc5R05sWHUzb1M4akNHUnNwUkpiTkx1UW95Rk9h?=
 =?utf-8?B?ditHNDU5N2xGN09NNzNDVXdjcGN5Ty92N3hvWFZPazVPNW90MFJCL3Y3OHhI?=
 =?utf-8?B?VSt2bSs4SFVsQzJaa0hkbnpJb2x3WVFQSTczZFhpcDB4a1BxamRONGUxMnJt?=
 =?utf-8?B?OGsxTkw5QlZWUE1VVEh2Sy9udG9TZ0ZSZUxEL0V5MmE2MHQvUEV5L3p3ZlBY?=
 =?utf-8?B?SlBSSmVaSkZLa2tlNkZDZCtDVTZneEJ4S0xOMFp0NWZXeUt5cm0rZ1BqNnlw?=
 =?utf-8?B?cERFZURzRzZqTk9qaVVDWFRCV3hhSFRMSGVRZW1wbHNtK1N5S3crSkFaZlEx?=
 =?utf-8?B?RUpCWEQva3Nid3M4eEo0YUlGdG9iU0xCT3FpTml2VHV0TUNNcG1xdGpvcXF1?=
 =?utf-8?B?UVoyOU1zUlBMWmJmK21vQlpXaUpSSXlHalN4WVlxYTFNa1dqb0VVU00wMlI1?=
 =?utf-8?B?dDl5ekpNd01xcStBVnhxcDROV3h3RFJIVjMvTUpqTmdMRHM1TXJmN3hJUjY2?=
 =?utf-8?B?R09kRDBTR2E0ZTdyeTZHY0h1WnV4UnBPM05GN25pSXdiSU5URDdSZXhuSkdl?=
 =?utf-8?B?YUlna2dXQ2hJQUpkQ3RXUzJZUWVhOHNmdU53OXlUbzhtMzNFUkF2dUF1TENH?=
 =?utf-8?B?QkxmbVJFeVlwY2srTCtwNnphL3NKMFY5RVZ5TzZKa1ZJeC9POWZrWTM0S1pY?=
 =?utf-8?B?b1ptSmM0L0VNT0VjMy9KRmhnSEhXbFVhQUpLQUY5bTlvZHlWMjMySi9Gczl6?=
 =?utf-8?B?eXJ1UEJjRmlUZlVLYTAzb2V0TDdMVXZwR1IwdnhFdENuM3hqQVBCbEFiZHdx?=
 =?utf-8?B?bHJlUE44bmZZMUdqemRDQy9DVTlUVHRtRVJHTG5QVCtLWkI2TXZpdW0wYjBV?=
 =?utf-8?B?eDNMZ3F4cmlTMG8rMUo5UGNoZGVNcFZmaHVjMFpBQmZZbHZNb3Jqc0tpcU1P?=
 =?utf-8?B?UmlYdmVBWmZmWXArYmM3SWI4Vys1MFU1eFByYmhkd1lySkV1bExYQTlOemVY?=
 =?utf-8?B?Tk5oS2xRczdnZTcySHl0ZHpFck52TFhRd0NiM1o4Vzhlb3JGUG9BQVl2VzF6?=
 =?utf-8?B?aXBEdmYvMytnMnB4VVhZa3VZRnZENW1idFpQeCtwZ29uRGRoTGpoM2JDbEhQ?=
 =?utf-8?B?OEFPVWRnN014bU5MRnhjS2hwYnFoYkx2U2VHS2tKME9oTWh4YjJuRDhWR1F3?=
 =?utf-8?B?VkdGZFJlMStpRWZTZGFlWXJFMGRFSHpqejNxa29vQThPaVJIOXJPdXRESmNX?=
 =?utf-8?Q?baeQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c71bbda3-0aa7-4791-2dca-08db9f578aac
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 19:24:14.3705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bEXOjLPllvfPF+ixNXdo1JMXLrUcmle9ySMtvAKKL0QbqGirKYm1ByIWcS9UQW50
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7319
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 8/15/23 17:52, Reinette Chatre wrote:
> Hi Babu,
> 
> On 8/11/2023 1:10 PM, Babu Moger wrote:
>> In x86, hardware uses CLOSID and an RMID to identify a control group and
>> a monitoring group respectively. When a user creates a control or monitor
>> group these details are not visible to the user. These details can help
>> debugging.
>>
>> Add CLOSID(ctrl_hw_id) and RMID(mon_hw_id) to the control/monitor groups
>> display in resctrl interface. Users can see these details when resctrl
>> is mounted with "-o debug" option.
>>
>> Other architectures do not use "CLOSID" and "RMID". Use the names
>> ctrl_hw_id and mon_hw_id to refer "CLOSID" and "RMID" respectively in an
> 
> "to refer" -> "to refer to"

Sure.

> 
>> effort to keep the naming generic.
>>
>> For example:
>>  $cat /sys/fs/resctrl/ctrl_grp1/ctrl_hw_id
>>  1
>>  $cat /sys/fs/resctrl/mon_groups/mon_grp1/mon_hw_id
>>  3
>>
>> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
>> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  Documentation/arch/x86/resctrl.rst     |    8 ++++++
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   46 ++++++++++++++++++++++++++++++++
>>  2 files changed, 54 insertions(+)
>>
>> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
>> index 5a2346d2c561..41ad9b1f0c6a 100644
>> --- a/Documentation/arch/x86/resctrl.rst
>> +++ b/Documentation/arch/x86/resctrl.rst
>> @@ -351,6 +351,10 @@ When control is enabled all CTRL_MON groups will also contain:
>>  	file. On successful pseudo-locked region creation the mode will
>>  	automatically change to "pseudo-locked".
>>  
>> +"ctrl_hw_id":
>> +	Available only with debug option. The identifier used by hardware
>> +	for the control group. On x86 this is the CLOSID.
>> +
>>  When monitoring is enabled all MON groups will also contain:
>>  
>>  "mon_data":
>> @@ -364,6 +368,10 @@ When monitoring is enabled all MON groups will also contain:
>>  	the sum for all tasks in the CTRL_MON group and all tasks in
>>  	MON groups. Please see example section for more details on usage.
>>  
>> +"mon_hw_id":
>> +	Available only with debug option. The identifier used by hardware
>> +	for the monitor group. On x86 this is the RMID.
>> +
>>  Resource allocation rules
>>  -------------------------
>>  
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 6b7e914657fa..94471ad9d905 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -776,6 +776,38 @@ static int rdtgroup_tasks_show(struct kernfs_open_file *of,
>>  	return ret;
>>  }
>>  
>> +static int rdtgroup_closid_show(struct kernfs_open_file *of,
>> +				struct seq_file *s, void *v)
>> +{
>> +	struct rdtgroup *rdtgrp;
>> +	int ret = 0;
>> +
>> +	rdtgrp = rdtgroup_kn_lock_live(of->kn);
>> +	if (rdtgrp)
>> +		seq_printf(s, "%u\n", rdtgrp->closid);
>> +	else
>> +		ret = -ENOENT;
>> +	rdtgroup_kn_unlock(of->kn);
>> +
>> +	return ret;
>> +}
>> +
>> +static int rdtgroup_rmid_show(struct kernfs_open_file *of,
>> +			      struct seq_file *s, void *v)
>> +{
>> +	struct rdtgroup *rdtgrp;
>> +	int ret = 0;
>> +
>> +	rdtgrp = rdtgroup_kn_lock_live(of->kn);
>> +	if (rdtgrp)
>> +		seq_printf(s, "%u\n", rdtgrp->mon.rmid);
>> +	else
>> +		ret = -ENOENT;
>> +	rdtgroup_kn_unlock(of->kn);
>> +
>> +	return ret;
>> +}
>> +
>>  #ifdef CONFIG_PROC_CPU_RESCTRL
>>  
>>  /*
>> @@ -1837,6 +1869,13 @@ static struct rftype res_common_files[] = {
>>  		.seq_show	= rdtgroup_tasks_show,
>>  		.fflags		= RFTYPE_BASE,
>>  	},
>> +	{
>> +		.name		= "mon_hw_id",
>> +		.mode		= 0444,
>> +		.kf_ops		= &rdtgroup_kf_single_ops,
>> +		.seq_show	= rdtgroup_rmid_show,
>> +		.fflags		= RFTYPE_BASE | RFTYPE_DEBUG,
>> +	},
>>  	{
>>  		.name		= "schemata",
>>  		.mode		= 0644,
>> @@ -1860,6 +1899,13 @@ static struct rftype res_common_files[] = {
>>  		.seq_show	= rdtgroup_size_show,
>>  		.fflags		= RFTYPE_CTRL_BASE,
>>  	},
>> +	{
>> +		.name		= "ctrl_hw_id",
>> +		.mode		= 0444,
>> +		.kf_ops		= &rdtgroup_kf_single_ops,
>> +		.seq_show	= rdtgroup_closid_show,
>> +		.fflags		= RFTYPE_CTRL_BASE | RFTYPE_DEBUG,
>> +	},
>>  
>>  };
>>  
>>
>>
> 
> I think the comments introduced in patch #4 may need to be updated
> in this patch.

Sure. Will add it.
> 
> Apart from that this patch looks good to me.
> Thanks
Babu Moger
