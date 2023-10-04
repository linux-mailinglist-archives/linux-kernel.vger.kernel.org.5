Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA967B800B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 15:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242525AbjJDNAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 09:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233110AbjJDNAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 09:00:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99A7A1;
        Wed,  4 Oct 2023 06:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696424403; x=1727960403;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Br4t2HHSaW2VwBYRDMtIOXQjAAIRvE4Iyn1UXUJf9Mw=;
  b=XVhaUK5VPdGmk+4vXHKtsJzrQyzmCEri1Vhr+nNomYYkaSXFe+3YT93J
   0tmPbyuAB+FPYncvajjxa2W/xj1mI0t1vD3cxUYyHg34R1XYeCkgPXw91
   wwQ9iDrNTuugkYlryT09XVtewTpCuo4YQIAWTPBXF0Ps29NG4XWMH0Z1u
   00/8/PbshdhUBeUx5IYn+AwBRCd1FYCeFjje4HEazYk0NmO5nTiPKgA0o
   3oRWk5+RXcszQ1+ucG8J1wB9TV8IxcQsXrrJ2rzCwytDlI/sbdRoYvDIm
   4QaWe2CIwYnpdCvyHi2gQbWAgFBWeNrV1sJY7bjNseCZJ/jdH49B6fYUv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="363429523"
X-IronPort-AV: E=Sophos;i="6.03,200,1694761200"; 
   d="scan'208";a="363429523"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 06:00:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="780767763"
X-IronPort-AV: E=Sophos;i="6.03,200,1694761200"; 
   d="scan'208";a="780767763"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 06:00:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qo1Tq-00000002m9b-0kKx;
        Wed, 04 Oct 2023 15:59:58 +0300
Date:   Wed, 4 Oct 2023 15:59:57 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] platform/x86/intel/tpmi: Add defines to get
 version information
Message-ID: <ZR1hzZ4KNZqElGGH@smile.fi.intel.com>
References: <20231003184916.1860084-1-srinivas.pandruvada@linux.intel.com>
 <20231003184916.1860084-2-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003184916.1860084-2-srinivas.pandruvada@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 11:49:14AM -0700, Srinivas Pandruvada wrote:
> Add defines to get major and minor version from a TPMI version field
> value. This will avoid code duplication to convert in every feature
> driver. Also add define for invalid version field.

...

> +#define TPMI_VERSION_INVALID	0xff

I would make it clearer with (GENMASK(7, 5) | GENMASK(4, 0))
or even with specific masks defined and used in both cases:
#def

#define TPMI_MINVER_MASK	GENMASK(4, 0)
#define TPMI_MAJVER_MASK	GENMASK(7, 5)

#define TPMI_VERSION_INVALID	(TPMI_MINVER_MASK | TPMI_MAJVER_MASK)

#define TPMI_MINOR_VERSION(val)	FIELD_GET(TPMI_MINVER_MASK, val)
#define TPMI_MAJOR_VERSION(val)	FIELD_GET(TPMI_MAJVER_MASK, val)

> +#define TPMI_MINOR_VERSION(val)	FIELD_GET(GENMASK(4, 0), val)
> +#define TPMI_MAJOR_VERSION(val)	FIELD_GET(GENMASK(7, 5), val)

-- 
With Best Regards,
Andy Shevchenko


