Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89CDD7DBDE5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 17:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbjJ3QcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 12:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233870AbjJ3QcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 12:32:24 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2057.outbound.protection.outlook.com [40.107.102.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3645A98;
        Mon, 30 Oct 2023 09:32:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3dpY5DZnEkuVRO46LtcYMDCmzuT0bJRYcqR0W9KX0xIOM8TNnctiRzxu2hwJo/f/tK5P05XnTRBK1FvzZYr9ienyqNWg5J3JPGT7K/1H+qAEupCaP4Plvs/iYGVTyv5Tc1fszlfCBztWaZsNZHSBa8KHuFeFWigHRrYTgZ2RNMH/k45FWFnLe1Wgmc3Z5Qx38VdJzkpJRBtEUOW/ulawfio3Uhc2SLQEbdscwe8LxHEh6ds3VWmK3NtN6pgr4pHrwWz+vC54cC2IuP5DrCgxGyUYF7hoocgNCao3GYApLNxuOCFNOYc8uJuqBplxdcgcWZZQxB8uEo0m9AP0CU1iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7gGKrcYCLUv+NDzgTe70wB6s1j166Q9ZseIrLPeMGY=;
 b=P2yLPRiKTz26f/DN5pS3HvPDu8OcGSSUVjl1d9T4mQ4tqzLcG6/MggtOPjhkLrfCfGhTPdS/U1bfSuFy3ni1meoakDMVXDxWgATJiMg5HWPJSQNVEqeDxEks5lNN2dY6Uu9/UHjJvu9ffIltfvgB/m1iEzW6SrR62S+WLCY6JyOQd0OUt6q35zkbsMf6U9Vs6JvPyfNTpHqeDjvb0s0yPPrelHy3mlBX2XENMwneMUiuZBp9MOZET4KWzR65tZPtNHv7lu6HOL9IGArM01hASjoMeaxOcK4q4yE8/Hln0CvB1N/zLM7uAG7b2FOTnkhl6GE1IO7WxS3+rJo7KutEcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7gGKrcYCLUv+NDzgTe70wB6s1j166Q9ZseIrLPeMGY=;
 b=PGh84WxJ3qeR5yCvjfRZifaMb7XyZw3UDH5WoE0oxFnM6nfFnoW3T3ZF88SyfEbjCtCNBnIBqstzT6wu1ab7PiTjzDWrsiQGsB46vdRAEYHMxuZq+XvHTKEwJrE7qndowqKvH56h6VjuDjN1e8Z6rY8ZjPJWbGLzlZvI1MyCosw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3407.namprd12.prod.outlook.com (2603:10b6:208:c5::18)
 by SJ2PR12MB8874.namprd12.prod.outlook.com (2603:10b6:a03:540::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26; Mon, 30 Oct
 2023 16:32:17 +0000
Received: from MN2PR12MB3407.namprd12.prod.outlook.com
 ([fe80::3008:be4:e9a4:2a98]) by MN2PR12MB3407.namprd12.prod.outlook.com
 ([fe80::3008:be4:e9a4:2a98%7]) with mapi id 15.20.6933.026; Mon, 30 Oct 2023
 16:32:16 +0000
Message-ID: <bbffd884-b31a-4e95-8a72-3705745b49f9@amd.com>
Date:   Mon, 30 Oct 2023 16:32:12 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND v2 1/2] dt-bindings: w1: Add YAML DT schema for AMD AXI
 w1 host and MAINTAINERS entry
Content-Language: en-GB
To:     Rob Herring <robh@kernel.org>
Cc:     thomas.delev@amd.com, michal.simek@amd.com,
        krzysztof.kozlowski@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@amd.com
References: <20231026093029.3122573-1-kris.chaplin@amd.com>
 <20231026093029.3122573-2-kris.chaplin@amd.com>
 <20231030154015.GA1141490-robh@kernel.org>
 <df37f8db-a8c7-4a99-8828-3cb123afed1d@amd.com>
 <CAL_Jsq+SMY+C3=e=zbdrP_Ekj3FkRs7QQyg2pqmjrcz_0AvmBQ@mail.gmail.com>
From:   Kris Chaplin <kris.chaplin@amd.com>
In-Reply-To: <CAL_Jsq+SMY+C3=e=zbdrP_Ekj3FkRs7QQyg2pqmjrcz_0AvmBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0258.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:375::7) To MN2PR12MB3407.namprd12.prod.outlook.com
 (2603:10b6:208:c5::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3407:EE_|SJ2PR12MB8874:EE_
X-MS-Office365-Filtering-Correlation-Id: 81a8046e-9bbe-41ed-a237-08dbd965c79a
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jSnu/4O3T+PU0pRcm00L5y/j2LQBrJ3U1w0EgIbTeO/+cznYFV3mXXVt0ztAlk7MtY7fWPf63mPVXNgTYVkJrNf60jLDoAF4c0r4ZBaATUDR1nmYN5p/8TkJ44XyKAJFWx1zgRXsTaJDM1Bt3DX3zrO3Kb8lctxjoBuyInNJIRQncuovQrtO8d29hxftnVt2EcKuR1gtzxiN/sVt2rvAPaxfZTH3p10B3yU0862C5rIwzfhS0mc2qkek5tm5WA71hhI3yfDUTPMUwx3w1hD+ECC7ihznnS6pxqcPkhcTShBPQ4SPhxGBAOFDon5r9ox4Ox6+z0B1Jk3/qhldZoG5rijGwOE9ZocpP650/oTjmdKhDmW7a1uxZ+rV5adFilrcrbtLTajNTR2H748xfCGK8GBVXWcOEBvC8Psf74cPzwknCtpBPeXQo1MYWTFqEURpdplSUXqzXJXXzd1L4Nt3GdTX4SAQLCrzlk0yvCLRaBWD6qL0xeKEqy63W4gqEhElguUxVUXDyC/cEsqRCaAIWosmC3r/i36evvH88LJWWdE8XlcEs4l14yUyMSkrhgTcWEdZXbrBp3b5jqu048UVkOftOFSE9DzgnA9bVHbf8uoHqzhEfvnU67gV5VctOHabSzL3EmDQJSqFG4KWKzAupA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3407.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(376002)(346002)(136003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(2906002)(86362001)(31696002)(41300700001)(8676002)(4326008)(8936002)(5660300002)(44832011)(36756003)(478600001)(31686004)(6486002)(6512007)(38100700002)(6506007)(6666004)(53546011)(6916009)(316002)(66556008)(66476007)(26005)(66946007)(83380400001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUFpMzFPRy96N2RPUzI2TUF2cmQ2dVZxNWJQOVJ2OE11TTROdDFtYlVQOGha?=
 =?utf-8?B?V1ZONmgxU0VBZ3pUM2hnenhkNi9HRmliNGFKUDZyaDlFMkJ2M2FpczN6M2d2?=
 =?utf-8?B?eGhjR3pMYWJvdG5zK2R2bkE5KzRtUFRiV01jZVo3K1VyTFkrR0ozSjdkRjFW?=
 =?utf-8?B?Mmp2U3dUS3plbHFLNlFqYmRYWE5tUWhxL2FvRE0zSVFBM1hHeE5IV1hQWFNw?=
 =?utf-8?B?TTVlQVhKVkNNMVowQitNQWluRlc0YWx3OGdXUFpuYSsrSUpzMXowU1MvRnY0?=
 =?utf-8?B?Z2p4SHlocmNkOHR3YVcvQ3Zua2tzYzB1Q2Y3TDhQT2dXNjN1Z2RLQmorc1JJ?=
 =?utf-8?B?U2hvd2FQTENQajVoeU1LRU1iMU5EZmZpS2wwVGlHK3ljWWV6dnRnbTlQK1pX?=
 =?utf-8?B?dW5na242ZmRRdnZWc3pyYVMzejlDRWVOWUIwME01L2d2Q093ZnFwRDJqVGlD?=
 =?utf-8?B?eUJObkdyYnpKS2lVbUc3aFFFam9BRzl2R0h4ckMxR3pUY2xybFU2VXliRnJR?=
 =?utf-8?B?SG41T0xBQ2hMbDhrQlhFNElWT21lTEMrcEZNTldTZmdKOFpySWhzZUtKYkdt?=
 =?utf-8?B?OUh3eWhjNVhzTDVZTVdPOXF1RytBZlRudnpsTkxsMCtwbWE2Um5HK1ZyTVVH?=
 =?utf-8?B?ZkFTWlRCakZZVHhMMlpFMnY4eXJOejVJVC8xNi9UMUlHOTU5VndYZFdMcXFh?=
 =?utf-8?B?Z2g4empIVkdVRnFLbWNQb1NxY05aSlJEVHJYa1RpQ0F2SDZMV3lYb3Y4U2xX?=
 =?utf-8?B?ZEpUVlMyeVZ0N3RRVTl4WDE2MFRXbFVLMEl2akZIUXMwajVZT055WVNpRnlw?=
 =?utf-8?B?Q1BNUW1BQk9Lci9LM29xL1V2RUd5eHVuUEFXaUZoSnUrWTJjQXZwWEQ3dFU5?=
 =?utf-8?B?bHNDL0xJNUNyanBSczN0cEUrY3BqQWd6QkVqUm5RSXBnNTdGREFEdTNCUlZG?=
 =?utf-8?B?bkFZcGtMTjQrRUxEcVNVNllBRlRnTGFlbzRVbHF3bVBtekMyazFSSGVLTlFU?=
 =?utf-8?B?MWc1TCtJK0FHY0tGVlJRdHVQaXFETzNrR3lKYjdmaXpvMmN2ZUgwVDA4U09m?=
 =?utf-8?B?dndYWldwN0txcFJNdXdwMENEQWRVcGVTNmdmK3hUbzh1VmpaUXRpNUpaOW12?=
 =?utf-8?B?ZklBRkduRzB4UlBuVEdmVitxUExqNWtxY29Pc3UyQmJYSnJHRkdLTUVyZmxu?=
 =?utf-8?B?VUhvY1ZXNUJhVmlQTnN0M3NBeXJ3YUNqUlFSdFBTbzZqQlBFWUJmSUVZTW94?=
 =?utf-8?B?ZWNianJnM2FCclhmaTRaZUNZNitPUmpOWGVSTnd3Nmh3cUtOSUE0aHV3TFNG?=
 =?utf-8?B?dHVJTDZKdWxCZWcwYXpqTzVhaUx5SHdtdmdWdHZNQ1R1SkRYQmVqZXVyUWRK?=
 =?utf-8?B?Yjd2dWlzS1pQSHJSa013ampiY0dQR3BRdHVZeTZOdXVCNCtIUlRzQzd0OVFp?=
 =?utf-8?B?bWYyTFc0ZTRLaENVTWR1NW1qYm91VkwzYzZ0MGlYVFA1OHYrOWZDNW5UTUQ2?=
 =?utf-8?B?UENCMWF3c1hScjc0eE9COFJYTm0zckVwZXhZUnhyUklwSjdLT25wSTJTU0gw?=
 =?utf-8?B?YjJ3MzR0Tjl1bUgyam5MMVNnR0hHdTRrUVNETmdpQlhYZXJSb3pGNHd5VktY?=
 =?utf-8?B?V051T3JQdmR3WEhjcTQ2eldRK3l2bXhnTGxKSnowbkJqRnY5My9CTGFPeDlB?=
 =?utf-8?B?a2RQUWVtOGZ4QWJqMjZqWlFFSUY5QkhvOWpSRUdpdzJmdFNUb1ZiVzdNeUFF?=
 =?utf-8?B?SXpmalp1WWkrdTB1SmdteUN0djFwL21ZT21yMHBGN1RVNzBUWFpSOGpKZWRt?=
 =?utf-8?B?cnZLQllyVXFKRGx4OThLSU9zUE5EeXZCNmdvd0F1UUczbWZ5S2hKRkIvVUho?=
 =?utf-8?B?K3JoVDBaMVdDRG85L0ljak11N3FCLzI3aWwwc3VzOEdJSFdBazFZOG4vMFVU?=
 =?utf-8?B?dzg2RThyTS8rVVk1dFF4dnExTUZMY2FRYStyam8vOGV3clhybEtIUlB2VTlU?=
 =?utf-8?B?Z0RsNjZ4YlBWdGl6c01oQm9TNjQ5bFdkQ2V2M1Y3TzZJZDcxUSsxK2REQmgv?=
 =?utf-8?B?aHBEb1R2NkZZckZkNHVUMmErODdwRnNsSytnOFpJVExqc2g2NStZbldpU3BL?=
 =?utf-8?Q?lGx/1vIxxcAkttVKzrYLiLO8V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a8046e-9bbe-41ed-a237-08dbd965c79a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3407.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 16:32:16.8596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lkY1OAQmwWRAciS74vms81amksPYp0foaOxua0OENzn0jh9BCouK/KqmHg2ic5oQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8874
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Rob,

On 30/10/2023 16:19, Rob Herring wrote:
>> Is there a device side implementation? I can't really imagine that
>> 1-wire would ever be implemented as firmware on the device side given
>> its limited nature. So adding 'host' doesn't make this any more
>> specific.
>>
>> There are slave drivers as well as master, although these do not have a device tree binding.
> 
> My question is whether there is slave/device IP for implementing the
> device side in software? The slave drivers in the kernel are for
> handling those devices, not a slave side controller interface.
> 
> For comparison, we have SPI slave in the kernel which is for
> implementing the device side in software (running Linux or another
> OS). There is no such thing in the kernel for 1-wire and I would doubt
> there would ever be a software implementation. Could you, yes, but
> given the limited nature of 1-wire why would you?

I agree - I'm not aware of any such interface or plans.  Yes - I've seen 
it with SPI, but I've not heard anything similar for 1-wire.
> 
>>
>> The IP device from AMD is called "axi_1wire_host", and so we are hoping to stick with this binding if appropriate as it relates to the IP name.
> 
> Okay, I suppose that is good enough reason.

Thank you - it does help when we can align the binding and IP name.

> However, the versioning comments in your first v2 have not been
> addressed. I believe the conclusion was to mention the IP has a
> version register. And Conor's R-by tag was not added.

I messed up with not adding a note about this to the commit on v2 which 
I can resolve in a v3 - yes the versioning is via register in the IP 
core at a known offset.  The binding name (and IP name) changed between 
v1 and v2 (from master to host) so I didn't add the review tag for Conor 
in v2 as the commit changed.

regards,
Kris

