Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C2077F6C2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 14:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350981AbjHQMub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 08:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350973AbjHQMt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 08:49:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FB42D70;
        Thu, 17 Aug 2023 05:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692276598; x=1723812598;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p0nuCy9DZYhec9JY4+aYto6MRU6VOezCWc58F5J5EUs=;
  b=X6p5+0c61/NDxFCENm3aegGIreqqVd9WJcVRNeFHaxzvKNGMnnPiEp0v
   SZ/kVC+HAdPaqvmHolQQQvHBT75XLyLRDIe3LPwoQjvxdL/o4GAVcKW79
   Qf+sVMmd8UqTe5aiRqeCZI39of6sN7mOWtyzs2LzCiYELfDfX7fT5oaZy
   UzpTC1ZYMdRsmHrmuR38xCSN8R8U6jUjOmicDGCqP0GGbAdM4L6DTfj4t
   k4iobYZ5PyqJoINNmcV5ROYmP1brxVB/+5JkUuYvsMekQkFiMBlfJCn11
   jweiFd9g6QSZ2RCz0eCrbQLTId4Q4rWC67uWvVBl44jVPHkF6ZgpzfSI3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="439153837"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="439153837"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 05:49:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="824627981"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="824627981"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Aug 2023 05:49:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qWcRi-00C62B-2r;
        Thu, 17 Aug 2023 15:49:50 +0300
Date:   Thu, 17 Aug 2023 15:49:50 +0300
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
Subject: Re: [PATCH v6 5/6] iio: adc: mcp3911: avoid ambiguity parameters in
 macros
Message-ID: <ZN4XbrcrWtVRISP9@smile.fi.intel.com>
References: <20230817120518.153728-1-marcus.folkesson@gmail.com>
 <20230817120518.153728-5-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817120518.153728-5-marcus.folkesson@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 02:05:17PM +0200, Marcus Folkesson wrote:
> Name macro parameters after what they represent instead of 'x'.

"And make sure the evaluation of that will have no side effects."

With that (or similar) added,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


