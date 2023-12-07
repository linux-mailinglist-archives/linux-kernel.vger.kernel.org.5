Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AECED809669
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 00:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjLGXHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 18:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjLGXHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 18:07:17 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA0B93;
        Thu,  7 Dec 2023 15:07:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jngMModldTECStukSjRaivNOccInHdB0YsJvntY/9jwRhTtfZo2xe+hWL0k7aXurvC1CzDf1j19T5ZDBZfK8DRlfxeDZLuM9eW/jpa2dG9KYzloKc6hHY3iLh1UtGut2srdBkooq8+PWs68op8z0A/CcualVRL6jZQ8FsUVmM4Eo3XbaUkF3B9r7vkKZBO59/JqTf+XiQ5/yWkyDUeSSlS9lIrbz8D3Kvg5vEiUajoz5LAEfF7GMe7TvnuqYSp5ekxG7WNL+fSBEZVFO5o4J9lFywtv2FogfNf5ZuOUiE9McEosN6TzthwDuG1KoukFaDjFwjN8MGypoR997mmPnyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aUmvVPx8RepS3Xvyl2gdVXatvVIBFmeXyiIJ8/AdBh4=;
 b=EIXvFWPPJdssDfB/67Ts4wPhQX72o4+jHqw51j7iFGQJ1zG9A6N5Lx19nV8ye0bCE7RYSeStumlOCZT+TJ9enddyjFDScTU814i1fo6nVHCWfMAuEgX9oUrM2sqn3Q3B1+ftCeAVs8113f6VmO8mlhuv3jNI4N3zSzEkc5chNyU1ysilaU/9+DHuO/+TtcHWE3vTk9KZzh106QG3YG2sR6dbe+geukaC3vNYtrWUo6gDUUdoRJ/OeFpYXFG+WPFZfkA+2pyDuoaMKoTqLiCJn+7bPWDizMqNrDt0LbjR/N+yoLjauFuTdqPctUHfIflfn1Md9dOloaHJqGKi8nQIJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUmvVPx8RepS3Xvyl2gdVXatvVIBFmeXyiIJ8/AdBh4=;
 b=oRrAA138zXtABZ85EFBMtJC6KMl83bKR+B74m81gWYBTkHf/K9+CFLq0gY99JjD8gn5DnrvENDAr4Ar47gpUlJL+mqBQIbJ7l9xyYj+xhed3OyKDOtvZ7Aw738D15iDWe3BOr4iMUpUvD9KI7Q1rKkY3Z6OO4qhEszMrMR4RMU4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by LV8PR12MB9405.namprd12.prod.outlook.com (2603:10b6:408:1fa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 23:07:18 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%5]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 23:07:18 +0000
