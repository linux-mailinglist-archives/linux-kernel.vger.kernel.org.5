Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649BD8096A0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 00:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444113AbjLGXeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 18:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLGXeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 18:34:19 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA9710F9;
        Thu,  7 Dec 2023 15:34:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RxTWYkdMxXVsxI6kfA7L+3vNJZvQkuS1jXywcfMGUGadWxu6/4YuuMCK6WoELBOcEi4D/oJWwvo+ioBmCcGDV/3W/RDBSbqQWGVFKFxIswyKHSfMBe+pNiEAUybXzkNcXiBdsY6Yjiunc6fEwZiYLqBUPRUPdc2yfbqjKxa2kU5VoM+eZ1aDlvFkXWhYiXD5ejwzOX5fUG8rRLXsG4a9/UBVMVMnAGC+7Ykhbx6XDPx22kSWubWTaA5XQG/E1y92o+H1j3NJeog8TR65202ld2S26onhEibm2DFRaeklVV2TArFIDABJ4REzZG2e0v44Hwj2xtYYa/j1p02g39/C5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Msi0V2e/hr7QIIc6Jmk/6DujG5EGjCUzsuxAu5jRA4k=;
 b=AhQJ0MoTKdN+Qn4esVMzwRnTWWmHeZrIbr4XdWbrCJoMTnTMSX8eE+phQfFNN+anBQghgUYg9jgAB+pNa6BcD4eTCIpSjk90ycqll7pyc8LQLb+x1JifhZFzr2szib/V9rYWD875O05jJ0yxZeqdwwBsJu8EXNslCFSMJNdS4JNiTyxx6qVnilQM5GuCX66FlpNQDqFcp69n/drfEfuDzoCMACqg0GGvWx44GeE2wQAj9TCbwGIzIvKmnJ6pqJXEjD8F1gvladk18oyMb6oVPBVqwqf36PfBuWwx2t+AtAKFw+70Jwrih1UXH39KhO8h7QWy5lc1YP58Hbzz6dS7kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Msi0V2e/hr7QIIc6Jmk/6DujG5EGjCUzsuxAu5jRA4k=;
 b=ma+rWZj+lrOsZi8tZxf5s818su5ATjZy0YwgKjPrp4s4LTWfio6/dzkTJSaQ+bRA/DfdBp9Pcqer0Ye5kjhBuLAR+qtveAnXR3cfOYEym50oipGW2ylJQuUIc1c6U/xzmuOt2rhjporqBoPBWTSBlB4psq6SmodrQKm3t19oghQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by BL1PR12MB5111.namprd12.prod.outlook.com (2603:10b6:208:31b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Thu, 7 Dec
 2023 23:34:22 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%5]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 23:34:21 +0000
Message-ID: <38421428-84cb-b67e-f3ce-b7a0233e016b@amd.com>
Date:   Thu, 7 Dec 2023 17:34:19 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH 00/15] x86/resctrl : Support AMD QoS RMID Pinning feature
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, babu.moger@amd.com,
        corbet@lwn.net, fenghua.yu@intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
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
 <5ce67d8f-e207-4029-8fb3-0bc7deab1e9f@amd.com>
 <390bbb7b-e709-4290-9bef-eed373e469b2@intel.com>
 <a6338e5d-ab94-8da8-3127-3ce90997bf65@amd.com>
 <c1ccdfa6-ff8a-4602-bb06-f49bf34629ff@intel.com>
From:   "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <c1ccdfa6-ff8a-4602-bb06-f49bf34629ff@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0300.namprd03.prod.outlook.com
 (2603:10b6:5:3ad::35) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|BL1PR12MB5111:EE_
