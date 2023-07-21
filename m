Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FA075C482
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjGUKUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjGUKT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:19:58 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A03B26A2;
        Fri, 21 Jul 2023 03:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689934754; x=1721470754;
  h=date:from:cc:subject:message-id:references:mime-version:
   in-reply-to;
  bh=C6wVBmCZeZFNIMXqGKN2Zjs/KW8YVqteA5G+zqzpIaw=;
  b=EQZ7ArONq/FCr+NAp8ZNxOyvMJxbZhM4LVpJcjBZ9bAILZgS3nzQRltx
   bSiHGFyCK9QbYsCd/jQW1urPFQ0qc59w5HLf+pcUivxfFb8gvOezRxn+4
   Sv3B6OrEoK9O/rASpB2eb5fPUb1JmJ+TkF42/YTNi+60gkEeTLNaCHc+U
   7RGsEWFAlVXAtGAtza4NLKf3wAplrEmlMwXfVcj5+2ogXV9+bV77MdBOM
   GUPqJtXdave3uz4JHfUrXotTT+DKqIC5gKOjfl1aQ3hVyWBCJSMMZptOK
   sRw967G3Kzhg9wl/y/9dtMu8F0DQP431CQJoQRn2JtWSL7+9UMroBFG2U
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="433219663"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="433219663"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 03:17:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="848786020"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="848786020"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 21 Jul 2023 03:17:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qMnCZ-00HFw5-2w;
        Fri, 21 Jul 2023 13:17:35 +0300
Date:   Fri, 21 Jul 2023 13:17:35 +0300
From:   Shevchenko Andriy <andriy.shevchenko@intel.com>
Cc:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Boon Khai Ng <boon.khai.ng@intel.com>,
        Mun Yew Tham <mun.yew.tham@intel.com>,
        Leong Ching Swee <leong.ching.swee@intel.com>,
        G Thomas Rohan <rohan.g.thomas@intel.com>
Subject: Re: [Enable Designware XGMAC VLAN Stripping Feature 1/2]
 dt-bindings: net: snps,dwmac: Add description for rx-vlan-offload
Message-ID: <ZLpbPxy4XHEGyU6I@smile.fi.intel.com>
References: <20230721062617.9810-1-boon.khai.ng@intel.com>
 <20230721062617.9810-2-boon.khai.ng@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721062617.9810-2-boon.khai.ng@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 02:26:16PM +0800, Boon@ecsmtp.png.intel.com wrote:
> From: Boon Khai Ng <boon.khai.ng@intel.com>
> 
> This patch is to add the dts setting for the MAC controller on
> synopsys 10G Ethernet MAC which allow the 10G MAC to turn on
> hardware accelerated VLAN stripping. Once the hardware accelerated
> VLAN stripping is turn on, the VLAN tag will be stripped by the
> 10G Ethernet MAC.

...

> Reviewed-by: Shevchenko Andriy <andriy.shevchenko@linux.intel.com>

This is wrong:
- I never reviewed DT bindings in all your series.
- My name for the patches is also wrong.

P.S. What I mentioned in the internal mail is that you can add my tag to
    the code, and not to the DT. Sorry, I probably hadn't been clear.

-- 
With Best Regards,
Andy Shevchenko


