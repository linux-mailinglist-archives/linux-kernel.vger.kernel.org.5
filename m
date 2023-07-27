Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2B8765305
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 13:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbjG0L6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 07:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjG0L6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 07:58:34 -0400
Received: from mgamail.intel.com (unknown [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0F4272A;
        Thu, 27 Jul 2023 04:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690459113; x=1721995113;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hY+8uYrnEMl08IuoLtWPq8No+6FuLjDj9Prajmo6FTE=;
  b=jStp7on7UQ6lEuhRc33J7BIleKv5UeqG43/zO29Z8UQweHssMl0zRjDz
   Kgm8Bp00YqJKk3CPZtx8W4jAKDXABaofcIDQTZRtkYhvZWDCUy3Yu3NAc
   gNm3FHWWsE7bbYrnQi7WB6QHcQ3Hs/8XajA1jS/PKuTHrRtt3sidEg/ow
   MMDFEIDEF3p23cWeE1DwzF7PliIBhVPYQzmxUzxnX9NVwlm/AwtQ8f5ru
   95qbsKBUbAOysXNKU+xukW/g96rn61zQYskDpPIHzazssy/vwxkz32+c+
   dwcNq5fr9RHTbTHfRCsErkFcevlhiYsWx+Iu+ZI2aD/F8e0GOBt+Ift6o
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="353185759"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="353185759"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 04:58:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="704158257"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="704158257"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 27 Jul 2023 04:58:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qOzdW-002kmz-1k;
        Thu, 27 Jul 2023 14:58:30 +0300
Date:   Thu, 27 Jul 2023 14:58:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 1/1] serial: core: Simplify uart_get_rs485_mode()
Message-ID: <ZMJb5lT5BjtSiflM@smile.fi.intel.com>
References: <20230726122335.14187-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726122335.14187-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 03:23:35PM +0300, Andy Shevchenko wrote:
> Simplify uart_get_rs485_mode() by using temporary variable for
> the GPIO descriptor. With that, use proper type for the flags
> of the GPIO descriptor.

It seems I will have more against serial core, perhaps it makes sense to unite
them in a single series.

-- 
With Best Regards,
Andy Shevchenko


