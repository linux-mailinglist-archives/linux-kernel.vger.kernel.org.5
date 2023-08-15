Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B437D77CD91
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 15:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237105AbjHONxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 09:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237445AbjHONxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 09:53:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE4B1990
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 06:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692107571; x=1723643571;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=++moibaST6BWn92qlp06bZ42D2VSV7UGRef46Rs1xGU=;
  b=geNviqfhhZt1TuA1IPiFUsezLIb8jrOoBRd/GFIrWRezuiFbnLfMkuUg
   DMVdaKb7JttBuBNtRY7d2I/PXgEzsOuDeSdqVb9uqcswsUWqTg0K3wfrA
   qS/WDl8m9e9sC62bGWILaJU0ZDpFaKl6rTaUBhp6GuWB8V73VGABpELpT
   u5cUx5kf9FwKjSIU+tpZ9YwKhRCyb4crFn7YYtbyfmQBl5/wv9KZCKUrv
   aYqbrHt8C57qWRzZ7qEEJGHGv/8M/xXcTNwAz5tv9tDflBk6Jl8MUmeK2
   P5H33mkYNI3fcsGj8SauDo4KjL2uoLwl0IP/GghvD/pePlF28HEw1iyoz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="436172026"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="436172026"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 06:52:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="877336881"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 15 Aug 2023 06:52:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qVuTY-003zOZ-1I;
        Tue, 15 Aug 2023 16:52:48 +0300
Date:   Tue, 15 Aug 2023 16:52:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/25] ALSA: dummy: Convert to generic PCM copy ops
Message-ID: <ZNuDMDOipYlOCHKj@smile.fi.intel.com>
References: <20230814115523.15279-1-tiwai@suse.de>
 <20230814115523.15279-5-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814115523.15279-5-tiwai@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 01:55:02PM +0200, Takashi Iwai wrote:
> This patch converts the dummy driver code to use the new unified PCM
> copy callback.  As dummy driver doesn't do anything in the callback,
> it's just a simple replacement.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


