Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A76A7A5111
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 19:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjIRRf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 13:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjIRRfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:35:55 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0FBDB;
        Mon, 18 Sep 2023 10:35:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ol1X9RKTJxrs2mWcnRMWLFk3Say85SxtOy3cKAhboeHbMvdHLKbam9yFfSidUFgRnzwzCBz3DpG7/m6G1Jzs/3FOYSvQwt3N5rSOdUv960xEbg6JUQ2myaBuQH68tM77iSvqE/mP9Y7gu81qXXMtxw470yFzDU2PoeF8FyEu/+g+JK+XR2CDZHjQ3Bw8vR8LlFI/SjAE59T+m1K0j28Ovi51vF9E07H4O7XeJ8B3Lu+M/X71+W2dLFRbfTanxm7nXeQGIjQRJE9FxCBHwaOuCdlEHxUnLKpty4oGERkgKcxhpZZestNKjO/q0YDczXrYwg+rgSrC9QZNfnoggN0vvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WH+hxLoJo6haRalroq6RRXy/B8eENqAS4lVUcV0XlIk=;
 b=QivUZrGdKW00fLo2unmlq/hX10ox8vRiBVtGi3zA6dvL2qflJ24fPqDFLotLwfgJb7f0itnhJ4+1txkPW6VMXKeEAdUod4PpAzSyAFn43fSeE1GXAVreOEMjCmk2xXu12UJ2lRWgbSk/WLKV9NaQykVaKpBu6cgSS7yGQ5cZlA9hNPppHYkEN0SKXWDr98VzWdMjBhp+uEqcLBKSEP/B82KQUc0+hqwKnu0Lh8lJqA4BJ4m4UGlaHC3DCC7EQRRZH/giIjYMkIfOuGacBCpLuYhfzA02nNKH4hhDgsemx3Q3B7q2kkn0yFYP0wfJJ84Z5xuCIVxiOqY8YLdL5FjoeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WH+hxLoJo6haRalroq6RRXy/B8eENqAS4lVUcV0XlIk=;
 b=j+JwX0vNA/+was56FV5oQblx/dPhOPPD7UDVl/PCd5pND6y4jd8MEOoGlU02nW1b0W6rSCk6kAJor28m0qVf9Z2Dv9n7n67XQyG/44Gxbaw0YmNbIBVBBFFrPKfd8MWb6tUI+Yo9y1PZ0E0bChbPiNG189O8Bw3ZR9RSdQCA46Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 PH0PR12MB7840.namprd12.prod.outlook.com (2603:10b6:510:28a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Mon, 18 Sep
 2023 17:35:43 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::44a:f414:7a0f:9dae]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::44a:f414:7a0f:9dae%7]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 17:35:43 +0000
Message-ID: <84acb0d2-66c2-4cc0-9993-2832b3bd7ae7@amd.com>
Date:   Mon, 18 Sep 2023 12:35:41 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tools/power/x86/intel_pstate_tracer: python minimum
 version
Content-Language: en-US
To:     Doug Smythies <dsmythies@telus.net>,
        'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>,
        rafael.j.wysocki@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        'Swapnil Sapkal' <swapnil.sapkal@amd.com>, Ray.Huang@amd.com
References: <001701d9e9ae$02438120$06ca8360$@telus.net>
 <002301d9e9e2$13424090$39c6c1b0$@telus.net>
 <002401d9e9e5$248f3d50$6dadb7f0$@telus.net>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <002401d9e9e5$248f3d50$6dadb7f0$@telus.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0176.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::12) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|PH0PR12MB7840:EE_
