Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B4379D4BA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234297AbjILPYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235947AbjILPYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:24:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6685D10E5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 08:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694532274; x=1726068274;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aQXO+WHNU3fDYIfBW1/ZzRknvF+MfkC+6+fBxSU80Ts=;
  b=QeecDR6OIWaKnp8h5eiXdRZFNd22XwkIAZsIuRR5Pp6+HNywVpqnb+us
   u1pP/DDcQTv9rvo76TiGFhTR2rXQvgKfya3YmLz6zV6yOdY2oqU2u1Qcc
   HnA8okGIu03KlcF27NzqrpjWBpI3gX0uHIVzezFUWFYnRNUNH4+lheZq8
   TmHAL2tUQsBOyUVLFs3ZLF7YXbqM4LlmPeaaOVpagElnNHY69kyWpG++Z
   p+g7cdjiA26zpoaDxqTBgexYV7WMb23f1Ke0KQu2H6FD4IXys4zkVShwj
   oYI8OrhdGja2mYNQQhkJtMngJBU0L5dFYrUnGkjbyFPGpTkVxPgYTGa8L
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="363440891"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="363440891"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 08:24:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="746928694"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="746928694"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 08:24:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qg5Fd-008cLC-2Z;
        Tue, 12 Sep 2023 18:24:29 +0300
Date:   Tue, 12 Sep 2023 18:24:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v1 3/6] params: Do not go over the limit when getting the
 string length
Message-ID: <ZQCCrfbtH16KjzCE@smile.fi.intel.com>
References: <20230912150551.401537-1-andriy.shevchenko@linux.intel.com>
 <20230912150551.401537-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912150551.401537-3-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 06:05:48PM +0300, Andy Shevchenko wrote:
> We can use strnlen() even on early stages and it prevents from
> going over the string boundaries in case it's already too long.

Should have Cc'ed this and next patch to Kees...

-- 
With Best Regards,
Andy Shevchenko


