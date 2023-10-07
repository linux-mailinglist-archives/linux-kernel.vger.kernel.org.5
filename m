Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338E07BC50C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 08:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343576AbjJGGgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 02:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343561AbjJGGgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 02:36:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BA0BD;
        Fri,  6 Oct 2023 23:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696660570; x=1728196570;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AscnAHQRDGeYJGrZWFGvj6OUrTzP92j0NRjNHgyzmn4=;
  b=IkMIIXmzIpD0M+M3Rtr+t6Eg8JmfZ6IjLSs/AkOBKD2Vw2cNEiAl0vIL
   JD8vp+eWs3EeRSU3wJyZmrVwGmSsc8kedzi0mLQmZZ1lPkQflSQjRYBba
   ohgj4kh3EWEFcQGMNA83IUZW9MJkF76ExN0Owfw78IjhXfUYCnD7QysWl
   qcSGjvPiY5K5Kso/KN5FI4HYp6DAMUxpHgEvBV/1/TuhY/GfOOGQ61kPj
   /7lMxqPTAGk5rJnBqLgQG6IUfsIr1YFZlw7GGH8QRHoD5EAqo+9NpCLnX
   OpMPF4a5uHWwEmxm4BbLYwBJTt+40wdOatawIwjcObUBGX3xFzEWryh9Z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="2507156"
X-IronPort-AV: E=Sophos;i="6.03,205,1694761200"; 
   d="scan'208";a="2507156"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 23:36:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="746118245"
X-IronPort-AV: E=Sophos;i="6.03,205,1694761200"; 
   d="scan'208";a="746118245"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga007.jf.intel.com with ESMTP; 06 Oct 2023 23:36:07 -0700
Date:   Sat, 7 Oct 2023 14:35:17 +0800
From:   Xu Yilun <yilun.xu@linux.intel.com>
To:     Marco Pagani <marpagan@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: Re: [PATCH v2 0/4] fpga: add platform drivers to the FPGA KUnit test
 suites
Message-ID: <ZSD8JXDIr9cZ4BON@yilunxu-OptiPlex-7050>
References: <20230929152057.85047-1-marpagan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929152057.85047-1-marpagan@redhat.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 05:20:53PM +0200, Marco Pagani wrote:
> Add and register minimal platform drivers associated with parent
> platform devices used for testing to prevent a null-ptr-deref when
> try_module_get() is called.
> 
> v2:
> - Renamed include guard symbol in fpga-test-helpers.h
> 
> Marco Pagani (4):
>   fpga: add helpers for the FPGA KUnit test suites.
>   fpga: add a platform driver to the FPGA Manager test suite

I added the Closes tag and applied the series.

Thanks,
Yilun

>   fpga: add a platform driver to the FPGA Bridge test suite
>   fpga: add a platform driver to the FPGA Region test suite
> 
>  drivers/fpga/tests/fpga-bridge-test.c  | 18 +++++++++++++++-
>  drivers/fpga/tests/fpga-mgr-test.c     | 18 +++++++++++++++-
>  drivers/fpga/tests/fpga-region-test.c  | 26 ++++++++++++++++++-----
>  drivers/fpga/tests/fpga-test-helpers.h | 29 ++++++++++++++++++++++++++
>  4 files changed, 84 insertions(+), 7 deletions(-)
>  create mode 100644 drivers/fpga/tests/fpga-test-helpers.h
> 
> 
> base-commit: 6465e260f48790807eef06b583b38ca9789b6072
> -- 
> 2.41.0
> 