Message-ID: <a6338e5d-ab94-8da8-3127-3ce90997bf65@amd.com>
Date:   Thu, 7 Dec 2023 17:07:15 -0600
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
From:   "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <390bbb7b-e709-4290-9bef-eed373e469b2@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0160.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::15) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|LV8PR12MB9405:EE_
X-MS-Office365-Filtering-Correlation-Id: aaccb776-fcd1-4532-ad92-08dbf779428b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G6W8qeicYllshRV5t4wd+c0WmaCLXafGEd7GFd4I2rRPfhqtScceuqI4JaT9WV1Wi7oFuaEAdrqOVWXYmaHOgFro3kgF3crDJWqRUf3/7d636aqg7ASsPXRtSPkMhgP8xEaIWFx8e+mzrMIzskt7uyxEAPlQw7/e0nSvLlFW26sj+aa6njt+aCBHDTqmOW3Nq0o/4JIU6fOybI23qahManOeoThNPJ9G1U58ByWnB14KTHQbaOCzoStRhqV/3novISxW4AK4rATShJY77lwnOo5TAb1q8jG1JrFtK0CL3Vwbqz6UuSqY6OfD+dLIK4oo/Y5WjWmLh8Sb4Vz41BA1o14SHvDrBmfvEoYXiaEIlOMqNXuiMuRgGYBAkt6bkxXjnVWFtvXXTlwjDpW6VUz0b714Qs4LZ37QDIHnFwkZBaiIiY7FcMmXUgC5E4rFxGDsXQhfCGsYzew0JnrKPtgbrDPj6P3ZBI8pwZU9Lh39uHdltUk3MbIlM81rI5oZ9vZzA+JobX2WIyiMtEjRqe93996gcoOi+x6uLZbRBNSJO1CMRgQXCDfUQiDhAyxJfIVe/JjL1dzilwOUnUTFK21KIeZ6N9/jt5NC7Ef9tSEpsbNXgNdvQqgh3WlESbBqbskYW6K5FhhRUOeXl4xagveOww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(136003)(396003)(39860400002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(6666004)(6506007)(2616005)(38100700002)(41300700001)(53546011)(6512007)(83380400001)(66946007)(66556008)(66476007)(110136005)(316002)(478600001)(6486002)(31686004)(7416002)(5660300002)(2906002)(4326008)(31696002)(8936002)(8676002)(36756003)(66899024)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUFQcW5KaUZ6aEFOejJGY0hkM2FlTlF2M3RYdUJwYnIrUGIvVWR4cXRIem9m?=
 =?utf-8?B?dFFybUdQaW9tOFVFaUdpUFN6RHpUUUlGUG1ReklyWi9rQ3dOenV5VlljaWY2?=
 =?utf-8?B?Uy9ZTkdKb3FFY2dyN2FFTkUxbkJ5d3hYRzkwQXVDbWR2MElrSGEyTUJOVFRX?=
 =?utf-8?B?eXNOSmN1blArRURyNUdRWlEvREMrWDQzcjRGcnRRajlZTk9DSlZXUWMreDdt?=
 =?utf-8?B?ODJBWEgyOWg0bEZUNDhyUGpITHE0ZXREMk1IcmluNVdtOWphZ0RNTkR5T0pv?=
 =?utf-8?B?bWlWVnhqVnN1VXlUU3JEb2pBNjBkdTVZREN3cDNKaGhMUmlkYVdiNHlycXJC?=
 =?utf-8?B?eHlFWGNqQ1Vkc0FHVHVlOS8za1AyR0QvTUhzTktyVkhJYzBxYlFKNXVhT3VP?=
 =?utf-8?B?K2pjVlN4LzZ5SHgwZ3NOUFVNR2Y1c0IvUllvd3NFVUE2dk5CN0hCc0ZzQ0R4?=
 =?utf-8?B?MERnSUExaG4rVjBqcGxNOCtkdkdFVi9XaTdlM2NkNEZiMkk2TXBoaTlmODZE?=
 =?utf-8?B?YmY5eTZIUUtEQkJObEtaQkZTK0oyc0R0ckw5d2FaV09MM0pCczB6RGtRUHJ2?=
 =?utf-8?B?VjRWaGJ4OWZoUWtNTGcrL2RGMnNXeURoaTZUOVVOdS90Y0pDUG1kZW9aQmd2?=
 =?utf-8?B?OTlWMGNUZ0QxdGlXUHlhVnVDZXQ1NlIyaERXQk9mTU9FUUh1N2k1Vi9PM3ow?=
 =?utf-8?B?RXRSSW9MVHFTdVh5b3FIQlRTTzVlVWVPSEFld09CZDViMHpSa2c3aGlQTnZH?=
 =?utf-8?B?OVNwcEtUVjNSYUFBWUFQNzV3TEc2M3JlUVkzbnBLM0lHNDdRU0tVTUdMK1JI?=
 =?utf-8?B?a0lRVHJET1lYaStDL2EraXY1UHpLVU0xZ3gzdmNZZWtTYjlURFYrbmh0TEZx?=
 =?utf-8?B?ZkJEeTJMQUJxQS84ejZjTmJrWjlIcVB3c1ZDdW4zRWVwbWRYSDI5ZXZ2Q0E5?=
 =?utf-8?B?UlpTMHlEek9tQ1daTVBkWGdhR1Evdm9aVjhZSmZ0YjlRVnEzWXdUa1BVR29w?=
 =?utf-8?B?YVNYVU9meVBDK2RJb3c4VmlmWjdRRUpsUE1HdTYxWUtyc0lodkNEdXIxS3kz?=
 =?utf-8?B?d1dLdDljZ2dEZk92N1lHYnBScnllYTgrRlVZMnRpM2pUUEo0VWI2ZG1QaXNn?=
 =?utf-8?B?NzJ4QS9ncHNUTnhjeVBNOG1wWi9oeEhXUzlCTWRWbC9iaHM1M05PenpUejAy?=
 =?utf-8?B?QTZiTzZYUEFxZmZGMG9lckE0WWQwQ3drZzZWM2s2WWpEVU9GQUFUVkdoeDFq?=
 =?utf-8?B?dGt1a1YvMVNnRDVrYVZ2azd5bVp4azBPbS9WOTZRbVo5eU90dlJ2Yk5ha3Ez?=
 =?utf-8?B?ckJJQ2owc3B3YTU2Zi84K0ZYMVltaWJkV21HVmRzZituUmVmenhhTFRjMXRV?=
 =?utf-8?B?WFFKamF5bEV6d3luandXMHRxWFNoUCtjaDVmL3dwMTU1RGFDeHRnYmJOamg4?=
 =?utf-8?B?Q2plRUxjTHRydWlLQVNvQU5Ra0I0RFhPZGxmUlE0WFN0bllHbTFvSnNCNFRY?=
 =?utf-8?B?TnFmdU1vK0lzSXZIMDFwYWpFcWtJdnhTUzZLM0xpRFNMcE5OVGo5cGEwenE4?=
 =?utf-8?B?YXBqUjhCZjd2VzRMTlJWMld2R3ZCWFVSWnlOSUZ5NFU5YzVpYkZkMUZVMGNl?=
 =?utf-8?B?UERERlVlYVdkMCs0ZDhzdERkNG9hWDN4OXlHVVFWbnRObVRHRVdTY2JTL0Fa?=
 =?utf-8?B?dU13UWpJUXRuMWdMY0E4dUpKQzYwMUtPNk5acUk1T0ZReWRkUSs1RUZvaElo?=
 =?utf-8?B?THpvMVRTemVLOCtTaTdVYjhBQ3RlS1ZHV2QrRVllL2xoMUtoWGRTckprclZU?=
 =?utf-8?B?bUJTSzNLbGhOQXIvc2M3U0RDS2k3YlJCS1AxMTJEaC80ZC85RTBRd0pHLyta?=
 =?utf-8?B?YzRyVHRRbE10SzJBdys1c01HM2xuUXd5QXI5TlJDMGkrT3JDQjVDOGFJYloz?=
 =?utf-8?B?U0FucWJEc3ZqYjB4TjBrSUcxblU2Z0hsZDltVUtpU0ZlWTgxUnhiNFpqdEJ5?=
 =?utf-8?B?T2RvY0JiV3FqZ3FUNWNYQTJUQ2x2STMvSTlsQ2drVWZEVDkrMFJFZ01jSW91?=
 =?utf-8?B?Z2c3WjZ6QVZYcEE2bEVSVmlxRVpLeThwV1o4NVZqeXJ0R014YzN2eUt1M3Zp?=
 =?utf-8?B?anZBckY3RFRQMDYwQWY1LzFXb3JtN2Z0cnBOM2pqSFJSOGVJUHA1cm82OFpZ?=
 =?utf-8?Q?6+Jqlz6J7mm0wTt+2WdDBYPsOn+4omyhmfsBOHJbFYx9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaccb776-fcd1-4532-ad92-08dbf779428b
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 23:07:18.4283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sD3d6rTPQtRERT+YZ7WltAtTeHg82katGTscLcpUva/cRCWUbiZss8J27UFf8U0q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9405
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

On 12/7/2023 1:29 PM, Reinette Chatre wrote:
> Hi Babu,
>
> On 12/7/2023 8:12 AM, Moger, Babu wrote:
>> On 12/6/23 12:49, Reinette Chatre wrote:
>>> On 12/6/2023 7:40 AM, Moger, Babu wrote:
>>>> On 12/5/23 17:17, Reinette Chatre wrote:
>>>>> On 11/30/2023 4:57 PM, Babu Moger wrote:
>
>>>>>> b. Mount with ABMC support
>>>>>> 	#umount /sys/fs/resctrl/
>>>>>> 	#mount  -o abmc -t resctrl resctrl /sys/fs/resctrl/
>>>>>> 	
>>>>> hmmm ... so this requires the user to mount resctrl, determine if the
>>>>> feature is supported, unmount resctrl, remount resctrl with feature enabled.
>>>>> Could you please elaborate what prevents this feature from being enabled
>>>>> without needing to remount resctrl?
>>>> Spec says
>>>> "Enabling ABMC: ABMC is enabled by setting L3_QOS_EXT_CFG.ABMC_En=1 (see
>>>> Figure 19-7). When the state of ABMC_En is changed, it must be changed to
>>>> the updated value on all logical processors in the QOS Domain.
>>>> Upon transitions of the ABMC_En the following actions take place:
>>>> All ABMC assignable bandwidth counters are reset to 0.
>>>> The L3 default mode bandwidth counters are reset to 0.
>>>> The L3_QOS_ABMC_CFG MSR is reset to 0."
>>>>
>>>> So, all the monitoring group counters will be reset.
>>>>
>>>> It is technically possible to enable without remount. But ABMC mode
>>>> requires few new files(in each group) which I added when mounted with "-o
>>>> abmc". Thought it is a better option.
>>>>
>>>> Otherwise we need to add these files when ABMC is supported(not when
>>>> enabled). Need to add another file in /sys/fs/resctrl/info/L3_MON to
>>>> enable the feature on the fly.
>>>>
>>>> Both are acceptable options. Any thoughts?
>>> The new resctrl files in info/ could always be present. For example,
>>> user space may want to know how many counters are available before
>>> enabling the feature.
>>>
>>> It is not yet obvious to me that this feature requires new files
>>> in monitor groups.
>> There are two MBM events(total and local) in each group.
>> We should provide an interface to assign each event independently.
>> User can assign only one event in a group. We should also provide an
>> option assign both the events in the group. This needs to be done at
>> resctrl group level.
> Understood. I would like to start by considering how (if at all) existing
> files may be used, thus my example of using mbm_total_bytes, before adding
> more files.
>
>
> ...
>
>>>>>> 	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
>>>>>> 	Unavailable
>>>>> I believe that "Unavailable" already has an accepted meaning within current
>>>>> interface and is associated with temporary failure. Even the AMD spec states "This
>>>>> is generally a temporary condition and subsequent reads may succeed". In the
>>>>> scenario above there is no chance that this counter would produce a value later.
>>>>> I do not think it is ideal to overload existing interface with different meanings
>>>>> associated with a new hardware specific feature ... something like "Disabled" seems
>>>>> more appropriate.
>>>> Hardware still reports it as unavailable. Also, there are some error cases
>>>> hardware can report unavailable. We may not be able to differentiate that.
>>> This highlights that this resctrl feature is currently latched to AMD's
>>> ABMC. I do not think we should require that this resctrl feature is backed
>>> by hardware that can support reads of counters that are disabled. A counter
>>> read really only needs to be sent to hardware if it is enabled.
>>>
>>>>> Considering this we may even consider using these files themselves as a
>>>>> way to enable the counters if they are disabled. For example, just
>>>>> "echo 1 > /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes" can be used
>>>> I am not sure about this. This is specific to domain 0. This group can
>>>> have cpus from multiple domains. I think we should have the interface for
>>>> all the domains(not for specific domain).
>>> Are the ABMC registers not per CPU? This is unclear to me at this time
>>> since changelog of patch #13 states it is per-CPU but yet the code
>>> uses smp_call_function_any().
>> Here are the clarifications from hardware engineer about this.
>>
>> # While configuring the counter, should we have to write (L3_QOS_ABMC_CFG)
>> on all the logical processors in a domain?
>>
>> No.  In order to configure a specific counter, you only need to write it
>> on a  single logical processor in a domain.  Configuring the actual ABMC
>> counter is a side-effect of the write to this register.  And the actual
>> ABMC counter configuration is a  global state.
>>
>> "Each logical processor implements a separate copy of these registers"
>> identifies that if you write a 5 to L3_QOS_ABMC_CFG on C0T0, you will not
>> read a 5 from the L3_QOS_ABMC_CFG register on C1T0.
> Thank you for this information. Would reading L3_QOS_ABMC_DSC register on
> C1T0 return the configuration written to L3_QOS_ABMC_CFG on C0T0 ?

Yes. Because the counter counter configuration is global. Reading 
L3_QOS_ABMC_DSC will return the configuration of the counter specified by

QOS_ABMC_CFG[CtrID].

>
> Even so, you do confirm that the counter configuration is per domain. If I
> understand correctly the implementation in this series assumes the counters
> are programmed identically on all domains, but theoretically the system can support
> domains with different counter configurations. For example, if a resource group
> is limited to CPUs in one domain it would be unnecessary to consume the other
> domain's counters.
Yes. It is programmed on all the domains. Separating the domain 
configuration will require more changes. I am not planning to address in 
this series.
>
> This also ties into what this feature may morph into when considering the
> non-ABMC AMD hardware needing similar interface as well as MPAM. I understand
> for MPAM that resources are required for a counter but I do not know their
> scope.
>
> Reinette
