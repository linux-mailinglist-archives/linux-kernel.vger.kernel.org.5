Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6945786E7B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 13:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241215AbjHXLwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 07:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241286AbjHXLwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 07:52:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B2D19BA;
        Thu, 24 Aug 2023 04:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692877941; x=1724413941;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JK7VPZN31hsDuL1/HeUHXdKKGt1LQLlCREuvkZZlvsE=;
  b=hbvXmcltcGm5SOucj31wdPdG1t1p6OqjjFfit5S0Kf+Zu0pMXMGfj+Qg
   6yOa6hAq0rNNIgpa6Aa95apDUejPT9fZwRQqJ3UvSEYxMiN3PozsBaZeD
   XXRG5YLH3iD4NHc+vzPtpZTbwCLgaObhjWYDdTHFLNksfutC01Dec1uG/
   2l4BHsg9fqrXAdqemCSd2q3n/ZjBWi4697BfKLNTIHZpjE/6pT98Ep22u
   e04z4OVBCtnHdnrbI+uGBwmB9rsDTPdMVBv6cZ+KJhbZjv0wKbAewMcaD
   k6IcLm+eq1wlzigKnAbDN9qLWTo15TEjcIiytRKYkvD+wITzHHySu7x0x
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="405423633"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="405423633"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 04:51:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="740151567"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="740151567"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 24 Aug 2023 04:51:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qZ8sQ-0021nP-0X;
        Thu, 24 Aug 2023 14:51:50 +0300
Date:   Thu, 24 Aug 2023 14:51:49 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mehdi Djait <mehdi.djait.k@gmail.com>
Cc:     jic23@kernel.org, mazziesaccount@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v8 3/7] iio: accel: kionix-kx022a: Warn on failed matches
 and assume compatibility
Message-ID: <ZOdEVYoWSUL3ZETy@smile.fi.intel.com>
References: <cover.1692824815.git.mehdi.djait.k@gmail.com>
 <2c69e918cb6dfab663bb62952c554b6b72f58390.1692824815.git.mehdi.djait.k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c69e918cb6dfab663bb62952c554b6b72f58390.1692824815.git.mehdi.djait.k@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 11:16:37PM +0200, Mehdi Djait wrote:
> Avoid error returns on a failure to match and instead just warn with
> assumption that we have a correct dt-binding telling us that
> some new device with a different ID is backwards compatible.

As we already discussed in the past I think this patch might be
not okay in case a hardware vendor decides to make incompatible
device with non-supported yet ID. It might be even harmful to
the hardware to program register without knowing that this is safe.

That said, I'm neither NAKing nor reviewing this and leave to
maintainers to decide.

-- 
With Best Regards,
Andy Shevchenko


