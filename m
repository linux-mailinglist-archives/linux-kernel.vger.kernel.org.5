Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82FA773FB7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbjHHQvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbjHHQuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:50:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FFB17AB0;
        Tue,  8 Aug 2023 08:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691510261; x=1723046261;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r2RdCw5wubTueAn5TyePX68lTy4zhxglWW/YYBYn2F8=;
  b=fXPPDsE+Dv2iP12TPlWJ4/cXrF1J3okUv7MSZvukF0uIGSpnLPsN8BAO
   V7Zy0hKW1GLUUz0BZyfHsQJe0yu62kiqNNXSRNf4QT4tjE+/mKRZBCiTV
   ksA8sjLW1vGPOQhOMUtI5gI/v70e3ttNNkVuqmAViqRUFZ7BrrOxPjEtD
   fdrN4xDxs1VZ/lgvT//fXZ5zWly//9lTXTGnJs/fHeChp4NC6ZdCS3F/b
   Q76NudFvGXpRCD8m0NWNMQDb4g+4BrJe5tZob1xu6P2uqNs10qbbZtqsI
   X6UXg5o4unPGwIgr/ViMOuzbj+cOwtKuzlZys0qBFKihK20BIlGVE+Xlk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="369719978"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="369719978"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 06:28:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="801324246"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="801324246"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 08 Aug 2023 06:28:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qTMky-009lKr-1p;
        Tue, 08 Aug 2023 16:28:16 +0300
Date:   Tue, 8 Aug 2023 16:28:16 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Wenhua Lin <Wenhua.Lin@unisoc.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Samuel Holland <samuel@sholland.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        wenhua lin <wenhua.lin1994@gmail.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Subject: Re: [PATCH 1/2] devicetree: bindings: Add keypad driver ducumentation
Message-ID: <ZNJC8OVzJEQyQugF@smile.fi.intel.com>
References: <20230808072252.3229-1-Wenhua.Lin@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808072252.3229-1-Wenhua.Lin@unisoc.com>
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

On Tue, Aug 08, 2023 at 03:22:52PM +0800, Wenhua Lin wrote:
> Add keypad driver ducumentation.

Why am I Cc'ed to this? I'm not a DT person to review this...

...

> +		reg = 	<0x40250000 0x1000>;

TAB and space mix

-- 
With Best Regards,
Andy Shevchenko


