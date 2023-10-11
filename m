Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E527C5017
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 12:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345729AbjJKK2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 06:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjJKK2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 06:28:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBE492;
        Wed, 11 Oct 2023 03:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697020122; x=1728556122;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rsTD5XJFyXduljJwviN1Mv4D20Kk22vilOkuQcsazDg=;
  b=GYjYJBmdfrMXBXmbBP0cFzF0EHcsKN7Bt2xpMsCzWvl73gg6TadL4X1c
   NMsVPHOycyJHXvgKCFw1RpAQCsl7f2pMjWOwE0pdZmQyw7uxTzS5U1p/9
   Q1hlIZZm6d2XS5JTwOqrwI89uCPVGo7lZMBfMG635n1o8kMRei9gJIP4e
   9hhNQAE9avmZLC5lSJLrQHpXjGUd8J7YNKxhXqBlvJG+j3w9fn81Uzioj
   CaylT+pOFTp6xayUcWiaNa63RKotp4LMSrANpL4sdM2dDwedpbwzfyx2M
   vre7cvpp5Mb75m4oU/s5DxgmSqgImH3zGs7/U1YxkUPnrb6m/P/yKqJ1J
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="387474357"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="387474357"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 03:28:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="877619313"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="877619313"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 03:28:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qqWSD-00000004atZ-1xqL;
        Wed, 11 Oct 2023 13:28:37 +0300
Date:   Wed, 11 Oct 2023 13:28:37 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com
Subject: Re: [PATCH v1] pinctrl: cherryview: reduce scope of
 PIN_CONFIG_BIAS_HIGH_IMPEDANCE case
Message-ID: <ZSZ41Xwg3Z6H/Bhm@smile.fi.intel.com>
References: <20231011064533.20549-1-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011064533.20549-1-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 12:15:33PM +0530, Raag Jadav wrote:
> We have a couple of pinconfig cases inside the braces which are meant for
> PIN_CONFIG_BIAS_HIGH_IMPEDANCE case. Although it is valid C, it makes the
> code less readable and prone to misinterpretation. Limit the braces to
> PIN_CONFIG_BIAS_HIGH_IMPEDANCE case to avoid this.

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


