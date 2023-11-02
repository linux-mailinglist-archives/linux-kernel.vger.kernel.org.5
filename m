Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28AFE7DF8EE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 18:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbjKBRlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 13:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjKBRk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 13:40:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0292B186
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 10:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698946853; x=1730482853;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=nsYlMTWUww8YnOWzQWMLZoiChKl1M1Xnh9+qYn0rJ5Q=;
  b=dkk0gRMnmkX/8XWX1Q6dibDmBZHO6YanY0c9dyn2xK/x4LVH6wc4SngV
   jWTaTn14abg84n64xr3P+m+U9ltZUD1U1Glu8hRsN59WLo0kqLB1Qk1Mu
   NbQg00bywG4fEBwTFfMG5h9dlCpa86EVoLSonlNrVduTUgq7w4PXKH5k/
   4IdYILn/9A9H2gGTki+aWAGTcn+7eQhzwEUTwZpqGi+fsGo90VKT4GsRc
   HEUXeN6N8xiI/wNXN1u7qdeNemj23Q2tPdSy1c5dpuaNV6Mm8RdQhyl+8
   EqXmETpOc90cy75aT+Io2Gfi9LjoMqBWISX6IvibJeJI/n2uFNGioHV06
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="10306073"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="10306073"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 10:40:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="761348091"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="761348091"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 10:40:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qybgU-0000000AlQ2-1Eg2;
        Thu, 02 Nov 2023 19:40:46 +0200
Date:   Thu, 2 Nov 2023 19:40:46 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     Jani Nikula <jani.nikula@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>
Subject: Re: [Intel-gfx] [PATCH v3 01/15] drm/i915/dsi: assume BXT gpio works
 for non-native GPIO
Message-ID: <ZUPfHhHOMqrBEFZZ@smile.fi.intel.com>
References: <20231102151228.668842-1-andriy.shevchenko@linux.intel.com>
 <20231102151228.668842-2-andriy.shevchenko@linux.intel.com>
 <ZUPX8RgtrCX8B_Cg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZUPX8RgtrCX8B_Cg@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 07:10:09PM +0200, Ville Syrjälä wrote:
> On Thu, Nov 02, 2023 at 05:12:14PM +0200, Andy Shevchenko wrote:

...

> >  	if (native)
> >  		icl_native_gpio_set_value(dev_priv, gpio_number, value);
> >  	else if (DISPLAY_VER(dev_priv) >= 11)
> > -		icl_exec_gpio(connector, gpio_source, gpio_index, value);
> > +		bxt_exec_gpio(connector, gpio_source, gpio_index, value);
> 
> We could just drop this whole branch since we end up in bxt_exec_gpio()
> in the end anyway. Or we drop the final else and make this one check for
> DISPLAY_VER >=9.

Looking at the code, I'm not sure how we can get rid of it, but the second
option is feasible.

> >  	else if (IS_VALLEYVIEW(dev_priv))
> >  		vlv_exec_gpio(connector, gpio_source, gpio_number, value);
> >  	else if (IS_CHERRYVIEW(dev_priv))

-- 
With Best Regards,
Andy Shevchenko


