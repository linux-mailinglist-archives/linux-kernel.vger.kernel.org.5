Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52CFD7594B9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 14:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjGSMAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 08:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjGSMAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 08:00:18 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78F5C7;
        Wed, 19 Jul 2023 05:00:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XCPvLteA7Dawzg7rZeud+D07kU2CzbWTbNymjerfL1AxpYzJ/A9gvIHSTNg+bt5jRMrSnNR63+Q1kabyqCgI9jS9C1Wy3eGULmIxWHru8ATst5ZlP1rvUP/KChq9R3Ttk0CIolLpNEEwgO/lPMdXaE0UoffEJ3FLC3s7oWk4AXEN0MLbhv5guEX/A/6PP5d9imUkUCNzbxuXobEn/A47kFhHRwOR10h0YENX/c1O3XgH+miAkR8pZT6cvDjoLi+eoSRmLyHBqcjkDMrPvod7tSe8wt2Qt6ts3av6LN/F6X23Y3/ypzY293Jg+R0WEN3YaxslwXcOUhm+Bb8qbCio4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+aWWqpUAzaQzcj1qulMugTvDmTXZSXYL2fIsGji8j4=;
 b=Hbz6pHAk1Ua/jSbsRT8VlCYDZAzm3WKQHIcayxaYlR/vomT+uHTcN/dE/Iko9v4FTddfZ8QSkYzDzz1fTJFONsiDBawN0LMHn2xb00r12qYACqv8WtGYZuV4q8Ig8iovfG+hzL8qwS5eS1QSn7z9c36R8IgY6HNQPPCnGxWT+0QeZczv181tIe9WEOMcoQXNGzRDCWDXDk5gJwrKGDuF4NUPLSVXGabDsOQOi+uRz0VrprhxAnOwYG1l+kt7YnhZ2L+e4rfO2olRy70dRX5vxZ3aepvnK4jsi9KRCeJOnK80XluWUkRHYaVcv9LNODj/TuMwoFRqKgolYgok0SzK/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+aWWqpUAzaQzcj1qulMugTvDmTXZSXYL2fIsGji8j4=;
 b=QlQSDhc1jA3II5fUwPZVaXnF4KMFxOR2vhHkuHxNvYMbt5D34z8wHDoWDAmsdb+EFYpDDqawya9pL4gV6nao0oVUYFGQhZEyY1uUZHlb3tHcxqkb9m1YF1pa4K3hxMZVvSu6t4vZCb/BRJTtZ9ve/WqXbCIwbNtcHSSJ6mYjnP0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by SN7PR12MB7204.namprd12.prod.outlook.com (2603:10b6:806:2ab::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Wed, 19 Jul
 2023 12:00:12 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::f535:4eb5:f7a0:ebac]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::f535:4eb5:f7a0:ebac%5]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 12:00:12 +0000
Message-ID: <3273e3fa-52a7-ab23-b64f-217cc410915f@amd.com>
Date:   Wed, 19 Jul 2023 17:29:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] x86/cpuid: Add smp helper
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        eranian@google.com, ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com
References: <cover.1689748843.git.sandipan.das@amd.com>
 <827723d8f506411700c68bccc5072ec8d918d2de.1689748843.git.sandipan.das@amd.com>
 <87v8egwe9l.ffs@tglx> <87mszsw25c.ffs@tglx>
