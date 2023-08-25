Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3930F78844B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 12:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242879AbjHYKJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 06:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240728AbjHYKJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 06:09:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5FC210A;
        Fri, 25 Aug 2023 03:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692958139; x=1724494139;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GX6ONpq0yKRKkuwTZxFQGv7Lr78g0MrzChGMnUkWTQ4=;
  b=htRHZY2eMAJw8ZbnZjtFWLbXc0uR8/2U1ivN7VaJ6+FKLXNW1DNCPV2n
   mt+8xjCwzfnK783b8EqdSg19qZh5t28RQ139oSgCYtEMrxLq8yKj44/2P
   At+Zdt2nmT4bIifqxj4BKCNncETHqJwrlffa+nuNzbg0ULwEBcpMwDWtP
   PQuUBZ1+Q/8Zt8HR9XLHOOIJmDN/6TyQ+L0k7QpfNMcihf5UvnZ2m53WI
   l4XYvLFmZ8X+bcNcH5Mya2qvP9twVJADuOLfeJZVOEPC6Qd0TYjW6narW
   uZhQQd15ajFeUbVFefabPnZPTRDm7Ccy2IxFfrPp2rpOk9wNT9I3SyBgS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="355010067"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="355010067"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 03:08:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="911240050"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="911240050"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 25 Aug 2023 03:08:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qZTkM-00CM62-0M;
        Fri, 25 Aug 2023 13:08:54 +0300
Date:   Fri, 25 Aug 2023 13:08:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linhua Xu <Linhua.xu@unisoc.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        lh xu <xulh0829@gmail.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Subject: Re: [PATCH 1/6] pinctrl: sprd: Modify the probe function parameters
Message-ID: <ZOh9tUvqtdOEnl+e@smile.fi.intel.com>
References: <20230825031826.31599-1-Linhua.xu@unisoc.com>
 <20230825031826.31599-2-Linhua.xu@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825031826.31599-2-Linhua.xu@unisoc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 11:18:21AM +0800, Linhua Xu wrote:
> From: Linhua Xu <Linhua.Xu@unisoc.com>
> 
> For UNISOC pin controller, the offset values of the common register and
> misc register will be different. Thus put these in the probe function
> parameters.

...

> +#define	PINCTRL_REG_OFFSET		0x20

0x0020

> +#define	PINCTRL_REG_MISC_OFFSET		0x4020

...

>  		if (pin->type == GLOBAL_CTRL_PIN) {
> -			pin->reg = (unsigned long)sprd_pctl->base +
> -				PINCTRL_REG_LEN * reg;
> +			pin->reg = (unsigned long)(sprd_pctl->base +
> +				(unsigned long)(PINCTRL_REG_LEN * reg));

Please, make sure you get rid of castings completely. They are weird
for the start and may lead to bugs.

>  			pin->bit_offset = sprd_soc_pin_info[i].bit_offset;
>  			pin->bit_width = sprd_soc_pin_info[i].bit_width;
>  			ctrl_pin++;
>  		} else if (pin->type == COMMON_PIN) {
>  			pin->reg = (unsigned long)sprd_pctl->base +
> -				PINCTRL_REG_OFFSET + PINCTRL_REG_LEN *
> +				sprd_pctl->common_pin_offset + PINCTRL_REG_LEN *
>  				(i - ctrl_pin);
>  			com_pin++;
>  		} else if (pin->type == MISC_PIN) {
>  			pin->reg = (unsigned long)sprd_pctl->base +
> -				PINCTRL_REG_MISC_OFFSET + PINCTRL_REG_LEN *
> +				sprd_pctl->misc_pin_offset + PINCTRL_REG_LEN *
>  				(i - ctrl_pin - com_pin);
>  		}

Ditto.

-- 
With Best Regards,
Andy Shevchenko


