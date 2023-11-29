Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652997FE166
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 21:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbjK2Uy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 15:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjK2Uy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 15:54:26 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F2ED67
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 12:54:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNnbYDQciF0yUOMpRP8bFStxNpNwA43u1yTR4NghDXJuN8+cCop103ESwmI0fvOTwEIxlAyYQbYlTRdP4XIYIlV0jVgaxG48RElyaBxFHPBdy2rz8Evr2YIIIrV9CB96pfdCxGZm/4qB5F6XMotXn+NJNb6lWnJF8HyAb1oXrjQTfwXB8JFjgDMxVD0SRD2anPPzxnPC42Mpeu4N10PbO77GmMA2ENWtHFdqQv6JLObeYHdvJ4X3t/v5/No7UKghmnvHHmSqVe7AUW+NEWRuhDYkMxOXcJueLD63RmOhGH1HH8o9MKXoRLV11kwYPP0RF2LTI67S+RpchSpqGZrU6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNBN7MqoK0bKziIP8Sg+5oktlwN/Aa7zxg4lmdjt0Pw=;
 b=ED30tC2/EoLzk9yOxt1mTTcrDL3+ZdRTCmOzHKLaSiWWYYN4EwLByZpPMd+dnuF5IkfaaIRdZaBYQNCGZbw9X/buTSG3v3Z62N6+hNBnwqmCGbAvccy3PPTWhA7b9dknSz8iB5dT0GwgR2WB+MdcMTbXMMYvTk5cIgSEY6qS8cA8bsfpdolmjKSdRMeuDW9SZ9bpmmlBD4NL8586JMn5G3d7aboTshxGzCq+1KGpNRUs2vuOddd2+JrooLg4LD1xf+g8XDeTS+GpW2QxuNe5gIkPeW/C9m0AKav/wp6E3uoj4ROtZHFoaTW16hPrkpXTlTkRF6Xvn85V80XFlugwaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNBN7MqoK0bKziIP8Sg+5oktlwN/Aa7zxg4lmdjt0Pw=;
 b=BQkcL7KsAIbQvKJNcefabXaG96Nj5V2X0A2jy/LtY7LaeWHN5MA+taz24415wcjsZdP4yCoPBiONNxlxlQxe2UJmn6ZZXK5rir1F8J5KdA1jIg5SRy8X/DlRnB47CBOH4BGlMBgHv1ZyFq97mtaJfWgHXN4RC31VeF7hyDcRoJs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by SN7PR12MB8771.namprd12.prod.outlook.com (2603:10b6:806:32a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.30; Wed, 29 Nov
 2023 20:54:26 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1d68:1eb8:d7dc:4b43]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1d68:1eb8:d7dc:4b43%6]) with mapi id 15.20.7025.022; Wed, 29 Nov 2023
 20:54:26 +0000
Message-ID: <cbc9c527-17e5-4a63-80fe-85451394cc7c@amd.com>
Date:   Wed, 29 Nov 2023 14:54:24 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: AMD Memory encryption vs. kexec
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Kai Huang <kai.huang@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
References: <82b2e0d5-edcc-44f3-b759-d6b8c8788ea6@intel.com>
 <29e235f7-add2-47ae-b06e-a717202c4faf@amd.com>
 <26d91827-8308-42e2-969e-993c82623bb0@intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 1NhFSLKvfA==
In-Reply-To: <26d91827-8308-42e2-969e-993c82623bb0@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0108.namprd11.prod.outlook.com
 (2603:10b6:806:d1::23) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|SN7PR12MB8771:EE_
