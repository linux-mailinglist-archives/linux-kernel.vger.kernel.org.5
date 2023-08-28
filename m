Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649B478ADFE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 12:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbjH1Ky4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 06:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbjH1KyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:54:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C7EF9;
        Mon, 28 Aug 2023 03:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693220044; x=1724756044;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4pZBnIZicNCdeixiCbnx4jHKlVuLI1o9xP3TnOB5trk=;
  b=jHuAb3szgQCsDF8m5BGU5TF64r5p5CBmGHCEJtrNplgdiOn8B6mYkCIw
   WqqtC1nx1zaRVPyIeLYmFqeT8iTQaBoAphkgUOHDbid4T1AQaVfIA9IzL
   kzOlvFD2vsfRB2T7Vi5darg6qNJAz9NXgt9hcwzeLecUBLTt2kmuqoMz5
   fMBpaX0wbCxS9NfJ6pWpBE5vGOEFqJ+wXHp8EZf3ESJY7TAG268LMdkPx
   9ntPxgsf0WB8CYsMziIkLCNevQajItepGQwZI+3tNrC5E2AnOJ3Rf+M82
   oyVHH9hYz/E+M4UF4WZUxo1iboKFi6xHEdTKGXHcvAxzcf4wOI3dDAHsi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="406063704"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="406063704"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 03:53:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="881901151"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 28 Aug 2023 03:53:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qaZsC-00F2mQ-30;
        Mon, 28 Aug 2023 13:53:32 +0300
Date:   Mon, 28 Aug 2023 13:53:32 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Mehdi Djait <mehdi.djait.k@gmail.com>,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v8 6/7] iio: accel: kionix-kx022a: Add a function to
 retrieve number of bytes in buffer
Message-ID: <ZOx8rAFBXMylgNzm@smile.fi.intel.com>
References: <923d01408680f5ac88ca8ee565a990645578ee83.1692824815.git.mehdi.djait.k@gmail.com>
 <ZOdFyKHBc6BcOgZw@smile.fi.intel.com>
 <eb47d0c9-9144-c947-f91e-d487c6ec9c45@gmail.com>
 <ZOdddZ0Zpk5CknH8@smile.fi.intel.com>
 <CAFukWp2Z0OCrJdTy+wzVs9jdCm70YNR-66q06=xoyGhaHg=aog@mail.gmail.com>
 <ZOdfeaW6AxE4eeqw@smile.fi.intel.com>
 <CAFukWp0ubncNcMiw-s_h5GoP1_RsjTaw3XxayGMuaeJJJneBow@mail.gmail.com>
 <ZOdrtNQijmhN9RAx@smile.fi.intel.com>
 <20230827190732.5e2215d0@jic23-huawei>
 <61247547-690c-fb8b-3a45-cd60754836a7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61247547-690c-fb8b-3a45-cd60754836a7@gmail.com>
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

On Mon, Aug 28, 2023 at 09:24:25AM +0300, Matti Vaittinen wrote:
> On 8/27/23 21:09, Jonathan Cameron wrote:

...

> I think that people who work on a driver like this should guess what this is
> for.

_This_ is the result of what people always forgot to think about, i.e. newcomers.
What _if_ the newcomer starts with this code and already being puzzled enough on
what the heck the function does. With all ambiguity we rise the threshold for the
newcomers and make the kernel project not attractive to start with (besides the
C language which is already considered as mastodon among youngsters).

-- 
With Best Regards,
Andy Shevchenko