X-MS-Office365-Filtering-Correlation-Id: 730cb20b-ab43-4ab2-38c8-08dbf77d0a2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XelwDzwhNagj3iJAtj4dpcCDaRNAWUCoDMx5DfMVd6TygFQrJyNkAk4Tg/GMfxFWNcjB0hrXL9BZ8VUHSCGaBtkR49fhRX6GPna7E2qyBVQpzpZ+sPqGqzRghilfWxPewmjAiB27MUCdcb8kS8qx9J0cBWxM0PnPYHiNF+BqqhGECutc5hM7kXHMfm7qNIez3/c7GJAl14u5xxs6of1fBzMea9J0LB/O0w5I5n18NMkJXUlXvU7/rV6DMrxKzMPeyzg8e05aHzOgbbaV7BGyw30Q1WAcYp9RWohijbqlEppZAaG7FmrniFU+cJtv7xLKo8j6m56kz60s0qbgnjekIFrTs/beN37J0OOZyRpPrTog7oLIWtOJ6jMHBHnI3O4E/gf8lZQxATzN4zCJ5gGBfPPoyacHmNjYkH0m6ihJ/k4b8B/jeu23ubjReAJ0u5Ub3JHv24Jrqo3QCdpRqDnb7uF2aXvXiuoz7VwBe8nIqPLyEC30vLbz9kuvODFchefYg+C7NwO2qGeMjv3BNqYCElJp/jjuKe/6SdJ22vNPubu1/Oz4Xpt6FsgjVsDaf1sMbUQKdunjjYJDvEp9xw5xVJmpEpjbvRGvAIF2g9oulz8Cz2/xdRJdWAjmdSQKNzqD/lFCG1tJVUonUazd0padnw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(366004)(136003)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(66899024)(36756003)(6506007)(41300700001)(53546011)(6512007)(2616005)(83380400001)(2906002)(316002)(7416002)(66476007)(5660300002)(66946007)(66556008)(110136005)(8936002)(8676002)(4326008)(31696002)(38100700002)(31686004)(478600001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGhTR0RqYnhkYncrcWd5b0JXTHJsU1R6bThGQ3BwZXFCWTZyNXlmSGtHV29R?=
 =?utf-8?B?RGRuV09uK1Q4SjgyYlBaQjBKVlA2N0orTkJ6N0tQVTdVdjBERkd6bDJTd3VR?=
 =?utf-8?B?VGFxQk1QSGdFcHMzSkF5MUw5QWs1bnp0WHBxdmhXTmw3M1EwSUZ3bWNMTjVv?=
 =?utf-8?B?UzJkR3R1VmwvM0NXYlRVY0RwRlFzTTVNSWhEVUd5cmdUeElnTis1eWxkL0E4?=
 =?utf-8?B?cTl0aUZFbXFJcFg4QXpXZHNsSUIzNFBSRGZDcVRMLzhnMDdUa0cwQjc3ckVI?=
 =?utf-8?B?Z3Z5aXJtQ2pOMDRnZ3Bzd3ZUcm5OZGh6R2w4RGUvYndYU1gxS1hzaU14bFhE?=
 =?utf-8?B?R1hzQkVQb2xtU0pKOUU5YzNqeldoZDU5VnhqaHdpWnpkL3ZqeGNhVnpNVURl?=
 =?utf-8?B?R0VvK1NiVTRBeFBEZWdpbm5PSWgvUkV0REhZM0JscDNFOHZQblByc1MrZWZL?=
 =?utf-8?B?c0F1Tmw2b0lraG5PL25HYzE4QXhLVm9iT1FUMEw3SFhYUWM5Mzc5SXRFbnht?=
 =?utf-8?B?NXBtV2lzQ2dDdTZyNEJKYmUrbFhEQ2U2N013RFZ5SkJwZExsQnNkZ0M0ME8x?=
 =?utf-8?B?WnAwd01IOCtYQlg4ZjZjWmRhbENkb043WEhVT3k0cGJuZ2VtVHJRalBKNWJF?=
 =?utf-8?B?SzVGa2hhNGhuSXlGUyswUFJJbnlsN1RGL0hRbW9NUGhSU25PbDRXTGZ1cXph?=
 =?utf-8?B?eWV3OWdGY29ZR3ZJNy9vR2xWaFJ2a1ZlZTFQT3Rzc09ubEt0STREZmpVVm9D?=
 =?utf-8?B?NklENVN5YnhpZ2Y5cDM4NkE4RXBYb1o2NFRxc1dMVk1MNlA4YjBONzBKS2Jk?=
 =?utf-8?B?b0xuTkZ0aHJsY2tNTzBJR1BXMTgwcHNoSng1QXJNelh6QkdDeFlsOW55cTNu?=
 =?utf-8?B?YUU0YlN4Z0llbzA2Tmt0bEJ0dlN4dnhYc0NnS2lxNHVEZFpuOFVneFF3QlJP?=
 =?utf-8?B?b0FPQzFBR0Zyc2Y4Qnc3TTNud0NVZlRXUU9wTWpFb3haV0tMWEJ6YkRtbzFl?=
 =?utf-8?B?Q0ZjM3MzTG1OTFJWd2xKKy93WVpPMWtCeVYzNUJ3QzVvYVRQUmYzd0hCYUhK?=
 =?utf-8?B?Q2RUbUJvUXY3aURtK2lsc01MQy9ub2k5N3VWVmp0WmhSRTJxZ1FUaFRwRGFU?=
 =?utf-8?B?VDNQenNhZVR1aTYrSnpUVS9xNFJHMlkrL1RnQ052VkdZSHFhVFZ4aEtkSHQ2?=
 =?utf-8?B?SGJJTnhjbmxtMytsU1pwMTRwVS91d0Y3a040alhDSDZyMnVQK25heWl0aktY?=
 =?utf-8?B?bXkxOG96Z0VWV3hqUXhCM1VmZDRSTlBQQlZFZkM4TjlDS0Q0aml4VG83OWI1?=
 =?utf-8?B?aHFjeUtYZnByaEhMQVBtc0VqR1Y1R0EvT3NNMWZ4NnJoOU1SV0tmamE1QzhT?=
 =?utf-8?B?Z0lmZWVMRUpKanFyMjlQcXdDQVhnNVRKRnBicDFWTmJ2UnJ6ZisrdzluOHF6?=
 =?utf-8?B?eDNOeTh1NWxKZnNFZGd0c0NWWGc5RWVOdURHbHF6b3V5cHhsTUI3UHZXV3lk?=
 =?utf-8?B?S1d1eUxiTDcxZ3ZDeXNsQlNRaTFBK2I1aHJUc1ArQjQ1Ym9EYS9DeHk0M20v?=
 =?utf-8?B?QXdqQ2VCcVhvc1dETWRyTWhqUzMxbktyRnhwQVFVWUlOZ0FKeTIyRWh5MFRP?=
 =?utf-8?B?cW53WDI0V1N5UHVJUjJvSnBYUm05RzBCM2JxMEIybTZEVlgrcUZXLzB0ZGt6?=
 =?utf-8?B?ZHVGKzUwNFljbWtwSkJBdCs3L1pBejNKVXhVb3lxcFJ5dFRXeWMyRy82SDlS?=
 =?utf-8?B?OWx2TjNtYlZHOW9lek5yZ0dnSjZySmdQNG1Td0ZJVlgxVVduTmhEdmJoT1M0?=
 =?utf-8?B?K0lmK3dhL0hhWk9KTVNvMTdmdjVsWDJRQk5ZSkEvSGZ3Z2lHTzllazY5TGdD?=
 =?utf-8?B?UUU5dFVkbXcvSFhOMkpPOTA1bFI5UkxRSEh1ZXhPY1QzWWUyczE3akVlS3gr?=
 =?utf-8?B?bVJPem1jVTYxQzE1cE1XTzdNOTA5S1k2OXdBNzZZSDN6Q0M2N0hHRnFnSXpJ?=
 =?utf-8?B?T2F4Rnp1N0J4UUFjNEpYZjhrSEo2YzF6SEVQZTl5L3c5QTNKN2JEL0xYR2VU?=
 =?utf-8?B?M3kyMkFYWmc1ZWpUM054TUxDS2FnSjFJY3M1ODZKQzgwVjlqdDNUa29NOVVz?=
 =?utf-8?B?S25tZ1d4K1J3eDdleTZUS0t6WElJUHRLd1lIaFlSSzVQSnJySjUzNmo5NGFK?=
 =?utf-8?Q?zkyCyBKD6xeLrkBzw8Tc6EfsV74yiUF6A/nwP/OMEV+l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 730cb20b-ab43-4ab2-38c8-08dbf77d0a2f
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 23:34:21.8532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TRhRGPUt3XOxvoVzIJ895j2owWDXENQrqMhDnMR1TW1F7JTqPyIYpr/k+Bvk6O6M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5111
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 12/7/2023 5:26 PM, Reinette Chatre wrote:
> Hi Babu,
>
> On 12/7/2023 3:07 PM, Moger, Babu wrote:
>> On 12/7/2023 1:29 PM, Reinette Chatre wrote:
>>> On 12/7/2023 8:12 AM, Moger, Babu wrote:
>>>> On 12/6/23 12:49, Reinette Chatre wrote:
>>>>> On 12/6/2023 7:40 AM, Moger, Babu wrote:
>>>>>> On 12/5/23 17:17, Reinette Chatre wrote:
>>>>>>> On 11/30/2023 4:57 PM, Babu Moger wrote:
>>>>>>>> b. Mount with ABMC support
>>>>>>>>      #umount /sys/fs/resctrl/
>>>>>>>>      #mount  -o abmc -t resctrl resctrl /sys/fs/resctrl/
>>>>>>>>      
>>>>>>> hmmm ... so this requires the user to mount resctrl, determine if the
>>>>>>> feature is supported, unmount resctrl, remount resctrl with feature enabled.
>>>>>>> Could you please elaborate what prevents this feature from being enabled
>>>>>>> without needing to remount resctrl?
>>>>>> Spec says
>>>>>> "Enabling ABMC: ABMC is enabled by setting L3_QOS_EXT_CFG.ABMC_En=1 (see
>>>>>> Figure 19-7). When the state of ABMC_En is changed, it must be changed to
>>>>>> the updated value on all logical processors in the QOS Domain.
>>>>>> Upon transitions of the ABMC_En the following actions take place:
>>>>>> All ABMC assignable bandwidth counters are reset to 0.
>>>>>> The L3 default mode bandwidth counters are reset to 0.
>>>>>> The L3_QOS_ABMC_CFG MSR is reset to 0."
>>>>>>
>>>>>> So, all the monitoring group counters will be reset.
>>>>>>
>>>>>> It is technically possible to enable without remount. But ABMC mode
>>>>>> requires few new files(in each group) which I added when mounted with "-o
>>>>>> abmc". Thought it is a better option.
>>>>>>
>>>>>> Otherwise we need to add these files when ABMC is supported(not when
>>>>>> enabled). Need to add another file in /sys/fs/resctrl/info/L3_MON to
>>>>>> enable the feature on the fly.
>>>>>>
>>>>>> Both are acceptable options. Any thoughts?
>>>>> The new resctrl files in info/ could always be present. For example,
>>>>> user space may want to know how many counters are available before
>>>>> enabling the feature.
>>>>>
>>>>> It is not yet obvious to me that this feature requires new files
>>>>> in monitor groups.
>>>> There are two MBM events(total and local) in each group.
>>>> We should provide an interface to assign each event independently.
>>>> User can assign only one event in a group. We should also provide an
>>>> option assign both the events in the group. This needs to be done at
>>>> resctrl group level.
>>> Understood. I would like to start by considering how (if at all) existing
>>> files may be used, thus my example of using mbm_total_bytes, before adding
>>> more files.
>>>
>>>
>>> ...
>>>
>>>>>>>>      #cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
>>>>>>>>      Unavailable
>>>>>>> I believe that "Unavailable" already has an accepted meaning within current
>>>>>>> interface and is associated with temporary failure. Even the AMD spec states "This
>>>>>>> is generally a temporary condition and subsequent reads may succeed". In the
>>>>>>> scenario above there is no chance that this counter would produce a value later.
>>>>>>> I do not think it is ideal to overload existing interface with different meanings
>>>>>>> associated with a new hardware specific feature ... something like "Disabled" seems
>>>>>>> more appropriate.
>>>>>> Hardware still reports it as unavailable. Also, there are some error cases
>>>>>> hardware can report unavailable. We may not be able to differentiate that.
>>>>> This highlights that this resctrl feature is currently latched to AMD's
>>>>> ABMC. I do not think we should require that this resctrl feature is backed
>>>>> by hardware that can support reads of counters that are disabled. A counter
>>>>> read really only needs to be sent to hardware if it is enabled.
>>>>>
>>>>>>> Considering this we may even consider using these files themselves as a
>>>>>>> way to enable the counters if they are disabled. For example, just
>>>>>>> "echo 1 > /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes" can be used
>>>>>> I am not sure about this. This is specific to domain 0. This group can
>>>>>> have cpus from multiple domains. I think we should have the interface for
>>>>>> all the domains(not for specific domain).
>>>>> Are the ABMC registers not per CPU? This is unclear to me at this time
>>>>> since changelog of patch #13 states it is per-CPU but yet the code
>>>>> uses smp_call_function_any().
>>>> Here are the clarifications from hardware engineer about this.
>>>>
>>>> # While configuring the counter, should we have to write (L3_QOS_ABMC_CFG)
>>>> on all the logical processors in a domain?
>>>>
>>>> No.  In order to configure a specific counter, you only need to write it
>>>> on a  single logical processor in a domain.  Configuring the actual ABMC
>>>> counter is a side-effect of the write to this register.  And the actual
>>>> ABMC counter configuration is a  global state.
>>>>
>>>> "Each logical processor implements a separate copy of these registers"
>>>> identifies that if you write a 5 to L3_QOS_ABMC_CFG on C0T0, you will not
>>>> read a 5 from the L3_QOS_ABMC_CFG register on C1T0.
>>> Thank you for this information. Would reading L3_QOS_ABMC_DSC register on
>>> C1T0 return the configuration written to L3_QOS_ABMC_CFG on C0T0 ?
>> Yes. Because the counter counter configuration is global. Reading L3_QOS_ABMC_DSC will return the configuration of the counter specified by
>>
>> QOS_ABMC_CFG[CtrID].
>
> To confirm, when you say "global" you mean within a domain?

Yes. That is correct.


>
>>> Even so, you do confirm that the counter configuration is per domain. If I
>>> understand correctly the implementation in this series assumes the counters
>>> are programmed identically on all domains, but theoretically the system can support
>>> domains with different counter configurations. For example, if a resource group
>>> is limited to CPUs in one domain it would be unnecessary to consume the other
>>> domain's counters.
>> Yes. It is programmed on all the domains. Separating the domain
>> configuration will require more changes. I am not planning to address
>> in this series.
> That may be ok. The priority is to consider how users want to interact with this
> feature and create a suitable interface to support this. This version may not
> separate domain configuration, but we do not want to create an the interface that
> prevents such an enhancement in the future. Especially since it is already known
> that hardware supports it.

Yes. Understood.

Thanks

Babu

