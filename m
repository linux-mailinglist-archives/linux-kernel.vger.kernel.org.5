Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBDB7D5721
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 17:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343997AbjJXP6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 11:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343993AbjJXP61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 11:58:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F47A10D1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 08:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698163104; x=1729699104;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Pco9+c9Eg9ly/9DbWSGwpJ4e3CXmtwOqtrtEus796lU=;
  b=fQhM5ey5krIC7/30q/lSdTeYf90w1ZoD5hCtXr+WfdNhkoR0XTSxS5EI
   gJ6zHHVpAhcW/ab17lx7EEdLTsANaMi5qi5Q7BDKlQKSQX0zbbh/2r8WR
   A5asM3rfgYeYIqneZbeInedENVKEX3C6K3Btck86qFbtd75IMjKzfvgv4
   aspn9N0yo9DfKWK1rE5AGMKYST/t6JINOh/IqWxugmuyaovcT9p2iEKe/
   FN7te9ozPEhPv0yFi9G1fKDpg6RNrCAtFXv+JAJydaKpXFTIVgGhfeY1Q
   aUsiPfE5kGO31VHcLXceLQwAslLdYESQaK7yH/CgHA09wh9n86VAsJxh/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="390972036"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="390972036"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 08:58:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="752041799"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="752041799"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 08:58:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qvJnL-00000008KH1-36if;
        Tue, 24 Oct 2023 18:58:15 +0300
Date:   Tue, 24 Oct 2023 18:58:15 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jani Nikula <jani.nikula@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [rft, PATCH v1 0/2] drm/i915/dsi: An attempt to get rid of IOSF
 GPIO on VLV
Message-ID: <ZTfpl/QE99fL3ii/@smile.fi.intel.com>
References: <20231018051052.1328852-1-andriy.shevchenko@linux.intel.com>
 <0c88666a-ff36-b649-d244-ccce500b6c2f@redhat.com>
 <ZS/VE3w7bafj+Kuu@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS/VE3w7bafj+Kuu@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 03:52:36PM +0300, Andy Shevchenko wrote:
> On Wed, Oct 18, 2023 at 11:09:35AM +0200, Hans de Goede wrote:
> > On 10/18/23 07:10, Andy Shevchenko wrote:

...

> > Yes I should be able to find a device or 2 which poke GPIOs from the
> > VBT MIPI sequences. Unfortunately I don't know from the top of my head
> > which devices actually use this, so I may need to try quite a few devices
> > before finding one which actually uses this.
> > 
> > I'll try to get this series tested sometime the coming weeks,
> > depending on when I can schedule some time for this.
> 
> No hurry. maybe you simply can add into your usual tree you run on your
> devices?

FYI, I have just sent a v2, which includes CHV conversion.

-- 
With Best Regards,
Andy Shevchenko


