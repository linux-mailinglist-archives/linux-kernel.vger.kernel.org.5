Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4FDD7DFDE6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 03:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjKCBzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 21:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKCBze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 21:55:34 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2031.outbound.protection.outlook.com [40.92.99.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2836A187;
        Thu,  2 Nov 2023 18:55:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kEVrScZhajIY6i+Z7My1xJGY4gbxcdnPqZl3cLLKdxrrROYsSif1sORsGg0JjRqEdKVqTEx3Ymd9OBtoaWo9alKpdbpMebhp9rz1r1lQ1pSsO1FVILr2BAQH/Utcl/0nVbq77LPdcc7zvy/iZqgNFWiZ44WkBzIcmNoBbufCYCoUbuhPNYEu1JH3E+hMb5dML7k+W1CMkWK13+2xKOhBFhVy73vIMi1vHxzb+mQn8UVyGwbVyGRNnHwOnPEV9R3u9LwSY8tHAKP8xV7EpoLqbyBLVfHipJkTYQH/+HQIK4TVgTZAqdPAPPFCJm2UeFin9AvtGkKJrUPXweNm5+E0Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oSG3CwATOWX8p6LM90GsaUmWSCePoHczfxOc2Y+8Cmk=;
 b=QSJRVFwtODaDwsEsx/JPbIrgbeE2OC/awjCTtPeT2JOJq07CmkafZoEw7sDN8ww4Jfqx0e1OvlpSryXG4fhitUVznnlVpkOQIIgG00V5IIq+IXl3tP40HtETeiHZ76faOFCXN4Qy0ozeOJcd2ocslBR66uS2pbyRM1YyY2KDBplyCCP4mliH+HRjbRrAKBLDdDStceZ8tTxExCdnuDSFhTTCbB37v86t/KMqeplR2eqDHbLeb6XWcnKIVxvrWrPs9UwOIqQyYeSdQwyxMCha6nREh5uijRwJB9L4XaLfAU/ApF7RTnIIqNuQN1zuyCANy/WA1ok5szTjU152zRINvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSG3CwATOWX8p6LM90GsaUmWSCePoHczfxOc2Y+8Cmk=;
 b=gz4OpNmqErwoAwCRUSe2fwot/x534jPUN/ucolnBiN64wLUbOrP9F+c1Fcd5gKN0QUSKTeYkgAgR/P/rv4dIWOTxQw+ggpV97pVlLGRm1V9iaaeDNeMKEj3MfDezBETsa6k5MtpBhbKNm9XUbaV0fuqb/SLcviBrlMafoBScekMWmsBFEqFcCmmYFIb5xAf7NtixacUKDGc4EWmhfVz8KbG0sZEoJb1Y8VbIdB6/slqFJbPkJ0vYyXuq2rR5NN/fWYXBqt1G+sh2xDpkVofCBy96UqQQVuqOXbgDwZxDMoHz1MWWtmIwWmxiVFwbkceVvIeVWDAt30xwV6rs1Rd1ew==
Received: from TYWP286MB2139.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:174::8)
 by TYCP286MB1561.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:17b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 01:55:25 +0000
Received: from TYWP286MB2139.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9e0:36f1:9660:29cb]) by TYWP286MB2139.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9e0:36f1:9660:29cb%5]) with mapi id 15.20.6954.021; Fri, 3 Nov 2023
 01:55:25 +0000
Message-ID: <TYWP286MB2139F4FEC093137295E21DFDC6A5A@TYWP286MB2139.JPNP286.PROD.OUTLOOK.COM>
Date:   Fri, 3 Nov 2023 09:55:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] tools/power turbostat: Fix Bzy_MHz calculation equation
To:     Doug Smythies <dsmythies@telus.net>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        liupeng17@lenovo.com, lenb@kernel.org,
        'Wyes Karny' <wyes.karny@amd.com>
References: <TYCP286MB214616F6AE3E088C5D781A2EC6C8A@TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM>
 <TYCP286MB21465F970BF56AAE5D0CEB72C6A1A@TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM>
 <002801da0da1$adb83fc0$0928bf40$@telus.net>
Content-Language: en-US
From:   Peng Liu <pngliu@hotmail.com>
In-Reply-To: <002801da0da1$adb83fc0$0928bf40$@telus.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [MhVE4o+KCX08p26o0tO0WZ1F7iUdoXc4]
X-ClientProxiedBy: SG2PR03CA0092.apcprd03.prod.outlook.com
 (2603:1096:4:7c::20) To TYWP286MB2139.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:174::8)
