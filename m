Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB677A5021
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 19:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbjIRRAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 13:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjIRRAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:00:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7AA83;
        Mon, 18 Sep 2023 10:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695056402; x=1726592402;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lT9p5hv31UMkD34LHrMrkfWLaA5eBFXeiFssGZsvkAw=;
  b=bQ4hX1/Fkyy1omgKjs9kLKQy8z1fs5pzx9TAyLSNQSbJPrT9bVhYNwzv
   hRm+tNH9+mbbTCSGteYSZBvlFcK3PLKvPEB6+Y9mTXimv64DwRBzrDZpp
   FiI/LapHRdhp2K3W0iKz1UkMbxsjHHi/ei+53DDSSjsmgbju1uUrUPJWz
   xLw+iEX3FFoBhhattox/lqY+ZWg6g+GK2K9H6tf2MW+m8TExcT+9+bUNd
   txYs6spX8x4rWked3GU9g5PmaNj+qQdhh9tcgKvRCSLOHD0/TdSs2tKxR
   o9wF8XMOZ5080C8bDz5vcAYN0IqWvu8E6piXcverbN1bBaVFlJUxwEJb2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="378624359"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="378624359"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 10:00:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="889142855"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="889142855"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 09:59:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qiHbH-0000000FUwZ-2I37;
        Mon, 18 Sep 2023 19:59:55 +0300
Date:   Mon, 18 Sep 2023 19:59:55 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Saravana Kannan <saravanak@google.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 1/1] device property: Clarify usage scope of some
 struct fwnode_handle members
Message-ID: <ZQiCC9xoCzwc/nEd@smile.fi.intel.com>
References: <20230904104046.1682875-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230904104046.1682875-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 01:40:46PM +0300, Andy Shevchenko wrote:
> Most of the struct fwnode_handle members are for exclusive use with
> device links framework. Clarify this by adding a respective comment.

Thank you, folks, for the review. Rafael, Greg, who can apply this?

-- 
With Best Regards,
Andy Shevchenko


