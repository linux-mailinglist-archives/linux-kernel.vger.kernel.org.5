Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BDA79190F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 15:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238668AbjIDNqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 09:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbjIDNqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 09:46:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D074CD7;
        Mon,  4 Sep 2023 06:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693835173; x=1725371173;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Je0PTQIr7elkbrBKVWrn47OMjVkBHZODPGlR145fXzs=;
  b=FkKx0c6jWTY8aV8VUV91BBJMx0Mm7GvVk/gEm70uRFgfrtz+DszQs0qT
   T2/xGlAty00Eo0ijWNRbDUpqt7JGwxxFSAQseKh0VA2XuxP/G8QYVj7YV
   rZG4IYpq0G9csEY57Hd5oAQMixG70iIEtuEDabNCGkN6Giku2gSsyP+Lv
   T3Ga02UkCxGgvvPSVOb94EI1MfUToYCRtB3ApcmLR5YJj1YdHkZ877XvW
   EvWAZ54pg0j+0TuBahmY2IyrfKHIgCngzerf26GobSGArkY5Ap8o7rCYv
   ajSaFnyJVb48FERNBkUcfT1IrdAZdQIqd5YuwSbPHFZYa8rxX+r/iMuWx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="380397734"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="380397734"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 06:46:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="1071621238"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="1071621238"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 06:45:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qd9tp-006Rbm-3A;
        Mon, 04 Sep 2023 16:45:53 +0300
Date:   Mon, 4 Sep 2023 16:45:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     yangxingui <yangxingui@huawei.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        john.g.garry@oracle.com, damien.lemoal@opensource.wdc.com,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        himanshu.madhani@cavium.com, felipe.balbi@linux.intel.com,
        gregkh@linuxfoundation.org, uma.shankar@intel.com,
        anshuman.gupta@intel.com, animesh.manna@intel.com,
        linux-usb@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        prime.zeng@hisilicon.com, kangfenglong@huawei.com,
        chenxiang66@hisilicon.com
Subject: Re: [PATCH v5 3/3] scsi: qla2xxx: Use DEFINE_SHOW_STORE_ATTRIBUTE
 helper for debugfs
Message-ID: <ZPXfkV7DYsxx179W@smile.fi.intel.com>
References: <20230904084804.39564-1-yangxingui@huawei.com>
 <20230904084804.39564-4-yangxingui@huawei.com>
 <ZPW39NRmd0Z0WRwW@smile.fi.intel.com>
 <6408e1c5-df6a-e257-26c8-2d100be6db97@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6408e1c5-df6a-e257-26c8-2d100be6db97@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 09:05:29PM +0800, yangxingui wrote:
> On 2023/9/4 18:56, Andy Shevchenko wrote:
> > On Mon, Sep 04, 2023 at 08:48:04AM +0000, Xingui Yang wrote:

...

> > > -/*
> > > - * Helper macros for setting up debugfs entries.
> > > - * _name: The name of the debugfs entry
> > > - * _ctx_struct: The context that was passed when creating the debugfs file
> > > - *
> > > - * QLA_DFS_SETUP_RD could be used when there is only a show function.
> > > - * - show function take the name qla_dfs_<sysfs-name>_show
> > > - *
> > > - * QLA_DFS_SETUP_RW could be used when there are both show and write functions.
> > > - * - show function take the name  qla_dfs_<sysfs-name>_show
> > > - * - write function take the name qla_dfs_<sysfs-name>_write
> > > - *
> > > - * To have a new debugfs entry, do:
> > > - * 1. Create a "struct dentry *" in the appropriate structure in the format
> > > - * dfs_<sysfs-name>
> > > - * 2. Setup debugfs entries using QLA_DFS_SETUP_RD / QLA_DFS_SETUP_RW
> > > - * 3. Create debugfs file in qla2x00_dfs_setup() using QLA_DFS_CREATE_FILE
> > > - * or QLA_DFS_ROOT_CREATE_FILE
> > > - * 4. Remove debugfs file in qla2x00_dfs_remove() using QLA_DFS_REMOVE_FILE
> > > - * or QLA_DFS_ROOT_REMOVE_FILE
> > > - *
> > > - * Example for creating "TEST" sysfs file:
> > > - * 1. struct qla_hw_data { ... struct dentry *dfs_TEST; }
> > > - * 2. QLA_DFS_SETUP_RD(TEST, scsi_qla_host_t);
> > > - * 3. In qla2x00_dfs_setup():
> > > - * QLA_DFS_CREATE_FILE(ha, TEST, 0600, ha->dfs_dir, vha);
> > > - * 4. In qla2x00_dfs_remove():
> > > - * QLA_DFS_REMOVE_FILE(ha, TEST);
> > > - */
> > 
> > I believe this comment (in some form) has to be preserved.
> > Try to rewrite it using reference to the new macro.
> Thanks for your reply, I checked and these macros aren't being called
> anywhere else, so I decided to delete them all. Of course, maybe this macro
> will be used in the future, and I can resubmit another version based on your
> suggestion.

Of course you need to rewrite it to use new approach.

-- 
With Best Regards,
Andy Shevchenko