X-Microsoft-Original-Message-ID: <0eae8d2e-c196-aecf-7e5a-3b8e88885ca9@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2139:EE_|TYCP286MB1561:EE_
X-MS-Office365-Filtering-Correlation-Id: 4127a135-3fd1-4a4b-3b47-08dbdc0ff213
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KgF/nq6o05j14Dtq3h2Ep1NXJHTX/T0G9KfupBxCjl6V8ssQrvWqmKnpmA1SZL7urCm4jtEPhrNiG1tkaud0ONzICHdvIDRa5ScRugKSh2mhxQETLJrqffuQf4+aGhZ5V4rPmsmwDtRAUuce/hbMaQkXGJ1gFHlSdv1bo55CIht4ylyHd9c4NAUFMThcCm2sf/RuPO0R5nIoZ1Fb1fzQhEi0QGKLZk7NbCRLRpDlU0V3IynYDaAoqNMhC+iY3xxlXOLlmqEx6FjW68PqFrCp1aUNq7ZmEVrM1iYUpxGimWIWhGtMy14ejn/enzlJb2ImWjcrenfRvXhmm2uRh9IQuRTRm8nz4UkuXJyJPvGV7wBbDWLgIqBcsencGlZsDZb0C9rdNN1h7Qqvw/avpGUkBrN2ZtPFQN9wPpLg+8UIWGn7vXOoxOHpC13cAfjeAQudaKH0/nBkjTYVf3iJovtYA7W4RvhRg/G+fW5v7hqWDpKIt0Gg3clIIlehZRoBSRBD6QliUZFoP3o7ShXFzZ624B6OIS1WYosip61k9PD9cLUum5w1YQQ/ZGPu0vUX0l9brsnJmk1s2gDc5e9ULH/hR0GpTGq6An2dVwwrPFvPzMQ=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1JIbUdmV0dYRUVWNmJUWXZBcVRVYXNxSy9XeGc4SEtPblJPMWc4VGRTWDkv?=
 =?utf-8?B?QjYzNG80Q2RCVVprZktUUmdGdVhCQmdvMlpDdlpLQ2xuUXBTUlBKaG5ka3JV?=
 =?utf-8?B?SDJsQllaRFZhZVRkV3ZuOG1qT3BucGlMM0NVemRoVWIwcWtVTGpYOS9NdXBo?=
 =?utf-8?B?cUpiTW5lU0VNTys4L0tGSDI3Snd2YU1SdW1kMVNCTXNPMEVzRC9SaTFjcW1t?=
 =?utf-8?B?VndPZFJrKzFGUkpkTUFEZGtlT2ZENFNIUFFkeHhGQTVxdTJKVkt6aHhrMURu?=
 =?utf-8?B?Vy9nT09iM2VxdXc0cVUrZDRRNnpiMHlOblplN0NtVVhXTkZyY2NoV1dCKzZm?=
 =?utf-8?B?Y3NCSXI4azBSR3ZUVjJCWW9LaGh1STdYTTNVQXhkV3BUQis2K0Rvbk9ic3FQ?=
 =?utf-8?B?SlA4bTVrSDFFa1hwc1d0Q3Q5b25ZMWd2Ynk0aE9jWWVrMFhUZFlqdmhReVdF?=
 =?utf-8?B?dVZraFNwalhwQzdjQTBER0JUQkNjWk5VWlF3Sm12Vmx0NWs0SVEvak4yMzdz?=
 =?utf-8?B?djFHLzNFallRcnZWMmF6UUNmVXJDTEdZdU5qZWRhdDFPazVlR0lFaUtTT1R3?=
 =?utf-8?B?RVVSMHZNL3NVckRzTWFtZ084RnpEbmZwT0gzUlltNHJsNWFlQ1JSNFV0NEVK?=
 =?utf-8?B?WUJzUG96VkNjcUMzUThPUHR1L2FMbHIrWi9NcGxXVFVmTDZHQVF3U1lHWFhD?=
 =?utf-8?B?elhGMyt0Y0xiSW1jQXVUbjVnT1NFSysrQThiN241aWNQcEJPdFdMSUlncFlB?=
 =?utf-8?B?bkxqN0d5WWtkbmFKcEJPYytVM2tLb3pXM3A5RDIyY21PazVadnFVaVpRL0lq?=
 =?utf-8?B?TVJHaFZOM1lGMTM2Y0s2aW1rUHVzU3M4WTZHTGdTM0JFbWZtK3loTnljUWJC?=
 =?utf-8?B?TkRFYjdvQkdiV2FQWjErb1JGMTRNbjdncnBSazFabFRNQk02cmZHb0lOWEhH?=
 =?utf-8?B?dForUFVUZmMzb3N3bkJ2SEZwQ2ZXNkZ5Z3pXeWN6bmp6YnVjdkdJY0hkWDAy?=
 =?utf-8?B?YmZ0anBLMDAwd0t6bm5DbHR2dk1XQzNLNG80QzRZdDV2Y3FnNzhFWDNvVWZF?=
 =?utf-8?B?MUt6b2dYT3lhM3Z5VnphMFo4eHJQSXUrd2FUK2FDTmFqaHB1cXVkamxOOE94?=
 =?utf-8?B?ajV0S2xnV1VyNGlNNEtpSGp2eDlhck1CZmtNcUhpdXlVVW9Gci9rU25iNCtE?=
 =?utf-8?B?ZVFsSXhCcnZiRWpkR2lyRExGT2czUnd5ZHE0ZjJBQ3YvaG1oUDJmUHZmWWVU?=
 =?utf-8?B?S2I5Q2tKSVdIZVYydnd5K3FYaEtDMjlaNVBIZlVsc1NiMnI1WFl1dWdMbDRa?=
 =?utf-8?B?T3ZrSzVDMlZ4aVVLTEtuQ0V3Tng5T0w0aGY4WitXRFhnUWlybWdQaFZNQ3BO?=
 =?utf-8?B?M0lldllqRC8zbWxtZEsyNnJnc0xCa3hjR05BQXhiRy81VlEwKzR5cjh6bytm?=
 =?utf-8?B?dWsraUl1ZmdnOHpjc0FQSEtaaTVTeWFDT256NXF3SGYzNFZ0M01reHZQOXpz?=
 =?utf-8?B?NGR0UzdqVC9WU0tJU25NMWN4SW82OVltaWpudG5tLzkyTUx6eE95cGJoMEFW?=
 =?utf-8?B?WHVuRmVSL2pXaGNueUx1NlZkVy9Rb05SYkJJcndPRGVCZnc5bEs1YVIxczVi?=
 =?utf-8?B?SUlvOGFJS1VyZDBOQjJWb2JYb3hiMEE9PQ==?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 4127a135-3fd1-4a4b-3b47-08dbdc0ff213
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2139.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 01:55:25.0300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB1561
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

