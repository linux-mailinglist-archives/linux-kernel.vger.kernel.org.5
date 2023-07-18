Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFCE757EEF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbjGROET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233619AbjGRODm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:03:42 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2073.outbound.protection.outlook.com [40.107.102.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEA0F4;
        Tue, 18 Jul 2023 07:03:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDSxqra+36wP5JsmbEhfJSsoZ6eIi8dAcPcmOMiE1ACRx6mR6dkmliZl7oGDRUo9qK5l2VuHqFpIpi7NuKvqk4VTzZo6eMBCQ8mcRBs4jzSOMOJ5I0Z7rxXrYxqb27pUJsV+0/8qpdpujZ7SH+1M0qVlt5L3TeAcSg+qx2rf272MQF533MvmcbEyXiWQeGDnU/ImK5GSxdoUtbKJ/5h7geF7154YoJz4Ndwcme2TBQKME7HMUYfWZxo4dskwlMFvqAylGdsHP4J+TqbWmujkwL01lKa0zhmDP9aSv2Ed9S008iNpyqJ6ZYBXxcwZCzYVD3Afj2b7gwQpBjxJaCDtsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9pbFsqtQOU2hb8q1rNZaDa5bJjxv8G0U44AX2nHJSp0=;
 b=CYTn25suD7UKhwEy2GX003kmSOryjHoq8wWSGwYpMPcUnKxn4hLsnkhpJ/gTbh32+16QQUduDcl+NASjC3Y6vvdK5LGqaTinpz2VbnSE+6sVYb3wyxkud5hNBIsZlcesR4jXFXv25DZDLJPfT++0UwY358/0vc8Aq9fjAlUwnEepdOjSDs5VPuWMGE40GCLlASaNsy5unToCmjtl4OqT/sRchYEWMH/JibSO7q9hEYSNJiAH+I1pDS5Geq8DL1/OZpFQ0yteYAMGPTkwaBm3ZKR/zOta1hjv7jInLTtVj52TRWGURauBJTY2052CRv/UzH03JJPhmlLkqeMn0QBXaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pbFsqtQOU2hb8q1rNZaDa5bJjxv8G0U44AX2nHJSp0=;
 b=kKNaUzXvObTQrQ7HeFkbPT/ZmoTmrPO9bNsIgcpUhrKKCg2rNs62cxNfwbNDuKp8D6XLTxFSpDgnpCAS82kVykOvmnK/qtVA2332BGMqrQ/JpFEbpySkTv2Nmzi2ti5pb6jFvTDmXzWXudFkvuOeRFoZ1CLL3HMmiAxfYpM3bSA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by CY5PR12MB6057.namprd12.prod.outlook.com (2603:10b6:930:2e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Tue, 18 Jul
 2023 14:02:02 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::be39:45a4:cd9b:4684]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::be39:45a4:cd9b:4684%3]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 14:02:02 +0000
Message-ID: <5df3e976-9fc2-19af-e6b4-e2bea0d64623@amd.com>
Date:   Tue, 18 Jul 2023 16:01:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] dt-bindings: reset: Updated binding for Versal-NET
 reset driver
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Piyush Mehta <piyush.mehta@amd.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@amd.com
References: <20230717112348.1381367-1-piyush.mehta@amd.com>
 <20230717112348.1381367-2-piyush.mehta@amd.com>
 <20230717-explode-caucus-82c12e340e39@spud>
 <ee81e955-32be-66ea-377b-263ee60a2632@linaro.org>
 <e8f48a30-9aff-bc2f-d03f-793840a192c9@amd.com>
 <694a1314-0b25-ff5e-b19f-5a0efe07bf64@linaro.org>
 <cae162d0-843d-ca1f-80d3-5a0dfe1e3d0f@amd.com>
 <22e7dc73-2411-5cb1-6cef-daa5f2af8297@linaro.org>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <22e7dc73-2411-5cb1-6cef-daa5f2af8297@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::15) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|CY5PR12MB6057:EE_
