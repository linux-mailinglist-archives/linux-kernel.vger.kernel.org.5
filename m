Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F70077CE98
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 16:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237795AbjHOO6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 10:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237875AbjHOO6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 10:58:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A72698;
        Tue, 15 Aug 2023 07:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692111500; x=1723647500;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hE2Z7EIx9lPTY/TXevj9JFdznE6dRVYWEq750m4r8U8=;
  b=ZZbgsT3moijXVESbXXWWYw6xUWwFsNEesoV0xRskDzzU6nYSy/tAun7g
   h0cw7uIR5KUfN8K+/Vpe8ttGMokfTbbnGwhKmgjE50nC3abnqiHgvwrhm
   weXmiIBkZg/VZ5yfhyVDeuxLZbtv6SoP243ctTyrNQ6pBbLjFu27RUMvs
   8zjhZXStNbEUFXMfMhNqhhkv9a50shOFEt8IhKX5pTFz5cqYIAzRQNLh1
   yVlUD/hvzonAtMlErVWKToMid2lbVC7ZxvtfB1X9WpMDOj7iAx8JiNmZ4
   nDSO/q9N5JuppPYIPKyUWBvy4mSSkvSmfLhmygSiT7gO03qQgp3Z54kFR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="403276101"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="403276101"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 07:58:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="803837751"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="803837751"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 15 Aug 2023 07:58:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qVvUr-006FPp-1I;
        Tue, 15 Aug 2023 17:58:13 +0300
Date:   Tue, 15 Aug 2023 17:58:13 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/6] iio: adc: mcp3911: fix indentation
Message-ID: <ZNuShXfOoaLk8Ua1@smile.fi.intel.com>
References: <20230814121010.184842-1-marcus.folkesson@gmail.com>
 <20230814121010.184842-4-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814121010.184842-4-marcus.folkesson@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 02:10:08PM +0200, Marcus Folkesson wrote:
> The file does not make use of indentation properly.

> Fix that.

I'm not sure this is anyhow a fix. Yet you may refer to the checkpatch
if it complains.

...

This kind of change is preferred to be the last in the series or closer
to the end where no more code changed.


-- 
With Best Regards,
Andy Shevchenko


