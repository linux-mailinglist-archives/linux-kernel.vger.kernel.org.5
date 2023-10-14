Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3B37C972F
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 01:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbjJNXHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 19:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjJNXHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 19:07:12 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2063.outbound.protection.outlook.com [40.107.212.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C71B7;
        Sat, 14 Oct 2023 16:07:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9q7keitzIX3/Oz+iKDfHUJaQAAkKmOQvEvfeqiB3cQqki8VR/NScffrIOZIBiUnpIQOMErf3WTO9mEhI6tOKNEXjjGLJzlesLl7N5eOuln71pmS/3oRcg21SCP/Ud6+DLqhLZRWc76wWUFUwtC2DhrEYPdHWkTjqfoa1jKpCMo+/y7y6fnb5Z07IS+v8Fhhl7+SFjhyTCmgmja2n2YCKlLS9GLdIA9HHfNXJ92klaqbA3aWaRFPKWpL9rMZBeGZR2zlyHnnHmAG7ld7o1/POTh8RAABi7DssBSjGt0ymc6cSO3BBAX6kbZA5HiKb/TJJcKm9Ds1ObVyWnh/ZPX6Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCMaOLX6+lY1oZyl52fXrrghsiwiJQZMnAHM4BRbGRg=;
 b=lPxpK+cDt1a+K8vl4PTFhPnHMsXbPC0exPdYWaBk3TqZmPJ0rQx1GTg5/9VB66is6g5pZJJ8I7ljfULR4OxOafj0HHh34M15PT7o/crwJJxdPwcNfMAXNZ7QOjX5MtcaJopkS+lrh6TxNSBEIcilsazFAxb4Ba8OtIagFh9GLuUOg+Cr9HVREhNd3H2eKVEdkh2vqEbJCaeNXQGMRjn6LgjMLp1c1sELYZaqbINlLYZVYQE0mfZuqFdCkFuZEM3K6/5C2vob0PNR4CoK01Yxw4JO6LQg/CtTAwgTB8uTYsNdwz2OXfEGwhLpynfrCHR/BAfRtMFsVQw155+AVspuOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCMaOLX6+lY1oZyl52fXrrghsiwiJQZMnAHM4BRbGRg=;
 b=nM0b5nq0SEQv3cCb9LkngA8SdPMwBOB56ci3NlcX/5LkqQrQlLn56KYtdZ1Aa8+9FpILDmi9wySGJw4/Rd56Bgz7gA/FBdrZreBz3cQmuAhuWzdDpwOzr7HLA9ewFmm4n9SCLhpB5TtulwnI62GMNWUEKhs5jGfCGJxrZGwQqUk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by LV2PR12MB5797.namprd12.prod.outlook.com (2603:10b6:408:17b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Sat, 14 Oct
 2023 23:07:06 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39%6]) with mapi id 15.20.6863.043; Sat, 14 Oct 2023
 23:07:05 +0000
Content-Type: multipart/mixed; boundary="------------nbwd5hDp6EnjQ4PfqpmuVVV2"
Message-ID: <299778a6-5ea0-c70d-54d6-1ecdc1b417d6@amd.com>
Date:   Sat, 14 Oct 2023 18:06:59 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v13 04/10] x86/resctrl: Add comments on RFTYPE flags
 hierarchy
Content-Language: en-US
From:   "Moger, Babu" <bmoger@amd.com>
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
 <0acbb031-a84e-1cbc-0857-f087b07a9056@amd.com>
