Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A25277E53F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344210AbjHPPfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 11:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344278AbjHPPfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:35:03 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6722684;
        Wed, 16 Aug 2023 08:35:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crTZ1y+tSMPBvV2zU+KzAT+pG1UhQsUw1GKLEue0XHzAjGfdBqXQv5FDRPEoA4p2piew8644j31RYdoC4pCD54qPQvdWOLdshdW4aIz/l5+zRAsxZZKVXbhT9aphTWj6yKH0ILn3xpFOvOMT5aXdXEVsfWaBiIwxBF46+u/AeiN6I6uQcFMaWvbDYbBcLDH1edyYrpHkeFNTU7XCOUrVBaYNndaVaZJrt7aw8dXAzRo6ufzJf+5/epxi7yWd8Sh5OMai8IyGPz7orh0Z2YeBRTXyptpt/i7CCJ7+TxwCOUcfGDfCcxqWt1lw/cKpouyPY9kt1J+jOggJ5fQoJmfK6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JPJ53+H1Mx0iDI9/iZeBk0guVmTsie5ydw6VYY3m7c=;
 b=Zo548KgbyomPY+PnTQND3C0hdQqE+2h197VtAuCcYIg+Zw3/4eJapJKCayYSEKI7fDznSjp7ZV0wawkJnNUEesdDlRydTtBRZ2XWyjIqnYkVfxAFHEenjERNoHZ1wIGhHpSZJJWsUypPcvOFzEBfEPCMgA+60rmiU6o9zdl+cIuqFcbrs3o1pp1nq0XUl7xU9wo216R+yvr4oeP24vbc1mEpO6gD4p7njV+YI4A1y/gmlmCROQXzb8cZExBB00yEEEOMAbQ3GsAJUBW2jqrWoghnwjR9uBfobYKiZqwx5GtAaUbEtotowe2TKl75VnDIrRLH5hotLzKfTQ2f5d48QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JPJ53+H1Mx0iDI9/iZeBk0guVmTsie5ydw6VYY3m7c=;
 b=BnVrvpFl6IMo4n+2s9ddXxrYRIz7kCZvXoZhzKNclWk5URcZ4xon7YC/OteIiMSTdbcGiFBpGiL/so0i4O2Y4gP5VHMqIMjR8mOCxQB5VAhUv1FCx8fdlff4+YPmmYeEy53pbAFSGbexe/0ruZnu50IbEuwl7p3IhMAV1lEUTr0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS7PR12MB5911.namprd12.prod.outlook.com (2603:10b6:8:7c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 15:35:00 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ae3b:f153:4d30:73a8]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ae3b:f153:4d30:73a8%7]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 15:35:00 +0000
Message-ID: <c341b2cf-7ebc-f52b-76ba-77a106dc20fc@amd.com>
Date:   Wed, 16 Aug 2023 10:34:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 4/8] x86/resctrl: Add comments on RFTYPE flags
 hierarchy
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
 <169178458575.1147205.16331131496340363561.stgit@bmoger-ubuntu>
 <37986ad0-4519-0f16-c09b-86fcf2f8a763@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <37986ad0-4519-0f16-c09b-86fcf2f8a763@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR03CA0093.namprd03.prod.outlook.com
 (2603:10b6:5:333::26) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS7PR12MB5911:EE_
