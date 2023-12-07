Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B72E809121
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 20:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjLGTSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 14:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjLGTSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 14:18:21 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06ECA9;
        Thu,  7 Dec 2023 11:18:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CtWpPjqJVNIzLJiNqNJo+jRfCaPkxN4rVXfNDEfzM0e0aHEl8kQPbuGN595XOCm9Ukerli02KY12eSFThX9Nr8KzzRndGfk8J/NG7KMEFhEbhDAYe8OlHRzn/4RhKSqkdpHAezt6Ma6bENQO7/9E7OmsikeBUU/pgwpU3JCbhlhjRO4LGxPBZls40fWRk6AgyvnNdH13MB0Bg93t9rPx4vHulfy6wFHW4R+7sRSUMsrXK15AdEBX9D6HBZK5VvRzYXvOgo37uGQu22FhP3VsAmvwkMZl6DvGfxuUWJNnQ+f7khutMlaxkgR374v1NkO4qq8UQMsOBVxhtKqVR9ET3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DlhLX5HCxFtw5RKguObSeRoGMVv4h43lU45G3jHZB8k=;
 b=AYmOSF81dIYsIC9Sg3SCljPOJPDbO90WyqDOOC+VWvOVc/iIPlQULq2twby8IlrZz4KBdapr40SGB9PIsQQaGyb0YxEiBjZ+0LK8ws2PrS5vO8SjwqO+tAOk/IxsBqZaK/Y9VYmHsTRyYwhb1gsgHx7mqMaiEpFDcJVDfEWhQHe939s2l+6SPCveKj1IfH4UKE/X3Gc3JM/Quspuq80Fe9r+jDG0AhQ/mwzSNKJl9dg48aaDBeoOxoHeG3Ld/UhzDi3ytx/Rb5btgIyS+pW0wvQqLMqDBmA39V2se4CCWmBdqp7/+j0B7O0DjqMArCpglbDcHJBu/5OPmvqHqp+ndg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DlhLX5HCxFtw5RKguObSeRoGMVv4h43lU45G3jHZB8k=;
 b=ZbTKhh10MAO8J/IGioj5Y6YJaLhJzpfKffRWyo1gjttx26pzRAv/OJ24w+u87ZBM+P3Bd3MXd5GfIjrKrcyE8Q9rlY8WqRS5c1DsI9bfu7EAuC2JwP21mcB4fKgntEnD32FyKO8U0LpNnf50g4Uu/T702ofMKCO2rc2vpRoerU0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ0PR12MB8113.namprd12.prod.outlook.com (2603:10b6:a03:4e0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.36; Thu, 7 Dec
 2023 19:18:19 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7068.025; Thu, 7 Dec 2023
 19:18:19 +0000
Message-ID: <3b3d2bea-c8be-4438-9c71-876ce55dce35@amd.com>
Date:   Thu, 7 Dec 2023 13:18:15 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86/intel/pmc: Remove GBE LTR ignore
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        jahutchinson99@googlemail.com, ilpo.jarvinen@linux.intel.com,
        xi.pardee@intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, rajvi.jingar@linux.intel.com
References: <20231207182311.2080972-1-david.e.box@linux.intel.com>
 <585eee5b-06ee-4b0a-a5e3-50e5c471fcff@redhat.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <585eee5b-06ee-4b0a-a5e3-50e5c471fcff@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0018.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::31) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ0PR12MB8113:EE_
