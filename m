Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3255806112
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 22:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345993AbjLEVu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 16:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjLEVu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 16:50:27 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDC7B9;
        Tue,  5 Dec 2023 13:50:33 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="15516376"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="15516376"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 13:50:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="914948187"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="914948187"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 13:50:31 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andy@kernel.org>)
        id 1rAdJE-00000002BsX-2Tvf;
        Tue, 05 Dec 2023 23:50:28 +0200
Date:   Tue, 5 Dec 2023 23:50:28 +0200
From:   Andy Shevchenko <andy@kernel.org>
To:     tanzirh@google.com
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nick DeSaulniers <nnn@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev
Subject: Re: [PATCH] lib/string: shrink lib/string.i via IWYU
Message-ID: <ZW-bJLGv-bXUXWbU@smile.fi.intel.com>
References: <20231205-libstringheader-v1-1-7f9c573053a7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205-libstringheader-v1-1-7f9c573053a7@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 08:58:53PM +0000, tanzirh@google.com wrote:
> This diff uses an open source tool include-what-you-use (IWYU) to modify
> the include list changing indirect includes to direct includes.
> IWYU is implemented using the IWYUScripts github repository which is a tool that is
> currently undergoing development. These changes seek to improve build times.
> 
> This change to lib/string.c resulted in a preprocessed size of
> lib/string.i from 26371 lines to 5232 lines (-80%).
> 
> If there are any problems with the output of the tool please raise an
> issue on the github.

> Link: https://github.com/ClangBuiltLinux/IWYUScripts
> 
> Signed-off-by: Tanzir Hasan <tanzirh@google.com>

Blank lines are not allowed in tag block. Unless Link: is not supposed to be
a tag (which looks quite strange in that case).

-- 
With Best Regards,
Andy Shevchenko


