Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2CF7BF9F1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 13:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjJJLkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 07:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjJJLkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:40:21 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2052.outbound.protection.outlook.com [40.107.212.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3375899
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 04:40:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WNQ1F70h2G1RwZFFwlb+eB3gEnAPnIkm+MgD0rhXRDZ4KUU1vTurZCd2C6Kg/2nuZND2iFPcSOabLBohnhcWMJil+EbpRuKAa7zOx3/HkzdDDSpsY9tuGsjbCufO6p7LHD3NrsHaHN5E9eFagB+agSAFKoOopzCtIrsBylc5al6RRX9cYTsFrPhbaBKt8+35+5PBjkWRyroL3EFcy8mW+ZfV0f8TcH9TriOXVp7JIOqaiwGoV24CCX85JdBdJIHlhPClzs3qZrLWT0ru03h/PgyqGN93HWhXnuxQzEAHOGpDt5Nx/Q+o5nfsbPJ2gZZwEp/jJpEWkpxoQa3BBtRVqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fW5U7IziRp3theiEBjEhD+JWtF/kEywxmtnKRgjpVdY=;
 b=hUd4vf93BYyh/mYgHNtf3CsfEY+y2Y3aW34zsjvxyS0FOEITPaUC4uNEUYMyvAUZnRfJStyPWZstwdFTeFIoZfXGDEHD9vEabwvIHmxlkVikTKzmokALxDPpnpXjRreR2C/rhnii3Q+GRbDvQpsy7e76dnBRlJR+3HVMEI6hI4I+m90MXpJJ48R3Dg5UkJBsU5ynwQwypVWT2dbguyj42IK6KEF+82pXJvvzgMws123eQVVfr06w9Ih1eulbiGLM8J3C43iq2etNTG1VYCrue9iUDTiB99sqO/K1VIInrgt0K9oPhnA8nzYHllLvLMsjfzCgW57XnPGB01/MCnxXQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fW5U7IziRp3theiEBjEhD+JWtF/kEywxmtnKRgjpVdY=;
 b=DCcghTMESZYj/nP0ZJ2+RSQexVxmwggvJfvmHTEROnUAQn+2rlTrgNvXMnTznfwdO7GyZNZkS9f/HhZXSzMRofMX19c4gk/G0BIH6tUPi3qM23XmizR96g/5tkjl/dI4vtdU+adYBuYFqntkndVn4Hgf2onT+7OKRHxJlxOO16o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3008.namprd12.prod.outlook.com (2603:10b6:208:c8::17)
 by LV3PR12MB9095.namprd12.prod.outlook.com (2603:10b6:408:1a6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Tue, 10 Oct
 2023 11:40:17 +0000
Received: from MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::74d4:ad6f:f00:8187]) by MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::74d4:ad6f:f00:8187%3]) with mapi id 15.20.6863.041; Tue, 10 Oct 2023
 11:40:16 +0000
Message-ID: <15c17bd5-744b-9ae4-93ae-19150bfb85a5@amd.com>
Date:   Tue, 10 Oct 2023 17:10:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 6/6] sched/numa: Complete scanning of inactive VMAs when
 there is no alternative
Content-Language: en-US
To:     Ingo Molnar <mingo@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Bharata B Rao <bharata@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20231010083143.19593-1-mgorman@techsingularity.net>
 <20231010083143.19593-7-mgorman@techsingularity.net>
 <ZSUX9NLa+DDjFLnZ@gmail.com>
