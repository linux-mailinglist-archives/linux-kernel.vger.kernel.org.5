Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB277A978A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjIURZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjIURYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:24:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AC015A34;
        Thu, 21 Sep 2023 10:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695316303; x=1726852303;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=vvWk5lwMmbRSN+gAu/AiftGVMBLQN6q37NEHikPsVPM=;
  b=SpgcGqq6ctrje7nlEnKb0q4jVcQfaCtUMFv59yd49s5HtnAGMpIiSH1b
   fJFqZMKld/Z5UV91RypRAH3R7BLLHbueV8rlwa/YvZ75h3ybApw4732UP
   J5tJN6bPA0UhAjQo8RSAvd9tQymIorw/p0FHKA4UMTa7rEYmtJ8Ump1tt
   htiU5mAYeWMc16we2xLBpAZIlK9T4xYlouPMqDsClv32aMPNaOYyY3MC3
   kqrBM4GJf7tmFeXlqeJhjrMSEhMvT8FxCCmKDzzN3g+2zAcW55+cY3qj1
   +Eu/eLlHi15laAp6XW6JTFUSXmotLvYtl/miwceuh/TofsNkuOgefhTYZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="370807288"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="370807288"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 04:16:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="723705661"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="723705661"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 04:16:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qjHfE-0000000GsHA-3XCG;
        Thu, 21 Sep 2023 14:16:08 +0300
Date:   Thu, 21 Sep 2023 14:16:08 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mips@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/6] serial: 8250: remove AR7 support
Message-ID: <ZQwl+OXvhA6/x6f1@smile.fi.intel.com>
References: <20230920201035.3445-1-wsa+renesas@sang-engineering.com>
 <20230920201035.3445-2-wsa+renesas@sang-engineering.com>
 <a86483c4-9ec2-3435-198b-9773379c67be@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a86483c4-9ec2-3435-198b-9773379c67be@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 12:36:05PM +0200, Philippe Mathieu-Daudé wrote:
> On 20/9/23 22:10, Wolfram Sang wrote:

> > --- a/include/uapi/linux/serial_core.h
> > +++ b/include/uapi/linux/serial_core.h
> > @@ -32,7 +32,6 @@
> >   #define PORT_XSCALE	15
> >   #define PORT_RM9000	16	/* PMC-Sierra RM9xxx internal UART */
> >   #define PORT_OCTEON	17	/* Cavium OCTEON internal UART */
> > -#define PORT_AR7	18	/* Texas Instruments AR7 internal UART */
> 
> I'm a bit surprised definitions are removed from the uAPI, isn't
> it expected to be very stable? Shouldn't it be better to keep it
> defined but modify the comment, mentioning "obsolete" or "deprecated"?

The numbers up to 20 must stay, they are being used somewhere, setserial
implementation in busybox (IIRC).

NAK.

-- 
With Best Regards,
Andy Shevchenko