In-Reply-To: <0acbb031-a84e-1cbc-0857-f087b07a9056@amd.com>
X-ClientProxiedBy: SA1PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::6) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|LV2PR12MB5797:EE_
X-MS-Office365-Filtering-Correlation-Id: 62e337ac-0a80-4d42-c609-08dbcd0a4835
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZHmcaStAPrtHJM5CzSACXtIfOvm8W53b3l6kgE+mMaHuj7yfhAMVZb5OaEJVFstirn1tugoJOatJljF27Hkth4El6ZmxfL7lLiRl8CGdH4K3LSFud1JldQQLzCu4PU9KVF2VCZdoMM0QItyZ6AQQrCDNlHWmefrSZ/eD7PLHdb5/oYzWdipc0lOR8xoCOGYHzVN/q18xU2lmmkitrFyG/g9Cvqr37jDfUik6F3Q/EgaxqVk5ljCnJbmryVohbDdq55QRHYVhrLamlLS7tnpFm9/Dalcs+l7rK7a8yvMGKVut7YYXAt2qlRb6rEZD/znfYc0/Pbz0WX722wRQNx4fS/2csr1Rri7r9qM65yr6YjQo2yHY/J45jvyG6QCrs94WaCuR46ar1CEow0QwdGvBi9wVpXfU8CBuB1w07QE8HSfOmUydEC8hAyQqjDpskIWaCF6IH5aUED06Jo10EtYjS4j1xi5NT5pgz8cT++ZV3tti+8jF/ODHIEmJUZvhMSPr8ZVqh1AcZOhcdjGjpoa0IMn8VJgkCQccAM4pvGPXdwDuQtmwWCaN+O8Z/meE0ceKPNdWeMnAuJZ2w8HoQi9A1ZjTu0LLWIRbTAmSvYrrpSrgJnq2g1pU6mMREQAw3NtlNQvcEc6ItYQRHRR7V8jCTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(136003)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(6666004)(110136005)(8936002)(66476007)(66556008)(38100700002)(66946007)(316002)(478600001)(2616005)(26005)(33964004)(53546011)(6506007)(6512007)(6486002)(8676002)(4326008)(7406005)(7416002)(235185007)(36756003)(2906002)(5660300002)(31696002)(41300700001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUJ1SEF2YzYvNmt0NXR6UDF4NXU4cVk4Mnd6ZFdlcEF2OVVOVmNrVThEN1M3?=
 =?utf-8?B?NVpaK2dUS1NmakkzUDV5ZUZRaFFzM0dhNDVzQ0xISmIwTDkzdU4zaVBkVU5V?=
 =?utf-8?B?cnE1OVF6TUtZT3B2ZGJmaW9ZM1NhTnpRZ1RwR3gyTTdBWDdoTmdyQ1ZmMTc1?=
 =?utf-8?B?UVF6T3pFM0RDY1d0SG9qaGpQY1FmZmtGTmwzZkU2dFphN1lUbWtuaHFzbXkw?=
 =?utf-8?B?Y3ZxeXVldEZkVjUxWURGQjRTNmVTS2wveXBIdHBocVVPM05xZjV2YXVQejc1?=
 =?utf-8?B?cHBFZUdZMm1ZdDFnVTI0UC9EZXR3UXRPVlFjejY2dmI5bjFCam9xcE9EK3dK?=
 =?utf-8?B?Qk9LakNkU0dFdFVXY25IVGRITXJZMDF5Z0JJQzdiSmxtdEFLcFo4MzhoNjgy?=
 =?utf-8?B?MWwwTzdsMlB2TFpJRGtsaHFBUHozaW9PVEdMN2RMZ3Z0SThoOS95UEZUSEx5?=
 =?utf-8?B?V0lRbGNrMnQ2aWRIdUdiVnQ4Um5td29DMWhWcUhUdDlYYnpkSktobks3elJm?=
 =?utf-8?B?cHhyT2tCS21naEdoWTRjQVU0N3BhZlpJcXlWcDVvU3k4Z0V0dGNlWlI1aGVF?=
 =?utf-8?B?VnV3NnJHbUVkQzFqT0RHRkRDektqamJrN1NMRVN5dGxzM2M1THAzN3hCQTE1?=
 =?utf-8?B?VForQUI3S25Odm0xQmJtMW5TNmx4Vm85YVAweEJKa3gzTzFRZys5RmpYWldI?=
 =?utf-8?B?UHA4QkNsV3Y3eHEyVW5EeDY2ZnFCMnMwRHNTbWZBZFQ1SnhDZVUvL05tL0pr?=
 =?utf-8?B?eG5USnl5cGM4QVZMZDhKNmNaM25mVm9BWnJIcmN0S2NJQUI0dDVNbmpiS1Ru?=
 =?utf-8?B?SjgwUTdBS0s5RzBoQTRRcFNEejRiOEorbEJZRVRNUTlSQjNZNGE2TStPeGVq?=
 =?utf-8?B?dnhMcWxibEZGek1yQVZIQSs5RG8valZGZnk5aVA2azJOK1JRa1Y4aEw1K3B6?=
 =?utf-8?B?WDdzOTRHc3V0QnJ4NmlLSmhnZ2NadzQ5UFlOSXAzUnlFcUgvTUl3bWtzYnUz?=
 =?utf-8?B?ZVVwZUcrRVByY0NIVE4wTEZTWFZrdVpXa0VTUFcrbGtzRlpzSlViVUxTL3hE?=
 =?utf-8?B?eEd5U3VramcrZU1ZV3FGU0xDcVR3K2tjcDRQbHN4Vzd0bjVRdUM4QThOYUxz?=
 =?utf-8?B?ZHcrRkRERTBKNUVoNktDeUN6T05iOG9ZU2paM0E2OUhGWjhMVytFSksrUW5H?=
 =?utf-8?B?Vk1qRE4xby9pMC9rdkNrOHVMRG85Q0F2ZWxobmFjVXo5OVRnQzdUbHNTUzhz?=
 =?utf-8?B?amNsNUJWVlJMM0Fic3hPdjUrb1dCVDRDR2pGUkxxaGQ0NnRxbFNjQk5lcytU?=
 =?utf-8?B?NGY2SkU4emxFb1JXOU5IbDg5TTB1cFhMaG1oSFFyUXdxOWpkM1pwYllJUG1G?=
 =?utf-8?B?bWZFUURrTW9obFFIYlpQZVVEcE1IWDFxU0xNK2VDbWVISlBHQlEyTjc1czlw?=
 =?utf-8?B?b2Y4akpHNEJRVEYvWXJaNGVXTk5BSThGTkVQVlYzK2FyRldySUJZZVoyZDBQ?=
 =?utf-8?B?ZThHMFplWjdRK0ZMVzVXTkM1TU1oWm5KZWUzZFREUFRzMU40anZpUmQweEo5?=
 =?utf-8?B?eTYrVXpIeSt3QUhQUWRTbzdTd085bXVVbmJnZWhRQ1ZxT1FjSXlvYS9QWVQw?=
 =?utf-8?B?eXRxTkVwTFczdUNheWZJd3NPZ25BUnVsRjdwTXRSbHhmR0lKRkUrb1hBN1Fj?=
 =?utf-8?B?d2Q2RzE2VzZET2dzNlhBeWFVYjA4QVpqZVgxaUpmTWtIUVNWVDgrenBGSlN3?=
 =?utf-8?B?cVl2VjBIU2VKWEEvQVMyUmNFNmI1bTVkQTc2M0M2M0E0dFRBVzcrdE9sbHlP?=
 =?utf-8?B?a01kQ0xTWXlDMXhKMi83TUJsQkpwQzYzMWZJUit6NGxvWFM3MVd0MjBURUcz?=
 =?utf-8?B?YVdqandReGd5ZjlkUGNwdm11UkJwd2V0ZzVEVWNEYjJHTFR5NXRidm5jM0d5?=
 =?utf-8?B?TVJLS1p3bWxLTFFwOVJnRUV3TW9JVHhsdlJJbHFTMElheUdUR3lvTTdFdko5?=
 =?utf-8?B?VVd3aGRVTDdNUENsRnFPWGFDOVlBRlZhenYyUndtRTM0WGFWT21jRXNta3px?=
 =?utf-8?B?RGhZRHhMaE1OaFFHOHQ2VVdlNCtDcm9tTHhHY3Y2clNzSE1OT3RpakZIblQz?=
 =?utf-8?Q?0vBY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e337ac-0a80-4d42-c609-08dbcd0a4835
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2023 23:07:05.3202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4+oTgaXfXYH9uAeMKa/c3EiOX4xk7zaeJes5zAkCUNTJRJ2H6jD75emb7iLZn/78
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5797
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------nbwd5hDp6EnjQ4PfqpmuVVV2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Reinette,

On 10/13/2023 4:39 PM, Moger, Babu wrote:
> Hi Reinette,
>
> On 10/13/2023 4:23 PM, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 10/13/2023 1:25 PM, Babu Moger wrote:
>>> resctrl uses RFTYPE flags for creating resctrl directory structure.
>>>
>>> Definitions and directory structures are not documented. Add
>>> comments to improve the readability and help future additions.
>>>
>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>> ---
>>> v13: Fixed the format issues in the documentation. Needed few minor 
>>> format
>>>       changes to address the syntax issues.(Reinette)
>>>       Removed "Reviewed-by and Tested-by" flags as the patch has 
>>> changed.
>>>
>>> v12: Moved the comments from arch/x86/kernel/cpu/resctrl/internal.h
>>>       to Documentation/arch/x86/resctrl.rst. (Boris)
>>> ---
>>>   Documentation/arch/x86/resctrl.rst | 64 
>>> ++++++++++++++++++++++++++++++
>>>   1 file changed, 64 insertions(+)
>>>
>>> diff --git a/Documentation/arch/x86/resctrl.rst 
>>> b/Documentation/arch/x86/resctrl.rst
>>> index 178ab1d8f747..1163da74f734 100644
>>> --- a/Documentation/arch/x86/resctrl.rst
>>> +++ b/Documentation/arch/x86/resctrl.rst
>>> @@ -369,6 +369,70 @@ When monitoring is enabled all MON groups will 
>>> also contain:
>>>       the sum for all tasks in the CTRL_MON group and all tasks in
>>>       MON groups. Please see example section for more details on usage.
>>>   +RESCTRL filesystem implementation notes
>>> +=======================================
>>> +RESCTRL filesystem has two main components
>>> +    a. info
>>> +    b. base
>>> +
>>> +    /sys/fs/resctrl/
>>> +    |
>>> +    -> info
>>> +    |
>>> +    |  (Top level directory named "info". Contains files that
>>> +    |   provide details on control and monitoring resources")
>>> +    |
>>> +    -> base
>>> +
>> Could you please do a "make htmldocs" and then ensure that the output 
>> looks sane?
>> The resulting output does not look right to me. For example, the 
>> above turns into
>> a single line that looks like:
>>
>> /sys/fs/resctrl/ | -> info | | (Top level directory named "info". 
>> Contains files that | provide details on control and monitoring 
>> resources") | -> base
>>
>>
>> The spacing also looks off when viewing this in html.
>
I have fixed the all the format issues. Please let me know if it looks 
ok. I will send the final version after that.

Attached the patch and also added the diff inline.

Thanks

diff --git a/Documentation/arch/x86/resctrl.rst 
b/Documentation/arch/x86/resctrl.rst
index 178ab1d8f747..e990272e9a4f 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -396,6 +396,67 @@ Resource monitoring rules
  3) Otherwise RDT events for the task will be reported in the root level
     "mon_data" group.

+RESCTRL filesystem implementation notes
+---------------------------------------
+RESCTRL filesystem has two main components.
+
+a. info
+b. base
+
+::
+
+       /sys/fs/resctrl/
+               |
+               |--> info (Top level directory named "info". Contains 
files that
+               |          provide details on control and monitoring 
resources")
+               |
+               |--> base (Root directory associated with default 
resource group as
+                          well as directories created by user for MON 
and CTRL groups.
+                          Contains files to interact with MON and CTRL 
groups)
+
+               Note: resctrl uses flags for files, not for directories. 
Directories
+                     are created based on the resource type. Added the 
directories
+                     below for better understanding. The RFTYPE flags 
are defined
+                     in arch/x86/kernel/cpu/resctrl/internal.h.
+
+"info directory structure"::
+
+       --> RFTYPE_INFO
+           Directory: info
+               --> RFTYPE_TOP (Files in top level of info directory)
+                   File: last_cmd_status
+
+               --> RFTYPE_MON (Files for all monitoring resources)
+                   Directory: L3_MON
+                       Files: mon_features, num_rmids
+
+                       --> RFTYPE_RES_CACHE (Files for cache monitoring 
resources)
+                           Directory: L3_MON
+                               Files: max_threshold_occupancy,
+                                      mbm_total_bytes_config,
+                                      mbm_local_bytes_config
+
+               --> RFTYPE_CTRL (Files for all control resources)
+                   Directories: L2, L3, MB, SMBA, L2CODE, L2DATA, 
L3CODE, L3DATA
+                          File: num_closids
+
+                       --> RFTYPE_RES_CACHE (Files for cache control 
resources)
+                           Directories: L2, L3, L2CODE, L2DATA, L3CODE, 
L3DATA
+                                 Files: bit_usage, cbm_mask, min_cbm_bits,
+                                        shareable_bits
+
+                       --> RFTYPE_RES_MB (Files for memory control 
resources)
+                           Directories: MB, SMBA
+                                 Files: bandwidth_gran, delay_linear,
+                                        min_bandwidth, thread_throttle_mode
+
+"base directory structure"::
+
+       --> RFTYPE_BASE (Files common for both MON and CTRL groups)
+           Files: cpus, cpus_list, tasks
+
+               --> RFTYPE_CTRL (Files for CTRL group)
+                   Files: mode, schemata, size

  Notes on cache occupancy monitoring and control
  ===============================================


--------------nbwd5hDp6EnjQ4PfqpmuVVV2
Content-Type: text/plain; charset=UTF-8; name="patch4-10"
Content-Disposition: attachment; filename="patch4-10"
Content-Transfer-Encoding: base64

Y29tbWl0IDZmYzNkNzM4OTAzODZjMThiNjk1Njg0NDQ0MTFhYzk3NjMzOTE3NTIKQXV0aG9yOiBC
YWJ1IE1vZ2VyIDxiYWJ1Lm1vZ2VyQGFtZC5jb20+CkRhdGU6ICAgRnJpIE9jdCAxMyAxMDo0NTox
MyAyMDIzIC0wNTAwCgogICAgeDg2L3Jlc2N0cmw6IEFkZCBjb21tZW50cyBvbiBSRlRZUEUgZmxh
Z3MgaGllcmFyY2h5CiAgICAKICAgIHJlc2N0cmwgdXNlcyBSRlRZUEUgZmxhZ3MgZm9yIGNyZWF0
aW5nIHJlc2N0cmwgZGlyZWN0b3J5IHN0cnVjdHVyZS4KICAgIAogICAgRGVmaW5pdGlvbnMgYW5k
IGRpcmVjdG9yeSBzdHJ1Y3R1cmVzIGFyZSBub3QgZG9jdW1lbnRlZC4gQWRkCiAgICBjb21tZW50
cyB0byBpbXByb3ZlIHRoZSByZWFkYWJpbGl0eSBhbmQgaGVscCBmdXR1cmUgYWRkaXRpb25zLgog
ICAgCiAgICBTaWduZWQtb2ZmLWJ5OiBCYWJ1IE1vZ2VyIDxiYWJ1Lm1vZ2VyQGFtZC5jb20+CiAg
ICAtLS0KICAgIHYxMzogRml4ZWQgdGhlIGZvcm1hdCBpc3N1ZXMgaW4gdGhlIGRvY3VtZW50YXRp
b24uIE5lZWRlZCBmZXcgbWlub3IgZm9ybWF0CiAgICAgICAgIGNoYW5nZXMgdG8gYWRkcmVzcyB0
aGUgc3ludGF4IGlzc3Vlcy4oUmVpbmV0dGUpCiAgICAgICAgIFJlbW92ZWQgIlJldmlld2VkLWJ5
IGFuZCBUZXN0ZWQtYnkiIGZsYWdzIGFzIHRoZSBwYXRjaCBoYXMgY2hhbmdlZC4KICAgIAogICAg
djEyOiBNb3ZlZCB0aGUgY29tbWVudHMgZnJvbSBhcmNoL3g4Ni9rZXJuZWwvY3B1L3Jlc2N0cmwv
aW50ZXJuYWwuaAogICAgICAgICB0byBEb2N1bWVudGF0aW9uL2FyY2gveDg2L3Jlc2N0cmwucnN0
LiAoQm9yaXMpCgpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9hcmNoL3g4Ni9yZXNjdHJsLnJz
dCBiL0RvY3VtZW50YXRpb24vYXJjaC94ODYvcmVzY3RybC5yc3QKaW5kZXggMTc4YWIxZDhmNzQ3
Li5lOTkwMjcyZTlhNGYgMTAwNjQ0Ci0tLSBhL0RvY3VtZW50YXRpb24vYXJjaC94ODYvcmVzY3Ry
bC5yc3QKKysrIGIvRG9jdW1lbnRhdGlvbi9hcmNoL3g4Ni9yZXNjdHJsLnJzdApAQCAtMzk2LDYg
KzM5Niw2NyBAQCBSZXNvdXJjZSBtb25pdG9yaW5nIHJ1bGVzCiAzKSBPdGhlcndpc2UgUkRUIGV2
ZW50cyBmb3IgdGhlIHRhc2sgd2lsbCBiZSByZXBvcnRlZCBpbiB0aGUgcm9vdCBsZXZlbAogICAg
Im1vbl9kYXRhIiBncm91cC4KIAorUkVTQ1RSTCBmaWxlc3lzdGVtIGltcGxlbWVudGF0aW9uIG5v
dGVzCistLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KK1JFU0NUUkwgZmls
ZXN5c3RlbSBoYXMgdHdvIG1haW4gY29tcG9uZW50cy4KKworYS4gaW5mbworYi4gYmFzZQorCis6
OgorCisJL3N5cy9mcy9yZXNjdHJsLworCQl8CisJCXwtLT4gaW5mbyAoVG9wIGxldmVsIGRpcmVj
dG9yeSBuYW1lZCAiaW5mbyIuIENvbnRhaW5zIGZpbGVzIHRoYXQKKwkJfCAgICAgICAgICBwcm92
aWRlIGRldGFpbHMgb24gY29udHJvbCBhbmQgbW9uaXRvcmluZyByZXNvdXJjZXMiKQorCQl8CisJ
CXwtLT4gYmFzZSAoUm9vdCBkaXJlY3RvcnkgYXNzb2NpYXRlZCB3aXRoIGRlZmF1bHQgcmVzb3Vy
Y2UgZ3JvdXAgYXMKKwkJICAgICAgICAgICB3ZWxsIGFzIGRpcmVjdG9yaWVzIGNyZWF0ZWQgYnkg
dXNlciBmb3IgTU9OIGFuZCBDVFJMIGdyb3Vwcy4KKwkJICAgICAgICAgICBDb250YWlucyBmaWxl
cyB0byBpbnRlcmFjdCB3aXRoIE1PTiBhbmQgQ1RSTCBncm91cHMpCisKKwkJTm90ZTogcmVzY3Ry
bCB1c2VzIGZsYWdzIGZvciBmaWxlcywgbm90IGZvciBkaXJlY3Rvcmllcy4gRGlyZWN0b3JpZXMK
KwkJICAgICAgYXJlIGNyZWF0ZWQgYmFzZWQgb24gdGhlIHJlc291cmNlIHR5cGUuIEFkZGVkIHRo
ZSBkaXJlY3RvcmllcworCQkgICAgICBiZWxvdyBmb3IgYmV0dGVyIHVuZGVyc3RhbmRpbmcuIFRo
ZSBSRlRZUEUgZmxhZ3MgYXJlIGRlZmluZWQKKwkJICAgICAgaW4gYXJjaC94ODYva2VybmVsL2Nw
dS9yZXNjdHJsL2ludGVybmFsLmguCisKKyJpbmZvIGRpcmVjdG9yeSBzdHJ1Y3R1cmUiOjoKKwor
CS0tPiBSRlRZUEVfSU5GTworCSAgICBEaXJlY3Rvcnk6IGluZm8KKwkJLS0+IFJGVFlQRV9UT1Ag
KEZpbGVzIGluIHRvcCBsZXZlbCBvZiBpbmZvIGRpcmVjdG9yeSkKKwkJICAgIEZpbGU6IGxhc3Rf
Y21kX3N0YXR1cworCisJCS0tPiBSRlRZUEVfTU9OIChGaWxlcyBmb3IgYWxsIG1vbml0b3Jpbmcg
cmVzb3VyY2VzKQorCQkgICAgRGlyZWN0b3J5OiBMM19NT04KKwkJICAgICAgICBGaWxlczogbW9u
X2ZlYXR1cmVzLCBudW1fcm1pZHMKKworCQkJLS0+IFJGVFlQRV9SRVNfQ0FDSEUgKEZpbGVzIGZv
ciBjYWNoZSBtb25pdG9yaW5nIHJlc291cmNlcykKKwkJCSAgICBEaXJlY3Rvcnk6IEwzX01PTgor
CQkJICAgICAgICBGaWxlczogbWF4X3RocmVzaG9sZF9vY2N1cGFuY3ksCisJCQkgICAgICAgICAg
ICAgICBtYm1fdG90YWxfYnl0ZXNfY29uZmlnLAorCQkJICAgICAgICAgICAgICAgbWJtX2xvY2Fs
X2J5dGVzX2NvbmZpZworCisJCS0tPiBSRlRZUEVfQ1RSTCAoRmlsZXMgZm9yIGFsbCBjb250cm9s
IHJlc291cmNlcykKKwkJICAgIERpcmVjdG9yaWVzOiBMMiwgTDMsIE1CLCBTTUJBLCBMMkNPREUs
IEwyREFUQSwgTDNDT0RFLCBMM0RBVEEKKwkJICAgICAgICAgICBGaWxlOiBudW1fY2xvc2lkcwor
CisJCQktLT4gUkZUWVBFX1JFU19DQUNIRSAoRmlsZXMgZm9yIGNhY2hlIGNvbnRyb2wgcmVzb3Vy
Y2VzKQorCQkJICAgIERpcmVjdG9yaWVzOiBMMiwgTDMsIEwyQ09ERSwgTDJEQVRBLCBMM0NPREUs
IEwzREFUQQorCQkJICAgICAgICAgIEZpbGVzOiBiaXRfdXNhZ2UsIGNibV9tYXNrLCBtaW5fY2Jt
X2JpdHMsCisJCQkgICAgICAgICAgICAgICAgIHNoYXJlYWJsZV9iaXRzCisKKwkJCS0tPiBSRlRZ
UEVfUkVTX01CIChGaWxlcyBmb3IgbWVtb3J5IGNvbnRyb2wgcmVzb3VyY2VzKQorCQkJICAgIERp
cmVjdG9yaWVzOiBNQiwgU01CQQorCQkJICAgICAgICAgIEZpbGVzOiBiYW5kd2lkdGhfZ3Jhbiwg
ZGVsYXlfbGluZWFyLAorCQkJICAgICAgICAgICAgICAgICBtaW5fYmFuZHdpZHRoLCB0aHJlYWRf
dGhyb3R0bGVfbW9kZQorCisiYmFzZSBkaXJlY3Rvcnkgc3RydWN0dXJlIjo6CisKKwktLT4gUkZU
WVBFX0JBU0UgKEZpbGVzIGNvbW1vbiBmb3IgYm90aCBNT04gYW5kIENUUkwgZ3JvdXBzKQorCSAg
ICBGaWxlczogY3B1cywgY3B1c19saXN0LCB0YXNrcworCisJCS0tPiBSRlRZUEVfQ1RSTCAoRmls
ZXMgZm9yIENUUkwgZ3JvdXApCisJCSAgICBGaWxlczogbW9kZSwgc2NoZW1hdGEsIHNpemUKIAog
Tm90ZXMgb24gY2FjaGUgb2NjdXBhbmN5IG1vbml0b3JpbmcgYW5kIGNvbnRyb2wKID09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Cg==

--------------nbwd5hDp6EnjQ4PfqpmuVVV2--
