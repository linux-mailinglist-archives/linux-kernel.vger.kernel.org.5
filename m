Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC4177297B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjHGPkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjHGPke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:40:34 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A206FE79;
        Mon,  7 Aug 2023 08:40:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fkPtBs2DbK2JEJg4VDhv9aTrrT9Z4I8PZs4Z5yAh9mhXGytAgZ94+qTGDE6xPC7VFGFkpeSQ4KuAJtue1RPQaNK8iZecD4mDajXWOg51wKGae5l3ggNkxtVW3pJ0Jp88HYG0Xyd4SSnyBxEzu5/51rLJWeLDTWTyyBn41qWOQ7Ddhw54//awo60g//Wej6IU6zl6YPsfrViX81dBzL1U4aVOimEgDWvWlE0F19dJIAwcRSpI/gdVGq+B4NH2rOszJKJpizLpXjE6q2j6hxMKsG/lkslgoA3xYpCqDqQPO9/rBNzpb+H3EPiuNCaw2+UVhZG/bmAM2goWYRM8TCOwHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzGFUNzBXdBqa049Imcn2giDGugTAg4m5C56eAr0s+s=;
 b=fHVvs6nkE7KFNs2wyBeuBjeMTr9mWL/FPcLgmwccrsQsKhBnXosJTC1NMw6DTYLzHaGCHn/a605tcsQN/0c75jqAIzO+YqqMit+tEfxD9fbM9wJsX7zcWBvS85+CGP2gXqn3VbGU3TeMLK00U8lqewv7PaVc8mhnRz0wKudCpevnRZP1xB+PfZrwqEPGu6THf43z+pqzIPgeHU8Tvvh3XwyI2sjyC3DDUvx8aJtD5KOhlqDguEk4SUI7y+6RLzvl/v+jm6wLKm1KDFZO/AGSPejEQGZU7K6HsuKLDQ1MGNU1WZUhhgVUZtf71cn/Ue6DOmyY+z3Ay1MXkxYdpxfceQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzGFUNzBXdBqa049Imcn2giDGugTAg4m5C56eAr0s+s=;
 b=P7BWTPxUD/bKOhhLyJfQ4Hj9ATvy4csqeePD5DLwybOCvlB6BRFixz081lEzXpT0vsKe+gRAwDLk2UGjtOv1XN4ohe/I/J8BBhKHj10vgZzZNpdQD37nCrWZjELOS8uFQvssn7ie4JqObYlGe1FOcB/xDHDNaaAurnYyyGMj2+g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA0PR12MB8302.namprd12.prod.outlook.com (2603:10b6:208:40f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Mon, 7 Aug
 2023 15:40:28 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ae3b:f153:4d30:73a8]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ae3b:f153:4d30:73a8%7]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 15:40:25 +0000
Message-ID: <d6dfa143-36e1-a92e-8a73-7b5dfd3db62d@amd.com>
Date:   Mon, 7 Aug 2023 10:40:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v6 4/8] x86/resctrl: Add comments on RFTYPE flags
 hierarchy
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
References: <168980872063.1619861.420806535295905172.stgit@bmoger-ubuntu>
 <168980891501.1619861.11056885467637617879.stgit@bmoger-ubuntu>
 <41c166e8-d6a2-7be8-1d4e-6b2b1cc62f2a@intel.com>
