Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BE675F4D1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 13:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjGXLS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 07:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbjGXLSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 07:18:23 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5A1E56;
        Mon, 24 Jul 2023 04:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690197486; x=1721733486;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=d8vak/LSDsPYk3xgOqhW7O86GgEOYdVGt10seqFukCA=;
  b=MW7T6JMgTVfAv5rabuBG+hTPmmXt0FqWYEfJPKJti1uTaeuMMv1VjX4o
   jtDOagEMELUID2DYyBjiEaJ8HvgRmmqS4ARM5eL4BFuH6lXC80Hm+6t0H
   vEZdGltdjVjK7eQtt3xND2lxeWkI0xqU1WF2Baz0n3kdN3pnMB2wf+LVj
   0PlZn7WKkjSORxzKmLi2sjK2ipPRgZ05JT/2UzFveQR6yKwMS5Cry+j0f
   P3jqMJEhwkL/L41p0oMn75cVH9/5VBp91xD/s//6Tula/IqVXwdwc6Vap
   2lnghAhjOZQJeTvMesfpYQLer4rrmkQmR4ncclSTj0hQysvai5ocjrMOD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="364875141"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="364875141"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 04:16:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="899463688"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="899463688"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 24 Jul 2023 04:16:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qNtYT-00AHg5-0J;
        Mon, 24 Jul 2023 14:16:45 +0300
Date:   Mon, 24 Jul 2023 14:16:44 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc:     Stephen Boyd <sboyd@kernel.org>, Doug Brown <doug@schmorgal.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH v1 1/1] clk: mmp: Switch to use struct u32_fract instead
 of custom one
Message-ID: <ZL5dnFEIiC7lGibK@smile.fi.intel.com>
References: <20230724094838.32596-1-andriy.shevchenko@linux.intel.com>
 <2293793.ElGaqSPkdT@radijator>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2293793.ElGaqSPkdT@radijator>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 12:17:51PM +0200, Duje Mihanović wrote:
> Tested-by: Duje Mihanović <duje.mihanovic@skole.hr>

Thank you for testing!

-- 
With Best Regards,
Andy Shevchenko


