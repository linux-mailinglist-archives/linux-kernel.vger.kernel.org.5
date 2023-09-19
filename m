Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5397A5B61
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 09:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbjISHkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 03:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjISHkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 03:40:49 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2053.outbound.protection.outlook.com [40.107.101.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A31BFC;
        Tue, 19 Sep 2023 00:40:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRBaxsB9tpkMPyNnXlY41zI0jvwl41a5v+zNIsnYIFZUbNo7fgaZJ80lOCJprn97RFz/dQNcHKh6PhiP4hUgwJYFHGfVW6YjJQHjqyRnJ8opDzSjgbz7nPHX1HBemsjx8xz9eS+OfyceiFe0RcnXjEhxdEv/skUs+Kz0aG0UPJknvkn7P7TwLfYTq7CQYXVLow/01qLvgPZe0fJG7loCBMKofWKHsVTuIMUyFa0ilX37MdJ2FeSfejYgGoYPncdCGd6d4p3TP0Z0qCIXe+tfaZom7MhS+IjVi9YTAe6CXHsSK4++BrHjjBdLR3Z5Y+U3LVqRRCgAk64yVv/WqveQ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63dh1ECQO5VdEU1kqgSru9DDl9iAeikoZ3KtYmEVrW4=;
 b=iiSTFMxRUdapW0BwpspIc8t8qhFcd2lEMMSu97J42hSSrT6EmZw9sTK/9giAsmJ9eZQU2cEPC02zu7earGyEASUcNH7HH05k77aHlaMQluK5N+3sM2Bbst12X95/eJNl33J7m6K9ORK1S22tgiuZPmq/yMvvtjqXNlxMOilBil6oMWfrygZUdnWB5Yh4YctzW8jjT8LKyj+ija8ZQwcCoPGwDqvfIzwvqgxCvjzjK8XpgZM05Vhwu+utuwDXi7DuQWd3N/GcK9xTinU6mktL9HHqFnHvy/QmimJ8TZYK8Y8bq6xDE39z76rcxs2yMp3dOUDxE2U55ynKZt09ruHrEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63dh1ECQO5VdEU1kqgSru9DDl9iAeikoZ3KtYmEVrW4=;
 b=uWgVYk2Zo82v3bD7mtMF3AfX+xPiBV1N3i8p/BFRpvoloa9mlVesONkmhld4qsrdVWr9zoYtKGBAyXBqy+NBpEZkwejeweegCfLQgG6jMdrvCqbtvXnP0gZDGT91TU78TaIPX4+EEK591bYtPHRW46xnQ/QyMQ1+vHI1dmZZBGE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6165.namprd12.prod.outlook.com (2603:10b6:8:9a::21) by
 MW4PR12MB7440.namprd12.prod.outlook.com (2603:10b6:303:223::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Tue, 19 Sep
 2023 07:40:40 +0000
Received: from DS7PR12MB6165.namprd12.prod.outlook.com
 ([fe80::208c:3910:f2d8:e43a]) by DS7PR12MB6165.namprd12.prod.outlook.com
 ([fe80::208c:3910:f2d8:e43a%2]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 07:40:40 +0000
Message-ID: <80db4227-1e66-1e44-2f2f-a81b101f2d79@amd.com>
Date:   Tue, 19 Sep 2023 13:10:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3] tools/power/x86/intel_pstate_tracer: python minimum
 version
Content-Language: en-US
To:     Doug Smythies <dsmythies@telus.net>,
        'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>,
        rafael.j.wysocki@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mario.Limonciello@amd.com, Ray.Huang@amd.com
References: <001701d9e9ae$02438120$06ca8360$@telus.net>
 <002301d9e9e2$13424090$39c6c1b0$@telus.net>
 <002401d9e9e5$248f3d50$6dadb7f0$@telus.net>
From:   Swapnil Sapkal <Swapnil.Sapkal@amd.com>
In-Reply-To: <002401d9e9e5$248f3d50$6dadb7f0$@telus.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0062.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::11) To DS7PR12MB6165.namprd12.prod.outlook.com
 (2603:10b6:8:9a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6165:EE_|MW4PR12MB7440:EE_
X-MS-Office365-Filtering-Correlation-Id: 453cc6fd-5dce-45c5-b8f9-08dbb8e3b90b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wc5u0PCzHN1zGLTNP03a0Xmr8JXZa/bcdCkAGgM+K18rKyXkhUMCeSAEwYU1gaYKexLSuOgFE+X9ZwjrdtSc6uGDU9ASWFTIsplKFtWhdaxS8dOCthOFleTgTyOFvAeNlQ/38r5xQqjcW121/W447R7vdfjrdz2H9yPASEQijOOXNuDX6c3MuWT+64wEmJia5bABcKcBDtMpPTzOXtHpGpVVHeTQw8RxIMB/zmMzCNx5Z8r1rOeLOXfAkAC5sjVIsrdWqRQd8mc4Z86r8zwFRVIjeddqZzdOeowtzf3udDS30Vg/BDxSv/2ROrTGnlmMxESk/0lHMGxRi5KX8rkNxqFgcST1tu/t7/PhMpwIHk/KyaUtNl9922j5+ZHDmuy5ecD+3HmQTmsVYpcsXWrzsqrI2PjoL0GaaNFdSafRfUCXWcXRSKPBTlocAvGtB9ZU3VwdwXk6PSIYU4Ij7n+YC6lFVia8hYSIvrK3MLk2qQwAUYEKBR0lpuRdl3MnUWVCT69MZ8/f+Kjr9jH2Tnck4JVBQqoWa7xOLjVfNW0HDHAu4qofhCKwIN/Vgk86AVc54TrXWlYwAobjBQyLs5LPqybU5z9KSD++APuK16QTuIJGEfxkVe+E0oi+xRuEuUYUa8yis6sqncBMTxUZJOLbrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6165.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(366004)(136003)(376002)(1800799009)(451199024)(186009)(4326008)(316002)(41300700001)(8676002)(66946007)(66556008)(110136005)(66476007)(2906002)(5660300002)(8936002)(53546011)(6506007)(6666004)(26005)(6486002)(38100700002)(36756003)(2616005)(31696002)(6512007)(86362001)(478600001)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnZxN0oxcGxGZUszL1RIeWR0Yi9tS2ZHc1pGa0ZDYm42NE1DdWFxTmxPZWNx?=
 =?utf-8?B?b09ORHBvcHIxclFDNk1BclJWZ2tmRytQLzcrSTR0a0FUalNMNy9vc2RrbDND?=
 =?utf-8?B?YkhFTTQ0UTUxc0tWWTcyRm50cTJJS2ZqNjEwN2Y0TXRGdVdsZUdqQmRHSTEz?=
 =?utf-8?B?MWVYdVdPYlJwNm1WSzAxQ3lyd0dQZCtPUjhseFFyYXJxcnA2WVF0bG5vRVFI?=
 =?utf-8?B?eXNqcUFCWHcvTERCTXVpc2xOVjVoNlZlU09LSS9ITHVCUEVKNVZCL0F2eUxm?=
 =?utf-8?B?Z0t4UmQ2MFdJYmxoK3IxZitSblhxNnBmN05qQXlDMjhIaXJ4dklYUkt4ZXph?=
 =?utf-8?B?bENVT2V0Unc5R2hLYTRrdmZJcXIreUFRdy85dVJ6WVh0bGhaWWJyQXVvQVJa?=
 =?utf-8?B?T1I3Ujl1TnJ3aDRhNkRrRkFkZWpOM2tKMUlHVjh6V3BVN1Q5dVQ5QTllWjhX?=
 =?utf-8?B?OXdNM01TWmljaUlsdzYrckVBNXZ1bldQS0o0LzIvd3Fqb2JoSXVjZ3cwRnRY?=
 =?utf-8?B?RVZLaERhZU5NVGE1Uk10RkZIbm9PMDBDdFhmSHhlMm9YM2VxdDk0MkhJVlNp?=
 =?utf-8?B?cmdBS05HQS9SN0hXdGN6UzJ1V3dhUXMwWFdnOTU3bnBvSTM2ODkwbG9peVRT?=
 =?utf-8?B?eDNlTXozcHZ2alpZOVJMQms1ajJVVnVXbVZ0c2VXTHZMRm5sRHVDOVd1b0xS?=
 =?utf-8?B?cUFJMlZmTXBUR0o3RGhBUnlKbjBMenNVeEJ5WnRLQzBzT243RGNZdi90Vkho?=
 =?utf-8?B?azF3M01PQzM5VkFKdERtQ0JTTHYyU1BNb1ZVR0VlbGUzNE15TnJLNGkvdTBz?=
 =?utf-8?B?MlRYcERjcWYrRElNc05EbUJwQ2M5Y2lQQng0QmRuK0h4YkVIQ2NwRjZWaWIx?=
 =?utf-8?B?OUlVcDBJcDJTTU1oQnpTVEVKSUZOajRQVTA4RlVZQ3NOR3lhaXRZWkF1Umtx?=
 =?utf-8?B?Y3N4U09WZ1pLdDVqbUVkQzFDQ3ZTaTNlVHpmVzNEbGZGa1dxTzZxRU5GbXUv?=
 =?utf-8?B?SHdXMCtuRkNpSG9KSEkwSS9sSmJDbUdsRXNBclowTS92SUZRZVBQTWYzYUt6?=
 =?utf-8?B?NWozSlRaVG5uSXRqdVpTU2xQeEVUaXhwcGVhNVR4akw0MHlXM3NaaFRnS2p3?=
 =?utf-8?B?bHY5R1JJRW5MMzhrMTFiZGF6U0ZnbDBxbkJzcjYrbFh3L1N5b0E0aFp5ZGx2?=
 =?utf-8?B?Rkkwam9TMmV2eElkb0hDdEdHbkdLOXd1WlVkUU5aUTRJclMzcUxEZGFBZTN2?=
 =?utf-8?B?aTZ0MHZrOXlYMTZDZERoMDJTRVc0VWtadVFsbERLM3JVT0pWQzBSWG5pSTNT?=
 =?utf-8?B?bElpSGt3eEVYcjhYbEMwb2R1c1ppL2lvdnVrS01YTnlTQVl2VEtsVnFuTkpR?=
 =?utf-8?B?VVVHcGt0MmdkOURFdjN3RGVpczMyL0g5c0M2dVZ4YTVLekdXWHBRU0MrQ0Zn?=
 =?utf-8?B?RUE0WDRqbHFxeUJuR1QzVk9kQWxucnRrRitVaFgyWVFHN1RpYld0Z1M5TFZZ?=
 =?utf-8?B?c1dmeWdVdHJFcUpVUkdSZ1hPaitydU91ZTEvcmpoa1FhQ0Z3eTVRdCs4WU54?=
 =?utf-8?B?U2tjT0dBY0tONWM5M3pLU1YxVXRPZXFaeFVoN1FhdmJobVp6WjNscGZtTFlX?=
 =?utf-8?B?SFBzV3llcXY0QVoxMDhwNTA5RklaVjgxQ2FwYWVncndLNVR1SzUwZTlmNlk3?=
 =?utf-8?B?Mk10MlpDUFZ1aUk4d1ZmRWV3cG5oMUUzWUlVbFFIN0lEeEoyMXR5SXVEeURX?=
 =?utf-8?B?S1plZDJFeWRNV2FFQmtHcFhvakIxTlRpdDJrRHVjWjJzTXRDNlNvSUlhcjRE?=
 =?utf-8?B?SWkxWTJEcFdTcGVlYUFxeFp3SGJwK1ZKbWE0Tjc5MTAwUFRpYnF5NHlxb3FQ?=
 =?utf-8?B?a01EM2JORnBweE9UclVmWnN4bTJnWU95amJocUJ1bTdzMmx6VzFUNkRpK2xS?=
 =?utf-8?B?SXlSbVFBRFhMNExjWDZ2MEUxaDNUZzRQcnB6bUFWem5ia2dCeGdBeXZMSVZn?=
 =?utf-8?B?bUM1RS8zWG54L1dVMHdVTWVaY1dMSzliWkVYMktWOU9UVWVGeTZySWtuSUV1?=
 =?utf-8?B?bTdOSmszc3dVWTlGRksrNzNpbkRIYTZoSm1XMTdvYXpVYzFES0l5L2lpb0Nz?=
 =?utf-8?Q?DgdCQpULwKAlYwWtJCH1LfNM2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 453cc6fd-5dce-45c5-b8f9-08dbb8e3b90b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 07:40:40.8098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g4izSfKhgg0mBKbhhZ75aFOy4Sd05eDW/k4Qhr06c5Z64gbnvI9Pk0vEBv+7PV8Eewl2ZhzZgRYS7Yh1r/Ha1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7440
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/18/2023 9:33 AM, Doug Smythies wrote:
> 
> From: Doug Smythies <dsmythies@telus.net>
> 
> Change the minimum python version from 2.7 to 3.6.
> Remove a 2.X backwards compatibility line.
> 
> Signed-off-by: Doug Smythies <dsmythies@telus.net>
> ---
> 
> v2 -> v3: Try to fix mess that was v2.
> v1 -> v2: Fix careless typos.
> 
> ---
> .../x86/intel_pstate_tracer/intel_pstate_tracer.py   | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>

Tested-by: Swapnil Sapkal <Swapnil.Sapkal@amd.com>
  
> diff --git a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> index ec3323100e1a..38cfbdcdedb7 100755
> --- a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> +++ b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> @@ -1,4 +1,4 @@
> -#!/usr/bin/env python
> +#!/usr/bin/env python3
>   # SPDX-License-Identifier: GPL-2.0-only
>   # -*- coding: utf-8 -*-
>   #
> @@ -11,11 +11,11 @@ then this utility enables and collects trace data for a user specified interval
>   and generates performance plots.
> 
>   Prerequisites:
> -    Python version 2.7.x or higher
> +    Python version 3.6.x or higher
>       gnuplot 5.0 or higher
> -    gnuplot-py 1.8 or higher
> +    python3-gnuplot 1.8 or higher
>       (Most of the distributions have these required packages. They may be called
> -     gnuplot-py, phython-gnuplot or phython3-gnuplot, gnuplot-nox, ... )
> +     gnuplot-py, python-gnuplot or python3-gnuplot, gnuplot-nox, ... )
> 
>       HWP (Hardware P-States are disabled)
>       Kernel config for Linux trace is enabled
> @@ -23,7 +23,7 @@ Prerequisites:
>       see print_help(): for Usage and Output details
> 
>   """
> -from __future__ import print_function
> +
>   from datetime import datetime
>   import subprocess
>   import os
> @@ -562,7 +562,7 @@ if __name__ == "__main__":
> 
>       # Temporary (or perhaps not)
>       cur_version = sys.version_info
> -    print('python version (should be >= 2.7):')
> +    print('python version (should be >= 3.6):')
>       print(cur_version)
> 
>       # Left as "cleanup" for potential future re-run ability.
> --
> 2.25.1
> 
> 
