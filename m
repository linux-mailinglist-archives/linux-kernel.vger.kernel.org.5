Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9817AF407
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 21:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjIZTTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 15:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjIZTTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 15:19:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B64A121;
        Tue, 26 Sep 2023 12:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695755962; x=1727291962;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RDDnn0RT8BTf+SkiJ/qZGTe7ct79exdI/f5yk+XuDgY=;
  b=kQ+56MTWbovkcjFsEEAKWNEmeNyLKX2qTfo4g3QCvjH5w1JemvMNZSP+
   bj26T2UiPYtRnoeBW1K/TsjDYLXE+QSjKwr6gFb0A5omJdO3BtvS5B3yB
   O4Dem4Sg93AYUa8V/U6+paDGErYbxrtExoWCd0JgF2YlEyQVzPRKKhu4z
   uf0H0lozbLgOPKdrqBKpBLbu47KeQaPoX1YDaTo39ygDqU7gB37OAfFwX
   c5/Nv7jN5vJZxHAu6LyCabHtlj6W8e3vEGpVo8OLcLPn+hJ36FFJ+1KIv
   dHxZpF9cMa/7F/o9fktcbsSwS5DgGyo62IrJYrI8znEA6aWrFxGl97PcE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="380520293"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="380520293"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 12:19:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="814590213"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="814590213"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 12:19:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qlDaX-00000000hOR-0B2j;
        Tue, 26 Sep 2023 22:19:17 +0300
Date:   Tue, 26 Sep 2023 22:19:16 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] platform/x86: intel_speed_select_if: Remove
 hardcoded map size
Message-ID: <ZRMutFhiZ0lIjoeC@smile.fi.intel.com>
References: <20230926175349.989618-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926175349.989618-1-srinivas.pandruvada@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 10:53:49AM -0700, Srinivas Pandruvada wrote:
> The driver is using 256 as the size while calling devm_ioremap(). The
> maximum offset can be obtained from isst_mmio_range. Add a field "size"
> to the isst_mmio_range and use it instead of hardcoding.
> 
> No functional impact is expected.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