X-MS-Office365-Filtering-Correlation-Id: f5292d77-f058-4bd0-ba0a-08dbf7594548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w/l6JL5WasOtwpThtc1V7w5Kl1Ti6HZm+C5G3jOnbdqWaIeEhWwU/m+YBOS0amWdQZ0z7OcHkIuoPrLhm1i5A8W18lWvmYlgfpmDxwnSXbyRl0dQlV+kdkqZz//RNW/A00DAecVUe6luHAUrx7AduU77M0xkHdYOKiIUKm8szHXo4nGzj3WGQtSa91RQcPPd78wuoA9Tt1R5d4Ycw3cHzBZs/R9voFk17il8mIG1jO47sNzGTtKaC8qQueVRTYX+BBZrKNlsWtNcfjp0WG5Nsw2eqHEnM+PxSSf3U4I7nZsSIZ79+jdsKswsNg3vlU+qmkEvf6/O3ncJamwoxkIQ5vyfFjHPhpcwOMPvHa25oWzKENcHrhLlHgPDwGPM2lM1paBS2yRj6BARFiVl3u+Y6ZLOlzKfauadE02NbPMqycj/wCVB4R7Tx5pAvH5KrlooQC5fjMHekkt2V9ICTW7tP0qWHyIqCfRArRFNg5L56fCOoVCnGO9caRC8Aj+ekcHQz/SiNzHIjWS3HBVjqU3QNp0x1oGaAFgLgraHFywEUh7F331I+9NnrcZ8M/q0lyqigVOrEaHdluTAxz7Gy9mlhmg9mRekQNzYwiJjaVluco3bqKOBSGaHEX9RXusuVSaxMnz3Rt/dtmPF/XHTZo1msg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(396003)(376002)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(83380400001)(2616005)(26005)(38100700002)(31696002)(86362001)(36756003)(110136005)(66556008)(316002)(8936002)(8676002)(41300700001)(5660300002)(2906002)(44832011)(31686004)(6666004)(53546011)(66476007)(66946007)(6486002)(966005)(6506007)(6512007)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEViVGRyek16Q2FTWWlqemZ0T3NOKzVVWDdsb0FLTDdwSU94c2hMcFR4d1Av?=
 =?utf-8?B?MStNejA0aWNObXBtTTlzZ0dmUUVyQ2ZlL3o2YXM0WjIzYjRtUDJ5RDFTbjA2?=
 =?utf-8?B?SkJIeE9KSlhSQUFHY3Y5aXBmS3pZMm5ZNmJMdGNoVSsxQThmaGVnamYvTkZ3?=
 =?utf-8?B?bkpzY3ZzTVkwUDYyaWZReFJ6MlZFbGVhNWl6aHhObytSRDhrTkJQUnRvbEJm?=
 =?utf-8?B?N2JyWWV3ZEt4LzlyQmdTRzViRGhrTDBsL0lqYTN5SU5pMmV4alhnRjY3Y0lF?=
 =?utf-8?B?bGhVQm53b2tqUzk0L1M2Mzd3am1kdUJTejlqaEhzNnR4SjEyTUN4VlVoQXlY?=
 =?utf-8?B?L1p1ckFHaExSbEc2NytROHFjN2R3Q05MYnZmdzBya3pIR2krSGxiWks5Z1Bi?=
 =?utf-8?B?QjMxZXA1MmJHZmFBamsvY2dudlFkMHFTaDdQZFhFanJJYlBJS1hPVU5sRXBF?=
 =?utf-8?B?eG5KTnVyWWR3Q3hQMXhiRDNwRFF3RmYxWlI0ZGZDTHZiei9FM1ZZRmt1TnJX?=
 =?utf-8?B?SVRMWmRUeFoyV1hSUU4vS0JTTkQrTU5nanE5NUxoa1hEeVEzR3VSbFNCN0tO?=
 =?utf-8?B?Z2dXNmR5MXM4UTh6TnBPZnUwMVFtenZ6enFkYmlxVHdlVnRwMGMyTk5oYThJ?=
 =?utf-8?B?bkNzNG5RSGI3NDMvL1ZPdFRVdndwV2tzMm1GL0xRSUFocjNnMlBuK3ZMbSsz?=
 =?utf-8?B?N3I4ckpZQjJoRnB4eE52c2ovdGJHc0dFT1FwT3VsTWVQTE5RL29rVUw5amFv?=
 =?utf-8?B?U0J1UlpXM3pLMEx4V2hsa1V2Uk9MZDRTTURRMjM2dHliWmJpUXRuWUNsaWc1?=
 =?utf-8?B?aFJ1c3NrSGNhZEdhOXNzRlhGOEpMQzhHVmVpNkNubzVqRHhQOUR1Tk8xc3Bi?=
 =?utf-8?B?V1VPUzQvbVpaT3lpLzJDdlpmUEJ6ci9OTURJTEx5QmdBSmVYa0RvT1JBUW5C?=
 =?utf-8?B?ODFLSUVYV1pPb0ZxdkdKVkg2empPdVdqUC8rV1pCU1c0Z2g4UVZGQ281eUZF?=
 =?utf-8?B?YXozYXFHeGpJWnVoVENJbTF1VEZIYi9EdDFsblppR2I2MWo4Y3hobjRnTkdD?=
 =?utf-8?B?T0RWTisvM1Zncm4yRG4rR3R5SzVvdElqVmszK0dPSUtYUURWMDJxTTVDMjNX?=
 =?utf-8?B?dmVTTkpUS25kbStOeXF5dHNDeTZDVlAyV2t6d3QvVWNJUXpWNlFDTXJLRVJi?=
 =?utf-8?B?T1BCYTA0SS9pNkJCbGlXTDFGZjRrRzczTXNYaU5mREppVERkUHgwOGNvTXZy?=
 =?utf-8?B?bDhYUVB1K3ZSbnNzRm96WVh1d1ZENFg2OUdYZTRyT2w3YmVzR0lOeHZmWE1U?=
 =?utf-8?B?aXFaS1p3RXliRUxIWHIyTTJOUGJ6QmxEc1lPcm14dXVSS2RNdnFCbStEVXRL?=
 =?utf-8?B?bDVTTmJ4WlNFTUYyL1hzL2FKQ2RyWlIySDhNMFFYQUsxUFQxU0JmZDNYTW5H?=
 =?utf-8?B?aElTbFNHZ3c1KzZ4NDVuOENtcWxURXFtRXBOVTRsNVRCdXRhdDBuc3Q5dTZC?=
 =?utf-8?B?WUl1WmpRZmJxWjZyL29OYXpOZ2xBWVF4VWlHTWhwQVBOUDAyZ3hVMStOa3Y4?=
 =?utf-8?B?Vml4ZDk3WlhSRDZBbDhvS3BsZHJlK3oxZXN3T1RiMHU1dHFEcVNGcmgwREdT?=
 =?utf-8?B?TmhzOFBLU2NIczR3OHN4eE96NUFrdm01cmxQR3QxWmdEYUR5TElDajMweE5O?=
 =?utf-8?B?WTJQaUdOaVViN3VYMXF0cmtRYjdYN1BRNVk3dXYrVFdNNzhRSU9ZMEdURVZI?=
 =?utf-8?B?WEpuK29FSHZTWjJYazNlQ1Y1cG0vT2FmMWFsTjI5bkUrQ0JuSW15cVl4eElI?=
 =?utf-8?B?ZFBvZWF6UklmaWZSV0Vtdnl1Z2FXY20zZU9mNENhU0tGbGo5QkFSS3Y5UEZH?=
 =?utf-8?B?eWszSnN4U0hZalBaaWNkQjhlU1ZEUndaZWJqclkzNkhUQlRtc0sxNlA4V0Na?=
 =?utf-8?B?Vk8rMmFxSWUvYUxySkorVWlkQnplWWFoTGxjL2tLQ0lzUFU5cTZOd2hnZmkr?=
 =?utf-8?B?VFBsY3hpU2VpMDVvUy9ncjBKcG4wVmZvSXJDd0lmWEdjM3BnTzdYQjVoUmZs?=
 =?utf-8?B?anRyMUJzZVo2ME5HdG9RbGtzV2p6QmRraThYVmNPL01mbXpvaEhjNFc1Q3Js?=
 =?utf-8?Q?qx6s6W+X0w30sjyCMqCEvIVVW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5292d77-f058-4bd0-ba0a-08dbf7594548
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 19:18:19.1811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2p9Hd7YPWov5bdKpZrpmbKB2jasepKKoZYV4zBYgMxm0+CtIg0Vit4GSd/Or0wJQ/P1Avk/L2BUH2JW52Eqfng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8113
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/2023 13:02, Hans de Goede wrote:
> Hi David,
> 
> On 12/7/23 19:23, David E. Box wrote:
>> Commit 804951203aa5 ("platform/x86:intel/pmc: Combine core_init() and
>> core_configure()") moved the GBE LTR ignore workaround from core.c to PCH
>> code and added it new for Cannon Lake PCH in cnp.c. This introduced a
>> network performance regression on a CNP PCH system [1] which has been
>> observed on other PCH architectures during testing. Remove the probe-time
>> GBE LTR ignore for all platforms. While this will prevent performance
>> degradation, it will also limit the deepest SoC Package C state that can be
>> entered at runtime while a LAN cable is attached.
>>
>> Reported-by: James Hutchinson <jahutchinson99@googlemail.com>
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218143 [1]
>> Fixes: 804951203aa5 ("platform/x86:intel/pmc: Combine core_init() and core_configure()")
>> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
>> Tested-by: James Hutchinson <jahutchinson99@googlemail.com>
> 
> So it seems to me that to fix 804951203aa5 the only thing
> which needs to be done is remove the pmc_core_send_ltr_ignore()
> call from cnp_core_init(), the other changes here are NOT
> related to fixing the regression.
> 
> So IMHO it seems better to split this into 2 patches?
> 
> Also if this block the system from reaching PC10 should
> this then not at least be done at suspend time and
> undone at resume ?  I'm not seeing anything in the current
> code which does an equivalent on suspend/resume, so it
> seems to me like this will cause a significant increase
> on suspended power-usage if an ethernet cable is attached ?

In addition to system suspend on these system does GBE support runtime PM?

If so, would it make sense to also have a Linux communication path from 
the GBE driver to this driver as part of the runtime PM callbacks?

Then if the the GBE goes into runtime PM it could tell this driver to 
waive LTR and if exits runtime PM it could tell this driver to stop 
waiving LTR.

> 
> Regards,
> 
> Hans
> 
> 
> 
>> ---
>>   drivers/platform/x86/intel/pmc/adl.c  | 6 ------
>>   drivers/platform/x86/intel/pmc/cnp.c  | 6 ------
>>   drivers/platform/x86/intel/pmc/core.c | 2 +-
>>   drivers/platform/x86/intel/pmc/core.h | 1 -
>>   drivers/platform/x86/intel/pmc/mtl.c  | 6 ------
>>   drivers/platform/x86/intel/pmc/tgl.c  | 5 -----
>>   6 files changed, 1 insertion(+), 25 deletions(-)
>>
>> diff --git a/drivers/platform/x86/intel/pmc/adl.c b/drivers/platform/x86/intel/pmc/adl.c
>> index 64c492391ede..e4a421ca64be 100644
>> --- a/drivers/platform/x86/intel/pmc/adl.c
>> +++ b/drivers/platform/x86/intel/pmc/adl.c
>> @@ -321,11 +321,5 @@ int adl_core_init(struct pmc_dev *pmcdev)
>>   
>>   	pmc_core_get_low_power_modes(pmcdev);
>>   
>> -	/* Due to a hardware limitation, the GBE LTR blocks PC10
>> -	 * when a cable is attached. Tell the PMC to ignore it.
>> -	 */
>> -	dev_dbg(&pmcdev->pdev->dev, "ignoring GBE LTR\n");
>> -	pmc_core_send_ltr_ignore(pmcdev, 3);
>> -
>>   	return 0;
>>   }
>> diff --git a/drivers/platform/x86/intel/pmc/cnp.c b/drivers/platform/x86/intel/pmc/cnp.c
>> index 59298f184d0e..416d3a0c3615 100644
>> --- a/drivers/platform/x86/intel/pmc/cnp.c
>> +++ b/drivers/platform/x86/intel/pmc/cnp.c
>> @@ -216,11 +216,5 @@ int cnp_core_init(struct pmc_dev *pmcdev)
>>   
>>   	pmc_core_get_low_power_modes(pmcdev);
>>   
>> -	/* Due to a hardware limitation, the GBE LTR blocks PC10
>> -	 * when a cable is attached. Tell the PMC to ignore it.
>> -	 */
>> -	dev_dbg(&pmcdev->pdev->dev, "ignoring GBE LTR\n");
>> -	pmc_core_send_ltr_ignore(pmcdev, 3);
>> -
>>   	return 0;
>>   }
>> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
>> index 983e3a8f4910..7c6a74957d57 100644
>> --- a/drivers/platform/x86/intel/pmc/core.c
>> +++ b/drivers/platform/x86/intel/pmc/core.c
>> @@ -462,7 +462,7 @@ static int pmc_core_pll_show(struct seq_file *s, void *unused)
>>   }
>>   DEFINE_SHOW_ATTRIBUTE(pmc_core_pll);
>>   
>> -int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value)
>> +static int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value)
>>   {
>>   	struct pmc *pmc;
>>   	const struct pmc_reg_map *map;
>> diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
>> index 6d7673145f90..3bbdb41a754f 100644
>> --- a/drivers/platform/x86/intel/pmc/core.h
>> +++ b/drivers/platform/x86/intel/pmc/core.h
>> @@ -493,7 +493,6 @@ extern const struct pmc_reg_map mtl_ioem_reg_map;
>>   
>>   extern void pmc_core_get_tgl_lpm_reqs(struct platform_device *pdev);
>>   extern int pmc_core_ssram_get_lpm_reqs(struct pmc_dev *pmcdev);
>> -extern int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value);
>>   
>>   int pmc_core_resume_common(struct pmc_dev *pmcdev);
>>   int get_primary_reg_base(struct pmc *pmc);
>> diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
>> index 38c2f946ec23..33d32a76c43a 100644
>> --- a/drivers/platform/x86/intel/pmc/mtl.c
>> +++ b/drivers/platform/x86/intel/pmc/mtl.c
>> @@ -1065,11 +1065,5 @@ int mtl_core_init(struct pmc_dev *pmcdev)
>>   	pmc_core_get_low_power_modes(pmcdev);
>>   	mtl_punit_pmt_init(pmcdev);
>>   
>> -	/* Due to a hardware limitation, the GBE LTR blocks PC10
>> -	 * when a cable is attached. Tell the PMC to ignore it.
>> -	 */
>> -	dev_dbg(&pmcdev->pdev->dev, "ignoring GBE LTR\n");
>> -	pmc_core_send_ltr_ignore(pmcdev, 3);
>> -
>>   	return pmc_core_ssram_get_lpm_reqs(pmcdev);
>>   }
>> diff --git a/drivers/platform/x86/intel/pmc/tgl.c b/drivers/platform/x86/intel/pmc/tgl.c
>> index d5f1d2223c5a..7e6f5739a197 100644
>> --- a/drivers/platform/x86/intel/pmc/tgl.c
>> +++ b/drivers/platform/x86/intel/pmc/tgl.c
>> @@ -265,11 +265,6 @@ int tgl_core_init(struct pmc_dev *pmcdev)
>>   
>>   	pmc_core_get_low_power_modes(pmcdev);
>>   	pmc_core_get_tgl_lpm_reqs(pmcdev->pdev);
>> -	/* Due to a hardware limitation, the GBE LTR blocks PC10
>> -	 * when a cable is attached. Tell the PMC to ignore it.
>> -	 */
>> -	dev_dbg(&pmcdev->pdev->dev, "ignoring GBE LTR\n");
>> -	pmc_core_send_ltr_ignore(pmcdev, 3);
>>   
>>   	return 0;
>>   }
>>
>> base-commit: 35ddd61cf023b5deb2b7e9f1627abef053281c0a
> 
> 

