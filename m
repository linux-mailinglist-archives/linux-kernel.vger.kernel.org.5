Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C33177FC8D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353481AbjHQRIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 13:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353556AbjHQRHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:07:53 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8530C30C5;
        Thu, 17 Aug 2023 10:07:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJ5F5OddCZxhEvtbu3sBLyXCSy9fMk7SE8awDXDOTiIaV9WOjLXDsPuOxXVBM04POAA4T1zSkKm+JO7RKWCxMWun3hifTB7IucPQHR7n9yqDb9cxsWNT8sAOVMAPAVmgg4Am7ba4w7ZZjxyHRCFqm0LY4Xv9eNPm3LaGXRy1VKJBgR09GMIrL62fFXo3DAN9viRA7SJxr9ARqmvjjh9W6EtxTAF0zim/vMr2KIBGMmEvn1pa9UB2xCwcUAh2Mth8WSUqK2U4WAcTMaBUIDENu/M+XbNu6JFz753dn/DdVC36n+2OzgVvU9m6ANqc8lfIpp3hlY5TDbjpyEuMfE6E2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XkhcvEvcxXDMlke38SkGb/K5LOrRKpkTObBOnRhMjTY=;
 b=dbpIwLYtTQwFRbJbP+bO4CoCV7QN1hPorSHkSs8i4v2zhlqyFvjyHSS2I2BNo6q8o6rfXWxnXzCCzuKAW+Mg6pt1W/V9UZ1PHdFq8kM6eib1Ay70/pMbAbIvZdwO1spd2RbR00mWtG5AZX0svQYPzc3nLLxO+Te8OmrxICH3WWat3QAlsj15iiFAwbviwD8gwqVO0AmTI2mH5nBd529p2rYMiPDtHoUE+lMv+dCEXtfxBLYIFwDFreilZCFNvbwAgjetzwE9ETO88BVkSnlI7NRyTOPLWw53fP+ETsOAoh4bvMQHhb9Pk2SAy+iOVIUlqVBA+OTOPSx2L6zuiRE4ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkhcvEvcxXDMlke38SkGb/K5LOrRKpkTObBOnRhMjTY=;
 b=tWggld3xoYNDg+Qvh3iZAf9niNqdTKGaAxJTo6x4uv7+vzZiRnr/0P9YVPSc76bKREDa/Tfqqlq9ldpetjJwx6G08dv1R8G9yoe9bz6iAKwLAZRlQK49+F1QqXTOUKnvAU8OR57BfSU4WCOoTgN+K1C5F0gpv7vZWrwh+WCaayw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by SJ0PR12MB6806.namprd12.prod.outlook.com (2603:10b6:a03:478::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 17:07:48 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::93bd:7d4:6a9a:45ad]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::93bd:7d4:6a9a:45ad%6]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 17:07:48 +0000
Message-ID: <21dbac92-7f9c-12c0-771f-7ef716eb4eaf@amd.com>
Date:   Thu, 17 Aug 2023 12:07:44 -0500
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
 <c341b2cf-7ebc-f52b-76ba-77a106dc20fc@amd.com>
 <25c23223-520b-f6ff-ec8f-678e2524c511@intel.com>
 <702d2d05-d37e-c275-ab05-a88cac49a81b@amd.com>
 <6ff03090-bb8b-b4dc-1ab8-1221de8b1358@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <6ff03090-bb8b-b4dc-1ab8-1221de8b1358@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR07CA0044.namprd07.prod.outlook.com
 (2603:10b6:5:74::21) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|SJ0PR12MB6806:EE_
