Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABC87A5005
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjIRQ6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjIRQ5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:57:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FDEBF
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695056265; x=1726592265;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LoHrUz4HloF7i91ZOnTnIldDYZxmI+ChqmUmJcHbdYg=;
  b=ep7ZUJjKOEQvAW12vi5Jex6SOn3iV6rmk/7j+vi+JZ2W//aWDL4JJJBg
   pHXflm+aA7yrHyWn85vOiBVOpL7OMR50zVoyi4l+HEHzkzoosZ9qe924g
   JFCoKqnTaORocLB27u2hxAlTPSLiTgo5DfnlWlQVR5ZmLEaGT6c/DUfMm
   7bww27MeFWjg8rk2ZFw9dr4mzn3W7aQ+ClXjg9n7sgZ07DjQY66JG6myJ
   PsEYb8rM3KePXFubKI5JAL6Qdi6mKKkP3sfqjOawTLK4nw55Nyu4s97Fm
   bzXn8JHBIKLODaSqCaox/OPdid6xNqIcFnUxdVBCx9E687d41kiPl0YF5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="359131616"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="359131616"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 09:57:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="836113094"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="836113094"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 09:57:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qiHZ7-0000000FQOZ-1dy3;
        Mon, 18 Sep 2023 19:57:41 +0300
Date:   Mon, 18 Sep 2023 19:57:41 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v1 1/6] params: Use sysfs_emit() to instead of scnprintf()
Message-ID: <ZQiBhRCGG13CNWqt@smile.fi.intel.com>
References: <20230912150551.401537-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912150551.401537-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 06:05:46PM +0300, Andy Shevchenko wrote:
> Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> should only use sysfs_emit() or sysfs_emit_at() when formatting the
> value to be returned to user space.

Any comments?

-- 
With Best Regards,
Andy Shevchenko