X-MS-Office365-Filtering-Correlation-Id: 01b14780-f38c-4f05-3132-08db87978f85
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4XrgtupLxR1ZFwG/KcLPT7l/Z0Fo68GnRVm4TGfeNrEVH8YcyrsZ8UjA07e2Io37Rmj8NdKapJHjj7VHjGjpDj1hKgwZ4ggfqsfgXbuYdiTbFOgIUCrOPYVDohXFJrCb4IJRk/M6ZL43MzGSPJBaPkLrhiOOeE9gGy4Z1kQP8xTwnkq8kWNBvwpTu+wcuCsiDyqJvU1VoYT7fszxRP5QOcsqRp6dVzpDSlNbzMskKAa8nw4+vrNo1P7gb22sRgRuMhb7U8tkbGnygQQB6tWZwI8poblIiHf+1vEuccZlq8ZcFgcVU4i4UwmV0Rpz+yussYZsPxdFZ854coxiFRhe8GuHjrCrqbDCygwVQTslZT7PArw02rfJ0RKmlVntPMF0eYf3Lyn0D2+ME66bJ8XZ2jsHSbikglj+DmCXj3WFz7+sgausSpJXb48V2hWY29stOONFVx1NIsZbFva6rq6aLq0wc5W/bm+eRSCC08yeBzPo5xvdN2ZwCpHgZbwuVX1gF7psjDJQC6n20gv5UZr12b60+uFGC2G1igLU1hKZcxDlgycCvd4hgIsOr4tk9CjVltTgBBruxc+HU6HgtyIYgivv7Da0rHiKJxYeOxbtkjn3CFmWvBWpFKKvfn7eh/0HCkMSwa3P830hmUkV0qdfsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(451199021)(15650500001)(110136005)(83380400001)(26005)(6512007)(6506007)(53546011)(6486002)(86362001)(31696002)(6666004)(36756003)(186003)(2616005)(478600001)(2906002)(6636002)(4326008)(66556008)(66476007)(316002)(5660300002)(66946007)(44832011)(8676002)(31686004)(8936002)(41300700001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVlkVkQrZG53b3laVDZDS2Y0ZVBPOVZwTHo1c096ajZRQU95U3pYTUtML0hw?=
 =?utf-8?B?NWJNT0hjcHNRenpudzAzK3pnK29hV1d3dGJ4OW0yVWRSQXlMWXdYRm5jUXdo?=
 =?utf-8?B?VWdaYURqN1NGSXFBMjlUYlc5R1AyV01kVitnQmt2aHRUQ0xEL2UrYzJ2R0ls?=
 =?utf-8?B?blJDcGx3ZlRpckwxWlFWeklXc2x6TmNLTUtmWU1aV1dvdmU4M1BYL2w2RnFa?=
 =?utf-8?B?Q1E2ZDdPMUlJRlk2TTJVUkhNRnNNV1NKYnU2dVZiM1hrdmhqS2JBNzU1ZURV?=
 =?utf-8?B?OUN2cXZpRS9IZEFnYXJweGdZUU9QZUJWU2s2a3gxY3B4RHJ2dkRxOWV1dk10?=
 =?utf-8?B?MGZzZGRtQU1xVGM5VjVyQ3UzUTVHN1hDOFRxVlVXc1JodFNxOFBHTlBvU2ND?=
 =?utf-8?B?dFJkNGdWVE5mNmlFS2IrTG5BUjF0ZEl1MGNFRURZTEY4ZUhyU3JOb1RNMTh3?=
 =?utf-8?B?Z1pmMXNWcjNocVpXNWRLMXNWbnAxVCtobTJYaUdVTXYxenZTalpYNlNtTy9p?=
 =?utf-8?B?UUltREt3K3pTZWdLajFCYUZxclhicWJNU1pOdU5Pd1h0U2ZDdFZ1UUhPUnFG?=
 =?utf-8?B?Y3ViY3Z2R2UzSlhmSHZ1ZlhLbHJ5YW5LbmdRMDVYaVFEY2VkSDBoS0FnbFVa?=
 =?utf-8?B?MHZWdUZZZjNxT1JJMXFrbU1TN2ZsTHJRSHFDUDBwdDVwcmhzUHpaY1RBazdy?=
 =?utf-8?B?Y05uOVBvUmhvTTJ0WE1BTXZUV2ZxWVdvREhkTVJORUpYOTFEWm41MStBYU45?=
 =?utf-8?B?dytGaE14U1NyeXdFQTQxQ0hiSjFzcWgyNmR4MFFiUC9qUXBYYVBGYThWNzdG?=
 =?utf-8?B?NzhhS3FKcnMxMlVOUloxT0ZRRmtFcVBkQitraHI4Z3J0TDVLU0pjWW9rdVJy?=
 =?utf-8?B?TGlybVp3K1BVTnBRRkdxWEd4VlZlS2lVOWc4aTZxbmFhTE9SSTRYaWlxOHRZ?=
 =?utf-8?B?QWZIWmJKUys2Q1k4Tk0wZXFRMFgyRmFDYmVXWUdoazRoN095czF6azdUTkRK?=
 =?utf-8?B?eVJxeFZ0dXRMWDA1aGtuSEZ0OUpkSStXbmEyZ3ZPT2UzcFREOG85WWk0Z0hD?=
 =?utf-8?B?ZTlFNmVucExicFhXQXdrZDJLQjNBbEgyamYvNGE3RkVuQXJvaFpyNm1Ebmtu?=
 =?utf-8?B?SmlxWnBoQS9Hekk2cWJaWnZJOFNlaHFneUE5UG90bHJaWWpieU04TFFFdC9y?=
 =?utf-8?B?bEpuREM1R0xHM0h6VS9wMTNQRUV6SWEwRFBNWXdER1krNW9rUzhSVDJoT3hJ?=
 =?utf-8?B?eHI4TGZnYTNTMU8rMWl2RUhsOW1ydk5NWkJzemNNK00yak51Tmcwc1ZsbTJn?=
 =?utf-8?B?QlR0Sk5aZW9nMTduWVhidTB4emR6enNXaU9lVmd5dXhvZXl6WkNXME52azNS?=
 =?utf-8?B?eVpRWWU1d0NHRTlsQTBtM3FYbW56bktZdVduR3hxaGw4ditSWjBqL01GRGxU?=
 =?utf-8?B?SFphcmdjem9yVDh1Wk41ajRsNGgwcklBY3gyTllBOGphYmFrZytvOXhKRHlw?=
 =?utf-8?B?NjhiRmtvcmtzVkt0UHNrUjIxelczdTFucldlSEtOanVsazRUbVJLS2hOTklT?=
 =?utf-8?B?Z1M4aFFYVXJXdisrbnE4LzF5NFZ3QklkV0N4aWJFTW1iMjZzQXFmMm9raXcv?=
 =?utf-8?B?N1JNWVU5d05NaGdNS0NIeDMvUm1seVFuMjcvbWRFWnJCQTUrcjFPR0tIYUk5?=
 =?utf-8?B?NHMremxjUGd3NDRvVkEySzlZdmN1bzY2dEFjQ2dLVEVWb1hEdW15TFVrUEo2?=
 =?utf-8?B?U0ZTU2Q1anp1L0tjZFV2SUJmcXFMcTQvOXptdWdFTzlNQVNqcnNsZ3NWTW5V?=
 =?utf-8?B?dW9Ta25sN3VybXQrTGYzVDBEWnd1Mm5Qd1lid1ZicFJFWkJEWGdVTmNEZkQ2?=
 =?utf-8?B?TWN2TEdCdWtpYjUyU3phUHkvY1pxV1p4NUR4Y2svYzZ6b1J5MmRHWkxGSVRj?=
 =?utf-8?B?Uk1NTkdDUHA1OGRpK3dwLzJlb2ZwaWphUmwyY3Z2QVhSbkFWVUdNWTRxZHN0?=
 =?utf-8?B?elB0VDBsdlp5Nm5FTFBSeE1BRWdvSFhJNzFDUWVMcGJqSDdPZ3ZMcXVBL3FI?=
 =?utf-8?B?c1RYVlB6ZWdMdDRkTldYNjZydm1vTERxTEtibzJtTnZoWWdQRUltSEY2K0Fh?=
 =?utf-8?Q?K0xtJpvEg6HplXic+r1o37Wg7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b14780-f38c-4f05-3132-08db87978f85
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 14:02:02.3747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d5QyRMIUG4qIj24xvU6juyDsGsf9CBipVvxgTd75M11XyRe/K2izhK8A3vafu0qH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6057
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/18/23 15:20, Krzysztof Kozlowski wrote:
> On 18/07/2023 15:11, Michal Simek wrote:
>>>>
>>>> That numbers in DT are virtual no matter if you use ID from 0 to max or random
>>>> values it is up to code to handle them. Checking nr_pins against ID is done in
>>>> core but it is up to drivers.
>>>
>>> No, you confuse "virtual" and "ID". IDs are not virtual. IDs are real
>>> and have representation in Linux driver. You do not need to define
>>> anything virtual in the bindings.
>>
>> Not sure how you define ID itself. But HW doesn't know ID. HW knows only
>> register which you can use to perform the reset. It is not really 128bit
>> register where every bit targets to different IP.
>>
>> And this is SW-firmware interface like SCMI reset driver.
>>
>> Firmware is saying that ID 0 is QSPI, ID 1 is MMC.
>> Their Linux driver is asking for nr_reset via firmware call which can be
>> different for different SOC and that's fine and I have no problem with it.
>> But only SCMI server is dictating that ID 0 is QSPI and ID 1 is MMC. Different
>> SCMI server implementation can map it differently.
> 
> Sure, and all this points to: no need for bindings.
> 
>>
>>
>>>> In our case that IDs are coming from firmware and driver itself is just matching
>>>> them.
>>>
>>> So they are the same as if coming from hardware - no need for IDs.
>>
>> It is hard to say what hardware here exactly is. From my perspective and I am
>> not advocating not using IDs from 0 to max, it is just a number.
>>
>> If my firmware knows that QSPI reset is 0xc10402dU then I will just pass it to
>> reach my goal which is reset QSPI IP.
>>
>> If you think that we should use IDs from 0 to max NR I am happy to pass this
>> message to PM team and we should extend any SW to do translation between.
> 
> When we talk about IDs and bindings, we mean IDs meaningful to Linux.
> Whatever is ignored by Linux and passed to anyone else - hardware or
> firmware - is not a ID anymore from bindings point of view. It's just
> some value.

Please correct me if I am wrong. Description about ID should be removed from 
commit message because it is not necessary. And
include/dt-bindings/reset/xlnx-versal-net-resets.h
should be added when we merge also DT for versal-net SOC.

Thanks,
Michal
