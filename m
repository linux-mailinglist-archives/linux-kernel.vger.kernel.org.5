Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A217DBDC9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 17:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbjJ3Q0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 12:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjJ3Q0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 12:26:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503EA9E;
        Mon, 30 Oct 2023 09:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698683201; x=1730219201;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d9S6c/pVGFDBczd8S2/JaIcyqT/Qv2W1jh05agMin1c=;
  b=ah4FJr09nw0esnZMDFOrOvNwnk++j1egVDwyYD6p/TFrOTVK/3Z3RqgA
   V/+767eL2o8GEq7v+9KpydmdDwCdJwSeIzkC53RuOHnasLs36/F8s0Wb/
   ULAOfDuFp1DWKhdV/enKhbv7KXUx9SQ13rzqkKfpUfrRCuHyn36d3xLra
   z6K4VbeMj6AQ+16Q4Te5bLUUpi0Ddx7hjsdAjdtNoTnjlYpBj/FQMi2IS
   f6+ZaNRD/Uo31LxK/PNh3rdZ2m+fESYh2k/FF0SlLaz8x/qXd81ScI1ce
   kh9UMv7RxLG93Axm3p8tznYRDt5cQT3W6IUV9nXtKB2S4YcdWwDIRzp6P
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="390973606"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="390973606"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 09:26:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="877186870"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="877186870"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 09:26:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qxUip-00000009vbO-010K;
        Mon, 30 Oct 2023 18:02:35 +0200
Date:   Mon, 30 Oct 2023 18:02:34 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] pinctrl: baytrail: Move default strength
 assignment to a switch-case
Message-ID: <ZT_TmmFBNpexS-Pl@smile.fi.intel.com>
References: <20231030155427.3468671-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030155427.3468671-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 05:54:27PM +0200, Andy Shevchenko wrote:
> iWhen ->pin_config_set() is called from the GPIO library (assumed
> GpioIo() ACPI resource), the argument can be 1, when, for example,
> PullDefault is provided. In such case we supply sane default in
> the driver. Move that default assingment to a switch-case, so
> it will be consolidated in one place.

Scratch this, it will be part of the bigger series.

-- 
With Best Regards,
Andy Shevchenko


