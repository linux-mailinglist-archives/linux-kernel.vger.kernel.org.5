Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68E1774FB9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 02:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjHIAN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 20:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjHIAN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 20:13:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A353C1996
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 17:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691540006; x=1723076006;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1eSDbAt5xz38EDB7pnP0rQRQBzO0yffpz1XWRqKSzro=;
  b=VOAnk/2gnjH4wzHsldYRAWiDtQ+9pP8CHw2KawZeSEZcMtLQxsv4kekN
   Cxuy8xCqBZGuTjd7VXVYQj0FQ/8kKdkH4lI6x6HW7qCBkIfpRZXg+G7i9
   UdDpEZlvtfzn6IU0o3hPJvrXgJRI6FFMDvxf6G+VtLwkyEIoChIWB/7t7
   +889o0DP/C255jGVNiQKnSDljuOxtYIh0QElqR6GEhmP9jfWTxDNUleBN
   XiNeleY7Gk9ONSsh8tR1g1yDCYstgOifbvrQGlzs89q548R1URfnnfEsk
   CqZb0lAsy71diDyUIQMpS4LlauEuXYoyow/I5PUjidi6tRo1akt0rif7T
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="370979107"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="370979107"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 17:13:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="845714072"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="845714072"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 08 Aug 2023 17:13:25 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 17:13:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 17:13:25 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 8 Aug 2023 17:13:25 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 8 Aug 2023 17:13:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RkLf956WLHFfc2gbeqQaFh8vJYb5Pxs6qAuHyizr1X9Anj4p7t5DZ2nIJ7GP7BL2V6L55DEGe1xJ1NPNW2jz+fQT+snR3nhtv16tPr+oEeyUapEJopmW8ErJL/AAvE5VY2NTyIfEdAnNZRWH67IGx+GWu59ZkdZuFZ1uUuDAfY2oWJmAvAD52HsOx3m1eF02L4aZ7EwocYFgdl2TXsljdwjNEEWwNVgsqH9nkQEsU4kRukBjgQx0WbFLtD9ykPBJhnciIe5NzqQf4BLL1B3XUxGAQG27PjRAHDx/FW2NtaXWY1uHOAzQWfuKKpAVPmCci6ssEHFaPGrfHBbor8FKrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTe4oUQGZSs10au8LkevLHwXvrIXRpkMAGkNgtcROKE=;
 b=e7g6zWqm+DLumjEqIiRuadC2NHRe3mz7B/7CGPmyrfWZzZcnKiIgtRirMBzVS+S/rW9AeXRwdm4nhq0bfX+UVgJ13+DOVgR88SkrVx4TD4ViVa29kwoySabBfo3KksmdwiFoWsjgtIwLnrJyoeSL+uUq/fZ44OAY92f0/DLP9gKHwf+L6SogrzqONPlsYPHnUDfE6feoT6Nm8MghtBbjuCYPmY6TUmwZ0ae+Swgff51gprA/FUBXSp3QqAXia2YBHGgPHyvIDSzOZIhSxn7DvdF6STLjKneVUxEJ/IIRxtWxWNMp0QAs4cTEZMoU9BXsBUMIoOVGGOVYrEIQtGPJjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by MW4PR11MB8266.namprd11.prod.outlook.com (2603:10b6:303:1e3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Wed, 9 Aug
 2023 00:13:14 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::70ac:fe46:e033:41be]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::70ac:fe46:e033:41be%4]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 00:13:14 +0000
Message-ID: <c0aed6a4-23e0-d947-5c17-26e580d5c40a@intel.com>
Date:   Tue, 8 Aug 2023 17:13:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH RESEND] x86/pti: Fix kernel warnings for pti= and nopti
 cmdline options.
Content-Language: en-US
To:     Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>,
        <linux-kernel@vger.kernel.org>, <dave.hansen@linux.intel.com>,
        <luto@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>
CC:     <x86@kernel.org>, <bp@alien8.de>, <tglx@linutronix.de>,
        <hpa@zytor.com>
