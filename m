Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5270F7A3F0F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 03:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbjIRA5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 20:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbjIRA52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 20:57:28 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAE6103;
        Sun, 17 Sep 2023 17:57:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9XcEycS0HM0MiWvYVbx02uuNXNQw7hZ1ZX1Epx2IZWJINahqN3RWpP+eAMYopugu4LVLXSuhKz2kgLc2gSlwR40XeTFh9RRsuTKuZskbnDSuio55J+yVlQmQszyU8nrinhVs610Hq+gSrzEp2tqsBYdLZHzVyxqz4UMwuACRR9uWtzqBEzZQLm5erSutANr8YbbZqee+3KAKQEvBMK6gi3Wgd69vLzsnzfpsG399rDK1PJbML+OIiXFFiMyAVXs0ZFl0SX4e84UxV1lxxvv4IXXboNwAyjzqCtAj0GqtqwNCbmpWUDdYX4wpeFtm+hMK4GBKZGDZQny+jTpg2ys6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5mAu0QQd0dPiXO1FDrtJIQ0IEBFiE5tK/RPMnhAGKxU=;
 b=LWe/0/ltS8OmqYwOkrhgxL/m0IrRZW1IohPSKT6inU/CTPEMhj0g4n0WtLULeR/3Fdm+XaiycNXQc5F2aBvf429llu5iQzvYWpISxskUeC6LuKYtXQ9OKtO07MF+EQEp2v1D9ZgwDcBrhHMLF1YxoOFLVck5TddzhqdQ/R9uHCd08gJ0xVHCPiM63HjjtyRYdWBDZzgrvNUo9Pu0gfzpB0y2AuvJaX86ydU4lhnw6z+YZ+Cuv8QIpKBRtogbExHRmElA03bv0OaRKEhl/sBzvCBHivY9VD3P5Kk/rYMbpd3TEfrchMJvhBqmP7Tr9QbPmWhwYhjGyDIW7+WAHS1Q6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5mAu0QQd0dPiXO1FDrtJIQ0IEBFiE5tK/RPMnhAGKxU=;
 b=jJmo2Y1AMIHpR1CIjt9Vqim1MwCKNeSN7hUZkg4yALmZp961tbEXW6psbAbg9g3dK905iXsoBLzZ/15EuOKlN40oDlZ5+/KRSaqj7o71U4+Y3BBPwm44LXN4pZ81XWFXVyIpYorABpv8tDQFvWA6viPgUNms/NyoGQEGccJBZe0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB6632.namprd12.prod.outlook.com (2603:10b6:8:d0::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.26; Mon, 18 Sep 2023 00:57:17 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::96b:b6f7:193d:82d5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::96b:b6f7:193d:82d5%2]) with mapi id 15.20.6792.024; Mon, 18 Sep 2023
 00:57:17 +0000
Message-ID: <e8a05f05-deec-4784-9627-354939ad30f6@amd.com>
Date:   Sun, 17 Sep 2023 19:57:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/power/x86/intel_pstate_tracer: python minimum
 version
Content-Language: en-US
To:     Doug Smythies <dsmythies@telus.net>,
        'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>,
        rafael.j.wysocki@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        'Swapnil Sapkal' <swapnil.sapkal@amd.com>, Ray.Huang@amd.com
