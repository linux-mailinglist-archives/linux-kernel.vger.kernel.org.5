Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C23477FE78
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 21:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354677AbjHQTW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 15:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354703AbjHQTWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 15:22:09 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A078735A1;
        Thu, 17 Aug 2023 12:22:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JvVXD8KgQgQeD7SIvgE+jgc4h2s4LkN6m9s+rwbSJbnc65UrGWFUwSC8U3jRWhOIf+j3qir3LQLE7DdFS6H7x5UZagBN3ELAeahTFOWMrdb2jA4dB3KMo1ukTBabglW7Qss1KopBUTe7SEegY8f1WGcyCIPGAL/IIABEVBw/dryFJnqgmZVhgi/yRO5ISvndgIE9aD9EMCyeKFe2kDNu2nizkL5BL9KsA3m1yvQRGlmaJrFardSiyfji1B33Jhw7JEJt5rAVOEDcPe4TcaxIQqijtEjezlgR+4VRA0zvwZ3JbxWLmdTZJecccgjsqFGOFV46jK5ykkEEgFT3Dkl4gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhpTn5vzzQfEhGd61eP4/YzV+zqN8aNk7JLb0OIzOUY=;
 b=HcwvpcEiDAVHabGpwzLqAxlJ5aKDZegbKK4Uw6h/fZa0kmgSg9eyGkNt3n5PN9W1S/nPIE9apiodnm3SBGwjsrDaVpsi9U6pzo3I623NkRKSpeBSnwO5LFkalOjkNt95rY1tuy6sAy9oamx8NDTpvXKPy43w5ItHIJh5qDN2X8T5ff8fbyHiph1WoyeyxKv3tbU5yyM18yrwTI1AClV21837008eAJHfMbBTpFKBIUfjJ6AKJBitN2UQlpSNdIVZbkocYqSeBgZltIlWFE0ffFig4Ge7jX/KkShZP+kQxd/iafEBiJXS6BN1h3zkFUFM4+0S09UayUpmkFtQcS+HGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhpTn5vzzQfEhGd61eP4/YzV+zqN8aNk7JLb0OIzOUY=;
 b=v3Kwoh8u/jQJoeRdFNdJ5Iw3h37cI6Zwt9XYIBK2cGGdl9M3dl7t1t7rWWSrvM2SPZbp7naPq8rUmmLMQSNpjPrPcNklYoAJXqlGnxEa5j+q/USKI6NglYaj2c8dxaemLTb4xnmr/nH9YigpjysyLPsCHiLs0tbZb5w2hFq1AgA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by BL1PR12MB5127.namprd12.prod.outlook.com (2603:10b6:208:31b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 19:21:59 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::93bd:7d4:6a9a:45ad]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::93bd:7d4:6a9a:45ad%6]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 19:21:59 +0000
Message-ID: <938f4939-39ff-26f2-63d8-79bb67d0d45a@amd.com>
Date:   Thu, 17 Aug 2023 14:21:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 4/8] x86/resctrl: Add comments on RFTYPE flags
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
References: <169178429591.1147205.4030367096506551808.stgit@bmoger-ubuntu>
 <169178458575.1147205.16331131496340363561.stgit@bmoger-ubuntu>
 <37986ad0-4519-0f16-c09b-86fcf2f8a763@intel.com>
 <c341b2cf-7ebc-f52b-76ba-77a106dc20fc@amd.com>
 <25c23223-520b-f6ff-ec8f-678e2524c511@intel.com>
 <702d2d05-d37e-c275-ab05-a88cac49a81b@amd.com>
 <6ff03090-bb8b-b4dc-1ab8-1221de8b1358@intel.com>
 <21dbac92-7f9c-12c0-771f-7ef716eb4eaf@amd.com>
 <4279763d-7e73-761d-21e2-513cd60ce2c6@intel.com>