References: <20230808195615.9795-1-jo.vanbulck@cs.kuleuven.be>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20230808195615.9795-1-jo.vanbulck@cs.kuleuven.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0294.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::29) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|MW4PR11MB8266:EE_
X-MS-Office365-Filtering-Correlation-Id: aabf167d-badc-4b4a-b550-08db986d6c83
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lOPMtsV80IX97l0Ag8pVrJA/nRS4Lba0++voK39jFV73T4dh7OLvBq6uVzHab2xV2x+X8gs6BCm6TN+kIOMTcb8Phyt6BkwYCR8Ww4i7PiG0g7rDNWiPY+tfWhjtmQnsd2gYafaCA7deWOAWinRpsuGgE9d8Eu+K/xSPjb34LzLpCIpfgGGPx8BwfJr1hFs2gCvceFvgAO7MuLlzqqHeQ3oJaRj/MsWbfhyxgr2WXYk+wQ5Kydn1otBzE506+CsDahpTwa7Lxu39ZorRwpyPgKLsRoptz93ZKD4ZOjmhGawxRVk6CRWhpekxqxkp3CDWVESrti6F0fVIV53ilSe4PIQ5y7/j/fNyX+awbYW3zNGRLRitPq3rARaEBlMpgamK7kYvz5X9s84dGRaZsrPqMtSPAeFxWg3HVjpCTYmqCvVOMyhtnvP4bSZrdklMUuKo72m/Ij9nLTFoCBbzAt1ZsEaPAfTPPdb5W56Rn/GYJQ9hvjXszXQ0ihOj/nKSqzwJc+7hBzoDVDeXtm2uxUIvI7phrDq5LeZrFyRFSPoFRXD2p0WuthvfS+OEHwlirRWs+SCES4uwEfkuBdSYQs35Wzt32++MPet4V2MVX2CvjjqjLqOq4bg+HJdudXVhWZvbfILLotfpFcNJtBs8DZPeqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(366004)(346002)(376002)(1800799006)(186006)(451199021)(6512007)(31696002)(6486002)(26005)(6506007)(53546011)(36756003)(2616005)(83380400001)(38100700002)(86362001)(5660300002)(41300700001)(8936002)(8676002)(31686004)(66556008)(4326008)(2906002)(316002)(82960400001)(7416002)(478600001)(44832011)(66946007)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RExoUnJldHFXTTJIcGNLUVBHcGFFNU15MjArMlF3VVRNSG1XRTNieEJZZ3ZR?=
 =?utf-8?B?N1F3anBpZlY3ajNiRHVvUGl2YWQ4QzhiaG5kTCtxUFgxQm9iVmhLQ3N3WUpm?=
 =?utf-8?B?Z08zdGw1dWdNUVJueXB2S0dSZkRoWktYaGgycjhTZUVPd0N1YjkzNmRzY3g2?=
 =?utf-8?B?a1Z4eG9Zc0I2aFZPV2dHSHAzZzFqUk90WWZmZmg5c2htMGN4RGJ2RlhjM0Nj?=
 =?utf-8?B?bXFYS1ZRYVY1UWZldEdZR1hLaVhOazJDTnZ3a0xPUVN4eHhqMWY2T0FXMkVO?=
 =?utf-8?B?N3dXWlJxQi9CWkx1M2gyOG5zR0VEVWRTSFlwTzI0TnFpSURZWlljbHFiUU9h?=
 =?utf-8?B?UzJ4cUJoYmpEWmhIem4vU0NyZnhGLzc2MTl6ZEtUSHV6UnB1NjdYUy9lYlpF?=
 =?utf-8?B?T29LZUJlODNIVE5Na0J1V08xd3FDWEZ2T0VKbDFwWFhrMTRMNFFVM1ErVFhR?=
 =?utf-8?B?Z0IyWFA3UDVhanZvVkRqYVpOS1VkVUFmRjBIc1JWbVFDdlNRdDB4NkNBMmxz?=
 =?utf-8?B?a1N4Sk1mWnJnOWR5bEQvWVVQNEo4MWJndUJvU3NXc3hNODRLTU9YekRHQ1JF?=
 =?utf-8?B?OHduN2lES3RJV294LzdML3dDQjdYdEJFa21EQW4ySFVWNzEzVlhnaUZHYmp1?=
 =?utf-8?B?SEZlZnRlK2lWb1RRNnI4SjNlWnRwbWhQL0t0UGttM2VQdDdSK0UxU2Y3aW1h?=
 =?utf-8?B?ZmxLdm0zcm41TXJ0VGNqWUpWZ3AwNWNuMVF3dW1Jc1NUdUNhUVNnajdTOGZq?=
 =?utf-8?B?LzBrRHZkQlZ4NWd1RjV2QjkvSEZiNEoybVgwbkt5dDROVzM5aDhoYkhiaW4y?=
 =?utf-8?B?ZTN0aFlMWDgwNC8yQlZzdEVsZkZrMWl1Rk13N0hobTdBTTYzRVZVS2FKNmNW?=
 =?utf-8?B?SVo5S0JESXhiaFFaVmhHNUxwdFc2VFRvOVJoZENyZ29FVmFuRUdUaHg4eUE0?=
 =?utf-8?B?UUFXeTZsWXFabXBvMEtGZDdjUVh0Qm5vZmYxRDVYZG13RzNYa2xYakh2SkVL?=
 =?utf-8?B?MnJtNFdSZDZyeFQ0aVE2NTNnVXBnbENCOHo4RHprU2EyVXFraGZYRlhTRUF5?=
 =?utf-8?B?YUJUbnNZVDc1ekN3VE95RVErSnV6VzBobFVyK0FUa3p2RHJmZG9KNEd2UFF6?=
 =?utf-8?B?OGx6QUc5QmRMK3RLVTA2bHZFdEQ2YTN6cFJ6dHpZenJXQ0FwelNCWmpkMzdC?=
 =?utf-8?B?OVFTSHdwUFRpZm04MXArUVppK2hXQ3Y0VlcvRExtUEFlQWFRaUpMZHJnZWY5?=
 =?utf-8?B?UGdFZVZsUjdWMUt3UkxuSjdON0p5TkpKM0VvYWhBc2NoTEs1d0Nja25ab2tm?=
 =?utf-8?B?QzVRSzhTYTJUTXdWQnVJb2tEVTZYU2RWZkx5c2RNVDFUS3dsbWFnRVpZR0JS?=
 =?utf-8?B?cENqSjJGcWI4NXFmaE85aEM3ZXN5cUEvVzNTWkgvc2VGZk8wcm5SVlVuUExq?=
 =?utf-8?B?c2phMlVnWE9wK094YUxIQzRrOGtZbkRNNDF2TW9Mb0xidEkrR3duVDFxdm1O?=
 =?utf-8?B?MjhhN1pMY3RpZTJRTkViejlsZEdKVzhVbFliR2ZyUnBpV09yNWNYQ1Jkb3Y0?=
 =?utf-8?B?V0RQMy8rcmo5TzMwQTc0bFluOGlkRkovU3VJTWZHYUZTdFFubi9xb0RyRXd1?=
 =?utf-8?B?VzFQdnJkOVgyTEdGSkhxUy95b001V3FWT2VTN1RzVnJTUVZ1eklMcVBTaVZn?=
 =?utf-8?B?bWVpdGcrSkhWdkp6d25EbHdlemhzYTM3dDRQMGlnNkNuZHRXMkF5NDMrU2JP?=
 =?utf-8?B?enNsNlVGRjU3K3p6dDNBQmRUUFlCemxiNWptQmE3L3EvZ1FySXl6VE9sUmJ3?=
 =?utf-8?B?akNCQWt2Y1VxKzYzcGNIamtvd0RSQUx2c2hpYXJMOEhZNlE4cG1lc3cvcE1Q?=
 =?utf-8?B?UXEyLzFGTnU5WThOUUlmVE0yTmtzS1l3bkFFSjl0ZE85NnVoQVN0N0FFWUht?=
 =?utf-8?B?OHZXbHc0TU5OY1NQU2VTRTcvbXQ2QnJ0RkUwVWd2cTVCZmZ4dmx2MTNiT21l?=
 =?utf-8?B?bi9UQUV2c2JtUm5HbzQ3dXQwV2UydWNnMG8wS2gwWlpWZFg5SHJTVGdsV0Fm?=
 =?utf-8?B?b0lRM3p6Q3VrY1VmSlhaSmp0WXJUbHptY1BKUlF3VldZejZuVVlYMmdiL05Z?=
 =?utf-8?Q?YSGjkPqRFzWR/0scS6YNAAEE+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aabf167d-badc-4b4a-b550-08db986d6c83
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 00:13:14.6249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iJIALn2tAXcgmpTcl6ztbU1/Dtm6XKkHf+w/Zx1oy3gcR/NTEqVMLvsJxyQCl8j7ehrG0aLtWG81hKmaEmOXcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8266
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/2023 12:56 PM, Jo Van Bulck wrote:

