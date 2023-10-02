Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4E47B53B5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 15:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237307AbjJBNGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 09:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236163AbjJBNGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:06:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61E093
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 06:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696251979; x=1727787979;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WKIleiWSJ1tR8CzEVhqMwrjvr06Klzw90wrRiXB+SGU=;
  b=a7pX1gSiBiBEAD9N0wDPoHhGb+jS2mx6rHUDvnQ84TC/o/j7UEs5jHZp
   OxMF0Nm1WKLgp2MS7HpKmD946PdU6DPPg/+1FaTmMzEZILeAAdVZTGJ9u
   7rme3Y2FZVda5KThqRbjqo2jT02GNEvrk8Jh+V6cu0Q5bbBzm/2kEMkv3
   c+V8c6Jj43NRZtDon0cRD4LlD0XwwA8+KvY6CfiLm7hIxt9m6KZr/H2CK
   sI8YQAUttxkNRa4RTunha3tdlNFw9HCZnJSJfeYhk1Ox7YkAwgKecIP/i
   xY//sL8lDjlMDdfJnk80hmIrAZo/3uGbcqiGIv/TGp6XiLB3fDh9wPd8Y
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="1219592"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="1219592"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 06:06:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="744107736"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="744107736"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 06:06:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qnIco-00000002A9k-13fD;
        Mon, 02 Oct 2023 16:06:14 +0300
Date:   Mon, 2 Oct 2023 16:06:13 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Joel Granados <j.granados@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH v1 1/3] parport: Use kasprintf() instead of fixed buffer
 formatting
Message-ID: <ZRrARabezuARTMat@smile.fi.intel.com>
References: <20230901134250.1172990-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901134250.1172990-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 04:42:48PM +0300, Andy Shevchenko wrote:
> Improve readability and maintainability by replacing a hardcoded string
> allocation and formatting by the use of the kasprintf() helper.

Sudip, any comments on this series?

-- 
With Best Regards,
Andy Shevchenko


