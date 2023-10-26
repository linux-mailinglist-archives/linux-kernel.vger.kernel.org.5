Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66DC07D8293
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 14:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344913AbjJZMZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 08:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjJZMZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 08:25:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED444193;
        Thu, 26 Oct 2023 05:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698323146; x=1729859146;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3oymhqKPLQ4aagYCtM6O+oH5sWgUy/FP7tfThNaeWG0=;
  b=I54iPt2I3QLWJjQKh0i9TYwJE0CKj00Xr8ACy6T5a3Unj7lwcgfXOSm4
   2Eyjpvuc+t328W/3TYDZcQAicJ+qR7Jwh+UeoqLZbQXGl2P70Wr/cFNQE
   btrwk9stlN+hQoDzAkzsblreSxkINcY7dEoK5qNOsF2dn/3v0MEzXwlnB
   xSht0RQ+S7LKCs9J9oIcCOhiHkS+VJPqktOqrfzoRqjv8umsFo0PqKvYt
   o7/MUH547er4h8gxGxX6tGVdQ1eI7tQ65iC4pu8VHgVBNbHcB/TLhKt9L
   u8rtUFVAwtNjCqqOjj4dGMH/bYTJEO7z8hhfjuVhIC0ZSB+kiJCKfmZrs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="333870"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="333870"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 05:25:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="932719324"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="932719324"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 05:25:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qvzQi-00000008qsC-2cYJ;
        Thu, 26 Oct 2023 15:25:40 +0300
Date:   Thu, 26 Oct 2023 15:25:40 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Michal Wilczynski <michal.wilczynski@intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael.j.wysocki@intel.com, lenb@kernel.org
Subject: Re: [PATCH v1 6/6] ACPI: acpi_video: Fix holes in acpi_video_bus
Message-ID: <ZTpaxGRFgP0qsGLX@smile.fi.intel.com>
References: <20231025111806.2416524-1-michal.wilczynski@intel.com>
 <20231025111806.2416524-7-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025111806.2416524-7-michal.wilczynski@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 02:18:06PM +0300, Michal Wilczynski wrote:
> As identified by 'pahole' utility there are holes in acpi_video_bus
> struct. Rearrange elements to get rid of the holes. Put elements
> biggest in size first, and one-byte elements later.

How does this affect the code generation (e.g., measured by bloat-o-meter)?

-- 
With Best Regards,
Andy Shevchenko