Thanks for your information. I wonder whether a submitter will be notified if his/her patch is not accepted. Can I assume that my patch is accepted if no reply is received?

Regards,
Peng

On 2023/11/2 23:31, Doug Smythies wrote:
> Hi Peng and Wyes,
>
> Just for your information about your recent "ping"s about your turbostat patches:
>
> Please be aware that there is rarely any reply. There tends to be about 2 turbostat updates released per year. Your patches are in patchworks [1], as are some others, including an old one of mine from 2023.04.03
> Eventually there will be an update, and hopefully it will include all our patches.
>
> [1] https://patchwork.kernel.org/project/linux-pm/list/?series=&submitter=&state=&q=&archive=&delegate=107
>
> ... Doug
>
> On 2023.10.29 08:12 Peng Liu wrote:
>
>> Ping
>>
>> On 2023/10/7 13:46, Peng Liu wrote:
>>> From: Peng Liu <liupeng17@lenovo.com>
>>>
>>> To calculate Bzy_MHz, TSC_delta should multiply APERF_delta instead
>>> of dividing it.
>>>
>>> Signed-off-by: Peng Liu <liupeng17@lenovo.com>
>>> ---
>>>    tools/power/x86/turbostat/turbostat.8 | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
>>> index 8f08c3fd498d..1ba6340d3b3d 100644
>>> --- a/tools/power/x86/turbostat/turbostat.8
>>> +++ b/tools/power/x86/turbostat/turbostat.8
>>> @@ -370,7 +370,7 @@ below the processor's base frequency.
>>>    
>>>    Busy% = MPERF_delta/TSC_delta
>>>    
>>> -Bzy_MHz = TSC_delta/APERF_delta/MPERF_delta/measurement_interval
>>> +Bzy_MHz = TSC_delta*APERF_delta/MPERF_delta/measurement_interval
>>>    
>>>    Note that these calculations depend on TSC_delta, so they
>>>    are not reliable during intervals when TSC_MHz is not running at the base frequency.
