Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C56F7A9DB7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjIUTqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjIUTpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:45:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1607E7C4;
        Thu, 21 Sep 2023 10:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695318646; x=1726854646;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=r8uWye6WnlR2en4C/jodsgGrDCSliU+HdwgBWRHbfks=;
  b=XlrK9eth3wRizRMoIGRwGN2pvTQhYfJaOoeRKdtjT7bUiWjh50yt3lw+
   cGnLdlKJxc7rOpTVS+u477zRkxIyrJAQ9oDDwllJoCRfczgbdJUW16tbK
   um4MEH/mhtnjnm3Uq7wa/+jbC6MiXvIZ0IIxJacHvBoolH8jwGyAo6ahS
   SA8GUP/8zdO1h4V7Cd0ljizyftNqLG3/s9+QOXUscv0nmed82aJ/aqQ5t
   SX4K4qMrg7jrTHZAl+o2e0h6pCJR0ruFQGMLSQ8YoQp+0cLMosPloY4nx
   0ycYCW1Wb8/tj241HVJj8gbsfG+eu0wfS3FEw+Zvv3u2bmKUC5Pbtrx+L
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="384331410"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="384331410"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 04:18:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="812598581"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="812598581"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 04:18:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qjHhl-0000000GsJe-0Egs;
        Thu, 21 Sep 2023 14:18:45 +0300
Date:   Thu, 21 Sep 2023 14:18:44 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mips@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/6] serial: 8250: remove AR7 support
Message-ID: <ZQwmlJS2QBZFLYt4@smile.fi.intel.com>
References: <20230920201035.3445-1-wsa+renesas@sang-engineering.com>
 <20230920201035.3445-2-wsa+renesas@sang-engineering.com>
 <a86483c4-9ec2-3435-198b-9773379c67be@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a86483c4-9ec2-3435-198b-9773379c67be@linaro.org>
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

On Thu, Sep 21, 2023 at 12:36:05PM +0200, Philippe Mathieu-Daudé wrote:
> On 20/9/23 22:10, Wolfram Sang wrote:

> I'm a bit surprised definitions are removed from the uAPI, isn't
> it expected to be very stable?

They were added to uAPI by mistake to begin with. I don't know why people
still continue adding more there...

Basically we should stop to publish those numbers and move them into
internal header (except those 20 or so, that must stay).

-- 
With Best Regards,
Andy Shevchenko


