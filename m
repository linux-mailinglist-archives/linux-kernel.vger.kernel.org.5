Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A014B78C8A3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 17:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237064AbjH2Pcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 11:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbjH2PcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 11:32:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769D499
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 08:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693323136; x=1724859136;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0n+m++KPN1r3Yvn7PDKqakNtL34RTBQf7rUiOj2lj0A=;
  b=lsDdO/+Ft0Tu+jotrezow4zOvuCGkKfUz9JQKlld7ZBM2PaDdkfQHdTd
   VMjNRBA+AlZOzx2PGIf1LdE8d01fsIzLx8YFjXKVZWmxlEezHbvsv7S2g
   yoA3PApHYLbDwJeaSxR1sBrHegGlVdTum/7WsZiFpdaNuzKOphK9Ezkfk
   gjgV2/VB0LoI07EElzIH/rubUQTWJmc09PMkK+OogYNMOI+SLP9H0H/vY
   zfL5f862aBobg77DR4omJvwL4bfbTSTjydpK/DJ0e8W0ODjz0OphItgLw
   2iq19dKzxnclxZM1+K2dZFcxl6dXZ4TUY9lwXudjSHbTvqeE6RnBWLSAS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="365607520"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="365607520"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 08:32:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="773728259"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="773728259"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 29 Aug 2023 08:32:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qb0hR-004upn-1d;
        Tue, 29 Aug 2023 18:32:13 +0300
Date:   Tue, 29 Aug 2023 18:32:13 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v4 5/8] bitmap: replace _reg_op(REG_OP_RELEASE) with
 bitmap_clear()
Message-ID: <ZO4PfUHs7cDLAQXN@smile.fi.intel.com>
References: <20230829023911.64335-1-yury.norov@gmail.com>
 <20230829023911.64335-6-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829023911.64335-6-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 07:39:08PM -0700, Yury Norov wrote:
> _reg_op(REG_OP_RELEASE) duplicates bitmap_clear().

...

> -	__reg_op(bitmap, pos, order, REG_OP_RELEASE);
> +	bitmap_clear(bitmap, pos, pos + BIT(order));

Is it still buggy?

-- 
With Best Regards,
Andy Shevchenko


