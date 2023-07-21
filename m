Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D2375CC6F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbjGUPtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbjGUPs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:48:57 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD77171B;
        Fri, 21 Jul 2023 08:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689954536; x=1721490536;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R8WEdCXTW/dlJZdkuVMQaXyvnxbiy+28P+8xBmUAS78=;
  b=ktM2sEPiuqIHTOeEDMZYDCHnk3SbiTW/Xo1FmF/0fiMoBBJdZdmDZYWF
   hbYD1K1QJt3P3LPsCS4HpIkOjYJdJl6wMdGCmlmfKqvMbK9RKsRvok5ki
   eq3wUKcLdwaO4YPjNVmqFY4523YTDemQyB53mcN//qxsoGEcb0+Ofs9wz
   csqet0F7rIJxT5gYTsFzdJocXrrBlrBzASWYX61i/9RTkl5R2MsAoivKx
   5H79KVD92emzxhAfLQdizSkrZIw7ECNVJsJiFNruKTSs3b2a/U2H+DbFg
   1h82/sqeBN2xYcrit7O+DxqlvCkWLV7XR6OYcmv6N82MXZqGTaoqKFsc6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="364514619"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="364514619"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 08:48:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="728147277"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="728147277"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 21 Jul 2023 08:48:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qMsN7-00B57Q-0m;
        Fri, 21 Jul 2023 18:48:49 +0300
Date:   Fri, 21 Jul 2023 18:48:49 +0300
From:   "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
To:     "Ng, Boon Khai" <boon.khai.ng@intel.com>
Cc:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Tham, Mun Yew" <mun.yew.tham@intel.com>,
        "Swee, Leong Ching" <leong.ching.swee@intel.com>,
        "G Thomas, Rohan" <rohan.g.thomas@intel.com>
Subject: Re: [Enable Designware XGMAC VLAN Stripping Feature 1/2]
 dt-bindings: net: snps,dwmac: Add description for rx-vlan-offload
Message-ID: <ZLqo4SL+OAovs2In@smile.fi.intel.com>
References: <20230721062617.9810-1-boon.khai.ng@intel.com>
 <20230721062617.9810-2-boon.khai.ng@intel.com>
 <ZLpbPxy4XHEGyU6I@smile.fi.intel.com>
 <DM8PR11MB5751E1290649A690A0B50F7AC13FA@DM8PR11MB5751.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM8PR11MB5751E1290649A690A0B50F7AC13FA@DM8PR11MB5751.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 06:35:44PM +0300, Ng, Boon Khai wrote:
> > From: Shevchenko, Andriy <andriy.shevchenko@intel.com>
> > Sent: Friday, July 21, 2023 6:18 PM
> > On Fri, Jul 21, 2023 at 02:26:16PM +0800, Boon@ecsmtp.png.intel.com wrote:
> > > From: Boon Khai Ng <boon.khai.ng@intel.com>

...

> > > Reviewed-by: Shevchenko Andriy <andriy.shevchenko@linux.intel.com>
> > 
> > This is wrong:
> > - I never reviewed DT bindings in all your series.
> > - My name for the patches is also wrong.
> > 
> > P.S. What I mentioned in the internal mail is that you can add my tag to
> >     the code, and not to the DT. Sorry, I probably hadn't been clear.
> 
> My bad, sorry for interpreting the meaning wrongly, I will remove all the 
> "Reviewed-by" stamp from all the DT patches on the next update.
> 
> However I copied the Reviewed-by: from the previous email, your name
> Shouldn't be wrong.

Oh, this is a bit messy. The address for the kernel work should be
Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