X-MS-Office365-Filtering-Correlation-Id: 43d76643-ec7f-4de6-9dad-08db9f447b61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wtm7RsBPKVTvaOw9IQwobjFU76plMANUeIAdYVm66IO5YrCEyrAnuVhPH0koMCKfDY9CZ8ERgR6UxBXyFQQ99j4A04GnP/hyBEhPxTsbLIfSJHOsTg95rbkABQQH+ZqIO+1Ya3qYDICyFOS+ocJb7qGaDxy4Q6UMqGJd4tL8/Wc+iQgyMoKnpjHfxr+HCZ2mpinmOgHON63RlBqNXKKlB7YuLv+lmuVHOfYBD3OSckuJbzC5t/YHJS/wiNssRAJPHOavNN5yw0b2Jbw2WXxAhnboqEp0qud44WkDxdzCTvPb6Q0XUsMPMOuycLnJT2KMaGYAfaM75LL5B+GbL134tKJn3936n2c2MTm9pbRDNMuO5+RAj1hvmDmWeu/qkAyqBVgOVppPoXzmasy7k/iA4P/1HMb2CeyMvHDCo7LDxO+Msd1t5bYu2mVg4yCFPSn8VYBIs3evxaL4PbvyUqZUdjFyUQE8Y2hppVvDtK6gPS0kIGG88/3xGDeouWuseMPz/9CAZgLBDEpa3q38tgOdoTaasb+Z32YprBqc+BITealgp2n4cT8GMlLXOocxEx15LICkhWGo6O1oxxTV3ov2byEMRQ6RLkVTLtNCyDRTFnmKyf2uPhyo0QAYkhbwKhQutOkEC272dyvEd2T4vyE15A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199024)(186009)(1800799009)(36756003)(31696002)(86362001)(31686004)(83380400001)(5660300002)(53546011)(8676002)(4326008)(8936002)(2906002)(3450700001)(41300700001)(26005)(6666004)(6506007)(6486002)(2616005)(6512007)(478600001)(7406005)(7416002)(66556008)(66946007)(316002)(66476007)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2J3dlBWdm5KY0tEbmtsTGVJL1NmUXJEL0F2Y3dEbG1CSUM1Zld0Nlp0clNT?=
 =?utf-8?B?bU1YZzI4eDRGL0RLbkxoVndKdkEybEtEblg1d1Fhd0tmZ3NaWHJrbExCZlJT?=
 =?utf-8?B?cDRIcTd0NkdSaGFyVlQ3WUoweEdFQlZFTVd2YTAySzdHRzFyL2pHNWo0NFB6?=
 =?utf-8?B?b3hpbGlFNW4rMlFoK3VyOUlwdG1TSTBzMGltRGtKN25SQllxTHk3QXM0UjZy?=
 =?utf-8?B?RUhGSEUyWUduS3RYbzJ2NXI5SGpRVVZNVkpGRy91dldDNVRlOE9Vb2NhTklU?=
 =?utf-8?B?RXlHWnRoam12UEw4VTNmOHpTWEVXZDNhUlByYUtYQmVtTHYzbGtCZ3NtTFlt?=
 =?utf-8?B?bmhjNmpmc2RwVFRMd293MzRWRWVQT0hZdTAxZTd3TkZMUDlXWXRXV01OdE5N?=
 =?utf-8?B?akpSeVZjVm1uZkppOHJnNFE3Nk9ka3hCOGYxb05ScTl6ajlTWnVmaDJZWWJK?=
 =?utf-8?B?bGFZaHRGYVZOR2xPcE5OVENORmpEV2lwUHZlb1l4TXNOMGRGdkpDdkNnS2RV?=
 =?utf-8?B?UzcydmtDdlFhY2ZrbzlleVN3MzV5SkIvWHVTcitEeTJZdjIxYnhjWEFBbUR2?=
 =?utf-8?B?UFVZcHBGOVVMR2kzWHhCYnhKNEJuOGNtTVFxclplMCtMTms3QktvWjYydXI0?=
 =?utf-8?B?ZFBpcHFzc0dvZytVeXpaa2JIQmJ6QVlBYkxubk92SDJoZTZ6ZlNnYXFneXZZ?=
 =?utf-8?B?K3BTRHZzN205aFJuVDk0M3FqeFVDdkxZSXNYemNGeS9tSWRVUVNIZkVDaXJP?=
 =?utf-8?B?Q2wzb1FIVjJKOGdGNjhFWTdQVVNUVEIzYjRNN2l3TWdmVjYzKzljaFJsZkVV?=
 =?utf-8?B?em9kemRybFhWT2RXNWUweCs2dEd1em9VYk94ODI3NGZ0UVIyajJJUnpKTjdy?=
 =?utf-8?B?WEZuLzV1Y3hBQ0JyWHY0MWI4MmpteXdLdHV4U1JuSkdCZzdTTkxyaDZHQ0Jh?=
 =?utf-8?B?cTBZQjhKeURJSnhqQStZOHZ2K01hVUFjQjY5RG5uYXl6ZjVZSkt1U1JBLytD?=
 =?utf-8?B?b3dubzBrSU5LSGtKYWNMeVl1T1plVzZtTDFtYVovelRoenVIWVZYYUh6VE1L?=
 =?utf-8?B?dmhmVE1tWEZ6Z3QzaytHNDRLaTd2Q25vTDNGTG1odmtFR1NGYkRjc1hEMTkx?=
 =?utf-8?B?TEJNMGdNeS9jdUl1anIzK05mSjBhYjNNY3VWajdEM0FYTWlTMURHbTBMVWYw?=
 =?utf-8?B?T0pPR1ZqY0xPUTNkMFVCRTEwVlpaajdseDV2MlNhSmVmUmdjdzhPTzZvUFlF?=
 =?utf-8?B?VnZqNE5BWmdXUVlwTkhxeVp1b2VvVkk2VEtRZmJweHljdVRkT2pweEw1Mk5K?=
 =?utf-8?B?bEZoL2duMEJjNHFwVkpSYjNIUWhGZG5WZlBqRTJzek5VR2tScE9sR2RScDd1?=
 =?utf-8?B?Rm1zNjFGaE5ERzlVZUM2ak9ucDlkclhxV2xMa2o0ancvQWR0eVQwUHBVK1dM?=
 =?utf-8?B?RXRoVTJ0NnpVSnIvc0d5enFRZDhMTWF1MUZ5RlhFK1VkTTJaaDg5aW80NUJj?=
 =?utf-8?B?ZXU4V0lCRWdGVUdRb2ExZ3c0dVdnL1VFbzNsdXN3cFo5MTVlVEhPRVNrN2tF?=
 =?utf-8?B?aVllekRRT2R6cGdEaDUrcjlSWFcydUNHcEtWWkhDSkVZZ0dDclNFbmsxVEtO?=
 =?utf-8?B?REU0MS9sdWYrb3ZIcW1XYXlOZEtpV1RVakRQQVBVRlpseTNFeHRHL2Z0b21k?=
 =?utf-8?B?UGJzU29jQytoQmJHOVB1L3NTc3NOejc0K2VKbDgrUS9xQVV0WlJUaG92QUp4?=
 =?utf-8?B?eTlOMk5YRW1VSzFuWUVsQXFTelJ0QmgrQ2dzVHdjZFIrNWsvYms1bzFKZlVk?=
 =?utf-8?B?YmxudHF6RmJKa3dpdXJQUEVKN0RaZGh6cm13cjJsWHJaRFpLKzI4RHpuZ1lU?=
 =?utf-8?B?dUl2OFliK1dDL2pMa1pZdHpvZ3ZvYWVxZnBHZHovUDVsQzF4RDUxZCs4bzFo?=
 =?utf-8?B?MXpzZGc1QmRDZTJaYkNSWll2S24vWUV4UzZxZWwrRkFJYTFSamVMbjZaVzlM?=
 =?utf-8?B?WVM5ZVZlN3pXbEgzcXFNNnN1cSsrZnREbGN3eFd1NTNLRjVtQ1dxc2w3cGNz?=
 =?utf-8?B?cGZqcGNJMWdMOWJ5bW9qWWtQdDQxRlgxekNKL0VyRXVlYjFqRmZxbFRDeE9H?=
 =?utf-8?Q?1RMY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43d76643-ec7f-4de6-9dad-08db9f447b61
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 17:07:48.3408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BJSrzKQ5bY6KpvjLqVPrce/fPtqvMQmjHmD44yBWq/xVCAn6gOgaILn8rQ7rcNet
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6806
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