Content-Language: en-US
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <41c166e8-d6a2-7be8-1d4e-6b2b1cc62f2a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P223CA0015.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::20) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA0PR12MB8302:EE_
X-MS-Office365-Filtering-Correlation-Id: a6fd5240-3940-4a79-e4ae-08db975c9e0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: befwhN0zB8ut3tQDjKoaRcvJ9EHgWS6YZNq58DjsxmDW0e/aopxyucM+BT4rvTVZkE4N4uVBMeJJrDC4RFh+dAXI8BPgX3puqxBIduyrLOvvgY7VVJK2DSckqv5sQRgAHn4KcaNcR/zuPgb1o1yuQThAJP82lKoOntdgFziigEvbx7/M6ZMlTN3+n8fWFluf+7d3U2lnxyI2OEqF6YgmPhp3O/dHMaJTuKcV+8GYxpmcKyYD8cGLIeZvfDorO9VaXOjdtv6w2Ahdt2sGqspwvCtDBlQSE4PDhX8BMuxv2TPR/Orx/PuZGCm2TbNOC1kdtu0prGK4epjsPB4bG0V1AzE0Bu11PEvokcwIYAKzOaBlTQpsOgoB11yoXSKZN0YBGpP9cR5YKCBI35qP7JdtSPzFlWaHIPi/xEfcnQ7FeaA8eTqkKbw/GFmjpymg20bjKKCVW4XVzW4VvuwJCFVEqYlFLnkWl/arSQrn+rlimm3C23hjZh49QU0JX9UsPgrL95/SQ6yO3O/4ELDHnTTFiZFLSQOyay0k32qq3btA1ZfI1uJDyUx/zFm4MXRoenP3cxOAthknD/2eX7mQ7ZKmRYN3xOjyHxsq6ZHRf0P/qLvNUF/WtyoAr3pve/togZoi9+PdV2hEpfazOGV3FhpnYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(451199021)(1800799003)(186006)(2616005)(6486002)(6512007)(478600001)(86362001)(31696002)(26005)(36756003)(6506007)(53546011)(41300700001)(316002)(7416002)(3450700001)(5660300002)(8676002)(8936002)(7406005)(38100700002)(4326008)(2906002)(66556008)(66476007)(66946007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXhzTlNjN05ITkkxV1N4L0M2UjR6SUJKUHE4YlhPa29YY25XeGkxNUxkK3Rj?=
 =?utf-8?B?eHdVdHVoUkZ2R3NoR095bDVuWnlOdGRBbUc1VHJUUWVVY3hVMkpZbU51NnRW?=
 =?utf-8?B?N0hBbmpxdzUwamc0dDd3bzgzaXA1UnBUbGJVMFVjeC9mb1lweDNsNzY0UlBh?=
 =?utf-8?B?RkdhaFJOMGNDbkc3b2ZBRmNjY3F4QVl5NDNwbVhhWDUxdThaenJBWjdnNGNu?=
 =?utf-8?B?NEEwaHlOUVJZQ2QzVTczSkhwUk5nTk85K3RMNWNheCtKMzludXhLUTdtYlhI?=
 =?utf-8?B?MVRvQ0ZCQTVkM2NISStaTStER3g2bGdLT3p3RTB0ckt4MndOa1dhZFlXazF3?=
 =?utf-8?B?YW5PbGJEMmdZVUprNlVCU0dSSlU0RUxtYVlxcnI1bk9oY2xheFMxaysrblhK?=
 =?utf-8?B?OFcwYkxtWmJ6UUhQTDNPM1RXRHR5QW5zQjhWVVUyYkR6RS9PdTdodkozRitD?=
 =?utf-8?B?MVFoLzJaTlR2bE1rQmJGVjZyTDlzcUorNDY5TUlXa3hMdmd5WkZqL2sxYTR1?=
 =?utf-8?B?WGl6ZFBYbSttWTVOcElTRHJ6VG5tbHFlQTFQUW5qenFCdDc4eWcyZFNyMzRi?=
 =?utf-8?B?RWtMRUU2aEFyejhuMHpVQVI2L3lOOW1vcENQWkJXV3h2TS9Jb3I5Ym44ZkVz?=
 =?utf-8?B?VDVUeXg4NENYV0JiSmUrVmtSVFg3QzBLT0UrQmdYS2hGeWk0ZU8rdWR0ZVRx?=
 =?utf-8?B?U21wVHhLVWlpdlZ4UW1zS1U1N1paK0JLK0tUTmhuc1FOZDRrdHVIcCtHb2l1?=
 =?utf-8?B?eFI1aFdHbTZNOXgrV2FCTStLeTQ3ZDVqcGxRUkg0TXpaTVN1WHVxeXlXaUxF?=
 =?utf-8?B?SjA4TmwrNmpLNHVRVVVJbDF1Y1g3SC9BSHd6a1dNWER5MkN3R2hjRDZ1YkxX?=
 =?utf-8?B?WEZlVUdVNDdXdEFmRmZPQnNzWlhEaTFnMW5wOTRib2JLQ3dqbGR4T0FMNks0?=
 =?utf-8?B?QVFMRGEzeEJLelBiMzJMWTJvYXQxbGdmN3UzNm5HNWRBYmMrczNDdnl4NXdp?=
 =?utf-8?B?SnA0d1dZWm9RYU1RYUxYSzl0MTRpODlsSWRzZjBreEg4dkNxSkpITkcxK1l1?=
 =?utf-8?B?aW1mMlNlV1RzZ1ovZldFMzhHcDFmckNvTVRuN3h0ZjdKejM2c1pjK3g1Mkhu?=
 =?utf-8?B?QmFzNm1QWVQ4cWpqTENYMWFDRWpUYU85TllBWU9LSVdwV0kxdHByNGVUbTZB?=
 =?utf-8?B?RjlkUk1ENTJpTkMxNHlYcmt1WGpPdmpsRVdsOVU4S2JXQ0hqSnNXSkliSG1v?=
 =?utf-8?B?UTdENnBVK1dHdXNVRlNIcUR4SWF2U2tyeEVaZDcvVk5ETGxHdTRXTjIycXBF?=
 =?utf-8?B?Q1ZiNCtBVkJiZk54LzVCblQ3UTVBcnZaKzBFanhERHkzSnNSek1sZWlBbTR2?=
 =?utf-8?B?aDVkck84RjhzcDdKOTZIa2JTZjlwUnJaZFRHQW5wU3ZjcFlTbHBFL0h6NnBK?=
 =?utf-8?B?NFYxZXlmaUY0clV3ZlRZZDc1ajF4YzhlUnAzSXFJS3haTDAwaVdEYUVDa09H?=
 =?utf-8?B?WUVxbkMwWXFEek5qNDhFZWVQWjlwb0F2RlRJcGRBbkUxT0pjcXVmV2xMa1dB?=
 =?utf-8?B?MXVwaTBPYStZeDJQV1JQcGIyL0lGTDd2ZklUME1YcTJqVjEwa2dzWnAxQ1NL?=
 =?utf-8?B?RzhWd251NEJCNTVJeUNvdGVHaThqVmpjNUIrbklYNlQzeUJaaDFzWithWWdu?=
 =?utf-8?B?RWNqcFBRdERtS3JtbzA1dlRRRlZxR0pBdzJyRzVacWFtYVM0N2hZT1ByRmRY?=
 =?utf-8?B?MU9XdUd4YjFabllFL2tqYXJ6ZHMvM3ZNaHE0VEJoN0cvcEY2bG1sYlJGQWNl?=
 =?utf-8?B?ME9sVzNHbldKYUNpQ0ROd2F2SytBM0FBNlJqN0N4MkxxRVlJRjNQblR0UmY3?=
 =?utf-8?B?ODRlMGJKZ3QyU1luWUJnV1pwdEJaZk5EVStVZFpIZXh1UFRmc2g2dFhvRXZL?=
 =?utf-8?B?bk9DWEpWTWJEMXBVK0JQNWJPcno5dXRzdEI3Q2dlNC9SQ3VQMndoK3haV1VQ?=
 =?utf-8?B?dFY1MVU0cjI4MFZaUytTUWovbzRXR1FIWXJnYUM0dnZpV0h1QkMvb2dDWlRE?=
 =?utf-8?B?MUE3NnhYSFQ3VW1SM2FGNEhlUUJTRWU4U0tFNWFwWlpOYW9xc29ucXErWHNE?=
 =?utf-8?Q?qB2Y=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6fd5240-3940-4a79-e4ae-08db975c9e0f
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 15:40:25.1300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KFxTwFbE4NF6wTXREbKwU7ce2a1jvyk2jRZnSjQCtYkO8B18+414vAOuDA06qmVk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8302
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 8/4/23 15:39, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/19/2023 4:21 PM, Babu Moger wrote:
>> + *	------------------------------------------------------------------
>> + *	--> RFTYPE_INFO
>> + *	--> <info> directory
>> + *		--> RFTYPE_TOP_INFO
>> + *		    Files: last_cmd_status
>> + *
>> + *		--> RFTYPE_MON_INFO
>> + *		--> <L3_MON> directory
>> + *		    Files: max_threshold_occupancy, mon_features,
>> + *		           num_rmids, mbm_total_bytes_config,
>> + *		           mbm_locat_bytes_config
> 
> mbm_locat_bytes_config -> mbm_local_bytes_config

Good catch. Thanks

> 
>> + *
>> + *		--> RFTYPE_CTRL_INFO
>> + *			--> RFTYPE_RES_CACHE
>> + *			--> <L2,L3> directory
> 
> Should this be "directories"?

Yes.

> 
>> + *			    Files: bit_usage, cbm_mask, min_cbm_bits,
>> + *			           num_closids, shareable_bits
> 
> Based on the hierarchy presented the files mentioned here may be expected
> to be associated with RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE.
> For accuracy it may be better to move num_closids one level higher so
> that it is only associated with RFTYPE_CTRL_INFO?
> 
>> + *
>> + *			--> RFTYPE_RES_MB
>> + *			--> <MB,SMBA> directory
> 
> directories?

Yes.

> 
>> + *			    Files: bandwidth_gran, delay_linear,
>> + * 			           min_bandwidth, num_closids,
> 
> Please remove space before tab for a clean checkpatch.pl run.

Sure.
> 
>> + *			           thread_throttle_mode
>> + *
>> + *	base (root) directory structure
> 
> Since "base" refers to more than the root directory I think this can
> just be "base directory structure".

Sure.

> 
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
