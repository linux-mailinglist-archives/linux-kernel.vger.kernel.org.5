Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0A577798F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 15:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbjHJN1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 09:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbjHJN1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 09:27:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF63E26AC;
        Thu, 10 Aug 2023 06:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691674026; x=1723210026;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NNTKjAQ4/Nbiw5gObH2nRESWhwRRZzoZr3mLclxqhow=;
  b=F52AEd15Lkv8izGmXNJAAZGncCFHi/iN6nsnfiosSrV46kqXDe3a2XzN
   chqoJ9W1/nhD/EqW410iZZvmySdJeICue7bL49ATfFmpAOcsxCAadX3pf
   j9FwmC0k3PhHQwdwV5C8mi6BpXD0q9DIqQi4AIoXNE/LsqM3dt4wxd/w/
   zt6c+QMNGrm0uowQWj+hheIO35aQEIXFtX07XU1CIkIGaP4MJa5+69M/f
   RDnKZwEyYxknpE5p+0vmDHwpJ4IXTt+FtyyN/fgU8KJMeSWABvowSton+
   3lCc1WbjytTHr4/YrqYIQ9CyiTIP4MSM6TA5/JCME+3/Sfm2/bxO5s959
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="435295103"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="435295103"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 06:27:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="855940741"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="855940741"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 10 Aug 2023 06:26:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qU5gk-002j9r-39;
        Thu, 10 Aug 2023 16:26:54 +0300
Date:   Thu, 10 Aug 2023 16:26:54 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v1 2/6] device property: Add
 fwnode_property_match_property_string()
Message-ID: <ZNTlniWf8Ou9hHOT@smile.fi.intel.com>
References: <20230808162800.61651-1-andriy.shevchenko@linux.intel.com>
 <20230808162800.61651-3-andriy.shevchenko@linux.intel.com>
 <20230809185944.1ae78e34@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809185944.1ae78e34@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 06:59:44PM +0100, Jonathan Cameron wrote:
> On Tue,  8 Aug 2023 19:27:56 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

...

> > +int fwnode_property_match_property_string(const struct fwnode_handle *fwnode,
> > +	const char *propname, const char * const *array, size_t n)
> 
> Hi Andy,
> 
> Whilst I'm not 100% sold on adding ever increasing complexity to what we
> match, this one feels like a common enough thing to be worth providing.

Yep, that's why I considered it's good to add (and because of new comers).

> Looking at the usecases I wonder if it would be better to pass in
> an unsigned int *ret which is only updated on a match?

So the question is here are we going to match (pun intended) the prototype to
the device_property_match*() family of functions or to device_property_read_*()
one. If the latter, this has to be renamed, but then it probably will contradict
the semantics as we are _matching_ against something and not just _reading_
something.

That said, do you agree that current implementation is (slightly) better from
these aspects? Anyway, look at the below.

> That way the common properties approach of not checking the return value
> if we have an optional property would apply.
> 
> e.g. patch 3

Only?

> would end up with a block that looks like:
> 
> 	st->input_mode = ADMV1014_IQ_MODE;
> 	device_property_match_property_string(&spi->dev, "adi,input-mode",
> 					      input_mode_names,
> 					      ARRAY_SIZE(input_mode_names),
> 					      &st->input_mode);
> 
> Only neat and tidy if the thing being optionally read into is an unsigned int
> though (otherwise you still need a local variable)

We also can have a hybrid variant, returning in both sides

  int device_property_match_property_string(..., size_t *index)
  {
	  if (index)
		  *index = ret;
	  return ret;
  }

(also note the correct return type as it has to match to @n).

Would it be still okay or too over engineered?

-- 
With Best Regards,
Andy Shevchenko


