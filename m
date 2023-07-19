Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A720A7599B6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjGSP2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbjGSP14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:27:56 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05BF12F;
        Wed, 19 Jul 2023 08:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689780469; x=1721316469;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=giYj7E79SFC5uRRCOZ1jC9xYfhxyjyPap8ZnCxguQFA=;
  b=d6r1PddSr5df82hHa+p1ElWwwfZ9gIogRalyImE7Mpahgy1HGOBYAELA
   V/UxAT6Webd3G43OOdx+VJ0o1dkxWtixeux0QPoY5oXNK1Y/X7i5lVOAd
   XMR2RQhMR5Z+hlsaNR+0Xo2eUJsc4lVoRdedXkCpVL41EbyYVHu+KvIiC
   xrWqTaZ95JAL+bUQGyd7noDwrIMWbpQnhGsh7PSSICw508ZN7c7wxsqQ/
   7khOEz9raqEMul+4o3riO/4uocJLBdJZy3DKguKMIdXwQ4p/oFo0C/bnq
   QvIpluYoRGglBeybsT2CfrwHjl4C9P+iTTpa0VrVsq9tpHU3cT2HJAgjZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="351362464"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="351362464"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 08:27:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="753744424"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="753744424"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 19 Jul 2023 08:27:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qM95d-00GAUI-2l;
        Wed, 19 Jul 2023 18:27:45 +0300
Date:   Wed, 19 Jul 2023 18:27:45 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Milan Zamazal <mzamazal@redhat.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Subject: Re: [PATCH v3] iio: core: Prevent invalid memory access when there
 is no parent
Message-ID: <ZLgA8QG67QGROzwW@smile.fi.intel.com>
References: <20230719083208.88149-1-mzamazal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719083208.88149-1-mzamazal@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 10:32:08AM +0200, Milan Zamazal wrote:

> Changes in v3:
>  - The call trace in the commit message reduced to the minimum lines
>    needed to explain the problem.

Precisely, that deserves my tag which I already had given :-)
Thank you!

-- 
With Best Regards,
Andy Shevchenko


