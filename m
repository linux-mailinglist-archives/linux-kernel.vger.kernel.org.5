Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779457A419B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 08:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239945AbjIRG4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 02:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239933AbjIRG4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 02:56:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F809E7;
        Sun, 17 Sep 2023 23:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695020178; x=1726556178;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XrSfw2W0O+t/0lvXd45ewRtfb5Pv7XZcrDJN+rZoBSI=;
  b=gNabwxF8llHsdhIe8maUWf/t/4QlZtH0T6AVWzf8Ggs5A8mJ6Td8qXos
   WZMAR6CEWARYShn24DRsS9+REM5fCcyVKZWSSLrXgppDxS4jpaRAa2VP7
   TXsbS/HdQjtEciMHSR0SFnxbzwz1/1k9KtIupg48kxoU1GZQ+ChWZC6EJ
   7OPWnUJAe/s8oSeJykZkGDqKGpTmAW4zj7goxaXl7zQsATi0oVyKfIk1g
   ugx4dbWQWanywbMYOric2eUZ0Cy4SZ+F+hnbg0spqpK78Pxr3wNul9Wtj
   51m3exxNTO6/ADFXRZGcM1XGlNYE22WciATmptNp3ek9f1ORJYOIMviT1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="383402053"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="383402053"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2023 23:56:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="919354263"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="919354263"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2023 23:56:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qi8B3-0000000DXFJ-33wO;
        Mon, 18 Sep 2023 09:56:13 +0300
Date:   Mon, 18 Sep 2023 09:56:13 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH resend] kstrtox: Remove strtobool()
Message-ID: <ZQf0jUg6DP42Mgi2@smile.fi.intel.com>
References: <87e3cc2547df174cd5af1fadbf866be4ef9e8e45.1694878151.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87e3cc2547df174cd5af1fadbf866be4ef9e8e45.1694878151.git.christophe.jaillet@wanadoo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 16, 2023 at 05:50:11PM +0200, Christophe JAILLET wrote:
> The conversion from strtobool() to kstrtobool() is completed.
> So strtobool() can now be removed.

Thank you for this cleaning up and previous work you have done to make this
occur!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


