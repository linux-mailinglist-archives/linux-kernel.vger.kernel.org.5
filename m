Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A3D76F48B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 23:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjHCVQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 17:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjHCVQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 17:16:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E1846A9
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 14:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691097330; x=1722633330;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KNQZlIWG/h+t4rLatLx9PIt2Om8Y05npfkBS5cZ9joE=;
  b=gGfMkwXi+djpQ8tfAH/2+uGfFyE10p0nkDYpuzy/vRQNffzxZfHL2TRQ
   +S+ZEmGbo7+DhZzq8Wkeq6u3k1ZrNrjlrJU2L51+dxxWNy2NolnCRg8C5
   q0Q3UrdcpZJ3nP3Sy94tnj1nJ+I13BZqnGVKFLjknorOdbI+FKdiXI5w4
   sTBo/qnVNkYYVlAhNnT4rWLJoQsUYJDPfi5jmbEH5QrTyjqq7ILn4M4kW
   zqr+xetcVP/cV6CMeACSyrzKAB93qJ28F+W6QDZb8rT+pmV10LhxNyc1P
   hzYZDB1OkxGLAFDzjQchAGQheFdjYkffW0Y7dRbrJp55qknRj5LxoWPCM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="354937517"
X-IronPort-AV: E=Sophos;i="6.01,253,1684825200"; 
   d="scan'208";a="354937517"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 14:15:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="679629712"
X-IronPort-AV: E=Sophos;i="6.01,253,1684825200"; 
   d="scan'208";a="679629712"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 03 Aug 2023 14:15:18 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 14:15:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 14:15:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 3 Aug 2023 14:15:17 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 3 Aug 2023 14:15:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fCZX6HtUZdB+qk8V5axGOjvVgNPP68pIYHz/dcVMw6JzoDa2/03eLwvifwYw1Z7g5z/uyPqB7ofV2S4Tc2ryz03LQ+7pCP9ssCmy+evYwkBb2nELAsr4vbw7KqN6UADcnEj2dGmbEqxZfgNjBEPGSdmtKUeYfwAvdTY5w85Lj0Fjlc8ytsek+1aQRdijKSXOJAOR0m+JOJQRVOuRwUMFDes/kYQLwPCFJNxIjbKAb+bFLfHIzchxgWYMUmBWtQsBONOjVFuf2/YIuYYIKW2dA1hlQm2tePkNWQRnXJgPk88uRI99PbcQ2/CQm83iOqVHnUVBcmO1wtkcYTEwkCPjkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmOrux4dorWNrzQD2kj61eDtdjIuSfw33sBN+mi2/bI=;
 b=XDycKGscDCpfQPB2N1bo48CdG70myumQW89XWhylM5UA1MQIt7t8GjhO6UysHHWS+VzDbH+70WLy6+oyYn15/NCPthtxJoVk+3qq5O5h8LI1rWC8hiQNs2B5oQAHggygFa4ZF15bA+fCebhDUS65FUy79dXTiE/em2Ds6ko3liPduaTcN35U1KfDa2dqXJhuFSHXDWa9JSk0Ig5W+CtbbFdnn7KAzqK8rjzvMhmNd6JlPSu7eU4+3sgh35LpnmxZOkGW7JK0cKJbg0IWYjLoTwoPMu95iU4g6AgHGu0wlcIKo/Zu4nXBTllW3QmQhlO77YEBGBuhC87zuhgGYXcbfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by DS0PR11MB7681.namprd11.prod.outlook.com (2603:10b6:8:f0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 21:15:16 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e96e:8ce2:abd9:c61c]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e96e:8ce2:abd9:c61c%4]) with mapi id 15.20.6652.019; Thu, 3 Aug 2023
 21:15:16 +0000