On 8/17/23 10:37, Reinette Chatre wrote:
> Hi Babu,
> 
> On 8/17/2023 7:20 AM, Moger, Babu wrote:
> 
>> Yea. We can go with it. How about adding a little note about directories?
>> That might be easy to compare directory structure on a systems with these
>> flags. Something like this.
> 
> 
> Thank you for improving it.
> 
>> + *
>> + * RESCTRL filesystem has two main components
>> + *     a. info
>> + *     b. base
>> + *
>> + * /sys/fs/resctrl/
>> + *     |
>> + *     --> info (Top level directory named "info". Contains files that
>> + *     |         provide details on control and monitoring resources.)
>> + *     |
>> + *     --> base (Root directory associated with default resource group
>> + *               as well as directories created by user for MON and CTRL
>> + *               groups. Contains files to interact with MON and CTRL
>> + *               groups.)
>> + *
>> + *     Note: resctrl does not use flags for directories. Directories are
>> + *           created based on the resource type. Added directories below
>> + *           for better understanding.
> 
> This is very helpful. How about a more specific "resctrl uses flags for
> files, not for directories. Directories are ..."
> 
Sure.

>> + *
>> + *     info directory structure
>> + *     ------------------------------------------------------------------
>> + *     --> RFTYPE_INFO
>> + *         directory: info
> 
> directory -> Directory ? (for all directory/directories instances)