X-MS-Office365-Filtering-Correlation-Id: ef29b7ba-b8ea-48b5-c7f3-08dbb86daf12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aZiVYNtylHhRZ/c9Jq8qNrls+YERfMESDP8zk0orcJt2Kx8Q2S3k8hp2R3ZODZ4wQYIlcJnoDuO0dzIkim9xY7F47dFuUYe+QzhPDL1oxvaztK0AQn/QEeZMUYh3u3QLMo2s0GLgXwXE6Bdk4MnSZ4y296pA5FQbZyFRQf8Q17K4bML2yXij/ZIZdL4wsBchd7wh+VKRG8Z4YJfkyKAPhGeZ+8aSHg2ME56UyGLKoqb0n57pct3Pz+014Z5JCaig4xFBNUxETz7V0pRPF5eU2N5KPkHSMQSW/FWAt0ToyhLT1q6BaZMg8/jkgNOsx+M39FkVz9aeFDXqnouNea8Kn0CnaxIqFnv0sakFveRzSmT3+vSDF1iehLyc7bguHAxJ8Vyi0qMTYvQKIl9iqf+UnGAHaF1L7fYrWA7w5OaMJJdwk/aVuDSqc6L8bSjrh16gwhORyLAEru8Gju5glO0hCt57apZIduvpr+Cs4XHX5fMIVnZCTrdNqc8Qm9dpcHEuJhHTEi6pRKvRttuAyElCpIPrVrTBEH8vUTKyJrqDGVjGdsxtYcvleumpRszJbxm0XdviXOvAcS7wTxP6o3z8ASO83TlS9WCRNXI1aTfD7zD8zf0WlNfWA2G2Uq4ZZWOAuaxGKHaDqXoJ3mrOem2qQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(346002)(376002)(136003)(186009)(451199024)(1800799009)(110136005)(316002)(66556008)(41300700001)(66476007)(38100700002)(66946007)(478600001)(2906002)(86362001)(31696002)(36756003)(44832011)(5660300002)(8936002)(8676002)(26005)(4326008)(2616005)(83380400001)(31686004)(6506007)(53546011)(6512007)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cE9VWEN0OVZ6VnBNQUo0TmtEUG5COHR6VTdoRTloVlJvSW50eHI2WTcrS3NZ?=
 =?utf-8?B?dCtOa0k4aUp6NUpsZ091bktmME5jcDluaGRZN1F4eWY4YjEzL041Wi9OQ2tR?=
 =?utf-8?B?NDFVUDZBVC9hZ2tHa2NzVFk1V2NJYlNUYURteHNMdWZGaThOYXp6dXFnOE4r?=
 =?utf-8?B?SS9XSklkMVh0YmQ5aHVYV3A5MWx4WDBnNjIyMEUvRmxDYW5tRHNtdExOMXg0?=
 =?utf-8?B?ajNwMjljTHJ4T00ya1d5MkZoUGpSU3FTdGpmblgyZHVDTENiY201Nm5UYU9l?=
 =?utf-8?B?ajZLckxkVkdZMW5QZWhieEdQbC8yWWs3blJaVEh1MmswNThEL3JWMGZyTkxD?=
 =?utf-8?B?OTE2czVOWDVmT0ZSQzM5b3VDWDVHMWhoNkVwejFEVk81Y2xSTHZ0OTNuaWk4?=
 =?utf-8?B?Q2srWUd3enFKTHNtclFHa09jbWNzaTFHM291dGpxdFBLc1d4NFJPVUYxdFBO?=
 =?utf-8?B?VGRBNnI1OXFWSUU1ZkdCSGl3S1BKUzErZGdEbndPVUUrOXBNbm82ZzVlRGhq?=
 =?utf-8?B?a0J6aHQzT0lVOW9GbGRGcXNGK1JtWHJXaEk1ZkRseU9GbEk5UVJFT09HSC9v?=
 =?utf-8?B?VHBkU09WK1FvZXlnT0NwbGdHc0J4T0R2WlFaUExlQVpkaURlSGw5T0ZrcXNN?=
 =?utf-8?B?aUxvYkZiZlJVVThmMGlya2RkRk9kQTZvRlJLei9PVGd5eHBTYmJXSUdXOFRF?=
 =?utf-8?B?MFYrR1I4SytIc1ZJaWpob2VEdk1iRWtKZCtBU1dMOTh5Tk0vT1pibTR4M0ZO?=
 =?utf-8?B?emlhbEVtRWVXQTFJWjd4a2RqSkJUYThaWUtuMVFHcVNoVmZ6dDVtUG9DZW51?=
 =?utf-8?B?ZDZyUHkya0RNTW1MUTA5MGxpaVV2ZHdsdnc3WDYrQXY2V3RrOERhQXBQUjNu?=
 =?utf-8?B?dmdkeVVsN2NyT0YrZzJFcmNvdjZwZlZzcVJIUVlVVmpZWnRqa1kyRmFBV25O?=
 =?utf-8?B?RHZmM2RJWWFLSkRuMVphNkFLZDBxK2pmK215U0FlZVdUeFdzcU1vWFR2a0Ez?=
 =?utf-8?B?SXdBSW1lUkQrT3ZBM041ci9pNGJBRGZXMHFOODZhdjE2bTVOQnR4OEdEaXdP?=
 =?utf-8?B?QUJTR20yaVpjbG12UFVKU0QrQXhNWWdZSzVrTVdIbnhwSkpaUVduNWNuK21S?=
 =?utf-8?B?TUxXa0hYak0zaTFPcUZqVzRZQkJDeXdwdm0zQWpsckFiSWRrb1JiQ1dsTDJo?=
 =?utf-8?B?N3pLdzBNRnBHV2QzTXFmbEZGdWNUOEJpZ09EUEJ4ZUtOanpIamlsemJ2MlBr?=
 =?utf-8?B?VVovMUprQksreWdMUXQvdng2aE5oTHJyZzJteGF0UGk0RGdLRFNteXVRQXdn?=
 =?utf-8?B?dzFMckxSUTlJYStPdjNjbXZ0SEM2SmxIODhXRW9pQkRHQ1I0VlZkeDNRbEox?=
 =?utf-8?B?NC81NUZFc215R2hZQzVVMWJPS2NLZUNqaWtROXdYNS9SMnk5bXJSWk0zMHdV?=
 =?utf-8?B?T3dNR3c5d3FQM0tST1RJeE1ZT2pzZWZjajNvcFYvU2hpTnZVMldxR21JcUkz?=
 =?utf-8?B?dDVWMm9STHF2cGRDU01FYm45WnlDYXRCSC9ZUGtxa0xhL21NUGdHSGc4aWhh?=
 =?utf-8?B?KzJHU0dKbno1d3o2M0R3SldLa2IwSUN0NFhmUDFSV05xN2JZSUFVaVhvcFpn?=
 =?utf-8?B?eUJaVHFkRjMxQ3p5M1J1R3VlTERGQVZvbDM1bnVQdXFaY0MyR2srdlBqWDhi?=
 =?utf-8?B?eGVrRUNRbmVxLzJ4VWxXMmMwaU1mMkMyaDVzQWZtOFFydjZHNm9PZzkzTTRW?=
 =?utf-8?B?NnZsOHNkRmxSQm0vVmpYM3M2djVXbisvZ3ladnc0SEM5eFVFUEdVQkRnN3E1?=
 =?utf-8?B?MFIzRUVwUjFzbnR3ZmVrams5YzlBQ3NPZkxLNDlGQTU3VVhkbjQxYUlIVTNt?=
 =?utf-8?B?N0pnR2FnOWRsUGVzYmNSRXFwS1B1R2Qzcjd2LzlsZWswdnQyTjZVMzBIelZz?=
 =?utf-8?B?U1V3ZkVuNkNId09JYTlJL01rNS9KOGpteXlncEtvMERwYk5ITE42aGx3Z1pT?=
 =?utf-8?B?V1pJVnNadHRYejJxM3FHZkxsa0pSMWh6c2hWazBMZ0NVaVk1endTRWtGUGFQ?=
 =?utf-8?B?alJ0cmdwdE1ZVklmYXl4VkcwVWNHL0UxTE9MNTQ3STgrYXJ0MjNnM2tlUThl?=
 =?utf-8?Q?2ELlLWCj27GAZt6LVhKGtIpzX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef29b7ba-b8ea-48b5-c7f3-08dbb86daf12
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 17:35:43.3094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xu51K7Zu5hLmppQ54A/ALEa37+Cqwh6FJaafTm8fkk8T6lFGFXru92oAZv07Jy2gGzWU20SAIdvNoI5fmVDi0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7840
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/2023 23:03, Doug Smythies wrote:
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

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

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