Content-Language: en-US
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <4279763d-7e73-761d-21e2-513cd60ce2c6@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR13CA0027.namprd13.prod.outlook.com
 (2603:10b6:5:bc::40) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|BL1PR12MB5127:EE_
X-MS-Office365-Filtering-Correlation-Id: 30430b88-ed07-4874-6b13-08db9f573a19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5c3QryF8L7s/EztdVs88p0QsQWUL73j2GwgX8ZdZe7f3N5KW4sxujGB+x8ki6WIH6+wfvv5aehBTUxU2P9hWKn7cycKAJtwt+SBr8hd+TWhun7KHwCT6P96n0zQgpgDKqA/yrb4FfagfpOCpWWQwTAjtD5iGBk9R43/Ma3k3LWdTL8HyftL0+9+CvHZmzO3AvvbE6MXaZ0cpKVcoW0Dq7v8nFISovXXlVNez6eTirf9aS3yYKvVpKBrgOhoZiAp9qeSr1Xnnd/jXuhGXCjkG1OMMKCwem3eXFNj6EZbmEBEQ1xsrw6hAcPZJ2KTlbpSe7u5TJKR+A6uQ2DeNu53JlWxUcE1ups11o50i46Z5uezL26tsBUVxtFRpvYFq8SiM7ve/XgH6OxjB7e5y3390Qva5c701iiQsh7PyQooWkB1Re12bcK5DS3gDJ6AO0Ua/0u+nXOivZZLM2ypiTfjuial3UyXgvKyOwudHv9MYUmcXZJ3Wp89dmU4pf7SI+zncS6G/eQUWlHTcWBFTLz8xJQoWvN/7uYCSZZBe68T8DfvrlcAv9qHa42f6KwUPoKMwWf7/JNiP8fsKlscOc5Eot+O0A6XWE1lSClIlkLtUKCFzhs+of7jLeBdLh2Zy7VDPS/NwvJaFsYU4+cnkB+I73g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(136003)(366004)(376002)(451199024)(1800799009)(186009)(31686004)(86362001)(31696002)(36756003)(38100700002)(2616005)(5660300002)(66556008)(478600001)(6506007)(66476007)(66946007)(53546011)(6666004)(316002)(6486002)(26005)(6512007)(4326008)(8676002)(41300700001)(8936002)(7416002)(7406005)(83380400001)(3450700001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmtoOVR3ZW90bkk3NlJSNkVhRkI5QWt2S3prVG8wMlZHSHRyMWpPMnlGRmVX?=
 =?utf-8?B?NlNvQzZ3WVJ2RFdFLzNFRnUrS0NiTG9tMlQ0Q3JoMTFheVoxUThBdjNTL25F?=
 =?utf-8?B?VWhHeVJuRkxiUHpnZ09rOTB5eVBxeU1kRm1NS3lWRUt2Z09DMUthL1BJY1Uw?=
 =?utf-8?B?bjRvdU5meS8wOU4yUnZLaXR5ZUgvc2dvbGk2bi9CcnBsWU5kQzZFWGtUWXor?=
 =?utf-8?B?Ujk0TllKVEZtbWxrT051azFpV0pia1pWWHJxUENYT3lMNVc0bFdQaDdHbUlv?=
 =?utf-8?B?K0lvcllFNmtERXNVL1FFOWx1bk80dExvZlFsTTdDV3IxbzhYS0Jsa3V0aUNt?=
 =?utf-8?B?MDA3RVhGWFh6dVJPYmRsYkN2aE56RWk5OUpVdWFWQ3dHR2pKeVc1UzRWMlQ3?=
 =?utf-8?B?UTlTZDZiQkhSRUdNYTF5VllqWWh4WWxXNXY3R3JyZjUrUlVjWk9tZm5abVhX?=
 =?utf-8?B?ZktPWDUyTElGZzJrMEZ6NGtzZWV6N1FDS1IyRHJjZFpvRHhaL1BSVzllcjNJ?=
 =?utf-8?B?RG5Ka1g3RzFkUk4yTmJzdnY3VkRZWnBQMG05dS9TWkZ5Nm5Venp6U0paQ1pz?=
 =?utf-8?B?NTVWanpFeVRwL3J1ajcxYmRydVpvcEw1TUxFd2NDMjF3VFBYU3luckZCamhW?=
 =?utf-8?B?bTg2aXlnMzlTNEVpMVlZaXZjN29WUGZpbnI3TjJVVlU4MmFDeGxXYWIvZVR5?=
 =?utf-8?B?USs0NVVZRkxEQnVDV2lYNkdFN3QvWVNrdUE2OGphRkM3RFk3MjJJYWVZVTNl?=
 =?utf-8?B?M3hIdWdaVS9XcUxNMlp6elY3eHNZUThGT2JaWS80NGIxM3VETkVIQmN3LzNa?=
 =?utf-8?B?WHk1bG9yWkJCemxMMmxMaWxSY3M5VzZMb1BYNCtvVVF0di9UMmtTZjl2L3Ri?=
 =?utf-8?B?SnZSVmptSHd5RGtaRVFraUhrT1BzTWM3TVpYbzZPdzhrZW9tM1pzblArYzhX?=
 =?utf-8?B?M2VQdW5uNHdrei9kd29sZFZCOW1oUkdjL1UvaVR3Qlgzd0JzYjJOZzQ4UEhk?=
 =?utf-8?B?MDB4UDR6cWFIRVdnNFhVZjhOVUROa2JSeTVycUxsUGxlUllLSUFUSU5rRWJp?=
 =?utf-8?B?dmdseVp1RjhnR21KaU81RkpXT0cySVA0REJoaG5lbjZ0VTIzRWdOTDNENnRF?=
 =?utf-8?B?NGZUUytnZUdZbjBvQWt5UWFiSVdhUjhJM1laWG5KbVVRUThtNFgzMVJjYjN2?=
 =?utf-8?B?ZHpUaHV4TW1ZaXh1YzJ5NzUzYnR1NWp2U0I5MTFaYWhXWWE1aFlLT1dzVVVL?=
 =?utf-8?B?U0dZY3dpNEdWRmdkWDJRSm5yWjlCbkFmOGJBZ0tDRlQvUVQ3VkRkb1cvWERs?=
 =?utf-8?B?TWdsb0MyT3ExWnk0RXlJWEcreThpUDZnbk93aEt0MmdRS2cyMGRxdlJZOEY2?=
 =?utf-8?B?NzN4ajk0dmh3c1BoeVcvVWd6T1lJRFpTN3RUMjRjS29ldGcxZ0N4bWZYNVRi?=
 =?utf-8?B?YzY3OUN0S2FnQVd0Yys1OTdVOVpobjNPOUFGeWlpazdUTnhBU3d1V2ZTUk5H?=
 =?utf-8?B?K3ZnWjRGV1NxOVNsZzdmSWNlSElzQ0p0Y2E2eS9NMXV3TDlGS2Zjc1F0QTFL?=
 =?utf-8?B?Z0JQRUFmOHFrcmYxNlE0N3FwcS81M2hKK1NWSDRZWjJOZ3h2aWU0S3V5Lzg2?=
 =?utf-8?B?MitjNVRQeWlvdUprbDlHSjVRSEdzcXJveUczVkxJSDE0Y0Z6UUlJSE16cGh3?=
 =?utf-8?B?YWtaTHg1NHkxQUc5VUpLQ3RIVStFWnIvUXJyUUhjRWU1akZVNlVXcjI4bGVy?=
 =?utf-8?B?SlZ2U1BPWkRMRTZ1cjd0RjdROE8yTWJoUTBHUkh4RGo0Z25mM09ySHNTVjNY?=
 =?utf-8?B?NzVOZ2VqOEdWbzJab3NacmkyWTRJVUozRWpZK3ErTDd1aEsvNWtRVWd0MmpZ?=
 =?utf-8?B?dkhuczFqYi8yYWZsUzErZUJXeTVaWVl5ak05emYwM1Z6d1ZWcnlrNGFpdXpl?=
 =?utf-8?B?VGRIR0dhZWtPMzZKOXVHY2ZXZ3VlbnFtcXE2UFJwS1hqSklWcVQzSFZ4bFlF?=
 =?utf-8?B?bkQydm1VMjVlTjhKYTBCbm5uNXc5MVVBd3NpRHNmdWFXYXF0ZmJ5MmtiSmZF?=
 =?utf-8?B?RjM5Nk5aT2hhNis4M1N1azkxdWt3SzIrY1lScWJyQmQycGxoWXNBYkJDeUsw?=
 =?utf-8?Q?5bpM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30430b88-ed07-4874-6b13-08db9f573a19
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 19:21:59.0851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yrMtrAJWMNXclLwfZIyKEupNwUJ+bhR7WOvB0jpqZyyHQOsPeiYrjR3fl7e/7rMF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5127
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

On 8/17/23 12:42, Reinette Chatre wrote:
> Hi Babu,
> 
> On 8/17/2023 10:07 AM, Moger, Babu wrote:
>> On 8/17/23 10:37, Reinette Chatre wrote:
>>> On 8/17/2023 7:20 AM, Moger, Babu wrote:
> 
>>>> + *
>>>> + *             --> RFTYPE_MON (Files for all monitoring resources)
>>>> + *                 directory: L3_MON
>>>
>>> Should this not be below RFTYPE_RES_CACHE? 
>>
>> This is kind of odd. I know why you are saying it. Wouldn't it confuse the
>> user? Then, it feels like mon_features and num_rmids don't belong L3_MON.
>>
> 
> This is exactly the confusion that I attempted to highlight in my
> first response to this patch. The same issue is present for
> "num_closids" (which is currently treated differently ... at least
> these need to be consistent). How can it be made obvious that
> these files are present in all resource sub-directories while
> also capturing the hierarchy of the RFTYPE flags? I could not
> find a clear way and that is why I ended up removing the directories
> in my earlier proposal and just stick to documenting the file flags
> that only applies to files anyway. 
> 
> What do you think of something like below? It has duplication
> but may be less confusing while still capturing the flags
> accurately?

Yes. This looks good to me.

> 
> 	--> RFTYPE_MON (Files for all monitoring resources)
> 	    Directory: L3_MON
> 	    Files: mon_features, num_rmids
> 
> 	    --> RFTYPE_RES_CACHE (Files for cache monitoring resources)
> 		Directory: L3_MON
> 		Files: max_threshold_occupancy, mbm_total_bytes_config,
> 		       mbm_local_bytes_config
> 
> 	--> RFTYPE_CTRL (Files for all control resources)
> 	    Directories: L2, L3, MB, SMBA
> 	    File: num_closids
> 
> 	    --> RFTYPE_CTRL (Files for all control resources)
> 		Directories: L2, L3
> 		Files: bit_usage, cbm_mask, min_cbm_bits,
> 		       shareable_bits
> 	
> 	    --> RFTYPE_RES_MB (Files for memory control resources)
> 		Directories: MB, SMBA
> 		Files: bandwidth_gran, delay_linear,
> 		       min_bandwidth, thread_throttle_mode
> 
> 	
>>>> + *                               Files: bit_usage, cbm_mask, min_cbm_bits,
>>>> + *                                      shareable_bits
>>>
>>> The extra indent is not clear to me. Did you do it to represent
>>> a hierarchy or just to line up the ":"?
>>
>> This is to line up with :. I can fix it.
>>
>> Just wondering how do you notice these tabs? My linux diff does not show
>> any difference. Are you using any utilities to see these tabs?
> 
> My editor is configured to visualize tabs and trailing spaces. In
> this case it was just how my email client displayed it though.
> 

ok.
Thanks
Babu Moger
