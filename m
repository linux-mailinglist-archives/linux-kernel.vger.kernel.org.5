Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BC27F34AF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 18:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbjKURPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 12:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbjKURPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 12:15:43 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C391510E;
        Tue, 21 Nov 2023 09:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700586939; x=1732122939;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S9sccXWZMCeaoBSIUXxMBPcEyCWpWSBji+ESLneAGus=;
  b=d22j2hlc/T042yw7s5LhdIUA08tuxljEjmSSJjYdNoSwkIMtQN6j1STt
   GL33z5Bb3ZsPgq3wuFL0giw5CE+elUjtpBBfPpYv6Jtfx8isxrEIBqnVb
   L9RIK0yTkfEE0KSSlMIRRcO+9HDsB4G9CqqmBCMQ7FBdjdPpUOgYYkFwP
   sDn6HyZPa2YG3UO8BzVaBqC294QAq/dirKedBYRQ3/VtfHtRwvBJ5il0s
   X/30dYda26iFnLmPw7npULOC0kURoTbQc7ocwNrnSt2BN5U3l+3HsJS+o
   goWG6b8na6Jb5dZn2aMRH4lRcsiE0hiOEbssvefEUO2+eXMBnAVAFRTVZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="5012006"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="5012006"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 09:15:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="760154432"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="760154432"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 09:15:36 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r5ULV-0000000Fs7k-3WXX;
        Tue, 21 Nov 2023 19:15:33 +0200
Date:   Tue, 21 Nov 2023 19:15:33 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [rft, PATCH v1 1/1] pinctrl: qcom: lpass-lpi: Remove unused
 member in struct lpi_pingroup
Message-ID: <ZVzltQByY1Z0pOGI@smile.fi.intel.com>
References: <20231120193353.1670732-1-andriy.shevchenko@linux.intel.com>
 <c622c2a5-665f-4ee3-b3dd-fafb3adf6191@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c622c2a5-665f-4ee3-b3dd-fafb3adf6191@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 08:14:09AM +0100, Krzysztof Kozlowski wrote:
> On 20/11/2023 20:26, Andy Shevchenko wrote:
> > The group is not used anywhere, remove it. And if needed, it should be
> > struct pingroup anyway.
> > 
> > While at it, replace kernel.h with what exactly being used.
> 
> Missing Reported-by and Closes by for LKP... Unless you discovered it
> without its report?

It's just at hand discovery.

> Missing sm8550.

And sm8650, but there LPI_FUNCTION(gpio) and I'm wondering why LKP complains
about it. It's really a maze to me.

> >  #define LPI_PINGROUP(id, soff, f1, f2, f3, f4)		\
> >  	{						\
> > -		.group.name = "gpio" #id,			\
> > -		.group.pins = gpio##id##_pins,		\
> 
> Aren't these used by core pinctrl code?

Only via APIs and pin control registered them also via APIs, so I don't think
this is being used directly. But if you see how, tell me! I spent already a few
hours on this and haven't got any clear picture in my mind.

-- 
With Best Regards,
Andy Shevchenko


