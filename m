Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E67791605
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 13:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352781AbjIDLCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 07:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352768AbjIDLC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 07:02:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0BCAB;
        Mon,  4 Sep 2023 04:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693825342; x=1725361342;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/jMyoju6ZJux8VDzcuGeVRIrNRrTX37ly2ZnWUfckE4=;
  b=ajL+r1bksC7mbGrO6rF4N50sgOD1BKuiTCOhpRPaUH8GCOpf5hnwoyiB
   Z79TmWgmIvxqcitw2tPyekQSCFPKGQ/ijwkhAt1M5k++43SBSGE5O/Crq
   4snqpkx/RK6hs/LnpR2SlKh1XWTIIVUBfjiJ5NTuTLO73STg6Q4BTP+uO
   HxQ4Us5EsZRQ5Y/1VcRt34VOMUXPsoaoSFhDzBfOX98xIHEWT58RlZ4EW
   WRCBb3HkpEsdM+tk4r8h2HivjmJ/gVh3dhKEgfeYaTNvpAZJOiPFWa8DB
   CEvVLa5U/XG5KNsSyge5XapMMiWpVWieBqA+aMbessAPTouof/R0mBfY+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="356894134"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="356894134"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 04:02:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="740721668"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="740721668"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 04:02:19 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 3E3B711F854;
        Mon,  4 Sep 2023 14:02:16 +0300 (EEST)
Date:   Mon, 4 Sep 2023 11:02:16 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Saravana Kannan <saravanak@google.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 1/1] device property: Clarify usage scope of some
 struct fwnode_handle members
Message-ID: <ZPW5OEEXw+C7aH5U@kekkonen.localdomain>
References: <20230904104046.1682875-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230904104046.1682875-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 01:40:46PM +0300, Andy Shevchenko wrote:
> Most of the struct fwnode_handle members are for exclusive use with
> device links framework. Clarify this by adding a respective comment.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