> -
> -	if (cmdline_find_option_bool(boot_command_line, "nopti") ||
> -	    cpu_mitigations_off()) {
> +	if (pti_mode == PTI_FORCE_OFF || cpu_mitigations_off()) {

Can mitigations be off through some other mechanisms such as kernel config?

Maybe split the mitigations_off check into a separate if and it's own
unique print message?

The existing code might have the same issue as well.

Also, with the separated check you can avoid the unnecessary re-setting
of pti_mode when pti_mode == PTI_FORCE_OFF is true.


>  		pti_mode = PTI_FORCE_OFF;>  		pti_print_if_insecure("disabled on command line.");
>  		return;
>  	}
>  
> -autosel:
> -	if (!boot_cpu_has_bug(X86_BUG_CPU_MELTDOWN))
> +	if (pti_mode == PTI_AUTO && !boot_cpu_has_bug(X86_BUG_CPU_MELTDOWN))
>  		return;
> -enable:
> +
> +	if (pti_mode == PTI_FORCE_ON)
> +		pti_print_if_secure("force enabled on command line.");
>  	setup_force_cpu_cap(X86_FEATURE_PTI);
>  }
>  
> +static int __init pti_parse_cmdline(char *arg)
> +{
> +	if (!strcmp(arg, "off"))
> +		pti_mode = PTI_FORCE_OFF;
> +	else if (!strcmp(arg, "on"))
> +		pti_mode = PTI_FORCE_ON;
> +	else if (!strcmp(arg, "auto"))
> +		pti_mode = PTI_AUTO;
> +	else
> +		return -EINVAL;
> +	return 0;
> +}
> +early_param("pti", pti_parse_cmdline);
> +
> +static int __init pti_parse_cmdline_nopti(char *arg)
> +{
> +	pti_mode = PTI_FORCE_OFF;
> +	return 0;
> +}
> +early_param("nopti", pti_parse_cmdline_nopti);
> +

In the rare case that both pti= and nopti is set the existing code seems
to ignore the nopti option. Would the new implementation do the same?

Sohil