X-MS-Office365-Filtering-Correlation-Id: ff021c56-fc53-40e3-10d9-08db9e6e59ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kHZ6T69mEl8PqrWnVjjKyG0333IWlJF3IiKIyyL63U0UYHNCWcxA2fU9di7wZGSBKaZ676FCXCk6jxpU35KjVLLWCySoS19H961qVbGyPIEDA7u8x/q9GCdTSt7Gqq2hERiZE5vOM+9R1oLgByeP7NGo8sYEvNoMrvJ/rEhjajDw85skySFidp1Dw0qe1uCtfEk2Xx2RVs0ZUHfVZznZzYkw5I39BXMDaosVTnqye4EXhGqFGW5YEkBdKxhDLxnIFNcYwjHyGRBpgkc6SnEadKir81Imiq7tmGYAXH96v9EK76kjdoIAKkKPRhvKsq9kiCbpdrCbvRpzDzhJVx/AC696adiTzN8VtwmK6XFztbh+zN+1+YZL22wdgXkOyKA0VG4mdYkGqiO7sQRs2IaHzQJdGrFpkuaNDBENrUZ2jJpqZEEY22Mt7uC0WZq4djCnWXI2yDQhiWwAujkqO/eSe2nDdbdk7x3wv/aeRTxM8nyGM4TQAEQx2Zyfo3+EktcNhdP75tSGwtgdK31WRpqndfMQcTmuyqiIDpW1LGgn3OJqSUAhOIj/vix9rRiwSVyz7FYBdwuPmP7BEi6YhuigAacVACNltefB37F2vlhFxRaRxXGARgl9Y0jf8+WqJiBkXjmhul7qa7N7JfPyL8W+Mw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(66946007)(66476007)(66556008)(41300700001)(5660300002)(38100700002)(31686004)(8676002)(4326008)(8936002)(2906002)(83380400001)(3450700001)(26005)(478600001)(7416002)(7406005)(86362001)(31696002)(6512007)(53546011)(6506007)(36756003)(6666004)(2616005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0FtVWFsTGlNZ3N3bVhjdnBWL3RNV1F6cGVub29QaDVtUWg2eVYzUEZmNG5Z?=
 =?utf-8?B?RXNpcVphZXlweW9GenhUSFpvL3dUaFZhV0szTDdHUWtSWHlpR3VpbmYyUnlX?=
 =?utf-8?B?MWcxTmpQV0hRSUdDclEzM1VwSlVlMUhueTdYV2F2MlFzbDVrOGdaamdyL1JR?=
 =?utf-8?B?SmxZQlc2TDUzSGkrOWY3b3RNZnJVY29rUXBFbVpSSWc2cjRPNVdXT2U2d2Q2?=
 =?utf-8?B?WnpwMHY3cjc3TWhFZStmaXpOeDl3Vi9kbDlpUTNVS3duYlJCbkhkb1Qzam43?=
 =?utf-8?B?WkczL3d0cHlTNEo0d0pHT0txODRybEg5c3YzV2JRaGlzeDFRYTJaSTZGZHZ4?=
 =?utf-8?B?ZEhXZk1oYTlRMHEvMndJQjhJd1pjeXo1OHZHQm1lOVYrazkyY3pGK1lsRGJZ?=
 =?utf-8?B?eGtuZHpFeXVLSzB6VWR3VldnN3k1dGJwd1ZSZ25GeldnNzV4Q0dndGRabGU1?=
 =?utf-8?B?cTNlRHNYNHZRdlYrSmU0ZWM2NlJPTlp4ZGdnRmtzcmRIeGx6VHNFdVlyOWxp?=
 =?utf-8?B?dnpwV1MzcWgveDM3VFNGSWtIYzJJTTN3OTdadkV4SlJtR01VWlRjTythVjh1?=
 =?utf-8?B?NGt0VWZyY2VValV5bGYrZTRlR2ZnNXNaZmlpMU5nTFRMM1FGTEd4bkg3dCtD?=
 =?utf-8?B?SjV5NHRDOVlzZjRkL3hJNWlMZ2dXOWFNK1VmVkt6RXpOYitWMVhKbVRaWjlH?=
 =?utf-8?B?MVBQRVREMGFDaDNIelhrTDZPODNjZTFEYzBzU2xnRUkxaUFPTE8zL1pQK0pq?=
 =?utf-8?B?Z09KOHNrd1B4a0Y5M3VzbXRKL09iY3lZZ0VrZVlzaWUyeWwxS2JsalBQdys5?=
 =?utf-8?B?WWVGR2lWK0huREZTZjhKOFpLSjRrQXBkMys2d1EyZWV0MkwvUFQrQ2E5eVJ1?=
 =?utf-8?B?K21rZ1ZXSHBhRTFlOU9MNjZ4WWJGZjFWR1lGbURNYnQ0NjByNDBQQXAvWFJv?=
 =?utf-8?B?V2krYTlkWkkrMnF5VDR2R3lsblBZTVVtSUFIOGUwNCtZRmxTdTVMc1JBTEpS?=
 =?utf-8?B?OVZtbFgwVUp2b0F4OWI0Ylg5dGpGK0daMkR6cEUwRjM3bURNMTNyS0w3MlFU?=
 =?utf-8?B?Y1BJeVNUbmpQT3FXQUUySmdFeE5DUVA5cDVJM051aWFKZEcwci9LRzBxdSsx?=
 =?utf-8?B?NnZxNk9NbkZVY2hJLzN3b1FSSGpqRjROZmk0UnlDcE5YRHZOZXV1Ry9GTXRy?=
 =?utf-8?B?LzZZRDFyVWowL3lPalRGK1hnc0lxdUNUQ2NEL1ZIbUpEaUlqTVdrUHIyVTZp?=
 =?utf-8?B?amVVejFTbGJBN29zaE82aU5qckJLN1dqMUhtaTE5Wk5DbTJzUXJscEN0TCs4?=
 =?utf-8?B?T3lLRHp1aEw3dSszOGtCSWJzZTNtUWNNeGludms4TkVHS1djUWZvYm5KK3NR?=
 =?utf-8?B?SHZxT3lzK05talFzMmpLeGszViszd1Vib1pJK0RMRVpQQ1NESjBPT1U2NVJy?=
 =?utf-8?B?WGt6UVdlN0NHQ2FtZDhpaVplZFBKTW1hUU5ESXlLcHFYWDFmNXJ6NWU2dXN6?=
 =?utf-8?B?VEdqT1NkU3NBTmRBaXNIVUhOUzRhWjV4MVFTeVdINFNOb2huT2JxczJpMExS?=
 =?utf-8?B?UjFGbEhVTGJTRi9IVHgvL0pubzlwVW9ocHAzUmY5Z1M3QzhNaytqR29aL3g4?=
 =?utf-8?B?UUcvenNEZWJiT3R6VEkvbm5ZbTVXS3QrUC9jaHBzVnpsdDhvUGpndzB5Wll0?=
 =?utf-8?B?cVVMZVVJcjY3VXZ6aFVZTDdSUHN5NjRzdlRGLzlta2dmZ1N2RCs1d1hXUWZo?=
 =?utf-8?B?R28zRXRaRllKRzAwT1NFRlMyLzNIOTBPbmRVak1MRTJ1d3M5Ujl4UEppemR0?=
 =?utf-8?B?WXNEN0tzUVkwNi9DdXlob3hFZFFOVUo3OHI4dHVZM0RzdGt6TDh1T0dHWm9U?=
 =?utf-8?B?NDJXbTNrNXhGSThFRHc0M2V5V3BDRWpITzZndWpoNFArZTQ4STcvNy9XYlUw?=
 =?utf-8?B?WUNONjk4Q1E4Y3JwSGZXa3RQQ2FocTE2S0pqYkVTenBacmpvN2Ezb0Fmc0hL?=
 =?utf-8?B?TjhLWm5GSmtxeHU1K21MK1ZDQVA0M1Q3UlViZlNKZDlKV0ZRMmVDK1hacEpJ?=
 =?utf-8?B?UXZ2QnZmR2F3T1JoQTF2eHJmaFErR1AveU1NWWxNbzllUXhaOTUyOFVlYTQ0?=
 =?utf-8?Q?5560=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff021c56-fc53-40e3-10d9-08db9e6e59ef
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 15:34:59.8268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qBI198TONa7a+aiGnk3ERXH49HVNWOvXmnr+1BVWTSAsvBgeZ9Z2kIN8lH5twAKg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5911
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 8/15/23 17:45, Reinette Chatre wrote:
> Hi Babu,
> 
> On 8/11/2023 1:09 PM, Babu Moger wrote:
>> resctrl uses RFTYPE flags for creating resctrl directory structure.
>>
>> Definitions and directory structures are not documented. Add
>> comments to improve the readability and help future additions.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  arch/x86/kernel/cpu/resctrl/internal.h |   49 ++++++++++++++++++++++++++++++++
>>  1 file changed, 49 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 2051179a3b91..37800724e002 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -240,6 +240,55 @@ struct rdtgroup {
>>  
>>  /*
>>   * Define the file type flags for base and info directories.
>> + *
>> + * RESCTRL filesystem has two main components
>> + *	a. info
>> + *	b. base
>> + *
>> + * /sys/fs/resctrl/
>> + *	|
>> + *	--> info (Top level directory named "info". Contains files that
>> + *	|	  provide details on control and monitoring resources.)
>> + *	|
>> + *	--> base (Root directory associated with default resource group
>> + *		  as well as directories created by user for MON and CTRL
>> + *		  groups. Contains files to interact with MON and CTRL
>> + *		  groups.)
>> + *
>> + *	info directory structure
>> + *	------------------------------------------------------------------
>> + *	--> RFTYPE_INFO
>> + *	--> <info> directory
>> + *		--> RFTYPE_TOP_INFO
>> + *		    Files: last_cmd_status
>> + *
>> + *		--> RFTYPE_MON_INFO
>> + *		--> <L3_MON> directory
>> + *		    Files: max_threshold_occupancy, mon_features,
>> + *			   num_rmids, mbm_total_bytes_config,
>> + *			   mbm_local_bytes_config
>> + *
> 
> I think the monitor files need the same split as what you did for
> control files in this version. That is, there are some files
> that depend on RFTYPE_MON_INFO and others that depend on
> RFTYPE_MON_INFO | RFTYPE_RES_CACHE. In above it appears that
> all files depend on RFTYPE_MON_INFO only.

ok. Sure.


>> + *		--> RFTYPE_CTRL_INFO
>> + *		    Files: num_closids
>> + *
> 
> Looking at this closer I can see some potential confusion about where these
> files appear. A note saying that these files appear in all sub-directories
> may be helpful because at this point it appears that this file is at the
> same level as the directories.

Sure..

With both these changes. Here is the diff on top of current patch.

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
b/arch/x86/kernel/cpu/resctrl/internal.h
index 37800724e002..412a9ef98171 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -264,12 +264,16 @@ struct rdtgroup {
  *
  *             --> RFTYPE_MON_INFO
  *             --> <L3_MON> directory
- *                 Files: max_threshold_occupancy, mon_features,
- *                        num_rmids, mbm_total_bytes_config,
- *                        mbm_local_bytes_config
+ *                 Files: mon_features, num_rmids
+ *
+ *                     --> RFTYPE_RES_CACHE
+ *                         Files: max_threshold_occupancy,
+ *                                mbm_total_bytes_config,
+ *                                mbm_local_bytes_config
  *
  *             --> RFTYPE_CTRL_INFO
  *                 Files: num_closids
+ *                        These files appear in all the sub-directories.
  *
  *                     --> RFTYPE_RES_CACHE
  *                     --> <L2,L3> directories


Thanks
Babu

> 
>> + *			--> RFTYPE_RES_CACHE
>> + *			--> <L2,L3> directories
>> + *			    Files: bit_usage, cbm_mask, min_cbm_bits,
>> + *				   shareable_bits
>> + *
>> + *			--> RFTYPE_RES_MB
>> + *			--> <MB,SMBA> directories
>> + *			    Files: bandwidth_gran, delay_linear,
>> + *				   min_bandwidth, thread_throttle_mode
>> + *
>> + *	base directory structure
>> + *	------------------------------------------------------------------
>> + *	--> RFTYPE_BASE (Files common for both MON and CTRL groups)
>> + *	    Files: cpus, cpus_list, tasks
>> + *
>> + *	--> RFTYPE_CTRL_BASE (Files only for CTRL group)
>> + *	    Files: mode, schemata, size
>> + *
>>   */
>>  #define RFTYPE_INFO			BIT(0)
>>  #define RFTYPE_BASE			BIT(1)
>>
>>
> 
> Reinette

-- 
Thanks
Babu Moger
