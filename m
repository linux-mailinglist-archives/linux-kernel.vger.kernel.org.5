Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53357811BFB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379355AbjLMSKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379350AbjLMSKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:10:09 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DFEAF;
        Wed, 13 Dec 2023 10:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702491014; x=1734027014;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jlsFvOzyqT4lCeHgccX9klrASV6AvbefBdhu1S+ikBs=;
  b=dHdCrEBvzgC3EGwbHds0nRpwvBL4ruXJn8y8W1zShvz4XUWGkuhxzSja
   /2whvIGM3d1wlIOKAU29Q3tk4cFM0vr+m5Ldg9EjX95JjjxL4oj6gvDsp
   T3+3fDcJIhoH+5ZEu6U/wK2c97WAPJO4NHJRGfekQBVr6b04wyHhWq5yv
   if4mjlpIBbv6Q92QN4OMBiisGNlG7moIs/D+l4mn3pNR1PJ9fvtR+u4Vy
   4u6Vxsjo8KYWZZOa3f3LWYYOpOOArmjTx3FgNtDZnVMQ68fXGV7fLTXnf
   HaCo2+gWR+KsfkFFyQSbznVYVtrocYlWV9ynIFVToK+kVe0YsjY/ALP8M
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="385421502"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="385421502"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 10:10:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="864710906"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="864710906"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 10:10:13 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1rDTgQ-00000005bZA-2AaS;
        Wed, 13 Dec 2023 20:10:10 +0200
Date:   Wed, 13 Dec 2023 20:10:10 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 26/40] wdt: ts72xx: add DT support for ts72xx
Message-ID: <ZXnzgo5Bv3Wgfmpp@smile.fi.intel.com>
References: <20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me>
 <20231212-ep93xx-v6-26-c307b8ac9aa8@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212-ep93xx-v6-26-c307b8ac9aa8@maquefel.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 11:20:43AM +0300, Nikita Shubin wrote:
> Add OF ID match table.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


