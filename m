Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA2C76A1D8
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 22:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjGaU1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 16:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjGaU1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 16:27:38 -0400
Received: from mgamail.intel.com (unknown [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C111723;
        Mon, 31 Jul 2023 13:27:36 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="369124347"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="369124347"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 13:27:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="678449692"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="678449692"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 31 Jul 2023 13:27:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@kernel.org>)
        id 1qQZUL-004oIS-0k;
        Mon, 31 Jul 2023 23:27:33 +0300
Date:   Mon, 31 Jul 2023 23:27:32 +0300
From:   Andy Shevchenko <andy@kernel.org>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 14/42] power: reset: Add a driver for the ep93xx reset
Message-ID: <ZMgZNOm2okw47Gaa@smile.fi.intel.com>
References: <20230605-ep93xx-v3-0-3d63a5f1103e@maquefel.me>
 <20230605-ep93xx-v3-14-3d63a5f1103e@maquefel.me>
 <ZLq0Z0QgBdCoDpV+@smile.fi.intel.com>
 <7788b12515f7e00b4bb0a04da30fc7fd0fdb8d51.camel@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7788b12515f7e00b4bb0a04da30fc7fd0fdb8d51.camel@maquefel.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 04:53:19PM +0300, Nikita Shubin wrote:
> On Fri, 2023-07-21 at 19:37 +0300, Andy Shevchenko wrote:
> > On Thu, Jul 20, 2023 at 02:29:14PM +0300, Nikita Shubin via B4 Relay
> > wrote:

...

> > > +// SPDX-License-Identifier: (GPL-2.0)
> > 
> > Are you sure this is correct form? 
> 
> Should it be // SPDX-License-Identifier: GPL-2.0+ ?

I don't know, ask your Legal department or your lawyer.

(note that the 2.0-only and 2.0-or-later are different)

I'm talking only about the form, not about the licence itself.

> > Have you checked your patches?
> 
> Could you please be more specific:
> $ scripts/checkpatch.pl -f drivers/power/reset/ep93xx-restart.c
> total: 0 errors, 0 warnings, 86 lines checked
> 
> $ git format-patch -1 51f03c64b8fde79fb16b146d87769b7508b6d114 --stdout
> | scripts/checkpatch.pl -
> WARNING: please write a help paragraph that fully describes the config
> symbol
> ...
> WARNING: added, moved or deleted file(s), does MAINTAINERS need
> updating?
> 
> I don't see any license complains...

checkpatch is not the ideal tool...

> checkpatch.pl is working as intented as:
> 
> $ scripts/checkpatch.pl -f drivers/power/reset/ep93xx-restart.c
> WARNING: 'SPDX-License-Identifier: (FOOOO)' is not supported in
> LICENSES/...
> #1: FILE: drivers/power/reset/ep93xx-restart.c:1:
> +// SPDX-License-Identifier: (FOOOO)

https://kernel.org/doc/html/latest/process/license-rules.html
doesn't mention your format.

-- 
With Best Regards,
Andy Shevchenko


