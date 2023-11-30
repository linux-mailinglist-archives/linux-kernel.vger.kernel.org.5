Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62AF77FF970
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 19:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346482AbjK3Sej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 13:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjK3Seh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 13:34:37 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9782A10D0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 10:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701369283; x=1732905283;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6fe6r4oGXmlWtl87di6jHyTGp2/WvpIkBKBwoyVQYLg=;
  b=Y/7biOELOHvaUmT6kQA7Q9E9aBkBbDhbfk5ne+tN5+/Qa3Qx9ZMWKJ66
   eMMrn8+tbEwLwAVQF0R8MILsEjE2mLgp+xW2MHIBsfmHMKZ9lpoUfbbbp
   NdRdYHAJmjglT9mGDxm/dGe5fL8EwHZmMAaevRL5A4nteUENJEq87eorp
   Wl8jp3OFymrfubALBCYqkUTZIu1f9hPpvIwh9PtvRb+K6SYdUsJDAyo4b
   Mg8DkSB9I/i+byfoSLyVFy+Gew/ISu1UbaZ5aS+f5OLzIBqMNoiNAY8bz
   UMfGYueU/kTJSQoPwX74F2h0aIGS1w69ncNYdEXJHCBa3lKOYHeUzeMeH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="368082"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="368082"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 10:34:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="942799576"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="942799576"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Nov 2023 10:34:43 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 30 Nov 2023 10:34:42 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 30 Nov 2023 10:34:42 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 30 Nov 2023 10:34:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EP/AuIWx8al5dOE3JcgK0+7jt8KkWLCX1CpqyriwopS4Ay/h/hUYizvi5bmXDl4vXD3DKObkWrLcTve1/y93MRYzWJDc9qNG7stK4eM3mjpvvd42ECudvDokxq/puF7Zo/1jQGOkCaPNqgBNBZXNE7A4Fkz/242+k7thmdkX06WBDSBLKDKqRHvdvu6DcULkkPn9oYE1YnXgheL8R8qj8CR2d6VeqzHPSdIW03Lfgrslt/KG4si/XJPW+P0QmeFSWxC/vX4QiD1yA8lrvidB9xTLAlbL/VwWpiXBE1ozwTGE1cePgZjB9hboK+gRBWlmWh104ELmkbYC4+R7il/0Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJcUgCsSdiynKJO7hzshscg1NtcUhNlbHWvyzcmQ2QI=;
 b=eKQjk4XJruju5t1YGvw7ldju0y1pwqoESGLLo8Lhvw7CQirURTWY3daIcknUjrEBNI4F/Fb+jAuYm2HjwBM1UcMhrMrFidkPUFPaPqLaQVvE/wqADh0hrscgUJg+TqVLVWRgwAEm6uJ7faz8VXhM8wZrFvMJA2bh7uFayBOZZJQ1gCPyqtgqYHcHKqAA+TN7aWK4FU9VJx5CHKrLYH36ApdUPS0zX1vmPTshWEtTs962RKwwDEeAWFj3tx/rnyVKQ9RIAJ7Kbmt+/vmXx1yHv2Oi+ELvQoLVFXW81Ez8B+nzn48f6dcYweyZ/6bC99FAowmET6vrV8yV5YzudQdm1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by IA0PR11MB8336.namprd11.prod.outlook.com (2603:10b6:208:490::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 18:34:39 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6299:dc9f:239:202e]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6299:dc9f:239:202e%5]) with mapi id 15.20.7046.023; Thu, 30 Nov 2023
 18:34:39 +0000
Date:   Thu, 30 Nov 2023 10:34:31 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH 2/2] x86/microcode: Rework early revisions reporting
Message-ID: <ZWjVt5dNRjbcvlzR@a4bf019067fa.jf.intel.com>
References: <20231115210212.9981-1-bp@alien8.de>
 <20231115210212.9981-3-bp@alien8.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231115210212.9981-3-bp@alien8.de>
X-ClientProxiedBy: MW4PR04CA0126.namprd04.prod.outlook.com
 (2603:10b6:303:84::11) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|IA0PR11MB8336:EE_