X-MS-Office365-Filtering-Correlation-Id: 321632d0-258d-4772-ea26-08dbf11d5fa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cWa+jUxTz2kR0dbjqcxwg11GRa6A+gMd0fAShhwjz6jLPaM0BM+wtf2fTJzhVcwL9hLBpaIKucrnyEqGAiankKXBE8MwSgCMK89qNS3LNH0r5+Uf7uX5KlwX3c1DNZEKhaPFJk/kcmQponCRtODG6q6LpQVvdLFV6+UQbRYIenhBVKGRoH4TnJ9ZJJq41WZikwiRSEXM8ei0NIrVyNL0BLm3OxeHv3Rcn7k/XSuRYUTMR0bqw6bbxZKyjebkXSeFBqCWzn4KkFY+6m/NpE//btmluYnWjncAUiwy78Vap3lqRyIyyoXo6jnK0rUTY8pemYqpmnnbHysT4Nyqj94zvE0WZtlx1pG1zJdHFnB9VlkjIBbyIn73WyZkfmr47tnLEdFcnLmhn+yJnKFxSxW+62tBLMyAqnBo+47GsfeLgdo6U4v4sU9kNXW7ZajL4lg/R5MqeEkOYEnVZWVJoCfYa7tRl8pRDyTMKSD4uFDN6qjkfjCcsXbm5eE+v/WjMKo9omVS9S6ecoqrvAwsH34+wemqkmWnEz+bkTC91jLmDW6IcPyfpDq7smItGb6VvLaMrE5+eA/gWzbgHKq8jKKPZHF+772N9uFAW4/WO0elxJ2STzrAv3X7uoSmy75crLMz1lg9cl8EdrvB72v8hmBZ7c6lrCGdx+UwzjggEQnI4lwi7zBTW/bEO4amBTfF0Dso
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(6506007)(6486002)(41300700001)(478600001)(4326008)(8676002)(316002)(36756003)(38100700002)(8936002)(86362001)(66556008)(26005)(66476007)(31696002)(110136005)(66946007)(54906003)(2616005)(53546011)(6512007)(202311291699003)(31686004)(2906002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TExWbUU1QXZycGlObURtWFFxSjZ5d3BLeVNRZSt6TjNabm9aZTdIbDNsUXVN?=
 =?utf-8?B?Q09Yc2VtLzl4V2dFc08xTVhsbmhPRGgwSFV3Q0VkWTBQWFd0S3RYSjdhd3ZY?=
 =?utf-8?B?NXRSM3QzMXdoTytSQjNNWjV2bG9qR3U0OGt5OTIzYThKTmk1UlgyaW53L05u?=
 =?utf-8?B?RGdjOEQzMUZMc3MvRENNWXJuTUVvNEZ3L2ZWdE9KSmRVNWVuZ01YbVF0NWFV?=
 =?utf-8?B?VTZhc1BNSTFyaGtDN05JeFFWd0I0b21GNmpnQWE0eEVmeDdsK0ZTeTJIOCtP?=
 =?utf-8?B?TzRocFRodndqeUpQTjhSSlRnUkdBVWFIdzM3MUE2dHBWek9JbnBaNmloT2NB?=
 =?utf-8?B?MU1lVE90THFBbXpPKytSV2xYWDNPa3VUTlNOY1g4dmZ2dTV2Q1JyNTE1Kzdn?=
 =?utf-8?B?eEhCNWNZNzVOTUVyWXJHeTk2MndYbkZxbDRUWHZoQ0FuRCtMK2llMndBUGJO?=
 =?utf-8?B?ZkFMRHI5dUR1aFBvbXlnUFEwdzZORnVkVzU5Nk81bjNoTEprcXdVVUNPMFZ4?=
 =?utf-8?B?WkFXbE1Pc1AyaUkreG95WFFGWEt5UWZFTTVSanE5SnZIT2FEQk90cXNIaFZP?=
 =?utf-8?B?SUZYcjVtRWVOaG4yaUdYWGJwNHFRcXhYWFJaMkhYUXo1eDQ2U0t6REpJN3BN?=
 =?utf-8?B?bHg0c2YxcXNTbEhQcllDTDlIa1dYQUdZNmxQK0FhQnZHcUhEN1YrWGRINmJD?=
 =?utf-8?B?Rnl6Mk5mOVRmQ2pkZXljNFFxeGVKNkc4TjA3UFFKWDZiVm1KN1F3YitVK21K?=
 =?utf-8?B?ZlpnLzFydjcvVjg1cVZOSEZrV0E1MGhabVFuNU5LZHpqd2RTeFdzdjhKQ05t?=
 =?utf-8?B?NHd0OUoybno4SmFuWFhsbHNmUExLVml6RlU4QXE2WmExZkt1UFZ4Tm5kcFFG?=
 =?utf-8?B?YWp4czlqeE5mdEQ0MWdIanhmUDJQRFhzV0ppMWJqNTVHMlBZaGNGYlMyaGIy?=
 =?utf-8?B?bGxxenB3WlVpUm12Z0gxVVVaR1UxMXRneXVNbzBFMWlQMjN0YlM2U2puOHc1?=
 =?utf-8?B?Z3gwalNJdC9Ecy9OSXBuM3UwdXBFeEs4aC9lTllRV01uN1NNTzAyb0RkVkZm?=
 =?utf-8?B?WXlReG1qalRPc3EvWDRLTzVTaEtiVTluK0NJMittNTFwS2dLVHRoUThDd1V1?=
 =?utf-8?B?MHFhY093VjJEZW5VRlhLeXppaGVmdUNsWFhBWmtYb1hGbXpjS1k0d2pjcWM3?=
 =?utf-8?B?Y2NiUDk3UDF6NjdmcmUyZ2wvRXA4TnNZREMxejhuMUUzWDM3UDd1MWhzamti?=
 =?utf-8?B?TzBGUnQ3T1pnQnRlUEZ1cWFPUG91UHkwNHJPRGpDQzJJUlN4a05mS1RxQlJu?=
 =?utf-8?B?ZUNXU2tvRWZBa0xOVWJUdS9FUG9wVk9BaklrclZvM2p2QktUVEFNQXFuTFhR?=
 =?utf-8?B?N0t6UVMzdzFSemJ0UGk0bnJPSDJMeHozb21QYnY3SW0yblZNNCt4aFREYnFD?=
 =?utf-8?B?UEdPKzUwVVZiVTR3S1RrVytCVzR3dXY4VkoxQnZOQmIzUFIybzlkUTJ0QXU5?=
 =?utf-8?B?cWs0d1FZdjg1SGJIUXNJVXFvRHVXdGNlNVBqcTArTDFPQWVUSzFxSUljL0Nw?=
 =?utf-8?B?d0RDTGNOeVQ4ZkwrWVNxY2w3K0JQZE5JVnhBMkNkRm9qeU9CWm1NOVNtc3hw?=
 =?utf-8?B?Z3oyZEFaOWRzZUlDRkZPK0gyZ1czNzZ5M1pGblVzZElxVFJMek9KZ1QrTHFa?=
 =?utf-8?B?ck1NUm5tNjNVV2JsUjB3cGxXMjVGMzFwcUZwTVJZTll1TG9hWEsyWlVxQ21T?=
 =?utf-8?B?eDJSQitqT3VZM080MlUwbmtJQzBvOCtzZjBmNlk5TGRtdHRjYjhGZXpHalR2?=
 =?utf-8?B?VCtob09Gb0QxVDhDN0ZrTkFNYzFJNzFzcWg1ay93aW1CT1NhS25zRTREUmZp?=
 =?utf-8?B?ZHBXTjIwS1lGVGpPMGNudzE2WUVQTG5LV0VPcHZ1d2trWkQya21OUk9TeERu?=
 =?utf-8?B?ekdiRWZ2M1FPRFpoYXlKQk1GQk5FY1FVSmhUSEY1TjZ2ZXZDQVBSVmNvak1o?=
 =?utf-8?B?Qm9DSUVxUTRSdjRRVzBCc3VuRldUSktNM0dtUXJQZ05HYlo0ZzdVRTVvbnk4?=
 =?utf-8?B?ZGRzeXAwOFAvMkU3bUExSVBEWTZobitzMzUwclNIdHRYS3FTS2RzSm5teE4x?=
 =?utf-8?Q?qjmE34Lz0lvk6bTtl6NoKatNK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 321632d0-258d-4772-ea26-08dbf11d5fa8
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 20:54:26.5731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YPgMWy/TjYEhMQmfbzO16ZHLAY4SUaszarNieB4gjQaLlf89+O8jv6SuRVOSjkqt97Q/TiLXZguhC3t9AfcBDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8771
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/23 14:01, Dave Hansen wrote:
> On 11/28/23 06:03, Tom Lendacky wrote:
> ...
>>> By my reading, the CC_ATTR_HOST_MEM_ENCRYPT is basically a check for
>>> whether the current kernel has enabled SME but not SEV while the
>>> stop_this_cpu() site is driven purely by whether the hardware *supports*
>>> SME.
>>>
>>> The whole supposed reason stop_this_cpu() checks CPUID directly is that
>>> the current kernel SME/SEV enabling might not match the _next_ kernel's
>>> enabling choices.
>>
>> Correct.
>>
>>> So, why is a _current_ kernel check OK for relocate_kernel(), but not OK
>>> for stop_this_cpu()?
>>
>> The relocate_kernel() check provides an indication of whether SME is
>> actually active. The kexec kernel is placed in unencrypted memory to
>> match how the system was booted - where the kernel is loaded into
>> unencrypted memory and then encrypted in-place if SME is desired
>> (mem_encrypt=on). Since the kexec kernel will be unencrypted, the
>> cc_platform_has() call is used to indicate whether to perform a wbinvd
>> to remove encrypted cache line entries. If SME is not active, then there
>> is no need to flush caches prior to booting the kexec kernel.
> 
> Ahh, so that wbinvd is truly specific to kexec.  It protects the
> always-unencrypted kexec area from being zapped by encrypted lines.  It
> isn't necessary when the old kexec kernel is mem_encrypt=off because the
> unencrypted old kernel matches the always unencrypted kexec area.
> 
> What I was worried about was the _larger_ case.  Not the kexec area, the
> *rest* of memory.  But I think that's irrelevant because there's yet
> *another* wbinvd in __enc_copy() that is will flush the rest of memory
> when going from mem_encrypt=off=>on.

Correct (I was actually sitting here before I got your email wondering if 
I should reply to my previous email with just that info).

> 
> I'd like to propose a simplification.  Let's add a
> CC_ATTR_HOST_MEM_INCOHERENT.  That bit gets set on all hardware that
> needs WBVINDs at kexec.  On AMD, it can use the stop_this_cpu() logic.
> This will cause an additional wbinvd in case where a mem_encrypt=off
> kernel is kexec'ing.
> 
> We can also set it on any TDX-enabled Intel hardware.
> 
> That leads to very simple logic at kexec:
> 
> 	Could the old kernel leave incoherent caches
> 	around?  If so, do WBINVD.
> 
> That logic gets applied to all CPUs, both boot and secondary.  It
> applies to all the SME-only systems (currently CC_ATTR_HOST_MEM_ENCRYPT)
> and also all TDX systems.  It would not depend on the current kernel's
> SME enabling and it would allow both kexec-related sites to share the
> same logic.
> 
> I don't really like the idea of yet another CC_ATTR_HOST_MEM_INCOHERENT
> bit, but I do think it's better than adding some TDX-specific paths.

I'm good with that change. I think an additional WBINVD during kexec is 
acceptable to make everything less complicated in the code.

Thanks,
Tom


