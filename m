Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6DF78FA46
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 10:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346415AbjIAIye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 04:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjIAIyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 04:54:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CFE10D2;
        Fri,  1 Sep 2023 01:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693558470; x=1725094470;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2/bqX217T+NIJ6k+UnOTcD+QbA7ZngdBr03vA4SIUyg=;
  b=c8OuS/+P8QWJN8QPiY9iu7JqnLWgNkHdDzwdHYFkHwC6BKZo/Dq6vsSl
   ep+dkXk00GCgJqKMAHqqWfynzjPY5oYvbsXjGabRrti/mHEMqaBdq8SGg
   Y9C/tFWT0ikH2e6bJcTOr7huWhojrbQvn4/7QTSfcRZQ3+E48C2NL+DXG
   jqFe6wg6CGkMqDvqGEebKRaYDkmO1O0prAez0kyayAkSjQz4bgX7+OlnQ
   6PvEB8rpUWr+Gse6sFvJ0Lmjxb5rj9uwe22QqPY1JYMWkx7hhRqj0MGLi
   hY9UQ/mNVXbBzdv/evillEUpCXHM5v0uX0YksGMdxNbAXLo2S7Xi9oZYi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="440151313"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="440151313"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 01:54:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="1070669202"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="1070669202"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 01:54:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qbzv1-005cqw-0F;
        Fri, 01 Sep 2023 11:54:19 +0300
Date:   Fri, 1 Sep 2023 11:54:18 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     yangxingui <yangxingui@huawei.com>
Cc:     Luo Jiaxing <luojiaxing@huawei.com>, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        martin.petersen@oracle.com, john.garry@huawei.com,
        himanshu.madhani@cavium.com, felipe.balbi@linux.intel.com,
        gregkh@linuxfoundation.org, uma.shankar@intel.com,
        anshuman.gupta@intel.com, animesh.manna@intel.com,
        linux-usb@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v4 0/5] Introduce a new helper macro
 DEFINE_SHOW_STORE_ATTRIBUTE at seq_file.c
Message-ID: <ZPGmulPTWGa1W3OM@smile.fi.intel.com>
References: <1605164864-58944-1-git-send-email-luojiaxing@huawei.com>
 <ZPDZtR8W1TLcOHW+@smile.fi.intel.com>
 <14010198-c128-4960-0d56-5ee28f4da53f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14010198-c128-4960-0d56-5ee28f4da53f@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 03:11:38PM +0800, yangxingui wrote:
> On 2023/9/1 2:19, Andy Shevchenko wrote:
> > On Thu, Nov 12, 2020 at 03:07:38PM +0800, Luo Jiaxing wrote:
> > > We already own DEFINE_SHOW_ATTRIBUTE() helper macro for defining attribute
> > > for read-only file, but we found many of drivers also want a helper macro
> > > for read-write file too.
> > > 
> > > So we add this macro to help decrease code duplication.
> > 
> > Are you going to pursue this one?
> Hi Andy
> 
> Jiaxing has left his job, and his email is invalid.

OK! Anybody else to continue this to be finished?

-- 
With Best Regards,
Andy Shevchenko