X-MS-Office365-Filtering-Correlation-Id: ddbd28be-cf13-4d05-9ee1-08dbf1d302cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mhKuE73fVsC6UwW+ogo4Mb7l9/CgVqynbt4JLzTsvQLh/J+CS+iCUwa60trKb+Ls/DwzzcUWoDTp5C+8Q+anzQIJAYJSIknLblIOgT/8KuF9lK0Eg2AObGaX2CRE9udG7q+/oJ0fosHSq0zaRpqo390YiRicXzURNmPG5bjpC7NElLz9ZunJRmHCH6ArBkdx1yglbXLdRw6Q2WwgPK2HuiC2oyCtRcLBTVKBK6mACEUXL94in1gPXc7eMRJUSWpRhkUFCbHYKx8tFceevhnQ+WivWqOlmBH4IVEcS62/n+qCAbx1rpv1ba36qvP+KCOtVIH5fd+TnGqBycKSeorfoVtct011RJ5lzuE1KgaFZ/cJAOX0hWVV9ag3II/XBuIVXTpcWyrbNg1spbPxxh2CWgglk85zc+Mb/Yi83JPwa2wyvzLb/lyJoW4POp4oSYmscr71PZrwbYNMzQvpQRM/4NKXIB/1IXFS8hezSdKqBB02zCjEl1bGPDxHoIL2I2J56jkU0jQxQ0qZfGS4QsiLQHmeJlIdddtI3Tfzo0sNg6s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(376002)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(8936002)(8676002)(4326008)(54906003)(66476007)(66556008)(6916009)(66946007)(316002)(2906002)(41300700001)(44832011)(86362001)(5660300002)(26005)(82960400001)(107886003)(83380400001)(478600001)(6486002)(966005)(6512007)(38100700002)(6666004)(6506007)(53546011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DuLe8OjvdM0mSmf4rdYHydamsrrbT+1dOu3IZBMWICIcqbj25TDznfyuznQX?=
 =?us-ascii?Q?Dflm6hBbL1OaFI7JeW89sBLQU3/xe6DwYNUL95Jzcsn3QlhF0MEMebzQvLZ6?=
 =?us-ascii?Q?xYpmta7Irt7WY2aUyC3Mz2G9IrR7nlVZQHTvSk34CoIwqnYS4jwl7GlYCrPE?=
 =?us-ascii?Q?lSlkeU8a5uJGhzfbcooV6RLZbOQmrww+nbDTlfYLwF3pMtC+DUylru7MBNXj?=
 =?us-ascii?Q?+X/yDo93zgG0nKOUQ9HHwK6kEZf/hmqOASU/DKJzP7nr03+uutT4/paSVGFA?=
 =?us-ascii?Q?+g7EHlD9/pCho8eaMip3anpydZFTlqoJERsN7qgzuzOaRmf9oVqK88xR6llD?=
 =?us-ascii?Q?m6RMiyukglUN7GnEsF30VT2G8ArbY4UyseWE1u4hdAxnCppyQNCI35llTHAi?=
 =?us-ascii?Q?EeCCgL48WVBiKKxEWkK6ZQ/2MiK+2BQfA8wFn6bid4ALp8cVyLBZ0Q4/gqji?=
 =?us-ascii?Q?ik0JDXCEo1N+c56oFXvHnuvyf/bS5YF2tw9K60kkTamaLBDwGP2YoyZ6xPEB?=
 =?us-ascii?Q?sL08zgqTzDAyf3uvIxf6IlEgrTBHV2DN8FrGl91Usl2gggn2imYBSryVsCLJ?=
 =?us-ascii?Q?3t1f39K7LO31JhK5s2TcALGXT54nNQXHvyMGqsPzGWzbWeD4vCoHn7KDejTB?=
 =?us-ascii?Q?dPma4CbI1xZpdOd9Qh3Cthca6mb4YPkmEvg/N0uKNdQm1x6KIfkvSJhoNXJD?=
 =?us-ascii?Q?KdsRMYWvY1KBpZi7dJi0iKDRaBaW/bapiTtzcw0cu3+42LlNzvPzV9/FjEJE?=
 =?us-ascii?Q?qUxecc7ULojE1b83TEt1w+iVywiDshswJB/sc/Gd0aN3ePbK8kgLo4ZEpNim?=
 =?us-ascii?Q?jyPaRzvZ5+Gwx6ZARrd4/Y7L69+xIEAhnHrwsw8NMrAKHsLIF7yOsvHTOvjx?=
 =?us-ascii?Q?XBThrP+Dldnd4lFvuRg4oFcdyuPuxFOrfyNtlJ/BY3K20zIr5T8TBgF62CWH?=
 =?us-ascii?Q?dGHzyf6nTetc/NdhCFC/Hr7a/HKCMzLZoVZZbTSoV47VQ2XZO3CBihWXPXk8?=
 =?us-ascii?Q?0qoOdWY4AYT7m+G0xLLAL0ShDGYMekkCr0CK0AV88adZDAvOd8Oo1PKf+Z37?=
 =?us-ascii?Q?IkcTKQfs3Xb6z7P0y1Yy2PVrWSo6XZs1dTd+HVBDzssj+CaxwEkIjQ/i7f8q?=
 =?us-ascii?Q?u+3gELadFxtDclQI6hQ+bbLzeoySapz5K9oOTjMt7sfhAvRlDO+8DEzwVGWC?=
 =?us-ascii?Q?Ozivu+UND3po2x3hEumBlGEmcXK7o1zu90LXM7S62W5tc4BehCc07VDnTNa/?=
 =?us-ascii?Q?eaN3UuENIGm6bhJTDkrwAjvOHp59RS6bSwFiQCDWBvB6feGu+Ao2IpnWO1/f?=
 =?us-ascii?Q?7PJNeHgIbN+3JO8in7j0j+YJtp9Z9XqR2lcReNjPR7d88K3wo4dMyfBEHxDx?=
 =?us-ascii?Q?vkCBz+8n8jMDy0RSWTnWiElDAHXrh35vvcX3156hnGjhrCG20MgzrKCo454j?=
 =?us-ascii?Q?9jN7zf0NERqFMTMQzuPkrqCVpN5p1KKKl2nBUuN/qmG5LnwsgTZPo4qi5gZ0?=
 =?us-ascii?Q?OAk/Hwb6dOVvqHJS3m00lL4nT1AmzRdRHBXm/UAhukaHmcKHEqAzJAdVYPKA?=
 =?us-ascii?Q?a5gci7rWWlRhwZMqQ8FkK8OR99+/9LpR/PWU5VhS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ddbd28be-cf13-4d05-9ee1-08dbf1d302cd
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 18:34:39.5472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XLFH+o62Y9vizlpESlbgutweNVXnVW13uuCeaKPsrSHRzeugc8LVB7sr7ENfCTSqyiNmF/GshAEam1imQwqPwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8336
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On Wed, Nov 15, 2023 at 10:02:12PM +0100, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> The AMD side of the loader issues the microcode revision for each
> logical thread on the system, which can become really noisy on huge
> machines. And doing that doesn't make a whole lot of sense - the
> microcode revision is already in /proc/cpuinfo.
> 
> So in case one is interested in the theoretical support of mixed silicon
> steppings on AMD, one can check there.
> 
> What is also missing on the AMD side - something which people have
> requested before - is showing the microcode revision the CPU had
> *before* the early update.
> 
> So abstract that up in the main code and have the BSP on each vendor
> provide those revision numbers.
> 
> Then, dump them only once on driver init.
> 
> On Intel, do not dump the patch date - it is not needed.
> 
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Link: https://lore.kernel.org/r/CAHk-=wg=%2B8rceshMkB4VnKxmRccVLtBLPBawnewZuuqyx5U=3A@mail.gmail.com
> ---
>  arch/x86/kernel/cpu/microcode/amd.c      | 39 +++++++-----------------
>  arch/x86/kernel/cpu/microcode/core.c     | 12 ++++++--
>  arch/x86/kernel/cpu/microcode/intel.c    | 17 +++++------
>  arch/x86/kernel/cpu/microcode/internal.h | 14 ++++++---
>  4 files changed, 38 insertions(+), 44 deletions(-)
> 

[snip]

>  void load_ucode_ap(void)
> @@ -826,6 +828,12 @@ static int __init microcode_init(void)
>  	if (!microcode_ops)
>  		return -ENODEV;
>  
> +	pr_info_once("Current revision: 0x%08x\n", (early_data.new_rev ?: early_data.old_rev));
> +
> +	if (early_data.new_rev)
> +		pr_info_once("Updated early from: 0x%08x\n",
> +			     early_data.old_rev);

See below, new_rev is always assigned. The above message appears even when
no new microcode was applied.

> +
>  	microcode_pdev = platform_device_register_simple("microcode", -1, NULL, 0);
>  	if (IS_ERR(microcode_pdev))
>  		return PTR_ERR(microcode_pdev);
> diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
> index 6024feb98d29..070426b9895f 100644
> --- a/arch/x86/kernel/cpu/microcode/intel.c
> +++ b/arch/x86/kernel/cpu/microcode/intel.c
> @@ -339,16 +339,9 @@ static enum ucode_state __apply_microcode(struct ucode_cpu_info *uci,
>  static enum ucode_state apply_microcode_early(struct ucode_cpu_info *uci)
>  {
>  	struct microcode_intel *mc = uci->mc;
> -	enum ucode_state ret;
> -	u32 cur_rev, date;
> +	u32 cur_rev;
>  
> -	ret = __apply_microcode(uci, mc, &cur_rev);
> -	if (ret == UCODE_UPDATED) {
> -		date = mc->hdr.date;
> -		pr_info_once("updated early: 0x%x -> 0x%x, date = %04x-%02x-%02x\n",
> -			     cur_rev, mc->hdr.rev, date & 0xffff, date >> 24, (date >> 16) & 0xff);
> -	}
> -	return ret;
> +	return __apply_microcode(uci, mc, &cur_rev);
>  }
>  
>  static __init bool load_builtin_intel_microcode(struct cpio_data *cp)
> @@ -413,13 +406,17 @@ static int __init save_builtin_microcode(void)
>  early_initcall(save_builtin_microcode);
>  
>  /* Load microcode on BSP from initrd or builtin blobs */
> -void __init load_ucode_intel_bsp(void)
> +void __init load_ucode_intel_bsp(struct early_load_data *ed)
>  {
>  	struct ucode_cpu_info uci;
>  
> +	ed->old_rev = intel_get_microcode_revision();
> +
>  	uci.mc = get_microcode_blob(&uci, false);
>  	if (uci.mc && apply_microcode_early(&uci) == UCODE_UPDATED)
>  		ucode_patch_va = UCODE_BSP_LOADED;
> +
> +	ed->new_rev = uci.cpu_sig.rev;

new_rev is always assigned even if there was no microcode to apply.

Feel free to squash this patch if it makes sense.

From: Ashok Raj <ashok.raj@intel.com>
Date: Tue, 28 Nov 2023 15:30:31 -0800
Subject: [PATCH] x86/microcode: Suppress early load message when the revision
 is unchanged

After early loading, early_data.old_rev is always updated, that results in
printing a message even if the revision is unchanged.

Currently, it's displayed as below:

[  113.395868] microcode: Current revision: 0x21000170
[  113.404244] microcode: Updated early from: 0x21000170

This should happen on both AMD and Intel. Although for different reasons.

- On AMD, the ucode is loaded even if the current revision matches what is
  being loaded.
- On Intel, load_ucode_intel_bsp() assigns new_rev unconditionally. So it's
  never 0.

Suppress the "Updated early" message when revision is unchanged.

Fixes: 080990aa3344 ("x86/microcode: Rework early revisions reporting")
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
 arch/x86/kernel/cpu/microcode/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 232026a239a6..18e61ecab005 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -830,7 +830,7 @@ static int __init microcode_init(void)
 
 	pr_info_once("Current revision: 0x%08x\n", (early_data.new_rev ?: early_data.old_rev));
 
-	if (early_data.new_rev)
+	if (early_data.new_rev && early_data.new_rev != early_data.old_rev)
 		pr_info_once("Updated early from: 0x%08x\n", early_data.old_rev);
 
 	microcode_pdev = platform_device_register_simple("microcode", -1, NULL, 0);
-- 
2.39.2

