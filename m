Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE9A7915F3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 12:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348039AbjIDK5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 06:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236333AbjIDK5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 06:57:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42A899;
        Mon,  4 Sep 2023 03:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693825022; x=1725361022;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F6bMJv0iuSajV+sMvvlKQf/YvMy2t++WwT6Fl2VIPlI=;
  b=PzU0HXmmMSuonm1Z6It4cFhLOeuKRCa6sUNA+RTBRj4ew2AGGgRyqaZg
   8ZHOOMXVx4fWy7L4EcG26SQuXJFDOj+esEB2rzT2TyfWP9bwfN9PKozYv
   Lnzw4QMK5+bLBLZ5HM53cUdrkm9VyA/HwVaxuc7klZgWWmvByImmIstzM
   VINgFGMuQ4VDP9tJsn4drY+n2MnetMVhgyZLZKPcEIeZCfbvqnAMvInma
   7WXbBHe0qk8+6nxJlOKU9RV/r/KU4JQ2eFTVc1XyR5BOeG8yBfTLf2quT
   6p/4OEn+HoCSOjm2tX4GVO1DB+kVx/mpKeCqu39W/5uDcOF+Pszs3sUrh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="361598974"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="361598974"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 03:57:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="734279861"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="734279861"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 03:56:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qd7GH-006PAi-0I;
        Mon, 04 Sep 2023 13:56:53 +0300
Date:   Mon, 4 Sep 2023 13:56:52 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Xingui Yang <yangxingui@huawei.com>
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
Message-ID: <ZPW39NRmd0Z0WRwW@smile.fi.intel.com>
References: <20230904084804.39564-1-yangxingui@huawei.com>
 <20230904084804.39564-4-yangxingui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230904084804.39564-4-yangxingui@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 08:48:04AM +0000, Xingui Yang wrote:
> Use DEFINE_SHOW_STORE_ATTRIBUTE helper for read-write file to reduce some
> duplicated code and delete unused macros.

> Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
> Signed-off-by: Xingui Yang <yangxingui@huawei.com>

Same comments as per previous patch.

...

> -/*
> - * Helper macros for setting up debugfs entries.
> - * _name: The name of the debugfs entry
> - * _ctx_struct: The context that was passed when creating the debugfs file
> - *
> - * QLA_DFS_SETUP_RD could be used when there is only a show function.
> - * - show function take the name qla_dfs_<sysfs-name>_show
> - *
> - * QLA_DFS_SETUP_RW could be used when there are both show and write functions.
> - * - show function take the name  qla_dfs_<sysfs-name>_show
> - * - write function take the name qla_dfs_<sysfs-name>_write
> - *
> - * To have a new debugfs entry, do:
> - * 1. Create a "struct dentry *" in the appropriate structure in the format
> - * dfs_<sysfs-name>
> - * 2. Setup debugfs entries using QLA_DFS_SETUP_RD / QLA_DFS_SETUP_RW
> - * 3. Create debugfs file in qla2x00_dfs_setup() using QLA_DFS_CREATE_FILE
> - * or QLA_DFS_ROOT_CREATE_FILE
> - * 4. Remove debugfs file in qla2x00_dfs_remove() using QLA_DFS_REMOVE_FILE
> - * or QLA_DFS_ROOT_REMOVE_FILE
> - *
> - * Example for creating "TEST" sysfs file:
> - * 1. struct qla_hw_data { ... struct dentry *dfs_TEST; }
> - * 2. QLA_DFS_SETUP_RD(TEST, scsi_qla_host_t);
> - * 3. In qla2x00_dfs_setup():
> - * QLA_DFS_CREATE_FILE(ha, TEST, 0600, ha->dfs_dir, vha);
> - * 4. In qla2x00_dfs_remove():
> - * QLA_DFS_REMOVE_FILE(ha, TEST);
> - */

I believe this comment (in some form) has to be preserved.
Try to rewrite it using reference to the new macro.

Otherwise looks good to me.

-- 
With Best Regards,
Andy Shevchenko