Message-ID: <7f31f938-cd4f-bb1b-d44d-57adabf62c51@intel.com>
Date:   Thu, 3 Aug 2023 14:15:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] x86/microcode: Remove microcode_mutex.
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20230803083253.VGMnC9Gd@linutronix.de>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20230803083253.VGMnC9Gd@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0179.namprd03.prod.outlook.com
 (2603:10b6:a03:338::34) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|DS0PR11MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: aa9c8c5e-8de1-4ca9-ff58-08db9466bba6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: We2b6t/dZKv2TEYQyM/Zm4QwmoXMifVmgMtQm+dw3a00VJMZCFMbpDG1RZkbvT7d+3yNoUEeqid26GAWkGureKvBGkuOENOF+ge+6y6Khz6/W+ZuUfUNK7XUj4SYyOw8xBef1JYD/OXCQv7tZ2LmykQo7dFfNriKETyMbVYhUIlhrcWZtOxvgRwuaLem2G4naNrOaFcgqeFk8LBYwcaOGq+PQTPYGtI9OPUVxNtGjzYJitKTcMqFPIGw9C8D3ELqGKubVd6gU0QlQ8fKRcH5v3gru07f2DXBoVYrX64IdUKxEq1Srrq02jRjsNV4NEvWMgW2I1gMWkIHo+I/w+jD4rQfZbbplrJR+epDcgzPHLG1jUgroWtpvu+N1U6z+GXBZkwatdeVUDRv2a90iVRK0+Grw10ozzmQVbpXSoWPj6c2pa2aS55UWqQ3M5HtroSBdfskorGHNRXQzvbnKXCN0MQSTdC5P7SAsFIK+PVte0r65FefHAIbhK7hBod4Gxh3cLM9H9bRrBvkN+x9xnt3M95XitPr7tVYNmm/420IPkbhbKmzW6T0kUqw/AYWnpXDHzGtl1FkpZbGLvO/u6K9tjlj5azViCt9vrgbQxiUkE8MHD1hqdxR5fTfsrIjTVeFVCtLb87ZC5miiqBltuWdoU+FfE9GoOYKRktPeWsdR00lsMRs4NgXn4oKUlHKDb/1Yj6YZulD6mBgEZFhVV/W9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199021)(186005)(41300700001)(8936002)(8676002)(83380400001)(53546011)(6506007)(26005)(31696002)(86362001)(2616005)(38100700002)(82960400001)(316002)(6666004)(478600001)(6486002)(6512007)(966005)(54906003)(36756003)(66556008)(4326008)(66476007)(31686004)(2906002)(5660300002)(66946007)(44832011)(60764002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVNMM29lckhmQjVRN1g1em9IU3RZU3h5R0IzYUlsREUweVFZQU9KbGN1bXQ0?=
 =?utf-8?B?QWR6RkdxbFQwN0ZsZ2U2VllQRWpLUHdCOU5LeDFVcllPdFBsTXZoOGIvbTFB?=
 =?utf-8?B?c3NxNHZrRlhEQmlaVlU2a2I0dUVvNWpsYjQ3RWtHNnlBdWZnbXVvRkNnbW1k?=
 =?utf-8?B?bnBzL1F5eGR0MlNGMng2SlpOTjhJd2dMUHF4Z1Fma0taM0F0RFl2MXBkQ0hR?=
 =?utf-8?B?ckkvQVpCSUgwTmJEeWJHa3hnMk9tdXdQVHhqTlhIOU9VaU8vc0o2QWpJVU1Q?=
 =?utf-8?B?WHRyNUVMODRnWHhyRVVBQ0x3cXRHTFVLUTRXeGVCaEhTR0M1cFNnZWlaS05q?=
 =?utf-8?B?RTdoVTUrL1FKR0ZJOGlKRGtBVlV0U2Y2c0MvZms0Mk5WTDF6YzRlK1I3K1dN?=
 =?utf-8?B?QndwQVVDMGNaQ0w4bUlab01HVDBoWFFxTk1XNHNFTHBZRStiK3R1aURTckgx?=
 =?utf-8?B?cmdlVy93SlgzTjFFNDc1bzRJWXFiKzhqL2hEc3BIMVJ4OGtNbXd5dzJZMTJY?=
 =?utf-8?B?L1JNWVVxcW9wUzh2ZUN0VlZxL01RRUNvT1FIUFIrRHQ0ZjFNNVAyTVJ3cnZK?=
 =?utf-8?B?UklwUTRKdzhJOHdqcHIvdU16S0ltWjdTdW1pdFFRSlU4ZVNLM1ZibGVHdHhV?=
 =?utf-8?B?dmZOekMwUlgvbVRTc0VrTVdkU0pkeUJTdjFoY09LZWJsWWtvdER6MlRYdHRX?=
 =?utf-8?B?OGpxS1ROTUsvQzBzM09ydEtEUnczaUlERnJmeVo1Z1V6aE1RbzZwSUR2TVlk?=
 =?utf-8?B?dW85a0hzRFpDOFgyTXdWanVTUGxwcHREWkFvdTRMVjdzZ1phTDBrNURsNnVv?=
 =?utf-8?B?Z01Id0EzRkNuK0Q3L29wa29pdm4wcGhqSTVzWlVHWldBSTNNQnUrcW9BUHVD?=
 =?utf-8?B?NXJXZlJGUTgySnpoeDZxMmlaNXRpZHViZ3NzS1BveXJQRlV0Z08rMUFJWTg1?=
 =?utf-8?B?WHJvYjVjUTZUVzV5dld5MTM0SDIyd1k2bW5jOTZyYUYyL3pDZFprZmJRQk5N?=
 =?utf-8?B?SXpNMnlhL1NhZDZyVnl5K3FPd0tSRG1SSURXbG8wc2FwRHdHcEJUUEx2c29G?=
 =?utf-8?B?VVh6KzJDeEl5TE1VL2tGN3lwc3VYcjBpTW9HQmQ5QWdQaEJEZHNhQ1hLcm1C?=
 =?utf-8?B?S2ErNkkySk5KL3luOTk5MUxGeThnK2JVQVJPSXNnUTd6NGo3dTBGdVJaeG0r?=
 =?utf-8?B?ZVFUV2k2bzcvTm9VSnVHaTNmU1B4bEpJZVNxN1pIbHVSYlRjS1lkU0dsNkhM?=
 =?utf-8?B?VXpFRFZHWG9YY01vaFFPNUV6ZVRweW5RZklBSkFGSWtzUkUyTEsxeXlqeWFp?=
 =?utf-8?B?d3I2OFFGN3kzbjlBV29BUWZINXZncCs2V2sxb080WXNJZlV6R2k5bmJoNmw0?=
 =?utf-8?B?SGFvT0JNTlU1MTY3eWJESkthMlIrUnBJeW9FTnF0aENLc2loRk9MRVNSM3Rw?=
 =?utf-8?B?Q0tKcUEvZmVRZGhhNXJCd2pIYkNaOTh5a3VEaENCVVVPYlB1REZLOFhPL2x6?=
 =?utf-8?B?cEtObXR5NHRXNEFWMkJoZlJYakNrejU3SHUrZXV2ZllxZ2NKakNxMXhBQ3VN?=
 =?utf-8?B?aUl5L3BxNjJwdENsMVBDVURqelluTTVRaGM1Z1dpamRuZXNNbTBPeWt3dkJw?=
 =?utf-8?B?L0pJc2FXR3BJckdld1ZDOEppcVVoVU1vaWY5VDBjZ2NBUGZPUUFtVU5KUlpO?=
 =?utf-8?B?YWJydXhuUHVnZDFTRE1HQ0F3S0NJY0FaTTM4ZEJFS3dCSzNjOEtPL1pDNStr?=
 =?utf-8?B?NmxxTFVBZ3JyN0dtOHpCYkxlczlQNTNLcldmWk1rNXBqNE95VERBUUorbEdD?=
 =?utf-8?B?OXBkT0J5Q2RpSkhKUDB5NXVGREJHR2RYU2l3dHh4emlYejEvM2xmTVdrbkor?=
 =?utf-8?B?SDlDNjlBdjY1YnVoT2g4bW9VcHM2MDNvZXU5NWJXdFBZTkpIaStnTWFoTitI?=
 =?utf-8?B?V2ZsdlVDclgwTnJHak5jOWhZZzUwQ2NMRmxhdE85SVVzeWpvMUVSUU1nd0NF?=
 =?utf-8?B?VHZuNndpK1JicWM5bzJKOXBGdTVacmdLdERaZVhTamFlVGpDS08vNzZUUERm?=
 =?utf-8?B?OVNRQ1puK0V4eVZlUUV1clJ2UmE0dVZLSm5jVGxXUWtXM0ZzOCt6RlZjVTlh?=
 =?utf-8?Q?4lVXiGfrg8DlLg4LahtZFLfSs?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aa9c8c5e-8de1-4ca9-ff58-08db9466bba6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 21:15:16.0066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LZviBocEsO1ez/TD3Ihkyzw8imfdeFZjrpdLS8aa6s9EBXTv+uKY3xbcvV3RNDqM8+DxELvj2N2IIztw1wYU7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7681
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nit: The full stop at the end is not needed.

On 8/3/2023 1:32 AM, Sebastian Andrzej Siewior wrote:
> microcode_mutex is only used by reload_store().  It has a comment saying
> "to synchronize with each other". This probably means the sysfs
> interface vs the legacy interface which was removed in commit
> 181b6f40e9ea8 ("x86/microcode: Rip out the OLD_INTERFACE").
> 

There is also commit b6f86689d5b7 ("x86/microcode: Rip out the subsys
interface gunk") which last year removed another usage of microcode_mutex.

> The sysfs interface does not need additional synchronisation vs itself
> because it is provided as kernfs_ops::mutex which is acquired in
> kernfs_fop_write_iter().
> 
> Remove superfluous microcode_mutex.

I agree, the current usage does look unnecessary.

Maybe reword the commit message to say that after these two Rip outs
there are no of *other* usages of microcode_mutex to synchronize with?

> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> This poped up as "defined but not used" on RT builds without
> CONFIG_MICROCODE_LATE_LOADING enabled.

This issue has been raised a couple of times recently but the
justification has been deemed insufficient since it can't be reproduced
with a .config file.

See:
https://lore.kernel.org/lkml/20230324114720.1756466-1-john.ogness@linutronix.de/

and

https://lore.kernel.org/lkml/20230522062713.427998-1-christian.gmeiner@gmail.com/

However, your current justification of not needing the mutex itself
seems reasonable to me.

> 
>  arch/x86/kernel/cpu/microcode/core.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
> index 3afcf3de0dd49..2f9d35744bc41 100644
> --- a/arch/x86/kernel/cpu/microcode/core.c
> +++ b/arch/x86/kernel/cpu/microcode/core.c
> @@ -54,15 +54,12 @@ LIST_HEAD(microcode_cache);
>   *
>   * All non cpu-hotplug-callback call sites use:
>   *
> - * - microcode_mutex to synchronize with each other;
>   * - cpus_read_lock/unlock() to synchronize with
>   *   the cpu-hotplug-callback call sites.
>   *
>   * We guarantee that only a single cpu is being
>   * updated at any particular moment of time.
>   */
> -static DEFINE_MUTEX(microcode_mutex);
> -
>  struct ucode_cpu_info		ucode_cpu_info[NR_CPUS];
>  
>  struct cpu_info_ctx {
> @@ -488,10 +485,7 @@ static ssize_t reload_store(struct device *dev,
>  	if (tmp_ret != UCODE_NEW)
>  		goto put;
>  
> -	mutex_lock(&microcode_mutex);
>  	ret = microcode_reload_late();
> -	mutex_unlock(&microcode_mutex);
> -
>  put:
>  	cpus_read_unlock();
>  

The code changes look fine to me.

You can also add below to the patch.

> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 52683fddafaf..777340724ec3 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -2276,8 +2276,7 @@ void store_cpu_caps(struct cpuinfo_x86 *curr_info)
>   * @prev_info: CPU capabilities stored before an update.
>   *
>   * The microcode loader calls this upon late microcode load to recheck features,
> - * only when microcode has been updated. Caller holds microcode_mutex and CPU
> - * hotplug lock.
> + * only when microcode has been updated. Caller holds CPU hotplug lock.
>   *
>   * Return: None
>   */