From:   Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <ZSUX9NLa+DDjFLnZ@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0037.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::16) To MN2PR12MB3008.namprd12.prod.outlook.com
 (2603:10b6:208:c8::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3008:EE_|LV3PR12MB9095:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b698af0-a28c-489d-5d8e-08dbc985ac91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AFwxy1ODAA5YqTWJFY12DGiNIc3//3p2gD3Xg7+2sBtVUj0tN0PLsztg32EF2hwpRJ7KcAV/O0N/mKUjCnxld6V4PFBZK5EpiNzmUx9gg7jAQ2h28zSunOIa8JE0J/2pTeSFabjZYOCCNMQc64d9cirgrgXXGlH8DBI/HRDE9UcxwU4kDnvwBGLcyAK9VV8pvJzCpivP8t/omEdvXusEjnuwEFdGRSbB6pCyg+7OC5pRAHPxTCe9po+qwAxWUntcCfBT3zR6OR1bsdidcPtvO7K+aSWua60USFLKTGOzenBPSTq1BlrcTO8yayGOmJ7e9oDtt5hjIfwcYe7epLRe38Qf7Efak1efUb9sHeMhqnIp0Pwuu4/wSLdw9XAM+jV7NDT+L40e9tRm8jifDyMNt/NMmmzIwzBrj3jl53f0aeNGLEo+WWTjE/WglMci3hZQe/HIrwDZyVT2nlMMlqHswiMv/DPa1DXCx9TfBiY23qE1daWZ3CCMj+1yB1XlFYt73tqfjJ448MOeXbEoiTtU91O9KQsAzaj8/lfZ60rL5/Rb7YC0tS14yAFitD6jBbU2fZdalpJldSyxxPE7/bE5hHFoJp3vHqEZ1wslXggvkqDXJPQ3IjR+HqMzOQuSQcobY+kQmQfrAABHJSFfG3Fzvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(39860400002)(346002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(31686004)(83380400001)(26005)(2616005)(53546011)(31696002)(38100700002)(36756003)(478600001)(4326008)(6506007)(2906002)(8676002)(6666004)(6512007)(110136005)(5660300002)(8936002)(966005)(6486002)(316002)(41300700001)(54906003)(66556008)(66946007)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTVnc2cwVUQ4QWh4NkVmZWZ3cnM0VlBBeVkweDhZU1JESjZmdVJ2My9ZZ3Q5?=
 =?utf-8?B?V2ZQOHNFcG9FZHhPTW16UXBYRDRUeUlBNzBVSFN2UVpvZExNQXRrWnFuQzN5?=
 =?utf-8?B?ZmVMLzA1d3F3eHFxdnZEMFF6SGRjc015dk1EVmd0YnA4NjZtTmRYMXYzSUFR?=
 =?utf-8?B?VjFmSU5DMk1OL1VvR2tYdGdBN25pT1ZJVDR2UG1NYTRVSk5sSEpBSkhJeHpQ?=
 =?utf-8?B?WnJrMnJxY1h1U0ZsTklEQk9MWVZpUzFaV2VCc21BYVZRREFWNm9jaGhZT0hI?=
 =?utf-8?B?US9VMDQzVEVCSnVYdWZYSXdMWGF2RVYvTnVRM0lsZlE0RmdkK3JxOS9HQ2VW?=
 =?utf-8?B?WVduWjNFSERuTy9JRkZuSzJKN3VaL2Fqb0w4OWppQlF0N044cGtiTXhqUnlI?=
 =?utf-8?B?b0M4cVAyT1N2TXM5WUU0ZmZpRlNPRE9PelVDbk8vazhkQm84Sm80Ui9hTURL?=
 =?utf-8?B?QThFMlFObFNMVTc5TDNIenJLRjlESmtOeEZoQk9raXY2bkZUU2Vtd2wxWjFt?=
 =?utf-8?B?MDI1WGZjS21aNEVkYkNEQlVWMytRakw1bkVyN3EvdkZ0aGJ5Q2VuRWxBMlQy?=
 =?utf-8?B?YjduaEF4UCt1bkpBcXNOc1BwbU5EaUJJZEdZQldVSERQbzA4a2Zna2pQdHR2?=
 =?utf-8?B?TlV3UUd6TFduV3JUekg4R3l4RUFKWGVKRW9ZU2FQeVRqQ2tvSXNxTUtpTjF1?=
 =?utf-8?B?N0poaEd5M2x4YzNiNm1QWGxrY2xvRFpBR09BTGdjNnBVK0QvRGJxS1pVbUk4?=
 =?utf-8?B?TWFqWnIyMzhiNlM0WUdoRkZ1dmNDUHJGODlORzNhTFJkMWJ5QUxsRzl5QTNC?=
 =?utf-8?B?bzlydEJhNGxCUDBrTCtDOVNaeEVaY2NFanIzL1h1Z0VBTTJLMksvVXBEc0M4?=
 =?utf-8?B?MkNWSmZvSTBpS3NodnFyYlZIdW5BNWxlc1ZERm5rRFlWUURFNHNQZlBTOFQx?=
 =?utf-8?B?QlcycnZJamJLeUtOdFZVKy9JaGZkOG9ydjBCZXhrbWlOMkY3cVNuNXRIeTR6?=
 =?utf-8?B?MklOd2Z2TDlVbWppMEZTM2Y0cmFNZGFKK05ScFpobHBpcTB1RTBOemhSZW9q?=
 =?utf-8?B?Uy9mSFFDRkdobVdhbzBZd2pJRHU1a0ttUlFxb2dxWnd0YWNZQkNSQXUvc1lQ?=
 =?utf-8?B?N1JqK05MNXl3bEZHbmtNeDJvblB1RWdqV0hNNnpSVTMzcFFWNXBleXVpQ3lN?=
 =?utf-8?B?akdLS2pQV211Nmt6WUxXanY4UzNsRG9rOHRyR2hoTXJSRVdXODBuTUtrdzBx?=
 =?utf-8?B?THhGWjVteFU5VUl2S1Uzb1A4VFZOTHR4eHJrQXQ5L0pXdCtlY0lGRXpuRzlJ?=
 =?utf-8?B?UG8wSXI1M3cvZWswdmc2M2hmeitjSFduOHdJKzR1VWZuZGZDOHZ1YmpPR2th?=
 =?utf-8?B?Vi9FdjFNMmZZd2J0enorRk9ZYnl6aDhrS1g5bHRmNnJic2I0TlFmc0p3SEJs?=
 =?utf-8?B?S1JRd0xOWVR5OE1lZnN5SnhudjVLNEw3Q0VyT0JGMXAySWhoU0RXTWpiTDN2?=
 =?utf-8?B?T051L2FkcldEdU0xcUhGSWdBZnByQXdiWGQ0R3ZqcU4xV2c3dmdBV3k4Q3Vn?=
 =?utf-8?B?ZVp0MDlEQTAwVUJNT3VNTTNJWVFCOUlYN3oyVGU4SzhzSjQ2ek5tN3B6eC9T?=
 =?utf-8?B?MEJJZWt0MTNKQXcyTTlGQS9XRDlLZ0ZRME1TbjhveGI0QnhLeHBHaXp3YXdx?=
 =?utf-8?B?Y21sK1dtM1d4V2YyYld6b3pDLzJ4OWpzWWltZGxnOVVJWWxteGJMTUp4bks4?=
 =?utf-8?B?L1ZBM1ZVUVJyK1pEeld1aGh3M0Q1UzNhQUtHeGQzOHQrbnh2a1pHVjB0a0Vr?=
 =?utf-8?B?NkllMEl4K3hnclpzQzU0SlFRZDBEc2xWTU55ZkJrckZrNHU2QUFWVStPZVNK?=
 =?utf-8?B?dGpoRnNWTUZ0clNMSTNBWStUWWxYTkR5Y2FnL0VhVEZKd2l4aE1XU0NmR0xN?=
 =?utf-8?B?czZsL24rYUFOTzZoNW5OSDh4eFVTNU9pYitQWTlVWktPQXI1YW8yT2FyVDRK?=
 =?utf-8?B?b1REQ0JnWVcrYjgvbzVLakMrMWUzM1RWd0JpNlBsd3lKRFZCa1JmaU5BQXl2?=
 =?utf-8?B?U2ZwWVRrSGordkdyNXhnZW5zQVRKVmd5Tm9JdWRaQnIrdmdrUkxRZU94elEv?=
 =?utf-8?Q?vkHFK6gp6uh24sRsjXHp5WKl2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b698af0-a28c-489d-5d8e-08dbc985ac91
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 11:40:16.8801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eiXgo4qiA5piDqVnkx6Mg5Bqy9znrkEtoRc9iV0/eL52VTA3kBLZPobCxHyYn/jJupeu4Bza/QDFi50Fo62KFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9095
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/2023 2:53 PM, Ingo Molnar wrote:
> 
> * Mel Gorman <mgorman@techsingularity.net> wrote:
> 
[...]
>> Both the number of PTE updates and hint faults is dramatically
>> increased. While this is superficially unfortunate, it represents
>> ranges that were simply skipped without the patch. As a result
>> of the scanning and hinting faults, many more pages were also
>> migrated but as the time to completion is reduced, the overhead
>> is offset by the gain.
> 
> Nice! I've applied your series to tip:sched/core with a few non-functional
> edits to comment/changelog formatting/clarity.
> 
> Btw., was any previous analysis done on the size of the pids_active[] hash
> and the hash collision rate?
> 

Hello Ingo,

I did test to understand the behaviour threaded workloads relation to
pids_active[], and that there is more spread of bits set etc, but not
actually from hash_collision point of view since it would work better
for workloads that does not create multiple threads quickly (thus we
have sparse PIDs) as well as normal case where we have almost continuous
PIDS.

But I also did not try to increase size of individual pids_active more
than 64 for the same reasoning of Mel that at the most we endup doing
cross PTE updates.

Perhaps I can experiment when I come across workloads that have 
512/1000s of threads to refine these cross PTE updates further.

However, I have tried increasing history (PeterZ's patch) (i.e., 
increasing array size of
pids_active[]) to get a better VMA candidate for PTE update in

https://lore.kernel.org/all/cover.1693287931.git.raghavendra.kt@amd.com/T/

to handle what Mel suggested in other email.
viz.,

	1. Task-active
	2. Multiple tasks active
	3. Any task active
	4. Inactive

Thanks and Regards
- Raghu