Content-Language: en-US
From:   Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <87mszsw25c.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0015.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::20) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|SN7PR12MB7204:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c2fdae4-39af-4c3c-9916-08db884fb4c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iSitX1v4JrHevYPKoHyUV3VZS0hgKDM9VZ1lW5QE8Ig9BZSMCO+NDjcQKhgJncRjUWx+4j6T2/xW0isDSk3q0qmdKc4PzICmgSjvdNMnQbVcYQsCLn+Hx5UAdWKL+lay0f8ouCCqIcj7Ks9gM8kgL3FOrqXRU65W7oLLAB+BnDdkBIB/xsZK0KQF4tluRmQCHD/+sup0aX6qT5zE3n2IOH0K5K50iCCvvj2MZttx0loOr2UcP9ao+woihgWCyIMq6WsNXUHah7ouNWj0W8n4uQ8Ye5gBY4ALzuusr4zkX8Ecijr9DTEFIlVvUFTSg2dK7IhIzSRm/EPJhOgpvjz/5cKNGziG56Z3UmTykBopmkH5oJHLCzqvA4Cla9foncIcm399sqpSGxNAP/XCzX73YBEs/atcjJ3pIOs/P35BuInwaGDT5/1ONEkB/kCOU1KK/H0FZv24kBhS2QgPElsr1i0adhmmu7rKjjLM8TO088KOXl7RTg84yZhaHfqKMCXnOgWOlWPjmOh/apaQp5qYl7Ifko8fSqfgnFi19RkbW3VoIQljGPukFfsQdUneoEL/VLiDCYjg18P5PgQev1D0dartSnBZ73DS8sIy7rJMhn6tlh8G/F9NO11KJk/HTRz3xjcs2zhNMFTLjTCuiwmtPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(366004)(136003)(451199021)(53546011)(6506007)(26005)(44832011)(36756003)(38100700002)(86362001)(966005)(478600001)(6512007)(31696002)(2906002)(6486002)(6666004)(31686004)(8676002)(316002)(8936002)(2616005)(5660300002)(83380400001)(66946007)(7416002)(66556008)(4326008)(6916009)(186003)(66476007)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2E5RTRhRkZ4a0tpc3ZHeHdHd0ZVMjgrY3Q2Z3R3VVZZSHRKWDNtLzBxeUxo?=
 =?utf-8?B?ZTN3L2NrQTNCNktEMWprV2NFdFBEVlRZWncyb2RVc0svT01UdEdkUHR2WVJT?=
 =?utf-8?B?dmJwV0ZLRGdWejltN2Y1YktVRGtYR2ZXdGJ6VzNpeWFkNTJ3TzMvb1ROZXRU?=
 =?utf-8?B?Ti9kOFRSeEEzSzdFakgvU09XeU01UUFRdzdlcnZXNnJBUFhPdXIrT1VHMXZL?=
 =?utf-8?B?UGtGdXZBc09TcW9JSHRJTktwUCtCdTNmZnk3dCtBMlQwMWxlT0QybHY1bFMw?=
 =?utf-8?B?c25DUUwwUG1Ndjl1VGxwYzdpZ21TVWVhcXdCNndZZHF5SDhOdy8yYVdwYmR4?=
 =?utf-8?B?alROV0h2K3Q2Y1llUVRHbEF3YXFJdEIvbGFxalFHcFlIdk1QT0VuSjdoR2Vk?=
 =?utf-8?B?VThXT1NIcGpSSVlWcTZnVGloK0tYbm85ajlHd3F5b0xJZEFhbkNxZkNISkF5?=
 =?utf-8?B?SmYvUEExVVNxTlhMYi9OTTl4Vkc5eUNwa25uaTcxUzNKT2RrTUhSQW5OUmlu?=
 =?utf-8?B?UHF0TzJGQmxIY0FVb2N3bmFmTkZ3VW9JK3ZGNDAvYzZkR2R1alk5YzFlUm9K?=
 =?utf-8?B?aG5KcS9NdEdHTGJiY0VETnlONHQvM2FvdWpZN2tpVTd1b0VJaWltM3pwMVhN?=
 =?utf-8?B?MCtIRjhDVVFIb3RvQnBNM2J2NUZ1Umw1a21JVG5GSzhFV0FXOEtQMkRZcm5n?=
 =?utf-8?B?MVpDSGRrZzgxSDRCbTUrK05ibFpjYlo0MXVUQVlRSGx5Qkl1dzVPNGs0a1N6?=
 =?utf-8?B?aDdnRzJ2U29YenA4VGdvV2J1UThLOGJrbmR1bG4wWkwrdnlNTVQ0emNPMkRu?=
 =?utf-8?B?MWhkMm5RNXkwVFcvbE96Wk0wZzM4L2w0OWttTVhMRTExNmRnb1ZRQ1NpY1pv?=
 =?utf-8?B?ZmRtdG9idmRlT2l5OE9yQU5aUGt4QzJCRVRjbENEbmdCS1JYVkkyNW03UlpC?=
 =?utf-8?B?ZHU5ME5kWW5kSU9id2d6NEJhSnNUWnhiTXFmTExRNGRxNHpjaDBmL2Mzd1lo?=
 =?utf-8?B?ZTE4cGVQRUlrN0RPbklnV0FuTVBJY0JhWVpyS1NOSG1VMDJBaWNjM2xYdEQy?=
 =?utf-8?B?cFV3VXY5RElTTmR1bEE1YS9lc2YyYUlFVXNhazQ4Y05oTTc1cGtic2JrbGZ5?=
 =?utf-8?B?LzRJVmR4ZnhRZldJcTU0TUpoU3owdE1keEhMbWVmaGNLS2pmOVlTWUVoc3Nz?=
 =?utf-8?B?QlhSMVo2M0lwWUpybElzYTEvUlcwbkdMM3pPMFFnMTFUcm0zbU1DQk9Rb3d3?=
 =?utf-8?B?SnlJNHRqaWN5SVEzeHNjWDVaMzg0Zm43Y1hDTmVRNDJkelJyd0VDWStkQWV6?=
 =?utf-8?B?RkM2RnE5aUZieHlRcytvUXZHcDhSdDJhUUxpS2VrbEJzaWdwNkJTb1F4Ymtr?=
 =?utf-8?B?dnh2UDY4dEdDSklsTXFMaUFndkEzR243cFg1UVZzNWNuYW0rZ1FESjlQNGFq?=
 =?utf-8?B?cWZKREhpc1ZiRlhFaWl5NysyZXZzOHE5NC84VEl6OXlhdGFZNERpSXRHNlBW?=
 =?utf-8?B?NjVKbEdJbDRPZGVGTFhkWmx2VUhtanQ4ZGRIdEJzZ0c4L1hMU3J2SzFEd1lR?=
 =?utf-8?B?aVdQZFFjZXlkRGwrYXpsYnhyVzhvODFKdW1mbmowUDRZZ3N5L1pEUWdZSXdx?=
 =?utf-8?B?RmdGaERjTWVnVGMxb09wRDlLSHNYcUtKUldpYkdseEdlcTd1bFRZN2JqWGIr?=
 =?utf-8?B?VEk0QzVqakMyOHNrQ0dkaDU5OGozVTM2T0JnL011dEdVWVhDYWdjVE9XREhX?=
 =?utf-8?B?eEgrTC9kbEdPRm40ZkJxOGtxS0RoV01NbG4wVUVRc2R6bWx6c0NkRlhlQWZq?=
 =?utf-8?B?NmtOQXVxb1RvbGtnYlNqcDBvcEVzS2t2elVYNGREaUk3cmFLYXB0WHJETWhQ?=
 =?utf-8?B?eWRzbGY5QmtYdXhrd3dWeUJxV1NyTGJNTm1laU85SktXUmg4eUZzM0R1RVdM?=
 =?utf-8?B?aGZtZzhGbE5hNGFZdUUrR3NNMXVOc3dtNWg1bnAzRSt4dzN1b2hDcHdtQ2Nn?=
 =?utf-8?B?QWUrM2dSY3dvR0c2YVl2cEZWa0x1dWQ3N1hQcHpUTklmaFdqSVlEUlpXWk5a?=
 =?utf-8?B?cXFqcE1PcTJSeTV5aXgxdUkzNm94NmR2TDhyRExmdUpLbjRxRHIyeUdnaENz?=
 =?utf-8?Q?iLACXrXqpAeYxA9E/FsDiyvTT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c2fdae4-39af-4c3c-9916-08db884fb4c5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 12:00:12.3667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TgWwTWP6kVWHWdBPB/Zj7/E7QKfm1TFNwfEWQaBbwa30kGmz4wRVG2i3oeDwRkSzYwMMb4H0uUoEhzuAIqtnBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7204
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/2023 5:20 PM, Thomas Gleixner wrote:
> On Wed, Jul 19 2023 at 09:29, Thomas Gleixner wrote:
>> On Wed, Jul 19 2023 at 12:25, Sandipan Das wrote:
>>> Depending on which CPU the CPUID instruction is executed, some leaves
>>> can report different values. There are cases where it may be required
>>> to know all possible values.
>>> Add a new helper that executes CPUID on a particular CPU and returns
>>> the EAX, EBX, ECX and EDX values.
>>
>> NAK.
>>
>> This madness has to stop. The correct thing is to parse the information
>> in CPUID at the point where the CPU comes online and store it for easy
>> consumption.
>>
>> I'm in the process of reworking the CPUID and topology evaluation and
>> that's where these things need to be stored. I'm still fighting some
>> nightmares with the already existing mess.
>>
>> Look at the mess people created over time here:
>>
>>      https://lore.kernel.org/lkml/20230717223049.327865981@linutronix.de
>>
>> No need to add more insanities to it. IOW, this has to wait for a week
>> or two until I settled the remaining issues.
> 
> Actually you can do that today already. Either make it part of the CPUID
> evaluation or use the perf hotplug callback mechanism which is invoked
> early on the upcoming CPU and read that CPUID leaf.
> 

Thanks for the suggestions. I'll start with the hotplug callback mechanism.

- Sandipan