Sure.

> 
>> + *             --> RFTYPE_TOP (Files in top level of info directory)
>> + *                 Files: last_cmd_status
> 
> (nitpick) Considering the directory vs directories, maybe this can be "File:"
> until more files are added.

Yes.

> 
>> + *
>> + *             --> RFTYPE_MON (Files for all monitoring resources)
>> + *                 directory: L3_MON
> 
> Should this not be below RFTYPE_RES_CACHE? 

This is kind of odd. I know why you are saying it. Wouldn't it confuse the
user? Then, it feels like mon_features and num_rmids don't belong L3_MON.


>> + *                     Files: mon_features, num_rmids
> 
> 
> 
>> + *
>> + *                     --> RFTYPE_RES_CACHE (Files for cache monitoring
>> resources)
>> + *                         Files: max_threshold_occupancy,
>> + *                                mbm_total_bytes_config,
>> + *                                mbm_local_bytes_config
>> + *
>> + *             --> RFTYPE_CTRL (Files for all control resources)
>> + *                 Files: num_closids
> 
> Maybe this should just be "File:" for now?

Sure.

> 
>> + *
>> + *                     --> RFTYPE_RES_CACHE (Files for cache control
>> resources)
>> + *                         directories: L2,L3
> 
> Please add a space after the comma.

Sure

> 
>> + *                               Files: bit_usage, cbm_mask, min_cbm_bits,
>> + *                                      shareable_bits
> 
> The extra indent is not clear to me. Did you do it to represent
> a hierarchy or just to line up the ":"?

This is to line up with :. I can fix it.

Just wondering how do you notice these tabs? My linux diff does not show
any difference. Are you using any utilities to see these tabs?

> 
> 
>> + *
>> + *                     --> RFTYPE_RES_MB (Files for memory control resources)
>> + *                         directories: MB,SMBA
> 
> Space after comma here also.

Sure.

> 
>> + *                               Files: bandwidth_gran, delay_linear,
>> + *                                      min_bandwidth, thread_throttle_mode
>> + *
>> + *     base directory structure
>> + *     ------------------------------------------------------------------
>> + *     --> RFTYPE_BASE (Files common for both MON and CTRL groups)
>> + *         Files: cpus, cpus_list, tasks
>> + *
>> + *             --> RFTYPE_CTRL (Files only for CTRL group)
>> + *                 Files: mode, schemata, size
>>
>>
> 
> Thank you very much. 
> 
> Reinette

-- 
Thanks
Babu Moger