References: <001701d9e9ae$02438120$06ca8360$@telus.net>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <001701d9e9ae$02438120$06ca8360$@telus.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR04CA0075.namprd04.prod.outlook.com
 (2603:10b6:805:f2::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB6632:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c00e2b9-7ed0-4e7e-5c04-08dbb7e23443
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ya3L9eLp4tMvMi+jRITCtXe/lQdmANAe6ZrrhXyecyt/awxpKB4jGstW6zx2bE3HD8chFwyyhdkWIhKSb7XIktSeTkEUWTkNnRByM2vEcSeDmxnd9x0dY3EsYOQK4Hie7qDk5Goi/CZuBG+Js30fBi81MkALcJqzzWVu5+SVm990m6KR3Mf9MyNSSsyCyu9B5WMQMz3Hz4pCAvAHr6gZioTOpJ2c8zOzcjZgHi0HOZ0s6XTl2ieNpZMP1TJ9FD0j17TFbFRRqhTwmhxCRy+Ma+EyR/3Wc8OBT3qKUfRJU8VNaODLsbCBXDWEHAqGIyKsr//VFQHyeJkoDB1KMuxbmY8ydi1tKlSnwL9sA4YEkZ4o/aXZGaKl442Wyqq7CyRyxjHbr0EIMAkOz+Nr6TQdkR+mKn5j++W5cVaxps6MWnkfD5ShkDk/nTaEeW3rMBVyNlkTqkWY5RXvvxgWf0X5fajyJfPBMEY3nNVrkohXUUgRlkVbHWyFOTmQUAwJfctvZfJqsTH7XYlTR/VQaPnzWvR/8+/x279JDdPrQt2rFLTKLM+hgdUvHp0+PAvBN+Ka2Hk3Jzh/Pokqf0WMc2DHelhkP1N2/gk5nytvGp3ykJplO8CdwuEhbNMkHCjCl/tyujwccOYTR17VMICRmB3Hog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(39860400002)(136003)(396003)(1800799009)(186009)(451199024)(26005)(2616005)(8936002)(8676002)(4326008)(83380400001)(2906002)(36756003)(31696002)(5660300002)(44832011)(86362001)(53546011)(6506007)(6486002)(478600001)(31686004)(6666004)(316002)(6512007)(110136005)(66946007)(41300700001)(38100700002)(66476007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXdUQnhEL0JFcFQ1TFY3VG9nT0EvZUdYWHVCS09iQ3FpNHdnSjcxNThNa1Ja?=
 =?utf-8?B?eHk2S01sWHdqK1JnM2gyek13bDFDTVYrTVdvWXVaV00zVU5XN3I2Z1NHYUZE?=
 =?utf-8?B?OVgyV1dXSGp0VTQxN043R2lZc3pSUC9JVmxXL2tNeXBOUTE1OFRSTVhWajJK?=
 =?utf-8?B?V3B5bC9WOEdKaTNoUGtaSFhxdDZhcG52ZDZZbUc1WDJQaExPWmdiQXZqWHZY?=
 =?utf-8?B?WXhCMEZYanZoSlFHVnV5c1IxdlpHMzQ0bXFaTWdFUzM2bW5hY2tTUGhMNUNo?=
 =?utf-8?B?V1YvY1ZvSjV1UGlyb3VXRWJsVUpxamd3UERxQVNrZksvRVdSMHJISXF3a0NY?=
 =?utf-8?B?aVVmUXppUzRubWpyTDdCNUhvaFpPM1diUkcyZEMzRTZuajhsUm9xVWt3QkhL?=
 =?utf-8?B?cG4xTHgrdjl6WVMxRE9yV0RLMDN3ajlPVG1qZ3hCWStuRzh5ZlZUd1ZHbHJG?=
 =?utf-8?B?SlNnVTRTTk1zTDh4M01MaXpEaUVZdHd6M0NLT21rcVVkeDZQWEcrV2dZK1Z6?=
 =?utf-8?B?ZGZ4VWFMZyt1VG1jUmlNaFZWa2lCdVJEYzRBbG9JOXYyNmdwTFJaZEtqVEdT?=
 =?utf-8?B?Znh1aVpWa2hkK2JjQzRaQkd4ZUtTTlFySGJOaTJXdEd4U3lrc1U2SE5qZWhq?=
 =?utf-8?B?M3V1VU1IOWlWU2lHNWpzZVNzTmI5YmwvUEJIMmZ2QmRIWXIyNEpxcEhJOWt2?=
 =?utf-8?B?K1dmZXFDNHFUUHVuT3BMU2Q2Yk1UTWsralpCaVh5YVlNdm9UbGYvMmVLMmNz?=
 =?utf-8?B?cFhDVENzTzdTQkkyZk9oVlNZQzhQTGZuamYyWlNqTWcxWCtqa1hnNlVtYnVH?=
 =?utf-8?B?UnhOZk5nNDZYSXJ4SUpCU3FXR0hTVVphTVkrdzROSDhLTDMwVk9lS2hNTDlj?=
 =?utf-8?B?UnRQWkhaWk51d3NjU0NRdlcxTlZmVkNDWkFxdnZ3ZHFCWFVBSHJQdzFzeVpK?=
 =?utf-8?B?S3JibWZlRzR3SlVud0krbUpiU2kxZzlXam1rQUtTd0M4b052YVEwNHhYZ29r?=
 =?utf-8?B?c25ZaHdZY3doSzNuWHRJRVNwQlJHRm4yQk5zV2ZrQjdWeFdGQVdCQ1J2SEJv?=
 =?utf-8?B?SmlpNVZySXhZQWhkeEh3Rk5MYnFKRTJRRkRLTmJ1UGFhVklyL002OXZBSjFE?=
 =?utf-8?B?eUc1TjErRU9QcXlHQU1zdk9PSFdHbUxkR3BYbUtUMVVIUjdTOUNKWEcvMjU4?=
 =?utf-8?B?WHZQVXpUdjBUMXlnWFNYRTY4MGx2TkU2a1RZRVRTU1NxQnE0UU9jRVRSQ3Aw?=
 =?utf-8?B?eUJXSDhLQ2JqTldOT1NPbkE5dmFQUEFLVzZCSUFtSlgraTZSMThscVB3eWRG?=
 =?utf-8?B?MnBacnFHR0ZCZVdmVlNWbmFnNWRnOGt3SUZSbHlLQjEzNG1JQmVvanBPWktF?=
 =?utf-8?B?YUxCM1lHT0Rrc2VKckNHM2JVejVsQThGa3IvL1A3ZEI1c0QyVUw2L3IvSEFu?=
 =?utf-8?B?K0RHcGFLMVpYMUlPZW9GWi9tWDRBa1Y5bzVwYWRhUkNIYTJlM1k5V09nQXNk?=
 =?utf-8?B?S1kxMHI0bGJzT2FFSnFJcTdFVVVZaVhMaFEyKzlCOXdtcjU0WWlVeXFXUitl?=
 =?utf-8?B?aUI4dHo1TzRNOFJCSzVNL2xVaWUwbjd5SUJWdjk2N1FyazlKeng3VEZqSG5W?=
 =?utf-8?B?MExCTGRsSHozVTY0SmJKL0FVNFJGMXp3V0N4VmMvVktwL2YveE5CdGU0d0oy?=
 =?utf-8?B?V1FaZFYvbk03TU1nWDVhcnA3eFZsN1dXOWllMEREK3hGclM4WnUrSWJZTkxl?=
 =?utf-8?B?clNxc3Jja1hWTlVlY3RUeTdzdjhvTk9MYWRqM1VhSnNDeDAzTUZLQlZSajBr?=
 =?utf-8?B?WTVHK0ZSdnlkVk5CMVdCbmErNWd3SXU5QW9LdGZmL1VNYWNDdjNVNG92L3Ny?=
 =?utf-8?B?NVdJekw0RlRZbFNCcDd4SURBcU1uVG1mY3Jodkl3Y2pCRDBxUmRReWplenIz?=
 =?utf-8?B?OHpvTEI4MUVIR0U5RXBnSVV3bzVsbTB3SHVnaXFvaUJHSWZnNk4wcXBJRW8y?=
 =?utf-8?B?ZW1LdDdiM3ZYWVM0MS9CZ2kyQ0I0NHNDeEdyM2NnSWVSWGNzeStaNzNuYVdM?=
 =?utf-8?B?R1pha2ZObFkyNUhsdDZXbDRQaG9raUpxL1pVanRWZ1FWeHVHK1BLQUJlbDIy?=
 =?utf-8?Q?2DrYE7joxAhLzaSEhDJV2+gJ7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c00e2b9-7ed0-4e7e-5c04-08dbb7e23443
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 00:57:17.2804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d/5ddm+QvKBztVg5aO6KRx2hAffvKyvng7FzaVdeLCKhW/3X9Elep2ewlzXq+gLcKSuw6xELs9I3jCmBmrUS7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6632
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/2023 16:29, Doug Smythies wrote:
> From: Doug Smythies <dsmythies@telus.net>
> 
> Change the minimum python version from 2.7 to 3.6.
> Remove a 2.X backwards compatibility line.
> 
> Signed-off-by: Doug Smythies <dsmythies@telus.net>
> ---
>   .../x86/intel_pstate_tracer/intel_pstate_tracer.py     | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> index ec3323100e1a..6b0790e6465a 100755
> --- a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> +++ b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> @@ -1,4 +1,4 @@
> -#!/usr/bin/env python
> +#!/usr/bin/env python3
>   # SPDX-License-Identifier: GPL-2.0-only
>   # -*- coding: utf-8 -*-
>   #
> @@ -11,9 +11,9 @@ then this utility enables and collects trace data for a user specified interval
>   and generates performance plots.
> 
>   Prerequisites:
> -    Python version 2.7.x or higher
> +    Python version 3.6.x or higher
>       gnuplot 5.0 or higher
> -    gnuplot-py 1.8 or higher
> +    phython3-gnuplot 1.8 or higher

Presumably you mean 'python3-gnuplot'.

>       (Most of the distributions have these required packages. They may be called
>        gnuplot-py, phython-gnuplot or phython3-gnuplot, gnuplot-nox, ... )
> 

Likewise here too.

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

Is this block printing the version really needed at all?
I don't see 'cur_version' used anywhere else in the file.

> 
>       # Left as "cleanup" for potential future re-run ability.
> --
> 2.25.1
> 
> 

