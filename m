Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519FA7901B3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 19:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235311AbjIAR7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 13:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234753AbjIAR7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 13:59:38 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8BB92;
        Fri,  1 Sep 2023 10:59:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHQDCkN7dgOyyNBQGWNb75+e8d0+K2RVsaxYEKT5Mz6TGWkc9bkE7vFOenqS0PEQPIEXaYJvr0nToIS2Ki7HKzy/6kMgz+r79ypKfZRRVmyAzysQPjOlBqqESl1FZ3XzDwiEmW7fz5Z1cy8DSDCrC9mJMTw82G07XbRr3TnFrisv/dWiHNLAm6yHUsTxr9BZFA00MCuGbaKiU3KlalkDG8EhW6cYNVtjFWv2frkaXrivsyBvmuaBUjmEjLI1+9/9RHmahm9uj2XCx96UbhtUz3x4dOg4iNUVANzJSLocO/AGljGQI7AwseMcqJZ4eMg8rigrrzrK9CUjTzc/l3e2ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KT87Rcm1O6FCR5hQCjYu5Ctiuw3IN5l6+0lVlHUutwQ=;
 b=Tk8HmrUcTzTleYfH4DkAtr/kl6QKCCwNyLZTyLMUfPAXhnvZY/T2a/2kG7J/dFi4gR4Tb4t38ksb6E8uKipJ3F4lZVVoRVl5drfZDMTpGvuUjXKPK/yhZHZe/Aemf7vQFWSu5Y7XDAI3a3a63kkbtaRN8U4pD/7XuPY397CF5m5dqRl4vpr0C7yYqvBlLaU4dAvM8V7yhC3obxwP9OwPhKVEVhyQeo3IQXPzObCF9+X0y88rkADIniZZJIAUkPA+xJT44qFdIizyuilPa+BxFsgdoJ9pH/Qkb5mbSLTSiTgBgKAixBd2bbGzcFnwxJkSmgzG2QYtFx3Tny6DRmPWCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KT87Rcm1O6FCR5hQCjYu5Ctiuw3IN5l6+0lVlHUutwQ=;
 b=K4yhMoXJB7Cp5m8oJ1Kdux2lMshlVw7tDwIoRAxfXINWnYHy5ufHSqaCJZCFRpZ6kI9cGlJnc5JHuLTimJ/LLbVwsoC9Kmj9lWwHssgZ4TNSJomFI4XG5xeYmFQpNH/PR38oMsvAZ2AiEYHRohgJvLUrWJ9jpV4pdno64crLg2MmV3LOsG4mXb36dEhJl/OymlYqIKUvEG/Z+aqeU/9jigPZzEbb15E3RYMHHDXKeWS/pNDcuiUTAVK+RMjuzUJe+WUjRi3+RbOb5UBHw9bJex6ELu6M9L7nEZGRElK6j6ofDmPi3N3eoS35DaMNO5dCEMpceaORfLJScZSz8gly2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Fri, 1 Sep
 2023 17:59:32 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::1d1b:2ca4:1600:a865]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::1d1b:2ca4:1600:a865%4]) with mapi id 15.20.6745.023; Fri, 1 Sep 2023
 17:59:32 +0000
Message-ID: <8c26f493-76d4-086e-c353-2f60a4ef7a72@nvidia.com>
Date:   Fri, 1 Sep 2023 18:59:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [Patch v2 2/2] cpufreq: tegra194: use refclk delta based loop
 instead of udelay
Content-Language: en-US
To:     Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     treding@nvidia.com, bbasu@nvidia.com, amiettinen@nvidia.com
References: <20230901164113.29139-1-sumitg@nvidia.com>
 <20230901164113.29139-3-sumitg@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20230901164113.29139-3-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0163.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:347::13) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|CH3PR12MB7763:EE_
