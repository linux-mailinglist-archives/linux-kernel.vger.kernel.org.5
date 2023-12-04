Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9031B8040C0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 22:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbjLDVJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 16:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjLDVJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 16:09:16 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C196090;
        Mon,  4 Dec 2023 13:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701724163; x=1733260163;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g6e51FNxp+1EJ+cdgD2Lf4wIB+ZA4EpMDcO10MdBrfg=;
  b=GPRHEWTHFN4sV7h4PFc9DPWRKennUQO3dBUJDgcprfIvsaM1J3oKqH3i
   BBAZSul3jaqFUtEwDdp9ipoLlt89RUz/dLzEjNs/Llv3tVwtPDiL8/kMU
   4oqis3HUonyNJTrgtHGzbiwYNyEFnwT0dxigJMHB+KJPAjneBlAff0IlD
   +Z2Vedtj71YKbT60Jjb0a7tMwpqkWC3b40kQqAMDCThF8csvuMSQ51e9F
   ZU12hlNM34FD0C5TxNHndozEhkhOzYgXvncVTWQ3gskPq86CB8ZC6lfwR
   jF0dt/brdiGlrUJ7xT5K9MX9EWGfkEJ6Wtn5T0SvZwuC9FBGb2sa2t+KM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="7125771"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="7125771"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 13:09:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="764097433"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="764097433"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 13:09:19 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1rAGBo-00000001swh-2DtU;
        Mon, 04 Dec 2023 23:09:16 +0200
Date:   Mon, 4 Dec 2023 23:09:16 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petre Rodan <petre.rodan@subdimension.ro>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v7 2/2] iio: pressure: driver for Honeywell HSC/SSC series
Message-ID: <ZW4__HBfiJtwNF_p@smile.fi.intel.com>
References: <20231204194401.20891-1-petre.rodan@subdimension.ro>
 <20231204194401.20891-2-petre.rodan@subdimension.ro>
 <ZW4_OoyKSZ3EBL2x@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZW4_OoyKSZ3EBL2x@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 11:06:03PM +0200, Andy Shevchenko wrote:
> On Mon, Dec 04, 2023 at 09:43:59PM +0200, Petre Rodan wrote:

...

> > +		ret = match_string(hsc_triplet_variants, HSC_VARIANTS_MAX,
> > +						triplet);
> > +		if (ret < 0)
> > +			return dev_err_probe(dev, -EINVAL,
> > +				"honeywell,pressure-triplet is invalid\n");
> 
> Still you can use mentioned device property API.

Repeating here from v7 thread: I think that deduplicating code, esp. when APIs
are available, is a good to have before merging.

-- 
With Best Regards,
Andy Shevchenko


