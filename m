Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA914767CBE
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 09:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjG2HZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 03:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjG2HZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 03:25:04 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2082.outbound.protection.outlook.com [40.107.20.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2451B49D5
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 00:25:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQ+3vo78l8lu3FJfJICwoGLbGL96tm5hss0KMAMswX2xg07BBlW8pQutBXsiORLzaq3KXUoJp5KFsmeMSy836trllFzE6yi3t8bbJX5vmwW9ZjL2pjRcK92/eEqhIbrHJIVaDWmJS1jrrSEYT6s/j0XyO2le4QAjginK8e8g+qpvM4iXYuRsIRswRTCBIyKW2WK54LjmL5v9hwWSw0jOGPRKVyQcmv+8Phhf17wrQR3o7UrbiuPSauDYG/yPf6X3GmaYlKOOnJA8wc2n6yRnWXDV58XyFkgUhohr1qNF5ct7vGJ+jN3NQ6Imzvm9HPOR5P3KYXvgmz+7Gc7lms4bWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pd+82HHTUWaNFucXSgjsvH8KQxyBWnX4ck+ad4ya+3E=;
 b=W6914+p7nGTPi2yFCmyKir2OFY6bytVTdzidxk/3cEn1vge2zCzFRUXgZrtbeVX8g6NJeTmXnR35rKSLGM0eW9lNxJHvNUQ8Ie66VGV2+qQX6nXEEw2CHpgVWEU7qS6A3V3mHIt5km+ah8dYTyXot4DuiLHCp/nxg7AN4l1wcYM/u1C6Yixx1P0U/eiv4qpPaRP/XjsDTriBe0qwf91Xm3TlmP/xUc4pRNk39cAqKw7ATsohM7VrhcrvKWigN53MaU+CCLwO6naRIR/sYb9LfEuB7+bw6VjFgSdl9XPwPh/FaZNpya4F407jQS1PIQO4/vW4pvokKv0g17pMFzAKRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pd+82HHTUWaNFucXSgjsvH8KQxyBWnX4ck+ad4ya+3E=;
 b=AvCFQfklmetaRXQwlnCFZ+yg/jd61ntqQY8bri2nTvEKUFiZgp+mxWmMMU/jUcVN/MBrDDStHqUD53NcQ9ux1ZGBsR93uTmf6utjC1VaRQ+fKxLILdb9v/o8ncxtUmc7Kj+VRxQ4qNQ05ODU/ixj4xDHCdg4sFY7FAQr4A4bBYsZ9g5ts4Yw9TfvYXet1R+1m/K6Bh6FxfGbMpGPV93iJxfdFC/s6GfUYA4EToaUAkfTUWUS1AOO4XooTO+pO9bubs67ygv3XrWcUJBIimLhILObjHzjuJNAL6PNOFxayDMtDdBNXNCN8DVhhyODmy0WiqF6zOV+MZrcnGAXX055XQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by DB9PR04MB8412.eurprd04.prod.outlook.com (2603:10a6:10:24d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.39; Sat, 29 Jul
 2023 07:24:59 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361%2]) with mapi id 15.20.6609.032; Sat, 29 Jul 2023
 07:24:59 +0000
Message-ID: <58bde8b7-018c-5f4c-282d-629cfb42515f@suse.com>
Date:   Sat, 29 Jul 2023 10:24:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] x86/cpu/amd: Report zenbleed in sysfs
Content-Language: en-US
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     x86@kernel.org, bp@alien8.de, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
References: <20230727075446.1749969-1-nik.borisov@suse.com>
 <20230728231425.mku5wnsgfzx2kyeo@desk>
From:   Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20230728231425.mku5wnsgfzx2kyeo@desk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0146.eurprd07.prod.outlook.com
 (2603:10a6:802:16::33) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|DB9PR04MB8412:EE_
