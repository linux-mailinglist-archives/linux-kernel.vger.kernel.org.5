Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6020C757F58
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjGROVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbjGROVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:21:41 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9E1171A;
        Tue, 18 Jul 2023 07:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689690096; x=1721226096;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jTsXgXwlkog6FCZK88toyY4s8+rrS2VC81SjBh8qxrY=;
  b=Hwjgh05HZSitMBQvaNIL6+sWJjQYmrDm70h8VdTtt0D01NYZ8jcZ0gci
   YAO72MIrFaL5syZnxM9jwS3vyrOotcbHpO8FutTzFGO/6H40fMYn4CkUO
   Wky+Rgk/1jEDCK/bn3RNZyZaagtTBfcx7p7ygQXkby+l9Qh8rF8DHSspD
   f1Cp7wkJenfRlq3zI07OpOrPzpE4hNz+YPDobvEhx05XChOaCLqLQUoFj
   Nf9xrVK341daVN9cGU6WjhnYZdxQhNtv1MeHxxCYAhZBVwc/e3qKWDxxE
   92Lo1UQQ+p4TX9DqBUx/iNT9x7wHU30ysKlIlzqVGK4TJb+FgYwXaBpqY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="432398451"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="432398451"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 07:21:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="717608162"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="717608162"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 18 Jul 2023 07:21:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qLlZY-00GsSI-1Q;
        Tue, 18 Jul 2023 17:21:04 +0300
Date:   Tue, 18 Jul 2023 17:21:04 +0300
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
Subject: Re: [PATCH 2/3] leds: simatic-ipc-leds: default config switch to
 platform switch
Message-ID: <ZLaf0Cn2kfb0qxJJ@smile.fi.intel.com>
References: <20230718105213.1275-1-henning.schild@siemens.com>
 <20230718105213.1275-3-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718105213.1275-3-henning.schild@siemens.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 12:52:12PM +0200, Henning Schild wrote:
> If a user did choose to enable Siemens Simatic platform support they
> likely want the LED drivers to be enabled without having to flip more
> config switches. So we make the LED drivers config switch default to
> the platform driver switches value.

Same as per previous patch.

-- 
With Best Regards,
Andy Shevchenko


