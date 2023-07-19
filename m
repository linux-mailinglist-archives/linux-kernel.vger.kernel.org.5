Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB684759A7C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 18:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbjGSQJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 12:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjGSQJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 12:09:45 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607EA113;
        Wed, 19 Jul 2023 09:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689782984; x=1721318984;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bfmNxrSOSuOKyNBS+iuM0AhQyIpxlWUsNNWHaPn1DrQ=;
  b=MMiqb4ahPGRrPldVkBfeQtmyBY5lk5w2qhLFzObq3JJ64RaJhUcQk2iq
   QdWNFWYL4lW1Gz6gvO9QbBQiTOkY+7k1u6ewCxecygQyC6A8kPzu43JC4
   FeKILvJB6hh4RlVdMSJVbYCb8V+3m06FOlDz4eihBFEMJhB8Ww76+5k0/
   s5Y+uVNTTbGdZ0/eIx+bugpUbKCrrksISTUKNYl0d1g8X3JDqHgEjH9Jf
   cHU83+WyxKXml1VTKnPq5GDRUX2QkQFcJtnzaicBGsJrEA9wLW3+3hrLH
   FYMl5sOkMnFZeGHyZDImPGWZAi/9tEBRRhNQ/RYcFSnVVntRrLc4afl+a
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="356464764"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="356464764"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 09:06:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="674352133"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="674352133"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 19 Jul 2023 09:06:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qM9gj-00HVG2-0p;
        Wed, 19 Jul 2023 19:06:05 +0300
Date:   Wed, 19 Jul 2023 19:06:04 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Lee Jones <lee@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Mark Gross <markgross@kernel.org>,
        Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: Re: [PATCH v2 0/3] platform/x86: move simatic drivers into subdir
Message-ID: <ZLgJ7Oz1XlicGzEn@smile.fi.intel.com>
References: <20230719153518.13073-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719153518.13073-1-henning.schild@siemens.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 05:35:15PM +0200, Henning Schild wrote:
> change since v1:
>  - switch LED/wdt Kconfig to "default y"
>  - remove guard which could hide whole siemens submenu, and default m
> 
> This series does two things. It builds up a Kconfig inheritance chain
> for all platform device drivers, namely Watchdog and LED. And then it
> puts all Siemens Simatic IPC drivers in the platform/x86/ directory in
> a subdirectory called "siemens".
> 
> That is so that users have to flip less config switches, and to ease
> maintenance.

All three good enough, although I prefer the ordering that 'tristate'
followed by 'default' without interleaved 'depends on'. I leave it
to Hans. Other that that,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