X-MS-Office365-Filtering-Correlation-Id: e3dcb5fb-8e6d-499c-1301-08db9004ea5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 21h94/9q7azYWWir8JNwPK5lT6MKzuUMhZpPTymnF53VbNjp7kT1rPn61yEH7BE/kN5STFORhnPy+JoRNSe70EyDLIQItZwe8H+DAMt5G+zbWmZy7W93rBR7zgzrGo9WHGXglnNc3+scQKg01T7XA2LAa+s13YhYkkXPqmnZwJ6xIP36rlYcCOQSqXEuwCnDfed5OELk2ExpHbvY8sboWM9A1j9gJIIPX9oB+l54LGP9bjysN+cI1WZII1HWF26Chytq/LObuZPPnsgLnvys2FW3RIpA0FXiskCjb6WKV+eq3DsikKaJJZtnJu1TP0JwWLBYtbDd7CsPmH6rI6WQQ58YXqBcIxeJvPAV/psxv9bCRzZ/E2WVAZuQe1eoeW5UM97DhAL1EP2QrNngb96eO/4rSf2uCccMAnvhb9vbQmUNhfBHCis6orPvjhwugu+KnycvRriqAmynrSovZJ7Hb2YBk7k+RfzzsE/6LfJkzPr9QR7W+rhg2FKy3QufZ6b/r/Cn1XDJIUPiexIPlPSLSZ2TlJLT/NpzYUVQa4PNU5K8g8gNJgaJEcSbc1YRWQvFftf1VydMYi7EeWZo/o9I7dDGU9cRoCP4wzPzTJKLyz0cgbh9AzMvoY8AOp9KKbx9COZufc+1Te5mWOmpS/u+Zg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(376002)(346002)(396003)(136003)(451199021)(6512007)(6486002)(36756003)(2616005)(6506007)(186003)(66946007)(66556008)(41300700001)(31696002)(86362001)(66476007)(316002)(4326008)(5660300002)(6916009)(8936002)(8676002)(31686004)(38100700002)(2906002)(6666004)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGJXZGlmYXVpSTVLWDdXN254LzUwSElFM1l5OEZKWjRRWW9ldmFGbWg0bkZI?=
 =?utf-8?B?SkhaZm9FUFlTSWFBZW9SallHYldUcjdWNzkzRnZLSU5qVnBaSXNxR1FIdFhp?=
 =?utf-8?B?cmQrQU50VE9aM0twYVpVY1NGSGpUUFdkUUZtVWhXbGMwMWpNOHgyeFpOc216?=
 =?utf-8?B?TTliMS9VWVNVdjV1SzZXQnAzU0tQcDJpd05lS0VZQk4yclNRbmNZM0l3dXNS?=
 =?utf-8?B?bnVqL1JadzllZGIzTDBjVCt0VzVzZzRzSEhiMGlCWVZ4MHRGd1M3NWN6b2FF?=
 =?utf-8?B?T1J6Rjl0elJMc05DWVpPbGZWQmFIUUsxRTYrekU5R0duQndwWEFUZnF4OWYv?=
 =?utf-8?B?M0pZZkdNSTFpZ3ZXTHJuVXJSeElDZzB0bzVHUXJ2SnVpaXhmTjdlaDlid0RP?=
 =?utf-8?B?VnpYWnR3T2pFQ0p5REZUUUNhK2VJVG9iWjN4b2oyQUYyVWhFajBOa2F1enMx?=
 =?utf-8?B?bjJZYkwySll0Y2FmSkdySzkvOGFkbEpNYXVVWEpTWE9TaFBBamkyekh3MjND?=
 =?utf-8?B?Wm8xcDQ2SGNMNG5PNHNFM21NS1J3RjhybkJTeDRsN3lSekhSZlJtZmhFVWtq?=
 =?utf-8?B?YWJsRVYveDBaREZyU1BnNlJzdDBFOE81ck9hSlljeVJyYVJXRE81bDEyczRs?=
 =?utf-8?B?L08rbUs4T09ZRjg3YU5WOG1OYVZtekMvS1dScWNBZ3M3aGpISzU4eXRqcVZt?=
 =?utf-8?B?Tko2REd3bmloZVd5SE9tTGIwQVBCN3NhLzZ2UlhML1ZBSFJpTVhJb2daanVj?=
 =?utf-8?B?RFBDZUU4OHcrczhkTXdmWElkN2g3bUt6bnNkT3k4dW1QV2tBZGx4UDgyZVVB?=
 =?utf-8?B?WkloSUNXNHIzTGMxTlpJM3lKd0FSTEtJY3lGMTVuSlpNRlFSRTVwbm5uNHlh?=
 =?utf-8?B?c0lkNHp2bHFNN0Vtam9nRjBjdnRtbWg0M3FGcmd1KzhYaVNmY1draXdMZGhO?=
 =?utf-8?B?SlhIOGpFdGFLa20rZU5pR3BQWXUvK2VSL200WVJHbHdDR0dHUmpSakFheG5q?=
 =?utf-8?B?czBuQjZxTEkxSll3UW9GVzhLNXV0YVhpcWJ6dmFpeVU3eUVJbENVbElNVjZE?=
 =?utf-8?B?TjBBa1orbnJ4eWNpYVFtVWRzY1NabVFTc3FXOU5TREI0Y29jMTFWWDhSMTdG?=
 =?utf-8?B?aEVsRzYzT3J0LzJRRy9EVVJUbTNGZmtEd0dVOEhJc3QzRlpFY0psZ0RlMTFm?=
 =?utf-8?B?YWllU2VFcjFUNk9jTHJPY1F3MXA3ZEhIbTd6eCtZdnFPdDUvaUFBbXBsRWJS?=
 =?utf-8?B?VitaWHNZTlJVYjlHcXR5RUk0S2NhckxZb3hXbEJrK3NiK0lYWFYwektwTmFI?=
 =?utf-8?B?akhncklFWTJDWS9EWHd2NnQxRllVNVh2Nnd2RmViK0ZHSmdtdXhQb0JueHhu?=
 =?utf-8?B?cGxZMDNPSEU0Y00yWmlwOUtCUUxjZ1hPazVzVTJnR0ZMMHc2c1JseHlvU2RB?=
 =?utf-8?B?TlpJNm52d0xDa0JyMjl5V2hBWkZIdVJ0d2Y1RFI5Y2ZXWDhCanpTNm9Ua1hs?=
 =?utf-8?B?bmVjUUFNUXVOS0Z1THJHeFBCQkJJOUxJTVZoWTNqR0ZlcXkxYysyS3ZMb3RU?=
 =?utf-8?B?YjlkakxCU1VNYVp1c1ZjejJETTlUTVJpOEx1VUFMNE84T3ZISWZ2eGVlSWZv?=
 =?utf-8?B?b25yTnNXTC9uVSszS2wxU1FOUjFxU3UrT3h0Vm5DZkQwQTVkSGpnV1h6WC81?=
 =?utf-8?B?UldrNUtPWWNtbkNISHk2U1NzQnlkKzhkcGlTaGNjZUlJMWp5QzFQcEVMVVNC?=
 =?utf-8?B?YlRZT0t5UlRQLzBNVGhPU1JWeVJyUE9XQlNWNXNOOGRKek0yQ25lV0RNekRt?=
 =?utf-8?B?OW5LTHBIQi8wWW1HaHZieUFWa0NSd0w0MWk0YXNUTGljNUwxWEp4eUQvamNx?=
 =?utf-8?B?NTBjb3FPak9USjloMk0vQ0JxUG8wZEZvZytaY3V4YjJOZUJvSWRPOU0xMDdL?=
 =?utf-8?B?MG10ejRNdXpERHowY2VtQVhsOG1pUE52WjBVdW5jWnB4aUdHbjk5ZU04QUsy?=
 =?utf-8?B?bWsrem1VbFpVS1l2Ti9HWVBWc0FsTjk5eWtFTVlUWkttMHFlaU14ZEx5cCtS?=
 =?utf-8?B?cERhT0ZoQnF0V0NXV3ZJZ08yT2JHNjlicVh3RHd4emdZZmNzTXZFZDFpM2U1?=
 =?utf-8?B?dHVJaytDTlhJUXhOa05EYy8zQ1BFa3FLa0kxUkZYNXIxT1pLN1lselVuWDZt?=
 =?utf-8?Q?0HYUZKS3LKJBmEDgz5J3itZZjxJrlzIVVb2Ks5QwEjk6?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3dcb5fb-8e6d-499c-1301-08db9004ea5f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2023 07:24:59.1107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SduY46KNeQW+x6zwuQuYXRD4gIXaUsFu/+s9hoaSbNqUyXUhmZBpY7druKQtHcMPc0LTmnBahTeTOvDrjB/n/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8412
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29.07.23 г. 2:14 ч., Pawan Gupta wrote:
> On Thu, Jul 27, 2023 at 10:54:46AM +0300, Nikolay Borisov wrote:
>> Initial submission of Zenbleed fix omitted reporting the bug in sysfs.
>> There's no reason why it shouldn't be reported so let's add it among
>> the other vulnerabilities.
>>
>> Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
>> ---
>>   .../ABI/testing/sysfs-devices-system-cpu          |  1 +
>>   arch/x86/kernel/cpu/amd.c                         | 15 +++++++++++++++
>>   drivers/base/cpu.c                                |  8 ++++++++
>>   include/linux/cpu.h                               |  2 ++
>>   4 files changed, 26 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
>> index ecd585ca2d50..30bb4196e451 100644
>> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
>> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
>> @@ -524,6 +524,7 @@ What:		/sys/devices/system/cpu/vulnerabilities
>>   		/sys/devices/system/cpu/vulnerabilities/itlb_multihit
>>   		/sys/devices/system/cpu/vulnerabilities/mmio_stale_data
>>   		/sys/devices/system/cpu/vulnerabilities/retbleed
>> +		/sys/devices/system/cpu/vulnerabilities/zenbleed
>>   Date:		January 2018
>>   Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
>>   Description:	Information about CPU vulnerabilities
>> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
>> index 26ad7ca423e7..3ab9745eafc5 100644
>> --- a/arch/x86/kernel/cpu/amd.c
>> +++ b/arch/x86/kernel/cpu/amd.c
>> @@ -1279,6 +1279,21 @@ u32 amd_get_highest_perf(void)
>>   }
>>   EXPORT_SYMBOL_GPL(amd_get_highest_perf);
>>   
>> +ssize_t cpu_show_zenbleed(struct device *dev, struct device_attribute *attr, char *buf)
>> +{
>> +
> 
> Extra newline.
> 
>> +	if (!cpu_has_amd_erratum(&boot_cpu_data, amd_zenbleed) ||
>> +	    !boot_cpu_has(X86_FEATURE_AVX) ||
>> +	    boot_cpu_has(X86_FEATURE_HYPERVISOR))
>> +		return sysfs_emit(buf, "Not affected\n");
>> +
>> +	if (!cpu_has_zenbleed_microcode()) {
> 
> For readability this can check of microcode present case, and drop the
> NOT operator.
> 
>> +		return sysfs_emit(buf, "Mitigation: Chickenbit\n");
> 
> Shouldn't this be checking if the chicken bit is set? And if its not set
> then report "Vulnerable".
> 
> But, looking at zenbleed_check() it appear that the chicken bit for
> zenbleed will always be present, and it will always be set if microcode
> is not present.

Yeah, but based on feedback I got from Boris it seems this is not going 
to be merged so it doesn't matter.

> 
>> +	} else {
>> +		return sysfs_emit(buf, "Mitigation: Microcode\n");
>> +	}
>> +}
