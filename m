Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635747F19A8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbjKTRTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbjKTRTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:19:16 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41279110
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700500753; x=1732036753;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tftpT5rZLKbRyBjfdRG89+3WcMyMC/cSf3NwsXLUelU=;
  b=OI6c0JHcay2BTRndWa0URny2YQHvkMc+yWYZov83h4hX1Hz7//MS5/7M
   Vo68FpWEBgrF/aLqB8qKfBGjh3GzEnYrDO+9qYOhYnVMlWn5lAgBj2qgU
   uD3i2lIsMKsgIfcOcvvg3dOHg9k+iIpIx+sMgyg6e1M1hI23W2DQHyDM1
   MFoJv8IGJZKgQy9b0HH/2VO5IIFw7OvizXSr8cQPGlxlsVxtpse2VD50f
   cjTkKa+CFgbVFLl+BrUrBR3NeXenElAIFiKPGsFLE/mi+OlDmbvh1vfIY
   pDWcBIrolftl3mR//646GP/HaTBdItZ3mRFBKsaaZnNi1FVGnLAqz+yqY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="371007205"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="371007205"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 09:19:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="795520290"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="795520290"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 09:19:10 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r57vQ-0000000Fbs1-1r1g;
        Mon, 20 Nov 2023 19:19:08 +0200
Date:   Mon, 20 Nov 2023 19:19:08 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [resend, PATCH v1 1/1] logic_pio: Use RESOURCE_SIZE_MAX
 definition
Message-ID: <ZVuVDBW3grRB-Cto@smile.fi.intel.com>
References: <20231016132611.1201402-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016132611.1201402-1-andriy.shevchenko@linux.intel.com>
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

On Mon, Oct 16, 2023 at 04:26:11PM +0300, Andy Shevchenko wrote:
> Use a predefined limit instead of hardcoding it.

Any comments on this?

-- 
With Best Regards,
Andy Shevchenko