X-MS-Office365-Filtering-Correlation-Id: 1308b5ee-f6bd-4aa5-6793-08dbab1531e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LZJg6jG94BWKbRKjz8fCQBPQ4ayaZtfMTZUmsR5VEHJQaDnfRfNhrDABSMKzbxCT+tKbop2Gvq49vJ8R5zdGUoqBu9Gyx7SMLbSveh2AGoSqAGXqv3wde1Bxa7K5BfI8neMiSNf5ArgI/0mOfuDRu+LmG/nGencMPWhu4izcdbTIVkvSRkB0n0kkI/SC69CT7/jukazb4YVdDEHnqdkVTv8hojd3uw+DYfs+Q4P0FFEygjv4zo9a5+2dsOCsFo8tYP8N6dO+kvY1+sOOhxG2SsIQEzl87SQKve+Lkauoa2joT5EzS+4Okm9FYHL3awf7gGSZyN4exSk0JLJ38uUnA9RLqUUvziWGaBtqkqdk2zArsXR9sLEXMRLVqsHma3Pkym2lYIM6Yy4T5V0Uv3J0eWpcKkVlSvnLm4ETvT3ZeCXOl2C8X3TuAUoS2hQsdVSGHdruVMI7GI8Cq85jQiiOmaTa2am8iz5NCGaJRibKJo5er1FtxXGIRI7zMO7vpw1tG6UScFrxfVjxABNUlD20AkewEH7249mfhPLggmErAioVDcaGb4nlsA/ZXXkBGRzfZsOH6wR6KJELv6MmqJNzkpwkws0Muo7MxjNpPhXtPyESIegVbPHGBbUCfObfyw0V3e3sk5Nybo7m3zeGaqM9Ow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(396003)(366004)(39860400002)(186009)(1800799009)(451199024)(478600001)(8936002)(6666004)(55236004)(66946007)(53546011)(31686004)(66476007)(6506007)(66556008)(6486002)(38100700002)(316002)(41300700001)(6512007)(31696002)(86362001)(8676002)(26005)(36756003)(2616005)(83380400001)(107886003)(4744005)(2906002)(5660300002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmJTNXM4VkV2ck5meXVFSE5GOTQ5dUJ0MHpBNzlFL1dUaHExTkhDTGp1bFZj?=
 =?utf-8?B?Mm9yUytMb1dmeW5GMnQ0QStDY1RoNHJyUXhXOGxJdks2VDRCK2RZWVp6aEVY?=
 =?utf-8?B?Wkt0QXhaUS9hMFRPcGp4RHdLYlN2YUhIZzA4bWtjVk5xRmdRcXFvc3dCdndr?=
 =?utf-8?B?Zjc4eFhLZWMvbm4rc1pqZTRKTnRPTDBuTE1Jb0FDbnJBbVlxVm9GWGU2R2Fm?=
 =?utf-8?B?WnBIUjlRQW5WTnBvSDRVUklSQXIxWUhBeWNVOWZma2JSU2xZdGpqN2JIMEFE?=
 =?utf-8?B?YkZ1ZExEQ2liTDVXcUZVOXI0ajdBdmxlaFBZQnFheVppbTlEOEdVOG92ekph?=
 =?utf-8?B?N0RQTDVxZjVPTllwNjZiMFNKK1NUdXozQnlNS0hzb0hDNk1TR0tDVHVtT1pz?=
 =?utf-8?B?YklRcGcybDR6ZVJRa3VKY2hsOW5VU0JNSUZCM3g2Zmh5Tnc1cDdkNldvaWpo?=
 =?utf-8?B?bDk5VllPZHlxellVdVFhc2duYko0VXdlQUFNNDErSUtrT1BpZ29jQU14Vy9T?=
 =?utf-8?B?dXQwcE1OeUtQSEkwbVhoTGRBcktJRWJua2J5Y3djS2k0RkgwNzFCWEcxdVpr?=
 =?utf-8?B?Q24rNUpvV3dRZGh6aEdib2pYejJkNEV2YjRzenBLSCtZUy9lUm1yRHgzNEw4?=
 =?utf-8?B?SjZJK05sMkpTRmx5RElCTTNScGNEZ1d0YmJxcEtYYjl4VWVwRDUwNjBQbEJQ?=
 =?utf-8?B?WFAxUnhDWVBLSUhzb1ZKVWEwSUpWTFdNa3FNMWZ4bnpDRWtub0s4TDZrWDJJ?=
 =?utf-8?B?aGZvTnc5ZkRTR1lhcG8xa2pwZVZ5WnRVbEM3NEt4anJkNHhTS21RalltQStP?=
 =?utf-8?B?UkE5SWtHUlEyZEpMeW12KzFLSGdiVzRjYk5Xc0lxUCtQUHI4TzdJQTJ6OHQr?=
 =?utf-8?B?TU5UejA4SmExbmc2blkvNU1EZXUwVmxWZWNVZk5VZDZ0azE4V0N4bjdtTURv?=
 =?utf-8?B?ZGtHdFdsVzBncm5pVkVjcXZJL3QrNHZZMFFDcDFyeW1OWjlZc0ZudGRwalhu?=
 =?utf-8?B?N1NTUzZ0NVF3bVpyLzBBVEtkUU9SS3NYQjFrOCtoZUh6a0RiYmVwdStuejVn?=
 =?utf-8?B?MTFKRG93cFViRDZHSUt4VjRTYlNTK0l4bEVSNFJRVUJLQUZNQkYxS2NSbDFm?=
 =?utf-8?B?NU9GYkQ3NzVqV3JHdXYzdXphSi90YzdqOGJJTzhZeWd6OGFMeDI3YXEzNjl4?=
 =?utf-8?B?VU9KLytXQ1dhTnY4TzJjb1ZQY1pJNTR2L25Md0NObWxvTEtyOCt2RDVlL3Ux?=
 =?utf-8?B?bzB2L1ZOUHdmZ1NVOEVFMHFudEpKNEZxUWFDeGJXNFdYcCt2NlhONkZCK0hQ?=
 =?utf-8?B?QzlKTU1zSHlWZFdleU14SEViaEtFWGE3RWxOMmx2OCtUWVFKZzBkMlZ0eVN3?=
 =?utf-8?B?cHRqcWxOcm8zdU5wWWZzdEdjVXV3Z3RGcEc0UnpBTmN2ajJDTjIzNkQvM0RV?=
 =?utf-8?B?bHRxRVhuVFhNZCt0SExjUmp2YTlkWEtBN3pOSmdKZlRrWlAzL1EyTXFlUDBD?=
 =?utf-8?B?cG5tUzBFaFpJamZ0d05EN0ZPV0hKTnFScnc1MkFCTFhySFQ5ckZrYmFGdGph?=
 =?utf-8?B?RUtVNWgzd2lzT2x0Z0M0K2ora0JWeVNpa1lWc0lQRlVSWE5mTHFIMU4vSmhN?=
 =?utf-8?B?M3k2VlR5V0NZWnRGRTVFQVViaTd6UlVHQUVuam43NVVSNWQ2VzFrUUdHUkNX?=
 =?utf-8?B?aXpPYXRaZjRLd1lJOE4vSldTN0JIbEx5RWVlM1JJV1N4R1NBTEY4bEVzdzE3?=
 =?utf-8?B?aVRmakNkTk9wQ0VaMWgxUkV0WjNCNE9iWktWNFA5TzJPRm4veGZWQWtHekR4?=
 =?utf-8?B?VU5tVGZQU0c1aDBQakFXTUZPbkJpc3ArNUh5V0JTWE1ZVnROeXlVNjJRQ1JC?=
 =?utf-8?B?elY5cGtNQ0ozdU96czFLL1d6THFqdlR6a1NpQWF5bS9WUmpYV1grZlR1MUdj?=
 =?utf-8?B?NEpVMHJ1bTk4MWxSRmdyZUdoblh1TTZpTUVrRnhEL2U5aDdSL1B4VTlNVU92?=
 =?utf-8?B?WEdCRXRGQWFBSWhYaWQ5WGpNUnhWb1BRRXlXNjZZbUljQkpvSnRTMWtnVEVn?=
 =?utf-8?B?aGFpbDdtL01Xa3U4d3RCRWZVc3JFQkY5MVd0eXEzb1o1QjJNQXNMR3RQMWNV?=
 =?utf-8?B?bFhpbmluVCs0bVVjQ2JvZGprT0N4ZlFETWJnMS9MSEw0YlBMcVBGcWhxUmRQ?=
 =?utf-8?B?S3c9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1308b5ee-f6bd-4aa5-6793-08dbab1531e3
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 17:59:32.4042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UwW3D1lfGfYpop29bwMTO6zKYOoMTKbidFz6PMVDV6O34v+ewwYe6zlnlKlLmTW072A5B0CTJR+cwhs4fhyoWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7763
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01/09/2023 17:41, Sumit Gupta wrote:
> Use reference clock count based loop instead of "udelay()" for
> sampling of counters to improve the accuracy of re-generated CPU
> frequency. "udelay()" internally calls "WFE" which stops the
> counters and results in bigger delta between the last set freq
> and the re-generated value from counters. The counter sampling
> window used in loop is the minimum number of reference clock
> cycles which is known to give a stable value of CPU frequency.
> The change also helps to reduce the sampling window from "500us"
> to "<50us".
> 
> Suggested-by: Antti Miettinen <amiettinen@nvidia.com>
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---

Same here.

Jon

-- 
nvpublic
