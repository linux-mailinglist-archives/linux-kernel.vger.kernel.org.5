Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA8379C87A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbjILHrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjILHrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:47:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B9BE73;
        Tue, 12 Sep 2023 00:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694504836; x=1726040836;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=8EXQG8egyIX1ymK9v/zGLmxWtHpBO73t/7Ai9GgfNWA=;
  b=LvcTHqkgTF8per1wwTRdNudXt/67+XLMywAC7rDAg+5s4B0C43Fe7Jrm
   8Pu7oDAI3lw3kl9E+umXNT62dCgCv4T3IKMLxM9eG5qTfproYG7GlKP2B
   WTxaIyd1Qo1GCAQK2S7YKUoRpthXtRqcvxdXjKA+uIThYWftC/yFPadOx
   6YsipvIW6C5D8RytfkcH4OrEG/IGV0dyQqVoTqsEr/9c4i8ka/h7xmIBW
   OmL/R23J7WouUV0wbk+/O6zdv/zYxYzdn3UAiifRb6Mi2ZjJEoIRNShYv
   Bk/BMoaSmVB9jCv00EQ0HMLjng9rXS8fB8QG2sOpq0il3nhx6+M05iRVV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="444742241"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="444742241"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 00:47:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="746776228"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="746776228"
Received: from kscholl-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.63.206])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 00:47:13 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     intel-gfx@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: linux-next: Tree for Sep 11
 (drivers/gpu/drm/i915/display/intel_backlight.o)
In-Reply-To: <eac933bb-eb6d-8b21-422a-b8c6255facc3@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230911121131.006d3fec@canb.auug.org.au>
 <eac933bb-eb6d-8b21-422a-b8c6255facc3@infradead.org>
Date:   Tue, 12 Sep 2023 10:47:11 +0300
Message-ID: <87a5tresu8.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Sep 2023, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 9/10/23 19:11, Stephen Rothwell wrote:
>> Hi all,
>> 
>> Please do *not* include material destined for v6.7 in your linux-next
>> included branches until *after* v6.6-rc1 has been released.  Also,
>> do *not* rebase your linu-next included branches onto v6.5.
>> 
>> Changes since 20230908:
>> 
>> Non-merge commits (relative to Linus' tree): 643
>>  614 files changed, 227990 insertions(+), 9502 deletions(-)
>> 
>> ----------------------------------------------------------------------------
>
> on x86_64:
>
> # CONFIG_ACPI is not set
> CONFIG_DRM_I915=y
> CONFIG_BACKLIGHT_CLASS_DEVICE=m
>
> I915 selects BACKLIGHT_CLASS_DEVICE if ACPI is set.
>
> ld: drivers/gpu/drm/i915/display/intel_backlight.o: in function `intel_backlight_device_register':
> intel_backlight.c:(.text+0x4988): undefined reference to `backlight_device_get_by_name'
> ld: intel_backlight.c:(.text+0x4a1b): undefined reference to `backlight_device_register'
> ld: drivers/gpu/drm/i915/display/intel_backlight.o: in function `intel_backlight_device_unregister':
> intel_backlight.c:(.text+0x4b56): undefined reference to `backlight_device_unregister'

This comes up periodically. The fix is for i915 to depend on backlight,
but it's not possible to fix just i915, as it'll lead to circular deps
unless *all* select backlight is switched to depend on backlight.

I've gone through it once [1], and not keen on doing it again unless
there's buy-in.

IS_REACHABLE() is often suggested as a workaround, but I think it's just
plain wrong. i915=y backlight=m is not a configuration that makes
sense. Kernel configuration is hard enough, there's no point in allowing
dumb configs that just silently don't work.


BR,
Jani.


[1] https://lore.kernel.org/r/1413580403-16225-1-git-send-email-jani.nikula@intel.com



-- 
Jani Nikula, Intel
